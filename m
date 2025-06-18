Return-Path: <linux-arch+bounces-12372-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EFBADF24E
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 18:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9EF1BC1AE5
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 16:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B182EE299;
	Wed, 18 Jun 2025 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Fm/yLMgk"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2075.outbound.protection.outlook.com [40.92.40.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B262EB5C5;
	Wed, 18 Jun 2025 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263503; cv=fail; b=pV7HCG2iL1JOK5NyW2y39I7d0MT6e+tuSJCj/1QHScG3cBPswfsEkvlqknpecnR+Tzu7RNDwJfhUAOMOwwEN2kfc2TOPv3C/7HINui1uHq211EvvTNu0Kw9pgc3M5RYJBkvPAvVGVfjOGc6y2J1tLCE1WAUiwb4kcJ7Z1zrqs08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263503; c=relaxed/simple;
	bh=Ur4h91T2kNXOd0VB0Ok2ca4g6Va9T7qTLfdJ5kRgglU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lu/TVZc+E9IvsknD/bnIQ6PcBBktThLfLd8Epw/8eSikZEoFCCd2aad9t/Bt6AHYr9pnC5dHfSW7j6Wasx3BOa4zQsdfAnd1RY0tH9+EdUDREbT1OB8LkowzIbs89Uqpb0bU5gIrZT3U0CO6ysvLbZfjJsP+Wvf5XskL3x/HbGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Fm/yLMgk; arc=fail smtp.client-ip=40.92.40.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNUaAuaQatCxOyezk20jjN1cbi0J3nutSS4XN9ME6OZsQE0P5bSjGwCFWHZqf2KtV6N19I2uIUjN84Kk5uJ5xBgYbB9JCxQj+GXCSSHlICQ+lU/OvxA0mFoGlZiss/cc5Lr9suJR7Z7wEcWP59Pe0UmUbuGmaxGgRSfu8hhYDFQ/k/REll+ERPvlhv+cQOhfZRnfhfdcB9DgLDi4ep281nDNFp62M32v2ruQ5F+XMr+zotZ64eazXiJLg1J8f8GGOqnPnexqt5IhARzD36Khk6BHSfhFb1by0lUA5ClLabQ+wCaJ/WHxYgcugy2T7Z7kBcpOklGjsn/dlTNSL73PSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2lAnEfVQVDN2LB+KAwCjLVpwDZAG4wBi1oYhNs6oKY=;
 b=XzYWDcLJL3QLkMJCdaTTNiFHKCbIxSnZooKas5D19aaHUQQM7xysYna7IBZtU1zLwuQXuk5Cpk+qxTapjW/tdjnE4IhtSCq0zZaNMu0xFhBqQ3YG/LGPcg/NAfrg7EZhj53Bf0611zyYiby+YQ2nEPE4FfisrjdGcGHhpV6ncfpIo/M56l9NcJXadbPqN+hNK20iwAkCAq8L5lmm3LgzbEHcuh2mYXg9z8eRuRksnVUQf5LAyWomJL20+kXpMMFmX1CJs0agAevSRW9OHDM+HBu9o7zrUKZMIjMxK8rZDpYOdKPzo99PXPGv71vRRzMh6jEuqR2eugPc5rDm2SU2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2lAnEfVQVDN2LB+KAwCjLVpwDZAG4wBi1oYhNs6oKY=;
 b=Fm/yLMgkzP6Lu9fX1HAxH8XwqWxVjbGb9d45vuGDlqt77iV8XE3c1BUlv8XljqaVqbmg6ZOmmi388IvwBNMaawCdc8l1EG1TKssPi2NRnNgx7uAcvAGl3B7gWuohexOFl21gFh0Y8sa78SvfGGd/Le7iDvjCLLH5RKfNHoztnIftBlPIeIJtgrXl1YCBoo8tHPz82b0aNQK54+TPr7PV2mKdGLOmN9MhJWzZ1nC3LXrnEW+jscZrMKR5IvCpOqejPrXYN2k5t4we1NQYik347IOQJRsn6zrNaCTrb1RFu/AnZG0s4MhjbkQmitcdUqr7wwu8D7mHoIa7rYE6QNhGYw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 16:18:18 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 16:18:18 +0000
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
Subject: RE: [PATCH hyperv-next v3 05/15] Drivers: hv: Rename fields for SynIC
 message and event pages
Thread-Topic: [PATCH hyperv-next v3 05/15] Drivers: hv: Rename fields for
 SynIC message and event pages
Thread-Index: AQHb1Om8l/Cfja6RyUyDyFKbD/ka3LQB6ZvA
Date: Wed, 18 Jun 2025 16:18:18 +0000
Message-ID:
 <SN6PR02MB4157F1743B73616286BC4CABD472A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250604004341.7194-1-romank@linux.microsoft.com>
 <20250604004341.7194-6-romank@linux.microsoft.com>
In-Reply-To: <20250604004341.7194-6-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8462:EE_
x-ms-office365-filtering-correlation-id: fde06f47-f8aa-4f4b-dd73-08ddae83bc90
x-ms-exchange-slblob-mailprops:
 ZILSnhm0P3k1KuhwzYdE6C/ocrAmq9m00kg422Wb/EAeNIL8ZKvZkECDQqjovwfyzRBbIouYuwk21Hqwab+YXk1dHH5d2kZTI+H+DVNBaK0nnEbIoArRAVwui1QiSQlTVJLxgjbof42kC4sQ5PkB7X82MCdpqIycfxdZwgTCWhAxGXYApeoN5xjxf7hzv8UFRFuA6bPJjeTtuKOcdbiel8r+yjaSzAe9/P7XeU+AexUM4LML2wAUxtVfjZWAUHh1bYs/QeJtB1y070kIzrVJ/THPN+xPSaOntG7qp1Z+u23zhZemYYXLjjNGnWR8x2LHdhmG6FvnDeHXsutV/SaRAJwV3iX7r2sO565Bh+oQnn9tJ6PdhISaiaRTMDrVnbzV/F34CsFlBADSw6SMWXBJoRE98pSysYVVLJ+uL0+ZdiZLGGf2Zy//D0+bm57uyQwTCq1SKywKsI7Z1UawQ/iSn7REkYgsGwPdkuwPJP3TNMUU1zLdEwQxt2r6uPDOVJwmzwJ5v5f/O22gbcObLEOi7LVCgpR30+IOSFJABig07VYB6QLaYH7C8uYdY2Amj/pF55QWNBTjsMAYtLqdgJzod5Yo86VvsvqqQqARzBeT5aNCMjBJMblzCNVPgLabbOYmvWHsML7LQB5mCvKQYE3facEBK8tn9Y0YnL/47pZO7xA6e7C6JgyX1Agph4ZffcaktLKD7oZLkUXXzrV8It+1PXH7nxJDvJjeHvyZ7UvRzPx9CQCeRdCMex+Hn1grUPNVoddCyqhwxSYj1hr+g9OleoL4HH2FBj9s
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799006|8062599006|15080799009|8060799009|3412199025|440099028|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ftaEh40LpgOF3ovMNa0SoUj1Iz/ZOb074ONxj7dzelAR4TsoESO0v6LT0gyd?=
 =?us-ascii?Q?QIt8r42aS8k7PQ57IRYdmmd5xgkRueSaFp5py/QttCpGsQYOBqw90XIDV7mW?=
 =?us-ascii?Q?TMb6CqQYHkzHTjV0FVLQvvboH69ih0Q4YaKnzoo1iz7v7TKOmjeSBogQmCiv?=
 =?us-ascii?Q?l194qXuA2cMIjUrKKcQ+KcHmXiwk8fyT8AX4x7zk9MJLgAv8IessUYkGCNTH?=
 =?us-ascii?Q?yktmPHaanMpqFpPumIatimuK8Eh+T+44WxvoOBm6uy97oemINI8uUytXXtmg?=
 =?us-ascii?Q?4X72Xw35ICY9p4rFert+N9ILv2R8Osq6l2qOEpP4pLpsUfnPHpA38Pew9XyI?=
 =?us-ascii?Q?Lq5ysaUdfEQd/w3Ta5dhWQHP+bcJtq+NdL+DMbfU8VaOTvzN7DDWCbx7IW8d?=
 =?us-ascii?Q?dH+QH1rIf/g+1UD0VCugIe/9pgbzcMGFhlfYUhyuEJtgg6v+NX1eWG9N6Zk6?=
 =?us-ascii?Q?LMvsr5QAC/xtf4vDTODxtV3EvhYvH1dFYEz2uJdK3ALikJ4vdlZmbo+eZ4Sw?=
 =?us-ascii?Q?U+Tf/vm1cInMn0dGGkHk+R9JXwBgj24djL4MppB1l4vOQk9OVrVSNtm+X4Es?=
 =?us-ascii?Q?17NCF1c/JcNHJqprLU0tzcjcrbDox7C8b8X+RlOejCEE8w6cElR/tQorKF45?=
 =?us-ascii?Q?lOptXffHpj/OiXXV+OLd5EciIp/clQckbyDWo1vNQ0k/FMRvR8vieGRyy4lr?=
 =?us-ascii?Q?Chw+fSFTXbwwf92wy6BC7xdh1aM853rNYvg9l3OdQOFfz0PKzH6xL8OcFLDN?=
 =?us-ascii?Q?zpBEMuHCf8wwPu1vslhPfc+4/6BHhL3elpfDO3n99zU6SIUTqKjLMATArs5J?=
 =?us-ascii?Q?T2qlkhaNfbFJYmM5Bl+7zuUz7ynUSTIhNmQZy5izZunI6c9pua9wH+Ee4Xg8?=
 =?us-ascii?Q?+R0cOsVUS0Cb7iekwYhFvQvBVckskP+G7Gm1XiQzf0RphS9tNpSS6UenJy7w?=
 =?us-ascii?Q?VdtAF3vIKTLg3bMToy0AqYzQI86vAtxvORYqbbcWj73oCq0IhmQVQ70lecFx?=
 =?us-ascii?Q?rfucFCrsdMFyMmALBPXWvEu0LQNsXCO5IfSvnnVcJNRGJ7MfNQR3fpv3vX2V?=
 =?us-ascii?Q?OoctPWv4Ht4af5+XKDa30K86h8yAdCItAKRxNDVQD1WkHiEw5Mk=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aAYKP+rvumKeEwFZremB2G0JkYfPE96qVOhw6z5tNYxzfcIBP9CyLMtU7wgR?=
 =?us-ascii?Q?ASPlgREydTJZzc6cljWOp0NGMiqIYWqzSVhTI8EEppP0/rQ8WLn8bqKb1Soe?=
 =?us-ascii?Q?vbz6r20Fwoa7KZ8BMr3NnNuktSZ6JP2dpZLoeTD6P5L80ehbiFVWqYDRRDgU?=
 =?us-ascii?Q?v2pUd98W2ilC2NVkuazZ6zr8DQFBuL0jIooP/adxKAgLrORBS/eeL3VPtxTW?=
 =?us-ascii?Q?gW7/C/tnPZXioMefEsJGPBKr/2ei8BfNXnN+rokBk3bdU+RWiHPxDNj2QI2w?=
 =?us-ascii?Q?UpqaLIpVd9+pze57KPAKlejJBd3T/C+AKcZxO05apuB0UpIEwfnqLKi6fRBz?=
 =?us-ascii?Q?MUhn1200VNWO782ZBfyvX1ddS9Ju8AgzaKe6nT9t8kML1fc8Jk2J6RBLPNvk?=
 =?us-ascii?Q?U1EFybsn5ro2KSRmZwPbb/fL53rxcyuv0GoVCuAVA90RoXTm6Xbpr7LyS2gG?=
 =?us-ascii?Q?tIcsXHKPrBaaKxl7G1t4KdlXOZkSp7i5LmUZnFHb8nvLaKVmbzZaSl14lGro?=
 =?us-ascii?Q?Dnwphmyt9LcLp40OkiVFn3H0z+51luitdQr47W1mls7rKjDq9XbbY2CYCuUW?=
 =?us-ascii?Q?wW+a6Dv6aAawmTP9DnnZg9b58eFq5A7ysl36/FfHp8Mr/D/QqZz3YAuXPCbb?=
 =?us-ascii?Q?3NUlDk/tiqI3w86CuJFihAFgB5fnV7pcEfyUvsvhWk3GSJ4puPNKrUJTa79N?=
 =?us-ascii?Q?dnGRNn3fp0RlV2mUsWK9XGJTf3WphbbORNPRu/2RgyH9/izMj310MlhlG8nN?=
 =?us-ascii?Q?/RgeUVxB1clU8quI1cH9MxZP2ZostXpqb4eUqPZb5kFkeS7mNd0V+Iv6tsct?=
 =?us-ascii?Q?FQpwAVOLxLqaE13ZqrIFLjmGOdvPuYmjyB09pAvcdP1ie0/fvNUSgfgrQcjM?=
 =?us-ascii?Q?gElgDj3JTvnjZQVcz3VK2QY3SsX9jRQ8GE1hE1Us+3nfyFFkv4IHni+yuFHs?=
 =?us-ascii?Q?+qqspYi9GbTsrW0v6OA4Tn/SzjWhpQkRuJljFMtdcdn+8aAhVqmJAGugPh/I?=
 =?us-ascii?Q?osBO/mTC1T/B8D8bWCOF/xIZRnu7rztR2/YrDFZoUkCybzIjWjOIYOV3rFP/?=
 =?us-ascii?Q?TePgIE2j+sgoZV3E3mWgFFI5Ic5KzM5GxOS7aT5kX7p/yIjPyNYnQqtIHHBc?=
 =?us-ascii?Q?Gt3lmUW25n25/Fog2fmqS1+rLKZHVMawaxglgt9dz+ahuGbvjLJbfFJsKc7P?=
 =?us-ascii?Q?+YxtuhmnBRs/lac0hKfRdRieMyJ1yfeDueBwLEdxOTvsbhn345sUJz85QVE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fde06f47-f8aa-4f4b-dd73-08ddae83bc90
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 16:18:18.3942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462

From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, June 3, 2025 =
5:44 PM
>=20
> Support for the confidential VMBus requires using SynIC message
> and event pages shared with the host and separate ones accessible
> only to the paravisor.

Slight tweak -- tie this to having two SynICs:

Confidential VMBus requires interacting with two SynICs -- one
provided by the host hypervisor, and one provided by the paravisor.
Each SynIC requires its own message and event pages.

>=20
> Rename the host-accessible SynIC message and event pages to be
> able to add the paravisor ones. No functional changes. The field
> name is also changed in mshv_root.* for consistency.

Rename the existing host-accessible SynIC message and event pages
with the "hyp_" prefix to clearly distinguish them from the paravisor
ones. The field name is also changed in mshv_root.* for consistency.

No functional change.

>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c |  6 ++--
>  drivers/hv/hv.c           | 66 +++++++++++++++++++--------------------
>  drivers/hv/hyperv_vmbus.h |  4 +--
>  drivers/hv/mshv_root.h    |  2 +-
>  drivers/hv/mshv_synic.c   |  6 ++--
>  drivers/hv/vmbus_drv.c    |  6 ++--
>  6 files changed, 45 insertions(+), 45 deletions(-)
>=20

