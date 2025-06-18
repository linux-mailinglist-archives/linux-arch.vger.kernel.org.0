Return-Path: <linux-arch+bounces-12374-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310CAADF25F
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 18:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95D63B64BC
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 16:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941962EFD94;
	Wed, 18 Jun 2025 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rG90pHp9"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2015.outbound.protection.outlook.com [40.92.40.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF597280CD1;
	Wed, 18 Jun 2025 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263526; cv=fail; b=C0xn4g0EDYLS/PlNOYfTsY809SW3jjHEu5HAI9G2YE0DlMas+1bzjlYvJPZn+1eDfia0a9+JAw45PEYwNWIiEX6mbQ0EO4GSpoPE1Hws+8kB3NYmg7hwTSKAfTJv7gEp0mrsBRHALPuwnXmnyxuWumBqzCCd5ib4HTRGLAW7Ybc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263526; c=relaxed/simple;
	bh=sp7Wj8tiBHNDJZZz/KVu8CnawFfxTgIvwwcH9vjoW18=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BxRl9hPKag+V3MNg9mM/4gDz5oQUGA7kKguilHL4+iKMZzWnqNj+Vf0iG7RXLcDnHB8XWidSsPY6MRne7wN4p4UZNz/h0mECFuSsrIZ6MjQ9tOF2hVRt5Y4a++OjmaJDm184OciLW5iq/9Ynbkkh0ozdetg6p6QJUUVpYskZLe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rG90pHp9; arc=fail smtp.client-ip=40.92.40.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBEaBVfh2QLohCWV4MLpwwYaIF3WbvK1dVEAlRndkxGDFHuwg0DlQWRC+h6KBxDWoNYd59tDE3JGZTdgAvcLTqeAdr7hk0FhAGlbaiTZ6qfTISb8TS3WyyitfRa54S7adk99wd8R8kc2157axaE9w4RwVrNYpN5eGb4XIYYazZ78oljJHeAa1+bfk5gcpbs/5/5bMtdgfuGCIIYsqtvl3r3IakpO9CB01X6HFInmXruJehv/bQzIC5Jrvtgr/setNuxPRzGtsp2Wj80BSCQi3z94kaoJcJpOdD8OTds2RAHzIyY4IYZUJGvGUnBi03napjyH4sTuQ1A89EwsvuVodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ao+V5DdcYc++RdrEXqeV6r1Zq2EIGDwAg2paEIPVzsE=;
 b=ZRO+aJIoIWC4s4DrBet1Z7R2QsyWN/cz6pct1D3ei975Qvux4FKeM6JwsYgBbYp5tiF8RpJaqc4V6e1boREOWuTk6lOTco0LnV/8SFNVLVb8P/XmkOG40GJPYgB6VVrDOYgrD4sSSrJx+pmOZdVThwRW8y0gggH0fGAzGfwXA3MMDm+sF9f40syDBWeV08NVq9tChFpGKO0vl9G1Mme1Ckr6dPAw4SvKKBm3DrEdURleXTlMY/5WJE259ftdTXMHfwAkoj3npxQeI05vshAtkn5FC/zAoxw9JjJYYs2mQy5kW0lBQrk3UUhaZjim9dRtS092nHiCcWEpxY7Yvfam4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ao+V5DdcYc++RdrEXqeV6r1Zq2EIGDwAg2paEIPVzsE=;
 b=rG90pHp9lEdic0Y2nuWua3YB/cjdfwhCRIuwfRzSpqAVpQBVywTvqGryiPmBnPI6D3XONk+cskNhWxnsMOt7uB5q8hEz9zZIwo9B9FPvGq7GUqeKXsHNOgUdLRl7plbhx6nzvc0MA3Q0BRB1SZLVwh0Szcp8hvmEKY6CjcYb6qJh2dQCizH1JggR943qFIKJ38y13adBEXLwRN/1Sj9E1qKiMAH55fmvU8t/yW4lAQiVJZgLmuHc9cmVNFm+DQizoSAcciTRKoziKFv0WBUYek66HcxaoGm3qWEjsnaBj09gD1CC86q50zicxzWrrNi/G2XUY8MI1y/c5UyterOZ4w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 16:18:41 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 16:18:41 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "alok.a.tiwari@oracle.com"
	<alok.a.tiwari@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de"
	<bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v3 07/15] Drivers: hv: Post messages via the
 confidential VMBus if available
Thread-Topic: [PATCH hyperv-next v3 07/15] Drivers: hv: Post messages via the
 confidential VMBus if available
Thread-Index: AQHb1Om9RxBp9Ro9ZUqQtsBmxXtY1LQF6hcg
Date: Wed, 18 Jun 2025 16:18:40 +0000
Message-ID:
 <SN6PR02MB4157E23F495276EA814C775BD472A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250604004341.7194-1-romank@linux.microsoft.com>
 <20250604004341.7194-8-romank@linux.microsoft.com>
In-Reply-To: <20250604004341.7194-8-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8462:EE_
x-ms-office365-filtering-correlation-id: 0dbb9cff-5f50-4ed6-7940-08ddae83c9fc
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmrJ3OdcGJgulPpe6kFhF3ONRqwUsxPwnNDFbt/Vx169WqWeGtbpNw2CN+e31VwjA5FccIcPh27Gde/UttVHjIPk7h1jjq7cOUwUQn7jEz40ucJZtJlVK4hqMsn1yergUQ6q/SLlhNAdYnWXR4sHtYLxUQP7maKsZB39qSbe2CmmNjznzmtxeqlJ/I3vcrVQW+Wso2H8VgHK7mOyKLfFafehyzdQsgTNCCAkh4qmgS5YCwK5x86XQrXI2mEo/DzpiN5m6yAcA1jkpsjdcTxuxpbUoIjpTnrJYz93c9jjcp0Nq5/c1nqi1jSm1SfwVNZAq0o9Igjffih4plM+0WDA3f251+bzYGlQD4Up2e4S68gavRfJcMVTq0C2hMxTpXvLcJT8P5oke1W1EyOPtW2Yrj+TVIyd2uKAEVYMcWaqBp1IQLwVOfVWhSlDwws1fecw27BmAKnljm9Qxr4Hk6c3TEowl/KJxZksB6u1gLysBdzjFf0rcYYlVghOkjB9WdOZgJkhlDUOI2gSz+qhGQDeZYtK20Yg7qJLvSaGG8Jc76a/v/jWtPgTL19DnLByxi+/Dybi5JFZa+6FjC7Unvpop8yj17SX3riGGEQ/x2Z6crt69Nj8+1Jm3id7v/K8K9T10/rkFvF9LWDN/UfwsAqNfJ2qnrMMqCtyY1A1/bGzIWdhUyJvZ3wo9JG5LG9N/YxVnahZj1BQrcFLjnpnqyIWUTcmlsrtuaqcNatknqvydWYn7Ph4jjuM3eclzTdG/LkwR6Y=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799006|8062599006|15080799009|8060799009|3412199025|440099028|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IAiovo4zhnjNeXh3sT5v+UeVpSwVJodeXHRMd4tc86NFUmrP7D+Spumb9DPd?=
 =?us-ascii?Q?aJo9g6g5F1rnd0TGMcOinUf/bDAtNgpvAoovXRCEROtO71gq9qnBDZPV18xe?=
 =?us-ascii?Q?gQimhUGlBpl1xcGSv1km1vnKbnWPoWmVQuJPISh2zCPdpCSq72nJ4VITJ5Rm?=
 =?us-ascii?Q?MHsaxGfg+CbUPLRdut8u1661Z86XrhiIkpdvRa3jodOoNpupjeTaascub2cN?=
 =?us-ascii?Q?+oafBKtCKy97MtAPAOqToxM3+DoIAe8pDG4gxfLgNLtlt25ICTT0H6gRWmgZ?=
 =?us-ascii?Q?pEHtKF0oDyji0AzT2m1EsaK2op1dLa/EXY4l+gRC6emE7R9qU2vQcpGdn/0o?=
 =?us-ascii?Q?yvT95n0pZQjefrSoPQRjtd8CGQZnUrQ6ZmZUPagdk3jOUPxGdLlO9J1pdJAj?=
 =?us-ascii?Q?BFianwXD7P4FyowB2DGiDqn0F4iYe5AwJxI8p3xXkeEP1SJ40Io/S1Nbhs15?=
 =?us-ascii?Q?K4n3UQwDHeBoa6OYWAX7FaBrbVxrUw2o2W8EPAEbH8Dogw5yqwa7o1Az0o/2?=
 =?us-ascii?Q?2UAn9EVPkV+YGlWmojv9MPrXajXrL5YPijgGh18eOWaAh1/xIpBA/BZo1h43?=
 =?us-ascii?Q?l8BSOyktj+ACqpmxOWvWimyKpA57/vS44ZFZ/D0FECaWR4nexwArUr4rXZfz?=
 =?us-ascii?Q?+TTj7QfIAgwI1Prc5OymfHfOaQ5YzOD7uj4OBnb7a5AOkFjySCmKwR+qzw4J?=
 =?us-ascii?Q?SnJf4M+3Bg1hNV/Qfjrj0i5J3mTkSNMMwEllvePgnLrc7gT8mO88yVTGdgXE?=
 =?us-ascii?Q?kjSbW+EADqsw6+FtTuVCXe0nyIT9DPX4J7OY8nwlY2Pfa4gM5uWXnobdOfq0?=
 =?us-ascii?Q?Z11Z6uj3JBSb6i43voRhUDnVSkbhUs1m/pWxBXvnVIRFvixvwFljWb4BaOVY?=
 =?us-ascii?Q?y9cZdqU3Jx2WcHNqYocm2WQm7qW2KbmMsafBuP13kw4ycom33o/EsvY0Dydi?=
 =?us-ascii?Q?7UnTf7H7HfM2jam3b0OZh6mw5i5kWS4Kb99Gur7o/95FXRxTGiLdA/cRcAw1?=
 =?us-ascii?Q?09Lz5WGSTQikYcmI5MCvxahPTOGjwsWOFecC7hSgThCQYNKnp7Uaw8Dr2pSi?=
 =?us-ascii?Q?SzqL1eZ1joJC4SqEJ9eu563RdGVl2NkUIY17FaKFtbKEAPlY7/o=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BwQYtj124437CHzS3GgumTiRayWslWYlCNSS30r9p2WfPfgrWj3E1mO1Vs+E?=
 =?us-ascii?Q?LI2/HHSzbc0B4KuGXQn9Ms8D/OkSYJv1xFpTPT4gsvRzrRPdMZdqMXa9Z9iE?=
 =?us-ascii?Q?HB9lrz/qHNApzRHrYDBRPeL4s1vQXNEfLHbBmREQ70sAqvLk4vSPqqXEA9Op?=
 =?us-ascii?Q?AGmDfXcl/Q0g45pRh1gsBcInaPjCf3Z/PDbJo45zQhjfwoPIldb26SesCcZc?=
 =?us-ascii?Q?Ympp9vUnkVHLV45pd0Qmdc8DF2LJBqHYaxpXGILH5NVGFqd960U/NEtYYIdc?=
 =?us-ascii?Q?y0riaGxVV6kM3cfS8vlk9ORZukLoay+lJlM14XrtfuR8c3a7xw8EimFUJRcD?=
 =?us-ascii?Q?Iot2TApDnhw44nB1BWDgAAhkyX8FCIVvi0wbopjcHh4Orj/KC4IvyCGQabx3?=
 =?us-ascii?Q?ZXHBlyy0U/n03BBGyAa4gdsyM5phj05F3fI9z6Gc5ANTmQ/0h900SUu+xwNs?=
 =?us-ascii?Q?coL2bs7vK2iNalqDlR2sXjs0CqaTHAu4zs96AOEVKccXTjGw9nYGIBLe1ZQ1?=
 =?us-ascii?Q?mN9uw5dSpgzBZub8qP9vtwZ4OX6JdiZj2r2BYWHBP92SeNlDl5ZcVSWP8QC4?=
 =?us-ascii?Q?HCW+MqpxdbsIIHeiOYhSl4IFgET6LeuKPQT9AdKWLpUi1n7RcqtxetACzj+a?=
 =?us-ascii?Q?5cW3c1luOUgNgu9icLRRxzf3I6t/OFRBeG7E9lbX1/Ex1/M2V3lDeAt6UKx3?=
 =?us-ascii?Q?PKYaNHoeJw62nQUyDkY7kEjjT/Xf9zMfKpwR0yBi0tn/vYIdnkHCtSfdHaNI?=
 =?us-ascii?Q?f72x3KBH4dRJzHUK5YE3noak2DlFtbU5lqDc+yMklTdogKYa29cc7dOqOJaY?=
 =?us-ascii?Q?OfJ6X7Y3OHt4d04t+w9OsGBqCVjTnPiuF35jKhQ9ZzE2J3e5mnp2S+7tpDzp?=
 =?us-ascii?Q?krHiuKSk+q2Zcqtu0FlkM78rcZtQvex62phuZJjAM+2amRwEDIkC3nKdXh4Z?=
 =?us-ascii?Q?2OuenT7tjhCqaSbzi761SxvLd7OLWDOvBEnqUdw21ZwEC/4EjJqdWJHESrRh?=
 =?us-ascii?Q?IaZDfeK7Npd5nNPSfPE3qvwME4HrVL6NCV9BqbWw4oBqykml8CsHEAod8Pq7?=
 =?us-ascii?Q?vAOOvX5rmZE6qK4GSUpXio4H7GeDtETYsF/n7EKRXie+0MOT98YOxVTj7gTU?=
 =?us-ascii?Q?5qJSRcVQLNb1B4FdHu28THF2R0/7t9rGErJQE8EIjAHq3cqyvWHlu2pREa7F?=
 =?us-ascii?Q?tSXy7ALvW8MSvad1o9onfMUmK2M1RZbJdWb2SD4JFs03iyX1sG9sVIgTyN8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbb9cff-5f50-4ed6-7940-08ddae83c9fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 16:18:40.8885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462

From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, June 3, 2025 =
5:44 PM
>=20
> When the confidential VMBus is available, the guest should post
> messages via the paravisor.
>=20
> Update hv_post_message() to request posting messages from the paravisor

"via the paravisor"?  I'm not sure what "from the paravisor" means. And
you used "via" in the previous sentence and patch Subject.

> rather than through GHCB or TD calls.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/hv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index e25c91eb6af5..1f7cf1244509 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -74,7 +74,7 @@ int hv_post_message(union hv_connection_id connection_i=
d,
>  	aligned_msg->payload_size =3D payload_size;
>  	memcpy((void *)aligned_msg->payload, payload, payload_size);
>=20
> -	if (ms_hyperv.paravisor_present) {
> +	if (ms_hyperv.paravisor_present && !vmbus_is_confidential()) {

Does this change make post_msg_page unnecessary when Confidential
VMBus is present? When using Confidential VMBus, the code path will be
to use a normal hypercall, which will go to the paravisor, and hence
doesn't need decrypted memory.

If my thinking is correct, the code in hv_synic_alloc() could be updated to
not allocate post_msg_page when vmbus_is_confidential().

>  		if (hv_isolation_type_tdx())
>  			status =3D hv_tdx_hypercall(HVCALL_POST_MESSAGE,
>  						  virt_to_phys(aligned_msg), 0);
> --
> 2.43.0


