Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7366C9610
	for <lists+linux-arch@lfdr.de>; Sun, 26 Mar 2023 17:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjCZPQV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Mar 2023 11:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCZPQU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Mar 2023 11:16:20 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2129.outbound.protection.outlook.com [40.107.243.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FF6618B;
        Sun, 26 Mar 2023 08:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wv2qnN9Yc+cpLe8VX/oLHEwWSrV3oY/OI+q/MvwzLGtCw+jXbsvibVYk8iCMR2FgZ/4c8CfU/vYHmgRJlVQLNhMAqK1CHSHrKZrJr4HaopPPzUGfUYbBp2ZyT8p85RnoPzZexQxjh7mtQs3H9uiI3MOEewpOKajeZ2nhLBphmH4WqPrLmKfjppHVde8OkiTvfso5Sm0w0mJ9pl+UbEEGPdkpEJPq3Gugy4GfTTgftrVgUleyRJxlJkT/Lg8pH46NUlsgeOxuqsvsO5YfTIoxxRqSbukVyF3at4eumuo0zVyBz2y5RewI4MjQKWFbBFHPGKUU1beFiExRb2refuntIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oi6hSdPU2ZW5DWXDws7psTJJG7/xRe2m9klJzZd802Q=;
 b=ZHPG20ItqT0LUf2WWgR/HWkc6acx9J8w67RqlMpx31Burd0FOQ8KRD43syV0GPTnphno48jnIdYUTlb5bbdCPvhnWORDNjCSAUP/rENA9JUCnlqvBGbbEzm0jUZHCno6mWnCuccCPNlmCMwMByvWcttkBiWKgzxIxvCYUYHlPPylqfse8iVUiFWXgdc/oxUIemmfW4yBd5p9bm19b4BhzkK7dkmreGNhKU4zJ1KyybWDVv5XvwSSSSGkpE1lnGPQ33adwnjeCVWpsn485ixU2o7OPGiOMDe1AYt6EICAQE/zDQaSXGk0TCW0WUsOf2OEGkQeH5+i0bP76m/hb28oxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oi6hSdPU2ZW5DWXDws7psTJJG7/xRe2m9klJzZd802Q=;
 b=KfaGGMPix/mSa3Xnco3PAPmj/h7yI8CylViUp7c/JxJYL8KNoiNT6E0qItZ1XijYas5uYWtzVsXmkzfBoMj2ZBTRFnxq2On4gdq9gVfW+sx7njtsk6WYzO6pbjaXI1SJdHV1OxpqYSFADDv12PxgPtRfxfuPE2IDWAPocEOROEw=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SA1PR21MB3809.namprd21.prod.outlook.com (2603:10b6:806:2b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16; Sun, 26 Mar
 2023 15:16:15 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6254.014; Sun, 26 Mar 2023
 15:16:15 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v3 5/5] x86/Kconfig: Add HYPERV_VTL_MODE
Thread-Topic: [PATCH v3 5/5] x86/Kconfig: Add HYPERV_VTL_MODE
Thread-Index: AQHZWxNEqRYSn0nD+k+iKqSzBIKvFK8NM95Q
Date:   Sun, 26 Mar 2023 15:16:15 +0000
Message-ID: <BYAPR21MB16885C786D5DC8381C21868AD78A9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1679306618-31484-1-git-send-email-ssengar@linux.microsoft.com>
 <1679306618-31484-6-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1679306618-31484-6-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4f15cc9c-6bb7-45f8-a12d-80e43a7db871;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-26T15:09:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SA1PR21MB3809:EE_
x-ms-office365-filtering-correlation-id: 645c3951-ee31-4001-9ea1-08db2e0d0ac3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R03V4eCysOtpixk5j4YU6bX75M0Fr86WT7n2GuCTf9/3Su81lN8kIdyN5L72byzum1MhYIdDBj9w9SNHmKI3s3TnkGw942KuKYNHL82pr4B1cxexJYaP2P2X1mYkQqIH8JcvmBinND2/5ooFAX9q1+DX8th5x3xdHNynNIFw8HONnCgXmC47feMiMimzv/ww9979kPYfON/dbiTL46yWdGe9bsLpvFrsxdtYBOu+iy+L3guqcnlryujb8g053p5Q9rzkcmlUIIREVo12kk7K2T1GaPI6W2g6m/ZI31PK2bTL06VDyrCEKLjsNoYpWJ0Z6MgW2E9/Y7V1XHS8x7Hga3UcXo946Zwt4fWc0wd+YE5fQnH9jQYeNHgwSrhcDCeKrc/uWgsNIN7d1lNQEv6/T+DHW0ISzGO7M/7/X3liNho0XdpLIEx2bByry8o9VVU7PWeb4v9ZExEBV9g+jwATEwzr53VoNxUgYCJg//ul0uHeoLe8SnnKevmOJYx0MPEkEnX4PorLIW55UkN5/FwHM5IXOuSMfdFrvRf5fkW0sUh79367qwWoFseB3+bIF6n18qTbSt3em657sHDpH0rUJu+4mwGvaiIZ742GO5+gbjqrjTR5uF46TqrX47b7oOHBjz2CGepi3dCmXjSC+tdokltgvMVZVV8sXaFg3xryzEsAsaS9WjZfLZxZsD1cLVZx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199021)(122000001)(38100700002)(82950400001)(82960400001)(55016003)(33656002)(86362001)(38070700005)(921005)(2906002)(10290500003)(186003)(26005)(478600001)(6506007)(9686003)(5660300002)(7416002)(8936002)(71200400001)(7696005)(52536014)(41300700001)(110136005)(316002)(66899021)(66556008)(64756008)(66446008)(66476007)(66946007)(8990500004)(8676002)(83380400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pax20+B2o+WgMbJ+IRuFVNRMm9ZMpcrQlgVKYm1LqQ2skO+6a9VZ7hF0P2ZF?=
 =?us-ascii?Q?osetOWX28qzms9IQvPJOifIlyI7BxHoTeOgY6Z9ddIVJijTk6e2mcnmUgldG?=
 =?us-ascii?Q?4XrbR8tTIkCe/Rl4A9Fhj7xgLXmPnpaEEFV7ed+FpexDb1QPFuR9kY3MmGvF?=
 =?us-ascii?Q?KOVV6ghHtzu/Wufx0tNxMwLzenAl0gOic+rKwN4NE6tTlvu2c6Z7crot6ovv?=
 =?us-ascii?Q?xpVBgUAxtZxRjzytxpaIreJh9+XVLLZSEPsblU1S2UMP2f1MQbLDrxCr6Mal?=
 =?us-ascii?Q?eZRPIQSvPnMV2Lnwx/OJoDBtHaOY9e5Yu0zqRWtjA+0NExiexF2EvFh3JR5T?=
 =?us-ascii?Q?dbnpiUAdY72SDZgw29vgVLLAG+Rg4erzS9I7uzYnOUvV1bbmo5NQHLMzPClq?=
 =?us-ascii?Q?Voxx2aHdaZfE0+HafyYf9lFcX/fIEMGzZnHnNGlxAqpCWb/hoCJdyA7kU+yZ?=
 =?us-ascii?Q?klEIFd0TJ7ctAMVgKHDO/UMhX9TVYkOOH4LF2FevvW7tourbDZXJfTnp5K02?=
 =?us-ascii?Q?1WCvWlOAxIO5sc8zMjPJnPO0CGG870JWb6t0jOHzyVZRIZY6jb6WTyp8Apvs?=
 =?us-ascii?Q?LiEW/A3jlxlAoOBl0fL0IMzHd+pEXSLEF+p3E1kzX7P+TJmrbd5AyILBhA0u?=
 =?us-ascii?Q?ZVU5jzRY+xFWqfdApVyRySQTfCUdlHOhzBaj9WPzeF5evNHqFxpvGcpmm76X?=
 =?us-ascii?Q?kftqZ9hjTTWUjfBOqv03GemgvUisQSYjb2JbopL0XGW72VnEeo9wrClyIF0D?=
 =?us-ascii?Q?b+JbslzVO4K6dVxcAtJbeW7BPj3oDl68qPSZwa2Ui+fha1hq01kqxWTh6LP2?=
 =?us-ascii?Q?rRATZsRITS0mjHJnyqkkyo2hMCl9No2wKUmKJazHSiTAPo4r1lQzBqZe3EC4?=
 =?us-ascii?Q?1HmjYgjU4pUCXJMzXyJU2ICRkXX/dX7k3t/ic1etDbgEsqNBsDT01yJy/Jol?=
 =?us-ascii?Q?VithZX0ehmNRroRhuo7Gz/+ALEhqEKEP2b2Tv/qOijdo2GP7M7Y77TywvWQW?=
 =?us-ascii?Q?SRcHq+dwEQjiqPrGZUSlCfmlvRjGGSxHkm0nVCNCyYVPkhmTISwDpvFK2dRQ?=
 =?us-ascii?Q?n7ii0B3Z88ORx9kWmqTFIA2z1Azc29+sjGRZInc0nnWtcsB248GSgxGZyPQX?=
 =?us-ascii?Q?PqLtWdKIB7YUDwqU6imqtS1FVAvHET1h5GZmPWTzUgw5nmspQo97++Sf7H2s?=
 =?us-ascii?Q?OYK0geecnvP616bIjAkdNx4v2iMx5d63I1N5TZXsBujOseRWbEtPhSLuThg8?=
 =?us-ascii?Q?z38a0jVglRQTBVu6qhSz2LlXgKdCaCL0mavLmwWUqPYnx6rvLDHs1002VnY5?=
 =?us-ascii?Q?uDlpNF3MvoGVaGeyjJ5f0AMDHwqc3j3CQqhHwS7exEQJ0L1SIZDZUMK8oHvF?=
 =?us-ascii?Q?tcgsOoraja0oydCVaWdBEGTSkAuOGll1NEIdGfA6+wMt2t7f5yV+s+CJgLBv?=
 =?us-ascii?Q?H9QRiDvDHhWfiUZZgHEPNXk3uKj3Wy4b3PItgMUFcrhIlTWevjMHHptP80zI?=
 =?us-ascii?Q?Lyg/YnKxQcnrPnAZha2Vcar9wvhNk+Yu5jDikrldHlaJJ+0iXG4F6BCn8rUH?=
 =?us-ascii?Q?aSPBoKw/IXeBUapv0Ot1dELTxRLsQ4eDNQQb00C0ozQpb3wycD7W7sv2pa7J?=
 =?us-ascii?Q?vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645c3951-ee31-4001-9ea1-08db2e0d0ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2023 15:16:15.2527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uxBwz/M97BG6H14+A2Ujct01MTb2DdjqsA9nQMgFvrxFW4U9ccvG02BcC5qLJq2PZ1Oz/BY9OFHUEXvOj4CvOcwxbD90+NeJ4NIfk1ZaaEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB3809
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Monday, March 20, =
2023 3:04 AM
>=20
> Add HYPERV_VTL_MODE Kconfig flag for VTL mode.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  arch/x86/Kconfig         | 24 ++++++++++++++++++++++++
>  arch/x86/hyperv/Makefile |  1 +
>  2 files changed, 25 insertions(+)
>=20
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 453f462f6c9c..c3faaaea1e31 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -782,6 +782,30 @@ menuconfig HYPERVISOR_GUEST
>=20
>  if HYPERVISOR_GUEST
>=20
> +config HYPERV_VTL_MODE
> +	bool "Enable Linux to boot in VTL context"
> +	depends on X86_64 && HYPERV
> +	default n
> +	help
> +	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
> +	  enlightenments offered to host and guest partitions which enables
> +	  the creation and management of new security boundaries within
> +	  operating system software.
> +
> +	  VSM achieves and maintains isolation through Virtual Trust Levels
> +	  (VTLs). Virtual Trust Levels are hierarchical, with higher levels
> +	  being more privileged than lower levels. VTL0 is the least privileged
> +	  level, and currently only other level supported is VTL2.
> +
> +	  Select this option to build a Linux kernel to run at a VTL other than
> +	  the normal VTL0, which currently is only VTL2.  This option
> +	  initializes the x86 platform for VTL2, and adds the ability to boot
> +	  secondary CPUs directly into 64-bit context as required for VTLs othe=
r
> +	  than 0.  A kernel built with this option must run at VTL2, and will
> +	  not run as a normal guest.
> +
> +	  If unsure, say N
> +

Is there a reason for putting this in arch/x86/Kconfig instead of in
drivers/hv/Kconfig under the "Microsoft Hyper-V guest support"
menu with the other Hyper-V settings?  It seems like grouping
this with the other Hyper-V settings would make it easier to find,
unless there's some reason that doesn't work.

Michael

>  config PARAVIRT
>  	bool "Enable paravirtualization code"
>  	depends on HAVE_STATIC_CALL
> diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
> index 5d2de10809ae..3a1548054b48 100644
> --- a/arch/x86/hyperv/Makefile
> +++ b/arch/x86/hyperv/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-y			:=3D hv_init.o mmu.o nested.o irqdomain.o ivm.o
>  obj-$(CONFIG_X86_64)	+=3D hv_apic.o hv_proc.o
> +obj-$(CONFIG_HYPERV_VTL_MODE)	+=3D hv_vtl.o
>=20
>  ifdef CONFIG_X86_64
>  obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+=3D hv_spinlock.o
> --
> 2.34.1

