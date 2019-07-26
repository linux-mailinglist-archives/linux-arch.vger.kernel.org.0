Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4AA975E3E
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2019 07:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbfGZFPo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Jul 2019 01:15:44 -0400
Received: from mail-eopbgr790122.outbound.protection.outlook.com ([40.107.79.122]:37888
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbfGZFPo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Jul 2019 01:15:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLu9y41WyrtHZX291E/lHBP56PPHQJAAq43ZJPANhZar9f1ysdVJcdL/gAgCcp4BSsOXjCJpgxOjblmz0YZqzu9ckfMidGXOeXfJYYTq1Y6x9xsKMMJFv2S0DcQ9x+4D+bo5Y6DUzJhMToEZ2zDIk3DYWYCq3/nZrONmUzjrE7wAdBSkyoG26BbNgWmRP9ST6l3uEAPKX3E3Vxa0ZDh5dq+2qunbBP8dwdVxovrIGBq+9/aII9q8Ut9bJG/NGNAL8jGYKBWzF6fGt2+1gp6htoVPp8mpp7BojlKzfw4d2gJqP5Bjz+xnA8Jzl4GlwdUfHM6kzvRzCrVIgYCoDxkUWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbfHS0Lpl+FEBr59jEJrBwRm/eISZeE50hRkaeS1KLw=;
 b=K+M9O+/E2Gu5Z4aVUsJuo07JQnHZx/tZkVQExQ9f85yjx+Pedgafl5JwZ5I30xZeT0bQextFWxAn3vRQ6UUNhnc2rxiC+cYcoGKcZRWj9LGyA59BWr9c339P5xLyecPi/8LdvaRWgjoUlhXBc7nj3d8TYDTj/xU5+ezPx93G8uIKU2e24eCFoixJ102ySYwDtBP0QyY5lcHtGyNgo4zvV3+krxNw1stvUp41/KFu1/y9ONSV0/z/SGANjDaVO3xIBnGYLtT62fjxD1DyRVob7kMWS9RuzNa2cOMut9k8loLnwmF9og98V8+n9r9aF8LUQSNGEmsLNfc0uWtWpOfe1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=mips.com;dkim=pass header.d=mips.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbfHS0Lpl+FEBr59jEJrBwRm/eISZeE50hRkaeS1KLw=;
 b=YoLng8gtCzX+3xUkNBUa2Q8fv9ntilSv3qQa3/GF1StjZBRPP1vOmRQYq7IOSSdeYXCBAklDLTsAVGtX5l9YnPjY/VtJtG/WGQwIf6yC4lLxKPX8rfkyNnjaN1n/UhnezLaIXrHOXebhmQdHyiJF6N0SiG9maAf+D3XpaM5b7dU=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.172.60.12) by
 MWHPR2201MB1501.namprd22.prod.outlook.com (10.174.170.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 26 Jul 2019 05:15:36 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::49d3:37f8:217:c83]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::49d3:37f8:217:c83%6]) with mapi id 15.20.2094.017; Fri, 26 Jul 2019
 05:15:36 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v7 19/25] mips: Add support for generic vDSO
Thread-Topic: [PATCH v7 19/25] mips: Add support for generic vDSO
Thread-Index: AQHVKBdBT62A9PHS5kqstEWJZIpgrqbckh8A
Date:   Fri, 26 Jul 2019 05:15:35 +0000
Message-ID: <MWHPR2201MB1277C33D971A9C8945812CFCC1C00@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190621095252.32307-20-vincenzo.frascino@arm.com>
In-Reply-To: <20190621095252.32307-20-vincenzo.frascino@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::33) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:18::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:646:8a00:9810:5cfa:8da3:1021:be72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eefa4eab-75d8-4b8c-bd7a-08d711884a41
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR2201MB1501;
x-ms-traffictypediagnostic: MWHPR2201MB1501:
x-microsoft-antispam-prvs: <MWHPR2201MB1501BC9787485B9263612973C1C00@MWHPR2201MB1501.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(136003)(39850400004)(366004)(189003)(199004)(66946007)(446003)(14454004)(66476007)(66556008)(64756008)(66446008)(74316002)(9686003)(68736007)(55016002)(7416002)(478600001)(99286004)(6916009)(4744005)(25786009)(316002)(5660300002)(6246003)(71190400001)(71200400001)(4326008)(6116002)(53936002)(476003)(8676002)(44832011)(11346002)(81156014)(81166006)(54906003)(486006)(7736002)(8936002)(2906002)(6506007)(256004)(6436002)(229853002)(305945005)(102836004)(186003)(386003)(52536014)(42882007)(46003)(33656002)(52116002)(7696005)(76176011)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1501;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p7WzZhWK0m+oI/PbWDH1Kk4p+6DgFHYBhhiaZ8Tm4+z5Klb1oa0KJZiCAIq1ELD4vaRObLFe5YmbYTojMYhGNI4MCE7QGjXoYmJFJIj2xA3p9FmI/WciWsIlo/E93iWSdpjzo5SvgUylnAe+H4Uq2egV6cfohZvROrcR6piJrWYfxFfJm0QMhDkON/WWuf0+mH5AO3ic3rjJAkwkLtFRac/jGsneh9MdkDeGHHAceo17Rx5qDYLU2SJn5ok/5gzCHVtpFRawvlFgVe+j1HVr2a7CpEMEIHgPIp3YBUA8sPB5whkbMElxdDSPnqF7WF09roI/ho0f6UAAX2hyvx/4Wu02fyiYHZ7SLlZ2LgFnUap8bwXMVFBBtbsr+M4yjRzMb2IlWmTwtKXGvZbov3KemHtaGK+w9DzGqja/NdYtjD0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eefa4eab-75d8-4b8c-bd7a-08d711884a41
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 05:15:35.8674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pburton@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1501
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello,

Vincenzo Frascino wrote:
> The mips vDSO library requires some adaptations to take advantage of the
> newly introduced generic vDSO library.
>=20
> Introduce the following changes:
> - Modification of vdso.c to be compliant with the common vdso datapage
> - Use of lib/vdso for gettimeofday
>=20
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
