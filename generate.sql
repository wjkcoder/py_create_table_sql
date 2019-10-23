CREATE TABLE `bd_user_worker_relation`  (
  `CREATED_BY` bigint(20) NOT NULL COMMENT '创建人',
  `CREATION_DATE` datetime(0) NOT NULL COMMENT '创建时间',
  `LAST_UPDATED_BY` bigint(20) NOT NULL COMMENT '最后更新人',
  `LAST_UPDATE_DATE` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后更新时间',
  `LAST_UPDATE_LOGIN` bigint(20) NOT NULL COMMENT '最后更新时登录ID',
  `CID` bigint(20) NOT NULL DEFAULT 1,
  `TENANT_ID` bigint(20) NOT NULL COMMENT '关联SYS_TENANT表中的TENANT_ID',
`MO_ID` bigint(20) NOT NULL COMMENT 'MO ID',
`MO_PLAN_ID` bigint(20) NOT NULL COMMENT 'MO计划ID，一个MO可以拆分成多个MO来安排计划，但必须保证数量之和与MO数量一致',
`APS_OU_ID` bigint(20) NOT NULL COMMENT 'APS运营组织ID',
`APS_GROUP_ID` bigint(20) COMMENT 'APS运营小组ID',
`APS_RESOURCE_ID` bigint(20) NOT NULL COMMENT 'APS资源ID',
`RELATED_RESOURCE_ID` bigint(20) COMMENT '相关资源ID',
`RESOURCE_FIX_FLAG` bit(1) COMMENT '资源固定ID',
`ITEM_ID` bigint(20) NOT NULL COMMENT '物料ID，冗余字段',
`PLAN_ITEM_CODE` bigint(20) NOT NULL COMMENT '计划物料CODE',
`PLAN_QTY` decimal NOT NULL COMMENT '计划数量',
`PLAN_FLAG` bit(1) NOT NULL COMMENT '进行计划排程标识',
`PLAN_RULE` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin  COMMENT '计划规则',
`PLAN_PRIORITY` decimal(10,6) NOT NULL COMMENT '计划优先级',
`PLAN_LEVEL` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin  COMMENT '计划层级',
`MTO_FLAG` bit(1) NOT NULL COMMENT '按单生产标识',
`MTO_EXPLORED_FLAG` bit(1) COMMENT '按单生产分解标识',
`DEMAND_DATE` datetime(0) NOT NULL COMMENT '需求时间',
`PROMISE_DATE` datetime(0) COMMENT '承诺时间',
`DEADLINE_DATE` datetime(0) COMMENT '截止时间',
`CAPACITY_TYPE` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin  COMMENT '能力类型',
`CAPACITY_VALUE` decimal(10,6) COMMENT '能力值',
`EARLIEST_START_TIME` datetime(0) COMMENT '最早开始时间',
`START_TIME` datetime(0) COMMENT '开始时间',
`FPS_TIME` datetime(0) COMMENT '首件开始时间',
`FPC_TIME` datetime(0) COMMENT '首件结束时间',
`LPS_TIME` datetime(0) COMMENT '末件开始时间',
`LPC_TIME` datetime(0) COMMENT '末件结束时间',
`FULFILL_TIME` datetime(0) COMMENT '最终完成时间',
`MO_REFERENCE_TYPE` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin  COMMENT 'MO参考类型',
`REFERENCE_MO_ID` bigint(20) COMMENT '参考MO ID',
`EXCEED_LEAD_TIME` decimal(10,6) COMMENT '用户指定的最大提前生产周期(天)。在进行并行生产时，上游物料最大可以提前生产完成的时间，优先级最高',
`PRE_PROCESS_LEAD_TIME` decimal(10,6) COMMENT '用户指定的前处理提前提（小时），必须为大于零的正数，优先级最高',
`PROCESS_LEAD_TIME` decimal(10,6) COMMENT '用户指定的处理提前提（小时），必须为大于零的正数，优先级最高',
`POST_PROCESS_LEAD_TIME` decimal(10,6) COMMENT '用户指定的后处理提前期（小时），必须为大于零的正数，优先级最高',
`SAFETY_LEAD_TIME` decimal(10,6) COMMENT '用户指定的安全生产周期（小时），必须为大于零的正数，优先级最高',
`SWITCH_TIME` decimal(10,6) COMMENT '用户指定的切换时间（小时），必须为大于零的正数，优先级最高',
`RELEASE_TIME_FENCE` decimal(10,6) COMMENT '用户指定的下达时间栏（天），只有进入下达时间栏内的计划条目才能够被允许下达，形成生产订单，优先级最高',
`ORDER_TIME_FENCE` decimal(10,6) COMMENT '用户指定的订单时间栏（天），只有进入顶层MO进入订单时间栏才能够被允许下达，优先级最高',
`SCHEDULE_RELEASE_TIME` datetime(0) COMMENT '预计下达时间',
`ENDING_FLAG` bit(1) NOT NULLDEFAULT 0 COMMENT '是否是尾单标识，Y/N，尾单不参与计划计算，但可以进行报废、补料等业务操作',
`PLAN_WARNNING_FLAG` bit(1) COMMENT 'MO警告标识，Y/N',
`SPECIAL_COLOR` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin  COMMENT '特殊颜色备注，用于在计划工作台中显示',
`PLAN_REMARK` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin  COMMENT '计划备注',
PRIMARY KEY (`MO_ID`,`MO_PLAN_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '用户与员工关系表，设定用户与员工之间的关系' ROW_FORMAT = Dynamic;