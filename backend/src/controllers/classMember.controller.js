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

exports.getJoinedClasses =
async (req, res) => {

    try {

        const classes =
        await classMemberService.getJoinedClasses(
            req.user.id
        );

        res.json({

            success: true,

            data: classes

        });

    } catch (error) {

        res.status(500).json({

            success: false,

            message: error.message

        });

    }

};
exports.getMembers =
async(req,res)=>{

    try{

        const members =
        await classMemberService.getMembers(
            req.params.classId
        );

        res.json({

            success:true,

            data:members

        });

    }

    catch(error){

        res.status(500).json({

            success:false,

            message:error.message

        });

    }

}
exports.removeMember = async (req, res) => {

    try {

        await classMemberService.removeMember(

            req.user.id,          // người đang đăng nhập

            req.params.classId,   // id lớp

            req.params.userId     // thành viên cần xóa

        );

        res.json({

            success: true,

            message: "Đã xóa thành viên"

        });

    } catch (error) {

        res.status(400).json({

            success: false,

            message: error.message

        });

    }

};