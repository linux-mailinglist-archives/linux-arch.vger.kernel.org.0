Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCA732B4CC
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354230AbhCCF25 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:28:57 -0500
Received: from mail-dm6nam12on2096.outbound.protection.outlook.com ([40.107.243.96]:29120
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348511AbhCBVkT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Mar 2021 16:40:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEOa7PPXirlGr8X/EFyFbdWn6eVnWgytEt9R8UVTmMfcCXe/9cduJs88TsLrFJbuXFYV6FbilQanNSE17WeHd4PkLLc3UzHdoC8zaMGWsdHd0mv/eRfBel2iPWzsVYRzsWKHQSESriz57mArx8W15MNCYpsNLceiPf1/7rYEOQpD24PsnQa877aaOwKYSZ1wCglh9Y6r5w8vkE4bvZr12aIc7TJpFKWVra2TcCARsXOkL+TMl87KSCmdAQhibeh2pKtroY1y6zTsHH68eKjO3YS7W1+NnH3M1gf8eL27dKOjyYxSi3LzKduW8Jpi99Drhr8K/q9/a9iU1sau5PVbRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txggF8iQ8mcO2SGRx/imtBk3C134gRD0P7g1BjM7tOc=;
 b=S5d3KzT+yd5Lwih9rkIhV//uPgC4dlisVHdORAs6IHnSnuHrB93nGv267sEkUC6BffHlu9v3AR31as3aYY1/K3sAUouQkSdEIVh/M39d+ABkpOImLw7J1b8YNm8Tnvg/+SI17VcBgjyjejAN1Vdpx6DSGbxrDHLVFqy0cCvNQqIswuvQBuOyzuaYn+DaJ3XRcm19CMYwy78QrQ3+VLHqI5dgJg9Q2LBD1VkQVBjSKlZWiNxUduBXbV456qomIWgIEGfU1pkF5C3WL6NK+E4elOuMeQRl8WIsFQ15DEmPzh2AzuZkTjC/yYNqHJcPQ1sdXVmh5hXBC0WYmiiOT8s+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txggF8iQ8mcO2SGRx/imtBk3C134gRD0P7g1BjM7tOc=;
 b=fPbh8wg2H6LFkSozPrALZ6ANMw0mmneextXziTdj+U2q31eIp9r0lROGkxoKOvtMJHoBueMkAZJ+2hZnWuVHeR7KFRGAivX8QXL4WcpBKmwi/EQourZw8ssilbi3NGuoeO9riBX5ZrEbW03SHEB7vTnJbJ91RDbsxVPfcfMHuvA=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM6PR21MB1739.namprd21.prod.outlook.com (2603:10b6:5:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.1; Tue, 2 Mar
 2021 21:38:45 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3912.016; Tue, 2 Mar 2021
 21:38:45 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v3 00/10] Refactor arch specific Hyper-V code
Date:   Tue,  2 Mar 2021 13:38:12 -0800
Message-Id: <1614721102-2241-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [131.107.159.16]
X-ClientProxiedBy: MWHPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:300:117::15) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.159.16) by MWHPR03CA0005.namprd03.prod.outlook.com (2603:10b6:300:117::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 21:38:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d3a0660b-c384-4e08-4655-08d8ddc38db2
X-MS-TrafficTypeDiagnostic: DM6PR21MB1739:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR21MB1739564BD29A8109472BD8EED7999@DM6PR21MB1739.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pc4CQ5V9nbXgqNnYtE0T7pPCuOzYPjQaQ0gR50Yt3fYiky76nNGkpQq9eV6h9BaTxUWWqrHGiol+wD0UXRO3WO8ZGONFKIAw70soQOEbjNjGIwY24AFlvotlNONGgN1Xi/HcUIVnf+UgjwAtDW5ge03xwVcQU5Q18Kwi7J3aZJCHqpYCg9wOEWJmLYH8C+7gsrQM43MODvRcPREvHyr9QBhvc3AkNZ0YozNw5vRA9HXNCuONZKy58M4u3469YsnQdjyDdcr1pNHrfS03/r0INHmCBDm/4uN43F9HpOMBMcdfAbpDFpKkSM7SIJZgtHM4XI9zhTXavMCpotsG0+R69kzGDn+zbz8Tpsyvh1W9BcSAsV4jBSGF7Y8fGabaTm/7+cjy9SVZxR+DhD6lzepR3mSmcYiw+x2m6hVhu5j5sGfbplmcw7frVwqpaYWxzCOIxBSkys9AXg3sv9z+xb8bxIhoY+FVQva1K9GKrOeFeUukCom0FIlv6RxL93H+T+QImVzUvNKvS90ETdIOTOXuyysrnzz+WCY1olQfKBWUIBkhtSngNnlvGRnMlZYw0Lm4QhPdOpRVWRv/p6HtjXYRgUG3GxGmBOqNm+DywikQm9QfykUONGXHV0GnbJQ0ICRX9TH9kEcBiPR+4JwM7pUTlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(82960400001)(956004)(36756003)(82950400001)(966005)(8676002)(66476007)(6666004)(921005)(26005)(83380400001)(66946007)(478600001)(186003)(6486002)(7696005)(16526019)(8936002)(316002)(2616005)(52116002)(4326008)(2906002)(5660300002)(10290500003)(7416002)(86362001)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CXQsE4fysVD3rG3hpKSfYyBxESCe00xkB3mei2Iy3gJcuqUT/DP32/CuI2vL?=
 =?us-ascii?Q?SOfLuHTqFGr4/xw+lt9tjBhlFvkwAvAgkCTQo4G6MpDYqiJMiAfE/k1wJEkm?=
 =?us-ascii?Q?4ngzSG4jop67+ndjOBFfzaoZn3iPhFIVKVIvz3yTUvZOZoIoYv0OSFof5KTV?=
 =?us-ascii?Q?2Bs3YGNenPpqs6MNolT53TwFvMW+PQOR2/ZDwC7JE1SRTnHrL4a3fD31dvh9?=
 =?us-ascii?Q?tVQ8HzdOv6WcJxZNjhLWF8ZSM3c7vfvUorlOs+aJuSpyeXxHnpNEJouqDkkw?=
 =?us-ascii?Q?cqk//ipCFxZwQWYbIypdHTwMpWZm1ItIU35H3JvABgxM33MHwxQfQ9TL1VS6?=
 =?us-ascii?Q?00SRFl2rXtV3qKDHDNKIE7DbH17ra6PM29GjK+UgqJGBV7VeUwniTuWI1Q19?=
 =?us-ascii?Q?YiFT2ZrTOVbhzvU2kXFYcLIw4TBSH4JbaMmfqTyLyOGSwf75yJMTYVVR+0M4?=
 =?us-ascii?Q?XaxQL/+dzjipfex/PW6E3LuHlInp7IfwPyG8GvCisP5AX79LHETaEfiM1NBm?=
 =?us-ascii?Q?nBwEk5SVGvWM8IjYWZAs/HahUIVXak/FfGpS5Td/z81Hs4cf3H5yNwUgM3n1?=
 =?us-ascii?Q?wN1OUIiaWaijLSKwC3HsfAUJY3Skwww1M7k30BZoFroehmWFiI2wu6EY8t+Y?=
 =?us-ascii?Q?gS09W5ul9iyDgOQ6XwPTiHA1shzx2rkK5n+T2pUcNMs03mqwpQt5Bh/Mpsts?=
 =?us-ascii?Q?kp7siKkWSD5beKbEbs8ivQnKKQctslP9gbbxDuEZ2jByDglJSuMVXSuDgm+O?=
 =?us-ascii?Q?l6cUhhvKRvQbeAKW8AQuTBeK8Gk5ZOj+VeayaU71ucQ/FpWlXr7mnZEhuMLN?=
 =?us-ascii?Q?FvH38J8P15llpy9RBt7OaD0Vj8yvVkcPhlCkYcw5A/ZpjtQI61z8hq/odftz?=
 =?us-ascii?Q?5sjNjFqa+ac2AgIJHOWl0/UGhIY0qg9grNmKTixBtPz7vML1I3uu/+YrWzuK?=
 =?us-ascii?Q?R7NZ2h//Z65HnUbUAVo02/q3I6DRyu5msk3JqTBLckKkijxLuI0Yba/7RbfH?=
 =?us-ascii?Q?UniVMarQWM/l3zoVAR1Sy8l7t7GDwNhdAabx/tyNZnvGjIJb25fdWTvy4zyy?=
 =?us-ascii?Q?tPMCqDRQY4sL4+AAil5YHHbM4oItFVz1eE7x3efnN3Fycbv4jZ+jpYykjlFo?=
 =?us-ascii?Q?R20lwD3EDbIOzWaiZ+RLCxtdx35KoXuah1+RrmsP94uxv/mCdIzzx9IRcgvD?=
 =?us-ascii?Q?pP7CS9I9NJy9MGC+wk8ommeM5sckWMyGEay9B0y7m6aN6Ve0Ne+uL91uGAXB?=
 =?us-ascii?Q?LMgVRx0qya5TikUL4gGCrAm7HHEyjpIUzyyqtaq+eHy7ut25YD5tiivXLOHq?=
 =?us-ascii?Q?viQcx0UhXE979VvSD+6X5O3z?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a0660b-c384-4e08-4655-08d8ddc38db2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 21:38:45.7862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLZYlBOEmBzPhiG2W0bJUw2vTdRogHgX10IPxi5/9JsJqBUU8cMsN/tk0blz5JAHXDrwgU7A7VX5sGhWnNnw6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1739
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

Change in v3:
  * In patch 7/10, tweak the #ifdefs [Daniel Lezcano]
  * In patch 8/10, tweak the #ifdefs to be around entire functions
    [Daniel Lezcano]
  * In patch 10/10, use DEFINE_PER_CPU for stimer0_evt instead of
    dynamically allocating per-cpu memory [Daniel Lezcano]

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
 arch/x86/include/asm/hyperv-tlfs.h | 131 ++++++++++---------
 arch/x86/include/asm/mshyperv.h    |  67 ++--------
 arch/x86/kernel/cpu/mshyperv.c     |  23 ++--
 drivers/clocksource/hyperv_timer.c | 249 +++++++++++++++++++++++++------------
 drivers/hv/hv.c                    |  93 +++++++++++---
 drivers/hv/vmbus_drv.c             |  89 +++++++++++--
 include/asm-generic/hyperv-tlfs.h  |  35 ++++++
 include/asm-generic/mshyperv.h     |  19 ++-
 include/clocksource/hyperv_timer.h |   3 +-
 10 files changed, 449 insertions(+), 313 deletions(-)

-- 
1.8.3.1

