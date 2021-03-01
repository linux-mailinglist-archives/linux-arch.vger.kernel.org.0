Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C643275C6
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 02:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhCABRf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Feb 2021 20:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbhCABR0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Feb 2021 20:17:26 -0500
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (mail-co1nam04on0714.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe4d::714])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC785C06174A;
        Sun, 28 Feb 2021 17:16:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrKk96k/fk42BfrNTBQLbUMU+PYZrPtCWKF+H8cE2tJVn3P/skjlAVBEfD8IAOWuplMPp8t10qw+3inckLYJvcSbSTtUJh1l8BcILuiJB/5sw9YIXJEkAJvt8YqxWnK3WWg27kEwG1HGoQNvezJsWMrPrZehlDQKZsYWb9hWyEuW/55SoLaLLAFXSoQKOCCmv0bCL6W9CpC0kk7/l0jWhdrDfBHFrw9jWMQDWTvrs/Qs9RHubmu2S6W1PhKCblCqbW4qma634K1oMyWoXP1kMVpR4lhgILdzOBatq0PrXuVQ8bHqp9Z7KqULgs8kgl87s4lg1l1TySyeuY9kB11Ugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdGP+wYC1h5VR4EZqRUKGIe9teAlnbKIjXzL5Y/lUNQ=;
 b=EQjTCghhulDsdhf5Z0roIy8IIkQuLPlzxeIbhAPUNG/zNUJLgWRDoLfrJuYUI4YqODviZQOa1RmPY53JGeJID7zonod/eZSBY37TwbOFSkhq3Q6HllYL0yTeXG/Cl/EnCUe99RyIIgBAFVtmzHU7hmtRAyDiojj6pTtbgfu84QN/6/ZzNMyo4+1dtSXCkCpIRfq6rjdHj9zeKJZ/lOD73m9sLh5KrQyMHxYB4lYpzLcOqbO07Daw1V1VCtSy4YAwHNS5J2G2nzmdqc3xEEynJD8i9+OE+eZjqxMssjxcLrOZ4CD23fQwNUffKBxwd6pc6oKRSW35qi8VrdxQpgGNWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdGP+wYC1h5VR4EZqRUKGIe9teAlnbKIjXzL5Y/lUNQ=;
 b=ehUaF2nzVorqiOAso77gUYHVUeQ12rVpttlize1B0RfjdHcNTnAxAi2dALxrTzjPGmyyGD7xEuD7eg4yIj+VECQzOuNCkhDbMJTQOkBAgxoNr7mO5p9REmbe0o5skQYPv9QmbtZu4ERBIhn/aHgCM2ZDBwFawdHrv1rOFgD/gVY=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB0981.namprd21.prod.outlook.com (2603:10b6:4:a8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.4; Mon, 1 Mar
 2021 01:16:02 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3912.016; Mon, 1 Mar 2021
 01:16:02 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 02/10] x86/hyper-v: Move hv_message_type to architecture neutral module
Date:   Sun, 28 Feb 2021 17:15:24 -0800
Message-Id: <1614561332-2523-3-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1614561332-2523-1-git-send-email-mikelley@microsoft.com>
References: <1614561332-2523-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.159.144]
X-ClientProxiedBy: MWHPR14CA0008.namprd14.prod.outlook.com
 (2603:10b6:300:ae::18) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.159.144) by MWHPR14CA0008.namprd14.prod.outlook.com (2603:10b6:300:ae::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25 via Frontend Transport; Mon, 1 Mar 2021 01:16:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4bb9c453-cea4-42df-3ee2-08d8dc4f9495
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR2101MB0981A3A2906A503D50FF453CD79A9@DM5PR2101MB0981.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F2wQOrUfW8Pn7cUWXVzjnYfbItr0GyEeHJY+ifEEJF7g+bwnAd4Kcn3yVZW0tfKVHS2ljJq3fhVlY3SBqt3vKMjOhvaqKIizDV6LHkY8ygQntNKwbZhz4m7mK46RPh/BgwUvVbBB0TsZN0YevdzYhorLDMekxoYgbsJip924DOeomp6jZoeykWTEOaOXGpdDT4rHvnFIAvG9aQOvjciBcs8UnJ8hUP0Xkkda4f9qbmTlJzjPErGik51/+/tAFEsyc8AVunmKxYC/XR6x9mhSGXvzD8DsjIZogFQ0OrGSZieLVzbgZENJ7kcsGnMvHKMpQ3Heh03woP3Tdo1fUS/nfCM/02wlDF4GkQ+Im4MgIGuJCN9BX/2ptVnza25nTzvkgShVDYZkXP5onuJyImbCh+b3HHmkL6XK+gspmNUBGyIYTKmdN4eBzGBTEXF0N3lHq1UKqk35/JZWmwM+nAxZuNp/RN1WZ3xcVJjwzHJ1zsgmDo8clQkb2uZypzr6Wk85ens1gJVI2loa0dPASe8P4AslDbz/X9WiVeYT5t+YTF+//YuZN5SEEpBxgmY7Pw3s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(83380400001)(8676002)(186003)(4326008)(66946007)(956004)(86362001)(52116002)(921005)(26005)(2906002)(82960400001)(478600001)(66476007)(16526019)(6666004)(66556008)(6486002)(8936002)(316002)(7416002)(10290500003)(2616005)(7696005)(82950400001)(36756003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CELnk8xZyvr/UxEmWnHCzj2aWmveYuunZVKSTuKy/PAOZInyNunSYNb+VyuP?=
 =?us-ascii?Q?dulqgcWQUZhWn1vmjWWQJJEXk2Ip90/v3nkfRHqdRaNwVRHl4TKbtVoET21a?=
 =?us-ascii?Q?2UjitnRN6v7H+eNyu1iXQ1Q/u95uO51EPCDcyY2c4Wp5a5sFr0RF0RZhaW5j?=
 =?us-ascii?Q?O8/R4PTPgmKIPu7QzdlWsI6+3dEIzFKaYXImdeJSNrcH4RVbwKgg9+55uTSd?=
 =?us-ascii?Q?vBkpOGFlJb09ncAA2sRXLkmKGTHwMEs0rA5LN3e7UGjGFJiUPekWUuU7BTVL?=
 =?us-ascii?Q?qquJuakKQxxr5YGIY5VMeRDzAfcKE5RePk9qCnTfKRv8gOHTiuZGADfe5fre?=
 =?us-ascii?Q?SJycB4AMf3miZWdMNZQfbf9UWumM5XvPAaF74NfFQPPKBjdFSKSsLgUQW9nh?=
 =?us-ascii?Q?JB4+jLm4hjQos1wC6GbbXaWh6Yoje6dSuoxQStzJMlJUT0dXUpNjeYvbgvxF?=
 =?us-ascii?Q?/GknbJnqwPrMku6F01stYTyZDKtwFLq6nZBx7/j3LEnCED1ArmbKW1UXWOWA?=
 =?us-ascii?Q?F1RBVzt+UszBS2b3ifKv43NZRsH/Fw9hMS7VuQ4ODiWUhpFgIxC47PAS/OnO?=
 =?us-ascii?Q?GUWR96Z5QOfE0gqQQ3UCD9t9l6guIbB7eRXYEPMl3edchD+22AYM2vLyf7Xm?=
 =?us-ascii?Q?wFv4aVstXC5ZgIMzQFvCB4WmQXi5RFuptrEKZeHleyh7ZUcS0bTwm0cRGX32?=
 =?us-ascii?Q?AKxWRcuY6d+YvvK/l5cckgx8pEKtqe0mcVqpLliwktAuEO9Z8mBRbHCj33pE?=
 =?us-ascii?Q?cgKq+WQCAwMZlP+b3qaCMSpHQmNGG7HAhR5pokzyNK8tQ5Si90KKVi9Q7B54?=
 =?us-ascii?Q?C1bylyBCVmKYXH5zHlWSnrreJ8TQdh4rti1nF1vziHT/bFG025OAbuRaBAIi?=
 =?us-ascii?Q?2DJ5zz5/Z+GAuaJkb6OqqGjISolbPSzV08DVSQFuk/HBj2C8v+Aa9BFCbbhh?=
 =?us-ascii?Q?R9Znl5hJ/3vveIEr/knpK4veEnT4AjfBHk/nkRzcqVmT1ebnhbF2khNxgaAt?=
 =?us-ascii?Q?bgsNxQunU/f851sP8bi+Zi9BHDTKy47et+8qx2A51px/Czwr6rCkAbRzht9Z?=
 =?us-ascii?Q?0yxUqxMlrww3/NYvz0QLKkprOsIN8WlAjjyqnuY5nBmBbGuqUoqHOJWIofFP?=
 =?us-ascii?Q?zuMfe8kYNjhFLbGsNWCSxtsk5wQtilHctm1zG3D2j/zGmwT5LmzPcZOKyaKy?=
 =?us-ascii?Q?2FHyZEd0B1Vzihj1/cPLFtEivHDM1XTlOIDpZdtZX4XgZnt1mU1ykYOTgsBc?=
 =?us-ascii?Q?AVvisYlWxatT2k2twwSYeaL8IGAlurFCBVIM1umDxnaNzimxJobUS3aFdpyZ?=
 =?us-ascii?Q?yFzQA78QseM9l36pplKQY/9z?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb9c453-cea4-42df-3ee2-08d8dc4f9495
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 01:16:02.7724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFmEiCqkt+J16zN/pfam+dge74q+LHFAHorqm7ogg71JSSw/gIMyONLGIa6vrnpMDT+JoirGz11q/jBfMS+vqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
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

