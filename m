Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8940414D4E9
	for <lists+linux-arch@lfdr.de>; Thu, 30 Jan 2020 02:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgA3BCS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jan 2020 20:02:18 -0500
Received: from mail-eopbgr1320123.outbound.protection.outlook.com ([40.107.132.123]:16224
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726671AbgA3BCS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Jan 2020 20:02:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8H7lKQNeG1t2AG2SjgDj8QHf0lRJ2c/31ft6W8YgZmXl5VVxw9ZMmPachbxrqChMw+1dWsZeDI/il0UohIFpHmXj+osQRQHeBhVJVFSOsBApdAKpgcT3JHjsIPLixmETavyyKcUorhCGAFtxiQZw6hc0EUDxFkdb4sDpjHd/srNuCBoGDLxWyGRYlhLCNY6jDqyXBq82Vfb6J4GfpxTd4bDIpXn2HhdL2hAMg4k9NVkmpLEmsAWDxNzktCZFZZodo8GFTYl82sC2ESYCQuxPqCwxOV6Zds6GGpCw441UYNuqV7hGrrosTNzG7nJ4UCPwSnazjJhQOgOSnO9kgkvpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bx0If3Uk2eEktwdcZj/qm4O6VnhF2p5Fjdsq7fIogSM=;
 b=LJSsLl/PFWdLmE/cGs5bSKaUJYLSiZc6E0WPLEeExL/NWJJLMs/vJJxmihzLJWkcfQ7mtCDE8gCWk+7xt5HWHMcAJoDYlfTFWIHM9NLh4xtqY74ZVpPqLvZUFU7fEJmWpIw18J+0MEAbzXk8EyHMe629xYjJYH0O9G69BtzZUONv42eWWOSIT3LlhMJ5hEnN9dWu+ZXH6vsZkDK2F/dlEPK6CcNAElviOx8e5rbuPYl/XyFH4v2W38SThO1HDHr1zNMqjhemJmbC6Gx76TR0cAMPowWMTYI+M++hRWXXbSAPNs/WUpwR4RwB4NrFyNyyUIxGmWfGnZ1W3NSdQfrMZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bx0If3Uk2eEktwdcZj/qm4O6VnhF2p5Fjdsq7fIogSM=;
 b=dD6BX5XgDLhUV9BnqTfh/MJYSwBESrJWOIgvr4EHIwOKiNKPD/k/Y0RZp34l4wvIpJIn0yVSN8P0HfWKz3Ba5GT7ZEi43w6whaR1JakPFRcE+R6wgrThVkOvFZytBOP7ldMx33eHNhau9QOPGTAQXRwd/gDToTB30fe6hMSLFEA=
Received: from PU1P153MB0155.APCP153.PROD.OUTLOOK.COM (10.170.189.11) by
 PU1P153MB0153.APCP153.PROD.OUTLOOK.COM (10.170.188.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.0; Thu, 30 Jan 2020 01:02:07 +0000
Received: from PU1P153MB0155.APCP153.PROD.OUTLOOK.COM
 ([fe80::49a0:b051:e5f0:4c3a]) by PU1P153MB0155.APCP153.PROD.OUTLOOK.COM
 ([fe80::49a0:b051:e5f0:4c3a%7]) with mapi id 15.20.2707.008; Thu, 30 Jan 2020
 01:02:06 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Sasha Levin <sashal@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v6][RESEND] x86/hyperv: Suspend/resume the hypercall page
 for hibernation
Thread-Topic: [PATCH v6][RESEND] x86/hyperv: Suspend/resume the hypercall page
 for hibernation
Thread-Index: AQHVxOKfKplvVmki0EiTTmOHhKt+Nqf6tz7wgAfBDgCAAAs2AA==
Date:   Thu, 30 Jan 2020 01:02:06 +0000
Message-ID: <PU1P153MB01552D8E75E152C3F3FB9C65BF040@PU1P153MB0155.APCP153.PROD.OUTLOOK.COM>
References: <1578350559-130275-1-git-send-email-decui@microsoft.com>
 <HK0P153MB0148ED41CE96B637019DF26ABF090@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
 <20200130000552.GD2896@sasha-vm>
In-Reply-To: <20200130000552.GD2896@sasha-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-30T01:02:02.8003111Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ed8647ab-f4f5-4b45-9f41-e85affc11ce5;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:1191:cedf:8423:18ae]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b87e4584-6100-49e5-cd4f-08d7a52006d3
x-ms-traffictypediagnostic: PU1P153MB0153:|PU1P153MB0153:|PU1P153MB0153:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0153575FC65661A5E3055BC1BF040@PU1P153MB0153.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02981BE340
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(189003)(199004)(7696005)(966005)(316002)(54906003)(9686003)(110136005)(10290500003)(4326008)(66446008)(8676002)(86362001)(478600001)(52536014)(15650500001)(53546011)(33656002)(71200400001)(186003)(55016002)(8936002)(76116006)(8990500004)(2906002)(6506007)(66946007)(66476007)(66556008)(64756008)(81156014)(5660300002)(7416002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0153;H:PU1P153MB0155.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oevTPKhK7hXbPpry0TxxmzGtfrezacO82KsCb5LESBPAGFlxj9T71QlpSeqTNuHok51MIocpXD1cKmLwlWg/lhLSOyjmsubyLtPqeGdAojgNvtRQ4vnKeXIxJpjNBrpPun6bmAedZ0pYw0j0kOBh/nFJgPRWYnRBdBu4fo13mokLKf6KgvzLLqrXRKZwMAFaegi0n7OleS4bLmSrp9bIPG/IzUKJhB7R734o0Wo9oVqhy6uRjoelVdi6WAmLZvtGwGWGE2mUZVzhLz+/wZlh2fXaI2TL+QHUgdlMRp8YQ4IElTF1mSHGF0ICXV9hWJ4hzh+HSozncgtUGF+Kmw12hJGxkoKdMo48JCWPP7jt0ElHTn8NXGLceWEelhOPfR+qZJU6zCqS29zncWs1A0O6N+a6yPewWu00n0wgdd4BGSP0391VJEVdFl79sfi70vbraRcdWCcpmGcSp2nEjNNMhAsdsTAqJjePAy8QzDP+ehGdvac1aLCY//npk9NR8hv0n/029sqJnFyOXMsUNoz5JQ==
x-ms-exchange-antispam-messagedata: C31PZxC9OgOpvi0Q0zvTra0O8Sv/v752czqtgzivE92IEULvobank+MolSBOPI4EL0ZnobyyXEiR5rI9vEMSGSDfTmBCrQH0EZJ0xEl4/x+Ot39g64mFrrrhuYnS29M4nQ24VPlC2hIMZY4iI38ocErYCqdNabMt9uYTbkpYETRsj4S3ueNWDwpSQHRhmDwZcEC8REQsnr9yAJbuJhA46Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87e4584-6100-49e5-cd4f-08d7a52006d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2020 01:02:06.4487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8F++C3wtlXlP4BCUsWT603ZqpMs2qK6GAAqQrvhJnBYPyuRyn+cEWAmbE9DbgVAAVwL+ROBSV3MvIY6Za6IxxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0153
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: linux-hyperv-owner@vger.kernel.org
> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Sasha Levin
> Sent: Wednesday, January 29, 2020 4:06 PM
> To: Dexuan Cui <decui@microsoft.com>
> Cc: arnd@arndb.de; bp@alien8.de; daniel.lezcano@linaro.org; Haiyang Zhang
> <haiyangz@microsoft.com>; hpa@zytor.com; KY Srinivasan
> <kys@microsoft.com>; linux-hyperv@vger.kernel.org;
> linux-kernel@vger.kernel.org; mingo@redhat.com; Stephen Hemminger
> <sthemmin@microsoft.com>; tglx@linutronix.de; x86@kernel.org; Michael
> Kelley <mikelley@microsoft.com>; Sasha Levin
> <Alexander.Levin@microsoft.com>; vkuznets <vkuznets@redhat.com>;
> linux-arch@vger.kernel.org
> Subject: Re: [PATCH v6][RESEND] x86/hyperv: Suspend/resume the hypercall
> page for hibernation
>=20
> On Sat, Jan 25, 2020 at 01:44:31AM +0000, Dexuan Cui wrote:
> >> From: Dexuan Cui <decui@microsoft.com>
> >> Sent: Monday, January 6, 2020 2:43 PM
> >>
> >> This is needed for hibernation, e.g. when we resume the old kernel, we
> need
> >> to disable the "current" kernel's hypercall page and then resume the o=
ld
> >> kernel's.
> >>
> >> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> >> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> >> ---
> >>
> >> This is a RESEND of https://lkml.org/lkml/2019/11/20/68
> >>
> >> Please review.
> >>
> >> If it looks good, can you please pick it up through the tip.git tree?
> >>
> >>  arch/x86/hyperv/hv_init.c | 48
> >> +++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 48 insertions(+)
> >
> >Hi, Vitaly and x86 maintainers,
> >Can you please take a look at this patch?
>=20
> Ping?
>=20
> This patch has been floating around in it's current form for the past 2
> months. I'll happily take Hyper-V patches under arch/x86/hyperv/ via the
> Hyper-V tree rather than tip if the x86 folks don't want to deal with
> them.
>=20
> --
> Thanks,
> Sasha

This straightforward patch is the only pending patch for v5.6 for the
hibernation functionality of Linux VM on Hyper-V. It would be really great
if we could merge it for v5.6-rc1. The patch is safe in that it only runs w=
hen=20
the VM hibernates, and the hibernation functionality of Linux VM on
Hyper-V never worked before. I'm pretty sure the patch can not cause any
merge conflict since nobody else tries to modify the file recently.

Thanks,
-- Dexuan
