Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0987473E6
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jul 2023 16:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjGDOSM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jul 2023 10:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjGDOSL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 10:18:11 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2133.outbound.protection.outlook.com [40.107.94.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F751AD;
        Tue,  4 Jul 2023 07:18:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LR9v5hMetLeyYhyUBdjoiJZ09f2NvR7awogRATFDVusk5cLo5o2a+J9frbduTCEODGSX3sBDae+UViRcK/366Vgh/FjhQ+GCDNyoGMSzL2757ZujC24mH+MIT8V27g3e0LJJCDZ9cR5H0//FfiSIJQcB8uaSuQEhELQri/YlY1DdIl0BjcXLPoQMiJzZNypjRH7nMXb3NeDSn0KkkbxzC/x9xHQWsqFhNquOqysBD7uGvg/5r1bB+1kXlJWC8CQHHeCMtCxYeX0cWOEiW0ml6dbHX/FEmK2alzegdjAN+v64gfs55ziCftEHeHqMkg9RK1gh0kzqL6Z55myJYeJo5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtAnXe9UwXJmIM5y2jiU/fisQbnYhwY0IC4ClOC5ZUc=;
 b=ktwqvKmKdsrgHfM6X/aBbeHNuIk0ow/F8wehvCxt0+cuX5kTnaCwSqm+NmUb4JUE/GO2Tkpw6ZD/3v2TlmyJsZL/l3uchgQnw2D5EFKqeNEQkYccLVdkB3HaMGUVycqnuIcyaUBIYIn68qNFi6/4TeADdcARl6/PGdqYW8RwVXII5TTNra7XSTA25M7WaiAq0D8SZ/W7hpiPLJPSwV+s+pAkR4hHmyinMZ1n3A+HgY6Bc7wbX4kUIiLhktE+Jp7Af8lATIl22Q5x/I5gBi0YJs4RgBDazRIBRnIiMK4+jXadol7coRBBS0EU0gFRkUz8ObvwZtVqpa9XNjYg4XAsBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtAnXe9UwXJmIM5y2jiU/fisQbnYhwY0IC4ClOC5ZUc=;
 b=i+pdqYxR6BZ52/SvuVn77Dp3lpwWQsqICWpfubzfxunZdi9UzZoXRfSKNkVXyZxMJNwV96yGcVWoJNGKu7/Gvl2lSxBOTN5f0OTQ+NhH62IJZE9Gf/ehk89mJoXzfSqDnPIu/Nca+I/4roHHUAsBKGR7m1pOgu+M9RKHMYwC+Ao=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3733.namprd21.prod.outlook.com (2603:10b6:930:d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.8; Tue, 4 Jul
 2023 14:18:06 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4295:75a9:26d2:e64]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4295:75a9:26d2:e64%5]) with mapi id 15.20.6588.006; Tue, 4 Jul 2023
 14:18:06 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
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
        "arnd@arndb.de" <arnd@arndb.de>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH V2 2/9] x86/hyperv: Set Virtual Trust Level in VMBus init
 message
Thread-Topic: [PATCH V2 2/9] x86/hyperv: Set Virtual Trust Level in VMBus init
 message
Thread-Index: AQHZqKatWU6ATZvp1U+6jn6EvQ0xm6+psyoQ
Date:   Tue, 4 Jul 2023 14:18:06 +0000
Message-ID: <BYAPR21MB16887D7F14D246162CAE765DD72EA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230627032248.2170007-1-ltykernel@gmail.com>
 <20230627032248.2170007-3-ltykernel@gmail.com>
In-Reply-To: <20230627032248.2170007-3-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8ed53cbe-6830-4ffa-809b-90cf5b3da467;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-04T14:17:16Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3733:EE_
x-ms-office365-filtering-correlation-id: 3ee88300-bb7e-44ba-0b9b-08db7c997cb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GU4RgeaCqkOtNLeHbwZzzSwIL0crbELlFiks0pquUZajrpeC6mARR1DkTl7x8i+wRaPj6Q5jjk3NvRrhkz6Q6jzzQoVGQb5kjpb921t2/FQIsMKGwIQ38y5exkA8GCYMEL6Zj6GoDCZEH8vt1clxuN9gaUldiJPNLE4/i5JJWk2Fp2e0d2Lh9sYFKYz99sV15Kj8tevk3t/zc2AqzOnjo274FFQWw91ydc07Ksod38TnsbYCPectwrll3jqz+AKQXoLGbe+GFWwjh2lkrXQE5lbftfC9JR9uZAq7EczVyLfuaK9gdFk3yxuuPsfE14XqNGEB4+kauiK9SIivvBhagpnFOZ0kMgC0vDObYKw6Wt4DwwYFHa3JCdJNekU/Y8kNz6NE1CjSXk3d/ckOJQ4LEJYhxIwe7MmKywmsKSm9TS/mCJcfYPsAfHGc+3f8h+poQuy/veXE3HLV2jkUFMgAbo8OHFclXPqXvlQAIWifwb1til8MBbbjrwymibEQBLZCbIZj3yh0PQdUAMFLHBBeJsNYx9Rx5I/ghW1G5abQL2kdNBYDFQpnJVbpn4dIR0fGdzW5Ffn51R5Ez+Yf6onOHsskJgBfuIEPq7mf2nR3USpSw0GGpyKaH0N68cNZ1yZTzknr4aWDzTSOCsMs9yQngxPlITJbNDPpDpwsnbDmyVP2Z8lLE58fIhCKJ9LThmtN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(8676002)(8936002)(54906003)(110136005)(478600001)(26005)(9686003)(41300700001)(52536014)(33656002)(15650500001)(71200400001)(7416002)(2906002)(5660300002)(86362001)(7696005)(64756008)(316002)(66476007)(122000001)(55016003)(66556008)(76116006)(38100700002)(4326008)(66446008)(66946007)(38070700005)(921005)(8990500004)(82960400001)(82950400001)(6506007)(10290500003)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k0yt6SaM/7/lA0iqZzhK2XuaGp9RZHpWypBFVZ2tSHY+phQ3EgsLr1/vWMKM?=
 =?us-ascii?Q?ZLIFVr7URQoXUviRl4JQPK4jtsPwjzPLSbP7AyeAqrtM2MaZhQY+5s9ldE/O?=
 =?us-ascii?Q?+euW4LCfYF75dEYN74vXKyRddhaiC8jo/pqozfYuxiXTwW/+PhiZgaNFjvdz?=
 =?us-ascii?Q?NuXpm0TvQWmt3TbluivPd+qikq49wUhPyrelbmz9d4ydqtNHDChA43LTVfyD?=
 =?us-ascii?Q?2mM29ZyVzy1ypQWMJKuSjvpgC1cDvy1/qdOPuIAfKq3jBK+EDAwy/ZU/h502?=
 =?us-ascii?Q?YTXor9G4Ppss7YsYuflXc6GE+OgYvJNCuqr0XkuQDMvIMGt4W3CKpoQ2ulrz?=
 =?us-ascii?Q?Lh5zxoXOQgd/z+d4K5UQEdlrXF2/vtOWSi8ECBOcz0FQX7AVA275lf6D9iDD?=
 =?us-ascii?Q?9qq9/UrMS7m0trQYmnK2tywaz+S1CpLLki88SCHvo6Yf4OsYqYbnyE0UYd9H?=
 =?us-ascii?Q?QOV9uO8O2GAsXqL1i46G5mgKehNRf5HwIB2Er2xTfQnF7G5v1tukKRLg95vW?=
 =?us-ascii?Q?YIxs6Hi8yczVvHHpO/jv+N2vi10jKZKgwpc0ecdPy/56ybKDTuSLzCkq1L2C?=
 =?us-ascii?Q?cK7omp+459x8YRSGM8qK9g227F0/XDl0/p4HLA/iZpK8rPtotmAXPEeLtZSW?=
 =?us-ascii?Q?dI63owrGAJRGZOqsNxqakIKsb4idWxHeml74EQhE/zCkXSovydKa5WMEwtxJ?=
 =?us-ascii?Q?JkrMPP3o0gbtVKQynRIR+kYm33t/ePPWAKovee2abuVDpMaS4SNPq114bthL?=
 =?us-ascii?Q?Ow8bME3DR860jDp6tnyrZENomQ6Jndc1qscDbFpo+BKdMpQxenOrSrkYYacn?=
 =?us-ascii?Q?3Dr/hSWjDMYW9Rcv8UPOITwmRUVELu+b+9jh0ESyP/cBE42eyo8DUiPiJRkt?=
 =?us-ascii?Q?wsPvC6te/uLPgO7mYqmGKY6IFAke1nHpOLndHwLXFK7NepLViWQtOxwC2Clu?=
 =?us-ascii?Q?yptdavMAQmJBjoEH1xULkDuAYexpp17oi2EzJMcMGsFSIYDw8SkpXrDLA93k?=
 =?us-ascii?Q?Iu8nbIFmCTQfZgnMoa4w32fnRapwDUguWzasdZwiY6xvML2tYQYnYSrVjni2?=
 =?us-ascii?Q?/nbjddq59Fy9KVf09pvqpR7mvJGlFvKtJVfq2juf+mCwmIyos4mQcl0j6Ust?=
 =?us-ascii?Q?2VTxnINcJ+lfRNyMvABHqICv9j9ZUI/gkt07B+pFQvoUrq3lbicfmHCsOnt5?=
 =?us-ascii?Q?JcYDnHe0rRKJCorX1cMVjve0bwnn2JvzDX6u6jGlJHMvrY+lHN98pCj2VrBh?=
 =?us-ascii?Q?sYckEY/Ghwve2qSSYfLDFYkHyOgfPEUbq1TQ6dwUr0yUCWqv5adDnKa4OEsH?=
 =?us-ascii?Q?Y1QlqfpSHUmVSNbdnDx/6nSE/GizsfR9esGDAvSVGFQVYbI6ZsKRc6RloP55?=
 =?us-ascii?Q?YJKtSOWdNyyxRuMZKYAb4cXEJZFgTl5EZYQV27rEHWMBdGdPzPR3JTvM1KBG?=
 =?us-ascii?Q?tLyWw7k9zOqQAYdYGgdcIlUdQsf/vq9HItYLRaQnEcmNwEsallVPNH7YMd08?=
 =?us-ascii?Q?olJxeCGVZvmB7bRnoBuX043GnqWgPGmkNK//Wjakhz3Ian0TXeaQqDtiA4Uw?=
 =?us-ascii?Q?KhAouX3eEZyk6zcwoR/vUjgE8O50gapcW92EANBfSVbycnn3mlq18GbpRmqK?=
 =?us-ascii?Q?HQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee88300-bb7e-44ba-0b9b-08db7c997cb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 14:18:06.6846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PYkGvt+zBfMaiOxhkHYKn6tO0WHaRMjCKrRuasKJEkIYBqlicLzs81NpXp5Gx+MAQ2VZZR6pIvUTkP6am92n1H820c1n80lJu7fSMGgEFz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3733
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, June 26, 2023 8:23 PM
>=20
> SEV-SNP guest provides vtl(Virtual Trust Level) and
> get it from Hyper-V hvcall via register hvcall HVCALL_
> GET_VP_REGISTERS.
>=20
> During initialization of VMBus, vtl needs to be set in the
> VMBus init message.

I had suggested a revised version of the commit message, which you
agreed to use.  But this is still the old commit message.

Michael

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
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 6c04b52f139b..1ba367a9686e 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -378,6 +378,40 @@ static void __init hv_get_partition_id(void)
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
> index cea95dcd27c2..4bf0b315b0ce 100644
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
> index 5978e9dbc286..02b54f85dc60 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -98,6 +98,7 @@ int vmbus_negotiate_version(struct vmbus_channel_msginf=
o
> *msginfo, u32 version)
>  	 */
>  	if (version >=3D VERSION_WIN10_V5) {
>  		msg->msg_sint =3D VMBUS_MESSAGE_SINT;
> +		msg->msg_vtl =3D ms_hyperv.vtl;
>  		vmbus_connection.msg_conn_id =3D
> VMBUS_MESSAGE_CONNECTION_ID_4;
>  	} else {
>  		msg->interrupt_page =3D virt_to_phys(vmbus_connection.int_page);
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 6b5c41f90398..f73a044ecaa7 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -54,6 +54,7 @@ struct ms_hyperv_info {
>  		};
>  	};
>  	u64 shared_gpa_boundary;
> +	u8 vtl;
>  };
>  extern struct ms_hyperv_info ms_hyperv;
>  extern bool hv_nested;
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

