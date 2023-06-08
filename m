Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01037280DD
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jun 2023 15:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjFHNGQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jun 2023 09:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjFHNGO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2023 09:06:14 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021017.outbound.protection.outlook.com [52.101.57.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF071707;
        Thu,  8 Jun 2023 06:06:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7JU0Mc2YPSBuvq5W/9ANK8A6oU3sL36cF/VsMG/FJWUIjb2fnDh4Ry9yQHvHIKZxaixgvEYGqRkPJVtF9wS+U0Ohgz+A8vgp4CDjeu8C33dFxy+BoOqpG1afkjd35Js1Y4e8Zd8cToHQvSsUkWXHI5cds0DFYzuiFk0pikysF7fiRowE2WItRDL1jqOOdmDpNlLNIYtvKSDof4cYahR8B2BvjmPBJTr1lqgGJOJtTAD38/ViAoPvu83+Z0HN24BOOXj1+wrX3H1vUzIj5JWOhdiwu+Qtf/p4Oe5KEeO5DYDcN50ZQoOsVAQyimItWs56LoHiM5YcyhsucwybiKwqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arJUCXNRDe9j1lFcgtL0qOHVMJwW/fajKxRXIKrzSyk=;
 b=h2JlHtDBXLdpsMs5oKop9s/z31ogiBG2khuxh06INC8DBKurpVz1UVK6TDITPCtRFg37AGBq1p9mLbsC/9SdXsi0dVjLZ4HJK/r0MjoqBv+2tAtesc+NVzoI88Q0CvmZcfj8JBqZxA/UEWKToXJ2zlBrr9hGN76rWxsoXE3NFUZGeYhebPHJM9a4CC0L2baPjtRgObqBYax7fGGXQVZtxe0R3kQUYJDRzmmcB/pkQQNE/FCsC7yJjumT7j4yn+4vXiCZFBZ2JjcSWReY/b/2LnxUhJlKuFSLmbt6qvpT2OSjwMvQ85fTy/sIAOhfifIZBkhJR/MGJ06wCwp6Ywg4WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arJUCXNRDe9j1lFcgtL0qOHVMJwW/fajKxRXIKrzSyk=;
 b=C1nwzYrtAjfZrV6ZCiO/w6G+1U5P14yFar6F8UKAsiF4oMhbv6QorW8MiHx8ys9mOjbvFCTFzcLFGN4FFK1D+dh6DwJJYBpoCGppIc8Jcl7DVlKJP05OHK3A3qEFMIrcSloqvHfxBNQ4If57b2zNnV7ASA1L2+/tVLli40vURBs=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BY5PR21MB1412.namprd21.prod.outlook.com (2603:10b6:a03:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.14; Thu, 8 Jun
 2023 13:06:09 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b%3]) with mapi id 15.20.6500.004; Thu, 8 Jun 2023
 13:06:09 +0000
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
Subject: RE: [PATCH 2/9] x86/hyperv: Set Virtual Trust Level in VMBus init
 message
Thread-Topic: [PATCH 2/9] x86/hyperv: Set Virtual Trust Level in VMBus init
 message
Thread-Index: AQHZlJwOs5XRKcZuvEKgWk5lE+JQC6+A6Vvg
Date:   Thu, 8 Jun 2023 13:06:09 +0000
Message-ID: <BYAPR21MB1688903C92A708680FFE7B91D750A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-3-ltykernel@gmail.com>
In-Reply-To: <20230601151624.1757616-3-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e159e65b-baec-4431-a123-c8c96e92c5f4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-08T13:01:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BY5PR21MB1412:EE_
x-ms-office365-filtering-correlation-id: 09f3d1c3-a5d8-4b9e-246d-08db68212099
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m1QgMSJP5VcmPDL97s36jVMao/5ep9rvB1K2yVk0J2S0SORnP39b8RNLV/rJ7OSdR55Dwk45qQKDuqFNVWG75pRWfsOLu7VnseElBC3/Kx3+J56L8sz+9FHLwzwCyjDYuTmbNaJN7rJh3uF/Js96S6MzfP3d5so8mi52ADp1dIKoB4GvOTiDhR90aVLSe4glh7REQ+JV6bNCN76Q1JCpAQjML8rpc73/eNgV5VvX26y73rdrsrngjWqfkOWRk5sC+2CxmwZCFrfS7g7hEjpvDnSfw0p5ipj2d2EQKmFj2P/wbxzFJ9+u4iOpbIt94Ak6A/yog8KvTO7eQfckzCzvAn8NDh0i5X8UpAaWQ0B7Bo4cQPEsx4DE3z9TmPGP977eE0k2pzSiI5sHl7axteEuUQYXqwDvcwITE5UjFmTfOySZ8zX90rZn/9Vc5sSgb/s7LIqJ5nUCy+bO78ofI7IC2ye0HvFsnJ9HbEJoY6iOMToRvUenS4reHlgQEByedcBXX/hWn2n3sv5fx5U2iwIv5aAwPNxV8xwaJfHpSAqLyCVT1YvKbVxkG45+RZlu25f+eNAcBJEMtfmf+XNG1lXu4aJFIhE3yJnkEKk4M+iok7O6+VicAtIz90CgcLBp0glrmUiJs7cjZeDjO+3c0R5cZ7b4vkkERVPDJ6OZi/mfdEK0w2PdK8PVtfn6joBMLfim
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199021)(55016003)(110136005)(54906003)(921005)(122000001)(82950400001)(82960400001)(478600001)(10290500003)(8936002)(8676002)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(316002)(41300700001)(38100700002)(186003)(83380400001)(7696005)(71200400001)(9686003)(6506007)(26005)(8990500004)(33656002)(86362001)(15650500001)(5660300002)(52536014)(7416002)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WE1AlAuowQ7S7JcvdwWxm+o6gKeFLqF4gIzy566TEgQDLOixTYhesApQgorF?=
 =?us-ascii?Q?gUrWZy16yNgay/5XI2/X7WVw4alnbSoPcnFl2GEBRvrNZYjs82V5TQvSg31u?=
 =?us-ascii?Q?b+z7PMJWF7iuhust/P8KLXmEWdPKkLGx9dWAE/w6GZFIb0j58nI8qBEfflvo?=
 =?us-ascii?Q?Nl5fmia7WyqA6D8SuZ7AvSciPxlS1CkDUL7npLRFKa9WxRGYRG1U/Dro5gf/?=
 =?us-ascii?Q?clPpBzhdzoeZv28yOpsgzD3lsGG/6+1E1H8n20JeXOmxMwAJ4wm88Qr6Lm8f?=
 =?us-ascii?Q?5HNFUsmPR3NfPN53h3SSoNTb4gJf+HBMB6JF7xXv8IOK9yqVPQNLIBxSGE07?=
 =?us-ascii?Q?eZZ3XkLaKAC50NioDgHB0Xd2kIJJeduxCK+eIaWJtnIyzCLSCOj2/qvSm1hK?=
 =?us-ascii?Q?Bl/LTHrqxZHD63lIKrVhNxFnP0jXVpXkJbKNDKILiWeMt310NXb0WBjsRpaj?=
 =?us-ascii?Q?PiZbLMxo+oHj1iwRiF6V9kSEBaFDUeOxPeB36O4vdkJjgI/BKHud192E7zaP?=
 =?us-ascii?Q?pFnU4y53vI3Rf0GZAKaI88QRCQAHxY9duUOg56CdVC7xVS/pQ0lJHRuajVEW?=
 =?us-ascii?Q?SGNZuWLFYBENlPhPeu55tgRXlGjSjhlpJbJPVrnbbFdYlSQKq/FgaXwWDSQ6?=
 =?us-ascii?Q?PQPVrEQtNMOa0dEE76tKLgmFnHg+dpn2YXIkSEoXH8s0EUwEOu6Ayq/tOWql?=
 =?us-ascii?Q?VrDTU7Pte88TmV2YpHudgD/5t+xYfazlCxJJCRwAk3RLmk1W4EdnL85oO+li?=
 =?us-ascii?Q?FFoWJMgPveANcW8iDCNjrOkuDTmx3phIHRq3AO7q6iBZAHohFfupGMqa5Jtm?=
 =?us-ascii?Q?zCbXjqvEbq3x3VJe86LDEB90xJARydmy4z7xvIzKZkYoPbIXfuBfphSykWVU?=
 =?us-ascii?Q?/sAJGJ/e3PFfJcUp95bEe0vXYPPUuQvlD1rtEqu2SKWcmEblU3td7BLJiIgh?=
 =?us-ascii?Q?efyzZlOyT7wG8dn7w6E29ZRqUUZAcBhYJKYltXEmhwRy4C64MZtex/7KBgaR?=
 =?us-ascii?Q?hENuRRhaLAbMBGmBOa+LOf5cE+sJn+D2psqg235fC+zlnElCbVl8WnJRUKLn?=
 =?us-ascii?Q?0Qb3AAeJuxoEzWxlADM8ICUc3Zgfl6Ukc+Iw2tpOKCUY1RgelEAk3pSnAT2X?=
 =?us-ascii?Q?maqeDk5P4nJHBEli4Ko0OgM34gGDpPJSGNLsF8QPxLlyH/3M9JWdm/+HvtI9?=
 =?us-ascii?Q?u82qH4gEjSXEcqMuSL5WBzzAWJ8fnWWTxamK5svrjFCamttRFvYEhAq3Q0fS?=
 =?us-ascii?Q?4UtSZ7qIG/8IipqEIQvvGEGTYJckFRCs4rIILYEOa5wNs+DDZzQYsrI6Oskr?=
 =?us-ascii?Q?uxyj41x6/1RJym4l8UEmN44p2u9pIaV73xqvvwj0tGEi4Py1cQ3kpzgt8iCD?=
 =?us-ascii?Q?kCQaPzFtxzol1mS/mQmX9sK63GnGhLInNferroh+s40D4q7wP1wAzDTZnNlA?=
 =?us-ascii?Q?Jam1KdDZAfA/MBpazU/nuZCYrkcsD6QKQbPKFobAxfkG0Avy6FJGiTkxlE6n?=
 =?us-ascii?Q?JeWR5az9WxJVfHCil68P6vIc6prDn6rg2o0hW6fnzbZw4zLTfBZ8O0kB1PMB?=
 =?us-ascii?Q?hUtJD9Bn2uIF0+psFD6sMGm+9uvduGQOHJW6hHWWF7PPeLZSo5uuz2IfhgYy?=
 =?us-ascii?Q?xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f3d1c3-a5d8-4b9e-246d-08db68212099
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 13:06:09.2689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S3VRzVlGFOJ/GnVTpPwtut2cieEMZEBl/yanUQKtwNbE24R/986yFYJxjtQFAQJ7Ozz0/CouU6b8XCjfhLM81A+PBSfYVrmMwoX+o1Ob3lA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1412
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Thursday, June 1, 2023 8:16 AM
>=20
> SEV-SNP guest provides vtl(Virtual Trust Level) and
> get it from Hyper-V hvcall via register hvcall HVCALL_
> GET_VP_REGISTERS.
>=20
> During initialization of VMBus, vtl needs to be set in the
> VMBus init message.

Let's clean up this commit message a bit.  I would suggest:

SEV-SNP guests on Hyper-V can run at multiple Virtual Trust
Levels (VTL).  During boot, get the VTL at which we're running
using the GET_VP_REGISTERs hypercall, and save the value
for future use.  Then during VMBus initialization, set the VTL
with the saved value as required in the VMBus init message.

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
> index a5f9474f08e1..b4a2327c823b 100644
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
>  		vmbus_connection.msg_conn_id =3D VMBUS_MESSAGE_CONNECTION_ID_4;
>  	} else {
>  		msg->interrupt_page =3D virt_to_phys(vmbus_connection.int_page);
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index d444f831d633..c7a90f91c0d3 100644
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

