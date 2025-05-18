Return-Path: <linux-arch+bounces-11986-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47208ABB1A6
	for <lists+linux-arch@lfdr.de>; Sun, 18 May 2025 23:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324911890519
	for <lists+linux-arch@lfdr.de>; Sun, 18 May 2025 21:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA3E1D5AB7;
	Sun, 18 May 2025 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pDMstHOJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2022.outbound.protection.outlook.com [40.92.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497A02A1D8;
	Sun, 18 May 2025 21:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747602949; cv=fail; b=hFGBpiTgw0jKJ00BFJswGgEdbSoJWV+HkDOMfAaKRaZ8RIZy2qHreY55kEa6jyq5OXwcfPJojdSIXmRb9QBEF9+LdXihu24PbdIwf/vmbN5aiGAL1n5jJLvmajfQPa4dmCQApCCn3+0h8AW4ADyO8j+psU6VzpOtlpszU0ppg0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747602949; c=relaxed/simple;
	bh=E4fTPTvY3h9RDGGQkxy6i6LRBC0zunxeuUBdIlK69g0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HypFCuZOlEEW7U2lYoXVHXXzgcpkFoOSBY411P4tBOKKcu8nzHHmelZqudNthzJgbjjgSZXnbWA3JTQyls4zbq10L9uc5+3LUDcv+decOdBlAEZMwkh65g3XekHq4MBL1GJkAvEd9vgL3K74R7NT7zXSyMqqm0mj+HwYV9dSWAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pDMstHOJ; arc=fail smtp.client-ip=40.92.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6DPwUlq15w4ELVw9kbZ/uvpowxYqhHftrx7UIJUwqDWsW7+2F4ut1dstNokDT+oRi67wSAIhjn9Ucf8aVA33vg5UvysRxvNAabIYe+4socPjvv+6QmXmA6j3LJhED7vC52G5VM17tKhZW8OUvAPgTjzE17gLM+higO9bHSY62Pqial0jmiRXYiF5ACh5ciaICpv81+rYcKvHM4KB0+xzDV4tPJyQP2JLRgUMWqvxcaf+9SFk1T4GmtpGtC02ZcwV471B9AqQ+xMH1NeHjh1MADs3ha3E0gUVDgqA0qPAPS2xDEfojO/9loS+sgiIufAJPqJCglc0j5nKm79cLRSuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/iPXtK2r2w4CWh9ZVCh6g8Ai2YvbAV4U00m5cVnNNk=;
 b=uTZE7hQNlO7ON/QcuA3GhbtUWAP1eS+KIW3lwe7AYBwfzt7xAypnsTz8TaHljfRXX4SCQrheA8L0OJHDnchNq5yMnXRtybM2ZUsGfuTPl+fMy49QNJcqoLcqQl+SdseFWFe7vqHTRynZsjaV9U4s3QxrYSqnvSjThzFFY//RXWQW7YVMo2xR1mpjGhVZsQGPePnBKXYg6vXOMqA1Lrcfyr+N1aCe2FxAvXTfuwvotAySVnN6UQVNtczUeYEv+slv2JWZii66EgDPIRyGxqPzhF2bxRB4djf6wYRblAQPa8uoXOYgLecVAoJQxJ6IXV9TOqCvyLqNKCjZYDn1D4AWHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/iPXtK2r2w4CWh9ZVCh6g8Ai2YvbAV4U00m5cVnNNk=;
 b=pDMstHOJT3KViM0FxV9HbDZceI8P+TxzKu1+VjEboukLFbrbWP5cHI/z07mEv3rN8gVN9rM6UmOFs5q2YMnJp0rC++mbBuzcY4WifruqOg7/sOUezdTQ1z0YrXkvtcspKvaFzM+T+Wj6FWQgW6IkFJCHjdnnEeijIQ+6NQkYcD7JO4ABm5L8UQx5CPcboSVOwgnBBHxx8Lgmbwg6Oqudw8TahyZxT0z5xjBas70jx1fjJeuTDeWO/9P8DxikjCKEcdwP12nRLRMLuo3ylW1G+7KmMGzlWu2xNbZY6dPkgf8m+rmHh+xnPorpz/a42Ojd0+F5IU20//up9ihCAOa5eg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB9189.namprd02.prod.outlook.com (2603:10b6:8:10b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.16; Sun, 18 May
 2025 21:15:44 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Sun, 18 May 2025
 21:15:44 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bp@alien8.de" <bp@alien8.de>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "will@kernel.org"
	<will@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v2 2/4] drivers: hyperv: VMBus protocol
 version 6.0
Thread-Topic: [PATCH hyperv-next v2 2/4] drivers: hyperv: VMBus protocol
 version 6.0
Thread-Index: AQHbwsmsdQ+TvazRlkucbSBndz90/7PTw7fA
Date: Sun, 18 May 2025 21:15:44 +0000
Message-ID:
 <SN6PR02MB4157507E1E57B52A32DDF0B5D49DA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250511230758.160674-1-romank@linux.microsoft.com>
 <20250511230758.160674-3-romank@linux.microsoft.com>
In-Reply-To: <20250511230758.160674-3-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB9189:EE_
x-ms-office365-filtering-correlation-id: ebf9606f-9249-4a01-6e11-08dd965126a8
x-ms-exchange-slblob-mailprops:
 EgT5Wr3QDKyPkYWRuRja31U+70CKwIFkuOLo54lOdj3ib1bvE/4B8aDyFjQzaCE3uYOT4mJmpJ0+P8CFHYMWCvy+MiM9RXx+m2i/7O326MQzqTRQLHbJYIRruDjKsjaiDxGpJhaFb4wRPaLFB8sDKf39WnidXrPegBZxguqBgKE+bpJ7eYZbK4N+T6IIN1leMb0Z0j90kMdpeEaTrk2kGfGYHdrYCSbkOa9ANgRhMBKkOEy+Vxt9Ucpu8Yt/zjfHVisTe0BIhYdglPsJujYhKSQBDbiMvH5udSAfDQfwgSx6VIIbbtTM04MRBJhMnX+xKLr+09k9UTaowVVPEllx23o6un2AYiwr3VXtGyOd3VvxQLmxxpwrfjgAlZInF/4KGc28d8VV2LHTrBYDEy4G2v0uYNNjPEzkJDY+0N8m16TUd48FV/AEtdn4eWviN2XaDrUACGnXFNa2JW0bm38QhuRMLKoVCmk6K1AK/0NfBBdbKeCJS+xZwW5LjED2U0yVzL82AR4N28UU+3AWVklcgcRk+UmTAeHxR0Y8NNtPFzHjON9C4wtZ3lvKvHb4jxlbI795vr6x6amjPeOf6kJs8tsqWmG7QEkZkEuTexFuA03tAKD9QEgMkXtDduoI9bWudhjuJIZqWqGaQBf0NsjCMcVRmz0/s37HPDxE2AfUwVO2+0ta3b4nEoXAFYa4OgymPH9OuBRl23vUGVYEt8Tms34VxyL0ecS9E+1Uz/k9n4A=
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|19110799006|12121999007|8062599006|8060799009|15080799009|3412199025|440099028|12091999003|56899033|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wFhjetbTeOAbz3TN4+lLfH0tm5wUaYEPweABP0e6mJMG8Rj9110RkNS2MYvJ?=
 =?us-ascii?Q?y7aMgRnr0ZZskPIu8UWuOI5ICqhDbFWGkQYDFUGS/9dNDpXideEAs/a2+tCj?=
 =?us-ascii?Q?TOdL7zkMA0CYkqCTH+be5XkyNqHhynxDQaSmABX4DwZzgP6OsKxzWFeaioGW?=
 =?us-ascii?Q?W0tavan4+KG6phB5Weli+Zbekxam2hiba7Vi2njgHlJldPB2az3h3jagmNVt?=
 =?us-ascii?Q?QQMevA2fOcGBLmtH9U+n/fMv/L6w4m3AqpB3wHhuTgEdYOZKAbG4OXoCOkBE?=
 =?us-ascii?Q?J264M4mmOyLHYez0Qw6jts/VhlO3BKuIoidfssDZ5SsW4IAhAjPPIgjhxEbk?=
 =?us-ascii?Q?AaG8aq6tXlXZEmgeMO/UYKCZsOU6Uwxv2TUz0p6La797WCF/vFcucACu032l?=
 =?us-ascii?Q?eLZvDVZk5IaWGvEYN3YyWV191Ym7jKQJ56t7Fjb+dMOhQ76NA4XHiPjVqln2?=
 =?us-ascii?Q?x9/oRZv6xcmmq7hoaDunlDLqnKet/VQtw9y9n8zOX/bi2sDMJFDxGsjMh0/f?=
 =?us-ascii?Q?MOuvpRoIJrdc60xKsAG+gazT22DipMOZswtn0gKem8odenZCmwRbrFjQqILz?=
 =?us-ascii?Q?Wya7ut4WmLODgx56zsDOpL+lZxu5hnAZAiWKvEflqcDqnEQBMZAM/Pg0GDPZ?=
 =?us-ascii?Q?Jxxh+soKDJoX+jwKKkOLvQQYhMEQyjA4ZpBgygD97mpGkN3t5Er0HyL18xQG?=
 =?us-ascii?Q?pLlSOvPHWkddSLu03SomDP9udrE0NBbp6W1f0vc3hRhUwshHYArKmetLANNL?=
 =?us-ascii?Q?AJBoUy0pgVyT1ovkfHEnMdlyPdeJQ3bWAw+/NOVFgyLJ/hSAMpHad3Ck0vIw?=
 =?us-ascii?Q?fQ9wAHZFcYvoDl83j2KwVTgVMI1Gme/o1qefHmZQDt6Elj7Z7AsGgjZGHlvg?=
 =?us-ascii?Q?j86Y85lJoo8e9LPtaAEraObKn/P4Bs68fHjSQKd1H2SBzNJOD+3WES56JK1U?=
 =?us-ascii?Q?dVslS8Xl+4m321CPr7UFb6NmREfxLSzkAOKPh0MaAh0xf7tSqsz4Yn60/Jx4?=
 =?us-ascii?Q?S7CvhjijCyGk0xREU7xXX845kEBpqMxRTb6yUPScfcZZgbxgqjWgVtrVPSY1?=
 =?us-ascii?Q?RtNaFR9ZGjw/K/JZd8eH760B0Me2JElDQmdikhkGA6FngS3kLr6fTI3If3Up?=
 =?us-ascii?Q?rjqfCvu3jPyV141qUxzh7qnVSV0qIB7h4j/1/G+EIcuw5MNZfWlBs3A=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Dj9zdei9a2mMlHmHe0iPHlo8uy1YWNuGEOKbt1dENzuu3B49kw+LrYaq0/zU?=
 =?us-ascii?Q?8Uq9e6z7Le8E0CVMIdYT1OTf/RFzeIJIJjCKq/du5FG80ipeNeVQHdeKBhKX?=
 =?us-ascii?Q?v1QCIzVbwLwUqdyH+hn+b0lYbKMgLD31ZXjl68y2a99GyDU6D6Eg9R7Liv3V?=
 =?us-ascii?Q?t43CrfgzmWPoRif8gYyJ4u/3yzHSwxX07MvyY5yNCXm0ISQDHu0usUE/ADqU?=
 =?us-ascii?Q?d0jKTdTC5uMat5mivhwRynOBqnbv0TrwVF8QIMmhWxoe+TOID1L7wOpDwbbw?=
 =?us-ascii?Q?z+2yTyHKZc2KeVVH3gKUkC+6o+ajTPW+NTmYCkZoDKeuUphTm9s+FSoGneWR?=
 =?us-ascii?Q?6lo19M81pQn6RkZmDXPXLMTuY82ZHC+Bjw2vb3LO/qc4pG/N/giYYdkUSVL0?=
 =?us-ascii?Q?rA+ktNtOGM7BrgCWicuolbshrh0vmqh9A83FS2/Q9rLIM+d8OtseLdl9Njq1?=
 =?us-ascii?Q?7MG2JWPS8r08XfQDVIgNz7Si4woGcG8uzfBfMCD6+TXSF1SK8l2WxwCdevit?=
 =?us-ascii?Q?rbVh0bwyu49Pj0kZcTWry4SlTawuDjm0nJfQk2epr6NDazc8YQCfoQAEtsTs?=
 =?us-ascii?Q?nAjIUnM/IG2oPna4qut7CDOmh659qDuGRrBiYb2ItGPngGf8Xqkm6xoeqX18?=
 =?us-ascii?Q?H7QwVSke62QxlAEC77nglEVM1c2lGh3yB9slK+nc7Aij5IGFvE7+RyTM/DQw?=
 =?us-ascii?Q?mQPPmZi1HSvcvgn1QfaUxltTer5y8oD4+UH0mtfz65VeEsxCdjLSCcpK0OfD?=
 =?us-ascii?Q?ZHR+GnauKSaZP9fR467fLRrexq6rqmdFdjch2s1EsR2ulZ27KXEin9zABjFs?=
 =?us-ascii?Q?OlhVYRB7En+hH+5i4oWuSJaAZc3DIe4GiXwhpejXA1rIaK1OpWzHV5AvCc+K?=
 =?us-ascii?Q?99jTaZTiKfeCKLXU11/dlgAxVql3zJtmzTAYMlOCu/VDjj3+/+3hR8zRAXPp?=
 =?us-ascii?Q?etj2oyW0sr8/3afeM4Av9xZQ0cfDtTP0Sb+9YrAPFaEij17+zv/ivq9OwnPM?=
 =?us-ascii?Q?USVftqBDFcfMwmjfhEYrNWSFsxnVeaEQUHsS+ZW8NfNliGNvnwozTrb5ayG4?=
 =?us-ascii?Q?/sDLhSZR2rv2v440UB7QrLx+OENaGHNaXT/orF3nGsbowv2A9vL9UdImxkx6?=
 =?us-ascii?Q?iNDfqH0+PlCZaERWoTV4KdBgWGUyJ2/fIfqIrKkYL2QrzifI8zP3ulRWSFo1?=
 =?us-ascii?Q?x3R+zXCyKy7jm3EQKcRlyegKbS5w2zOkYWZbezhRSsD0ul0lYQ2kyZDELCc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf9606f-9249-4a01-6e11-08dd965126a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2025 21:15:44.1072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9189

From: Roman Kisel <romank@linux.microsoft.com> Sent: Sunday, May 11, 2025 4=
:08 PM
>=20

For the Subject line, use the prefix "Drivers: hv:". =20

> The confidential VMBus is supported starting from the protocol
> version 6.0 onwards.
>=20
> Update the relevant definitions, provide a function that returns

s/definitions, provide/definitions, and provide/

> whether VMBus is condifential or not.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c         | 12 ++++++
>  include/asm-generic/mshyperv.h |  1 +
>  include/linux/hyperv.h         | 71 +++++++++++++++++++++++++---------
>  3 files changed, 65 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 1d5c9dcf712e..e431978fa408 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -56,6 +56,18 @@ static long __percpu *vmbus_evt;
>  int vmbus_irq;
>  int vmbus_interrupt;
>=20
> +/*
> + * If the Confidential VMBus is used, the data on the "wire" is not
> + * visible to either the host or the hypervisor.
> + */
> +static bool is_confidential;
> +
> +bool vmbus_is_confidential(void)
> +{
> +	return is_confidential;
> +}
> +EXPORT_SYMBOL_GPL(vmbus_is_confidential);

Spelling out "confidential" here, and throughout this patch series,
makes for really long symbol names. Have you thought about any
shorter names to use?  The 12 characters in "confidential" makes
the code somewhat "heavy" to read. What about "covmbus",
which is 7 characters instead of 12? That also aligns somewhat
with how "coco" refers to Confidential Computing VMs. There may
be other suggestions as well.

> +
>  /*
>   * The panic notifier below is responsible solely for unloading the
>   * vmbus connection, which is necessary in a panic event.
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 6c51a25ed7b5..96e0723d0720 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -377,6 +377,7 @@ static inline int hv_call_create_vp(int node, u64 par=
tition_id,
> u32 vp_index, u3
>  	return -EOPNOTSUPP;
>  }
>  #endif /* CONFIG_MSHV_ROOT */
> +bool vmbus_is_confidential(void);
>=20
>  #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>  u8 __init get_vtl(void);
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 1f310fbbc4f9..3cf48f29e6b4 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -265,16 +265,19 @@ static inline u32 hv_get_avail_to_write_percent(
>   * Linux kernel.
>   */
>=20
> -#define VERSION_WS2008  ((0 << 16) | (13))
> -#define VERSION_WIN7    ((1 << 16) | (1))
> -#define VERSION_WIN8    ((2 << 16) | (4))
> -#define VERSION_WIN8_1    ((3 << 16) | (0))
> -#define VERSION_WIN10 ((4 << 16) | (0))
> -#define VERSION_WIN10_V4_1 ((4 << 16) | (1))
> -#define VERSION_WIN10_V5 ((5 << 16) | (0))
> -#define VERSION_WIN10_V5_1 ((5 << 16) | (1))
> -#define VERSION_WIN10_V5_2 ((5 << 16) | (2))
> -#define VERSION_WIN10_V5_3 ((5 << 16) | (3))
> +#define VMBUS_MAKE_VERSION(MAJ, MIN)	((((u32)MAJ) << 16) | (MIN))
> +#define VERSION_WS2008 			VMBUS_MAKE_VERSION(0, 13)
> +#define VERSION_WIN7 			VMBUS_MAKE_VERSION(1, 1)
> +#define VERSION_WIN8 			VMBUS_MAKE_VERSION(2, 4)
> +#define VERSION_WIN8_1 			VMBUS_MAKE_VERSION(3, 0)
> +#define VERSION_WIN10 			VMBUS_MAKE_VERSION(4, 0)
> +#define VERSION_WIN10_V4_1 		VMBUS_MAKE_VERSION(4, 1)
> +#define VERSION_WIN10_V5			VMBUS_MAKE_VERSION(5, 0)
> +#define VERSION_WIN10_V5_1 		VMBUS_MAKE_VERSION(5, 1)
> +#define VERSION_WIN10_V5_2 		VMBUS_MAKE_VERSION(5, 2)
> +#define VERSION_WIN10_V5_3 		VMBUS_MAKE_VERSION(5, 3)
> +#define VERSION_WIN_IRON			VERSION_WIN10_V5_3
> +#define VERSION_WIN_COPPER 		VMBUS_MAKE_VERSION(6, 0)

The internal code names IRON and COPPER should be avoided as
they have no meaning outside of Microsoft. I think IRON is WS2022,
and COPPER is 23H1, though maybe that was never released.

>=20
>  /* Make maximum size of pipe payload of 16K */
>  #define MAX_PIPE_DATA_PAYLOAD		(sizeof(u8) * 16384)
> @@ -335,14 +338,22 @@ struct vmbus_channel_offer {
>  } __packed;
>=20
>  /* Server Flags */
> -#define VMBUS_CHANNEL_ENUMERATE_DEVICE_INTERFACE	1
> -#define VMBUS_CHANNEL_SERVER_SUPPORTS_TRANSFER_PAGES	2
> -#define VMBUS_CHANNEL_SERVER_SUPPORTS_GPADLS		4
> -#define VMBUS_CHANNEL_NAMED_PIPE_MODE			0x10
> -#define VMBUS_CHANNEL_LOOPBACK_OFFER			0x100
> -#define VMBUS_CHANNEL_PARENT_OFFER			0x200
> -#define VMBUS_CHANNEL_REQUEST_MONITORED_NOTIFICATION	0x400
> -#define VMBUS_CHANNEL_TLNPI_PROVIDER_OFFER		0x2000
> +#define VMBUS_CHANNEL_ENUMERATE_DEVICE_INTERFACE		0x0001
> +/*
> + * This flag indicates that the channel is offered by the paravisor, and=
 must
> + * use encrypted memory for the channel ring buffer.
> + */
> +#define VMBUS_CHANNEL_CONFIDENTIAL_RING_BUFFER		0x0002
> +/*
> + * This flag indicates that the channel is offered by the paravisor, and=
 must
> + * use encrypted memory for GPA direct packets and additional GPADLs.
> + */
> +#define VMBUS_CHANNEL_CONFIDENTIAL_EXTERNAL_MEMORY	0x0004
> +#define VMBUS_CHANNEL_NAMED_PIPE_MODE			0x0010
> +#define VMBUS_CHANNEL_LOOPBACK_OFFER			0x0100
> +#define VMBUS_CHANNEL_PARENT_OFFER				0x0200
> +#define VMBUS_CHANNEL_REQUEST_MONITORED_NOTIFICATION	0x0400
> +#define VMBUS_CHANNEL_TLNPI_PROVIDER_OFFER			0x2000
>=20
>  struct vmpacket_descriptor {
>  	u16 type;
> @@ -621,6 +632,12 @@ struct vmbus_channel_relid_released {
>  	u32 child_relid;
>  } __packed;
>=20
> +/*
> + * Used by the paravisor only, means that the encrypted ring buffers and
> + * the encrypted external memory are supported
> + */
> +#define VMBUS_FEATURE_FLAG_CONFIDENTIAL_CHANNELS	0x10
> +
>  struct vmbus_channel_initiate_contact {
>  	struct vmbus_channel_message_header header;
>  	u32 vmbus_version_requested;
> @@ -630,7 +647,8 @@ struct vmbus_channel_initiate_contact {
>  		struct {
>  			u8	msg_sint;
>  			u8	msg_vtl;
> -			u8	reserved[6];
> +			u8	reserved[2];
> +			u32 feature_flags; /* VMBus version 6.0 */
>  		};
>  	};
>  	u64 monitor_page1;
> @@ -1002,6 +1020,11 @@ struct vmbus_channel {
>=20
>  	/* The max size of a packet on this channel */
>  	u32 max_pkt_size;
> +
> +	/* The ring buffer is encrypted */
> +	bool confidential_ring_buffer;
> +	/* The external memory is encrypted */
> +	bool confidential_external_memory;
>  };
>=20
>  #define lock_requestor(channel, flags)					\
> @@ -1026,6 +1049,16 @@ u64 vmbus_request_addr_match(struct vmbus_channel =
*channel, u64 trans_id,
>  			     u64 rqst_addr);
>  u64 vmbus_request_addr(struct vmbus_channel *channel, u64 trans_id);
>=20
> +static inline bool is_confidential_ring_buffer(const struct vmbus_channe=
l_offer_channel *o)
> +{
> +	return !!(o->offer.chn_flags & VMBUS_CHANNEL_CONFIDENTIAL_RING_BUFFER);
> +}
> +
> +static inline bool is_confidential_external_memory(const struct vmbus_ch=
annel_offer_channel *o)
> +{
> +	return !!(o->offer.chn_flags & VMBUS_CHANNEL_CONFIDENTIAL_EXTERNAL_MEMO=
RY);
> +}
> +
>  static inline bool is_hvsock_offer(const struct vmbus_channel_offer_chan=
nel *o)
>  {
>  	return !!(o->offer.chn_flags & VMBUS_CHANNEL_TLNPI_PROVIDER_OFFER);
> --
> 2.43.0
>=20


