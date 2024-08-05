Return-Path: <linux-arch+bounces-5970-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C35E3947C99
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 16:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45BCD1F22BBD
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 14:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE8E137750;
	Mon,  5 Aug 2024 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="q+A31pQZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012057.outbound.protection.outlook.com [52.103.2.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25401139CE3;
	Mon,  5 Aug 2024 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722867181; cv=fail; b=Cc/g3q4bqGpli9ve+O1ldH/mAiM7KroycOmGAcmO+2UHBCtF9FIBiYUOK632YnRvRKmlAKwZtfEGZGB61v+rkevqO+r2SxG/KdQTnxC13nBXmVwvjWs/DGH0DVhQydl13O8oXzVknPF1jq8M4HTJWQcRata+os9Ox3Plx4iEJKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722867181; c=relaxed/simple;
	bh=q+Qlf4d/CGHKsuy1HT2+74gMu2UmkkiGr2bNk3UPs28=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mD4XHJtK1NYbKs9zmeaoYlcqi4/p5rDq2X6DbbBubTJEvG36CJri8wizn3z41nPBW8piF30CRsQ0TYO8NXl3dmFAKaHIeH+WO5RATrUEJyGVEIrMWtoboy0zVRAwA73VwQtpWdgauQVPpczJfxn6lm3ujLs3tcjklbkofY2+jiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=q+A31pQZ; arc=fail smtp.client-ip=52.103.2.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTpbertyn2Jof3Z57/QXUyqLWhsaMjT+4+9Pj0n31ZSCXQH8J35BShff3A5RjXxwO7e2szAbn2TFl40i61IYvw+DRv8ngQNdluYj8VgdMVGusKgJoAWQ4ruNjAJKWgjRl+QEOJf4MBYZ3d/7jQPe4QFHYJkSjXnTZ7fI4Z+e5mQBfyrI24xSUzo0DM2kPAfWElLuvXYontD51G/apKtczEnQOPECEeiY1RKHK0yz77/+vwiMJQzJ3r9lGTW5LWFDVieSqvrfj1+fx5NsXGH+viZZwabcdsQnyO2oTO2wDvqYQ9Fsa0CwrtD/G3Jak6lY7jpaWS1x9gQUSdHLqNi1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+M04b7BgIER6F7iCEgjrg2kJ6k+WAI7Fg3Jx/fAhPs=;
 b=Ltz2VYeBpJ31oTs/EtwM7I6Sar3mO/Pnc4xfdmrm2UMa4Aky5Fw4PqmmdlTYbNAfbYHZmWrIwcmLSvrubhIEGWOkJCo0OgbKsJsqJdTUZ6k2OKh/kSk/6MIRDdFy2bdzUsTgA0eb11a371HgPA6m6enrRg8/u5tDFPYTAlKJjwytqY3TPD57eCkpcWaQy5Mm/uauw2fSpMYGsEp6gWi+wpxI1NXst3DC23ti8//G3oJQTF8Ub2urDTtSGWaLXjlrYKzDXoms8z82UGzGPSxBolGeT5IBYhL/1gtvqf9dq8G3w8CF7f4LRj3BGv2woNNTe0I+Qo68FeWiYUntwLjG9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+M04b7BgIER6F7iCEgjrg2kJ6k+WAI7Fg3Jx/fAhPs=;
 b=q+A31pQZvsKLGP0LVth0U3kjLbt555GPehOtvRa+LJQcMvOSYUsERXomGqS+6PySjSlhTgHKvXxuMeOBKiS/ajahbNAu5Dbp4t40rRLhRgW/LPDye9SMeGR5rS3OKS+2eOa/UmZr9YLwaVpPXW0gsI6eRMZTe1KGkr44bufAVqzUgdzs/WwJUppLuaEjIOEvK1Q9brmPZ7xSqOSEeUkaDwT9zI1CUD1gsPEzVxk0BBTlUxu8FJ+07z/3hYsjo7YCzQCsY2pmp7dylxjGf1nq7Ej2uB9ld94ei9fLCOUNS3/Epw/rW7UWJ8sOepRXRqHg0UN6gIdJtOVwXU6FtZvaRQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA3PR02MB10589.namprd02.prod.outlook.com (2603:10b6:208:535::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Mon, 5 Aug
 2024 14:12:41 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7807.026; Mon, 5 Aug 2024
 14:12:41 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>, Roman Kisel
	<romank@linux.microsoft.com>
CC: "arnd@arndb.de" <arnd@arndb.de>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
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
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "ssengar@microsoft.com" <ssengar@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>, "vdso@hexbites.dev"
	<vdso@hexbites.dev>
Subject: RE: [PATCH v3 6/7] Drivers: hv: vmbus: Get the IRQ number from DT
Thread-Topic: [PATCH v3 6/7] Drivers: hv: vmbus: Get the IRQ number from DT
Thread-Index: AQHa36/Ax7vrWbxjOkqE907xHGTdubIYZA8AgABfOFA=
Date: Mon, 5 Aug 2024 14:12:41 +0000
Message-ID:
 <SN6PR02MB415701C313BD5E296393A29DD4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-7-romank@linux.microsoft.com>
 <20240805083024.GB31897@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20240805083024.GB31897@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [KjvQz9zTnNR4Zn9QTpCYtX305timbdLV]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA3PR02MB10589:EE_
x-ms-office365-filtering-correlation-id: 90fd52ca-3af2-420c-6a0e-08dcb558ab70
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 RbdD8ftR0LvqD/8NYZoHbMRDkzf51h0QcvqBwp8U/CkAD4hg4whhikZ4TqG0BIvj1wHu7S5zWnyGZHuDxoPaEKOOvzBCa1oRB9fCjG3lZrcsYytGFUZxfQN3Jn0AYImLvCDaxvYTfc49DU8wfaEXjh/fms2yl4J0dI8vacSTLD4nc1xPy7aL9j/i9lYFhD2We5+e0PNATsb2zDktINvWc6sKlTfFQ2DPPibChTwjUEYAGI6zVQNuHnis49PqDPiYoJOmNz7FDLl99LJaGJykQV0O1sg0yfyr/eNJ/e/0j3PItP4+bz8tdT/hzZK057omFmOGcHodMSrD+fQofK1SMytGPXXs9FWuqUP16HrYn324MZ1sJCxZ+QMk1BHGcAbYpMPemV33Vt1kYkdgJdcXt/IJNxIGguN7G49OyODQsZ5ZWMYsKshBWqyi6aUy1/8gIsZLLZDD9OXhhmt3jfCcT5jZCgjDWG5vcQlQdw2XV9FDl5BnMP0Lx5mQbKWfgJlNjYRgOVxX0nQNwQO0C1JhCRX0+hFEa/Fuv3sE1y4lfVFFQ/G4/8gcmpfz8fNShY5WYhmOZ6hJgvkq0cGLvQXUeXjw0EfKGzhJSfo12ss+FG7Lc4GB/APW4xYLPCP4tzbVZJjZ9IOG4UAO5wQUmfcf2A==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HkZEZ/1H2Vr5pgZzeCJpGJV2+pTiKXbl7/LgYhjjH+9EPWTIXnzefcRvqyTJ?=
 =?us-ascii?Q?FNazZWVuNkZ6wdj4NxWcdbz3E8jHm0p2Kphl+SsM7rDboW7XKVmyidT2w11Z?=
 =?us-ascii?Q?JxaENh8hsGb3uN5/wZjzqaYdjMUPElQdOEM5gkIk96ncg8BuXVJ/uNkJ1yzT?=
 =?us-ascii?Q?1A3sd7a3lq6bTRWCsZ/wUw3ys2P/zeGcLy93EU+bQxxJvHBDGrQsXBMrtyoN?=
 =?us-ascii?Q?xsMLhjBr8SjpIiS46U9S2XulI0eAEYj50H5s7oRWtGw60VHzxVrJQHOyMKrp?=
 =?us-ascii?Q?bC7S9IrmDx3c2rn2hg+SRbKK08I4eU29IT90+B2vlUAMJaf9ht7lcwsdV5rZ?=
 =?us-ascii?Q?17NcS0dYwA/ylQqmdKYJW9Nq32G6EJr23hA+2F/1rnUA94C9YQnwZLgi7FFu?=
 =?us-ascii?Q?ztpMGin2USJst/JQI3kRuX1qNO9WDuh1xWTWs/Tws1KY+mi9dOOxfuAGmPGu?=
 =?us-ascii?Q?k26J6TLGQryfmy3UfmFR2op3Sj9puBabR5cws3Cu4KIpLT7IAzb9FHE+Qd7c?=
 =?us-ascii?Q?4DeWqTl6zORTJ+Mmvg1ZHLUMq1mwvahb9ef5ZSr7Tx+NHROoHcKP4fMG6Ubd?=
 =?us-ascii?Q?V5R1Zbxsa4S5eIVeKZts3QLteGqOlqJlz778zBSER8zudd6cup7kmEYL2A52?=
 =?us-ascii?Q?R6LoY3swH7n59g3Gai7xy5nJ54MPClOUTAEATPBzfZZRDjVjZq0Lu/FDbpld?=
 =?us-ascii?Q?cBnNYGpO+nGkClLvsV19tWx70591nhkc3jRjyUtoCUuR2yVEIgFzo08XSVPh?=
 =?us-ascii?Q?o2umBaVZ1lfEbPgbwzemZQWITUkL/ejPn58r325TzvR9TotYwklBC+pZQgRL?=
 =?us-ascii?Q?rtURAutDbF4yrSi0SWF7/sZRiywEKWx+rg/EQglJNUeC2bBKqfB7XId7iTSK?=
 =?us-ascii?Q?8/ZoNyk4VgcBSI+bfnfsGbTuhuruDVv4RLGRMZol2a8i9EwS0xnYTv2aSqER?=
 =?us-ascii?Q?IK6WSgZKQWakYvrI24nO2D6BRsL6IS6W2Zyj27ventnH6crBvCqR2Rv6k9dC?=
 =?us-ascii?Q?ekv3Oo13AyU610seqy5WXR3REMJomjFZKn+yw2kbP76w3ywlXHJeOa7hF3pC?=
 =?us-ascii?Q?XYeNAma8KSfTAi4Vx6OG6CBsmhF/LYKbze2fc0fwnZRB8O7sfaKeaC/7CPjm?=
 =?us-ascii?Q?LWV5xZtCxt3qGzbhAMfWqdO+kEWmNobc32bMbkhyRAF/bJxjRkO0sm5xubu0?=
 =?us-ascii?Q?w6vUuAAV/drxWaOGvvJiXOdgh5frnlvQ5Jpp5b1YHKRq5aU+ehpeb5Xsg98?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 90fd52ca-3af2-420c-6a0e-08dcb558ab70
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 14:12:41.7171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB10589

From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Monday, Augu=
st 5, 2024 1:30 AM
>=20
> On Fri, Jul 26, 2024 at 03:59:09PM -0700, Roman Kisel wrote:
> > The VMBus driver uses ACPI for interrupt assignment on
> > arm64 hence it won't function in the VTL mode where only
> > DeviceTree can be used.
> >
> > Update the VMBus driver to discover interrupt configuration
> > via DeviceTree and indicate DMA cache coherency.
> >
> > Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> > ---
> >  drivers/hv/vmbus_drv.c | 49 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 12a707ab73f8..7eee7caff5f6 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -2306,6 +2306,34 @@ static int vmbus_acpi_add(struct platform_device=
 *pdev)
> >  }
> >  #endif
> >
> > +static int __maybe_unused vmbus_set_irq(struct platform_device *pdev)
> > +{
> > +	struct irq_desc *desc;
> > +	int irq;
> > +
> > +	irq =3D platform_get_irq(pdev, 0);
> > +	if (irq =3D=3D 0) {
> > +		pr_err("VMBus interrupt mapping failure\n");
> > +		return -EINVAL;
> > +	}
> > +	if (irq < 0) {
> > +		pr_err("VMBus interrupt data can't be read from DeviceTree, error %d=
\n", irq);
> > +		return irq;
> > +	}
> > +
> > +	desc =3D irq_to_desc(irq);
>=20
> irq_to_desc is not an exported symbol if CONFIG_SPARSE_IRQ is enabled. Th=
is will
> break the builds for HYPERV as module.
>=20

Instead, use irq_get_irq_data(), then irqd_to_hwirq().

Michael

