Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAD363FF4A
	for <lists+linux-arch@lfdr.de>; Fri,  2 Dec 2022 05:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiLBEAd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Dec 2022 23:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiLBEAb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Dec 2022 23:00:31 -0500
Received: from CY4PR02CU008-vft-obe.outbound.protection.outlook.com (mail-westcentralusazon11022018.outbound.protection.outlook.com [40.93.200.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CD3CFE7B;
        Thu,  1 Dec 2022 20:00:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2LPaRf+0xlQj5rUJQ1lRnQPupxriX+T9LhL+y5A6uLDjXuKjif9AR53K0DsYMiz8OGzKU8JIN4CWp0ZKRabM8ytLaAmWUPr1QzFF/EcGzGxcyYbAUk9dbFbNXduLqBuvWLgNNRG93tNykpw0J2YzCwdvRJdMv/Y6RNNFySC14Uu5d7018J+tie0CxYTF8vRDak8yGiqqwSBbt2yNeCzCoG5lbQED4HM0nP6VPQDOmgeLvV05KZIikfMLB/xi715fiKD04JWGswAE6P03Jh7CJenQFUIvgM+ry1PY2dyeX/M3RwNsl/2kUdea1xcLuVHVEjeILWEAzkChVISFfxtKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdktdyYHoJi/tzZLa7O5hD2un/Qr5Ushe+rPUVnBvQk=;
 b=oTl9uc7mlOkf4foJOa1xcyp8wk5ozAQaYK0ui/l2s0NxRg+ecEDx88H8MqsLaFIxOPSoaQN96H78RA/eH1gtPKkQw+0iBMu3bJnTHMQD/PP/JU7Dn6MO7WRj6D6CD8VlvMajO4P7aY1CVYDZvT4LiloDcchV3ZpOlHC1tKaWbJSvdDr9sCL4knbN7OKzIvj42sqlfHMLKWt+5uzIgnBnqNCVbH4n3mrFFwuWNvAbJK6Y5orvFGfynzWgv7lc4GJIrKgxmilNVs6lJH2FfsXcFE3J3bNUMVYUP7ArhrwJ6VKWeYGFIkLfhl4MEqn502tkh3PHKidEHd6VME66C8jEtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdktdyYHoJi/tzZLa7O5hD2un/Qr5Ushe+rPUVnBvQk=;
 b=XN4UbHlw3Tbi1/u5Uhs/m0RuEnGK4CXq9VncDTQ/8ZBKiRXZGbuMzttubPzS7PBSU/cXWUrHmVbYm1bAuBRUOJVsVDdsvObRu9tWTrbeQmVpxS3V4X9g8Ou6AKhkEzDuzNAx4WR9J9ZrkWpBbDRGOmi2FvPOUyI1rzA3/m3uNtE=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by IA1PR21MB3737.namprd21.prod.outlook.com (2603:10b6:208:3e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5901.8; Fri, 2 Dec
 2022 04:00:27 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%4]) with mapi id 15.20.5901.008; Fri, 2 Dec 2022
 04:00:27 +0000
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
Subject: RE: [PATCH v7 2/5] Drivers: hv: Setup synic registers in case of
 nested root partition
Thread-Topic: [PATCH v7 2/5] Drivers: hv: Setup synic registers in case of
 nested root partition
Thread-Index: AQHZBXSil2w+xAR5q0O5xVC9h2d3OK5Z8/Eg
Date:   Fri, 2 Dec 2022 04:00:27 +0000
Message-ID: <BYAPR21MB16889FE0F7862850DAEB308ED7179@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <cover.1669788587.git.jinankjain@linux.microsoft.com>
 <dae50574584d821dda19399cb3535089e1465b6a.1669788587.git.jinankjain@linux.microsoft.com>
In-Reply-To: <dae50574584d821dda19399cb3535089e1465b6a.1669788587.git.jinankjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8c1e7e3e-166f-4b2a-9a0b-e26afa0a9da2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-02T03:37:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|IA1PR21MB3737:EE_
x-ms-office365-filtering-correlation-id: db3deae7-4161-4391-4a96-08dad419bf17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aZ3c5C6RH0jyeXyrg3RZf8zGL4AWcBWw0WO16JsaM1VcCIUxHOLeUEph1jfDUYbMlA/1tS56J3C+sUlKroe//1TsECUBtoMlsTssuBLszxMFlR+BILZtlQGBVe1nbXR4NOCuuQxAMaEsPOFD4Q1dVB/++D6op3fLf3cjFB6LlT4luu1saWoEiG1DTMV61VgbxLyGMAvA/gdWu07nDMDTDjutdZJEb2tMNXZkJA8tUdYkDQiY2Uo86zxi879jcorIuXEkGZufLwivCzrRa9suAXpiLXQswHQccYrgNi66RGjao9YHWvwFCL7yzOxJFcJQJylNBiqPGbFzg2plXdZHhDvacP2VANVGhCIeUr+AGILe4hjpZj2c5Ps3lk/40j2MKDmAOhac6wGg4edmcAfUnqulKv/DBGasGG4KBeARXt3giL/Gf53sA5DWTueaaIT5tlEfMKBZvjGS7j6GH8S39g/2WJVbpdpqKLbiz3xnSFIgxJrw11JEc4Rl6dePVH3k3mvuS4XwOVm4uCTtuRqrZB5yTDbk41X7h4hwBrI1Is33Ksk2AGFCn7uQtTUcUjvRezovuSiuA2lwuS2LNXMVVAnSV5hK/JneJqyEcD7WK85ZKcETc3+UBQV5rLJnJLX5VQk7ExIvQmXurkPxUJMWQX7qqaizNG3oxU5PYx/HA7tNfIlAa53sP1ceEIqAw69KP12aW1x18DP9iqTOUmWVATFrWpKNaty9RjQzcfjUl9CkNpmsuj0znY7DfJbL7Qpx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199015)(55016003)(33656002)(82960400001)(86362001)(54906003)(110136005)(38070700005)(316002)(71200400001)(478600001)(64756008)(52536014)(10290500003)(8990500004)(30864003)(4326008)(8676002)(76116006)(41300700001)(7416002)(66946007)(66556008)(66476007)(8936002)(66446008)(107886003)(83380400001)(26005)(38100700002)(82950400001)(6506007)(9686003)(5660300002)(2906002)(7696005)(122000001)(186003)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sl0XHcruc6uqHu4qZ7vpF7KzjdFqh4Dy2q3+j+Icl5iD3Jo7Hh6hYyRZGZs3?=
 =?us-ascii?Q?39qUy6ePBQZF9CNd7OdSnSIO8HrQwwBOm3VJmpPwssliR8ExSckMVxueYFay?=
 =?us-ascii?Q?Db5e1fk2s16CiWFq9P2Wmn/UHQEOdBc0N0fV0KHXlv+xYoyArp2FzXdVTbyH?=
 =?us-ascii?Q?E0HQVYDelvXM637Gjk+6ifW/xjx5PEBL8azsl8Bxryc8Ih7doT6yQ+APZu1d?=
 =?us-ascii?Q?R3EQ/5gAC4qCB/rhu1SfTNWDfjE9/ppZ7EYytzfFOGo39sqIJUDFbfd2GSZ7?=
 =?us-ascii?Q?E0j8BHCLCER992FYQce6umpPiNaKXmpoEsmaqE/F2kBvbp7FnTJZ9F1rlq0W?=
 =?us-ascii?Q?ZWQZ9M51NDj7NV/OWlu4zA3Xp1cTH5zG2wPYkxE67uGUJR9aTT/rhQqasOZd?=
 =?us-ascii?Q?/t8E4GDLpcNIRpcVSHwJoWBo1Go/Mw4WVxUdkF5fAD4uRJKYOq9vF20PXI1i?=
 =?us-ascii?Q?94P6yejUZ+6euJ1ItdQXJEqhdiNkcZso8kl1Py2LYcxQmtjc9O1cBv+xcROT?=
 =?us-ascii?Q?UfuA8ZySJYms2JQXezrDEqe1mq96OLbZcrK+l1iP84sbposaGfo/92LDxiaj?=
 =?us-ascii?Q?d2vjaa7jN3GMPWqe8YI4OczNHqyS3fk5VeM1xunx/xPm9le8oKdrDh4smbBX?=
 =?us-ascii?Q?WFd6zt97WmyNwcNEDoBnDv1SrD3YjIHHHTzcBytjt6KH0xMKQ/nJZcbyTUvr?=
 =?us-ascii?Q?e/17mEYQR8WN25cpBp4/DsX0WBVP5p0DCW34utL50X6B7CDZxFpU/v45duSk?=
 =?us-ascii?Q?p9OKK7MLqV+H4NNOAmjfaVnM440SRn97x5O0yRaAEQaiId2ADKfBdLebc/SM?=
 =?us-ascii?Q?8HZXMGyYEg4EkDRtPMybeRk4qBo765W6bSCulkuhE5tsX5cfVBNwCx90gx2N?=
 =?us-ascii?Q?9eGqbOyDla/pOrlVQhM2iqA51a7kRYhDEULwOgEOns1MpsLvKZGR49VRtTfr?=
 =?us-ascii?Q?hFDi9Po5iOp634d8ZgrIQd7xPzkYDK38PJCe1tpOyFg/ohuO6MWNgvUhVoiQ?=
 =?us-ascii?Q?sDNDVaZAb1WF8y6EgKLetEvn0Xf7QhuUOx2+k/m6bkq7uGrUod3HC+OVbAyB?=
 =?us-ascii?Q?5ZKc1k6eeZUszssqLg9wPPyTn4+6O4vBccfCUUIXJrth+wTvmG+zVwdU1rla?=
 =?us-ascii?Q?mOXMdsUtZsHXhaitfYBgK3CF0bL05mo9P3NNm5pgeEerWdQ98FqdKyabmsF5?=
 =?us-ascii?Q?uEWpvcQjmQJIGXzDOmzYwWo3xmqD+Rx5/l+5YM61oFcsYhr4ugNSpKXiHvUP?=
 =?us-ascii?Q?+75Fs+kdrNKmhBxrrZfCgOWO45LOIZAQIp9+cfLG3Mo3Z0/4RQ05aZxQH1va?=
 =?us-ascii?Q?9EUW/oEYaTWGu5d3zJECDczsNy0rty14MVctPCAamL4NyxUX0DYr8kXj5mGg?=
 =?us-ascii?Q?2VzXusLZElht7dp+ibwwcyNAcftmvRvj5Cs6qus+EfPjOUthuAMK77DCXGSS?=
 =?us-ascii?Q?XTUyU1MfBDZZnxnGOo+i6eYIXARdqvaTN4QPnlMYkidIQFprOnN61nN5+37d?=
 =?us-ascii?Q?IMMwSDlF+HXZLoGPwNX1hcBP5/qBlIuVwajbNII0kUCCWHPW5ui3fEPaTwFz?=
 =?us-ascii?Q?5iiAThMfFi7BAb75/f0m38vjsu6equg9ubeBQA4/TtRQ6CqUJeu0DPRoVBXD?=
 =?us-ascii?Q?sA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3deae7-4161-4391-4a96-08dad419bf17
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 04:00:27.1123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m4P9djU5WAwj6rSTu9b1RBSZ37WYqMY90x5TWK/bYy0c/OTyZa26Jd1fZtHFY3+/a5FvNTjdLlflGOW4k9IiSCfGOqf1z3gCrJ3fuCQN4pI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3737
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jinank Jain <jinankjain@linux.microsoft.com> Sent: Thursday, December=
 1, 2022 3:04 AM
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
>  arch/x86/include/asm/hyperv-tlfs.h | 11 ++++
>  arch/x86/include/asm/mshyperv.h    | 30 ++-------
>  arch/x86/kernel/cpu/mshyperv.c     | 69 +++++++++++++++++++++
>  drivers/hv/hv.c                    | 99 ++++++++++++++++++++++--------
>  include/asm-generic/mshyperv.h     |  5 +-
>  5 files changed, 165 insertions(+), 49 deletions(-)
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
> index 61f0c206bff0..3197d49c888c 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -198,30 +198,10 @@ static inline bool hv_is_synic_reg(unsigned int reg=
)
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
> +u64 hv_get_nested_register(unsigned int reg);
> +void hv_set_nested_register(unsigned int reg, u64 value);
>=20
>  #else /* CONFIG_HYPERV */
>  static inline void hyperv_init(void) {}
> @@ -241,6 +221,8 @@ static inline int hyperv_flush_guest_mapping_range(u6=
4 as,
>  }
>  static inline void hv_set_register(unsigned int reg, u64 value) { }
>  static inline u64 hv_get_register(unsigned int reg) { return 0; }
> +static inline void hv_set_nested_register(unsigned int reg, u64 value) {=
 }
> +static inline u64 hv_get_nested_register(unsigned int reg) { return 0; }
>  static inline int hv_set_mem_host_visibility(unsigned long addr, int num=
pages,
>  					     bool visible)
>  {
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index f9b78d4829e3..f2f6e10301a8 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -41,7 +41,76 @@ bool hv_root_partition;
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

Just a question:  You added #defines for 6 nested registers.  But
the switch statement above maps only 5 registers.  Is it intentional
that there's not a mapping for HV_REGISTER_SVERSION?

> +}
> +
>  #if IS_ENABLED(CONFIG_HYPERV)
> +static u64 _hv_get_register(unsigned int reg, bool nested)
> +{
> +	u64 value;
> +
> +	if (nested)
> +		reg =3D hv_get_nested_reg(reg);
> +
> +	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
> +		hv_ghcb_msr_read(reg, &value);
> +	else
> +		rdmsrl(reg, value);
> +	return value;
> +}
> +
> +static void _hv_set_register(unsigned int reg, u64 value, bool nested)
> +{
> +	if (nested)
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
> +u64 hv_get_register(unsigned int reg)
> +{
> +	return _hv_get_register(reg, false);
> +}
> +
> +void hv_set_register(unsigned int reg, u64 value)
> +{
> +	_hv_set_register(reg, value, false);
> +}
> +
> +u64 hv_get_nested_register(unsigned int reg)
> +{
> +	return _hv_get_register(reg, true);
> +}
> +
> +void hv_set_nested_register(unsigned int reg, u64 value)
> +{
> +	_hv_set_register(reg, value, true);
> +}
> +
>  static void (*vmbus_handler)(void);
>  static void (*hv_stimer0_handler)(void);
>  static void (*hv_kexec_handler)(void);
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 4d6480d57546..0ed052f2423e 100644
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
> @@ -213,10 +221,12 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	union hv_synic_scontrol sctrl;
>=20
>  	/* Setup the Synic's message page */
> -	simp.as_uint64 =3D hv_get_register(HV_REGISTER_SIMP);
> +	simp.as_uint64 =3D hv_nested ? hv_get_nested_register(HV_REGISTER_SIMP)=
 :
> +				     hv_get_register(HV_REGISTER_SIMP);

Unfortunately, this code and the similar places below will run into
problems on ARM64.  Drivers/hv/hv.c is common code on all architectures
so it needs to compile and run on ARM64 as well as x86/x64.  But there's
no hv_get_nested_register() defined or implemented on the ARM64 side,
so the code will fail to compile.

I think there's a better way to do this.   Based on Nuno's comments, it
seems like there are two hv_get_register() functions needed:

1)  Get the value of the register or its nested cousin, based on the value
of hv_nested.  That's what you are explicitly coding here.
2) Get the value of the register.  Don't access the nested cousin, regardle=
ss
of the value of hv_nested.

Based on how you coded things earlier, I'm assuming #1 is what you want to
use in most cases, and specifically here in drivers/hv/hv.c.  That's good,
because #1 can hide the testing of hv_nested in the x86-specific
implementation of hv_get_register(), while the ARM64 version of
hv_get_register() continues to do whatever it does now with no changes.

I'm also assuming that #2 may be used in particular cases in the code
that is specifically related to nesting.  Give the #2 version a different
name --- maybe hv_get_nonnested_register(), or something like that --=20
and use it only in code under arch/x86 that is related to nesting.  That
way, ARM64 won't be affected.

Of course, the same approach applies to hv_set_register().

hv_get_register() and hv_get_nonnested_register() will obviously
share some code.  But rather than calling a common function starting
with underscore like you've done above, let me suggest that
hv_get_register() test hv_nested and potentially do the translation,
then call hv_get_nonnested_register().  That way you'll end up
with just two functions instead of three as above with
hv_get_register(), hv_get_nested_register(), and _hv_get_register().

I haven't coded up any of this, so take it as a suggestion.  There
could be some problem with it that I haven't seen, or my assumptions
might be wrong.  But give it a try and see if it works out.  I'm hoping
it can all be handled on the x86 side without having to add complexity
on the ARM64 side.

Michael

> +
>  	simp.simp_enabled =3D 1;
>=20
> -	if (hv_isolation_type_snp()) {
> +	if (hv_isolation_type_snp() || hv_root_partition) {
>  		hv_cpu->synic_message_page
>  			=3D memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
>  				   HV_HYP_PAGE_SIZE, MEMREMAP_WB);
> @@ -227,13 +237,18 @@ void hv_synic_enable_regs(unsigned int cpu)
>  			>> HV_HYP_PAGE_SHIFT;
>  	}
>=20
> -	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
> +	if (hv_nested)
> +		hv_set_nested_register(HV_REGISTER_SIMP, simp.as_uint64);
> +	else
> +		hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
>=20
>  	/* Setup the Synic's event page */
> -	siefp.as_uint64 =3D hv_get_register(HV_REGISTER_SIEFP);
> +	siefp.as_uint64 =3D hv_nested ?
> +				  hv_get_nested_register(HV_REGISTER_SIEFP) :
> +				  hv_get_register(HV_REGISTER_SIEFP);
>  	siefp.siefp_enabled =3D 1;
>=20
> -	if (hv_isolation_type_snp()) {
> +	if (hv_isolation_type_snp() || hv_root_partition) {
>  		hv_cpu->synic_event_page =3D
>  			memremap(siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT,
>  				 HV_HYP_PAGE_SIZE, MEMREMAP_WB);
> @@ -245,13 +260,19 @@ void hv_synic_enable_regs(unsigned int cpu)
>  			>> HV_HYP_PAGE_SHIFT;
>  	}
>=20
> -	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
> +	if (hv_nested)
> +		hv_set_nested_register(HV_REGISTER_SIEFP, siefp.as_uint64);
> +	else
> +		hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
>=20
>  	/* Setup the shared SINT. */
>  	if (vmbus_irq !=3D -1)
>  		enable_percpu_irq(vmbus_irq, 0);
> -	shared_sint.as_uint64 =3D hv_get_register(HV_REGISTER_SINT0 +
> -					VMBUS_MESSAGE_SINT);
> +	shared_sint.as_uint64 =3D
> +		hv_nested ?
> +			hv_get_nested_register(HV_REGISTER_SINT0 +
> +					       VMBUS_MESSAGE_SINT) :
> +			hv_get_register(HV_REGISTER_SINT0 +
> VMBUS_MESSAGE_SINT);
>=20
>  	shared_sint.vector =3D vmbus_interrupt;
>  	shared_sint.masked =3D false;
> @@ -266,14 +287,22 @@ void hv_synic_enable_regs(unsigned int cpu)
>  #else
>  	shared_sint.auto_eoi =3D 0;
>  #endif
> -	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
> +	if (hv_nested)
> +		hv_set_nested_register(HV_REGISTER_SINT0 +
> VMBUS_MESSAGE_SINT,
> +				       shared_sint.as_uint64);
> +	else
> +		hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
>  				shared_sint.as_uint64);
> -
>  	/* Enable the global synic bit */
> -	sctrl.as_uint64 =3D hv_get_register(HV_REGISTER_SCONTROL);
> +	sctrl.as_uint64 =3D hv_nested ?
> +				  hv_get_nested_register(HV_REGISTER_SCONTROL) :
> +				  hv_get_register(HV_REGISTER_SCONTROL);
>  	sctrl.enable =3D 1;
>=20
> -	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
> +	if (hv_nested)
> +		hv_set_nested_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
> +	else
> +		hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
>  }
>=20
>  int hv_synic_init(unsigned int cpu)
> @@ -297,17 +326,25 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	union hv_synic_siefp siefp;
>  	union hv_synic_scontrol sctrl;
>=20
> -	shared_sint.as_uint64 =3D hv_get_register(HV_REGISTER_SINT0 +
> -					VMBUS_MESSAGE_SINT);
> +	shared_sint.as_uint64 =3D
> +		hv_nested ?
> +			hv_get_nested_register(HV_REGISTER_SINT0 +
> +					       VMBUS_MESSAGE_SINT) :
> +			hv_get_register(HV_REGISTER_SINT0 +
> VMBUS_MESSAGE_SINT);
>=20
>  	shared_sint.masked =3D 1;
>=20
>  	/* Need to correctly cleanup in the case of SMP!!! */
>  	/* Disable the interrupt */
> -	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
> +	if (hv_nested)
> +		hv_set_nested_register(HV_REGISTER_SINT0 +
> VMBUS_MESSAGE_SINT,
> +				       shared_sint.as_uint64);
> +	else
> +		hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
>  				shared_sint.as_uint64);
>=20
> -	simp.as_uint64 =3D hv_get_register(HV_REGISTER_SIMP);
> +	simp.as_uint64 =3D hv_nested ? hv_get_nested_register(HV_REGISTER_SIMP)=
 :
> +				     hv_get_register(HV_REGISTER_SIMP);
>  	/*
>  	 * In Isolation VM, sim and sief pages are allocated by
>  	 * paravisor. These pages also will be used by kdump
> @@ -320,9 +357,14 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	else
>  		simp.base_simp_gpa =3D 0;
>=20
> -	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
> +	if (hv_nested)
> +		hv_set_nested_register(HV_REGISTER_SIMP, simp.as_uint64);
> +	else
> +		hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
>=20
> -	siefp.as_uint64 =3D hv_get_register(HV_REGISTER_SIEFP);
> +	siefp.as_uint64 =3D hv_nested ?
> +				  hv_get_nested_register(HV_REGISTER_SIEFP) :
> +				  hv_get_register(HV_REGISTER_SIEFP);
>  	siefp.siefp_enabled =3D 0;
>=20
>  	if (hv_isolation_type_snp())
> @@ -330,12 +372,21 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	else
>  		siefp.base_siefp_gpa =3D 0;
>=20
> -	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
> +	if (hv_nested)
> +		hv_set_nested_register(HV_REGISTER_SIEFP, siefp.as_uint64);
> +	else
> +		hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
>=20
>  	/* Disable the global synic bit */
> -	sctrl.as_uint64 =3D hv_get_register(HV_REGISTER_SCONTROL);
> +	sctrl.as_uint64 =3D hv_nested ?
> +				  hv_get_nested_register(HV_REGISTER_SCONTROL) :
> +				  hv_get_register(HV_REGISTER_SCONTROL);
>  	sctrl.enable =3D 0;
> -	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
> +
> +	if (hv_nested)
> +		hv_set_nested_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
> +	else
> +		hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
>=20
>  	if (vmbus_irq !=3D -1)
>  		disable_percpu_irq(vmbus_irq);
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index f131027830c3..db0b5be1e087 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -147,7 +147,10 @@ static inline void vmbus_signal_eom(struct hv_messag=
e *msg,
> u32 old_msg_type)
>  		 * possibly deliver another msg from the
>  		 * hypervisor
>  		 */
> -		hv_set_register(HV_REGISTER_EOM, 0);
> +		if (hv_nested)
> +			hv_set_nested_register(HV_REGISTER_EOM, 0);
> +		else
> +			hv_set_register(HV_REGISTER_EOM, 0);
>  	}
>  }
>=20
> --
> 2.25.1

