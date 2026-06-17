const classMemberService =
require(
  "../services/classMember.service"
);

exports.joinClass =
async (req, res) => {

  try {

    const result =
    await classMemberService.joinClass(
      req.user.id,
      req.body.classCode
    );

    res.json({
      success: true,
      data: result
    });

  } catch (error) {

    res.status(400).json({
      success: false,
      message:
      error.message
    });

  }
};
