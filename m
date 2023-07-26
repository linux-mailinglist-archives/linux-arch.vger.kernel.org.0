Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D593D762944
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jul 2023 05:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjGZD3G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jul 2023 23:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjGZD3A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jul 2023 23:29:00 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2109.outbound.protection.outlook.com [40.107.244.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61152712;
        Tue, 25 Jul 2023 20:28:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbCJT4YTxSizgUblLhMp1teQy9fx448YXZ7tE9xh6G/jEgaBza9MWeBd2r++EFoUTMxNHEG26CcpH8Kp57+53Nzc8pqJDHPCoSpMZ+Eipkyem6v4X2PcmtZGXvp3sKgP1Uko5ExrMpT/EnOMNIgGd0S8GBsaELx+Qxj92Ovv8vJP/YRPIHgUSnH7s+0FhfWN+aaoyhRpnyd1WR86bJFZzG/WFu+fyjL72EHQdSmqTGeg1uA+ewbGa8BIxSrGYhqWecAWbrA3OZkNAeEFJ+OKBWz2+VQVgo4PoSc6XL1DgHvHg+eyAUam7hHQ1j1hkhlv+rfIpEDDTqdSf2WLy8iljQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46PuTrVH3dejM5HVm/OK877GXaeu8OYJpJsZHwZ7JY4=;
 b=fR1JcdVvWzSpXDbjYh8w1hOnZHuOQwtYeGGiduuTPPtaFw/EmnlUyzECjCgy7NmRvAAw4RqSeBDFEGMU3hWDBzRUN9H9Y6F6ITe7hG4AM2MD3Qs5YRDOp24zqVkQfo7YB27bbZ722KSE92cd/BG3ajdtcUrMautzSiyc6DctVnAaUm0RXTSEZA/DCCaCano8t/dCrldRxB26OPelKBaIIQME8OAyF2B4Iv6/RoIp40xTUdDaN8i4ZpfgitfF5/K4y6WrijMHguaTGfmLNKsRCmLBsJH/7fLJTevTc2FPdhEFRYrhxwkU5WAwL9GplVPfBSQNSjO2Weg78LOhEIVl7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46PuTrVH3dejM5HVm/OK877GXaeu8OYJpJsZHwZ7JY4=;
 b=Z0rHIgr7z3ipvooGk+ERbrWEJrVV8N1rxY6jh5AhTOJRDJ1A3cYC2bHOF/t6W7svhcvXgAO1Iy7ac1jIN+saHEF7r6mI55MXsrzVNkn9OLxotdEujF67iIG8VGJc0vWXbAV4Ol2YdFJS4kUpfC23clL5aZUl5m9uOfy395Jv1M8=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH8PR21MB3873.namprd21.prod.outlook.com (2603:10b6:510:25b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.0; Wed, 26 Jul
 2023 03:28:52 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f%3]) with mapi id 15.20.6652.004; Wed, 26 Jul 2023
 03:28:52 +0000
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
Subject: RE: [PATCH V3 2/9] x86/hyperv: Set Virtual Trust Level in VMBus init
 message
Thread-Topic: [PATCH V3 2/9] x86/hyperv: Set Virtual Trust Level in VMBus init
 message
Thread-Index: AQHZuScy/sRqEFkL1EOVDLnnSA/6uK/Lb8vA
Date:   Wed, 26 Jul 2023 03:28:51 +0000
Message-ID: <BYAPR21MB168860B0EDE63AD959936D75D700A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230718032304.136888-1-ltykernel@gmail.com>
 <20230718032304.136888-3-ltykernel@gmail.com>
In-Reply-To: <20230718032304.136888-3-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=015e99d1-8b8b-4ceb-847a-0edfb1bd7bbc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-26T03:27:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH8PR21MB3873:EE_
x-ms-office365-filtering-correlation-id: ada62a46-1cc8-4bd3-2085-08db8d886edd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: skIcDf+k9qJslmCshjedh8vRhZdwY/sV7M4sNSecKDK9CaFaFo1pYvGUTWeTp95iY5+3cMFXX8LPKZZc9YtQrlnJdOG3BvK5pfUVqz6PX1SYtYM0J4QM5korhxgCVef59kbggHE579ERC3pO/89BsbHcy9mNKjNoLIzlSMj87rx9xoUhh6nRRtepjJRNGULutKs4yLuhjC5MUV80k/ciW4zihSggduxcLJDrwInb6IlrUlBQeRBBFZJEYvpBDWA6J5lkrSRpIAlWC0uk5s74yTHrl/TcFEYD9Eat+TCDPkoC1IyCTR676I6hKb+Sd7Q5xiJslpA3ELz3APK5NJSduBic/eUWhlTT9UnG1CgZ7NFZ1Zf1h1XXVnIb40UNfP4bziIw91AoF93DAza8qYMbI1PNZBSHMMU6wv6bZhyxsjC1xMpyjggBoCyNBELkmlegOLJKvzi1Xhw4TujY0Bk1IZdhVMrx0Br0tkyDLd9cozwCujhEG/vRSzyikP4VWzspqoB89Im3OQwetUAV1zn+ekudTmQm8HGNcTK+ROCB7n6k3vI0AC5p2KIlTljD6s0E280vCG0frSH6vqLtZcXQ36JzXL5wdxUPt9mpLUg0DYxTychUCEwb6Yz/9KL09Zpy2JlZy39/0z9idUzxCfQ2aCvjk+9QCJZANiAz1hEtkWRHsH6FxEAVv1fCHxZgh3aa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(38100700002)(921005)(8936002)(33656002)(82950400001)(82960400001)(122000001)(66476007)(66556008)(64756008)(71200400001)(66446008)(7696005)(54906003)(41300700001)(110136005)(86362001)(8676002)(9686003)(5660300002)(7416002)(52536014)(66946007)(76116006)(316002)(10290500003)(4326008)(478600001)(15650500001)(6506007)(26005)(186003)(38070700005)(83380400001)(8990500004)(2906002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u85PtQSKmlhmWgK/K8r/2ffbh/JOScu6KWc86Uw+EOQdBD64nQvpRHbMXbJg?=
 =?us-ascii?Q?ueTkzpUPVN9ZvAT/9Kr4qAA0WTQPe0Lz0mwpYIWgfAcxI6kETTvPzlvJdfIG?=
 =?us-ascii?Q?t3+C9PvvYc2OeM6nYS6z+eZO8iVD5nEH35B6++BITLmbmf7g0sT0Gx8U4AX1?=
 =?us-ascii?Q?xHHAzbrNKdK2UzLbqoo5926IMK5iMvnJiEfnc/jSXoBmuFfWMTkhZM9tqm3R?=
 =?us-ascii?Q?f9NrPoSU7jkYGBL/vJUUFI7MT+Ef0EQclMoJA8FlVvmfctlAjmheT/IOcsML?=
 =?us-ascii?Q?fAtqiZIhS4DH9PeF3swFIdycNmeBkcRg+Eiv1qdSHUryVGSUrwDBc7hM2JjQ?=
 =?us-ascii?Q?yE0LKFuC06fecsoe1TNcdJv4/A1Amy2N3e6tJszdZW8UDfFKv8MknCfjoH9s?=
 =?us-ascii?Q?sjyk6/UuzZ9RVcWw4PpBNDyz4cFRf2RBzslStfphV+aDowYU5YFnF4tTLNl3?=
 =?us-ascii?Q?IUmq+QGiNdklkPiKIyt0M2ayHFoJLBIaosC7JPHlFlhiApKL+9po3XWKNVDC?=
 =?us-ascii?Q?YjNOL4eMhSta8YR3hiVvrn0iS2P9Jbs1kyBIdNvxg/zNGaj8VecjrupmkOSe?=
 =?us-ascii?Q?326kFUyWd2tzzyM7fZAV6URIOeCiU1GGsEwiGBdOc3Cu0Eeo1V/y6Ys/HJFs?=
 =?us-ascii?Q?Q0MlHUc2U4Ufu8naId7bEwEyD0+1e5V1eX5/SU7ckXVQ89orDPzyOLWyGCuv?=
 =?us-ascii?Q?ZID229U+tUvsTN6dmwB7KxujYYvhmfqXa87WjO7NH2AFFBm/T23urdJQY5We?=
 =?us-ascii?Q?1bmLwXwD1oZqfxuFDv3vxy0RuC5/XiKA6yTPxYw2gPXOwNxQFP2HOOZr557V?=
 =?us-ascii?Q?vkzBmQ0A75bgB1rvQZjyQAkk+pbqqFW8dIBs7b3ltK54ReCtS6r98XJ6GAPV?=
 =?us-ascii?Q?sohg5leWm1DLNyHjmLF+s5BMN8XnaMLKxKI0kvaKvge82sWvR6W/cTykv4EC?=
 =?us-ascii?Q?UZ7rkDrSN4irmv3NLd/k3aX3EJY/lBNDB2gSP0ynw//3z5EJYGEweNZ4DrpJ?=
 =?us-ascii?Q?bG21bLJiXKMLe0dvGAJFq750lgNWbEjpYlUaOruIVv1yQbMJQ7VbIV0tLNlS?=
 =?us-ascii?Q?Q6zjerdWF1yRpkQLapFsPP1Bhdm/46T5H+01B5IFCznIHJL6vbXBwL2vtane?=
 =?us-ascii?Q?hewjwdROItVuiV3yMDuGRCviF0f0pZYP7rkgDlmRFhHN6dYabO7Povn2RvMw?=
 =?us-ascii?Q?yY8whvMS7CGq5LPqOkjuhZe6de9J5h9HIHt8VAsyS/SxDBEr4Wz/+hkNYo9Q?=
 =?us-ascii?Q?hmXD0kU79f10uezevqOkmkH0+WCkuqK5s12Qw2GH45pdDi5ZtPLYiSjjAwpg?=
 =?us-ascii?Q?aCPyWU8JJ/Qj6ErMZMm//2j6ELTqv3LjPOH1N8rBs0VG956/3Iw4d7WDfx9/?=
 =?us-ascii?Q?9nKO7LC1WticClaUJb6Lx/7qbVAf8bk6Gcc2eEWkEhO/od2fXhAGkYkEUFq/?=
 =?us-ascii?Q?bUSHTjCVe0BrAfiSrO4Pl7cMF8J+XytuCUcl1HmJbj/8UYr1oJgkYkzpJkbv?=
 =?us-ascii?Q?l1mX+qj2+1Y9LW2nq/jYg/mObAYFc5WMPRr13QPsYZcvCCH5VOkEb6X51Zmf?=
 =?us-ascii?Q?arQECz8BGD5pUlxnxKFCdV4JsACxMCRWYFTM4xTJpVT6H0AbuLbA15oIuyJa?=
 =?us-ascii?Q?oA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada62a46-1cc8-4bd3-2085-08db8d886edd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 03:28:51.7819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VeJPwrqkXDtrYHo+w9pz1HWqF4T7wyfAKLZZpibqaH2C6SuC1RhPz6S4M/jMBvHkrZ0zIxXRDHkW5ATgXjVbvqWAhjvf9nX1aIlwsCb1Kkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR21MB3873
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, July 17, 2023 8:23 PM
>=20
> SEV-SNP guests on Hyper-V can run at multiple Virtual Trust
> Levels (VTL).  During boot, get the VTL at which we're running
> using the GET_VP_REGISTERs hypercall, and save the value
> for future use.  Then during VMBus initialization, set the VTL
> with the saved value as required in the VMBus init message.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> * Change since v2:
>        Update the change log.
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
>  		vmbus_connection.msg_conn_id =3D VMBUS_MESSAGE_CONNECTION_ID_4;
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

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

