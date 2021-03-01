Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957553275BD
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 02:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhCABQt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Feb 2021 20:16:49 -0500
Received: from mail-eopbgr690130.outbound.protection.outlook.com ([40.107.69.130]:37231
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230386AbhCABQs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 28 Feb 2021 20:16:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mk6gSsvLew7dx1LPTDyu2pIz7IaZLu9LlxgLYV3NGfTcUDQV5REvJs+nm5NZT0qL9mwNPGn/Q1gunITaA7MtgS9YgToM5fYLTSid2dDFY+15YHMrBrAX92HLxj+lGSZo27YQzIafu17kKjLy61PX5kZLFYsHYVYBRORe4VSqZj2ipmKPYzi2LCeX6ImqpVAH3tZSn3rS/i3Cy5YKbKDtZ6uT1d33bQGXBpMX6fvO+1Q0DC8PITYoBkv24XamJJewhvd44zZ7wqFA43n/JUQjaxENA82vFkTUZGsGNb1v7mBpiHK9JVWVMQOyd7JTPeIVZwx40Kcxl2zywH0CPeHpmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4p2B/9cD9Jf8f3ZtNfCCMR7cw7ryCmSbFRLZkZuyT8=;
 b=TjMGxYtcPVglicKj7yo+JnmBul4rDgc0J4hPr1SM1jxp2qNdqjeq84GXg9VW4gkPlbhFzf65AOO11nHdCXqf1XEAx5eumv8bFZTDHYOl5BGMKjWYFDYDjR/utMhiI3JMbjPRD4+apA8NnOKwkoxzol77SJFsDgUS6/tpZN2iylzNMN/lovyTSdsJg5trgD8ogoEG0Oq0e8bIDyv5X4BOUHVJ4tkJoM4dCiaALU6jLjoij0FGCJWYyULCC13rS5jq9Pwp8YY5QP9THxg5Jcgf56EVZ9ULljofZw5MRV+kErLaf7Mg4LFha2KYgjRUW+iLRNPdaAps9J24p8B8ArDndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4p2B/9cD9Jf8f3ZtNfCCMR7cw7ryCmSbFRLZkZuyT8=;
 b=YM7LE+V2/ZB9U/yTFO6SBaV8cdgWkTpooGaKn6YI6V0uB6+KciLupgF967CX8IL7ZGJZe1lwenJnZ92yCMedqWXTyfIilZGYJoqWYpgzQ7QRAmbD2yfnDK0kr21QYU9CflYx4fQhHmqfgzF/ZstBsx7cabIyvVn1EfXdegmmdJo=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB0981.namprd21.prod.outlook.com (2603:10b6:4:a8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.4; Mon, 1 Mar
 2021 01:16:00 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3912.016; Mon, 1 Mar 2021
 01:15:59 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 00/10] Refactor arch specific Hyper-V code
Date:   Sun, 28 Feb 2021 17:15:22 -0800
Message-Id: <1614561332-2523-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [131.107.159.144]
X-ClientProxiedBy: MWHPR14CA0008.namprd14.prod.outlook.com
 (2603:10b6:300:ae::18) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.159.144) by MWHPR14CA0008.namprd14.prod.outlook.com (2603:10b6:300:ae::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25 via Frontend Transport; Mon, 1 Mar 2021 01:15:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f6bc5fc1-a076-41a0-319f-08d8dc4f9228
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0981:
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-MinimumUrlDomainAge: kernel.org#8760
X-Microsoft-Antispam-PRVS: <DM5PR2101MB0981AE805F2343882F5D7184D79A9@DM5PR2101MB0981.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CgItKvqkXdlfFDyPdMToQc+tIMFx5WyHhYFYEr77djVHpFYXSbiFPfeFzbMOWW6OCcTPv7XDmqbGVbARYN+elzvk4jhw/6q/ApyrQkMdZVZATmgRPxv+isCfLKwKfuxKkprjBHJshF8/hYi0cLeZ1aJZkHZkKzb844ogJZOjQ0ATT30DjALiXPb0RY3AnxkXMQFgM1ks4PTpDpqV673dFobtGXI45pOjOcnTl1L2GqthMFxDEyPJceWBCnWgDG1tn9dD0HE/eoui4HHY6hwNim6OO31m8LXpPYal25o8jC6zG2pIqePtNNz9nfGItARtPcLwutmSDpoQQ0XL8XJmeszM4XKqWTu/5+viNjGI1X31mLow4D4NHkM7SXXIjN9NHWC6uzgR3MZ1H/eAbOFhI4XVWf0/LUHdS2NyR47Awdq7AeOwaZqvAwLAWM7lOF8yFLIYjwD6kAWN/RBHfg6+euabwDjEQC80AMJwl9bc7LJXwzgMN4epn14Dg6vuzZ200DWrtRdeIMPETN7oDQekC3CWyXZB6BX3jb9m27AMH3tIg85fasYd0FxLIX3N/ha8x2YrKoMC1uRHbRBCM7W8rZL1oLE11i5adxspImKvS3bX85L98XvM2rvkzDI1n+yTBRpIN5TTChs3YkLhEqWseA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(83380400001)(8676002)(186003)(4326008)(66946007)(956004)(86362001)(52116002)(921005)(26005)(2906002)(82960400001)(478600001)(66476007)(16526019)(6666004)(66556008)(6486002)(8936002)(316002)(7416002)(966005)(10290500003)(2616005)(7696005)(82950400001)(36756003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AEP75K+IDYFX2gZFnAuVfliusAvU9VXNDKU8iCBvOfFPbHgRwUgDqpwMzUMi?=
 =?us-ascii?Q?TRoxnY8GkvgN+SeqiT4UK03vMA1TcXoxPB2Oe6bg//hiR1WZsS3ZJT/hDPRh?=
 =?us-ascii?Q?bAOWrU5WGN/3i+sqKChIbRFgo6aRymGwWOIyuw0ZKuDRAE0u6ccxxw26KLA+?=
 =?us-ascii?Q?yJlMz8x/zepIzeO72hIBuXO82DkOFA0l3FCVf7o8HK4PtliiaRCcwBXFT9lu?=
 =?us-ascii?Q?AZenHvA1CcohtEkfJ4JNt4VAeK+dyaad6JrH2VEVA8yCzK1jurjU0GyGyupy?=
 =?us-ascii?Q?CWZO94fKrar7yZIwwqHjgniSRzSbb+f2ts/ieTsLqEOkf1gRwtssMaYCpWXI?=
 =?us-ascii?Q?EHCpRFnq7ZJ+OShI85fngcPiT4xSY1P6r5y5vYdRbKfobE6E237dfcja23oO?=
 =?us-ascii?Q?MHDsZHLu8No6p5GUyDH9Xps2FYdWeeErZw0oTzyehQ4Mcd3bc9iMpo3aMjBW?=
 =?us-ascii?Q?zkOv0BJclagtQYsAWSTNve3ODfFkFWfHejQx6k96jWwy2wk1LGopotYzDW8O?=
 =?us-ascii?Q?+F29wyzpOPJucjE3j3quh7f1w9odrQA/rCn031F4FnS2hAnXedocM4skv/k2?=
 =?us-ascii?Q?ay/3EdC9FNfTQ6Ct7l1I97+f+wmrYTC+KsNMa7hmiDzhUscYy0Jl/xcxK4Da?=
 =?us-ascii?Q?rJrg7oadhytWufDqL2Fo9P/+F3kheDVfzUw1WrsmTS4Xj17TBu+qmlKsrcVx?=
 =?us-ascii?Q?EjAgHx3Z7awxU+GtNNeoXbDVR6o9erSWqlyc9EvteyCnWPbs/g8vWN8MJ3QM?=
 =?us-ascii?Q?/F1oOiKD3zPvk1HhpZv9/V2T1SbQ2BBsNL10CcRkq2ofTpzAvTs+VW22DpjI?=
 =?us-ascii?Q?x5OkGPrxMVIj5JTuA5Xo06jjNpik6AnSX6gOr7IRsnR3qpbdtuiUZ3q2G0xd?=
 =?us-ascii?Q?C8V/MdsoF3ZjuordPDc/so3ZvBAHylZy9KgHC+yFLfaLFiclLRq60aWkQwyK?=
 =?us-ascii?Q?hiIvXvPAPNwWDjtOoNTzc3fVocpEetE9V4MtcVXcROzFUlrd98broOSHjLkM?=
 =?us-ascii?Q?Gsf9geTTzugx/NfBWlVcVdG8WmUkpbwcpw+KjXSVWrJ2csijKedzbvG9FJnk?=
 =?us-ascii?Q?iFCpl273vDWspZkB/KvTON40XnuPYjkwzVQPOvlTsArvv+xd+iY66EBEldPd?=
 =?us-ascii?Q?N3LJHlwFtM25w54k1mf16k8OKtY8OX3NYbkPhqJeyoB2+Ice9G9DVS72NWg4?=
 =?us-ascii?Q?oNdDq4ivEmjchX85BIA28aGrC9p6YV8GsJiO2SeC5MUCSg7MTwOOg1YVx+le?=
 =?us-ascii?Q?meMHB6pl8bj9GxgLceQjceU3ilr4JJCJGtaXjxGxiJiS+TgQ6SVvLBqR97dj?=
 =?us-ascii?Q?XYFGS78DN1JnVPWygzfvCyWG?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6bc5fc1-a076-41a0-319f-08d8dc4f9228
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 01:15:59.7388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+jNIoJP7ogoPfvJdR9Q/Xr+t8Eb3PezuV5mjiwA75mb52Z17M85U6XJkWo4y3Lm4MjETcbS6iTmWAK4wzLk/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To support Linux guests on Hyper-V on multiple architectures, the original
approach factored out all differences between Hyper-V on x86/x64 and
Hyper-V on ARM64 into functions or #defines under arch/x86 and
arch/arm64. Some of these differences are truly related to the
architecture, but others are more properly treated as Linux OS
differences or just quirks in Hyper-V. Feedback from Arnd Bergmann[1]
recommended that differences other than architecture should be
incorporated into the architecture independent Hyper-V code. Each
difference can be handled with conditions specific to the difference
instead of tying it to the broader x86/x64 vs. ARM64. This approach
reduces the amount of code under arch/x86 and arch/arm64 and keeps
the non-architectural differences localized and more easily understood.

This patch set implements the new approach by changing the interface
between the architecture independent code and the architecture dependent
code for x86/x64. The patches move code from arch/x86 to the
architecture independent Hyper-V code whenever possible, and add
architecture independent support needed by other architectures like
ARM64.  No functionality is changed for x86/x64.  A subsequent patch
set will provide the Hyper-V support code under arch/arm64.

This patch set results in an increase in lines of code (though some
of the increase is additional comments).  But the lines needed under
arch/arm64 in the upcoming patch set is significantly reduced, resulting
in a net decrease of about 125 lines.

[1] https://lore.kernel.org/lkml/CAK8P3a1hDBVembCd+6=ENUWYFz=72JBTFMrKYZ2aFd+_Q04F+g@mail.gmail.com/

Changes in v2:
  * In patch 9/10, for consistency change the rating on hyperv_cs_msr
    along with the rating on hyperv_cs_tsc [Boqun Feng]
  * In patch 10/10, add missing call to hv_remove_stimer0_handler()
    [Boqun Feng]
  * In patch 10/10, add clarifying comment that hv_setup_stimer0_irq()
    is not used on x86/x64 [Wei Liu]

Michael Kelley (10):
  Drivers: hv: vmbus: Move Hyper-V page allocator to arch neutral code
  x86/hyper-v: Move hv_message_type to architecture neutral module
  Drivers: hv: Redo Hyper-V synthetic MSR get/set functions
  Drivers: hv: vmbus: Move hyperv_report_panic_msg to arch neutral code
  Drivers: hv: vmbus: Handle auto EOI quirk inline
  Drivers: hv: vmbus: Move handling of VMbus interrupts
  clocksource/drivers/hyper-v: Handle vDSO differences inline
  clocksource/drivers/hyper-v: Handle sched_clock differences inline
  clocksource/drivers/hyper-v: Set clocksource rating based on Hyper-V
    feature
  clocksource/drivers/hyper-v: Move handling of STIMER0 interrupts

 arch/x86/hyperv/hv_init.c          |  53 +-------
 arch/x86/include/asm/hyperv-tlfs.h | 131 +++++++++----------
 arch/x86/include/asm/mshyperv.h    |  67 ++--------
 arch/x86/kernel/cpu/mshyperv.c     |  23 +---
 drivers/clocksource/hyperv_timer.c | 258 ++++++++++++++++++++++++++-----------
 drivers/hv/hv.c                    |  93 ++++++++++---
 drivers/hv/vmbus_drv.c             |  89 +++++++++++--
 include/asm-generic/hyperv-tlfs.h  |  35 +++++
 include/asm-generic/mshyperv.h     |  19 ++-
 include/clocksource/hyperv_timer.h |   3 +-
 10 files changed, 458 insertions(+), 313 deletions(-)

-- 
1.8.3.1

