Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EED247CC15
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2019 20:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfGaSht (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Jul 2019 14:37:49 -0400
Received: from mail-eopbgr750099.outbound.protection.outlook.com ([40.107.75.99]:26831
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726944AbfGaSht (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Jul 2019 14:37:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeY/NBVCZPYFQRjW8SIEZuOK499Pn6Tn10L324BhlOZDgmPpAvP7k1l6zYPVBmqyRQ2zA3Fp3EAQ6soF3kYUmGixqeOvvr+vJOeGHxKNipt35UFTe8lrVZX6NBwoS52J2IR8cw+AhONNISqUK/mpNlhUZQ+vBQU2RGKBSW5DfoZN/CBziYFMV7LgfZ2ybZpvk9NkepH4+oDOquh0tZsYavtYSsNRAWkpn+ZqT3rqJGOdUKXNkA8L+douy9QVyHgTmne5J8LZynj9SJg2dKRkev1qhfSQBDTNVJ4ZWil78suPb4L7BEP3S772xr3I9cLF+4A2FukawkW9B0UY9gJwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSvIk88Nk5x2PlZt83UkZwDGUxm5wUayb5vMrWgJxO4=;
 b=HlyBhSooApp/fO5RDMj3Y1E0Llc6Ax4Wzj/jIJvzaac2D8Fpjnw943aPkiTNHq+KSFqd+qn2pq2l0NjNKjz0zeU1W0KmBAJdYbEqfyI2/WVCheOiXmuK/Y3nx05eWMd6TnCzSeVswQ/MiIXtBMJcV/XqCxj53pM/Qr1NVNlwPbfeIOB39AkynSM2NF3ltcsuxBDyPnt7waT+foW4qyjFS8Ugjg851FIDmThzn8gVRCCoxUrms65Kb2tnZjOaN43t/6MqsNOqln9AXJ5XmZkXnAabVk5RoVHkSOoypYaGUwJSxq8xivqbiU+MAZB3c43DACWqHQzo50pZoujnZT1Hkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=mips.com;dkim=pass header.d=mips.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSvIk88Nk5x2PlZt83UkZwDGUxm5wUayb5vMrWgJxO4=;
 b=cVrNnf7VinHDbsz9oksg3xAbr/amsZzKVX+KZJRi2ma+aFip3tfzqlIOlFPvxI0rP+3hBMzf5q9vHbYPLuImgIaYqIu5UrD05emFcdxSBBnT1O4z6IHRUCjy19p+ZMarm5Jc/mhD8puIFoV2SPlp9/DuDajtMYEMllzcy4BxxfA=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.214.23) by
 CY4PR2201MB1750.namprd22.prod.outlook.com (10.165.89.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 18:37:46 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::c99b:131e:aaf3:bd81]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::c99b:131e:aaf3:bd81%4]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 18:37:46 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Firoz Khan <firoz.khan@linaro.org>
CC:     Paul Burton <pburton@wavecomp.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>,
        "firoz.khan@linaro.org" <firoz.khan@linaro.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 1/2] mips: remove nargs from __SYSCALL
Thread-Topic: [PATCH 1/2] mips: remove nargs from __SYSCALL
Thread-Index: AQHUoqtkUF31nts6yU+Wl0WAgPekgKbmWL4A
Date:   Wed, 31 Jul 2019 18:37:45 +0000
Message-ID: <CY4PR2201MB12725431D0D757F50CBDC1EBC1DF0@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <1546440978-19569-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1546440978-19569-2-git-send-email-firoz.khan@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR21CA0003.namprd21.prod.outlook.com
 (2603:10b6:a03:114::13) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:6e::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.94.197.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 912ebe37-2159-4a69-e113-08d715e62e12
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR2201MB1750;
x-ms-traffictypediagnostic: CY4PR2201MB1750:
x-microsoft-antispam-prvs: <CY4PR2201MB17501F68E92EA3300E273357C1DF0@CY4PR2201MB1750.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39850400004)(189003)(199004)(66066001)(4326008)(486006)(229853002)(446003)(476003)(44832011)(305945005)(11346002)(71200400001)(7416002)(71190400001)(102836004)(99286004)(52536014)(25786009)(6436002)(7736002)(6506007)(52116002)(7696005)(33656002)(76176011)(186003)(74316002)(2906002)(8676002)(26005)(386003)(6916009)(68736007)(42882007)(66446008)(66556008)(6246003)(64756008)(66476007)(66946007)(53936002)(9686003)(6116002)(4744005)(3846002)(14454004)(55016002)(54906003)(478600001)(256004)(316002)(5660300002)(81166006)(81156014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1750;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sjOpyFHOrcsxrIw/Epq7zOOpW/PFiHbwGPNelwUg1aQixXoUWexRboQDCs4hLYOiZYRR3wTro3WqU8woBGtizV8X31B7c6ZYJFJZ4Ibt525rXQvhr15UHN+g5YA1Qx9YblaqiyJXegSLXRbYbYb6inVpKhKFS9SxQqg9AKMkuK2Zia4lLecXUEWZxHKxZYrk8D/3LCfI+mEsKwHS9hOYRtpNCjXTJQbFejvkOxk8yC7Gr/gPFzqQNJZU1dluYSJVCNGfM32m7H3L3XnEmYDSD9xHuv7V39eYaaB3xjIVDeO0Ylk8N7ugU2rWzf7oNSgoA1FWtOBg3J6oVU87rbwuu38UyABJeO8F8Je3QOhozvUwHvH+BLUcQRl3Y2TYr0nuYD/kWnWOFFDuJ9GgMhPqP6XarBAKF2G6JPDixvfwX5A=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912ebe37-2159-4a69-e113-08d715e62e12
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 18:37:45.8034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pburton@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1750
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello,

Firoz Khan wrote:
> The __SYSCALL macro's arguments are system call number,
> system call entry name and number of arguments for the
> system call.
>=20
> Argument- nargs in __SYSCALL(nr, entry, nargs) is neither
> calculated nor used anywhere. So it would be better to
> keep the implementaion as  __SYSCALL(nr, entry). This will
> unifies the implementation with some other architetures
> too.
>=20
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
