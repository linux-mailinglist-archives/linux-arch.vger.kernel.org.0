Return-Path: <linux-arch+bounces-10568-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84A6A56F42
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 18:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1003B8283
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 17:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FCC241105;
	Fri,  7 Mar 2025 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="g4y76f5g"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2038.outbound.protection.outlook.com [40.92.19.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC2723FC4C;
	Fri,  7 Mar 2025 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369114; cv=fail; b=epU/J5Lyi/LmR7zo42ufNdftNi55AOV9b6CwFYB6x31+fmvXpTNEV3uR20HhWMqQBAB1r84bK6POtr7pD0qWMaWGGfFK8zx5QURedbeJ1FvzjyZYaL5gCC25CWC2ytguDkeHb9Lf0WNU1C2ZES96KIMfZ1rTrVPI7MbzYRaCD2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369114; c=relaxed/simple;
	bh=lk//98w7GFTf5369yN67TswCP7MUf1LkAwh+Rze6ql8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SQFjcszQdDmwknt4J2FSw9yzrGAfKcFCneUIt8fxyXU4VOxVqFqE/jtfhk+eBigtasBT29JJTS0E24pYJAC78YSpvRmLH/0DA9Or1mu2m6GF/JsvPbpvBWm73UpsAMzV1+oCMUUDPd5j5BKoStjfUJ8YeNnaaPn9xOkqwPscxus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=g4y76f5g; arc=fail smtp.client-ip=40.92.19.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pR9RnOF2IRb4BQYcNFFHx4o0dX2HwxKgFu0/eOrHUSDM39EXhvH4+gtG57UDfQy83KR/8bbzXETYd4EbhBAIYILgccF51J3s/1IVURpE4EvVCJ1ts0itkBJNAcuyU9eDoRlh43nbGfEtUEipUMkkbUdPMSdkgetM4VGBGZz4M3rBuskeJlxaq2/pOuOxOvI+gF+LbmqmLYvO9NW7ApnxoDkslbuRf1Fzu38vlOwC6N+9w/zIRehhekRcDymZYkGOX7AwP7/GOAwCX2jwPGV2eBQeTtxhePWmxx9NWU/695nUHYFzNF4X+QQRnQ/1yxJIGDycasK6duGVKghwz9Vp7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lk//98w7GFTf5369yN67TswCP7MUf1LkAwh+Rze6ql8=;
 b=mAYEnJutzr4q8B72ITflZkwEA7aBG//2QlSfurRr3d9TAnD5PV7odzBcbM4udP0QIBW0IQWBVkMfa/VZjf/3HcFb64k81ouIzdD/PiK6AmTjFBOpHUX5EFmWM3MQkbmKyP0sjZkyO0c7vnPxkzjnRIbKlHcKkHT86mcYPeGjRs74yuUBq41tYFBd1Q9LTHegTU1uIl2T7r63kKAmdNL6dBVsb1+d9v+ewzVuIWn1OMQs1C0USYkA+W6qMeoli1tePKO9rJ1dL2IPPCe44Au9aS+d43JXDJn+0+IsMKgpQK6rKataKDxA8Aa6qkB1gq7lpPcwQ44Mql971f5lhlch5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lk//98w7GFTf5369yN67TswCP7MUf1LkAwh+Rze6ql8=;
 b=g4y76f5gReQIuAohpU3XurgKWdlAQiy4KTt2EFMAHvxYaOWxy5+0ZoMMrJTv46bPDHi+ACacJCXZn4BU/2QlD1A2d1hdl+k4GATD3/x5F7iw+FWIgVkJFtD5E1VJTXrrSQapUzy1wRqTKM2IN1fBI64Z89blIqkYcMDLcur6GR/EUY/WXcB3Il8+53nprVVT2dFuaJADQYB/i0EnQBnAXia8E2vL8yD2qJQ1stuy69LYHgrOQU28xAZkor66yZUNwDLoDV2i38AaUmPwb3SrvGCO4a35EYijqLHO/tE4k5dW/lKmNbFpWo0z3NDPwxV93Gl4fMWlKH6D7mmv+bedww==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BL3PR02MB7970.namprd02.prod.outlook.com (2603:10b6:208:355::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 17:38:29 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 17:38:28 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>, Stanislav Kinsburskii
	<skinsburskii@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"muminulrussell@gmail.com" <muminulrussell@gmail.com>,
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
Subject: RE: [PATCH v5 08/10] x86: hyperv: Add mshv_handler irq handler and
 setup function
Thread-Topic: [PATCH v5 08/10] x86: hyperv: Add mshv_handler irq handler and
 setup function
Thread-Index: AQHbiKNt6Dmf5ml0nkycDSKgcIRUw7NaPxqAgAM0E4CACohmkA==
Date: Fri, 7 Mar 2025 17:38:28 +0000
Message-ID:
 <SN6PR02MB41573673D5F786E6C47FC08ED4D52@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-9-git-send-email-nunodasneves@linux.microsoft.com>
 <Z7-nDUe41XHyZ8RJ@skinsburskii.>
 <7de9b06d-9a32-48b5-beda-2e19b36ae9c9@linux.microsoft.com>
In-Reply-To: <7de9b06d-9a32-48b5-beda-2e19b36ae9c9@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BL3PR02MB7970:EE_
x-ms-office365-filtering-correlation-id: ce9a330b-250d-4d3a-49e1-08dd5d9edf4e
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|15080799006|8060799006|8062599003|461199028|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?utf-8?B?aU9RaUJnK2crVlkxNkhrS25PRDBrbDlkZVVNaHBPZFV3N3ZFd3FuQVpmdkdt?=
 =?utf-8?B?UjRkUkVZNkpFbVJYdjhLQUphNmtWK3FSbkdLMFRhTFp4R3haWk9kVEhwME00?=
 =?utf-8?B?QkFyRHFzemRHOXUxdDB5MW1VUXZlK09vLzZIbzZBemhNcko5dHVTd0kybGJB?=
 =?utf-8?B?UzBaZnVyWmZtNnl4T1ZueUlOZjBJcDlQdnA0SU1SZVZCdVBHYmxtMW9jSS9R?=
 =?utf-8?B?TDdEZy9yRjc0MUsvU1dmcmkxV3dWdHRBV0U1Nlp3aWI5THB4Tm1nMTB1UXlm?=
 =?utf-8?B?UjNHS2JLdjBFeG0yT3VWbXpzb0ozR1NMUHh6UThNeE9rSndmbDlMZTk0ZkNQ?=
 =?utf-8?B?SHhtNTNpejk3QWg1S3NIa3U1K0RKemxMVlRVN2M1WHU0eGV1djIrNEtwMWt5?=
 =?utf-8?B?N3I0eUQyYmtuUFlpRUFURVF1WlZwZTBOaWRsVkJxVUM3M2JSREJOa2xhc2Q5?=
 =?utf-8?B?cGpXR1JMVUM5aXg1dDJwNVhQYUhERzZVSnBUczc3Q1JOZXVDdkI5QTlnRTBx?=
 =?utf-8?B?cW5CaWxqelh0MmpoZnh5d1MzaXN4RS9zY3ZyaEIxNm9lWXJYQWdUdDNXVUJR?=
 =?utf-8?B?VTZFbjVzL0w0K25oZkFWcnZsR2RObW1WaExIQzRvQUFRTVFBZXYxMDQzWm93?=
 =?utf-8?B?MytkVVJmaFU2ZFd0L0hBZENkTm9MVVJFanhGWlFVYkNrdm56anIyNTB6aGxk?=
 =?utf-8?B?bEw1bXM5cktaZkRUYVhWaUNBK3NlOVlvNWo5ZXk5VlhSNEJTNm9pVCtsMGxt?=
 =?utf-8?B?OUdJN0dBRDVmbDlaeVE3NHFNS2xUeXZKVlJyMEhGbHdlUE1CakxjTGUrb1Na?=
 =?utf-8?B?SThjNER5WHp2bWtkVzZWVzFpalB1ZEQ3TFBlRTdJMFFNZDJoWkFTVWNzd3Ar?=
 =?utf-8?B?NituMnZsK3REM3pKUm5HZ2xIbHRLQXRoTHI2QTRndkNCVGRQQW5ha3BJRjBK?=
 =?utf-8?B?ZkpuMkE5eS9MMFVkbUgySmF2N2x1c0xPaHEvS0FFckZkWkZneUx4RzJLVWhq?=
 =?utf-8?B?bG95bnBLbFpDWjBNVllmZ1ozR3A5RlFTZDNOcFdCZ0kzU1ZxVG5ZVFRIQnNz?=
 =?utf-8?B?Z1AzMUVlNjFOYmszL2JLdHhYTGE4NGoxcDRNWllDc3RIb2NISUE4eHN3Z3Ex?=
 =?utf-8?B?V3BrNnlLcmxrek53bVN5RWZsTi9PQ005S2YvSnExQlZmODhQVVpKZXJDMXVn?=
 =?utf-8?B?SnhUS0ZEaXJZd01YKzd6c0VsRDdxSkVzMlppb0dudHNzRUxyRlY5L2ZhQXhu?=
 =?utf-8?B?Q3M3eVpzZlRSKzVEdGxDb2JMR3Voa2xMQ29mYWVBQmNibjRvRXFVZy9WajBy?=
 =?utf-8?B?TkIvWUVFa1VVV3FBY3VxL0lSTlh6MjB3VkNBWk9qaWhINy9McXNPeHFDUjNB?=
 =?utf-8?Q?oM4NawZPNxWadK3+Ao7LGdo9eFRwYD3s=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eFVRb25Ic3N2Z2lTTi9BZnluS2VIUFhzT1hpaTQ0RmRMR2lGQkhKdGppU29l?=
 =?utf-8?B?clVpZUVZclRnanI5QVdNeFdhazRrbTJ1Rk9ZMkF0MUtYVFFaZmcreHcwbXE3?=
 =?utf-8?B?VGx0VTFFNDUyditIeHJIYXBMRWFCT0kwM2gyK1NvVmQ1WVVLZTBUSTFKNnl4?=
 =?utf-8?B?bjkzUmJrSDJ3Q1dqbnlsSE9sT3hZc09CVTlITm1pN2JuOTJVUGFHN3ljanEx?=
 =?utf-8?B?a1hwWUFjQmtFWmtCWFdEdnN2Ym04ZzcxSnBLZ2JmODJYcm5BdDdhTVF4WnB2?=
 =?utf-8?B?MHJFUVRSa25EMldNNEpyWFpMakdwTDRQV3FGcXZ5OUg1U3Qzd0FiYnUzUU9J?=
 =?utf-8?B?UlE5ckZSTGVHdjJYRzQ3VmlPSmFkRC9RczB3ZGoyYXBaRlY1MzR6S25uTlBi?=
 =?utf-8?B?cm92MXp1RjFxSEwzVHg3T2VoenFNc3padE4rZFlhY3pmYUVUbGNIbStIUzQ2?=
 =?utf-8?B?WVJndE9lVlVWSk5OQnpUM001TGhFOTNGUkVycTdhVXNBYVpvYWg2UlZiaEN1?=
 =?utf-8?B?amh5WU50WkdrbVByd3NXZ3ltdmIrVnpjK01rTXp5S2ZuMHlYcUUyWDVnWG8y?=
 =?utf-8?B?am0wcTZ0VHdvT3l1M0VZU1lGSE5vaXE4eVkzSW1pMlAxbk1Jb1RMclMzV0dM?=
 =?utf-8?B?eEVLMDZ4VkJ6Q054dGlWRDdEb3V1cXI5elNZOTBxaHRmYUZCVWs2MVZRa0xE?=
 =?utf-8?B?VU9QeW1XZ0JTdDYyZEcvVXpaTUdxU21nbm1ESENtK1VOakh4dzhpSzJoWndV?=
 =?utf-8?B?Y0x6RnM1Yjl2YnQ3TkZtN3E4ajR2RUJHRitmZTNEclVLeWtyUWUvN0lYcFBL?=
 =?utf-8?B?dG9TQno1YUxScHVtVEw5WjdtTTlYanIvSVVsZ1pqSzUxMWxvK0pWcXBONk9I?=
 =?utf-8?B?engvcHR4T3YyTjcxSVFBclJWN0ZWeXZMWklMcmY1K00vOUpQVmVjQzlZYnhR?=
 =?utf-8?B?QzhNMVVKbHhMbmVDNGpidkd6T2tyOGozcHprL0VWbVBhSkwvbkhwdVRTWk52?=
 =?utf-8?B?UzNPOXhRU3dhTy9nSDRmRDN6NWJVU2NSNk8vWmd3VlhjRkVDalNqTGVaYms0?=
 =?utf-8?B?K2FFUm5aSnpRTEY2UWtGMDYzUTFVSm9vSG1Yd0NxVzVudHFxQjZsVC9aUm9U?=
 =?utf-8?B?c21lZHNPTFJDcVFjNzYycnJ3MHl4Rjh3TXI0WE5XNkRnb0I3NWJJWmdMdUti?=
 =?utf-8?B?UVYxRENrOTZyU2YwdXI5K0dMNlVSZXdkNkhHYkFMRVZhaGZXYkNBVlB2SmR1?=
 =?utf-8?B?OWpFUlBLMXlTeW4zMGUxMHJIZG9Tbm04bWlXSTRXa3RFeVFmcHBhdTVpTFkx?=
 =?utf-8?B?RDZ5RW5BbVV6RC8wR3RJanNSbUlhMklFaXFVTC9iNlVkZjFFMXh6cXp1ZVpu?=
 =?utf-8?B?dUlCRGJWaEtuSnBzNktnRSt4MVdETjNISmVJbHdRTW8yNSt1WW82ck9RUFA4?=
 =?utf-8?B?dzlTeEhzcmpxbkhTL2VPOUl4RFVBbWRLSzRLMlJpY2k1Z1NCTS9Rc3V4Z3Vz?=
 =?utf-8?B?QlJseVR4cXVXdzFzcTlZZGNxQjQzeCt3bW5TeXBFMi90MUVHaklVbndUYnpE?=
 =?utf-8?B?b2ROSXh0aTBVdENQcyt3U0pRZ0F1dGNmbG5xcmlhcGdBRHFpYnJGTWVyanUx?=
 =?utf-8?Q?jlwKtpG/bUFOXi5jlE3LL3Hyob2NZvgj6pro37y5FI/o=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9a330b-250d-4d3a-49e1-08dd5d9edf4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 17:38:28.8751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7970

RnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBT
ZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDI4LCAyMDI1IDQ6MzggUE0NCj4gDQo+IE9uIDIvMjYvMjAy
NSAzOjQzIFBNLCBTdGFuaXNsYXYgS2luc2J1cnNraWkgd3JvdGU6DQo+ID4gT24gV2VkLCBGZWIg
MjYsIDIwMjUgYXQgMDM6MDg6MDJQTSAtMDgwMCwgTnVubyBEYXMgTmV2ZXMgd3JvdGU6DQo+ID4+
IFRoaXMgd2lsbCBoYW5kbGUgU1lOSUMgaW50ZXJydXB0cyBzdWNoIGFzIGludGVyY2VwdHMsIGRv
b3JiZWxscywgYW5kDQo+ID4+IHNjaGVkdWxpbmcgbWVzc2FnZXMgaW50ZW5kZWQgZm9yIHRoZSBt
c2h2IGRyaXZlci4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogTnVubyBEYXMgTmV2ZXMgPG51
bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPg0KPiA+PiBSZXZpZXdlZC1ieTogV2VpIExp
dSA8d2VpLmxpdUBrZXJuZWwub3JnPg0KPiA+PiBSZXZpZXdlZC1ieTogVGlhbnl1IExhbiA8dGlh
bGFAbWljcm9zb2Z0LmNvbT4NCj4gPj4gLS0tDQo+ID4+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L21z
aHlwZXJ2LmMgfCA5ICsrKysrKysrKw0KPiA+PiAgZHJpdmVycy9odi9odl9jb21tb24uYyAgICAg
ICAgIHwgNSArKysrKw0KPiA+PiAgaW5jbHVkZS9hc20tZ2VuZXJpYy9tc2h5cGVydi5oIHwgMSAr
DQo+ID4+ICAzIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKykNCj4gPj4NCj4gPj4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbXNoeXBlcnYuYyBiL2FyY2gveDg2L2tlcm5l
bC9jcHUvbXNoeXBlcnYuYw0KPiA+PiBpbmRleCAwMTE2ZDBlOTZlZjkuLjYxNmU5YTVkNzdiNCAx
MDA2NDQNCj4gPj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9tc2h5cGVydi5jDQo+ID4+ICsr
KyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbXNoeXBlcnYuYw0KPiA+PiBAQCAtMTA3LDYgKzEwNyw3
IEBAIHZvaWQgaHZfc2V0X21zcih1bnNpZ25lZCBpbnQgcmVnLCB1NjQgdmFsdWUpDQo+ID4+ICB9
DQo+ID4+ICBFWFBPUlRfU1lNQk9MX0dQTChodl9zZXRfbXNyKTsNCj4gPj4NCj4gPj4gK3N0YXRp
YyB2b2lkICgqbXNodl9oYW5kbGVyKSh2b2lkKTsNCj4gPj4gIHN0YXRpYyB2b2lkICgqdm1idXNf
aGFuZGxlcikodm9pZCk7DQo+ID4+ICBzdGF0aWMgdm9pZCAoKmh2X3N0aW1lcjBfaGFuZGxlciko
dm9pZCk7DQo+ID4+ICBzdGF0aWMgdm9pZCAoKmh2X2tleGVjX2hhbmRsZXIpKHZvaWQpOw0KPiA+
PiBAQCAtMTE3LDYgKzExOCw5IEBAIERFRklORV9JRFRFTlRSWV9TWVNWRUMoc3lzdmVjX2h5cGVy
dl9jYWxsYmFjaykNCj4gPj4gIAlzdHJ1Y3QgcHRfcmVncyAqb2xkX3JlZ3MgPSBzZXRfaXJxX3Jl
Z3MocmVncyk7DQo+ID4+DQo+ID4+ICAJaW5jX2lycV9zdGF0KGlycV9odl9jYWxsYmFja19jb3Vu
dCk7DQo+ID4+ICsJaWYgKG1zaHZfaGFuZGxlcikNCj4gPj4gKwkJbXNodl9oYW5kbGVyKCk7DQo+
ID4NCj4gPiBDYW4gbXNodl9oYW5kbGVyIGJlIGRlZmluZWQgYXMgYSB3ZWFrIHN5bWJvbCBkb2lu
ZyBub3RoaW5nIGluc3RlYWQNCj4gPiBvZiBkZWZpbmluZyBpdCBhIG51bGwgcG9pbnRlcj8NCj4g
PiBUaGlzIHNob3VsZCBhbGxvdyB0byBzaW1wbGlmeSB0aGlzIGNvZGUgYW5kIGdldCByaWQgb2YN
Cj4gPiBodl9zZXR1cF9tc2h2X2hhbmRsZXIsIHdoaWNoIGxvb2tzIHJlZHVuZGFudC4NCj4gPg0K
PiBJbnRlcmVzdGluZywgSSB0ZXN0ZWQgdGhpcyBhbmQgaXQgZG9lcyBzZWVtcyB0byB3b3JrISBJ
dCBzZWVtcyBsaWtlDQo+IGEgZ29vZCBjaGFuZ2UsIHRoYW5rcy4NCg0KSnVzdCBiZSBhIGJpdCBj
YXJlZnVsLiBXaGVuIENPTkZJR19IWVBFUlY9biwgbXNoeXBlcnYuYyBzdGlsbCBnZXRzDQpidWls
dCBldmVuIHRocm91Z2ggbm9uZSBvZiB0aGUgb3RoZXIgSHlwZXItViByZWxhdGVkIGZpbGVzIGRv
LiAgVGhlcmUNCmFyZSAjaWZkZWYgQ09ORklHX0hZUEVSViBpbiBtc2h5cGVydi5jIHRvIGVsaW1p
bmF0ZSByZWZlcmVuY2VzIHRvDQpIeXBlci1WIGZpbGVzIHRoYXQgd291bGRuJ3QgYmUgYnVpbHQu
IEknZCBzdWdnZXN0IGRvaW5nIGEgdGVzdCBidWlsZCB3aXRoDQp0aGF0IGNvbmZpZ3VyYXRpb24g
dG8gbWFrZSBzdXJlIGl0J3MgYWxsIGNsZWFuLg0KDQpNaWNoYWVsDQoNCj4gDQo+ID4gUmV2aWV3
ZWQtYnk6IFN0YW5pc2xhdiBLaW5zYnVyc2tpaSA8c2tpbnNidXJza2lpQGxpbnV4Lm1pY3Jvc29m
dC5jb20+DQo+ID4NCj4gPj4gKw0KPiA+PiAgCWlmICh2bWJ1c19oYW5kbGVyKQ0KPiA+PiAgCQl2
bWJ1c19oYW5kbGVyKCk7DQo+ID4+DQo+ID4+IEBAIC0xMjYsNiArMTMwLDExIEBAIERFRklORV9J
RFRFTlRSWV9TWVNWRUMoc3lzdmVjX2h5cGVydl9jYWxsYmFjaykNCj4gPj4gIAlzZXRfaXJxX3Jl
Z3Mob2xkX3JlZ3MpOw0KPiA+PiAgfQ0KPiA+Pg0KPiA+PiArdm9pZCBodl9zZXR1cF9tc2h2X2hh
bmRsZXIodm9pZCAoKmhhbmRsZXIpKHZvaWQpKQ0KPiA+PiArew0KPiA+PiArCW1zaHZfaGFuZGxl
ciA9IGhhbmRsZXI7DQo+ID4+ICt9DQo+ID4+ICsNCj4gPj4gIHZvaWQgaHZfc2V0dXBfdm1idXNf
aGFuZGxlcih2b2lkICgqaGFuZGxlcikodm9pZCkpDQo+ID4+ICB7DQo+ID4+ICAJdm1idXNfaGFu
ZGxlciA9IGhhbmRsZXI7DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h2L2h2X2NvbW1vbi5j
IGIvZHJpdmVycy9odi9odl9jb21tb24uYw0KPiA+PiBpbmRleCAyNzYzY2I2ZDM2NzguLmY1YTA3
ZmQ5YTAzYiAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9odi9odl9jb21tb24uYw0KPiA+PiAr
KysgYi9kcml2ZXJzL2h2L2h2X2NvbW1vbi5jDQo+ID4+IEBAIC02NzcsNiArNjc3LDExIEBAIHZv
aWQgX193ZWFrIGh2X3JlbW92ZV92bWJ1c19oYW5kbGVyKHZvaWQpDQo+ID4+ICB9DQo+ID4+ICBF
WFBPUlRfU1lNQk9MX0dQTChodl9yZW1vdmVfdm1idXNfaGFuZGxlcik7DQo+ID4+DQo+ID4+ICt2
b2lkIF9fd2VhayBodl9zZXR1cF9tc2h2X2hhbmRsZXIodm9pZCAoKmhhbmRsZXIpKHZvaWQpKQ0K
PiA+PiArew0KPiA+PiArfQ0KPiA+PiArRVhQT1JUX1NZTUJPTF9HUEwoaHZfc2V0dXBfbXNodl9o
YW5kbGVyKTsNCj4gPj4gKw0KPiA+PiAgdm9pZCBfX3dlYWsgaHZfc2V0dXBfa2V4ZWNfaGFuZGxl
cih2b2lkICgqaGFuZGxlcikodm9pZCkpDQo+ID4+ICB7DQo+ID4+ICB9DQo+ID4+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2FzbS1nZW5lcmljL21zaHlwZXJ2LmggYi9pbmNsdWRlL2FzbS1nZW5lcmlj
L21zaHlwZXJ2LmgNCj4gPj4gaW5kZXggMWY0NmQxOWExNmFhLi5hMDVmMTJlNjNjY2QgMTAwNjQ0
DQo+ID4+IC0tLSBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvbXNoeXBlcnYuaA0KPiA+PiArKysgYi9p
bmNsdWRlL2FzbS1nZW5lcmljL21zaHlwZXJ2LmgNCj4gPj4gQEAgLTIwOCw2ICsyMDgsNyBAQCB2
b2lkIGh2X3NldHVwX2tleGVjX2hhbmRsZXIodm9pZCAoKmhhbmRsZXIpKHZvaWQpKTsNCj4gPj4g
IHZvaWQgaHZfcmVtb3ZlX2tleGVjX2hhbmRsZXIodm9pZCk7DQo+ID4+ICB2b2lkIGh2X3NldHVw
X2NyYXNoX2hhbmRsZXIodm9pZCAoKmhhbmRsZXIpKHN0cnVjdCBwdF9yZWdzICpyZWdzKSk7DQo+
ID4+ICB2b2lkIGh2X3JlbW92ZV9jcmFzaF9oYW5kbGVyKHZvaWQpOw0KPiA+PiArdm9pZCBodl9z
ZXR1cF9tc2h2X2hhbmRsZXIodm9pZCAoKmhhbmRsZXIpKHZvaWQpKTsNCj4gPj4NCj4gPj4gIGV4
dGVybiBpbnQgdm1idXNfaW50ZXJydXB0Ow0KPiA+PiAgZXh0ZXJuIGludCB2bWJ1c19pcnE7DQo+
ID4+IC0tDQo+ID4+IDIuMzQuMQ0KPiA+Pg0KDQo=

