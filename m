Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959CB63B275
	for <lists+linux-arch@lfdr.de>; Mon, 28 Nov 2022 20:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbiK1Tpm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Nov 2022 14:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiK1Tpl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Nov 2022 14:45:41 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11022027.outbound.protection.outlook.com [52.101.53.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8C9205C6;
        Mon, 28 Nov 2022 11:45:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdESAGu8/QjgzG6GydNO5BFMwmlP+ipRLfRyWYk2qpwiYdhzGLj71Vf7YZIzumTDXziCQdGkjMNdwnhShL+WZIN8MNdk5d+bjZQ5Ij4VgNu0g7hngaIx6uswKmS0BkVBj5Mxr8JjeBex+VWWCgDUIOjKKlE5OH1qrK6EN258fcfAgThYdFCAbcQPCggdY0couGOshGwAnN2/Xmzk2/CZwQcJOd7yM64/6OEiRA1Whe5B9GsbqPz7kpYh6jcsj8dNMxwbCH24UsTpHOoK7JOw7fobokLxNEzt/WXzZdL2rqRbDEaU1M59OQaY7CwceD2K/z+V3gVYyUadno1/LeYGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=er8E8ev/p0FXABkWQpu5+wbPpgm5DI1Cmu6d65ywqWo=;
 b=Mwc86XeJ+tBXotjygzx8UdNAEYinyyooO2nY1AUKdxJM7K/rDwJTnq63c/GSrJNmLcQrDygZjqaqoHtt8YEzBYN7bzxa9w/B7WorTxSLBzRtrsFusc5dqb/c0QENV+NY3SlPoW/vkCB5P1FWN8Z73ZHtX0dpjXQwYzHddooOo/AuszLQS4hRMXlCM7hilocIfNTHrgKAF1uKxZzAaXY+xdQJ9Q1fVAUvIni7XNtlcc2rHFWR1WfLaxvJA8KMlcCFihlWzz4WdorfcKAPbKnLlfGYMgJ70FzVbI0wD1abI170nSErVqJTTfie4g89tTmRCcxfdO8VTTv9DDcHIjQTtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er8E8ev/p0FXABkWQpu5+wbPpgm5DI1Cmu6d65ywqWo=;
 b=B/oUj7ubss2xx9lGCMO5SPN+G6pNz2LnA6DNq7Eh32OzIouFh/gd8SOCCeqQWAetnbWlZZwxFGI36UxBuUVHHE3EGbA/wvYm9z0zI/7rLbBz1cM7Lx0EzYk+Cn2ht10eceYzStf4Gz5pTXH+RH+o3abxZP/2THE9IjzMtQ++3iI=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SA0PR21MB3039.namprd21.prod.outlook.com (2603:10b6:806:153::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5901.4; Mon, 28 Nov
 2022 19:45:37 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%6]) with mapi id 15.20.5880.008; Mon, 28 Nov 2022
 19:45:37 +0000
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
Subject: RE: [PATCH v6 2/5] Drivers: hv: Setup synic registers in case of
 nested root partition
Thread-Topic: [PATCH v6 2/5] Drivers: hv: Setup synic registers in case of
 nested root partition
Thread-Index: AQHY/8pXSjQlSipOuUSuvuBGSoM0La5UwP0w
Date:   Mon, 28 Nov 2022 19:45:36 +0000
Message-ID: <BYAPR21MB168812D4F283EABBA20C6E86D7139@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <cover.1669269377.git.jinankjain@linux.microsoft.com>
 <bf78acdc273fa730faf6eff49dd67a32c2242d84.1669269377.git.jinankjain@linux.microsoft.com>
In-Reply-To: <bf78acdc273fa730faf6eff49dd67a32c2242d84.1669269377.git.jinankjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=92211c0d-19dc-4789-9d1b-8bcc3a6da3f3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-28T19:33:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SA0PR21MB3039:EE_
x-ms-office365-filtering-correlation-id: 6b33f068-825f-4103-c359-08dad1791f21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +jjN34mBMmxhXHSdp54Z9l8VAcvRoD2AiD6z6m9Bd19N6Lk1NCbZVjBqUPdcz1qwBXUiuzz5XnNxC6oJ0rN74A/T5MqeaR+wh4r1f7dJ4FR/r9ClXFMYCqXRM3SE98bK53eKTdH5YoxfQU29Xds8zy23TI12rumuzk6P9H6K0YJkCW0BovlJDwuuOtvdGGU61G6iXG4Y/TVe6NXyef0tPkI6YtwxFa2TzFoBONhYKJjd+a6UXpfpYrlnqcoroi3UPZHxFahYM6a4R8G++kCmEO7iwGkYUBYgMIcb/FKXuIsTqmvOznQnHEix1R8pDG9Jwgos352k5CzXbNjncF0p+CMwiffTgTPK5m0MV3+RGg84EtK9H8EVjkLfD330jxsjdkZ4i7shn1aN90raRLJsTuJcXpVAvxjLmd5DevKh2eWrj/OmaoDZTI93X0lgOL5aX/yyHZenfC+wIkAnU/gMhDpIwi1qEGEQMjWR82FgyuIRBcC3gZsgJKfEai5fcklveWmlNaTuIiOnrfCP/zrtTV+eLgIKR+PFYITXXTWXKyUcrsuOcTHhFLmA5sdYeDijffANI9/XrAHYlyyyN3RKYH81HWhZpLIxYv4by1yTIMbFu6b/v4GjIeZFRfZ37IDnAGQnuE2tzuk5KDRow5npZDriHQKNMJS6c25kVLxAIkZr7MQzL0W5iGOiQA6eW724cRBJNN7S3byz4KgMsSzXQC+Q3Gabi6C2cwtLoovMTE0i57qMae78aGvMpVBzbnnd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199015)(38100700002)(122000001)(33656002)(55016003)(38070700005)(82960400001)(82950400001)(86362001)(26005)(316002)(9686003)(6636002)(110136005)(54906003)(478600001)(71200400001)(107886003)(10290500003)(7696005)(6506007)(2906002)(83380400001)(5660300002)(7416002)(8990500004)(4326008)(8676002)(66556008)(66476007)(64756008)(76116006)(66946007)(66446008)(186003)(52536014)(8936002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UPbxPlVHHWRTCNzON44lC9usvi8KO1C/XqTGNejfhCU9ntA4gHsiLH6CMyzh?=
 =?us-ascii?Q?vAqRy4PuHO7G9SCJqAk8x96j0QrH/LcVt0/MO2+rC30PMC6tLqys0as6mJw3?=
 =?us-ascii?Q?lPIYzZsKq0XeLhjwyCRKt/xHC+95KPueF2TwzPUyKv94J+pylnzG127S9Ak7?=
 =?us-ascii?Q?lvr15DZdvB0vapA+VkrzzN7EsHTjcK1Dl/NJCgZSkzFVe/NvYfhHCgoVITXi?=
 =?us-ascii?Q?JSScV+hkCKbBXe8nBqs7vDViMLtelSCkv1r4EsBA1ogLdTGleLnEN9YsbrM2?=
 =?us-ascii?Q?14jldw6Mqk4ZNQNRMXQInJDgsn4Z0hy+mD4znoPDVu7314HBrJHx1MQkLoNF?=
 =?us-ascii?Q?m5E3+QDkw/L3qnweM265/N0DWKhR7fQ+7A258BRgJftzT/b/3cncEPaqdGFs?=
 =?us-ascii?Q?iXWUqiratQ+K6hxxDQ/tNV+A/f5GV2smupDZ+JWsK862FTg15wHVG9Lp8KGf?=
 =?us-ascii?Q?VqMxs2FTbmFE3jAbTguXV7i0cYBNqtLnE5t0P1Ii4S+Ll1/eftxHXW9XgngR?=
 =?us-ascii?Q?JHpEV8sIrd0Eq3RjkvlSbXK4zCrpCH5R764WtZ3xXVszWEujgP1FlDumuHwK?=
 =?us-ascii?Q?oXl7W/GXwYSvuAqaEGIVTyNrfmb3vK5Mi07XU1EPOvyl4gi1FvTi9i49dynC?=
 =?us-ascii?Q?n8cQ12qeGvgsonOAdNzpGj0BBqs1vwa9YB/RYyz6RO1QrjPzBADDZquHtTiU?=
 =?us-ascii?Q?L1Q/bd8G4KEXw2BMxEZBtjoJDe9L6qY5837FqbGNklw1wnvnPJC9wbxprmFh?=
 =?us-ascii?Q?vtEkzvp8y1dbtInC2reDcy/wp+d7exF6nDWbRJIlEfyoDdbFqlGd/oIIIal2?=
 =?us-ascii?Q?pDMxvGiCmVG/lZN3/F5BaUHZJp63m8utCtSViVX3hvLFv8qWox9IYKNLkMPb?=
 =?us-ascii?Q?EnX2VC7OzHhkFyLaYu9eQR+VUuAVpGisFwBRwIcnTrd7ZQDtw1KM2LHYf8rO?=
 =?us-ascii?Q?tl1dKDzpwEXLAOkmTrGrMzDyBOeag+bjoFxTx0rmKi4ZLLShM+dl9qwi44A+?=
 =?us-ascii?Q?a8HWsJL1qZ1Dt8x3nTFCqCKDc81qVsevW0u6EErnSgH3pYkndnq70syDsrKf?=
 =?us-ascii?Q?+74N3qeUgSxuDdOiLPd8jBnXA3lKvXDtQuHeZn6vCbzcHDRln5AazMbMhOBk?=
 =?us-ascii?Q?Kxxa5PeePt3lKZ8raILuN6UMk9lGWH5W8ePtkEQ0sjuxM8XWcOUqCQ1KiwfW?=
 =?us-ascii?Q?1q0sOOvmQezQmpnAIfYLNdipOtBUC3XlGLDSoAbAfMHthe6ifVvXLvymk0g1?=
 =?us-ascii?Q?VW13q7D1nygJ9uP5llRF5nMeGUWM/+2EcGj9BCQgo3tX+yhE/aEmQRVuFVbH?=
 =?us-ascii?Q?MSqeDlezc7xtdyrRvIlvpt3lFgmKwCdW9K+rXHBxckBIGBMs7HiQ4FyOt5nb?=
 =?us-ascii?Q?McBerJAFz/Gk8tVfdoks/mKEhcj88hALsA9tx7YNNp5hwuX6MQ+lFKVb6aQH?=
 =?us-ascii?Q?nnkPVQwPti2O1CnXlvZzThODLcwUYV98Alz9t8rHJkcDKETlTtaFTAJDPLh9?=
 =?us-ascii?Q?/xq0DpgAc7ljt+yI+vo/gj9CvX7jM2C+DsMZmFNgOg0wIaSgLwipIXq8CU+a?=
 =?us-ascii?Q?QJrrZDzaJSWZLjU/tt4w5tlmyAkkbjUD+n9SO4ExcqMV0JOyi4mEuLiUPTJA?=
 =?us-ascii?Q?qA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b33f068-825f-4103-c359-08dad1791f21
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 19:45:36.9432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: unJjJt8Ts0R0XzBLzywonIbYj7gL/Modv+5uu5E6JoUUs64EvpDbJKTdeZQfAmO8jmTTUpvDpjKGBae8uocGxaQXijcR2NcAIdNhv8bEvAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB3039
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
r 23, 2022 10:02 PM
>=20
> Child partitions are free to allocate SynIC message and event page but in
> case of root partition it must use the pages allocated by Microsoft
> Hypervisor (MSHV). Base address for these pages can be found using
> synthetic MSRs exposed by MSHV. There is a slight difference in those MSR=
s
> for nested vs non-nested root partition.
>=20
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 11 +++++++
>  arch/x86/include/asm/mshyperv.h    | 26 ++--------------
>  arch/x86/kernel/cpu/mshyperv.c     | 49 ++++++++++++++++++++++++++++++
>  drivers/hv/hv.c                    | 18 ++++++++---
>  4 files changed, 75 insertions(+), 29 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index 58c03d18c235..b5019becb618 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -225,6 +225,17 @@ enum hv_isolation_type {
>  #define HV_REGISTER_SINT14			0x4000009E
>  #define HV_REGISTER_SINT15			0x4000009F
>=20
> +/*
> + * Define synthetic interrupt controller model specific registers for
> + * nested hypervisor.
> + */
> +#define HV_REGISTER_NESTED_SCONTROL            0x40001080
> +#define HV_REGISTER_NESTED_SVERSION            0x40001081
> +#define HV_REGISTER_NESTED_SIEFP               0x40001082
> +#define HV_REGISTER_NESTED_SIMP                0x40001083
> +#define HV_REGISTER_NESTED_EOM                 0x40001084
> +#define HV_REGISTER_NESTED_SINT0               0x40001090
> +
>  /*
>   * Synthetic Timer MSRs. Four timers per vcpu.
>   */
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 61f0c206bff0..326d699b30d5 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -198,30 +198,8 @@ static inline bool hv_is_synic_reg(unsigned int reg)
>  	return false;
>  }
>=20
> -static inline u64 hv_get_register(unsigned int reg)
> -{
> -	u64 value;
> -
> -	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
> -		hv_ghcb_msr_read(reg, &value);
> -	else
> -		rdmsrl(reg, value);
> -	return value;
> -}
> -
> -static inline void hv_set_register(unsigned int reg, u64 value)
> -{
> -	if (hv_is_synic_reg(reg) && hv_isolation_type_snp()) {
> -		hv_ghcb_msr_write(reg, value);
> -
> -		/* Write proxy bit via wrmsl instruction */
> -		if (reg >=3D HV_REGISTER_SINT0 &&
> -		    reg <=3D HV_REGISTER_SINT15)
> -			wrmsrl(reg, value | 1 << 20);
> -	} else {
> -		wrmsrl(reg, value);
> -	}
> -}
> +u64 hv_get_register(unsigned int reg);
> +void hv_set_register(unsigned int reg, u64 value);
>=20
>  #else /* CONFIG_HYPERV */
>  static inline void hyperv_init(void) {}
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 9a4204139490..97d8ce744e47 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -41,6 +41,55 @@ bool hv_root_partition;
>  bool hv_nested;
>  struct ms_hyperv_info ms_hyperv;
>=20
> +static inline unsigned int hv_get_nested_reg(unsigned int reg)
> +{
> +	switch (reg) {
> +	case HV_REGISTER_SIMP:
> +		return HV_REGISTER_NESTED_SIMP;
> +	case HV_REGISTER_NESTED_SIEFP:
> +		return HV_REGISTER_SIEFP;
> +	case HV_REGISTER_SCONTROL:
> +		return HV_REGISTER_NESTED_SCONTROL;
> +	case HV_REGISTER_SINT0:
> +		return HV_REGISTER_NESTED_SINT0;
> +	case HV_REGISTER_EOM:
> +		return HV_REGISTER_NESTED_EOM;
> +	default:
> +		return reg;
> +	}
> +}
> +
> +u64 hv_get_register(unsigned int reg)
> +{
> +	u64 value;
> +
> +	if (hv_nested)
> +		reg =3D hv_get_nested_reg(reg);
> +
> +	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
> +		hv_ghcb_msr_read(reg, &value);
> +	else
> +		rdmsrl(reg, value);
> +	return value;
> +}
> +
> +void hv_set_register(unsigned int reg, u64 value)
> +{
> +	if (hv_nested)
> +		reg =3D hv_get_nested_reg(reg);
> +
> +	if (hv_is_synic_reg(reg) && hv_isolation_type_snp()) {
> +		hv_ghcb_msr_write(reg, value);
> +
> +		/* Write proxy bit via wrmsl instruction */
> +		if (reg >=3D HV_REGISTER_SINT0 &&
> +		    reg <=3D HV_REGISTER_SINT15)
> +			wrmsrl(reg, value | 1 << 20);
> +	} else {
> +		wrmsrl(reg, value);
> +	}
> +}
> +

With  hv_get_register(), hv_set_register(), and hv_get_nested_reg()
moved here, they need to be under the #if IS_ENABLED(CONFIG_HYPERV).
If CONFIG_HYPERV=3Dn, this module is still compiled, and you end up
with the implementation of hv_get_register() that's here and the no-op
implementation in arch/x86/include/asm/mshyperv.h.   The linker
will rightfully complain.

There's also the issue of hv_ghcb_msr_read() and hv_ghcb_msr_write().
With CONFIG_AMD_MEM_ENCRYPT=3Dy, there needs to be a non-stub
implementation.  But nothing in arch/x86/hyperv is built if
CONFIG_HYPERV=3Dn, so you'll get a linker error because of missing
an implementation of those functions.

Putting the code under #if IS_ENABLED(CONFIG_HYPERV) should
solve both problems.

You should specifically test with CONFIG_HYPERV=3Dn after any changes
to arch/x86/kernel/cpu/mshyperv.c.

Michael

>  #if IS_ENABLED(CONFIG_HYPERV)
>  static void (*vmbus_handler)(void);
>  static void (*hv_stimer0_handler)(void);
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 4d6480d57546..9e1eb50cc76f 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -147,7 +147,7 @@ int hv_synic_alloc(void)
>  		 * Synic message and event pages are allocated by paravisor.
>  		 * Skip these pages allocation here.
>  		 */
> -		if (!hv_isolation_type_snp()) {
> +		if (!hv_isolation_type_snp() && !hv_root_partition) {
>  			hv_cpu->synic_message_page =3D
>  				(void *)get_zeroed_page(GFP_ATOMIC);
>  			if (hv_cpu->synic_message_page =3D=3D NULL) {
> @@ -188,8 +188,16 @@ void hv_synic_free(void)
>  		struct hv_per_cpu_context *hv_cpu
>  			=3D per_cpu_ptr(hv_context.cpu_context, cpu);
>=20
> -		free_page((unsigned long)hv_cpu->synic_event_page);
> -		free_page((unsigned long)hv_cpu->synic_message_page);
> +		if (hv_root_partition) {
> +			if (hv_cpu->synic_event_page !=3D NULL)
> +				memunmap(hv_cpu->synic_event_page);
> +
> +			if (hv_cpu->synic_message_page !=3D NULL)
> +				memunmap(hv_cpu->synic_message_page);
> +		} else {
> +			free_page((unsigned long)hv_cpu->synic_event_page);
> +			free_page((unsigned long)hv_cpu->synic_message_page);
> +		}
>  		free_page((unsigned long)hv_cpu->post_msg_page);
>  	}
>=20
> @@ -216,7 +224,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	simp.as_uint64 =3D hv_get_register(HV_REGISTER_SIMP);
>  	simp.simp_enabled =3D 1;
>=20
> -	if (hv_isolation_type_snp()) {
> +	if (hv_isolation_type_snp() || hv_root_partition) {
>  		hv_cpu->synic_message_page
>  			=3D memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
>  				   HV_HYP_PAGE_SIZE, MEMREMAP_WB);
> @@ -233,7 +241,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	siefp.as_uint64 =3D hv_get_register(HV_REGISTER_SIEFP);
>  	siefp.siefp_enabled =3D 1;
>=20
> -	if (hv_isolation_type_snp()) {
> +	if (hv_isolation_type_snp() || hv_root_partition) {
>  		hv_cpu->synic_event_page =3D
>  			memremap(siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT,
>  				 HV_HYP_PAGE_SIZE, MEMREMAP_WB);
> --
> 2.25.1

