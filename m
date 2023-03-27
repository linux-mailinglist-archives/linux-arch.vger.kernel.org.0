Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2438A6CA563
	for <lists+linux-arch@lfdr.de>; Mon, 27 Mar 2023 15:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjC0NRV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Mar 2023 09:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC0NRU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Mar 2023 09:17:20 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021022.outbound.protection.outlook.com [52.101.62.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E011723;
        Mon, 27 Mar 2023 06:17:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZO0CrDEK1QccjzYkBaD7OLyKYSkzevj6zDZAodVtWs+4AbS6+HBU2QtW1+Pn6v7o038t1UABnXrz04KaS36b798ypKzmYpH9XLWDiY1ZgoK9fYYJxcaLz/Wk4Pad+EXLilB+uPEMkNYpH3t94Cw2RrRzsOZL7ppfg7tWWTdDkb10p9q/bjDE94VPvTaNGxWeYwxm8GHJ32b4IrQf51Kg4KxoqteiEWL05mRbZE1Ao3w5FVXlYPlYd5iwhZG8BeP/H1NN/IWbgrBg+DvjbEM40XFuwhidSeudLle4rWQfMSnScuFaM4DGaxR7eR0ySI5UNC64c3yl7v0+71vqwleRiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3yqcVFe5g1URHBUi2wMMfEovBgS4ZR9Gdc4fXfzDTo=;
 b=NKielj0KXqFKywRftcUW5cZjbU3Tbod/4pLiR9/c7UH8wMw3qkHkyVDhjWLqlRFf4diR3CnCrX/GVKEE/86IoFqDv89OutT05GjArgcA6G/MmjVJiByOopZUNydnkT3GsRvhx7GVx1i3MD5PSRQ87DlRgs2j4vCgHFUH5bP/OFxvEGlxeomwM0datrgWfsbir26i5DVWhUm0hcG5z5rP6lQTZaM29yVoQruDY4ZUQ0LQItFhU85ARr+XMlfHdZqB54HcxKGjOg+mvLgp6ft1GNdM103MksShzLFVf44zFZKkZjYVZdDsXRYUPdW+LOi84QFLI5vWPmopHXobT1W2lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3yqcVFe5g1URHBUi2wMMfEovBgS4ZR9Gdc4fXfzDTo=;
 b=Xl8iGSk181mqgoLsTEO7SVsSPo9qCpDybQPol17tmaLs9ArJA5RIiGmfMlZLPFhUtM7+RrY0xyLauV8T5Aph0+zPmJiC5OiqX0eJk04SkV0RvYJgB5F9RvGDyLoE8tbYHLZDHn2aM4wiyg0J48IGSlVczH4Crhw5yOxc5HtqAwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by SA3PR21MB3960.namprd21.prod.outlook.com (2603:10b6:806:2fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.11; Mon, 27 Mar
 2023 13:17:16 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f%3]) with mapi id 15.20.6254.016; Mon, 27 Mar 2023
 13:17:13 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 0/2] x86/hyperv: Exclude lazy TLB mode CPUs from enlightened TLB flushes
Date:   Mon, 27 Mar 2023 06:16:05 -0700
Message-Id: <1679922967-26582-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:303:2a::31) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|SA3PR21MB3960:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e6e2af-6830-4579-b9c0-08db2ec59445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5GZHT6I/+u8lVbVCk+v/qSD+yrCbKF6B0zjlaL5IkW0d1Llbz32YgSUT9V3kImxfmvte7jEp+ASWmxCwCE6c2/5tHsW12Nnz2a6PYaztrvu9yo0zAiOQOfS+vn5AtgLKnUlyxgVzIsmht+okkQ41wnGhcZvb8+Pia8Vzzr3n5IHow29wQybmfeEqxpla37Ugwe67C2HTM9B6Gd6jWq0G3fOLM+zUmyj4MXftNL5YaqKGBWh7BKRdXyqxwfb9XGhr+08iPBoMq+hERvAgQmMpbwdC3gSR8LgI/C32Lf2nvvBO6pYA7d9GB5xG8cAQnhVIV1tn63kN9eTtA9FlaZZDrc8bggAHddqDOW+kggPWNy1N1L1HOZ7rS1BpMNeXv1kcbcJYpAkOxAKgtoIyh+W+iJFimRMiOcgXZV6ICt/3zE5sYBwEUNofHi23qr0C3iK9BIKTwwWEbFLSSgmsaZtvh3dpFubnQydRIbfe5dnYvvkx1T+vcFjkcMPqR/lQ9JS4tPzxKOjc8V8Y7tkSZzMyxZR4/UB8/t/1Mlt+qcOXUXaPsxChMDkdvNnT1H0zjLsG3HekCxNbB2GFzrERgc3f+G7tqnVu5VlgLc15wo3I6pCUeO/qIJVM5V4kMW0wD2WufVLZkm8r4lDwyfScNZ6AYldIQhuOtLx7n1Bz8wf5U9GsmpCCe73Oe/69TWRi1FAt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(41300700001)(4326008)(82950400001)(26005)(2616005)(921005)(6506007)(6486002)(82960400001)(8936002)(86362001)(66946007)(66556008)(5660300002)(66476007)(8676002)(6512007)(10290500003)(83380400001)(2906002)(38100700002)(38350700002)(107886003)(7416002)(36756003)(6666004)(316002)(52116002)(186003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FnGL93yPUP1eP8a6HaTqj6OWMEmiRYFPAi7B96yI/dTDo1pJ/0xaB8AARbtG?=
 =?us-ascii?Q?z2UrtTX7l5i7QjlFCqo7FtMh6DYlZTejo+JxwruXZIdz1yD0BNAqihZAoCHT?=
 =?us-ascii?Q?PHzB6gRsuM8eumaLt95cDLbvAGxJLjcSi5mVrYaObVyx0HwKtLSzcJp8zTft?=
 =?us-ascii?Q?cEbxisoOTIMaCCQsDIht1lxugjs/VYT2Eu5WZiO10eZ8gt6gk3mG+tscI/jk?=
 =?us-ascii?Q?l0HQex+CeO7Q9HpuMv/KiFhHyTWo+FFSjmcHOKcv4yjS96AJgrrtgHQusCsd?=
 =?us-ascii?Q?2hXDB74LIKBdH6wx3zc3S/kBJrhbb8pTdHHGM3fwuT44Gkywi0zExI3pP+cH?=
 =?us-ascii?Q?POIs126+LMda1cVGhkPrPNdV9VkxUsQS/499z/TlKxjuMC9GCIiOU0YwojoH?=
 =?us-ascii?Q?S+1wLualjnLUFCLQIVMSDqsmUyl5QGyUAH5Ivd9RWmyxIXRAy9rB5nobyQPy?=
 =?us-ascii?Q?4TeRIpep/qu52LkiEvMzXwzC1xaGO6GkpsLtHJmPgF40n6Y0n8Gl7AXmnOQm?=
 =?us-ascii?Q?t7O3mSrc+2S13XE7TYdxhZrxMcmE2FTYfC9pn+NEDMl3wgACp+RWgEXjLbIo?=
 =?us-ascii?Q?wsfxcpFLBcxTaJPx9vZSnl18e2oQpl4/OIlwqBQXHDlpKGvgOH9hnDmcRkuM?=
 =?us-ascii?Q?meyKHJO7lx/SPzfYkRib8yLdSHFCqNcFQFxZmYAk5rjv82LUuLZLaAorxRoi?=
 =?us-ascii?Q?KVZ2Jd9oxX+af9NWsqNiDzsn/U2oFI4dV9Nrvo1angjyaPTnPqpouh9COSKI?=
 =?us-ascii?Q?MgSzkqsYxMM2lsFHyIsoV0IlF9uyjxeVXpSu4rp5bb2aWbnhWy/kKlT58h2N?=
 =?us-ascii?Q?SrjjQ8CNhk2OFxq3H4MRCYHyHUVwgEfq4BJIT5mEBJy1Zch5karFsa0+t90K?=
 =?us-ascii?Q?QtdpX9aoJPjzOZWPYCyvf7SwSplfoc/nphtgO8XBGt17eQcbtUpAaQmOAiYM?=
 =?us-ascii?Q?LP101S/scrTMtaOtmbE2pJyXQhIKSagl7mQsq0dGT+NUqE54Jonn6jsWlfS6?=
 =?us-ascii?Q?PBGehbqAN18o8iuWrOKwH0M3cn9xfBC/MAdg/dTpH+EyF0gAa+cf434QwBav?=
 =?us-ascii?Q?qk/NrSF+fUsorLeP9BH0sP/hIZ2NTXjgLY7PA3xKW/ju5tGmoOCSg8286fyC?=
 =?us-ascii?Q?xZc7mqEajEN3308uH2hAvoYV+J4wYhUj+ZIXTxPE+b4xDUoEmNkR5/ikRbzn?=
 =?us-ascii?Q?n0FD5ach/FWTSgh6rvE3XZ5pRkyfyzDeL0UT/i5smLDg6tcLl1la5finD6Rq?=
 =?us-ascii?Q?q6EV0rlQMUNQeB0mr8hW2y+CCq8D8zHyhPyHY+NWqryGojv8c3IVX75jxzMq?=
 =?us-ascii?Q?fjNNRXGHcnNcvSWSrJxQJ5RRzUDjhoHhR2kb2DZukBiyjPxbpOPWbUJTZVC4?=
 =?us-ascii?Q?Y4QpgIMNyh+sUnQoTDyWSnykLkgjx18sllr3RcXioekUtcSciH0gYvd6Nmfp?=
 =?us-ascii?Q?63X6JG7hUuQ1rD1/hD93XrhKlyl74miBrdm9KnTczXWzAjNyS5KOk0ehxH/y?=
 =?us-ascii?Q?8DM5jA+jacbFCutc/PcDekHn8NTunj5caS4htrMnW7hDFSbJnzy4Jqd9DmIf?=
 =?us-ascii?Q?8yRC8VQxTq4d55qiM7FCqcqmnPW2BpexZ63Y1D6V?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e6e2af-6830-4579-b9c0-08db2ec59445
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 13:17:13.5689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dx8kkH91WPM+w7xtCkZxcyVu2tLKGxDfrwdFXVgexbK2zMDFcsQXGYm9h+VfiSr9l3xYyI8ftkk14IaTgVi/kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB3960
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The Hyper-V enlightened TLB remote flush function does not exclude
lazy TLB mode CPUs like the equivalent native function. Limited
telemetry shows that up to 80% of the CPUs being flushed are in
lazy mode, so flushing them is unnecessary and wasteful.

The best place to exclude the lazy TLB mode CPUs is when copying
the Linux cpumask to the Hyper-V VPset data structure, since the
copying already processes CPUs one-by-one. Currently this copying
function has the capabilty to exclude the calling CPU. Generalize
this exclusion functionality to exclude CPUs based on a callback
function that is invoked for each CPU.  Then for TLB flushing,
use this callback function to check the lazy TLB mode status of
each targeted CPU.

Patch 1 of this series does the generalization, and fixes up the
one caller of the existing "exclude self" capability.

Patch 2 then implements the exclusion based on lazy TLB mode,
using the generalization from Patch 1.

Michael Kelley (2):
  x86/hyperv: Add callback filter to cpumask_to_vpset()
  x86/hyperv: Exclude lazy TLB mode CPUs from enlightened TLB flushes

 arch/x86/hyperv/hv_apic.c      | 12 ++++++++----
 arch/x86/hyperv/mmu.c          | 11 ++++++++++-
 include/asm-generic/mshyperv.h | 22 ++++++++++++++--------
 3 files changed, 32 insertions(+), 13 deletions(-)

-- 
1.8.3.1

