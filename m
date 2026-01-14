Return-Path: <linux-arch+bounces-15794-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 281ADD1FEC4
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jan 2026 16:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 389AA304ED93
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jan 2026 15:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE56214812;
	Wed, 14 Jan 2026 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pAccA2UU"
X-Original-To: linux-arch@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011062.outbound.protection.outlook.com [52.103.14.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101B6395242;
	Wed, 14 Jan 2026 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405439; cv=fail; b=nxlkXnvtA5ZCbC7ASd8d1JTE8lqkqtUZplOJ39OxUwtsy+w7q9J78c9gv9sPN9emU2Sak0gzYUlqzs+9m1atXIFIgSIgGA4ajREtYWE6pK3251I4BEuzzbl+Q3yaobK/b1r4vatwaZQfzbg9Eb4YV4K5MWWQHsTtbXtZ6KC7qlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405439; c=relaxed/simple;
	bh=dwUpo/2tvpuROsnd1mhlRCwFtVhiWNXExMwNeJH4hKA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JnRv51pW5g7IxGplWde99NGY6EMyA84BeJ6NC2IEpEu15PQEcPj4CpRWg8rMlN/3oMGS5vari5hO/2QKFLCM//VwW5+GkcNahTFirxkHftYfY6MAPy3KjTtp5fnDc3sIuieMETDJsDeo8qXjQXwt3tgMphIKqGtd8K9zRds020g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pAccA2UU; arc=fail smtp.client-ip=52.103.14.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaJ1fFxb9k8Sk7fx60sPIWE2YF/YjZxqJQ4q3HLYguGIaUksEXWc4pKdQUsYR8dnUJOXjmGGnMcXXgRqelwvt474QvfU7TRO+YS7p2Ua3nV/dKaoIThtcwBgKyqTXCZ2IP7IbBa25LaD6X9oQpGYce5BS1Mo9EprImZbH7dlcydPGQW2qom2E3mQ3NxD3pL1ZNyznOX8GUjBPIbmod+FVM4UuQtmN3fsUkidtfE3zwgazJwCKekZqg4nXu1DeXddV6O5U25WLrSgRDj0kg0Vg/UTILT3lkgz4bahrD4IY2T3KbO3FMw6XlUM9VWGALAYkGOTlRS3TfkIYJUXGmCnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwUpo/2tvpuROsnd1mhlRCwFtVhiWNXExMwNeJH4hKA=;
 b=eUwxtxLD450BdysHSR0hJAzN4stow7wB0oxfXTPCckO3jXQkUh/F6KDa2SdvYjw2xBejpnB6/J1KxvqxdUI+wED9lX2mciwBYNLvWNR34lT0d8VwIpgqVg+k2C1Mswempm7PftXpy8F5pOJuwfvlWo2IGO7qki7mVBtypAYkuPYE+s8BwlIfR/pwSjjS5tj5OJPL7rcvAYjXPgMHh/65bXHFx/dEaW5rk5rW8KgxiQHshy4HpTL+RErY745gzPLysKyxkmGVS/S3DxmnowW33cqHUm1yJRSVA4rkDyVM4DYTFxi/M4ok2447eRNuOhECWuSDRhkEAqiGh2ofJ4iTkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwUpo/2tvpuROsnd1mhlRCwFtVhiWNXExMwNeJH4hKA=;
 b=pAccA2UUbgt4JWk2HFDbGUvucIIYqR17xFLnoD7tcbboK6hXhT3hUzHsaWg4OJay3Wy8gN5pw2sC6GGxuDkmX8di5VHVaeFVz0Tl6NZ1mYCudKqDMoCkpJrjhfqTrsiJPEnalN3GEaKF7NTnMdz/Pl1DvduZxSZiO9R2j4z8yJATs3435L/d0ftk3cA35q4aWrpIxyZYaQBH4xvVhThnRKlHsdZjZ/m2L1vGpOCj52WEAMzq+Uw7Pjxoyvn/kqYpLhy86GSfaUcuENlVjJI8VoHTvbwq4EUS+1HBinRSsw3QzihKViFLF4T9IzRiMfzDY5/Cfy9DfDfCbSctdwXUyA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB8206.namprd02.prod.outlook.com (2603:10b6:408:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 15:43:54 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 15:43:54 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
CC: Yu Zhang <zhangyu1@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "nunodasneves@linux.microsoft.com"
	<nunodasneves@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [RFC v1 5/5] iommu/hyperv: Add para-virtualized IOMMU support for
 Hyper-V guest
Thread-Topic: [RFC v1 5/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Thread-Index: AQHcaMpb286bdBhc60y7Ts6ZOD3veLVIruwggAZIL4CAAAL1EIABmMAAgAFzcRA=
Date: Wed, 14 Jan 2026 15:43:54 +0000
Message-ID:
 <SN6PR02MB41571917BA6F36FC35359482D48FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
	<20251209051128.76913-6-zhangyu1@linux.microsoft.com>
	<SN6PR02MB41572D46CF6C1DE68974EAA1D485A@SN6PR02MB4157.namprd02.prod.outlook.com>
	<dws34g6znmam7eabwetg722b4wgf2wxufcqxqphhbqlryx23mb@we5utwanawe2>
	<SN6PR02MB41571D67D866538138D06585D481A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260113092940.000050b8@linux.microsoft.com>
In-Reply-To: <20260113092940.000050b8@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB8206:EE_
x-ms-office365-filtering-correlation-id: 11d57baf-6075-4390-2fd2-08de5383b93e
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|8060799015|13091999003|51005399006|8062599012|19110799012|461199028|31061999003|15080799012|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?M3Zrd2E3ajFCUFVyUkFBVEVRcHExRG5uZEpoTlBvaDhiUFlJZ2dscXZjYXpi?=
 =?utf-8?B?RERwQnlidlVvd1F5RS9YUUpuT1FOc3c2T0xXbWNQTTE5VTk2WUVkZzRVblls?=
 =?utf-8?B?SENOS3I5SFl2ME9WVndxaWgwUTBTVy9pbWx2LzRPQzBOWFkxVkJSUk95QWJw?=
 =?utf-8?B?L1lvelZuRmNYeWwwRnhyM2R6YXRvQWNNOFg2dU9wc0JaeHdwd2dHUkxTc3FR?=
 =?utf-8?B?UmFrcTM0bEoza29vYlJoUEV0M2Y5Z1BNcEZ5bkhkVlNWeFhHVitjSU9RNGVO?=
 =?utf-8?B?WGp5cEc4SGhlWDlOVE1Mb3JCUTFLUlB0TlFXVHZidUlEZ2wrQnJrb2FOYWRo?=
 =?utf-8?B?bXk4a002c3ZjSkRtUjBQZFh5RFJSVUtNRHRrTlJuaDNzUG9vOTM4Z0d0Wk5v?=
 =?utf-8?B?Q3BGbGdUdmZNZnBiSytvMC9IU0lWZ3c0UTJXTjZvZVRTbEZzV21JSG45V0s0?=
 =?utf-8?B?MTAxcHAzZlB1SS9Bc1JhV29jRUU2OXdzeXBiWk5xRmNiSnBkbytIa0xDd1RC?=
 =?utf-8?B?YW43Tkhpd2pSaHFpYiswOHlTQmlaaXM2N2tKOU1UNm5lRnJEVE1jTkpXWjI2?=
 =?utf-8?B?d2I4NkFOc0NVMlBOK3ZwbHVFb0RLanovQTdpZE0zOEx4MytYU014MUlhR2Jx?=
 =?utf-8?B?emdySVRXcXlabFUwY2FwcGtxQm9sVVhDYURrTGR3ei9iV250TWRtV0lQUVpx?=
 =?utf-8?B?bGtHWFVvc1AvbWpWY1pHTzFiNFBWYit0MnZjRzA5bnd6SURONUVWSGk4eEV6?=
 =?utf-8?B?Ukx1em9Sa01QUzl5MHdna0tZbWFQVzlVVDIweE53RTZsc3JickNZVm5TVnZl?=
 =?utf-8?B?Zm5GUExtem1VK3pZdGZwUGZqWnNSazRRdmVUZEd1dnpIbGlDWjNrM3Qya3VM?=
 =?utf-8?B?c3V3bDZIMEZWTWwrekwrTEJRQlNoc3YvK2FvK0pxemJLUzNEU1d0S3ZvY212?=
 =?utf-8?B?aWFpKzJvUHNKam44VC9LMXlWbmd1Q3FUQ0U1UzlIRnlyY0Y1VGtXUENzbGpw?=
 =?utf-8?B?TVhjemU5VHdGV3duWnVwVlp1OWh6bmxockpsaU9UYjc4dnd4ckt5d3ZZWXJk?=
 =?utf-8?B?aU5KcFpNbFZmcVJyK0lTUVZYaklwdXVxczIydUhyekU1RWdmeFlrMjI1dEhH?=
 =?utf-8?B?MmY2RTNMTkZQTGlBV2dZS3VsbjJlZU1NYUMweDBjSGpFMWZ2QVNQUVBWbE1o?=
 =?utf-8?B?eWtZVFVWOG9YN1FSbi9yV25wMThKbXFxWTMyOUNnT24vV2dQRUt4Tkt6SDB2?=
 =?utf-8?B?RjhoSitqa1pZMmkxSE1MRy80VG00R284WFFua2NZazdmT2dYSCtpWDAzWUJJ?=
 =?utf-8?B?ZTlpZ2gvN3gwblFQakx3SDlTSmhLWUwyMjA5dUlPVHFhRGQxTkZCZHZ1TzlM?=
 =?utf-8?B?OHRSS1k5U2pLTDEvckxIRm9ONVY5M0F2UjU3MGlIM1RpNlFUeDd6UWZaTHZ3?=
 =?utf-8?B?Tkd4TlpnbUI0WHJkZ3BoTlQzTVBBcURrNytpMlNvcTVvb0Y0M1VBbFNLaCtx?=
 =?utf-8?B?R0ovR1hjZkJEdHA1YllZcmQyMGZjMnZjNDZYRnh4ejlMWC94ZjJrd01rQnla?=
 =?utf-8?B?NE5ZQkMyZDcydUlZTWw3eHNzb3ZJRTZLMkI4a3J6NlgxYlp4NHBvaXRrUlc3?=
 =?utf-8?B?bTRtY1o3VVdMU2JJTVk4NGhHeXZUUjVxRHd6a2RqM3ppWHdlYzRobGpOWlVL?=
 =?utf-8?Q?+xOO615TINmFLsQ8QfZt?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RHNRbFpjTUxCMEJWaXFCZU05OTc1SEw4Y21IOFQ1bGZLV3FSdy9IUGo2SlU4?=
 =?utf-8?B?SmFaaGhlb1JrWEZKYzY1bnVhbDJzRDl4dEF3VllvV3ZEK2VUcFV4SFU3Mk9K?=
 =?utf-8?B?QUI2VDN3aE16blFkQVhHUGVMVHpLRWx4eWR0dmhSRURUSXN1Sk11Q2d0enB0?=
 =?utf-8?B?eVF1cUk0eWFzejc2ZUZKMnVFZHNkYVowNy9pMUVpdzdVZFp5NzBEb0FiWS9o?=
 =?utf-8?B?RFJJcUpaVE5PeVdaQTkyeEJ4QjVXQktnNXhHYzduKytldVJvNFljWUFMdzJk?=
 =?utf-8?B?TEZzWWJTUHU3TzEwaHNlR0hPenR6eExkR1Z5RXBWQXlBS0h2RS8vTWNSdlhi?=
 =?utf-8?B?cmlCUmZJUDlKdXpHVG80c082OVVMaEdSV0Zwc0gxUGN4U0FXeEJwL2pSQ2FM?=
 =?utf-8?B?RGhLR0szdit2RnZ3L1VRcTI5UWhkaVBaM3ZZVTdDT3kxaFBCSE9xbTNmbjVr?=
 =?utf-8?B?VVVTNTFLUXVvMjNQRWdrSkxLWlJ5YWtOdENBTWpNRzF2azJsOHJ4UHF4Zm9r?=
 =?utf-8?B?Mmp1TWhXZzhic3RoSm9zbjdKN2tzN01BM3hzc2pQRS95QTJ6c3ZnY2ZvWXVj?=
 =?utf-8?B?clhzTEk4dmxxTFFrdlE2enM2ZGl0aG9wcjQ2ODhOVmFVSmsrcDdmc093SW1w?=
 =?utf-8?B?REwrUG82ZUxQc2ViMUNuMXVGdkF2QXExL2FrUWdnUDlZbkZiMkN1TjJpc3d6?=
 =?utf-8?B?YU5nS2l0WWJHdnVERTZZSXRHeG5wV1NRWDlyN0pCRFFlOWswS0tWejFHZG9R?=
 =?utf-8?B?dEdCV0k5YlpEd1JETVZqWW1yZ2J5dUpGU2Q0YmZGZjdFUmFtbjBnc3M2R2Ju?=
 =?utf-8?B?K1c2V1hJTUtHazRYTTVjTGRtUGJ4R2Q1eWdUYnQ3WEdYVlBDeEFHK2o2dXVO?=
 =?utf-8?B?eTgySVRuKzFvQ1o1S0NxUGFNRkpiYVRySnR0ZE5ET240ekhvL3dEcGVFWGV5?=
 =?utf-8?B?ZlJhS1l3TEVBODdleDBYemxMK3dFZEp2WXhmZjRqejRQRDNZaEY3SnpiQ3Q5?=
 =?utf-8?B?bzhoT0tRWHIvd05KajZuWnEraWw2V0lEK09xWFNRbHpERHdMM0s1dzRELzN0?=
 =?utf-8?B?NmpvTTFCdThJUUlWbFVmaFJNandnclkxWHhMS3Nob1QyNzAxTkZNTkVKOER3?=
 =?utf-8?B?c0Vyc0R0RnlVTXI5dE5WRFBlRHNrTXczbWdQeTl3SmdseUFYZDRMc2NCZGZx?=
 =?utf-8?B?WExSVTI3VDMwSHJWaVZFclBnUHNRSy95OWVONTBncDZHSk4rTGU4VHN0aElN?=
 =?utf-8?B?NDBuQW9VSzNQaXpoank2VWFxUWEzbTQ2aDR5ZlpvendjbmwxbXplQnlJR0Zx?=
 =?utf-8?B?S3lSVUxHTHEybmZ5Z1FYK1NHNmtpZ0F0czZVQVYzbUFmemxFaXZZb3VrWk1y?=
 =?utf-8?B?dHA3aTc2VUJlWmlsaTJDSERMTGp6Y1JXdHFqbThNdnhVZmhkd0YwdS9raUc4?=
 =?utf-8?B?ZDlTNkZkVHF3d1RBc1dQclQrZElrQURETStsS3RyemhpWStscW8yd1oxOHE4?=
 =?utf-8?B?VFZEVVhTUXc2K1gwbWNVZFVxd3c1S0wvYWdkWlUyd1l6empLOENLbThqejdE?=
 =?utf-8?B?S1E0S3IwUWNUM2JRVHBwMUNBN0ZXWTR6SnlSZ3BOOWVjRU9KSzRxM2VLbzdS?=
 =?utf-8?B?eml3UytkTzdLK245WGZodHI0bzQ2QzI1SyttQy9wYlJCb0Z1WUZjOXJJVzJp?=
 =?utf-8?B?bUZUdFphM3dIRTN4cEpneHQ4cTRubXk2M1QyeVVoSHpab1F6ekVlWU94Q0ZQ?=
 =?utf-8?B?YmFBTzJMUFZrQUM3a00yVTkvR09BN3RzUC94YmV3WDZkK2VHMDJ4ak1VaUJO?=
 =?utf-8?Q?00OqQPPx5AQJVmaSBZ2ld29cmC2XRKFh8aZ7g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d57baf-6075-4390-2fd2-08de5383b93e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 15:43:54.6804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8206

RnJvbTogSmFjb2IgUGFuIDxqYWNvYi5wYW5AbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogVHVl
c2RheSwgSmFudWFyeSAxMywgMjAyNiA5OjMwIEFNDQo+IA0KPiBIaSBNaWNoYWVsLA0KPiANCj4g
T24gTW9uLCAxMiBKYW4gMjAyNiAxNzo0ODozMCArMDAwMA0KPiBNaWNoYWVsIEtlbGxleSA8bWhr
bGludXhAb3V0bG9vay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogWXUgWmhhbmcgPHpoYW5n
eXUxQGxpbnV4Lm1pY3Jvc29mdC5jb20+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAxMiwgMjAyNiA4
OjU2IEFNDQo+ID4gPg0KPiA+ID4gT24gVGh1LCBKYW4gMDgsIDIwMjYgYXQgMDY6NDg6NTlQTSAr
MDAwMCwgTWljaGFlbCBLZWxsZXkgd3JvdGU6DQo+ID4gPiA+IEZyb206IFl1IFpoYW5nIDx6aGFu
Z3l1MUBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDgsIDIwMjUg
OToxMSBQTQ0KPiA+ID4NCj4gPiA+IDxzbmlwPg0KPiA+ID4gVGhhbmsgeW91IHNvIG11Y2gsIE1p
Y2hhZWwsIGZvciB0aGUgdGhvcm91Z2ggcmV2aWV3IQ0KPiA+ID4NCj4gPiA+IEkndmUgc25pcHBl
ZCBzb21lIGNvbW1lbnRzIEkgZnVsbHkgYWdyZWUgd2l0aCBhbmQgd2lsbCBhZGRyZXNzIGluDQo+
ID4gPiBuZXh0IHZlcnNpb24uIEFjdHVhbGx5LCBJIGhhdmUgdG8gYWRtaXQgSSBhZ3JlZSB3aXRo
IHlvdXIgcmVtYWluaW5nDQo+ID4gPiBjb21tZW50cyBiZWxvdyBhcyB3ZWxsLiA6KQ0KPiA+ID4N
Cj4gPiA+ID4gPiArc3RydWN0IGh2X2lvbW11X2RldiAqaHZfaW9tbXVfZGV2aWNlOw0KPiA+ID4g
PiA+ICtzdGF0aWMgc3RydWN0IGh2X2lvbW11X2RvbWFpbiBodl9pZGVudGl0eV9kb21haW47DQo+
ID4gPiA+ID4gK3N0YXRpYyBzdHJ1Y3QgaHZfaW9tbXVfZG9tYWluIGh2X2Jsb2NraW5nX2RvbWFp
bjsNCj4gPiA+ID4NCj4gPiA+ID4gV2h5IGlzIGh2X2lvbW11X2RldmljZSBhbGxvY2F0ZWQgZHlu
YW1pY2FsbHkgd2hpbGUgdGhlIHR3bw0KPiA+ID4gPiBkb21haW5zIGFyZSBhbGxvY2F0ZWQgc3Rh
dGljYWxseT8gU2VlbXMgbGlrZSB0aGUgYXBwcm9hY2ggY291bGQNCj4gPiA+ID4gYmUgY29uc2lz
dGVudCwgdGhvdWdoIG1heWJlIHRoZXJlJ3Mgc29tZSByZWFzb24gSSdtIG1pc3NpbmcuDQo+ID4g
PiA+DQo+ID4gPg0KPiA+ID4gT24gc2Vjb25kIHRob3VnaHQsIGBodl9pZGVudGl0eV9kb21haW5g
IGFuZCBgaHZfYmxvY2tpbmdfZG9tYWluYA0KPiA+ID4gc2hvdWxkIGxpa2VseSBiZSBhbGxvY2F0
ZWQgZHluYW1pY2FsbHkgYXMgd2VsbCwgY29uc2lzdGVudCB3aXRoDQo+ID4gPiBgaHZfaW9tbXVf
ZGV2aWNlYC4NCj4gPg0KPiA+IEkgZG9uJ3Qga25vdyBpZiB0aGVyZSdzIGEgc3Ryb25nIHJhdGlv
bmFsZSBlaXRoZXIgd2F5IChzdGF0aWMNCj4gPiBhbGxvY2F0aW9uIHZzLiBkeW5hbWljKS4gSWYg
dGhlIGxvbmctdGVybSBleHBlY3RhdGlvbiBpcyB0aGF0IHRoZXJlDQo+ID4gaXMgbmV2ZXIgbW9y
ZSB0aGFuIG9uZSBQViBJT01NVSBpbiBhIGd1ZXN0LCB0aGVuIHN0YXRpYyB3b3VsZCBiZSBPSy4N
Cj4gPiBJZiBmdXR1cmUgZGlyZWN0aW9uIGFsbG93cyB0aGF0IHRoZXJlIGNvdWxkIGJlIG11bHRp
cGxlIFBWIElPTU1VcyBpbg0KPiA+IGEgZ3Vlc3QsIHRoZW4gZG9pbmcgZHluYW1pYyBmcm9tIHRo
ZSBzdGFydCBpcyBqdXN0aWZpYWJsZSAodGhvdWdoIHRoZQ0KPiA+IGN1cnJlbnQgUFYgSU9NTVUg
aHlwZXJjYWxscyBzZWVtIHRvIGFzc3VtZSBvbmx5IG9uZSBQViBJT01NVSkuIEJ1dA0KPiA+IGVp
dGhlciB3YXksIGJlaW5nIGNvbnNpc3RlbnQgaXMgZGVzaXJhYmxlLg0KPiA+DQo+IEkgYmVsaWV2
ZSB3ZSBvbmx5IG5lZWQgYSBzaW5nbGUgZ2xvYmFsIHN0YXRpYyBpZGVudGl0eSBkb21haW4gaGVy
ZQ0KPiByZWdhcmRsZXNzIGhvdyBtYW55IHZJT01NVXMgdGhlcmUgbWF5IGJlLiBGcm9tIHRoZSBn
dWVzdOKAmXMgcGVyc3BlY3RpdmUsDQo+IHRoZSBodklPTU1VIG9ubHkgc3VwcG9ydHMgaGFyZHdh
cmXigJFwYXNzdGhyb3VnaCBpZGVudGl0eSBkb21haW5zLCB3aGljaA0KPiBkbyBub3QgbWFpbnRh
aW4gYW55IHBlcuKAkUlPTU1VIHN0YXRlLCBpLmUuLCB0aGVyZSBpcyBubyBTMSBJTyBwYWdlIHRh
YmxlDQo+IGJhc2VkIGlkZW50aXR5IGRvbWFpbi4NCg0KQWggeWVzLCB0aGF0IG1ha2VzIHNlbnNl
LiBXaXRoIHRoYXQgdW5kZXJzdGFuZGluZywga2VlcGluZyB0aGUgDQppZGVudGl0eSBkb21haW4g
YXMgYSBzdGF0aWMgc2luZ2xldG9uIHdvdWxkIGJlIGZpbmUuIExlYXZlIGEgY29kZQ0KY29tbWVu
dCB3aXRoIGEgc2hvcnQgZXhwbGFuYXRpb24uDQoNCk1pY2hhZWwNCg0KPiANCj4gVGhlIGV4cGVj
dGF0aW9uIG9mIHBoeXNpY2FsIElPTU1VIHNldHRpbmdzIGZvciBndWVzdCBpZGVudGl0eQ0KPiBk
b21haW4gc2hvdWxkIGJlIGFzIGZvbGxvd3M6DQo+IC0gSW50ZWwgdnRkIFBBU0lEIGVudHJ5IFBH
VFQgPSAwMTBiIChTZWNvbmQtc3RhZ2UgVHJhbnNsYXRpb24gb25seSkNCj4gLSBBTUQgRFRFIFRW
PTE7IEdWPTANCj4gDQo+ID4gPg0KPiA+ID4gPHNuaXA+DQo+ID4gPg0KPiA+ID4gPiA+ICtzdGF0
aWMgdm9pZCBodl9pb21tdV9zaHV0ZG93bih2b2lkKQ0KPiA+ID4gPiA+ICt7DQo+ID4gPiA+ID4g
Kwlpb21tdV9kZXZpY2Vfc3lzZnNfcmVtb3ZlKCZodl9pb21tdV9kZXZpY2UtPmlvbW11KTsNCj4g
PiA+ID4gPiArDQo+ID4gPiA+ID4gKwlrZnJlZShodl9pb21tdV9kZXZpY2UpOw0KPiA+ID4gPiA+
ICt9DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICtzdGF0aWMgc3RydWN0IHN5c2NvcmVfb3BzIGh2
X2lvbW11X3N5c2NvcmVfb3BzID0gew0KPiA+ID4gPiA+ICsJLnNodXRkb3duID0gaHZfaW9tbXVf
c2h1dGRvd24sDQo+ID4gPiA+ID4gK307DQo+ID4gIFsuLi5dDQo+ID4gPg0KPiA+ID4gRm9yIGlv
bW11X2RldmljZV9zeXNmc19yZW1vdmUoKSwgSSBndWVzcyB0aGV5IGFyZSBub3QgbmVjZXNzYXJ5
LCBhbmQNCj4gPiA+IEkgd2lsbCBuZWVkIHRvIGRvIHNvbWUgaG9tZXdvcmsgdG8gYmV0dGVyIHVu
ZGVyc3RhbmQgdGhlIHN5c2ZzLiA6KQ0KPiA+ID4gT3JpZ2luYWxseSwgd2Ugd2FudGVkIGEgc2h1
dGRvd24gcm91dGluZSB0byB0cmlnZ2VyIHNvbWUgaHlwZXJjYWxsLA0KPiA+ID4gc28gdGhhdCBI
eXBlci1WIHdpbGwgZGlzYWJsZSB0aGUgRE1BIHRyYW5zbGF0aW9uLCBlLmcuLCBkdXJpbmcgdGhl
DQo+ID4gPiBWTSByZWJvb3QgcHJvY2Vzcy4NCj4gPg0KPiA+IEkgd291bGQgcHJlc3VtZSB0aGF0
IGlmIEh5cGVyLVYgcmVib290cyB0aGUgVk0sIEh5cGVyLVYgYXV0b21hdGljYWxseQ0KPiA+IHJl
c2V0cyB0aGUgUFYgSU9NTVUgYW5kIHByZXZlbnRzIGFueSBmdXJ0aGVyIERNQSBvcGVyYXRpb25z
LiBCdXQNCj4gPiBjb25zaWRlciBrZXhlYygpLCB3aGVyZSBhIG5ldyBrZXJuZWwgZ2V0cyBsb2Fk
ZWQgd2l0aG91dCBnb2luZyB0aHJvdWdoDQo+ID4gdGhlIGh5cGVydmlzb3IgInJlYm9vdC10aGlz
LVZNIiBwYXRoLiBUaGVyZSBoYXZlIGJlZW4gcHJvYmxlbXMgaW4gdGhlDQo+ID4gcGFzdCB3aXRo
IGtleGVjKCkgd2hlcmUgcGFydHMgb2YgSHlwZXItViBzdGF0ZSBmb3IgdGhlIGd1ZXN0IGRpZG4n
dA0KPiA+IGdldCByZXNldCwgYW5kIHRoZSBQViBJT01NVSBpcyBsaWtlbHkgc29tZXRoaW5nIGlu
IHRoYXQgY2F0ZWdvcnkuIFNvDQo+ID4gdGhlcmUgbWF5IGluZGVlZCBiZSBhIG5lZWQgdG8gdGVs
bCB0aGUgaHlwZXJ2aXNvciB0byByZXNldCBldmVyeXRoaW5nDQo+ID4gcmVsYXRlZCB0byB0aGUg
UFYgSU9NTVUuIFRoZXJlIGFyZSBhbHJlYWR5IGZ1bmN0aW9ucyB0byBkbyBIeXBlci1WDQo+ID4g
Y2xlYW51cDogc2VlIHZtYnVzX2luaXRpYXRlX3VubG9hZCgpIGFuZCBoeXBlcnZfY2xlYW51cCgp
LiBUaGVzZQ0KPiA+IGV4aXN0aW5nIGZ1bmN0aW9ucyBtYXkgYmUgYSBiZXR0ZXIgcGxhY2UgdG8g
ZG8gUFYgSU9NTVUgY2xlYW51cC9yZXNldA0KPiA+IGlmIG5lZWRlZC4NCj4gVGhhdCB3b3VsZCBi
ZSBteSB2b3RlIGFsc28uDQo=

