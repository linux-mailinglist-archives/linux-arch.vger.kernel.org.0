Return-Path: <linux-arch+bounces-9024-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AFB9C4993
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 00:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B26283EE6
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 23:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE381BD4E5;
	Mon, 11 Nov 2024 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FKoH1UJA"
X-Original-To: linux-arch@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020125.outbound.protection.outlook.com [52.101.85.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB58224FD;
	Mon, 11 Nov 2024 23:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731366639; cv=fail; b=El1SWf27Q02xIScgVwRXOkfi4Vr2EKNyNHZ/XBzfOxjfTEzrKg8SeSaS3z+017jcirfDD3kCAubY4yqsazayl1guz2wpTcxPwCrj4oofeDB/ApCUKzUc9o8Y+Sf9WCuqi2Kc8tVA0nOWJjnazqjWwSl49uIcQ1bZVGxlbFnsxVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731366639; c=relaxed/simple;
	bh=NUrQw4i5BDrx/JxcIiuk3paaCtOxkdwIX3tHXGyX3Mo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=foOscd9hon2DF0wGse4cFVxR9fYMFs2buC+dVIjcPJi0P6wYRcqjZQmBHIGX4iWv7G7Eg4Yo5IrmbqH9bhec8hVQbvJjRAwPgXWS3zgxajKB/ZyXgdL1xE7hwdR7PeJJvhzE/b9/g6gsHt55klRIPFSBPms6fvfD0cE3VEioAvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=FKoH1UJA; arc=fail smtp.client-ip=52.101.85.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zo1CDBkDGm/RyoSuhH/KfBIctg0DD/OwifRnkn+EYCuPujZOM97Gu7iCC/YV7TiuS5m6TfMu3hSbQkdO7qsxnvWax8yg8yP2plpZcUJ9GHY2pcADLtC+K2dSCxaIhpcEn5KDTSrZTaK/tPJzNCVgAfGJsjFpmhpryR6ETtcuHkI5lXqPKkQXI4ZIElv6wlfCnrUxZHIedtFjiJ5yIPjmPyBPY++nG4fVWfW4T0or+v2JyVAF18akNXOWtNpEecaCGWAUOpIuAfAGOuN3RvSzmcgX5pZRbYZi6GMXsPe6PI5T7adRn2r9p9d0pAQD3kwS7hRn8bPHoetf79/t8QDyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUrQw4i5BDrx/JxcIiuk3paaCtOxkdwIX3tHXGyX3Mo=;
 b=jpYdUo29rS8Vfo0fYS9qv+gRHAVwc6mvxUapZRWAHX77ASqE2Om0QaE2fAxpEzMzH9QN1sYYBW+DCl1ormgkQzXjD6UkGkLp/hFqUR75a5U//mk3wqzcJTmEWo5hg+s97A9jTcub9QDvVaGXFVZTkRHRxpQPU5oOa6Ufv6aYlsWYqEoacvxB1QaACZODT0FlpH/2i9VbAr1NsXl/0mKb6QkbYbLjAy8dvqQkrj/s4H06XMI7rCdvZJGoVns262UuRQC6kdGhmG02uWOCzAwIY8aYoEPCKsik6iqkXYWxvwPaTWmTFWllAb6AjDR42wQUZ5IvNKrHDeCCmTSCrpNFXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUrQw4i5BDrx/JxcIiuk3paaCtOxkdwIX3tHXGyX3Mo=;
 b=FKoH1UJAn4opnNs9pW5M7DXbFVgRJuG9H8KxUZ1clktBjGwx43L9rkG5B/GlLcWRO/WoqxoF8Mqerai60oYNEZ6/X9cYHr2fCQVp55XRScJ5uVt9qdU4msWKGNn9riPgi9zC9AtH6zNG4yMDLU0SHkzW+18xBg36n/1g9VsTmyk=
Received: from DM6PR21MB1434.namprd21.prod.outlook.com (2603:10b6:5:25a::10)
 by DM4PR21MB3320.namprd21.prod.outlook.com (2603:10b6:8:69::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.10; Mon, 11 Nov
 2024 23:10:34 +0000
Received: from DM6PR21MB1434.namprd21.prod.outlook.com
 ([fe80::790a:4e07:a440:55cd]) by DM6PR21MB1434.namprd21.prod.outlook.com
 ([fe80::790a:4e07:a440:55cd%4]) with mapi id 15.20.8158.013; Mon, 11 Nov 2024
 23:10:34 +0000
From: MUKESH RATHOR <mukeshrathor@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "luto@kernel.org" <luto@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "joro@8bytes.org"
	<joro@8bytes.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"muminulrussell@gmail.com" <muminulrussell@gmail.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "apais@linux.microsoft.com"
	<apais@linux.microsoft.com>
Subject: Re: [EXTERNAL] RE: [PATCH v2 0/4] Add new headers for Hyper-V Dom0
Thread-Topic: [EXTERNAL] RE: [PATCH v2 0/4] Add new headers for Hyper-V Dom0
Thread-Index: AQHbMWTxJJYHeO0ZVECt2plLi445lLKxfTKAgAD10QCAACt+AIAAHIaA
Date: Mon, 11 Nov 2024 23:10:34 +0000
Message-ID: <8abdc84b-1ee5-bf19-c65e-82f9293d5c84@microsoft.com>
References:
 <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
 <BN7PR02MB41485DAD2E066D417FE12020D4582@BN7PR02MB4148.namprd02.prod.outlook.com>
 <b4a46acc-f4bb-81db-fcc1-29c55dc7724f@microsoft.com>
 <SN6PR02MB415747D0DB0879729E6D7D03D4582@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB415747D0DB0879729E6D7D03D4582@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR21MB1434:EE_|DM4PR21MB3320:EE_
x-ms-office365-filtering-correlation-id: afd8a3a5-3687-4cbc-ec51-08dd02a60bf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?UE14L3luMHFNdGN2QkhWY1ZwTU9uUW9aTzc2dk9NbUNoVGsvallFL2dEVEYx?=
 =?utf-8?B?Z2ZQYTMybmZlSkJHTnRFNXE4Q0p6MGd4S2VYV255ei93UmtnRkRRK1V0Z2Rh?=
 =?utf-8?B?UDM3d3ZUUDRRNVFXUTRzelA1RzM0N0toZnZsTklMeTNqc3gzRTU1MVFoT2I2?=
 =?utf-8?B?UmloYWNnakZyUjM1aUowNEsvTGxZc24xSUc4VGxKdUZjWEhjbUl6RUpaOU00?=
 =?utf-8?B?SFpuNHlpUzBjWHIwblFFOVdhckFQZGcxdUFOeG43eEEvNVpaWG45Y2ZMdGtw?=
 =?utf-8?B?Y1VzV2xBRGo5QUVpZXhHMWJlRDNJNnFIY0xod0d6VVFSN2h1dDl0b2dvSU5P?=
 =?utf-8?B?d3NWUlNnVm5PaytnWkhyNTE3YVZMOS9aMzJ6NUN6WUpsZUEyeHRlM1c0bW5l?=
 =?utf-8?B?L1I4bVpjQTE4N2dpYU5acGw1ZVVPMHFpQXYzOVFWNTJLWUszMjdZc1B2T0Vw?=
 =?utf-8?B?bDNjSWVrZ0c4aUtqdjRVNzdtdGZqTnV3RUJwUW1SNWVsM25FVytGKzZBRlc3?=
 =?utf-8?B?M1lTandRVk01S2NUclhXL3lsUys1c09RWGV1Q3pFeFlJeGd1UmtRWXUzaHNp?=
 =?utf-8?B?MllPaGlFeG16VVhzL08reUxMVVB0UVloT1dkajZ0aGh3WERMTmw1dTQyNmtN?=
 =?utf-8?B?NHZwYmNPTEJreENDN1NNYVV2cEcvcVdQV1FRN2daOGNmL3FSYWhuZ3dkMHlJ?=
 =?utf-8?B?Ti96d1NMNldUblYrdXdNekJsdWhXcnZuZHlkaVVUT1hFWU1wbHBWc3Vlb21D?=
 =?utf-8?B?SEV2aG1CSysweVNrQ3pHWnFWRWs5VGoxZWJYazhGSENEcEI0bUp3eDBia3hB?=
 =?utf-8?B?U2NiZUd5Nkd4alFyZTNzcTdIWkZBZXN5cXYrRHhReHBFRXZybVpNZ1B2dUp1?=
 =?utf-8?B?TUYzZzJ4aXBSOWVaeEN4KzIvdHJtWUExa2JWSUFPTk0xSHdIMVR3OWlsQW9n?=
 =?utf-8?B?T0VOcDJISXQrRHFkb0lyUThtQ2Mvako5QlZNc1VPN0U5czJYbysxc2JJcjNR?=
 =?utf-8?B?RVdMR0Z1K0hzek1UOHp4bithRjJ0b1JnbFVoaXNwVis4bEEzaW90MFFvTmVz?=
 =?utf-8?B?UEk1aEZ4akg0U0RVUGw3bzVrVUp0dG9YUVlqZVpxWmtsWnlqanpsdGhFMXND?=
 =?utf-8?B?YXlKWUp4d2VkN2tCQkhEcU05T3Z4QVlSREpuZDg3VUVHM1VsSmhkRnAvaGE0?=
 =?utf-8?B?bmxveTZvTHh2bzBVbUVPUXp2Z2hxMXNZc00xQnpyT3I3UkczSTA3NXhOdkNN?=
 =?utf-8?B?cEQxMFNiejhCUlRET2t4Um9IM041MmNwNnIzSXFjc1N1T1ZkeWplc1FCR00y?=
 =?utf-8?B?dFdhbnN3K00zY1FtTksxUUNPbE9lK0xMdDZOMEZoSHVWVGx0VXhUUks2SWda?=
 =?utf-8?B?OEFMOFpHWjNSaUlDanduUzdsM0EyWW9qMjV4MllhVUJjS3cvbUZScUhEUUZl?=
 =?utf-8?B?UWliZEkwV0R5WDNHM1FoekovZE1PR09pK25sRGgybHAwME5kU1dkdVhraytp?=
 =?utf-8?B?Zllnc0M4cmw4NGQ4Z1czZVhhdHlmYVJFWXFrd1ZwcElOZTAzM0J5bHZKQUcr?=
 =?utf-8?B?VTdMOCswQ0ZuLzBDT3NtK3k0YStaajZNVFZuYzFWOTRUd1VTSURwbURIaUxV?=
 =?utf-8?B?RHFldTk2TlYxdmxGUnZmb1dGaEZWb2kwU083RXcvU1BRK2pTZXJlSGI5UkVr?=
 =?utf-8?B?eXlTY0dsaWN0U0hBVTgrT3VxNldqUXFESkZkeEc0Snd5ZEE2UzRKN2Y3NEls?=
 =?utf-8?B?VldDTnVxQjVZazQ4N25vbWdHM3kwdXJ1SFdrSlJBNEJoVGd4K3ZHUEEyQVY4?=
 =?utf-8?B?emNvZGkzVENxY1NJVGFKNjloNzZ5MlhIaHhtVWJHeHkzUXJzZ3JVNjZQZTRJ?=
 =?utf-8?Q?uRLy96TeATaf/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1434.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TTJqbUdaV2FzTEFyT1RPRUxUdmtqTmVxNXlmcTcyYlBrSVo5WGxhdFgwK3VJ?=
 =?utf-8?B?ejgxN2hmaDZmb1g3b05BeTRVWFBvNGtsVHRzVnQyMERieHR5dG0rSUt3TVBq?=
 =?utf-8?B?QXpMdXdxNmc1Y0d0SlJRVktwRm9NL0ZGekVFNDhjR2VvYlpqdEs2dU43REpY?=
 =?utf-8?B?QS80S2ZyRndTd3VxTGVGUXA1OGVkR1ZWMGJXOEc2STE3UnZ6Wkx0N3N5Y3Va?=
 =?utf-8?B?amVkMFdRQXR4eEh1UFdVbWlSSkh2clhEWGphenBjZ3VRN1JKOFdYbE1lNmNK?=
 =?utf-8?B?ZEZWVTNHWTZFZytEcUVDK3dGK05XR3h2SXhOdWJFVVVhRnZHaEFEQWpkQTNV?=
 =?utf-8?B?WG1xYnkyRU5Uczg4NFBuQ2VnSEIwUkViNWdhNDhRRnJVQ1V3NmlwdFNQZDNG?=
 =?utf-8?B?MXNHaGtlNlRZUzM2TDM0cDhkVmk5aWJwUlUyV2FhTzFoS29yaGlVZlJPR1ZR?=
 =?utf-8?B?dTlCTTRYRmhBc1M1VFhpOXp3TEdTRnUrOVVSby9ScTBXOElZcEp3MXdUbFNB?=
 =?utf-8?B?M25qSFlmeTF2ejk2VWF6a2pRQ09nNmRaWGk0c1dsWkwvR0J6TFNhVUdXakhE?=
 =?utf-8?B?WVhibG1LVFFMS1Vqd2grTTVlQnBiWWx6aFR2Lzc0RkZaOWlLWFlpQng2THFV?=
 =?utf-8?B?QmRxWWtXMWVCd3lXYW92dUVHZlA5bHVXRENmRlBzUGlaNWNJVVVyTFB2SGtk?=
 =?utf-8?B?c0hUUGxWbzluMndFRFZjM2FHcmpBNjk3K0F5eVAwQlJPSnA3VmhQMjJ2aHNB?=
 =?utf-8?B?a3pUZW5vTHN2QVZKTSs5MjA5aHlaek1Edysvc2hQVVVkSEM5cnZ4OXZBWkhI?=
 =?utf-8?B?T0VyRTFtWjUxU2RScTlsL3hyVk9STnQ4MjBFNDhPV3M4dy95OTIyc2QyL0tN?=
 =?utf-8?B?SHhBcmZsYWJ2cyttVzVlRFM3QmwwU1pIT3A5c2FVSmZsUVNDYjNyQzYwbytj?=
 =?utf-8?B?SjB4dTl0eURCZ3g4ZGJMc2FkM1ZXWE1yaW11bGtCUFdZbzJVUEt5N0F0NDly?=
 =?utf-8?B?aGdnZFBPWTBkamZjMUVsMGtwYkxVa0FQRS9DQjVWN2crWWxsTUFzMTZOckN0?=
 =?utf-8?B?WFBKY1FzZ0p4SFR4UWZ5R1d6YkQ3THVxNEJWYTI5R1J0K3U5RTA0Z3hFbVdY?=
 =?utf-8?B?UmlSUnRSbTZ0aUlpWDE4UWtRNEhZTmJVZ3AzWmFrY3VhV3FodndVem5sSUZp?=
 =?utf-8?B?QkxjdzF6cHJidkhoQUFuMHdyaXl2MFJEeHM4VmRHZFpSOFgzNW5OOEEzZ3BH?=
 =?utf-8?B?NmUvTWxZMmpCaThUK2ZNYU9GTDQxQjBpUHJSK1dONUd3VzlyL3gzUzJ5N2NX?=
 =?utf-8?B?c2dvUlQwQ1VCSlNQd3EzUUNFcGlKOE9qdDNNT1hwcDhMZEh3dTZmUU4ydlpt?=
 =?utf-8?B?b2NyODBSdjdKQUxFYkg2UWhURXhQSnNOMWxhbUYzbWE2MTZYV29ENUpIYVpJ?=
 =?utf-8?B?cEs4TGtnbHJoZGxJTUxhVmZ3Zm9qTGpvT2F6TDBNS2JnakpkUGcrNHhnR2lV?=
 =?utf-8?B?My96b3A4blJJSG92Ykg3U0s3bmRlRW9ETktieFlPTDV1b2x1d3cyVzFOVU5W?=
 =?utf-8?B?dENwMk94SlRHV1pia1pVVUNGeHl6aDVlZ3QxZHZkZ255Rm11dmNtbHlhbjdU?=
 =?utf-8?B?RmFyS29hbE9PU0pjQ0xtKzJqRG9vTkxOT2FtdDRRYXQ0Wjh6NjJ5cDFlSEhY?=
 =?utf-8?B?MUw0N2JwMjVKVy8yakd2cGRERkZuQ1Y1d0FybCttZGt3SUM0MEtkZXJvbzlE?=
 =?utf-8?B?V1pGT3E5UjEvQStuem5XWkh5bkFBM1huTTVzVkMrUnlEekdZUmYvSk9oR2Nw?=
 =?utf-8?B?cS9ibk43clh2eFgvelhlQkhxMG1wUThFc1BLcTM4QUdxZlMvbllQS1Y5WmFn?=
 =?utf-8?B?YjZaRTFSRkVQdGVXcnlsMjlBSFV4cFMvUEdyR1hJSTBjOXQrOUVjdFMveGZV?=
 =?utf-8?B?a2MxYlljZE9hcWFTUUc0ZU5qaGJ5eVM2aHA1b3NGeFJ0U2VWb3JLNDlDRGs0?=
 =?utf-8?B?Vy9ZczQ3SFIya1V4V1F2cjBMcFltZlczYWxycmM2bm9tV2FTRlgvejluU3Yr?=
 =?utf-8?Q?NhAoNk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B2DA57BB15F4648AAA53837AB911320@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1434.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd8a3a5-3687-4cbc-ec51-08dd02a60bf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 23:10:34.4835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ge70Weizi053FwG/3QAzxIlVDpn2rRFjSdzZG0GJKhOFtL2FuQixkEwHLzZd6x27mxy5Wls+K8L41tzPq4Jtf7tWhxWu8o2Trng0uRkrJnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3320

DQpPbiAxMS8xMS8yNCAxMzoyOCwgTWljaGFlbCBLZWxsZXkgd3JvdGU6DQogPiBGcm9tOiBNVUtF
U0ggUkFUSE9SIDxtdWtlc2hyYXRob3JAbWljcm9zb2Z0LmNvbT4gU2VudDogTW9uZGF5LCANCk5v
dmVtYmVyIDExLCAyMDI0IDEwOjUzIEFNDQogPj4NCiA+PiBPbiAxMS8xMC8yNCAyMDoxMiwgTWlj
aGFlbCBLZWxsZXkgd3JvdGU6DQogPj4gICA+IEZyb206IE51bm8gRGFzIE5ldmVzIDxudW5vZGFz
bmV2ZXNAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDoNCiA+PiBUaHVyc2RheSwgTm92ZW1iZXIg
NywgMjAyNCAyOjMyIFBNDQogPj4gICA+Pg0KID4+ICAgPj4gVG8gc3VwcG9ydCBIeXBlci1WIERv
bTAgKGFrYSBMaW51eCBhcyByb290IHBhcnRpdGlvbiksIG1hbnkgbmV3DQogPj4gICA+PiBkZWZp
bml0aW9ucyBhcmUgcmVxdWlyZWQuDQogPj4gICA+DQogPj4gICA+IFVzaW5nICJkb20wIiB0ZXJt
aW5vbG9neSBoZXJlIGFuZCBpbiB0aGUgU3ViamVjdDogbGluZSBpcyBsaWtlbHkgdG8NCiA+PiAg
ID4gYmUgY29uZnVzaW5nIHRvIGZvbGtzIHdobyBhcmVuJ3QgaW50aW1hdGVseSBpbnZvbHZlZCBp
biBIeXBlci1WIA0Kd29yay4NCiA+PiAgID4gUHJldmlvdXMgTGludXgga2VybmVsIGNvbW1pdCBt
ZXNzYWdlcyBhbmQgY29kZSBmb3IgcnVubmluZyBpbiB0aGUNCiA+PiAgID4gSHlwZXItViByb290
IHBhcnRpdGlvbiB1c2UgInJvb3QgcGFydGl0aW9uIiB0ZXJtaW5vbG9neSwgYW5kIEkgDQpjb3Vs
ZG4ndA0KID4+ICAgPiBmaW5kICJkb20wIiBoYXZpbmcgYmVlbiB1c2VkIGJlZm9yZS4gInJvb3Qg
cGFydGl0aW9uIiB3b3VsZCBiZSBtb3JlDQogPj4gICA+IGNvbnNpc3RlbnQsIGFuZCBpdCBhbHNv
IG1hdGNoZXMgdGhlIHB1YmxpYyBkb2N1bWVudGF0aW9uIGZvciANCkh5cGVyLVYuDQogPj4gICA+
ICJkb20wIiBpcyBYZW4gc3BlY2lmaWMgdGVybWlub2xvZ3ksIGFuZCBoYXZpbmcgaXQgc2hvdyB1
cCBpbiBIeXBlci1WDQogPj4gICA+IHBhdGNoZXMgd291bGQgYmUgY29uZnVzaW5nIGZvciB0aGUg
Y2FzdWFsIHJlYWRlci4gSSBrbm93ICJkb20wIiBoYXMNCiA+PiAgID4gYmVlbiB1c2VkIGludGVy
bmFsbHkgYXQgTWljcm9zb2Z0IGFzIHNob3J0aGFuZCBmb3IgIkh5cGVyLVYgcm9vdA0KID4+ICAg
PiBwYXJ0aXRpb24iLCBidXQgaXQncyBwcm9iYWJseSBiZXN0IHRvIGNvbXBsZXRlbHkgYXZvaWQg
c3VjaCANCnNob3J0aGFuZA0KID4+ICAgPiBpbiBwdWJsaWMgTGludXgga2VybmVsIHBhdGNoZXMg
YW5kIGNvZGUuDQogPj4gICA+DQogPj4gICA+IEp1c3QgbXkgJC4wMiAuLi4uDQogPj4NCiA+PiBI
aSBNaWNoYWVsLA0KID4+DQogPj4gRldJVywgaHlwZXJ2IHRlYW0gYW5kIHVzIGFyZSB1c2luZyB0
aGUgdGVybSAiZG9tMCIgbW9yZSBhbmQgbW9yZSB0bw0KID4+IGF2b2lkIGNvbmZ1c2lvbiBiZXR3
ZWVuIHdpbmRvd3Mgcm9vdCBhbmQgbGludXggcm9vdCwgYXMgZG9tMCBpcw0KID4+IGFsd2F5cyBs
aW51eCByb290LiBJIGRpZCBhIHF1aWNrIHNlYXJjaCwgYW5kICJkb20wIiBpcyBuZWl0aGVyDQog
Pj4gY29weXJpZ2h0ZWQgbm9yIHRyYWRlbWFya2VkIGJ5IHhlbiwgYW5kIEknbSBzdXJlIHRoZSBm
aW5lIGZvbGtzDQogPj4gdGhlcmUgd29uJ3QgYmUgb2ZmZW5kZWQuIEhvcGVmdWxseSwgW0h5cGVy
LVZdIHRhZyB3b3VsZCByZWR1Y2UNCiA+PiB0aGUgY29uZnVzaW9uLg0KID4+DQogPj4gSnVzdCBt
eSAkMC4xDQogPj4NCiA+DQogPiBZZWFoLCAiZG9tMCIgY2VydGFpbmx5IGZpdHMgYXMgc2hvcnRo
YW5kIGZvciB0aGUgcmF0aGVyIHBvbmRlcm91cw0KID4gIkxpbnV4IHJ1bm5pbmcgaW4gYSBIeXBl
ci1WIHJvb3QgcGFydGl0aW9uIi4gOi0pDQogPg0KID4gQnV0IGV2ZW4gdXNpbmcgIkh5cGVyLVYg
ZG9tMCIgdG8gYWRkIGNsYXJpdHkgdnMuIFhlbiBkb20wIHNlZW1zDQogPiB0byBtZSB0byBiZSBh
IG1pc25vbWVyIGJlY2F1c2UgSHlwZXItViBkb20wIGlzIG9ubHkgY29uY2VwdHVhbGx5DQogPiBs
aWtlIFhlbiBkb20wLiBJdCdzIG5vdCBhY3R1YWxseSBhbiBpbXBsZW1lbnRhdGlvbiBvZiBYZW4g
ZG9tMC4NCiA+IExldCBtZSBnaXZlIHR3byBleGFtcGxlczoNCiA+DQogPiAxKSBIeXBlci1WIHBy
b3ZpZGVzIFZNQnVzLCB3aGljaCBpcyBjb25jZXB0dWFsbHkgc2ltaWxhciB0byB2aXJ0aW8uDQog
PiBCdXQgVk1CdXMgaXMgbm90IGFuIGltcGxlbWVudGF0aW9uIG9mIHZpcnRpbywgYW5kIHdlIGRv
bid0IGNhbGwgaXQNCiA+ICJIeXBlci1WIHZpcnRpbyIuICBPZiBjb3Vyc2UsICJWTUJ1cyIgaXMg
YSBsb3Qgc2hvcnRlciB0aGFuICJIeXBlci1WDQogPiByb290IHBhcnRpdGlvbiIgc28gdGhlIG1v
dGl2YXRpb24gZm9yIGEgc2hvcnRoYW5kIGlzbid0IHRoZXJlLCBidXQgc3RpbGwuDQogPiBJZiBI
eXBlci1WIHNob3VsZCBldmVyIGltcGxlbWVudCBhY3R1YWwgdmlydGlvIGludGVyZmFjZXMsIHRo
ZW4gaXQNCiA+IHdvdWxkIGJlIHZhbGlkIHRvIGNhbGwgdGhhdCAiSHlwZXItViB2aXJ0aW8iLg0K
ID4NCiA+IDIpIEtWTSBoYXMgIktWTSBIeXBlci1WIiwgd2hpY2ggSSB0aGluayBpcyB2YWxpZC4g
SXQncyBhbg0KID4gaW1wbGVtZW50YXRpb24gb2YgSHlwZXItViBpbnRlcmZhY2VzIGluIEtWTSBz
byB0aGF0IFdpbmRvd3MNCiA+IGd1ZXN0cyBjYW4gcnVuIGFzIGlmIHRoZXkgYXJlIHJ1bm5pbmcg
b24gSHlwZXItVi4NCiA+DQogPiBJIHdvbid0IHNwZWN1bGF0ZSBvbiB3aGF0IHRoZSBYZW4gZm9s
a3Mgd291bGQgdGhpbmsgb2YgIkh5cGVyLVYNCiA+IGRvbTAiLCBlc3BlY2lhbGx5IGlmIGl0IGlz
bid0IGFuIGltcGxlbWVudGF0aW9uIHRoYXQncyBjb21wYXRpYmxlDQogPiB3aXRoIFhlbiBkb20w
IGZ1bmN0aW9uYWxpdHkuDQogPg0KID4gQXMgZm9yICJtb3JlIGFuZCBtb3JlIiB1c2FnZSBvZiAi
ZG9tMCIgYnkgeW91ciB0ZWFtIGFuZCB0aGUNCiA+IEh5cGVyLVYgdGVhbTogIElzIHRoYXQgaW50
ZXJuYWwgdXNhZ2Ugb25seT8gT3IgdXNhZ2UgaW4gcHVibGljIG1haWxpbmcNCiA+IGxpc3RzIG9y
IG9wZW4gc291cmNlIHByb2plY3RzIGxpa2UgQ2xvdWQgSHlwZXJ2aXNvcj8gQWdhaW4sIGZyb20N
CiA+IG15IHN0YW5kcG9pbnQsIGludGVybmFsIGlzIGludGVybmFsIGFuZCBjYW4gYmUgd2hhdGV2
ZXIgaXMgY29udmVuaWVudA0KID4gYW5kIHByb3Blcmx5IHVuZGVyc3Rvb2QgaW50ZXJuYWxseS4g
QnV0IGluIHB1YmxpYyBtYWlsaW5nIGxpc3RzIGFuZA0KID4gcHJvamVjdHMsIEkgdGhpbmsgIkh5
cGVyLVYgZG9tMCIgc2hvdWxkIGJlIGF2b2lkZWQgdW5sZXNzIGl0J3MNCiA+IHRydWx5IGFuIGlt
cGxlbWVudGF0aW9uIG9mIHRoZSBkb20wIGludGVyZmFjZXMuDQogPg0KID4gVGhhdCdzIHByb2Jh
Ymx5IG5vdyAkMC4xMCB3b3J0aCBpbnN0ZWFkIG9mICQwLjAyLiA6LSkgQW5kIEknbQ0KID4gbm90
IHRoZSBkZWNpZGVyIGhlcmUgLS0gSSdtIGp1c3Qgb2ZmZXJpbmcgYSBwZXJzcGVjdGl2ZS4NCg0K
ImRvbTAiIGlzIG5laXRoZXIgYSB0ZWNobm9sb2d5IG5vciBhIHByb3RvY29sLiBJdCBzaW1wbHkg
bWVhbnMgaW5pdGlhbA0KZG9tYWluICh3aGljaCBvbiB4ZW4gaGFwcGVuZWQgdG8gYmUgZG9taWQg
b2YgMCwgY291bGQgaGF2ZSBiZWVuIDEpLiBUaGlzDQppcyBjcmVhdGVkIGR1cmluZyBib290LCBz
YW1lIGFzIGxpbnV4IHJvb3Qgb24gaHlwZXJ2LCBhbmQgaXMgcHJpdmlsZWdlZA0KZG9tYWluIHNh
bWUgYXMgeGVuLiBFdmVuIGluIEtWTSB3b3JsZCwgSSd2ZSBoZWFyZCBtYW55IGZvbGtzIHJlZmVy
IHRvDQp0aGUgaG9zdCBhcyBrdm0gZG9tMC4uLg0KDQpHaXZlbiB0aGUgbWl4IG9mIHdpbmRvd3Mg
YW5kIGxpbnV4IHdpdGggbDF2aCBhbmQgbmVzdGVkLCBkb20wIGlzIGhlbHBpbmcNCmluIGNvbnZl
cnNhdGlvbnMgaW50ZXJuYWxseSwgYW5kIEknbSBzdXJlIGl0IHdpbGwga2VlcCBwZXJjb2xhdGlu
Zw0KZXh0ZXJuYWxseS4NCg0KVGhhbmtzLA0KLU11a2VzaA0KDQoNCg==

