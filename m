Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702FE306509
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 21:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhA0UZI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 15:25:08 -0500
Received: from mail-bn7nam10on2091.outbound.protection.outlook.com ([40.107.92.91]:61825
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231968AbhA0UZF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 Jan 2021 15:25:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2qMoeYb+SCaE0kHXG6C4K/kem2lS3WSh5EhKy90D97sgzZx7Ab/ISa2wE50Pc+iZQTToz9hZLTHJ8x6/z61ad27HJG+CkH41vm52rx+kRanMxrRUzn2wPc7r3bcyyN3/+KqGZAMbdukewSwU/BRt0nGG5gXv91ITSzZXLxgEq5Y0jl+i0Twt/iOMPhmrfHxgdB1QPgU8DTDRaeCRfBfKaQXMg0Fp0HDXzKFDiDdfDbLHb5YHDjudXmvJPg8vc5T9BKTvz615NVojmyf8SDEpXajhlkvtxWxO5GPzp/a7hmqKYVCyEdd2YO4xFGBYoc2LVvbzo9L03zW8R7Alef0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4uSV4yAL/VcnW3Lf7MGrB5fOqGBLFst3k0fX1W1hqs=;
 b=ESrTYhdtu7nzXhmuZ1JEzLSq93EhDQlcttabAS10k928MUBxOONujRdw4XiEhqk4E0UIiAg9T8s0/Qx/e+y2CpcXE/mhsg3hMyC6iHYVqVkBgGmP56tygPXiBBzpycXMSKYkEEUfUMOI1mpCXclUKbiqbo6y9oDepasfnY/IDb0FIDxK306H05EvhIDHtsTrLwOvbQQlqh5nC5dQMZQpuBtXJKIIZUzLet2tQ+gMJKOUfeuK2xbwiv4uz9+7Y/ezJZjp81k8+zp0Fn0jpBgkYZL1bSSDgyGVcXkzBau7RtNHh1jr8RMDF4955SV3AuHwYjG0Hv0ZOsVFSVH/Pqe94Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4uSV4yAL/VcnW3Lf7MGrB5fOqGBLFst3k0fX1W1hqs=;
 b=LsuPF9PNBWAz0mE8MfauK4j18by3dwHfGMyU0wR+/krmvCek//Ua7vK4wIUJKoMMPue1xIv3dBHP/B+8BCigH8KY4tG+t2H8F6Xl128XGWNcscDOpEE0i4Bp10hPAa3/iQ5fGD9AzfCdWGMdnhDhQ/OnM9AXE9/+ZLZNt7wTMGM=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from (2603:10b6:208:3a::13) by
 MN2PR21MB1215.namprd21.prod.outlook.com (2603:10b6:208:3a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.6; Wed, 27 Jan 2021 20:24:16 +0000
Received: from MN2PR21MB1213.namprd21.prod.outlook.com
 ([fe80::91f:e9a:5737:3a05]) by MN2PR21MB1213.namprd21.prod.outlook.com
 ([fe80::91f:e9a:5737:3a05%9]) with mapi id 15.20.3825.006; Wed, 27 Jan 2021
 20:24:16 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 00/10] Refactor arch specific Hyper-V code
Date:   Wed, 27 Jan 2021 12:23:35 -0800
Message-Id: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [131.107.174.144]
X-ClientProxiedBy: MW4PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:303:8c::24) To MN2PR21MB1213.namprd21.prod.outlook.com
 (2603:10b6:208:3a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.174.144) by MW4PR03CA0139.namprd03.prod.outlook.com (2603:10b6:303:8c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 20:24:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 02535152-192a-4d47-963f-08d8c3018498
X-MS-TrafficTypeDiagnostic: MN2PR21MB1215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR21MB1215E9B61304CE7BFF2E9D94D7BB9@MN2PR21MB1215.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DbQ+bCdI34df4GFiXZeK28JegpUxeawJfHGVq+1s/4SDmjCSFpyE74uKjN78BejupSqASNLnOy/fCSaT/Xotu520rBVacO+M0wU3ySGKqLO6UyP0aHiAejMsBVw1N/QkcP9M8tIvCCDdqkxYLOURbh6GUwRUvSYe+3YCyu2TOTjYq9PjM6ECKFYnqCoGbkDwq/UveB7dS6/ylAtTaaU88sdxQuBe35lwexdxoSg9PKoNKzrWf2N5cpXIExVSr1P233Md+ZyAXhQJ6/bjT5CUmxSSWeH+NTd61t2N2zTAk69Dfo3USoLUWo3m4WUYAKXLAmAVT5cXw2r8VCvOFQjDak07tHeaowgUyQ/XPhCjpqWzgrPpGKt/QvYFvi+MUbF6fIi5J1HO+8k6cqBimkTiID/TvFIlQe/lCcB6AtECKftOJF5X+kqnNhTKmIM73X8o0gNvjs69Uqgik3Sn+HBPTsB7Iqu5xNeJjOf6Ib3eKBCWEOoqP2MWsYdjwguV2t9UZ7Y7rhJXO9v4DsHwBDCM/ml2CX3/ugY3BIfGHVzRIw8TWGA/2QWw+kvPuCTrhMaTElLQ0gRslF+Y3MXl7Sz06kmkYZjA8fxGiMcGSTDP+zZdTlAjHNLCypPBS+xlqpfhHaYqtvVAaBqMDqqMnfmj+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR21MB1213.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(6666004)(66476007)(66946007)(956004)(26005)(66556008)(478600001)(921005)(8676002)(5660300002)(966005)(316002)(2906002)(86362001)(83380400001)(8936002)(186003)(36756003)(82960400001)(16526019)(4326008)(2616005)(6486002)(7416002)(10290500003)(82950400001)(52116002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/Y81Qg7VHqO9vPVHAnRWiLHIL2jllJ587EknePBKh21EzG5kEzQvNpm3V7AB?=
 =?us-ascii?Q?mSvzJPxibDb3zlZ5Cy1N/mwmEWg/869SaeabP4KOxgyc7RYTdQf5XKVEHrPH?=
 =?us-ascii?Q?xMgo0kVEgnW8TcUtXA3/CCiXCV+UtRGfroS80HmoLvRGVNtO3PTXVmb86PcX?=
 =?us-ascii?Q?HSik2Jpp8BxL6nNEdEYIMUh1NTMZSsxJJ/afvUskuCxGaIN40dXaqXD/6yoz?=
 =?us-ascii?Q?V+UwsmtXrJFA4QSwBRZV3NYD0jAlTK+J2LB+EcPpBokEwftdFnJSHNHT9d0k?=
 =?us-ascii?Q?jN3dMG7N695GUIGxOop7NMXLzb1jfn+5RdFLyzwdyZe88HJIcbiSk6/LlyiM?=
 =?us-ascii?Q?Zw0MPHWRyTZk7PG+Hiydc7+aMICz52CWi63K86cAaf3b2pSqZpDbnM1mG28l?=
 =?us-ascii?Q?AWJDIqASRLt48nJ/TEl7+rUfPL2CxN29dQssc91ZAf08ESCwHWEfmVjc//b3?=
 =?us-ascii?Q?V1w+6WzWNKjylpiPtqNLUTcrCzdCm+Mnu4cPKek2XgvnWpZCjF1jbMg7C6iz?=
 =?us-ascii?Q?qtROT40jyLGdfSRESqhe8p+XY25/jnNXgXBqsNxY5lnFTJzL4vTyR0iWQqkh?=
 =?us-ascii?Q?NTABDzSSSsrpuTFoLo0Cicj8s5N9Pg9n0oLgvQVn3zlvALAMxzDnqXV1odTo?=
 =?us-ascii?Q?NxbyUDs47Zpluu6c/JkCXxNkt6oo+xmadvpTmX/t6qxekqSnYwiGtDfhB4dJ?=
 =?us-ascii?Q?fA9h1gi4DMmy5Hb+hTrga6YwADwkw4p4i5BFx0s7f7UBotrkcDzIfl5qVVMH?=
 =?us-ascii?Q?+mK0tu2P9TcraD33Qiz8el+Qyl7/bhtTAUnq7BVu9hnkXlx2WsBSseynlrSI?=
 =?us-ascii?Q?7FvU9jVLVxccB8PKSvXJrbLPBgVdlBv1DTfNnqWVQZGscRf4WFkOMdnS6E4Y?=
 =?us-ascii?Q?W6nrKceQHeR0tpHOxHa/MDSjQztZd6iUeuHNO0WieGD/nOKe2T501iClgMUo?=
 =?us-ascii?Q?z4TXn9/BnnzTHyHp9xaz7bOi3UUnAFNJSRz23m0q9R65ARE7TbI91OsTiN+O?=
 =?us-ascii?Q?QFxw6uSSxDxTfxODyIZnNrpIgvTY8cam0sd9UOgePmV9H8pL01DzUafqHp2k?=
 =?us-ascii?Q?U700EYju?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02535152-192a-4d47-963f-08d8c3018498
X-MS-Exchange-CrossTenant-AuthSource: MN2PR21MB1213.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 20:24:16.1570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKsoskyIrFnltYSjloICtuf87hXdAqWuR9QpqdR0oaSAFwVHIX24qp+ITW/yW6AblME8zIupfP6cesjdhR4I8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1215
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
 drivers/clocksource/hyperv_timer.c | 250 +++++++++++++++++++++++++------------
 drivers/hv/hv.c                    |  93 +++++++++++---
 drivers/hv/vmbus_drv.c             |  89 +++++++++++--
 include/asm-generic/hyperv-tlfs.h  |  35 ++++++
 include/asm-generic/mshyperv.h     |  19 ++-
 include/clocksource/hyperv_timer.h |   3 +-
 10 files changed, 450 insertions(+), 313 deletions(-)

-- 
1.8.3.1

