Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9449B74AD8D
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jul 2023 11:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjGGJIC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jul 2023 05:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjGGJIB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jul 2023 05:08:01 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11020016.outbound.protection.outlook.com [52.101.128.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193991FF0;
        Fri,  7 Jul 2023 02:08:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnPk+Uy0B+BgSZCH4omt7cvvdDaCojVdaakBmw/r8TYxmcx2jSrvz+Th39zONTIsXWf02XWIC1irmgp5ZSZP9DBdMALPp/83rm4j0kOozZE2KkispJ9xnlJYlpegANDvCmFSFXw2LKNwaaNlxzDlm02OLhjyRW/yr9iOYotA7SYRNVjfuzcHZE2rg1LW3aXXZBrFJEOYwK25v1KihkFOQTC0UgAjPdV/pPa3DVyN1YqKvpxfYmwP+s1APgjLytSvcsMd3zPPWatUWmB0bQ4TCrCfGnndtlMVSH2nUWoVsDzutWP8641fz+qxb+LJcYAPwQN5kP3U3SZ711lAbwTwjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaKFVLJXYT/0HGPRw16xpzTPWxAd0iLBmMN+UoN08Ng=;
 b=IdeL1RlQVWEUnXZWiFOgdE4zjADQyNm9etNwPDpfYJidK4KqFy4QJQr4hDJ4+MSrW0mV/SDnepdcx4vr1i0BeS9KFpsoCHimJUP12sMtlWkPqAgeLW9Wbk5NYWDqCTIItE+N3hOii+hmGUvbvdMBvDqWDVAl3EIe0aLYUkFGd6Igngg3gUGAXZcbg0zbM7/xdthcn6ux71HZoQrtK1AFz8ytN3tmFVQD1Yq/WgquK5jnH954/NRzKXwcrj8l7o348GH6tPCnoi3fK/OwE/o/dDnWOBpjmvhGTD9BBdL0rG7W9EGZMDMAKb3rq6eRRC+bGcPeX9MPgFUGG//BTZCfQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaKFVLJXYT/0HGPRw16xpzTPWxAd0iLBmMN+UoN08Ng=;
 b=DFJpGRwP8jESZF2DdHw9jmNpaB94gGduOlxgw891c5X41D1d9FLm0Ly8aChyK+sfHErob4e8rB5cldYmAceG1iip/mGmuelhssXrSJAu0055nTznCEYbWKOX0gvz3btDbygObeURBmgLGFxp3Dau6ZFPs8juSB8jGIBBYMO3+8U=
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::8) by
 TYSP153MB0981.APCP153.PROD.OUTLOOK.COM (2603:1096:400:415::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.13; Fri, 7 Jul 2023 09:07:55 +0000
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::5d43:697d:e190:459a]) by PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::5d43:697d:e190:459a%6]) with mapi id 15.20.6588.001; Fri, 7 Jul 2023
 09:07:55 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [EXTERNAL] [PATCH V2 2/9] x86/hyperv: Set Virtual Trust Level in
 VMBus init message
Thread-Topic: [EXTERNAL] [PATCH V2 2/9] x86/hyperv: Set Virtual Trust Level in
 VMBus init message
Thread-Index: AQHZqKeHE/Z/njW7J0ynfWu9eGUrHK+uEnnQ
Date:   Fri, 7 Jul 2023 09:07:54 +0000
Message-ID: <PUZP153MB0749BAAA8E288D76938704A5BE2DA@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
References: <20230627032248.2170007-1-ltykernel@gmail.com>
 <20230627032248.2170007-3-ltykernel@gmail.com>
In-Reply-To: <20230627032248.2170007-3-ltykernel@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4f2f1155-dace-4622-883d-461028b7aaa0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-07T09:03:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0749:EE_|TYSP153MB0981:EE_
x-ms-office365-filtering-correlation-id: d6c36a27-5305-46f3-d2ef-08db7ec9a66b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rl3FXfTRiGXlmIxAX44Kzp3NJ71CjJUUZCfsd38HCSKYpc1aJDrCowfe75j1+PkrZl3W7AvPjqUZX6+2fqxq/InjEZTQ1ej5StOFuZ6CqYH6gM0aHOGDTfk/FNamYVNts6efRgTz7zRZv3Fbr0UU9wyMDEsuPFkPcbS76sztHgNyS36GSxHsQG1dDRH4y1AnV9+shou3IMDBisVZb/Y/s2uLbg6Dlv7TiTa3L0bpZ9JzXK5lijIwd5J0bufscC8euxGST6USTbOtY4wN9IIEL1ceiAdQ4DRnzfxgeSDPSbCvLV5v+0qcX8EfE2B2SehOYXrFAhDLyHSsh4iaDdHMb/h0LqFCRD1Op1VN6gFXfJ9b9vxDgY22VWSei8kpBQC9M0LELOpcW77OLw3YDh0orvDcPkRO1Bt82Vmb1qDP5AYvQ/rzo9qWE2/AZXW2n1wV0fIlnNmvYpp2MOk0IuPsTgFWBIhS2tSSCZk15yQF8esIbX9Jvx6YC3ADNyKeb/vVKkrFzUX2aXNrIDd/rgyhvKcJJF4NjP3cW7P0OpiYL26bf5EI9JkKTruj3hijncbQYTaTeWByLvwDKblJ+MgYukRnBrEH2DaccEyje2bKLMBU/Y9/FCxCeY0iHqmhouOylYTqaKRlZVMVbEGa4jw/yMhsOKv9ojTvGt5Jrg1XROSI6/H2HftxMyQE/DEWM4z+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0749.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(5660300002)(8990500004)(2906002)(54906003)(8676002)(110136005)(478600001)(10290500003)(7416002)(15650500001)(4326008)(6636002)(41300700001)(8936002)(316002)(76116006)(64756008)(66446008)(66556008)(66476007)(66946007)(71200400001)(83380400001)(122000001)(38100700002)(921005)(82960400001)(82950400001)(33656002)(86362001)(9686003)(6506007)(7696005)(52536014)(38070700005)(55016003)(186003)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w7dNpXnscLmh1eO3giFsTlilzmIOCD8UzUsR+ngQ3w8Ne/lvxvx5+GpbvDnV?=
 =?us-ascii?Q?ErowZyU1NPYYtBdPx9njPPU3qzjSORagF0asKe9s7UG3/RvOrpTcRtyYcu3a?=
 =?us-ascii?Q?bNRb82hqiN/jRF7kfbWrUviMxHvGgPOdw95wU0ZVpbFdVt1DQp7WP4pB2+nr?=
 =?us-ascii?Q?J+9QI7aeIgzwyioc+VvO/dN/nZcVtTtv1S/Pnxh4uqwmKjYI7Hi2wGab3sMd?=
 =?us-ascii?Q?gtH5PTXNp/QBzC+DD2+o6wS9BdZQFFYiG5/4kLJvYhswg0B4mCtnt5A84SPl?=
 =?us-ascii?Q?Wo3M3kfZAzmDCZ/8E1Qhs6nju3aFGEUHCtwFNHjxVFMX0P6TBqAN8Gml/Vxn?=
 =?us-ascii?Q?qd9AYen8hPk9lAkGw0giWJ2Om2vEeHVEBi27LXm6I9RSHqbRbzd0NwJqoIWW?=
 =?us-ascii?Q?l5WxHEW5KuRTfAGV6i60TDMLgf1TNISmR/H/cWvUVX6Y4iQVSd7TSlIF4K2w?=
 =?us-ascii?Q?mPhLYQf2AlUnuQfvg/E3cXk3XCkRqSG0bsKoWALOLdJDYvqdrFucvS0q9kzv?=
 =?us-ascii?Q?hw3N0iyMR5FgFsg5Ml8KednIaEGEAspBRF7hbR0ufRu7o+IU3tVkGzD3+/Fj?=
 =?us-ascii?Q?6/PZtoElEB/C58PVWM8tKbPugfvRgNTMiSkaVulW55PvtVgqupLPIpQkO6rV?=
 =?us-ascii?Q?5eqndsRSiCrQ7hW+xu9l9+VpC+uZRoZSsgBIih5jj54nAwnYlMfhip6SpV+f?=
 =?us-ascii?Q?MpXbMqamA1DWQ6dSYqqIzMhZDdcWbyHHabLGiL+0cw+3MPDlD9OFKsABA2iB?=
 =?us-ascii?Q?gKmxe4IPU8nlaplwQCrqIeZ9Cbq6WsEeCOm3j3U6M+A7pUGPU1ZPVwEwpw0P?=
 =?us-ascii?Q?Un1qA1KnwzF2OjKoCw6VdRwpn1eSUBcUGU4qH+ncuhYSa7LJ+Xq7a7eU72dk?=
 =?us-ascii?Q?3CTTDNcWy7f/9V7uHDV1t8hLMIIadzaDWZwvSFvjgcOkI0AYtTYMo46po+xF?=
 =?us-ascii?Q?/aEm3s2ExeHSCQ8CcJKZ+iILnZHq+fzHOcls7cHziXhHXEEfHjYuJJ3ARCSq?=
 =?us-ascii?Q?+q/X8XpNWGIY1uLPPQhCeZFg6WAR0HskhKJ508x7pWdPl1zKHxfF6OOC2NG3?=
 =?us-ascii?Q?B7tlyPPWLhCJn15z0sCvGd+0Nd76wEJpMD0dL39djfNRGL8fAu7XRVMwHKsW?=
 =?us-ascii?Q?O/MEgr9xOCkNKFnRNWuy6X0WGDC9SrfnxJQCtvzGv564NrVt65otuahnhzud?=
 =?us-ascii?Q?Ag0wFuwO/0+r6PSpG2SrLTmGsWR17arDVZHq7fcHoalaY3AtDyCsXy+FoVMl?=
 =?us-ascii?Q?8uutxCCgmaJoFEbOf9Dd8/zGzW4TKiBL91r8wC9JXNjRDGOPOxHxwo+JMFAU?=
 =?us-ascii?Q?8FDXBr8D2DGxx1Zo44yv6PFWyIOsaXDtVJev97cLeEGbu14/7PAf7okVZexR?=
 =?us-ascii?Q?xWW1dqrc0H8uQHzjZXmREvidtALagBLoyZGxNxooDG/Glhdb6LGcFTUNonKm?=
 =?us-ascii?Q?Rz38GbPPE5iKmasAWiAdJqt54s9JYRqe9o2YsrLKQ6S5EA3eTd9PJKqSo2Eu?=
 =?us-ascii?Q?ECUJ++0YPUlL1AMyu989vhLDvvTGv8rwq6d1MI/OIaIc1N79wwLB7aetv1ys?=
 =?us-ascii?Q?nrSuhIYjBT6rjGQ/jHxOVuUd0CIMchnak13oUuPo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c36a27-5305-46f3-d2ef-08db7ec9a66b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 09:07:54.8308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CgT1KLtb2+OtfJVdSjsz8uy30Xh/ulmhUTJaeKyOy6aUMXo80HODodIVPfEtOR9ZbvYWAJPRTwei5JaaL/ZhyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSP153MB0981
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> -----Original Message-----
> From: Tianyu Lan <ltykernel@gmail.com>
> Sent: Tuesday, June 27, 2023 8:53 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; tglx@linutronix.de; mingo@redhat.com;
> bp@alien8.de; dave.hansen@linux.intel.com; x86@kernel.org;
> hpa@zytor.com; daniel.lezcano@linaro.org; arnd@arndb.de; Michael Kelley
> (LINUX) <mikelley@microsoft.com>
> Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>; linux-arch@vger.kernel.org;
> linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org;
> vkuznets@redhat.com
> Subject: [EXTERNAL] [PATCH V2 2/9] x86/hyperv: Set Virtual Trust Level in
> VMBus init message
>=20
> From: Tianyu Lan <tiala@microsoft.com>
>=20
> SEV-SNP guest provides vtl(Virtual Trust Level) and get it from Hyper-V h=
vcall
> via register hvcall HVCALL_ GET_VP_REGISTERS.
>=20
> During initialization of VMBus, vtl needs to be set in the VMBus init mes=
sage.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c          | 36 ++++++++++++++++++++++++++++++
>  arch/x86/include/asm/hyperv-tlfs.h |  7 ++++++
>  drivers/hv/connection.c            |  1 +
>  include/asm-generic/mshyperv.h     |  1 +
>  include/linux/hyperv.h             |  4 ++--
>  5 files changed, 47 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c index
> 6c04b52f139b..1ba367a9686e 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -378,6 +378,40 @@ static void __init hv_get_partition_id(void)
>  	local_irq_restore(flags);
>  }
>=20
> +static u8 __init get_vtl(void)
> +{
> +	u64 control =3D HV_HYPERCALL_REP_COMP_1 |
> HVCALL_GET_VP_REGISTERS;
> +	struct hv_get_vp_registers_input *input;
> +	struct hv_get_vp_registers_output *output;
> +	u64 vtl =3D 0;
> +	u64 ret;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output =3D (struct hv_get_vp_registers_output *)input;
> +	if (!input) {
> +		local_irq_restore(flags);
> +		goto done;
> +	}
> +
> +	memset(input, 0, struct_size(input, element, 1));
> +	input->header.partitionid =3D HV_PARTITION_ID_SELF;
> +	input->header.vpindex =3D HV_VP_INDEX_SELF;
> +	input->header.inputvtl =3D 0;
> +	input->element[0].name0 =3D HV_X64_REGISTER_VSM_VP_STATUS;
> +
> +	ret =3D hv_do_hypercall(control, input, output);
> +	if (hv_result_success(ret))
> +		vtl =3D output->as64.low & HV_X64_VTL_MASK;
> +	else
> +		pr_err("Hyper-V: failed to get VTL! %lld", ret);

In case of error this function will return vtl=3D0, which can be the valid =
value of vtl.
I suggest we initialize vtl with -1 so and then check for its return.

This could be a good utility function which can be used for any Hyper-V VTL=
 system, so think
of making it global ?

- Saurabh

> +	local_irq_restore(flags);
> +
> +done:
> +	return vtl;
> +}
> +
>  /*
>   * This function is to be invoked early in the boot sequence after the
>   * hypervisor has been detected.
> @@ -506,6 +540,8 @@ void __init hyperv_init(void)
>  	/* Query the VMs extended capability once, so that it can be cached.
> */
>  	hv_query_ext_cap(0);
>=20
> +	/* Find the VTL */
> +	ms_hyperv.vtl =3D get_vtl();
>  	return;
>=20
>  clean_guest_os_id:
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h
> b/arch/x86/include/asm/hyperv-tlfs.h
> index cea95dcd27c2..4bf0b315b0ce 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -301,6 +301,13 @@ enum hv_isolation_type {
>  #define HV_X64_MSR_TIME_REF_COUNT
> 	HV_REGISTER_TIME_REF_COUNT
>  #define HV_X64_MSR_REFERENCE_TSC
> 	HV_REGISTER_REFERENCE_TSC
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
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c index
> 5978e9dbc286..02b54f85dc60 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -98,6 +98,7 @@ int vmbus_negotiate_version(struct
> vmbus_channel_msginfo *msginfo, u32 version)
>  	 */
>  	if (version >=3D VERSION_WIN10_V5) {
>  		msg->msg_sint =3D VMBUS_MESSAGE_SINT;
> +		msg->msg_vtl =3D ms_hyperv.vtl;
>  		vmbus_connection.msg_conn_id =3D
> VMBUS_MESSAGE_CONNECTION_ID_4;
>  	} else {
>  		msg->interrupt_page =3D
> virt_to_phys(vmbus_connection.int_page);
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-
> generic/mshyperv.h index 6b5c41f90398..f73a044ecaa7 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -54,6 +54,7 @@ struct ms_hyperv_info {
>  		};
>  	};
>  	u64 shared_gpa_boundary;
> +	u8 vtl;
>  };
>  extern struct ms_hyperv_info ms_hyperv;  extern bool hv_nested; diff --g=
it
> a/include/linux/hyperv.h b/include/linux/hyperv.h index
> bfbc37ce223b..1f2bfec4abde 100644
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

