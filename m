Return-Path: <linux-arch+bounces-12897-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A0AB0E2F0
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 19:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B67561179
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 17:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D7A281375;
	Tue, 22 Jul 2025 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tdAgughW"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2088.outbound.protection.outlook.com [40.92.42.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8359428312D;
	Tue, 22 Jul 2025 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206320; cv=fail; b=e95QBTQZz0b76o2J0migs8WFS4CKOFL2YQm/kzK3va7P0Zx3RFQNVEClDFdGcfHw+nXLtPB0acWSbVFRy7jsl15KYxwSf6iEoKcW9TUZx0a2g8wb3b61HcP57GhIWvQjzFDb28Pcz+m00A9f/53H0nnfnw1NjshqeHkzXZNgCFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206320; c=relaxed/simple;
	bh=3Fce6U2RCQHVv5g8jB9TaUGF9rIf/qtTCUjpkwcB5ls=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NKVyF/sX4GPYtRctVPlxm2Lhc2BAiu09KDBLV+IFrZ6UHgoekecDzfn670236pRQA6TScbFzS8BQqU1ZBUGBpRsj4gNlK+W3caXeEJIvIL2rNS+sm2vEh02yc5+RBOEuuexj7o6p55njEVSOGbj6TCulTAaEvRP7P4PHBJyuK/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tdAgughW; arc=fail smtp.client-ip=40.92.42.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYzuhSjgLrXX4x5o0Yq87OGX558LVSNJUk+6uIEbNrB7/ag/WHjwcsYJxOotfalL8F3jerS36EgxLIyuNsRc4ttGjJgZB5nUj3tvWQkl0BsMFP0Rh2NEkIoub4ZFk1AbCKTc0KQoekbQeyu2fjbhgq8ucU/0RKM2LVOXm5wenN8mOex8v/91F/bvSmDy7mi6K2jzK9/Z2t2+OUNcLD5jCmB9MEXrvRrlR4e/K4qwQqAmWmW2/+0qImKNlTMzsvBlxx/4gcOYRd4gCwVv5wENlAfrO2b6Tv5DLMPJY0DBlQKvGSJ0cwlxeIGX5LrZJdn+aCbalPG8LmxH8NBbbXzk7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/NPO+y2+nTZqT8Unnr4jmCQ4NwJd4pioS5vo0faU1E=;
 b=P6MUW3QJZB6X5ogRr0Mf+owFPKARBCHGOueMKy65n0KkmEXyEJvDf7wGKZXSwIqKIC5QVhCVfT3M8KoC3yZzXT/cm/Mruqnbmk5qgXTDwpJ7Mwfok1ere/WS541LTBpHfe11YOkSUVpDgzH1R4LfTwboVj90f0UoxaiE7DTlAFPcFeS8t8Gj7HUOW1xUWe8yfQ2jVHx14tVKZ1TN5bNLdtoi/K6fKW3pXCcjmaFvyKwn09UztkOzjWtFOcIvKxuLfwQUSTGqtvxjLCWYZ+GQiQDVNVNacL/ttay/w8Z/Mc2Ij5c2B2ePr/+B2ymVuWhPCMjQMMsI9Q0l+1gs/x6H5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/NPO+y2+nTZqT8Unnr4jmCQ4NwJd4pioS5vo0faU1E=;
 b=tdAgughW3LX/P1AGTMT+szxS/efhLzqUthY4X8Rrc2st4Z4EWJk0Ffm9LLxlPveJH0Zh6uEckQSHVAZ7GpuaS6afCoZT3ziT8+bmF3DGeD87UT9XPfPcOHUQ4g45BSADSSl90IgtkP5nVS03lF00g76bkeeVYv1SpBq2XVN/fZFS2CaBbDZxAUc8Ru67r+B3jczxul5RGepF5PXbD6EH7nwajAH0BXk3OFOikWCU4n4BJ5sJ9PVQbOv+TxP8p+Cd5yNc+ejGdTa1XbyeikhvZrGsyhFyKr15b3NnNArdm7bQnG8TthxM1JIHtMQk7FFTMDnMJoKC6DLWW21W5ETkBg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9201.namprd02.prod.outlook.com (2603:10b6:930:9c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 17:45:14 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 17:45:14 +0000
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
Subject: RE: [PATCH hyperv-next v4 14/16] Drivers: hv: Support confidential
 VMBus channels
Thread-Topic: [PATCH hyperv-next v4 14/16] Drivers: hv: Support confidential
 VMBus channels
Thread-Index: AQHb9QzdiG3gZaN0aEy5PNeQtFrsP7Q4xlmA
Date: Tue, 22 Jul 2025 17:45:13 +0000
Message-ID:
 <SN6PR02MB415786D31F8D00B0E7815FF0D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250714221545.5615-1-romank@linux.microsoft.com>
 <20250714221545.5615-15-romank@linux.microsoft.com>
In-Reply-To: <20250714221545.5615-15-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9201:EE_
x-ms-office365-filtering-correlation-id: 691679eb-430f-4226-c49d-08ddc947835b
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|41001999006|56899033|40105399003|3412199025|440099028|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KyqKTAtaxXoiy7yE2Y0gomEKJ8UMOwegXuhyDfOzbtunImd9KfGZgKfuBaR6?=
 =?us-ascii?Q?HSfOX3gug6tt7vYYf4aPh6MIEN9GB/X9USdV8l41yNTZMhgkTwJcXhzsQya1?=
 =?us-ascii?Q?6iD40QItmqEuDwQRv1/YP7PU1qQaeo3YzjPaJCK/FRgZLZ81hQ391NZWkoXK?=
 =?us-ascii?Q?Su85yHko5rthe3GA7xi3UjYXnVjCYcg/1gmiFvLC3AYESUBRYgxyL7m+YM7P?=
 =?us-ascii?Q?EAAzDQj8CBEPjdc4OsoAQyt65KGHmbmAOjUvII8FpHCO5gwwW9Q5ojcfn43S?=
 =?us-ascii?Q?YAXmFtNvFKyFxQogWF94qdBpm295vMRMn0gQCKHKXxK21Dh+ar3K0HKQ4RDd?=
 =?us-ascii?Q?zjKhNkkBGsQCIsLoHSh7i7FPr0pLvVuXN2kTSnnAcvxOtfwHIvShR868AjtZ?=
 =?us-ascii?Q?ENowbjeEADh0eOE1uoGjwTyUwLRHBAXbhH9APe8qcf/59+5Uga0+ANQ1b76D?=
 =?us-ascii?Q?mkOSKo8x+rxu/7He1IHp9zANY1g9L1KEFhEI1sRW7v8Pak+pGHgrtcdNia/P?=
 =?us-ascii?Q?XBuVFsijdhCfbssyyF1viFg+mP19V9ukgAefdaYCS6oFe7edHDBiuXV07Y3w?=
 =?us-ascii?Q?vyjjc0mtqwl9HNg2QcKNiO4sCkAqP0LkP/myEjl8D6tokId+gNy5vzJ0R4pC?=
 =?us-ascii?Q?voaO9pE8n+o5+gWLq15OFjOjEWwUSGS+nbKFO6F5g2Gd58YSKVmi4AkjFCCn?=
 =?us-ascii?Q?CFHcORESXkYGhA1QD1/UQZ6VQv9e4w/r6c4rVE66pRAt2GX6IyQqCyAdCWAv?=
 =?us-ascii?Q?bLPiDCvUXW7cYtzco3/0fVX22ilVWzmgwTICOQwIiw5vbMPguHCRVNFUTvyR?=
 =?us-ascii?Q?J2EXP1a34/iAqeMfXQjjwSPjzKcwkkJy6QFk2Ea0erqkr718DTCfhJp9NYAR?=
 =?us-ascii?Q?11y2cX2SOIKqFTON+y5WO6DCD0JX7Bhja6qFfe1Sd0sYz3yvuK+Ya9aJp5aQ?=
 =?us-ascii?Q?uqyZSKGH3rRnatx6nIFDbPDY0qGCmztXXp5ZC+Aczn5kKHmpmCEJ6YegKga+?=
 =?us-ascii?Q?T9E0AgMe2c7qUSFCaZT+4UaXq1qXq+E0tkaa01Aa6/f3wBfIt4ITqAMMDyUf?=
 =?us-ascii?Q?UKAfSCyWE2r/pl4vSlNS5bcmS9xLew=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5E29jXKaHq7vjUhbjpknSijfz88B+lB35qBBtFBphnA86BOwjwdRO+TAoUnu?=
 =?us-ascii?Q?emKZtWN+C8zNfsT7MwxASg3qdvMeyR83XzkVkIvVOTcRFQC7BaRmLVvffCVD?=
 =?us-ascii?Q?Ad7zvj8O7YMxlEtg9TiPb8o3d438c8zATKGsXe9aJI8YYp0W9411Qk8wl7/N?=
 =?us-ascii?Q?I0VPYMiG/ZW1+wiEH7NzXOOzMt3oLbhtC7BbFPSiZ9W+3nrruoap9by/vHvO?=
 =?us-ascii?Q?HXVhJ/tGPSgH7qVN5l2Igr+NrDTmhWJG8I0xSLdcj7no5ojWXIm6vtrQm0p7?=
 =?us-ascii?Q?LvZMtSUymHS8ORckUCdaHSJHQEOmSJhcqkUjEwGNkLzMmtHaAuwywMtqYhEg?=
 =?us-ascii?Q?1Cz+V3ulXHK9oLu7b2mz80/H6kw2xfsB8fGxVbBQeT/w4jq7Wvoprrc8MrBX?=
 =?us-ascii?Q?D8BCTG98N682PbERjIzNcEBMB4ETm1q1CMiozfs7HK/vLapjdNNdc8LzlMTt?=
 =?us-ascii?Q?BPg34gjNZN/JfJwNtM2YBbQWSlMOlk0h4sjBk8mMY9JladO0GljMeb73ELiU?=
 =?us-ascii?Q?qpx6zt2nQeUIxH/o3zJq8pmbamepPl2QR1W075jH9EK7HLBer3WF5QVgpZ/6?=
 =?us-ascii?Q?d0Y2DmzqkuzbDw38NE5PB+g3mzfEqddMoHAgGGb+q3GOLmO4kv9GkHl330ka?=
 =?us-ascii?Q?fhatKhG5Dw2wkcXUoVf4G0YV7B/Txxr4SXMvFAsPled9Epkujg32RS0FxKTV?=
 =?us-ascii?Q?UKGVOnvwjkPKEd9XglMC3QvJdjBpBxlboRhVs+qpFXJungZ+5hrdON/l0+Vp?=
 =?us-ascii?Q?7vHp76RqpkRImW8OPnHLRG6zntD5JeltFQf5ejLZmd7KukvbhX/BeiISg6LZ?=
 =?us-ascii?Q?lwQmocCh7PfZ5zjiEAMDj2GyqQ5FeWCu/C8cnGUSKh1UhPOBapm4M9Wskiu2?=
 =?us-ascii?Q?WeO4RfcM9bQp6Eg3O576AeDUKYpmAk9+jjxKlosWO33KZ+VnR5F3qmjehNr5?=
 =?us-ascii?Q?8CmhbS6owA8SjN1EA7prz/tCG5qYzbsWiXmKqbQSdm2IERlyYZU26Z1lDMdJ?=
 =?us-ascii?Q?YV1d/iwOZ7GNWy2aKIHHk4QkEUFDMUyQ0kQa+d1ENgehtXaS/FIamlzMaWZ2?=
 =?us-ascii?Q?s/Gel8/XGZQWje+9mMCg4DWEfrhdLXc6h2xcyBVm0tSDcz/1tP6mG92sPRLO?=
 =?us-ascii?Q?PtRQXhhy9qnPt0lTqvjTNuggnUs7+fK4QZe9jOrTK7Vynw1Fi+n3mLearAe7?=
 =?us-ascii?Q?mgQ/bjVLuq93883Cog4MdE5cGvgcpPzGB7GEHRAdo75dNd4C13uitV1Vd4U?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 691679eb-430f-4226-c49d-08ddc947835b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 17:45:13.9865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9201

From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, July 14, 2025 =
3:16 PM
>=20
> To make use of Confidential VMBus channels, initialize the
> co_ring_buffers and co_external_memory fields of the channel
> structure.
>=20
> Advertise support upon negotiating the version and compute
> values for those fields and initialize them.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/channel_mgmt.c | 19 +++++++++++++++++++
>  drivers/hv/connection.c   |  3 +++
>  2 files changed, 22 insertions(+)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index ca2fe10c110a..6ae44eab1626 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -1021,6 +1021,7 @@ static void vmbus_onoffer(struct vmbus_channel_mess=
age_header *hdr)
>  	struct vmbus_channel_offer_channel *offer;
>  	struct vmbus_channel *oldchannel, *newchannel;
>  	size_t offer_sz;
> +	bool co_ring_buffer, co_external_memory;
>=20
>  	offer =3D (struct vmbus_channel_offer_channel *)hdr;
>=20
> @@ -1033,6 +1034,22 @@ static void vmbus_onoffer(struct vmbus_channel_mes=
sage_header *hdr)
>  		return;
>  	}
>=20
> +	co_ring_buffer =3D is_co_ring_buffer(offer);
> +	co_external_memory =3D is_co_external_memory(offer);
> +	if (!co_ring_buffer && co_external_memory) {
> +		pr_err("Invalid offer relid=3D%d: the ring buffer isn't encrypted\n",
> +			offer->child_relid);
> +		return;
> +	}
> +	if (co_ring_buffer || co_external_memory) {
> +		if (vmbus_proto_version < VERSION_WIN10_V6_0 || !vmbus_is_confidential=
()) {
> +			pr_err("Invalid offer relid=3D%d: no support for confidential VMBus\n=
",
> +				offer->child_relid);
> +			atomic_dec(&vmbus_connection.offer_in_progress);
> +			return;
> +		}
> +	}
> +
>  	oldchannel =3D find_primary_channel_by_offer(offer);
>=20
>  	if (oldchannel !=3D NULL) {
> @@ -1111,6 +1128,8 @@ static void vmbus_onoffer(struct vmbus_channel_mess=
age_header *hdr)
>  		pr_err("Unable to allocate channel object\n");
>  		return;
>  	}
> +	newchannel->co_ring_buffer =3D co_ring_buffer;
> +	newchannel->co_external_memory =3D co_external_memory;
>=20
>  	vmbus_setup_channel_state(newchannel, offer);
>=20
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index be490c598785..eeb472019d69 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -105,6 +105,9 @@ int vmbus_negotiate_version(struct vmbus_channel_msgi=
nfo
> *msginfo, u32 version)
>  		vmbus_connection.msg_conn_id =3D VMBUS_MESSAGE_CONNECTION_ID;
>  	}
>=20
> +	if (vmbus_is_confidential() && version >=3D VERSION_WIN10_V6_0)
> +		msg->feature_flags =3D VMBUS_FEATURE_FLAG_CONFIDENTIAL_CHANNELS;
> +
>  	/*
>  	 * shared_gpa_boundary is zero in non-SNP VMs, so it's safe to always
>  	 * bitwise OR it
> --
> 2.43.0


