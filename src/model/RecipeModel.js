const Pool = require("../config/db");

// MODEL : showing all recipe data

const getRecipe = async () => {
  return new Promise((resolve, reject) => {
    Pool.query(
      `SELECT recipe.id, recipe.photo, recipe.title, recipe.ingredients, category.name AS category FROM recipe JOIN category ON recipe.category_id = category_id`,
      (error, result) => {
        if (!error) {
          resolve(result);
        } else {
          reject(error.message);
        }
      }
    );
  });
};

// Model : for showing recipe data by ID

const getRecipeById = async (id) => {
  return new Promise((resolve, reject) => {
    Pool.query(`SELECT * FROM recipe WHERE id=${id}`, (error, result) => {
      if (!error) {
        resolve(result);
      } else {
        reject(error.message);
      }
    });
  });
};

// Model : for adding recipe data

const postRecipe = async (data) => {
  const { title, ingredients, category_id } = data;

  return new Promise((resolve, reject) => {
    Pool.query(
      `INSERT INTO recipe (photo, title, ingredients, category_id) VALUES ('https://placehold.co/600x400', '${title}', '${ingredients}', ${category_id})`,
      (error, result) => {
        if (!error) {
          resolve(result);
        } else {
          reject(error);
        }
      }
    );
  });
};

// functon for chacking email exists of not

// Model : for update recipe data by ID

const putRecipe = async (id, data) => {
  const { title, ingredients, category_id } = data;

  console.log("model postRecipe");

  return new Promise((resolve, reject) => {
    Pool.query(
      `UPDATE recipe SET title='${title}', ingredients='${ingredients}', category_id = ${category_id} WHERE id=${id}`,
      (error, result) => {
        if (!error) {
          resolve(result);
        } else {
          reject(error.message);
        }
      }
    );
  });
};

// Model : for delete recipe data

const deleteRecipeById = async (id) => {
  return new Promise((resolve, reject) => {
    Pool.query(`DELETE FROM recipe WHERE id=${id}`, (error, result) => {
      if (!error) {
        resolve(result);
      } else {
        reject(error.message);
      }
    });
  });
};

const getDataFilter = async (data) => {
  console.log("data filter: ", data);

  const { search, searchBy, offset, limit } = data;
  return new Promise((resolve, reject) => {
    Pool.query(
      `SELECT recipe.id, recipe.title, recipe.ingredients, recipe.photo, category.name AS category FROM recipe JOIN category ON recipe.category_id = category.id WHERE ${searchBy} ILIKE '%${search}%' OFFSET ${offset} LIMIT ${limit}`,
      (error, result) => {
        if (!error) {
          resolve(result);
        } else {
          reject(error);
        }
      }
    );
  });
};

module.exports = {
  getRecipe,
  getRecipeById,
  postRecipe,
  putRecipe,
  deleteRecipeById,
  getDataFilter,
};