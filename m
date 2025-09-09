Return-Path: <linux-arch+bounces-13442-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B853CB49FCC
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 05:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1914189B8C7
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 03:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7123B260578;
	Tue,  9 Sep 2025 03:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="E9JzcE3K"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2078.outbound.protection.outlook.com [40.92.23.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15442609FC;
	Tue,  9 Sep 2025 03:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757387698; cv=fail; b=V04nws6ckTBTRLudMMeR6xJ3LiDVAFDkriYhv5ovoahSWleiaxFWKjY+ZAU6lweVUG295pOZrICe/NJSGYPklJJ1KYeBEP3t8JXmKv/Px2M0E8HxkYrBkGaH6FxedCZv5g1mr+4DlrHFxPxr4QUDJIVICqSbjhg8c2DwYwALjVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757387698; c=relaxed/simple;
	bh=U1dPdGq6xnBQHwy3MVbkrMtMAsfZmcbS3Y9NjhBuphA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eI8+bgucZ1qtOwiDJoFgSvHqNfbcmCgTqjNcwuPa+hRPCOu4DdK5q8uZADqOYlw9qXhvV3Buyq7RlbQeO8YXmjcVT2fhPJyfaqlXTb6EmsA6Cflh62B7h/PM7UdskTsX85ifTvsVmMaqDmC33h1j7LHt0iYjf1gjsRGRFduRM6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=E9JzcE3K; arc=fail smtp.client-ip=40.92.23.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+0m02JbfkgnU9TJyzBlLqQ5qa3ojAumykMfkxMLnKyrldsewwKZ6t454HSbEcnwItT1n8GLJLKa5t1YglK0bUJ+BVenQPYWI9JzmtyxdUDIWnkUCxLcXOmTA2Kbcw4OiWg6pc0LPNnbdyaJDaYxJhBqApRZzXf6AsBe+m5Ysj0MU9vseuP18RYlXOyiDVQMN4L0DDGxmWljuG9AhValNh1z3jheoaLe+QLJf2znLk93gAyL8TPDrmtdkvyHjYDYg7lKR/LSsBvV5NLtuY1c+MBFg+tQo+PNovvDFv++VTrX18ymrjGOh88FbQToE93IigZLrns2kzdq8H4Dm0xehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15mi+BSxRy2HFNzDLIVuGx48tlhAUoQVL3fJP6w5G4g=;
 b=dru6zYZKKtnEkxHIt4DGcmVBwfLzbbGfPg9SOVmc2+hsV/7+/Uu0xYp64ycHWWnyn0wrkZI3Vqu295V1wAsMMw14u1fEE1l/x5R2nFf/d4edlbtJPpZOQ858NKu4Sr+DOE/pVWY9ROb33tAFYnibvL7DcY54D7qND/0JHiTW3NMXkkVKRUFYteGhyUDYAxRkgi9EE/iDU1tX+qOj1kX24x2pf+vkeLoXtQBqC6u/3drND9SpCB59VhUl/ju+JVvULMSZjkGQIp1rtGEB1+QlYVb8cV9EKOhHrcyqU7NKVv7mffB+Z5ctHKAvksspuRjRFjyN63dWquNY0+QzT9l5GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15mi+BSxRy2HFNzDLIVuGx48tlhAUoQVL3fJP6w5G4g=;
 b=E9JzcE3KtUlVZAbT1/vqy/HviEJ90dAMedndl6OgPG+tebbjvDNpCA95GXdtSLlb07mktMlO96Ef7ICmfAcoDQRYhie8gXelw8L2kUih0EsygZlglI2JMEr762jvs30lTeY66vb3WTjBFspa4jbh6n/NejUCUZ5jAuqeky4sufIgvk9yzaJm8Uvj81PizqZQcjKNDGh7y3pwco7G+ZTjXlyLjmGKBDnDfgnW/gU254AGClMzWqmJo7hzv7C3Z9TSw1gfu+nHH/4JKTitZHSDN58ek3/mdMRxG4EZAvYEt9N4Gp1v5qh5LOsRHWe2O6n121rPbSTCfqU8D8I3mVcpjQ==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by SJ0PR02MB8484.namprd02.prod.outlook.com (2603:10b6:a03:3fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Tue, 9 Sep
 2025 03:14:48 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%4]) with mapi id 15.20.9094.018; Tue, 9 Sep 2025
 03:14:48 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mikelley@microsoft.com"
	<mikelley@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "Tianyu.Lan@microsoft.com"
	<Tianyu.Lan@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: "benhill@microsoft.com" <benhill@microsoft.com>, "bperkins@microsoft.com"
	<bperkins@microsoft.com>, "sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v5 13/16] Drivers: hv: Free msginfo when the
 buffer fails to decrypt
Thread-Topic: [PATCH hyperv-next v5 13/16] Drivers: hv: Free msginfo when the
 buffer fails to decrypt
Thread-Index: AQHcF7hZDpvsnLYxm0SLy+ITASeRBrSKP7tw
Date: Tue, 9 Sep 2025 03:14:48 +0000
Message-ID:
 <BN7PR02MB41485581F33D416E019A54C9D40FA@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20250828010557.123869-1-romank@linux.microsoft.com>
 <20250828010557.123869-14-romank@linux.microsoft.com>
In-Reply-To: <20250828010557.123869-14-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|SJ0PR02MB8484:EE_
x-ms-office365-filtering-correlation-id: 22b0df93-836a-4c15-90b6-08ddef4f08b6
x-ms-exchange-slblob-mailprops:
 Z68gl6A5j294JuRJ8WqUlwRTErf/quLvUeg/DO6oiOSCDDiqh5F6cCaGD2kLWndGtgLrFJpWmLGZRNroTJioXvPA1oax9fnh8MULQoFAkqz+MiYEZ2phnyY2ftvqf6pnedztEqdlPGBGV0N7ASlKnSCooSqZIb694avPeNz+uiocprZ/xudbkGRRIwbzUlk2QVkR0yeZTPY86YlMrWFhJtDUB4yeCuUvKxLNxrQzKDk8jXbyM0kENclPmKHqgnVgZ1xSu6STjSYKs0yFvxrG5JyO9Aj5baQesM8dwAtUUwISvvsz/k9PmrhZFwJlx+AcJ7Ld5tScXC19t+OYDmPzkzOIeQH1i+eHeWFhSWiZZlh+HVwap6W3Zjl81nZDMzrzKnqKCLVewUK1imh5IaeujY/MDnyozgT874ZBvyC4MGN4kUWayeJmg3DUKYzqcJ/I+HNx7O/L5TPnzjCumoTFKBT4ak8Bvgv0HUUNG0z4LU2SHvQF2VGL07dQgHb+eQfYiciFzlX+c7WUz4cw2EzDaywhHCzIsoFmkT2st1OVJn+n6f2QLA7X/hWVGggXJ3ZffYA1ER7kTwv5kX9vro77B8Q6a1a83syvHki29lsz+nEVKuIUCraUSRZvTiGma4+n0tuBTKCivrreqH/56sWg0tIS3wMI1dyQ1not1LnZ5RnP62G2Db2XwHcn6l/1qb25vZA+wJtoBeVz9bBVO6qGnXS296BGPfCe+kii+U9yN1tzaV07srPBMKISHrPwL0eW5Nzf2rtTb6VvWXEMSIaSAQZY7KebXiXecZGp2S6fDtnz6ZejVIb4ODOWc7wcQu7T
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|8060799015|8062599012|31061999003|461199028|15080799012|41001999006|19110799012|56899033|1602099012|4302099013|440099028|40105399003|3412199025|10035399007|102099032|12091999003|11031999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?u9CIkYGJeGN+leDy3o7Bb6H15WDb0tWA/QWLj2xM+Z8+Fy0IAwE/AZxiL/Wr?=
 =?us-ascii?Q?0yJXNJ7Q+JNCIN0NxjizDPCIKnDd5GJdNMiqS632vue/MWQeIKdYRyYs5Gdn?=
 =?us-ascii?Q?xksVt2JHPjxavFpWc6KPVvdJlk6McDw//shCEBN/T98m9gsz7D1pgxeGao2h?=
 =?us-ascii?Q?IdaT6Z2IwanocEJSQsKhNUU8ms4MOxJ4zz9tD0FzRY3mcqB/uNom84eMuYBM?=
 =?us-ascii?Q?Hetw3Ks0cQif1QnV6WV2nBCCt5aU0DS3tCwD0X5tgnlivp0iWI7HqLE29Z86?=
 =?us-ascii?Q?e37JRXUG03M8UKeLSxW6BrmpvHypT7rocZ0kk9D60Ml3ugP79/drxuOsZAHa?=
 =?us-ascii?Q?vCzvig0d/q7d168L07JjY2yp/0c7vSycMSokN9uKxaPUkCLxd8iA+jKUWoDx?=
 =?us-ascii?Q?k5lg9vXRDWl5tuJzvWBrCGHohHqmdt22STiTNFH3B2l5dF0P97n4px652wWL?=
 =?us-ascii?Q?6g39IJjmyQvzMKKMhgq4EkqRzG0kASYGHngZ0zRZHrPVdCNYfaupl2hElhJo?=
 =?us-ascii?Q?kCpT89+3sOm7dnU3b8J0j04Ve9Fm93vFdCtviD/gPyj+ORFmquIrAlhHpg4u?=
 =?us-ascii?Q?OYzRn3nJf75w0TbEm7qq8mzinxEjmKSMkIg2PMHDlbxahu6xvZE7F1wFji5s?=
 =?us-ascii?Q?WDRpgGlgr7pUBdC/yDwFVTy3u8AHc6oQrCTUvcoVJlAG+0eMuKpx11S8eT4j?=
 =?us-ascii?Q?T5QIglN3fZYd+xHhbf9QEp64oWp0KlcrEHYFrZu3oRGkKnmcOyhdr4Yp39Tz?=
 =?us-ascii?Q?HrilZ+/E0w08tqEhFQC1SWe3mwjOSIPe9wUUdc/Ff76BFWlblT1YVx2T+saf?=
 =?us-ascii?Q?R8Ckm7Dtj302ZOOU+f8tCYLVlmE2A0Hympupltljrw2Yt8Xae8ykt1js21aq?=
 =?us-ascii?Q?15f0P/DzdjR1rGLPJMkRRRlNb+P0ZfckHZFyY9gP/5YaL0KIIoHxxeroOqEW?=
 =?us-ascii?Q?fDZjz08MDd4tbVIXg38qFPax2JYmmNF7/WQ/X7Ud/D6fRzmotTRvNhqdDDp2?=
 =?us-ascii?Q?xKxgPt9mbkYA4Cu7wKRq9ywVudoHFi3Z4i1jMFZW9ZX/snZnAeK1M+a58vKH?=
 =?us-ascii?Q?bqtvN9dUF9oq2JnSyI3fODq2baK40PjsCUQNoBRC+mcsRZr91123QEP0dOp0?=
 =?us-ascii?Q?nwmljrd/a3waSXnm198spq5rv2UMxTXIbJ34jI4eOW5MrTGbWfNVFr0vxfGs?=
 =?us-ascii?Q?aevn8bPoM9JGJFmZw6a9diDIRvKLiy5Lrx83sWyso1KR1/q2I8I9BHJ9DCJR?=
 =?us-ascii?Q?6c1YLqD8kevjZdojb205Ilr5m0ZPeTBxXvmrsC/HrUKYW7qAWhAuSzZCnbl/?=
 =?us-ascii?Q?dx9bV5/Ha7FI2iYLJeaiTiBzj64E3E+MNW/tWDN1I0Db07UmZowHWiQ6mP1C?=
 =?us-ascii?Q?9NzXiTA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gr5zt71tvcxiPhZAc3j7B+HG/zk+4DxzGPLtksBuRMEkdofRmhLqEi6eovjr?=
 =?us-ascii?Q?JHNKRLe7SF1ZeNvKCyl2+TGZ/Pgd8mvCI+YFbJsjXkMfa0dGN18z4ejGpnQD?=
 =?us-ascii?Q?gVmqDjEe0SGD0rdmW6lYi9M3EnBV5eI0ujUm0d8RJFcKyQJrL4eb6AL+jHdm?=
 =?us-ascii?Q?Z41BGiWEloLec72tBBLH/ajNZcMxqDD0Js+41z9+u7YR4A7kCvST4y/JBcc4?=
 =?us-ascii?Q?CQPhxMstNThJnAH+NhRWZaxwNuWE4DwT1sw/UV8e2Thd5ci9+29POLqLgEke?=
 =?us-ascii?Q?PLyngkQvr//7F1LTwhWv8gHDfXdNVRGqN5wkCvIrmxrMWY2vlN46Grt/gcyE?=
 =?us-ascii?Q?6OD5Ne88oyDZCB/+YRDnHj07aSsPwdO6cWz+Tjc8UeAp+8h5OA/rRxv57Opq?=
 =?us-ascii?Q?nmeVZXILP4g+VlThHllBkiED1o+Eft5clMTPeZA2Ha/GEjr+dgW7tYvy9+6P?=
 =?us-ascii?Q?Y+46n0VHDkOk/Scjt+ZDSEKfm7noE+5ptEbUnu2tBE6vn21YdqJYBLMrQgXV?=
 =?us-ascii?Q?kor7wk/JCP9qkTXmXi3IVzRjJqcXzruVcjd3S7YnIUNHNyFX2lF0gpDTMzEe?=
 =?us-ascii?Q?F38dPuu+UFfyyahHzySJmHV0XnaeuUwhfA2i8un2xtmO1XJ/lasV2Y61R4mM?=
 =?us-ascii?Q?vx0RbQRubBbLtqEYzmZXADnS9c4orYR7vdl0Abha5LLktjB0tdtVPxLEJs9m?=
 =?us-ascii?Q?Kn1mvpmjmNYYhSsibPITNa7NJ+vZVG83Rf2ERv1qgBzqjT/0IS5ghygZo/ki?=
 =?us-ascii?Q?wav/rWnaHK9KIZfhrvdaiZeWLG959bA02x7SOeMY8Gx1l9kygwNuOcTeKTOz?=
 =?us-ascii?Q?rifdepEangfZLV6TwKwUWABhwOogk0IO0gL+mStb7txPhgpmgXttgFeVNRQ/?=
 =?us-ascii?Q?+iJI5S38vO7084g/EpPssWX1u090wPgV6raSchMgSSwPkGAaA5xUyABy7vA4?=
 =?us-ascii?Q?V04/7yjVOKGCq7OZ91fKjMPBpcZ97nbEI5+Nidk+g9DfQwPOr5u/IxivUWGE?=
 =?us-ascii?Q?ZPec+N1XZZ4dhiXrxKx7doUPeFYCSDNrEqWmRucRF/1yd35Oy/kYzDBKDNJ0?=
 =?us-ascii?Q?v0pZTwVS93j2ez3nVWbKEYTQp481dQ3lfozUpwlajoaZQY8yJNPlNq18SMtg?=
 =?us-ascii?Q?tTsWr3C2SV+m6rL2/dF6dnpryuDnE4E3ABRe814N6C8z+cjhr/k90slj4LOX?=
 =?us-ascii?Q?AdorunrCRrLIr4+csogzAPtQ8Vh+aCd2zu11Amcq301V3ad+mBThU4UqVno?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b0df93-836a-4c15-90b6-08ddef4f08b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 03:14:48.4007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8484

From: Roman Kisel <romank@linux.microsoft.com> Sent: Wednesday, August 27, =
2025 6:06 PM
>=20
> The early failure path in __vmbus_establish_gpadl() doesn't deallocate
> msginfo if the buffer fails to decrypt.
>=20
> Fix the leak by breaking out the cleanup code into a separate function
> and calling it where required.
>=20
> Fixes: d4dccf353db80 ("Drivers: hv: vmbus: Mark vmbus ring buffer visible=
 to host in Isolation VM")
> Reported-by: Michael Kelley <mkhlinux@outlook.com>
> Closes: https://lore.kernel.org/linux-hyperv/SN6PR02MB41573796F9787F67E0E=
97049D472A@SN6PR02MB4157.namprd02.prod.outlook.com/ > Signed-off-by: Roman =
Kisel <romank@linux.microsoft.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/channel.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 1621b95263a5..70270202209b 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -410,6 +410,21 @@ static int create_gpadl_header(enum hv_gpadl_type ty=
pe,
> void *kbuffer,
>  	return 0;
>  }
>=20
> +static void vmbus_free_channel_msginfo(struct vmbus_channel_msginfo *msg=
info)
> +{
> +	struct vmbus_channel_msginfo *submsginfo, *tmp;
> +
> +	if (!msginfo)
> +		return;
> +
> +	list_for_each_entry_safe(submsginfo, tmp, &msginfo->submsglist,
> +				 msglistentry) {
> +		kfree(submsginfo);
> +	}
> +
> +	kfree(msginfo);
> +}
> +
>  /*
>   * __vmbus_establish_gpadl - Establish a GPADL for a buffer or ringbuffe=
r
>   *
> @@ -429,7 +444,7 @@ static int __vmbus_establish_gpadl(struct vmbus_chann=
el *channel,
>  	struct vmbus_channel_gpadl_header *gpadlmsg;
>  	struct vmbus_channel_gpadl_body *gpadl_body;
>  	struct vmbus_channel_msginfo *msginfo =3D NULL;
> -	struct vmbus_channel_msginfo *submsginfo, *tmp;
> +	struct vmbus_channel_msginfo *submsginfo;
>  	struct list_head *curr;
>  	u32 next_gpadl_handle;
>  	unsigned long flags;
> @@ -459,6 +474,7 @@ static int __vmbus_establish_gpadl(struct vmbus_chann=
el *channel,
>  			dev_warn(&channel->device_obj->device,
>  				"Failed to set host visibility for new GPADL %d.\n",
>  				ret);
> +			vmbus_free_channel_msginfo(msginfo);
>  			return ret;
>  		}
>  	}
> @@ -535,12 +551,8 @@ static int __vmbus_establish_gpadl(struct vmbus_chan=
nel *channel,
>  	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
>  	list_del(&msginfo->msglistentry);
>  	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
> -	list_for_each_entry_safe(submsginfo, tmp, &msginfo->submsglist,
> -				 msglistentry) {
> -		kfree(submsginfo);
> -	}
>=20
> -	kfree(msginfo);
> +	vmbus_free_channel_msginfo(msginfo);
>=20
>  	if (ret) {
>  		/*
> --
> 2.43.0
>=20


