const workModel = require('../../models/works.js');

const getWorkById = async (id) => {
  try {
    const work = await workModel.findById(id);
    return work;
  } catch (error) {
    throw error;
  }
};

const getWork = async () => {
  try {
    const works = await workModel.find();
    return works;
  } catch (error) {
    throw error;
  }
};

const deleteWorkById = async (id) => {
  try {
    const deletedwork = await workModel.findOneAndDelete({_id: id});
    return deletedwork;
  } catch (error) {
    throw error;
  }
};

const updateWorkStatusById = async (id, values) => {
  try {
    const work = await workModel.findByIdAndUpdate(id, values);
    if (!work) {
      throw new Error("work not found");
    }
    
    work.workStatus = values.workStatus;
    work.__v ++;
    await work.save();
    return work;
  } catch (error) {
    throw error;
  }
};

const updateWorkById = async (id, values) => {
    try {
      const work = await workModel.findByIdAndUpdate(id, values);
      if (!work) {
        throw new Error("work not found");
      }
      
      work.headers = values.headers;
      work.startDate = values.startDate;
      work.endDate = values.endDate;
      work.__v ++;
      await work.save();
      return work;
    } catch (error) {
      throw error;
    }
  };

const createWork = async (values) => {
    try {
      const work = await new workModel(values).save();
      return work.toObject();
    } catch (error) {
      throw error;
    }
  };

module.exports = {deleteWorkById, updateWorkById, updateWorkStatusById, getWorkById, getWork, createWork}
