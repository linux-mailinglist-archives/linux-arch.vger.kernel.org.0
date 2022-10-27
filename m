Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0102C60F974
	for <lists+linux-arch@lfdr.de>; Thu, 27 Oct 2022 15:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbiJ0Nmk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Oct 2022 09:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbiJ0Nmg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Oct 2022 09:42:36 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11023016.outbound.protection.outlook.com [52.101.64.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAAC1826F5;
        Thu, 27 Oct 2022 06:42:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+eNH+/Qs6l+jN+Gcn+LKjWw6M7Pul13GyCS/675RTTzNCJUyjst2MYIw64D3BYtJAlgVlUOm5RPqgeDJMOvM93TjJaTAqZroJw9U81MXVGHiXaqE11+aV26sCCtniSs8tpH/M93ZULbCYgqZaUR+R/GEmjkrm0XNPm+Tr8K6CXEFYRUYtuULtUpJ4PUX/r7yo+5/Lj03NL4ZTkmhj1EKxaA+ThdxI4MqJevgcLxIGp0xHM3w5FLVRuZ0IFQiILv4SMuABsxtgwhg1ZhSTCbjyKI+3IMyFXdMNiRpRx2Rfa52oklF4Ip/iNRUKV7K7gbnCdBsl2FxyiqZZVFYI0acA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYbqfum4UACg6Lc7Q63KXGKfDeoo+l1HqyfMeesO9L0=;
 b=mQLvFl++XNfxxaudNLJQV2oZKtFqXShPlGIoGM1ACYTlyTs+QU67YIfQpzxJmmpP2W42VnzyY4Jnkaa05Si3r2Y/njW3Y2gb/FEYaJWASXeKnNLK75wH4OeUa9Dw+XwLdsY2FL77ux/DI0l1HjfIYRBJxC9uWiUC2eeXzewLboe/D84aW55Ioq3ohDCc1UvFw+NT1TDBQT0YZDIjFCZCSg7CIHJYN1nymdF2OugnQahz+QuPqBAoX5ttjkoSVezAUiQaRptJXHjOgPsg3BZASKtqvEijy254lvyygSyTBRBAxcRicsk9q+hEOWA5sOsOVJKje+bOi8bMShTSPX76sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYbqfum4UACg6Lc7Q63KXGKfDeoo+l1HqyfMeesO9L0=;
 b=DUM3hQz/Gf2gSikqCPu4zVy0dPdtS3tY2YKUYJOiT3QwCggvUgVM+gbMwkqtQ1W3vUDm4JKPi+OedxrUfivaw0N0sRlxIP4fHxgT75LoU2Emdy/cxnFxdkMQs3/nmLiIXaXInBfGyh3yyH0GT/zf4ZN67HkspPe7YvdSizKwJCU=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SA1PR21MB3809.namprd21.prod.outlook.com (2603:10b6:806:2b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.9; Thu, 27 Oct
 2022 13:42:31 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5791.008; Thu, 27 Oct 2022
 13:42:31 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     "stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
        "kumarpraveen@linux.microsoft.com" <kumarpraveen@linux.microsoft.com>,
        "mail@anirudhrb.com" <mail@anirudhrb.com>
Subject: RE: [PATCH v2 1/2] clocksource/drivers/hyperv: add data structure for
 reference TSC MSR
Thread-Topic: [PATCH v2 1/2] clocksource/drivers/hyperv: add data structure
 for reference TSC MSR
Thread-Index: AQHY6erhWJkiLKLdokahKR7tbQL5tK4iP8/Q
Date:   Thu, 27 Oct 2022 13:42:31 +0000
Message-ID: <BYAPR21MB1688E0040710DF040BB7FCCDD7339@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221027095729.1676394-1-anrayabh@linux.microsoft.com>
 <20221027095729.1676394-2-anrayabh@linux.microsoft.com>
In-Reply-To: <20221027095729.1676394-2-anrayabh@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7807c19b-bbc9-4867-b28c-415332ac85e7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-27T13:41:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SA1PR21MB3809:EE_
x-ms-office365-filtering-correlation-id: e2ea3bad-dbc6-4ade-59c6-08dab82118a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O+G5okJZ/cHLkheH2A9Qa3wytqiZVLigBgyBjcoJccM2XznmO4ScbPk/h0woYonVzDyjE5NYMN6+XBOfctXPaaq/2PQjbPa8WXBYMkWwmE8rE2sWO3LuoStT4FgfXsm9u/Pfeh/7FKxg7+Aj8+4dybFR7AptjqGUd6Y+OC6tne2NUCQeZlYnlE3na1F61bMXRSwCC4cc4Y7Kb/jvzhZyd4O4XoLU/zthaW1zSpypgWDmbp5IDTj5XZkY2+DU6XxCJ9JsQZkLdTj+mqDR6OTxoKsFD5sg+vg9t51uCVxxUxRYMRwH95Lkeu3A3CjtdX4v7SCzoPVguErZeWoP/afxcIT2C3LqKDu/s4SZA4Lfn2oCod1R8Ii/5PSGNzFfdba64P8uL+Y2aM1m8J3Jmu06AQBTP9vAzEU9kW3pBjEGKvR1T3uaWKqoY4/JBSX2p3nZYiRRXcIpjTOTJ/JWgEEdBNmipPQ09B1KSTXDBfC+XCmal9LvEOnIYIwXqNePZUZS8bs17fnlpIMKwaXTbrhaobZDAYZPx/uY55JEj4DMJMiET1qrBLAi8w+SRPYxijiwubYVGHDEvT0FEUCOqwOqBqG023UDp0dRgGFCAnlIcotS/8ITAohcL1yUcg7aRm0uqfwsLFxVrGVs55OeK6IWQE+GSCpOoBHGnKE4If1VfYs29EsaX27Y0EY5qBCLIxC5xf6Ngst6dmRUBuJfTdDNiIPooVdUnpiMAkOrsIpuxQVPqXS8E6khgBCpeSXVbacgWRrNs0yImm45+b0GgNcqcOkKeMyhUs54RrAyrpCpbtIaKsoHAfp24iRd7/iep9YZRwAA1/Ge0As4Yf4mw7sZIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199015)(33656002)(2906002)(8990500004)(64756008)(66446008)(66476007)(66556008)(38070700005)(921005)(38100700002)(122000001)(7416002)(5660300002)(110136005)(52536014)(41300700001)(54906003)(8936002)(316002)(71200400001)(66946007)(55016003)(10290500003)(4326008)(8676002)(76116006)(83380400001)(9686003)(26005)(478600001)(6506007)(82950400001)(82960400001)(7696005)(186003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZtjPG5ipPEvLYQAcPhh8Xr6E5RoIW6UrLMusGGnt1BUEP+txSzVFlc13nkG8?=
 =?us-ascii?Q?NCgyDAS3W1WZAQN1SDxTafdKLVd13af3hStfhLHvwZ/o0YBXEF978dXsIL1D?=
 =?us-ascii?Q?1MtEbXfhK0pBHrbu20x9uakP0uF5XLQhHoc8W82Y7ol4i8eTsqKmCIyjgd4A?=
 =?us-ascii?Q?ZXQjii7Slen9NS8e+0MEc1rHK5SBMB6srJ9IA2wL2nTAkwUMLs2OPTosNrB2?=
 =?us-ascii?Q?lTPOzOaDNVrFFmS3NUe4kTVhst87dOXnPGSFZ2an9csLvpfuKebXEFF+2CFd?=
 =?us-ascii?Q?atTzkq4u+KirhFfYV5GhCD58ByhjHPV4SzYNSd7n57Gc5+wWAAWFEiGfkKgO?=
 =?us-ascii?Q?YCnjoAKMeSPJMU5Ilh2BoMknc5nUYk5iHnHDo0nxKdcyf4ZoC5AB2qZVTZgA?=
 =?us-ascii?Q?4IC4U2tGUbzhq0lPlBsQrdz0rFFUzp2OKSjOkbY8HZvz7c9sTPSNMQH2qS7Q?=
 =?us-ascii?Q?Sp2JgGabxF6KJXi5raLsy2bFUE6VpEPVlMVfN9i3cufEsVUgAcILK7W/UpsL?=
 =?us-ascii?Q?K1lPoqrmnA2/WHJ0bHzEbmO4qXZm0fNpAS4Idh/fk+2Yxtx6gA57o0Q+SUGb?=
 =?us-ascii?Q?4BEEtaimANKUCZmngDcO2MQWbdK+wJm41YTXbJDR8Sr+wcGLcNXd7HPN3yKg?=
 =?us-ascii?Q?B2NIK1L2+RNl4bBaWv1k2q36FIA9dGD3wpfhrSyiykAQUuSIWcS0cr9wgk6C?=
 =?us-ascii?Q?kZrAZh4F2w5qI0ncm39HZhQXVbSmbaEYnFVmsLU1Rj7MVgQYOfc66t/TjSMh?=
 =?us-ascii?Q?TMvuPnMe/yj5OigDKRIvNMRR6PtdXtbZN3qiR48wVzt6/gEFUL1wQK1apeOt?=
 =?us-ascii?Q?J6QLpKfqmt/sflRyeOUYyWHNUUOV9NGhOyyZxlrS+aKbMbJEceqnZRts/uWX?=
 =?us-ascii?Q?wYrVOwfIHfx/Ma7XvDdUls22PhmdtN7yMJCWQAVek26VhJeXwUob7qh8c1d8?=
 =?us-ascii?Q?dbojj97cGu++1t7duKcG3K5/wlw8znsPPGQoqY6HEqc3fUn4rcsrlPCv0zF0?=
 =?us-ascii?Q?WuHyS/bsKO+PLIelT67iS6SX7KQI2Zq2owLlS0ZG/6Z0KjyjkT6Zl421mpdZ?=
 =?us-ascii?Q?1u9xQMHKuMH9yUyYWdW/ARJSadijtXCos/onb2tlUKYDnLtvb1dOZNU6YOWB?=
 =?us-ascii?Q?AOca5FUU9uGCf22XODBKl1tyqbOdXSk4bIrLWqEEPBnMprqu4v12KyQaZvHb?=
 =?us-ascii?Q?QaEi6QpUW0eQ28YKP3agyYOYNgrc/ICvtSR6W13M3j2LbUzkT1GEcODDEt26?=
 =?us-ascii?Q?IC6ZORJKXsgeRKrM02ZE/uabP4KI/ZEZiStEPfbaUgZkv317+R7MthtqGodr?=
 =?us-ascii?Q?nD/SlwH5oQcq/bAGVYExPvh6S7xygpPetoXbf5BJ2F7hITwOvYpN6qNjR0ql?=
 =?us-ascii?Q?+qyMk2oZemzx8/p4FyAteN4t9zQnp/kPTUZucZu+u9I5AiPyjGLfbOmhrJQ8?=
 =?us-ascii?Q?zN0KU2C2YQwmnzPWckEadh60XsB7D8/XEGlk/jkOg+yGPgvWu9KFjNV4s9FI?=
 =?us-ascii?Q?wCUbyALygMD/bB4lbcrZ8jvx/WpHXh/Al2xsY7SMlqjRjwTxh49YTVtbSUjc?=
 =?us-ascii?Q?+LG/aQX9tHEx6Xv2OAJbqatv/mVibnj0HKVZJeWRSXgzP8K82mTML4LinsRC?=
 =?us-ascii?Q?7w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ea3bad-dbc6-4ade-59c6-08dab82118a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 13:42:31.2798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j9Ce+eTBa2lln1LjjjZQxuVTBQcjvstlz7Je65MJMRPkRtGC+dBKQsG/R36ISPkIYU3cOOhLlBni7F0NzK27FGuhrci3K6K+z2RUd2bH904=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB3809
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Anirudh Rayabharam <anrayabh@linux.microsoft.com> Sent: Thursday, Oct=
ober 27, 2022 2:57 AM
>=20
> Add a data structure to represent the reference TSC MSR similar to
> other MSRs. This simplifies the code for updating the MSR.
>=20
> Signed-off-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
> ---
>  drivers/clocksource/hyperv_timer.c | 28 ++++++++++++++--------------
>  include/asm-generic/hyperv-tlfs.h  |  9 +++++++++
>  2 files changed, 23 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index bb47610bbd1c..11332c82d1af 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -395,25 +395,25 @@ static u64 notrace read_hv_sched_clock_tsc(void)
>=20
>  static void suspend_hv_clock_tsc(struct clocksource *arg)
>  {
> -	u64 tsc_msr;
> +	union hv_reference_tsc_msr tsc_msr;
>=20
>  	/* Disable the TSC page */
> -	tsc_msr =3D hv_get_register(HV_REGISTER_REFERENCE_TSC);
> -	tsc_msr &=3D ~BIT_ULL(0);
> -	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
> +	tsc_msr.as_uint64 =3D hv_get_register(HV_REGISTER_REFERENCE_TSC);
> +	tsc_msr.enable =3D 0;
> +	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
>  }
>=20
>=20
>  static void resume_hv_clock_tsc(struct clocksource *arg)
>  {
>  	phys_addr_t phys_addr =3D virt_to_phys(&tsc_pg);
> -	u64 tsc_msr;
> +	union hv_reference_tsc_msr tsc_msr;
>=20
>  	/* Re-enable the TSC page */
> -	tsc_msr =3D hv_get_register(HV_REGISTER_REFERENCE_TSC);
> -	tsc_msr &=3D GENMASK_ULL(11, 0);
> -	tsc_msr |=3D BIT_ULL(0) | (u64)phys_addr;
> -	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
> +	tsc_msr.as_uint64 =3D hv_get_register(HV_REGISTER_REFERENCE_TSC);
> +	tsc_msr.enable =3D 1;
> +	tsc_msr.pfn =3D __phys_to_pfn(phys_addr);
> +	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
>  }
>=20
>  #ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
> @@ -495,7 +495,7 @@ static __always_inline void hv_setup_sched_clock(void
> *sched_clock) {}
>=20
>  static bool __init hv_init_tsc_clocksource(void)
>  {
> -	u64		tsc_msr;
> +	union hv_reference_tsc_msr tsc_msr;
>  	phys_addr_t	phys_addr;
>=20
>  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
> @@ -530,10 +530,10 @@ static bool __init hv_init_tsc_clocksource(void)
>  	 * (which already has at least the low 12 bits set to zero since
>  	 * it is page aligned). Also set the "enable" bit, which is bit 0.
>  	 */
> -	tsc_msr =3D hv_get_register(HV_REGISTER_REFERENCE_TSC);
> -	tsc_msr &=3D GENMASK_ULL(11, 0);
> -	tsc_msr =3D tsc_msr | 0x1 | (u64)phys_addr;
> -	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
> +	tsc_msr.as_uint64 =3D hv_get_register(HV_REGISTER_REFERENCE_TSC);
> +	tsc_msr.enable =3D 1;
> +	tsc_msr.pfn =3D __phys_to_pfn(phys_addr);
> +	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
>=20
>  	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
>=20
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index fdce7a4cfc6f..b17c6eeb9afa 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -102,6 +102,15 @@ struct ms_hyperv_tsc_page {
>  	volatile s64 tsc_offset;
>  } __packed;
>=20
> +union hv_reference_tsc_msr {
> +	u64 as_uint64;
> +	struct {
> +		u64 enable:1;
> +		u64 reserved:11;
> +		u64 pfn:52;
> +	} __packed;
> +};
> +
>  /*
>   * The guest OS needs to register the guest ID with the hypervisor.
>   * The guest ID is a 64 bit entity and the structure of this ID is
> --
> 2.34.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

