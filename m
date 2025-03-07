Return-Path: <linux-arch+bounces-10588-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86006A575E7
	for <lists+linux-arch@lfdr.de>; Sat,  8 Mar 2025 00:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6AFF178731
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 23:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95140258CEA;
	Fri,  7 Mar 2025 23:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Tuu4T/y/"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2062.outbound.protection.outlook.com [40.92.21.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E0C219E8;
	Fri,  7 Mar 2025 23:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741389674; cv=fail; b=PyFOxSH9rvdmUy/0cdIWrgo7YgtYRxHv6bR2Da7iKTvDURM6zAec46UsVc/MvWkVKeZqGg8phKG9XhP+O7CIeNc/ADPlwtQ4CK84A+c0XuVW027JNX02/YZHLjB+2KFFkiJMYzzKJ+icin8WjKE0Z3IU+kVZdHOhgBlNcSvF+tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741389674; c=relaxed/simple;
	bh=xwuNYS6aHKiilN4znvQEwtcx3gs5Y9n/x5UIGvWk1xQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i8TgCO0GtVk2lv48PhfeUt63rlOCdi/VUk7i36KkCGa4x7laeg+SLqPEo1omj1h9lO22IoZ+Hyvm2ZopQUH/6qB5j5LhD7UeEePv9cLgnwn1UU4fu+O9iqzxSGQMC/ObeiMZU+O0TKig89gcILAdx8KYgPc1aWGPRiWyvIbIr7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Tuu4T/y/; arc=fail smtp.client-ip=40.92.21.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKchapo3+WHGZILst4JCgr1fGZOfdKfBpf1UJjIZKqoNEtKM7PT7eKcOIqH6pzVJrLnKHQDL4+kinHc49odsllb4n+Xg7+8VHyCiH2Sr7CfLHzuCPKA0r8Eau0GVcNmR1zKN4h6Z1lkeCfhpIZkbA+l0Bew1LC2zSid8Z8h8mSPVKtMtuURD2ypffwxtyTYd9/VjZfBu20aOWJl9ZaX+34Uv4WPMViDvtomVF8HOQ0XS1Wjb8MOvu76lRrF5VY6bMPhB+eL23ci5f+m5JMOXATYX8KxT+aRtqZiuBnk/BSQADEw6R5pfKkatZXPV3ahAS5X8o5EeGFCGR7EB/fi/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwuNYS6aHKiilN4znvQEwtcx3gs5Y9n/x5UIGvWk1xQ=;
 b=qm9TvWxHEB2N7ZQWaXJGYdzHbRMH8/SXXThapYIpeiDGeGS6s2L/cu3CFbkc5rB6ZtQyyR9jMFOW+w3qSa0uSBqSHdZDWzwEnrESGSpoAFCtCP8YN8SH7cAf9gJOMYwiIP6+QULLCB8KBhPxGk6fY5Zi5gA58bxxfz9+5R8Lmxc44Z2aJ+WNPyO5hJ3OYOel8Lxr/J0fZAtp8PT2Mhw6vx8wpEI3ffqEoV6M3uWRiilpl0e5eAYTZ9LflJu2aL27ZVHl1Jo9ByQLRgwMjkOU6/23WtISxGcUvDL7ScLbcYwNviBPTciwe140tjmrVN8Ew7egK9VW0lUV5SVg9YTk8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwuNYS6aHKiilN4znvQEwtcx3gs5Y9n/x5UIGvWk1xQ=;
 b=Tuu4T/y/iZ/AZwd/3Ra2yztEbipoiVXrxn2d4EEt+ZNa4xS0fUddi3QOmibIh0jGScEfYGp86qSoVFZY9pqFEexNPF4XiaDUCWNkULjvNZp1+wJbkZOeRnwsmjorhZkFaDy4YtpI2L6SZa7zdWva8YwbmjE1bwTYN82bOwI8D9gy0vlP6X0pijDrg4HVVeJiAyb94vnwC254Ns0XlSgXGqzgezbahfCJQmN63ftqpUSiPCNJWl1bVN+cvtIdOjr5Np5eh3dNmBgrjRYrE9YTZLUUeikrXnD4bpi64bClgEGiMwRF0jNOepB6hTbzf0EPzTRq5VjO7lo6p4HIPcDpPQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB9001.namprd02.prod.outlook.com (2603:10b6:510:1fb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 23:21:07 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 23:21:07 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org"
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
Subject: RE: [PATCH v5 07/10] Drivers: hv: Introduce per-cpu event ring tail
Thread-Topic: [PATCH v5 07/10] Drivers: hv: Introduce per-cpu event ring tail
Thread-Index: AQHbiKNvTQlMQtRMy0ySwjthERjeILNn7PMQgABcNQCAAA2QMA==
Date: Fri, 7 Mar 2025 23:21:07 +0000
Message-ID:
 <SN6PR02MB415710BED37BDD375B0D769AD4D52@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-8-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157107676CF415A464C2C25D4D52@SN6PR02MB4157.namprd02.prod.outlook.com>
 <63437aa6-d45a-4b7a-b222-5901c03c48e0@linux.microsoft.com>
In-Reply-To: <63437aa6-d45a-4b7a-b222-5901c03c48e0@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB9001:EE_
x-ms-office365-filtering-correlation-id: a4e8fc7c-696b-48b9-fcfc-08dd5dcebd26
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|15080799006|461199028|8062599003|8060799006|12091999003|41001999003|440099028|102099032|3412199025;
x-microsoft-antispam-message-info:
 =?utf-8?B?TmVjZ2tLazBXQTBYU3JkSytUTGwxaCt3R2t4TVd5TDdvZGVrWE9kK1Z2aGpv?=
 =?utf-8?B?MGhxNFoxSUpZVzBjSkc0Y0tWUGNQMjFPdkhockV2eFROTFRzcGxmWmt6VTdZ?=
 =?utf-8?B?dHJYRTdzM1pFZ1BFMUVMZGNnQmVRTVNCRVFZa211YXkzZnpBRFNMQmRjckRT?=
 =?utf-8?B?YkM2bUlYY21pSkdSbkVqcUdZSlBCU0VsYmFqM3d5SWcwRGFUR0plZjFuOVhP?=
 =?utf-8?B?YUpLbmViNEJGakswdTV2NVE2L1ZLS1NrU2ZqUkJ5SmxEdmoxYTFESFduMGNY?=
 =?utf-8?B?L05JdUFLUmZQeDVWWTBLbGMraXc0QmZjdkVUZGE4b2hSTVR2b2lwTFhlZm8v?=
 =?utf-8?B?TjZYZVRJZCtrMG5FOUpnZy9yRGIzeUdXU05IN2xYUi9ZNnFabERldWV6THJz?=
 =?utf-8?B?UmVuUWVOaWhjL2ZOVEdtNlBhbGNiZ0tPdkpJOFNKTTUvT2RhcGNmZFBVM0RQ?=
 =?utf-8?B?blZyc0FUQWwyNDlyeXB5MnJQUHlYMGp1bXd1aEJ2Nnh2b2lSRXg4UlNYUmRN?=
 =?utf-8?B?ck1WaWQ5Z0FYbFBVeTNXY0Q0di9tc1B6amlwMFJUNnBsa3djMDFMMTN2WGwx?=
 =?utf-8?B?TmNRcmtSR2hMVzBVNlF1QldMaEpZc0xBV2VzSWljQWYxZnpjZTIxZ1A0TlpZ?=
 =?utf-8?B?aVROUzVnU1FOQTN6cndGNlNML2NLUjMyV2REeXFzRmV1TWxUdHhBY2hRd1pF?=
 =?utf-8?B?YlJyeHE1ZUNsQU1haHZnUSswaEFSTXBYVEpMczZZV0JqS290TnRzeThic29m?=
 =?utf-8?B?Z08zZCtLS1h4UUJJalAzYnNnbVdnaXluSzFSSSttSjBnSkV6VWJEOXFvT25Z?=
 =?utf-8?B?NzJxSkppU2JkL2YxekV0UUFBYjdxZjZJRExLY0R4VHZQL1V1SmhjUWpWcG8z?=
 =?utf-8?B?Rk5UZVYzdThlK0NtTER1YTkrSCtnZFlrUDJxUGwvSXRmNWtXUk1zTDBKWlRG?=
 =?utf-8?B?cWpYWlJST0JXcGRvYmRnbkhiSEFVdGF4ZVBJbXBONkVid0dVYlpXTTZUOUxS?=
 =?utf-8?B?d0VSRXg3c0laVXNjK05pSVJLdzVvZjBtclQ5Q0ZGb3ErT1c0biszL1VzdFJX?=
 =?utf-8?B?UjF6bmRHVTA0VEFNYTV5TDFkWFhWTi9KUTVOU1V3eEI4WktFSkNUbE54UWx6?=
 =?utf-8?B?akVrYzE5WEdDTFM1TmZFWEFudU1kQXJwN0RITkYvYWViQThkelA4NzRCOE9l?=
 =?utf-8?B?QTB6Y2NIVzBSUXlKQTV1TzNoMUJFOTI4Uy9GR0VVVVlOK1p3My9yNytJQkxw?=
 =?utf-8?B?enRxK2t6bDA2S014R3gxSjd3Q21zbVcrVElJaXRmSmtYRlpienE2STAzYzBk?=
 =?utf-8?B?NFF2SGVnNTFVQ2syVlhyc3lPMEQ5V0xQb3hpdHdzSmZlNHRhY29nNzNYelY4?=
 =?utf-8?B?cVlGeTNiYlpNN1ZCTkFLOVNYL0Y3eGFsQmNPMThMblExSHk5N2dqZkwzQkNz?=
 =?utf-8?B?bnd2clVYeTBYTE1wek10TkJOeStpd3p0TXROcmt1WFI1WGNPRWsxMFBtcjVI?=
 =?utf-8?Q?f95Ycc=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cTRKWGxQT3NhaXl2V1JsdDBiN0NlQW9vejFWM3hpT1hYNEE3cEVNMWlsMnpN?=
 =?utf-8?B?ZG1uWEdKM0FITzBPUWFMT0ZxUmxDRjRiRnhtNHZ1MHR1VjZ5SVJDeXpNdzV3?=
 =?utf-8?B?WUZxd3NLYlJiWitMZ2hIWFZIM2JwdUxURlBuSUwzRGRFdVV1NUtBSDZpWEVo?=
 =?utf-8?B?Z0FKQXJTOUMrbGhPUGkycGNwaVJBSFR2WEw4TTlyRFdrYW11Q0MwNys1cm1O?=
 =?utf-8?B?NkE3Z2F6Zm52N2NsWUp4VlpmSzdtaWsvSXIrVTd6ekQ4Q0dBRnVxV25yRmFC?=
 =?utf-8?B?bUM1TW9SL1pob1FjTmNjRVFZV08wWnk3M1F3RjNnMTRvY1lKLzVPempnN2wy?=
 =?utf-8?B?SVhoQ2lMZnVZZlJ5NVAyZlpsL0JaUVhmVWFvUzFpK0dmMVJnNXdzaThUMkx6?=
 =?utf-8?B?b0xXdUczM3VXdjMwZSt3UFNEaUVtZzl1T1FhaU5aVStnUFRHajRVKzREQnhY?=
 =?utf-8?B?WXliOXZSU21DWkpyNkgyTW9OUDZqS0hFWWZPalZzUU53alZHTDRtdjI4Q05t?=
 =?utf-8?B?d2NmK0dMeEY4eDVheTFmS3RnYnZrRlM5aW9BR2hMc3VueTgzOGVnNFA1c3Fs?=
 =?utf-8?B?SE44NlZqalE3YTR4QzJoRjZZMmQ5OHVkcUxJamZ2L1Uvb1ZWVFVBVWpwdVBu?=
 =?utf-8?B?dGI3QTM5YUdrckRIVENtek5pMm96bFBRakoxWWQ0MTVWak1GZzgwMFViMElm?=
 =?utf-8?B?WDdQN0srdUd4VVZOeVF6QkxHK0Y2bTIxME9JWFNQeU50VC9PdUhtQjc0N2hX?=
 =?utf-8?B?K2s3TVRMZXdYRHl3OTRuRWNLZkY2NDExMTNKYW9SM1RXVFU3RzBHd1EwWmhG?=
 =?utf-8?B?dE5ON0s1ejVwQ082WHh5RHNzNWt4dFp0NlZlcU5JYTdxL0IvaVVPZzFwaFhF?=
 =?utf-8?B?YzZLRGFUZ2luWThibjFqUTRvQkJlTW82Tm9tS3g1SXZWSnB0SGwrSjU4TXZ0?=
 =?utf-8?B?YVdMNGZCSlBNSzN5dXgwZ2FLcGJrSnhRZUlNc0k2VUQyNHNscGxwN25zSzNE?=
 =?utf-8?B?MTE0ditTT3EyRjJUZlRLWFRhMFI4UW9UYW5QR2pCejEzUURaRENQenFxOFpl?=
 =?utf-8?B?VFBBYUU5UkZXK3ZJTk1rV29CSTZwQXdQYis2Z0g2dExmUndROE1OMElxdzFu?=
 =?utf-8?B?UXA2eTNzbklsU0ZUbGlsZWxib0pWblhzR1h4OU1PTHRIV3dwaFBSUmhlUkFq?=
 =?utf-8?B?Z29DQmZnVFFMaUlJd1FCU3hqM1l6UzNlWkdSYW1TY0ZueksxUXZVV2Njb2sx?=
 =?utf-8?B?NXoxbUZEZHIwWGlvTmQ4YTlpS2s4dnhwYWhpOElhd3JJeFhtVXF0UHpybmo4?=
 =?utf-8?B?U3pubFlxM0N6TSsyQk4rVmoyMmVUUGtENUxNRFJaSDhSNllUSklIVkRqaG53?=
 =?utf-8?B?K0VLb3JndDN1NCttK2NqQXkwNlpTS3JUK2ppczFmdWlMenNvVHpPUW9MS0g5?=
 =?utf-8?B?cjA5MTFJUjhrVzRtcURqUmRoSllZOTJmdVhzbi9wNkhFYmw4andROEE2UHFH?=
 =?utf-8?B?N2RSL3UrdG82UFZyMjVteFVJa2FmblZoK1UzejMyTXZ3eUZ2a3JndXpiR3BY?=
 =?utf-8?B?UWRXc1dmemtFTWRsajltMVdmNzRCNDF1TUFqb0tlTlFmZmFKR202TzI4RTJD?=
 =?utf-8?Q?1wrJhlfGy7emYxuv0B1iHN++TQuNcZFXdm2E2J+AHRQs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e8fc7c-696b-48b9-fcfc-08dd5dcebd26
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 23:21:07.4069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9001

RnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBT
ZW50OiBGcmlkYXksIE1hcmNoIDcsIDIwMjUgMjowNyBQTQ0KPiANCj4gT24gMy83LzIwMjUgOTow
MiBBTSwgTWljaGFlbCBLZWxsZXkgd3JvdGU6DQo+ID4gRnJvbTogTnVubyBEYXMgTmV2ZXMgPG51
bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5
IDI2LCAyMDI1IDM6MDggUE0NCj4gPj4NCj4gPj4gQWRkIGEgcG9pbnRlciBodl9zeW5pY19ldmVu
dHJpbmdfdGFpbCB0byB0cmFjayB0aGUgdGFpbCBwb2ludGVyIGZvciB0aGUNCj4gPj4gU3luSUMg
ZXZlbnQgcmluZyBidWZmZXIgZm9yIGVhY2ggU0lOVC4NCj4gPj4NCj4gPj4gVGhpcyB3aWxsIGJl
IHVzZWQgYnkgdGhlIG1zaHYgZHJpdmVyLCBidXQgbXVzdCBiZSB0cmFja2VkIGluZGVwZW5kZW50
bHkNCj4gPj4gc2luY2UgdGhlIGRyaXZlciBtb2R1bGUgY291bGQgYmUgcmVtb3ZlZCBhbmQgcmUt
aW5zZXJ0ZWQuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IE51bm8gRGFzIE5ldmVzIDxudW5v
ZGFzbmV2ZXNAbGludXgubWljcm9zb2Z0LmNvbT4NCj4gPj4gUmV2aWV3ZWQtYnk6IFdlaSBMaXUg
PHdlaS5saXVAa2VybmVsLm9yZz4NCj4gPj4gLS0tDQo+ID4+ICBkcml2ZXJzL2h2L2h2X2NvbW1v
bi5jIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiA+PiAgMSBmaWxl
IGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2h2L2h2X2NvbW1vbi5jIGIvZHJpdmVycy9odi9odl9jb21tb24u
Yw0KPiA+PiBpbmRleCAyNTJmZDY2YWQ0ZGIuLjI3NjNjYjZkMzY3OCAxMDA2NDQNCj4gPj4gLS0t
IGEvZHJpdmVycy9odi9odl9jb21tb24uYw0KPiA+PiArKysgYi9kcml2ZXJzL2h2L2h2X2NvbW1v
bi5jDQo+ID4+IEBAIC02OCw2ICs2OCwxNiBAQCBzdGF0aWMgdm9pZCBodl9rbXNnX2R1bXBfdW5y
ZWdpc3Rlcih2b2lkKTsNCj4gPj4NCj4gPj4gIHN0YXRpYyBzdHJ1Y3QgY3RsX3RhYmxlX2hlYWRl
ciAqaHZfY3RsX3RhYmxlX2hkcjsNCj4gPj4NCj4gPj4gKy8qDQo+ID4+ICsgKiBQZXItY3B1IGFy
cmF5IGhvbGRpbmcgdGhlIHRhaWwgcG9pbnRlciBmb3IgdGhlIFN5bklDIGV2ZW50IHJpbmcgYnVm
ZmVyDQo+ID4+ICsgKiBmb3IgZWFjaCBTSU5ULg0KPiA+PiArICoNCj4gPj4gKyAqIFdlIGNhbm5v
dCBtYWludGFpbiB0aGlzIGluIG1zaHYgZHJpdmVyIGJlY2F1c2UgdGhlIHRhaWwgcG9pbnRlciBz
aG91bGQNCj4gPj4gKyAqIHBlcnNpc3QgZXZlbiBpZiB0aGUgbXNodiBkcml2ZXIgaXMgdW5sb2Fk
ZWQuDQo+ID4+ICsgKi8NCj4gPj4gK3U4IF9fcGVyY3B1ICoqaHZfc3luaWNfZXZlbnRyaW5nX3Rh
aWw7DQo+ID4NCj4gPiBJIHRoaW5rIHRoZSAiX19wZXJjcHUiIGlzIGluIHRoZSB3cm9uZyBwbGFj
ZSBoZXJlLiBUaGlzIHBsYWNlbWVudA0KPiA+IGlzIGxpa2VseSB0byBjYXVzZSBlcnJvcnMgZnJv
bSB0aGUgInNwYXJzZSIgdG9vbC4gIEl0IHNob3VsZCBiZQ0KPiA+DQo+ID4gdTggKiBfX3BlcmNw
dSAqaHZfc3luaWNfZXZlbnRyaW5nX3RhaWw7DQo+ID4NCj4gPiBTZWUgdGhlIHdheSBoeXBlcnZf
cGNwdV9pbnB1dF9hcmcsIGZvciBleGFtcGxlLCBpcyBkZWZpbmVkLiAgQW5kDQo+ID4gc2VlIGNv
bW1pdCBkYjNjNjViYzNhMTMgd2hlcmUgSSBmaXhlZCBoeXBlcnZfcGNwdV9pbnB1dF9hcmcuDQo+
ID4NCj4gVGhhbmtzLiBJJ2xsIGZpeCBpdC4NCj4gDQo+ID4+ICtFWFBPUlRfU1lNQk9MX0dQTCho
dl9zeW5pY19ldmVudHJpbmdfdGFpbCk7DQo+ID4NCj4gPiBUaGUgImV4dGVybiIgZGVjbGFyYXRp
b24gZm9yIHRoaXMgdmFyaWFibGUgaXMgaW4gUGF0Y2ggMTAgb2YgdGhlIHNlcmllcw0KPiA+IGlu
IGRyaXZlcnMvaHYvbXNodl9yb290LmguIEkgZ3Vlc3MgdGhhdCdzIE9LLCBidXQgSSB3b3VsZCBu
b3JtYWxseQ0KPiA+IGV4cGVjdCB0byBmaW5kIHN1Y2ggYSBkZWNsYXJhdGlvbiBpbiB0aGUgaGVh
ZGVyIGZpbGUgYXNzb2NpYXRlZCB3aXRoDQo+ID4gd2hlcmUgdGhlIHZhcmlhYmxlIGlzIGRlZmlu
ZWQsIHdoaWNoIGluIHRoaXMgY2FzZSBpcyBtc2h5cGVydi5oLg0KPiA+IFBlcmhhcHMgeW91IGFy
ZSB0cnlpbmcgdG8gcmVzdHJpY3QgaXRzIHVzYWdlIHRvIGp1c3QgbXNodj8NCj4gPg0KPiBZZXMs
IHRoYXQncyB0aGUgaWRlYSAtIGl0IHNob3VsZCBvbmx5IGJlIHVzZWQgYnkgdGhlIGRyaXZlci4N
Cj4gDQo+ID4+ICsNCj4gPj4gIC8qDQo+ID4+ICAgKiBIeXBlci1WIHNwZWNpZmljIGluaXRpYWxp
emF0aW9uIGFuZCBzaHV0ZG93biBjb2RlIHRoYXQgaXMNCj4gPj4gICAqIGNvbW1vbiBhY3Jvc3Mg
YWxsIGFyY2hpdGVjdHVyZXMuICBDYWxsZWQgZnJvbSBhcmNoaXRlY3R1cmUNCj4gPj4gQEAgLTkw
LDYgKzEwMCw5IEBAIHZvaWQgX19pbml0IGh2X2NvbW1vbl9mcmVlKHZvaWQpDQo+ID4+DQo+ID4+
ICAJZnJlZV9wZXJjcHUoaHlwZXJ2X3BjcHVfaW5wdXRfYXJnKTsNCj4gPj4gIAloeXBlcnZfcGNw
dV9pbnB1dF9hcmcgPSBOVUxMOw0KPiA+PiArDQo+ID4+ICsJZnJlZV9wZXJjcHUoaHZfc3luaWNf
ZXZlbnRyaW5nX3RhaWwpOw0KPiA+PiArCWh2X3N5bmljX2V2ZW50cmluZ190YWlsID0gTlVMTDsN
Cj4gPj4gIH0NCj4gPj4NCj4gPj4gIC8qDQo+ID4+IEBAIC0zNzIsNiArMzg1LDExIEBAIGludCBf
X2luaXQgaHZfY29tbW9uX2luaXQodm9pZCkNCj4gPj4gIAkJQlVHX09OKCFoeXBlcnZfcGNwdV9v
dXRwdXRfYXJnKTsNCj4gPj4gIAl9DQo+ID4+DQo+ID4+ICsJaWYgKGh2X3Jvb3RfcGFydGl0aW9u
KCkpIHsNCj4gPj4gKwkJaHZfc3luaWNfZXZlbnRyaW5nX3RhaWwgPSBhbGxvY19wZXJjcHUodTgg
Kik7DQo+ID4+ICsJCUJVR19PTihodl9zeW5pY19ldmVudHJpbmdfdGFpbCA9PSBOVUxMKTsNCj4g
Pj4gKwl9DQo+ID4+ICsNCj4gPj4gIAlodl92cF9pbmRleCA9IGttYWxsb2NfYXJyYXkobnJfY3B1
X2lkcywgc2l6ZW9mKCpodl92cF9pbmRleCksDQo+ID4+ICAJCQkJICAgIEdGUF9LRVJORUwpOw0K
PiA+PiAgCWlmICghaHZfdnBfaW5kZXgpIHsNCj4gPj4gQEAgLTQ2MCw2ICs0NzgsNyBAQCB2b2lk
IF9faW5pdCBtc19oeXBlcnZfbGF0ZV9pbml0KHZvaWQpDQo+ID4+ICBpbnQgaHZfY29tbW9uX2Nw
dV9pbml0KHVuc2lnbmVkIGludCBjcHUpDQo+ID4+ICB7DQo+ID4+ICAJdm9pZCAqKmlucHV0YXJn
LCAqKm91dHB1dGFyZzsNCj4gPj4gKwl1OCAqKnN5bmljX2V2ZW50cmluZ190YWlsOw0KPiA+PiAg
CXU2NCBtc3JfdnBfaW5kZXg7DQo+ID4+ICAJZ2ZwX3QgZmxhZ3M7DQo+ID4+ICAJY29uc3QgaW50
IHBnY291bnQgPSBodl9vdXRwdXRfcGFnZV9leGlzdHMoKSA/IDIgOiAxOw0KPiA+PiBAQCAtNDcy
LDggKzQ5MSw4IEBAIGludCBodl9jb21tb25fY3B1X2luaXQodW5zaWduZWQgaW50IGNwdSkNCj4g
Pj4gIAlpbnB1dGFyZyA9ICh2b2lkICoqKXRoaXNfY3B1X3B0cihoeXBlcnZfcGNwdV9pbnB1dF9h
cmcpOw0KPiA+Pg0KPiA+PiAgCS8qDQo+ID4+IC0JICogaHlwZXJ2X3BjcHVfaW5wdXRfYXJnIGFu
ZCBoeXBlcnZfcGNwdV9vdXRwdXRfYXJnIG1lbW9yeSBpcyBhbHJlYWR5DQo+ID4+IC0JICogYWxs
b2NhdGVkIGlmIHRoaXMgQ1BVIHdhcyBwcmV2aW91c2x5IG9ubGluZSBhbmQgdGhlbiB0YWtlbiBv
ZmZsaW5lDQo+ID4+ICsJICogVGhlIHBlci1jcHUgbWVtb3J5IGlzIGFscmVhZHkgYWxsb2NhdGVk
IGlmIHRoaXMgQ1BVIHdhcyBwcmV2aW91c2x5DQo+ID4+ICsJICogb25saW5lIGFuZCB0aGVuIHRh
a2VuIG9mZmxpbmUNCj4gPj4gIAkgKi8NCj4gPj4gIAlpZiAoISppbnB1dGFyZykgew0KPiA+PiAg
CQltZW0gPSBrbWFsbG9jKHBnY291bnQgKiBIVl9IWVBfUEFHRV9TSVpFLCBmbGFncyk7DQo+ID4+
IEBAIC00ODUsNiArNTA0LDE3IEBAIGludCBodl9jb21tb25fY3B1X2luaXQodW5zaWduZWQgaW50
IGNwdSkNCj4gPj4gIAkJCSpvdXRwdXRhcmcgPSAoY2hhciAqKW1lbSArIEhWX0hZUF9QQUdFX1NJ
WkU7DQo+ID4+ICAJCX0NCj4gPj4NCj4gPj4gKwkJaWYgKGh2X3Jvb3RfcGFydGl0aW9uKCkpIHsN
Cj4gPj4gKwkJCXN5bmljX2V2ZW50cmluZ190YWlsID0gKHU4ICoqKXRoaXNfY3B1X3B0cihodl9z
eW5pY19ldmVudHJpbmdfdGFpbCk7DQo+ID4+ICsJCQkqc3luaWNfZXZlbnRyaW5nX3RhaWwgPSBr
Y2FsbG9jKEhWX1NZTklDX1NJTlRfQ09VTlQsDQo+ID4+ICsJCQkJCQkJc2l6ZW9mKHU4KSwgZmxh
Z3MpOw0KPiA+PiArDQo+ID4+ICsJCQlpZiAodW5saWtlbHkoISpzeW5pY19ldmVudHJpbmdfdGFp
bCkpIHsNCj4gPj4gKwkJCQlrZnJlZShtZW0pOw0KPiA+PiArCQkJCXJldHVybiAtRU5PTUVNOw0K
PiA+PiArCQkJfQ0KPiA+PiArCQl9DQo+ID4+ICsNCj4gPg0KPiA+IEFkZGluZyB0aGlzIGNvZGUg
dW5kZXIgdGhlICJpZighKmlucHV0YXJnKSIgaW1wbGljaXRseSB0aWVzIHRoZSBsaWZlY3ljbGUg
b2YNCj4gPiBzeW5pY19ldmVudHJpbmdfdGFpbCB0byB0aGUgbGlmZWN5Y2xlIG9mIGh5cGVydl9w
Y3B1X2lucHV0X2FyZyBhbmQNCj4gPiBoeXBlcnZfcGNwdV9vdXRwdXRfYXJnLiBJcyB0aGVyZSBz
b21lIGxvZ2ljYWwgcmVsYXRpb25zaGlwIGJldHdlZW4gdGhlDQo+ID4gdHdvIHRoYXQgd2FycmFu
dHMgdHlpbmcgdGhlIGxpZmVjeWNsZXMgdG9nZXRoZXIgKG90aGVyIHRoYW4ganVzdCBib3RoIGJl
aW5nDQo+ID4gcGVyLWNwdSk/ICBoeXBlcnZfcGNwdV9pbnB1dF9hcmcgYW5kIGh5cGVydl9wY3B1
X291dHB1dF9hcmcgaGF2ZSBhbg0KPiA+IHVudXN1YWwgbGlmZWN5Y2xlIG1hbmFnZW1lbnQgaW4g
dGhhdCB0aGV5IGFyZW4ndCBmcmVlZCB3aGVuIGEgQ1BVIGdvZXMNCj4gPiBvZmZsaW5lLCBhcyBk
ZXNjcmliZWQgaW4gdGhlIGNvbW1lbnQgaW4gaHZfY29tbW9uX2NwdV9kaWUoKS4gRG9lcw0KPiA+
IHN5bmljX2V2ZW50cmluZ190YWlsIGFsc28gbmVlZCB0aGF0IHNhbWUgdW51c3VhbCBsaWZlY3lj
bGU/DQo+ID4NCj4gSSB0aG91Z2h0IGFib3V0IGl0LCBhbmQgbm8gSSBkb24ndCB0aGluayBpdCBz
aGFyZXMgdGhlIHNhbWUgZXhhY3QgbGlmZWN5Y2xlLg0KPiBJdCdzIG9ubHkgdXNlZCBieSB0aGUg
bXNodl9yb290IGRyaXZlciAtIGl0IGp1c3QgbmVlZHMgdG8gcmVtYWluIHByZXNlbnQNCj4gd2hl
bmV2ZXIgdGhlcmUncyBhIGNoYW5jZSB0aGUgbW9kdWxlIGNvdWxkIGJlIHJlLWluc2VydGVkIGFu
ZCBleHBlY3QgaXQgdG8NCj4gYmUgdGhlcmUuDQo+IA0KPiA+IEFzc3VtaW5nIHRoZXJlJ3Mgbm8g
bG9naWNhbCByZWxhdGlvbnNoaXAsIEknbSB0aGlua2luZyBzeW5pY19ldmVudHJpbmdfdGFpbA0K
PiA+IHNob3VsZCBiZSBtYW5hZ2VkIGluZGVwZW5kZW50IG9mIHRoZSBvdGhlciB0d28uIElmIGl0
IGRvZXMgbmVlZCB0aGUNCj4gPiB1bnVzdWFsIGxpZmVjeWNsZSwgbWFrZSBzdXJlIHRvIGFkZCBh
IGNvbW1lbnQgaW4gaHZfY29tbW9uX2NwdV9kaWUoKQ0KPiA+IGV4cGxhaW5pbmcgd2h5LiBJZiBp
dCBkb2Vzbid0IG5lZWQgdGhlIHVudXN1YWwgbGlmZWN5Y2xlLCBtYXliZSBqdXN0IGRvDQo+ID4g
dGhlIG5vcm1hbCB0aGluZyBvZiBhbGxvY2F0aW5nIGl0IGluIGh2X2NvbW1vbl9jcHVfaW5pdCgp
IGFuZCBmcmVlaW5nDQo+ID4gaXQgaW4gaHZfY29tbW9uX2NwdV9kaWUoKS4NCj4gPg0KPiBZZXAs
IEkgc3VwcG9zZSBpdCBzaG91bGQganVzdCBiZSBmcmVlZCBub3JtYWxseSB0aGVuLCBhc3N1bWlu
Zw0KPiBodl9jb21tb25fY3B1X2RpZSgpIGlzIG9ubHkgY2FsbGVkIHdoZW4gdGhlIGh5cGVydmlz
b3IgaXMgZ29pbmcgdG8gcmVzZXQNCj4gKG9yIHJlbW92ZSkgdGhlIHN5bmljIHBhZ2VzIGZvciB0
aGlzIHBhcnRpdGlvbi4gSXMgdGhhdCB0aGUgY2FzZSBoZXJlPw0KPiANCg0KWWVzLCBpdCBpcyB0
aGUgY2FzZSBoZXJlLiBBIHBhcnRpY3VsYXIgdkNQVSBjYW4gYmUgdGFrZW4gb2ZmbGluZQ0KaW5k
ZXBlbmRlbnQgb2Ygb3RoZXIgdkNQVXMgaW4gdGhlIFZNIChzdWNoIGFzIGJ5IHdyaXRpbmcgIjAi
DQp0byAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHU8bm4+L29ubGluZSkuIFdoZW4gdGhhdCBo
YXBwZW5zDQp0aGUgdkNQVSBnb2luZyBvZmZsaW5lIHJ1bnMgaHZfc3luaWNfY2xlYW51cCgpIGZp
cnN0LCBhbmQgdGhlbiBpdA0KcnVucyBodl9jcHVfZGllKCksIHdoaWNoIGNhbGxzIGh2X2NvbW1v
bl9jcHVfZGllKCkuIFNvIGJ5IHRoZQ0KdGltZSBodl9jb21tb25fY3B1X2RpZSgpIHJ1bnMsIHRo
ZSBzeW5pY19tZXNzYWdlX3BhZ2UgYW5kDQpzeW5pY19ldmVudF9wYWdlIHdpbGwgaGF2ZSBiZWVu
IHVubWFwcGVkIGFuZCB0aGUgcG9pbnRlcnMgc2V0DQp0byBOVUxMLg0KDQpPbiBhcm02NCwgdGhl
cmUgaXMgbm8gaHZfY3B1X2luaXQoKS9kaWUoKSwgYW5kIHRoZSAiY29tbW9uIg0KdmVyc2lvbnMg
YXJlIGNhbGxlZCBkaXJlY3RseS4gUGVyaGFwcyBhdCBzb21lIHBvaW50IGluIHRoZSBmdXR1cmUg
dGhlcmUNCndpbGwgYmUgYXJtNjQgc3BlY2lmaWMgdGhpbmdzIHRvIGJlIGRvbmUsIGFuZCBodl9j
cHVfaW5pdCgpL2RpZSgpDQp3aWxsIG5lZWQgdG8gYmUgYWRkZWQuIEJ1dCB0aGUgb3JkZXJpbmcg
aXMgdGhlIHNhbWUgYW5kDQpodl9zeW5pY19jbGVhbnVwKCkgcnVucyBmaXJzdC4NCg0KU28sIHll
cywgc2luY2Ugc3luaWNfZXZlbnRyaW5nX3RhaWwgaXMgdGllZCB0byB0aGUgc3luaWMsIGl0IHNv
dW5kcyBsaWtlDQp0aGUgbm9ybWFsIGxpZmVjeWNsZSBjb3VsZCBiZSB1c2VkLCBsaWtlIHdpdGgg
dGhlIFZQIGFzc2lzdCBwYWdlIHRoYXQNCmlzIGhhbmRsZWQgaW4gaHZfY3B1X2luaXQoKS9kaWUo
KSBvbiB4ODYuDQoNCj4gT3RoZXJ3aXNlIHdlJ2Qgd2FudCB0byByZXRhaW4gaXQsIGluIGNhc2Ug
bXNodl9yb290IGV2ZXIgbmVlZHMgaXQgYWdhaW4gZm9yDQo+IHRoYXQgQ1BVIGluIHRoZSBsaWZl
dGltZSBvZiB0aGlzIHBhcnRpdGlvbi4NCj4gDQo+IE51bm8NCj4gDQo+ID4gVGhlIGNvZGUgYXMg
d3JpdHRlbiBpbiB5b3VyIHBhdGNoIGlzbid0IHdyb25nIGFuZCB3b3VsZCB3b3JrIE9LLiBCdXQN
Cj4gPiB0aGUgc3RydWN0dXJlIGltcGxpZXMgYSByZWxhdGlvbnNoaXAgd2l0aCBoeXBlcnZfcGNw
dV8qX2FyZyB0aGF0IEkNCj4gPiBzdXNwZWN0IGRvZXNuJ3QgZXhpc3QuDQo+ID4NCj4gPiBNaWNo
YWVsDQo+ID4NCj4gPj4gIAkJaWYgKCFtc19oeXBlcnYucGFyYXZpc29yX3ByZXNlbnQgJiYNCj4g
Pj4gIAkJICAgIChodl9pc29sYXRpb25fdHlwZV9zbnAoKSB8fCBodl9pc29sYXRpb25fdHlwZV90
ZHgoKSkpIHsNCj4gPj4gIAkJCXJldCA9IHNldF9tZW1vcnlfZGVjcnlwdGVkKCh1bnNpZ25lZCBs
b25nKW1lbSwgcGdjb3VudCk7DQo+ID4+IC0tDQo+ID4+IDIuMzQuMQ0KDQo=

