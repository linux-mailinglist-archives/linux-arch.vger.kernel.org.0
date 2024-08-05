Return-Path: <linux-arch+bounces-5956-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC25947386
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 05:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8816281017
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 03:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43364524B4;
	Mon,  5 Aug 2024 03:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MgjM4IO0"
X-Original-To: linux-arch@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010006.outbound.protection.outlook.com [52.103.13.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B822F50A;
	Mon,  5 Aug 2024 03:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722826906; cv=fail; b=gSosfP3gtNBiolPYV4nwCfgYmVTkQlVkHDoFzcyotzXxJtRTnI32gi60p8Tc8wirf6RRfhLrkqBzqchQ1Y0LxBPfxgfmppmvZ+9ma5UMHKdH/uyQjmf4QYJoC1xJ9fvDRhCZ8sRXFsRL2cJHDHfub82UHB14Fh4mI7wzl/yOOlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722826906; c=relaxed/simple;
	bh=3WCdyfFUsfR164BMm71w6veWwuW00kQvGwd+m3QrZuI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rPgai6LHF5wa1jfB9CGALwbYSrzIyKCnWE2tedRjVloDtSp8c6jzqdxAgRsMnjiaDBC/4IjZ1lmeeQS5noKIdlJy41LxnOVfcVJfQEIyHpGxQk3a6G+3B2ZUL6HdM/SujNOfr8Nqxd8FG6dttsQKlIo4u0lBBtkvoizVUjNlztY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MgjM4IO0; arc=fail smtp.client-ip=52.103.13.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuUcMD/KNbUyNTDenoQzfvMX0chD+Uf1V10W0BxBarflklvEhukMQZvWmEKntLgP8fc0sB0zPWKbZmN76/ADV8GLnyi3tLVSjNktsWMmUvBUmCRvhdJxwsaJlzthwtDEkEx70Nu2hvQEwwoqwM300JMiyLGNXDO7liodK5to3iDsaeqHd7LjCq9YCs4UTKSvCz/Fzef79bH9MdC++pwzJcOdo5DomOJKFmrJ1Cz0Fbh6eZHtGOSuEyo9h7dXi/xjcOgmQ8FflYT3K70vT0pI1H+++2KZn60PQd+TgRIDpSCrf/0xlGWuVMW+zo2elNFVlIjZLcVq6VmD8fDq5wmdhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zfemuu36Y2mP0IOPKJn4FHpC/CbuvdivXpKHFcm7ZwA=;
 b=xjscUob1jkFW2sa58nstqIgiHFqu9yVZLZkUe4S/iXAeFXb3OiUR3Vek1SxqKTRfvTROg2lafFeKbnBTIaf0pR6drLFziNtujJEkKP9pyNK4/T5bsAecxbgPcBsFK2y2iSl+HvCiZYvlgFiq89vlv0y7vq/e82D6PlVxHZnENJ6PgYU411XoVoJOj5q2isoqVSUax3UO3QXPBX+RO6B34e+u4jssPC5sGvzvfzZyRW1DdOpJxMo94bJk3BjbPSaesC25MtsFYZlpdtfnu82eaRUzl+U+wrP1nVc8pDg4x3hZb1ByqbPE6U/2rja7/R6sda0BLdKrVA3mAJvuamZWKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zfemuu36Y2mP0IOPKJn4FHpC/CbuvdivXpKHFcm7ZwA=;
 b=MgjM4IO0o9OfU8b858Whi4vv3jFXpM0y1si3zmjBkViV0ZO7CfusyqV+ckECzA/G5C97eiFLyALDXQwQVU7aAVQnL+GG4HQSer5cKLUxilznQHsZ21rpzn36VWOu0sYIBZaWL4RKjBjUfSaIBfcYShwMoaxWbRHTOR4wOOqiLBYb04Bho60fpNjKBmBrwMX47/ZCPI8BPdhkh70uuOQDfIqNoE0C9712qNBBrygNAQpAg+4oLO1qbdr8oKh3f87rNWXZzUG3tGNZCoq9tAlFzxHhKD5pVU23uLy2LawD4NLW4TDwm8SAWkz0SU2BibhbHy3fYrEsi1RKDsL9FUAqDQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA0PR02MB9464.namprd02.prod.outlook.com (2603:10b6:208:408::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 03:01:40 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7807.026; Mon, 5 Aug 2024
 03:01:40 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, "kw@linux.com"
	<kw@linux.com>, "kys@microsoft.com" <kys@microsoft.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "ssengar@microsoft.com" <ssengar@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>, "vdso@hexbites.dev"
	<vdso@hexbites.dev>
Subject: RE: [PATCH v3 1/7] arm64: hyperv: Use SMC to detect hypervisor
 presence
Thread-Topic: [PATCH v3 1/7] arm64: hyperv: Use SMC to detect hypervisor
 presence
Thread-Index: AQHa36+WUBGIaT7NY0yUh4aIGbbqLbIXSEtw
Date: Mon, 5 Aug 2024 03:01:40 +0000
Message-ID:
 <SN6PR02MB41573831866B7FC9E267D72DD4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-2-romank@linux.microsoft.com>
In-Reply-To: <20240726225910.1912537-2-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [u6mODX+1dQTsv0QiR7Tj+oOJwF1rUAKg]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA0PR02MB9464:EE_
x-ms-office365-filtering-correlation-id: 7178f7ae-7633-4346-bf9d-08dcb4faed9c
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|19110799003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 n/V9Grpo72qbSsCP1lZb5pm3KuR2kYlmY1wSDaRkwrDnBO58LpmgKWLB00rWQiXV2ASaTMFPydxZWi3Ct/1lcE8HG7N93mRtq3wKqw26p3nW2ocgz4JXoRzma+joBYS4ongi/Q24oweTicZfkAx1ka5QSf3kh9BbIti9CCusAXpDt4Wm+CPcaD2nwCoWf8VT+4nE8I5eQqn/dRrrOktkifBTkv6Apvfk9v60eLGV3C8DntQqtifUBE7ycP5dA5H9brjEZe3SEH+wTh1NDk0cON1U3amgQKnreHix/Ov7qY6RPGbV8yLZz1edgX7DnJ63/Y8HMryqVvIHPqFs2Ye3HxRXsUt0YvxSLm3U4xQzvp+jkmpBDQqQ9op34stSUnAOibgvYAUHZ3BLF5edeBsB0fnPq4UsjB0lBdqmrbrdga2r/qThU5k2NgMJJ3FMMQ2l5RNR34LrNlAo+zw4gAGq1gwRiaPMS/xObjv5XlvuMdzvH3vJ6+I+uAtub5e8XBEO6Weg+H9Vxkogn0n8yZ3Vg7MNYACQyMj/QVE/cUCqaLG3R4IxgxoX9MerPQEdFRxjzsnjOSpLgYiUJuw8GE+/5b5OD9UQ7VF4DCQelEwLBshy+73PNH2wgSOynJZAdXm3sk9+Cfv0RGMm36wxz2hCCw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iprtMBDGGstGXs0BOnO48QUpiLkPNmoX9XlLf4e7cbLdhCOk/6awIl/QGVTg?=
 =?us-ascii?Q?cei7+kyeCW5CQXbsEvcLTA3jERU3VJ0wv6EJv3U0FFWLNl7vrh09IXDuYceh?=
 =?us-ascii?Q?hOdHb1UHKqgsjWW2/7DExmBTZiAWJhk8WhuW6EWIGVscTbzLhQF+4IH9WIUn?=
 =?us-ascii?Q?XWuj+KzPKToXWFWNj9iBkJcd3oqLti71qTGmml55unHMyLvwrxfcJG87Thz3?=
 =?us-ascii?Q?pYgdP3c4RR/WVGzucs5piYuaGp8v/DCFZlzo+8XQQyPYDKop8SXflmsVzLrh?=
 =?us-ascii?Q?z888Jkz8s5jYOACAWV7ymHqNdCWHKtDOa5BYbI1gtnUVPxtGV3DBhTpj8Zje?=
 =?us-ascii?Q?8PAPQUNHPhgs5UAYdvkBzSUkWNmZDsolsnrENmZxPtCBDGYhxjBQG+utljI6?=
 =?us-ascii?Q?FlFcM05T9iAcidRAvGaiXO3Z25sFGSogZBJhmkQoYsuriMeRU/lE92S9GGYR?=
 =?us-ascii?Q?cNH56+RgEh9JRNOpfXIbicD4YAKHSFSFijToOsSsWYo0ABhYfMkrbiE118Aa?=
 =?us-ascii?Q?KpqA2ttZkG5Ex6x6+1ZnkFOwvEVLRVM0MHbw3fhr12W0FG4HjQGxZbrXyTfe?=
 =?us-ascii?Q?cZDYCLG+/VLrYzOg0335wGG4SVnI2RuNh5Jrc/kSlYzM19oJL8yvK5Z+XOIv?=
 =?us-ascii?Q?J77IJwZ30pg/9HrKZTTSApla6DBqfv2pxURnEvci4D9mEBzyW5lsnblwwllc?=
 =?us-ascii?Q?Fw1Xwus2Ya2ZbvlDBBiMkQT6KU8E8MtKIs0CMr6oj5fvZfmUCoT3zGr3+RAg?=
 =?us-ascii?Q?e/TBbGY6yoSzey/6XPLpoq5W5mjrsOkmJlf/pgqM5im8/GRx8pcELVYVKtV+?=
 =?us-ascii?Q?KXdfetGuZMOSPuMF/zJfUo/SyJRGMhgHyOMO88mILC2QDKomBho9BJCX17dC?=
 =?us-ascii?Q?4VWjK8eJEVqsLEd3z/zU1I866usvd6xW3fufDZw2VzIfZxYamipwwWa8Kz11?=
 =?us-ascii?Q?QQIpSLNhntjOAhxD96PDwLMdeKrtd9c9pJptB+ESOoSaZzfh87RUkvaQnzOh?=
 =?us-ascii?Q?j+PovC3CPf6ZLiLNWYRKJ0ClEVqI2gM9DH0QTG94jaZtMRiIW/pop+4p+xNW?=
 =?us-ascii?Q?UEMQMPZ0gCjQjXmw5OA67IjV+pvMuksIUl914CGa2cTxA1hk6agb+gsWPStO?=
 =?us-ascii?Q?H+8fhMhntF8/feHJmugQMDtqjGsepMoVM9AI2WGPqmSO26xQPv5xWu/7hCnU?=
 =?us-ascii?Q?vWH3KITBi0HULmcB9BCNmTwqVCOLDN7Nt1P7jdzvrcgB+kbGulPCrHpZmzc?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7178f7ae-7633-4346-bf9d-08dcb4faed9c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 03:01:40.0844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9464

From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, July 26, 2024 =
3:59 PM
>=20
> The arm64 Hyper-V startup path relies on ACPI to detect
> running under a Hyper-V compatible hypervisor. That
> doesn't work on non-ACPI systems.
>=20
> Hoist the ACPI detection logic into a separate function,
> use the new SMC added recently to Hyper-V to use in the
> non-ACPI case.

Wording seems slightly messed up.  Perhaps:

   Hoist the ACPI detection logic into a separate function. Then
   use the new SMC added recently to Hyper-V in the non-ACPI
   case.

Also, the phrase "the new SMC" seems a bit off to me.  The "Terms and
Abbreviations" section of the SMCCC specification defines "SMC" as
an instruction:

   Secure Monitor Call. An Arm assembler instruction that causes an
   exception that is taken synchronously into EL3.

More precisely, I think you mean a SMC "function identifier" that is
newly implemented by Hyper-V.  And the function identifier itself isn't
new; it's the Hyper-V implementation that's new.

Similar comment applies in the cover letter for this patch set, and
perhaps to the Subject line of this patch.

>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/mshyperv.c      | 36 ++++++++++++++++++++++++++-----
>  arch/arm64/include/asm/mshyperv.h |  5 +++++
>  2 files changed, 36 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index b1a4de4eee29..341f98312667 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -27,6 +27,34 @@ int hv_get_hypervisor_version(union hv_hypervisor_vers=
ion_info *info)
>  	return 0;
>  }
>=20
> +static bool hyperv_detect_via_acpi(void)
> +{
> +	if (acpi_disabled)
> +		return false;
> +#if IS_ENABLED(CONFIG_ACPI)
> +	/* Hypervisor ID is only available in ACPI v6+. */
> +	if (acpi_gbl_FADT.header.revision < 6)
> +		return false;
> +	return strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8) =3D=
=3D 0;
> +#else
> +	return false;
> +#endif
> +}
> +
> +static bool hyperv_detect_via_smc(void)
> +{
> +	struct arm_smccc_res res =3D {};
> +
> +	if (arm_smccc_1_1_get_conduit() !=3D SMCCC_CONDUIT_HVC)
> +		return false;
> +	arm_smccc_1_1_hvc(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
> +
> +	return res.a0 =3D=3D ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_0 &&
> +		res.a1 =3D=3D ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_1 &&
> +		res.a2 =3D=3D ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_2 &&
> +		res.a3 =3D=3D ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_3;
> +}
> +
>  static int __init hyperv_init(void)
>  {
>  	struct hv_get_vp_registers_output	result;
> @@ -35,13 +63,11 @@ static int __init hyperv_init(void)
>=20
>  	/*
>  	 * Allow for a kernel built with CONFIG_HYPERV to be running in
> -	 * a non-Hyper-V environment, including on DT instead of ACPI.
> +	 * a non-Hyper-V environment.
> +	 *
>  	 * In such cases, do nothing and return success.
>  	 */
> -	if (acpi_disabled)
> -		return 0;
> -
> -	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
> +	if (!hyperv_detect_via_acpi() && !hyperv_detect_via_smc())
>  		return 0;
>=20
>  	/* Setup the guest ID */
> diff --git a/arch/arm64/include/asm/mshyperv.h
> b/arch/arm64/include/asm/mshyperv.h
> index a975e1a689dd..a7a3586f7cb1 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -51,4 +51,9 @@ static inline u64 hv_get_msr(unsigned int reg)
>=20
>  #include <asm-generic/mshyperv.h>
>=20
> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_0	0x7948734d
> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_1	0x56726570
> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_2	0
> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_3	0
> +

Section 6.2 of the SMCCC specification says that the "Call UID Query"
returns a UUID. The above #defines look like an ASCII string is being
returned. Arguably the ASCII string can be treated as a set of 128 bits
just like a UUID, but it doesn't meet the spirit of the spec. Can Hyper-V
be changed to return a real UUID? While the distinction probably
won't make a material difference here, we've had problems in the past
with Hyper-V doing slightly weird things that later caused unexpected
trouble. Please just get it right. :-)

Michael

>  #endif
> --
> 2.34.1
>=20


