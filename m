Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C136464A655
	for <lists+linux-arch@lfdr.de>; Mon, 12 Dec 2022 18:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiLLR41 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Dec 2022 12:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiLLR40 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Dec 2022 12:56:26 -0500
Received: from CO1PR02CU001-vft-obe.outbound.protection.outlook.com (mail-westus2azon11021017.outbound.protection.outlook.com [52.101.47.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ABAF582;
        Mon, 12 Dec 2022 09:56:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOAdA2MPI72AGsmcCpHPsTsUTbZiFfV22OcUNkRMU5XrikvBJbQs+k/6ageEoUOIND8cYo+RCcqTqRy60hyn+vKpd0V5OERodSGXjMOzrmHwR0I6HEs/zTCz/X6ceKCFzmA7XDFTHGgEFHvbwEzmHCyRKld+r4cvJ0QVDc8eR/HHyeYuyj46JSCiwiRFKgMFvHpb0W4vKMyncOdcqVtYjMOQ4O+G+QJFV/HTxxE7iguaTqN7XB9gnYj8Z/pdj4tdW4aav7RE753vqL3gwWmy7jbNYpsPdEs7zDvevi5ZGHnabEWKgXOA5u7fxSfndPV2SC5l8hFGjwrHYnRaP+fEVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toqGopddtErDssBF0Ptg2pVOu4MBlWNW2oLFykUcgmw=;
 b=jEMK3P3UIHur3u5Sd3c5TyiktOzaFqqnWIuZNxJ48sVhJQ2WhF5Mx2xohuhLA11TT7c3eCZnfhCaRTuZ6bWwOnmy8tEvno88pCIEz2xgPSsatMCUD+1VJ1p8RBYYWOsSQmDbkOCuRDZo//IcE4jviHwosOTLh/hUoxmt12akQMg/NDKGXZbm3Wu9RDP/URF+ajXqQ8g2W0etU+JqHKi6NfuqbOwsz2iIJ3TgHtA7HYb+2OUj4j1wdwMO2FJZejLQASA9o/wBfIGkViD1MlsduIE+7LZ/qF/fdthpwZpeDNDlwhnFb5LUCdr+QZi+XkdFwSHO59yZzNkuqzixlM9m/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toqGopddtErDssBF0Ptg2pVOu4MBlWNW2oLFykUcgmw=;
 b=cCp6JqwPAWERv0BY3QKeJOR/bwoAqPwE8RDZjXJrH9s9PDXDBs9PcZR5Rk2vKFvHwwitnxBQ2fbh2Kxv6RBfvobXvUec6FM7Oxqr/WzrPqdmK0wyIhR7MjUUvEdAjcSI+J+nphs3UWAV5Wzap/lAY103LjeZITB41nYsuUAw5Oo=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SJ0PR21MB2056.namprd21.prod.outlook.com (2603:10b6:a03:395::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.2; Mon, 12 Dec
 2022 17:56:18 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%8]) with mapi id 15.20.5944.002; Mon, 12 Dec 2022
 17:56:18 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jgross@suse.com" <jgross@suse.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "jiangshan.ljs@antgroup.com" <jiangshan.ljs@antgroup.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "srutherford@google.com" <srutherford@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "venu.busireddy@oracle.com" <venu.busireddy@oracle.com>,
        "sterritt@google.com" <sterritt@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [RFC PATCH V2 02/18] x86/hyperv: Add sev-snp enlightened guest
 specific config
Thread-Topic: [RFC PATCH V2 02/18] x86/hyperv: Add sev-snp enlightened guest
 specific config
Thread-Index: AQHY+8mZf+1Iyx0OH0GDW+MmqmAne65qpz9g
Date:   Mon, 12 Dec 2022 17:56:18 +0000
Message-ID: <BYAPR21MB168814EC5FA61976B69158B7D7E29@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-3-ltykernel@gmail.com>
In-Reply-To: <20221119034633.1728632-3-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=206f8b0a-ef16-45d8-a90b-3e452e789463;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-12T17:30:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SJ0PR21MB2056:EE_
x-ms-office365-filtering-correlation-id: f2611294-4396-42da-9253-08dadc6a2bb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KfxAieJfIEiDwNLekq+7h8jEzWEVintCB8XflpdwmdP6NHSDCLcnx9mJvuyIzHFnSeVT+MAD+qaWkuMmXbFq127zeytMc+Zcp7QyZPPZQvX9GGYVVN3lnKqC4yl20rlFISGPH114yPMVo3S6IshoFngB5GnGJZrBMJtCzv8AnpPMPMPm8MQ0gHJjTM8PqatU+C+52SDocz8AgXGPgBu80C0afMDt0Hsbcj/QnD033v+9blVTCVA3NDF8rashEsx5zkwM75btIXzT2//1lfHaVxNaQCM2Z2HHOHmtZ5wdq3zjjUy3KLC9i4YmJ6Uzj4Yo43y8Xrw3ycoFmsNZvQewnKtS5OfAH/mpxdsxcwSiBOjOm+TsO1PYM4SPceY5NFakpKu/fO7EuhnCtyjHo1hg1UoJWJYSTGeogDV45ZTiJyz/3Ai8mRsiPe5SI6e3/91lezEi8YvJCFx61OkJ/akD/BefAMwoJ5lfaWSd/Vg3V2I0xKEFEtse2QJsqaAvFynBorZNmEjeSDtQ7aKFr5Pm0jCmmUQOC1FJqnepyz/BRdc66hi/nzHxl/jRlx3GHrEC2Hb1fv68/awOrW/UlV0QSDmicozGul5GOZ/hrBLdzFpIXXIR0hwq6Y5/k/bjmQjTKGmoT3UNi3BQoVdKpIoryhLl6CfjAQ9nF+NwQlvnMJC5HWhXBDyeyFTG3vbDAayULSpGWv/fpBpwcZ15TK/vcsC8QXPiSVA8HObI2BX3dCCA+d2AGnxmtflDbVwrc/n7OkdNkck5FPukcD+1joIQqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(64756008)(2906002)(8990500004)(66446008)(76116006)(4326008)(66946007)(66476007)(921005)(38070700005)(8676002)(5660300002)(7406005)(7416002)(66556008)(41300700001)(82960400001)(110136005)(54906003)(316002)(82950400001)(478600001)(52536014)(71200400001)(10290500003)(8936002)(55016003)(26005)(9686003)(186003)(83380400001)(86362001)(38100700002)(33656002)(6506007)(7696005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uA55p/tiHZv/IVsnepAnH4dr34+IMhdnp2qqcn2stFXXhP71IQLj54aoBHpH?=
 =?us-ascii?Q?2vO7VdFyNvFnOiMIiIpgWQB7wYOXuLjQnkgqBsVK+CRkVygPyLgVJOtrHVbe?=
 =?us-ascii?Q?/C48Mcsoa+iUyjkfV7ZJMfHGA4Hswd5a5pYG9ZxoM/IteytpmlVHmndANbWN?=
 =?us-ascii?Q?jd5yNkdXcPx2x1+97vtk0uXcwz7JFdYB17A6GD/Hri9tiUHqxjMAFSkqBDm0?=
 =?us-ascii?Q?pPUlkThatthkrUBq4R/yqO9i1ORj0oEguiGxJMxKOdglsdfnslGtWJXytcgy?=
 =?us-ascii?Q?vJnm8XxorkSWqZycK0ju1If1IleCk5E64kAlc90THwiOtyM/Lw835YYOQS+R?=
 =?us-ascii?Q?hiq4heUtf84haauRLlVZpKHIjGmO7WpwRl9rEGVFRaq4ND7blO8W7zUULg2M?=
 =?us-ascii?Q?Duom1rvjL1aHOYG1473yYQMmVfBUoIpNE2XNGAYxalD43X0IW9KW5+erpSyt?=
 =?us-ascii?Q?Jmpea4iE+ICYXJl81+KJgrZduufrfFEY/OHcUBLNKuK+LM/kHh9FD7Sdhtwu?=
 =?us-ascii?Q?1yY1NWALOVWidrepDlJqsawSJrsJn+LWHuyJmqE5il2wI198r7p8S5RpiRM0?=
 =?us-ascii?Q?sCO7czB2TT7xawFmOZbI4MFOfc/tZaii37idam6+9eg0iJEJTYhFX2IJ2PbP?=
 =?us-ascii?Q?F7VAHA47R6f9QImpRBNYV1tSNs4RMPTzxVDxUGcS8eYXTWko2oTNqIZUeWLA?=
 =?us-ascii?Q?t4+6TtBMp3JOd/I5FaFQ44nQpfm+t8UbWTX6adKJ0ReM4HGuzNMkSSiAFn1j?=
 =?us-ascii?Q?V5i9D1NWIct5Ar94pvX86CXvMV7ILA4I7oY9CcoYOiuXDxgDr9czWuWJtbAN?=
 =?us-ascii?Q?G/XMjNa7NDtllhSREEc4fDSGOkBjKc0416UmtOhMEWaBJlsiloXot3bz/Byx?=
 =?us-ascii?Q?Zeu78SU/8amH+6TqAXmhOqFXMEMA5dfc8zrQfiGWIqAZUG0IKHb8w9RkpggI?=
 =?us-ascii?Q?FSjdQFH0Dd8LLniFg4goz2m/uBQSJjvkEhCVECUYJ22SaqS+x2p+DBbO1Uyf?=
 =?us-ascii?Q?VLChZL2DnM3m9J2fz0jjZrnAywGoPFBsj6tKWyEx2fwdNFr/8DS4kweBhSnA?=
 =?us-ascii?Q?otEK1ponU3N/dxQ507etiN8W8mfB7bWMD8xUUx+C1XF7GifGS0HH1HKXywb4?=
 =?us-ascii?Q?72j1bV/vMHz/uI8qOZDGTtQ2KjNqifqI5dtMALgjgOa0kytSlwJVDkRbnXQg?=
 =?us-ascii?Q?0OWcXhFQYhuz4ER73Szyks/Yd1rT2uiIjRE1tdxrUWsOnVfJLUsw+3pj99bw?=
 =?us-ascii?Q?TGJDvARmmhAHQkPLRx22NdXFTuG5fF0RnNnoIp/IJ+pEBftPXTa5szISTiMD?=
 =?us-ascii?Q?EoiuzBsXP7HkUdCOE7n9tWOphNXDlXuz91clvbwCVt5hTipBKOmBS2vYIyjj?=
 =?us-ascii?Q?zbtc7+/D86bTEdvX9tckiC7mQ9VXyZDBIF/CTvNGst6ZyUt92gbheZzOve2H?=
 =?us-ascii?Q?o8y65eUn9RNG5sO3ZYJlKUTuMDNhfsJvk4wvbqEWnPsGQ/vtZeqklI/mv5Z8?=
 =?us-ascii?Q?Ia3H1X92lE95GRHek9XVllCxFCN4ppZfua7KHmlwLQh6k6R6I8/78qUGYU9e?=
 =?us-ascii?Q?VWn0WjnM1J45E4J/yF/PzUVaz6SCQq16+iMtpYx0aPPNVZ4/rZNDj1jqjvn+?=
 =?us-ascii?Q?qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2611294-4396-42da-9253-08dadc6a2bb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 17:56:18.3826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xz+RVEaa3mms5Q56TP+iZkoHcAxK0FKZ/l9weqrO1mFnl3lhMdmJ+IJnvib3yN5gIq03uDvogfQxk+dxPngQX4DfEFfSoTMiTNAKsu6/x7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2056
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Friday, November 18, 2022 7:46=
 PM
>=20
> Introduce static key isolation_type_en_snp for enlightened
> guest check and add some specific options in ms_hyperv_init_
> platform().
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/ivm.c           | 12 +++++++++++-
>  arch/x86/include/asm/mshyperv.h |  2 ++
>  arch/x86/kernel/cpu/mshyperv.c  | 29 ++++++++++++++++++++++++-----
>  drivers/hv/hv_common.c          |  7 +++++++
>  4 files changed, 44 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 1dbcbd9da74d..e9c30dad3419 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -259,10 +259,20 @@ bool hv_is_isolation_supported(void)
>  }
>=20
>  DEFINE_STATIC_KEY_FALSE(isolation_type_snp);
> +DEFINE_STATIC_KEY_FALSE(isolation_type_en_snp);
> +
> +/*
> + * hv_isolation_type_en_snp - Check system runs in the AMD SEV-SNP based
> + * isolation enlightened VM.
> + */
> +bool hv_isolation_type_en_snp(void)
> +{
> +	return static_branch_unlikely(&isolation_type_en_snp);
> +}
>=20
>  /*
>   * hv_isolation_type_snp - Check system runs in the AMD SEV-SNP based
> - * isolation VM.
> + * isolation VM with vTOM support.
>   */
>  bool hv_isolation_type_snp(void)
>  {
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 61f0c206bff0..9b8c3f638845 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -14,6 +14,7 @@
>  union hv_ghcb;
>=20
>  DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
> +DECLARE_STATIC_KEY_FALSE(isolation_type_en_snp);
>=20
>  typedef int (*hyperv_fill_flush_list_func)(
>  		struct hv_guest_mapping_flush_list *flush,
> @@ -32,6 +33,7 @@ extern u64 hv_current_partition_id;
>=20
>  extern union hv_ghcb * __percpu *hv_ghcb_pg;
>=20
> +extern bool hv_isolation_type_en_snp(void);

This file also has a declaration for hv_isolation_type_snp().  I
think this new declaration is near the beginning of this file so
that it can be referenced by hv_do_hypercall() and related
functions in Patch 6 of this series.  So maybe move the
declaration of hv_isolation_type_snp() up so it is adjacent
to this one?  It would make sense for the two to be together.

>  int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>  int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flag=
s);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 831613959a92..2ea4f21c6172 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -273,6 +273,21 @@ static void __init ms_hyperv_init_platform(void)
>  	ms_hyperv.misc_features =3D cpuid_edx(HYPERV_CPUID_FEATURES);
>  	ms_hyperv.hints    =3D cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
>=20
> +	/*
> +	 * Add custom configuration for SEV-SNP Enlightened guest
> +	 */
> +	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
> +		ms_hyperv.features |=3D HV_ACCESS_FREQUENCY_MSRS;
> +		ms_hyperv.misc_features |=3D HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
> +		ms_hyperv.misc_features &=3D ~HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
> +		ms_hyperv.hints |=3D HV_DEPRECATING_AEOI_RECOMMENDED;
> +		ms_hyperv.hints |=3D HV_X64_APIC_ACCESS_RECOMMENDED;
> +		ms_hyperv.hints |=3D HV_X64_CLUSTER_IPI_RECOMMENDED;
> +	}
> +
> +	pr_info("Hyper-V: enlightment features 0x%x, hints 0x%x, misc 0x%x\n",
> +		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);
> +

What's the reason for this additional call to pr_info()?  There's a call to=
 pr_info()
a couple of lines below that displays the same information, and a little bi=
t more.
It seems like the above call should be deleted, as I think we should try to=
 be as
consistent as possible in the output.

>  	hv_max_functions_eax =3D cpuid_eax(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTION=
S);
>=20
>  	pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, hints 0x%x, misc=
 0x%x\n",
> @@ -328,18 +343,22 @@ static void __init ms_hyperv_init_platform(void)
>  		ms_hyperv.shared_gpa_boundary =3D
>  			BIT_ULL(ms_hyperv.shared_gpa_boundary_bits);
>=20
> -		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
> -			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
> -
> -		if (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_SNP) {
> +		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
> +			static_branch_enable(&isolation_type_en_snp);
> +		} else if (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_SNP) {
>  			static_branch_enable(&isolation_type_snp);
>  #ifdef CONFIG_SWIOTLB
>  			swiotlb_unencrypted_base =3D ms_hyperv.shared_gpa_boundary;
>  #endif
>  		}
> +
> +		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
> +			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
> +

Is there a reason for moving this pr_info() down a few lines?  I can't see =
that the
intervening code changes any of the settings that are displayed, so it shou=
ld be
good in the original location.  Just trying to minimize changes that don't =
add value ...

>  		/* Isolation VMs are unenlightened SEV-based VMs, thus this check: */
>  		if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
> -			if (hv_get_isolation_type() !=3D HV_ISOLATION_TYPE_NONE)
> +			if (hv_get_isolation_type() !=3D HV_ISOLATION_TYPE_NONE
> +			    && !cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>  				cc_set_vendor(CC_VENDOR_HYPERV);
>  		}
>  	}
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index ae68298c0dca..2c6602571c47 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -268,6 +268,13 @@ bool __weak hv_isolation_type_snp(void)
>  }
>  EXPORT_SYMBOL_GPL(hv_isolation_type_snp);
>=20
> +bool __weak hv_isolation_type_en_snp(void)
> +{
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(hv_isolation_type_en_snp);
> +
> +

Nit: One blank line is sufficient.  Don't need to add two.

>  void __weak hv_setup_vmbus_handler(void (*handler)(void))
>  {
>  }
> --
> 2.25.1

