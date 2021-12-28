Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62784805E4
	for <lists+linux-arch@lfdr.de>; Tue, 28 Dec 2021 04:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhL1DdH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 22:33:07 -0500
Received: from mail-centralusazon11021015.outbound.protection.outlook.com ([52.101.62.15]:54485
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234716AbhL1DdG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Dec 2021 22:33:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euSUZsdD8Aba+pTgEX7+WqW1po7Aw9SUUfeSvGd11u+02DEp0djb5tMADzORwFAKKpKwiZJcxGpYbdADFvVLzBHav9J/mQeib8BSqa1AsYGHN0cT+vFDnr8hfGfKArazgacixxCxuj3x7rWKTmf4b1OQ2uH7O0f343buB5Hx3JC76TVcwH/cr7SjUFh8A5ELGfUcx23nxJlmSJF+HrQqrIixmPhdGnrkCNeiFp3c1f2E6U70WUA206jQwSZrNBLgbgid6jbJpEUmE4lcASpaeTbQuxHwoQAOLNKUOwaudE3qGhlfmVrnnB4Coo5qEGErl/ryf//czBUaQfwoZUWluw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZm2e7r2jSKfToR3pCci7F5GeR8cAIItQwTUOunAJxo=;
 b=R6wpd+DYniJzgyNgKMywHw8FXEWnPYW3PATKjRUcYWPDvTqtgLNl/MTrGkCKjO8QIbVm5OKzGJABlEf4X+g9Z3LIqcyBziVfsmriB015yBbzUVN2nqUSmtgRQrQggm6NWI2njioLrdmb0laUNrhe+1aDthO8JY7M1hQBJ3oy554DtvZxx2dCJ2RGs2Y+RxjGfChdNL+cSRrNBQ+1FaPC9+pDCHGfxNqwlUB8hg9mLMmCNgXygmwAAaO3x27zhQjrKnHrNr3gaY9yBC/ROgwDOciHI6wF7ZZ5flmBNrQdLVm5gL8RDcEEO/vxkvqm4lOyR9D7RCmd+Puxh/4KuFgt6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZm2e7r2jSKfToR3pCci7F5GeR8cAIItQwTUOunAJxo=;
 b=iWKX+Qo86/ANBM61iEUsT+bChTElWzDEJEH0HtAW+oy5A5vAyl2TObTgxp//dORBaLjMvf1s6sW++dnRVxRS+d5Qga8H9XFPaQS16C+3tFf1IJRq8V48XLI5+7DSomorxek7HJL/LyIz628mzAoXlOGfdTeK5lhQenG340IJTSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by MWHPR21MB0477.namprd21.prod.outlook.com (2603:10b6:300:ec::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.3; Tue, 28 Dec
 2021 03:32:56 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::4c2:54c4:85bc:dd62]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::4c2:54c4:85bc:dd62%6]) with mapi id 15.20.4867.003; Tue, 28 Dec 2021
 03:32:56 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, arnd@arndb.de, tianyu.lan@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-arch@vger.kernel.org
Subject: [PATCH 2/2] x86/hyperv: Fix definition of hv_ghcb_pg variable
Date:   Mon, 27 Dec 2021 19:31:55 -0800
Message-Id: <1640662315-22260-2-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1640662315-22260-1-git-send-email-mikelley@microsoft.com>
References: <1640662315-22260-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0266.namprd03.prod.outlook.com
 (2603:10b6:303:b4::31) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e06747f-8842-40f0-1bc4-08d9c9b2bd36
X-MS-TrafficTypeDiagnostic: MWHPR21MB0477:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <MWHPR21MB047735CC1FAF94ED7B729FE4D7439@MWHPR21MB0477.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gmw60Yz1Buhe+yrLtqD/jytrjS3h6ltp2ZL6N4GNo89RxQRq4E3mlL6Lq+btU4po3AKIxiWi8killOgBedG5oo29BSScnzPHMaKlf6efLQ6va0Rqc1CD7MDLI1iaeWzLzu6Do6tYw8xQJmbLcPYozGwDI1uGmV7ogUnXH4lu7wPAuDzWUb0WaFoxHhqbGV4Saup/A06c4kW/3WtIabstbeI6TCYO3NUVF0qMJAyAbRhQjgjOYjOzuGbsxW36Y3h0iuOqoRfwxX/Y6jlF842ezcuUuuXiUIbQZLnTRxBmfFNuhFwBWFDRDWjzmq+SEEigz3hvs6Cl5x1ZiZNmj5fM5MpwamHkeq5CMjpw+5ohHFyXtmvK7S+ci76/P5ulmVdftfLUEaJlRc1BceIpEPVKYSbqvzxArGNZ9vXL8ZVUKWK60hKm3RcRafJrfay+USVNq0ykKK2vmqmiHvTwnMJRreWhaE5Q7HH0h8+57VNfup6ZxUEmuWwkpQvMt1AWlSGmYD8ieTwF2oXAEkQT9mGHVTYsxOTa6DLbFcowk37Gx0KZOzNgcyWlGMgjGcFi6RiKfIrxMvxBwdo5X4U8eLM3f3qm3kPaPCkNXGknLfL3WlFNA5CUZzuovH4RMHkQHCR03WDTvZ0h0kW648oyHa7IimWkjEHwzFHBQKUu+hiSNz4buUGVZcajp0VYj049qHQ2koTgsXic7hnhQObzCKw43AxbbvJnglxBOVgW8j7QumrYgLBd/gxib/WiWEEVEPP79ldEDCc3UqJg2GcN/774Tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(66946007)(921005)(52116002)(6486002)(82950400001)(82960400001)(86362001)(316002)(36756003)(2906002)(38100700002)(6506007)(38350700002)(66476007)(66556008)(5660300002)(2616005)(4326008)(7416002)(508600001)(8936002)(10290500003)(83380400001)(8676002)(26005)(186003)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v0hP93clAjtdTpyeT2ZHjYPHpS4x9QYDABLSrernMpu9p1C3amw+X0g3raEn?=
 =?us-ascii?Q?s5V5t1syoSFg03FlpDOwsO5jevtKWDVXWViJKFmnTU9foZeyFFz/cmcLCH1t?=
 =?us-ascii?Q?iLWxjwJWOM4gWfCw47spqAsMrD20WyCKOCy3ofxBYNHd5vi0Dv0vBIbKX30d?=
 =?us-ascii?Q?gnPFBJiSfzW+0J4XGPvXAn2U+x6ILvlfMVmHIcffGe5g6/oOPzWggTk3OsQ7?=
 =?us-ascii?Q?g3qU/SVUzkJf3BrFedNpBSJzdbcNaLIrweMoEI0KCji6k6xkVq87OFfzMx0X?=
 =?us-ascii?Q?T7nxfpAgS5bI76gcsaQylAjR5goirnW0DPW8ssqcrP7Il6Dmt3nAKRbvgQWC?=
 =?us-ascii?Q?24Yy+UpaIoqiluSkHpBhd7C4p/Yqmy0UE4NNLBj22RIDh2DarRzjoYj9lgbg?=
 =?us-ascii?Q?EN6ztKO8gKq+xS0is9QtEhLrjhRmReq7sXXtDLo23qO2VaMYqMOSeTxvEbcC?=
 =?us-ascii?Q?mUMmQNzwIklPjs66enZxBt6PxIp/hceqT6Cockjsu10DrDh1jkAFl7rg0woN?=
 =?us-ascii?Q?KmMaX5bxplKTzKJqGhbnKBbfUAqF96Bkyqh9CYvGq/dNeCyUCFCrO5ostSMX?=
 =?us-ascii?Q?WW4Vs+yL9KoGQLGw9q4YEPOmzREPuK/Gslwb9Oy3+dmqWjGYbwUN1tt+xeMV?=
 =?us-ascii?Q?1ckDI5jLMJWBSxTyAlB0tos2FLOGlB7Kbju95EZeX0eU2BCVNr37bY1S2Ni5?=
 =?us-ascii?Q?nVg7WQQbweuTGWjqOnVr5GTonbfhlX+NW61SxMRnuuQYeqWTJ4fm/QReO96I?=
 =?us-ascii?Q?63AESB+3hU/AlTLwUEe0ArvOZHZZ7r7AjfQF6ezwDf/DtWEbIAtSTbMF8IAp?=
 =?us-ascii?Q?VICjbLbPSRzqPMgWDKoyrVft/Yq9PbKT7W6fKa0KvsL8/TuLKDuOwB9Ux0Be?=
 =?us-ascii?Q?OhwDOLbi97KF2A0IHGasyHRsae/j1kXJQkkZX3ruZfxVQLCdMufiyUznUVY4?=
 =?us-ascii?Q?Miky30KmgDNCFcWEBSeD+RaCkkVuN7ZzzftbDZ5L+/V4G71wRbagby7Jz3PJ?=
 =?us-ascii?Q?dQoB6BJ4GwoOXvqW3VRatyfBnmIO1WTzFEXxYZjQSm8FSOespn+zxdTmj7mp?=
 =?us-ascii?Q?Kx8hrPXOKOWTqRTN94hwdzGjDTCZoWvMxsRlNGoASkDzfFtiQ0IP/Z2WlRTA?=
 =?us-ascii?Q?dugHo7UWRtV2jOiiRNATvV9vZCFCoM5oFR+Q8rtuejJUqcgEQzcyY+49sEdz?=
 =?us-ascii?Q?9Dc5FMzUNb/MNNM4c7Wlj+Dmvmmsl/Xj3Qu4RcRtwVhumP4zg9SFKvhTSMZR?=
 =?us-ascii?Q?09JHd8USYRxkG7PVDlxeUlmnK9xlqtu0TGSjw6RLE7B4CUDq51RGAElPHVgO?=
 =?us-ascii?Q?4F0COf4PEpXWxu0oj/nkkqUVRryG2bPoROTRZGc2VsxM/bUVkxq/0BY/qdGW?=
 =?us-ascii?Q?H9gyoGWsyf6R7CTuZRTEH4wI70MiG9y5mzvU3NciQKbmhG0oh3T9Mt8oHI9t?=
 =?us-ascii?Q?dNIveDzMp/dvlEwYoRDQrSv1bPTiqLUUY1kL5/rIUdPFA20jtOYrXAIIeEos?=
 =?us-ascii?Q?6Sx1U0/9Ihh1kD/YP1GCrmLAies0+W+j+cA1hiJUQTCz/A5xdm15fxOvrgXS?=
 =?us-ascii?Q?NHOhDSwjjQ5CVrAp/YjaRbjQ7XGuqo0cSe36UY7w2lv6ESPTwK5RFj0qRgQc?=
 =?us-ascii?Q?CGx11PFq/SfK+sEu9le/PN8=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e06747f-8842-40f0-1bc4-08d9c9b2bd36
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2021 03:32:56.6687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyOHddo70wRiBPSbzFDLjP0nOlnaz+kP+ayb8eVbWBsC/8hX//35YMgHxEUexxIoaJdxPrryAf1q8Ios69jJ5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0477
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The percpu variable hv_ghcb_pg is incorrectly defined.  The __percpu
qualifier should be associated with the union hv_ghcb * (i.e.,
a pointer), not with the target of the pointer. This distinction
makes no difference to gcc and the generated code, but sparse
correctly complains.  Fix the definition in the interest of
general correctness in addition to making sparse happy.

No functional change.

Fixes: 0cc4f6d9f0b9 ("x86/hyperv: Initialize GHCB page in Isolation VM")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/hv_init.c       | 2 +-
 arch/x86/include/asm/mshyperv.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 96eb7db..99afe77 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -36,7 +36,7 @@
 void *hv_hypercall_pg;
 EXPORT_SYMBOL_GPL(hv_hypercall_pg);
 
-union hv_ghcb __percpu **hv_ghcb_pg;
+union hv_ghcb * __percpu *hv_ghcb_pg;
 
 /* Storage to save the hypercall page temporarily for hibernation */
 static void *hv_hypercall_pg_saved;
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index da3972f..498317d 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -30,7 +30,7 @@ typedef int (*hyperv_fill_flush_list_func)(
 
 extern u64 hv_current_partition_id;
 
-extern union hv_ghcb  __percpu **hv_ghcb_pg;
+extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
-- 
1.8.3.1

