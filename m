Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2166978205
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2019 00:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfG1WUV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Jul 2019 18:20:21 -0400
Received: from mail-eopbgr710092.outbound.protection.outlook.com ([40.107.71.92]:19728
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726097AbfG1WUV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 28 Jul 2019 18:20:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFlbTVuwOW+4kDWU1BEnqqxRQOMEtusbDrst7ESMHXkE1b0tkdqrWeOqOdMisOsjvuNjdgH0rP45sVM0sLblZcMFE4dUpmeY2AouYADjRgXRXQsKCe5xT0tYzhPQ/xVl/YgPO8rT7aiYgb14CwaYz+amEX1lSiTWHeXWoBA2/B0QlAiEEPn1CoXFZhpyjCeJhwkQ4BFtrrdvEsBMVp/WFbhEtAnAEKV7Wk6VN9q6zl/fMNXoE528N/L3b/VcUicp7qvJLYQf10Na3o4DZWFHZOhRA5wKScMCMM5tX1tm2zqnJqBo4q1gyny3mKPR2+yhpTQ/IB6LPvK8TRv09adDiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3opuFXbaKwLLJOMaMaC7S7a1B0Uyu3kQutKi36Thdc=;
 b=Txy6I+m2uNxIeTZqCebyzQDAfWzizx/TwnOZ/l2AecMYRt6axWmXQfCBp5Vg27bpJ+Q0ZuCiqyFy9niyqCdhPCy462HeDXEyHSvPnR3DaQaTCg4PXucfdiO/l8Z9wzrkOEFQzDmRtcrHqqKkP7ejkyiY5VcIsR6Wx47c6ORsz1dYoDkxnxi9MX6G90NZrUrv9QrzGjScFOTTzvRXe7VUnbeMBVtRWQvzdH3GSzvgAwAJZlKblQi4Lq+tStL/mu0ruy1ptXzDV3N5g0ZkgqJYbKcrwYsvhjcSjV+zQ7lNexoXPN2fa47lE1Dh6zok1EjK+lNLCerD2h2pcyaWgqOcCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=mips.com;dkim=pass header.d=mips.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3opuFXbaKwLLJOMaMaC7S7a1B0Uyu3kQutKi36Thdc=;
 b=mTYVHu06tdCBzuP8ZafQTXXXw0gJnCUBQohen0e/imOnFtKdn0ek63OQP9OO90/GUgNrgeC9brM1oq6DE3yThvdqrFFOqiejSsjqtIkAWaOZ2+klm2bJdllEcQ9g1YvV/HSfIcK5dzsXj3AfN8C7V/nyNOUScf3xinqe+eEXU7c=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.172.60.12) by
 MWHPR2201MB1070.namprd22.prod.outlook.com (10.174.169.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Sun, 28 Jul 2019 22:20:18 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::105a:1595:b6ef:cbdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::105a:1595:b6ef:cbdf%4]) with mapi id 15.20.2115.005; Sun, 28 Jul 2019
 22:20:18 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "salyzyn@android.com" <salyzyn@android.com>,
        "pcc@google.com" <pcc@google.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "huw@codeweavers.com" <huw@codeweavers.com>,
        "sthotton@marvell.com" <sthotton@marvell.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 0/2] mips: vdso: Fix Makefile
Thread-Topic: [PATCH 0/2] mips: vdso: Fix Makefile
Thread-Index: AQHVRZKjNDOd89w6f0OrGlErnSrK7Q==
Date:   Sun, 28 Jul 2019 22:20:18 +0000
Message-ID: <MWHPR2201MB1277BCF195D341D7AB3FA5EBC1C20@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190726162944.12149-1-vincenzo.frascino@arm.com>
In-Reply-To: <20190726162944.12149-1-vincenzo.frascino@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::43) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:18::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [73.93.4.225]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d77f69b-e456-428a-f59a-08d713a9c578
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR2201MB1070;
x-ms-traffictypediagnostic: MWHPR2201MB1070:
x-microsoft-antispam-prvs: <MWHPR2201MB10706CC264D422693AF3C918C1C20@MWHPR2201MB1070.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01128BA907
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(39830400003)(376002)(396003)(346002)(136003)(366004)(189003)(199004)(33656002)(229853002)(386003)(76176011)(102836004)(6246003)(6506007)(71200400001)(71190400001)(7696005)(7416002)(14454004)(99286004)(54906003)(52116002)(6436002)(53936002)(6916009)(478600001)(256004)(74316002)(4326008)(2906002)(7736002)(66556008)(64756008)(42882007)(11346002)(476003)(55016002)(52536014)(26005)(446003)(305945005)(66476007)(44832011)(9686003)(8936002)(316002)(66066001)(4744005)(486006)(68736007)(6116002)(81166006)(3846002)(5660300002)(66446008)(66946007)(186003)(8676002)(25786009)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1070;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PFfJqBqSbNu0EDcWM+C3Q69PZxOLKFq0MBMpYg0wHV+ytGOFB5JwSkPmvqptqTQUxliwi2WcrbCI4HlRHS40F/7deyN/k4zzI1PagUPczwoCNo2b+QQte/7rZCDMdVZU62RZiaXw8ul1LwuMgu3YCndH7TFDikrqB25kaGP/quwllYxIYWqVGD2zslAwKrY+CmLbHZNIs8TiV2jAU1Fq5prRCwU99rE6ZNm2McR6pWkFDQ4y7L46yZBWU14HvA143FNtg1/6j+1M/K2Zz3wjd0yWpqZ7bhBYgxdw3lUJxI1XT/ymrbSRBlESQ2PxUmCpPJ3ymXTdnVRiQpG4takckcPSpCn6bLTAcQNl5LPEMoE/oaTOOH/h2aEUH/by1GtQoTkZp7SiY9BYlX7YnrBbEL1ci43u82KAvy1fDtDHNI0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d77f69b-e456-428a-f59a-08d713a9c578
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2019 22:20:18.4568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pburton@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1070
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello,

Vincenzo Frascino wrote:
> Consequently to the unified vDSO transition of the MIPS architecture few
> compilation issues appeared due to:
> - A wrong source path for the configuration environment settings for
> the O32 and N32 vDSO library generation.
> - A flip/flop vDSO building bug that would cause to rebuild the vDSO
> library every second time.
>=20
> This patch series addresses both the issues providing the respective
> fixes.
>=20
> This patchset is rebased on top of mips-next.
>=20
> Cc: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>=20
> Vincenzo Frascino (2):
> mips: vdso: Fix source path
> mips: vdso: Fix flip/flop vdso building bug
>=20
> arch/mips/vdso/Makefile | 18 +++++++++---------
> 1 file changed, 9 insertions(+), 9 deletions(-)

Series applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
