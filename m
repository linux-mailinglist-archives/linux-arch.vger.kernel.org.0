Return-Path: <linux-arch+bounces-4694-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C07A8FBF88
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 01:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1A5288A26
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 23:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA62314D430;
	Tue,  4 Jun 2024 23:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FPd8n2ie"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2088.outbound.protection.outlook.com [40.92.21.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED15A1411EB;
	Tue,  4 Jun 2024 23:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717542212; cv=fail; b=szxcglHDH66ArHFsZw2gqej0UZ283X9axWZfcJ4+eTtaLV7KKC/uAnQ+lb4K0TnF1SXGUf1BR3XXqw3cf+BVbNFwBiARoXCKkHhcznv++GKp2bhrR6Xu88ElZlWvZD6BDaNVyvabN5qG/D8kWWGkRbnHpt1T68Raew4s536Syi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717542212; c=relaxed/simple;
	bh=4u/o1Vts+nbND6lbMVzDMz8NUsR/XbZY/5kXwuhzW+Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YuUUQRnbe289kvF7n6rAAcV7OUM2CStfrmNIPsriW7W+rxi++cmK06EvbyJ0JJyvkpytpSXSkSXz1hhI1WibRwPYrVlm2zcUMxX7CoMqc5qI2sBXVLBOf9yrKjxgO9zafXHwd8w+jj/T/BrzTdJyCMLD6MaWXb3WJ8QtN8GCMWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FPd8n2ie; arc=fail smtp.client-ip=40.92.21.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaKYgobl7udEgGYF/paue7xVFbNoxzLaENhWSFv6EJIcm4ZT6nI5mIzckzcS/IbeO7oo5iV/3h4rjbT52dy4YDz2JZfgvzxxfHUQ72mfhykxfJkE9SjCg3Jn6VpNPyFx113A2IuwMIIKoOF8hlPywrfNwlZu7OCloAmWE+m+m6m4djP1H/PBHpLlYr0HiLkVFBH8SZDVgyI43dhpBwutDGEDj/X5lyX3AM57ARGc/WuTm3VUp4VZZavBl+uHn2UeFMTZStOTSkLaGcDKIX7JhLmQ3YAIiAO15gkiupSzQOGLiifEmOzPD5YU45DHNBKyEjTkT5cLui6EiFBqpC67ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3s41lGxCLQMkgfS9DMUrly/lJZUhNNPUsLcGM3Tysk=;
 b=dUDq+RY0DGzFN6D/VbRR2tpcdj1cTKCGj+HXYaTYLNCri8I7Vi8fTcQNh8LzfsBAwpRg0/tHsKiglCRcXYa5ibLXgONmqljBSmXV1uP6ffZO+MI+mLUKm8ll5O2bbaN2IoEZKRANt3lGkH0OiUmqftsGnwR3j5lkpb7SVS25KI+m61DSlnrEIbxiJr9WHpqVzf8obO2h7Ui3RxgYCsxpBh6x4noyDKcBcwGrhTscdH+N2p3FXXvR3h9mUgW3zcXg0nJJc3jCNF59MncGltXcBOO5k9c1lKS3P9QG8q4tHYV02EFJLsz5b/q0K1dN3j/VyCa6kmfEb9MftrwzI4cf1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3s41lGxCLQMkgfS9DMUrly/lJZUhNNPUsLcGM3Tysk=;
 b=FPd8n2ieM+Hi36huroahhUtsPQi8jJPQHmRL2YD9HPlIolD8H4DHhxQMO2if8huAME7myMuEJFC/5owkrKFYaYO6LsHBDV9YN0v+fCKMYy7LvBPnq1diKNFWx9ybZ/4+9yml3BCb+/7hMLyCOiZd+kluDVtpxlTgk0R8a7lTszJTJxQlisRK5viGyBhrLewo8fVwXmCVmBObfN8LG6/SCMRJfHgYpv0hziHIKixHwk7UjeCGrJezaBP/+y6Ie0SksrXP3mcgWTNTMWgt2dFaPtic0vlTrsmIJQdI6tCOVp0XYD/UrpbNgiEZe6QlVccFj9Iy8LnsdkUxFHYrJx56qg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA0PR02MB7305.namprd02.prod.outlook.com (2603:10b6:806:e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 23:03:28 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 23:03:28 +0000
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
Thread-Index: AQHatj3dxfDAEhKlmk6xJJhdAubqnrG36WaAgAAakqA=
Date: Tue, 4 Jun 2024 23:03:27 +0000
Message-ID:
 <SN6PR02MB415737FF6F7B40A1CD20C4A9D4F82@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240604050940.859909-1-mhklinux@outlook.com>
 <20240604050940.859909-7-mhklinux@outlook.com> <87h6e860f8.ffs@tglx>
In-Reply-To: <87h6e860f8.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [TzkLggcP4FUY+p2DXFdqqGDD7x3eEtGy]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA0PR02MB7305:EE_
x-ms-office365-filtering-correlation-id: a864ab32-a865-4faa-85f8-08dc84ea8b9c
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|440099019|3412199016|102099023;
x-microsoft-antispam-message-info:
 r+0piGp8TDQBw/V5mGAliOdPzLWj8/Ou04wQ65eApWTUhoSNEbTuuRWywn3RNJ2MC7gboZHzNc0SI/SDPbqBShjuprAI+lf0V965fUvBKno3OfMCDFSCoT9QFDnm7B1wQdC5C//AXaCBp5bh3xcI4E7OOpVOpX5g4e1W7bWaCsJ4g91sUgavHZmuUb5yJysEToEBzxHl3MoclDPPkU+W6ZMM8ZtHVTOjYYF7YYlCnDWVhaFlzxKCm02bYlVY2xc8H8vuWIVM9itTJIUIsZKoYK0w4xeP0tuV6YZnqqT3Z4lypjznEOIA6juWPTGXFuQZMIBnYqyd+vcKm1Mf33tCtgCGQX9jpBjrd2m2cTKRqUn8I96s8PTwfV48SQjz/uJf85QBddCrkOyaiOrdZ+UOLsVuiFMe0+ugq6bik6qgWd8x1JF3e7MEuJx34xVPZJZzWMIOjEDQ4gy4Rgt4AX6lTjdQI+k4wHi4Vu0EIx5b4cAJrrRA3/CbusIzysG7X5ct5zWgDTnUfKCMbPj4tzy4qgA8eFIrMwQ7Zmmrs4IY2EO+frHgInHznUqifU2C9iLZ
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7uaBgRBxuEYxKYF/dTcbRD6OHZ5b4h2bRZWxIADOTUCSJ8LU9hgca8criqSf?=
 =?us-ascii?Q?viSanDcRiksbT9moiBKL7zjb0nDeXisBRdpLRNtUuLesAc+3laNSybzd1cSk?=
 =?us-ascii?Q?neDDS770wgQ1vZL5UZGJbo2rGmTKvj/VXKzCj9rSx/asatn6JE8nC+BaxsoW?=
 =?us-ascii?Q?f6oT6qNrwZ10wvevSeZxeKdCUO6Dk4GFyqRSR9gtOV07OGu6VvgIAOS9uvUM?=
 =?us-ascii?Q?e3bkCR6WCbMoHTmxx02k4eAudSIXAzSE/kY59zZj9Rcqbi08MHo2FlkB0nOw?=
 =?us-ascii?Q?4gED85a0EWjlYISt82kykjz60DfCgY1sFxF6BacwrmBJnkWvQVPkkO+/Ulub?=
 =?us-ascii?Q?F7Jhi2dwkpKd35c1DJqTkINz3FMumqzjTkHpA88Ip1alyMgxqV2J6sU748W1?=
 =?us-ascii?Q?2ltlnn0TDCyDb2VTBI/h5j3/kNlDUG3ro72EQMT3jAcofYMkXiDKrEXJuoRU?=
 =?us-ascii?Q?6Fx/ch4sVP4GjTN4nrzMJ004DUYXrXE6uyjYWN0JnSINfSdsznyHBRL4IrC1?=
 =?us-ascii?Q?mv60exDDf17yoP0J+kZZeAbC7o6acJ0lyHoeXbdYXlB29ZGOMyKbLOMg3fNc?=
 =?us-ascii?Q?Isgi9GbjoZitBALiKCuzklyWD+NxSCbvWTrAHeR7i6LU267LJoJPAb3pH1BD?=
 =?us-ascii?Q?LTdTVwhwU3LAyp7gk4Wx3D7o6UB2ZIVmytpXVvRDMYJ2iR9FBC2dnDl1XVIG?=
 =?us-ascii?Q?r/nl26tpiqt+t+vbjzzvnBaRVzsfMHTAP7kfpE4woeLr8ipSU4VCYHEPKUoE?=
 =?us-ascii?Q?VHB8lNDqvt+8mfRzWr9EDP0yxVyrdgbT6w6aGGzNdNUgBfoBdFwHPEC+jaBg?=
 =?us-ascii?Q?yRNP9Qf5LjzcP3yaIxxNjDRAzSWfinVZwzzkJjfhiZNtHO6X8OKNaCSBUGQ4?=
 =?us-ascii?Q?6QRwIkJ6RsEQDiLgRjVJhrP0o5WceRO3zEoMVBc+sLhAyxL6Y9MMu8DDLPt/?=
 =?us-ascii?Q?6MlsiMowBOiRW2VdtRXvo6XbOgUNUX3RXLSJBbzND7xxklPYc8bNU0KXtpBE?=
 =?us-ascii?Q?C70XMCTgoYdtUmDGKEecDAKEQxa2+Hb9kh6F1//fji9v7U3ptXs9Tm+kj789?=
 =?us-ascii?Q?M3GrGfPEWGMXNpSKv0G6/dc6mRz9mX278x+pkCIY39kWBPsSpAOI8bgaOfBG?=
 =?us-ascii?Q?AioUrh7CNPSEnwGv3akddvEI/q5ZU1ZJAzhpNhJ7J3JciNCWDoLixWD1uney?=
 =?us-ascii?Q?cMx746moGKx/w3qkzPFe4tWoW/WBT6LgYChx7Lu5znHPz1Y0cwdWRyqHQA0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a864ab32-a865-4faa-85f8-08dc84ea8b9c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 23:03:27.9074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7305

From: Thomas Gleixner <tglx@linutronix.de> Sent: Tuesday, June 4, 2024 11:1=
4 AM
>=20
> Michael!
>=20
> On Mon, Jun 03 2024 at 22:09, mhkelley58@gmail.com wrote:
> > Hyper-V VMBus devices generate interrupts that are multiplexed
> > onto a single per-CPU architectural interrupt. The top-level VMBus
> > driver ISR demultiplexes these interrupts and invokes per-device
> > handlers. Currently, these per-device handlers are not modeled as
> > Linux IRQs, so /proc/interrupts shows all VMBus interrupts as accounted
> > to the top level architectural interrupt. Visibility into per-device
> > interrupt stats requires accessing VMBus-specific entries in sysfs.
> > The top-level VMBus driver ISR also handles management-related
> > interrupts that are not attributable to a particular VMBus device.
> >
> > As part of changing VMBus to model VMBus per-device handlers as
> > normal Linux IRQs, the top-level VMBus driver needs to conditionally
> > account for interrupts. If it passes the interrupt off to a
> > device-specific IRQ, the interrupt stats are done by that IRQ
> > handler, and accounting for the interrupt at the top level
> > is duplicative. But if it handles a management-related interrupt
> > itself, then it should account for the interrupt itself.
> >
> > Introduce a new flow handler that provides this functionality.
> > The new handler parallels handle_percpu_irq(), but does stats
> > only if the ISR returns other than IRQ_NONE. The existing
> > handle_untracked_irq() can't be used because it doesn't work for
> > per-cpu IRQs, and it doesn't provide conditional stats.
>=20
> There is a two other options to solve this:
>=20

Thanks for taking a look.  Unfortunately, unless I'm missing something,
both options you suggest have downsides.

>    1) Move the inner workings of handle_percpu_irq() out into
>       a static function which returns the 'handled' value and
>       share it between the two handler functions.

The "inner workings" aren't quite the same in the two cases.
handle_percpu_irq() uses handle_irq_event_percpu() while
handle_percpu_demux_irq() uses __handle_irq_event_percpu().
The latter doesn't do add_interrupt_randomness() because the
demultiplexed IRQ handler will do it.  Doing add_interrupt_randomness()
twice doesn't break anything, but it's more overhead in the hard irq
path, which I'm trying to avoid.  The extra functionality in the
non-double-underscore version could be hoisted up to
handle_percpu_irq(), but that offsets gains from sharing the
inner workings.

>=20
>    2) Allocate a proper interrupt for the management mode and invoke it
>       via generic_handle_irq() just as any other demultiplex interrupt.
>       That spares all the special casing in the core code and just
>       works.

Yes, this would work on x86, as the top-level interrupt isn't a Linux IRQ,
and the interrupt counting is done in Hyper-V specific code that could be
removed.  The demux'ed interrupt does the counting.

But on arm64 the top-level interrupt *is* a Linux IRQ, so each
interrupt will get double-counted, which is a problem.  Having to add
handle_percpu_demux_irq() to handle arm64 correctly isn't as clean
as I wish it could be.  But I couldn't find a better approach.

Michael

