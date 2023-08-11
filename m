Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BC0779AA3
	for <lists+linux-arch@lfdr.de>; Sat, 12 Aug 2023 00:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237097AbjHKWUE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 18:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236763AbjHKWT7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 18:19:59 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021018.outbound.protection.outlook.com [52.101.57.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE98730DE;
        Fri, 11 Aug 2023 15:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWjw+cSsrEVdt82ibMCEDSWXUth9Eteuzw2L81esA2XsXDKeZfwOPmuE39myO4/THAOqjhxSCDAj5wCnWu/ZjcROiSTPbw/454RlcOdHljl5gGgdeIN2qLOtMyj2oJAIl9lXY0yMf7WiPv5sR0mDs2uGTjShhl0HbzQWtZVGXC3mhyw2fxZ+1ONfv5JWFhmmZBdtMxf5TOMfTowPmOFxP0XNvCkVjet7nBcXr8Y1yvKVjWOReqRllwj0uUv0O8JYECRLZNl+c3zjIYiGHrpjUgzlwFH5GnPsDF1Auxm+/wwcEdGp32XCHmlrn+626L4zKNp7ABBLQ9i9b+88G1UUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JWjwqNLkW2JGsdf5lKNlEg54cXE8hSh8knd9xwlUIw=;
 b=ElRCF2UFV6QWsyAsM0LxQOUzur+fqVN2Pe/67S7aTLIBEcvPCQ2hInTXINp0lFNbCliishd5YhMU5HH7LIcnAmQ36cNnu8sGRawAlnJxoDIZZoJlWXUzWjMnrLLtr04v7hm2QVy3DYeUmouGN7eTWnRngHViPrLozsX54bWX3NGVeL9ji3Jx/X7px3JWpQXc7nCydQia4jkPGovDC3W2WWSqoGPOZK6aTT82KWJfXzogbVfDzS5zoH3UVZwX3zbmBvZB2//31p1hlPZrT2+M0iIxXM/l+4heGUmrAUWXpQfqsaSR5g9AuzlmVX6cg/RjpIKpPyA5IUw8/dgkvpZhWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JWjwqNLkW2JGsdf5lKNlEg54cXE8hSh8knd9xwlUIw=;
 b=aosxYPGZQvlQeubH23rDwe3KGP83al2Bln0PEAX0xOWbdukCMjWZIKcU44JcuxeIA4Op0bgA36+7NnTPB5jYhaF5cc+jcS5OoHZr2JBLw/8/XsY6rlGvOc/sXJBqEFd1YAjOKgoHWm8hPL42j0M3IB7/63EDF7Wad+IzA9e3GII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from MW2PR2101MB1099.namprd21.prod.outlook.com (2603:10b6:302:4::29)
 by DM4PR21MB3417.namprd21.prod.outlook.com (2603:10b6:8:b1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.9; Fri, 11 Aug 2023 22:19:41 +0000
Received: from MW2PR2101MB1099.namprd21.prod.outlook.com
 ([fe80::5feb:7d06:e396:fdba]) by MW2PR2101MB1099.namprd21.prod.outlook.com
 ([fe80::5feb:7d06:e396:fdba%4]) with mapi id 15.20.6699.008; Fri, 11 Aug 2023
 22:19:41 +0000
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
Subject: [PATCH 8/9] x86/hyperv: Use TDX GHCI to access some MSRs in a TDX VM with the paravisor
Date:   Fri, 11 Aug 2023 15:18:50 -0700
Message-Id: <20230811221851.10244-9-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 49ff765f-3946-48cf-c570-08db9ab90e06
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7JvuirCfwTW5TTVHLi9NtPxfB2bSnti3CXvLEX6tP5kpF4BpT3xFjtr5kcXB1YeEeEGQiz3iBfdc0bn+bcZ8JllnzZt7YDz24aOGlbKydOYNkkQUj+UID8tol7r2F7Ac3oosWtPVNw30eFJw/Rx7otiRFaguX+b4FA4y5UgVnPOLRfL9XJXH3CY00EXA98aGMDdb25sKerEiWIuuhMevH15dKXPWlEXwWcVE79oBG4J9g859Giu23upcZgex94XdfCgyHw8oYWcUVO7ruUNFKYIR9Vr5ei/OGFjm2EH+qBelhwjajGbH6UVJGyM2PS7FFQJxQ9sIHTXDIyKVwZ71M8QqxCH5yR2zLfIw12HRzWttaYmo5uknKwEJyRkdfWyGOrZ2FGyztBkMwlC3gYnCSEspBbMVkDVglWuAtHAItIHuWUi1YLsrUazJq/rsfI2nv0e/2kkdLY+yVnMLruaDvA06nFT79Kp+KO5lmxomu62xku51r4onDsf43IV6jAfrzyiBmBztHuTZH9h0SA64ECAHW2CxwWLOdfvAUMMjbn/Pn/69jLLcdDYtlHqiOebWmTr1s9UkN2mQQ6tpj8tN/6OGEIy84LyoEXpLXjYXkKITiVeOS2+LJ+rKZ2rNiCfpb8sPm0OHN/bIzREVsuja+bkw/+J3Ue6sIq9zP7Cw3/r6IQMik2omFc0xL5MKERE2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1099.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(136003)(376002)(396003)(1800799006)(451199021)(186006)(2906002)(12101799016)(36756003)(2616005)(86362001)(41300700001)(83380400001)(5660300002)(8676002)(8936002)(6506007)(1076003)(107886003)(6512007)(6486002)(4326008)(6636002)(316002)(52116002)(478600001)(10290500003)(66946007)(66476007)(66556008)(6666004)(921005)(7416002)(7406005)(82960400001)(82950400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wyRl4EVPUtf0uOoRbPYqUOJgXeCkOVl1X86vuLB0HptD9i6Hl8j+kTaxV7Le?=
 =?us-ascii?Q?jRUE+bTeIceMfMIkM5aSLCf0BQzWraMdO1vWVnvtrHeFB/nI5sXhju36Hj9X?=
 =?us-ascii?Q?dU2m8hXFLW3v1Q88Fm8U7fUw7x2teegNjB2hpPpExXOc4n52CAvOuFHYnTTV?=
 =?us-ascii?Q?xo1Y4uHXd5AsUaYUTruy4mlkEzCxjwPiaLKQ/JepQdWP8FagKs22oG9Xvkcg?=
 =?us-ascii?Q?uY8MgHkxra9iRshuNvkjo+d7+FQaI4A92Sh7OSASJZaXGNoOV08DhU8JzNTh?=
 =?us-ascii?Q?j+AIiTS36jJh+8d5DJjCmNRp0Eg7cX2Hs8jckaQYF6s/PQw8lfV7Wh+0Epmn?=
 =?us-ascii?Q?hu1tyeFJUqVTybe9pw/Se3l8Hhygn8Os8fqTaMpo+B2c8xL02IbRQaosEASU?=
 =?us-ascii?Q?5MjIlHDHk0VaJK3fUWLQ4sVJVvDFtsLlTfSOLXPEy3ZN2saDOyG8BGYLhE+s?=
 =?us-ascii?Q?vdcskbTODc44fc8jtUOmYUEdJYc7nejJc5WaHkFV9YzGbX9KK+KdBrCxcyS5?=
 =?us-ascii?Q?B+J8ywk0IbOIGXIYMw+Qee/LehVfYQPaIafs7PAy2lf0kPYMHVkvmphd1XA1?=
 =?us-ascii?Q?g64880RODVP1CDCReZyTgtGRzPVVUceZCAowtufqK4CIaYPDrJA+K7LG/Jas?=
 =?us-ascii?Q?NIaUNe30k5hObgx63bvQg7u0igO3kY+oVLUamb+X61gbXnuMo80W9ZfQyaqd?=
 =?us-ascii?Q?EcRWgn5VjP5RDVBBj9MR1mKId3CZcyUJUfE5Ai43kUSayXDF3JuZxSViZvb2?=
 =?us-ascii?Q?meGLEY+FxFY/jZx1npzhT4o3h4DHYNtPY0TDheKQnlnzulLNNA1wyY8A4EnZ?=
 =?us-ascii?Q?Uyaj0sE6FyIISu0WMAEOzmMHStk/ZqDUpX8pOjFqdf5LgHjN62REq5n8uv3w?=
 =?us-ascii?Q?HD7439AtMtK/RdA7Cq+4UGFocffSDsKzpPEaG9ym5pfWb0AtCg06OangPdQu?=
 =?us-ascii?Q?j7n9Xi7qGd9uKjuqSyqzNk9gBMq/U6Fo5XbrfqXaSK/6OpfoHodVmjyCm+sN?=
 =?us-ascii?Q?OmvBb/ctSJ/zBu3A6xLqdLcBjhMtFG5dxEzf0rYYnaBHGfndBe6vxjK6tnxC?=
 =?us-ascii?Q?HjZxOuSwOJXFCF1WbRQ0cBAyMwIla3a7N7U769bd8JSXc6ueo3wr+/yc4OQ5?=
 =?us-ascii?Q?ilsw9Fz2+gLi4Nl9LW2jkWhR5EdUUVsSumBKuA9+Q4E4A+Ts/nKj2r+8OFhS?=
 =?us-ascii?Q?nLwMNwJM4AgqyG9VxxyWOQYynOmBbKcIKh1O2Uoty0XQQlukBREFqswYUV7+?=
 =?us-ascii?Q?oA5JXbZs36JzNqvJb9TpdpmVxFVtW3lFVVEX8ffAu5aosRcVqHSMp8/gytLw?=
 =?us-ascii?Q?U79dPtJ72aw4sJTufF3rFXqkFGn1L+FO0CTXB5PZGw4bWz83wIRRwVAqABTh?=
 =?us-ascii?Q?HSPcsOupN7Btfvla6W1mJI8G3e7f6HCMfkS5Qf5mOu/VXpMLXZ3sBJx/xBjM?=
 =?us-ascii?Q?Wepq063Ca1fNZZQCgWcBA3TkhFnlpm/npGQIgrH9ltpy4FqTvmoWpTaPDMar?=
 =?us-ascii?Q?L61AB+EDFzzeR4knF8LAm1DvKaXdkua3ju9T+S6BnGYd1yl1FwFN3bOpgKj5?=
 =?us-ascii?Q?oG6RmS7rYmbVIC36eqfpNQ/L9u1OFFVmdPpcZeoWGPFdcjGv5VdPPsQrSK2p?=
 =?us-ascii?Q?cJ/zCQKzvOZBfgHYrbOsiyJuqXmiOLB3Ft0+4J9McH8e?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ff765f-3946-48cf-c570-08db9ab90e06
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1099.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 22:19:39.9579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gkx6MJpEqfLnuXpKKpSyfV0OcKopYDxmYgZzZxpv8hyiKW2/ytqeTh2oh6M0CeUKGjuivqtCQznLuEonVjCOOw==
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

When the paravisor is present, a SNP VM must use GHCB to access some
special MSRs, including HV_X64_MSR_GUEST_OS_ID and some SynIC MSRs.

Similarly, when the paravisor is present, a TDX VM must use TDX GHCI
to access the same MSRs.

Implement hv_tdx_read_msr() and hv_tdx_write_msr(), and use the helper
functions hv_ivm_msr_read() and hv_ivm_msr_write() to access the MSRs
in a unified way for SNP/TDX VMs with the paravisor.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/hyperv/hv_init.c       |  8 ++--
 arch/x86/hyperv/ivm.c           | 72 +++++++++++++++++++++++++++++++--
 arch/x86/include/asm/mshyperv.h |  8 ++--
 arch/x86/kernel/cpu/mshyperv.c  |  8 ++--
 4 files changed, 80 insertions(+), 16 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 9c12a199ea62c..abd0a8bd3f15e 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -505,8 +505,8 @@ void __init hyperv_init(void)
 	guest_id = hv_generate_guest_id(LINUX_VERSION_CODE);
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
 
-	/* Hyper-V requires to write guest os id via ghcb in SNP IVM. */
-	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
+	/* With the paravisor, the VM must also write the ID via GHCB/GHCI */
+	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
 
 	/* A TDX VM with no paravisor only uses TDX GHCI rather than hv_hypercall_pg */
 	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
@@ -595,7 +595,7 @@ void __init hyperv_init(void)
 
 clean_guest_os_id:
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
-	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
+	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
 	cpuhp_remove_state(cpuhp);
 free_ghcb_page:
 	free_percpu(hv_ghcb_pg);
@@ -616,7 +616,7 @@ void hyperv_cleanup(void)
 
 	/* Reset our OS id */
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
-	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
+	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
 
 	/*
 	 * Reset hypercall page reference before reset the page,
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 0d54bc8b06b4a..b8fb1557c1986 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -184,7 +184,49 @@ bool hv_ghcb_negotiate_protocol(void)
 	return true;
 }
 
-void hv_ghcb_msr_write(u64 msr, u64 value)
+#define EXIT_REASON_MSR_READ		31
+#define EXIT_REASON_MSR_WRITE		32
+
+static void hv_tdx_read_msr(u64 msr, u64 *val)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = EXIT_REASON_MSR_READ,
+		.r12 = msr,
+	};
+
+#ifdef CONFIG_INTEL_TDX_GUEST
+	u64 ret = __tdx_hypercall_ret(&args);
+#else
+	u64 ret = HV_STATUS_INVALID_PARAMETER;
+#endif
+
+	if (WARN_ONCE(ret, "Failed to emulate MSR read: %lld\n", ret))
+		*val = 0;
+	else
+		*val = args.r11;
+}
+
+static void hv_tdx_write_msr(u64 msr, u64 val)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = EXIT_REASON_MSR_WRITE,
+		.r12 = msr,
+		.r13 = val,
+	};
+
+#ifdef CONFIG_INTEL_TDX_GUEST
+	u64 ret = __tdx_hypercall(&args);
+#else
+	u64 ret = HV_STATUS_INVALID_PARAMETER;
+	(void)args;
+#endif
+
+	WARN_ONCE(ret, "Failed to emulate MSR write: %lld\n", ret);
+}
+
+static void hv_ghcb_msr_write(u64 msr, u64 value)
 {
 	union hv_ghcb *hv_ghcb;
 	void **ghcb_base;
@@ -212,9 +254,20 @@ void hv_ghcb_msr_write(u64 msr, u64 value)
 
 	local_irq_restore(flags);
 }
-EXPORT_SYMBOL_GPL(hv_ghcb_msr_write);
 
-void hv_ghcb_msr_read(u64 msr, u64 *value)
+void hv_ivm_msr_write(u64 msr, u64 value)
+{
+	if (!hyperv_paravisor_present)
+		return;
+
+	if (hv_isolation_type_tdx())
+		hv_tdx_write_msr(msr, value);
+	else if (hv_isolation_type_snp())
+		hv_ghcb_msr_write(msr, value);
+}
+EXPORT_SYMBOL_GPL(hv_ivm_msr_write);
+
+static void hv_ghcb_msr_read(u64 msr, u64 *value)
 {
 	union hv_ghcb *hv_ghcb;
 	void **ghcb_base;
@@ -244,7 +297,18 @@ void hv_ghcb_msr_read(u64 msr, u64 *value)
 			| ((u64)lower_32_bits(hv_ghcb->ghcb.save.rdx) << 32);
 	local_irq_restore(flags);
 }
-EXPORT_SYMBOL_GPL(hv_ghcb_msr_read);
+
+void hv_ivm_msr_read(u64 msr, u64 *value)
+{
+	if (!hyperv_paravisor_present)
+		return;
+
+	if (hv_isolation_type_tdx())
+		hv_tdx_read_msr(msr, value);
+	else if (hv_isolation_type_snp())
+		hv_ghcb_msr_read(msr, value);
+}
+EXPORT_SYMBOL_GPL(hv_ivm_msr_read);
 
 /*
  * hv_mark_gpa_visibility - Set pages visible to host via hvcall.
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 9fa31dce69727..3f22324ef2e25 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -255,15 +255,15 @@ int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
 int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-void hv_ghcb_msr_write(u64 msr, u64 value);
-void hv_ghcb_msr_read(u64 msr, u64 *value);
+void hv_ivm_msr_write(u64 msr, u64 value);
+void hv_ivm_msr_read(u64 msr, u64 *value);
 bool hv_ghcb_negotiate_protocol(void);
 void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
 void hv_vtom_init(void);
 int hv_snp_boot_ap(int cpu, unsigned long start_ip);
 #else
-static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
-static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
+static inline void hv_ivm_msr_write(u64 msr, u64 value) {}
+static inline void hv_ivm_msr_read(u64 msr, u64 *value) {}
 static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
 static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
 static inline void hv_vtom_init(void) {}
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index ddcc62185e4ae..fb585d3b080b1 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -72,8 +72,8 @@ u64 hv_get_non_nested_register(unsigned int reg)
 {
 	u64 value;
 
-	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
-		hv_ghcb_msr_read(reg, &value);
+	if (hv_is_synic_reg(reg) && hyperv_paravisor_present)
+		hv_ivm_msr_read(reg, &value);
 	else
 		rdmsrl(reg, value);
 	return value;
@@ -82,8 +82,8 @@ EXPORT_SYMBOL_GPL(hv_get_non_nested_register);
 
 void hv_set_non_nested_register(unsigned int reg, u64 value)
 {
-	if (hv_is_synic_reg(reg) && hv_isolation_type_snp()) {
-		hv_ghcb_msr_write(reg, value);
+	if (hv_is_synic_reg(reg) && hyperv_paravisor_present) {
+		hv_ivm_msr_write(reg, value);
 
 		/* Write proxy bit via wrmsl instruction */
 		if (hv_is_sint_reg(reg))
-- 
2.25.1

