Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630362506B4
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 19:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHXRki (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 13:40:38 -0400
Received: from mail-bn8nam11on2124.outbound.protection.outlook.com ([40.107.236.124]:12493
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbgHXRkg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 13:40:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mp7pxCyP6pfoiqW5X6jIXqxg1OFCVlfO69EkNfPlsBnO3wFDWkbtUwgT9IVqwdozouxXD53rP6BRwbrI50H1YPOmzNadw/u9N/cZQgyHBvAUc4M7SeFSFAD3aifKrFbJyM3l1XzFSfjxohS6n0WyDNtXUR0pll7+Z6sULC8CXCuPe5CBdmNEHpn3WcRRXImmZsdYNrFf6WRud2kD9kfzxXzkDWLp9fr37UKI5JSMDVDN85/P1x1k3L1WzZKNx3doMnb0l7ufSBVCpW5+CeRfMdaG44Aw7EUlmd4lozZiAjb/b0ARPdsOODvDl4eqNaYKB9drEgknydYnlnuLNL2q3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC9VHzd4rybTXSvIEn6vKv3HUBaQNPjxIEBbkUiAqlE=;
 b=Wj8j9k+aFPBzSFGXJQEDtCWFYoyUtpa+HeV/ogsNEJib3VYWu27aSqk0txXIbipzuRMQzfjXUCcPIcIO/sd2Y285OA0dsuWoTnfgwD7hGYYNvb2ZAHoZQ+km4QtqrYemI1/5f/28Z6PN0DDohsHR4zKzxkX1Men7sTfsRPjL21CIK4zcEXqOd9JUmwOX5Lrsd7Snndo1IsAUEnlqZ8AGfLPiCLjvBxPuQLVGtucUe+RmBG1ZJLAk/V1bMFrPvVvQTGY2M7kmZRuQG2OiBpA3UydtP1OgnnfvkyTRORvu/FQ3CSmdEFHY8CjcyGUHdUY0pyoNhCGRtCBMq51G7sL4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC9VHzd4rybTXSvIEn6vKv3HUBaQNPjxIEBbkUiAqlE=;
 b=OFk4R8NsP1bo7nLn8ZqGkl6Jlsb4+m+H6RXvTfdlKrg0ZLPVNVYMdqCl5hNL18uW6ZUiYXjmuey7agxUjtt1NS3zp/iwZgNXI2Zi6iO2QlJeGasIF+b0Z/vlajMHWVJo86PAVMXBSWwGh5Z//YocDkqdgHvPSDK9HDN/iTvFRow=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1849.namprd21.prod.outlook.com (2603:10b6:302:7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.4; Mon, 24 Aug
 2020 17:40:32 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407%9]) with mapi id 15.20.3305.021; Mon, 24 Aug 2020
 17:40:32 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "will@kernel.org" <will@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "Mark.Rutland@arm.com" <Mark.Rutland@arm.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>
Subject: RE: [PATCH v7 09/10] arm64: efi: Export screen_info
Thread-Topic: [PATCH v7 09/10] arm64: efi: Export screen_info
Thread-Index: AQHWejZWC3GY08nqAkGtdhnMB8m42qlHhV4AgAAAZtA=
Date:   Mon, 24 Aug 2020 17:40:32 +0000
Message-ID: <MW2PR2101MB1052C68771718B3FB47BB58BD7560@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
 <1598287583-71762-10-git-send-email-mikelley@microsoft.com>
 <20200824173502.GA1161855@kroah.com>
In-Reply-To: <20200824173502.GA1161855@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-08-24T17:40:30Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b1a6bad6-5462-4b54-aea9-d9458f32c526;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 827e11d4-b56b-4fdf-53a5-08d84854ccc4
x-ms-traffictypediagnostic: MW2PR2101MB1849:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB18495662E4E1A77441C18005D7560@MW2PR2101MB1849.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oyii6JwTPczUyjKXdyEZ4qD5HWHGsMDnmAO9SokBIk2NXGCx7oEnQflj+cREhSfIb60gcstMa2WYyCadfnj2h0S3+hA5Jl9OGBbjD6NzBnILimjH0TX9QLGMSiXHiV74wgA+Mx3zc3oZ1Za6JA+wcPZMla2vbPNI1mdF7Mkh/FuoAxUgxQtE993fBNMLhrEL5nW0EdrvvdvSzeBhFQdMM2FsLFGhpEXcHmevPP3GnWFFs7qtRHuzynSCevN7/O0YWchoITgT1BVrcm5v++b5jpl6B5/qQN36RFVh+21uHW2dgmDQWtnAshwWsQ7BXH/SDovybD8L7e6INgCraLp+aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(6916009)(26005)(55016002)(186003)(10290500003)(7416002)(4326008)(7696005)(9686003)(54906003)(316002)(71200400001)(2906002)(82960400001)(6506007)(5660300002)(8936002)(86362001)(66476007)(64756008)(66446008)(66556008)(83380400001)(82950400001)(66946007)(8676002)(8990500004)(76116006)(33656002)(52536014)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: mG19BDg/VXsLSDItTNaVvr1aMxZveZ3RkYow7pAGZrSL7krJoP5mHst0Z8IfpTaNUdpBCeP4aD1+JIuuOajCJgJDksCZHDRojQ9p53BZKd+E+Z8Zf2Y7l8GUeEuLjnpSelgqpxZwTtkeSn24GCfsFuSznKrP0OsmUJlyI9MFgsrJr9Gg8oHTTsF0vked7WQa8GIxl1j+OwFFYj/6KH6lOn7bDdoGK8QLGtu1/q3E56rsmeJevaZ2Go4YFUt/3OwkH2eZ1OYtGDziJ0kr8bI3NuR3ahVD63SlSbDF28kskJ/OQiZJ5XKz7+hmzoh5ExkNewBAjiSKU0Lw1K4LWILFU+LCC72kos/YnGceAf+/h/ukwaEhesKLnT70antid0u7v4c7Wh0yUhmgps5j9f05d4YeoikkNqOI1N3N/Ws3qSuV/uRxJ6AOXD+XvBoE6HQ64ChEczfqsGe6ATf0SoRG5bPQ8xWLbnvoW7nn1HHKGxzqdzrsDzCz6+noje5elUkpmPyvYS7pfxtqpa/FFlCekrqGD1Nrb8IflF4as7rmWHPr9wGDCDoK2LNYi2n7ZCNYrbCCb1DPemwVWrXz+rtrDHC5MomtCNcMI0sMWnaxhwbmGfIlBx7r9ZaHSgZtjhtn4N4WatEyFNqfLKFvmZcm/Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827e11d4-b56b-4fdf-53a5-08d84854ccc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 17:40:32.1597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j4VGhdjEe24ZrKlgAYmYbidXg+qWexJ6Rl5RTGg5jkhKUtkaEZABKtDIg03/TJ3IS0w0UMt/hPLY1gMnclniTRZWof/PCRLyCgYvlJhN5A4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1849
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Greg KH <gregkh@linuxfoundation.org> Sent: Monday, August 24, 2020 10=
:35 AM
>=20
> On Mon, Aug 24, 2020 at 09:46:22AM -0700, Michael Kelley wrote:
> > The Hyper-V frame buffer driver may be built as a module, and
> > it needs access to screen_info. So export screen_info.
> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >  arch/arm64/kernel/efi.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> > index d0cf596..8ff557a 100644
> > --- a/arch/arm64/kernel/efi.c
> > +++ b/arch/arm64/kernel/efi.c
> > @@ -55,6 +55,7 @@ static __init pteval_t
> create_mapping_protection(efi_memory_desc_t *md)
> >
> >  /* we will fill this structure from the stub, so don't put it in .bss =
*/
> >  struct screen_info screen_info __section(.data);
> > +EXPORT_SYMBOL(screen_info);
>=20
> EXPORT_SYMBOL_GPL()?
>=20
> I have to ask :)

It's also just EXPORT_SYMBOL(screen_info) in the x86, PowerPC, and Alpha
architectures. I know that doesn't guarantee it's right, but I'll have to d=
efer
to the appropriate subsystem maintainers for whether it really should be
EXPORT_SYMBOL_GPL.

Michael

>=20
> thanks,
>=20
> greg k-h
