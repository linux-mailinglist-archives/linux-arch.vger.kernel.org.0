Return-Path: <linux-arch+bounces-12378-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B46ADF26B
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 18:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD81F17270B
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C20B2F0C50;
	Wed, 18 Jun 2025 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QJRF8kp0"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2090.outbound.protection.outlook.com [40.92.40.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD202F0C43;
	Wed, 18 Jun 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263570; cv=fail; b=I27Frd0QC2COK1dg7tMlgytKVPmoSI8ZqT6XE7CYm7MIztkp9/G/dQNsVNmleJeUb+u0CKxHIUjDr2Mrx3GRaE/v+ulj5hDxpG2KaZmOgK2nT2rsijBTqQxKqLAox0JntrrPQnlvytNyKz5l8MyM+WE2vAlVv8K81pN6XskzDLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263570; c=relaxed/simple;
	bh=0vMKN4mK779A3Ao1DlJIlt5VyVKLyfKr/IqM5ud8Ab0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OHD839Dz2Zrlt418zksSG3lFfH4ynfDTHS9ie+yCzeU8gM0p6Zil7uHeVyqNrnsvSX+7fHiIKKOEDTNqeZgUtjQ1lZb4u3eyUUJ1GsslCc870ovv7M7kMjF0LhRh5naBoeVh1te0ry/aidRfd0YDYMy/dl9CweXeF2Vgyzo+4uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QJRF8kp0; arc=fail smtp.client-ip=40.92.40.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8jGc5cSguAzb2krWkbcGHAX6YHRZmkB1F5vTcf33Gn/bbA+wXwA7goImL6JjzANemB00FcONTbs9n+UFbzBlBGhfgqKXpRIEpt7jgiq0dUdoX4k8AemPsTtdgLD0OaxzacgfSPxjsJRAmKasrNo6d/RV7gMlzqkgGYSwBhONS7NPuxu0Wd6h/IwZwWtZlyNtQLZs5M/FaFflRgvi1pkQsAB+pvZQLKVIgIfxg8U1SUJguBIEN0vie33NbgIQLyP5U+Ct4AqjdWB2LjETVU/uuUMApOa5FRWuBCl1W4bAacVFkIxfYZ8+QdIb13t5/KUVnJUVVdmnHawx2PTUJIdrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQ3MQ7tkY9Ob5nw9HGweUvhWjAnqFuSKRIfoxwMOp9o=;
 b=ha064rFm2I9krDrNKpp/RSn9IUwPnbD1PW+kOvmX3JAoNx6q0LrNbIwPME0jrn6HWkCpZ+xyvfjAWuNliDuIEWXQY2vNkDSgS/xsPDooY2MvZ2+FTG7/AMnA5ErCVhSUXPkagql9njKxp07Cjdc+JIH9LICyIEh/udbGobuu23lwsDH96u6TGvnvdD2xcaB9CbXdoGUtZxuArSjNTRthAaxhW55DEbSQcDCtb9YaTUzb/AMd9qiBv9TlAPrzoB771nhhbJhLu8o+nQQpQjTgzPQrghJFUoJyVPEsiM8rOFld0iVmFKnRkcF0ggan5ll4Mv1sN/FAU3ncHJ+wzOuvBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQ3MQ7tkY9Ob5nw9HGweUvhWjAnqFuSKRIfoxwMOp9o=;
 b=QJRF8kp0jMSl3kBrKqtawP75EWyePxbxjhAP+s5LVxGyxQ/NWF1kdjvMB8xZl5ioM2IUe8gj0uLiNbnUmSqFwCNyTPcVJoLEehY2MeG9YDmZAyZRAV1iQyX8GHmDbWjKXChPL4fICuG8o5QuHKe8nF/KLAwD+vp/EPnF9ylkIL/3gyL9PbjktNVK2eRUkKh5PJu3m237+klHVdqjNAnbLEyOeMqWrbcPrvSD1dHY0IAaStLZF72ySxvcae82f/4XA+UQWPAw54WsXQS1DMIQMf0nGxNYew9QNJq+0LJVdVgqg8XFvmumZf2YWQqna8kcxadIBQsAKENwcZixEfJkuw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 16:19:24 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 16:19:24 +0000
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
Subject: RE: [PATCH hyperv-next v3 12/15] Drivers: hv: Allocate encrypted
 buffers when requested
Thread-Topic: [PATCH hyperv-next v3 12/15] Drivers: hv: Allocate encrypted
 buffers when requested
Thread-Index: AQHb1Om880BCABbfFk69y5Pa+M8deLQGtcvA
Date: Wed, 18 Jun 2025 16:19:24 +0000
Message-ID:
 <SN6PR02MB41573796F9787F67E0E97049D472A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250604004341.7194-1-romank@linux.microsoft.com>
 <20250604004341.7194-13-romank@linux.microsoft.com>
In-Reply-To: <20250604004341.7194-13-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8462:EE_
x-ms-office365-filtering-correlation-id: 51e5c3a5-c8bf-47d9-4485-08ddae83e404
x-ms-exchange-slblob-mailprops:
 EgT5Wr3QDKyLtlCs+NimovH+2L5LUdRJDl75il0fRJzvD+iRDVOOgRvPpbddPlnCURx/boK8BU6E2VThopPok1WCHFl7TsXVC87eMXU6+op520dusXVjPb1KcWFnLmfW2TsVGQuDjeb7aczg1XAuq2j3Or8W/7aLw3IxrIHzBJTXG1OPMm9QR6WIyKA9t/KGHoNqPZyapwqNey7I3QgUEp1QGWUK/Hg8LEihdyUGCTZ6Gr8TGMzS/tD5P0VljJNYAx21TDiniAGWfptTP32Tebul52jzj5/Aq56xjxooptHvCUtd3Iu1IKu1AQPNgo0gVmzTgnNEL0H8wcN0YTBkl5yA7KpIt0a4hGGH8h1sFjgnSm99ncmKgZp6JTkORv3BGJevhb5B2+Sz5XihgImlNw+DQxK4pOLtzX960h6ytCwK3FeGeEGPU2/tNQwNYcxZZln7F9zcN4EbTc9PfRH9JFWm08aGXNMeffSJ2EQPvF4ukwkbBvvJ9J01CbhAn1XWYT6tC1UEQ4E+QfQvpVW5nw70TPkVoS0CfOUzfTqu9hSP2L84VLjptppzYPw7J6P+AAS23BVdVBL+CjIecvpKc+Anrvr1kw/ihgEjQOZfJ+AWuDmlFr2FaNKLemsbvdGFmjdrl0AH4d6APK0WGOsWla0ywWjRykvmJ8NgwgOmDcQfRWL2iTY+ZhDLgIBPJO8umGA+Gtw4Flkw8befJ/xoOnsuVsh2G6EX8p45oTzcGmI=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799006|8062599006|15080799009|8060799009|41001999006|3412199025|440099028|40105399003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?naAWRh058GTNlnhBseGi50hNrZtMkS5Zr5QeUm+UYT3T0Ei337i4TJQzWQWa?=
 =?us-ascii?Q?POPjubbXhAlrAhLyFXX7zdeomk9WqPerFbyBNO+4sU+R/RIKqLweK3fMwHhd?=
 =?us-ascii?Q?uecUlS1hPvdLZpOKDMqjtY3pgbptx5jrJwu+FTDh30rsBaiXqkO4PQFpO+cd?=
 =?us-ascii?Q?KbpE1WNJiqGm7YYcrVcxKdEcVSB9DgqlGjoXIVWD6P0iRCedP1vC8LdJXDEb?=
 =?us-ascii?Q?+y0R2rqCm5VCavNXHAFT5rK/2y8pxSSYJQvVZ7G9nQDRW21BRS1Z+92/dX2W?=
 =?us-ascii?Q?+ZWrszyTSk0b8yFaRbuivUcEuv4JadzfEKaZUr4Huk4LEsugwUE/x9kwHTN+?=
 =?us-ascii?Q?MSbMTrvFFbj4YrDKgG264bLDLKLzDzP4YeJDT5HnclwclmLVjk59VSu1s7+C?=
 =?us-ascii?Q?RsqT1KgQ3hDznDst/4nzyi29YJ36cm+/YbYNReXNbzcJnw1XWCmp/Fag1Swn?=
 =?us-ascii?Q?2V1R5VdLjU1LRAnx4fLRwzyGVsizfjUsH9nUj7Ip+JWP7rUa7FpYy/17cSHj?=
 =?us-ascii?Q?EPulx+x3Z/fyjooJpOryAzKAV9svrsg+BDkCUxAG3nhvcI76RnededoIGSj1?=
 =?us-ascii?Q?GpzE/gxKPDecR/u/F8+6MKUB23qP1pbQTlcnDTKkAEIP+jyXt1QM0y34fk6j?=
 =?us-ascii?Q?oJlZoYmx2rQG1/970p0nwTpLH7ojUs3DgVSLOz7qQFOjHvq+lSQZpp+yN3Lu?=
 =?us-ascii?Q?d23XCliAzymYnSA3ztkSTQsFuZWqqLC8QbvaQ/VdzI6FbPfyvA/oQi1pXfrh?=
 =?us-ascii?Q?i4fK+IrksqBDoa8CHrbLGTY38Kw/lRnTzFQv4WKzKUPK6upWexCO5BJ70pp9?=
 =?us-ascii?Q?1rrf2/LU0nVJOKl2AT+gMmC/amNCHh/U9nlkwgGW53CUvtfyF/SerRd6UNFv?=
 =?us-ascii?Q?x4u1Z1lHPo+2UmU6UroceXEZEuifr+pUkzafBp6CfqcMibGjrSASChaWLdW1?=
 =?us-ascii?Q?soWQiPoLVcDpoy46nMas8nWrjuNJJGG5ZM5RLCQOE/sZH23bnYrn6wrXrJ2j?=
 =?us-ascii?Q?eOYN5Os1q9EyvvJUph4YKZL4Oc+yrq7kd88yZnWqWsPpJjV/JX7DoqZWtWc/?=
 =?us-ascii?Q?899UMxKKv8ryy5ilRJFqSf6q/9Cd2pC9vVo2MjlD4kQD5M1fHqgwEqd/GUqx?=
 =?us-ascii?Q?ijEIJt1Zkd5dutSQvgsyuEncOEWcIz4J6o9e804gfYqt3hpkos3a7U8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NUxD9GbdF//Etu2CXkG+9zjBd4glek9fNHRwNJjsL2sxqhKcWPUsFE7ehSYC?=
 =?us-ascii?Q?hUz0CauXiakcqoacpewls1mvkmsqa4lbNQbvVRgvUDNk9ceh4mkBhXZN5Dtn?=
 =?us-ascii?Q?V6SYHLpR7BxnUAxHXDohGZ0a7NXHEVByQOHUg8AQbZyuY2IP094FqtPGO8l7?=
 =?us-ascii?Q?NYSxbT/tKGFtttZToOfs24Un0iltgbv4mV0m3lHDjaHiFMYh6NqRsK+SyiTN?=
 =?us-ascii?Q?PC+6I8+4McHCeqtUoZ7TyOkkTUzJLhONpFrFBczFH8a8NWI2XWjm1AM7TTME?=
 =?us-ascii?Q?9eNpUNp/AT+QhVT/SO2HCsqMCwOYTZp2OzAtuGJyMio91ixSLMLkIuRGiqe/?=
 =?us-ascii?Q?lY3uwDsBrrKW9nT+Qx+yatHE0P+498imSfRofxUmzhbzH1hDE8V/Xv3fPiZi?=
 =?us-ascii?Q?Ek8p4KjM50AjDsqEAg/WRdxP84M/3Hok13JkXZ1idUFameWvbQwyFJou0VGz?=
 =?us-ascii?Q?W4NqDkoUgpl8Kv3gBluU8Xo6HNh8Im/ng3WNoiHcIKoWPC52oTo02gClv26D?=
 =?us-ascii?Q?VuDgT8ALMwRcArorwb7AHt91hnZvx+fu6E0+VejedDgrIaPIX7rm3m4Be9Q+?=
 =?us-ascii?Q?TpgRTEKgLqEaMHaHpoPgks639W7OiG3tyOqnAqhMbKCxmW+4Js0NuZZWRR5n?=
 =?us-ascii?Q?7SL4WKFNPmCpuGAd5DBysoG3IahbJ32iI84Bi23SuIk5N8xuc97k+odBRmSt?=
 =?us-ascii?Q?89ik0WcjWz894TqoFzUoEW5+qzuksIbwKkRUWDcZ3UjOZaEsCxciFCnsl8w1?=
 =?us-ascii?Q?UncKKXv8aqiRGylcIH48XuU4jfhlO3fqAzQjEgo4QvLacTOQSzF9NhSNuICY?=
 =?us-ascii?Q?AGrC5CkgfitYQNhBoDOBcyY0cgq/sgmwduVkYQHo6DJXLqjqQyUtYPSDtnC6?=
 =?us-ascii?Q?zZFPPALzX7MgeBjPHGrLNimJs2vkHBQaaXiCwD13Z1hI5bUYeWWVdxHlnwTD?=
 =?us-ascii?Q?/EfrZ3UkDVkBix0CdMXPiWvLlMORn4485YF2AWxUS9QxKCHlan0alGSPwLDU?=
 =?us-ascii?Q?1uQUs0M+nkrsHshrcjxWl7qFhfm0mhl2ISRVvPnmTkyTVuqCeAuCCge5yILm?=
 =?us-ascii?Q?0vFEstmAV1vhTyHqntWyK6g0CbOvs97Ny7Oay8LLXNqlobte/2Yi0OMCoMEh?=
 =?us-ascii?Q?EV9E8EQp40EDSH6JStptJuIjtB0qsIOsUzqBcpskJrVoeciYbCp+XvEWvEpk?=
 =?us-ascii?Q?nt1oLWdBA8kq2aKSCPnqocjzMveodXwE4bL6o0Fa2RaxQSEoZxpCP3FPLjA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e5c3a5-c8bf-47d9-4485-08ddae83e404
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 16:19:24.5304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462

From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, June 3, 2025 =
5:44 PM
>=20
> Confidential VMBus is built around using buffers not shared with
> the host.
>=20
> Support allocating encrypted buffers when requested.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/channel.c      | 43 +++++++++++++++++++++++----------------
>  drivers/hv/hyperv_vmbus.h |  3 ++-
>  drivers/hv/ring_buffer.c  |  5 +++--
>  3 files changed, 30 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index fb8cd8469328..3e2891c4b800 100644
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
> +		 * Set the "decrypted" flag to true for the set_memory_decrypted()
> +		 * success case. In the failure case, the encryption state of the
> +		 * memory is unknown. Leave "decrypted" as true to ensure the
> +		 * memory will be leaked instead of going back on the free list.
> +		 */

The wording in the comment seems a little weird since the code below isn't =
setting
the "decrypted" flag. Perhaps:

The "decrypted" flag being true assumes that set_memory_decrypted() succeed=
s.
But if it fails, the encryption state of the memory is unknown. In that cas=
e, leave
"decrypted" as true to ensure the memory is leaked instead of going back on=
 the
free list.

> +		ret =3D set_memory_decrypted((unsigned long)kbuffer,
> +					PFN_UP(size));
> +		if (ret) {
> +			dev_warn(&channel->device_obj->device,
> +				"Failed to set host visibility for new GPADL %d.\n",
> +				ret);
> +			return ret;

This return is leaking the "msginfo" memory and any "submsginfo" memory tha=
t
was allocated by create_gpadl_header(). It looks like that leak is present =
in the
existing code as well.

> +		}

There's still a problem here. If VMBus is Confidential, then the buffer mem=
ory remains
encrypted. Then later in __vmbus_establish_gpadl() if we get to the "cleanu=
p:" label
with ret !=3D 0 due to some error along the way, set_memory_encrypted() is =
called on
memory that is already encrypted. That should not be done as
set_memory_encrypted/decrypted() are not idempotent.

>  	}
>=20
>  	init_completion(&msginfo->waitevent);
> @@ -676,12 +679,13 @@ static int __vmbus_open(struct vmbus_channel *newch=
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
> @@ -862,8 +866,11 @@ int vmbus_teardown_gpadl(struct vmbus_channel *chann=
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
> index c1df611d1eb2..0f02e163b0a0 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -199,7 +199,8 @@ extern int hv_synic_cleanup(unsigned int cpu);
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


