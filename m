Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DCB65C6FD
	for <lists+linux-arch@lfdr.de>; Tue,  3 Jan 2023 20:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238185AbjACTKK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Jan 2023 14:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjACTJ6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jan 2023 14:09:58 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11022014.outbound.protection.outlook.com [52.101.63.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E000E13E0B;
        Tue,  3 Jan 2023 11:09:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilB0fMohrvkfLOcqn4rwiDIG9y07cDVwIpvJapsQrGw4nFWE6tRjkheXSzgwgwuEqauwSo1zfaag3lsV9b4WxG0AhZVvGJW0wFnRYwFfJgZO2jcM1nVRdxKgCh0PjzsOhKTEMhrwuj3I2ZA5D3KLVx+m9G/Pag4wHmidfsHAXhlNExuGnupiSq3wFfqwEuZNkWHKaIDp7bYGDHbYOLqxe0kiIB7qxaGD0COckxfSEVg4SMPm4zFExoamPwT/6W4eAAKJf1utghCcSVAo8sG94E+07Xmdjg/EhNsKMpE2qCLBOZ9WoT0CEySH+XBVq4eGMlMGgNkTU/esfiwfY5kabw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMQEiL5NgZl0IcCwd/yGrjcBZdenEOnIDCM58Ci2EQc=;
 b=Mwq+8T7k6Q9rtIrvHJVdZNWKvH8EY6lz9rFmI+Ozr/J8lj4MUEJO5/mg8yY1yvC2Tzl4ZVdapWluLl2Pu5AZO7FViH25ktjX87Z5rO+KcExc6RpCYB6z3BDcwWs+4z1Z48vdn/NDUf5rgFrvp+d5ibcH5fUSWrD+QFw9JDwbeQIwM/O5sn4styK2tfcxij5zooZ8kTX/AupuJqvVmX6didPkUdRzH49yto9TzabmHgEWPxIXU9QRWxhvqWChAf5L1bz4UiTD4UnZkceQDpkzACPjOqlD0+MLv6TkiDC9mAlPqk7cnCWa9NCgom2kCtP0TNfiugAORdmvT0SmjbPsuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMQEiL5NgZl0IcCwd/yGrjcBZdenEOnIDCM58Ci2EQc=;
 b=MKs6KfIr2J9cUFK5xxjlb7nDCziRUkeQpmJtGn9bWBdKx3RAbCWA34f1sqqkyFBxLwmYgxZZpzkSbSHcOQY2jCnbbSrE9kHxM/iXsuYz7r36rBcI1DQlP5mUR4soyZCTXEoDAbV9GGXM0V7JLGq84XuXm6kCnY04sgdn4EUBnkI=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH8PR21MB3872.namprd21.prod.outlook.com (2603:10b6:510:25a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.4; Tue, 3 Jan
 2023 19:09:53 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::db1a:4e71:c688:b7b1]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::db1a:4e71:c688:b7b1%4]) with mapi id 15.20.6002.005; Tue, 3 Jan 2023
 19:09:53 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Jinank Jain <jinankjain@linux.microsoft.com>,
        Jinank Jain <jinankjain@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "anrayabh@linux.microsoft.com" <anrayabh@linux.microsoft.com>
Subject: RE: [PATCH v10 1/5] x86/hyperv: Add support for detecting nested
 hypervisor
Thread-Topic: [PATCH v10 1/5] x86/hyperv: Add support for detecting nested
 hypervisor
Thread-Index: AQHZHnmpvVLD+m3uzEu9T0k4Q2fsXa6KtkyAgAJaXmA=
Date:   Tue, 3 Jan 2023 19:09:53 +0000
Message-ID: <BYAPR21MB168889C9592F7AD5CCFE9FF4D7F49@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <cover.1672639707.git.jinankjain@linux.microsoft.com>
 <8e3e7112806e81d2292a66a56fe547162754ecea.1672639707.git.jinankjain@linux.microsoft.com>
In-Reply-To: <8e3e7112806e81d2292a66a56fe547162754ecea.1672639707.git.jinankjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cdc26db5-0109-4aff-85df-da82e925ef19;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-03T19:08:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH8PR21MB3872:EE_
x-ms-office365-filtering-correlation-id: 3ba78a20-797d-485f-38e2-08daedbe1832
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EYyXQKVoVnOk9u3muTQ1C3QJWdWzHfg5dcpUML5ez6t5CE5ZbWjxLvDTehB46pCKgDiyQK54E13ITxUY5xvKTWhjVDL4k/2TTr88xfmwieEcmC0eSXzvXFTq11UhgCpibGw8uD4rFt9eQ+49iJ27poGwV8ldIbi3dgHs28jtMrv9CHayPMCn0cDQGFpuOdHU9iUpp+W4PTHvCEXH20H/ZF6S3HcpkbK+y99MbdwdGS2udmRu7ZnWOqGfPU/c7W6lSeoOMUbIz4/t9W3R2qpKTRmVF5kfhD4iiQRSSx9v8H1z8/3zzjW+CSwiaueO0vm7AiZ3uL2AKNGhdhpCJ16G/CMbCFrQ30FosJuIEtnd/2F0s+2h+NDd3CP5rx4p5cCVBxlPaSdFrmKF2ymiX2AoP14SGNcPdedCR6OZuByR2WriYz4m3l1dft4dEM0e1OSijLV7dhZVPwkR7FzxuOgEiQfuMxc8jugHuTu2/3ft90ZN2TwUiY7OcyUIT6OHNNkDv+J3lcR5pqxA/Ise7AxfW7qNgOQcPL1cHebX5VDlEMrsPmgPngmxZWFF6Ro2ZBBndK50NdAudqyRkfn7SWOFRnrzH+ha9/PxM/kwH6Jkq7hnAmaxSik1Nduf3E3z2PDgYR4xrrdl5LhzIOxUcqjnNwAMJXSYGjhwX1XX88bhPOt2R0do5B4Nv49ALAuaI/X+WkMtxkIumy6Fr207C/l/WDoTJFLvERu06OHLEFId6/0qDW0r6xnKOFtvjTknxIGqhvwjl4tMxGFz6ixCCvI+Sw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199015)(6506007)(9686003)(26005)(186003)(71200400001)(7696005)(86362001)(10290500003)(33656002)(107886003)(316002)(478600001)(6636002)(110136005)(54906003)(4326008)(55016003)(76116006)(66946007)(8676002)(41300700001)(66556008)(66476007)(64756008)(66446008)(52536014)(2906002)(83380400001)(8936002)(122000001)(38070700005)(8990500004)(7416002)(5660300002)(82960400001)(38100700002)(82950400001)(22166006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ddZbLWxQQ0cQi6MrpGrxWzW1IutPKngMcZOYYGQavVTqW4Htl3vJfJrXm02V?=
 =?us-ascii?Q?CSG+Eiz7/vpASQWX/SeZ2Zr1419maEdphRpFTW1z0ye9VzzMJEnUgAxhPdsZ?=
 =?us-ascii?Q?dVxST5G5eLYNiz/kRd8m8AahnIV+lOOBAYxQNqNOFMH4Gp504pmMgzFv8KNX?=
 =?us-ascii?Q?/XP/5K305m+xuS12Mi9sfhkt66grvw2OI+AGIT5olUWHNg9Gv5N7o1QkRaId?=
 =?us-ascii?Q?+njl+HaT6VOLYA0xRMGJrCxyewsYSfEJ9Y144woUx1g4TcJF/Y6L8/oZ1aQn?=
 =?us-ascii?Q?9Psdhr3qebQa+o+zQzsAk0RUDTgqm9XfDKottxf8uS8qWZiV4WFPLk+iYZt2?=
 =?us-ascii?Q?TulXdPQLDWvyC5UZzYw2XpNtO0r0raxRPAyLSzVNV3KC+/7e8ezpuZ8krGxu?=
 =?us-ascii?Q?rdZbghYCBnFHUaAWuAbinnii7vK67gcVXd0LkBQWrp7tVApzzRDkg+MBvp5x?=
 =?us-ascii?Q?/MAJOpXV29GX8rr/x8njCNAq32qQm2OZUV84PzHAtmu8EMc2W/pySWYif03F?=
 =?us-ascii?Q?TgKVh5sM9Y4Jm/7SSCDy2SAzboPDAjJySVd+Yy1TRsvCfmAI4ACQiruq+WQa?=
 =?us-ascii?Q?WMiYw19Tqx6dGLDu4lJwgiTrhscNx8TfAYnhi2pgtWQVmvkF29/qqqZ9UUcj?=
 =?us-ascii?Q?hSCMiG0aisEJKJSqfutYnXNWXMVtB4KrwX5/fwFsp4rwuxEl9BJ/EIvSV8YM?=
 =?us-ascii?Q?vST7UR8BXsNtYVivEWjakjNtbZr9Of2/5vB9jTEGSo+s1LfOsomf1gCrue3e?=
 =?us-ascii?Q?QvLLmbaKn/kKLEUocLfOg4Fw0Zq8FdcB56+BGmsONmjQByNofYjAHUVsKC5P?=
 =?us-ascii?Q?kK9ynPIZM8QX7ILTxXJnSyp3F6ITW91u052TMF4oJeHfqfkfs7w9rLfDFU/N?=
 =?us-ascii?Q?ZjPsKjNQzsQdrdmH6O1e1sIlf85LLvtQcm4NR3o5HE5Bu8/n7L0Gt5h7K2S5?=
 =?us-ascii?Q?dOhY3vLkGz7ryrbG33B44u7RkQUmHfUGo9u7SbFzc77pf/6GMgN7Tz1g1pgj?=
 =?us-ascii?Q?M75hlscz7wJD/WGcM+6Sa4c6qcrEhWiq9B1sh5RH2ztne3wPSD5WfOKvdBFF?=
 =?us-ascii?Q?8yQaJUghdoJ8zTDLsL/FkXhx4K2HaaOpNLvc4DKEiiW/9vK7MKhrOqSFDy59?=
 =?us-ascii?Q?WE7qbxj0aUeu+3FEbqsEiRUvkHxYudOmS5JFVv6QHqb5lUqg+XExBJVak7+t?=
 =?us-ascii?Q?+cwxIFboSuaSXWKZ321FJMiUn70bnsi7ndg1Q/J5SDkewanw+IWDL2H2RegB?=
 =?us-ascii?Q?GYiyZWz5W4Ph+Ic3CE+AqZKf2a/qcpz5Wy6irjqusYBHpuzbJXg7C7R7Me+M?=
 =?us-ascii?Q?CgCn6zEZmdyssvx3edVj+hwFdLVBvLHBpEPXQfG+Amcaf3T9xqiFDYvG/fxX?=
 =?us-ascii?Q?19WItG7/d/RS7ps1A2ERd0zqvz/U93KDGhFFNaKRcdMYAxu0dospsc1u3kUW?=
 =?us-ascii?Q?GBKUDUy9VrcOCEZLKckfrseLClwA9Bz4o3UtSPRUSQwnHLyJ0AsCNPJQz1Fg?=
 =?us-ascii?Q?VAkr1lEXio+wgmjfLUdLVJNENXCE+6+8XxMe2InZs/6EObZS0Tc8xdRsl481?=
 =?us-ascii?Q?woTlHwhURFeeflbzsTcEpuAmaPPEdRLxsrGSE0mebuM2JAHch+PTUJULMZri?=
 =?us-ascii?Q?kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba78a20-797d-485f-38e2-08daedbe1832
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 19:09:53.1547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0+m55ghcItP5HIG3aoUmL4ayEEKpAXcHx7+S9Hncm0YV05kS+oQSaB7F1UwewU3blCMUqb4ZmZS9Jk/BEnuSGog3HUN4s15oItB0MJhQDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR21MB3872
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jinank Jain <jinankjain@linux.microsoft.com> Sent: Sunday, January 1,=
 2023 11:13 PM
>=20
> Detect if Linux is running as a nested hypervisor in the root
> partition for Microsoft Hypervisor, using flags provided by MSHV.
> Expose a new variable hv_nested that is used later for decisions
> specific to the nested use case.
>=20
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 3 +++
>  arch/x86/kernel/cpu/mshyperv.c     | 7 +++++++
>  drivers/hv/hv_common.c             | 9 ++++++---
>  include/asm-generic/mshyperv.h     | 1 +
>  4 files changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index 6d9368ea3701..58c03d18c235 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -114,6 +114,9 @@
>  /* Recommend using the newer ExProcessorMasks interface */
>  #define HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED		BIT(11)
>=20
> +/* Indicates that the hypervisor is nested within a Hyper-V partition. *=
/
> +#define HV_X64_HYPERV_NESTED				BIT(12)
> +
>  /* Recommend using enlightened VMCS */
>  #define HV_X64_ENLIGHTENED_VMCS_RECOMMENDED		BIT(14)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 46668e255421..f9b78d4829e3 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -37,6 +37,8 @@
>=20
>  /* Is Linux running as the root partition? */
>  bool hv_root_partition;
> +/* Is Linux running on nested Microsoft Hypervisor */
> +bool hv_nested;
>  struct ms_hyperv_info ms_hyperv;
>=20
>  #if IS_ENABLED(CONFIG_HYPERV)
> @@ -301,6 +303,11 @@ static void __init ms_hyperv_init_platform(void)
>  		pr_info("Hyper-V: running as root partition\n");
>  	}
>=20
> +	if (ms_hyperv.hints & HV_X64_HYPERV_NESTED) {
> +		hv_nested =3D true;
> +		pr_info("Hyper-V: running on a nested hypervisor\n");
> +	}
> +
>  	/*
>  	 * Extract host information.
>  	 */
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index ae68298c0dca..52a6f89ccdbd 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -25,17 +25,20 @@
>  #include <asm/mshyperv.h>
>=20
>  /*
> - * hv_root_partition and ms_hyperv are defined here with other Hyper-V
> - * specific globals so they are shared across all architectures and are
> + * hv_root_partition, ms_hyperv and hv_nested are defined here with othe=
r
> + * Hyper-V specific globals so they are shared across all architectures =
and are
>   * built only when CONFIG_HYPERV is defined.  But on x86,
>   * ms_hyperv_init_platform() is built even when CONFIG_HYPERV is not
> - * defined, and it uses these two variables.  So mark them as __weak
> + * defined, and it uses these three variables.  So mark them as __weak
>   * here, allowing for an overriding definition in the module containing
>   * ms_hyperv_init_platform().
>   */
>  bool __weak hv_root_partition;
>  EXPORT_SYMBOL_GPL(hv_root_partition);
>=20
> +bool __weak hv_nested;
> +EXPORT_SYMBOL_GPL(hv_nested);
> +
>  struct ms_hyperv_info __weak ms_hyperv;
>  EXPORT_SYMBOL_GPL(ms_hyperv);
>=20
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index bfb9eb9d7215..f131027830c3 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -48,6 +48,7 @@ struct ms_hyperv_info {
>  	u64 shared_gpa_boundary;
>  };
>  extern struct ms_hyperv_info ms_hyperv;
> +extern bool hv_nested;
>=20
>  extern void * __percpu *hyperv_pcpu_input_arg;
>  extern void * __percpu *hyperv_pcpu_output_arg;
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
