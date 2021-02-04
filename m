Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46ED30F80C
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 17:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbhBDQe7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 11:34:59 -0500
Received: from mail-eopbgr770099.outbound.protection.outlook.com ([40.107.77.99]:12116
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237859AbhBDQeh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Feb 2021 11:34:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Elk5XGz0ZIACPq+fYz1fX59n+wD/ZTl6ygZ7sxeBvWaCjmKxZ+RY57gSfXyyQS6grnxtgWOMEyoJUqn2Y0Eydwot4nSvPcHxqdX6XUB2OLBxooWiBJaBS58vV7h9GxNuYdKDTzp18ZFbyRjrOhZm17d4/M3rRSyKphUd0kmo/WYaM1OIArW2y6LCJxyK+p1cyOmbAs0JggFNLG2lqnjkuDe3QwP6RSJtvZOKQq2B1BdtezYNu6BInmSHaAuWE7+BIs8u3sWGTnygGkMwr2AkWjmq5WPOzV7+7EDx4DrhdSqFTp+tzWJD65UrLrdsR4+khvZ6Xdc2kMvsscTn2kMvoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLGa8fDne4XXfs7DapM1i6j+oCkKK851Hy/x9HTRpI0=;
 b=T7UuVhhr4B2OcfGyIP8zSw+pyTOm/g3vVh9j7Rrh2CBsP7SZ9F8vU2hNXJVpt3hYgqHDs9ig1J/JnJprymIjlfuqN6h5OOrN6CIXLhmm4WPIi8xx30v2d3OlU3rqIM3Z9/8xkUoE5cI6luTY/FfmYhhzD1NY2eVO7AEenH/f0RZgGAShyE08SL7czfFd5kxI4CPb8KBwDcju1uDEtFbZKJk1EXI+9keRggmbHVcU+98QiFH31OApDZIxuvPeaUvMsBPEdNPVStEg4TTKgm8PjkMAkY3zjbu/RxkQOikskoGbJp760PE1YUoYSrpQ7oUVT4fn9McHy/BU8sAutx35Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLGa8fDne4XXfs7DapM1i6j+oCkKK851Hy/x9HTRpI0=;
 b=XkVMMcg3G1AZQZXyWL7iZPR+/YSNnZ1EGXapV0bmSBpO90dsA8MX+BKVw063PhnVugTWaBA9/gAytrV0w/zp1lYSKHytTnq5P8wOKuJG5hnRhSX/EALcunk16GCqnJg+67b0WmRGeijGU6qdmFUQ4pOYiEVDMdavdiNtTRygYqw=
Received: from (2603:10b6:301:7c::11) by
 MWHPR21MB1547.namprd21.prod.outlook.com (2603:10b6:301:80::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.3; Thu, 4 Feb 2021 16:33:49 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3846.006; Thu, 4 Feb 2021
 16:33:49 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
CC:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v5 07/16] x86/hyperv: extract partition ID from Microsoft
 Hypervisor if necessary
Thread-Topic: [PATCH v5 07/16] x86/hyperv: extract partition ID from Microsoft
 Hypervisor if necessary
Thread-Index: AQHW7yPz+GhbbxilDEuVBBNQAujR/ao5GZ8QgAvxVoCAAz0kkA==
Date:   Thu, 4 Feb 2021 16:33:49 +0000
Message-ID: <MWHPR21MB159300985570258E73E208D1D7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-8-wei.liu@kernel.org>
 <MWHPR21MB15932CD9CB9DA046EFFBA310D7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210202150353.6npksy7tobrvfqlt@liuwe-devbox-debian-v2>
In-Reply-To: <20210202150353.6npksy7tobrvfqlt@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-04T16:33:46Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=423e52f0-2cc7-4fff-b8c7-56a1d3e71e2d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 69809ede-34ee-4a1b-eac5-08d8c92aa6ac
x-ms-traffictypediagnostic: MWHPR21MB1547:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB15471499129D5593A75DD550D7B39@MWHPR21MB1547.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N035C67FBQlCKeZSY14pBvJ0Ie2MVKSKkMaaiPWhlI2d0xraL/YF6prqe8z0iT7RublUSgEhquupHELtXsnz6RxHeqdcD7MERLlflVAokvI6KDmEkX/KuSb+FQFQ9Rc7tWUf8wX5r0+uVaNdT/3+je2b84/jEo0cxKhhsMVw+Lv5S2IDYmQIXoMOg2ZXrwXcxGEQ4InUNnNEHoq3hkGk4G4SbBe4GilDhV+RJO3Jm8eIGSvSiHrXewRizDA4CJ+SXJMmOUbin7nW2OXIA0mlSc0HRMAh57f713rT271OajENkBIULUG8jOGcRJM4YLdYxl4z/6Jak3AZO/KDenx7CuANKgn0/C0UuW1lBxh0qC07YG+o7pWx1bAfnQWKiahAkyFPwu0CoepTuSjnWWejZ2DauXX7W93/TjkRZlXWItDDkFOg5l8aamE+DPiy/5Du312BXW2S3M25+ZP2SNcWf3hgy4KYVjwoRHBgzwwyagJtr696j7gkFnrKuAUTnS/XyZuU+O8l4fMAko3x68OgTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(47530400004)(7696005)(26005)(52536014)(6506007)(2906002)(66476007)(8990500004)(55016002)(83380400001)(66556008)(5660300002)(186003)(478600001)(316002)(6916009)(82960400001)(66946007)(4326008)(86362001)(66446008)(9686003)(7416002)(8936002)(33656002)(54906003)(10290500003)(82950400001)(8676002)(71200400001)(64756008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aSiC5GuJ9AhvgZ/+A9Hnj5haA4Ki/2IiggQB+7HHSD4hkyn4zhup1SPUMcqo?=
 =?us-ascii?Q?JzsI46z+zLNwIkIfZQNDkJst+JpqsphvlGD1kIAEaCMEy4+l26v/3nlOKx8x?=
 =?us-ascii?Q?SfBtfLyZw+buAk32RuBgeJ0jGI8kMvcJiBrsiIB3xNuShRqjlgVurRXSGAnd?=
 =?us-ascii?Q?vBnQ1iksoI5oriOIjAskbjCkstoogm2NgDONNLuZwHPVsl3iZR7PcRq4+eBR?=
 =?us-ascii?Q?uHRTdjInVd9GDu1gjWx8KdZ9BP86wBf0v1R7NRSzZnH7QoaZgA0QIibINhFc?=
 =?us-ascii?Q?iSjK7mWdBzraaaxxswaNiYY7yT6a5e100GsEaofuNONo6rV2sI2oantKto1d?=
 =?us-ascii?Q?inXTgGrABG3KW4BsvNurWmIWMGLG071ZmLXeZuzbWbJ/TjbLNbjXN/V5HToc?=
 =?us-ascii?Q?o65K+l69XrOoFdFTNw5+R5hLTF9n0Jf8I/VFG6TZjDpE2eMFTbSl9ITU1iIw?=
 =?us-ascii?Q?TFtixv7pImFCpLTgREKlNwB1V+jvPZtM7E7qVL3K0V7/Zy2IqY1OjOdGsFz/?=
 =?us-ascii?Q?lotzZIDu4gWAISFVP0hjCGCZVkae5GLMCZ53WJHPzs2gzS01jFqENGH0aKtA?=
 =?us-ascii?Q?CGOVAsiq2JKQeLC6NmzDaTC1/8dyxenCDpm9807b9mM6BMPiaqpMibXLL+zq?=
 =?us-ascii?Q?BEc+XbH5RK3yy5EFzKx1H9RPvYz+Z+QLWHHya4mzyfEKsNWHodQXm7nVA71N?=
 =?us-ascii?Q?uCZ4vAEdCqVv1IiZB426UBGOCdQKY2ftSKHnWnE6pgmcnvhiz04TB5hqQHuI?=
 =?us-ascii?Q?C0pJnlnznBUTUVpwzRdUtYjYY5ZtuV/FJqE4IKd3R4cf7Uu2CxdTzhYghw+y?=
 =?us-ascii?Q?khriHG/w5sQN4GI9e8GMXLstgOqW6ZoWscYJGMXTlRLIV2y35dldZFcVYTLc?=
 =?us-ascii?Q?Kmen3bpCMpBNB1RZ2f3oAab7ii+5rWTh4zkaqcsB827/uVKtEj6kZhK4pNPa?=
 =?us-ascii?Q?0jpUlbIywzOs5b+2SEZ/ptPQX/hODbxdqKtU9+8yakOjYhwOEH/K/KZ698MH?=
 =?us-ascii?Q?2pLOmttTlMtgcj4efJnfilbsU1MCGpDNKUt+5ZzXTIRYqKL9NfuKfYTwSDSG?=
 =?us-ascii?Q?KrUnXPUDka/ktNlSo+1+HIhaw+k5cyNbI/nPCiXSZI9Lbsbqd4SW/61UGWXV?=
 =?us-ascii?Q?K/DUwCVswYqX+1J0kPP/ZhcFHImo97YKxt5ypkOyJM424oe+Ger4z4ReQT/E?=
 =?us-ascii?Q?jU7VWOaVdMNTCemcnTVljmln7l7GkELKNbfxkYlpWrf1Ryb+UUEhoVt2Y1/C?=
 =?us-ascii?Q?lAvzs89wFBy/7d1sldm0YZkHodHCC5MYjUQHsFp0OA3gXOTVrGNNUrzdLu64?=
 =?us-ascii?Q?xc1urjo8K6Ii30TyN77OG3OY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69809ede-34ee-4a1b-eac5-08d8c92aa6ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 16:33:49.2606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cc4FSC132fHBrgF2ZlXcnTjyU4OZAmS4jWXjXvHJ4qlT3B7baq/Zprme9QKCPfiQIG2hyVer6KOaaX8IQ91vltIfGZ2HYq8CXTYokvCbVHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB1547
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Tuesday, February 2, 2021 7:04 AM
>=20
> On Tue, Jan 26, 2021 at 12:48:37AM +0000, Michael Kelley wrote:
> > From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:=
01 AM
> > >
> > > We will need the partition ID for executing some hypercalls later.
> > >
> > > Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> > > Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > > ---
> > > v3:
> > > 1. Make hv_get_partition_id static.
> > > 2. Change code structure a bit.
> > > ---
> > >  arch/x86/hyperv/hv_init.c         | 27 +++++++++++++++++++++++++++
> > >  arch/x86/include/asm/mshyperv.h   |  2 ++
> > >  include/asm-generic/hyperv-tlfs.h |  6 ++++++
> > >  3 files changed, 35 insertions(+)
> > >
> > > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > > index 6f4cb40e53fe..fc9941bd8653 100644
> > > --- a/arch/x86/hyperv/hv_init.c
> > > +++ b/arch/x86/hyperv/hv_init.c
> > > @@ -26,6 +26,9 @@
> > >  #include <linux/syscore_ops.h>
> > >  #include <clocksource/hyperv_timer.h>
> > >
> > > +u64 hv_current_partition_id =3D ~0ull;
> > > +EXPORT_SYMBOL_GPL(hv_current_partition_id);
> > > +
> > >  void *hv_hypercall_pg;
> > >  EXPORT_SYMBOL_GPL(hv_hypercall_pg);
> > >
> > > @@ -331,6 +334,25 @@ static struct syscore_ops hv_syscore_ops =3D {
> > >  	.resume		=3D hv_resume,
> > >  };
> > >
> > > +static void __init hv_get_partition_id(void)
> > > +{
> > > +	struct hv_get_partition_id *output_page;
> > > +	u16 status;
> > > +	unsigned long flags;
> > > +
> > > +	local_irq_save(flags);
> > > +	output_page =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> > > +	status =3D hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_pa=
ge) &
> > > +		HV_HYPERCALL_RESULT_MASK;
> > > +	if (status !=3D HV_STATUS_SUCCESS) {
> >
> > Across the Hyper-V code in Linux, the way we check the hypercall result
> > is very inconsistent.  IMHO, the and'ing of hv_do_hypercall() with
> > HV_HYPERCALL_RESULT_MASK so that status can be a u16 is stylistically
> > a bit unusual.
> >
> > I'd like to see the hypercall result being stored into a u64 local vari=
able.
> > Then the subsequent test for the status should 'and' the u64 with
> > HV_HYPERCALL_RESULT_MASK to determine the result code.
> > I've made a note to go fix the places that aren't doing it that way.
> >
>=20
> I will fold in the following diff in the next version. I will also check
> if there are other instances in this patch series that need fixing.
> Pretty sure there are a few.
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index fc9941bd8653..6064f64a1295 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -337,14 +337,13 @@ static struct syscore_ops hv_syscore_ops =3D {
>  static void __init hv_get_partition_id(void)
>  {
>         struct hv_get_partition_id *output_page;
> -       u16 status;
> +       u64 status;
>         unsigned long flags;
>=20
>         local_irq_save(flags);
>         output_page =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> -       status =3D hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_=
page) &
> -               HV_HYPERCALL_RESULT_MASK;
> -       if (status !=3D HV_STATUS_SUCCESS) {
> +       status =3D hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_=
page);
> +       if ((status & HV_HYPERCALL_RESULT_MASK) !=3D HV_STATUS_SUCCESS) {
>                 /* No point in proceeding if this failed */
>                 pr_err("Failed to get partition ID: %d\n", status);
>                 BUG();
> > > +		/* No point in proceeding if this failed */
> > > +		pr_err("Failed to get partition ID: %d\n", status);
> > > +		BUG();
> > > +	}
> > > +	hv_current_partition_id =3D output_page->partition_id;
> > > +	local_irq_restore(flags);
> > > +}
> > > +
> > >  /*
> > >   * This function is to be invoked early in the boot sequence after t=
he
> > >   * hypervisor has been detected.
> > > @@ -426,6 +448,11 @@ void __init hyperv_init(void)
> > >
> > >  	register_syscore_ops(&hv_syscore_ops);
> > >
> > > +	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_ACCESS_PARTITION_ID)
> > > +		hv_get_partition_id();
> >
> > Another place where the EBX value saved into the ms_hyperv structure
> > could be used.
>=20
> If you're okay with my response earlier, this will be handled later in
> another patch (series).
>=20

Yes, that's OK.  Andrea Parri's patch series for Isolated VMs is capturing =
the
EBX value as well.

Michael
