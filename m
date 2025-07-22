Return-Path: <linux-arch+bounces-12888-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B33C4B0E2D0
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 19:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C64C1C835DD
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 17:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF352820D5;
	Tue, 22 Jul 2025 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rq9z1Rmm"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2065.outbound.protection.outlook.com [40.92.41.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA392820BA;
	Tue, 22 Jul 2025 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206244; cv=fail; b=FOvoW+wESMia3gK09RLJMEff1xElZOWViRZPn9BzIFyR8cW6kRM6HiJjiRZr820ZviPlu1inHnUE2sQG3NkGHJvjqIsMXc+Aiy+FNRSs1SmlS9a7yYjBWMPyjEQOn2Vae+m1OR6KM7aEha429HH5kYMfwiihTEUcjfet5wopaAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206244; c=relaxed/simple;
	bh=y0OMLX2u1dBAEacdn/cYQVCVB9DRK5i5wlS3cWQW+r8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PnAufrjjYq84x0MsNEwD0YrfiikJERZtIp2JsP/8ksANeT+bBVX+sAIzdYcAmxpvlw2l5cfwQ7Ffp/qI9Cb4JXFthUTCXWXnsf9xQaVwmeGyd2AmsJpHON3X2yevO4iJyy7I8wt1bAykU4Wsis5YVzUHJtpnYiwPuD6YfCKSC2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rq9z1Rmm; arc=fail smtp.client-ip=40.92.41.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsO5jD++Fobag5H37ryfyYMpoRV3dnlMAwmxVst2rcEbV3u6rB4YV9ypzKGP6wml/H4vLFl2Ketq+UIyCpgj4AM3iQe33tkd/8z9prnHufsQjvOn5tFFrNwhV9IBxAyeaEIVGmK5BIgNaN5tD48yEOBJtkIo6WqquO0JHwqWWVtR4vdK4X5ZHs5MYQXCtjiU88JV/fUBEh5goqu73NlyWMBbY5gyGpS/M2TWaghapWP2QvgavcxO69mhxnateyv0JD+LhHomOmjJsr8N/SsMntKm9SeTJdnD5vi+nf6ZkBB5kYh/HrTMj/5BhxdlXo4uTXGmJaBVJgD18d8ME3WPwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBj2JzUqz9PB2qXbUZ/39phPqV55bgyaWnn01zx5PBw=;
 b=L+ZC7qwBm1GSrprPWwsP0JLDK5sSokxT9kmVrmyp5E+m4uqRg7QOcaT3lQ7ERn9GJeUhNMVSL2+KogujzlQickX+dpsiE8cgOsvrjFwheaaNcvwxbLJ7THtcTEL3j1mda704zYIWvj6lDIelMmh+H1ZNoy0+A20hDZBuQm6F9RoOOIcbl4dUgJafOBZKGiP5ag49D2jTZig9kPMO3OuVzxgeXRG/kj00eBlnSnYIfKWV5ycLtb9C4WPLQU+Rx8qFFXwYqGY+bd8UHHVBsEONDkZnW6CHvyGW1wxa7nsJG8Oz8NWm1hfZrqWCIQPV/GK+68an/8FyLuUPF0rvco9Vaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBj2JzUqz9PB2qXbUZ/39phPqV55bgyaWnn01zx5PBw=;
 b=rq9z1Rmm6BPFIHJsI1KjvwHfirlFNtv5ZrCYDOzK85o2yY3mPe3/LY1kZovMnjiyV3mEBJFCbd73TgcegBi1lYUolaxnrjfi8ixGF4uaFVOiy06PN0JjvZCIN0Y5/FLrOWJPAEmDpmQS5PK3yO55huW7V+yDLU4z+mMRalhbpo42uaATVYeVFSXRa6EGYcS1jImZTRTJuAF03Dxo2fGUcBK5ndjHN8dZiqu4OFxf+2r8D2J/Kju85AMFlk4YoiyHck8sMlpo5TA8FzwVMFADntIkYiK3p5c/KSR1KvEi8PisrVOOlGa73XJMXS8rb0hNu9XzHixLzZgi4Gpmets0tA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9201.namprd02.prod.outlook.com (2603:10b6:930:9c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 17:44:00 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 17:44:00 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "alok.a.tiwari@oracle.com"
	<alok.a.tiwari@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de"
	<bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "Tianyu.Lan@microsoft.com"
	<Tianyu.Lan@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v4 05/16] Drivers: hv: Rename fields for SynIC
 message and event pages
Thread-Topic: [PATCH hyperv-next v4 05/16] Drivers: hv: Rename fields for
 SynIC message and event pages
Thread-Index: AQHb9QzcLwGEXJQz+UiwasAj1cfL07Q4XY4Q
Date: Tue, 22 Jul 2025 17:44:00 +0000
Message-ID:
 <SN6PR02MB41577881ADDD9076F138DA3FD45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250714221545.5615-1-romank@linux.microsoft.com>
 <20250714221545.5615-6-romank@linux.microsoft.com>
In-Reply-To: <20250714221545.5615-6-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9201:EE_
x-ms-office365-filtering-correlation-id: 064f8d6b-4cef-47f9-c091-08ddc9475755
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|40105399003|3412199025|440099028|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XF0YGf9P6ufOh4FtvqgFJMiRwKcumEbvdc39GcB8cIl2Valc66YG/8Lle8es?=
 =?us-ascii?Q?lK0w9ClfjTNw4F/hhO8TPiV6kbtQuOUBDa6PrUUAege+L6j02P+gyBFUc9b+?=
 =?us-ascii?Q?2fCraBcI51/FuuBo0uD4DQdAby0JHZ4qsLULQGkOBxyrG9A4rR4+ThpuwRn4?=
 =?us-ascii?Q?bwrHNLkeL7giO6JzpTxOJHSKVqkxYgw3MIUeyZZMnSzUp62G6HSYEhdUKiDg?=
 =?us-ascii?Q?CFA5O3LOB98y7qb/osLSewMZ1dsOh0x0lQZXUu8NweQAvyRL09a9eG9U2aas?=
 =?us-ascii?Q?egddlHHVQMvU0BpfFNivDmEzyhrdur+tUBq5rsXR+oYehE0O9Pr/JdcClySa?=
 =?us-ascii?Q?09ak6MarEe1MpT9uxkC7lY4LlunFx3/Vw1vPnPgDp9YFKcuwHWVswAsuM7Cj?=
 =?us-ascii?Q?XYH9maQRTEWx6zIr3hLMbeA6Jhhrzc3+XfEPqLqfH+lkobJg9ZgM8hQnV6x2?=
 =?us-ascii?Q?RH4hzCmYzW8Ydu/4pz8qIJE06Xlgs5OQKhI/uJ0i6KlNgJCXFEyHE6saaa4G?=
 =?us-ascii?Q?Zt7vgYJbr+XhXQW/xFNpaMFdzP2qNdLOxhT+oDGJRUxrZ+mHVQgTqAhUj5o3?=
 =?us-ascii?Q?42gDGs0p627G9idnpLDCTwQ0aGCVoj0ZcoVSM0QlicQlGsYH3PpaWT/dAlNz?=
 =?us-ascii?Q?wnCwZ7kz8RcxtrxGR5MMDtuOPq3Lk4/lmVheeWpBLP7H/JaOaA/09H1iJOhG?=
 =?us-ascii?Q?XRuvu3UMmHmPNTYm+AlY1Ad2FGP5s/7t6bAt21KsIoITUblBUT+iiwwt+j8L?=
 =?us-ascii?Q?pkHi/JNUmSQkDX8rXxfa8zAVbehthon0jKNyEOAn5r6yhMzSt8nbhGBZXczq?=
 =?us-ascii?Q?rmFZZRtda3YdbBaHqG5qzOzRSePsecBbP6duz7jqRlKrrnB21Nyglk1exc6A?=
 =?us-ascii?Q?ofvUF7994k6MXbnquroDgwWcHsjyMzJM6IJNHLJrdu+JFObG1kf73aaqa/js?=
 =?us-ascii?Q?NTAu/ESGuPHL8tfPMU6bZZa0HUC+oaQNJ/KwwStVXAAmmTzVmkUE7ww3FZTv?=
 =?us-ascii?Q?51KOj0NPlD6nNrtXc8erjkaoPsjt4RP3S4IB6pZ2qULBrr6Zto5tQD8koaUm?=
 =?us-ascii?Q?c2+HDmYm?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lMzhYnqPVCYrJ8xlNtbNO1BaeEvExhSOPK8ifD/B7CuouUdDqEGmIQy8jwSp?=
 =?us-ascii?Q?LMQ/+RSq0dg2JmvkPze/dxUzLN1+qpcpZKwMMfIYdwzsFcjNTCcTwH0ufQsZ?=
 =?us-ascii?Q?spuYRkq74chHoIo7PG7gR7Zu1F9HLGfo6DV/UERsQ32J+nRqFpaMKNPg9flp?=
 =?us-ascii?Q?fmk87iD8zbFHSYqCMjr+YgdoiEyf0j7qlmI3T3YlpbJUrxY/jFdNxr3MmPc3?=
 =?us-ascii?Q?U6KLgWE7DMbbwTeXMOA6KkBBKAvuum3zqTYCX5D2nc2c82lQXuJFWBvhxnHD?=
 =?us-ascii?Q?bLqg7YBHo2xGhNQX8PGkC1k5yqW6yl1UPBNjN8dNHR7hOjfh+ykg0BJw0/+P?=
 =?us-ascii?Q?J23lNO31g6wPY+QyKZQuSZr/V0uJDd44LgOPLyicVVs9MlDURZ0pzXXduiYX?=
 =?us-ascii?Q?cRLIIsfojyXoO9I7GzpTr7ysDKTLJ7deiH9VmMS/hbwtPJmwKO9M4VMdZKeH?=
 =?us-ascii?Q?ZbtmKgvbvBNappA83uoYNbIO/SFEzYqMd+WzxM1EBKgjeAbqsQmGNKuxk1Mh?=
 =?us-ascii?Q?oWnK64vZlCUZZd5jiq9BYu1x4av2et1eVqXZPwZoNfYN08JX7vJVvhnzeaqS?=
 =?us-ascii?Q?cYQg+ujNfVx+9ICLFjvNY9ccwm2Azg6FlqrJOh9Vij+IXYyh033tfZKQxU06?=
 =?us-ascii?Q?NO2sYZJcGt4Gb2g66fJW713PR9F9CKlNvCD2FweJ+eMSq4gCKItw3eWvEcYF?=
 =?us-ascii?Q?7IJMW4G9QuEO4R+1315bahmyABb9f7o+nx34IVNDQPo313cWudwrujSZUZAA?=
 =?us-ascii?Q?/n9td0yQbMhxa2Cf+gK3xWrrUx8RZeoUUkbmNV0XTWq4/weL7C18yPXtxhFi?=
 =?us-ascii?Q?Sza5SE8TyNO8Fc4fSdqYSfEjbsR7hCLkXGP3yypicRRpwD1ZkrG6gkWEukWH?=
 =?us-ascii?Q?NlP9MEFUR0mbgB5Pa4pTvJWRKaa/y3f0sN1GjF8xiqOeYmfy8qxgTzlI/vEA?=
 =?us-ascii?Q?3sPPjbLeJTy3kpLmelI48L78nzBg9uzcTdHxV3TDmbFK6C0liBAl+eaBmHNT?=
 =?us-ascii?Q?B4oTOTwE6lWLNCEjeAVNBbSVZNTJztV5z/+Tb/IG9iYPdk0tCFByCrpywF0g?=
 =?us-ascii?Q?cW/5XtXHK08jIoCYj4nqTjtNIe0oQNSuP4nqt3O7ApzpzSa6LzG1+OiIyuUK?=
 =?us-ascii?Q?v2n1Mq9vonh4zBW/NHzolS0+M3XbH3tFZz9ysZQrdSlTxIxwRPs571KIYw8M?=
 =?us-ascii?Q?Vg4LcI+gyIWBnLD0zCRLJMq6Pi824z0G4elzuQT7rWe74ty3vDQVvVdjkeU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 064f8d6b-4cef-47f9-c091-08ddc9475755
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 17:44:00.1270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9201

From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, July 14, 2025 =
3:16 PM
>=20
> Confidential VMBus requires interacting with two SynICs -- one
> provided by the host hypervisor, and one provided by the paravisor.
> Each SynIC requires its own message and event pages.
>=20
> Rename the existing host-accessible SynIC message and event pages
> with the "hyp_" prefix to clearly distinguish them from the paravisor
> ones. The field name is also changed in mshv_root.* for consistency.
>=20
> No functional changes.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/channel_mgmt.c |  6 ++--
>  drivers/hv/hv.c           | 66 +++++++++++++++++++--------------------
>  drivers/hv/hyperv_vmbus.h |  4 +--
>  drivers/hv/mshv_root.h    |  2 +-
>  drivers/hv/mshv_synic.c   |  6 ++--
>  drivers/hv/vmbus_drv.c    |  6 ++--
>  6 files changed, 45 insertions(+), 45 deletions(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 6e084c207414..6f87220e2ca3 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -843,14 +843,14 @@ static void vmbus_wait_for_unload(void)
>  				=3D per_cpu_ptr(hv_context.cpu_context, cpu);
>=20
>  			/*
> -			 * In a CoCo VM the synic_message_page is not allocated
> +			 * In a CoCo VM the hyp_synic_message_page is not allocated
>  			 * in hv_synic_alloc(). Instead it is set/cleared in
>  			 * hv_synic_enable_regs() and hv_synic_disable_regs()
>  			 * such that it is set only when the CPU is online. If
>  			 * not all present CPUs are online, the message page
>  			 * might be NULL, so skip such CPUs.
>  			 */
> -			page_addr =3D hv_cpu->synic_message_page;
> +			page_addr =3D hv_cpu->hyp_synic_message_page;
>  			if (!page_addr)
>  				continue;
>=20
> @@ -891,7 +891,7 @@ static void vmbus_wait_for_unload(void)
>  		struct hv_per_cpu_context *hv_cpu
>  			=3D per_cpu_ptr(hv_context.cpu_context, cpu);
>=20
> -		page_addr =3D hv_cpu->synic_message_page;
> +		page_addr =3D hv_cpu->hyp_synic_message_page;
>  		if (!page_addr)
>  			continue;
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 308c8f279df8..964b9102477d 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -145,20 +145,20 @@ int hv_synic_alloc(void)
>  		 * Skip these pages allocation here.
>  		 */
>  		if (!ms_hyperv.paravisor_present && !hv_root_partition()) {
> -			hv_cpu->synic_message_page =3D
> +			hv_cpu->hyp_synic_message_page =3D
>  				(void *)get_zeroed_page(GFP_ATOMIC);
> -			if (!hv_cpu->synic_message_page) {
> +			if (!hv_cpu->hyp_synic_message_page) {
>  				pr_err("Unable to allocate SYNIC message page\n");
>  				goto err;
>  			}
>=20
> -			hv_cpu->synic_event_page =3D
> +			hv_cpu->hyp_synic_event_page =3D
>  				(void *)get_zeroed_page(GFP_ATOMIC);
> -			if (!hv_cpu->synic_event_page) {
> +			if (!hv_cpu->hyp_synic_event_page) {
>  				pr_err("Unable to allocate SYNIC event page\n");
>=20
> -				free_page((unsigned long)hv_cpu-
> >synic_message_page);
> -				hv_cpu->synic_message_page =3D NULL;
> +				free_page((unsigned long)hv_cpu-
> >hyp_synic_message_page);
> +				hv_cpu->hyp_synic_message_page =3D NULL;
>  				goto err;
>  			}
>  		}
> @@ -166,30 +166,30 @@ int hv_synic_alloc(void)
>  		if (!ms_hyperv.paravisor_present &&
>  		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
>  			ret =3D set_memory_decrypted((unsigned long)
> -				hv_cpu->synic_message_page, 1);
> +				hv_cpu->hyp_synic_message_page, 1);
>  			if (ret) {
>  				pr_err("Failed to decrypt SYNIC msg page: %d\n", ret);
> -				hv_cpu->synic_message_page =3D NULL;
> +				hv_cpu->hyp_synic_message_page =3D NULL;
>=20
>  				/*
>  				 * Free the event page here so that hv_synic_free()
>  				 * won't later try to re-encrypt it.
>  				 */
> -				free_page((unsigned long)hv_cpu->synic_event_page);
> -				hv_cpu->synic_event_page =3D NULL;
> +				free_page((unsigned long)hv_cpu-
> >hyp_synic_event_page);
> +				hv_cpu->hyp_synic_event_page =3D NULL;
>  				goto err;
>  			}
>=20
>  			ret =3D set_memory_decrypted((unsigned long)
> -				hv_cpu->synic_event_page, 1);
> +				hv_cpu->hyp_synic_event_page, 1);
>  			if (ret) {
>  				pr_err("Failed to decrypt SYNIC event page: %d\n", ret);
> -				hv_cpu->synic_event_page =3D NULL;
> +				hv_cpu->hyp_synic_event_page =3D NULL;
>  				goto err;
>  			}
>=20
> -			memset(hv_cpu->synic_message_page, 0, PAGE_SIZE);
> -			memset(hv_cpu->synic_event_page, 0, PAGE_SIZE);
> +			memset(hv_cpu->hyp_synic_message_page, 0, PAGE_SIZE);
> +			memset(hv_cpu->hyp_synic_event_page, 0, PAGE_SIZE);
>  		}
>  	}
>=20
> @@ -225,28 +225,28 @@ void hv_synic_free(void)
>=20
>  		if (!ms_hyperv.paravisor_present &&
>  		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
> -			if (hv_cpu->synic_message_page) {
> +			if (hv_cpu->hyp_synic_message_page) {
>  				ret =3D set_memory_encrypted((unsigned long)
> -					hv_cpu->synic_message_page, 1);
> +					hv_cpu->hyp_synic_message_page, 1);
>  				if (ret) {
>  					pr_err("Failed to encrypt SYNIC msg page:
> %d\n", ret);
> -					hv_cpu->synic_message_page =3D NULL;
> +					hv_cpu->hyp_synic_message_page =3D NULL;
>  				}
>  			}
>=20
> -			if (hv_cpu->synic_event_page) {
> +			if (hv_cpu->hyp_synic_event_page) {
>  				ret =3D set_memory_encrypted((unsigned long)
> -					hv_cpu->synic_event_page, 1);
> +					hv_cpu->hyp_synic_event_page, 1);
>  				if (ret) {
>  					pr_err("Failed to encrypt SYNIC event page:
> %d\n", ret);
> -					hv_cpu->synic_event_page =3D NULL;
> +					hv_cpu->hyp_synic_event_page =3D NULL;
>  				}
>  			}
>  		}
>=20
>  		free_page((unsigned long)hv_cpu->post_msg_page);
> -		free_page((unsigned long)hv_cpu->synic_event_page);
> -		free_page((unsigned long)hv_cpu->synic_message_page);
> +		free_page((unsigned long)hv_cpu->hyp_synic_event_page);
> +		free_page((unsigned long)hv_cpu->hyp_synic_message_page);
>  	}
>=20
>  	kfree(hv_context.hv_numa_map);
> @@ -276,12 +276,12 @@ void hv_synic_enable_regs(unsigned int cpu)
>  		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
>  		u64 base =3D (simp.base_simp_gpa << HV_HYP_PAGE_SHIFT) &
>  				~ms_hyperv.shared_gpa_boundary;
> -		hv_cpu->synic_message_page =3D
> +		hv_cpu->hyp_synic_message_page =3D
>  			(void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
> -		if (!hv_cpu->synic_message_page)
> +		if (!hv_cpu->hyp_synic_message_page)
>  			pr_err("Fail to map synic message page.\n");
>  	} else {
> -		simp.base_simp_gpa =3D virt_to_phys(hv_cpu->synic_message_page)
> +		simp.base_simp_gpa =3D virt_to_phys(hv_cpu-
> >hyp_synic_message_page)
>  			>> HV_HYP_PAGE_SHIFT;
>  	}
>=20
> @@ -295,12 +295,12 @@ void hv_synic_enable_regs(unsigned int cpu)
>  		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
>  		u64 base =3D (siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT) &
>  				~ms_hyperv.shared_gpa_boundary;
> -		hv_cpu->synic_event_page =3D
> +		hv_cpu->hyp_synic_event_page =3D
>  			(void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
> -		if (!hv_cpu->synic_event_page)
> +		if (!hv_cpu->hyp_synic_event_page)
>  			pr_err("Fail to map synic event page.\n");
>  	} else {
> -		siefp.base_siefp_gpa =3D virt_to_phys(hv_cpu->synic_event_page)
> +		siefp.base_siefp_gpa =3D virt_to_phys(hv_cpu->hyp_synic_event_page)
>  			>> HV_HYP_PAGE_SHIFT;
>  	}
>=20
> @@ -358,8 +358,8 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	 */
>  	simp.simp_enabled =3D 0;
>  	if (ms_hyperv.paravisor_present || hv_root_partition()) {
> -		iounmap(hv_cpu->synic_message_page);
> -		hv_cpu->synic_message_page =3D NULL;
> +		iounmap(hv_cpu->hyp_synic_message_page);
> +		hv_cpu->hyp_synic_message_page =3D NULL;
>  	} else {
>  		simp.base_simp_gpa =3D 0;
>  	}
> @@ -370,8 +370,8 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	siefp.siefp_enabled =3D 0;
>=20
>  	if (ms_hyperv.paravisor_present || hv_root_partition()) {
> -		iounmap(hv_cpu->synic_event_page);
> -		hv_cpu->synic_event_page =3D NULL;
> +		iounmap(hv_cpu->hyp_synic_event_page);
> +		hv_cpu->hyp_synic_event_page =3D NULL;
>  	} else {
>  		siefp.base_siefp_gpa =3D 0;
>  	}
> @@ -401,7 +401,7 @@ static bool hv_synic_event_pending(void)
>  {
>  	struct hv_per_cpu_context *hv_cpu =3D this_cpu_ptr(hv_context.cpu_conte=
xt);
>  	union hv_synic_event_flags *event =3D
> -		(union hv_synic_event_flags *)hv_cpu->synic_event_page +
> VMBUS_MESSAGE_SINT;
> +		(union hv_synic_event_flags *)hv_cpu->hyp_synic_event_page +
> VMBUS_MESSAGE_SINT;
>  	unsigned long *recv_int_page =3D event->flags; /* assumes VMBus version=
 >=3D
> VERSION_WIN8 */
>  	bool pending;
>  	u32 relid;
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 0b450e53161e..fc3cdb26ff1a 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -120,8 +120,8 @@ enum {
>   * Per cpu state for channel handling
>   */
>  struct hv_per_cpu_context {
> -	void *synic_message_page;
> -	void *synic_event_page;
> +	void *hyp_synic_message_page;
> +	void *hyp_synic_event_page;
>=20
>  	/*
>  	 * The page is only used in hv_post_message() for a TDX VM (with the
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index e3931b0f1269..db6b42db2fdc 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -169,7 +169,7 @@ struct mshv_girq_routing_table {
>  };
>=20
>  struct hv_synic_pages {
> -	struct hv_message_page *synic_message_page;
> +	struct hv_message_page *hyp_synic_message_page;
>  	struct hv_synic_event_flags_page *synic_event_flags_page;
>  	struct hv_synic_event_ring_page *synic_event_ring_page;
>  };
> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> index e6b6381b7c36..f8b0337cdc82 100644
> --- a/drivers/hv/mshv_synic.c
> +++ b/drivers/hv/mshv_synic.c
> @@ -394,7 +394,7 @@ mshv_intercept_isr(struct hv_message *msg)
>  void mshv_isr(void)
>  {
>  	struct hv_synic_pages *spages =3D this_cpu_ptr(mshv_root.synic_pages);
> -	struct hv_message_page **msg_page =3D &spages->synic_message_page;
> +	struct hv_message_page **msg_page =3D &spages->hyp_synic_message_page;
>  	struct hv_message *msg;
>  	bool handled;
>=20
> @@ -456,7 +456,7 @@ int mshv_synic_init(unsigned int cpu)
>  #endif
>  	union hv_synic_scontrol sctrl;
>  	struct hv_synic_pages *spages =3D this_cpu_ptr(mshv_root.synic_pages);
> -	struct hv_message_page **msg_page =3D &spages->synic_message_page;
> +	struct hv_message_page **msg_page =3D &spages->hyp_synic_message_page;
>  	struct hv_synic_event_flags_page **event_flags_page =3D
>  			&spages->synic_event_flags_page;
>  	struct hv_synic_event_ring_page **event_ring_page =3D
> @@ -550,7 +550,7 @@ int mshv_synic_cleanup(unsigned int cpu)
>  	union hv_synic_sirbp sirbp;
>  	union hv_synic_scontrol sctrl;
>  	struct hv_synic_pages *spages =3D this_cpu_ptr(mshv_root.synic_pages);
> -	struct hv_message_page **msg_page =3D &spages->synic_message_page;
> +	struct hv_message_page **msg_page =3D &spages->hyp_synic_message_page;
>  	struct hv_synic_event_flags_page **event_flags_page =3D
>  		&spages->synic_event_flags_page;
>  	struct hv_synic_event_ring_page **event_ring_page =3D
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 698c86c4ef03..72940a64b0b6 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1060,7 +1060,7 @@ static void vmbus_onmessage_work(struct work_struct
> *work)
>  void vmbus_on_msg_dpc(unsigned long data)
>  {
>  	struct hv_per_cpu_context *hv_cpu =3D (void *)data;
> -	void *page_addr =3D hv_cpu->synic_message_page;
> +	void *page_addr =3D hv_cpu->hyp_synic_message_page;
>  	struct hv_message msg_copy, *msg =3D (struct hv_message *)page_addr +
>  				  VMBUS_MESSAGE_SINT;
>  	struct vmbus_channel_message_header *hdr;
> @@ -1244,7 +1244,7 @@ static void vmbus_chan_sched(struct hv_per_cpu_cont=
ext
> *hv_cpu)
>  	 * The event page can be directly checked to get the id of
>  	 * the channel that has the interrupt pending.
>  	 */
> -	void *page_addr =3D hv_cpu->synic_event_page;
> +	void *page_addr =3D hv_cpu->hyp_synic_event_page;
>  	union hv_synic_event_flags *event
>  		=3D (union hv_synic_event_flags *)page_addr +
>  					 VMBUS_MESSAGE_SINT;
> @@ -1327,7 +1327,7 @@ static void vmbus_isr(void)
>=20
>  	vmbus_chan_sched(hv_cpu);
>=20
> -	page_addr =3D hv_cpu->synic_message_page;
> +	page_addr =3D hv_cpu->hyp_synic_message_page;
>  	msg =3D (struct hv_message *)page_addr + VMBUS_MESSAGE_SINT;
>=20
>  	/* Check if there are actual msgs to be processed */
> --
> 2.43.0


