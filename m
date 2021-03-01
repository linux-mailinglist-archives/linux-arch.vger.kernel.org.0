Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489403275C9
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 02:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhCABRh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Feb 2021 20:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhCABR0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Feb 2021 20:17:26 -0500
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (mail-co1nam04on0714.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe4d::714])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70570C061788;
        Sun, 28 Feb 2021 17:16:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpgytxK9CA/Fomk8vOXs1fj40p/XVGLe6kenYYeQ+bbAo10xhun1pIeUVDpvlPFMVq84nS+6bB5c9FRger4LOqfZw4WQdhGxzcV4xdM2imwulch9is67sQRDPkDaVtwirTs6X0HxUgxc01t12NEAi8C8SQBdIY6wxDqMmM34q67ck2nCurzWuAmYUYQbAvR92VQdQqRYE2NCYvcE/Bbm1lMVTxx6kUzSaKmXl/2OjOPvOl/88RMkPJSJ1WwS2oqeRgYxdy48vp0O/mzgtAUvaf3S6zcRTOuFB4n1WEnn6AsDx0AbYOmSJ3jDw4Pmt+vseb3M0eWOZvTWz/2NJWmB+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLj8ituJuOw4KteVSUdJDa2/mnTop9arIwpAnIfvLe4=;
 b=KNyoRYgUaa+pfuzsq6l3WamHBkx7ZT4zjc08gYpZaQozzKs+79SaGDndG/HnfatY+TraZI7TC44MzeWO8B86k4/dVyMZwnDkiWiPnftuLuAFWx8+XM4I5CPcODsdKE9g1tm8g5oPm3mpaLnivI070GBLWHnR6sUiyfb311gVCV8yHafv7iR9oi+fML++2n+EooWk65jZWNkOZp+uqwksuS8HrT2km/NU/eIRRDnHsBHT8VJxBSE9fjjPBjOz7WVRPVbY1q7Wl/Fnmxh3VaPl2Hi25cuV2uCLETHDRxq4oxPaDO+RdQDJAXCHQpFszNC/eYEd/45tfgj6piY3qi/VXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLj8ituJuOw4KteVSUdJDa2/mnTop9arIwpAnIfvLe4=;
 b=gxUXHjK07+Z7P5U1SiKO+Qp0xaq3AFH22sPHQRtjr7Np1R3intf9RW2UmB6W5leRS9GgKizXBbob7OQUZksQ+0b7p269qN61HhtwMEA1RzI9xC+YLCgeMp+MLhU7xIETXlA3u20IMRAasvguKFt+vz1CRlY9v1uIWUGh/sMSeMw=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB0981.namprd21.prod.outlook.com (2603:10b6:4:a8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.4; Mon, 1 Mar
 2021 01:16:06 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3912.016; Mon, 1 Mar 2021
 01:16:06 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 05/10] Drivers: hv: vmbus: Handle auto EOI quirk inline
Date:   Sun, 28 Feb 2021 17:15:27 -0800
Message-Id: <1614561332-2523-6-git-send-email-mikelley@microsoft.com>
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
Received: from mhkdev.corp.microsoft.com (131.107.159.144) by MWHPR14CA0008.namprd14.prod.outlook.com (2603:10b6:300:ae::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25 via Frontend Transport; Mon, 1 Mar 2021 01:16:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e4063db4-0bfb-496d-85b2-08d8dc4f9695
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR2101MB0981451816CBFD523A35681AD79A9@DM5PR2101MB0981.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 084Vi8f6gME4dElAZgeCEL9MRoXdH6If1zksAZmbxyQ/AFK0yyzUa5We2If7msFEVrLpHwU8S2RZ4Uscf42ehJ07ag7zM6o2g/CwL+LOHvnIfYTuZ9qEZ13/mU3G4S2s4s7NRoQLolMx1+Hbg4c1raHTDNR4oBuufJvthcuuRtLbjaqX5xY9j0mTRzRj0aXWfyiGbG4C3iWWp4JR5mTlasjU+hAZ2hF19tFnd+NyobvD/dpz7/CWIKuUHjEy5PcU2PZbsrWitCoOFVuNYDuWaPIiE4wF/9GZq4zsGrtcmgJwXMV+6klA33KceyC3btoavj+VUAaqfn1tpirhNZvwLUybCzJ9mrkmzMR4b+l7MFAIc+WNGkvbcbnl2sNGntwcM+bhZjZ6mw74ZeiLgSbc5dnhplQRRuz6RItCo4hvqooOsx1c45LGXv4W37Aw/SGP5Ux3Ng29MpXHR6R4FhRhq+eqocOc9ICfyV1wZv43YUOTKxssR0JuAoJUF5V+YuHpxs8eDVMU5Ev+vilA7cD/1ZOlI6A2tiKoumb716gzILhN8Zlgm50dii+w8TyH4U4M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(83380400001)(8676002)(186003)(4326008)(66946007)(956004)(86362001)(52116002)(921005)(26005)(2906002)(82960400001)(478600001)(66476007)(16526019)(6666004)(66556008)(6486002)(8936002)(316002)(7416002)(10290500003)(2616005)(7696005)(82950400001)(36756003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pHj+Mc8EgFl/OHdwu048Glu0RhvUFQfrYvwRzMf58L1PK2WZlcOSFxiTIAuN?=
 =?us-ascii?Q?/H2KnSkEGjRmG/KUQRZZiiK8IfSrVT3yQsdBhzQIEf8O/sVEOZXdimn8fTzL?=
 =?us-ascii?Q?fYefmXg25EvXLAnyQAethhYi8Y2jljtJ+6Yx4IiSe/gXxRJBUvXPH1Lcxrpd?=
 =?us-ascii?Q?qb0nUX28X1vEH2cY2QXbDZiR77lUQRqrlynaH6/5lNClLMyf7QKsZ7Vnw5OJ?=
 =?us-ascii?Q?OpbYL9XiR7qmVWB/Xz9ibcV28hDbRmDETeXUPKRaxQXdVQf/EO8N5a6gH421?=
 =?us-ascii?Q?XcZPDRzzlM+O7ugRA5Cm4rp6GCr6BAjFtcUb3CVX5eCUqgPa8BjKKDN0mEQR?=
 =?us-ascii?Q?T5oB6zD4IvBVGUoihD0/A7luilgVTUWIIEFNx1nb+cZhWqbMNRsXu8rYmpPJ?=
 =?us-ascii?Q?I2CHkR0c4J3POEB52sB6utXWf6zFaEZY9ZxpN7Ywzou2Zdvwhk6O25+js7ug?=
 =?us-ascii?Q?M9LpnVeG0GLivVg9Rn9Egtjl5TH3+ccA1gsVmb82J0WegNnkaspA+jiRZETZ?=
 =?us-ascii?Q?A9WEuZUQ7NYOhnyf+q5Hzb7+npKhzFmfT0gStjYnLcYyDibG6Z6hGdd0/BDn?=
 =?us-ascii?Q?hjcyba2EKfP0Dfm4DV/ptgEnyFYeW5Ik4zUUisydKzxnUoqNVGWHQQJ8Z3+j?=
 =?us-ascii?Q?QGrqON8Z4WHDQOThlBVkpYKlqKJzmvReYW7DSfzOQ9u7NJUEQ2seq86aJ0lm?=
 =?us-ascii?Q?sydvplRCL8II0OzhDOHKFSQ1wArTayDz7fqCYQkmcySMFFwRq2DiaCJpreVn?=
 =?us-ascii?Q?dDyaG5roRp/o+LOY7FjIbxT9rD81ypWTZPyZs4KxC5Z4xijMBAxNjRUOh1b4?=
 =?us-ascii?Q?zTqc1vQUY/xKVTPGGkg7+cCH9vGQr9UzDNZVbH3uQrI1qSikEt/PXK0IpzqT?=
 =?us-ascii?Q?8r4sEJPQoyYHVfPzsxH8A66h1neFsiyL/ovMKanfnNL18xuOb9R1J3fAAqVK?=
 =?us-ascii?Q?eEY4lwY2X8sVNi5dU0wRpiqh6LoFkquHwTAdq5erS40YXotfSl7gKtvwqm3K?=
 =?us-ascii?Q?8yc5c+7A2EBjgpk/c6ZL4NNI7LsHVw993u4Dv9k5HrdjrGovK/V9kgawSu8/?=
 =?us-ascii?Q?zVsYuSeHjTKHqVBOTZtd6ph3Jnn1FDsTiLmMpSMd9fD/CFBwFvb11Cp04nGH?=
 =?us-ascii?Q?0pqzRJv0Erx3O0iPSq95HZn7AE2pI3NW+ysB5iHkM8CBXAP1E6/iwGu16MKG?=
 =?us-ascii?Q?g74QBqaNiYoVxJAnSKskQgGast4CsHZ+pFG25AdVNHizqhgksI6flSfN6pZR?=
 =?us-ascii?Q?R8Xb6Oy3LqgFmJaZIHcTUkfv30tKP6zoCZfCxLRfYc45zWbQE5QMwOFqsYlb?=
 =?us-ascii?Q?+D7jzH0SOAN6LgBjIiyL5I8C?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4063db4-0bfb-496d-85b2-08d8dc4f9695
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 01:16:06.1307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /l1LmWe1AjW7LnsLJ0Dgqxw4dgEcvInrJx4ljxKKZF6BF8P0lBPEu4XhUnxFrQ/ezaOewINGDhhrVV1l66CCmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
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

