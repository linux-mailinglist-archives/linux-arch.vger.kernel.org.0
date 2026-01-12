Return-Path: <linux-arch+bounces-15754-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28618D149C3
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jan 2026 18:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F0D73175751
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jan 2026 17:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BFE37A4BA;
	Mon, 12 Jan 2026 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="k+vnLIU+"
X-Original-To: linux-arch@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010016.outbound.protection.outlook.com [52.103.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BF237F0E2;
	Mon, 12 Jan 2026 17:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240116; cv=fail; b=C8Vh4rSdNp7N3qo28LUZRbT+qy2tnDMPedFtekTbveNTsDUZGYxC3yQ98xgttr9B41WGw4K31DpvCSgLfMEMIK5WWcCPf/qfPfwsnAuPwoM5rBlvTRccodSwQ0fBfIWa7dwVPdDGixMBNXS2psPZANCmOuww84w+a8u2mwy/pRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240116; c=relaxed/simple;
	bh=0bAKGtYLKkhu7mzhcR5gfSQXEPFDlLZVn65p4AvO20I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aCMYUkbhrxyiF1ysplwBvPz8jCn2C09ZvlhOT6LlJC/nywkoIj8Fxe5hD7mh9XxTGEugnTLM5k1ehNUgBsRQ+9Nv8R+mRc6t5PFanPnnSwn4G+FXViBapUI7b/NxrDvFG1fA6qrc7pfDQAAaB2tiDJAh4w1+sI2+2hXhfQxbCKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=k+vnLIU+; arc=fail smtp.client-ip=52.103.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/MZbNf01cvVqhuJu2tW8QIhI8iH/p0VH5gmF/wCWSBAfYUqmNPs5e6ZAL7ej9fjB5NL327QLUiiG6D/CT+3KmnkhcVfhl3eTt5UnOUyogyRbtzBbRiyNpYz+tjKdpzu7ak1fqzPciwRM87oHgYWUhQOiWIQ1gf9YywHzirOp5ulQ2VwLw85m+/8Z8oqrUgcdQihYiuMdg4yM1TM/DJhe8VzA7/QjYJjM3UcYrhABJBvINcSsXHgJdravf4OVpm2H1LL0cUm9+ae5nSaI5/jFpU+r7MAMCgqsIQ6uOsGcmCspWrhSg4fxydxCsyQD6pEws+vOMYmbbF5q11Zcm1Y0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Prm0CkZjm6AvivR1lCW3tMDY0nezPby9oFrIoiApnzU=;
 b=mzrQHweQ1kNcCjhdqyYrJHGD3NKKLB1DafSg8BC97eXiWuUuDt3a39yZECqUSUS4BIxyfalcYPWKdsOb+qh3wA7f6cVhnsoRamv363t+LdA6T9wSjYpwKKLS4Un9tN8ePX/GIGz41eTq5RAiQFVJnLD4zGuEe2WoS3MdC03bK/TPEr7v2xtWk/gZbq+QQzm+qF1jP3KhW2t/A2ijY9LZKfYbK5ABDzqE+/uDm7koBPYDF5dPdWrNg3bN5iOPRmnOsUId2O7s1n7YRXa8LkWYDa+k4dzqjbzytizsLr3lgNXLhMy0k5A/pCu6cmwQWJx874xvNok5UT+3CKNYwIX+8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Prm0CkZjm6AvivR1lCW3tMDY0nezPby9oFrIoiApnzU=;
 b=k+vnLIU+lttgRLbJb3wEHme/MjCmz2RFupSrErrl2OSDSV7B0m70vdBrNZ7Frbyg1oZoRngN99L+fJewxTI9c7kYPXeS+GCzq+HDqES+SlA7poYQO3Ybi5/Oca1+QCBIZECBJx799grxdSdixEoq0K/0Pp1VUK+PfkJGfm5vzC4nhOXY4R3U1pKLJxMTZM55Ei3w6Pt+8u1YYLPguaw+sXyT5OIvsI+31CXytMI3VtnCeDsZ2DbncqX5azEbe7kI+S/iQbl3yR2UiSevpZpU18aPGsw8gg3uVi8WNRt87MthjhmBrWK4g9dqvCUnzLURhC4NLIqAhVKRiSXpo5QraQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO1PR02MB8425.namprd02.prod.outlook.com (2603:10b6:303:154::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Mon, 12 Jan
 2026 17:48:31 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 17:48:31 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "jacob.pan@linux.microsoft.com"
	<jacob.pan@linux.microsoft.com>, "nunodasneves@linux.microsoft.com"
	<nunodasneves@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [RFC v1 5/5] iommu/hyperv: Add para-virtualized IOMMU support for
 Hyper-V guest
Thread-Topic: [RFC v1 5/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Thread-Index: AQHcaMpb286bdBhc60y7Ts6ZOD3veLVIruwggAZIL4CAAAL1EA==
Date: Mon, 12 Jan 2026 17:48:30 +0000
Message-ID:
 <SN6PR02MB41571D67D866538138D06585D481A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
 <20251209051128.76913-6-zhangyu1@linux.microsoft.com>
 <SN6PR02MB41572D46CF6C1DE68974EAA1D485A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <dws34g6znmam7eabwetg722b4wgf2wxufcqxqphhbqlryx23mb@we5utwanawe2>
In-Reply-To: <dws34g6znmam7eabwetg722b4wgf2wxufcqxqphhbqlryx23mb@we5utwanawe2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO1PR02MB8425:EE_
x-ms-office365-filtering-correlation-id: f035fb3e-d81a-4250-d14a-08de5202cc4a
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|51005399006|19110799012|8060799015|15080799012|41001999006|461199028|13091999003|31061999003|56899033|440099028|3412199025|40105399003|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uiVbgy+oHE9k4h8zRKRO/w2N264bE84KNsxvurbDo4QlStmMCxfzKreMaQJ2?=
 =?us-ascii?Q?jml8gCmo7Rnt8xhUokmmrh0AMMWpP1PXhTJezlnwCNAaZaFuMXk5h1QHaAoY?=
 =?us-ascii?Q?M+DQ/aSJCaWVXCQ5JKvWGhzjlCx0blsDRoI83xMV0IZCIkGwnnogQABtapZB?=
 =?us-ascii?Q?T5osj3Ed/o/gLO6mjWKznqcu2cGAS88paSgooLdkJJAhUx6S7kUMu7Wrym3s?=
 =?us-ascii?Q?89Xo3Al0Oj3CrR93EZ/4lD5GLTNypbDe+aQS1NaIpjOJstLzmQ21dznmYq0i?=
 =?us-ascii?Q?b2ClShkCDzO0yFwAi2/mYMEMFTwPwA+LGAyKtTEMRv5RuyBgy+RLOrgqxmPI?=
 =?us-ascii?Q?LssPLCJiNkEsSbt9qOuB7Bq7Bbd6Z6iNXdi80MB0xk2dtRAUdfGbvR8bQ6If?=
 =?us-ascii?Q?YsBILH2JsRT0uO4ArGYfGJFofFK5oNl8kvof9HWTkgR4Y/aVLTxIl6lmoFeX?=
 =?us-ascii?Q?X0o+u7p2rrnxjoIGr2XXp4JF64W5l4kaIVbh49/902vj023XtCkH6HzonLma?=
 =?us-ascii?Q?zH9zuNZkivOqhOltRj/blnS+Wr0MpQkzFUmOWta9sJVK3xIZwfwVDW3HMHft?=
 =?us-ascii?Q?JjZYPO9PIoiD3OkBxAdm5BpZX4l2mQ1FVgQwjLHO/O6rGjK3v7sxsB7d2Mit?=
 =?us-ascii?Q?adMXj0WT7ZtU9rh7vJ76dJuT0biJ9UrQ0mfjhz3NzXOylyLWKScIuVjzET+j?=
 =?us-ascii?Q?yMEfifXgsSdYwIfZKC+ZqgVj/DVnrnLOz2mPn0rZDObHk5lTmqhS3CdFMvrW?=
 =?us-ascii?Q?wAmYHxLFQgya2i6k4LSPBN4lOQhFZJ/W8+PgYnMx8oIl6c9sfgxDbM2UCVA3?=
 =?us-ascii?Q?tcviJ5UgCySy8fuOaUxmm4ybFabW0gl7yFkIkPjS+x+vo5fEh/7DUWLBd+n8?=
 =?us-ascii?Q?2zjzmbDoqSJidYd3cfKFlUe+GmOggErFC1HII1Wwa2yaeiB8Myst7Wi6lZ+u?=
 =?us-ascii?Q?99pfN9KeUmfdkMBByOKITME4t/a07w70V0TDgS//EVxMqPVA+rETYtzwFddx?=
 =?us-ascii?Q?wbKl9zH1ddUAcisNUpJmR38c9/9pDHP3gM2urLEtobZZ45JOi/WHYsgbh1wF?=
 =?us-ascii?Q?fTPs/1vyFcr5QRwZaNV677EQUK07iUVOIgb2djnJjlYI2qu5uQqGcnIBSeVi?=
 =?us-ascii?Q?VncxkJAqAmMMzsFqFnPDOX9Lgp3bLc0/RX4NfVDDVNSSdgNw0Y+v3nbdPUqr?=
 =?us-ascii?Q?sKmSV0HIS/PBOMmdutBh/YJoqq2BYGKpatDK4j6+LGvRaVrfZAhQub4b5oms?=
 =?us-ascii?Q?UkanyOpeIDpGzga7spJgHTrz3/C1WOPncF+t2ltcaw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?N40aPPaRahhlTNiVwXcLJqgHceWv8msOxbI+EKBpcBc88NMBWlinwqOT/3A/?=
 =?us-ascii?Q?LXxb6woFD0LL3yHGrB5dhklsdrsMfLxClN44h16yii7p7l0lzp+0R7aVCxD7?=
 =?us-ascii?Q?e9T4YNzlntDJHHVkDCfclrA0xPZzyl4bZ9U9xHPKyc2EVV2iLVwmo5ArOhjW?=
 =?us-ascii?Q?OFRPKC0i9oq83BEcx4cmPImN9cymJqFKrr5FlY2uN+XZdnJofdrMvjVkn8ua?=
 =?us-ascii?Q?drGti3i7yEMuXVJjkm2XjfAe+bICvUKKsX1Xbtpi4xELpP8bB8Sxk0/W0fuo?=
 =?us-ascii?Q?/iCwQZ7mWW/SNtDIPvS0DgI8LRqVi8VZ8Jnq58BCt790UzYR/U5S1jEbxwe0?=
 =?us-ascii?Q?nSp0i7Z3/oyaWhyOlWUux6q7sBOSLvgJmpO6kH6iXRQVNiBwHbnFBsyUa+AR?=
 =?us-ascii?Q?9NiGMNPQajpz58R5icGDidPY79QxV281OgZdzfsnXZ56vHIGbYyk1CN6ZQtT?=
 =?us-ascii?Q?QEtAHkgcDr4j0LfLJBRPNnS5vJWXp065QPkrNohwQy1jSg9+YGX8WMhKN/i2?=
 =?us-ascii?Q?fmYpT7dogaA7Wta1UJnf4djCaREH6h6nqXrztJb3t+BTRVzqHym5MD73pe+t?=
 =?us-ascii?Q?78wc0JZow/h90WZcBVX9FIssNKtdtE9wB3t8KhGZpJaY8nIh2tYxDZfjDTTb?=
 =?us-ascii?Q?GCyXXloxKo/50DBYp00JUuAfzgwR038p2VaZMxnBmt0VS+FOBwpRbnc2hlb3?=
 =?us-ascii?Q?ScZjPUthab27DZEwstoW+Gi4XGUCzUWFFpdyIrPJmDZpd2yDyj9mo7QHHOiy?=
 =?us-ascii?Q?db0eNWXgedSClt+Frvj+X94eFgAj9YDlpc0fNaz8lh5YRygzxxYsCQ1cjIhj?=
 =?us-ascii?Q?VFqtI2j76sHkxXkuxFz4TaRX50XX27sju9fGv6+3ke5dfd6bxz2oJLGGFHcU?=
 =?us-ascii?Q?3O6kbBqIUJDhcMnbn9kJf5ektcCgrQJcjcDF7pOaLGuNLog6q+lZhvTSQrD5?=
 =?us-ascii?Q?vmWDOgShdcxIv5tuXhS5Ngc5aZJ26B8sjt1n1cBBUl6T06SafKl/oz5mMYvi?=
 =?us-ascii?Q?/TOPutcHmW3Y3zJ2NWy8swnjNenZJqNATNQ419wa+RBrVncpCGsdGeQmpPyG?=
 =?us-ascii?Q?Xc5J0IPB9NY5szEb3uPe9XZgsgMDHGGUZhvJvx6LQ2om+CysAiyUmhK+f+VP?=
 =?us-ascii?Q?/NqigXx45r9aIk6nFkxkrroBgow8gco5tctw9Zy2Yl5zE4yHaTOmGVqghzJA?=
 =?us-ascii?Q?wQqpJYWoZzUjD6UvtWknh/9Lxi9n5Xj/56IHx5moqY2JUmWuux1eYxT3U2fb?=
 =?us-ascii?Q?ilj8gsscCsLC7X9xdEwyFRJeZO7pAEf1zbiEh4zfEdOuTEjH+2aCVsFritMn?=
 =?us-ascii?Q?+Gg3a6duRV4+2MdgvpmU+/AB03Nj9Hq5j/G+27pmi806LlTF4ANCGUZAGunj?=
 =?us-ascii?Q?6OnOxiw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f035fb3e-d81a-4250-d14a-08de5202cc4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 17:48:30.3894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8425

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, January 12, 202=
6 8:56 AM
>=20
> On Thu, Jan 08, 2026 at 06:48:59PM +0000, Michael Kelley wrote:
> > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, December 8,=
 2025 9:11 PM
>=20
> <snip>
> Thank you so much, Michael, for the thorough review!
>=20
> I've snipped some comments I fully agree with and will address in
> next version. Actually, I have to admit I agree with your remaining
> comments below as well. :)
>=20
> > > +struct hv_iommu_dev *hv_iommu_device;
> > > +static struct hv_iommu_domain hv_identity_domain;
> > > +static struct hv_iommu_domain hv_blocking_domain;
> >
> > Why is hv_iommu_device allocated dynamically while the two
> > domains are allocated statically? Seems like the approach could
> > be consistent, though maybe there's some reason I'm missing.
> >
>=20
> On second thought, `hv_identity_domain` and `hv_blocking_domain` should
> likely be allocated dynamically as well, consistent with `hv_iommu_device=
`.

I don't know if there's a strong rationale either way (static allocation vs=
.
dynamic). If the long-term expectation is that there is never more than one
PV IOMMU in a guest, then static would be OK. If future direction allows th=
at
there could be multiple PV IOMMUs in a guest, then doing dynamic from
the start is justifiable (though the current PV IOMMU hypercalls seem to
assume only one PV IOMMU). But either way, being consistent is desirable.

>=20
> <snip>
> > > +static int hv_iommu_get_logical_device_property(struct device *dev,
> > > +					enum hv_logical_device_property_code code,
> > > +					struct hv_output_get_logical_device_property *property)
> > > +{
> > > +	u64 status;
> > > +	unsigned long flags;
> > > +	struct hv_input_get_logical_device_property *input;
> > > +	struct hv_output_get_logical_device_property *output;
> > > +
> > > +	local_irq_save(flags);
> > > +
> > > +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> > > +	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> > > +	memset(input, 0, sizeof(*input));
> > > +	memset(output, 0, sizeof(*output));
> >
> > General practice is to *not* zero the output area prior to a hypercall.=
 The hypervisor
> > should be correctly setting all the output bits. There are a couple of =
cases in the new
> > MSHV code where the output is zero'ed, but I'm planning to submit a pat=
ch to
> > remove those so that hypercall call sites that have output are consiste=
nt across the
> > code base. Of course, it's possible to have a Hyper-V bug where it does=
n't do the
> > right thing, and zero'ing the output could be done as a workaround. But=
 such cases
> > should be explicitly known with code comments indicating the reason for=
 the
> > zero'ing.
> >
> > Same applies in hv_iommu_detect().
> >
>=20
> Thanks for the information! Just to clarify: this is only because Hyper-V=
 is
> supposed to zero the output page, and for input page, memset is still nee=
ded.
> Am I correct?

Yes, you are correct.

The general TLFS requirement for hypercall input is that unused fields and =
bits
are set to zero. This requirement ensures forward compatibility if a later =
version of
the hypervisor assigns some meaning to previously unused fields/bits. So be=
st practice
for hypercall call sites is to use memset() to zero the entire input area, =
and then specific
field values are set on top of that. Any fields/bits that aren't explicitly=
 set then meet
the TLFS requirement.

It would be OK if a hypercall call site explicitly set every field/bit inst=
ead of using
memset(), but it's easy to unintentionally miss a field/bit and create a fo=
rward
compatibility problem. However, when the hypercall input contains a large a=
rray,
the code usually does *not* do memset() on the large array because of the p=
erf
impact, but instead the code populating the large array must be careful to =
not leave
any bits uninitialized.

For hypercall output, the hypervisor essentially has the same requirement. =
It should
make sure that any unused fields/bits in the output area are zero, so that =
the Linux
guest can properly deal with a future hypervisor version that assigns meani=
ng to
previously unused fields/bits.

>=20
> <snip>
>=20
> > > +static void hv_iommu_shutdown(void)
> > > +{
> > > +	iommu_device_sysfs_remove(&hv_iommu_device->iommu);
> > > +
> > > +	kfree(hv_iommu_device);
> > > +}
> > > +
> > > +static struct syscore_ops hv_iommu_syscore_ops =3D {
> > > +	.shutdown =3D hv_iommu_shutdown,
> > > +};
> >
> > Why is a shutdown needed at all?  hv_iommu_shutdown() doesn't do anythi=
ng
> > that really needed, since sysfs entries are transient, and freeing memo=
ry isn't
> > relevant for a shutdown.
> >
>=20
> For iommu_device_sysfs_remove(), I guess they are not necessary, and
> I will need to do some homework to better understand the sysfs. :)
> Originally, we wanted a shutdown routine to trigger some hypercall,
> so that Hyper-V will disable the DMA translation, e.g., during the VM
> reboot process.

I would presume that if Hyper-V reboots the VM, Hyper-V automatically
resets the PV IOMMU and prevents any further DMA operations. But
consider kexec(), where a new kernel gets loaded without going through
the hypervisor "reboot-this-VM" path. There have been problems in the
past with kexec() where parts of Hyper-V state for the guest didn't get
reset, and the PV IOMMU is likely something in that category. So there
may indeed be a need to tell the hypervisor to reset everything related
to the PV IOMMU. There are already functions to do Hyper-V cleanup: see
vmbus_initiate_unload() and hyperv_cleanup(). These existing functions
may be a better place to do PV IOMMU cleanup/reset if needed.

>=20
> <snip>
>=20
> > > +device_initcall(hv_iommu_init);
> >
> > I'm concerned about the timing of this initialization. VMBus is initial=
ized with
> > subsys_initcall(), which is initcall level 4 while device_initcall() is=
 initcall level 6.
> > So VMBus initialization happens quite a bit earlier, and the hypervisor=
 starts
> > offering devices to the guest, including PCI pass-thru devices, before =
the
> > IOMMU initialization starts. I cobbled together a way to make this IOMM=
U code
> > run in an Azure VM using the identity domain. The VM has an NVMe OS dis=
k,
> > two NVMe data disks, and a MANA NIC. The NVMe devices were offered, and
> > completed hv_pci_probe() before this IOMMU initialization was started. =
When
> > IOMMU initialization did run, it went back and found the NVMe devices. =
But
> > I'm unsure if that's OK because my hacked together environment obviousl=
y
> > couldn't do real IOMMU mapping. It appears that the NVMe device driver
> > didn't start its initialization until after the IOMMU driver was setup,=
 which
> > would probably make everything OK. But that might be just timing luck, =
or
> > maybe there's something that affirmatively prevents the native PCI driv=
er
> > (like NVMe) from getting started until after all the initcalls have fin=
ished.
> >
>=20
> This is yet another immature attempt by me to do the hv_iommu_init() in
> an arch-independent path. And I do not think using device_initcall() is
> harmless. This patch set was tested using an assigned Intel DSA device,
> and the DMA tests succeeded w/o any error. But that is not enough to
> justify using device_initcall(): I reset the idxd driver as kernel
> builtin and realized, just like you said, both hv_pci_probe() and
> idxd_pci_probe() were triggered before hv_iommu_init(), and when pvIOMMU
> tries to probe the endpoint device, a warning is printed:
>=20
> [    3.609697] idxd 13d7:00:00.0: late IOMMU probe at driver bind, someth=
ing fishy here!
>=20

You succeeded in doing what I was going to try! I won't spend time on it no=
w.

> > I'm planning to look at this further to see if there's a way for a PCI =
driver
> > to try initializing a pass-thru device *before* this IOMMU driver has i=
nitialized.
> > If so, a different way to do the IOMMU initialization will be needed th=
at is
> > linked to VMBus initialization so things can't happen out-of-order. Est=
ablishing
> > such a linkage is probably a good idea regardless.
> >
> > FWIW, the Azure VM with the 3 NVMe devices and MANA, and operating with
> > the identity IOMMU domain, all seemed to work fine! Got 4 IOMMU groups,
> > and devices coming and going dynamically all worked correctly. When a d=
evice
> > was removed, it was moved to the blocking domain, and then flushed befo=
re
> > being finally removed. All good! I wish I had a way to test with an IOM=
MU
> > paging domain that was doing real translation.
> >
>=20
> Thank you, Michael! I really appreciate you running these extra experimen=
ts!
>=20
> My tests on this DSA device passed (using paging domain) too, with no DMA
> errors observed (regardless its driver is builtin or as a kernel module).
> But that doesn't make me confident about using `device_initcall`. I belie=
ve
> your concern is valid. E.g., an endpoint device might allocate a DMA addr=
ess(
> using a raw GPA, instead of gIOVA) before pvIOMMU is initialized, and the=
n
> use that address for DMA later, after a paging domain is attached?

Yes, that's exactly my concern.

>=20
> > > diff --git a/drivers/iommu/hyperv/iommu.h b/drivers/iommu/hyperv/iomm=
u.h
> > > new file mode 100644
> > > index 000000000000..c8657e791a6e
> > > --- /dev/null
> > > +++ b/drivers/iommu/hyperv/iommu.h
> > > @@ -0,0 +1,53 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +/*
> > > + * Hyper-V IOMMU driver.
> > > + *
> > > + * Copyright (C) 2024-2025, Microsoft, Inc.
> > > + *
> > > + */
> > > +
> > > +#ifndef _HYPERV_IOMMU_H
> > > +#define _HYPERV_IOMMU_H
> > > +
> > > +struct hv_iommu_dev {
> > > +	struct iommu_device iommu;
> > > +	struct ida domain_ids;
> > > +
> > > +	/* Device configuration */
> > > +	u8  max_iova_width;
> > > +	u8  max_pasid_width;
> > > +	u64 cap;
> > > +	u64 pgsize_bitmap;
> > > +
> > > +	struct iommu_domain_geometry geometry;
> > > +	u64 first_domain;
> > > +	u64 last_domain;
> > > +};
> > > +
> > > +struct hv_iommu_domain {
> > > +	union {
> > > +		struct iommu_domain    domain;
> > > +		struct pt_iommu        pt_iommu;
> > > +		struct pt_iommu_x86_64 pt_iommu_x86_64;
> > > +	};
> > > +	struct hv_iommu_dev *hv_iommu;
> > > +	struct hv_input_device_domain device_domain;
> > > +	u64		pgsize_bitmap;
> > > +
> > > +	spinlock_t lock; /* protects dev_list and TLB flushes */
> > > +	/* List of devices in this DMA domain */
> >
> > It appears that this list is really a list of endpoints (i.e., struct
> > hv_iommu_endpoint), not devices (which I read to be struct
> > hv_iommu_dev).
> >
> > But that said, what is the list used for?  I see code to add
> > endpoints to the list, and to remove then, but the list is never
> > walked by any code in this patch set. If there is an anticipated
> > future use, it would be better to add the list as part of the code
> > for that future use.
> >
>=20
> Yes, we do not really need this list for this patch set. Thanks!
>=20
> B.R.
> Yu

