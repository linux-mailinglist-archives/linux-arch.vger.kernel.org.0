Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5562C32B4D3
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442737AbhCCF3W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:29:22 -0500
Received: from mail-dm6nam12on2132.outbound.protection.outlook.com ([40.107.243.132]:31425
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350037AbhCBVkT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Mar 2021 16:40:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cs35dnifJw3NXiv19uA7Iuadu9zL5rQuRFFXzyQBqkBtiSAwOQn09iZYSSKg+JMkhhJJUe1ltyQEq7LxqxRyv/X5qeAwF3wWShAYgdw93KH9n17Iy5aqRNJLUafCjeOhuUyubKjAwGUdnBCudrYiEhZd2A0vhkgQHToMfy+Sa5BLpsg5IXlP/nR8zjEsySMSSlWo7nRKLFbi4/yZvlbcyWeJoAQjKW8NlakypcdyCE+bKx0IP3hExSDwTj0iSbSsg+T3H0Q4gL91DPzqwfttiwxL4YcR1RETKRUyd0AtPzZteZZco0BAsWJGPvxAjzvf3DUNWeVLE8cNZPhoEsT/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLj8ituJuOw4KteVSUdJDa2/mnTop9arIwpAnIfvLe4=;
 b=hwbUW7cXv2VeFI3X8boW4FULCG5DW0OUvHLsdo8nUvltdk/Dz3P8lhb+5P/tm/c/f0e0fwJb7upulTMzPwzNrgrliggjW6gw//BuXqoPZXR8TmHDIGfBtdgV0BdmeoWA/K5QwzJjPDmyd2TLNanfS4b50QX+dOltxCQvoupRj72/d5dAlDPEzd98j+wwJQYXol6N1cOREf7DhHCLquoQQ0U8DN9KZi6dILlc+qoShCo1hbOFCySOSJaQfDYrr7XmBV/AhrTVSJ/38l90t+bdZXfUYgaStOtCftf6ex0pGM9Z4ooPUGadDSB0HxBavVhEpnMXnlsmcvA64qUc/+dJgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLj8ituJuOw4KteVSUdJDa2/mnTop9arIwpAnIfvLe4=;
 b=H6oGWn2LpUl8tFhBjYWOHFJ6nbXGcNLDT9EX7Fnerf4yXi5Ctpa3dzLkxI+GaKL5gmPLKXowJ9q2sMcRLApV7HC4xbAsvHxsXp5Id97KI+F1faN4Vgf4LMIl9z3VAEowi96bJ5A67sDx7HuFLr8G1wGv2iXohbfAk+yNFSHrO0s=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR21MB0153.namprd21.prod.outlook.com (2603:10b6:3:a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.11; Tue, 2 Mar
 2021 21:38:53 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3912.016; Tue, 2 Mar 2021
 21:38:53 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v3 05/10] Drivers: hv: vmbus: Handle auto EOI quirk inline
Date:   Tue,  2 Mar 2021 13:38:17 -0800
Message-Id: <1614721102-2241-6-git-send-email-mikelley@microsoft.com>
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
Received: from mhkdev.corp.microsoft.com (131.107.159.16) by MWHPR03CA0005.namprd03.prod.outlook.com (2603:10b6:300:117::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 21:38:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a15bb1b4-9d52-4a23-ff73-08d8ddc3938a
X-MS-TrafficTypeDiagnostic: DM5PR21MB0153:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR21MB0153ED44A8464F8BDA80CA2CD7999@DM5PR21MB0153.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oLyMHt3ECIBAZeWtNc8IUKrJKdNh3tmm590+GaI+QvsjH23xTG/NPlBX5RSgTpycIigFP4kIiTakpYjVtZK4d8kzsVhtEeY/iGh5UZFpOsnXphc+bv0gmvSP8C2WdX7yC6vEvOe/lPnm+mUG54RgL5dwlDMEUM8oFocE/AGioiARy4lA6IgyhBplLxaZMkJ3ipykakTnSF4Znvk2WjCpnte9ehgzwWGOjgx5uBsOmtEVDDAQb4j6+pQMpbaLGoxzDBdoVk2Y4YwAelBLN01SA2xsct8elLmtJSi7EyziOKdXbkVz3ObAo+uXTq0V3kEhCiXzXmzBzCpq/BeqcmZ3vecatHN2yI0Y5ToqmNkDBlUD8V7LqtnMqOgv1xldJvUsPwfJCUj33H26KU9J0D8fIhrBx1co1itk1D2CEskAHI0jcFfnqUEVJKE6xdvCostwTFXC1wbE3bEdPgIIw56PB5HsQXqJxaRZ0FgCuvihqD6sGXuSpZ/5ImEqjQraY2aqEPoo503XuOeEciGvKajFz5bJlU2IiJeG2R74KtbAHVAD6DnyfT3I2WT/lMRYoEuu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(6486002)(16526019)(82950400001)(478600001)(10290500003)(186003)(82960400001)(956004)(5660300002)(52116002)(4326008)(2616005)(26005)(921005)(36756003)(8936002)(66476007)(83380400001)(66556008)(8676002)(66946007)(7416002)(86362001)(2906002)(316002)(7696005)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?09qOFBzC0RUNdEpzHPmVtxM3Q+xgvEkseUd4bbIGm4mCIIAKkCymx1u4w4iK?=
 =?us-ascii?Q?rVzAUtxsXZLDm55nrf0rGoNWdJdJUtWoY0Aya9YCUCmnv9l1TloBkw15WTDD?=
 =?us-ascii?Q?LApz+EHs83lbd1HfGh2Ic6Aj1sVi86CjJb8xNUlf8uEO64Qh8D/ZHZ7BRUZA?=
 =?us-ascii?Q?QU5qRyno73TDYVgXwrO/J7bvwQY840wAzeORGnnMguu27ETKRhK3iQjWZLIU?=
 =?us-ascii?Q?acqpe/NBINq8bQkg/7zV/q6uVZRlNo7tXxTtqT/yZnJPM+/x8cW18VXnGham?=
 =?us-ascii?Q?OnVqSSfQcTsETvdgJ3awZJbL0LW/uipqvfT7qYz5BU/IM1R8UmFokv+VrdQ/?=
 =?us-ascii?Q?o5mz/0FXImJnIFcIC84XnRUnOveriZLFFqsJwK1GaqF3HQtoz/f5HvyTbVt2?=
 =?us-ascii?Q?c9wQyWsaPx0TdDZUN/VX7vvq0kHWcysEnj+9MhvbmNTwhggKFzPVoQOrWfS/?=
 =?us-ascii?Q?20FSdjIPJb/MLRurN3A4I5+K/BMuYNDQDzOUdJKX3pBHqOIx0+FcoxoZyw9A?=
 =?us-ascii?Q?3O4TZhQfUyoejbkuIMY7AOXLEEMWrsfRabjka4p4T4RU9qzAjwMhkZZXnBWG?=
 =?us-ascii?Q?Z2UwwFYeHsADXdUYrCFUVN9k/89KoWm8O98hxFGB4I2YpAOUmf51XpIVv1iV?=
 =?us-ascii?Q?h+Ee8yRyAzLRfYNnq+Hsd8mIOlhEJ6oC8oHChFxZGlcpK3I0cqjehqI3gmWS?=
 =?us-ascii?Q?FMYwinGiy1CQ4ONMOQ4CgaaQyEJor87Tq3E2Kfi+1Lta5/viH3eBwox+n3vv?=
 =?us-ascii?Q?0V6N8VMotHpw+YAKHq8eHS9x0WEaHMtQ0PaQf2SrKwYqoP8uy2NO0kS4RwLQ?=
 =?us-ascii?Q?h+0a8/87KXDfPcTku89TKvckExqO4Uyms8qQ04yYi0xLHN8CXlM2nOX/tFd7?=
 =?us-ascii?Q?YgkHbJ7aZf56/Cq3RgVGImYVRqKBNxoNiQ+gi++0XY46D0fSBLSau14Cknlw?=
 =?us-ascii?Q?bGKXLL+mQ8BRCKZYpMviOHIItbXGQi8zQnenNV5vOjP+bDO26WL57M3qYj9b?=
 =?us-ascii?Q?C4jQMwV2LME8Wq8tGXL+hEN1z7PDlsnS6lQbMcjwYfqip8ws+q3TT4JlA9vC?=
 =?us-ascii?Q?eelJz3xxemGevH6OygfW2ayRZ2Rp1+/it06b0u2gQaXEZVzYwmijZEEQ5hnW?=
 =?us-ascii?Q?Rd4lKYAI1sBngcJ7gT7y1bPh95hH0mnJzvMM5L2fyCOMoO4PKJH1nh3UToq7?=
 =?us-ascii?Q?1vWZDmusDzY3GGYdJ3Yl5A9oJXIx0oJyVvz5Q3O3Xxw1XXT2guYyZs8hYjZi?=
 =?us-ascii?Q?drcxQqoOr9N5bBN9gJvui13VHL4QV8lSB02oUl2g5r5enDbe5ogZJfxy1Ql/?=
 =?us-ascii?Q?ivF6YuhgC923AkdEojo9vOWg?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15bb1b4-9d52-4a23-ff73-08d8ddc3938a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 21:38:53.8229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GWpefQFPjQ9+PYKlXAIWiJiKmf/Zr5vg7dp5WCVSOMLGCtmGOiuMFUbExtpTDQkfM2Nbz9eyVS1RqWMloqZuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0153
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On x86/x64, Hyper-V provides a flag to indicate auto EOI functionality,
but it doesn't on ARM64. Handle this quirk inline instead of calling
into code under arch/x86 (and coming, under arch/arm64).

No functional change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/x86/include/asm/mshyperv.h |  3 ---
 drivers/hv/hv.c                 | 12 +++++++++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 2590ce5..a6c608d 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -27,9 +27,6 @@ static inline u64 hv_get_register(unsigned int reg)
 	return value;
 }
 
-#define hv_recommend_using_aeoi() \
-	(!(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED))
-
 #define hv_set_clocksource_vdso(val) \
 	((val).vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK)
 #define hv_enable_vdso_clocksource() \
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 0c1fa69..afe7a62 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -219,7 +219,17 @@ void hv_synic_enable_regs(unsigned int cpu)
 
 	shared_sint.vector = hv_get_vector();
 	shared_sint.masked = false;
-	shared_sint.auto_eoi = hv_recommend_using_aeoi();
+
+	/*
+	 * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
+	 * it doesn't provide a recommendation flag and AEOI must be disabled.
+	 */
+#ifdef HV_DEPRECATING_AEOI_RECOMMENDED
+	shared_sint.auto_eoi =
+			!(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED);
+#else
+	shared_sint.auto_eoi = 0;
+#endif
 	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
 				shared_sint.as_uint64);
 
-- 
1.8.3.1

