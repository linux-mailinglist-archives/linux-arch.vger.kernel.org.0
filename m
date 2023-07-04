Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170B974740F
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jul 2023 16:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjGDOZO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jul 2023 10:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjGDOZM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 10:25:12 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2120.outbound.protection.outlook.com [40.107.223.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EC5E5F;
        Tue,  4 Jul 2023 07:25:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXKv6PgtmR93bZGci8xFKJzzA/r6Uwf2KjFGLsJHVaekNa0qKYkRGUi8JniPjR5nkRkCyzLCOL4mc8vRrHGgy95bgA2PtiFyXUg3Z8oolu8W87MAuV23kHLHwO1/s7b79EzPxhf+0xXIfMpc+Cet9LNtN9OT5L3NQ2bMvOMkCEgW64tsQzGICDJSOYNwL5U6QmOySfhxHHEOuT+IXpqxr4TdAA5LJljdjcPmxZR5xWlgIp/7NbpdbK5SQ+zsF9M3YXpL/SGeHVtkl2Em6VsJFCbT2LEFmuWuNCL5zN16ViQy+gk2qPvdce8E+RKg1FIQorJ97LCy3G9zsCX532os4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbiYcrHUqprNkr/A4rsUshPdXBLTQkWjRlwLdJM7zos=;
 b=Q91CyTDOCdEY/bROU1bjXT9Jm4yp0QZb4fnc070tjDB7sSTedRMM840wZ8hf1phPPR/KBJp/czRN7sTVymajqamyf7mgfvHpqJfLpiBN8ViVpIbBW2GZrTnVu4Z3wC4zQkg3I8Zbl2+kXalA/yFQ3jw0jp0kuvfnd18OPg3zeYSyU9SBN+/a51k97wye6k/BqSgGRhxmuBh/mJY9LcaOdD+NDVt9E7LNMHWDW0m5LW+pdX/1hhW1T2Nzi7ww1vdWTNaeYFKzvnusMDwkN+agUXEcidSukfUce/T9TtmOcncTD4g/NgWa1JlPDbK3dbyG2r1ONt7SbkWXJhBsKOltoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbiYcrHUqprNkr/A4rsUshPdXBLTQkWjRlwLdJM7zos=;
 b=VOfm+qIxI2GBojzP/GXUUvedpyWq6TLRL/y8UihK5fY5pLLnOrmcvBtPSmF8zo6L0wE4PDxuwXmq6Mo4SiUqFjn3HrCcPZlW3ZzirSpxeFCUtHxeMyc+4EFT0MhajKZwEF4Ia4SPfbJEbTKtYr5rrpTAfV2UNT4k7gM3TGyEMgQ=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3733.namprd21.prod.outlook.com (2603:10b6:930:d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.8; Tue, 4 Jul
 2023 14:25:08 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4295:75a9:26d2:e64]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4295:75a9:26d2:e64%5]) with mapi id 15.20.6588.006; Tue, 4 Jul 2023
 14:25:08 +0000
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
Subject: RE: [PATCH V2 9/9] x86/hyperv: Add hyperv-specific handling for
 VMMCALL under SEV-ES
Thread-Topic: [PATCH V2 9/9] x86/hyperv: Add hyperv-specific handling for
 VMMCALL under SEV-ES
Thread-Index: AQHZqKazByoX1kbIcE2nCjBCNU3/Ca+ptTjA
Date:   Tue, 4 Jul 2023 14:25:08 +0000
Message-ID: <BYAPR21MB16889BD7BFB7FA1614AA4AFBD72EA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230627032248.2170007-1-ltykernel@gmail.com>
 <20230627032248.2170007-10-ltykernel@gmail.com>
In-Reply-To: <20230627032248.2170007-10-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a4d348df-1fb1-41cb-a46f-05dbfb04ce25;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-04T14:24:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3733:EE_
x-ms-office365-filtering-correlation-id: 1de669e6-4ee1-4631-eef4-08db7c9a77e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9FtbdfipBxHcL7LPwE3sW6Ywo2sKl52pS0+MpMcOZsxUSiZkNDAF64YcOq/k4tkO5dC/517nK+6rJbmwgXrHJSFA5P+4BPcCTimvdc9EC85YXOInVR9bxPF75avNaaQ0GBkBJmu2sd9i4VT+GYsm6J4P8Z4uYYcTwJO977afnbBovWSZfW9lrXv3+odbkErOwSl+jALgIqrjtjhKJS+8BKqlnQkvD4pGwn1hwtYNbF8KyEj68fFSPX5lZrYRb+wpsx/cZ8mkaLmkfIhFt9AmV40J0XH83dT2eZJjxHsX+z/Gf5/e2HkSOHRji9N2aNiCH8Fg9Z9awwRicOnVnb+KTxLVUYiot+ze7xB3I55zD24bco8XYQgmc0kxwB7D/t6JVauXRulRIVllz9asSJNjV8kR/P+WiZ7NPf3lC+Y5JkMhIyGr+Ymamb0JMYg3vx9RW03gL4+Gw02Kl/8bb14rgtNcKOFo0wVacZSugSH0Y9Pm/3rUht3YMTiX09ZlMzC73j+sVaXH4sR8nYxyKlxhmMRpDz+g/03hgXbAIt1+g185LGBR9Jar1nWeNcXYdW4pPV7iRCAWaFXDK/cMnwGLHOpNwQ/YHYrYbOfzmONjVuleZ7TXxAPfsW0EJ6ydcdx2y2w7m9EAw1uTnPTSrUc6CgAn2ivq3r9NKezgIoluQrw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(8676002)(8936002)(54906003)(110136005)(478600001)(26005)(9686003)(41300700001)(52536014)(33656002)(71200400001)(7416002)(2906002)(5660300002)(86362001)(7696005)(64756008)(316002)(66476007)(122000001)(55016003)(66556008)(76116006)(38100700002)(4326008)(66446008)(66946007)(38070700005)(921005)(8990500004)(82960400001)(82950400001)(6506007)(10290500003)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wMj43XHfkbfXMMuen/amix2ICxu3RzYIvU4pFPoCINPulJRdQ+eVkCrkLfz6?=
 =?us-ascii?Q?YA0RTZR4DdgkQOZcrnUuIcZJ/vqgNFNHs2QlMF7z9KInhmypth6SbTyY6kJJ?=
 =?us-ascii?Q?RvTqMmv6U8dUfuG0Uu+Es7jQaC3ISu2W9DHnWbrd0gqvOm74pVPe7baC52pY?=
 =?us-ascii?Q?YuALDg1kbsJqjhAfBkZBZUyhNhnMLnQDxtWnGhXRkiCGXiR3lLnQnbUMRuzp?=
 =?us-ascii?Q?j5OcD7ozF5SdRSuPuiW9l/H1oXWlHyVTxzhPtN9wUO+qulL/lNftGbhJ6bK/?=
 =?us-ascii?Q?sWDiI0PfdmZZ7YEmZc0YHpYSmfg717hzWF0EJlJQcOgoeIvzYKB+shgk2yz/?=
 =?us-ascii?Q?8GjQtGGHQXVC0HdyY57VWqBye9RTbfI5V/3gkwKLLZYSe/LX5UGfSXAIxwxH?=
 =?us-ascii?Q?psOkO8TMnGHxZaEBaDOnax2u8K9EXQSCRATEgtsnrZSOTz9sh9/HKhtPhQq3?=
 =?us-ascii?Q?Fo+s3+u8b499O0pSXPZcF6YOZxplKmWztLEDRuAo5mQut/XDdJerbEvFZmcK?=
 =?us-ascii?Q?+Q50L528dA+2bPk8z9Pn1dUPbZ3WxYDgI7QmqJUbf9q47j0KmZIT3+8nlnMm?=
 =?us-ascii?Q?+yp7ejX2Yz1Ea5GnRV9QDfLoowVoVyvom2CWHKCBA+0G3Ql1YtcU66ytekT1?=
 =?us-ascii?Q?0gIz/IVIWO/cgkfd+eG2vCxN4D0qSGendFEc03bwLq5jF97Tz3Cm4l6gtvRz?=
 =?us-ascii?Q?zsUxJp4oBDk6u7RbCQppO+iImWncPDpqxkERzsqdIZF4AUc12YYUV7mVDkc3?=
 =?us-ascii?Q?9vsBcW+WLUTqPNZ0o0zhJvYbyksS/LNUIpqI8nqgUe+EAZXr8HTcU0TR0Aqn?=
 =?us-ascii?Q?IPyTw2hHitdUuAA0sJ/9i/IuDX9JrWx9QOz4c6x3/XaPIDGsSkGCnpK1CXCY?=
 =?us-ascii?Q?ApjWZ0HA3240+aPADo9T9jQ6h/jrIrtFXyagxdVbMf/+P+3duZOz1qxD5+jJ?=
 =?us-ascii?Q?kjaZjTDSza0JrdNHY6EyEDRQN1tjQy2hMxCSUYcr+Icn8iOV05sNpoBFnkWM?=
 =?us-ascii?Q?y5xgMCVoAsqr+HT2U3O/29+vReiTZGXlIvROM01pyXagNspJl1yjvrar9kj1?=
 =?us-ascii?Q?9DU8gsOEENfXURQJXuR4DHmu2KTS1oiyTWUh2af/JVJGGY3OvrFZWJZlPy7I?=
 =?us-ascii?Q?pBmqsUxF7szureJsLn3FJMNeWO65iepAfSGRxAnG41JABKyBy/rgUDrSSE2O?=
 =?us-ascii?Q?Uz6mLmwT/g0C5My+aPNI6umsAH2Bj9JxUs8ImLJbJVuDIzu/ZTpJWcg95q5C?=
 =?us-ascii?Q?/tC1zzeKRxRQmKngbKJw/nhBlsbC+de/0jfm0w8ZY3vIxS9b46y8IY6XrQiL?=
 =?us-ascii?Q?WaoI5ftgUoaOGwkj4qFGDEcePh24q2NktKT9yPgbHWgf2ugEGJvrRymrVcv0?=
 =?us-ascii?Q?Lnxt6h9e71UGUgE3Avo8Z1oxmn78bsJwbsmZn8nb2zSsySSo3Xf06ph/IP64?=
 =?us-ascii?Q?RSDpvPY4HKtc0Dui6iL3x4LB2VFwSuRis8omWGvrbEAx8cC0AvGii7B2/pAA?=
 =?us-ascii?Q?jPE6z6990X229S1qX4x2NKO3ty0nUOYJurh2bCx3Nzy5C3w2d1+VmjdiZQlx?=
 =?us-ascii?Q?QOL3zCMYapKtGiM1ZStkRkyF19OgBqHEgWGgFVsb5KfJrVQMdNaVPd1nF3vo?=
 =?us-ascii?Q?kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de669e6-4ee1-4631-eef4-08db7c9a77e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 14:25:08.1419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kWx3lwHsZW/lJJz7Hfuesds2/xvqjnt+BxPp+/Xay3cGLK6XD0JSMh34DC1gQRMk1l/1MW+g1xJi1aizcyrKYj82hwyBdOOpW5KqcunAukQ=
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
> Add Hyperv-specific handling for faults caused by VMMCALL
> instructions.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 8e1d9ed6a1e0..ba9a3a65f664 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -32,6 +32,7 @@
>  #include <asm/nmi.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/numa.h>
> +#include <asm/svm.h>
>=20
>  /* Is Linux running as the root partition? */
>  bool hv_root_partition;
> @@ -577,6 +578,20 @@ static bool __init ms_hyperv_msi_ext_dest_id(void)
>  	return eax & HYPERV_VS_PROPERTIES_EAX_EXTENDED_IOAPIC_RTE;
>  }
>=20
> +static void hv_sev_es_hcall_prepare(struct ghcb *ghcb, struct pt_regs *r=
egs)
> +{
> +	/* RAX and CPL are already in the GHCB */
> +	ghcb_set_rcx(ghcb, regs->cx);
> +	ghcb_set_rdx(ghcb, regs->dx);
> +	ghcb_set_r8(ghcb, regs->r8);
> +}
> +
> +static bool hv_sev_es_hcall_finish(struct ghcb *ghcb, struct pt_regs *re=
gs)
> +{
> +	/* No checking of the return state needed */
> +	return true;
> +}
> +
>  const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv =3D {
>  	.name			=3D "Microsoft Hyper-V",
>  	.detect			=3D ms_hyperv_platform,
> @@ -584,4 +599,6 @@ const __initconst struct hypervisor_x86 x86_hyper_ms_=
hyperv
> =3D {
>  	.init.x2apic_available	=3D ms_hyperv_x2apic_available,
>  	.init.msi_ext_dest_id	=3D ms_hyperv_msi_ext_dest_id,
>  	.init.init_platform	=3D ms_hyperv_init_platform,
> +	.runtime.sev_es_hcall_prepare =3D hv_sev_es_hcall_prepare,
> +	.runtime.sev_es_hcall_finish =3D hv_sev_es_hcall_finish,
>  };
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

