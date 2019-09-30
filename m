Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD95C2702
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2019 22:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbfI3UoR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Sep 2019 16:44:17 -0400
Received: from mail-eopbgr1300137.outbound.protection.outlook.com ([40.107.130.137]:5032
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729158AbfI3UoQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Sep 2019 16:44:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/CtkMee/6Rj3Hcony3w6FFUBfiTPWnfkrRwRte+LzqBLXwiCdfIter663Je1a/OgUMoADR/m7rzJpKeZ4gU+FTtZgzjK0Rw7bAn57MvD+jYtdKv5kZYDJS3mPu0FByBG6mz4rFvMVDCGY1wiF+GJFHtpe47l/tkVZ32uq17E4ZdYUFCMPMPnjB3HctB9IOuXF7e0XggyirAeX8Ak6IrZFyB6753/WwQxUxJ/iPxJ7s25bZLpB/pWBXp5/Jsvwiw99sDGRMx4gxrbnaxmOChmtB40lYoFSEkHYPvpkR5BicfVBbt0nJkgKJvA3ax2Qc6rReFEDuR9bMlW1E6wYe+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7TT+kyzC8pC5j2sJkhcpA9ZFEYCfHh0UaNuv91qNf4=;
 b=JLzCdqORpfLt21o1/zvptkgbxABHSCbtKW4kb2ag7Nx9CTRANbk6qd0umvYbylXAqMm2rSsyv7ay6AN1hG4SENhCiqzBBd12d/k0lGAUDZ9AWP/ZcXNPu7kWNKYOa690Gxmz/E8wdcrhWyQgxolZNErOEhqvANIYf1Dj30gs3pELBM8FceQvFBjdriI0c10tQFs6WObHOfMEY4inWdud9huGyuhGwhQtQRUZVWRSSK2TOYAMbXf8Mgya4zxDXl1tojpFv7ExZ5M+joX1r+ErRES/zYyqjimBJVFxP1CA5y4Bym22ssCMQuUdwBloIAYnFyRGXPIwqOs+CdsHLcdpVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7TT+kyzC8pC5j2sJkhcpA9ZFEYCfHh0UaNuv91qNf4=;
 b=SfDxHizdWUflTqzyYVg6yoVqEFsZMo43YFbP5konigU5RWQVN6UxIXDgzizguKEJ+krZMmt/9rj0SVPMJKNa5FBTeFm2pHysaYkIBtSvOokv/5xqiZmJXOFwdS6R0i47aZgRSZXf59K/6+2JWA96VtWLW15LYdzQdRpHb70Nk4I=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0187.APCP153.PROD.OUTLOOK.COM (10.170.188.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.3; Mon, 30 Sep 2019 18:49:33 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2327.009; Mon, 30 Sep 2019
 18:49:33 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
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
Subject: RE: [PATCH v5 1/3] x86/hyper-v: Suspend/resume the hypercall page for
 hibernation
Thread-Topic: [PATCH v5 1/3] x86/hyper-v: Suspend/resume the hypercall page
 for hibernation
Thread-Index: AQHVdFddc0vkIIkGmEOkqRoIHJJIFqc/CHEAgAA0RQCABVkvEA==
Date:   Mon, 30 Sep 2019 18:49:33 +0000
Message-ID: <PU1P153MB0169804D32B95E0A145CD0B9BF820@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1567723581-29088-1-git-send-email-decui@microsoft.com>
 <1567723581-29088-2-git-send-email-decui@microsoft.com>
 <87ef0372wv.fsf@vitty.brq.redhat.com>
 <PU1P153MB01695A159E9843B4E1EC13AEBF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <877e5u6re3.fsf@vitty.brq.redhat.com>
In-Reply-To: <877e5u6re3.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-30T18:49:30.9074667Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d3e7ddcd-9ddb-4e60-9369-b0af671a3cae;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:d492:e91a:5e0:dd92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 178f43f5-62cb-430c-c11f-08d745d6ef61
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0187:|PU1P153MB0187:|PU1P153MB0187:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0187C0D3EE6EC3B4AB2932DDBF820@PU1P153MB0187.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(189003)(199004)(316002)(102836004)(476003)(486006)(46003)(7696005)(186003)(6436002)(9686003)(10290500003)(14454004)(76176011)(55016002)(53546011)(6116002)(99286004)(8990500004)(10090500001)(5660300002)(52536014)(22452003)(8936002)(6506007)(6916009)(7416002)(8676002)(71190400001)(81156014)(81166006)(71200400001)(446003)(11346002)(54906003)(86362001)(2906002)(4744005)(256004)(66476007)(66556008)(64756008)(478600001)(33656002)(14444005)(229853002)(107886003)(25786009)(76116006)(66946007)(6246003)(74316002)(305945005)(7736002)(66446008)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0187;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P1cTnrr60EXWZdug3y36Nrug6T/QeGlYVDK/09Tyj1Pz6dQs+2kk9VjpW5MhnnbjLZGrLRtuuHwlSilC6f5/3XxomitwKJ9MLUfROwXjZeOMSZxZw0M74DoaUe1t1f0/0BydJ0kn7PcAGOBiIO3y+lOc8mAsS9HqQh9NW2XIQawP5vQwFkg6RupOSNgXS28Axr+jjJsofmNiYnV8I1Z9CgMGsM5F1ZtKCEYiklBs7+VycGm9fXMSEFv1/K9IKvs+4C8cmb+eGFEtZjtHX3Mzq0jYWjJvktg7nLZxhAuvHOEvZwQT0D6dfmL6MHrm02AuxjVL5KEaJCycULYdhlWXVT60YP16dwm02NGcaQ8F1c8PlGHLue3siUJ5Nf6Oy0QTCB0piR/mQIVMzjMaxFHb18VcHhucpOPoiNxxY3RBkbE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178f43f5-62cb-430c-c11f-08d745d6ef61
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 18:49:33.3935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +J46sI8EARYq6eRD+9qksQ7dIPIoEibkNwyiB9dhCePxY39U+nKuWIbPuBJWDp7cuwvDehHE9lwoDcy1OockZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0187
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Sent: Friday, September 27, 2019 2:05 AM
> To: Dexuan Cui <decui@microsoft.com>
>=20
> Dexuan Cui <decui@microsoft.com> writes:
> ...
> > So, I'm pretty sure no IPI can happen between hv_suspend() and
> hv_resume().
> > self-IPI is not supposed to happen either, since interrupts are disable=
d.
> >
> > IMO TLB flush should not be an issue either, unless the kernel changes =
page
> > tables between hv_suspend() and hv_resume(), which is not the case as I
> > checked the related code, but it looks in theory that might happen, say=
, in
> > the future, so if you insist we should save the variable "hv_hypercall_=
pg"
> > to a temporary variable and set the "hv_hypercall_pg" to NULL before we
> > disable the hypercall page
>=20
> Let's do it as a future proof so we can keep relying on !hv_hypercall_pg
> everywhere we need. No need to change this patch IMO, a follow-up would
> do.
> Vitaly

Now I think it would be better to do it in this patch. :-)
I'll post a v6 to follow your suggestion.

Thanks,
-- Dexuan
