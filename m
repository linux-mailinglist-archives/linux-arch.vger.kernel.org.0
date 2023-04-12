Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D486DF859
	for <lists+linux-arch@lfdr.de>; Wed, 12 Apr 2023 16:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjDLOZA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Apr 2023 10:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjDLOY7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2023 10:24:59 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021015.outbound.protection.outlook.com [52.101.57.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3184D183;
        Wed, 12 Apr 2023 07:24:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqUcKLIVfGkhqZeFlJ4YstsIn6vb86fJ0tpcWrayRyx4cpMecHbjyYd4cUl8z0PfIYhVNWoxPwARyjjaaECGjJ+3zGZBLedHPWzRjeKl8a77D8ytSVn0pQSoLDKui0Va+Xhm0zm5tt3Zd8Bszj/OV0wgo3FtWDwVFq7vL1xlT3VTwrb+ad9tW6xEEHR9FK5jTsRnpfjJU5+/T7TLofXYFgUb5Ne9fSYG41AWeM9BhREq7w5a7XhYg81U0ousTAY3BRz5/70fIIgDX3l+wK6OAIUwUlY61D7gxPiGJ5V4kM7cRrtLuE2pcKBktV+CE2mnhE7yaHp6Puev7fNpjkHMCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZ9WeeDGqRc0cywUe/RtAAJDCw6s/FJoU0+ZlOKH99c=;
 b=Oef3yH0+2ODdG8Qk1jFteWF1ttDVGEh23JocZtHYjEbagv/NoHgUokH1VRFpAuJyr+9Kt4Sqir9iTXNLHFluQhv1ijSAaGcBxTz4AN+Xuanr8+/P9+MahuDywBM+p3DmdwKcdFM2whFth4CtmiscoW0AdeTLd9K8DYnZFZSR5lMNAamL/yl50ZQnw0Dk7nZ75Pz7LyusJfAmfxO2Eg5nSNpOuwOBtylaMx7Eoh+1V2FHxGtL78ly52lNza4Y4EZIM6gOifnJU5txXW6Tsk1UpCTwgxLBDCDN5lKJ3pPVWZjFpx/I6ygJXY9+3t5yeIxsE2NtxtLpvGSAgtjGCPgjqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZ9WeeDGqRc0cywUe/RtAAJDCw6s/FJoU0+ZlOKH99c=;
 b=h2NlDYK5eQcrpvLQ9WBmgHhmikh8WmHaHjl5G2i9E98sASqfMHRbwbCAjJHpT6r37hiYdOKS03MbW5hY9JCWwg6vK2iHHPzS1FWpBhzRswVAWNqIkMzqxu6h3tNslOxcnppGtXaJEaM7oMeLi/Rl8f6vdevAGLTfDfGr4CjmzkE=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3584.namprd21.prod.outlook.com (2603:10b6:8:a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.3; Wed, 12 Apr
 2023 14:24:43 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6319.004; Wed, 12 Apr 2023
 14:24:42 +0000
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
CC:     "pangupta@amd.com" <pangupta@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [RFC PATCH V4 03/17] x86/hyperv: Set Virtual Trust Level in VMBus
 init message
Thread-Topic: [RFC PATCH V4 03/17] x86/hyperv: Set Virtual Trust Level in
 VMBus init message
Thread-Index: AQHZZlP0wCLp2n3CnUG8320w9R7z3a8nw8cA
Date:   Wed, 12 Apr 2023 14:24:41 +0000
Message-ID: <BYAPR21MB1688C9F78B11DA2FC7A5AAFFD79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230403174406.4180472-1-ltykernel@gmail.com>
 <20230403174406.4180472-4-ltykernel@gmail.com>
In-Reply-To: <20230403174406.4180472-4-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d6cd17f3-468a-49a0-8e34-abc05234cbf2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-12T14:08:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3584:EE_
x-ms-office365-filtering-correlation-id: 1290295d-80bf-4b5e-db42-08db3b61a7eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zIQa8a7ilLgBVTlpve3rf9OY33fTnIJ/G+zVQs3hC1GrZ73RsjMFPJPzVERkB5+HTt/L1GZDHsHK26GxXYvrw2naVVekivP1f3jeU/JG7c1JVUe7s66KIbhs/mQnZm8B1I9YxoLepk+X11sOnBa/1PU6odEWjHZ5Bol5PiswMWTWtSIUB9y5l6PE2OH/FHDXNS6EvRHhqFTnSeMxKvhKk8oXOuR+pbjNBhNSvrJ6bdPQeuV7Hg9lrEbJyAMgG4UDyLiQZNgcH2C5Wpg2DXLN79pxX9sn2XMvjs5nKC7di3/cNrbDHrlJpiTgNqjXs2IieizsSG2LWAl8h+ETOFGNiEOWDDDWbX+kB0OebpCIzx4tkk60r9xRX9A05I6ud9Dgw5/n29FcUagkfwfM4FvuonxKSf87j8r2t6j8KF8qfZKqhN9QNzQLKJiNcAaZRKbtsuMegGDuMrmhGpn/Jbb6drXz/UQdJ7sM2rKg/nxu/pl+IwHjIT15pA26wD3SKyFn9taE/S3s0oFmK6ArnHmIiRuN4f/kqbGVP3D+FChDC8wO4/KmNgOudqPTXRvQCcrVZ2GG7GUHYMlHlGwBCY+iFfYGOB1+K4/5/hwsYGnNIl4stU697qEuNdEFaBxIK7cTnrvAtLRFIRWwfJCe7snUJRBd1ydx1EfwYJI6i2Oex56Z/DAuA5oZXgPycAuH9UWo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199021)(10290500003)(54906003)(786003)(316002)(110136005)(478600001)(83380400001)(186003)(33656002)(55016003)(26005)(6506007)(9686003)(122000001)(38100700002)(921005)(38070700005)(86362001)(82950400001)(82960400001)(71200400001)(7696005)(8990500004)(41300700001)(64756008)(76116006)(66476007)(66556008)(4326008)(8676002)(66446008)(66946007)(15650500001)(5660300002)(7406005)(7416002)(2906002)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EnI7puF4l0bN1XFJEdmew+gUMi9hYWTUJVDSPOqE4okrWs6CmHp/wMl/Pa3B?=
 =?us-ascii?Q?58sNxXvrj2bq5m9slN7pdZkGedKMsDMdTdp4SahoaONvxp8NZQkjEwL4c37d?=
 =?us-ascii?Q?eb/SFURaJ5+9IBsiEDXbTnCJc/nKFFL1HlwiW1JhAstO9e6s+2Law3uhPcEg?=
 =?us-ascii?Q?YzheiYF09z8d0nVy4JBhfO3SO0iQ1T54OSC5ij54/jA9/Hh2fh6XFZLW6yJ0?=
 =?us-ascii?Q?aS0bkuRDUQ5oOLjSLPJdA8D+Yxk9Rvaetp/PlF0EDKez5vzdBMvR/iOp4IoP?=
 =?us-ascii?Q?4XsRHGv97ja+yAcjOONx/zQf7FUd1TG6cFp/oFddT+4c+kiYQXcvuGtfgK0/?=
 =?us-ascii?Q?2HeQXbKXVqjZ4Qdl3Y5wI7Q5a+U2+KdzDTpy0gseEgRBOiYSZL/TmEGcqA3J?=
 =?us-ascii?Q?p1kohuL4g5KZNje7e0yezzi/aae1XumYwEgPZ9iOTBzGIRrBL0N10CEksZB9?=
 =?us-ascii?Q?V3UGVkAdHDed4sr1bMOVBELI6KqnHcNqGBsqMRP0pI2AEJJZUdy/oZbbl526?=
 =?us-ascii?Q?fOYYt8Gh/XRvzfdiLPC2KlpYFoMllzByZKh0FlsygEJmA2YLV/anWL9GVYl2?=
 =?us-ascii?Q?EyReeULnEZR0fzehJDxt9cZz0nrX1aADlXesjSd7WOjI9YuzHQW7crmlY/6E?=
 =?us-ascii?Q?k9mVPuXvrjc2FnilN+atVMUhxQjBlfl0FOkL9Rey6QAl0xtQOdFgOudwfAXJ?=
 =?us-ascii?Q?qpgi0iG89rrLYUqHRyfj2vRYqwj+zLDTVgLCXobvdxr5LiHi28eOTLtlyF5j?=
 =?us-ascii?Q?A1jjOmcMSzdLHlIhV1TR7RngBOPwb3bCyKwc7N6lbtdtfSyM9GJ5olQjjq6e?=
 =?us-ascii?Q?ZaQsD9GtwosuRF1mH906x4xrp0ft6KT9grixgP1sx/KVe6ZMOfz/rcnfm3fA?=
 =?us-ascii?Q?OKMxd0jST+UwM4DOXl55Iqnge1D/kKcQ5Rm2eDUbylrg/o0fLbNQfowsvKwG?=
 =?us-ascii?Q?hNWZPpmMId6smvnbBItFA+GcWijKOUzsXFRzy5/Eh30Osf8eJd6JUQuf4r7G?=
 =?us-ascii?Q?IGHbG/apdpU4JMAiUyA85VVkLkwBCMLdReoTf63+Rv61mCeiVcx2G1sSvbt7?=
 =?us-ascii?Q?06GzxcxUHtzDjCfwHYsgd3A0xk3m91NqvCXVRe7fQBh6lwpjDqNnRNOMygrh?=
 =?us-ascii?Q?jFazvUVDpkeGgzcMAKn5rKYr+E0GNJjt7M5YNvgs67uiIm1qdofNlBVUxDif?=
 =?us-ascii?Q?ZdpWAiESdGx5bIcyaFaPvOksKhXq8cgkO2U/7VChw3XWCTq4BFBNHQowhl+T?=
 =?us-ascii?Q?kS1iShgyd6Hik4oT50W2jPW+vFNggmfLkv6BgNgxRLwu+4GODjFno0S30IOD?=
 =?us-ascii?Q?JT9hAP8lQVzOHHQ4N8FUYov1Rh5TOvASLtSCZvVjj/MHuW57eiRIiGlvf78M?=
 =?us-ascii?Q?261qzyFQ1BkM4pDlNPugwjwHs4Rcb6BqdgtRqDMF08D/eqDsv4swuQrgml4f?=
 =?us-ascii?Q?jXdMw+izOFrTAg5K8t9FwWwOwfGQEJI9ktA9aNinMWqWtsLOCPv5foTTOaKE?=
 =?us-ascii?Q?P2TFQ5Q1i3awuwwOLIYyvPBi7idmVgg5bW99uxCigM+HsPONLJy0XB9UN22X?=
 =?us-ascii?Q?wAjsDE7ciPkKSUac9hpuvHqjWDn8CbBfKgIssHjytmTVXsAhT9I3bB3+HL9u?=
 =?us-ascii?Q?DQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1290295d-80bf-4b5e-db42-08db3b61a7eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 14:24:41.8122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kEC8YMpPyFFaT9On6vO/Kl+uyB2wztvYRq3P9H9pVE0bkyUHN2xah+7sKKgFvdBFWdap+UNDWQaXmt1V+J9ZfuF5DdEMkrfPa4+Pdo8nFMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3584
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, April 3, 2023 10:44 AM
>=20
> sev-snp guest provides vtl(Virtual Trust Level) and
> get it from hyperv hvcall via HVCALL_GET_VP_REGISTERS.
> Set target vtl in the VMBus init message.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC v3:
>        * Use the standard helper functions to check hypercall result
>        * Fix coding style
>=20
> Change since RFC v2:
>        * Rename get_current_vtl() to get_vtl()
>        * Fix some coding style issues
> ---
>  arch/x86/hyperv/hv_init.c          | 36 ++++++++++++++++++++++++++++++
>  arch/x86/include/asm/hyperv-tlfs.h |  7 ++++++
>  drivers/hv/connection.c            |  1 +
>  include/asm-generic/mshyperv.h     |  2 ++
>  include/linux/hyperv.h             |  4 ++--
>  5 files changed, 48 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 9f3e2d71d015..7602db5ad4aa 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -384,6 +384,40 @@ static void __init hv_get_partition_id(void)
>  	local_irq_restore(flags);
>  }
>=20
> +static u8 __init get_vtl(void)
> +{
> +	u64 control =3D HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
> +	struct hv_get_vp_registers_input *input;
> +	struct hv_get_vp_registers_output *output;
> +	u64 vtl =3D 0;
> +	u64 ret;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	input =3D *(struct hv_get_vp_registers_input **)this_cpu_ptr(hyperv_pcp=
u_input_arg);

The cast to struct hv_get_vp_registers_input isn't needed here.  Just do:

	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);

I know we have other code that references hyperv_pcpu_input_arg with a more
complicated code sequence, but it's really not necessary.  At some point, w=
e
should go back and clean those up, but let's not add any new cases. :-)


> +	output =3D (struct hv_get_vp_registers_output *)input;
> +	if (!input) {
> +		local_irq_restore(flags);
> +		goto done;
> +	}
> +
> +	memset(input, 0, sizeof(*input) + sizeof(input->element[0]));

Use struct_size() to calculate the size of a structure plus a trailing
variable size array.

> +	input->header.partitionid =3D HV_PARTITION_ID_SELF;
> +	input->header.vpindex =3D HV_VP_INDEX_SELF;
> +	input->header.inputvtl =3D 0;
> +	input->element[0].name0 =3D HV_X64_REGISTER_VSM_VP_STATUS;
> +
> +	ret =3D hv_do_hypercall(control, input, output);
> +	if (hv_result_success(ret))
> +		vtl =3D output->as64.low & HV_X64_VTL_MASK;
> +	else
> +		pr_err("Hyper-V: failed to get VTL!");

Let's include the hypercall status in the failure message.  If a failure ev=
er
happens, we will really want to know what that status is.  :-)

> +	local_irq_restore(flags);
> +
> +done:
> +	return vtl;
> +}
> +
>  /*
>   * This function is to be invoked early in the boot sequence after the
>   * hypervisor has been detected.
> @@ -512,6 +546,8 @@ void __init hyperv_init(void)
>  	/* Query the VMs extended capability once, so that it can be cached. */
>  	hv_query_ext_cap(0);
>=20
> +	/* Find the VTL */
> +	ms_hyperv.vtl =3D get_vtl();
>  	return;
>=20
>  clean_guest_os_id:
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index b4fb75bd1013..3d3f014976e8 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -301,6 +301,13 @@ enum hv_isolation_type {
>  #define HV_X64_MSR_TIME_REF_COUNT	HV_REGISTER_TIME_REF_COUNT
>  #define HV_X64_MSR_REFERENCE_TSC	HV_REGISTER_REFERENCE_TSC
>=20
> +/*
> + * Registers are only accessible via HVCALL_GET_VP_REGISTERS hvcall and
> + * there is not associated MSR address.
> + */
> +#define	HV_X64_REGISTER_VSM_VP_STATUS	0x000D0003
> +#define	HV_X64_VTL_MASK			GENMASK(3, 0)
> +
>  /* Hyper-V memory host visibility */
>  enum hv_mem_host_visibility {
>  	VMBUS_PAGE_NOT_VISIBLE		=3D 0,
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index f670cfd2e056..e4c39f4016ad 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -98,6 +98,7 @@ int vmbus_negotiate_version(struct vmbus_channel_msginf=
o *msginfo, u32 version)
>  	 */
>  	if (version >=3D VERSION_WIN10_V5) {
>  		msg->msg_sint =3D VMBUS_MESSAGE_SINT;
> +		msg->msg_vtl =3D ms_hyperv.vtl;
>  		vmbus_connection.msg_conn_id =3D VMBUS_MESSAGE_CONNECTION_ID_4;
>  	} else {
>  		msg->interrupt_page =3D virt_to_phys(vmbus_connection.int_page);
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index afcd9ae9588c..f91fb06634f0 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -48,6 +48,7 @@ struct ms_hyperv_info {
>  		};
>  	};
>  	u64 shared_gpa_boundary;
> +	u8 vtl;
>  };
>  extern struct ms_hyperv_info ms_hyperv;
>  extern bool hv_nested;
> @@ -58,6 +59,7 @@ extern void * __percpu *hyperv_pcpu_output_arg;
>  extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputadd=
r);
>  extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
>  extern bool hv_isolation_type_snp(void);
> +extern bool hv_isolation_type_en_snp(void);

Why is this extern added as part of this patch?  There are not any new
references to hv_isolation_type_en_snp() that would need it.

>=20
>  /* Helper functions that provide a consistent pattern for checking Hyper=
-V hypercall status. */
>  static inline int hv_result(u64 status)
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index bfbc37ce223b..1f2bfec4abde 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -665,8 +665,8 @@ struct vmbus_channel_initiate_contact {
>  		u64 interrupt_page;
>  		struct {
>  			u8	msg_sint;
> -			u8	padding1[3];
> -			u32	padding2;
> +			u8	msg_vtl;
> +			u8	reserved[6];
>  		};
>  	};
>  	u64 monitor_page1;
> --
> 2.25.1

