Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FB4779A9B
	for <lists+linux-arch@lfdr.de>; Sat, 12 Aug 2023 00:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbjHKWT7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 18:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbjHKWTm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 18:19:42 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021018.outbound.protection.outlook.com [52.101.57.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E901703;
        Fri, 11 Aug 2023 15:19:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adpCtpjkCO+jFbmiQ49KTwtp8IoVv3KRquAMQoZnHYZWUiTc/qUXYQGfDceYdz63a/hQkv/QACGHx34sqRblbHkhd9PRGfLprxG5Qbir3GTFJ6JzRwoM/7aUBNuS4ZjuVRYe3E00Ej2dGD7bKXg7OWUQVKTVJf0o3hPuqxmuoNQb7ttG79gs+o75W7t4r31elE8X5AKe4TgTDLBoVgh1EK/lBET9xx3B6DN5v0f7qdQRrcGXn+4db06eMMZID97jnqeY3rxhEcdG+dGj/BoT2XE+11YXnL1/kjmIO5Gg+6H/GNBZekJS/SrugY46NA8AdhpGUBdM0h5inJhl2AC+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPw7Vddc45kESbhT6KvcpG9Ky+b3HTPJlv/cwXC3dSI=;
 b=NHj0hADGuOSKWSmHE6fKokM84x3LNQmWT+/UR0/4sWvhd0z9yOzuHAFvIrFbh+YJFAC+M+JLJWnsLvcmxT7aGaAjQ7b53OjSlOY7KT3E8CjG4CaEuC9n8wCOjQslukroK+Zoi/XJiOWbAxia+dbk5VJ4KR1OQ2pkIFPQln5VcemaAtgs32YsN1BLfJ/EJQlQH521G0Wuv8GO5RKVX7PHRRsIIJkqiwy29NHaROEsTUbzCYXzt4h87JMCtPV5rDxDd0aS5ThYGZFOE0wOUWmqk7BBF42Swhsx1SzNqi4WwHFcYghvTX9W6d8tO5HUAexQTuSGa3BCanvDaufRTweUcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPw7Vddc45kESbhT6KvcpG9Ky+b3HTPJlv/cwXC3dSI=;
 b=eg2mKobYyWlGn5dS+txZpsgbhQr6ZLDNxBmlTzoMdnJiHH2ONZ3Xmz9/N+vbheT48idTH30CeJ7RkDnvCBvc37rlCkAoFirxy+aw0uei7hy5+K0flZn3sZdqqwiVUV7yli9MHDTXT2rS0hamLTXjjOxK1H3KJJddaW1fC4K8ZDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from MW2PR2101MB1099.namprd21.prod.outlook.com (2603:10b6:302:4::29)
 by DM4PR21MB3417.namprd21.prod.outlook.com (2603:10b6:8:b1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.9; Fri, 11 Aug 2023 22:19:37 +0000
Received: from MW2PR2101MB1099.namprd21.prod.outlook.com
 ([fe80::5feb:7d06:e396:fdba]) by MW2PR2101MB1099.namprd21.prod.outlook.com
 ([fe80::5feb:7d06:e396:fdba%4]) with mapi id 15.20.6699.008; Fri, 11 Aug 2023
 22:19:37 +0000
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
Subject: [PATCH 2/9] x86/hyperv: Support hypercalls for fully enlightened TDX guests
Date:   Fri, 11 Aug 2023 15:18:44 -0700
Message-Id: <20230811221851.10244-3-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230811221851.10244-1-decui@microsoft.com>
References: <20230811221851.10244-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0047.namprd16.prod.outlook.com
 (2603:10b6:907:1::24) To MW2PR2101MB1099.namprd21.prod.outlook.com
 (2603:10b6:302:4::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR2101MB1099:EE_|DM4PR21MB3417:EE_
X-MS-Office365-Filtering-Correlation-Id: b1dec020-535a-4948-692b-08db9ab90c5e
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76nb6IvlmLOck9zG+EM7G/8i3ioepgQ1M1tKHMcPzH353kHeA44hgsBGpqwlyXQVhE1jYE1H8uP8HX3xO/KGZrQsvC9QM4FBDsUIQ8pr9m9kuc39dKHtxFB2uqdXzNcRbwyTo4IZ3S/9sKjeLaJHYkdvDDfbORx4csuGvXw7WQIvl3Zu/4NQXMnFhBRe/4cy/Q6rjnTS6K2Ymmqymj1LCnI4ScNJXukahblCdL/s6GO1OlV6f/SQRZNRqLdnuJMNFdt0Gv+HcRNmlveA+W6EVRztppfQR5uvSVoDG0O/xQ9pgF4kKkLCYj0i428aiCSgaFZQ3OXthErxfSQZ/Ezzbt1eL8yqfpJKjw8mVJNUznwuM/nEB0Ge32o+kTE2fQ/TZLK1zESNiJkS+HsvDJmo2DHctQek3PHNvmSCzwNuNpeXEJxo8l3pCAD8BrXCrKyERAlluxrP0GbWsId5ZS8bR4pQ78+ZmmgowZERMnUbDRPXN3m+A7QPHXaIG6/SOC4dXiSzbHjLTL/GoPA8NkiR184FWmbHjVDB5AnUoLc7F12AA4lCNj639oDRX6g+8Smcb7GCwOdGao0SWBY84Io/zLNpx5Lgcoi+Z5YLwxnLqSNMRx+539y5iRy6qzOb1qmnCCcw62+Szmxfvu0W4DUA4pW79p6PSpbo+0ktsVLB7AxGj41zAiBOlM/x23E5Fz6y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1099.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(136003)(376002)(396003)(1800799006)(451199021)(186006)(2906002)(12101799016)(36756003)(2616005)(86362001)(41300700001)(83380400001)(5660300002)(8676002)(8936002)(6506007)(1076003)(107886003)(6512007)(6486002)(4326008)(6636002)(316002)(52116002)(478600001)(10290500003)(66946007)(66476007)(66556008)(6666004)(921005)(7416002)(7406005)(82960400001)(82950400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/5LXOI3/byVzoJjYJ3taN4r/1JjGeedfAlfT2vWVGt0N5YDOtvxPDmQeFhv/?=
 =?us-ascii?Q?P04092yfpba4ofEr+/jTyLdf4Wu+yGg7GGeSk6WgjaOKaolBP5usu5/xCLjS?=
 =?us-ascii?Q?nUPRKtmoTPNWECgZy6J9H6bxzLOvIFLN1iLuOau0uUkP59MVy/Q2x3gt+LT1?=
 =?us-ascii?Q?wGJrPFyo+AUwlC5UedY9Nqy5UEbEcCZ/+V0cV4Qg8h1aPDZN0EFomSuMA/Sl?=
 =?us-ascii?Q?PgN8ETgpTSZ1KxwtvArukmpMfuFJCfl+deHCv0Iw1Mjr5x+A4siX7FmDbqkT?=
 =?us-ascii?Q?w7Np4tTjaf9ziSqo5RjgFg2wjbitEG+JXk2G7G1vvwOnBxyBMaEgKD1AehHx?=
 =?us-ascii?Q?PvxnUhztl8MC7bWgFSBmq/RRqfit5/US3e+/4SohUJJQyhgGMsnz8D7w8dk0?=
 =?us-ascii?Q?BttCxu02AwOk6cYn0IwGAz2bfBRm73L56A/2l04dhErT8NozW+FkjsCwUdKI?=
 =?us-ascii?Q?HhN/s9yMqBOUgJ6WZBJDJIs4K1TBAve5PKyiDRIEtPazSEkjyzn9joquuYDc?=
 =?us-ascii?Q?iM4gOc2AGNV0ZWKg/V7HAaNSLNBZRXnQsWHYpHCwTHRaeO55mw2srNtB4f/E?=
 =?us-ascii?Q?qVGwdTb/W6Lm0P5UTbCfBfiPDRQlyVj32e2kkZ+GU+sDYc5Q5Rv2Bb54h2V3?=
 =?us-ascii?Q?QWIi8lnK3ckA5p3zIhJlvNlIs5Pg1IiYiUTJSKBBk5/xXkVSC4bbdUUwdDV8?=
 =?us-ascii?Q?t6Yqo8IeUlAf0K0O+jBHiDOlLpiROKcBZV2XfHgi3X4GKWKq1ms8BjnRhwH/?=
 =?us-ascii?Q?P2J8zl5z0KkuerMkQrtd7MH/HfA0+haQ+UEWe2sJuyrYQ06CVKRcNfaEUpzq?=
 =?us-ascii?Q?c3/e7L6leUcwiGZZM4/63i1D5EiWRuoEIiqAjme6oFHQHDkD3KKNR2LBB2+n?=
 =?us-ascii?Q?eoYhTdzSH4vUbtWVYAvayBrmFnUQ66CKFW87Dli+emEKxquLyQakHu/IjQNJ?=
 =?us-ascii?Q?WjbVOBT2d354qVPlj0AbMW/qgo/yuKbrz5yMqLP4dpeXRcmKSmHU88VI5jxF?=
 =?us-ascii?Q?YtaFTwfBZA9T0ccRjGGoPkonXpUIzhh1zi/6Qx1xt3eTq0qtkRYglEDTXtOo?=
 =?us-ascii?Q?LCqe8hvbyYteWf/YiCKkSad4TBLFeFZAGkaaPnv0GHupBDEBJFxkt34j4Jo4?=
 =?us-ascii?Q?volcSS8sbdtyAfj+2YpedEYd41MlS0VDMdEDZy9vLOAttYgsuyyWyzOihNlo?=
 =?us-ascii?Q?inKtka62Yj3NvxmXuWMJQKlUYGsdrhZxAmxWnnwZGG7wwV8WWW082WFT88rj?=
 =?us-ascii?Q?X8Dsn1DopX0M2wD/2BroE1hFKyzsVv4VmpyhZlxaxk2lwmkIDMvXwlFS3h9x?=
 =?us-ascii?Q?7rWIynrNM5ZDN0GIWrEVF0Y9a/8SAS864WHBcoAANfgL0o836Gn4JRni4OoM?=
 =?us-ascii?Q?wnYqBSCTxLIlmD3y158H9a4rHXaA9Q1Bnv3Y2t51Lzmoa6E0R/evm3P4gEM9?=
 =?us-ascii?Q?2fFZygalDg7AJZMfi6WyyNImE1rabnqb+aCvrYuC2kZpffogVgoikQIqYK4s?=
 =?us-ascii?Q?fM/m8patD6qYo6Iz6+lQ/t0bPcAX+gdsVUIpDp6ePW10DGJI7xNXe7Ki6Yy8?=
 =?us-ascii?Q?Wsen2/vFSWCZMB1Ql6NVdR4FT4gYVi+v3Raq4bqgyrYjnp1hUfA5TOyqcggH?=
 =?us-ascii?Q?PKkX0imqStHm5ce7LN9gqdlGfDFxtul3+2JPWxURNV7f?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1dec020-535a-4948-692b-08db9ab90c5e
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1099.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 22:19:37.1909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/R9bxoMzaKUADHtL+PY+4DGgtlQieCbRj3F059fOevCAaPU868dhuVR0P6AptIMWs1VtX2nxv0yQikh4Sd7bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3417
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A fully enlightened TDX guest on Hyper-V (i.e. without the paravisor) only
uses the GHCI call rather than hv_hypercall_pg.

In hv_do_hypercall(), Hyper-V requires that the input/output addresses
must have the cc_mask.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/hyperv/hv_init.c       |  8 ++++++++
 arch/x86/hyperv/ivm.c           | 17 +++++++++++++++++
 arch/x86/include/asm/mshyperv.h | 15 +++++++++++++++
 drivers/hv/hv_common.c          | 10 ++++++++--
 include/asm-generic/mshyperv.h  |  1 +
 5 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 547ebf6a03bc9..d8ea54663113c 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -481,6 +481,10 @@ void __init hyperv_init(void)
 	/* Hyper-V requires to write guest os id via ghcb in SNP IVM. */
 	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
 
+	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg. */
+	if (hv_isolation_type_tdx())
+		goto skip_hypercall_pg_init;
+
 	hv_hypercall_pg = __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START,
 			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
 			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
@@ -520,6 +524,7 @@ void __init hyperv_init(void)
 		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 	}
 
+skip_hypercall_pg_init:
 	/*
 	 * hyperv_init() is called before LAPIC is initialized: see
 	 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
@@ -647,6 +652,9 @@ bool hv_is_hyperv_initialized(void)
 	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
 		return false;
 
+	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg. */
+	if (hv_isolation_type_tdx())
+		return true;
 	/*
 	 * Verify that earlier initialization succeeded by checking
 	 * that the hypercall page is setup
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index d4aafe8b6b50d..5792cddea4914 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -533,3 +533,20 @@ bool hv_isolation_type_tdx(void)
 {
 	return static_branch_unlikely(&isolation_type_tdx);
 }
+
+#ifdef CONFIG_INTEL_TDX_GUEST
+
+u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
+{
+	struct tdx_hypercall_args args = { };
+
+	args.r10 = control;
+	args.rdx = param1;
+	args.r8  = param2;
+
+	(void)__tdx_hypercall_ret(&args);
+
+	return args.r11;
+}
+
+#endif
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 83fc3a79f1557..4c68564a165e5 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -61,7 +61,12 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
 
 bool hv_isolation_type_tdx(void);
+u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
 
+/*
+ * If the hypercall involves no input or output parameters, the hypervisor
+ * ignores the corresponding GPA pointer.
+ */
 static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 {
 	u64 input_address = input ? virt_to_phys(input) : 0;
@@ -69,6 +74,10 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_tdx())
+		return hv_tdx_hypercall(control,
+					cc_mkdec(input_address),
+					cc_mkdec(output_address));
 	if (!hv_hypercall_pg)
 		return U64_MAX;
 
@@ -112,6 +121,9 @@ static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_tdx())
+		return hv_tdx_hypercall(control, input1, 0);
+
 	{
 		__asm__ __volatile__("mov %[thunk_target], %%r8\n"
 				     ALTERNATIVE(CALL_NOSPEC, "vmmcall", X86_FEATURE_SEV_ES)
@@ -158,6 +170,9 @@ static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input2)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_tdx())
+		return hv_tdx_hypercall(control, input1, input2);
+
 	{
 		__asm__ __volatile__("mov %[output], %%r8\n"
 		     ALTERNATIVE(CALL_NOSPEC, "vmmcall", X86_FEATURE_SEV_ES)
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index da3307533f4d7..897bbb96f4118 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -381,10 +381,10 @@ int hv_common_cpu_init(unsigned int cpu)
 			*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
 		}
 
-		if (hv_isolation_type_en_snp()) {
+		if (hv_isolation_type_en_snp() || hv_isolation_type_tdx()) {
 			ret = set_memory_decrypted((unsigned long)*inputarg, pgcount);
 			if (ret) {
-				kfree(*inputarg);
+				/* It may be unsafe to free *inputarg */
 				*inputarg = NULL;
 				return ret;
 			}
@@ -567,3 +567,9 @@ u64 __weak hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_s
 	return HV_STATUS_INVALID_PARAMETER;
 }
 EXPORT_SYMBOL_GPL(hv_ghcb_hypercall);
+
+u64 __weak hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
+{
+	return HV_STATUS_INVALID_PARAMETER;
+}
+EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index c5e657c3cdf4c..30fa75facd784 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -283,6 +283,7 @@ enum hv_isolation_type hv_get_isolation_type(void);
 bool hv_is_isolation_supported(void);
 bool hv_isolation_type_snp(void);
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
+u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
 void hyperv_cleanup(void);
 bool hv_query_ext_cap(u64 cap_query);
 void hv_setup_dma_ops(struct device *dev, bool coherent);
-- 
2.25.1

