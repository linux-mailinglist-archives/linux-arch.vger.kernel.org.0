Return-Path: <linux-arch+bounces-4709-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 441EA8FD052
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 16:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECDFFB2E1D4
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 13:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC0A19D8BC;
	Wed,  5 Jun 2024 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Lo6vyq89"
X-Original-To: linux-arch@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010000.outbound.protection.outlook.com [52.103.7.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBFDBA50;
	Wed,  5 Jun 2024 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717595131; cv=fail; b=mmoQ06ZCF1jEzM3ULkOgzt9lKfrtGsxOIjto3NoZP/pY3856kvt4yMBALHKHZUhCFuxlWRUtnlso5l3OQPJhL+8OWNfpy9u8ZEyEGBqdCtsXVQvP3u9NfvcwWz2rwRQ+rtTniXBfXKKYlgPo8i3HmRTm2ZQWtE5s0gomdeWmH9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717595131; c=relaxed/simple;
	bh=CuMftBLQU0veawmQuLErEVNvWynYsRwOu5VEzteF+hA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QN/jl4AfJXJrkAzq8rnHIgOrY0Qi5bV1JHdr0T0UvvQJZ8jLH3qA8RhIsfVpJug8++6rX6cfI+qCH8CY6pQGWe9acXRcO2SqKKmOY0/KBx/MJF/D7BOWtzhH0KlDpcMqDOUc1w21z9yPVvUqrtq+I+GF6cXf+qI0S47OuATZqrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Lo6vyq89; arc=fail smtp.client-ip=52.103.7.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIza9N49tnvQTEauQEhRrOQnfqDVRch+O7R6K+sTSFBoA2nd6fC22y/8M8YY1Ue/Y5tlAXb4yU3f48PFWCyLksKwafU3EFOQn5J6/MInhH+YB71ajM87KYuWQdWA/z38f+9mXlrez5wFInWWSD3btrE3E0+R1AYtxgeSIjdZxJYB/n4YRbUfcKe2bDVVzWPGPhaMBpoknwGjtJFEcKytStCVQP8ycuVQZP+i/rArXWv6iSSn7f7nyupXGWC2/2iMx2Gopl/SaISuFSE5CqYuAe7ZsSrOg3Hwsm1fsjHiUtwhh885H291UXNnb7y0QqRqJCywx8okT8ZO0w4BCIMMow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zI70KYG5p+EdEKvDZJ8ndKozPcxDKCmEl4aOzuDd5Vs=;
 b=MBAu8AqM1fhRpihBxrodxnWagdlFQU/QUVmYUktRHp8bMzfcCWg+T8B7MGGIpgMKrqboxRkEycy/4tWTaZ9+YXWLE/tzX0RBjyBF67XP0TcAA2Hv+Uqxzm6LyPjn+sg49z+XXq/q4aXizZIIyPFL5p8n2OqzZDi7uxtmmVDaO3RRMQq1r7cO+NkmVRsPv0ytZWa5oE/ndqEIq7jf8vxPYXKe11cX+uej1HFW83nlO+q+rICjkhVFeIr9h5Bhael0VYzOPSX6/t6gosteVugvyCBIV387BIPAm+3NroFz06TUwySiRPTE6wamZP2JhW2e2by2mGcDSEuUptQw7B2GeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zI70KYG5p+EdEKvDZJ8ndKozPcxDKCmEl4aOzuDd5Vs=;
 b=Lo6vyq89+Fy0BXz7N/GFYt8LQj1MIdVvhIxbVpYUFUrwVIag5rqmWp5ygNJ4inuPAHnombIw3twC8jhNXe3JjBCk3sCyaWpXLt5fWwVJKp/SwwaEnSZnmMV+j3keYXvkuHNuHl1qCqHYP1YWLPBMyRTfr/vOrDD+ket98GqxOR8o3g8q2G6f1M7/DCzwVc9KL4Lhj0BWO3RbDRV2pGbkE2bNPhFP7NyndiSg/jFyD1SfEfX/JBeQN1M4G/afM0jIuF7D3OgN8B1RIHwkoLLClQI51buMZTzUwsRIDR823+P15BH+CJ4x1okjdoJQqt2Zz8Mnn7Ot7swoCx5iDHNCDw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO6PR02MB7778.namprd02.prod.outlook.com (2603:10b6:303:a7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 13:45:26 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7633.033; Wed, 5 Jun 2024
 13:45:26 +0000
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
Thread-Index: AQHatj3dxfDAEhKlmk6xJJhdAubqnrG36WaAgAAakqCAASXCgIAAA1YQ
Date: Wed, 5 Jun 2024 13:45:26 +0000
Message-ID:
 <SN6PR02MB415706390CB0E8FD599B6494D4F92@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240604050940.859909-1-mhklinux@outlook.com>
 <20240604050940.859909-7-mhklinux@outlook.com> <87h6e860f8.ffs@tglx>
 <SN6PR02MB415737FF6F7B40A1CD20C4A9D4F82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87zfrz4jce.ffs@tglx>
In-Reply-To: <87zfrz4jce.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [c5RCyg10DGYj8/LCV2V0ehx+fX4AEBm5]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO6PR02MB7778:EE_
x-ms-office365-filtering-correlation-id: 7b239599-1894-457a-fddd-08dc8565c167
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|440099019|3412199016|102099023;
x-microsoft-antispam-message-info:
 oO7k70hU1YyZ931NE0N0rccAKGPQcwBxIkI8bIbdln+e2chlJXMCWg/TLkFnx5Ya3CDkklVnItKlpms72LZeQGSPX5DbyHPChboXsJFAP2HI0jtMj4+FFtyIyMbzC7qYWtYTlcBJT5+AMji+WBMhqJ33RWxQ0EFbjdJJJYc8CU378FgQEO9fJTevIIOemzLeyFi7wWRRjkkOQVrvAxsW2GOjO1yG5KEygECdWm4VFK4d7F7c/8uPTA+hvZqNQ8oPo1O38LMmsyuKf0O9BKHp++I/QUUUEiUlmzWR4N3IzMukpmz72Cqa/lW+tm14IJZDdXQ/diyE6QTQmqxuKJALB16jLqM8uXm908I/djw6wJATS5zeVlKT9kPCXOJ3PxTMLRHbj/2Z4yduP3E9oihSKB9qSgPcJ9r9803pwBhM1yYVgvWfcSVMjNDB85a5Y+GCyGlbIP1L+oIAe9TgMRVHra6Z0A6N2jTKIkAxtdMvPPlXM/byAm7fZCNJwYH/tbONiJtBL0zqaaPPNUWjetKajBjK/Z6B7+k6ziGkQWe/THqEILYAeLV2TZhl4hE9zZ8G
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?katvRQVerasrzsGDz5nbYaZpD0OLhUMZ1EDzoT6ak6G2q0wd12OHW5QazrYH?=
 =?us-ascii?Q?DJn686n4LzIBSyoQqaut4MQNwUV083rJsmXEHfHARow1O8uvNF84WUL8aB9z?=
 =?us-ascii?Q?JQcJr7HNi67wiJ4x5jjoRwdUoi69YhgnceMMyJeozFK0Tk1p30L2SdHIN+bJ?=
 =?us-ascii?Q?XOgIt+432VEdMOIH4tFX96UNExBg2MszOrJubznmo8DhigT5+zgoUQqEgljU?=
 =?us-ascii?Q?AUDr+kYZ+22Hwwo1Bf9rVB+fXN79WU9hnSSnfOaneHAe44K4JsXpESmbX6yX?=
 =?us-ascii?Q?raYSJK7cPhpIhLzbuoGE7RaPYLwT9jBGTVPQz0GKRgn03OKUT4cl8gyS+qNK?=
 =?us-ascii?Q?bnq/PSwUV8lUpJaW9cycQQeJUx046A4XVNBdZOgktxCK+wXKc2EfmWQZxL0Z?=
 =?us-ascii?Q?KgAFyKCLO50DDGFy3cF73M4s2SBtTn0RjJhN4yKaZhYzwqGaTVF/DLuoUS85?=
 =?us-ascii?Q?oMzuumz4WoXVe3a+VSmSQjUEwypDu/AcdsxFrhnd4Etir3zDz0sXmybgcd1L?=
 =?us-ascii?Q?/cRvcmsRK5YIltTdOZJ2qm8ys5vqSX9eHI7ynSVTRisQ9z8RlpxOYSG0d3s4?=
 =?us-ascii?Q?vceTSLkQKZbCd4gxFYmjJ7X72XYwKogQF4gjJfDHnNIwlFthSXTC2C7ni1zd?=
 =?us-ascii?Q?b2fWdMA2J7me8kml6lc8Uizdk8UNf3qjdbgLa814l3HplSSu7L2budM+62bq?=
 =?us-ascii?Q?W5ErUG1g1FWV2IFu2JI1SRw1WVq+d4dKtWit50lR41UL4v3comT8MT222JrB?=
 =?us-ascii?Q?HoZPz1wXd3nrFhFkSkm258sROJ2T6b7+tFJKsiw0U365AceWrCvHBzQtOiVS?=
 =?us-ascii?Q?K7gq+0PCUykrvKIQpkH1tDagHzk92hIW9an5oNAt3FhNzvXJM48fPLEDVtJZ?=
 =?us-ascii?Q?cG1R+Sm0qSj4KlJOSYGzMuvrugH7Y/y1xmoYuKi/T4Gs4HdC24Ef3rerQfJm?=
 =?us-ascii?Q?LctWhxDYxATvzoVS1kYZcFSJW1y0208GatFwNVTUDhd7o16CtmfPxelfIjUi?=
 =?us-ascii?Q?/VtmwOfqNacE1fWU+KfONPe8rER/apnqQ6mMY9QMsP2Mcgq9x3MDuCVS0EtY?=
 =?us-ascii?Q?PsysZsWNEcrjTZjvLot4/ahS+b/nOPotXSEMLZaIUlaXCW6VMJEzciz5D2kf?=
 =?us-ascii?Q?uW/Re55ycLCh6LQnRj/saj8JKzLVSOz6V4x+p5cx3tVymzGn3MEdlnGGG3Fx?=
 =?us-ascii?Q?Qf+9V9/kvNPycLDkqdRLcBSv+Yf1TlEcuQHW8a/7l6lR9NmO+IYP4CvhC8Y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b239599-1894-457a-fddd-08dc8565c167
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 13:45:26.2729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7778

From: Thomas Gleixner <tglx@linutronix.de> Sent: Wednesday, June 5, 2024 6:=
20 AM
>=20
> On Tue, Jun 04 2024 at 23:03, Michael Kelley wrote:
> > From: Thomas Gleixner <tglx@linutronix.de> Sent: Tuesday, June 4, 2024 =
11:14 AM
> >>    1) Move the inner workings of handle_percpu_irq() out into
> >>       a static function which returns the 'handled' value and
> >>       share it between the two handler functions.
> >
> > The "inner workings" aren't quite the same in the two cases.
> > handle_percpu_irq() uses handle_irq_event_percpu() while
> > handle_percpu_demux_irq() uses __handle_irq_event_percpu().
> > The latter doesn't do add_interrupt_randomness() because the
> > demultiplexed IRQ handler will do it.  Doing add_interrupt_randomness()
> > twice doesn't break anything, but it's more overhead in the hard irq
> > path, which I'm trying to avoid.  The extra functionality in the
> > non-double-underscore version could be hoisted up to
> > handle_percpu_irq(), but that offsets gains from sharing the
> > inner workings.
>=20
> That's not rocket science to solve:
>=20
> static irqreturn_t helper(desc, func)
> {
> 	boiler_plate..
>         ret =3D func(desc)
> 	boiler_plate..
>         return ret;
> }
>=20
> No?
>=20
> TBH, I still hate that conditional accounting :)
>=20
> >>    2) Allocate a proper interrupt for the management mode and invoke i=
t
> >>       via generic_handle_irq() just as any other demultiplex interrupt=
.
> >>       That spares all the special casing in the core code and just
> >>       works.
> >
> > Yes, this would work on x86, as the top-level interrupt isn't a Linux I=
RQ,
> > and the interrupt counting is done in Hyper-V specific code that could =
be
> > removed.  The demux'ed interrupt does the counting.
> >
> > But on arm64 the top-level interrupt *is* a Linux IRQ, so each
> > interrupt will get double-counted, which is a problem.
>=20
> What is the problem?
>=20
> You have: toplevel, mgmt, device[], right?
>=20
> They are all accounted for seperately and each toplevel interrupt might
> result in demultiplexing one or more interrupts (mgmt, device[]), no?
>=20
> IMO accounting the toplevel interrupt seperately is informative because
> it allows you to figure out whether demultiplexing is clustered or not,
> but I lost that argument long ago. That's why most demultiplex muck
> installs a chained handler, which is a design fail on it's own.

In /proc/interrupts, the double-counting isn't a problem, and is
potentially helpful as you say. But /proc/stat, for example, shows a total
interrupt count, which will be roughly double what it was before. That
/proc/stat value then shows up in user space in vmstat, for example.
That's what I was concerned about, though it's not a huge problem in
the grand scheme of things.

Michael

