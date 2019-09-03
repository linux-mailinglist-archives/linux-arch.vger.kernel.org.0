Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEA8A75D7
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2019 23:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfICVBB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Sep 2019 17:01:01 -0400
Received: from mail-eopbgr800104.outbound.protection.outlook.com ([40.107.80.104]:7800
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725953AbfICVBA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Sep 2019 17:01:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSFlb6L76FOTBkw9d6tZAq1mBDr9HFVAykGZL/beLoWPflucXzLRmh98Bcbifd89Rq0zen2N7vG4mOQVar54Q2cIccB04hLAKpM4JVo83Wf8R4tYvDanxtljPru5LlYEJw6SB8Vf11KGqD/8gJfe6Eq42U71q75qpM2/4DbboTjgJHSeja4BAu+sX0DMqBiGCsjY7WJawVkgPbSAN4x9mpxb3SZUay02jma1UuCxP9al9xUhMbpRtdN8ezgi66pdGQFARhb6pyYA7Bc/7Om/9b6Jr7cfjDIf5cDpW2ysWas/4n+t7OPLtMWXhCNI5crYhPCG/kQax7emR0XhOJb2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHe+nRs17sEsXXBKjE7Wm2h+HNWZwys85dH9KzCIaeg=;
 b=ZyP3V5fQY8R88Xz3MjEZh1/Zri1phSJJMs/II1Hf7Cem98/DTCUUN8LfT1p1vZkAff1DuQYosaoz7cpd9bV/nKyNOii8yIE9LX3KtFwIuRLitvlcrkOsr0+GdGQaIpbB3YypjVaGucQkeDzGPQ/ABRRDuwMn+Ve/HdmQ0Y5YZgTezc+KgT5s7MnOkdZxL1qLZFFOawGCsPOoRHhCEDQy51Pq9RXoQ9bfphF7OaJJimSlAA/KREZSnSf+ikkb3T9plwtEmtdW/e9gX+FLkg1Ulc59itZN5Rj6VBGksDrd/nSDkvjM9PRSSVTY6iLo0jywkYfkQ+fir6zzJk3CROdPOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=mips.com;
 dkim=pass header.d=mips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHe+nRs17sEsXXBKjE7Wm2h+HNWZwys85dH9KzCIaeg=;
 b=WUVpWvQYd/b8YHlZ30o06xC6aGkigy7yGaOccKHGj8bkXL4Zr4q2EPO+X8+sHD7nGFPxzyHZPHuYAV4MOv1ZXuMJiyPfggUa3DlBzLAL7MgqScsDXCabNCqmMgRrG22PVupe1utSHJozh1gyQ9CCZPFPtUQvOJdSCbXca0tCsh8=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.172.60.12) by
 MWHPR2201MB1551.namprd22.prod.outlook.com (10.174.170.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Tue, 3 Sep 2019 21:00:57 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::f9e8:5e8c:7194:fad3]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::f9e8:5e8c:7194:fad3%11]) with mapi id 15.20.2220.021; Tue, 3 Sep 2019
 21:00:57 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "salyzyn@android.com" <salyzyn@android.com>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v2 3/8] mips: compat: vdso: Use legacy syscalls as
 fallback
Thread-Topic: [PATCH v2 3/8] mips: compat: vdso: Use legacy syscalls as
 fallback
Thread-Index: AQHVYpquVTUocwY3d0uz1j8PNA3NAg==
Date:   Tue, 3 Sep 2019 21:00:57 +0000
Message-ID: <MWHPR2201MB1277ED2AD21C031201F749EAC1B90@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190830135902.20861-4-vincenzo.frascino@arm.com>
In-Reply-To: <20190830135902.20861-4-vincenzo.frascino@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0480.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::36) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:18::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.196.167.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff988808-de10-4ae0-5a8f-08d730b1d103
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR2201MB1551;
x-ms-traffictypediagnostic: MWHPR2201MB1551:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR2201MB15518335CDAC1F1178B5C2DBC1B90@MWHPR2201MB1551.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(136003)(39850400004)(376002)(199004)(189003)(55236004)(316002)(42882007)(7736002)(305945005)(4326008)(8936002)(6916009)(74316002)(386003)(6506007)(256004)(7696005)(81166006)(76176011)(102836004)(54906003)(186003)(25786009)(8676002)(81156014)(71200400001)(71190400001)(26005)(229853002)(478600001)(966005)(99286004)(5660300002)(52536014)(3846002)(6116002)(2906002)(52116002)(33656002)(14454004)(486006)(53936002)(6246003)(64756008)(66476007)(66556008)(66946007)(446003)(44832011)(66446008)(9686003)(11346002)(7416002)(4744005)(476003)(6436002)(6306002)(55016002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1551;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Lo0x0Jh2oXuLX5JZhpQmBBuMCZ2IPJFHMZClsa04RSG3Z92aOAe+YdCS3uEyrWFlmyVdZdwwhFWq+CTTQK33S56C7wxAXE2keHyhUDXp/EbHEViNgnsdQ82KpsmlCUmFGDRq6seiug3JSkpTCW7fp6AsttfNsfP/NX3UuzcGjCwRxv9iaieV4IC/J8TE6Kho/gJdbvDtm953vZLuaa29ChN4IOaq2gesawcKrVdGFEoLyNuqPhxT0yMuxk5XMHHStlI7JFScGK95JUbvoNFo7o3ain73ae25TF6crmmee96djOsa5PINRVFfeG4b9eh8YoUbzl1H93ZuwUzDpqvAg52zC4e6p2D84mlsR3OzdFY6XCnIzwySaiLEusFNODKg+HrCNwMyUo1MxIoN8akRnDqlbpcubbyGwBHIyFH3uJ8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff988808-de10-4ae0-5a8f-08d730b1d103
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 21:00:57.1566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FsCJgR/o5cPJLaGQBxzwofEvEivm+RyDYhetHFlca0WvlvLtRW12y77S8Y9XM46+oWy7g7q9MongdJBtbWKUzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1551
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello,

Vincenzo Frascino wrote:
> The generic VDSO implementation uses the Y2038 safe clock_gettime64() and
> clock_getres_time64() syscalls as fallback for 32bit VDSO. This breaks
> seccomp setups because these syscalls might be not (yet) allowed.
>=20
> Implement the 32bit variants which use the legacy syscalls and select the
> variant in the core library.
>=20
> The 64bit time variants are not removed because they are required for the
> time64 based vdso accessors.

Applied to mips-next.

> commit 932bb934ed4d
> https://git.kernel.org/mips/c/932bb934ed4d
>=20
> Fixes: 00b26474c2f1 ("lib/vdso: Provide generic VDSO implementation")
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Signed-off-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
