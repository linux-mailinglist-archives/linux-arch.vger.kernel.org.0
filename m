Return-Path: <linux-arch+bounces-4726-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3403A8FDD3B
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2024 05:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 951F1B2111E
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2024 03:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714BB1DA4C;
	Thu,  6 Jun 2024 03:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EfN7d4RT"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2040.outbound.protection.outlook.com [40.92.42.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AAE1DFEF;
	Thu,  6 Jun 2024 03:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717643703; cv=fail; b=FOfwo+PMeNLmDaSlDtyn6JxEeM1RZiIq1nQ16RsuOTd4wtPxpf1wCX5HKAOFkd37HVcnn77LZNtlPDZPYpNdGwZ3XZfj3RgtjK4ycxl+n4amvFsccS52JRSt27qmAJlRzEaikNdUnBUx8scs+O48KoL2iOAMKoN8O/6e77ccGQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717643703; c=relaxed/simple;
	bh=VPvya+bdm9FoOUMHvPnj45GoMumopElFch20SvE9bd8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E6edzq7y6VNH7sCobi/tPr4Z2BsqbiThqodlfUQ33GjCZD9QMKsyg8grUbNisU1AaJk1V7CooV+tO31X5nhSlIfi5UgqzFr1elNMg4Ny2c/HvDAgT+iDGzKGkmq627yOrRDkXR5wgYca9byCwr7AoQ1l/QD1nsSlCHINn3DNEXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EfN7d4RT; arc=fail smtp.client-ip=40.92.42.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdgnU2xiGUi2LDDJIdYb7zcUEPCJTqxHITkd66VjtNPNeHrK+isUE5gWegYKDinufZ70EmINleuZYRUt5ma26lbNTV9Neo8YkLJBd+5c5S2nxH7wFb/mMqGUX/aXjES1y9Tt+t+uaGwg5hWwbJynL1y+A162C0VhHaBbakhY0pjPI7aY8py2P68ObMPrRHpmDh8idltMXVr8Vc8pT3/AS7CwvybYPoRJLcEY5ZS8+xJ0CEthuWSJ7DKmOUcqMGTZVAdCk+l0rpFgCPCIi4uTcoIeIoSvSzjqEgAtxjmys3bIO0ZqdTUNy/tkZ3cbpCEmZ5NkvqMma0Dgi+w0Y/chcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqeV680hIbiq6OnRQW8I6vFqzxRJ+spYsX2U+FmkdFY=;
 b=hZn9MKOzhPaOWlX70+NII0NyTxXgtcQLQ5rw69SEXuyc7Fo3oRlUwD2XFU5ceWCCps24HgJ4HOswm4VdKM2oomsQPAt7E839WR+idYL2PPU54lsmClwwSs63AXHFwlDCStb6rkqCkIq2hdJrHibc/uzT2xqzKSEB4zzda7D5D6Ds8c5c+jR2oFvTzDFVetFPnCp/NvxpksEIExdpBmonfThVWjLRN7TWCAUbuxmvRMwc7a72227WELFqXWramr0j15rcAAdsCk9zI9/ndnOjAbxwathaXT6K44tjCZ3radNJHC4pArjU/z0R1yo7UMY6JqP8lLoU7rrHbwQcleQBSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqeV680hIbiq6OnRQW8I6vFqzxRJ+spYsX2U+FmkdFY=;
 b=EfN7d4RT2qJ2eF618b9EGMPf/ij0RX/QJ/RrFrHtL11ShWuScqoJT6HQ07ug9jBq/UWBuKw/Eo4FeZsnMQSkROVrERUmyiYCWBZT7ePBK49rqKzcBcgTqaMclUo2W2ouFR3RQQP9PPEep6gyDJgzK7LxB9EW+QFUy8C0cvP3KD/x4ZpuJlZD+FThkZoGlLxFM+1H5i9l9KUZJK3z4wVDLp0Oqvt0VyptAFwQ7YVafzdEjFjo75XYLUYXDB6bc4q87Q2H2B4PBvjCxOJD/M0iJ6Kff6lsfij3qkx11Gw/vbubLvybFJ8ekjRiFDj9kyiaRvivsQPPhHjjNTMtLNvumQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB8063.namprd02.prod.outlook.com (2603:10b6:408:163::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 03:14:56 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 03:14:56 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Thomas Gleixner <tglx@linutronix.de>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC: "maz@kernel.org" <maz@kernel.org>, "den@valinux.co.jp"
	<den@valinux.co.jp>, "jgowans@amazon.com" <jgowans@amazon.com>,
	"dawei.li@shingroup.cn" <dawei.li@shingroup.cn>
Subject: RE: [RFC 06/12] genirq: Add per-cpu flow handler with conditional IRQ
 stats
Thread-Topic: [RFC 06/12] genirq: Add per-cpu flow handler with conditional
 IRQ stats
Thread-Index:
 AQHatj3dxfDAEhKlmk6xJJhdAubqnrG36WaAgAAakqCAASXCgIAAA1YQgAANOoCAANYaUA==
Date: Thu, 6 Jun 2024 03:14:55 +0000
Message-ID:
 <SN6PR02MB4157AD9DE6D3F45EC5F5595DD4FA2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240604050940.859909-1-mhklinux@outlook.com>
 <20240604050940.859909-7-mhklinux@outlook.com> <87h6e860f8.ffs@tglx>
 <SN6PR02MB415737FF6F7B40A1CD20C4A9D4F82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87zfrz4jce.ffs@tglx>
 <SN6PR02MB415706390CB0E8FD599B6494D4F92@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87cyov4glm.ffs@tglx>
In-Reply-To: <87cyov4glm.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [ELYwmNtWSkPSewCdjv9foDeprDCKWuSG]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB8063:EE_
x-ms-office365-filtering-correlation-id: 83167f07-7914-49cc-b829-08dc85d6d704
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|3412199016|440099019;
x-microsoft-antispam-message-info:
 W/6HmkJea+dfJB08OZTsOBTFLlIyUk0HODlZ+RJv5y21V/2InznUTAcSdmkYjyX064fpV6QYTcOWMKyoMkyhmRetnb8JJ2Ue5Atw+nw/JKyUsKePOayF2sbMStCF3qjqP9n7/smjdq8my6H2uAznEL4sRM3XoDg+uigAxfdcHkqc7cbskHJwA6BcKJaFHJ3nLkeXXrJkogTbTxq1WS7NabmMJakCLRxTMb11K6gEqBKW4QRvCXtwPwDjZLi2JKLrnV/3DTnuMytBdotVuhvJw1JzpocAxxLA7RhtOxRB74CfvxmgBeGN+PcBYeVtv/Rka8GD0UA4z4H2vaO+Mka0ZtX8bynTwY/jCeLXBfX9FR5j8fKVLREFcKFP5SHjwOi1PXoVecvQqKIgE4q/uyScTFR5j821CqnIuNmWeePyO3lrwsNTstLjixdUE1RIwAdTsFJZMuvtQBDlISDicnYltjYzzMt7+AwzXMT4jGmLF4q/Kx4sCSxFk6OxT/1a4snrSy9fq3t/93gQ42J1G/0ZA8Rj2+tceaYma+b6tegp9v84Kbe+VEfxvvvaSd5IQZys
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MeXDoziSiubnvCQwq/o9JKLOHPjy325GBSu5kzpwCIbVX+OSb+lQrQlZJNkc?=
 =?us-ascii?Q?rm1B/T0vNg9x/42nrdc75By7jyzVofTs6F/ZnXBedHguJHX0K1PUJjaHZTgA?=
 =?us-ascii?Q?SbqcAFIUPf8UwsTcG38FKx2xJAryiFreAo8Onq36wkWFlt8kVIeTA8WL9G30?=
 =?us-ascii?Q?AbKTG59tRKdInaiVYZLNn3o0e/9nigwrUTfvbx6c6Oz/z4kwmnRVGIkA3fuk?=
 =?us-ascii?Q?++dda5GxNf9WDprWnnAyTDyzB7gu7dY4y8RNOSTHF6zMdDdK0sGzaz+UViLE?=
 =?us-ascii?Q?eZxQNgONeoNZhX7EP1Dac1HQPs9bhWHyjPwCTtXuo1M/W4AfAjSbTakE9Y/P?=
 =?us-ascii?Q?HyVg5nV69h8t60zBJ+9cuEu3koZqEzpiZK0+ihj0O/wxVG6Y/WJYe15LX0ZM?=
 =?us-ascii?Q?k44nd2dLCjRrX195myDzGfUax6+L0gvUt3/7qV8hCkRKsW+TwIF+eApQR7Yo?=
 =?us-ascii?Q?TvmwXfT9Z6HnMbFcrwCgydjAPwQQ0cnOhHdzgGE374GdXgHvkJKprzFVLk4k?=
 =?us-ascii?Q?RCliG2FiY8KegYKy/Q6ImV86JB1iEU0PXLKM0PNAVCfNFN5u3C8mXIypst6C?=
 =?us-ascii?Q?oKFIdKdIfCLWDYyhKZm34VCKh4jRBCnTZT/yd4gjB/3Zwvx/8JEecYcFqiP/?=
 =?us-ascii?Q?IaqoZp7TYdaA2MgU8v+j9t9nJGg0ZyYKsr/AzUydCD01io0Oy+Zb1K6wj5Pe?=
 =?us-ascii?Q?zCMLeKP+BiDtXQOFGnEwokKKlzyi86ynnuPa8M6wT5igZCnKQPYdK1NPQR5j?=
 =?us-ascii?Q?6a6jOCTyd384caMXo25+SglmHSyqyWlm4HxdaYSgg/JNbBw3vO8ENmx2cR+N?=
 =?us-ascii?Q?5qJGqANEkcxv2Wm4IupvwSY7RnJhb+dmRx+8xaA7n8ICBQy/2nAe0VVp3m/7?=
 =?us-ascii?Q?NDJmlTZIjwMAKSQgWtqWNCFoq9s4gBa+G6TeaeGLxwDb/fEdb5q/kVW0sFjg?=
 =?us-ascii?Q?sEyZEsRTrOfdcnbc5RDm9K+1zLBLXxmVP02+7J6XYSYPd2GW3nz9laUljdlp?=
 =?us-ascii?Q?6skEbLdRw4WQ+TuFF6tKlTGQmM3MJ0fXe+NwApBzQD6dioJEGcbE+hf/bJlk?=
 =?us-ascii?Q?qgRFT6wexyluZ+O342hfwuXdOShhxWMzzIqBXrk2yE8+Tr4qc3mNLxeV4Hhj?=
 =?us-ascii?Q?1y/SojeV6ReOhU00SURV6WlbdXKCAURJj7mamOmpMmcbYYQh7nAy398J1XdA?=
 =?us-ascii?Q?Fci8SuaCBuhGKqQ6qlImSXLHhchy049QNarwZ8v7s0TE6F0vheZoYPO+37k?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 83167f07-7914-49cc-b829-08dc85d6d704
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 03:14:55.6609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8063

From: Thomas Gleixner <tglx@linutronix.de> Sent: Wednesday, June 5, 2024 7:=
20 AM
>=20
> On Wed, Jun 05 2024 at 13:45, Michael Kelley wrote:
> > From: Thomas Gleixner <tglx@linutronix.de> Sent: Wednesday, June 5, 202=
4 6:20 AM
> >
> > In /proc/interrupts, the double-counting isn't a problem, and is
> > potentially helpful as you say. But /proc/stat, for example, shows a to=
tal
> > interrupt count, which will be roughly double what it was before. That
> > /proc/stat value then shows up in user space in vmstat, for example.
> > That's what I was concerned about, though it's not a huge problem in
> > the grand scheme of things.
>=20
> That's trivial to solve. We can mark interrupts to be excluded from
> /proc/stat accounting.
>=20

OK.  On x86, some simple #ifdef'ery in arch_irq_stat_cpu() can filter
out the HYP interrupts. But what do you envision on arm64, where
there is no arch_irq_stat_cpu()?  On arm64, the top-level interrupt is a
normal Linux IRQ, and its count is included in the "kstat.irqs_sum" field
with no breakout by IRQ. Identifying the right IRQ and subtracting it
out later looks a lot uglier than the conditional stats accounting.

Or if there's some other approach I'm missing, please enlighten me!

Michael

