Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B8D7869A0
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 10:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjHXIJ5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Aug 2023 04:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240483AbjHXIJx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2023 04:09:53 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-cusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFEB19AC;
        Thu, 24 Aug 2023 01:09:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eg2edIuz3325ZtQ3jz64MxDdH6tAegU8w2tuNNNavrO2i7xrNLzAqxmo/FBAXfNdIGY1/n9XnFc+Dxcxxup/rbRo9lns6RSNZKUvj0nF349WBxBwq2xrZobcRNa6MyFPPdbopY6Rs3rNJWNc4HdbY+/S3r5oI01Rb7pFkkrwz2E0zZ1zICeqFZpNsNpDRlDVpM+uhTn22vmyCsF9O/JWJGzP70dUZinjy54GUYPhsI9innyxOE/SDOwsLiTmWc/Q3Shn2qGMj8dH7SPK5CeqAZaoocoTcMYCQ/LRzXdHjTO4PGlViWf9J1DHlTWeXW4cEwpB3X3dJHccxWzwFnoiKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnUayE8ALRviTCwI1L+S+95PH0M5CslHtG83Lvxgou8=;
 b=UwbJXP/wIbXNvCW1FNux3Npf5cR/hu617PMlgsObr7DHu/RMk2D8C5KD3+W9PyWkMhD9G05YrAiT91y4I/4L8rU6i0YcoEWhCT8NM7E2H6g+MGLNVqvxc+V1BeS5yZ9ilOYnRAnHNsgr5XuQDX0oNA/zuL+X6/bRbD/qPT9NsdSX3r3jQR0CmnW+iuGkXwfH5b6d4Hbg9FxMnP6nH9oTHaBkLTkaD8ifWe9SsAJGUBkeZXlZ2+7Zu9Bv05E5XB2KBSrEOCoSIygmlaft/l+DRDnx6wH9j+YZebS6u9uFVYp7E7sGib6PkiL06wq6XNAH540rxezO3Lj6FLwZZDp9YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnUayE8ALRviTCwI1L+S+95PH0M5CslHtG83Lvxgou8=;
 b=IEvuJDMwekjk0/teP59IZODZztBwHwJFp2tGNcf9oJDkM1p7wOIXs+oAeY/jOYX3cuQNw6X6KvEU+nqWH2UlaY9hhu2WlfrAdz8KVF8LElD3i6DzGrA6Ti4Ef4VMIAy9e0gjbj418Z8Gk+7E9H7wnUDJcirDsc0A/Ye1BXa5l1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by PH8PR21MB3901.namprd21.prod.outlook.com
 (2603:10b6:510:23a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.4; Thu, 24 Aug
 2023 08:07:52 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad%5]) with mapi id 15.20.6745.006; Thu, 24 Aug 2023
 08:07:51 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        Jason@zx2c4.com, nik.borisov@suse.com, mikelley@microsoft.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Tianyu.Lan@microsoft.com,
        rick.p.edgecombe@intel.com, andavis@redhat.com, mheslin@redhat.com,
        vkuznets@redhat.com, xiaoyao.li@intel.com,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3 00/10] Support TDX guests on Hyper-V (the Hyper-V specific part)
Date:   Thu, 24 Aug 2023 01:07:02 -0700
Message-Id: <20230824080712.30327-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0175.namprd15.prod.outlook.com
 (2603:10b6:930:81::20) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|PH8PR21MB3901:EE_
X-MS-Office365-Filtering-Correlation-Id: 0650dfad-26a1-47a5-d298-08dba47935e1
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p+Rik1g2NTVWNEUXCEYs5aPxZ1rX3E2BObk4h5O7WJc/IrfcCUFoEPeIr/BdoLwj57pMUTpREcUKcP2rQchGXGRTN2vECPpYFhT0meLQBD1krFP/qGHgI4n557IChEAqpCIT2vpP+0FTo5sqRpst2OA9rLcPvUf3AHnizJZDj8ApfKPT+hvxkQ7b7aXID9MxOjebM9zKpMCAbbV/fixkg0oGPGtpgsqJXVWLS5aMqVaERUE8YISanmA0vli6MU1seWkca371LUlnuAfOixH1AFqDn293JM5nQPSsDtjRZWqApOJNeYHI3XSoq5PutrDMsbJU228ElBDRbfkfg3T3RxOUDuuJHYPh7zSj25lP5vO1YVa2tkRmmz1yqBkz/R2l8KTkclf2oJ2aR9rw6T7fuxfeaqUwxhr5oH5kyQdaRrbq6KAlW23wFsdOMno+fv5VEPJFnz1oorzd4CbUrevGtqcgOhOmDyw9+cxgAfXpTcNDBozUNJx/qAdRCrJU6Ne6OZyRGy6kPgu5f7EhoBqDn5cErL6YZVBr2FMh01lAbNHeG0GPhHM9azhwi2QWhfOLnmyTxo8X1mEuE0vv68e+JlzTTJpc0C91LWuKsCQUPnNTFeDzFTy1nDACxQ1x/wNdrUX2oHvpPxjGmm2+fU7/keBNnJ4dtxl2fCXYwbJfrUGQ2uQffUqQpAhNgLdJmm2daeHLkeQciiYDVz2CMg+CWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199024)(1800799009)(186009)(12101799020)(478600001)(966005)(6486002)(10290500003)(6666004)(83380400001)(38100700002)(7406005)(82950400001)(921005)(2906002)(52116002)(7416002)(4326008)(1076003)(6506007)(2616005)(107886003)(6512007)(66556008)(36756003)(66476007)(86362001)(82960400001)(5660300002)(316002)(8676002)(8936002)(6636002)(66946007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L5LGts4WNYFdxDEGO8r4sk6ROI3yQXOm7B2xaCGO8zxi7u8xFV2f4jk+AJk1?=
 =?us-ascii?Q?WJYNw/MynT6qmAzhV8yGbauuxreSq7s9qq8ph2PD8yvkWv7lnTIAhvC1uMXr?=
 =?us-ascii?Q?tAQ1p4hAG4zAl4ew7xpWBbZcQa8D9ML+nY4BQa901Uv6tMnnE2SPqqmrku1d?=
 =?us-ascii?Q?1fIypeSWAI7ymwbtP8aD+uafyyvUvBXZZ64Gu1xJApnz+gPaJQHSdyziKJRZ?=
 =?us-ascii?Q?5NPpNSpVX/s1TVaXAoAMl7gDTRVmFijZdQRM7EXAulcMm76RHT8HDkQZyoCX?=
 =?us-ascii?Q?VqMTpZqIg2sZ4IeRqoz6xGYsV5PbIELaqrCjs/zUGLSrM1wjXmiy+hwnBmOd?=
 =?us-ascii?Q?PqtqphyFCq2HzhZ4v5ZbpRHxxdINse5C2xqOJVFaGRbAEGT/qic9lBC6N0Et?=
 =?us-ascii?Q?hsqUmTn4Sftid+ZCoEHBoHS9gRRdcyx4hsN148BYPCFKu3nLEuJ3NgRrlgnk?=
 =?us-ascii?Q?mDcK3CQTXJKxYcAmzu4Wct1Sz1u9ovUaTqcPG8oThTcXKwkRVxcxj8XIlH9b?=
 =?us-ascii?Q?ZuNN1f4yYjPqxjhE0sK3F492SlCQ5izXZBAleCX15H72jvu926zimyPE8b3e?=
 =?us-ascii?Q?YHGO9bX9TnDRV5EVAoA2BFt2G1R73CsHxwmTxIjsdX1DwhiP/A3OCP1cgqnO?=
 =?us-ascii?Q?5rm1ybKqBGCf7dXsw+YQHIeSY6+qfeFjrX+ROVd98BvFPR2fkz7H5Ze+iRu+?=
 =?us-ascii?Q?JaJLK2w/41eRzNjA3UAAiLuM4DNXK3+eiX0Olhoerk6Nk+l220BkDFmEGomq?=
 =?us-ascii?Q?u4mYPFkTDaJ+osnd/YX030KhUgSYW///Gf6xPRxNTZHkrVNw/CG5svxKG2O5?=
 =?us-ascii?Q?Kyms4J0UFILm441xxhE2c+L3F5/pTNHUYjqbQHsahtjCiW4pCATwnl+Otu/+?=
 =?us-ascii?Q?liApMhJYlOEp9X2gYSKzqO8TmpzwOBEDhQeMKt/2vzXXaLvBgxOAHdR5t5nF?=
 =?us-ascii?Q?jTHfsFsVgaJYorqlae5h3o7N256EsEKb8sTUFNJyj+Ie5CrXguiIfvoBX5LV?=
 =?us-ascii?Q?qCBCxR231HUjof0mNstiXar9XRuKiGfHhkPkzhaYQqOwhspHswhBFgccz8kL?=
 =?us-ascii?Q?LHI/tyUPiz9qZmPEkCPicPbfWUGyh1K1BQFJzg9qY8xgHgwHoxx8PoW4jM8O?=
 =?us-ascii?Q?QUsfKp+qQe165UWoNQtBS9T/aLUdorO13UVFu6aKyJsRkOCdFC8acKRFL397?=
 =?us-ascii?Q?aF4g6jpLAQiYR+eQCM0IGZHBcO9rUnM5bzkRg5vTkV5RGrBHspzhGfqtHDQ7?=
 =?us-ascii?Q?6eo7XrG1aP1eSPUxWXXAOvB2U3JbJ2Vs7KKhlOMpqUKKxJb86ZzL/OAV9hko?=
 =?us-ascii?Q?8h9vizPVPBHmCvKd+O/H3RlXeIehm0OiEgZbRiArM80g/KTq0h49i0t3KmqB?=
 =?us-ascii?Q?1OI0ks4gOqe9OVKSWL8tBAkSP2Syo0MbyVeWOguvxdsz4CWJG9VT7aR54xuC?=
 =?us-ascii?Q?31MIIww9rDYaZL0K+hRoV1nGDs3ZtveS0ogBGwtqN7K7GQvu7A+3ZDxVH0Ru?=
 =?us-ascii?Q?m/N93uj72g9zMRyiSXD8j8loqa+Rxhkiie7q5nXomongcxwbz5DA3j0wp43Z?=
 =?us-ascii?Q?psGtsO84vvD6gg07md/apTx7rLmyMTTo38BqHrvN5qxQjSYsFPm2C3OM3Fjf?=
 =?us-ascii?Q?/RRdPgi9RnygToq8Mb7PAN2q/kscGNcEw9ST4aHf/5EM?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0650dfad-26a1-47a5-d298-08dba47935e1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 08:07:51.2396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DzfD8LIfTDV27oXurp1WBXkNI8RpDu9TyfD1Vj9YGGThEDePxp9cpMPk/gNLpNWzQwNdOTxtoYne9KDoJFBACA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR21MB3901
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hyper-V provides two modes for running Intel TDX VMs:

1) TD Partitioning mode with a paravisor (see [1]).
2) In "fully enlightened" mode with normal TDX shared bit control
   over page encryption, and no paravisor

The first mode is similar to AMD SEV-SNP's vTOM mode.
The second is similar to AMD SEV-SNP's C-bit mode.

For #2, the v6 patchset was [2], which is later split into 2 parts:
the generic TDX part (see [3][4]), and the Hyper-V specific part, i.e.
the first 5 patches of this patchset. For the second part, I rebased
the patches to Tianyu's fully enlighted SNP patchset (which has been
in the Hyper-V tree's hyperv-next branch). Since this is mostly a
straightforward rebasing, I keep the existing Acked-by and
Reviewed-by in the v6 patchset [2].

The next 3 patches of this patchset add the support for #1.

The last 2 patches (the 9th and the 10th) just make some cleanup.

Please review all the 10 patches, which are also on my github
branch [5]. The patches can apply cleanly on hyperv-next.

I tested the patches for a regular VM, a VBS VM, a SNP VM
with the paravisor, and a TDX VM with the paravisor and a TDX
VM without the paravisor, and an ARM64 VM. All the VMs worked
as expected.

Thanks,
Dexuan

References:
[1] Intel TDX Module v1.5 TD Partitioning Architecture Specification
[2] https://lwn.net/ml/linux-kernel/20230504225351.10765-1-decui@microsoft.com/
[3] https://lwn.net/ml/linux-kernel/20230811214826.9609-1-decui%40microsoft.com/
[4] https://github.com/dcui/tdx/commits/decui/mainline/x86/tdx/v10
[5] https://github.com/dcui/tdx/commits/decui/mainline/x86/hyperv/tdx-v3

Dexuan Cui (10):
  x86/hyperv: Add hv_isolation_type_tdx() to detect TDX guests
  x86/hyperv: Support hypercalls for fully enlightened TDX guests
  Drivers: hv: vmbus: Support fully enlightened TDX guests
  x86/hyperv: Fix serial console interrupts for fully enlightened TDX
    guests
  Drivers: hv: vmbus: Support >64 VPs for a fully enlightened TDX/SNP VM
  x86/hyperv: Introduce a global variable hyperv_paravisor_present
  Drivers: hv: vmbus: Bring the post_msg_page back for TDX VMs with the
    paravisor
  x86/hyperv: Use TDX GHCI to access some MSRs in a TDX VM with the
    paravisor
  x86/hyperv: Remove hv_isolation_type_en_snp
  x86/hyperv: Move the code in ivm.c around to avoid unnecessary ifdef's

 arch/x86/hyperv/hv_apic.c          |  15 +-
 arch/x86/hyperv/hv_init.c          |  59 ++++-
 arch/x86/hyperv/ivm.c              | 374 ++++++++++++++++++-----------
 arch/x86/include/asm/hyperv-tlfs.h |   3 +-
 arch/x86/include/asm/mshyperv.h    |  43 +++-
 arch/x86/kernel/cpu/mshyperv.c     |  65 ++++-
 drivers/hv/connection.c            |  15 +-
 drivers/hv/hv.c                    |  78 +++++-
 drivers/hv/hv_common.c             |  43 +++-
 drivers/hv/hyperv_vmbus.h          |  11 +
 include/asm-generic/mshyperv.h     |   5 +-
 11 files changed, 505 insertions(+), 206 deletions(-)

-- 
2.25.1

