Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A353E1492C6
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2020 02:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387564AbgAYBor (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jan 2020 20:44:47 -0500
Received: from mail-eopbgr1300137.outbound.protection.outlook.com ([40.107.130.137]:1883
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387542AbgAYBoq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Jan 2020 20:44:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ww05MQRLHX+bit+DT123lTTK88OFInVcp1O4msmCsUZIggglNGVUSK0qtY25GGpDBf2HJoIvj7Q2n5wHX6EUm+XZWYr5OB8Teo28Y4qsocI0k7v9T4Cmka3sh8WcENDetpY/uW3n6yOUDbj5oOolSw1+EYWkkPMKv/QD1iJE3uubaAsnl94l7VAOcOmYNEacJ70Uja+TT1JRFLgcdeIkITpm925g/Th3OTZWqc4OyQADENYKE1KlsYPw8ZkCaIwsucP869flCKvO6aVhDhfy4uzOVPlP8Rwc3XUgfMGiwxkB+Bh/al9/7sMgqtomL/YKJq4qlCSntl4fn/PIZKYPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tN3lpDuKXJRxYPBFxbxHaV8NENsqzTZQN3gQOhisIXY=;
 b=SO3wVTDf/0rQrqIjFNLDz4wFwWwO6yNIoYyTrHCKUrWNjanxThqJ5tEjAjcPk0F+W/i5ejjZKzhxuIKNh8xK5uQpuH097tgShePzG15ZuL7Fc0ogmNnhpV2uGxeg6I7UluXB9ykXXuFjHCn9pzqAIbFL6xXfSeKkwrLbwf04G3miHuzN65+nEKUoHcYYHyVDCYaU1Zocms4H7c4+XhrQbRKR90CEs8/xMzgaW9VXyrEkphUAQXeXxmD4jzdj0M3JV9EMZNFcUotTQoD5dTGlEgHKiCwp1qBRhKn4yCbXLvzsFHm3EBhCdHuF3VX/2TkoWkOGKnV13MfhNP0HgmuYPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tN3lpDuKXJRxYPBFxbxHaV8NENsqzTZQN3gQOhisIXY=;
 b=X5GMJimdodAy1JSXdgaFDMnViG8d74GZq2ySomvUKCBfeNejoiz2k/NkHSzuAJw9AGpG4qnGKf1ImRQGQ94D2D7JAYrQ896yKyhQkRzmtY+P/AdWIytFZOb2lai3ZeoD3JQ2XPqqZvuZ4LNECaoFxjeRYHL+IHwIFC+eglAXOls=
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) by
 HK0P153MB0276.APCP153.PROD.OUTLOOK.COM (52.132.236.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.3; Sat, 25 Jan 2020 01:44:34 +0000
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432]) by HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432%4]) with mapi id 15.20.2707.000; Sat, 25 Jan 2020
 01:44:33 +0000
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
        Sasha Levin <Alexander.Levin@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v6][RESEND] x86/hyperv: Suspend/resume the hypercall page
 for hibernation
Thread-Topic: [PATCH v6][RESEND] x86/hyperv: Suspend/resume the hypercall page
 for hibernation
Thread-Index: AQHVxOKfKplvVmki0EiTTmOHhKt+Nqf6tz7w
Date:   Sat, 25 Jan 2020 01:44:31 +0000
Message-ID: <HK0P153MB0148ED41CE96B637019DF26ABF090@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
References: <1578350559-130275-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1578350559-130275-1-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-25T01:44:28.7104793Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ce328d69-c3f1-469a-b636-a08c9d3f1dff;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:20cd:da83:19e9:3198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e30ba3c5-a78a-4d91-e26f-08d7a1382088
x-ms-traffictypediagnostic: HK0P153MB0276:|HK0P153MB0276:|HK0P153MB0276:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0276D852B21FDF134CFAF62BBF090@HK0P153MB0276.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0293D40691
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(7696005)(71200400001)(6506007)(81156014)(5660300002)(81166006)(52536014)(186003)(10290500003)(76116006)(478600001)(9686003)(55016002)(966005)(66476007)(66946007)(66446008)(64756008)(66556008)(8676002)(8936002)(8990500004)(4326008)(4744005)(7416002)(86362001)(110136005)(33656002)(2906002)(316002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0276;H:HK0P153MB0148.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zhsUCS6zuEW3yh5RoCErOfR8G8y/WXFHkU/O7YPPBW+ersYzrlzrVA8LCCa0+oh/gbu2IManlJmiK0c7lOjnsCfu7E9C9eBIZ9+PpPW/P3OimVHXvkPMKFhOhxQG9Vr1CkT15Wc2WPMaaQEj2Ns45e3X2MSxHPnfVJRiYFr1rlJfx1OIrHm8DgCpj8FhyhAb3TvvxMSZRjL9XrkLX+tL4BF/VEz/GQVf+tfY3iUWcqJOLOkDdCziCbPNZq2LOZecPnhkNgl1r60LMXD8d5meyJ27DlqHFySVODWFxb10b6/wNFqc+u5xGIXFoQ2TwRhyhX/A6RQtCJskiQB3Su6cdiroBv6bBi2F5DoBoLZ9VP5BfVCdWy+/cTCLbzZA78lpV8ELkIfFsk7iY2rk7xuyOOFJEg0zM2dpNrew6eGkzT8d3zDgLDVC+xSRo9o2H1Epw4BqkHYQwh3sFNWVULjmp8ieXhThC2uPP7dTFWRfR6Zlzh4JIABFRqo7ckGQbwuCOsZ1GEKs/mVGyFsgGq6Q1gRMTCjzqtQ6Mie84CGq++Un1soM8fBCnh+5HfaCQWV2K3/nQlOJuyq7LNNr5/yEBg==
x-ms-exchange-antispam-messagedata: akpUXhnEnMfQMR6JkqlDBD4VRgCUzXsFzNN4OGOSzK91nCGT5AhKFOeDrUp/sk5xQiKI3Nok4QrfnDEl5+mQPJzESDfZn3VlGpY4bAqB6gCUwemOjF1ftqpDAOcqXFgNvfIB4gyXeMY2A+EV1GRAlwfJZsHzwZNy9UdzkZW4MnxibGnovayJ2Vw9AjwuP5Y3lCPlCHLa7qEovHd9GR/XzQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30ba3c5-a78a-4d91-e26f-08d7a1382088
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2020 01:44:31.6535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZgTRsSyTTv6NwNVtGtKn/QDSlkGItlRqzxFUagtpAGzpIOgt85MHb689KK4dkieX/G0+kB926pbJjMj4aCu/og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0276
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Dexuan Cui <decui@microsoft.com>
> Sent: Monday, January 6, 2020 2:43 PM
>=20
> This is needed for hibernation, e.g. when we resume the old kernel, we ne=
ed
> to disable the "current" kernel's hypercall page and then resume the old
> kernel's.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> ---
>=20
> This is a RESEND of https://lkml.org/lkml/2019/11/20/68
>=20
> Please review.
>=20
> If it looks good, can you please pick it up through the tip.git tree?
>=20
>  arch/x86/hyperv/hv_init.c | 48
> +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

Hi, Vitaly and x86 maintainers,
Can you please take a look at this patch?

Thanks,
-- Dexuan
