Return-Path: <linux-arch+bounces-10958-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D95A69343
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 16:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16A1F7A346B
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 15:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9491C4A13;
	Wed, 19 Mar 2025 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XYRmszfl"
X-Original-To: linux-arch@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010007.outbound.protection.outlook.com [52.103.10.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE19CF9DA;
	Wed, 19 Mar 2025 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742397984; cv=fail; b=rJVtC77TUf9adE0aWr0AfY8ogJGAo9Q9UePKlH1qzePNsJlXigy3cHtCDgUV05qjijwkURMJdBD3GWzIcKvtnbyPTKuVfOhi+UL9OPUT4T/gxxuUX3OH4OiwhEsr7uvFiGXxEOnrh/JhILQ6ph1BOgvju43uv2F6jll+Q36TsXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742397984; c=relaxed/simple;
	bh=BsqalKRBGQHMZYZCW2TBkWWwFoD499DeSKYhc6WzmRc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mW6Skp9/D83n9InSZ6AqZnv7TeR6GuSy79FGYIdkfdEj76grdWI/DvkyEW/UuB6QZRM1N6LFOntEV5DlW7pZ+/rjuZluLsQJt8UNnt+q7E/G3T5T8sq10x6Xkd6rvnmnWWWEgK9iigq4nPmpoWYdF/yeMQTNtPu+TvsZNpeHO5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XYRmszfl; arc=fail smtp.client-ip=52.103.10.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8Kys8qJvMxEvuXf63os3XhU4xAQx8o/pZBLQzgnSwQwH1raoyGvGxvlvoXScdnXIIqypnS+7HnQjrsRW/k/BWVWo+ytF+XL3zwx4x0EduGeXvMOD3qtln1A+y/S4aNBJOFqZZWM3AlB5nYSYdYi+f5n/E20l8nIjJK7TjlgVq1DP+TNQsJ8+B9XNwB7qTBBKqUCyKPwjs+SFo8GsDp19lQHDZEKAr2Ulcj5WLlsGdhtiGjbl9ohWyy0JxTA5FJPAYXbPTEH1XYJkits6MCMvN/jIg0m+GQBs4wIzRpbphJB+xK+INdJNWEf8319LnfACfm41rpYAZbKaaqFoch8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bagEGXFeCf6g39RY6S7vx8WP7V7WhyENHVEbs8MBkAY=;
 b=uQeloKoJ7LXNk0qHqYiK4P7qlO+/r+6T9aCfyvDsVE+/NLezvo+yW3eyKhoc2SgsygmyXJd2m85JZEAGbMubFFdMGjQuh7rZzBgrds2vVdUA5Q2wYwTvULIc3r+iT3ebaBinQBJsIovo6cTyVqF8iAw2d5UAlRdTNDic6VEv3evk3ORiGpOwJcFKJ3i2DTqQEKpwRh+2DJPiZxX8hvyzEDlq7ryb5kruscVzEAsUF4GdvOVye+wSyDqhfKGVeN7iNcLpPEdSjN9seJEiiZGUFHseZtLQH+x6DAoE8T1rnBmHMcSG0N5M2xGj4mflu1RmKjyAZAL0Jer66R7WHIGsZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bagEGXFeCf6g39RY6S7vx8WP7V7WhyENHVEbs8MBkAY=;
 b=XYRmszfla0UR1MbwysmcxbmsZQFJb8sQ/dwhIqd5HOZLmta6D3DvIT6EpDvifnCXFVk4W3n3MN5yh6uJEVv83EYgJe0q10H2zdbXb3TtNjMw4IIzjUOTzHqVfryvP/S65vkE6ojQMZFWwciAkk16nmJvvL/oiCtf9g0E1Wrdly/fcAI0lf+yssoAMJRwUM5XH222Kjw2hBkTHs1KoDAZtLFzvHtIpr2ZMglSrwj3FIdiKllTo8jvHZ4uBILc21Kpp/GuBtx5VUJI9hTL+QxJWUUQK9pxgo1isyjeGxsuNBRFQ3Oq+mvK0moBNJ3R0Zjh+4sAhF6ot8X/8acxRQcgKA==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by DM6PR02MB6620.namprd02.prod.outlook.com (2603:10b6:5:222::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 15:26:20 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 15:26:20 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Kelley <mhklinux@outlook.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"muminulrussell@gmail.com" <muminulrussell@gmail.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"apais@linux.microsoft.com" <apais@linux.microsoft.com>,
	"Tianyu.Lan@microsoft.com" <Tianyu.Lan@microsoft.com>,
	"stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "prapal@linux.microsoft.com"
	<prapal@linux.microsoft.com>, "muislam@microsoft.com"
	<muislam@microsoft.com>, "anrayabh@linux.microsoft.com"
	<anrayabh@linux.microsoft.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v5 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
Thread-Topic: [PATCH v5 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
Thread-Index: AQHbiKNt140GtdgK20KtRyAXlJwH1rNxYTIggAha0QCAAAvV4IAA6oYQ
Date: Wed, 19 Mar 2025 15:26:20 +0000
Message-ID:
 <BN7PR02MB4148D51FFF965676AD155A3ED4D92@BN7PR02MB4148.namprd02.prod.outlook.com>
References:
 <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-11-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157BE8AF5A1CDD39CF31124D4DF2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <afd87eba-742f-4b67-9171-fd8486416b7b@linux.microsoft.com>
 <SN6PR02MB41574DE5535222985147134CD4D92@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB41574DE5535222985147134CD4D92@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|DM6PR02MB6620:EE_
x-ms-office365-filtering-correlation-id: 672b8ef5-7b68-42af-9527-08dd66fa669b
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799006|8062599003|8060799006|19110799003|102099032|3412199025|440099028|12091999003|41001999003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+b3tbGp0RWBgYKpApB13tp4JDnrlUshlkX/TTJ0JC24WqK/GZO1f1cJGDOGs?=
 =?us-ascii?Q?AkxcfOyezVKJKWhxCQxntiHqr80+EBR/bpw7gMsn0KT0zl8wAt/ekeeFDpB8?=
 =?us-ascii?Q?DxyV/HKLmjd+sY76fssftijg0ofNoaQM/xBm+/EKYuWfLifBbFwaHvv7Fo3a?=
 =?us-ascii?Q?UYtn2yQ9jRCjuemLPHjuWNRJE6mKJ0TnOLRTY5dXZwDWWhZlU2Eqt7pDfFgo?=
 =?us-ascii?Q?28mo4GhShXJrfSj2yvXyh7+NjHrsyTS/FjDTgW3KaBpzbzaq68t+aYNY1D8n?=
 =?us-ascii?Q?RGuCgqsO8xpAamdsixU+PGAUT5DMxLKRDil1V5lPNAzRd3f2sV2sNFc0ot1u?=
 =?us-ascii?Q?uxioTLArJ620JSltz26+3uc+hb7hbEy1auc0sSwzVCKq0Sp+mwqjdiOZ8Sjs?=
 =?us-ascii?Q?dD7qktLN0p1gWt1JJDcD6UJ50h6SgstIofRg5/+k6umePXe6GB1iPfnO6kH7?=
 =?us-ascii?Q?zSDhFjA6BZjDRq9bAtGfon29YfemEPXOi7oO1mEEI191Roo8LFA0k7SFlmIH?=
 =?us-ascii?Q?O2Zu50P+5xkKq+1a/4wrocxyLXaMxWNvqs9Qc8/QKCXmJ+5cmER1ZrQ86Pdf?=
 =?us-ascii?Q?YMhasxKOxEeSUkhmw9dlSkekSnscSmYEQReprGXIGUCUhFEekHU1XIwr5lEg?=
 =?us-ascii?Q?UmV0BaaWCzh2WODXFY9QARc2zhfAh8jXyvZgBjjVd79XoTlVNkonpci7PChz?=
 =?us-ascii?Q?2+FhnyYyXp/1Wf6mZyQzJbFDE+KAbAbaPqLYCxjxZB8EKKXWB6dyxHQoVuAZ?=
 =?us-ascii?Q?nyFPPS1Yw38H1oVuWed8PG3zH93gavveSYji84Yu82P/yPJeO2/G5Bf71+Rq?=
 =?us-ascii?Q?AU32kRY6vaCPf8aYsJYIg7GIOazoXPfsYiW5T2HVABRdRRpxIA0fXfitJFCm?=
 =?us-ascii?Q?0dfksc4vmdSr5mcJ3rob2wFR1o8XujBoXn2kyZ9+GC3O9G7m6UwpxjyzlLds?=
 =?us-ascii?Q?ua4KeAyXvHKgEzbdCK3SuLibuiBx0kAMET7bg6/qxVnDoRzNLFHYqizEvWgU?=
 =?us-ascii?Q?KCVx6o22kitWpqLebVTdN4NTq3i/XgUfR6rPeLnnrPo+rYXDbZqaF4r4GcmC?=
 =?us-ascii?Q?naW1vJ6SxsQj0xNhfruUlPSMf+ydeAtKxF7EKILXpYCKlBNfaIF5eJ2hgk72?=
 =?us-ascii?Q?c6hFtQowhahZIv6SDJ1cae2htZKEG83FG7YpYBdM5WXuZwMggCnn3YE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/djkSBd1q/14QvruGH+4K2vCPQDvuGjbMDhomOpYZqGepFnEBJWlNZazgjwa?=
 =?us-ascii?Q?ZFaLJH9GwoYq1tIvzPmxUJL4Czv2HAeIb/iIfFhU+IGUUbRZyW8g9YgVo0yQ?=
 =?us-ascii?Q?b4pBSh+ehnG2KjqWHjPOVDNclXhSsuCyCUbqcaf3ixhCPI3jE069sWGpP7Zu?=
 =?us-ascii?Q?Jh+Om2nBzm0udMp7T6RC1fmGFTqXiM860S+LivjZ1ubfiVY9Oxujejz+R2EV?=
 =?us-ascii?Q?Yu/e0ByDg4pKLqsbX2OQFHXhe3zmuqoZCgKdxxZrG0a9O+zWulM+xkwuifMi?=
 =?us-ascii?Q?P6dXhShvaLStY2BQj4Acb3FgU725KKqJkOIqBLxXLLIZm7qBi6pBL0nk1ZRA?=
 =?us-ascii?Q?I5lLFg3nI5L2ddnXABlEpuH+EyiMXT9gJFuQk4dNhiaJ/nLfW5CvBFqLzDv/?=
 =?us-ascii?Q?YOTFCnTdS2pHvyHa4+zeNgoyu1OZJXc9PAq1fi3Lltyq/r2VNsqT1JOA5b4K?=
 =?us-ascii?Q?++Uwxb0Qdsv3HaJYUN6zPBpoHt2sg84LHo7Hy4asvHXP+LBfL+cyZKaIqRES?=
 =?us-ascii?Q?4GvfRaNqCzK2ZxgLDsrTbiejPgEZzByfNBM/Y7Lin4EDFFY+R4Lr1qt7QKt8?=
 =?us-ascii?Q?ahwJjVKMDlBcMxH2JBsF+FrBwy5CGoPbYiTq8ea/182iBlJC3X4j+MP3rBS/?=
 =?us-ascii?Q?uadCBbwVTFOMYQUGydLw6NNo1zQo5z/6Hncq9UwyHJLfjg0rfZywia4vTZVp?=
 =?us-ascii?Q?GSK6uL7emyETDXAFfeg8hev2W5Cmez+0ZBuVvGjXIfLkjNZfhRJ/RjjB8YD0?=
 =?us-ascii?Q?Y/h/6ICZNUDULRrUyZvsVRmooyMCnPTUYGe6ytAa0XKz8scSi0EIS/V7LeK7?=
 =?us-ascii?Q?An6kqL//OJsL5DxNxUToczvTj4QSLJy+f/IZzUvV9S75O3dePfvkUD1iM5zd?=
 =?us-ascii?Q?6xzTN7ImRGClZmyoPwUyogfQWxV7UrHGkkcsTFu7CV1u9yg7LVTw3cjKIRBA?=
 =?us-ascii?Q?lIjzQY9VKx0F55qWkQAuAKGT7faXG3qEWxHs1bYBwqCxQA3ICfRIoJGPnn12?=
 =?us-ascii?Q?VMAN1pX5ZJM6IA6cETbi7gkex763uFN1Upu1sHC60wz/uRRbL/cAXHKJJhBJ?=
 =?us-ascii?Q?GBT+0WQYLJRHGLcQARVdw+zYpGsDrXYj2cmaNTIA+ilj+m9udjEZs3L6PfO/?=
 =?us-ascii?Q?hZOzn2lQcJRrym4qzbJpJ3mpEPxKzHpezs0ZPFwMZI/gei2A2Y0Wkjuj4p+l?=
 =?us-ascii?Q?fuaMTFukQL1Uf3DV1ohro4sDJ5kx15O81e4rqJn99hSUiqt7Mvrz8hroWss?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 672b8ef5-7b68-42af-9527-08dd66fa669b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 15:26:20.5662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6620

From: Michael Kelley <mhklinux@outlook.com> Sent: Tuesday, March 18, 2025 7=
:10 PM
>=20
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, Ma=
rch
> 18, 2025 5:34 PM
> >
> > On 3/17/2025 4:51 PM, Michael Kelley wrote:
> > > From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesd=
ay, February 26, 2025 3:08 PM

[snip]

> > >> +
> > >> +	region =3D mshv_partition_region_by_gfn(partition, mem.guest_pfn);
> > >> +	if (!region)
> > >> +		return -EINVAL;
> > <snip>
> >> +	case MSHV_GPAP_ACCESS_TYPE_ACCESSED:
> > >> +		hv_type_mask =3D 1;
> > >> +		if (args.access_op =3D=3D MSHV_GPAP_ACCESS_OP_CLEAR) {
> > >> +			hv_flags.clear_accessed =3D 1;
> > >> +			/* not accessed implies not dirty */
> > >> +			hv_flags.clear_dirty =3D 1;
> > >> +		} else { // MSHV_GPAP_ACCESS_OP_SET
> > >
> > > Avoid C++ style comments.
> > >
> > Ack
> >
> > >> +			hv_flags.set_accessed =3D 1;
> > >> +		}
> > >> +		break;
> > >> +	case MSHV_GPAP_ACCESS_TYPE_DIRTY:
> > >> +		hv_type_mask =3D 2;
> > >> +		if (args.access_op =3D=3D MSHV_GPAP_ACCESS_OP_CLEAR) {
> > >> +			hv_flags.clear_dirty =3D 1;
> > >> +		} else { // MSHV_GPAP_ACCESS_OP_SET
> > >
> > > Same here.
> > >
> > Ack
> >
> > >> +			hv_flags.set_dirty =3D 1;
> > >> +			/* dirty implies accessed */
> > >> +			hv_flags.set_accessed =3D 1;
> > >> +		}
> > >> +		break;
> > >> +	}
> > >> +
> > >> +	states =3D vzalloc(states_buf_sz);
> > >> +	if (!states)
> > >> +		return -ENOMEM;
> > >> +
> > >> +	ret =3D hv_call_get_gpa_access_states(partition->pt_id, args.page_=
count,
> > >> +					    args.gpap_base, hv_flags, &written,
> > >> +					    states);
> > >> +	if (ret)
> > >> +		goto free_return;
> > >> +
> > >> +	/*
> > >> +	 * Overwrite states buffer with bitmap - the bits in hv_type_mask
> > >> +	 * correspond to bitfields in hv_gpa_page_access_state
> > >> +	 */
> > >> +	for (i =3D 0; i < written; ++i)
> > >> +		assign_bit(i, (ulong *)states,
> > >
> > > Why the cast to ulong *?  I think this argument to assign_bit() is vo=
id *, in
> > > which case the cast wouldn't be needed.
> > >
> > It looks like assign_bit() and friends resolve to a set of functions wh=
ich do
> > take an unsigned long pointer, e.g.:
> >
> > __set_bit() -> generic___set_bit(unsigned long nr, volatile unsigned lo=
ng *addr)
> > set_bit() -> arch_set_bit(unsigned int nr, volatile unsigned long *p)
> > etc...
> >
> > So a cast is necessary.
>=20
> Indeed, you are right.  Seems like set_bit() and friends should take a vo=
id *.
> But that's a different kettle of fish.
>=20
> >
> > > Also, assign_bit() does atomic bit operations. Doing such in a loop l=
ike
> > > here will really hammer the hardware memory bus with atomic
> > > read-modify-write cycles. Use __assign_bit() instead, which does
> > > non-atomic operations. You don't need atomic here as no other
> > > threads are modifying the bit array.
> > >
> > I didn't realize it was atomic. I'll change it to __assign_bit().
> >
> > >> +			   states[i].as_uint8 & hv_type_mask);
> > >
> > > OK, so the starting contents of "states" is an array of bytes. The en=
ding
> > > contents is an array of bits. This works because every bit in the end=
ing
> > > bit array is set to either 0 or 1. Overlap occurs on the first iterat=
ion
> > > where the code reads the 0th byte, and writes the 0th bit, which is p=
art of
> > > the 0th byte. The second iteration reads the 1st byte, and writes the=
 1st bit,
> > > which doesn't overlap, and there's no overlap from then on.
> > >
> > > Suppose "written" is not a multiple of 8. The last byte of "states" a=
s an
> > > array of bits will have some bits that have not been set to either 0 =
or 1 and
> > > might be leftover garbage from when "states" was an array of bytes. T=
hat
> > > garbage will get copied to user space. Is that OK? Even if user space=
 knows
> > > enough to ignore those bits, it seems a little dubious to be copying =
even
> > > a few bits of garbage to user space.
> > >
> > > Some comments might help here.
> > >
> > This is a good point. The expectation is indeed that userspace knows wh=
ich
> > bits are valid from the returned "written" value, but I agree it's a bi=
t
> > odd to have some garbage bits in the last byte. How does this look (to =
be
> > inserted here directly after the loop):
> >
> > +       /* zero the unused bits in the last byte of the returned bitmap=
 */
> > +       if (written > 0) {
> > +               u8 last_bits_mask;
> > +               int last_byte_idx;
> > +               int bits_rem =3D written % 8;
> > +
> > +               /* bits_rem =3D=3D 0 when all bits in the last byte wer=
e assigned */
> > +               if (bits_rem > 0) {
> > +                       /* written > 0 ensures last_byte_idx >=3D 0 */
> > +                       last_byte_idx =3D ((written + 7) / 8) - 1;
> > +                       /* bits_rem > 0 ensures this masks 1 to 7 bits =
*/
> > +                       last_bits_mask =3D (1 << bits_rem) - 1;
> > +                       states[last_byte_idx].as_uint8 &=3D last_bits_m=
ask;
> > +               }
> > +       }
>=20
> A simpler approach is to "continue" the previous loop.  And if "written"
> is zero, this additional loop won't do anything either:
>=20
> 	for (i =3D written; i < ALIGN(written, 8); ++i)
> 		__clear_bit(i, (ulong *)states);
>=20

One further thought here: Could "written" be less than
args.page_count at this point? That would require
hv_call_get_gpa_access_states() to not fail, but still return
a value for written that is less than args.page_count. If that
could happen, then the above loop should be:

	for (i =3D written; i < bitmap_buf_sz * 8; ++i)
		__clear_bit(i, (ulong *)states);

so that all the uninitialized bits and bytes that will be written
back to user space are cleared.

> >
> > The remaining bytes could be memset() to zero but I think it's fine to =
leave
> > them.
>=20
> I agree.  The remaining bytes aren't written back to user space anyway
> since the copy_to_user() uses bitmap_buf_sz.

Maybe I misunderstood what you meant by "remaining bytes".  I think
all bits and bytes that are written back to user space should have
valid data or zeros so that no garbage is written back.

Michael

>=20
> >
> > >> +
> > >> +	args.page_count =3D written;
> > >> +
> > >> +	if (copy_to_user(user_args, &args, sizeof(args))) {
> > >> +		ret =3D -EFAULT;
> > >> +		goto free_return;
> > >> +	}
> > >> +	if (copy_to_user((void __user *)args.bitmap_ptr, states, bitmap_bu=
f_sz))
> > >> +		ret =3D -EFAULT;
> > >> +
> > >> +free_return:
> > >> +	vfree(states);
> > >> +	return ret;
> > >> +}

