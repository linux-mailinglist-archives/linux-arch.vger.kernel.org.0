Return-Path: <linux-arch+bounces-4728-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BBF8FEFA6
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2024 16:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B1A28C4B9
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2024 14:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A895D198E66;
	Thu,  6 Jun 2024 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="N/X3fMk7"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2090.outbound.protection.outlook.com [40.92.45.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BBE160883;
	Thu,  6 Jun 2024 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684446; cv=fail; b=F71KJldz7ftRkgzO2PAN+sc1kedYOmikJx7Kn7dkN/JkyB1PHxj3WVdIuN/6mTw8U6/CZAuwxB+WL6kPmYSNrCTtfO06snEUUvWUp50dHPSsdOGuPbNp1qwCl9iAwl+UhyO4+mBXvHrPcDXXID0WEp1o9QlxMIV6y538IkRB4cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684446; c=relaxed/simple;
	bh=gMVkn7exBguDrQzfrx8Lc3CjG0F47p/wCGAiveRK2wY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HFdQEyeU3EUhq1nwNq9Vvd061wDbATVzjaEZX64d0/9Tuxl/pJ7h7E5gBg4+JFAkh7RxjnZxJXmaWzR6/eLLlrwdmwUvCuLTZ8nPPPzD8e63PCHLTxdZdSocB6MLC8I859VYMUb58gfIOYl3lv2BSkLnkkqkqtwAY7atk+Gfpjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=N/X3fMk7; arc=fail smtp.client-ip=40.92.45.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5jLG2Mw1eoLgEtza3qU8rkmS3XbZ7/6CW78yi7t+CdLRWAcFmFZd2uFBKfCS7vtPq2lQJHV56UqXsFksg4m6Olw7SGk6CVAjkFZEjZe/LOKu9Al3o5oZ8GO7OcExehCDvfcFtyw7A1rJEjsa84o6ytYMRtFmqqYe0eo8CqnMpaLHqP15coCjDYSs1mGAU2CqXImtCcW/i316bCMiWoGM1i1u1Rk8tGynnB/5QU7qu8hW3tfwnHjkMKc7QE2DFOXfBnw46MEpbC1w9BsE06BebfHVU0Kp5x3NnXFCg9P17BlkTNy32oMUhionlPOmD8yeOcBm4ng2xcH8IS57IHnnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLgP7/3wPPZoTnj9QPcPjIsz3VoEMuCUQ72A1hyO4Ag=;
 b=fHz1R/LsgHVyIJC+K/qks5D11l8bW0jVlB2sXG7hKX9qR5qwNLdtSRfJHySrHcqMmsW/9Bgsxt+DLFUtm/DWm4zRWfmXBTaq/KunMt2Xa7QPD4oL/gEncQvBjC2KeZ5CdYmwpFOXiZ4urYls14Vo9Ds5N7uamI/QlRopapJ+kzG9S5R0U5WAd8+nnv6er3WRMxq7pqAWIMwh4dWY3RBGeUuGfNe0hVXG/4Qx1I0+7eXsZA1KQZJqpHO+PZBMXmdF9/6AuuDPn4NRJIxiLwMpdA+JvdEUjUrHnoF8exaGqn6c4sOs2CXC8zjgtMDyWCUx4Uq7Gr2fLJxWN3TWeMEPZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLgP7/3wPPZoTnj9QPcPjIsz3VoEMuCUQ72A1hyO4Ag=;
 b=N/X3fMk7RIAVV2ODN4+2UMQHtMU/kibb3wBC1Ra/kAjFFLG81iF6I+L4coNaNl5gr0i+NnWV+sfm2OwPRwdduPlTKOl8H+etsjP+8oT5ukhLLeOl2L6V1ZtNjNNWS8kG/+StjA1EIAcYxKG2lC6+AZkZ8bWvDb9D5djLWG5jTmU0JioUnDRtRwn+Xc3t3ulBetGoJ9fa/CFq8Nqar1NaK7R84tprCo78e4pyF1sBFvD0OYihv+irnGDL+TD56SCpLVYGrX4/uniFQ6oIuU0b/dqM6ObzTvMQC333gDG7Gwe5gU1sTiK0bI0jsYl1UAJO6JsRgxRgy7YXvqB32q+Tww==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MWHPR02MB10499.namprd02.prod.outlook.com (2603:10b6:303:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 14:34:00 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 14:34:00 +0000
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
 AQHatj3dxfDAEhKlmk6xJJhdAubqnrG36WaAgAAakqCAASXCgIAAA1YQgAANOoCAANYaUIAAbHaAgABQ9bA=
Date: Thu, 6 Jun 2024 14:34:00 +0000
Message-ID:
 <SN6PR02MB4157A4B5C6726CDC369E0E39D4FA2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240604050940.859909-1-mhklinux@outlook.com>
 <20240604050940.859909-7-mhklinux@outlook.com> <87h6e860f8.ffs@tglx>
 <SN6PR02MB415737FF6F7B40A1CD20C4A9D4F82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87zfrz4jce.ffs@tglx>
 <SN6PR02MB415706390CB0E8FD599B6494D4F92@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87cyov4glm.ffs@tglx>
 <SN6PR02MB4157AD9DE6D3F45EC5F5595DD4FA2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87le3i2z5g.ffs@tglx>
In-Reply-To: <87le3i2z5g.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [d+msmNnIa85of4nq8LDjE4iLpC7KwlZq]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MWHPR02MB10499:EE_
x-ms-office365-filtering-correlation-id: 097fac48-51c7-4bfe-0110-08dc8635b4a8
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|3412199016|440099019;
x-microsoft-antispam-message-info:
 XHhuoGoTDrBbJJ7mNJG3ijXmBsFWNaSqR3A9ad+liIHaJJthbRFjp0b7iNH/mGAAW3ipNB/f34zBwMfVknbzYMJf0h/E8Cl3Nd4a57x5UYHXIM74Xy9sh/uxr7ztTw+6/Ec4AWsxdaIh16gdRWt3iakyxoP5OBHjjVsz+D3B5GF4A8D6L3T3ZqwtwGOEpSwK4Awo1MM5kAaLPUakW/lur2Gw56esEKkjT3IM23Jqx0vP7VJJQ575p3waksxRhK9SmBzfi7qDG4VmEtOUlX4rC9XJykCNPVa72l8mSLUx/XEkXY6HySNtTT+hMnyhoctHpl9DI3qnNEXwgcS/yXAW9M7yZWHi7yzGOsmulUVRMqp0VsE0Wzpeexw4q+vlxMT82HLDVpc0Rk84Do91exblK8NGWP7zQHzci/SLNElNyROjhTUiRxtFwqw1zx06TV3vcPGYtJxq4xMsJ7jJNHbKWyOageJBuxpwo5MrfBIRilNWpByBxd7l7RmxGH8uK5lt96ulfXMxItqibQ5U0BFP0IHlbD/VxrqBjFua1SNqmK8MkmlbUuVBBuIZmtZUdvfY
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xl3g7G3e/eiA2yR1BvRD7lD6AbvXDsmNoBPgGii+ushopAYvguaQSJk2GwAP?=
 =?us-ascii?Q?rUDhdK8fWwDev96S6nvVHi8CZNEQYehihCbDjA6PsqMajZlmMD3TD65qUImd?=
 =?us-ascii?Q?uM38HMhngVl0NNQTw660UsnkEDfNWfLGUdpB/W9g9HYRKD/VuVeiFHcGTAkD?=
 =?us-ascii?Q?mVMxS1MC84gx7q/S5ecYlKJzp3zByCQpZYgrPf2ISodGLqlPsa/KHUl88SVF?=
 =?us-ascii?Q?1ENgnRdIjyDiC9nlhT/RMIJtdcSVUz4fMTrMx0Fx03U4XlurbdlvqYxrY0Yo?=
 =?us-ascii?Q?W8ZssUCeI4p+Iqohc0W6gZuf+7jE2SscgKtDf9mI0vcX8JRgLzrVQ6wzbl3d?=
 =?us-ascii?Q?KezhSYyMRr31X7F9qtNJE0eXRShyNeDlEfY5AchGhqtJQRPIDfJu5TgjB1oE?=
 =?us-ascii?Q?SQKSVvjNadoj/Hk5U3TCQDNaW6EtMnfOTH+OI+pOmN3GeWiLdXb3pxzPTEFA?=
 =?us-ascii?Q?43ZsbylXxe9M0hDq4IQd/spkCsb1eo3nGvN2oSD5HctRLhn/DUQzJkswhlWG?=
 =?us-ascii?Q?cyVXGWQ+Rqigk6u/PkEtNSkPg0ZdDRadg4lipqYG+J8QRWcp06ohq9MZhPok?=
 =?us-ascii?Q?ezkRi4JRJbMktP9Mdhd/p3FP0Op1ua9eU3FfGu5MrvRsSQxyvAm7HcUeTIs6?=
 =?us-ascii?Q?sF0UYjMZJbwio7wYjoW5I4ubOvAkf8tYLFDmSAE4iJPE8ztwDNAlXo5UhqCY?=
 =?us-ascii?Q?TUElVVMN4fVPewJzgCaA9fyU+FsTXX71vOWAH8QzUdgU3IM5ukXGv6+54igW?=
 =?us-ascii?Q?rQWy+2HeepftAcX2oyspw3XbYjGDVBeJe0m27FTrVTwCBu9zaVHE8b/cNVFm?=
 =?us-ascii?Q?oKdY/urrwCIOkmL7vaIiyqwT+PojHubl8+1FDw1kCYhfO7RhwjLnQEMpugSy?=
 =?us-ascii?Q?cJIEdlfJjQ8IHxTxYXcPOQPqkpILVeyvBaSBBsLDjBmgxpeTaj+cqd3TKSJZ?=
 =?us-ascii?Q?RhdcsBTFuIz70Gzpj8jxrURpspI6DNRLNDWV6Jyv7aO+Zdn4oRmGyh+/U2g/?=
 =?us-ascii?Q?KxUpLWbvt0kbnQI+l2o37WmWCUNVpqkMffXk3oamA6rsKgfTTVuEK4DyRdxk?=
 =?us-ascii?Q?jtM4p+FnIa4jOg+OKbubJdnA0pQmbl2gFStgtJBT4Okb+aUiQo8f0dOAgjsw?=
 =?us-ascii?Q?foWEfg84yBKxFVNA+U1ttcKHzgkSbpMcBbiVV2qZBKtJXlh1OBhAY7DaDfdh?=
 =?us-ascii?Q?7lTIM74hreCo6SJ1qzkE7ahYa/JhCiq3KEfXHQvyp2ht9G8Q8dXnXT7SnZk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 097fac48-51c7-4bfe-0110-08dc8635b4a8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 14:34:00.1699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10499

From: Thomas Gleixner <tglx@linutronix.de> Sent: Thursday, June 6, 2024 2:3=
4 AM
>=20
> On Thu, Jun 06 2024 at 03:14, Michael Kelley wrote:
> > From: Thomas Gleixner <tglx@linutronix.de> Sent: Wednesday, June 5, 202=
4 7:20 AM
> >>
> >> On Wed, Jun 05 2024 at 13:45, Michael Kelley wrote:
> >> > From: Thomas Gleixner <tglx@linutronix.de> Sent: Wednesday, June 5, =
2024 6:20 AM
> >> >
> >> > In /proc/interrupts, the double-counting isn't a problem, and is
> >> > potentially helpful as you say. But /proc/stat, for example, shows a=
 total
> >> > interrupt count, which will be roughly double what it was before. Th=
at
> >> > /proc/stat value then shows up in user space in vmstat, for example.
> >> > That's what I was concerned about, though it's not a huge problem in
> >> > the grand scheme of things.
> >>
> >> That's trivial to solve. We can mark interrupts to be excluded from
> >> /proc/stat accounting.
> >>
> >
> > OK.  On x86, some simple #ifdef'ery in arch_irq_stat_cpu() can filter
> > out the HYP interrupts. But what do you envision on arm64, where
> > there is no arch_irq_stat_cpu()?  On arm64, the top-level interrupt is =
a
> > normal Linux IRQ, and its count is included in the "kstat.irqs_sum" fie=
ld
> > with no breakout by IRQ. Identifying the right IRQ and subtracting it
> > out later looks a lot uglier than the conditional stats accounting.
>=20
> Sure. There are two ways to solve that:
>=20
> 1) Introduce a IRQ_NO_PER_CPU_STATS flag, mark the interrupt
>    accordingly and make the stats increment conditional on it.
>    The downside is that the conditional affects every interrupt.
>=20
> 2) Do something like this:
>=20
> static inline
> void __handle_percpu_irq(struct irq_desc *desc, irqreturn_t (*handle)(str=
uct irq_desc
> *))
> {
> 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
>=20
> 	if (chip->irq_ack)
> 		chip->irq_ack(&desc->irq_data);
>=20
> 	handle(desc);
>=20
> 	if (chip->irq_eoi)
> 		chip->irq_eoi(&desc->irq_data);
> }
>=20
> void handle_percpu_irq(struct irq_desc *desc)
> {
> 	/*
> 	 * PER CPU interrupts are not serialized. Do not touch
> 	 * desc->tot_count.
> 	 */
> 	__kstat_incr_irqs_this_cpu(desc);
> 	__handle_percpu_irq(desc, handle_irq_event_percpu);
> }
>=20
> void handle_percpu_irq_nostat(struct irq_desc *desc)
> {
> 	__this_cpu_inc(desc->kstat_irqs->cnt);
> 	__handle_percpu_irq(desc, __handle_irq_event_percpu);
> }
>=20
> So that keeps the interrupt accounted for in /proc/interrupts. If you
> don't want that remove the __this_cpu_inc() and mark the interrupt with
> irq_set_status_flags(irq, IRQ_HIDDEN). That will exclude it from
> /proc/interrupts too.
>=20

Yes, this works for not double-counting in the first place. Account for the
control message interrupts in their own Linux IRQ. Then for the top-level
interrupt, instead of adding a new handler with conditional accounting,
add a new per-CPU handler that does no accounting. I had not noticed
the IRQ_HIDDEN flag, and that solves my concern about having an
entry in /proc/interrupts that always shows zero interrupts.  And with
no double-counting, the interrupt counts in /proc/stat won't be bloated.

On x86, I'll have to separately make the "HYP" line in /proc/interrupts
go away, but that's easy.

Thanks,

Michael

