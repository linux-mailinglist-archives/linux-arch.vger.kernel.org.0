Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468C532B4DA
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450127AbhCCFaU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:30:20 -0500
Received: from mail-bn7nam10on2119.outbound.protection.outlook.com ([40.107.92.119]:29136
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350948AbhCBVmL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Mar 2021 16:42:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zd5cJrvui+UfyXP+MMlvzWcPso6FyU108gqahBD5iYbuaafq6VDCcbJSvzW0Gm/207xzmy5dMhSsrG9avkTcxAIkzfSF3ayGAlsKEqoG5Lx4joxewVAPe//FMER3RQpFKWh7eeq2HCulYHN7g/iCF4jVd4Co/VlbbwFAHLoRR8bkajPce9AiocGcpIYTpZykMIurONRIumPzqr/RJ4BJsuEYdjYmWHIsKrVZbD45Z3NoTicGVOmlK3obECYi5mQ0prgtjJOXoQcEzwLxVkjQTiUPbg/j88MApSYn6MFJl/P9SPyA0bwdTNLOCIpSFJg52XKGJsJoiUEEzI2vlCdp5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdGP+wYC1h5VR4EZqRUKGIe9teAlnbKIjXzL5Y/lUNQ=;
 b=Fl6ba/u5eO1DnMeAxcsenv2JZSV6GR5Fq4xVqsytAvtHvNkxbMQqEq3K4zr5jRM6cBaGLFu9a6fyQzyqd1g+yRmKzt+su67sacR9lv2mwDQtEpj07vfYng5jIY6gRovbGS5oheYXJ6m9mphvS7dxrpE39qBmOxUweinn8GVZNEru6lhE0qs9NlyISbG5mOwbjw9kCZGY1nvBaQp8QGGhTa3/0DFfNGjmoXYHtzUYhNoA3QYnI1nX4vHu1TAp0Qj2pFT8DKpeUFegGLMlMi/onmt9ZOiJjpY9VXsSzoK6mAGy3ESsUmY3vXST6uVkCaH7GnldCOq84/0sgIq69vpyDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdGP+wYC1h5VR4EZqRUKGIe9teAlnbKIjXzL5Y/lUNQ=;
 b=KWMGZi9hSwUwJO2JYoOF+e7M0Yvp9lsiNbHgBDnjQ34UdUBI0u3TrByoGXvsvZbWABL7uowfSma8rTUQT7vosGDPkqZmuHsrDnLpPsHpqCPMxMt/2sFdNDn0DDRYcKkm7mfMwwSvGYD9LXUX/TQfvk4UYzgIZg+EWfI+CawDl9Y=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM6PR21MB1739.namprd21.prod.outlook.com (2603:10b6:5:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.1; Tue, 2 Mar
 2021 21:38:50 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3912.016; Tue, 2 Mar 2021
 21:38:50 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v3 02/10] x86/hyper-v: Move hv_message_type to architecture neutral module
Date:   Tue,  2 Mar 2021 13:38:14 -0800
Message-Id: <1614721102-2241-3-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1614721102-2241-1-git-send-email-mikelley@microsoft.com>
References: <1614721102-2241-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.159.16]
X-ClientProxiedBy: MWHPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:300:117::15) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.159.16) by MWHPR03CA0005.namprd03.prod.outlook.com (2603:10b6:300:117::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 21:38:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 878ca532-717a-4771-4ea8-08d8ddc391a5
X-MS-TrafficTypeDiagnostic: DM6PR21MB1739:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR21MB17390463A20E4960E4ED608DD7999@DM6PR21MB1739.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDwq0RizWBG1VcmCr75IM0Y9K/JWHBfUvfYMBUIGMY2x60meJSzT0hfYC1d8ft+QMGCrd7JMsgnLSd5NI0oEjUc4VwpwGhg52PDGz0b/V3P50gNWV0BIK9Cg5jUYll189Bq6rgUaNaihrNaY8UD3lBJCI5tbpdjBUtKXfEPFczY1rTIG5iu2pX9hF903eY2TVBloCPOkqWrfIF4C8tTWRXXCxstvvv7ZiEyWbnmJWwuBM9HtkO163E9jYkB27kxuiL75833AjkNOUruv1oYKEEeXuQTcehq1FJQYMlGeeG017+4QWHi3r0lp0nrwb/Q2NpeGJwHBT/zSiMR+IEV9l44C8m8AWZWrBKBvT73CZ7YGhCixafM3+IrsBYr1RZa1SViGJzadimrhqPTYSd/e9VkYAs6igT0RB3WiNUcjUnUE1x0BCGjKhqfa7ZJg9fR8NRGrQDHQbdvuBg3o1il35pnrMCWOuCThJSpMpXWHQivNARRsNZatZQLhlvDK2Fau+6H5OGiAfj/np9BxnrOB1mX5lZnuiEoBmOrxs9lJwrKD1w+RayHVTKMik1Oq/F5E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(82960400001)(956004)(36756003)(82950400001)(8676002)(66476007)(6666004)(921005)(26005)(83380400001)(66946007)(478600001)(186003)(6486002)(7696005)(16526019)(8936002)(316002)(2616005)(52116002)(4326008)(2906002)(5660300002)(10290500003)(7416002)(86362001)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cm4o8xgXbRVd18/JKeloBznwUDbkIgS2njlUvvvsb7jvXncKTprDmV/qdhE5?=
 =?us-ascii?Q?k5/omQQPTFWHOZGa0r0jXJ8BoosAgZjHsmLDGNv54/24Of2yw3g6f3BwhqlR?=
 =?us-ascii?Q?wdYvLpIVNbR/lpwAqitCI6MfruFfzmdv2h0eqTX/B0S4KQZtzsDWeerkaqhc?=
 =?us-ascii?Q?NWGGpAWYE3ZAZeBC7MN5mE7qifibwDJ4BxoyqnpjNYEID3U/XhB3jd1uH6zi?=
 =?us-ascii?Q?k7QI6GKHTbqVsqft2rXsWclvT9kx4wOCZa2RYOTOQCkKkP/9QbLjI0XpBCgb?=
 =?us-ascii?Q?0dM1UjU0ADaBgEqQWCmW0iLYx2koTDLfqu1Ys7aKDAmYLSHd3FLxUEGzkQXc?=
 =?us-ascii?Q?GsdzBdHOUgTUzQtVm3Szw+3XINQFqDEoALYEsC4SnsEUUGN4NMj2a8CzTm9l?=
 =?us-ascii?Q?fzxAC3hGKnhQEnClzdQQ6+Hr2GXfWssETRdtSj3nPOyVDiLTIx8ISd3FCLCs?=
 =?us-ascii?Q?RrZEWRPf+Wdu2SPZ6j3VeFNeHzNYItqhUZW6POYDtstkrmJ44YLlf7VNnBhU?=
 =?us-ascii?Q?HxA3GwUzKPeThvYWPcAdKVvuCaIc4zfQ4P48AybY9fgNsTofWLZAthm46diW?=
 =?us-ascii?Q?0KHMGE3l7sJV/Hg7oTmfqfFLYzwDui2TQLrhDMvmVvIH4duxwX6O1sNbZ63c?=
 =?us-ascii?Q?IbaWGlO59gkH7yVRPxEP5IPlyU89SRRxCu2YV+h/x5b1Lc8o6fZ+rt5Gl0u/?=
 =?us-ascii?Q?gcaz4Iq4FvwEBD+5U7bn8rc5kGnr1Na+s4GVSKMMl++RLgWe22Jm/BrrsAfV?=
 =?us-ascii?Q?rn45Cs9xvXij6y1n9yuOPeF1YFtTtpAszvbmsn9IBe42r/jv/LweNUS0gmz9?=
 =?us-ascii?Q?2HCf5mjzL2qZY2TZKeDMMrgg8Hd/cxIF6DhvxUD1Dg/8s+pB+Mz502O7Z0pW?=
 =?us-ascii?Q?x5znwlb3/e9EmFO5xQBHa1rhQ3/1nPlHYcOs7U2ayN0hKaimaHWDJXl4AhlM?=
 =?us-ascii?Q?XZaRQis+BtD4xLfxFnUbkVqKioSg/UVgEnmLsKzEvaJvnVmhI7vhgWi8CBeL?=
 =?us-ascii?Q?yJdGl0vH2j+Q6znkv1rYv5O/4fJp+p3+RNKwVrOLq749nKEwXp5dz0guEwNZ?=
 =?us-ascii?Q?Mt3brPSrAVdZpgsgeLwQ1KDZwpQ5JmHjpr3zyym0t/1o6EccrWB38t+lsvZu?=
 =?us-ascii?Q?s59cdmiLipQ/NOD7gZygPvXubhgEQ/7NIwp2bYXL8ZOFrLodDZA1w2rsz3UQ?=
 =?us-ascii?Q?VJkobsda8UBJDtHJMs+po4aSbbiVhla5NBtm1xX5WoNZ+NIjFeTIrXw5pYA9?=
 =?us-ascii?Q?egu72Fpsi9VzzOHci2Y9H1eaZxrAVmaR4iYARJy91sy6L/dJYzwJS4aQpdSU?=
 =?us-ascii?Q?G5wY4tBhATDpnB7cZ4XZYvMy?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 878ca532-717a-4771-4ea8-08d8ddc391a5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 21:38:50.6558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B05teTCqiPKqeXpWEZrFQgE0nR5ykHR2mFjv7tEknTm2pE4zSmvkWqupkOScss7qLB3gzk/gVutP/ZZuz76q2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1739
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
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/x86/include/asm/hyperv-tlfs.h | 29 -----------------------------
 include/asm-generic/hyperv-tlfs.h  | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index e6cd3fe..68b38a2 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -288,35 +288,6 @@ struct hv_tsc_emulation_status {
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
index 83448e8..9cf10837 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -220,6 +220,41 @@ enum HV_GENERIC_SET_FORMAT {
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

