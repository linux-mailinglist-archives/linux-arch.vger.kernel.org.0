Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE4E632D58
	for <lists+linux-arch@lfdr.de>; Mon, 21 Nov 2022 20:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiKUTxH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Nov 2022 14:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiKUTw6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2022 14:52:58 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11022027.outbound.protection.outlook.com [52.101.53.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE93A1C412;
        Mon, 21 Nov 2022 11:52:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJdOpBBSBvGdJh8jalNzS5vX64Op3Rs5Eh0quMXgeeF3umADwWNRcGhrbGr1u6q/lVpZB/6WgWqOCk39Wrf54QG8A2fDE9Zt1E2UaZAWG1AV5srFZ3zMZxv7EolvL9q9S52BYQakSBvRGizu0OBvss1k/JsiuC3JM/CysigXZUyNmI5+vv/PWzeafIKHfyBmuANfNT1/aCtd7tk5+4+QdfiICf7WW5JyTn3G5p5Rd7xQXbL381Je7PL6OHILPUMb3li/5g3v/YQBBqV2Kuq8RQEzmRZ51Rlgs1aT6ahooD908GT7LeOK9zU3SWkhAosf3kCWzTeneM/44cciKUGrfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTcwnvjiOi9DzXEOq0zBEBDfN3PZ8z46kx9WE1LjEZU=;
 b=EaV2JLRphATNCtM+gMDbmsGbDy7YQUyLevB/3wkKw6/tgDmR42WbNazPFMFlvVnuNFFKAnkVIYAqPiFbSGyOy8uIiAheNDI4JxT07mAUmPILBTTlDE4ZtFMDreFoPVB/ZJJ8S4+242IuNswZwVim6CNbIBepRgnZcGdwN4FguvuLUtZk2m/wOQAJl75nl/Jmd244Ifd30gvwDI2gYlZn+gKJPsX4Nl24o1EVvMikMXyu/hwUDHTtZOkliN9vB3dKByvZBSBHBBDroDTmBp+8hS01Mmyt+QuBVCvzm9u3COHeSX4IF0vM4Mvs1FkaLFaJBptS/ljfN4mW+A6W1sTx6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTcwnvjiOi9DzXEOq0zBEBDfN3PZ8z46kx9WE1LjEZU=;
 b=gFJiGerZKVmp6zlLFQggoVBhIFsVdiTAx7ZbsNlBgO9VxlK1LDthVd5NVHwdKooyVnEUDvbNp1dMXgqGE7niGXst6g+W5kcwPoEyNZQTV2TKQZ5krByw3v8QN1SbfMT/bJpFMFCrcS4GtKZvFQ3USRO3uT2gDljK4wtSDOcunT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by BL1PR21MB3280.namprd21.prod.outlook.com
 (2603:10b6:208:398::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.2; Mon, 21 Nov
 2022 19:52:47 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020%7]) with mapi id 15.20.5880.001; Mon, 21 Nov 2022
 19:52:47 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
        jane.chu@oracle.com, kirill.shutemov@linux.intel.com,
        kys@microsoft.com, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 0/6] Support TDX guests on Hyper-V
Date:   Mon, 21 Nov 2022 11:51:45 -0800
Message-Id: <20221121195151.21812-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::32) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|BL1PR21MB3280:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ca6737-0b81-4342-447e-08dacbf9f66b
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UAh7cMYI2ypF0nk5m78JeTFkuXEc3vXna+dcg97+frfyxNcYY92SEHnYJ3ZVZM+OFcR7aQKZiHWdEio5fKVm62ysV4XGQI2DPWSrGzEmZvw+P+c2JYwSIMWos9Q/P0i0NmnPsHGCJ4dLkSIj8IBrnGoNL4p3yuV6usUFVIbwSsmtnYnIKGYwgkxMPvruHn/TyGoRQumb5GwqhHOiG59M/KFQH7iiQ2z7PQC8ssgYoBBmRFhXg4PccdOxrNp8CUBwcwKvUNM/KHE+bANYeZPr6Orh6G7x3Yg7t8039xugaaPlZaoZr31s7KxKz8L4ujJiZrEKdtja0pTGjZECZJsAVxw9LhE2s8wstmWQvcSSs7ijO3MQ3ke6rsJO79ejsETI97vNm5OjLyOOX826Md+kczOo6dt8ej+Sld3RGT8zBMOxcK4l/1GzOf63KWHLgnqM4IeqKa0f70u2R70Hh3GTpOgbUn2LAa83mYAjeViwjQbXIJ96gA5j6pGvDiTMhhgJj3qgMxkA5ki1UUFgvCKGNlVl4xXzMztFx5FxFB2u4vTjAVuRThgsu+FV9SiVkm6+ATIb6YbO/lgM0Gz8g5yYDWVjGkkQR7qDaS5EchubHaCXVvogJLLq0nqpYvX5LnSI5fJCoUl+6FRFsE7t8sy7MjbXsQJiJr/dCzOv3yVKRxlqJcNH6OE4btFwlvvWXau+jSGw/fE+ZuKuXTd7r2W8VxAAdAn19YWk9FPJ6Y7XvLjYLq/KIN6cZVKIK4IVOAzvRYr888RAYqFwiShZC0awGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(83380400001)(2906002)(7416002)(5660300002)(8936002)(2616005)(186003)(1076003)(36756003)(86362001)(41300700001)(82950400001)(38100700002)(921005)(82960400001)(10290500003)(107886003)(6506007)(52116002)(6512007)(316002)(478600001)(66556008)(8676002)(966005)(66946007)(66476007)(6486002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J4By2Hyq3V82rXVJ6jwEfgADjteASCTXrkjJrj4BQTdA93pCP98mpwgfxU4I?=
 =?us-ascii?Q?GhLe4NW87IvX2BbpoJh1Yf+Ppm90jBLYkXeWyfMPf9DMzF/5v2Fx6L2MfVBN?=
 =?us-ascii?Q?LEth14uxC6EzhoGufUmp2AWRHT6Q6oNKbFxtTFpW+jVRd1lgWhfOyovugz5d?=
 =?us-ascii?Q?QAdXlw5ODBhh5sXKwIzMrHdlH/ghcj+jJFbMfr74alu1CHjE2Kf1l4qmGgZw?=
 =?us-ascii?Q?37ruxHA9/UePEbDu/lRBFdba7AcVqbcbMXMRHY/Z1kg82hiJvcMA+BU6ZcBf?=
 =?us-ascii?Q?9O7xrtj5OHa6xSzzX4F9qk2Nt/dA7rxQnI8OTcxQW2XWoMzavjkGFa18BRm6?=
 =?us-ascii?Q?QFbm9oHJsu9wMkc/SFgy+pB1orvtF7IO7Zly7HD4MuMyc1vlHg8HZOroigwv?=
 =?us-ascii?Q?ARiNv9CDLpfXjpHdHzJC+0N8euSWG6exoODRPyz31QTrK62PMPY6BSWrRGxv?=
 =?us-ascii?Q?Dv8xtq61TtDT91qmNUxh0sbgU2K21jtyTi5ecp7zyotq+PT0GbKexvm2Ur/D?=
 =?us-ascii?Q?B7jvFdtf8C0+uVXN9lNmnvWZtEa3tNZneaqzLdQUu7LJ7hvvhurv1x45SQIr?=
 =?us-ascii?Q?6LZcSzhm0bmHlJLjWJk1Tvgg9PeRMTJJ44Hjc6RXY0tGaaVhEZMd/nJMxbgP?=
 =?us-ascii?Q?wy1B31/YkDEkbY1PkXuaIRJSC8LpdiKhrKrE9CWeb3Sk1iIhcw2uOiSDsy39?=
 =?us-ascii?Q?AcEucSbSxYvLQIFCA1YEgnLE72cjWRkL/bFxHvL2MpVkWwXbzqBq52ynfaLB?=
 =?us-ascii?Q?FfSQ7AmkS2qS6umXm3eoT5/LBdT8NhFCU2EKTPd4esnW9GyYvyhlOjMfIU69?=
 =?us-ascii?Q?maUvYKCnStJZEXYpF+BOE4tGFe+xm//vcqbXctcntir1RlwTWmW5fx45CuTz?=
 =?us-ascii?Q?9YKa38LB5aqppCx2PdzX2xVhQWcc+L/2Mpt/a3JdasLSBbx9Urs71AiXv6Uq?=
 =?us-ascii?Q?NfmNiRZrMBRHDmruwlMG1UwmKDgIc4hNBYZ4GvpjukMQuekVzs76+5RRbv1m?=
 =?us-ascii?Q?ayl3d9HJOFWUa+cMrJ5Wt0XyvrFvEwcbu+7CeCdXB6NupNAjBVCBL9352Oef?=
 =?us-ascii?Q?4P7Y1LfqMnn1eK3SgQjU6WcrNTk2RGhOdO3Uodhj1Q35iXOZqd5i5U76R6mQ?=
 =?us-ascii?Q?KROHpuPO67+Ms5QHIyz28q64uqu0MZlgKUqpzHfqZb1YbZDOT9gnxOV28SgS?=
 =?us-ascii?Q?JD3hOiPRo0dypuxzpsA8mdIdzH6t6+nEiVZkH3k84dyzdTPGm9HQtCUpwRrz?=
 =?us-ascii?Q?1pMbODQJiG/lc7goMPFqgequapOvhwSv6OX1Gw/YqI5xON0nhMxaISRy0cvq?=
 =?us-ascii?Q?VR9Bf3+CWwrq+tq1qeCdhWMs9SdcC3KwPbxayNr045K98cvcGJg0XMDSKvZx?=
 =?us-ascii?Q?x6g4SYxai1sqG957cUSRPTtBHDJ9V5cMWaGiscQvWndTpfQf3KFghkddbUxt?=
 =?us-ascii?Q?PgglgbQP+yrWzv+uVDawcOBCQiv6BAYa0NbNLqpnG3B8+FHQqkNRjt3RRbLz?=
 =?us-ascii?Q?24HxCq96nzO1v29612ICSB8tBmtsgt7UHNKzvonLdSu+VHG8lMezis1Tv2am?=
 =?us-ascii?Q?RaX9xr7GMftj4AZc0N2duxFe95qfPlFG7Njez+ObYWkXEG45qXb60iWqL2zJ?=
 =?us-ascii?Q?otlVwYI1kIU69qhvkP0Rayl1by44QMyCEFcqTkE/wp/P?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ca6737-0b81-4342-447e-08dacbf9f66b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 19:52:46.9897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHJCHEWuHWhpkNLTwyVk9i8DmUYQ10lz0VCaeLkzbmo2wkmNeehaVwgsMKZBPBbBd+7OdYYVIYzFtSu8XTZamA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3280
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Intel folks added the generic code to support a TDX guest in April, 2022.

This patchset adds the Hyper-V specific code so that a TDX guest can run
on Hyper-V. Please review. Thanks!

Patch 1, 2 and 3 modify the generic TDX code in arch/x86/coco/tdx/.
I think they should go through the x86 tip.git tree.

Patch 4, 5, and 6 are for Hyper-V drivers and I think they should go
through the hyperv tree. Once Michael Kelley's patchset is merged
(see https://lwn.net/ml/linux-kernel/1668624097-14884-1-git-send-email-mikelley%40microsoft.com/)
I'll need to rebase the 3 patches.

Patch 5 depends on __tdx_ms_hv_hypercall(), which is added by patch 1.

Thanks,
Dexuan

Dexuan Cui (6):
  x86/tdx: Support hypercalls for TDX guests on Hyper-V
  x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
  x86/tdx: Support vmalloc() for tdx_enc_status_changed()
  x86/hyperv: Add hv_isolation_type_tdx() to detect TDX guests
  x86/hyperv: Support hypercalls for TDX guests
  Drivers: hv: vmbus: Support TDX guests

 MAINTAINERS                          |   1 +
 arch/x86/coco/tdx/tdcall.S           |  87 +++++++++++++++++++++
 arch/x86/coco/tdx/tdx.c              | 110 +++++++++++++++++++++++++--
 arch/x86/hyperv/hv_init.c            |  27 ++++++-
 arch/x86/hyperv/ivm.c                |   7 ++
 arch/x86/include/asm/hyperv-tlfs.h   |   3 +-
 arch/x86/include/asm/mshyperv.h      |  29 ++++++-
 arch/x86/kernel/cpu/mshyperv.c       |  30 +++++++-
 arch/x86/mm/pat/set_memory.c         |   2 +-
 drivers/hv/connection.c              |   4 +-
 drivers/hv/hv.c                      |  25 ++++++
 drivers/hv/hv_common.c               |   6 ++
 drivers/hv/ring_buffer.c             |   2 +-
 include/asm-generic/ms_hyperv_info.h |  29 +++++++
 include/asm-generic/mshyperv.h       |  24 +-----
 15 files changed, 345 insertions(+), 41 deletions(-)
 create mode 100644 include/asm-generic/ms_hyperv_info.h

-- 
2.25.1

