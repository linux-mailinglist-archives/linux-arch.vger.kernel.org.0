Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B44562F939
	for <lists+linux-arch@lfdr.de>; Fri, 18 Nov 2022 16:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbiKRPYd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 10:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbiKRPY3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 10:24:29 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11021023.outbound.protection.outlook.com [52.101.52.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE8F61B8A;
        Fri, 18 Nov 2022 07:24:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ilil6L7+KC4BI1YR98HT0ijEdt+o4oHsivDTzN4AGuzrox5xECQXKAqvirtyol+xfWry+lIfVG4KZsBYBm6WV3lwttykJjMwa5fr3orrj4XbCfUR04PAKdTUCOsl5RLmeCQ/6YLuEkjT1P7AoNKxdupQ2NWZFSrM0suLeJnI0TnkBw3fXGXS9hkjqOi3ChZdD8mnQVEoza229D0avZA7TbMJiNUyWK4sMS6U1aXN1mXfEa+1gjhAe6kmZGparYGo1QbddqIjm5L4KtuxbM0R00noj9dzECPIyKAyAQhslfWMrGK942fnPCHtjkX7uDciXFWNCom+by6oz9yHOrKM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDlgSWA6/uA+gs5xRlU5H5sJXDO54H+ujgqwmSaDF0Q=;
 b=AsogAIp2e0bxQxq3Z7OJVK+PbEkhVagLC1ytYXm3bLxU1X1NAQLkXO6AP+zOG6tqddSxMOHqGPKQMQUTQsHhHByTWh1HkKJIGJMyx8EGRq5CKABUpE4GZmOk3e6YEwB1C1CBh6nhECiaUzEZ4+rapicdqRLfAgUoop1in0gABhg+G9+N+meVTUMrDygHpXbfXaTkRPzB0xhREcn3FX02YFBGa935jVAIK3DnQp60j1eFHLtJyx8C9Pc1s0uXC8hQAC8wp+GXwSSbicZwzPj7f7wN7HR+t8JEfvi6jTcIUH80SEcT+hXMXvXvBz+4Am0IfMu4wPOYwIgQU2EEwU0bWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDlgSWA6/uA+gs5xRlU5H5sJXDO54H+ujgqwmSaDF0Q=;
 b=biwsZ7GBFXoyWb9LyiMeNWYeTR0rPkH/HpmKqEPsSAwWdmQiGP9nlDUcSbWfE750FAt2PRd8obrbBUCwFoW20wuYI+4Q4iuDVdYjrpNvaS6dzoSpjVgDOhlt51QuiGyJm0yprlhiJv8C9qpvjMvBE5gUmYR+Hfa8MYAhK5dAltA=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3384.namprd21.prod.outlook.com (2603:10b6:208:380::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.8; Fri, 18 Nov
 2022 15:24:25 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%4]) with mapi id 15.20.5857.008; Fri, 18 Nov 2022
 15:24:25 +0000
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
Subject: RE: [PATCH v4 1/5] x86/hyperv: Add support for detecting nested
 hypervisor
Thread-Topic: [PATCH v4 1/5] x86/hyperv: Add support for detecting nested
 hypervisor
Thread-Index: AQHY+jSiLohpBYaVr0ORI5uxZASSFa5Eyuxw
Date:   Fri, 18 Nov 2022 15:24:25 +0000
Message-ID: <BYAPR21MB16889A73BB7BD863CE92820DD7099@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <cover.1668618583.git.jinankjain@linux.microsoft.com>
 <08ab7aede41f2feb1cd8ac21d0ddd17e25b1d070.1668618583.git.jinankjain@linux.microsoft.com>
In-Reply-To: <08ab7aede41f2feb1cd8ac21d0ddd17e25b1d070.1668618583.git.jinankjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e1e12928-9525-4d73-8d29-09a15cc516d8;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-18T15:08:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3384:EE_
x-ms-office365-filtering-correlation-id: 1e51d224-311f-4b64-1342-08dac978fa17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: POt8G/vI+GEyMLbkrFzHSRfSrZS73jmnIIACF6EGOjz9/D2UdLCZxQ+/HPrOwfpYquFZtaK+xCGMd3q1VvLk6akIvs8N5TXyZl2AeMAGzd0iaxcsBBHhD/0F+AzxK4nf9Fn5zHmg8FEHWamggDD/Qtm3rWoS3cbR82A8HboLEXdI+4r/JlWen2QwaFilnP6uAR/VC4e+PnA0nSdBjrwRDrzi7nE8Ufdpe0NNvjreQKfZnMd+8/TEnEpyY1VDHnOtC2h3pDdaO1TSJ4hAm/iwPGhRP2Q7H/fQDJQDE+t9XWJCXz2/x4pQxnr0Xf094zALBZ3zwyAjx5g93IhBBhAHBijwUI4z31LIRYzOU7e1OePGemDRq4n66kc/WDgMUikmzOJafH0IUB2RuOF68/4XVNNZjqwMfkyKNX147oqz5nu7r0Y7raJNJ0qJ0zWF8S7bWljCjO70Es3l5tVu1Omp7I0C2cAe9NwA26KAvo5jn3vX98Tg11vD2D9g2VAVpt62tdIuakzzB11MOCz5uW+TN4EpF/63ttHrz/OK9N9R34s4slMgla2nyUX3KF5PAgUttVRbKNH0HBELA+zBD40llcdaXJ9fbhitgr/SZwtqR1erW0SvOF668KdOt/5/VnxnN3hzb1Bja+YOEFPqQpmVqVCTGIb1qeT1AMtKgBYwlmc3cePf3gc5aMfFkGTIxHyJVkDw0gR6IJ1Hl9omJCZ8he/9OcIWCmNgIRID2bFuqmOvHDFzF95OR/rnH6pEGOk4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199015)(8990500004)(2906002)(4326008)(8676002)(8936002)(7416002)(52536014)(5660300002)(41300700001)(76116006)(66556008)(64756008)(66946007)(66446008)(66476007)(122000001)(10290500003)(316002)(82950400001)(38070700005)(82960400001)(86362001)(54906003)(478600001)(7696005)(26005)(6506007)(71200400001)(110136005)(6636002)(55016003)(83380400001)(38100700002)(186003)(107886003)(33656002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6EOA9nBBJA7bT4xefGwRg/W07ZNXNVwxOzOMJp/Z9rCYcf7rtEoR7fEbL7S+?=
 =?us-ascii?Q?q/79Cvhc0wh+Ke8KbgxjvDWXu/rF9u0AVR1kD5yT49xIGfsvTMlLZiWhXDKo?=
 =?us-ascii?Q?AAjaRHJPukN9xYTatbHnDhjeBmwlBGJWB6a9p+5//J3InwFhBE7C40nER4DZ?=
 =?us-ascii?Q?/HJm62eyn70I2nXUCQpe24KR1XVSzQtKwOmfWEwVH7T7xj2zmcA7Y0QP3poO?=
 =?us-ascii?Q?TmDh3rJSRgDsSOKjUL8veg9devVEYrsC4CPGhrC+3khtvxqj/dxN/fPpKDKA?=
 =?us-ascii?Q?HaYplhoimddKvHQjgZLwT/XWP8KDO6fhTm1gz9TTcyxJ1rzxh9NVSrZ00ZVT?=
 =?us-ascii?Q?ldiBSlYUEBTBg94oult4MPuu/qqTHPiYvFFJJoF7pVB4KJTebAgAXw+5QjXY?=
 =?us-ascii?Q?kv//Qvh7V35HcS8tjq6JucXWVCoXAgLXFNhpJyVXk2VKfbpac780DcYAr0hA?=
 =?us-ascii?Q?zNg+9JFOvFy+bgjDUx8Is+O4pOD85tNeOoRdp1kNtbNlT7/s9km/vQ67eapq?=
 =?us-ascii?Q?4zlY5Ek+5SdxmJgV1jwy5ihABFs7JlvzoUwZZh1uNk0ce7cxnm89I9QUG2LP?=
 =?us-ascii?Q?Tigz7EWcjLR1tlr7kARtckqIQZfxWeAuTs4rigBcPIsMhjsLbHG/7NQ9UfL+?=
 =?us-ascii?Q?RGWJHmXqDfwCbaVKBbAF5oCcTA47ibla9eG+ipDaTBZvIx6cVjie6aYBh2aY?=
 =?us-ascii?Q?t9PonXOQ6m8cUiDiKbO0GOJGRHndeQ5FfUFoSXAQm5l6hPQL1yBOqsC9vPW5?=
 =?us-ascii?Q?frzdiDX0GPn9VH3WoKSo/pYVwqjt4MQdGu31ypTKYVpAbw2/7ih2OYTAGsHQ?=
 =?us-ascii?Q?KZkbvhau9HrOQpaCPZoKIACqPeKYUewKO2VknNHXt8R5Gm3MiKU9aG/eqLIv?=
 =?us-ascii?Q?nt3CUvRfzMVCvk8ZEWWacQMbST1FickAC6JoSyxFK65aO27Ik0WuMlLI9cwR?=
 =?us-ascii?Q?BKpeZyvR8oH2rgiV3tapdJ2yLER+fQMg0zLfUhkBTcir70f7u92kJqumN25r?=
 =?us-ascii?Q?vICvgK+/uge3iVyEXAsov2X6DtFt7EXc7lAbB0KFPiMiohi+1fdyGDRWqSIt?=
 =?us-ascii?Q?2Sc/EDE+haBFtmOPALT/jdNFX2sMjtZpX9l7ikfFH9oFtIGGf/646w4sy4U5?=
 =?us-ascii?Q?6Ws/9Hoja+V3A73RgvTMFA4rGqZjyaWT0yG7DNVx/RfrUos14IpoFBSAgaur?=
 =?us-ascii?Q?Y1eI05woqC97/Mvg7yQKjGs6c/Ni4u683VQ3D8pW0bAzc194Moot3XJkVz7U?=
 =?us-ascii?Q?z8pvGgJBAG7n5gacBK1w2VZ2FGyRtpb2AGr7ZoH0P/RWyty8KLj2q191V32x?=
 =?us-ascii?Q?1qSAPNLVcXVyaBHmur2p2v89H3yPC2XiEjr2Nyfu/lXkkPTD/2xHO+DXn/dC?=
 =?us-ascii?Q?QlY8YV+wT9xergAggYFZDlEw9i2KK9lm9MkH8ItI6n9AErta6oQsVq4xZjQl?=
 =?us-ascii?Q?bWIsEoTT4UE4RbJu3PNV/gKENCDZAEEKqnEDmIOa81/lSHmeFD3sWv1aH46y?=
 =?us-ascii?Q?w8/FRZumUXElBHcT8FLvY10RJ1pxAWNeoEwvwQuMCPsLxeot800qacTInJeY?=
 =?us-ascii?Q?uP1zfRiJ++HmVyU+5rq4lf3LemH0fzN9AG6Q2paIhrxG5QlHbWske/WFyCjA?=
 =?us-ascii?Q?qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e51d224-311f-4b64-1342-08dac978fa17
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 15:24:25.4796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zWfORV+2CedzHZBWN8r/IQ8DJOXQAsPGK8jPBj59LFG7lVSDsNQXyzkuwhRVB3L/YEitR7rZuB873FMpvA3KvxJQDNP2gG2jYP3QSZBTcLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3384
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jinank Jain <jinankjain@linux.microsoft.com> Sent: Wednesday, Novembe=
r 16, 2022 7:28 PM
>=20
> When Linux runs as a root partition for Microsoft Hypervisor. It is
> possible to detect if it is running as nested hypervisor using
> hints exposed by mshv. While at it expose a new variable called
> hv_nested which can be used later for making decisions specific to
> nested use case.

Make the commit statement a bit more direct, and avoid equivocating
words like "possible" and "can be" when there isn't anything that is
doubtful.  Here is my suggestion:

Detect if Linux is running as a nested hypervisor in the root partition
for Microsoft Hypervisor, using flags provided by MSHV.  Expose a new
variable hv_nested that is used later for decisions specific to the
nested use case.

>=20
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/mshyperv.c       | 6 ++++++
>  arch/x86/include/asm/hyperv-tlfs.h | 3 +++
>  arch/x86/kernel/cpu/mshyperv.c     | 7 +++++++
>  drivers/hv/hv_common.c             | 7 +++++--
>  include/asm-generic/mshyperv.h     | 1 +
>  5 files changed, 22 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index a406454578f0..2024b19dc514 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -19,6 +19,9 @@
>=20
>  static bool hyperv_initialized;
>=20
> +/* Is Linux running on nested Microsoft Hypervisor */
> +bool hv_nested;
> +
>  static int __init hyperv_init(void)
>  {
>  	struct hv_get_vp_registers_output	result;
> @@ -63,6 +66,9 @@ static int __init hyperv_init(void)
>  	pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
>  		b >> 16, b & 0xFFFF, a,	d & 0xFFFFFF, c, d >> 24);
>=20
> +	/* ARM64 does not support nested virtualization */
> +	hv_nested =3D false;
> +
>  	ret =3D hv_common_init();
>  	if (ret)
>  		return ret;

The above ARM64 additions aren't needed.  An architecture that works
with the default value of "0" (i.e., "false") doesn't have to do anything
as it uses the version in hv_common.c.   While explicitly coding it on
the ARM64 side doesn't break anything, one of intentions of the __weak
approach is that we don't have to update the ARM64 side every time
we add something that is x86 only.  To avoid irrelevant clutter on the
ARM64 side, the preference is to *not* add such code.  Similarly,
you'll notice that the ARM64 code doesn't initialize hv_root_partition.

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
> index 831613959a92..9a4204139490 100644
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
> index ae68298c0dca..dcb336ce374f 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -25,8 +25,8 @@
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
>   * defined, and it uses these two variables.  So mark them as __weak

s/two/three/  (since we now have three such variables)

> @@ -36,6 +36,9 @@
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
> index bfb9eb9d7215..5df6e944e6a9 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -164,6 +164,7 @@ extern int vmbus_interrupt;
>  extern int vmbus_irq;
>=20
>  extern bool hv_root_partition;
> +extern bool hv_nested;
>=20
>  #if IS_ENABLED(CONFIG_HYPERV)
>  /*
> --
> 2.25.1

