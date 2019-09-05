Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5891AAEB2
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2019 00:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391332AbfIEWrX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Sep 2019 18:47:23 -0400
Received: from mail-eopbgr720114.outbound.protection.outlook.com ([40.107.72.114]:24931
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726073AbfIEWrS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Sep 2019 18:47:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+neIXm0fjKeG73uLdgY1fsTu5nMaumihiVODoN3APGJ7GVM/I/r2hXzRTnC2H/AMjQ7h0IPloASE95/zMsgazgXyqyb89HJZOkz6fyQ1gPvEGk9xkVetT9VE6vtCo9iURbLVW7JLrpVj0xaU0vnrY4r6wScZmgm3lkGu0JmWSPja5IBNwDIHjO3Z0lUV0GXy1nT1cYK9WCqxcTx7P1G0inRTJBE44JBGi7jjOJrJtE99ESlltxPKeqfPf6QigRBb9o9s71qhqALJrvm/KIEJ5uhn+M4cAFzLZP+XCM/gFn3mhtUXa2l9DEYBv5nb1anwG7U/2pL6j0dxVQQjnYpWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdURKNttnLo5qXBi8Lwm+WfI8lgXTxhgQJXtn5e08+k=;
 b=ReEw+zhfD7diugFP3hVej1JzNCbvHO2G60fOiCi0iCtcV9fSTiPkqopHEripwXk95lvOB+aYJD7uMXEoRlBUIW39ojtM4W2bCn7pPz6ZKh5AevZYvYhFmSVn29dg0jYbQ6bPs/CZ4HCiN8ziI/tKZmU8T8e3e6Vaq6a4AH2h9kIfyy+Eu/KQ4HiX+0H9nhaRv+fR2htHdkNQyQ+5O2CSc6UJ5SUqAYgvkhBI7zPblvVANX0qq8RPGEGJEZI/x35NpeJ9HX7LVFvtQ/FsRRXIop6r02y2sz4sGWfhAoY/qYUirhrV7Zn/1U5kRUnmfBux9RJnmqEtczWXpctYtPrzhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdURKNttnLo5qXBi8Lwm+WfI8lgXTxhgQJXtn5e08+k=;
 b=c3PDTABYZ9nGaXbivJs3pczwDyGC+GgBuiSzBy5hS7Brqbnia6jQE7GQG1XMrhVkTThwLAl2Ap+d3+B4/HRljUTc1LTrDmFrLoSc9/QAqMPvB3xRp7TDvohQoC/JRkT475Q/bR5LFaGvnoYbsi1Rj2ruGEciJ1nOCr0F7MQhCxI=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1101.namprd21.prod.outlook.com (52.132.115.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.7; Thu, 5 Sep 2019 22:47:17 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Thu, 5 Sep 2019
 22:47:15 +0000
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
Subject: [PATCH v5 3/3] clocksource/drivers: Suspend/resume Hyper-V
 clocksource for hibernation
Thread-Topic: [PATCH v5 3/3] clocksource/drivers: Suspend/resume Hyper-V
 clocksource for hibernation
Thread-Index: AQHVZDvdvhBUU2BEl0WM7iwUOZE1Mg==
Date:   Thu, 5 Sep 2019 22:47:15 +0000
Message-ID: <1567723581-29088-4-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 075969ee-bc04-46c2-7ec1-08d73252ff78
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1101;
x-ms-traffictypediagnostic: SN6PR2101MB1101:|SN6PR2101MB1101:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB1101B8EE0783341CB3C4C5CDBFBB0@SN6PR2101MB1101.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(189003)(199004)(4326008)(36756003)(6512007)(25786009)(99286004)(6436002)(7416002)(81156014)(81166006)(8676002)(53936002)(386003)(76176011)(6506007)(107886003)(6636002)(4720700003)(316002)(54906003)(110136005)(50226002)(22452003)(8936002)(52116002)(15650500001)(3450700001)(66066001)(2906002)(2501003)(43066004)(1511001)(10090500001)(66476007)(86362001)(66556008)(64756008)(26005)(66946007)(66446008)(3846002)(6116002)(2201001)(305945005)(2616005)(11346002)(71200400001)(476003)(102836004)(446003)(14444005)(256004)(71190400001)(5660300002)(478600001)(10290500003)(6486002)(7736002)(14454004)(486006)(186003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1101;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hLJHbRTNPNNi/dH7Z0QrwawqaUuTOXCAcICkvucSg50z4UB41q+hqEdRdjmdDRom8fqUji1sMYO/47qwfIs+Erpnho68GxoHscaTrKjyXUPFfhkCr41NigU2RRZchPWjI5UF1YiaYGlkmeTQaCdPfFzKniRtJdMMWjZToJNaHb71WZ//Eis8ldj+LurE0pdBu0LGDDp9spLKcC0fxhDob9ci/MjBOr2vXMRscnHp3XylY2Tbru01PPrctohgSK3axnbgT1hHSyqrAG23zI97bZ680uAMjHoPU8CDanYHWDb2egajEe0L04astRu+tMto7Ljhq8ExPbt8txS+VKPqeHFtSeWPAATUdSPRpVJMGSYz8u7NBDK+eZ9dcDITPEaaYFyDcpDraUYidnbYssfzeiGgo6t46N3crTbq+5K94m4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075969ee-bc04-46c2-7ec1-08d73252ff78
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 22:47:15.3736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +tSO+TUiViA36eckM71CQnqfTmyHJ168aWgU4hY5PZAg1vPdaAy0FlViPtcBTm3hSTKbmXpl4+Gx+g+w5C8PSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1101
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is needed for hibernation, e.g. when we resume the old kernel, we need
to disable the "current" kernel's TSC page and then resume the old kernel's=
.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/clocksource/hyperv_timer.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyper=
v_timer.c
index 726a65e..07f4747 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -237,12 +237,37 @@ static u64 read_hv_sched_clock_tsc(void)
 	return read_hv_clock_tsc(NULL) - hv_sched_clock_offset;
 }
=20
+static void suspend_hv_clock_tsc(struct clocksource *arg)
+{
+	u64 tsc_msr;
+
+	/* Disable the TSC page */
+	hv_get_reference_tsc(tsc_msr);
+	tsc_msr &=3D ~BIT_ULL(0);
+	hv_set_reference_tsc(tsc_msr);
+}
+
+
+static void resume_hv_clock_tsc(struct clocksource *arg)
+{
+	phys_addr_t phys_addr =3D virt_to_phys(&tsc_pg);
+	u64 tsc_msr;
+
+	/* Re-enable the TSC page */
+	hv_get_reference_tsc(tsc_msr);
+	tsc_msr &=3D GENMASK_ULL(11, 0);
+	tsc_msr |=3D BIT_ULL(0) | (u64)phys_addr;
+	hv_set_reference_tsc(tsc_msr);
+}
+
 static struct clocksource hyperv_cs_tsc =3D {
 	.name	=3D "hyperv_clocksource_tsc_page",
 	.rating	=3D 400,
 	.read	=3D read_hv_clock_tsc,
 	.mask	=3D CLOCKSOURCE_MASK(64),
 	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
+	.suspend=3D suspend_hv_clock_tsc,
+	.resume	=3D resume_hv_clock_tsc,
 };
=20
 static u64 notrace read_hv_clock_msr(struct clocksource *arg)
--=20
1.8.3.1

