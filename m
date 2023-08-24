Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BA47869AD
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 10:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbjHXIKb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Aug 2023 04:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240529AbjHXIKR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2023 04:10:17 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-cusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C5F199F;
        Thu, 24 Aug 2023 01:09:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFfGYd9e+s4a/0Zui66nJ1mjTuBTRPbL2U7jSgRN5xWNrkn2Qre2Sq5xAG+2k423Mp8l/hHHRVmOYsioPl9SoWwg5YZlE+m4HFl5OMv6iqh8UOf1gzxLZ+u5CfV1cTSyQyAC5MCOKAM1eDMUHFyYDwNHg/GYDTmP9toHtS81r5CSXQ3b+XLF4EzKInf5gY7FIdtJU6vsA5B0nElIt+QM9Y1EGtpLwNHmIM5o7kj31uMhNZaJZVFgAfkjTh9C49pOhTF8bWIPShybuh27tFYXH1A6CxmZ3buMWELDZ3ROLfqdAsfk3hxczGT6IpHTW2Y3mq87AuGuH8tOxuYoi4JdBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwswV8Bj6wPA8UjZhh+UyjKK1FqHgPhxmwpfmGElJ8M=;
 b=a9dxqrNIRJDCf5W2qsahMzDkhKwbWz5LOzxwN864dgysPEELJ6WzMRg2eZVSsafI3GEx4i3SBw8fZ68LqC28bW7DIxThE0D+bzG6/2eNuXtDaz64iQpznsK3tHDv0AuQ/sUdBeZhjB7t2xoT6fN0Ymw+H2L1TpwMOZy4y9VCYwYzK6Ei0+lRgrqnGuHNApwki9fHrBLYJaT8qZ3OOdfG2POjJbE/QsTD94hJDBc/bXO622DPzAPltYNHZxfamkUjKapCkuv/XGS6nYtNN6JLJZm/zi428R1w3BN0GWq1HDqLa5yhJsq3VcuMBDphl1It8fUfnSsKTxJO58rf6d9E+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwswV8Bj6wPA8UjZhh+UyjKK1FqHgPhxmwpfmGElJ8M=;
 b=gGySFw/gIEcPszhZAl/Et4xCG0Mjz83swzI3F74VlHi1dOyXGOdu2kS878l6g29/K+Tz8DEElNyl1Q5g03wN/1QmYAdvylTp3vjhYZvm4OszoH+y99vTH9pwxFQ2GjkK5zgegTEhlgmD+WPg2QOMaMfYgdGp+rxTYm38c1XVTKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by PH8PR21MB3901.namprd21.prod.outlook.com
 (2603:10b6:510:23a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.4; Thu, 24 Aug
 2023 08:08:05 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad%5]) with mapi id 15.20.6745.006; Thu, 24 Aug 2023
 08:08:05 +0000
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
Subject: [PATCH v3 05/10] Drivers: hv: vmbus: Support >64 VPs for a fully enlightened TDX/SNP VM
Date:   Thu, 24 Aug 2023 01:07:07 -0700
Message-Id: <20230824080712.30327-6-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230824080712.30327-1-decui@microsoft.com>
References: <20230824080712.30327-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0175.namprd15.prod.outlook.com
 (2603:10b6:930:81::20) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|PH8PR21MB3901:EE_
X-MS-Office365-Filtering-Correlation-Id: da8a13b6-635b-42eb-db3c-08dba4793eb5
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rfb+9c7tJgbUhqUoyQgCsupWXrRuFujv5e2XJgwNm0o99gBGbfmkGoE7fdtP10yHmIP4oNeeB+xepq7XwUVNfiLOniQIMvjxwxoMUmz3/OVqihIDYO4ty9yKZjezWSIpwS356XIf0LMBkYlLK6doYdjIZqIQ3EGKyqU0E0cn+8VOFcSaOOjMoevC8egy1cB23x5dT82TfvsKyfuJIuV23Ka201PePooK/S2XEddS5LhGnWCAYlGTb/JUAasagzDp61oYiYCbhemlUysMISatOSAcu2PyfevFyye9Pxej3EaIyxH13WwwAZvnLmc7/+8NT5SG5Md8mKWaxge+Yexzv6T16wB1/PJ1BciQVy35XLJLPDYJqOW+PhDLtwwbO3WJe2UQpcKvnENd4kF8xb0K0mGPLhC1B/Qm1WKP/feZAwvywbulh2tyysXD+hSyub+paKt36OlXoMZrSWNa4pWSJYqCQ2ntO1umpHNW9OoNttDNtP8oVi+Q53bYEFstV/hPNZ5+J7GQ2dhoBvksRFcmoVdxTAnQIIQuGcpOE997yzP78XoeUFAKGlit+CUfXENZkTXfnx1hu/vTujYJ1U0AA6cMteiU8yjup7N1X97iGyLIn5maTcT0TVQ5vzUnjnLuEZiRwSw1CyYmuLkA1U0V8NiimUiF4yh/FimnKyM2TpQYgRYhGj6Lnnw0WGJN75YA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199024)(1800799009)(186009)(12101799020)(478600001)(6486002)(10290500003)(83380400001)(38100700002)(7406005)(82950400001)(921005)(2906002)(52116002)(7416002)(4326008)(1076003)(6506007)(2616005)(107886003)(6512007)(66556008)(36756003)(66476007)(86362001)(82960400001)(5660300002)(316002)(8676002)(8936002)(6636002)(66946007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wt8YhSzxKcMFbLqdc+NCiiRf2E9FDEY6WlXXKvNKsWvydqLP4ZHFDGpuN38d?=
 =?us-ascii?Q?DGlqVkCzXk1/mMUKkb2OziHHpyyI3xVs+OUxG0xSalY+q3ReJwQQW/mcXroE?=
 =?us-ascii?Q?QZtGbjqNCkGuEZkC/Xx/fT+giFJLfsDzQsufgphfVX1syVmihq0bm8I7+bgE?=
 =?us-ascii?Q?StAMiFg7DDBjgX2Y+FHJ0hEyJRf1FpU+85/qKpfPp8isOWt3pi5L6mdY8g/E?=
 =?us-ascii?Q?fRhai3jJ4QiSja8d8Tn5RO+Z+vVqqtNJpkWRvUx98Mp1VItxmB8ccTo0LcH9?=
 =?us-ascii?Q?O+TkMpSt1LPvEn7OPV7R1zASC66qqIFK2BgeymxT7VG5zn71g79De9oY9GhX?=
 =?us-ascii?Q?vbmaJr77+at2HYKbRdrG3TDx+3Png5EmCq79hsPXR01GVPiDnJNw5z+Or+Ei?=
 =?us-ascii?Q?fE1GUcN0shDxAZZdXurHxsL87zYZVezonK7AEiQJLEnFQ1b0WeMGrMl83KZE?=
 =?us-ascii?Q?hXTJosdFS5pnTS1L/Fbsqzvb0/SIftaC5DrcOMrMylIhiofpmF319xSuf2Yf?=
 =?us-ascii?Q?nybxM56lST/DKogc6BvhHbdGxFqlGrCe3F+QETtCx4XW4MUdbc25KFbRgnNP?=
 =?us-ascii?Q?xj+1Ssak6BeM3EQ9heOkZ4RcIaO2m2PAPljONGmT9mvkBOYQbwRVEOV6BF9p?=
 =?us-ascii?Q?egmZ14IpWJ+L+SBCUigDmVTYJ6Gtfa28OGJ4jiKZAI7QNwJqbQbas8P9yEj7?=
 =?us-ascii?Q?MJ8x7Gsk/eCG0YRShykM3KWW6a6xYHU5B/2MzsJHqgBLNMILJHjnNe9WxENR?=
 =?us-ascii?Q?LrQRZLI++wj92VpIW/6ta/VIaGLp16BnJQos0Oq04HGEmMtoYju9Qdaq2iXs?=
 =?us-ascii?Q?wLdZM1Qefq3FtCa3+ZcphdllMslNNOF1/ZTnSavWX5WmxTpoltQhOQrQNX9l?=
 =?us-ascii?Q?x4zea/LSYJ4LV5fi2MwwmLsKQFEfSGpGpDaQ0rk7a1AeSFwTUzoWxT717MBY?=
 =?us-ascii?Q?Jcw9o86SnMS2++iKzMpkqj1l+KdFP6fK7f+5sIRDJAoYvBz2SbXdE5ifcm3k?=
 =?us-ascii?Q?fSHVu1iOXuCdWwLldwQxQUrFIsxsDWCLMFbJLKwuzjgr83Hwa0nfZIIhPiac?=
 =?us-ascii?Q?T72eHKmPr9jjoFmDi5YBlje7qfcgD+mjjeiIMo9zCo3L92xea+esOmLShmu4?=
 =?us-ascii?Q?4OSF/0iAiit/OmRbTltQq0rWXGwlcijYet1dBuTfRmpzSVoPKJqYfjr/5uyB?=
 =?us-ascii?Q?/6LNRIK/ylURITnEcMGFY//LtURUUDXp7GXNxrIWQbpCQO/ZK2BGhlbdCrT0?=
 =?us-ascii?Q?vJ+peTy1+UFiAmZOwBt3T7v2qtem3BeAczuFoY8tRxV/hXcsrh3dZoncgneX?=
 =?us-ascii?Q?yPvxLvbqEIZ5E2Nk7v1i4JCk1LprIcG7v6X6OtQy0PUnLQTuMLbBTwoYsboR?=
 =?us-ascii?Q?0LYqv3DXuu3y/rDOCHLQy9WnMdfaseq+TMP75lmv83h6keicnvZr5rt3WzNm?=
 =?us-ascii?Q?y8p8H4jWS2SyLqt7TlRshvDZwjojxCVVK91aOr9ef1eeX/YLH3M0mEGTMF6e?=
 =?us-ascii?Q?o9mIVvvcka6I/Sn/9sdm2bxoEys4rebt30fIF2JWXHUtdDW7cixp3+FLxdfW?=
 =?us-ascii?Q?FEvi5bMGcgWZFH3tBhojOU+gyIPR7ltGUBq3xY/G6pabFYrOjkyw/Fjf9uCc?=
 =?us-ascii?Q?sFxjA9db3CfrHQVHR2vBkTnwSU9DvtVzor/qqX01PKpY?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8a13b6-635b-42eb-db3c-08dba4793eb5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 08:08:05.5787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kvx/n/npasp6IVtWdch4hyOdSne4aiiyntiC6dAodmmLhyGtqzHMYyB/zkodT3q3n4HN+WLxJGA4zIBIekkxg==
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

Don't set *this_cpu_ptr(hyperv_pcpu_input_arg) before the function
set_memory_decrypted() returns, otherwise we run into this ticky issue:

For a fully enlightened TDX/SNP VM, in hv_common_cpu_init(),
*this_cpu_ptr(hyperv_pcpu_input_arg) is an encrypted page before
the set_memory_decrypted() returns.

When such a VM has more than 64 VPs, if the hyperv_pcpu_input_arg is not
NULL, hv_common_cpu_init() -> set_memory_decrypted() -> ... ->
cpa_flush() -> on_each_cpu() -> ... -> hv_send_ipi_mask() -> ... ->
__send_ipi_mask_ex() tries to call hv_do_rep_hypercall() with the
hyperv_pcpu_input_arg as the hypercall input page, which must be a
decrypted page in such a VM, but the page is still encrypted at this
point, and a fatal fault is triggered.

Fix the issue by setting *this_cpu_ptr(hyperv_pcpu_input_arg) after
set_memory_decrypted(): if the hyperv_pcpu_input_arg is NULL,
__send_ipi_mask_ex() returns HV_STATUS_INVALID_PARAMETER immediately,
and hv_send_ipi_mask() falls back to orig_apic.send_IPI_mask(),
which can use x2apic_send_IPI_all(), which may be slightly slower than
the hypercall but still works correctly in such a VM.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2: None

Changes in v3:
  Added Michael's and Tianyu's Reviewed-by
  Fixed a typo in the changelog:
    hv_do_fast_hypercall16 -> hv_do_rep_hypercall

 drivers/hv/hv_common.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 897bbb96f411..4c858e1636da 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -360,6 +360,7 @@ int hv_common_cpu_init(unsigned int cpu)
 	u64 msr_vp_index;
 	gfp_t flags;
 	int pgcount = hv_root_partition ? 2 : 1;
+	void *mem;
 	int ret;
 
 	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
@@ -372,25 +373,40 @@ int hv_common_cpu_init(unsigned int cpu)
 	 * allocated if this CPU was previously online and then taken offline
 	 */
 	if (!*inputarg) {
-		*inputarg = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
-		if (!(*inputarg))
+		mem = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
+		if (!mem)
 			return -ENOMEM;
 
 		if (hv_root_partition) {
 			outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
-			*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
+			*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
 		}
 
 		if (hv_isolation_type_en_snp() || hv_isolation_type_tdx()) {
-			ret = set_memory_decrypted((unsigned long)*inputarg, pgcount);
+			ret = set_memory_decrypted((unsigned long)mem, pgcount);
 			if (ret) {
-				/* It may be unsafe to free *inputarg */
-				*inputarg = NULL;
+				/* It may be unsafe to free 'mem' */
 				return ret;
 			}
 
-			memset(*inputarg, 0x00, pgcount * PAGE_SIZE);
+			memset(mem, 0x00, pgcount * HV_HYP_PAGE_SIZE);
 		}
+
+		/*
+		 * In a fully enlightened TDX/SNP VM with more than 64 VPs, if
+		 * hyperv_pcpu_input_arg is not NULL, set_memory_decrypted() ->
+		 * ... -> cpa_flush()-> ... -> __send_ipi_mask_ex() tries to
+		 * use hyperv_pcpu_input_arg as the hypercall input page, which
+		 * must be a decrypted page in such a VM, but the page is still
+		 * encrypted before set_memory_decrypted() returns. Fix this by
+		 * setting *inputarg after the above set_memory_decrypted(): if
+		 * hyperv_pcpu_input_arg is NULL, __send_ipi_mask_ex() returns
+		 * HV_STATUS_INVALID_PARAMETER immediately, and the function
+		 * hv_send_ipi_mask() falls back to orig_apic.send_IPI_mask(),
+		 * which may be slightly slower than the hypercall, but still
+		 * works correctly in such a VM.
+		 */
+		*inputarg = mem;
 	}
 
 	msr_vp_index = hv_get_register(HV_REGISTER_VP_INDEX);
-- 
2.25.1

