Return-Path: <linux-arch+bounces-10695-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C44A5EAE6
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 06:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 546C93B78F3
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 05:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D880D1F8EFC;
	Thu, 13 Mar 2025 05:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ivBTiH40"
X-Original-To: linux-arch@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010013.outbound.protection.outlook.com [52.103.10.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDBE1CBA02;
	Thu, 13 Mar 2025 05:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741842616; cv=fail; b=MPchVp2JZH43pXfDvem6gx15EhAxeUwA/WDgPWLAMSd5bH24PVpXs4DtLJtfOEKBJPM6f2xtcod71GSPRLtIwcQWqOvBUKTbuxTnzVOdbbC8a+CXvfh4M+OBTAY3u8hQ0DdBHfqlq5ZbtdUFSzQrGUZ8DMBf3fuaxarRocd5HW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741842616; c=relaxed/simple;
	bh=scbspkoJzrPjYVr2/A8UL61H/UIAYsiuC3IeHjqp2Ag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HLbD50AgmgbP/s3HPdycJcmlKLhprwa4dzZnTaPerU/qhokR2VaK3DOR8zhfCqhgd4WsJWQ6PPXa9aPBlKzY1SRmq/NvDdhU+0uOwe9wpUkRgwVyMIBQVSvbbdcHesPu820ylTJeR5Gu0yjQmSdWLyWkjMa/h1wByMWtszlovLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ivBTiH40; arc=fail smtp.client-ip=52.103.10.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8tp5/X0Z58SYrfh74PcQED3V4V5cPENEeXvBEqfqv2P32y5KuJsY8ZoFCmxo+qWb+DE2qXBQvKci2V1vxoPrmd0fn7blbzfr5CAtcIHlZWUvMhA06ahg6wkPH1DljXFWjip7yE7cBybrpS05fjDV7PLbNCJewCjyjf6Ghj2Drk2oUcuX6ekA76KCFRTHs/2GZsEwFvS+WVH/2P8Gr0OkCTJd7Jzq3OAQAbNxF4hP6NavxZjSbGAL1tbyJ9rJcsjCyorg5ArJRjGHhfZOW6lZyiVlWoIhMekeqn8w41t77j0WqiVsB5+Mgv2SqOv85z8oBg3euj1mQ5iCoU1wDFK/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Vy9yWzdGitYJmKP//r1mXHpU72sPabkjGQB7hEgOm8=;
 b=zPpFd2+45BFmr6Vwl/KPpbGDYs0KhKuU6xQN+lcgKKooppw52kwE+hpHAr4caT/UBdVMoPeo9ZoVWXKiryxcyN76SGR6N0nk4wCh0WuZrUi014rd5wGtnxSPM2L3HfIlLOAPIDR51apr5bGd4T6XGAi5h2zWPC/vXsmc9pGO4VVTntVqLpvLnT9rbJ7m5S+puliyugPUgiJu1kt0khVOhLbWi+uJA7us1laczcQrowC7yiyic1vvxYmhXfNYnWYv2enTPhj79UwXuP+1MXUTkpy+5/PYlCZnqt5KqmuUtj+Gq4yWCbTlvijSPC8p8vDuUYuFZJMS6jRPm8oazPjI8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Vy9yWzdGitYJmKP//r1mXHpU72sPabkjGQB7hEgOm8=;
 b=ivBTiH40CorDnfBQF5x0L6va4bQ4/66x6eTOwq/4il1lgPHjOIiHucLvxvaU9r8nndS6v1AJ41F0/MOTZdUDCD8mZcXs1PSitGXkzJnrqlGTOFU+7dYUR5nWAzH2BHXCTPU7vNC2luyEHUQPCBpsuBM6iMC12YmtQsuSDxO6TpKr3EOaGh3DI7aSpOr5gi8qJwassTIrKERdTOAeiwiz/XRkUvmMT+ZsgPh/MGVqANVBwRLa9WGjW8LKGjUup89lV3O+j20ZUZNdZEa7QsjEZx2U+brhmWFSPc834fgy2W2FoxPejGiS3eLGoPCZMFyXqKNM92RV4L8w4SuA9C0wJg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8685.namprd02.prod.outlook.com (2603:10b6:a03:3e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 05:10:10 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 05:10:10 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, Arnd Bergmann <arnd@arndb.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley
	<conor+dt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dexuan Cui
	<decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Joey Gouly <joey.gouly@arm.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Marc
 Zyngier <maz@kernel.org>, Ingo Molnar <mingo@redhat.com>, Oliver Upton
	<oliver.upton@linux.dev>, "Rafael J . Wysocki" <rafael@kernel.org>, Rob
 Herring <robh@kernel.org>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, Sudeep Holla <sudeep.holla@arm.com>, Suzuki K
 Poulose <suzuki.poulose@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Wei
 Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>, Zenghui Yu
	<yuzenghui@huawei.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v5 03/11] Drivers: hv: Enable VTL mode for
 arm64
Thread-Topic: [PATCH hyperv-next v5 03/11] Drivers: hv: Enable VTL mode for
 arm64
Thread-Index:
 AQHbj6zpmH+gYA9h/kGlfIiTOb0OO7NpvEQAgAMg+bCAAAf2gIAAB/GQgALt7ICAAB+EgIAAD2iAgAB+wuA=
Date: Thu, 13 Mar 2025 05:10:10 +0000
Message-ID:
 <SN6PR02MB4157A635B0D1B43A2ED2664DD4D32@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-4-romank@linux.microsoft.com>
 <e0f81049-688e-4f53-a002-5d246281bf8d@app.fastmail.com>
 <BN7PR02MB41488C06B7E42830C700318DD4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
 <119cfb59-d68b-4718-b7cb-90cba67827e8@app.fastmail.com>
 <BN7PR02MB4148FC15ADF0E49327262B92D4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
 <caa0d793-3f05-4d7c-88d0-224ec0503cfb@linux.microsoft.com>
 <45171fb1-7533-449f-83d4-066d038c839f@app.fastmail.com>
 <996deaab-e1d1-4f04-ba31-c0dcab2d5e1d@linux.microsoft.com>
In-Reply-To: <996deaab-e1d1-4f04-ba31-c0dcab2d5e1d@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8685:EE_
x-ms-office365-filtering-correlation-id: 63069523-896f-499a-f054-08dd61ed5416
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|15080799006|8060799006|461199028|8062599003|10035399004|440099028|3412199025|4302099013|102099032|56899033|12091999003|1602099012;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?lxjhaKAHrGLnB4bTbdqRMAVyqXFFeOMwLR4N2Yn0f2PsVs/HbxZDx2zSGU?=
 =?iso-8859-2?Q?2/UXMDcB2pWAjm1WKmatXoBeOvB4kQH0Jrx8VCzZqTUt0qF0bqM4I/9pjp?=
 =?iso-8859-2?Q?FCcSZmX+nU0R1RTP8iaCThmiYxbRUMMhVHhiCMXWVTjAnWMqfzbc4c21qO?=
 =?iso-8859-2?Q?Ie7U47/72AAaEIU9OLoMbwaCsRetUp6mMg4Igq1A+TLRv9Jy36oGgKOa1g?=
 =?iso-8859-2?Q?LMSC9/RHwvK4TL26kPpjT8yQGYbFN4ZEesqNMmalUNV4WxLwPleCNVkglS?=
 =?iso-8859-2?Q?jIHI6E0uvpj4oqbYsa5O4HPu8gfeRHzlOYZYswBw4FaeEckuXFX2WrGr3q?=
 =?iso-8859-2?Q?fYJ1jLHEkOb08uDbhZ2DQz8cxMWJvhofAKZrDjtUjVIzwrfNiral+ILapG?=
 =?iso-8859-2?Q?5rmgGSoRuI+cmV+40nbx3oeZ4u5bPVuGK/TWMyhQUZB8aJOP18tZqCZP8E?=
 =?iso-8859-2?Q?O/A5F18VYhVss2DeIpWmudlXPIYIwz475Ml4mCdso6E+sElCSFufXkFGCn?=
 =?iso-8859-2?Q?HqM4dSyH1AhOJG8G8qg8zI0bJEgIEbROSEJiAFPIt+TBPcJXfhCnw/i/l6?=
 =?iso-8859-2?Q?QQ3aJzIjkYlldfQAiLkSPQfnqNGqHlDj+oWzm9ddLEBy33Kz922vSFrRJ9?=
 =?iso-8859-2?Q?wVVaXjty+IWXyFJhWF1KgGz6x/TsYiskpOVbYrvq3I6+dzSNDGtGFY6Zhr?=
 =?iso-8859-2?Q?Q4ilkktQASf9pKXXNVrVigGxJI0KevL66DYVSNAS8BiTll2k78nUcBKEXA?=
 =?iso-8859-2?Q?ir7Xf/VWkllLcSCgzLnRrp+Q8ypp7FgeobBbl/vGGFRd1b0ZbbhTY+62zz?=
 =?iso-8859-2?Q?LrbIBtvHBZeNpeG3tswePW2snDn0DGRd15En3/Pv28/veUafNOikFrIxwd?=
 =?iso-8859-2?Q?qwwyoT7QMwwMrHwDhnVKwVBwB38Q1wVEwcivWW6HJjwbGJbOhritnDFVUw?=
 =?iso-8859-2?Q?cU7d5AVc9YsF9n62moMhtyrlAXjl4rzF3xb5V20PaXz+hOvtXCIAdZQxbq?=
 =?iso-8859-2?Q?dZnAXqhNxImARVDTL8LXhE/neBdkCkt4Nmegv+yFHWGx8z9gWxgsTmcqRL?=
 =?iso-8859-2?Q?vg7j/JlQKyxV7SnLDSDjRx+aMVlY0S3Q3h/Fl1XGVFyfmgfxT3sGgZs8sd?=
 =?iso-8859-2?Q?UF5KEHENNESR5BmVytjCKw9ypj3crp4ISpcFbon7sK4mmFDzhYQqCpswVs?=
 =?iso-8859-2?Q?jnCeRuK89clKFr044/9m5/rT9D43KYnnwCGm5mr9kMTSa05rL/Q6pHUB3+?=
 =?iso-8859-2?Q?gTH7puyRUw0vz6wKjLn8vIz+Hql9bpjDdiVmyT0guU0LGSdy8/Ic4wj883?=
 =?iso-8859-2?Q?0Dp7?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?SQcZErHDzOOiPhCC3+DAAxDCF0L4XKbhjjDWTY1wXFNF+2ddqnz2H0LT4b?=
 =?iso-8859-2?Q?fLw/+MBuwtRpRAgqpKxv1cV8GWUQ7+Eru18AzTc6s/VTqOYdcjnIGSVlqZ?=
 =?iso-8859-2?Q?5IG2hXP20NiEEO0Cz6cOuxeuSUBThDv7KH/1MgnUpb8clwHM/lfgVVHF4t?=
 =?iso-8859-2?Q?sv8iMc1FgciLBomDCv6VEs0HN+OxLS7xWxRKT3VLkAEv54kQx5cSuIrr0a?=
 =?iso-8859-2?Q?FMdLEAKdRE+wmBMihLfvfws/0kyqorr1ap+xDk6jYVzUan4B25y8NdMank?=
 =?iso-8859-2?Q?o52VahN9ktwFCfKLYqagMGch/fnAhT07PQJJcmpu6Z9mIs0P+tpiDV2SgT?=
 =?iso-8859-2?Q?B3OwhcayDIwWsWE3c9fOLgRKYFg839RSgpnv2XqjrZU9+EvhNyprOvVBTN?=
 =?iso-8859-2?Q?JLj7h/nqT2i+vI/bPlVKrBHMwB45USJqofVAEMtlr0sJNiI8Bh3VjULfW6?=
 =?iso-8859-2?Q?BnonQTRPpIzoX1nKZJYMZYnbHeCyo/XNRAaMGkaAzixC/r/rFxOqjwj/nQ?=
 =?iso-8859-2?Q?smufy1f7O413icJu3rIhJZYzcXIQlBI44JhoJgCzMHzXpGjrf1LWNgLXPS?=
 =?iso-8859-2?Q?Br3mcN6a9KHsJgCJnfwrNplmUo48IwYrm95vupRYx8mjvYc5XuVEgltCSW?=
 =?iso-8859-2?Q?w8R+T7ycH5XTpTIVeCwSGB5HXu9nScD0Ddb+wCGl3QTp1CGiN+fU/XB7lC?=
 =?iso-8859-2?Q?vKxq6lkcB+Xzu0es5S74QgFUMIYSutJHi+Pmk0LHD7w3IOgZjVbjC+gjG+?=
 =?iso-8859-2?Q?QwsL27jtrz9d7ZUTCCTxYZrGFmbub5NCw6iJSVuu2O52djHE7IVtMUaE17?=
 =?iso-8859-2?Q?VRpsxSqailRRsvM12gg5sv3Tq6wKcHklGf+9IchLYC0kJjzDIjtn46NTY4?=
 =?iso-8859-2?Q?hP03CvzW2OjbsGLWy3VXWwPLsGBLYFQTzdDFCKj0iZhN1UbA3QvqOtkoaB?=
 =?iso-8859-2?Q?6o+hJ4TCQFNImvBQaq5Zb1YWROg/a8s41H5hEV/6WVq+5URr0VKNtc1jcr?=
 =?iso-8859-2?Q?9OxI56mbhXNiPabyZTzSuWZLs3pod5pCo552qFYzBEZ2s0Oqrc0CKFeXY7?=
 =?iso-8859-2?Q?UWBy2MJJ/WF0uocU4xYLuJH92FMXvgBsfgXSiQxK70dr8q9P/Y/zfDgl/u?=
 =?iso-8859-2?Q?9FKaQJ9Kak+5Dep/HzbkeM6CKMIcGCMeKahtKn5Edai6pBeinl+pTCUs5E?=
 =?iso-8859-2?Q?qQcBfzDdJkn15rc68eAXaEzHO5af14a3KF0RyxR+BWqyFIjVC5duGQaz/Z?=
 =?iso-8859-2?Q?RZlP8C7e2VApQjSV4xM/6KLP+0T+mFKDrBx705omM=3D?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 63069523-896f-499a-f054-08dd61ed5416
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 05:10:10.1788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8685

From: Roman Kisel <romank@linux.microsoft.com> Sent: Wednesday, March 12, 2=
025 2:21 PM
>=20
> On 3/12/2025 1:25 PM, Arnd Bergmann wrote:
> > On Wed, Mar 12, 2025, at 19:33, Roman Kisel wrote:
> >>
> >> That's a minimal extension, its surprise factor is very low. It has no=
t
> >> been seen to cause issues. If no one has strong opinions against that,
> >> I'd send that in V6.
> >>
> >
> > Works for me. Thanks for your detailed explanations.
> >
>=20
> Thank you for your review very much!
>=20

My original concern [1] with this minimal change is that it allows building
a normal Linux kernel (i.e., not for VTL 2) for Hyper-V with CONFIG_ACPI=3D=
n.
Such a kernel will not run in a Hyper-V VM since ACPI is required unless
building for and running in VTL 2. Current upstream code disallows
CONFIG_HYPERV=3Dy with CONFIG_ACPI=3Dn.

However, I don't want to make too big of a deal about now allowing this
misconfiguration. Arguably it's not likely to happen, and the solution is
"don't do that".  So if we want to go back to the minimal set of changes to
drivers/hv/Kconfig as Roman proposes, I won't object further. I just want
to sure everyone is clear on the tradeoffs.

Michael

[1] https://lore.kernel.org/linux-hyperv/SN6PR02MB4157E15EFE263BBA3D8DFC51D=
4EC2@SN6PR02MB4157.namprd02.prod.outlook.com/

