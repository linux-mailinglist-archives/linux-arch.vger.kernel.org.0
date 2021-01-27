Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045A7306514
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 21:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhA0U0I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 15:26:08 -0500
Received: from mail-bn7nam10on2119.outbound.protection.outlook.com ([40.107.92.119]:59360
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232801AbhA0UZp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 Jan 2021 15:25:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMcNtgIPTXdK9vVvpKWjnMuZng3ARLSmZ/x+tZN3d8VoZGlK8X358DYJZLm0doVf9RiKWP0ejwd2sTNTOnIMaxXHE7dtjDeEknyw9BFNkvLkSIfKvF0CuEonZ8mPWtZEpsiJq2REBR1ZLLXLLjCn7sxRvOeuUUap+P+UeVHfY9Hi7EzdT6geL153wwdNxmrekINH67Akl2z7H58ft5vsveEe05KGvKAC+L2I1BTPlW6eg770ySYfOUUkrMxXXjhYu6ucs5mwFcf+FIU8WY5noFojBLyC7YGnq2eWOfJ8neK17fGewPq7+5fqxEPdy9gTTJAkC1wc0hcNNEBfCxty8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OQbR98rQ4qnp8iQNTWspmgtNkZg9E5Sm8UvbW0CY+E=;
 b=BOQW46+iBAMbC4tNgEoTAgUUjJRbFi81mH76BjPksS5B7EVmUs+/UfbYXWB/QiawrUlu+eqsECL2ns2cQ/SHQ1hLOwVDZwTa48654l6/ndWqITnlxBbfAOmtxgSZuYUJ3yFvsW4E224t1oOpuylBM56YqEcp47IZC5pRgmWtwxSIXi6QPtMpxRsh2L6+ZEoJFKs/P+gz2afWLpjOuvwVCrrdrv2BQds+L0Zcitkev4sxMPa3+CIi6D3nU0odipjwmN7ZhwIpqIOeMyhuX6+VOnVfCkmBZ0c2W0JkiMsqyWlawOZLovYwmg/6ctQWGY4Zu8gwqAG0eyCljkgU/h7+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OQbR98rQ4qnp8iQNTWspmgtNkZg9E5Sm8UvbW0CY+E=;
 b=jABk0tnpKy2cWHineJ2yhmLRAxIKhbo/+/PbBER86yHme5g165BIWYg7bRmpT1/zQli1UdR/FWNAkTzUisu3prjXc9d5/ovafQZij/WyhFBCgAsFVJQJ9FkOor9ZvGDPrhRcrNNtu9rY4KUc6JcIQyxllY9qiFf5kItbidbQAOM=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from (2603:10b6:208:3a::13) by
 MN2PR21MB1215.namprd21.prod.outlook.com (2603:10b6:208:3a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.6; Wed, 27 Jan 2021 20:24:19 +0000
Received: from MN2PR21MB1213.namprd21.prod.outlook.com
 ([fe80::91f:e9a:5737:3a05]) by MN2PR21MB1213.namprd21.prod.outlook.com
 ([fe80::91f:e9a:5737:3a05%9]) with mapi id 15.20.3825.006; Wed, 27 Jan 2021
 20:24:19 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 02/10] x86/hyper-v: Move hv_message_type to architecture neutral module
Date:   Wed, 27 Jan 2021 12:23:37 -0800
Message-Id: <1611779025-21503-3-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
References: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.174.144]
X-ClientProxiedBy: MW4PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:303:8c::24) To MN2PR21MB1213.namprd21.prod.outlook.com
 (2603:10b6:208:3a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.174.144) by MW4PR03CA0139.namprd03.prod.outlook.com (2603:10b6:303:8c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 20:24:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4306279a-8f7d-4a8b-c351-08d8c30186a9
X-MS-TrafficTypeDiagnostic: MN2PR21MB1215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR21MB1215D8180C4B00863FB52DB5D7BB9@MN2PR21MB1215.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6AhYwFIyJt6tn5Y7cPW8QUs5dsyC09YEYzVdS0Emfqt0lnOvBMVlzpa18FwWZyIiqMigVJZm2RWo1qYCtC7htASzsIz6DMudvgKTc/IvIsudzcqFEj05/y99qClGnhlp6GmH+ajI7cU5ShS0+RZ1QkAaGrmkZOBn4LoU8M8gjQi7NShV4Nas0wLVgcwEhm16sADPcHarmcNw0VizLiCzXPZLQK5+ZA350/CJKnmn9lWKFui0J/seJjeKQ5WLD3qc0pqwp4T4TYg/bNrDGgrkOy4/D1oimB2aBtSj+6q9VKXqLd97muGlmRW41KtGAdhRS7PEP0VmFb24bw1U7waSOXkQdO121+QSk/g6DsyvsXiiW32IwElL8shBJ5sVV6vavIWXws7sFGGfzz7L9203Vr4cZflofKLydFiVAtn89STTWZ1RS2oQNdG7wRgyrGVN05VexjulG7kMwlXxxyG1Ufo6FJ7HjO+SdLYiDSLPfK6+j8u/jmVVmW2VCAurHP3iR6jcAm4MEIoWMnIRCGIimCiXGE+H8FpatAD8k9Y/YkBIclJzw+EsCe1FcVtHl4lS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR21MB1213.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(6666004)(66476007)(66946007)(956004)(26005)(66556008)(478600001)(921005)(8676002)(5660300002)(316002)(2906002)(86362001)(83380400001)(8936002)(186003)(36756003)(82960400001)(16526019)(4326008)(2616005)(6486002)(7416002)(10290500003)(82950400001)(52116002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xPCwmoBCvpplKKfuAzLcAaGuuRary9642oyHAMtnXFLeOFUcqAWGtpoKh8Rq?=
 =?us-ascii?Q?BiOJjuOXW6sX3Ed8qnd7IuKH//2Shj3WvRahejCUyW43U+BdOxFBIYOXctwO?=
 =?us-ascii?Q?+AUKJBVSteZ+Jfz/nuupGrV43AOZ1yASmYxSZsR7wZlJybaLvo6F5UW3QVIg?=
 =?us-ascii?Q?FGRsmi4NnxmQ6uAprtOee0bzQQaRpxoTBtcOMG7DODMrw0OJ7y0p8kV0ohNP?=
 =?us-ascii?Q?UvIInuqhS/c6tOFQEfesyOz5DvCsLgWHrlsVfgH7R7lQEigT5AWafZLMXOZt?=
 =?us-ascii?Q?Wd91N6McMueoeyaslPXgcmEvr6DqKAlD8wiaWP6K7FJM1g89lFCZ4yv6c8Eb?=
 =?us-ascii?Q?CS8/AXHsTMXBqjWvqq0Dl8s/6ufqv2ND5rQ4zZqJ6jnc4KoTDWXi1CW4Afjy?=
 =?us-ascii?Q?WPZ9EzJZude0x3jlRl+2/uBTQzseEoqfN8z3ol3pVFhMb0A0s3dJz6RKOeKy?=
 =?us-ascii?Q?y+lf3nF6FgxJzWWOW6/aZDy3i/VXXuOhcVyvJkM84QnqvtfIVRZ5AJ+q2sUR?=
 =?us-ascii?Q?qrdiDmbkEHc7wA9L+8R29CGB8n4uQU+HS5I7nHfr9t52r2d4wBOLvB95s5mE?=
 =?us-ascii?Q?L5PUG8oBBxxFz48uDqMnm2eokYxxyvJVePbbT50tifAEx5ZG4thhsLuN2UoL?=
 =?us-ascii?Q?OQm+VaMvk5yRFMgmWDhCvRZghb/o9RANtsj2R8/lQbXJY4JxBuz3U8JeItO7?=
 =?us-ascii?Q?B4KrXAgPee0YDHI5vKxZCq7LCZT8Do/WXVjLsZIhgSAF5vrC14tUltWtP5Gm?=
 =?us-ascii?Q?bbefT5usCzT75Hulz3eC71i164i9uLyPz6I+MPeMOjMLXZxQlV73tQx5CYTp?=
 =?us-ascii?Q?vxgLn1rE2f3MGMHn43Htm6V/x0vaMhzgbvZQkix0ux1Apa0GsIX+rvZ1z9nB?=
 =?us-ascii?Q?qse2GQbl6CB2gzFMKIPy2nIQLCTa5VYHphyqh/svnmqpuA5oCTYK4AYhOadk?=
 =?us-ascii?Q?+Z7XZ86F9jipMXhAKNHrOMNbkLcLUKfkN/fMJbn15ZGnPFxV+OfYA2VCA6Yc?=
 =?us-ascii?Q?TtyYFfQsrVZonY80eKhxxPZZRbFtQIozkYj90CwL7YntGJxasxn5i91pln2Q?=
 =?us-ascii?Q?eXg6nwUC?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4306279a-8f7d-4a8b-c351-08d8c30186a9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR21MB1213.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 20:24:19.6510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ea8HgFitY3B4AfWuByr9NfWrapXzFl1dLwt7zqPN956oQKSUzrWmazd3cgyCa1DXZ2YGyU3bopeKsXDTVTw/5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1215
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The definition of enum hv_message_type includes arch neutral and
x86/x64-specific values. Ideally there would be a way to put the
arch neutral values in an arch neutral module, and the arch
specific values in an arch specific module. But C doesn't provide
a way to extend enum types. As a compromise, move the entire
definition into an arch neutral module, to avoid duplicating the
arch neutral values for x86/x64 and for ARM64.

No functional change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/include/asm/hyperv-tlfs.h | 29 -----------------------------
 include/asm-generic/hyperv-tlfs.h  | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 6bf42ae..dd74066 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -263,35 +263,6 @@ struct hv_tsc_emulation_status {
 #define HV_X64_MSR_TSC_REFERENCE_ENABLE		0x00000001
 #define HV_X64_MSR_TSC_REFERENCE_ADDRESS_SHIFT	12
 
-
-/* Define hypervisor message types. */
-enum hv_message_type {
-	HVMSG_NONE			= 0x00000000,
-
-	/* Memory access messages. */
-	HVMSG_UNMAPPED_GPA		= 0x80000000,
-	HVMSG_GPA_INTERCEPT		= 0x80000001,
-
-	/* Timer notification messages. */
-	HVMSG_TIMER_EXPIRED		= 0x80000010,
-
-	/* Error messages. */
-	HVMSG_INVALID_VP_REGISTER_VALUE	= 0x80000020,
-	HVMSG_UNRECOVERABLE_EXCEPTION	= 0x80000021,
-	HVMSG_UNSUPPORTED_FEATURE	= 0x80000022,
-
-	/* Trace buffer complete messages. */
-	HVMSG_EVENTLOG_BUFFERCOMPLETE	= 0x80000040,
-
-	/* Platform-specific processor intercept messages. */
-	HVMSG_X64_IOPORT_INTERCEPT	= 0x80010000,
-	HVMSG_X64_MSR_INTERCEPT		= 0x80010001,
-	HVMSG_X64_CPUID_INTERCEPT	= 0x80010002,
-	HVMSG_X64_EXCEPTION_INTERCEPT	= 0x80010003,
-	HVMSG_X64_APIC_EOI		= 0x80010004,
-	HVMSG_X64_LEGACY_FP_ERROR	= 0x80010005
-};
-
 struct hv_nested_enlightenments_control {
 	struct {
 		__u32 directhypercall:1;
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index e73a118..d06f7b1 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -213,6 +213,41 @@ enum HV_GENERIC_SET_FORMAT {
 #define HV_MESSAGE_PAYLOAD_BYTE_COUNT	(240)
 #define HV_MESSAGE_PAYLOAD_QWORD_COUNT	(30)
 
+/*
+ * Define hypervisor message types. Some of the message types
+ * are x86/x64 specific, but there's no good way to separate
+ * them out into the arch-specific version of hyperv-tlfs.h
+ * because C doesn't provide a way to extend enum types.
+ * Keeping them all in the arch neutral hyperv-tlfs.h seems
+ * the least messy compromise.
+ */
+enum hv_message_type {
+	HVMSG_NONE			= 0x00000000,
+
+	/* Memory access messages. */
+	HVMSG_UNMAPPED_GPA		= 0x80000000,
+	HVMSG_GPA_INTERCEPT		= 0x80000001,
+
+	/* Timer notification messages. */
+	HVMSG_TIMER_EXPIRED		= 0x80000010,
+
+	/* Error messages. */
+	HVMSG_INVALID_VP_REGISTER_VALUE	= 0x80000020,
+	HVMSG_UNRECOVERABLE_EXCEPTION	= 0x80000021,
+	HVMSG_UNSUPPORTED_FEATURE	= 0x80000022,
+
+	/* Trace buffer complete messages. */
+	HVMSG_EVENTLOG_BUFFERCOMPLETE	= 0x80000040,
+
+	/* Platform-specific processor intercept messages. */
+	HVMSG_X64_IOPORT_INTERCEPT	= 0x80010000,
+	HVMSG_X64_MSR_INTERCEPT		= 0x80010001,
+	HVMSG_X64_CPUID_INTERCEPT	= 0x80010002,
+	HVMSG_X64_EXCEPTION_INTERCEPT	= 0x80010003,
+	HVMSG_X64_APIC_EOI		= 0x80010004,
+	HVMSG_X64_LEGACY_FP_ERROR	= 0x80010005
+};
+
 /* Define synthetic interrupt controller message flags. */
 union hv_message_flags {
 	__u8 asu8;
-- 
1.8.3.1

