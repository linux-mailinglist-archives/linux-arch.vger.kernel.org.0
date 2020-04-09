Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD201A3CBA
	for <lists+linux-arch@lfdr.de>; Fri, 10 Apr 2020 01:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgDIXGQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Apr 2020 19:06:16 -0400
Received: from mail-eopbgr690105.outbound.protection.outlook.com ([40.107.69.105]:53634
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726726AbgDIXGQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Apr 2020 19:06:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yc4+e0AmbV7C2FA+pDiD5lzaZSH3lLN7Ac8vzMFP1bLrLs/iwmpsKL0Z2xf0gUu0RjZbLC4JOrSIk3u3fNd6lEtNyPdLDYOqG4ZiOrcfdaynC9pBofCAwNbqZzYtT25+KU8+HOoww+IAmsoeQTtdmKoeU4cLnbNrcf1V6TdrRxUnrODmW7ZSNkagOGJUHKaAFTRlik72mUuq87/gvhVFsBkul+aNA6dz5BRI01ZEmQ4eaLWwCeMANcuremUAr9tIGWco61IpfgHTPVRi1Is3BdgHI8f4PBz3SlK5QfPDfVO4HGYGnU8UH3EFiXqx6tr7Zj5mGylHhl9wQRrkvqpPaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5j/9umVd/z0xBmibV/YAwAXMNhLm0tGKALPUd2lcqDg=;
 b=kzK/MaHpAx6fAb54snlQXPZnqBNz3yLpTzXVcU+dC0AWtyl+6m2pNN8AY3EKpfBeQk21A5fDXAQ10ySHp49Dku263/9Iar4AgDIIB/EFXFvd/Q+ERvQW36fa4pEL5iGDSvLS0zDgXtotabmOK1MXFXvNphW0NGiIpqPjMO+Ai+Mui9AnAXLB9Lt5mAG2DxY2OIrHej12vdyNH9/Quyfrm0Hb/XF9P+SfJOdHKz8nWQPocH5jtIjOcI900aXA8+of3t7MWDODJLD7j7jSYcr319dzK1dVnGje9V2DsytlEvHZwbQAE6M1YQEsJ9RL6KMxFUtTMnA6lEBBinCWuuDuFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5j/9umVd/z0xBmibV/YAwAXMNhLm0tGKALPUd2lcqDg=;
 b=cichUksibRSa7BbYlK5iWwnukaAg8634EvtdmOf9yPfGzKS3KxNjJkX3ZCCFXbzJJ+2yp7ytsQcnAEGw0wiz3rOz//SlEqkJf6xSZ2jSsuUolXOvInMUzSKbW43LndLiTXpUrXH57+KRJnU3tPORwab73YXbGev0ru7Fy1gV6yw=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1081.namprd21.prod.outlook.com (2603:10b6:302:a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.4; Thu, 9 Apr
 2020 23:06:13 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2900.012; Thu, 9 Apr 2020
 23:06:13 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
CC:     "ltykernel@gmail.com" <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH V4 6/6] x86/Hyper-V: Report crash data in die() when
 panic_on_oops is set
Thread-Topic: [PATCH V4 6/6] x86/Hyper-V: Report crash data in die() when
 panic_on_oops is set
Thread-Index: AQHWDCuMQ3aW2IzR1UuBUYCKtr2r9ahvrWpQgAFVhACAAGrnEA==
Date:   Thu, 9 Apr 2020 23:06:13 +0000
Message-ID: <MW2PR2101MB10525BA673D7FA81073B9F65D7C10@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
 <20200406155331.2105-7-Tianyu.Lan@microsoft.com>
 <MW2PR2101MB10524CB8CBF3FE49C2EDAA8DD7C00@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <20200409164054.72es2ykmbef3jbui@debian>
In-Reply-To: <20200409164054.72es2ykmbef3jbui@debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-09T23:06:11.4501117Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8d93f19e-e439-4fb9-9707-8699e6651ad2;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 280e18eb-ca32-4117-f1f2-08d7dcda99ba
x-ms-traffictypediagnostic: MW2PR2101MB1081:|MW2PR2101MB1081:|MW2PR2101MB1081:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1081CF30342B6E870DE94CC2D7C10@MW2PR2101MB1081.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(71200400001)(7696005)(76116006)(8990500004)(8936002)(66476007)(66946007)(81166007)(64756008)(10290500003)(6506007)(186003)(2906002)(86362001)(66446008)(66556008)(478600001)(82950400001)(81156014)(33656002)(26005)(316002)(54906003)(9686003)(6916009)(7416002)(55016002)(52536014)(5660300002)(8676002)(4326008)(82960400001);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2zEAto6yc8+1iZk7u70W+HLMfCSuqPZMdf6hZeF/3n4yWof4i/FIBulcYI2ymC/1qYvaak0RkpAldB/vQuMh0tcppXDBU8MyKHnTv2+tXXArh8OJUmk26RUTdd/DUQhr0/Er8zbIAngXwPKtX9wUrhp1XWfcRKq68IjtOykkc9jt8jRK9fFw3wHPLGzYgR9H1Wfm/g9RNrY6QSBeQKwmPSR3PPpO6+zv7dA/qxty/cx9VAiaS5Y6bL57414PMtgEDoGMkBGSM95L3fDbGvZ+F3yyF0ndl1G0Vl1IuepioAFJzsd6dguP7X/uuVobRvdHLviZ63AHKvNQq6YI/vWQoSUThb3vwuIdmsuB9tQaTWaz1dEfn8LLArECVAkkGfhr4EeQAZIe8Sl6p7l0YlOJIQJ1NThY6ZgpE6c2gCox3DZly3MpLyCZm8jED7PMxvrZ
x-ms-exchange-antispam-messagedata: s9cMOM0W8mSutdnc0q1KkNipR73lYFqEM9etFNeuO84Ay/Zsz7ucU0FTtymw5z7Y4GxwoeV2T4BfbuyI9/acEqVt+0du9pZ0lvVDxh6EePywma1e3cMPcsIR7icHXNAg5MR17g04IrtWUKQtnSUiUQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280e18eb-ca32-4117-f1f2-08d7dcda99ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 23:06:13.4432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OWkxrzJsIv2X3thJxVlF73VxoFidraATWDGed/MnC0RxMgjdQQ0H/FaJznm+Lc2OXTCi3LI3aGssGnmD/k8aiRMELwvanzXm8euzxFtBHtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1081
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org>  Sent: Thursday, April 9, 2020 9:41 AM
>=20
> On Wed, Apr 08, 2020 at 08:19:47PM +0000, Michael Kelley wrote:
> > From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Monday, April 6, 2020=
 8:54 AM
> > >
> > > When oops happens with panic_on_oops unset, the oops
> > > thread is killed by die() and system continues to run.
> > > In such case, guest should not report crash register
> > > data to host since system still runs. Check panic_on_oops
> > > and return directly in hyperv_report_panic() when the function
> > > is called in the die() and panic_on_oops is unset. Fix it.
> > >
> > > Fixes: 7ed4325a44ea ("Drivers: hv: vmbus: Make panic reporting to be =
more useful")
> > > Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> > > ---
> > > Change since v3:
> > > 	- Fix compile error.
> > >         - Add fix commit in the change log
> > > ---
> > >  arch/x86/hyperv/hv_init.c      | 6 +++++-
> > >  drivers/hv/vmbus_drv.c         | 5 +++--
> > >  include/asm-generic/mshyperv.h | 2 +-
> > >  3 files changed, 9 insertions(+), 4 deletions(-)
> >
> > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>=20
> It seems to me only the last patch is new, others are already in my
> tree, so I only apply the last one.
>=20
> Let me know if my understanding is wrong.
>=20

Tianyu added "Fixes:" tags to some of the other patches in
the series.  It appears the version you had already queued doesn't
have those "Fixes:" tags.

Michael
