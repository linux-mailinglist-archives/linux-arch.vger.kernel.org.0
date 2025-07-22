Return-Path: <linux-arch+bounces-12889-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CA7B0E2D2
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 19:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7863E3BCBE9
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 17:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E39281352;
	Tue, 22 Jul 2025 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="G4e4Tn6y"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2085.outbound.protection.outlook.com [40.92.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E45E2820BA;
	Tue, 22 Jul 2025 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206256; cv=fail; b=EW7a607haBSuFDP3B9/kzr/i6rk7zwHMg3/LoO6/zStqzJ2AmNrh7sW7xsKiQDyAkckuUV3VZiuzMna/kqeczmDG7+pnCukdVW5UjQDBbf03EsNRUUhN+xeC0xiixvMszwu6032mvm6pB4rSItxrAdVgcYa4TOgVhhGGOryZmqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206256; c=relaxed/simple;
	bh=2xN8ezX0gzXB5n9EGG19lvdVitk019JKwiPqomluwk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fGb3PybcBZuDw4V0tVArxuBvqHbot1gW9l6BDt47if4ZPuzDUiquF3cXPSeENTlKmbH89o0kf7obBPUnUpdGc/7tnDcD0FlNoGotpwf7QWFrCsiTH9PCpHD6AoXdc/7igjgNN73Y2wrqUYMI29YmokK0x0ZA7FQpFTC7L30Rk9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=G4e4Tn6y; arc=fail smtp.client-ip=40.92.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVfT7gm0AZm8PzhKK3Gcj0CAXCZfAFD7cfxDwggxWUpqP6SwJ26VuafvmhII3NhuoeKyhdkYKzLj/lxt6VCVoRN5Vx4NJqjr46nHoNHvqUDImLpMR8f/YlAOJG6V7hmz4OJ4JyEOea/NDXTGj3ryikYk4SBaGUlRX1EtrXv40mfnGQ3Yao45rJqllgfU+jgFrAOCabq5hVEO2WU3PgNCqJU6dpP+Kj5LbABFiw6q4OqNUkf4ED97aPQWzU5ivhOxBCDZVSjeIRyq97ii3GDYUU4QjZC5D2Y4gUuBKRndFWnDsRi8nGsBJjXlFnHoazAYDDfOzotZvrrLeUSoMAcdBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZX5v2WAxzLUL986YWuDY3p3GqGKVwBPcBEMknbo3Tk=;
 b=IVkBluEQUOpIopB2YGIgsIFIklKEFbYwuhr36GYfdEcyih6GCLxnHCFI64FgDH88IknRytD2cYA1ZnPB9Q3+Ucv3ZeD2FCmw38ZCME5v5A48nYmSKIY0cMXa1DWyc/bKuC6xwxKk4P+BuhggefX8/3VSy7dLjE13LvU1haLDKtc0wzxw2oVXG1UA/dlPBEPR6yDrFgYVz8r5iGvp54wu9+KTwJyLtVCc9A4oK31M9Rv3qwzl519Pw9K2bmRhgoKzytZUdRoRT0hYYg65K0JJJeo/GyExPPQwT757OuJAHblrSEeOw+IX2GMFBRZO4BTdI5fFZHWXTSwVaD4O33lAyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZX5v2WAxzLUL986YWuDY3p3GqGKVwBPcBEMknbo3Tk=;
 b=G4e4Tn6yPg0RyINu9spyZNEaEPkzECi8VWtC6jWg6N7+BO9Yo2p6/GnkGzw4uc+WQwVe4P7iFZmbb+78e3RuDkHX8aemubT2vNpR0d7QER2rtOim6ceP22V47T46Pd2hR548kO6KKH8Ml3oRHDXqCfUfDK1O481TRzTkODJklE65sCV/WFYy6bbmT8CtoCcto2MkG9Py0uJ3AZ9Wsb7xJPdTagisxNN+8GE3OUmJWFnNLrIuLemxUWN8B4664h2/icsP+ZySK74RSP02ziUD4EEG2lNbWzhd/0myxLQViTRwtbwXduwrHdh2/Xm0Pqzk/u/NKoOxLhU/f6A2wB0CdQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9201.namprd02.prod.outlook.com (2603:10b6:930:9c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 17:44:11 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 17:44:11 +0000
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
Subject: RE: [PATCH hyperv-next v4 06/16] Drivers: hv: Allocate the paravisor
 SynIC pages when required
Thread-Topic: [PATCH hyperv-next v4 06/16] Drivers: hv: Allocate the paravisor
 SynIC pages when required
Thread-Index: AQHb9Qzb3iIe3KBNsEGVEcqxpxVs6LQ4k+wg
Date: Tue, 22 Jul 2025 17:44:11 +0000
Message-ID:
 <SN6PR02MB4157BB7BD371A1144E184EB9D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250714221545.5615-1-romank@linux.microsoft.com>
 <20250714221545.5615-7-romank@linux.microsoft.com>
In-Reply-To: <20250714221545.5615-7-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9201:EE_
x-ms-office365-filtering-correlation-id: 3b14338a-ef31-4250-0ef9-08ddc9475e22
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|41001999006|56899033|40105399003|3412199025|440099028|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?17G8BEYHO/LEyK+fh+0Hwj2dT5t7GV0wiVul2b0dpu4WOPL2BhOLlVU/buTj?=
 =?us-ascii?Q?zCv4VkrH+A5ZZYcHqQCc+w0MYiinBbzJ8j2vk0mBfIk5eZYBQUAyAlyGQxvE?=
 =?us-ascii?Q?qLqeSGArWp0ZSX7OMwWFKWCTZvuA9rMftrTDKlZo9lqW+ZV5mZrqPq+yX4vP?=
 =?us-ascii?Q?VXsr3jIxZygWU6H5BY6gpON6bYUwC6tgajNoPGn82+Ak37uCB15v0OWOUJ8F?=
 =?us-ascii?Q?7moiqPIqeALl54zogj9EkFXb2AuY8HgJ98KGHp0cnBpe44FpnDTGczxuT9bx?=
 =?us-ascii?Q?sLe8XKBfdJtroUpCsf6UetdJmtETuz1ks07VIqjiFP3BOQKochRSyzRXuDWL?=
 =?us-ascii?Q?AKp1NiF/6D+UixpCpYxpkdZUhMncwOi5l8i2Sa3xNM/Gi82dANIeSg3SxcL0?=
 =?us-ascii?Q?cDzYYSf/GLxwhp7FOrjQ9jXwr/z+sTtHg4bW9ro9Xgx/t9S3s4Gd2msVE/Gp?=
 =?us-ascii?Q?hdPAogKVkx2ie6Fnehu/QTocfXjFQoHLVfw3Jw5Yi1hGrdaSAitR11Xp6jrt?=
 =?us-ascii?Q?0nupG5BHgVzSufVxVqw7WH4sYClDBfkqSzdt0qKVbZa37KXHsHeLNNbpTJvN?=
 =?us-ascii?Q?NtadkdBfpGxtqkOQh970XDpTjzbSuLdBgKDmhUDkvTpiQkcUd0CdzStPjwn2?=
 =?us-ascii?Q?D8Tzf17snU/S8eoi+8EzFL2Q44bLaO6bSAAcC8h0D4i16kFj/sipeUyjQfnT?=
 =?us-ascii?Q?oKadV97YBngOCiDHa0QOidJ+LSIavxIYvBbxFLXTCePPCJjvC5Qb82cQPN6q?=
 =?us-ascii?Q?sRJI0f4Wfs16H/qy08QJhfjtzdARDbEvxgfBCp8Q6n2ZdjSyIXMHcTJyQasW?=
 =?us-ascii?Q?3rNcd7WkBAI/aoEULzN9nRLeUB5nweHpOHe8OuUwEGPvOrwba2DvH61re9yP?=
 =?us-ascii?Q?mNP7SM9i2Zt5wgw3vOe+SdWNbo/b1N2LGZErtc/c+j0IpZD3Ud1qcBlZlUSn?=
 =?us-ascii?Q?QsfLipvGYJz0L7ZXeIAiVP+k/HQno4gOUf5NztPW6HSxncGysRV+7/KsA+O8?=
 =?us-ascii?Q?8gISKy1oILkIQGtrJBTKVRp4PdgyC40bs0NjuqrAZY2P77faQg0mzZ9R4r6g?=
 =?us-ascii?Q?Pms8J+JjXPRB1nGQ2isYjxgqQDfD4Q=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YMzrHqa9BUiMaLiwLDjgh3hupaIRqfC9KrVx88N1b5pIATn4ot3Ut710s2dH?=
 =?us-ascii?Q?Ws0PHaYzH9Il3UzZv3HRZnfEzYMpcb5U+lwvtdPYo5HAX7+dS31kSzhRxXYk?=
 =?us-ascii?Q?aDM962QtwRV62E1c8OSPNKn+T/EgpxKHRap9YwSGddeDCaTtIUrBfH8tU84/?=
 =?us-ascii?Q?uRiLouVIp8ZP1KDTyAFQiUueLC0dwp0ZT+cSxRWBfoFqObL0oZMN+amdkdqv?=
 =?us-ascii?Q?yfePPrmAkBljMrWI/5ts/2mWRcMKdoqVGLzkUJHe4HoauVIMIvFaj0H2qyZR?=
 =?us-ascii?Q?WK6hoCd70Kdg/oxJRm92D1p19CqDwMRzTnlWN1UWOQ8ixdX8RAUEJ8hqdg2A?=
 =?us-ascii?Q?MSaWOtH+quowDIFKiLmEhmO/XFZcbumVsPud6I/66lrEOOT8mXExkmKR769y?=
 =?us-ascii?Q?mT5RH6pR84jApa55ZpgAhJQ7JHqejjOWSB8AX+hgg0F8HwIk39cLb5Sivunk?=
 =?us-ascii?Q?mC4jRi3+IjkchDa8+slwxh9UP/NIkyTxFBMCRaJucJH0C4R0lHJExwO2rfTR?=
 =?us-ascii?Q?H9mXVr+mNDl2e7DYRhENm+f9D5nfLXmdUQLvPUdVothGusw4fWmDwsSHb33F?=
 =?us-ascii?Q?7hQvbE8v4ui9swwa/7TSa2YZjKfMICigCIDUTd6nmktbLhe+dxhjyoWJR2dO?=
 =?us-ascii?Q?StglJ5o4yPyKGjW5CjM+T4RMQCkr7ws1hFrbi8sjzPBT8av7lUHXKRmyi9J/?=
 =?us-ascii?Q?m70mdE6c6SFeXmvWmPcgbwTHPFJZNpLBDBlFyWqpF6vbAvtILMDNDaIrDWO4?=
 =?us-ascii?Q?cENSDjgfpYJneDJnnbeEkd5tL3eOt22TkVAw6CR6Me1pkNRJu7eiJsLh0Ia2?=
 =?us-ascii?Q?84ztq/4pSxtyJFS84JdQGPA7yZMNxnfQmREcXICSX2h1fKQRKmKL+hB5SACX?=
 =?us-ascii?Q?Q8Zq8vrB2DvKzZZaO60/BAQRbBua/7FqXKKjf07kIWsnwfT5UbnYKy2of3Sf?=
 =?us-ascii?Q?flpKBSintsu2/dh0qD9/shShpkZVzY1zWfZeNKqBLP6A3BsB3kLpgEv1ud/b?=
 =?us-ascii?Q?guw/wb+SOBhWHO/wrfTLnSaiEeFpB277mF+dWT3NX+nNJk0qlhHzAzZk6stu?=
 =?us-ascii?Q?c1eBzaQlXAdg0zFP5opuIodGtvtziWKqalCgfobew5qGkod5VWcdKpKAnunf?=
 =?us-ascii?Q?kErB40lBmlLlVnIM0mma3czsKVxRt+HSomvpvSMYtMBfj5Z25BWv/1Lh0mAo?=
 =?us-ascii?Q?QKkuiTukODPRQdZcq0MCwVrrn+15kYPIUBcLPatzIKDZ5L0RbLlG9065p2o?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b14338a-ef31-4250-0ef9-08ddc9475e22
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 17:44:11.5606
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
> Refactor and extend the existing code to add allocating and freeing
> the message and event pages for the paravisor SynIC when it is
> present.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>

Modulo a nit called out below,
Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/hv.c           | 184 +++++++++++++++++++-------------------
>  drivers/hv/hyperv_vmbus.h |  18 ++++
>  2 files changed, 112 insertions(+), 90 deletions(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 964b9102477d..e9ee0177d765 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -94,10 +94,70 @@ int hv_post_message(union hv_connection_id connection=
_id,
>  	return hv_result(status);
>  }
>=20
> +static int hv_alloc_page(void **page, bool decrypt, const char *note)
> +{
> +	int ret =3D 0;
> +
> +	/*
> +	 * After the page changes its encryption status, its contents might
> +	 * appear scrambled on some hardware. Thus `get_zeroed_page` would
> +	 * zero the page out in vain, so do that explicitly exactly once.
> +	 *
> +	 * By default, the page is allocated encrypted in a CoCo VM.
> +	 */
> +	*page =3D (void *)__get_free_page(GFP_KERNEL);
> +	if (!*page)
> +		return -ENOMEM;
> +
> +	if (decrypt)
> +		ret =3D set_memory_decrypted((unsigned long)*page, 1);
> +	if (ret)
> +		goto failed;
> +
> +	memset(*page, 0, PAGE_SIZE);
> +	return 0;
> +
> +failed:
> +	/*
> +	 * Report the failure but don't put the page back on the free list as
> +	 * its encryption status is unknown.
> +	 */
> +	pr_err("allocation failed for %s page, error %d, decrypted %d\n",
> +		note, ret, decrypt);
> +	*page =3D NULL;
> +	return ret;
> +}
> +
> +static int hv_free_page(void **page, bool encrypt, const char *note)
> +{
> +	int ret =3D 0;
> +
> +	if (!*page)
> +		return 0;
> +
> +	if (encrypt)
> +		ret =3D set_memory_encrypted((unsigned long)*page, 1);
> +
> +	/*
> +	 * In the case of the failure, the page is leaked. Something is wrong,
> +	 * prefer to lose the page with the unknown encryption status and stay =
afloat.
> +	 */
> +	if (ret) {
> +		pr_err("deallocation failed for %s page, error %d, encrypt %d\n",
> +			note, ret, encrypt);
> +	} else

Nit: The braces here are unnecessary.

> +		free_page((unsigned long)*page);
> +
> +	*page =3D NULL;
> +
> +	return ret;
> +}
> +
>  int hv_synic_alloc(void)
>  {
>  	int cpu, ret =3D -ENOMEM;
>  	struct hv_per_cpu_context *hv_cpu;
> +	const bool decrypt =3D !vmbus_is_confidential();
>=20
>  	/*
>  	 * First, zero all per-cpu memory areas so hv_synic_free() can
> @@ -123,73 +183,37 @@ int hv_synic_alloc(void)
>  			     vmbus_on_msg_dpc, (unsigned long)hv_cpu);
>=20
>  		if (ms_hyperv.paravisor_present && hv_isolation_type_tdx()) {
> -			hv_cpu->post_msg_page =3D (void *)get_zeroed_page(GFP_ATOMIC);
> -			if (!hv_cpu->post_msg_page) {
> -				pr_err("Unable to allocate post msg page\n");
> +			ret =3D hv_alloc_page(&hv_cpu->post_msg_page,
> +				decrypt, "post msg");
> +			if (ret)
>  				goto err;
> -			}
> -
> -			ret =3D set_memory_decrypted((unsigned long)hv_cpu->post_msg_page, 1)=
;
> -			if (ret) {
> -				pr_err("Failed to decrypt post msg page: %d\n", ret);
> -				/* Just leak the page, as it's unsafe to free the page. */
> -				hv_cpu->post_msg_page =3D NULL;
> -				goto err;
> -			}
> -
> -			memset(hv_cpu->post_msg_page, 0, PAGE_SIZE);
>  		}
>=20
>  		/*
> -		 * Synic message and event pages are allocated by paravisor.
> -		 * Skip these pages allocation here.
> +		 * If these SynIC pages are not allocated, SIEF and SIM pages
> +		 * are configured using what the root partition or the paravisor
> +		 * provides upon reading the SIEFP and SIMP registers.
>  		 */
>  		if (!ms_hyperv.paravisor_present && !hv_root_partition()) {
> -			hv_cpu->hyp_synic_message_page =3D
> -				(void *)get_zeroed_page(GFP_ATOMIC);
> -			if (!hv_cpu->hyp_synic_message_page) {
> -				pr_err("Unable to allocate SYNIC message page\n");
> +			ret =3D hv_alloc_page(&hv_cpu->hyp_synic_message_page,
> +				decrypt, "hypervisor SynIC msg");
> +			if (ret)
>  				goto err;
> -			}
> -
> -			hv_cpu->hyp_synic_event_page =3D
> -				(void *)get_zeroed_page(GFP_ATOMIC);
> -			if (!hv_cpu->hyp_synic_event_page) {
> -				pr_err("Unable to allocate SYNIC event page\n");
> -
> -				free_page((unsigned long)hv_cpu->hyp_synic_message_page);
> -				hv_cpu->hyp_synic_message_page =3D NULL;
> +			ret =3D hv_alloc_page(&hv_cpu->hyp_synic_event_page,
> +				decrypt, "hypervisor SynIC event");
> +			if (ret)
>  				goto err;
> -			}
>  		}
>=20
> -		if (!ms_hyperv.paravisor_present &&
> -		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
> -			ret =3D set_memory_decrypted((unsigned long)
> -				hv_cpu->hyp_synic_message_page, 1);
> -			if (ret) {
> -				pr_err("Failed to decrypt SYNIC msg page: %d\n", ret);
> -				hv_cpu->hyp_synic_message_page =3D NULL;
> -
> -				/*
> -				 * Free the event page here so that hv_synic_free()
> -				 * won't later try to re-encrypt it.
> -				 */
> -				free_page((unsigned long)hv_cpu->hyp_synic_event_page);
> -				hv_cpu->hyp_synic_event_page =3D NULL;
> +		if (vmbus_is_confidential()) {
> +			ret =3D hv_alloc_page(&hv_cpu->para_synic_message_page,
> +				false, "paravisor SynIC msg");
> +			if (ret)
>  				goto err;
> -			}
> -
> -			ret =3D set_memory_decrypted((unsigned long)
> -				hv_cpu->hyp_synic_event_page, 1);
> -			if (ret) {
> -				pr_err("Failed to decrypt SYNIC event page: %d\n", ret);
> -				hv_cpu->hyp_synic_event_page =3D NULL;
> +			ret =3D hv_alloc_page(&hv_cpu->para_synic_event_page,
> +				false, "paravisor SynIC event");
> +			if (ret)
>  				goto err;
> -			}
> -
> -			memset(hv_cpu->hyp_synic_message_page, 0, PAGE_SIZE);
> -			memset(hv_cpu->hyp_synic_event_page, 0, PAGE_SIZE);
>  		}
>  	}
>=20
> @@ -205,48 +229,28 @@ int hv_synic_alloc(void)
>=20
>  void hv_synic_free(void)
>  {
> -	int cpu, ret;
> +	int cpu;
> +	const bool encrypt =3D !vmbus_is_confidential();
>=20
>  	for_each_present_cpu(cpu) {
>  		struct hv_per_cpu_context *hv_cpu =3D
>  			per_cpu_ptr(hv_context.cpu_context, cpu);
>=20
> -		/* It's better to leak the page if the encryption fails. */
> -		if (ms_hyperv.paravisor_present && hv_isolation_type_tdx()) {
> -			if (hv_cpu->post_msg_page) {
> -				ret =3D set_memory_encrypted((unsigned long)
> -					hv_cpu->post_msg_page, 1);
> -				if (ret) {
> -					pr_err("Failed to encrypt post msg page: %d\n", ret);
> -					hv_cpu->post_msg_page =3D NULL;
> -				}
> -			}
> +		if (ms_hyperv.paravisor_present && hv_isolation_type_tdx())
> +			hv_free_page(&hv_cpu->post_msg_page,
> +				encrypt, "post msg");
> +		if (!ms_hyperv.paravisor_present && !hv_root_partition()) {
> +			hv_free_page(&hv_cpu->hyp_synic_event_page,
> +				encrypt, "hypervisor SynIC event");
> +			hv_free_page(&hv_cpu->hyp_synic_message_page,
> +				encrypt, "hypervisor SynIC msg");
>  		}
> -
> -		if (!ms_hyperv.paravisor_present &&
> -		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
> -			if (hv_cpu->hyp_synic_message_page) {
> -				ret =3D set_memory_encrypted((unsigned long)
> -					hv_cpu->hyp_synic_message_page, 1);
> -				if (ret) {
> -					pr_err("Failed to encrypt SYNIC msg page: %d\n", ret);
> -					hv_cpu->hyp_synic_message_page =3D NULL;
> -				}
> -			}
> -
> -			if (hv_cpu->hyp_synic_event_page) {
> -				ret =3D set_memory_encrypted((unsigned long)
> -					hv_cpu->hyp_synic_event_page, 1);
> -				if (ret) {
> -					pr_err("Failed to encrypt SYNIC event page: %d\n", ret);
> -					hv_cpu->hyp_synic_event_page =3D NULL;
> -				}
> -			}
> +		if (vmbus_is_confidential()) {
> +			hv_free_page(&hv_cpu->para_synic_event_page,
> +				false, "paravisor SynIC event");
> +			hv_free_page(&hv_cpu->para_synic_message_page,
> +				false, "paravisor SynIC msg");
>  		}
> -
> -		free_page((unsigned long)hv_cpu->post_msg_page);
> -		free_page((unsigned long)hv_cpu->hyp_synic_event_page);
> -		free_page((unsigned long)hv_cpu->hyp_synic_message_page);
>  	}
>=20
>  	kfree(hv_context.hv_numa_map);
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index fc3cdb26ff1a..16b5cf1bca19 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -120,8 +120,26 @@ enum {
>   * Per cpu state for channel handling
>   */
>  struct hv_per_cpu_context {
> +	/*
> +	 * SynIC pages for communicating with the host.
> +	 *
> +	 * These pages are accessible to the host partition and the hypervisor.
> +	 * They may be used for exchanging data with the host partition and the
> +	 * hypervisor even when they aren't trusted yet the guest partition
> +	 * must be prepared to handle the malicious behavior.
> +	 */
>  	void *hyp_synic_message_page;
>  	void *hyp_synic_event_page;
> +	/*
> +	 * SynIC pages for communicating with the paravisor.
> +	 *
> +	 * These pages may be accessed from within the guest partition only in
> +	 * CoCo VMs. Neither the host partition nor the hypervisor can access
> +	 * these pages in that case; they are used for exchanging data with the
> +	 * paravisor.
> +	 */
> +	void *para_synic_message_page;
> +	void *para_synic_event_page;
>=20
>  	/*
>  	 * The page is only used in hv_post_message() for a TDX VM (with the
> --
> 2.43.0


