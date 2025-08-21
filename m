Return-Path: <linux-arch+bounces-13246-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27775B302D8
	for <lists+linux-arch@lfdr.de>; Thu, 21 Aug 2025 21:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829671BC68D1
	for <lists+linux-arch@lfdr.de>; Thu, 21 Aug 2025 19:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8652034AAE1;
	Thu, 21 Aug 2025 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Foe2s04g"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2049.outbound.protection.outlook.com [40.92.44.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA8B2C11CD;
	Thu, 21 Aug 2025 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755804263; cv=fail; b=RN7ftZH6LsUPZCYcQ2Pstd1yL5GVpUh+Be8U9g7r8ER30UXjpfBs73YJC1lev1kTbDy7cjyoyClMOHF27LXoNfhMoH5lkRJNy9FUA4we2xj+9e+6Sfb0JCpKi+dpSKNSWtF5hW/AOMLrkfi1lZSF44dxFZP1hvxETjBl2eUwjHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755804263; c=relaxed/simple;
	bh=5H3kqSeOptIIteFkqdNJM2IZrksYEMNYqDV/1/KcSAo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DApAurJpHsy9NjaMjQQ4KFCBh71ON9VAxnqgccs608FjlpubfvR8PWg7Twaxw5dQZFjBXQhCOO6jlgxe0nwpbDi2DkXQRdWUO3Wz/RmsThZ0ubYnYVPjfkWgIV+tbZneZAliIOQzJXcr2iMB0IYYqiW+k834uikHsh8yPT+iij0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Foe2s04g; arc=fail smtp.client-ip=40.92.44.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGVvcHgOqi0wwQK3pnBOAupedwRo5xbQlBFqdLjvSiyP0k5U8I41r6z06ccSC+Dup48nG0KMw+IfjvtUH8ZWjbXwCn32IVGD9CvQzya3WR4A+6AP+oj5EVnKcjhsdcZ9PjKIFFZn5jROGjuokhXBU5WA2Zb1GQucSG0ucvRdtrBHFsGwkZciMAdAApuKog5MdLw8zJbswqr46gSC9nODK6Sw97gIy6Qw4aDCc5TiDz1z5+U4pj3GdRhyMrhK5g/Dt9EL2e7bNNIUOeZwJ6RXkstcMff7IkcK6/ltjyMuEwWQVUfBjOlhgYzqw81RaBZZlWthkcChCGCYPofd55x0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5H3kqSeOptIIteFkqdNJM2IZrksYEMNYqDV/1/KcSAo=;
 b=yTJaM7kCMlL/gQU5B3Oue/M5JJ7CdJEJZi8kCFkyqlAPYtfEgr4vbPhR2jZxCV/il629IGbzgnz2CWMIlAazuN1u5EZDB1/t0+TO3UhgS5wvaZB7H8sAxbM72orgSXD4B8Ksv7nlljxjTHSakouhxwa3cBvhnQ0N2BAIh3VoG06EA8HQ/obU5PsZeuoEPN7Ed+nx6wi0LgNiPhyXEI43g+9PtFnXLcFYeexzgJMDrn5V0uSQskoxIB19jbKISG625SSndCy4m8n+92Uj/YwOchoWhMXk7TrYH6pOQNAf9TpE/KJy35D3oDDfsylED42WFeGdt71ATDgAAHFfK5O1Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5H3kqSeOptIIteFkqdNJM2IZrksYEMNYqDV/1/KcSAo=;
 b=Foe2s04grDi4Fd1Z2GvChfTDYMDomWQ3gJOnwUHWlDecQtswFR0z6pZd9LiMQpYRZqCvq97Ug1NSq/EOY8U+ftckMLgrPx5gWXpi0bpAWjMDCzHncxtxqKktTlpFh0NquGb2I3g/p9j5X2jZC0IZjY0eeEXyGolnbZLENIL6QaJ5D8hUdWeVjkg6ukuPkamZmWixBXpbIb71+mHIqMkUgHSMtEL+eYudfc25EiKt3cUBT08HeOqrCycEozvJ/qDbkKltIi5QL4Oo+wne0yLa/z1UOzK4wn2lqf7CVzYeCeIhZfynecJPQibBiR0I4M4xZXonA/ocI+YwI4LkeE3gfA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA3PR02MB9277.namprd02.prod.outlook.com (2603:10b6:806:31c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 19:24:15 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 19:24:15 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh R <mrathor@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
Subject: RE: [PATCH v3 1/7] Drivers: hv: Introduce hv_hvcall_*() functions for
 hypercall arguments
Thread-Topic: [PATCH v3 1/7] Drivers: hv: Introduce hv_hvcall_*() functions
 for hypercall arguments
Thread-Index: AQHbrjFiyn0GJkB9FUywLGBELxbpZ7RtCZwAgAAo6gCAAQmaEA==
Date: Thu, 21 Aug 2025 19:24:15 +0000
Message-ID:
 <SN6PR02MB4157376DD06C1DC2E28A76B7D432A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250415180728.1789-1-mhklinux@outlook.com>
 <20250415180728.1789-2-mhklinux@outlook.com>
 <f711d4ad-87a8-9cb3-aabc-a493ff18986a@linux.microsoft.com>
 <33b59cc4-2834-b6c7-5ffd-7b9d620a4ce5@linux.microsoft.com>
In-Reply-To: <33b59cc4-2834-b6c7-5ffd-7b9d620a4ce5@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA3PR02MB9277:EE_
x-ms-office365-filtering-correlation-id: 7ed1c442-edfa-4061-a675-08dde0e8512b
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|19110799012|8062599012|8060799015|461199028|31061999003|15080799012|51005399003|3412199025|440099028|40105399003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?N05xTWduZnMvSHJxRFl0MHB3NkVkWk9iTHBpVUt0cTE3WWNqSEVrKzNIQWNk?=
 =?utf-8?B?ditzT0RlcWg4cU1LaWpoelg3Slc1RUFEZmNDSERVUUI4QWhKQkFJT1lHZEZE?=
 =?utf-8?B?ejE0bHdyai9kaVJrQWI1NWxSNnVnNjV0QllUa0xpMHhkWWRieFA3TXdRbElD?=
 =?utf-8?B?dzcvZ290TmlNNERMR0txTTZHSWEyWGxINnNuZkZnSGtTOHhucC9adTA0blNX?=
 =?utf-8?B?R3FTOXlrdlZ3emd3VWxVNGpnREwvSVprSFNxQW5LdGVSVW5OQmJEOGp1a2Vw?=
 =?utf-8?B?M3Izc3dDNUg1cURzVlM1ZzRIM0h4aXllTzI1YTdPa21YVStKbFgwSTh0Q201?=
 =?utf-8?B?eDRsUGJab2dFSVRCSngxRytCSjZhWUV4RHZxNVdyMnB3ZTV4d2t4eHRVZVVl?=
 =?utf-8?B?SjcvUzlWWXlCYnBQNE9MTXlESmFVckwrQTZKYm1zVFlQUXlwWmIwZC9XZUR6?=
 =?utf-8?B?azZwYU1SS1oyRFZ5M3BuZzBnUDNmckt5WnhQa3VCOHZDZHNVR2RSVHVKTmlT?=
 =?utf-8?B?U1RoWmxZK3FPM3NMdi9oWm10RFhDbHpqZWppZTVOTlFMUGpVUEYvNWtXZmRp?=
 =?utf-8?B?eXc0YWM1SEthZXI1UXRmVnJWOWtHK0pnc3BzUmVKdFVhQURZcm93eFFPMVFh?=
 =?utf-8?B?bzVKK2JMaWx4aVZKbU1jaFBiZjdZV2NyNDFVcXFqNEdDQi9mZHROc1dYY1Zv?=
 =?utf-8?B?YTNWaTlIeTlsbzRGeHdHckdNK0VZRGpqWXNjM3ZsR3NEQjBDTWxmZUs3RUVL?=
 =?utf-8?B?cFF5TXpyUW5ESjU1Nnh0VC9SVWJVMnNTNzkvdzV4UFR2bHdoMmRHMW90YTNw?=
 =?utf-8?B?aHBFTXRvTkxNL293eFY0SStLTmZsZUZQTjZjVjZKY2F2SmdMdFdYVk5aNTll?=
 =?utf-8?B?akpUeEpKcCttVkhPZ3RNNVA0cnJaZ2xNN0N0dXIyQXlRNVk5UVd5VzErOUtv?=
 =?utf-8?B?OGlCRlFUSFBXYWQ5b3g3bHNUSk9QZFpkOTV4TE9ETENqVjJlTitHdldYWGox?=
 =?utf-8?B?d2ErMVJremY0ajU3SEVWUU8ySzRDUDROM2ZFSmtRN2FoeHRlb3lQOGZ5eXFu?=
 =?utf-8?B?ck04TFZSMTVEMjNSRzNVQmVYQW1XT3o3dVhxOWhXTUprd1BlTGhlZldtUy9K?=
 =?utf-8?B?T0ZzdGdXQlR1eUxqb0dPNUJLdTZiZ3A4aTFQbDBtcFZrRjVnVURwM1YyS2Ex?=
 =?utf-8?B?U2NTdWxJKzFnZnJuYXA4eWdrVUpzK0ROVnRCVElhZjdmd2kvQXJiYUd5RFFN?=
 =?utf-8?B?d0s5cFZVZ05CaWk2c3RzTUpBbU9odkxuUWN4YytpN2RFMWpOUXhYYS9CSk5H?=
 =?utf-8?B?bVRZTXZRTzlUN0FKMFQvMXk4Z1BiSGJ6V3lXWkNMQlptZlQ5cm16cWE4Z20x?=
 =?utf-8?B?UEdTZGhHNE1lOWE1b1JOWUw3a3lnbllLOWx0OHlubW9YWXh0azZFdGtseE5z?=
 =?utf-8?B?cG40aVRJb2MvbXo0bFUyTVNsblEvb052N09QaitUM09Bc0V5YXBlS2VXUTk1?=
 =?utf-8?B?NTZIYVJCQUZOMXdPK0hJSGp3anhwWHhRUFBsK2t4Z3lDZGtpK0JiS0ZkUkRI?=
 =?utf-8?B?bmI3eHBVYW9oUE1jOHQyWDB1ZndRaGlkRlBYRlVJMkV3Q3hRL0UwZDJZa3Rr?=
 =?utf-8?B?bkhyTnc2MG9sR0xTTVBONmdCM0tISFdTRVZvZ3M0ZnhKUnhSeUxkSklDOEQx?=
 =?utf-8?Q?dkefsHMZGTuH9BSKu+fW?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUFRTS9ucmhFZU1KRjBFNHpVd3JjZklKWVFaY3Z4bUdCMG1kOHhtWms5aGps?=
 =?utf-8?B?Tk9XZ3Q0cXdCdGdrRXFMZjU5NjM2UUNIUDdPMkRWZDF5VSt5UXI1cG80MFZB?=
 =?utf-8?B?clJ6NkFOWVJPMkFoeTNpUFNqUDdVZ3cveFpmNURrQ1UvS3N2ZUg4bEVyUjZP?=
 =?utf-8?B?K0JNTjRaR21HZVYwNk51elIrUmk0am1qc3RRVndzUEdTQWdBUlJGbm1WZlZr?=
 =?utf-8?B?TFRSMllrbXFseTIrN0ZrQWwvQ0phdVI2QU5KOFZZMmtnOU9hQmlDWE9KaC9q?=
 =?utf-8?B?ako5LytSMVA0ZXFLRnhzd0haMkNwdEpZeFhVQjZYd05vZzN6Nms3azVlNjJE?=
 =?utf-8?B?SVJVTTZoam5tTFRPbXNrN0MzL3pqYTN4MWxvOUFGVjFQbFJqME93S3ZGUmRZ?=
 =?utf-8?B?UEcrU2NiaDV0clhWNHdlQlB6QlVURWJNQ3h2UFJSZGorZFN3WG5BbWR3TVU1?=
 =?utf-8?B?d1VmaHNvRzkwVFlqSW9VM0k3Tjk5cFpLM1Z5UjIyVUFkZlZOYjdrcDlBVGkv?=
 =?utf-8?B?Z3pITUlDck0wK3U4ZW1UU1pkWVdWZlhGSXpFMStHclZnTXk1ZG8rd21ZaEMv?=
 =?utf-8?B?bEpMSitlVDdrS1RIV3RyTUFsNmlPV0tuU2JyOGlZMm1qeU9TOGdoZ0pCM3Fx?=
 =?utf-8?B?c1FhVEJDcFNwZWZTRGpha05Jcjd6cW54V1NTK2RSeTZFVUNvTG9CU2xaZFZ3?=
 =?utf-8?B?V29oK2tWOS9lWlcycU1wL1VHSTZJTGkwNXFsd0pEWTN5SFJEVEVQVk9GbnRY?=
 =?utf-8?B?RnNwbDFvNUx6c0xlUXhCN3FDOFU1MTJBTTN1R0RWVE83aVJpSU5jWVFlMzYx?=
 =?utf-8?B?YUxuZlJpZjB3VXg4emcwT0hMUkIxRzN5V2h3VHZrZ3l6YzEzaEFqa1ArTkFV?=
 =?utf-8?B?MTJaNGRqeWEzZjNTT2JUeC9oZ1J0UUNLdmFGU0lUdzZPTHpMajlROWY1bHRK?=
 =?utf-8?B?YksxLzQwcXJNMk9XNmIxb29NTTU5QTQ0WHBMMlF6Z21NRjBSa2dlczdveUMr?=
 =?utf-8?B?QnNXRmtSM1BlNkx5TVV3VHpmTmNKd2VmL1NvNUZJbFU0cnNySE5qakx0Q1RB?=
 =?utf-8?B?bG52azZxbGtRMXlqMExzK282Z29VT3R4blhtcTBpcHZ2anZwamMxdEYyV1Ry?=
 =?utf-8?B?K3F3cnZmdi9pbDVaaHlxSml6K1lGYmMwaTUyeDhJTy9kVDV0WDRJbVp6Y2kw?=
 =?utf-8?B?QVl2eFc0WE14a1ZkZGlUWElETWpUTVpHcTh2b0cxYldBUEdxNWJrTXpnV1RG?=
 =?utf-8?B?RUN5ekVTZFI3anRBWXhaOVZYUnpkMkpBaW1EMjg2d2h5azZOWDFwd2xsbE8r?=
 =?utf-8?B?akZaQ2VXYVBQUDdjRWN5dlozVWc2bEo1a1VYWkd0UW1vUFlIbWJrMGlReEt5?=
 =?utf-8?B?V00xNkkza0RRVC80SEhKQ0N4WUVHT0dLQUFieC9CMTFjUi9Bc1pkcWFHckNQ?=
 =?utf-8?B?OWszNjRua3F5SkZDeFdMYnBNS08zNjJUbGVsZnJVemlGckNtMU9LdnJVMHFz?=
 =?utf-8?B?RzdCZmdmQ084dGc4czAvY1JEdlpaSkpVWGNiSHNENVAxbGlZcEVDZG1pUWVt?=
 =?utf-8?B?YkZSaUI4cGplTkxucy82UFliVkhiVm8zdExLTVA5dzZlRzBBNkRIUVU5OWsw?=
 =?utf-8?Q?SXmsp0GIxanuLsORPZtNrIzLcILRKLW2AF/uZCTfLuoY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed1c442-edfa-4061-a675-08dde0e8512b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 19:24:15.4912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB9277

RnJvbTogTXVrZXNoIFIgPG1yYXRob3JAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogV2VkbmVz
ZGF5LCBBdWd1c3QgMjAsIDIwMjUgNzo1OCBQTQ0KPiANCj4gT24gOC8yMC8yNSAxNzozMSwgTXVr
ZXNoIFIgd3JvdGU6DQo+ID4gT24gNC8xNS8yNSAxMTowNywgbWhrZWxsZXk1OEBnbWFpbC5jb20g
d3JvdGU6DQo+ID4+IEZyb206IE1pY2hhZWwgS2VsbGV5IDxtaGtsaW51eEBvdXRsb29rLmNvbT4N
Cj4gPj4NCj4gPj4gQ3VycmVudCBjb2RlIGFsbG9jYXRlcyB0aGUgImh5cGVydl9wY3B1X2lucHV0
X2FyZyIsIGFuZCBpbg0KPiA+PiBzb21lIGNvbmZpZ3VyYXRpb25zLCB0aGUgImh5cGVydl9wY3B1
X291dHB1dF9hcmciLiBFYWNoIGlzIGEgNCBLaUINCj4gPj4gcGFnZSBvZiBtZW1vcnkgYWxsb2Nh
dGVkIHBlci12Q1BVLiBBIGh5cGVyY2FsbCBjYWxsIHNpdGUgZGlzYWJsZXMNCj4gPj4gaW50ZXJy
dXB0cywgdGhlbiB1c2VzIHRoaXMgbWVtb3J5IHRvIHNldCB1cCB0aGUgaW5wdXQgcGFyYW1ldGVy
cyBmb3INCj4gPj4gdGhlIGh5cGVyY2FsbCwgcmVhZCB0aGUgb3V0cHV0IHJlc3VsdHMgYWZ0ZXIg
aHlwZXJjYWxsIGV4ZWN1dGlvbiwgYW5kDQo+ID4+IHJlLWVuYWJsZSBpbnRlcnJ1cHRzLiBUaGUg
b3BlbiBjb2Rpbmcgb2YgdGhlc2Ugc3RlcHMgbGVhZHMgdG8NCj4gPj4gaW5jb25zaXN0ZW5jaWVz
LCBhbmQgaW4gc29tZSBjYXNlcywgdmlvbGF0aW9uIG9mIHRoZSBnZW5lcmljDQo+ID4+IHJlcXVp
cmVtZW50cyBmb3IgdGhlIGh5cGVyY2FsbCBpbnB1dCBhbmQgb3V0cHV0IGFzIGRlc2NyaWJlZCBp
biB0aGUNCj4gPj4gSHlwZXItViBUb3AgTGV2ZWwgRnVuY3Rpb25hbCBTcGVjIChUTEZTKVsxXS4N
Cj4gPj4NCj4gPiA8c25pcD4NCj4gPg0KPiA+PiBUaGUgbmV3IGZ1bmN0aW9ucyBhcmUgcmVhbGl6
ZWQgYXMgYSBzaW5nbGUgaW5saW5lIGZ1bmN0aW9uIHRoYXQNCj4gPj4gaGFuZGxlcyB0aGUgbW9z
dCBjb21wbGV4IGNhc2UsIHdoaWNoIGlzIGEgaHlwZXJjYWxsIHdpdGggaW5wdXQNCj4gPj4gYW5k
IG91dHB1dCwgYm90aCBvZiB3aGljaCBjb250YWluIGFycmF5cy4gU2ltcGxlciBjYXNlcyBhcmUg
bWFwcGVkIHRvDQo+ID4+IHRoaXMgbW9zdCBjb21wbGV4IGNhc2Ugd2l0aCAjZGVmaW5lIHdyYXBw
ZXJzIHRoYXQgcHJvdmlkZSB6ZXJvIG9yIE5VTEwNCj4gPj4gZm9yIHNvbWUgYXJndW1lbnRzLiBT
ZXZlcmFsIG9mIHRoZSBhcmd1bWVudHMgdG8gdGhpcyBuZXcgZnVuY3Rpb24NCj4gPj4gbXVzdCBi
ZSBjb21waWxlLXRpbWUgY29uc3RhbnRzIGdlbmVyYXRlZCBieSAic2l6ZW9mKCkiDQo+ID4+IGV4
cHJlc3Npb25zLiBBcyBzdWNoLCBtb3N0IG9mIHRoZSBjb2RlIGluIHRoZSBuZXcgZnVuY3Rpb24g
Y2FuIGJlDQo+ID4+IGV2YWx1YXRlZCBieSB0aGUgY29tcGlsZXIsIHdpdGggdGhlIHJlc3VsdCB0
aGF0IHRoZSBjb2RlIHBhdGhzIGFyZQ0KPiA+PiBubyBsb25nZXIgdGhhbiB3aXRoIHRoZSBjdXJy
ZW50IG9wZW4gY29kaW5nLiBUaGUgb25lIGV4Y2VwdGlvbiBpcw0KPiA+PiBuZXcgY29kZSBnZW5l
cmF0ZWQgdG8gemVybyB0aGUgZml4ZWQtc2l6ZSBwb3J0aW9uIG9mIHRoZSBpbnB1dCBhcmVhDQo+
ID4+IGluIGNhc2VzIHdoZXJlIGl0IGlzIG5vdCBjdXJyZW50bHkgZG9uZS4NCj4gPg0KPiA+IElN
SE8sIHRoaXMgaXMgdW5uZWNlc3NhcnkgY2hhbmdlIHRoYXQganVzdCBvYmZ1c2NhdGVzIGNvZGUu
IFdpdGggc3RhdHVzIHF1bw0KPiA+IG9uZSBoYXMgdGhlIGFkdmFudGFnZSBvZiBzZWVpbmcgd2hh
dCBleGFjdGx5IGlzIGdvaW5nIG9uLCBvbmUgY2FuIHVzZSB0aGUNCj4gPiBhcmdzIGFueSB3aGlj
aCB3YXksIGNoYW5nZSBiYXRjaCBzaXplIGFueSB3aGljaCB3YXksIGFuZCBpcyB0aHVzIGZsZXhp
YmxlLg0KDQpJIHN0YXJ0ZWQgdGhpcyBwYXRjaCBzZXQgaW4gcmVzcG9uc2UgdG8gc29tZSBlcnJv
cnMgaW4gb3BlbiBjb2RpbmcgdGhlDQp1c2Ugb2YgaHlwZXJ2X3BjcHVfaW5wdXQvb3V0cHV0X2Fy
ZywgdG8gc2VlIGlmIGhlbHBlciBmdW5jdGlvbnMgY291bGQNCnJlZ3VsYXJpemUgdGhlIHVzYWdl
IGFuZCByZWR1Y2UgdGhlIGxpa2VsaWhvb2Qgb2YgZnV0dXJlIGVycm9ycy4gQmFsYW5jaW5nDQp0
aGUgcGx1c2VzIGFuZCBtaW51c2VzIG9mIHRoZSByZXN1bHQsIGluIG15IHZpZXcgdGhlIGhlbHBl
ciBmdW5jdGlvbnMgYXJlDQphbiBpbXByb3ZlbWVudCwgdGhvdWdoIG5vdCBvdmVyd2hlbG1pbmds
eSBzby4gT3RoZXJzIG1heSBzZWUgdGhlDQp0cmFkZW9mZnMgZGlmZmVyZW50bHksIGFuZCBhcyBz
dWNoIEkgd291bGQgbm90IGdvIHRvIHRoZSBtYXQgaW4gYXJndWluZyB0aGUNCnBhdGNoZXMgbXVz
dCBiZSB0YWtlbi4gQnV0IGlmIHdlIGRvbid0IHRha2UgdGhlbSwgd2UgbmVlZCB0byBnbyBiYWNr
IGFuZA0KY2xlYW4gdXAgbWlub3IgZXJyb3JzIGFuZCBpbmNvbnNpc3RlbmNpZXMgaW4gdGhlIG9w
ZW4gY29kaW5nIGF0IHNvbWUNCmV4aXN0aW5nIGh5cGVyY2FsbCBjYWxsIHNpdGVzLg0KDQo+ID4g
V2l0aCB0aW1lIHRoZXNlIGZ1bmN0aW9ucyBvbmx5IGdldCBtb3JlIGNvbXBsaWNhdGVkIGFuZCBl
cnJvciBwcm9uZS4gVGhlDQo+ID4gc2F2aW5nIG9mIHJhbSBpcyB2ZXJ5IG1pbmltYWwsIHRoaXMg
bWFrZXMgYW5hbHl6aW5nIGNyYXNoIGR1bXBzIGhhcmRlciwNCj4gPiBhbmQgaW4gc29tZSBjYXNl
cyBsaWtlIGluIHlvdXIgcGF0Y2ggMy83IGRpc2FibGVzIHVubmVjZXNzYXJpbHkgaW4gZXJyb3Ig
Y2FzZToNCj4gPg0KPiA+IC0gaWYgKGNvdW50ID4gSFZfTUFYX01PRElGWV9HUEFfUkVQX0NPVU5U
KSB7DQo+ID4gLSAgcHJfZXJyKCJIeXBlci1WOiBHUEEgY291bnQ6JWQgZXhjZWVkcyBzdXBwb3J0
ZWQ6JWx1XG4iLCBjb3VudCwNCj4gPiAtICAgSFZfTUFYX01PRElGWV9HUEFfUkVQX0NPVU5UKTsN
Cj4gPiArIGxvY2FsX2lycV9zYXZlKGZsYWdzKTsgICAgICA8PDw8PDw8DQo+ID4gLi4uDQoNCkZX
SVcsIHRoaXMgZXJyb3IgY2FzZSBpcyBub3QgZGlzYWJsZWQuIEl0IGlzIGNoZWNrZWQgYSBmZXcg
bGluZXMgZnVydGhlciBkb3duIGFzOg0KDQorICAgICAgIGlmIChjb3VudCA+IGJhdGNoX3NpemUp
IHsNCisgICAgICAgICAgICAgICBwcl9lcnIoIkh5cGVyLVY6IEdQQSBjb3VudDolZCBleGNlZWRz
IHN1cHBvcnRlZDoldVxuIiwgY291bnQsDQorICAgICAgICAgICAgICAgICAgICAgIGJhdGNoX3Np
emUpOw0KDQo+ID4NCj4gPiBTbywgdGhpcyBpcyBhIG5hayBmcm9tIG1lLiBzb3JyeS4NCj4gPg0K
PiANCj4gRnVydGhlcm1vcmUsIHRoaXMgbWFrZXMgdXMgbG9zZSB0aGUgYWJpbGl0eSB0byBwZXJt
YW5lbnRseSBtYXANCj4gaW5wdXQvb3V0cHV0IHBhZ2VzIGluIHRoZSBoeXBlcnZpc29yLiBTbywg
V2VpIGtpbmRseSB1bmRvLg0KPiANCg0KQ291bGQgeW91IGVsYWJvcmF0ZSBvbiAibG9zZSB0aGUg
YWJpbGl0eSB0byBwZXJtYW5lbnRseSBtYXANCmlucHV0L291dHB1dCBwYWdlcyBpbiB0aGUgaHlw
ZXJ2aXNvciI/IFdoYXQgc3BlY2lmaWNhbGx5IGNhbid0IGJlDQpkb25lIGFuZCB3aHk/DQoNCjxz
bmlwPg0KDQo+ID4NCj4gPj4gKy8qDQo+ID4+ICsgKiBBbGxvY2F0ZSBvbmUgcGFnZSB0aGF0IGlz
IHNoYXJlZCBiZXR3ZWVuIGlucHV0IGFuZCBvdXRwdXQgYXJncywgd2hpY2ggaXMNCj4gPj4gKyAq
IHN1ZmZpY2llbnQgZm9yIGFsbCBjdXJyZW50IGh5cGVyY2FsbHMuIElmIGEgZnV0dXJlIGh5cGVy
Y2FsbCByZXF1aXJlcw0KPiA+DQo+ID4gVGhhdCBpcyBpbmNvcnJlY3QuIFdlJ3ZlIGlvbW11IG1h
cCBoeXBlcmNhbGxzIHRoYXQgd2lsbCB1c2UgdXAgZW50aXJlIHBhZ2UNCj4gPiBmb3IgaW5wdXQu
IE1vcmUgY29taW5nIGFzIHdlIGltcGxlbWVudCByYW0gd2l0aGRyYXdsIGZyb20gdGhlIGh5cGVy
dmlzb3IuDQoNCkF0IGxlYXN0IHNvbWUgZm9ybSBvZiByYW0gd2l0aGRyYXdhbCBpcyBhbHJlYWR5
IGltcGxlbWVudGVkIHVwc3RyZWFtIGFzDQpodl9jYWxsX3dpdGhkcmF3X21lbW9yeSgpLiBUaGUg
aHlwZXJjYWxsIGhhcyBhIHZlcnkgc21hbGwgaW5wdXQgdXNpbmcgdGhlDQpodl9zZXR1cF9pbigp
IGhlbHBlciwgYnV0IHRoZSBvdXRwdXQgbGlzdCBvZiBQRk5zIG11c3QgZ28gdG8gYSBzZXBhcmF0
ZWx5DQphbGxvY2F0ZWQgcGFnZSBzbyBpdCBjYW4gYmUgcmV0YWluZWQgd2l0aCBpbnRlcnJ1cHRz
IGVuYWJsZWQgd2hpbGUNCl9fZnJlZV9wYWdlKCkgaXMgY2FsbGVkLiBUaGUgdXNlIG9mIHRoaXMg
c2VwYXJhdGUgb3V0cHV0IHBhZ2UgcHJlZGF0ZXMgdGhlDQppbnRyb2R1Y3Rpb24gb2YgdGhlIGh2
X3NldHVwX2luKCkgaGVscGVyLg0KDQpGb3IgaW9tbXUgbWFwIGh5cGVyY2FsbHMsIHdoYXQgZG8g
dGhlIGlucHV0IGFuZCBvdXRwdXQgbG9vayBsaWtlPyBJcyB0aGUNCnBhcmFkaWdtIGRpZmZlcmVu
dCBmcm9tIHRoZSB0eXBpY2FsIHNtYWxsIGZpeGVkIHBvcnRpb24gcGx1cyBhIHZhcmlhYmxlIHNp
emUNCmFycmF5IG9mIHZhbHVlcyB0aGF0IGFyZSBmZWQgaW50byBhIHJlcCBoeXBlcmNhbGw/IElz
IHRoZXJlIGFsc28gYSBsYXJnZSBhbW91bnQNCm9mIG91dHB1dCBmcm9tIHRoZSBoeXBlcmNhbGw/
IEp1c3QgY3VyaW91cyBpZiB0aGVyZSdzIGEgY2FzZSB0aGF0J3MgZnVuZGFtZW50YWxseQ0KZGlm
ZmVyZW50IGZyb20gdGhlIGN1cnJlbnQgc2V0IG9mIGh5cGVyY2FsbHMuDQoNCk1pY2hhZWwNCg==

