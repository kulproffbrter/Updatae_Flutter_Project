const userModel = require('../../models/users.js');

const getUserByEmail = async (email) => {
  try {
    const user = await userModel.findOne({ email });
    return user;
  } catch (error) {
    throw error;
  }
};

const getUserById = async (id) => {
  try {
    const user = await userModel.findById(id);
    return user;
  } catch (error) {
    throw error;
  }
};

const getUser = async () => {
  try {
    const users = await userModel.find();
    return users;
  } catch (error) {
    throw error;
  }
};

const deleteUserById = async (id) => {
  try {
    const deletedUser = await userModel.findOneAndDelete({ _id: id });
    return deletedUser;
  } catch (error) {
    throw error;
  }
};

const updateUserById = async (id, values) => {
  try {
    const user = await userModel.findByIdAndUpdate(id, values);
    if (!user) {
      throw new Error("User not found");
    }
    
    user.password = values.password;
    user.__v ++;
    await user.save();
    return user;
  } catch (error) {
    throw error;
  }
};

const createUser = async (values) => {
    try {
      const user = await new userModel(values).save();
      return user.toObject();
    } catch (error) {
      throw error;
    }
  };

module.exports = {deleteUserById, updateUserById, getUserByEmail, getUserById, getUser, createUser}
