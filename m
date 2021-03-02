Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7593932B4C3
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354198AbhCCF2K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:28:10 -0500
Received: from mail-mw2nam10on2119.outbound.protection.outlook.com ([40.107.94.119]:63808
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1580354AbhCBSCa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Mar 2021 13:02:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfmxKpHDGexfiwOqSxP7/sGFrEbEfWk/JO4FfQ9N35wbfZBuN+ALsY6hfq/m4UAEsZL0Od5Cg3C7i08SegrVou0c5DtR7jeIv80HsOKLERlMta0T1+xl4SYHzg2DcPkmT44WLdgOaJdSFhss7RItJTz5nPkc2fdJiN/dfAvnTJpIkC65+rgr94Q2NUlH0KyVaAFHXdqQ+iTZk+cga8Nbu1LLE5T7hRUxDEMou8szIARiTSymsH+CgU0G3FmdT1wE3pigUflVkPjttxiKqXmB8qq3T9NkHoFU++d6OLntECSRODwqxk82eRgt3K4lnflgc529rhLoC9K3OwZZLeRkyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AgdkcVM16c2bLY9JmelK/tCxgxV8JdYipOL2/QmorM=;
 b=nNQ6tBd2MvsjSkCgumM01+f5QRhSqmWxE8Vj3Ni7TTuuPtkJmQcSx2+EFbMrN50HsvpaCpxrp2bzjPjdKuQbosnlsh9tknHyPriX/R2EDubVPjO/FHCwSbkkGss3i/9LVnwivT7p817zSnnYSsqxdrUqSJvRYDWymgz7ez1M54ERvoXK7SNlpedFYLNaRhmm8P7lUHb13S7c+0VVVlJ6iClxTL6DcEsZLsRbsAdB/sFy7ACVFoFgR7P4wQtUdDhkpJLoA2V6lge1NSZiR3UatPbAH+41efcBWjre75VnKKrzWsWxLfZChA6J3np+jibTfoA7w6A7CmVbOqX5gqQyOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AgdkcVM16c2bLY9JmelK/tCxgxV8JdYipOL2/QmorM=;
 b=WXTJFlBxeJpxuKmM5YTp1kUSIY+Ui0E1C7CJqsqrcT1H97EGpaiKyL4E9xt9xTcA+enLdCqXAYWPlPyyzQczASQXPQu3vIuzJJXj1nWFgPY6wquvWPRA0EZUY6E0RlAKbgzColXG57qhuT+dHEstc/C2koAbGxD8Y9q3is1gGHw=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1970.namprd21.prod.outlook.com (2603:10b6:303:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.8; Tue, 2 Mar
 2021 17:42:30 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3912.016; Tue, 2 Mar 2021
 17:42:30 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: ** POTENTIAL FRAUD ALERT - RED HAT ** [PATCH v2 01/10] Drivers:
 hv: vmbus: Move Hyper-V page allocator to arch neutral code
Thread-Topic: ** POTENTIAL FRAUD ALERT - RED HAT ** [PATCH v2 01/10] Drivers:
 hv: vmbus: Move Hyper-V page allocator to arch neutral code
Thread-Index: AQHXDjhypGARyrRKUEOuG2wtOqcDE6pwqqAAgABO05A=
Date:   Tue, 2 Mar 2021 17:42:30 +0000
Message-ID: <MWHPR21MB1593AE5172A203C3D62B8C06D7999@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1614561332-2523-1-git-send-email-mikelley@microsoft.com>
 <1614561332-2523-2-git-send-email-mikelley@microsoft.com>
 <87r1kxemsj.fsf@vitty.brq.redhat.com>
In-Reply-To: <87r1kxemsj.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-02T17:42:29Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0f5b1eca-52c1-40cf-acc5-83b4d2934451;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3f134cbf-1db0-431e-9b68-08d8dda28df7
x-ms-traffictypediagnostic: MW4PR21MB1970:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB1970060681BF30CF7401A5EBD7999@MW4PR21MB1970.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /wWoRiIpjER4vE8mA8WpNF54binYcDcQpga/+eOAXpDjpoBy7D8KoRWd8kTDmkT7FAYL52G0jVsTBr4hfT0k1iYxOUyOGpk/t4vO4s3D0vKN9Lid7wNrGwam+N2LhfN3CwBMSg+OM/OvgSAGodFccVluUS6eEEERpQbWgYbhlgE1XUPj8ujX/9wEt05RFUwXkGjkEReQekQ2+fymGGtTvpMuF1rUci6eR0BzYfx4xZD+S4iCfL9Lr6RwI3FbzY5bum0jBctl56IrtTWZVhXSS8fk0b5au9ypgY1vBOa+7cV/PnDGRtozaOog+MeG/LdnMFIfRKQad5F8LoQT6Hss8+06FTaOSiCNHcZ/eqPRrV81HtAMm24RB6JMugvOlZG0tLZjYbI7492EySKPRBa0Bbg2i7hWxtTh3ttlWlO1I91C7C624O96OIAsP5fIdgHJdEAaVcAFh5K33+STrqLfZMz8u8jyWru5ZByI0bZAa0daaNNRjxk5aOTJhL2UixzHo3WfIaKvXyoRpNeROP7mHsSc2lmpoa5GchCris0olzTFzZwVZPBTkxc6Gl76BuUECVCNYZBmj/Wx4Bj92aVI3BGBcyetbp3BKDFC/Y0AnHDq1XP3Rbs2VwY0le2kUN12
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(9686003)(7696005)(71200400001)(55016002)(2906002)(5660300002)(76116006)(54906003)(66946007)(10290500003)(4326008)(8936002)(82960400001)(82950400001)(6506007)(52536014)(86362001)(26005)(66476007)(8676002)(64756008)(66446008)(66556008)(478600001)(83380400001)(33656002)(186003)(8990500004)(316002)(6916009)(7416002)(184083001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tjgcGuREFzajcF8e9MVV0l3DsjiXhPrJp+KfB2Gzt0735n+/j1XY8Z/uY5od?=
 =?us-ascii?Q?HcSdnwtMXDwvCkyBkve4v4eWvvpcNnGFx5MfL6A6YHBq5hPCQSs2x5jJTETx?=
 =?us-ascii?Q?1uE1aBp1wmA/M5iTRzE9twUuMlLCKKJ2T2MWs8hvzBS+LfHj9g1FJ/E7jQH7?=
 =?us-ascii?Q?5DmXd2jNxu7fTe7+/4bNSZ9uoUKb3Jl1JNE5fKlTrUjUeZ99oQpV3HqMF8zm?=
 =?us-ascii?Q?MK3r9XmN4BHuaozhrbYbCMzXzC4dfqO8K2kU6PdLNFDmo5QWlspi1w4Ax18C?=
 =?us-ascii?Q?knMQqN5vItmYrUbrsbgkZIux8+yCC0tinPTPmW0VOnoLFfmv470irRdPp9ZM?=
 =?us-ascii?Q?UbyrPY6UH8oCb5hYmjwKsYFE1FfSelqzfkVfO+r1KX5N2vHsCdnGEzzU8lHD?=
 =?us-ascii?Q?KuyofK+nM3UBXmnJgekBPc00+FTS1sxEECCrZYV08mtvOmZXnkpu95u1tpy2?=
 =?us-ascii?Q?sb1e0r/lEOVjgGNG3zXE5Dc6WdWjAhX2VL//zJbcP/1EzAFYknjYyhNRHGS0?=
 =?us-ascii?Q?sp8vSrc2yv3YVAHLdUK+phs1F3gxYSgYG8htNkZTa8RnJq7tvvxGEwO46q7C?=
 =?us-ascii?Q?AjVfHSGhynM85VwqTxUrl2BO/CUtJOeRnPgZ9iYCvagqAgzOAiwOLvA4QxLr?=
 =?us-ascii?Q?1JSNTurMUS98gBFBCDJ0NEN5S7F0N/+lcOfBxEQSLsH44tOdIrkres4NzA7+?=
 =?us-ascii?Q?Lw+Y7qJpmzStCzMHeUwVKDOCYbBK3zEFZFUL+nO589yElmINegmSpVmiGk1X?=
 =?us-ascii?Q?Do4aN4uyOZKCbHFBXi2i5641/fabscP/qaT23piw0PfZbm3cA3PlZOsoZ8V8?=
 =?us-ascii?Q?BJUPzgSGLOy6gXP+1DaKihbtdLBkk9JrQqYsAKNNTdd6fSXPm1IYcsq1zUvM?=
 =?us-ascii?Q?3HCDH/ZuGcti9WfVppg6/DzZ7xPdaPhmTXyFJJjmxFa1J854EgLFZsKgz5ou?=
 =?us-ascii?Q?V8IonovGrcBZLXDJnKtaGqS9pKW1/ArdjYNOaULBAMfZKbCJHGagy3qPN/3h?=
 =?us-ascii?Q?gdTEspGMScCVwVNFT8qfzcFw3m070/TMdfk8AF3KfWj3+uUfpJsRL++8++3p?=
 =?us-ascii?Q?pBlBnpdhajnv9iL/LydgpIBUcKtRZNs8EiUBDuL6IvXANYbBenQXfyhXIPHD?=
 =?us-ascii?Q?WVQJN2K69m8sR2usFBrmt2vZ4fKCD9DvxK68ooQZ1bkWPdJfCC3l7N5wJ2t3?=
 =?us-ascii?Q?BJBaxtlryAIg36OlBTeQzgThYtqRYhtVOpMgraa7g3IXkqI6+fTBhtE8jaoB?=
 =?us-ascii?Q?1yND2P5bd4D5bqME35MX4WbvDn8TX562qAVkhRgEzIdefdBwJKlz/eAMgbXx?=
 =?us-ascii?Q?4hawQMKd2j9/WkyaITL4pQgT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f134cbf-1db0-431e-9b68-08d8dda28df7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 17:42:30.8350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F1V9a9Vf+46jzupzdqAYN4ND54pYkCWNakH4weyb9+FW6YBmHN48QU3qU//sWA35SvHM/hIPVSaihc2UdZkZQSALhzMKf/kKZ3wP8xue6Sc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1970
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Tuesday, March 2, 2021 4=
:57 AM
>=20
> Michael Kelley <mikelley@microsoft.com> writes:
>=20
> > The Hyper-V page allocator functions are implemented in an architecture
> > neutral way.  Move them into the architecture neutral VMbus module so
> > a separate implementation for ARM64 is not needed.
> >
> > No functional change.
> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  arch/x86/hyperv/hv_init.c       | 22 ----------------------
> >  arch/x86/include/asm/mshyperv.h |  5 -----
> >  drivers/hv/hv.c                 | 36 +++++++++++++++++++++++++++++++++=
+++
> >  include/asm-generic/mshyperv.h  |  4 ++++
> >  4 files changed, 40 insertions(+), 27 deletions(-)
> >

[snip]

> >
> >  /*
> > + * Functions for allocating and freeing memory with size and
> > + * alignment HV_HYP_PAGE_SIZE. These functions are needed because
> > + * the guest page size may not be the same as the Hyper-V page
> > + * size. We depend upon kmalloc() aligning power-of-two size
> > + * allocations to the allocation size boundary, so that the
> > + * allocated memory appears to Hyper-V as a page of the size
> > + * it expects.
> > + */
> > +
> > +void *hv_alloc_hyperv_page(void)
> > +{
> > +	BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
> > +
> > +	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> > +		return (void *)__get_free_page(GFP_KERNEL);
> > +	else
> > +		return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
>=20
> PAGE_SIZE and HV_HYP_PAGE_SIZE are known compile-time and in case this
> won't change in the future we can probably write this as
>=20
> #if PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE
>        return (void *)__get_free_page(GFP_KERNEL);
> #else
>        return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> #endif
>=20
> (not sure if the output is going to be any different with e.g. gcc's '-O2=
')
>=20

I looked at the generated code, and the compiler does the right
thing on both x86/x64 and on ARM64.  I'd rather leave the code
as is so that both legs of the 'if' statement get checked by the
compiler regardless of whether PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE.

Michael

> > +}
> > +
> > +void *hv_alloc_hyperv_zeroed_page(void)
> > +{
> > +	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> > +		return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> > +	else
> > +		return kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> > +}
> > +
> > +void hv_free_hyperv_page(unsigned long addr)
> > +{
> > +	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> > +		free_page(addr);
> > +	else
> > +		kfree((void *)addr);
> > +}
> > +
> > +/*
