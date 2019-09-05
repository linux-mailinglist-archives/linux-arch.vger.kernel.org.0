Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26390AAEAB
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2019 00:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391272AbfIEWrP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Sep 2019 18:47:15 -0400
Received: from mail-eopbgr720114.outbound.protection.outlook.com ([40.107.72.114]:24931
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726073AbfIEWrP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Sep 2019 18:47:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnFJ469D37BNx93RXWYt1atpkNzjsKvGvU8YobjSB9ageIwQNFT+jHH0/aSN1WnMbY+lVlV/ABRDoveCir3YZuRsKwzQ6Gg/CTTYoMiWhxtEeZI91C7V0mGXCrx5y7zTCdRmJgLwD4hq9UCiv0Ev/hqFsezmttvmsmw8ADmRQBre52/JJ8Surqxhf9FGjEeVSVUxWoFCCgnecFB4hRKEhXMGFYH7AcOjyoDB50CHP9PHSkR9W3zpAlPim/Hz77qAo9BP9jN1lo1LdMhsXhkURaFV6RZ4cHAJuYZ08xIXZZgHbtuH2SFCdex4ARnYNHlqQ9TwL5r2Y8Ms/pwpue91Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wB/LjimBr2pjdLvv21IkEgXaqr45JwAy8AzGtOUTIIM=;
 b=PGf/tRPqZ5cFS0LSTlkf5yS6u+OutEr9NDpLFvkcmraXOIJ4bBxn1l1BMU6iZt/nL2jkHDSSGhXG4gDdrWkY7QQO5teZNpjLk4huhucsuvpYlheMGkelQN+046hEmk6WYXxTbRyKgWOWWuIsD6m4nPCoNZqK28h4ZWeObbNp2evs5WPQt4Jqm1Xj12sxMvyHUWBDDJf6TsIbJZpW9qmr0npKTw5lzHNLVC8bysxIzd06XcS4cSivFieQ9oajxAWQnRqUFClu8jFCgMdLHDM+wEo0aje3Kk1cU/9QGOuT1Wljd/IvMI0razRoCrY7DTAGltSHDdbs9sJLC1KyMtkw8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wB/LjimBr2pjdLvv21IkEgXaqr45JwAy8AzGtOUTIIM=;
 b=I52XLv9DEtKmXB+xSlmii6ETvk2PxoZ93mA7lgb4uXbbrSXrWSm8RzF6lZlgbA2DknHCQcNfwVM/vAwjRqCY54CMgzHu8mXXZObhN19kzyT9QnyRFO8VAyJs1adqsCS2MnkRsDLp0ps8TZrITOOKifp5Wtn6LeDxW18/4UjUAl8=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1101.namprd21.prod.outlook.com (52.132.115.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.7; Thu, 5 Sep 2019 22:47:12 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Thu, 5 Sep 2019
 22:47:12 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v5 1/3] x86/hyper-v: Suspend/resume the hypercall page for
 hibernation
Thread-Topic: [PATCH v5 1/3] x86/hyper-v: Suspend/resume the hypercall page
 for hibernation
Thread-Index: AQHVZDvbqcf4mG84E0mgdKNCoP1lHA==
Date:   Thu, 5 Sep 2019 22:47:12 +0000
Message-ID: <1567723581-29088-2-git-send-email-decui@microsoft.com>
References: <1567723581-29088-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1567723581-29088-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0019.namprd19.prod.outlook.com
 (2603:10b6:300:d4::29) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfdb9fd8-2bb8-4432-c9ee-08d73252fd77
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1101;
x-ms-traffictypediagnostic: SN6PR2101MB1101:|SN6PR2101MB1101:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB110106DB3D74EA7DB02258E0BFBB0@SN6PR2101MB1101.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(189003)(199004)(4326008)(36756003)(6512007)(25786009)(99286004)(6436002)(7416002)(81156014)(81166006)(8676002)(53936002)(386003)(76176011)(6506007)(107886003)(6636002)(4720700003)(316002)(54906003)(110136005)(50226002)(22452003)(8936002)(52116002)(15650500001)(3450700001)(66066001)(2906002)(2501003)(43066004)(1511001)(10090500001)(66476007)(86362001)(66556008)(64756008)(26005)(66946007)(66446008)(3846002)(6116002)(2201001)(305945005)(2616005)(11346002)(71200400001)(476003)(102836004)(446003)(14444005)(256004)(71190400001)(5660300002)(478600001)(10290500003)(6486002)(7736002)(14454004)(486006)(186003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1101;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lhiJ0OWW2yKoE0KsUt/qf1V9KGbYFwadIlUFBofySPbX9uKNoJCKRPntJ2GGrIr4Z5DFSyWP8YbROa6eqlSXskIFiI/lVyLYL86k+FX220Hmcd6HHS3Muw43cr2ZHiIj72wkbyIZfXs3fY9koX3dYiDX5/Fa+nVco7VgNcVmLlJnBoc2A/IG+73Y2YjgQiI6L3UNsxpu7mAxMmTDOnNK8TjgutD8kZMy0jgvqdZazHv6bNaNVpMXKJP3+yviYYL9IQ6g/wlw4uPuiA1y0oZjiOlLyKO4VDzdhIutKOnBIpRCvRG2RzmFkruYVQv0YmrqdJcRYGTsstlcP++OTq4nyuqJ4x28USWV39uLkyzlQv6plOzIr9mFMS7JkjmDhm/cVW6yBl2KWIFib7xniqeZAHh5Tm+nReiQ++wXKnkOAwA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfdb9fd8-2bb8-4432-c9ee-08d73252fd77
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 22:47:12.6822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iPH2hirT8jBlqbFLbbL2xSKgo3B7z84HItPP+fYfX8XSEUKePTU2RiEm3S/fwNdfmKvJYrZwNz+c4+1/oec+mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1101
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is needed for hibernation, e.g. when we resume the old kernel, we need
to disable the "current" kernel's hypercall page and then resume the old
kernel's.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 866dfb3..037b0f3 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -20,6 +20,7 @@
 #include <linux/hyperv.h>
 #include <linux/slab.h>
 #include <linux/cpuhotplug.h>
+#include <linux/syscore_ops.h>
 #include <clocksource/hyperv_timer.h>
=20
 void *hv_hypercall_pg;
@@ -223,6 +224,34 @@ static int __init hv_pci_init(void)
 	return 1;
 }
=20
+static int hv_suspend(void)
+{
+	union hv_x64_msr_hypercall_contents hypercall_msr;
+
+	/* Reset the hypercall page */
+	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+	hypercall_msr.enable =3D 0;
+	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+
+	return 0;
+}
+
+static void hv_resume(void)
+{
+	union hv_x64_msr_hypercall_contents hypercall_msr;
+
+	/* Re-enable the hypercall page */
+	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+	hypercall_msr.enable =3D 1;
+	hypercall_msr.guest_physical_address =3D vmalloc_to_pfn(hv_hypercall_pg);
+	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+}
+
+static struct syscore_ops hv_syscore_ops =3D {
+	.suspend =3D hv_suspend,
+	.resume =3D hv_resume,
+};
+
 /*
  * This function is to be invoked early in the boot sequence after the
  * hypervisor has been detected.
@@ -301,6 +330,8 @@ void __init hyperv_init(void)
=20
 	x86_init.pci.arch_init =3D hv_pci_init;
=20
+	register_syscore_ops(&hv_syscore_ops);
+
 	return;
=20
 remove_cpuhp_state:
@@ -320,6 +351,8 @@ void hyperv_cleanup(void)
 {
 	union hv_x64_msr_hypercall_contents hypercall_msr;
=20
+	unregister_syscore_ops(&hv_syscore_ops);
+
 	/* Reset our OS id */
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
=20
--=20
1.8.3.1

