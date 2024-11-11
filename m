Return-Path: <linux-arch+bounces-9026-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8059C4A05
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 00:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D85A0B2A24F
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 23:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A976C1BE87E;
	Mon, 11 Nov 2024 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DIssVUJx"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2078.outbound.protection.outlook.com [40.92.21.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33CC1BD9E4;
	Mon, 11 Nov 2024 23:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368477; cv=fail; b=AwCYt5Tl2uCZojHVzGLBF4nVPjAf2kCyySnHS4V6Y5DBNbN4DqGYygOuZicI2p50fBjzfv5UUwwUC0BsPayYciRgMxMqEo+jP6Un1H8YPCqSF2icMqLR61g2NX3F3Coe3DHgezeOZtrvTkz0b5extSm/NuIesdVX1HD/y36b1fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368477; c=relaxed/simple;
	bh=EHOICI5KtvKYhtIAv07IYyIM2iJ87EqgcdSPB+1rVfk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qyw6Q++N3l+KaA7FetCNos7IxbGHJ/W7M8gcLXlSS/DwM1nuM4VYKwuCIfv6bnfCQLppEOBwH0QjUMEMNPFyZzqtRvU59ton3UeSE1Ca1KTPnHHGtZ3jIlPQ5iXDpPbg8PsApmBJ7/HOlhp63EPbNmgCkUAUQs9QF9ZosTB5xeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DIssVUJx; arc=fail smtp.client-ip=40.92.21.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpwnC1I08lMIIU9Au2/A45214YCndW29YILAB11ZjG+sE5CjUzxREpibQDVECTwSzvETHfGD9vNGq/EarLBb7I+GOR/YuJdkW0ktV5qykgelwkh8I8UqDfLkSh7qh53dOOYqu15E6AAKuSkEVXXtzsqfawgPBdZcJEQkQcqE0oFD9J4m0HPJKYtDHzKkl7H8r0kD2Le23hei2ayyCkFcXcTAxvreiBo1Dj0+zeSESbIfiDmE7JQrNaPJ+d5GHntQXEVo3IoKxJvCsJBQcPTqGnG/dg/8kOYhxaYa837yy2gyniVTUQ7pBe7ba7U5ehbqlX4IaTd8DPzxwIMEIjuIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHOICI5KtvKYhtIAv07IYyIM2iJ87EqgcdSPB+1rVfk=;
 b=BU1e4Ee9Dsx1DvnFIL648nk8GncwrjJlhlh1jqFQblM2tWkFN9CeCPuqMiS2iVQ+keK8+Ltl5G2QxCB5+AKlQRE6APmspOPmZdM9woBSZwSLDlVa2EumXFOKp5gLp0vVok5bCrMH1yM/ROEucbOyP4j0YB10/TYqqFsnLG04twPEx4nf6uNsXNqJ4fVppMk0X+Q25J7j4bhmFjOR66/gYwm+CUZNpeeDLGVVfhT8NYTBYlMXpHcSOnl5cvmGxeq1DjRXAZhYEgys3GFslUlaEBO+ZryFniOFhRf1Mlpl4jGcw8+Vsfetu2KXv4zQRHYbrdwv8qu7WTQG5cBSxdOtHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHOICI5KtvKYhtIAv07IYyIM2iJ87EqgcdSPB+1rVfk=;
 b=DIssVUJxaG94gnckM1POCwr57pYWiuHWkd1h4+E+8vznzubWSI4tusmAz29AmzQaDdKSs2FTdAAkfd6z61mHNsVGxOOKMKF/q9hC7HfOJG2HuyJiTAceG2zynozScWG5rNE6Q0g9QU6A9fBRtG0h50DXqI2uvfwESRse0s0e0+rBq3/sM7LI1DwXPZjTamk8osFi3SHIjxfaMTHMtrPI7JrPxERw2+/eRkIKmmorsenGdotcQvYXB+7bfbtXRal9azPC3DMr7kuGJ7TfO9JMbakc1gRgBHEm5e3ccDo0Z4YXERbTP714WReX2Y9mWs/d2KAJRCqcdE0ZdfTzlbQ6mg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN6PR02MB10725.namprd02.prod.outlook.com (2603:10b6:208:500::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 23:41:11 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 23:41:11 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: MUKESH RATHOR <mukeshrathor@microsoft.com>, Nuno Das Neves
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
Subject: RE: [EXTERNAL] RE: [PATCH v2 0/4] Add new headers for Hyper-V Dom0
Thread-Topic: [EXTERNAL] RE: [PATCH v2 0/4] Add new headers for Hyper-V Dom0
Thread-Index: AQHbMWTyoKCBm8ky3ECkxBZdOyPiHbKvoZXAgALRb4CAACazIIAAIVEAgAAFX6A=
Date: Mon, 11 Nov 2024 23:41:10 +0000
Message-ID:
 <SN6PR02MB41573712E9625DACE6A1793ED4582@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
 <BN7PR02MB41485DAD2E066D417FE12020D4582@BN7PR02MB4148.namprd02.prod.outlook.com>
 <b4a46acc-f4bb-81db-fcc1-29c55dc7724f@microsoft.com>
 <SN6PR02MB415747D0DB0879729E6D7D03D4582@SN6PR02MB4157.namprd02.prod.outlook.com>
 <8abdc84b-1ee5-bf19-c65e-82f9293d5c84@microsoft.com>
In-Reply-To: <8abdc84b-1ee5-bf19-c65e-82f9293d5c84@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN6PR02MB10725:EE_
x-ms-office365-filtering-correlation-id: ec1c9e2a-c33c-4679-78c4-08dd02aa5299
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|8060799006|461199028|19110799003|15080799006|440099028|3412199025|102099032|56899033;
x-microsoft-antispam-message-info:
 =?utf-8?B?cDl3WEx4TW9DdWpuUEF4TFB1bm00ajkyWkxnako5b3lJOGw1SGs3VU9NdTVC?=
 =?utf-8?B?MGJ0VXlPTEoyR0dueHZxRklFSmFUQXNuU0JRZlBIYURVT0QwdEhJVVI0WkJL?=
 =?utf-8?B?SUdtYWdPZ0pBZDhrRnZuQy8rczdtWEk0MEp0Wno0U3doSmxTMDdiTDBWMllV?=
 =?utf-8?B?YnpYSWttUFJSalM2MHRVM1lFZ2hYNVZ0djd3MFBDdUdlQ1I4NGxZUWJkUFF2?=
 =?utf-8?B?T3JPS0FSWWNwUEIyV1lCTmtuYUZKMnFDSzNYSEJBYzM5Mm8yNE5NTHlHZzBW?=
 =?utf-8?B?L3dFa0NRbkZkL3NicnNLcHRmcC9ZUEZjQWlSQWsyUjVRRDdFMytMMTN3dXBQ?=
 =?utf-8?B?d3dpVmtoUmIzSDczaHdjV0lLVERoOUx2bWlPMnlmR09lalpUK1ZXQnVZdzlY?=
 =?utf-8?B?WnBRUSs4ZTNtSWVSclBSR3VDMmNNWEZReUFoTDl2b2IxMVFKMFFTZEJBNFFK?=
 =?utf-8?B?eGN0d1BBa0pMUU9aTGxMZVB4SnBuRmJtYjJKRi81NDEzQWU5dXQyZUY3bEMx?=
 =?utf-8?B?VUdUQmdaZE1ZVVNUdFZlWHE2Wlo4VVAxSXN2Y0UxR01nVXpCU1JXeDlOb3A4?=
 =?utf-8?B?enFsdWg3QXU4K2N2SXJrbnRmaFVnbDhDRnNjMVh0RVAvSkJ0T09XV2txaTJt?=
 =?utf-8?B?bU9RWEJEUGdYS2t3NHMzaHVueXZlWmkyVWVqN0JzOWNqUzBWRGxUdlRJRDYy?=
 =?utf-8?B?RnMvN1ZXVDVqZEN6VGJ1aS9ZODh6Ri9CU2RWczdUbGNLcGk3MlozWlJUMDFU?=
 =?utf-8?B?UjY4ZXE0WnVwV2FVdTlObmRHVC9sSGh6RlBod2xXSzFjSlI2cDFNdlBUSTFU?=
 =?utf-8?B?c0J0dGJYVGYxamZXNG5LU0l5VkJxbC9UVTFrY3RhSHBJbWRibkpSMjh4U0ZO?=
 =?utf-8?B?MjFmdVhYdE5sdDk2WHYrdm9rd2lSVXBBOEhWN085aXhuRVgxYUUzTjR6SlR0?=
 =?utf-8?B?RG1UU29PN2h1SHdlaCt3ZjRGVmx1VmdvS2d5RGZTcVZRdDBRNlJieFFiZXZx?=
 =?utf-8?B?NlZqNFY2eEhnaTdrQ0RLd0QxSXg5Qjl4SGUxWEw1bStDZzB5UWpBek9jaFJq?=
 =?utf-8?B?UW5lWHhqV2gvWWhkL25xZXNqS2JlNmd3MUVrSTNTbFU2RXNEVnBhZHlzRmt6?=
 =?utf-8?B?clFCM3FCd3NZRnRhdFhkZi9UaWRvYTNDb2swL2ZLMWpZSHlQMmVWR28zNjRx?=
 =?utf-8?B?R2lCajJ5ZHB0eVlpM2VJeTcvTnpRUmEzSnE4YTBwRzNWV1pYUVR2R0tUZFdp?=
 =?utf-8?B?ZXRzOXlCcmlwTXB5Q3JaRWp6V0l5SmRwTUNVWUVkU0QvS2RIbHo2TUx5ZWtJ?=
 =?utf-8?B?Tlk3aXd1UkdLTFNkUkhFQUhyRHdsQ3RNaWRqQlM3SWRVb1U3eHQxOXkwVFkr?=
 =?utf-8?B?YmlobkJmc1prblE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDdJODBjcXdDcjB3em90TWprWlYrZWhQTWdYTFlLWHh1cnFvNUNMNFgwRHMr?=
 =?utf-8?B?WlJXamNOMEp0TFhIbnFzNkp1YUN5M1ZCMjNHR09EWTN5cmxUUVh2ZjQvUkNN?=
 =?utf-8?B?aElXNG5veU9QVlFzUzEyZ1BVc0lTN0xoYUhDTHExQm1RMnBPZ1pwOTdsZjJE?=
 =?utf-8?B?RG1VbUpZeFpFd3ltanNBdTVTR1BwREsyUCtQZ2hRV3ZCVktYMlp3Um1HY0ZZ?=
 =?utf-8?B?SUNEWkxhSUkvMHczZjNlYXBxMnZsa3gxbGZKcFdSeDVNZTdlV0cvL2NMS01R?=
 =?utf-8?B?Q3Y0MGV3cGszV2VUV2x5NWU1RTJPN3JrQUdEak1MUGVkRGFWMlBPejRlNkZ2?=
 =?utf-8?B?bk9hbjFyT3hNWEltNVE2Z3VsN0d0Sk43Z25idVVJdFdWTkNvT21veFpjOEhI?=
 =?utf-8?B?UnBjK3lBUFo5NXdsMUZ1MEJsMFpIMktVejVsU3NWbWMrbWZuWSt1UkVHamtz?=
 =?utf-8?B?YVZZVkZOQWhYL09UM2VQYjg0UEk1MjZlSkJrZE43UUdUZGlNSktVb05POUxk?=
 =?utf-8?B?QjFITzZ0dWYrSmp1ZGNyNmJZR1puSjVoc3ZCUzlSMEZUN0JwQm44dERhOEVN?=
 =?utf-8?B?WjVRTFVZVTVYWmh5Y1Z3Mk9lOWJidk12V2gvaE5VSEo4a0JIRWdNOEpUQUhi?=
 =?utf-8?B?bTFxZ1FZY2dEbUV4bTVVRjF4QjU0SkFSb2FBbzRHbmtoTXR0QkRQUDFWSmRY?=
 =?utf-8?B?NlppOVhJeVhncGJIS0NNcHBXTGk4cnI4amxxaHF1SDkrWi9LeDlkNVFjQmlx?=
 =?utf-8?B?ZXdzalJDY3BsRTU1Z05tOGdPRnN4anJwakt1eWViTTVTcHk0ZFFURGkrSkhW?=
 =?utf-8?B?Z1k3WTJTRHpSTXprVHlPTVE4bnU4dlNaYzRBYlFYeHNXaXN0TDZvaXUvalNy?=
 =?utf-8?B?dEVyMGhKTzhkOEJZTC9jZU04bGVPTHlBdHk2WGd0eTdUR3VjTi93VDVIOEQ4?=
 =?utf-8?B?elhla0NGU3hUZzhHYzBJOGlmY2tjMDBCcDVDM3RZK2hVdTUwb2tKY0xUblNE?=
 =?utf-8?B?YVdGaHFXVjNXYmhsOWpNUUg2eGlQRW5Qd0dtcGRhcmxZM2Q0TkxmR0R6a2NC?=
 =?utf-8?B?RitjWjIwazR2bFpTTWhrODU0cGJTeFFEODlvZmdlYnI5MTN1UW9ZanhpR01S?=
 =?utf-8?B?NHlSVGtuZGtldG1lUEFwckw3eEZDeEFFUGE1L2dCL3dXQlBvNjBPMkR3VDlp?=
 =?utf-8?B?OHZNY0lTeWpSQW9EbWlTQzJrakxRc2MyUERFRFBwS3FRczUwSFJ0YkQrSkdJ?=
 =?utf-8?B?UU1LM1VwcGNTK2ZEZmlCTis3cFN4WS9WUlZtaWZPWFgyMG1QeGlEa0R0OHZ5?=
 =?utf-8?B?Z21XNk1jNm56VzUwbldsWUUwd1NEZVZhR1pwRGxwanU5R2prN3AzRVBzb2Qy?=
 =?utf-8?B?NDdlZCt0V1A1K2lOMmF6UjlmaE9KYnUxWVM0UU9hZG5LN1puT2hoNm1JSWgx?=
 =?utf-8?B?QkJyMkk2Qy9Ld1BPcDNBNi9pOE1ZUGJHSlBrb1VCbU81b0FBajZJWWVnOTRu?=
 =?utf-8?B?Vlk5b2pxcUQ1N285aXFVc0kyTXRhdjdKQjlydDcyNmtOQXhKMWh0VkRmSWcy?=
 =?utf-8?B?bUxSNVpiMGhhcUlrN1loWEFCNXBNMjlHdytlMG1nZnYvbFNJRGtiMUpFeldq?=
 =?utf-8?Q?XL31yOPl2LQ+iVdotZAm/S7NAiKebZxV/YwaccEFprWU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1c9e2a-c33c-4679-78c4-08dd02aa5299
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 23:41:10.9647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR02MB10725

RnJvbTogTVVLRVNIIFJBVEhPUiA8bXVrZXNocmF0aG9yQG1pY3Jvc29mdC5jb20+IFNlbnQ6IE1v
bmRheSwgTm92ZW1iZXIgMTEsIDIwMjQgMzoxMSBQTQ0KPiANCj4gT24gMTEvMTEvMjQgMTM6Mjgs
IE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiAgPiBGcm9tOiBNVUtFU0ggUkFUSE9SIDxtdWtlc2hy
YXRob3JAbWljcm9zb2Z0LmNvbT4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAxMSwgMjAyNCAxMDo1
MyBBTQ0KPiAgPj4NCj4gID4+IE9uIDExLzEwLzI0IDIwOjEyLCBNaWNoYWVsIEtlbGxleSB3cm90
ZToNCj4gID4+ICAgPiBGcm9tOiBOdW5vIERhcyBOZXZlcyA8bnVub2Rhc25ldmVzQGxpbnV4Lm1p
Y3Jvc29mdC5jb20+IFNlbnQ6DQo+ICA+PiBUaHVyc2RheSwgTm92ZW1iZXIgNywgMjAyNCAyOjMy
IFBNDQo+ICA+PiAgID4+DQo+ICA+PiAgID4+IFRvIHN1cHBvcnQgSHlwZXItViBEb20wIChha2Eg
TGludXggYXMgcm9vdCBwYXJ0aXRpb24pLCBtYW55IG5ldw0KPiAgPj4gICA+PiBkZWZpbml0aW9u
cyBhcmUgcmVxdWlyZWQuDQo+ICA+PiAgID4NCj4gID4+ICAgPiBVc2luZyAiZG9tMCIgdGVybWlu
b2xvZ3kgaGVyZSBhbmQgaW4gdGhlIFN1YmplY3Q6IGxpbmUgaXMgbGlrZWx5IHRvDQo+ICA+PiAg
ID4gYmUgY29uZnVzaW5nIHRvIGZvbGtzIHdobyBhcmVuJ3QgaW50aW1hdGVseSBpbnZvbHZlZCBp
biBIeXBlci1WIHdvcmsuDQo+ICA+PiAgID4gUHJldmlvdXMgTGludXgga2VybmVsIGNvbW1pdCBt
ZXNzYWdlcyBhbmQgY29kZSBmb3IgcnVubmluZyBpbiB0aGUNCj4gID4+ICAgPiBIeXBlci1WIHJv
b3QgcGFydGl0aW9uIHVzZSAicm9vdCBwYXJ0aXRpb24iIHRlcm1pbm9sb2d5LCBhbmQgSSBjb3Vs
ZG4ndA0KPiAgPj4gICA+IGZpbmQgImRvbTAiIGhhdmluZyBiZWVuIHVzZWQgYmVmb3JlLiAicm9v
dCBwYXJ0aXRpb24iIHdvdWxkIGJlIG1vcmUNCj4gID4+ICAgPiBjb25zaXN0ZW50LCBhbmQgaXQg
YWxzbyBtYXRjaGVzIHRoZSBwdWJsaWMgZG9jdW1lbnRhdGlvbiBmb3IgSHlwZXItVi4NCj4gID4+
ICAgPiAiZG9tMCIgaXMgWGVuIHNwZWNpZmljIHRlcm1pbm9sb2d5LCBhbmQgaGF2aW5nIGl0IHNo
b3cgdXAgaW4gSHlwZXItVg0KPiAgPj4gICA+IHBhdGNoZXMgd291bGQgYmUgY29uZnVzaW5nIGZv
ciB0aGUgY2FzdWFsIHJlYWRlci4gSSBrbm93ICJkb20wIiBoYXMNCj4gID4+ICAgPiBiZWVuIHVz
ZWQgaW50ZXJuYWxseSBhdCBNaWNyb3NvZnQgYXMgc2hvcnRoYW5kIGZvciAiSHlwZXItViByb290
DQo+ICA+PiAgID4gcGFydGl0aW9uIiwgYnV0IGl0J3MgcHJvYmFibHkgYmVzdCB0byBjb21wbGV0
ZWx5IGF2b2lkIHN1Y2ggc2hvcnRoYW5kDQo+ICA+PiAgID4gaW4gcHVibGljIExpbnV4IGtlcm5l
bCBwYXRjaGVzIGFuZCBjb2RlLg0KPiAgPj4gICA+DQo+ICA+PiAgID4gSnVzdCBteSAkLjAyIC4u
Li4NCj4gID4+DQo+ICA+PiBIaSBNaWNoYWVsLA0KPiAgPj4NCj4gID4+IEZXSVcsIGh5cGVydiB0
ZWFtIGFuZCB1cyBhcmUgdXNpbmcgdGhlIHRlcm0gImRvbTAiIG1vcmUgYW5kIG1vcmUgdG8NCj4g
ID4+IGF2b2lkIGNvbmZ1c2lvbiBiZXR3ZWVuIHdpbmRvd3Mgcm9vdCBhbmQgbGludXggcm9vdCwg
YXMgZG9tMCBpcw0KPiAgPj4gYWx3YXlzIGxpbnV4IHJvb3QuIEkgZGlkIGEgcXVpY2sgc2VhcmNo
LCBhbmQgImRvbTAiIGlzIG5laXRoZXINCj4gID4+IGNvcHlyaWdodGVkIG5vciB0cmFkZW1hcmtl
ZCBieSB4ZW4sIGFuZCBJJ20gc3VyZSB0aGUgZmluZSBmb2xrcw0KPiAgPj4gdGhlcmUgd29uJ3Qg
YmUgb2ZmZW5kZWQuIEhvcGVmdWxseSwgW0h5cGVyLVZdIHRhZyB3b3VsZCByZWR1Y2UNCj4gID4+
IHRoZSBjb25mdXNpb24uDQo+ICA+Pg0KPiAgPj4gSnVzdCBteSAkMC4xDQo+ICA+Pg0KPiAgPg0K
PiAgPiBZZWFoLCAiZG9tMCIgY2VydGFpbmx5IGZpdHMgYXMgc2hvcnRoYW5kIGZvciB0aGUgcmF0
aGVyIHBvbmRlcm91cw0KPiAgPiAiTGludXggcnVubmluZyBpbiBhIEh5cGVyLVYgcm9vdCBwYXJ0
aXRpb24iLiA6LSkNCj4gID4NCj4gID4gQnV0IGV2ZW4gdXNpbmcgIkh5cGVyLVYgZG9tMCIgdG8g
YWRkIGNsYXJpdHkgdnMuIFhlbiBkb20wIHNlZW1zDQo+ICA+IHRvIG1lIHRvIGJlIGEgbWlzbm9t
ZXIgYmVjYXVzZSBIeXBlci1WIGRvbTAgaXMgb25seSBjb25jZXB0dWFsbHkNCj4gID4gbGlrZSBY
ZW4gZG9tMC4gSXQncyBub3QgYWN0dWFsbHkgYW4gaW1wbGVtZW50YXRpb24gb2YgWGVuIGRvbTAu
DQo+ICA+IExldCBtZSBnaXZlIHR3byBleGFtcGxlczoNCj4gID4NCj4gID4gMSkgSHlwZXItViBw
cm92aWRlcyBWTUJ1cywgd2hpY2ggaXMgY29uY2VwdHVhbGx5IHNpbWlsYXIgdG8gdmlydGlvLg0K
PiAgPiBCdXQgVk1CdXMgaXMgbm90IGFuIGltcGxlbWVudGF0aW9uIG9mIHZpcnRpbywgYW5kIHdl
IGRvbid0IGNhbGwgaXQNCj4gID4gIkh5cGVyLVYgdmlydGlvIi4gIE9mIGNvdXJzZSwgIlZNQnVz
IiBpcyBhIGxvdCBzaG9ydGVyIHRoYW4gIkh5cGVyLVYNCj4gID4gcm9vdCBwYXJ0aXRpb24iIHNv
IHRoZSBtb3RpdmF0aW9uIGZvciBhIHNob3J0aGFuZCBpc24ndCB0aGVyZSwgYnV0IHN0aWxsLg0K
PiAgPiBJZiBIeXBlci1WIHNob3VsZCBldmVyIGltcGxlbWVudCBhY3R1YWwgdmlydGlvIGludGVy
ZmFjZXMsIHRoZW4gaXQNCj4gID4gd291bGQgYmUgdmFsaWQgdG8gY2FsbCB0aGF0ICJIeXBlci1W
IHZpcnRpbyIuDQo+ICA+DQo+ICA+IDIpIEtWTSBoYXMgIktWTSBIeXBlci1WIiwgd2hpY2ggSSB0
aGluayBpcyB2YWxpZC4gSXQncyBhbg0KPiAgPiBpbXBsZW1lbnRhdGlvbiBvZiBIeXBlci1WIGlu
dGVyZmFjZXMgaW4gS1ZNIHNvIHRoYXQgV2luZG93cw0KPiAgPiBndWVzdHMgY2FuIHJ1biBhcyBp
ZiB0aGV5IGFyZSBydW5uaW5nIG9uIEh5cGVyLVYuDQo+ICA+DQo+ICA+IEkgd29uJ3Qgc3BlY3Vs
YXRlIG9uIHdoYXQgdGhlIFhlbiBmb2xrcyB3b3VsZCB0aGluayBvZiAiSHlwZXItVg0KPiAgPiBk
b20wIiwgZXNwZWNpYWxseSBpZiBpdCBpc24ndCBhbiBpbXBsZW1lbnRhdGlvbiB0aGF0J3MgY29t
cGF0aWJsZQ0KPiAgPiB3aXRoIFhlbiBkb20wIGZ1bmN0aW9uYWxpdHkuDQo+ICA+DQo+ICA+IEFz
IGZvciAibW9yZSBhbmQgbW9yZSIgdXNhZ2Ugb2YgImRvbTAiIGJ5IHlvdXIgdGVhbSBhbmQgdGhl
DQo+ICA+IEh5cGVyLVYgdGVhbTogIElzIHRoYXQgaW50ZXJuYWwgdXNhZ2Ugb25seT8gT3IgdXNh
Z2UgaW4gcHVibGljIG1haWxpbmcNCj4gID4gbGlzdHMgb3Igb3BlbiBzb3VyY2UgcHJvamVjdHMg
bGlrZSBDbG91ZCBIeXBlcnZpc29yPyBBZ2FpbiwgZnJvbQ0KPiAgPiBteSBzdGFuZHBvaW50LCBp
bnRlcm5hbCBpcyBpbnRlcm5hbCBhbmQgY2FuIGJlIHdoYXRldmVyIGlzIGNvbnZlbmllbnQNCj4g
ID4gYW5kIHByb3Blcmx5IHVuZGVyc3Rvb2QgaW50ZXJuYWxseS4gQnV0IGluIHB1YmxpYyBtYWls
aW5nIGxpc3RzIGFuZA0KPiAgPiBwcm9qZWN0cywgSSB0aGluayAiSHlwZXItViBkb20wIiBzaG91
bGQgYmUgYXZvaWRlZCB1bmxlc3MgaXQncw0KPiAgPiB0cnVseSBhbiBpbXBsZW1lbnRhdGlvbiBv
ZiB0aGUgZG9tMCBpbnRlcmZhY2VzLg0KPiAgPg0KPiAgPiBUaGF0J3MgcHJvYmFibHkgbm93ICQw
LjEwIHdvcnRoIGluc3RlYWQgb2YgJDAuMDIuIDotKSBBbmQgSSdtDQo+ICA+IG5vdCB0aGUgZGVj
aWRlciBoZXJlIC0tIEknbSBqdXN0IG9mZmVyaW5nIGEgcGVyc3BlY3RpdmUuDQo+IA0KPiAiZG9t
MCIgaXMgbmVpdGhlciBhIHRlY2hub2xvZ3kgbm9yIGEgcHJvdG9jb2wuIEl0IHNpbXBseSBtZWFu
cyBpbml0aWFsDQo+IGRvbWFpbiAod2hpY2ggb24geGVuIGhhcHBlbmVkIHRvIGJlIGRvbWlkIG9m
IDAsIGNvdWxkIGhhdmUgYmVlbiAxKS4gVGhpcw0KPiBpcyBjcmVhdGVkIGR1cmluZyBib290LCBz
YW1lIGFzIGxpbnV4IHJvb3Qgb24gaHlwZXJ2LCBhbmQgaXMgcHJpdmlsZWdlZA0KPiBkb21haW4g
c2FtZSBhcyB4ZW4uIEV2ZW4gaW4gS1ZNIHdvcmxkLCBJJ3ZlIGhlYXJkIG1hbnkgZm9sa3MgcmVm
ZXIgdG8NCj4gdGhlIGhvc3QgYXMga3ZtIGRvbTAuLi4NCj4gDQo+IEdpdmVuIHRoZSBtaXggb2Yg
d2luZG93cyBhbmQgbGludXggd2l0aCBsMXZoIGFuZCBuZXN0ZWQsIGRvbTAgaXMgaGVscGluZw0K
PiBpbiBjb252ZXJzYXRpb25zIGludGVybmFsbHksIGFuZCBJJ20gc3VyZSBpdCB3aWxsIGtlZXAg
cGVyY29sYXRpbmcNCj4gZXh0ZXJuYWxseS4NCj4gDQoNCk9LLCBmYWlyIGVub3VnaC4gTXkgcGVy
c3BlY3RpdmUgaXMgcHJvYmFibHkgbW9yZSBsaW1pdGVkIHRoYW4NCnlvdXJzIGFzIG15IGV4cGVy
aWVuY2Ugd2l0aCAiZG9tMCIgaXMgZXhjbHVzaXZlbHkgd2l0aCB0aGUgWGVuDQpjb2RlIGluIGEg
TGludXgga2VybmVsIGVudmlyb25tZW50LiBJIGp1c3QgaGF2ZW4ndCBzZWVuICJkb20wIg0KdXNl
ZCBlbHNld2hlcmUsIGJ1dCB0aGF0IGNlcnRhaW5seSBkb2Vzbid0IG1lYW4gaXQncyBub3QgYmVp
bmcNCmRvbmUuDQoNCklmIHRoZSBkZWNpc2lvbiBvbiB0aGUgTWljcm9zb2Z0IHNpZGUgaXMgdGhh
dCBpbnRyb2R1Y2luZyAiSHlwZXItVg0KZG9tMCIgdGVybWlub2xvZ3kgbWFrZXMgc2Vuc2UsIEkg
d29uJ3Qgb2JqZWN0IGZ1cnRoZXIsIHRob3VnaA0KSSB3b3VsZCB0aGluayB0aGVyZSBzaG91bGQg
YmUgc29tZSBraW5kIG9mIHJlY29uY2lsaWF0aW9uIHdpdGgNCmV4aXN0aW5nIGNvZGUvY29tbWVu
dHMvZG9jdW1lbnRhdGlvbiB0aGF0IHVzZXMgInJvb3QgcGFydGl0aW9uIi4NCg0KTWljaGFlbA0K

