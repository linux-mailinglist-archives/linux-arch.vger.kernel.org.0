Return-Path: <linux-arch+bounces-8980-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5539C45F9
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 20:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 797CCB21E35
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 19:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75941155391;
	Mon, 11 Nov 2024 19:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qLqDtmT2"
X-Original-To: linux-arch@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazolkn19013082.outbound.protection.outlook.com [52.103.2.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AE2139597;
	Mon, 11 Nov 2024 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731353799; cv=fail; b=bhjQtyKmiK+8QBomtsmAnf7ODX9QE06s/8r5wtrNHkTM179jIZNdp/JNBu9hXu4y8rdAA9Kk+RemmsdCB/TQLZ/Hz39rdpPXkhSAsjdCeo9VNOAkMWw5iaAmz/PQRFkw+km1eO7PFfWGXAuh9q3CVkyVM2Z7BpGustnxr8yEEmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731353799; c=relaxed/simple;
	bh=gkgANm/zjRqkND6vfG1zteI7h+PByiOZ5eKdvT5IYqU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ujx3y1CVGpMhcmBiRlrXKHb3RoeHqBAIVSZR01hobUfwgNrJOV10Cps2TDErjfjw75+ri8il+k8Usw0tvNIHr47yUTj555+F0wshBzZvLfgaYzdvXsyBMlPBtebScY445/XY7Jjd16YSOPFzYO8I14cDiKJi4eRBLcIs2EeAyPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qLqDtmT2; arc=fail smtp.client-ip=52.103.2.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlrDklBSLzuhKkwgUrD2LuoWpvg8nZ0t0iFYD2R46HePsB7hcP7HOrjKZZW/T8Nl30JGuBNzkN7fCm2QeHToHBEvq1JfXkLCN2NPsSLrJzIaIetuzqA9qXK0CDgr7hLGEClP7/nArWKgMCdcXAy7ex0VRgJ6hDQXLag8mh6kHeXs43gsdTy8bVT6FVrdt7cmwoUrYRSV7fPTSPn2+1IirnjWFrgd8P5UTFGiJkZl0bJ9Q21kV7iMRkeSWso1QoAJlCYe5YYMdBiMg8UDpyZYkPtsbFe7EyUooD17zRosocbS+vgrAVcD+Bl0oBeR1k2W/FezK9Kvi6X2Pp7/kah+Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkgANm/zjRqkND6vfG1zteI7h+PByiOZ5eKdvT5IYqU=;
 b=lTqvnKMoTDgQ22K3ZERe52OQixFotftHRQ6VXujU/6i3V/qyfsvwVcPEkl/U1QD/VDisKssPJzt6LnMd3qpaDbgD7VpiDAobnhwRuFerTnxIKgoz9+lwITOW3cpxBFFh2/RdoOpCezKQVDtHhmoJmHcxoxcrvEuRCey2YsVSk5gnlTIgDuL+6Avcn8D/RJ/3yDuQG9RGnuawkAhk+m5OuGKsyd/AGc9kC80o6xtdxE4n4ds6XdW4XFoVLPnH3lxauGYtZ6+bw1PdbCvcnGaBOHhhYK5Ztr7OoC9ZRE802EfKY2XjH7f2r1qnSe6WUPpuQGynNNZ6gVRMJycbqKHc7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkgANm/zjRqkND6vfG1zteI7h+PByiOZ5eKdvT5IYqU=;
 b=qLqDtmT2BMXm08WFXfwV/HJ+IWSh263+tyophKd+kiv2XeG+bAQl5m41Y4dVybLgdS8gOJWHb3ONIrCbDcvT4xZdXYPV4+ec8cgJCbdXRUnPhz4gjt3TJ7owRAcNwGoNMAQJNMUgHNrBvZoPUvGMKjxwFOVSpCMsSqsMqsAg914QCiRZmeCvZu1x04DEe01VrNPy+ipSF5b+lWm8buphMSZp0apLZkWSyxeTD2QTliNr8AFwiIqQCNNPnjfu7mksTtPoP0tZs3Cx/g435mNMT7plPGnmyqYo1MfDCuXVqm/GgQTBKJQ5mDyYiu/GCrLlK1IcfXMEE+4z4TqtnOdKCg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9930.namprd02.prod.outlook.com (2603:10b6:610:175::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 19:36:34 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 19:36:34 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"luto@kernel.org" <luto@kernel.org>, "tglx@linutronix.de"
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
	"mukeshrathor@microsoft.com" <mukeshrathor@microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "apais@linux.microsoft.com"
	<apais@linux.microsoft.com>
Subject: RE: [PATCH v2 0/4] Add new headers for Hyper-V Dom0
Thread-Topic: [PATCH v2 0/4] Add new headers for Hyper-V Dom0
Thread-Index: AQHbMWTyoKCBm8ky3ECkxBZdOyPiHbKvoZXAgALCjwCAABpmwA==
Date: Mon, 11 Nov 2024 19:36:34 +0000
Message-ID:
 <SN6PR02MB4157B020020EC4C77BB5893AD4582@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
 <BN7PR02MB41485DAD2E066D417FE12020D4582@BN7PR02MB4148.namprd02.prod.outlook.com>
 <8f0433ed-4d5a-4ec1-9552-86870419c79c@linux.microsoft.com>
In-Reply-To: <8f0433ed-4d5a-4ec1-9552-86870419c79c@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9930:EE_
x-ms-office365-filtering-correlation-id: a13b32c5-2295-425d-c180-08dd028826eb
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|19110799003|461199028|8060799006|15080799006|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?NHhLMER5TzJMdTNPbHVnWUxrSjNTUFBhaUZBa3FGNDczdzViUElKNERPNUxX?=
 =?utf-8?B?bHlzMjNIeHpzS2lvRTJnU2tGdk1SNmpDazBtRjNJN1ZIaVpiVmZ5c3EzbitE?=
 =?utf-8?B?b0M5RXY3Zjliek1kM2IxRHU2NEtaWHA3WnFoYnlYUjJJMGNFOSs1QUhGT1px?=
 =?utf-8?B?enhjcURCR0RmUG95MjZ3V0pCNjY4UmQxbnhBcGhmRXdjaUhpZzdSa1dDYk9x?=
 =?utf-8?B?SXpNeEpaWEZUOEVuUGtkMkJHam11eFlmNEFqNWN2MzVhdS8rVDlUTnIxMnNH?=
 =?utf-8?B?L3FTQlZDN0M3RWVkdGZHbDZDK3hYa0JiZzQrNnc4TllraVRtdnNROUJiR21M?=
 =?utf-8?B?OVRPL25vcGUwcG5EbmJsN2RUVCt2eGFyNUpYUU5makx2MFpzd3krV0dzdVBE?=
 =?utf-8?B?dnpWbkluRVhUTDcwWWtXUGcxSFU1elJhUDEwN0g3OFQveU1lVEZ4eEpHK2dj?=
 =?utf-8?B?Ui8rOFo4Z3lQTEVUS09IRHNQTXVoK2pKUjIxT2N1bFlQUEJMcllNY1VDY1hE?=
 =?utf-8?B?TzgveGlkRDg4RGhsS0kwUDkzVWRDNUhRTFEwMnR4QjVXVjcvMURXT1h1SGR4?=
 =?utf-8?B?cGplWUxWYnU4VGJZS2VUYkpFbkUyV09GN1BhVVB2ZCt5WFJNUWFESlczWWVW?=
 =?utf-8?B?UnFOVzFGR3M0NkMzNFdQNWx0bEN1RnhYL1hzM3BuSkVJcmhXSlJMVzVsNkYw?=
 =?utf-8?B?S0s3T0g5QURhQkdRekg3TzJGaTNyTm1JVXFBQlE5VkV5MWJ3bzN0S0ErbVVq?=
 =?utf-8?B?a2hGUEl0SVRvUUFNamMvRW5TSHVUQnZSZXFmWEhMM3N6S0hCNTlYQjZnN3FY?=
 =?utf-8?B?UTFrVEcvNlphZGtkZ0lFNFVrUFozb2hPTkVPeTk5bjdEKzFnUmpXc2luZGdr?=
 =?utf-8?B?dm9DU3VYRkVSRWg4c1A1K041K01OZ3JwYWpVL3pZbkdlQjlFZi9NcnhkOE9p?=
 =?utf-8?B?UThZd2gvU1JkVVQ3NjdBejhlYnQ3V1FCY0FOMk9kZHVUekxIUHlLS0ZPcXFl?=
 =?utf-8?B?NHIrSE5hZGNZTlRUeFFTbjFCQXFJWWNOdlQrT2RNTU1uMlM0WHRkMmxtM25R?=
 =?utf-8?B?YW1Uam5zNS96K09uR2xmRmZzbldaY0ZucVhlQUU3Z3h5cVNmc2RDdnRjZjJG?=
 =?utf-8?B?NDZvNUNBQ0t2KzFzNFRrWXQyckdNZVRQYXlUOFZyeUxIdWprWVlZR3RoQkE2?=
 =?utf-8?B?UEpJaFBFLy92d0ZWSjZZU2JuZVRKQlJuckltYkxjUlptREh5dUxYOTh0amJB?=
 =?utf-8?B?TS9FUE0veW4xZFZJS3pVaGRidEdxazVGVm1sZmR0Q09MVXBqQmJXejgyUlpy?=
 =?utf-8?Q?5EZWqTVfTRhQlgKUPPzxKsU2nm1p4cAQ1V?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkRLcWdERmFHZ2Z4dU1PYWhnWS9tREJ0TUdiTkRrYlROZFdFV2RIZVplamdG?=
 =?utf-8?B?VXoraFYzcXBWMEFVYTljWXdIMnE4SHhHWURSMk0yZTJDQ0VRVExrcDU1NUFK?=
 =?utf-8?B?Zi9CWkVtQUlEbitpblV4UTNZY0hhbTdmMVRvVmNoZHFoUEc0YmNpTndBU3Nn?=
 =?utf-8?B?K2xHYjF0bjgxSU9abWtuZU5leGNtek43Tko2aDIvdGJ5alZBMmdhaWczRXpt?=
 =?utf-8?B?cTJDYTZKR2JuSlVkeXRFVXZEaTY4ZHlrcUtQRFBDaUE0THNUL3pZdFFmcm94?=
 =?utf-8?B?TXN1OXhRa3kxY01DRFRsQXQ5RFZtZmdQQThPZVBaSGF0M2ZGSTVsRUsxMVpI?=
 =?utf-8?B?UkhCemV4MDgzMnFHRlpiZjNwMmh2RW5IbnRJNlQwYjhnMkZvUEZhSDJ2djE3?=
 =?utf-8?B?aVBWOXR6ZlI4K1RTcFJPb0lPTTZxS29US3dScTJOQnN4YVJnMnI5MDlxd0Fp?=
 =?utf-8?B?dmhlQ0t2Y3NWekZYOUFHNHhPZHpBUGtkMWUzTVVyNFpZNWwzdEhQVHRLWjk3?=
 =?utf-8?B?Ryt3ZlYzTHRqMW5xWks3ZzUvencvcG9rbmxEVUJVS2RxVnAxclM3VTdrVTJB?=
 =?utf-8?B?Y0pUVWhwakt1eXdJV3VXcDd5dXpVbzlQWHpXaHk5cURJV0JqdTY3Z21ZUy8w?=
 =?utf-8?B?QkIzVUtRWjA0eng5UGFLVzdSazRyY1dRTmxiRmNGL2JQcDdudWdpK3A1V2pl?=
 =?utf-8?B?V1Y2MFdrbjEzVStVVTJyelJHeDFzQnloU3BiU29iUnBLc3A3RzlOZmduMFND?=
 =?utf-8?B?NHFMZTlwbFR2VEkwWE9pck5TdHZrNzlCYXlnVFhQMHVVcHVjNGp3YlUzWFNF?=
 =?utf-8?B?NnVjOXk2by96ZzdFaHAxdER3ME13c1F5VmtEV2dxaG1FYWEvdE9XaHdXUWF4?=
 =?utf-8?B?amkvVmdaT3kzZlVqWUswakJCQ1QzTllNcnZWMkxIdkFOSnVpNG5MOTU4U1Fu?=
 =?utf-8?B?Y096Z29VcE5GV3VWU2ZFQ3lXMUswamVxMkpZcEFqWGFGVThaMUtBYmpFbDVM?=
 =?utf-8?B?bUhCK0o1ZlZsRmgzaFBhQXpwNjFwUG5iSkVaaXErKzBIN1FJcmo5WURqeW9y?=
 =?utf-8?B?cEJ5dnhLcU1XZjVFemtmWG94T2RJNG9vbFlUYUpCR3BhbnFjWFpZSlZPQ1kv?=
 =?utf-8?B?Z3VMZTVMOC9KVXFRTFpSQTlaZ0lTOWxHM0hTOUkzTER1UlN0M2txeW9VZnNj?=
 =?utf-8?B?VzBuRFI1YkdiM2lhYnVkSzAwUm9OMzZ2WUlTMHkrL0hHcHhFWEhFZzRUeFZW?=
 =?utf-8?B?N0I2TWppWmo3TXR3UVdBVklBYWtMa3h6a2NZWnVRS2szdWlUV2hkekxjL2hF?=
 =?utf-8?B?QWdWRGZwcGh1dnFPMTR3K0hobFovaEZmSFNKcG8zNmQzRm1QWlJSeGdvNTVI?=
 =?utf-8?B?bGJZUHRuRDFqSFAzVGZKakxoZjNVdkFqYXdERkFIUGxocDkvOXBSellqR2hl?=
 =?utf-8?B?YXJqdVpBYVpvYUY4R2NKTUNNOEFyZ0c5dTBCQ1NyU0dNVVFJWU5oaGhDaUhj?=
 =?utf-8?B?cWZ0Rmt4M0tZWS9SRjB5a1lDdUZ2a3JOa1pPWWQ5MFdiZ0R6SDZuYmVJaTVE?=
 =?utf-8?B?cmRrZWFZbTUyejdPZTBpdlpqb0pmU3BIMmxYeDFJRjYvZmRKRXBzSGtYeDBx?=
 =?utf-8?Q?CvrfmX8dUfDtMfGZkFhEkDOWXXzRkm/AT6PeSFyclrbs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a13b32c5-2295-425d-c180-08dd028826eb
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 19:36:34.7761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9930

RnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBT
ZW50OiBNb25kYXksIE5vdmVtYmVyIDExLCAyMDI0IDEwOjAwIEFNDQo+IA0KPiBPbiAxMS8xMC8y
MDI0IDg6MTIgUE0sIE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+IEZyb206IE51bm8gRGFzIE5l
dmVzIDxudW5vZGFzbmV2ZXNAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogVGh1cnNkYXksIE5v
dmVtYmVyIDcsIDIwMjQgMjozMiBQTQ0KPiA+Pg0KPiA+PiBUbyBzdXBwb3J0IEh5cGVyLVYgRG9t
MCAoYWthIExpbnV4IGFzIHJvb3QgcGFydGl0aW9uKSwgbWFueSBuZXcNCj4gPj4gZGVmaW5pdGlv
bnMgYXJlIHJlcXVpcmVkLg0KPiA+DQo+ID4gVXNpbmcgImRvbTAiIHRlcm1pbm9sb2d5IGhlcmUg
YW5kIGluIHRoZSBTdWJqZWN0OiBsaW5lIGlzIGxpa2VseSB0bw0KPiA+IGJlIGNvbmZ1c2luZyB0
byBmb2xrcyB3aG8gYXJlbid0IGludGltYXRlbHkgaW52b2x2ZWQgaW4gSHlwZXItViB3b3JrLg0K
PiA+IFByZXZpb3VzIExpbnV4IGtlcm5lbCBjb21taXQgbWVzc2FnZXMgYW5kIGNvZGUgZm9yIHJ1
bm5pbmcgaW4gdGhlDQo+ID4gSHlwZXItViByb290IHBhcnRpdGlvbiB1c2UgInJvb3QgcGFydGl0
aW9uIiB0ZXJtaW5vbG9neSwgYW5kIEkgY291bGRuJ3QNCj4gPiBmaW5kICJkb20wIiBoYXZpbmcg
YmVlbiB1c2VkIGJlZm9yZS4gInJvb3QgcGFydGl0aW9uIiB3b3VsZCBiZSBtb3JlDQo+ID4gY29u
c2lzdGVudCwgYW5kIGl0IGFsc28gbWF0Y2hlcyB0aGUgcHVibGljIGRvY3VtZW50YXRpb24gZm9y
IEh5cGVyLVYuDQo+ID4gImRvbTAiIGlzIFhlbiBzcGVjaWZpYyB0ZXJtaW5vbG9neSwgYW5kIGhh
dmluZyBpdCBzaG93IHVwIGluIEh5cGVyLVYNCj4gPiBwYXRjaGVzIHdvdWxkIGJlIGNvbmZ1c2lu
ZyBmb3IgdGhlIGNhc3VhbCByZWFkZXIuIEkga25vdyAiZG9tMCIgaGFzDQo+ID4gYmVlbiB1c2Vk
IGludGVybmFsbHkgYXQgTWljcm9zb2Z0IGFzIHNob3J0aGFuZCBmb3IgIkh5cGVyLVYgcm9vdA0K
PiA+IHBhcnRpdGlvbiIsIGJ1dCBpdCdzIHByb2JhYmx5IGJlc3QgdG8gY29tcGxldGVseSBhdm9p
ZCBzdWNoIHNob3J0aGFuZA0KPiA+IGluIHB1YmxpYyBMaW51eCBrZXJuZWwgcGF0Y2hlcyBhbmQg
Y29kZS4NCj4gPg0KPiA+IEp1c3QgbXkgJC4wMiAuLi4uDQo+ID4NCj4gDQo+IE5vdGVkIC0gSSB3
aWxsIHVwZGF0ZSB0aGUgdGVybWlub2xvZ3kgaW4gdjMgYW5kIGdlbmVyYWxseSBhdm9pZCAiRG9t
MCIsDQo+IGV4Y2VwdCBwb3NzaWJseSBieSB3YXkgb2YgZXhwbGFuYXRpb24gKGkuZS4gdG8gY29t
cGFyZSBpdCB0byBYZW4gRG9tMCkuDQoNClllcywgSSdtIGdvb2Qgd2l0aCBjb21wYXJpbmcgdGhl
IEh5cGVyLVYgcm9vdCBwYXJ0aXRpb24gdG8gWGVuIGRvbTAgYXMNCnBhcnQgb2YgYW4gZXhwbGFu
YXRpb24uDQoNCk1pY2hhZWwNCg0KPiANCj4gVGhhbmtzDQo+IE51bm8NCj4gDQo+ID4+DQo+ID4+
IFRoZSBwbGFuIGdvaW5nIGZvcndhcmQgaXMgdG8gZGlyZWN0bHkgaW1wb3J0IGRlZmluaXRpb25z
IGZyb20NCj4gPj4gSHlwZXItViBjb2RlIHdpdGhvdXQgd2FpdGluZyBmb3IgdGhlbSB0byBsYW5k
IGluIHRoZSBUTEZTIGRvY3VtZW50Lg0KPiA+PiBUaGlzIGlzIGEgcXVpY2tlciBhbmQgbW9yZSBt
YWludGFpbmFibGUgd2F5IHRvIGltcG9ydCBkZWZpbml0aW9ucywNCj4gPj4gYW5kIGlzIGEgc3Rl
cCB0b3dhcmQgdGhlIGV2ZW50dWFsIGdvYWwgb2YgZXhwb3J0aW5nIGhlYWRlcnMgZGlyZWN0bHkN
Cj4gPj4gZnJvbSBIeXBlci1WIGZvciB1c2UgaW4gTGludXguDQo+ID4+DQo+ID4+IFRoaXMgcGF0
Y2ggc2VyaWVzIGludHJvZHVjZXMgbmV3IGhlYWRlcnMgKGh2aGRrLmgsIGh2Z2RrLmgsIGV0YywN
Cj4gPj4gc2VlIHBhdGNoICMzKSBkZXJpdmVkIGRpcmVjdGx5IGZyb20gSHlwZXItViBjb2RlLiBo
eXBlcnYtdGxmcy5oIGlzDQo+ID4+IHJlcGxhY2VkIHdpdGggaHZoZGsuaCAod2hpY2ggaW5jbHVk
ZXMgdGhlIG90aGVyIG5ldyBoZWFkZXJzKQ0KPiA+PiBldmVyeXdoZXJlLg0KPiA+Pg0KPiA+PiBO
byBmdW5jdGlvbmFsIGNoYW5nZSBpcyBleHBlY3RlZC4NCj4gPj4NCj4gPj4gU3VtbWFyeToNCj4g
Pj4gUGF0Y2ggMS0yOiBNaW5vciBjbGVhbnVwIHBhdGNoZXMNCj4gPj4gUGF0Y2ggMzogQWRkIHRo
ZSBuZXcgaGVhZGVycyAoaHZoZGsuaCwgZXRjLi4pIGluIGluY2x1ZGUvaHlwZXJ2Lw0KPiA+PiBQ
YXRjaCA0OiBTd2l0Y2ggdG8gdGhlIG5ldyBoZWFkZXJzDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYt
Ynk6IE51bm8gRGFzIE5ldmVzIDxudW5vZGFzbmV2ZXNAbGludXgubWljcm9zb2Z0LmNvbT4NCj4g
Pj4gLS0tDQo+ID4+IENoYW5nZWxvZzoNCj4gPj4gdjI6DQo+ID4+IC0gUmV3b3JrIHRoZSBzZXJp
ZXMgdG8gc2ltcGx5IHVzZSB0aGUgbmV3IGhlYWRlcnMgZXZlcnl3aGVyZQ0KPiA+PiAgIGluc3Rl
YWQgb2YgZmlkZGxpbmcgYXJvdW5kIHRvIGtlZXAgaHlwZXJ2LXRsZnMuaCB1c2VkIGluIHNvbWUN
Cj4gPj4gICBwbGFjZXMsIHN1Z2dlc3RlZCBieSBNaWNoYWVsIEtlbGxleSBhbmQgRWFzd2FyIEhh
cmloYXJhbg0KPiA+DQo+ID4gVGhhbmtzISBUaGF0IHNob3VsZCBiZSBzaW1wbGVyIGFsbCBhcm91
bmQuDQo+ID4NCj4gPiBNaWNoYWVsDQo+ID4NCj4gPj4gLSBGaXggY29tcGlsYXRpb24gZXJyb3Jz
IHdpdGggc29tZSBjb25maWdzIGJ5IGFkZGluZyBtaXNzaW5nDQo+ID4+ICAgZGVmaW5pdGlvbnMg
YW5kIGNoYW5naW5nIHNvbWUgbmFtZXMsIHRoYW5rcyB0byBTaW1vbiBIb3JtYW4gZm9yDQo+ID4+
ICAgY2F0Y2hpbmcgdGhvc2UNCj4gPj4gLSBBZGQgYWRkaXRpb25hbCBkZWZpbml0aW9ucyB0byB0
aGUgbmV3IGhlYWRlcnMgdG8gc3VwcG9ydCB0aGVtIG5vdw0KPiA+PiAgIHJlcGxhY2luZyBoeXBl
cnYtdGxmcy5oIGV2ZXJ5d2hlcmUNCj4gPj4gLSBBZGQgYWRkaXRpb25hbCBjb250ZXh0IGluIHRo
ZSBjb21taXQgbWVzc2FnZXMgZm9yIHBhdGNoZXMgIzMgYW5kICM0DQo+ID4+IC0gSW4gcGF0Y2gg
IzIsIGRvbid0IHJlbW92ZSBpbmRpcmVjdCBpbmNsdWRlcy4gT25seSByZW1vdmUgaW5jbHVkZXMN
Cj4gPj4gICB3aGljaCB0cnVseSBhcmVuJ3QgdXNlZCwgc3VnZ2VzdGVkIGJ5IE1pY2hhZWwgS2Vs
bGV5DQo+ID4+DQo+ID4+IC0tLQ0KPiA+PiBOdW5vIERhcyBOZXZlcyAoNCk6DQo+ID4+ICAgaHlw
ZXJ2OiBNb3ZlIGh2X2Nvbm5lY3Rpb25faWQgdG8gaHlwZXJ2LXRsZnMuaA0KPiA+PiAgIGh5cGVy
djogQ2xlYW4gdXAgdW5uZWNlc3NhcnkgI2luY2x1ZGVzDQo+ID4+ICAgaHlwZXJ2OiBBZGQgbmV3
IEh5cGVyLVYgaGVhZGVycyBpbiBpbmNsdWRlL2h5cGVydg0KPiA+PiAgIGh5cGVydjogU3dpdGNo
IGZyb20gaHlwZXJ2LXRsZnMuaCB0byBoeXBlcnYvaHZoZGsuaA0KPiA+Pg0KPiA+PiAgYXJjaC9h
cm02NC9oeXBlcnYvaHZfY29yZS5jICAgICAgICB8ICAgIDMgKy0NCj4gPj4gIGFyY2gvYXJtNjQv
aHlwZXJ2L21zaHlwZXJ2LmMgICAgICAgfCAgICA0ICstDQo+ID4+ICBhcmNoL2FybTY0L2luY2x1
ZGUvYXNtL21zaHlwZXJ2LmggIHwgICAgMiArLQ0KPiA+PiAgYXJjaC94ODYvaHlwZXJ2L2h2X2Fw
aWMuYyAgICAgICAgICB8ICAgIDEgLQ0KPiA+PiAgYXJjaC94ODYvaHlwZXJ2L2h2X2luaXQuYyAg
ICAgICAgICB8ICAgMjEgKy0NCj4gPj4gIGFyY2gveDg2L2h5cGVydi9odl9wcm9jLmMgICAgICAg
ICAgfCAgICAzICstDQo+ID4+ICBhcmNoL3g4Ni9oeXBlcnYvaXZtLmMgICAgICAgICAgICAgIHwg
ICAgMSAtDQo+ID4+ICBhcmNoL3g4Ni9oeXBlcnYvbW11LmMgICAgICAgICAgICAgIHwgICAgMSAt
DQo+ID4+ICBhcmNoL3g4Ni9oeXBlcnYvbmVzdGVkLmMgICAgICAgICAgIHwgICAgMiArLQ0KPiA+
PiAgYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCAgICB8ICAgIDMgKy0NCj4gPj4gIGFy
Y2gveDg2L2luY2x1ZGUvYXNtL21zaHlwZXJ2LmggICAgfCAgICAzICstDQo+ID4+ICBhcmNoL3g4
Ni9pbmNsdWRlL2FzbS9zdm0uaCAgICAgICAgIHwgICAgMiArLQ0KPiA+PiAgYXJjaC94ODYva2Vy
bmVsL2NwdS9tc2h5cGVydi5jICAgICB8ICAgIDIgKy0NCj4gPj4gIGFyY2gveDg2L2t2bS92bXgv
aHlwZXJ2X2V2bWNzLmggICAgfCAgICAyICstDQo+ID4+ICBhcmNoL3g4Ni9rdm0vdm14L3ZteF9v
bmh5cGVydi5oICAgIHwgICAgMiArLQ0KPiA+PiAgYXJjaC94ODYvbW0vcGF0L3NldF9tZW1vcnku
YyAgICAgICB8ICAgIDIgLQ0KPiA+PiAgZHJpdmVycy9jbG9ja3NvdXJjZS9oeXBlcnZfdGltZXIu
YyB8ICAgIDIgKy0NCj4gPj4gIGRyaXZlcnMvaHYvaHZfYmFsbG9vbi5jICAgICAgICAgICAgfCAg
ICA0ICstDQo+ID4+ICBkcml2ZXJzL2h2L2h2X2NvbW1vbi5jICAgICAgICAgICAgIHwgICAgMiAr
LQ0KPiA+PiAgZHJpdmVycy9odi9odl9rdnAuYyAgICAgICAgICAgICAgICB8ICAgIDIgKy0NCj4g
Pj4gIGRyaXZlcnMvaHYvaHZfc25hcHNob3QuYyAgICAgICAgICAgfCAgICAyICstDQo+ID4+ICBk
cml2ZXJzL2h2L2h5cGVydl92bWJ1cy5oICAgICAgICAgIHwgICAgMiArLQ0KPiA+PiAgaW5jbHVk
ZS9hc20tZ2VuZXJpYy9oeXBlcnYtdGxmcy5oICB8ICAgIDkgKw0KPiA+PiAgaW5jbHVkZS9hc20t
Z2VuZXJpYy9tc2h5cGVydi5oICAgICB8ICAgIDIgKy0NCj4gPj4gIGluY2x1ZGUvY2xvY2tzb3Vy
Y2UvaHlwZXJ2X3RpbWVyLmggfCAgICAyICstDQo+ID4+ICBpbmNsdWRlL2h5cGVydi9odmdkay5o
ICAgICAgICAgICAgIHwgIDMwMyArKysrKysrDQo+ID4+ICBpbmNsdWRlL2h5cGVydi9odmdka19l
eHQuaCAgICAgICAgIHwgICA0NiArDQo+ID4+ICBpbmNsdWRlL2h5cGVydi9odmdka19taW5pLmgg
ICAgICAgIHwgMTI5NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4+ICBpbmNsdWRl
L2h5cGVydi9odmhkay5oICAgICAgICAgICAgIHwgIDczMyArKysrKysrKysrKysrKysrDQo+ID4+
ICBpbmNsdWRlL2h5cGVydi9odmhka19taW5pLmggICAgICAgIHwgIDMxMCArKysrKysrDQo+ID4+
ICBpbmNsdWRlL2xpbnV4L2h5cGVydi5oICAgICAgICAgICAgIHwgICAxMSArLQ0KPiA+PiAgbmV0
L3Ztd192c29jay9oeXBlcnZfdHJhbnNwb3J0LmMgICB8ICAgIDIgKy0NCj4gPj4gIDMyIGZpbGVz
IGNoYW5nZWQsIDI3MjkgaW5zZXJ0aW9ucygrKSwgNTIgZGVsZXRpb25zKC0pDQo+ID4+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9oeXBlcnYvaHZnZGsuaA0KPiA+PiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGluY2x1ZGUvaHlwZXJ2L2h2Z2RrX2V4dC5oDQo+ID4+ICBjcmVhdGUgbW9kZSAxMDA2
NDQgaW5jbHVkZS9oeXBlcnYvaHZnZGtfbWluaS5oDQo+ID4+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
aW5jbHVkZS9oeXBlcnYvaHZoZGsuaA0KPiA+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUv
aHlwZXJ2L2h2aGRrX21pbmkuaA0KPiA+Pg0KPiA+PiAtLQ0KPiA+PiAyLjM0LjENCg0K

