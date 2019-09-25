Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E88EBE874
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2019 00:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfIYWtk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Sep 2019 18:49:40 -0400
Received: from mail-eopbgr1320130.outbound.protection.outlook.com ([40.107.132.130]:22541
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729604AbfIYWtk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 25 Sep 2019 18:49:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEdk/oQONk6bv73qNqg/Bh/TJB3Vtyt+nFdFo5t3tPq9tqxCX8iqxNG6YB92OijW3q0Z2UhxRDdcJiueA2NIZF2Qls5TyUcY9UZGcaNEuuwpclk1ne4s/VK0tpwTDYFDObXVX6+3m9Uph6Tav9YMXCOeaSs+MFaoHxvb0I2B5OLYQU5tRlMsAOeFGFlHkQKEIHIjJk6Xu588RlH5CsTvaJlY+H+3xvqGLslowerVO4sI2n0HkVzTQEA/ZT7wPD23XsOriuwm5UbOy8UVCJxmtv+7xgQhQz0XkKUC83aGkOAbr+zukrsGu/d/YgodLZFoSdGOn9mB0cZZEvls4ke3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/5Hot15RqpbN++rLgjrxKMVjJYK8CfoIl0+eZL8bG0=;
 b=ACzSc1rTLkCYRc+ZcOD3fomT0bqfss/ez2VHxGeW7ItgSPmx8uUw7t0N28hmNPmIYY9Sz06TztnAA7y1AunA1+i1aHYka5WjqF+sBC8bZNHCaBIS64bjWwXFhwpf2vD6Lg/RZzJXhAe+pUkvs9IkHr8WySdPTS+yYSO0pi6aXxJr928Sk+Z8sYoa+ra1mUh+fnxwPK1yW4tKFc0HKzuVPsKr+xyLZj9EJAZ5hSA9ZLTeHrEkC4Xnh7I55Z+AEPKj3TBwWD9jFr4LtdQvhfehQZFJXEG7qqcCiX11Dm1pauCG6WQZQ2noHgSG8fPPfRZ1FyfJVESHOCYiNFFJXNBC6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/5Hot15RqpbN++rLgjrxKMVjJYK8CfoIl0+eZL8bG0=;
 b=egd20KHORIAxvH/34gZ05dJ553g4Jr8dqgCh40uV0wOwHwOjI+IluOe6DgxtQqoyEepQ8tCrxHNtD7WlWxCq8PaDB3jkZmtXWOniCx1Gd8J55mgVWjAjvjNl8+L2OzNwBjqvvms1SHQNZ7vMW5EzT9VoN5oRIoPDS1xsIAbQhik=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0137.APCP153.PROD.OUTLOOK.COM (10.170.188.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.3; Wed, 25 Sep 2019 22:49:35 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2327.004; Wed, 25 Sep 2019
 22:49:35 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v5 0/3] Enhance Hyper-V for hibernation
Thread-Topic: [PATCH v5 0/3] Enhance Hyper-V for hibernation
Thread-Index: AQHVZDvWiJN7KE4mZkeEB0PYga91O6c9Gb9w
Date:   Wed, 25 Sep 2019 22:49:35 +0000
Message-ID: <PU1P153MB01692C8EC435F7F108564BAEBF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1567723581-29088-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1567723581-29088-1-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-25T22:49:32.7769187Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5220183a-209f-4c76-a7f5-88915c722ca3;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:35f9:636:b84a:df21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 792fe893-6aed-498f-4344-08d7420aa373
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0137:|PU1P153MB0137:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <PU1P153MB013792FCBD8C2EBBD4B251CEBF870@PU1P153MB0137.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(189003)(199004)(1511001)(10290500003)(110136005)(478600001)(6636002)(66476007)(66556008)(64756008)(66446008)(66946007)(76116006)(2501003)(55016002)(99286004)(22452003)(10090500001)(316002)(256004)(6306002)(86362001)(14444005)(9686003)(8990500004)(2201001)(71200400001)(71190400001)(33656002)(5660300002)(52536014)(6246003)(2906002)(966005)(6116002)(4326008)(14454004)(102836004)(6436002)(186003)(305945005)(6506007)(46003)(7416002)(7736002)(229853002)(476003)(7696005)(76176011)(486006)(25786009)(81156014)(8676002)(11346002)(8936002)(81166006)(74316002)(446003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0137;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MbljAvkGnmlJYBADJuNlLmBQ4V4ZaTCx+lRcZlJpDtxBWaDYCk/nsV4o0lc3MbanfKtXtgnbhneI3VwQyUe9003sJLjKohxLRzoWSKM6Gq/WmcerCHGTTDQaJAOF87CzxJeAcqoIVcQ27n/cz+uvTxex0bXM1/PpHvklOX5Aq5J2OWaOEOENHPIYXVLAJSZ7s2lj610iihr5OhLDbOWi9Ohr77ZkrgWboB1HsQX0be2kPrmhYxHuFCVPHVdAjzKEg/C2900ARUd5pEJ2WDrsKbs/nwe6sMrdHoP07fYkGXq1H1ebKS28/bCCmcYrHAy7ARGpDY8KLfXSdJ1N+Eb7ia4/KJF0WBmsys2jB7ILg9SxpwZ7Ytcv+0p80a75zz5RMvCDM0gmuCbnmuMxnTN6oCmi3ZbaA9+d/ssorV1glzo+R4q/VQ2OnmC4QdLs7TSMN2SqjJ3Upvwl2wH3FepUsQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792fe893-6aed-498f-4344-08d7420aa373
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 22:49:35.1173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z1Tw3C8+9yPTLOFw5rF6AUrDFfYZvoWoEc+RQcb6GkSXF1xm6+9z9iUDAt3vSHYf6bBLPLZy752h/2PQjJ8kCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0137
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Dexuan Cui <decui@microsoft.com>
> Sent: Thursday, September 5, 2019 3:47 PM
>=20
> This patchset (consisting of 3 patches) was part of the v4 patchset (cons=
isting
> of 12 patches): https://lkml.org/lkml/2019/9/2/894
>=20
> I realized these 3 patches must go through the tip.git tree, because I ha=
ve
> to rebase 2 of the 3 patches due to recent changes from others in the tip
> tree.
>=20
> All the 3 patches are now rebased to the tip tree's timers/core branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=3Dtime=
rs/core
> , and all the 3 patches have Michael Kelley's Signed-off-by's.
>=20
> Please review.
>=20
> Thanks!
> Dexuan
>=20
> Dexuan Cui (3):
>   x86/hyper-v: Suspend/resume the hypercall page for hibernation
>   x86/hyper-v: Implement hv_is_hibernation_supported()
>   clocksource/drivers: Suspend/resume Hyper-V clocksource for
>     hibernation
>=20
>  arch/x86/hyperv/hv_init.c          | 40
> ++++++++++++++++++++++++++++++++++++++
>  drivers/clocksource/hyperv_timer.c | 25 ++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h     |  2 ++
>  3 files changed, 67 insertions(+)

Hi tglx and all,
Can you please take a look at this patchset (3 patches in total)?

IMO it's better for the 3 patches to go through the tip.git tree, but if yo=
u
(the x86 maintainers) have no objection, the patches can also go through
Saha Levin's Hyper-V tree, because the dependent patches have landed
in Linus's tree now.

Thanks,
-- Dexuan
