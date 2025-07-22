Return-Path: <linux-arch+bounces-12895-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEEBB0E31F
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 19:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B06D67B77DF
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 17:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB3128468E;
	Tue, 22 Jul 2025 17:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Yc1Hld1f"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2073.outbound.protection.outlook.com [40.92.42.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FB0284671;
	Tue, 22 Jul 2025 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206301; cv=fail; b=Ht6Sfw4gTTucp2L8p2Ho8BkDtdSaP87zHoMjZVPbgJ21ORm3A4gqFeOpfR7QnJjNCbtTLWmvmjVS0v8+pUyo6TJNxzcpgoVmEdIaykz2Cs1jtk6yzflr1kAvE4qkD45i/RkGCIzuNKQC2eT9ae0s2i7yl6/N558wydTFs63K2rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206301; c=relaxed/simple;
	bh=/rNPXANsNuaDWyj/KRk6tV3aIHl0RMKyUZn9RekUbPM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W8KqoAqZXABKxGK30Nu/jkPxDFyOYdKslxropibhPkxvDOuBpfVPKR5beCNmyOhilmzjji52OPx3YU9tLApr5J0PZeBNUWFNcFUBg1UeVTVW2iwobiGSxWskzoDkJLOCBqUqu+cFCifrcji0K0oig6ThVnvC5NGOxaXJXbgutug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Yc1Hld1f; arc=fail smtp.client-ip=40.92.42.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgJGh6Xihq/p7vEWuolxZTcZCb3m/P9n5CLBZD4TAHMwDxHtxda5OnPp+6CEfXRiAm1fwk4HSt1vgai398NRq0WoByt7rooJtRm6wRu3nRzDF2mG4cz7PELcNTsfVXXZfL9VJTchrLfGZX/IyewOYU7I9/ZJ8Bm7+VMlDL4w107a5jIKtlncr/VpkfP3tNkQsa8ohegiL6nJgyGPrlpM0UG5FYHp9eCObZJlB/pE5x7dN5H7yk45w5WosQQhWfSrKs26k3dGR5zY2BNqNMXgUVmV+9thJElLpEe4/PNawiHDDgn7k4Ezy+vs6CfvbMlwguZsrbomDAhWFbg6UamanA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1CHo516q6sOnGsWjRGVeu/KHzoWpEB/Yq/9a4qYp6c=;
 b=OTtbYO+UvCUg2LYOXIaXuWCxXRDqgy/KIo6C5geJeKuYKvEfTlyYeCrK1EmLnqPGkUL6vE2lLFDRR2MDWi/H7ob7iQN5tQoHEmp6aknDAxVyQf1Mb68ha12X/PrJ1RjXGZWD5x5TxxbrYyo1NgR2vFQpptsZwZZ+M2RGJjh9KiZZFao5Yd6kp1G9pLcrKEIP7/hrBrgd5HsSdJ5wHlgArG7IMGvbJALsksuFyFs9JERIgS3q/r6qZvX98sfjxaGOlmzQWP1b7g3PrAyOQH5aI4WaLhsBJbzODG7FoB6FSCtIhfW63g9SMUFZk1KYqCPS4FC3N6/krSQ3/MOYY3b4Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1CHo516q6sOnGsWjRGVeu/KHzoWpEB/Yq/9a4qYp6c=;
 b=Yc1Hld1fpWB0hvfnohT6QpKEDjiVNLYUYppR6+b7+fK/P5wB30PabNaQp30eD7PN7vbW1/qE3OdaWA+x8GbemdAZGcrwVoQelIelKiocwoXNOZkD4HposNVIijz1dYCZWZHUgO4LIZ4Mh4wE4TUasuZ2cm/6vOfnCh+7DE+i0neF5TwfW2ES2hXELdxwByQMbLeKUdX83Nc6HGzTed+Wo0nUvKxlm7StX8ypFciGId54hUAjBA2tcOj1ItSd+E4xh07DO8O3GUqwfBvJ4SJPIGxJmxVOyGhoCxWIMne+b+i+uHPHxU2muyDN7nxEKjd8BAG9NePeuDX9UgAM/rqCIQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9201.namprd02.prod.outlook.com (2603:10b6:930:9c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 17:44:57 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 17:44:57 +0000
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
Subject: RE: [PATCH hyperv-next v4 12/16] Drivers: hv: Allocate encrypted
 buffers when requested
Thread-Topic: [PATCH hyperv-next v4 12/16] Drivers: hv: Allocate encrypted
 buffers when requested
Thread-Index: AQHb9QzcQZoiZAZyzESMFl7Nm4j6aLQ4vilA
Date: Tue, 22 Jul 2025 17:44:57 +0000
Message-ID:
 <SN6PR02MB41574517E9313301CEFD1E55D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250714221545.5615-1-romank@linux.microsoft.com>
 <20250714221545.5615-13-romank@linux.microsoft.com>
In-Reply-To: <20250714221545.5615-13-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9201:EE_
x-ms-office365-filtering-correlation-id: 5b6c83cb-cec6-417e-fbc3-08ddc947794c
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|41001999006|40105399003|3412199025|440099028|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uisLu82LPTISAZYvTb5c6cAhn9r2uyAlvFLCSt/GAHvvgzmF3HM3qquTvUmN?=
 =?us-ascii?Q?AfFy3zTu6jTGY6Bo7qGb0GvP8ixilFEnJtip/Mz/UNdMtxdKYmZmGIPflMpt?=
 =?us-ascii?Q?2827jXlLfiHVE7ZaYCUXh/wEoNq1DGJRSSr5iPG3Kii/53ggDuuEP12bzQD0?=
 =?us-ascii?Q?KGQG/r3PeG/w2YWtx+P+eHMZexdb6t7h6zUr4XZwvu2mIIqFNn1tZKFcrszr?=
 =?us-ascii?Q?FjN5KBtYFtuGrx5/gVf7Rr5lAw7g3lv1bqqmIof1qDms2RqfP1JmJ7dusSgb?=
 =?us-ascii?Q?gdc3iqgkGDJ9QIpBcZuBkGK8NAVRYP16BkJWM4vVCXTKnlEuKy9i30XeeNGc?=
 =?us-ascii?Q?iLgzLbuidGTxr2KlpGUe1qvM6g8WTMFuDyvVZ4lomBvSYQNKaBeni00O2tvs?=
 =?us-ascii?Q?UNv6Sqf+siWOX8Sbc8ZuGLcDwuAyk/1OnzcTJTiWtnZ5FJJNMbyF+fFwJltK?=
 =?us-ascii?Q?AkrdIAfya17HCdlBJZ0AA/2O/vmrepgenq8s4UE7oqPTtUOGAgD594AliBME?=
 =?us-ascii?Q?lXWJZEbY8XoHcCHrVVX31VEsu8qF5fpth+wu0UR+Wiwa8dXkWrrGX7EYtQr4?=
 =?us-ascii?Q?jBW06yMkyLFih7lbD+wi0TqniRHkqw95F9bBZbene1EaUFBeREfWpntC/lvZ?=
 =?us-ascii?Q?lu0TpF7MipNGGwFE6kz+lJCzkVndKFj+CbjtZdD4DDBjM4B8mOe2Qlr8kBWv?=
 =?us-ascii?Q?q1MzRa/HvagB+cv9Q8+SuYNCeFBraKILiWNyqUG0/fuyRk4c45bdDZHF3zzp?=
 =?us-ascii?Q?WLzT+5nYnvErY3+ckgmVbNOcSuqJd8JMuJe/SKYs09u+tefjPgiks//e2Ygj?=
 =?us-ascii?Q?16uGqiYjrqbYvZtCvP2qqW/Pcgi8bGooEGOLTY6tz01qdZc/d57tNKWdRnY+?=
 =?us-ascii?Q?iVMK0MdQd1L4UNYTPoP+r1IlnpGGm5rSDhJFXaQTF4wIBBnqbnmEWMnBirul?=
 =?us-ascii?Q?k9v7HBPjkm5AM9v5p5SJpEVuCM5y+s/nF1ChOif5R2VAfjx/CBXhWX4F3jaH?=
 =?us-ascii?Q?u6BR8iCFOzV+f+hfVl3CTF+fqRZVM98k3Z3PgylpBniT9tR8B0js3aNfnkHL?=
 =?us-ascii?Q?EEu8RhaBkUHlBadX3Ssvi73cw/SGFA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RBXwFM3/mbqmdld3cxTx5HwWtN4PGJCmnWVOpETstVc3KEujO3SJMrq562QJ?=
 =?us-ascii?Q?AegdpzHNu0nzYtbFzMxnT+yXycP5q9RTO0+SZXrbnKdLq9xq7YbY9mTB9sdE?=
 =?us-ascii?Q?1PUTf1Zy6gbtvs3IbZY5Ol+9DiU/tXZ9IUuEFpdMwSliRKr1pKq8LBw2/qW7?=
 =?us-ascii?Q?UuApyRIOBUoAtt7U4B4/5cn7XF3j/yP/Ny2DrH73JY/7VVy/zyiamfzCYU4J?=
 =?us-ascii?Q?NzYeevDG3+wC1ZvrVRZhFFf9Isp6CTSBRjm0MHZ5O5VqtuUXkVnLBdhZbs7i?=
 =?us-ascii?Q?pwzd7xZ00a1TO4IlUG8lytxXiwRTs90Zlz+1ciJ6bYrbJIp+e6R9gX0vsdTP?=
 =?us-ascii?Q?B5vgTR7gO2AaO9eEM+viooFa1f4xtbn+uCVIlm8AeZOlxVmZP3EyAkRgug5D?=
 =?us-ascii?Q?48tQCzbBewcGkUHt/9Rc9n7MkzbxMjYJhRhr12UE/aiOLv8/ws+MZrZ7pggj?=
 =?us-ascii?Q?q64hqPA4PHSl1j9nytbeFjfRnyuXW/fSpS6vUaYH/0Iq+Y7BqumXTU8Lwl89?=
 =?us-ascii?Q?UvJWl/1WhAPMHL0t0UK7qyjjnemmJwWkOGI2sUd8euc6iBJGUzoLYUhHQVdt?=
 =?us-ascii?Q?Epd9rExVJcEFXBic3SWleCBFfqCCUDl2D9ZfObuKFBReyJ5QeEp5kpYuXfrB?=
 =?us-ascii?Q?DPgCbfI/mKXyd2Q3iSPJOhFsscm9eo62sg1XQ0U2NX8mThD6BbxGdq0U78Zj?=
 =?us-ascii?Q?FawLb9iHtp1hNy7sGVegzRIUp9XZ9YZVBPgjBU4Z9PlAPMvWVmpcJiX4G27/?=
 =?us-ascii?Q?Sql+gVHSXTrVrOsKhVpn2qh3JaURZ/7s7QmzsVM11aV/FQiJiAgmOrLLSlmR?=
 =?us-ascii?Q?SGNTv0AUIJjS9qiN0kyGRqDafshca/wgiW3EkfhZctA2NMF2WtbcIgrAOY56?=
 =?us-ascii?Q?jxa8sG83NT1FPr/JJLD2KbhOrO/RhdPPfw5yzWJuvEZnfxb+/JOScCt7MCe8?=
 =?us-ascii?Q?Gi8L6qMaJZTWjU86X8vYecxWpzx+hTBBE33wsjJO5c43II58EwHTFpMfleFD?=
 =?us-ascii?Q?aJGkuhUtCBO/RlsgMn2gmIcIclCk2az+52O66bQCsGVZgzVeU0RcuWoOGtqW?=
 =?us-ascii?Q?l8I1fcjJ6rO42LKAucZA8ge1bvtbe6SQcN0ZaLgtR0gwky9+OxhOKntcai17?=
 =?us-ascii?Q?aaSG6WS1Y/6m35eWd9njjPHx5lkQ13TY5rbti+vbGBbrp3BFSkML8Vr8I/Jo?=
 =?us-ascii?Q?BJsjd1ZF5YSl3/ekGxMIPgP5jk0J/wJdyK5NAb/csblx2dZQ8q2M5ulgV4E?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6c83cb-cec6-417e-fbc3-08ddc947794c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 17:44:57.1398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9201

From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, July 14, 2025 =
3:16 PM
>=20
> Confidential VMBus is built around using buffers not shared with
> the host.
>=20
> Support allocating encrypted buffers when requested.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/channel.c      | 49 +++++++++++++++++++++++----------------
>  drivers/hv/hyperv_vmbus.h |  3 ++-
>  drivers/hv/ring_buffer.c  |  5 ++--
>  3 files changed, 34 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 35f26fa1ffe7..051eeba800f2 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -443,20 +443,23 @@ static int __vmbus_establish_gpadl(struct vmbus_cha=
nnel *channel,
>  		return ret;
>  	}
>=20
> -	/*
> -	 * Set the "decrypted" flag to true for the set_memory_decrypted()
> -	 * success case. In the failure case, the encryption state of the
> -	 * memory is unknown. Leave "decrypted" as true to ensure the
> -	 * memory will be leaked instead of going back on the free list.
> -	 */
> -	gpadl->decrypted =3D true;
> -	ret =3D set_memory_decrypted((unsigned long)kbuffer,
> -				   PFN_UP(size));
> -	if (ret) {
> -		dev_warn(&channel->device_obj->device,
> -			 "Failed to set host visibility for new GPADL %d.\n",
> -			 ret);
> -		return ret;
> +	gpadl->decrypted =3D !((channel->co_external_memory && type =3D=3D HV_G=
PADL_BUFFER) ||
> +		(channel->co_ring_buffer && type =3D=3D HV_GPADL_RING));
> +	if (gpadl->decrypted) {
> +		/*
> +		 * The "decrypted" flag being true assumes that set_memory_decrypted()=
 succeeds.
> +		 * But if it fails, the encryption state of the memory is unknown. In =
that case,
> +		 * leave "decrypted" as true to ensure the memory is leaked instead of=
 going back
> +		 * on the free list.
> +		 */
> +		ret =3D set_memory_decrypted((unsigned long)kbuffer,
> +					PFN_UP(size));
> +		if (ret) {
> +			dev_warn(&channel->device_obj->device,
> +				"Failed to set host visibility for new GPADL %d.\n",
> +				ret);
> +			return ret;
> +		}
>  	}
>=20
>  	init_completion(&msginfo->waitevent);
> @@ -544,8 +547,10 @@ static int __vmbus_establish_gpadl(struct vmbus_chan=
nel *channel,
>  		 * left as true so the memory is leaked instead of being
>  		 * put back on the free list.
>  		 */
> -		if (!set_memory_encrypted((unsigned long)kbuffer, PFN_UP(size)))
> -			gpadl->decrypted =3D false;
> +		if (gpadl->decrypted) {
> +			if (!set_memory_encrypted((unsigned long)kbuffer, PFN_UP(size)))
> +				gpadl->decrypted =3D false;
> +		}
>  	}
>=20
>  	return ret;
> @@ -676,12 +681,13 @@ static int __vmbus_open(struct vmbus_channel *newch=
annel,
>  		goto error_clean_ring;
>=20
>  	err =3D hv_ringbuffer_init(&newchannel->outbound,
> -				 page, send_pages, 0);
> +				 page, send_pages, 0, newchannel->co_ring_buffer);
>  	if (err)
>  		goto error_free_gpadl;
>=20
>  	err =3D hv_ringbuffer_init(&newchannel->inbound, &page[send_pages],
> -				 recv_pages, newchannel->max_pkt_size);
> +				 recv_pages, newchannel->max_pkt_size,
> +				 newchannel->co_ring_buffer);
>  	if (err)
>  		goto error_free_gpadl;
>=20
> @@ -862,8 +868,11 @@ int vmbus_teardown_gpadl(struct vmbus_channel *chann=
el, struct vmbus_gpadl *gpad
>=20
>  	kfree(info);
>=20
> -	ret =3D set_memory_encrypted((unsigned long)gpadl->buffer,
> -				   PFN_UP(gpadl->size));
> +	if (gpadl->decrypted)
> +		ret =3D set_memory_encrypted((unsigned long)gpadl->buffer,
> +					PFN_UP(gpadl->size));
> +	else
> +		ret =3D 0;
>  	if (ret)
>  		pr_warn("Fail to set mem host visibility in GPADL teardown %d.\n", ret=
);
>=20
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 2873703d08a9..beae68a70939 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -200,7 +200,8 @@ extern int hv_synic_cleanup(unsigned int cpu);
>  void hv_ringbuffer_pre_init(struct vmbus_channel *channel);
>=20
>  int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
> -		       struct page *pages, u32 pagecnt, u32 max_pkt_size);
> +		       struct page *pages, u32 pagecnt, u32 max_pkt_size,
> +			   bool confidential);
>=20
>  void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info);
>=20
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index 3c9b02471760..05c2cd42fc75 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -183,7 +183,8 @@ void hv_ringbuffer_pre_init(struct vmbus_channel *cha=
nnel)
>=20
>  /* Initialize the ring buffer. */
>  int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
> -		       struct page *pages, u32 page_cnt, u32 max_pkt_size)
> +		       struct page *pages, u32 page_cnt, u32 max_pkt_size,
> +			   bool confidential)
>  {
>  	struct page **pages_wraparound;
>  	int i;
> @@ -207,7 +208,7 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ri=
ng_info,
>=20
>  	ring_info->ring_buffer =3D (struct hv_ring_buffer *)
>  		vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP,
> -			pgprot_decrypted(PAGE_KERNEL));
> +			confidential ? PAGE_KERNEL : pgprot_decrypted(PAGE_KERNEL));
>=20
>  	kfree(pages_wraparound);
>  	if (!ring_info->ring_buffer)
> --
> 2.43.0


