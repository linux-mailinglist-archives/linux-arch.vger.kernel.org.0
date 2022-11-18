Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBB662F958
	for <lists+linux-arch@lfdr.de>; Fri, 18 Nov 2022 16:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbiKRPem (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 10:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbiKRPel (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 10:34:41 -0500
Received: from DM6PR05CU003-vft-obe.outbound.protection.outlook.com (mail-centralusazon11023015.outbound.protection.outlook.com [52.101.64.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF54F5A8;
        Fri, 18 Nov 2022 07:34:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5Ti+y7PNAQAOcbtU4HzeGwyLz3hzYErr6X1ySd2Fdb9aSBhAe2F0otWXDMMQb5yel4Yz5OEr7/CKDWw+N3tciF5kUAJn90Nn3Ip+QbfgxXWbP/f0+db9UdmPWB/QuFHCJDkO+VQ2lXhukx2WfH4xYUpdYAlnWOkxqBsGc5diMF1lTfyGgwnwocqR34GoeWBT7eN1jaugUI6ERRwlN1haUtAbArlQWS6pW8EcLmCm82ssWAdgL5ow4srbI/eGfCCvx1km0qRfrlTfu1SgzaVFcbAsrXB6jVXitH7P/+jKIDh+KwCrpVZJGUXjomn4GcMaHAVdTbDhJ9BlbRK3iOK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xp1YUJoLdjKLeu0fbsNY8F6EPDmg0u2tiTqlfm+WDI4=;
 b=LpYGDzXMFQRSMgk7/f8Qt1BAMjq96IydJn2RgdH9d+V0UUyfVAlEyEA8zaSKclLhPRU9NOfyUtF4ivTPO/mebKVHMQkPFuEZboNvWgP43UsxpYdutU/mZt4Q+nDlbo4iT7RL/wLAHPLv7aV8atOyufLItfUq4jDim0UqKTCJKJGhhPPcDMi4gQJjdNrROtY/aDjYmiSBYn3EqEiU8o4HAZtYXZx0jhjf2lDDBYGjI8SyjXivN5FHAuJ1XFGqG9P+NZoE7++uB6UMqKRxn591wVUmWyGhs19bvsuWdEVZyGg/d253EmhEN3xVLYKlBwzTERL05fKN7bvUGlD5RUOl3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xp1YUJoLdjKLeu0fbsNY8F6EPDmg0u2tiTqlfm+WDI4=;
 b=DP45qkRU8pU6fbxuVbKKijUyyweox/5/9kPDtk4MOXOTiW2RzkKQYZFpA0VuIsq2Yr2EnCqzftkR9gtMlYECcst/mydqNJwe81b/WxfbHKHmhlD3jY134dr2HeH/CcTOg0wSG/22N3ConlAxEqj4AH9SVoYF3hFwFd9ygHwUCFg=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BL1PR21MB3331.namprd21.prod.outlook.com (2603:10b6:208:39c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.8; Fri, 18 Nov
 2022 15:34:35 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%4]) with mapi id 15.20.5857.008; Fri, 18 Nov 2022
 15:34:33 +0000
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
Subject: RE: [PATCH v4 2/5] Drivers: hv: Setup synic registers in case of
 nested root partition
Thread-Topic: [PATCH v4 2/5] Drivers: hv: Setup synic registers in case of
 nested root partition
Thread-Index: AQHY+jShZZpJ1Yue3EG2WBJxHC1xl65Ez0mg
Date:   Fri, 18 Nov 2022 15:34:33 +0000
Message-ID: <BYAPR21MB1688F753417081A8186C177FD7099@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <cover.1668618583.git.jinankjain@linux.microsoft.com>
 <11dda2c697781c5d12bbffd11052e6d6bb2ca705.1668618583.git.jinankjain@linux.microsoft.com>
In-Reply-To: <11dda2c697781c5d12bbffd11052e6d6bb2ca705.1668618583.git.jinankjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=58172e4b-5867-42d4-be85-9a189bb8a208;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-18T15:24:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BL1PR21MB3331:EE_
x-ms-office365-filtering-correlation-id: 648c4a22-88cb-4e41-fecf-08dac97a64b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lXKeOjsO1I0STKmPIrNqRT1bELkCH9eToAiSwHj3SpXFSaPgPV+rgAeFVPrIZhZuHwWjAP7NSBFDt8Gpd6f8InjSsLMs9V1dWYPTVHxZ05HUhw6/U9/iYiE4QBBy1mfnTKtz4eIv2Hxc1c7gxPI9PFkoIxk5Qpf+T1DQGlksbmxWkm+/Bi3DpwUawzdvv/DVn/paFAu0ddPb0qz3UR3hOQHid71iDGaL1ZeCDT40yGmsT0aUxtNh/OdQavFaRjVOe9uN5bWo4zgHIcM7bX8FmMgBhr9zQfU5hSLXgfZ9TFK0+aksBnrSWGvw+n2ivqnrXh+/LYw87LPZBfIA0harwXc/5clYd/LtmSPlVm3gVysdaRckQ6Io2U/m1SkPliNjr5YN+VI+MTupzZXQSttbyd06/HHQwS4OwhUfNuuFqCWsUYhuX/LxKMB3LigyHIz58XLKws5tTZstPe3BB5XZd76rjlqE1n+q95ifKJWNYNSlzcr59tUSY5XU1HykvPH8N6IAvHAZwvOU83j/2ttW/tpOgvSwIJaR+mSnqX17ffRpMimcu2mdSeOXvtDvE8Mv6NRJ+kr80NnuEB7i+9uhLapqOcdAE/teUDJaQxdU27H2+K+RdUtSi3xOxhXl+ab40VwPPFrUG0fEqUKBPz2Bc9vesU5ux0AfNSSSkTXpatuMycpHf/iCSf1/u4vBH1r9vurYOlv+IbihiFx/bN4noGRpg05C07MEB3tQmVRSA6LTocffz5KgyvIPjOH68eUF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(5660300002)(316002)(7416002)(122000001)(71200400001)(478600001)(8676002)(86362001)(64756008)(66946007)(76116006)(66556008)(66446008)(66476007)(4326008)(8990500004)(26005)(107886003)(41300700001)(55016003)(82960400001)(8936002)(82950400001)(38100700002)(110136005)(6636002)(38070700005)(54906003)(52536014)(10290500003)(33656002)(2906002)(186003)(7696005)(6506007)(9686003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?38cpJUMUBKzuE/eRiTSJ7tZU/6nkv1EDfj9aF/1cXddFB1Vv1WuQb3fjjpJC?=
 =?us-ascii?Q?tPk5yuEMKrjz0jurDRg7/z7/RWQADL7uhwji4t03ygE2TValuV1Q4fbuZOo2?=
 =?us-ascii?Q?KmCJxLluARRcQcZ51+qCBJgBIM09zYEuPVGkMTBhwwqAI1m59F46q5v3CzuH?=
 =?us-ascii?Q?DVM1rkPGfgTXn4uzppZaueGBojpwsIaKPwxsoeTj+omFwWSpkqBZLEtkaQhz?=
 =?us-ascii?Q?Fmdimokrkgz+9ljkVWv4fQN1bfqsdzu5q4zBuvPUwePw5HB/y+o+FXbxHTDD?=
 =?us-ascii?Q?VUFGL0kTiWac6rUPAxg62cmS/A/ebv7xsgEsOdlDcW+MW3KOZkoJjFmYZYAb?=
 =?us-ascii?Q?U1d5Ihf/94ktirIgCCViyiaIiovAvyVX3HjjY0gm1Q9f/FRzrDrFW/2MOc2C?=
 =?us-ascii?Q?ousMPoKLW4QK67mswZb/4HYPBoNUbY/bEzn281NrbuSbikxMR8YNwJ971yPo?=
 =?us-ascii?Q?Ika6ufkDBRlSGU/+6/O0obYvSun0EwCNXgLNpBo0jjjALtFBm2KxMLOOrbGI?=
 =?us-ascii?Q?IcdylKA3bvF8cPDPgapohCc7MqmEtVe/qntRpg5cteNhPCmLnu/+frI8r7ee?=
 =?us-ascii?Q?PEJUBVLv1SmkuX/zL/LRHwqTBHbnHSj793IHvWcqfrCePhFb1j8RHt6sVRjK?=
 =?us-ascii?Q?Cn3DLOmFow1HpqWdLejjnGz5U8I84BAbiop4jQ/e9UlTkW9jeLKnOLgqXUXr?=
 =?us-ascii?Q?RyZBa9tXgyRW2AvMHMsJlZuqDM2wNMwGKYVIsEpCg/+bA0xMO8KltLX/0QwN?=
 =?us-ascii?Q?XAkvWQO45BnnYwTjxcG0zyZG59ByR1xZq9/a6nRYLdtmqLCIGS64Fvvga5wm?=
 =?us-ascii?Q?IahLe6zuHbLHunMQYWgllLX/qIZQAuA7Yz8HHbnRimwBKh7gfLTwXKjuC6kB?=
 =?us-ascii?Q?1MeiN55xdlm6HQ9i0kvrl5jJpXj/QU1ENTIJe4Csm4qNfeyMJOK0/dwoHjE4?=
 =?us-ascii?Q?O1R7204wEWTAuDd9AexmMFjPmDklXZ24unIR7wUTvw7oc5Mnv6ACi/M9jlIR?=
 =?us-ascii?Q?SR04NNZjxdDYytUxYSMLOhh3RxitmrPu15/SwATZ9e3D9GltLNWq6/VaWTDs?=
 =?us-ascii?Q?uD9o4HVbsAHiMas+qTsTWvzmv6WRd4DhO28glHlXopvTaEOrnjRfzTmRvG0Q?=
 =?us-ascii?Q?hHTK3gBZaWgHyYoFPngYiXEbu733mgSxA3Itqxt7zdDbkA0bihEnFgFmQ8td?=
 =?us-ascii?Q?+m9SqDRZ9/0TsSt90hF6Rud5dEGuby79uzx/HDjZTdYbqEibs5fGVKn3o4JV?=
 =?us-ascii?Q?YEchE+9sxpwVPYYuUG0QvXEDrQ1Z+akWMLFKPi/F/sfniRCbgyF6bJ+VXU/R?=
 =?us-ascii?Q?xdKiXG3jvMNwho7qiKBPqxLdP0yflF1AvornWysHa5oqKICqIFJsU0IRhnFl?=
 =?us-ascii?Q?sZVumCgZvtdVIJpfZ2DTc3prvGuvKd21MH7hhVbm1rAdi5ykNDm7n22e5RCl?=
 =?us-ascii?Q?A7YTxwbnFm1lhvnP4Jq0clBZqGbIa7bWVstJr55zOkZDoAeBqelEhRk2eMf7?=
 =?us-ascii?Q?aQeGuD7H0yhsgzTCS2CS5g2g+SfDvDcJSgky5p2VAmmxk/Z7hnR0yP+sW6Fz?=
 =?us-ascii?Q?VhXlioAtqC8IOJWGwa4UeS+ZISoEONCj927u4KsdbuzFuXj2WC0Q7EfBUdd7?=
 =?us-ascii?Q?VA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648c4a22-88cb-4e41-fecf-08dac97a64b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 15:34:33.8719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hUX6ZMu1vYFbWU20VGP08yz+qi+kLqZdu0NuEzX7w1nfUA/naSgKR+xf+Ti228wLEFUc1XHKD/MPx1h0sUJjXneSUW4yEZBP0jT8Ondt50o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3331
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
> index 9a4204139490..3e6711a6af6b 100644
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
> +inline u64 hv_get_register(unsigned int reg)

I don't think "inline" here does anything.  There aren't any invocations
of hv_get_register() in this module.  Previously, when the code was in
an include file, then "inline" would do something.

But I'm not an expert in compilers/linkers, so maybe I'm wrong. :-)

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
> +inline void hv_set_register(unsigned int reg, u64 value)

Same here.

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

