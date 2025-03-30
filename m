Return-Path: <linux-arch+bounces-11194-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE848A75CE1
	for <lists+linux-arch@lfdr.de>; Sun, 30 Mar 2025 23:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA72B1886B29
	for <lists+linux-arch@lfdr.de>; Sun, 30 Mar 2025 21:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476C71E32DB;
	Sun, 30 Mar 2025 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cuhBsgFK"
X-Original-To: linux-arch@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010003.outbound.protection.outlook.com [52.103.10.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE6B1E0E15;
	Sun, 30 Mar 2025 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743371642; cv=fail; b=IpjffgAGB57u+v9rMYGrGdjOaVWg+KNkovUtCjOg11mat1b9r0NxGzlUEdWgxckWuNoFqDK0As1w74eGHX9+JV2SHXi/hnGIAuq9TTo/bhi7RCTlFqGOhvMyB2mxtA5O/CVutz7XaEXZxTd1MDxFT0vJNTzOVqnh0bQ2eTkqG94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743371642; c=relaxed/simple;
	bh=wQQuvRBieyv+npjj85+PCXF7Dop0emXOO/Vwsl2OTc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ka6s5L3SoMeUAruQUaI6WNo96WmgBXoN64+4nHf1RDgrUOLVQwfvm3e8PlWgl7LOufpCpGJf03tmhP6bh1JvHADgjj/42vx2TZPOwnBMVOY2TmBFnsYz2Rm+sk2V+3SI8nO7Ss4gi8BhcJ2DHVA3wcIUCht9uJKOSNvdXUS523c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cuhBsgFK; arc=fail smtp.client-ip=52.103.10.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9fbxzin0HWm6hMt0/OXPM3RL3XcSWkLvFe79JiAYcv5cJ1DSUaNpT8oKDswvWZmUcblVJUgxW9rQV+kcj4UZupnUiWJgsuUj6F7IXVh2XYxMOrbsJxE4IYYq32RTVBTjCJgiynMAe/bqRACOE9Q9ui5cRBcQ6Ej2au9ItZgl9S7DC+9KKzX3u2qnv/iSZvJyLCLx0JdTWtzZaN663fZ/v+HtUcV5kWJgglSClPpZYIWC/OBk96qgsSUisvyTAbRWRPzN6bWpTWKc1TcYWAwmgdArN5dnZ7M9VppovheVNgB26r1Q3ngKUPrf+G9h6og5MJqg0CPLhmXpDBD0Fla1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUfDCKVeDTEy8/xYtvtK24Xf+VH7VOlhdbkUow0hHIQ=;
 b=VZZ0Z6fvueCjfX+ttqqYMwgYetUdYbseVoiP5G2eZgWImiUPQ9oaxRid9DMmSJVgqxuakKhLZ6BCOOp0tsLvPb/la/RgiwLjaiyW98PMRiVueDjPUxWcfNYVwjYPgZ6mC6jHweQXh/sMkiuoxx519T2gVPfdIugv3Wb/i/hann411BAQimFX9TO5ZI/dzwtfFtmG9Sypf9+/qlPSaZvHBuJ/XDODwBWsx621X8OO3FQyqo/IIPv2TZvEIEXJf7/9nKdqwP3OO6prBUbxTClfXAnTCgWSbmR1h0Wv1ole1yCljBn76Y4JCUZR75R8k1N6SfByBkjQyB6/g1MHgsO1ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUfDCKVeDTEy8/xYtvtK24Xf+VH7VOlhdbkUow0hHIQ=;
 b=cuhBsgFKUVymbxObgzu+04fqNgkQ6QG3DFuP/QY2aQRbY0c2vjOQHbl4iozk+1vYrrQZn8vNQEEUf6cABKKqmLdSJMGErN65bEXVC2oEIqsGEXbRojuyl9lv025373hVgJutal3xD+ZTiYgUGCeIzSsC0oBPkdvsnAvGEx4l/Y4sPutGA18lmH/lg7qJX7J1JsGWO/irX4aqJxkDhU/M4SW2Qx7lvyL+8N5d22nRj5+F1i5sqhpjOZr9KQ3jAjja4Te8wS18EKqJge2UiMFAvY13yBgVWQTF1eaPD6S6vFQbXx3H4tmLi2zPchCEPw65YeO4qoEkorj21sLeQGooZg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7527.namprd02.prod.outlook.com (2603:10b6:510:4e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Sun, 30 Mar
 2025 21:53:57 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8534.043; Sun, 30 Mar 2025
 21:53:57 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
Subject: RE: [PATCH v2 5/6] PCI: hv: Use hv_hvcall_*() to set up hypercall
 arguments
Thread-Topic: [PATCH v2 5/6] PCI: hv: Use hv_hvcall_*() to set up hypercall
 arguments
Thread-Index: AQHbk+AX3OvCv70ag0ykdq1muQMwqrN+FS2AgA48AzA=
Date: Sun, 30 Mar 2025 21:53:57 +0000
Message-ID:
 <SN6PR02MB415761B853808B7865125CD0D4A22@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250313061911.2491-1-mhklinux@outlook.com>
 <20250313061911.2491-6-mhklinux@outlook.com>
 <34de36fe-f4f6-4ec3-848d-9191fd1e8b9f@linux.microsoft.com>
In-Reply-To: <34de36fe-f4f6-4ec3-848d-9191fd1e8b9f@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7527:EE_
x-ms-office365-filtering-correlation-id: d18ec04f-77e8-4c63-f769-08dd6fd55f58
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|12121999004|461199028|19110799003|8062599003|8060799006|102099032|3412199025|440099028|12091999003|41001999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DxqEhSJM56/mWkViv79KF9H/dXUvUEDfPuJRTCXUtXTEyKqtsSNVR9SZgzk7?=
 =?us-ascii?Q?xB/PwMeukkyWU5iHiIC2NhZcoJxjPvWc1v4hHJc7cuQCq+wLOanbNOhTLR9E?=
 =?us-ascii?Q?hJwpHr1LozSy97bLBknPULn26gMx92lmRH6vg79GWTdWsQG8nAS0ZKIdLKoO?=
 =?us-ascii?Q?GkX69sq7Ip5EFd0c4UQXijh1hglwl2z8h+1rmhylhKFSqls7d8/+TN2BisU3?=
 =?us-ascii?Q?2Xpjw6Vnm5tzVYwV1px1/vGwfsU5XkDMLoKcBmNixxfSwVUcZJYhP088qqR4?=
 =?us-ascii?Q?rm1N7v2TSuY850dN4dl4iZ86PkgqJYOO/KLUlYtsK3CM6iO691ZwcG4zqySp?=
 =?us-ascii?Q?sdUPzTNkN93/yfEaQ0+ofZh7S3t+Q//aad9shvRj6sLfDQhFhov+2W3iBfxX?=
 =?us-ascii?Q?jzHTLHbahEzBeJ8Spo6J41KpFBdfMu3k6nnRYpJNWpwDc1W1+6RYnX3PoJwl?=
 =?us-ascii?Q?OTy2OSLS8erpjETtrD2yjRuRWtYjBa0bDNPLVFK0SkKPLRaNFA3VrmpESZAL?=
 =?us-ascii?Q?ey9G7Bdhfey13/QCAT7iSsmGLgWdZzAJSFhHHdpg37TdMgiOHWwSmgJ90Coe?=
 =?us-ascii?Q?lErckhFWr5V1PB3QEa9XkUVTO2JhIMNic40VB/YwuafEywTJj/AYh60ZG00c?=
 =?us-ascii?Q?zPmckVgB20JJHbp6mbud9SQWOqh/KxuA7m/IzPAO1+KVAotURhlMI/97w/8+?=
 =?us-ascii?Q?ujoLIZNKpNUDx7ar/dD7znrvj3uDtOO6WGInBwMVNa2LDT+xqlO5eIJn2Arp?=
 =?us-ascii?Q?0VTzIvUFSWCc3QKoPnyN+TF5BHxxhD07AYvr1xFjlDIhXZuJt09ztGuLWrRz?=
 =?us-ascii?Q?i2aDF1W/htiOMdqxRacOC4TtMWf9BnndmXUE/nu8XNugwXduK4bUj1NPmpY+?=
 =?us-ascii?Q?J1n+LAiVzXdSjaHNr/tAHPbVJ0xfrBcRzdiOh9WTwEckqzTLKhlXnvxlEHqE?=
 =?us-ascii?Q?283VtxuXl2ToBuzrQpMuocNYYOK6VrtSNtDW+07gOr3sq841UnnuuUK9kt+R?=
 =?us-ascii?Q?y8rJ8i6Q5pVZySTUEYHd4ePcrW0p6UQNLN3gcw/8Pdg7Rcv+snQFM4m1fedw?=
 =?us-ascii?Q?FbSiu6r5G4g33Fs41kBd3RsU0qsol00OLUzsjjMmz9E7q1zTe1RcNbEOx8DS?=
 =?us-ascii?Q?lM8LM9SSFmMsHovEqje7sq74m7BESpTtRQOKHiilyVXTki/hL3OB4MYvK21l?=
 =?us-ascii?Q?6jhVCyNhDwkdftZy?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XY4u4Q8R5nRbrVah2XAaIwNqKvHsWAIYyO9Gfd1io0lrtAgjNoJGsDhOY+Py?=
 =?us-ascii?Q?myop88FeJtcNmGt60vlbynWBWf2KZ4cfjCC1xIHOyFLTnBB82iRpxPm5hsrc?=
 =?us-ascii?Q?vH5WxiaHpU9HYDwTUF9bBu0+zKfDl142VGHqqSrR5Lz3vB9IvCqmvSWpxDvn?=
 =?us-ascii?Q?bC+fQyXMnmBGlxrVZCUFXvBF8JD9RA798a6+i0QofMHJnozHKSVxweJpAb/k?=
 =?us-ascii?Q?nDhXbOOUBaekfzu2dKLLbd3W+I/1fnMdyiSr3dGKRoph0GC4v44SW+/8ait3?=
 =?us-ascii?Q?GH4+Hd5BMMcFThSg7a1xeBr/SmhWjvJZyBJMiR0k4/oiKNWy105Wv+cuxKab?=
 =?us-ascii?Q?vK635fj9lZzJZKpbWJdIqkPG68q7Sqntc8M3q/WdVfq3aP73/2Zn9BHf0sMn?=
 =?us-ascii?Q?UcX3X8Q742l4UzPQlXnkZSpzd/MpCrwMOz1wUVfGARKrw6YuaIIN6YSNyBir?=
 =?us-ascii?Q?FwWsR6r8WioOZAC/lcBQ2OqGFRuLS0QVGize2tLRxj+2HR1eQlk/4uGNq4sq?=
 =?us-ascii?Q?fB9I1NnUuaRxlc+/sCO6JuoSanZUCm+UW0zIrAzsOfzy0PKF+Mnpq4wKeFV3?=
 =?us-ascii?Q?QSbROVOcZhDz1z3J+BMKDUPb8EXVObfvhD9ilLMFRhfBm2gGcdNS/beHixc6?=
 =?us-ascii?Q?nT0fC9wcNr1TJF2ueMWrXhjbNhanYEmf8CdCfPO9pJWe6/jnP1lcmSeKlssf?=
 =?us-ascii?Q?WOyP3L+1Efc2bPkC+XJWwtLoSbas3NvMUl+alrLILQ6u5bzkJ7W1uzFhKDCO?=
 =?us-ascii?Q?Z3t9FdvW8Q4E0Q9GJKI+OpkLiaKkrySjJn1/heuEXJqZGxSi/LTaMhZRhwgA?=
 =?us-ascii?Q?nHq228RTdW5RK4YKkPUe9G9GRRGgInCO/xBryLADJ+O2NSBRTYsHmg3Rafu7?=
 =?us-ascii?Q?R8mC3kAao02fdC9ZEkN7OMijvlHszxEQVLQh7nymUUXsekc1Wrs1tu5L9dKu?=
 =?us-ascii?Q?QYcnDNsOwMQSTRfdj1kM4fThFe5Uc10MBwn0d9ONtvsTl39MisN3OVpRAK+H?=
 =?us-ascii?Q?nruka/9fu95Sglc4MPEqE+wb+IFkWOBlTsWyMT97LzgZvoNK2KcK9vPn8oIN?=
 =?us-ascii?Q?FKc8p0dYlZ/Fl7HI7wXO8e7TDGovNnU/9xQA/jJRcTzAUKbWOuGtLh5y7C0d?=
 =?us-ascii?Q?WVzjyN3wAT3D5LKi1/BmDCr0WI7jiDeL5HVBmOy93IKp7M6cLIZfQ2cfSa4g?=
 =?us-ascii?Q?joOi8lyPEQKejhoKtF7yWMG5UO5H+VgD8tAW8auHCSp1ey1qZyZwnduyddo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d18ec04f-77e8-4c63-f769-08dd6fd55f58
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2025 21:53:57.4737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7527

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, March=
 21, 2025 1:19 PM
>=20
> On 3/12/2025 11:19 PM, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> >
> > Update hypercall call sites to use the new hv_hvcall_*() functions
> > to set up hypercall arguments. Since these functions zero the
> > fixed portion of input memory, remove now redundant calls to memset().
> >
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >
> > Notes:
> >     Changes in v2:
> >     * In hv_arch_irq_unmask(), added check of the number of computed ba=
nks
> >       in the hv_vpset against the batch_size. Since an hv_vpset current=
ly
> >       represents a maximum of 4096 CPUs, the hv_vpset size does not exc=
eed
> >       512 bytes and there should always be sufficent space. But do the
> >       check just in case something changes. [Nuno Das Neves]
> >
> >  drivers/pci/controller/pci-hyperv.c | 18 ++++++++----------
> >  include/hyperv/hvgdk_mini.h         |  2 +-
> >  2 files changed, 9 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controll=
er/pci-hyperv.c
> > index ac27bda5ba26..82ac0e09943b 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -622,7 +622,7 @@ static void hv_arch_irq_unmask(struct irq_data *dat=
a)
> >  	struct pci_dev *pdev;
> >  	unsigned long flags;
> >  	u32 var_size =3D 0;
> > -	int cpu, nr_bank;
> > +	int cpu, nr_bank, batch_size;
> >  	u64 res;
> >
> >  	dest =3D irq_data_get_effective_affinity_mask(data);
> > @@ -638,8 +638,8 @@ static void hv_arch_irq_unmask(struct irq_data *dat=
a)
> >
> >  	local_irq_save(flags);
> >
> > -	params =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> > -	memset(params, 0, sizeof(*params));
> > +	batch_size =3D hv_hvcall_in_array(&params, sizeof(*params),
> > +					sizeof(params->int_target.vp_set.bank_contents[0]));
> >  	params->partition_id =3D HV_PARTITION_ID_SELF;
> >  	params->int_entry.source =3D HV_INTERRUPT_SOURCE_MSI;
> >  	params->int_entry.msi_entry.address.as_uint32 =3D int_desc->address &=
 0xffffffff;
> > @@ -671,7 +671,7 @@ static void hv_arch_irq_unmask(struct irq_data *dat=
a)
> >  		nr_bank =3D cpumask_to_vpset(&params->int_target.vp_set, tmp);
> >  		free_cpumask_var(tmp);
> >
> > -		if (nr_bank <=3D 0) {
> > +		if (nr_bank <=3D 0 || nr_bank > batch_size) {
> >  			res =3D 1;
> >  			goto out;
> >  		}
> > @@ -1034,11 +1034,9 @@ static void hv_pci_read_mmio(struct device *dev,=
 phys_addr_t gpa, int size, u32
> >
> >  	/*
> >  	 * Must be called with interrupts disabled so it is safe
> > -	 * to use the per-cpu input argument page.  Use it for
> > -	 * both input and output.
> > +	 * to use the per-cpu argument page.
> >  	 */
> > -	in =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> > -	out =3D *this_cpu_ptr(hyperv_pcpu_input_arg) + sizeof(*in);
> > +	hv_hvcall_inout(&in, sizeof(*in), &out, sizeof(*out));
> >  	in->gpa =3D gpa;
> >  	in->size =3D size;
> >
> > @@ -1067,9 +1065,9 @@ static void hv_pci_write_mmio(struct device *dev,=
 phys_addr_t gpa, int size, u32
> >
> >  	/*
> >  	 * Must be called with interrupts disabled so it is safe
> > -	 * to use the per-cpu input argument memory.
> > +	 * to use the per-cpu argument page.
> >  	 */
> > -	in =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	hv_hvcall_in_array(&in, sizeof(*in), sizeof(in->data[0]));
> >  	in->gpa =3D gpa;
> >  	in->size =3D size;
> >  	switch (size) {
> > diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> > index 70e5d7ee40c8..cb25ac1e3ac5 100644
> > --- a/include/hyperv/hvgdk_mini.h
> > +++ b/include/hyperv/hvgdk_mini.h
> > @@ -1342,7 +1342,7 @@ struct hv_mmio_write_input {
> >  	u64 gpa;
> >  	u32 size;
> >  	u32 reserved;
> > -	u8 data[HV_HYPERCALL_MMIO_MAX_DATA_LENGTH];
> > +	u8 data[];
>=20
> As with the prior patch, I don't think this is worth changing. The
> code in hv_pci_write_mmio() is more complicated as a result, and
> changing the array means the struct no longer matches the Hyper-V
> struct 1:1.
>=20

Given the goal of matching the Hyper-V structure definitions, I
can see that changing the "data" field to be a flexible array is
problematic. But what are the additional complications in
hv_pci_write_mmio() are you referring to?  There's only a one
line change. Again, I'd like to not leave cases where use of
hyperv_input_arg is open coded. I think hv_hvcall_*() can still
be used even if the "data" field is a fixed-size array.

Michael

