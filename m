Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D316B55592
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2019 19:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbfFYRLY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jun 2019 13:11:24 -0400
Received: from mail-eopbgr760110.outbound.protection.outlook.com ([40.107.76.110]:34473
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728855AbfFYRLY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Jun 2019 13:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+iUoYUFY0FkKIr+aKKX1jj9cXKpVu1fn63ON3UHAEY=;
 b=lBMHHVH3zhdbqJAGoPOuBOWXtjpbsAM2AtNgcw1Ls1vuMB+itvPvRowhA6MKDew7HPy3Als6znt5QAroJj5zxNb8Nn/igbC1XqYCbooMmforgOZZ8tN4L6grquNV4eoe75SdWvEEd/jZDVOSPsW/apy596ryIYro/f2tBbBh6Mc=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.172.60.12) by
 MWHPR2201MB1118.namprd22.prod.outlook.com (10.174.169.156) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 17:11:20 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::6975:b632:c85b:9e40]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::6975:b632:c85b:9e40%2]) with mapi id 15.20.2008.017; Tue, 25 Jun 2019
 17:11:20 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@openvz.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v7 00/25] Unify vDSOs across more architectures
Thread-Topic: [PATCH v7 00/25] Unify vDSOs across more architectures
Thread-Index: AQHVKBcjN6FJrtEBy0+FRUrPEWueWKap+PYAgAEv3ICAAEzTgIABLC4A
Date:   Tue, 25 Jun 2019 17:11:20 +0000
Message-ID: <20190625171118.wznk5nva3h3jetky@pburton-laptop>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
 <20190624184157.mu6n74a7qqa4z5z5@pburton-laptop>
 <3ae7f595-0a15-0584-198e-b32fe3e3ea57@arm.com>
In-Reply-To: <3ae7f595-0a15-0584-198e-b32fe3e3ea57@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0070.prod.exchangelabs.com (2603:10b6:a03:94::47)
 To MWHPR2201MB1277.namprd22.prod.outlook.com (2603:10b6:301:18::12)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.94.197.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b809b5de-4021-4a76-8945-08d6f9902426
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR2201MB1118;
x-ms-traffictypediagnostic: MWHPR2201MB1118:
x-microsoft-antispam-prvs: <MWHPR2201MB1118A9595B9D7AA19A7BA973C1E30@MWHPR2201MB1118.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(396003)(39840400004)(346002)(376002)(136003)(51914003)(199004)(189003)(229853002)(99286004)(4744005)(6486002)(186003)(5660300002)(26005)(71200400001)(6246003)(71190400001)(42882007)(1076003)(5024004)(58126008)(446003)(102836004)(2906002)(256004)(25786009)(54906003)(11346002)(66446008)(66556008)(64756008)(6506007)(386003)(66476007)(73956011)(66946007)(53936002)(316002)(476003)(7736002)(8936002)(44832011)(33716001)(81166006)(52116002)(68736007)(14454004)(305945005)(7416002)(6436002)(9686003)(6512007)(8676002)(6116002)(4326008)(3846002)(81156014)(66066001)(76176011)(6916009)(486006)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1118;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zcyNfYbyNhwspxVfGJ1htlI8y5R6VxxQcCVOyO09/n/9Bwwxi02qlNQ6NDcd4p/wsXmRMzHqvW4I3SzmIwVxTbMI1qwCpmcrNlrbbzqYQfsW0cKNlnzojpp+N13L2JVb10ZYle/j47RRHwDruBbt5N4h1dDgDJz/VolQH3Y74ZlreJFkUuFluHNAefENxQVQFqiqry9YDoi6Tnp4K2h6W5W6krnypP2RKTN7a5TDIEOrujZWCVqUvZx+omSOUx8Vi2ot0zxjoW5pXDc+2kad6aSjkXJBFdATyOMfy5PLPWetWhVhe02uarErHTNxDiUpkhUhEFPL5rv1kRfTaDXlAxGJ8cW36E1RZEa26QjEx0SmxoUitAgRCImd/QE8ca7pUeIsXku+M7BL/vZ3aDvwLTebP/JWQZ6WFIUgiXbUrrM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FD39DF5A3ADB314EAA7DACEAAC30B7A9@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b809b5de-4021-4a76-8945-08d6f9902426
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 17:11:20.2050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pburton@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1118
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Vincenzo,

On Tue, Jun 25, 2019 at 12:16:55AM +0100, Vincenzo Frascino wrote:
> In the end I concluded that all the errors seen here depend on the fact t=
hat I
> tested my vdso implementation on MIPS32el only (as stated in the cover le=
tter)
> and that when I tried to compile a 32BIT binary on a 64BIT configuration =
I did
> it wrongly for two reasons, for N32 and O32 binaries:
>  - we need to undefine CONFIG_64BIT and define CONFIG_32BIT
>  - we need to define CONFIG_GENERIC_ATOMIC64
>=20
> I have a fix for this (patch in attachment), but I do not have the hardwa=
re to
> test it. If you could provide some feedback would be appreciated (really =
want to
> see MIPS merged with the other archs in 5.3 :) ).

Thanks for the quick turnaround on your patch!

I'm certainly willing to test it, but in a few hours I'll be spending
the bulk of a day on airplanes[1] so it might take a few days until I
get to it.

Thanks,
    Paul

[1] ...and travel isn't the hackathon it used to be with my 9 month old
    son around :)
