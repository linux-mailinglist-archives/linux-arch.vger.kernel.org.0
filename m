Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB69B8A66B
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2019 20:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfHLSkC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Aug 2019 14:40:02 -0400
Received: from mail-eopbgr800122.outbound.protection.outlook.com ([40.107.80.122]:61504
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbfHLSkB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Aug 2019 14:40:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbIgtrCagGm5q3CCk1gqNakHDBZjSu8KLjErmZeqzPfQqipmEsxfHQfwl9hOv8rRrpPozlJKjJaAwg7FjNk26N7cUYBUWMkK3q5tGa7KQSdMTfEUX3mxiqs8yoIPla/DHAoRm8J4mPP3XSzACrkqBhXwk+iGbQbJUenABTPAbLnFJR8zUxJmpLP8YFK1UalPbtHW4qcj1sEojwxG5z8yvBZma0zEi9Gmyr8ub8esBWa3nHakA55xglbRg5q9UY9iIFyickverMoHg76QKbYFFeolrwDq+EdmTIsqM+gOb4xEY6YoxyGyXOrPhhH8K43nmuik/XN4njm/hYyyTRVlRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJAvyZ9PdbGSYTSrpXna7k9PUG27IHAsLp8x4ZMzL8M=;
 b=asDQcctfuAYBYv8GEiRieaYp1fXVrlpn1Bx/0jxcmGbG1lGA67YBzkgJK6qAmLKPJtV/6MKz+paxG3f4SCcUsb6059EsVJMDj8XvgahfhbGYq7S/p6nBgIW5g8PWAoXdsfkHiit1P6dsVCea7wGQ0ZZcLoELHVDHPIuFxZiXxg2UOyu2YuTnbLD09LFj1/9lnl9l2zBXUIJmkBuAh6CnFO8n8szfQEGJBrpxGTQHXaERrMzY73PjMCROZ985wO7VwNUHdkHJQldntX3G+tfimI0Xi13lAfRB/AjRInOscLxj1yiK0DlWW7UG8+VEmreRoxpM34zrKuSedHlfGP3ZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJAvyZ9PdbGSYTSrpXna7k9PUG27IHAsLp8x4ZMzL8M=;
 b=BiuRzYIDnWtD+PcgIREHNW50zKeyh2QEuN0/+398L9xsOOl0cqyVIkE5K13Y3IP81YujY2fFCNmfQJ+qC5xl3jCUEDkHKnDnZ585LBlJ9XdkPIkVGCv/2p2i4H9OdlA+VdWut4qGlVxrinEHsZWgRXQw/AaXnPQcc2AAa0F9OZw=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0764.namprd21.prod.outlook.com (10.173.172.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.2178.6; Mon, 12 Aug 2019 18:39:53 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::9558:216:27ca:5dfd]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::9558:216:27ca:5dfd%2]) with mapi id 15.20.2157.011; Mon, 12 Aug 2019
 18:39:53 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ashal@kernel.org" <ashal@kernel.org>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH 1/2] clocksource/Hyper-v: Allocate Hyper-V tsc page
 statically
Thread-Topic: [PATCH 1/2] clocksource/Hyper-v: Allocate Hyper-V tsc page
 statically
Thread-Index: AQHVReKmD1hZIClpP0qYR/nqtNVfa6b3603g
Date:   Mon, 12 Aug 2019 18:39:52 +0000
Message-ID: <DM5PR21MB0137DBE06D9E8667311AFAF0D7D30@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20190729075243.22745-1-Tianyu.Lan@microsoft.com>
 <20190729075243.22745-2-Tianyu.Lan@microsoft.com>
In-Reply-To: <20190729075243.22745-2-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-12T18:39:50.4556069Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=15a59b8b-3f8e-467f-8df5-2e5d22380cf3;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c4c8a38-24c5-48e2-7f23-08d71f547715
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600158)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR21MB0764;
x-ms-traffictypediagnostic: DM5PR21MB0764:|DM5PR21MB0764:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB07642FE72E80520EDD115338D7D30@DM5PR21MB0764.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:356;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(189003)(199004)(22452003)(10290500003)(446003)(316002)(478600001)(25786009)(5660300002)(7416002)(81156014)(6116002)(102836004)(2201001)(2906002)(52536014)(66066001)(76116006)(66446008)(14454004)(66476007)(64756008)(66946007)(476003)(1511001)(11346002)(66556008)(486006)(33656002)(8936002)(6436002)(6246003)(110136005)(26005)(71190400001)(256004)(6506007)(86362001)(81166006)(14444005)(7736002)(9686003)(71200400001)(2501003)(8676002)(74316002)(7696005)(54906003)(76176011)(10090500001)(4326008)(229853002)(8990500004)(55016002)(305945005)(53936002)(3846002)(186003)(99286004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0764;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NDumm07rmUhzHADcs8yx+YowysqwwYeaYi7N6U5VzBasm1W8SeTUbQWlWzJUU/AObDihOHaahfAcePM8S5/iqevxNVL+CmMFIA4po11YmKSXw9OQILUQJjmKela/gkhG8/2MniP9qCItM0V7hU3gwIVPonv5q75vJsk5y1C4n3Zm/jnqX5CscfFxEnRMVBYSw9m7VS5gvq2GU9n64uZfjL+R44BwYGqRKh/Q1zJyoiWkFNqvcxLIYY95EVtmV0/TyoKOvMxRosdo0YvP6ktiXXv85hsKE4/6xwSVlT0Iq61xV1Nz1nGdNSGY2/D+s2ky5J7uzp651dKYCHsRFsLbZWi7h48EMQF/mMeQeF6+PTTYAYbHe3cIqxv8oIX4KjH4KpmzLXKlw/enH/fwy9uBsZ0DtCw8+W0WIMcZMn8jTbY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4c8a38-24c5-48e2-7f23-08d71f547715
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 18:39:52.9676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ocJg50cPajJMDZqsjUVeY0AvZG5j4u2K853KIL+MqN0WnFhyZGUOMsjVgFRe0QDeLLkfZ6kd5PyBU4fIjzkv083oSnOqAaufWyK42hIx0Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0764
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: lantianyu1986@gmail.com <lantianyu1986@gmail.com> Sent: Monday, July =
29, 2019 12:53 AM
>=20
> This is to prepare to add Hyper-V sched clock callback and move
> Hyper-V reference TSC initialization much earlier in the boot
> process when timestamp is 0. So no discontinuity is observed
> when pv_ops.time.sched_clock to calculate its offset. This earlier
> initialization requires that the Hyper-V TSC page be allocated
> statically instead of with vmalloc(), so fixup the references
> to the TSC page and the method of getting its physical address.

I'd suggest tweaking the commit message wording a bit:

Prepare to add Hyper-V sched clock callback and move Hyper-V
Reference TSC initialization much earlier in the boot process.  Earlier
initialization is needed so that it happens while the timestamp value
is still 0 and no discontinuity in the timestamp will occur when=20
pv_ops.time.sched_clock calculates its offset.  The earlier
initialization requires that the Hyper-V TSC page be allocated
statically instead of with vmalloc(), so fixup the references
to the TSC page and the method of getting its physical address.

>=20
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  arch/x86/entry/vdso/vma.c          |  2 +-
>  drivers/clocksource/hyperv_timer.c | 12 ++++--------
>  2 files changed, 5 insertions(+), 9 deletions(-)
>=20
> @@ -280,12 +280,8 @@ static bool __init hv_init_tsc_clocksource(void)
>  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
>  		return false;
>=20
> -	tsc_pg =3D vmalloc(PAGE_SIZE);
> -	if (!tsc_pg)
> -		return false;
> -
>  	hyperv_cs =3D &hyperv_cs_tsc;
> -	phys_addr =3D page_to_phys(vmalloc_to_page(tsc_pg));
> +	phys_addr =3D virt_to_phys(&tsc_pg) & PAGE_MASK;

The and'ing with PAGE_MASK isn't needed.  You've set up tsc_pg
to ensure it is page aligned, so there's no need to mask out any
low order bits.  That's why the previous code didn't do the masking
either.

>=20
>  	/*
>  	 * The Hyper-V TLFS specifies to preserve the value of reserved
> --
> 2.14.5

