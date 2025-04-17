Return-Path: <linux-arch+bounces-11424-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EE1A92187
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 17:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D540C19E8346
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 15:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26B3253B51;
	Thu, 17 Apr 2025 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ghoQ9pLf"
X-Original-To: linux-arch@vger.kernel.org
Received: from outbound.mail.protection.outlook.com (mail-dm6nam10olkn2074.outbound.protection.outlook.com [40.92.41.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BA725393D;
	Thu, 17 Apr 2025 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903699; cv=fail; b=JSLxSU21FRns+NtHustuHXjA7Bn0w52Y1hjNSvBtvf4jvJ90TXqsep3rnME4rmhvlq0bUpfCkz1q3EVATKfVIvFT5H2Wnp88MUFSeixispzZeGgnifAcsd0137GHM0OJWWlB3sUHAIP6dk2fJPZdTT+2LujunLSqEw0LIxkPKF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903699; c=relaxed/simple;
	bh=QxSk/wLhfL45f4PnQg69K12CI70prjRTZskpQa/8A9Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TsPavFvxxBoxfV8cU3SCvE0+s4wqYnrPEYmdRpiOpMvIENZWzVde7AcRowv2J3AuAnDrz6a0PPAukgn8L4vJfUE+6Ve2dIZLXb7UcGup9oE/NdhGmZ+wCp+OU2aLybnzW7flokG0z3COGUF6bu641RDyadFXCSdEOHWgA6GoLpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ghoQ9pLf; arc=fail smtp.client-ip=40.92.41.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xa9WulnBzXNE4HIxjTNfaBcZHqQPwczgnIJpaY34u12w0tNd4v5nM78718ibTuawgW7fD7x01symNYUaw4OrPe3KSbdf2F7jCiD7T+TR+Eftbf6H1rTdVPwxDnnQfeFcxkwfU9P4LRDYDN024+n3y/mE6qzKsfMdiapAGRKjTrgUJ2IUAFCp5sSLCFa/ufouj7If9Heg5kmzxCZVUo6AgLZ/37+Vm13mktTxs1znJ6tMpobDjfMPaTSKliJ0m5uHl8RoKnOs7OgD6opRup6lER/MD5HzssYQxc0jyusTcsc1XgeqOa2JeQr2/ehtCilXu3CuMZu8NqN1eAzpesYHqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKI5kdADE6tY8wWXmU7XIxpu7U+FNSykpAGDCoVf4z4=;
 b=wnidn7fiKdCAxqzJQkLUGnNgDT5cItfs8zbKeSdJwclxKJ7n6MzF43ZJKAh9B4R5sQkuElO72+f1v/tNyOsFNKpcAUHajvMAg8oO/s6XjG6WTZNBMHrz4KxKYcPiUPI5cNa+r9BArnr+4ocFuo3m2vBZ8TULhlNlTnW70qSEys28cv0Mxr77so42EqlJt5HSMFAS0Jfln9P8PmhUbZeDaBMF7q0tWImnoofsJSR657r6jjqqlgLPt2wfkcykIBwVcBCq6Yt0FCF7Gcp2KT+DsK6Xurkpp8kwSu5ln8zpy+Z0Gf4BGhCaZhKA1LlmHU6gAMvBq5kA2wj8P0Jl3fQ5BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKI5kdADE6tY8wWXmU7XIxpu7U+FNSykpAGDCoVf4z4=;
 b=ghoQ9pLfSsIluMjPMlTQ9edHe3ASRfp8VOHAOd0XYJvdM2+4zV1gaQHnTOXyq6GILDyUWze941CA2kqnkwPvbEswRwWugEZbMEa5To6FHwGfVQoJB0E8GA7avf37qBg1frhIWKgCdKd0f65j+QUUOtloZyTdE3wUZWvcDGUmyAvuU0XC0ERIzTkrnVMw7cCUCtbEJ6sd0FuEAELitMx6wkque79kIGiWyED3f9DXemaJi5ldM4o+1YpaoXsmtw8Ox5sS7NcW06Mj9Kw60NFcHWc8V51lL/p7rDc5hT24AWqDhaSYVIRox8nulrfTEiFXqyDds87Na4+B3OBL5FEg9g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8209.namprd02.prod.outlook.com (2603:10b6:610:f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 15:28:14 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%5]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 15:28:14 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "kw@linux.com" <kw@linux.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "maz@kernel.org"
	<maz@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "rafael@kernel.org"
	<rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "will@kernel.org"
	<will@kernel.org>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v8 06/11] arm64, x86: hyperv: Report the VTL
 the system boots in
Thread-Topic: [PATCH hyperv-next v8 06/11] arm64, x86: hyperv: Report the VTL
 the system boots in
Thread-Index: AQHbrY+RT1SxiDc6Zkq82gF8IfKB2LOn+Knw
Date: Thu, 17 Apr 2025 15:28:14 +0000
Message-ID:
 <SN6PR02MB415729A098EF2346C912873AD4BC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250414224713.1866095-1-romank@linux.microsoft.com>
 <20250414224713.1866095-7-romank@linux.microsoft.com>
In-Reply-To: <20250414224713.1866095-7-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8209:EE_
x-ms-office365-filtering-correlation-id: f66d04be-bc06-414c-3b58-08dd7dc47875
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmpI8tRyoOXaSUmOkLVCBKasalI0wg0TYhh8xwbo6WZjddg/EhrPvfSPty2XV6wpOgJMLfN6DbxIcotzT6DaL2eZwK2E+8p+iS2EucyR1xrMYYhXVJIaUkvomtWI4FyYDQ4ISRXzYnDXUEIZYX1Fs9DNMgChnp2H5zHO88nzNPD3c9QRb4PJv/xMkZxSgkl9PajoqYbZg8WwYyaZFf1SKqVT0YauPdt0+TcvMzH9UcZsfaxxag89cbY9hQ4JL3BoxYQuF7MDqFypruAPQfxkfuZPxGC128fHMbVPY4GYcGokL5sqeu05VNf1u4uSH4EqWig9iZADg+04zeCHgt83xdnZ9biTEiaXyZMuMFekoey3XwKP42kqzVvUhfPuWDLRHMaT/IueSeUutZIPNw4nUjqBsIjFOhmiaYXYHIsUXBB7umzuJXB5gLodYX0z7VzmW6YTecwAKPvoZMr2QVc8p9+OPfK8Q0JBILZql1Ge6+TP7I13+/yZvQVFNaYoG1ePvzghoiHCDsPWuEFqAY0Psct8JBS78tuDMhEq+uwpBGr+pu4Qy7KEb18qPHfMTo1tvYP9/ac8WM3qLg2zoB2tAoM1628Khl2Eh7IzmbEyYnMj0Tmu6bbquQwK1ucrXtgex2/MRGKygD9QCyDtf591QbG0mP436i8dqdP6OQ8+DXDMaLc+IqoVN/27nkm13qujJDMlKhRE5Boq+5VI1dyJcjGSoHDoSz3MogZLnnsgq4hLRJRs3wwaWHz2qAOJmzr0BTo=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|461199028|8060799006|19110799003|15080799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KCig3EvUGwMc9oyMxW58TiywKPFS89mUCDTHERoHZ0Q+AH5Zv5LLBCjHi4gw?=
 =?us-ascii?Q?rFbdvESofmlhrcYsu1yk/36CxrVK1F37euKkZqZr7XlDHVdCT9tRWIYkAdQK?=
 =?us-ascii?Q?be23IifVjaOihBOa/2k7UASGr51CgqpsrLtbrF9Sa4oYTJ14+NWEPz8pabxd?=
 =?us-ascii?Q?TlgLvznn2Zx0ILGMjmzxp+lVozsQbfsETIlh5CUtMi9xhtOo6c4z/5vb7LZx?=
 =?us-ascii?Q?gvRwbcfW9ksc1mndnR0NYgt+/BYWgRC9xXbLftM/S57lwtRfqweQps5c+hTU?=
 =?us-ascii?Q?lf4Vyj0EAM3XB/QZIJWkK/qhtJnnQSd3WusEBTatkjQJDExdVQQwG7c0CLPd?=
 =?us-ascii?Q?ta56DcPZr0i/4DYZDNZz4gZLNccjxIjEhBSB05hC0y+pxw12mtZqPkU9zGgT?=
 =?us-ascii?Q?ByGR4K0HZ0di8Dc+pGzrY4A8Ylqg9EYyCBEri0FYCjUfbw1Q/virsh/dRizB?=
 =?us-ascii?Q?YgEmuCmvq7qHmoTl4J9mOY9pkVMTn0nzEs9z+7sSI6u8PDpndOW6it6EJSr4?=
 =?us-ascii?Q?Poak7KCha6Eh7yWCkOXotHWY6yEq12keWGkGoKQq3mAOPNlWKck29+D1vmrp?=
 =?us-ascii?Q?/0wL4CbIye8c8iEuaYUQ777eJTqiVjK+7YMAJyDCjeox1yNN3gLZ/MA5Tnof?=
 =?us-ascii?Q?ezH75zkRnAPk0MM1Gcoo5D68yx1m4ZI5lskt/5lOCBP8oDRVN+0qL7iilgcc?=
 =?us-ascii?Q?NCg8/WqBFQ5GZMh53fgqT8NkUKHmHG291CjUphb0Kvuxz8e2C2im9nXMLA1D?=
 =?us-ascii?Q?ogOBY+fdPoBMwA7Lv+Zawta4CMBuS9O+yCjYlNdDpBdjgt8Xdfy1zPoZ+u4u?=
 =?us-ascii?Q?iIutO+wkZRs0RjRaXdGadm9V2Pds8DrDjiV4iAQ7UF1kvNYBhVvAUcpyPjcr?=
 =?us-ascii?Q?GyPuATNhTb03TT93xnv+j9NkSkRmkVbZglv763/3h7X5DEFw3fePuEhvoTg6?=
 =?us-ascii?Q?ZIuUWb1ra6AzAP8hqTAnLROaiYtPQmNmnPy7erS+WToxJoHL5moqJNeUgl2c?=
 =?us-ascii?Q?eHGVGKKrRlqPq2MRIYJTDV1s5ByUiKyOZAovyTQtu/02UHqTe1TNnmAPvN2r?=
 =?us-ascii?Q?ipQYyL/PBXeSWDtMasdoVHMatPzHig=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9+0IkLXNEtiXWOATGxpZA3QRIp+8PW8Urr7/+4A2BGwUFsKTytggQ2wMJ8VR?=
 =?us-ascii?Q?g3GLVI3GTWvrNTomq2tLRtBkgX8UKdpMq0HeHj5oUTa+69uHgQhU5+SZkMjO?=
 =?us-ascii?Q?9F4ZmdqqDce3lMoiG+iLfjjlH7pA3FBh8Fk0GI+E6AvBkBSKPsSVZoFgCsJI?=
 =?us-ascii?Q?29+H+Z9pjsetrktxg4LaflRRel4Akyr9FRYsEkZ7+/d8NEjpljEkyGEAgd4F?=
 =?us-ascii?Q?3BqL0B0PytwQf8bLpjuqzY8vaKpDT/yfpwezKu4fKzW8GL3TJ4VXGVE4akqH?=
 =?us-ascii?Q?XQSoebjorBORYZ2ozhNV4PlobGQolJNuNUDGLyTKQPh8nUBCXrXcd5hBbV+F?=
 =?us-ascii?Q?GQn1VCl8yq8EVvENANDaSd+bqzbLgsbpUYhGDiVTlJrMJO9SlrqmSzgVHyAz?=
 =?us-ascii?Q?CYT/r1DZ+toZuqhjuLp6mKDfGFUvbTgrNjGAE9uxZCLmf663ySf1Q1NEBdzo?=
 =?us-ascii?Q?ng2y37b/XTG/Lb+BtYK4/87gqOudtgPHQ9G4rnDGOEQTPo0vTu40qWMbuzpa?=
 =?us-ascii?Q?3vxjugHFXLjzYG05xoQjUylEOzFNHHXI/qDx0LK7uLEp5iRg5l8VvpRpIFwq?=
 =?us-ascii?Q?evB7wLb9W7x8thSq6uaKYLEgfxqTHgQ/JhEItNpQXF+Ra4rcpVk4SbTUIFsP?=
 =?us-ascii?Q?hjo4TCC5xG+NPD0bc3De07gNSYlI9F832GEiakoqXxcnf1mtw1699JiwleSx?=
 =?us-ascii?Q?1GlVgZLPueYinpwoNvqfBbhWPN8H+UlwWVAj1fdy9CUntMNtaHwkyZ+AMU5/?=
 =?us-ascii?Q?e2iPBgStoYdtC0DJ+AGVz+oC/WfqBpgc7OvPefs96Ho9HBtSwH/gOnWC2qMK?=
 =?us-ascii?Q?iUyRnN/NCRGS0Pwr7/z5XMr83VE//is3OfyjGde+52D7YvN0c29HjBbqi2fU?=
 =?us-ascii?Q?gsQ4WyD5XCPHOZ41aEUTCBm96/r8P/tk5UBK1zuuSglG26XV5yLosXhmrbDh?=
 =?us-ascii?Q?81qedvrKWJh3ZuWmOIHyfCSr+V1FCeQJIhiHDjw1B5QhD1Ir1bDxGWf5Tx+e?=
 =?us-ascii?Q?9Bxx5DnJcr3TD3HC4d4OYF9gB6Ypns4nPuyl2WBxGrWmkISKGGPSI5iM8QL6?=
 =?us-ascii?Q?n7bD4PIKggTVwTzu4O182VX+w4e8guayvEICbn0vxqHc2TyzG2+zEtZgLThM?=
 =?us-ascii?Q?7tdfgiwNP34OSB1hx7RRKktHpITry2budGLwfy9Cyi0vpE5sWBdp78Qm68cK?=
 =?us-ascii?Q?CRhIS7RC3MaM1PT0qX/v7Thr3lJLErO99TNcr88dAI4rGxDbOD5ANoumDec?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f66d04be-bc06-414c-3b58-08dd7dc47875
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 15:28:14.4249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8209

From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, April 14, 2025=
 3:47 PM
>=20
> The hyperv guest code might run in various Virtual Trust Levels.
>=20
> Report the level when the kernel boots in the non-default (0)
> one.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/mshyperv.c | 2 ++
>  arch/x86/hyperv/hv_vtl.c     | 7 ++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 43f422a7ef34..4fdc26ade1d7 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -118,6 +118,8 @@ static int __init hyperv_init(void)
>  	if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
>  		hv_get_partition_id();
>  	ms_hyperv.vtl =3D get_vtl();
> +	if (ms_hyperv.vtl > 0) /* non default VTL */
> +		pr_info("Linux runs in Hyper-V Virtual Trust Level %d\n", ms_hyperv.vt=
l);
>=20
>  	ms_hyperv_late_init();
>=20
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 582fe820e29c..038c896fdd60 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -55,7 +55,12 @@ static void  __noreturn hv_vtl_restart(char __maybe_un=
used *cmd)
>=20
>  void __init hv_vtl_init_platform(void)
>  {
> -	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
> +	/*
> +	 * This function is a no-op if the VTL mode is not enabled.
> +	 * If it is, this function runs if and only the kernel boots in
> +	 * VTL2 which the x86 hv initialization path makes sure of.
> +	 */
> +	pr_info("Linux runs in Hyper-V Virtual Trust Level %d\n", ms_hyperv.vtl=
);
>=20
>  	x86_platform.realmode_reserve =3D x86_init_noop;
>  	x86_platform.realmode_init =3D x86_init_noop;
> --
> 2.43.0
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

