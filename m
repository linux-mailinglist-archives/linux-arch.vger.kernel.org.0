Return-Path: <linux-arch+bounces-9016-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EB39C4807
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 22:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212E41F22163
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 21:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3AF1BC9F4;
	Mon, 11 Nov 2024 21:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ktAFvI9q"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2061.outbound.protection.outlook.com [40.92.23.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACF41AB6FB;
	Mon, 11 Nov 2024 21:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731360512; cv=fail; b=PTK8LCSRO0WW/uKSyJqSvWevQnbmr+AYQKoLqQr7WBoccIJd9nr9WzUu44Prs3+q9hSvRBEzGz3cLq5SIK1lq4RyxCLSHqxIYySTmaYW8IVXspD7z332wE9mUPfo2N5f27GPhICUh3UnBQKn1plRr2mBttExnuBJjziLSrEsB8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731360512; c=relaxed/simple;
	bh=PHM7BZpzbOBFyOc+aZLPBnA5KVSFLITq/rkr3K9I1NQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RH1BIi7XlIaTuNZWUdgI6CwOYMsPeuvcXY0lEfkMmcUSYZEVcOwjdTC8ow2+yHyEo8qlfgyuUDE1GkywP48XNoV8jWi6mLCKrpaFD1KfDHnitiWZEi5p1x+P5eANYxeuLjMgRUqcuu02TN62m5rpzy6numE0uvddpgjzEpfNkNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ktAFvI9q; arc=fail smtp.client-ip=40.92.23.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDG980lRw/2SnUJi6iYwUYPgiTlW+Ty0B+b9GFA4y4V8zjLAZgk1rLyDgFs03UVDogY1pLczhcSTfrEdRecy6yjN69vUVV00hW12JfG+UHC3RMKKAVEe+RtWgkM1bfoJqWOAzIpeSdrNqy+BPZQpQsaJd6jAB05iDpQI6ia2a+rTVtFP7Ie2l7pBj2vDCKzTnXf0jFHyEDquV1kxseYlGyKkcBrSnnC9FwY/ptxSBhZdi3z87FJXS1cSNmi2clpkFVv/k3cba+z/LnCJxUyUaAS5iR/rkuCRFnxY+xbyh4VItDquOPDZbx4CuixGzWzQs/cHJnFjxb10TK6ExOkAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHM7BZpzbOBFyOc+aZLPBnA5KVSFLITq/rkr3K9I1NQ=;
 b=th7fEGHe3DSbxhU1/MUPokNWR/ZDRGwIveVIk/F83UuKUf11EYYCQqnyPFqEzYYoF6rVgOFyHFQg6U7Mve8ni9AguObKXR+FX76x7aFyAy3hwZz3PfwQm6icnQ4wa1QqVGRBJTW9Bg/Fed1hupc+JHtJf1C++ntCXqhsdAUfPDy2svsPVCq9qQUkufQBfkKdGCdftLrki+9jYefZG1A7l2ZUd0f5gCxyueQ64A13Eoy+yPnMHyiy0iUE2ewUcoi/MqWAoHPhHNiPvZSqclf20AS6eT+UTUCxXhI/HMakNGab1I2Cnz7MmYsjd4DQS6Pj4tRv2byjkhNRGlp8WozP9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHM7BZpzbOBFyOc+aZLPBnA5KVSFLITq/rkr3K9I1NQ=;
 b=ktAFvI9qXfPRTTbecFHrVKDc9ERk1ByZ02EjOGrQuIRzCAIuhYas0NzjtIg2O14x8PcHlEf73U3/3w3+OiNbLKLOKxqM0qej22DlG6vrXcgEFRaATYo/2XULRkzr27jmqrZLyJPbml4REl+xgmsEjujWI+Zn0OlGNeOelLAQr+yI+n8L06Vd6W5tyUTsrg2W+/Jd3lMHsWv/kG3dzQMZVH0kyFO7d744aNXWYRF/AdSH/O9X70ptZ154FF4ZMap0GqelERXcz0AFnDV/dMhCgTAy68MQqKecsnRx4ftZMWAAhW+YQU8J5dQ90nxsjlvbsd+VwMKuvcFFmn6mbFlcUg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS7PR02MB9603.namprd02.prod.outlook.com (2603:10b6:8:da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.25; Mon, 11 Nov
 2024 21:28:28 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 21:28:28 +0000
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
Thread-Index: AQHbMWTyoKCBm8ky3ECkxBZdOyPiHbKvoZXAgALRb4CAACazIA==
Date: Mon, 11 Nov 2024 21:28:28 +0000
Message-ID:
 <SN6PR02MB415747D0DB0879729E6D7D03D4582@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
 <BN7PR02MB41485DAD2E066D417FE12020D4582@BN7PR02MB4148.namprd02.prod.outlook.com>
 <b4a46acc-f4bb-81db-fcc1-29c55dc7724f@microsoft.com>
In-Reply-To: <b4a46acc-f4bb-81db-fcc1-29c55dc7724f@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS7PR02MB9603:EE_
x-ms-office365-filtering-correlation-id: 1ec8fedf-5689-4402-4fd3-08dd0297c870
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|19110799003|8062599003|15080799006|102099032|3412199025|440099028|56899033;
x-microsoft-antispam-message-info:
 =?utf-8?B?eTJHWllISUY1NDR5NGx4djl1enEyQlZGTEN0aHhMMDBGdm5JbkpnSWE5SFJr?=
 =?utf-8?B?MEpNYmIvNGpDdklVZlRXRlRFR3o2Q09TMlZvZE9jdlZ5TjlISGIxT3Z6YWRN?=
 =?utf-8?B?QjJ5RXdscUpJQ1haaU5VR1RmTnlrd3FLYWJEVGJWcG5pazQvYVZqL3pYUFRw?=
 =?utf-8?B?NEV6bGwvUzQ3MVBtUEdHbTRkb0RyNzlVbDVLeUNCZng2QnAyM3NlTk9xdmM0?=
 =?utf-8?B?Rk9rWm1aRSswaHk0MUsxM2plM24waFdTRjVvcU9lSVdUd2toa3hsTVlxR3VM?=
 =?utf-8?B?dmpadStyY2UyNUgzWmpXeGtSRUlvZFptZEZEeXdUOFZ0OW9hU1NHL0NCQm1x?=
 =?utf-8?B?R3ZFT0pRMjl4NmdEVkxGRVhGSGlGN0tKckFDOUFMYk1qVkRFVlZrOFdUUUhx?=
 =?utf-8?B?VjFORjNnNnAwYklOSlRuZjc0WVI1blZTT3BuaEhMZk5QeHpsa2JIeHNWM3lt?=
 =?utf-8?B?K1NOMFplSEI2dTVWZ2RtUzMxMlFKY29KYTF0UTlZc3UyYzlzT3NHeWN6all4?=
 =?utf-8?B?eFovTzJoSGZPRUdjcDJyR1NxNVpCazNMRGVsR1UwWVVOVG4wZTh2RVFjZmFE?=
 =?utf-8?B?UFlxU0laVk5TTy9TQ0I2OGlETEE2RXc1aHYvT1JPbVo2enJDei80Y1VLSWJZ?=
 =?utf-8?B?anNVdS9NK2VocmEzQVkxeUpNWTJzaVpGbzR0SlNJSjdmeDJlRC9XWDBTUmNx?=
 =?utf-8?B?U1VGM0UrOVlWa2U0ZzFkR0g5c2FSWG53Q25seW9PZVJlczdxeVl0WXFMS0hr?=
 =?utf-8?B?N1lqUDZsbEdkYmUzMjluWGsyeXBFQlVISXgvUkRjN1Q2dmNkeTJDT0pUZHM4?=
 =?utf-8?B?K0lmK3lyTlZFT2YydGpTUmljL3BPNXJ6dFZEdjB6cWJxSDU3MWllcWM1bUEv?=
 =?utf-8?B?MlNWSnEwNmhQZkYzTzYwcnUzTm5RRW84WEw2Q0cxTWxIWUpoSlBKQVo5a1Qr?=
 =?utf-8?B?VzlVMHo4VE9RNWdUcmpGczVmcldLcjVCYkNaS3p1bEpZVlVuZFQxd0FsZFpj?=
 =?utf-8?B?aUdqQUZCODN0ZW1qMGVPTWJndmpqbzdsS1hqL0lDbHkrZ2R3M21kZExaUEhy?=
 =?utf-8?B?T1lxSFFMbDBaZGF0VjRZTHNFbDhBdU5SOWZCMCtJcHI4ZjdHWVIvZk4ydUNv?=
 =?utf-8?B?b0UvVmV5cTFJL2F1Zm1RMldxcjdqQzd3dmYvUXhFcWpRRUtzRGRFckVVQjFh?=
 =?utf-8?B?Zm9PYkVDZG00a1ZOM3pmdnlhNEFDcXY0RWQ1OHpLRkhzU0tGRkxLc25YSmNj?=
 =?utf-8?B?KzFJUk95SDFZdHhseTExeHBrSXg5c3MyNHNBaC9YWFpidERVVmU4Y1M5Wm5Z?=
 =?utf-8?B?VytRcXpmMzZPTDV2WWxicnI5ZXUwR1lFb3czZ3QxZTFZeHpJZnNuQmUrSXc1?=
 =?utf-8?B?NmhjYlJQNVBYbEE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NFZ4V1E0REIwb1hsVTIyRld5a0k0bDltT0VrcXR3c040YS9aZ09ZVzhTekVD?=
 =?utf-8?B?SytuY2pEZjFFcWdhbHZSbFNWaVZQU3JTdTJ5OHhjSDZleHFWWk50RW9MZ2hX?=
 =?utf-8?B?SE1tKzArWVl0ZEpFRVhCdjZXYmowRlk1blJ6Z0cydkxPK1cyMXcwT2t5MDFK?=
 =?utf-8?B?T0RKMzRjUi9hRzYxR2JYdkdEWDc4bHNjUXFxYk1sc3RwWFF4SERBcjFTMWhJ?=
 =?utf-8?B?U2tlNWlLQXdFZVMwc2NVdDVIVGFTWmpFMDlJWEthV3ZyNnVySlhGWkxPb3Ns?=
 =?utf-8?B?TXp4N3FJSXUrQjNjUUJUYmhOU1lKMG9mTWZGMDI4aFVtMVEzTkJMRzV1NkxN?=
 =?utf-8?B?Uml5anVsRzhrM2NiRE5OUi9MNWxuSCtST2IzWGtGWTc3S2lUTXJUZ2RZaTNj?=
 =?utf-8?B?Y1dsNEdpMCtWclEyWFp6bnZxMVZralVhZEUyaVVjZmI1d0pHa2QvQWRZM21Y?=
 =?utf-8?B?RXg0NkdZdDd6TmFkY1VKaGtHMVJxemVLZXJzR1pPY2NBSXR4b3lEN1dHWlRD?=
 =?utf-8?B?S052YlZjejRHdWorL1N3bEhLOEpvbUZCdFh5L21nZE51RWZNd2pGaEN1SE9M?=
 =?utf-8?B?RldnMUxrMUU4QW8zZEVnSk8yYzhNL2hNanJ4ZHJzcHZTYVFXRlh5N2NNSDdT?=
 =?utf-8?B?UWtacHFaZUc2NkFqWHl0YmpmT1BFLzB5cnpxMTJnK3cwYmlvSzJhRkhlZTJL?=
 =?utf-8?B?R0V2U2ZQVnJ5VmNRZFdmeGRpNDFaZEJYdUIzNWNwb245R0hGemRsQ1N5KzVl?=
 =?utf-8?B?SDZ6ZHBDNk5HMVQyREtBQkhTNTE5NGNaQnB4Rk9ZZEQvTnV5MTBPd0JIQXRj?=
 =?utf-8?B?QWREZk1lRll1dU9Cb05rbHY0RlN2ZkxXZ2IxMTVOQTVNcThuS3c0K2h2RFJN?=
 =?utf-8?B?bk1ydmhWK0tEVW5qcGFFZWxrWlF3MlR1YkRHTlhCT3hiMUFtSGo1WlMvYVNZ?=
 =?utf-8?B?TGFXTUI0WDlJa3hTTnAzNWNma3RBaUZXeTA4c3U3cEc4UkVXdXo4Z1grWWtS?=
 =?utf-8?B?cTR2OWhQdE5ldkZEeW5BSU92QThQSGg0YWk0UlJCUy9GR1BhREFjN2RsUCtu?=
 =?utf-8?B?b0ViTkZkUHREcHJpWGRNN3hGQjJ2WDEvOWE1T3QvY1pycHBCR3B6OEU4U0FE?=
 =?utf-8?B?Nlg0YUJxV1o4Mm15a05LdTd1clVyTE00U1BtOFVlMHFKeFVFa0tBWHA5Zjll?=
 =?utf-8?B?SDlMem53eTRJbk9BVVFxQnlSL0gzOThSMC9pMkdqSS9ZRnRNeEhoMVZ2M3Ir?=
 =?utf-8?B?SC9tVUlQb3dJN0dERVZsYUNwZjY1VjZpSHpuajJmU1N5bmp2NjBEb00waFpk?=
 =?utf-8?B?RzJFV2pCZTh3cWN5ZlYwY2xhRjAxd0RnWWc3dFJEOElkOFNYM1FFaHQ3MHdG?=
 =?utf-8?B?NkpzR2N1ZHp6cDcydHRIL1JpZjJ0NEtKRFhqVTRtZ2oxdkVOR3dnTDRqVGNZ?=
 =?utf-8?B?cC9kRjZDdko4cHZQUnlBdEcySTQ5SWI4aWRJd0plam9OVmNvd0ZYSWVQaW95?=
 =?utf-8?B?SWZMMXVJbHRvWXRvTUZSaFcwQ1ZudVk5bDhuTGFUdzRWOFUzKy9EMzVoNDJ0?=
 =?utf-8?B?R2p6VUd6ZmUrWCt0c2RjRkF0WFhuVXVqd3VzMFlwREUzOWltbmhvRGJ5dHBr?=
 =?utf-8?Q?BXZ6Nk29MFiaYkhk2aEqr2mEYnzv/cAOUqEO3m++LBnQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec8fedf-5689-4402-4fd3-08dd0297c870
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 21:28:28.2255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB9603

RnJvbTogTVVLRVNIIFJBVEhPUiA8bXVrZXNocmF0aG9yQG1pY3Jvc29mdC5jb20+IFNlbnQ6IE1v
bmRheSwgTm92ZW1iZXIgMTEsIDIwMjQgMTA6NTMgQU0NCj4gDQo+IE9uIDExLzEwLzI0IDIwOjEy
LCBNaWNoYWVsIEtlbGxleSB3cm90ZToNCj4gID4gRnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9k
YXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBTZW50Og0KPiBUaHVyc2RheSwgTm92ZW1iZXIg
NywgMjAyNCAyOjMyIFBNDQo+ICA+Pg0KPiAgPj4gVG8gc3VwcG9ydCBIeXBlci1WIERvbTAgKGFr
YSBMaW51eCBhcyByb290IHBhcnRpdGlvbiksIG1hbnkgbmV3DQo+ICA+PiBkZWZpbml0aW9ucyBh
cmUgcmVxdWlyZWQuDQo+ICA+DQo+ICA+IFVzaW5nICJkb20wIiB0ZXJtaW5vbG9neSBoZXJlIGFu
ZCBpbiB0aGUgU3ViamVjdDogbGluZSBpcyBsaWtlbHkgdG8NCj4gID4gYmUgY29uZnVzaW5nIHRv
IGZvbGtzIHdobyBhcmVuJ3QgaW50aW1hdGVseSBpbnZvbHZlZCBpbiBIeXBlci1WIHdvcmsuDQo+
ICA+IFByZXZpb3VzIExpbnV4IGtlcm5lbCBjb21taXQgbWVzc2FnZXMgYW5kIGNvZGUgZm9yIHJ1
bm5pbmcgaW4gdGhlDQo+ICA+IEh5cGVyLVYgcm9vdCBwYXJ0aXRpb24gdXNlICJyb290IHBhcnRp
dGlvbiIgdGVybWlub2xvZ3ksIGFuZCBJIGNvdWxkbid0DQo+ICA+IGZpbmQgImRvbTAiIGhhdmlu
ZyBiZWVuIHVzZWQgYmVmb3JlLiAicm9vdCBwYXJ0aXRpb24iIHdvdWxkIGJlIG1vcmUNCj4gID4g
Y29uc2lzdGVudCwgYW5kIGl0IGFsc28gbWF0Y2hlcyB0aGUgcHVibGljIGRvY3VtZW50YXRpb24g
Zm9yIEh5cGVyLVYuDQo+ICA+ICJkb20wIiBpcyBYZW4gc3BlY2lmaWMgdGVybWlub2xvZ3ksIGFu
ZCBoYXZpbmcgaXQgc2hvdyB1cCBpbiBIeXBlci1WDQo+ICA+IHBhdGNoZXMgd291bGQgYmUgY29u
ZnVzaW5nIGZvciB0aGUgY2FzdWFsIHJlYWRlci4gSSBrbm93ICJkb20wIiBoYXMNCj4gID4gYmVl
biB1c2VkIGludGVybmFsbHkgYXQgTWljcm9zb2Z0IGFzIHNob3J0aGFuZCBmb3IgIkh5cGVyLVYg
cm9vdA0KPiAgPiBwYXJ0aXRpb24iLCBidXQgaXQncyBwcm9iYWJseSBiZXN0IHRvIGNvbXBsZXRl
bHkgYXZvaWQgc3VjaCBzaG9ydGhhbmQNCj4gID4gaW4gcHVibGljIExpbnV4IGtlcm5lbCBwYXRj
aGVzIGFuZCBjb2RlLg0KPiAgPg0KPiAgPiBKdXN0IG15ICQuMDIgLi4uLg0KPiANCj4gSGkgTWlj
aGFlbCwNCj4gDQo+IEZXSVcsIGh5cGVydiB0ZWFtIGFuZCB1cyBhcmUgdXNpbmcgdGhlIHRlcm0g
ImRvbTAiIG1vcmUgYW5kIG1vcmUgdG8NCj4gYXZvaWQgY29uZnVzaW9uIGJldHdlZW4gd2luZG93
cyByb290IGFuZCBsaW51eCByb290LCBhcyBkb20wIGlzDQo+IGFsd2F5cyBsaW51eCByb290LiBJ
IGRpZCBhIHF1aWNrIHNlYXJjaCwgYW5kICJkb20wIiBpcyBuZWl0aGVyDQo+IGNvcHlyaWdodGVk
IG5vciB0cmFkZW1hcmtlZCBieSB4ZW4sIGFuZCBJJ20gc3VyZSB0aGUgZmluZSBmb2xrcw0KPiB0
aGVyZSB3b24ndCBiZSBvZmZlbmRlZC4gSG9wZWZ1bGx5LCBbSHlwZXItVl0gdGFnIHdvdWxkIHJl
ZHVjZQ0KPiB0aGUgY29uZnVzaW9uLg0KPiANCj4gSnVzdCBteSAkMC4xDQo+IA0KDQpZZWFoLCAi
ZG9tMCIgY2VydGFpbmx5IGZpdHMgYXMgc2hvcnRoYW5kIGZvciB0aGUgcmF0aGVyIHBvbmRlcm91
cw0KIkxpbnV4IHJ1bm5pbmcgaW4gYSBIeXBlci1WIHJvb3QgcGFydGl0aW9uIi4gOi0pDQoNCkJ1
dCBldmVuIHVzaW5nICJIeXBlci1WIGRvbTAiIHRvIGFkZCBjbGFyaXR5IHZzLiBYZW4gZG9tMCBz
ZWVtcw0KdG8gbWUgdG8gYmUgYSBtaXNub21lciBiZWNhdXNlIEh5cGVyLVYgZG9tMCBpcyBvbmx5
IGNvbmNlcHR1YWxseQ0KbGlrZSBYZW4gZG9tMC4gSXQncyBub3QgYWN0dWFsbHkgYW4gaW1wbGVt
ZW50YXRpb24gb2YgWGVuIGRvbTAuDQpMZXQgbWUgZ2l2ZSB0d28gZXhhbXBsZXM6DQoNCjEpIEh5
cGVyLVYgcHJvdmlkZXMgVk1CdXMsIHdoaWNoIGlzIGNvbmNlcHR1YWxseSBzaW1pbGFyIHRvIHZp
cnRpby4NCkJ1dCBWTUJ1cyBpcyBub3QgYW4gaW1wbGVtZW50YXRpb24gb2YgdmlydGlvLCBhbmQg
d2UgZG9uJ3QgY2FsbCBpdA0KIkh5cGVyLVYgdmlydGlvIi4gIE9mIGNvdXJzZSwgIlZNQnVzIiBp
cyBhIGxvdCBzaG9ydGVyIHRoYW4gIkh5cGVyLVYNCnJvb3QgcGFydGl0aW9uIiBzbyB0aGUgbW90
aXZhdGlvbiBmb3IgYSBzaG9ydGhhbmQgaXNuJ3QgdGhlcmUsIGJ1dCBzdGlsbC4NCklmIEh5cGVy
LVYgc2hvdWxkIGV2ZXIgaW1wbGVtZW50IGFjdHVhbCB2aXJ0aW8gaW50ZXJmYWNlcywgdGhlbiBp
dA0Kd291bGQgYmUgdmFsaWQgdG8gY2FsbCB0aGF0ICJIeXBlci1WIHZpcnRpbyIuDQoNCjIpIEtW
TSBoYXMgIktWTSBIeXBlci1WIiwgd2hpY2ggSSB0aGluayBpcyB2YWxpZC4gSXQncyBhbg0KaW1w
bGVtZW50YXRpb24gb2YgSHlwZXItViBpbnRlcmZhY2VzIGluIEtWTSBzbyB0aGF0IFdpbmRvd3MN
Cmd1ZXN0cyBjYW4gcnVuIGFzIGlmIHRoZXkgYXJlIHJ1bm5pbmcgb24gSHlwZXItVi4NCg0KSSB3
b24ndCBzcGVjdWxhdGUgb24gd2hhdCB0aGUgWGVuIGZvbGtzIHdvdWxkIHRoaW5rIG9mICJIeXBl
ci1WDQpkb20wIiwgZXNwZWNpYWxseSBpZiBpdCBpc24ndCBhbiBpbXBsZW1lbnRhdGlvbiB0aGF0
J3MgY29tcGF0aWJsZQ0Kd2l0aCBYZW4gZG9tMCBmdW5jdGlvbmFsaXR5Lg0KDQpBcyBmb3IgIm1v
cmUgYW5kIG1vcmUiIHVzYWdlIG9mICJkb20wIiBieSB5b3VyIHRlYW0gYW5kIHRoZQ0KSHlwZXIt
ViB0ZWFtOiAgSXMgdGhhdCBpbnRlcm5hbCB1c2FnZSBvbmx5PyBPciB1c2FnZSBpbiBwdWJsaWMg
bWFpbGluZw0KbGlzdHMgb3Igb3BlbiBzb3VyY2UgcHJvamVjdHMgbGlrZSBDbG91ZCBIeXBlcnZp
c29yPyBBZ2FpbiwgZnJvbQ0KbXkgc3RhbmRwb2ludCwgaW50ZXJuYWwgaXMgaW50ZXJuYWwgYW5k
IGNhbiBiZSB3aGF0ZXZlciBpcyBjb252ZW5pZW50DQphbmQgcHJvcGVybHkgdW5kZXJzdG9vZCBp
bnRlcm5hbGx5LiBCdXQgaW4gcHVibGljIG1haWxpbmcgbGlzdHMgYW5kDQpwcm9qZWN0cywgSSB0
aGluayAiSHlwZXItViBkb20wIiBzaG91bGQgYmUgYXZvaWRlZCB1bmxlc3MgaXQncw0KdHJ1bHkg
YW4gaW1wbGVtZW50YXRpb24gb2YgdGhlIGRvbTAgaW50ZXJmYWNlcy4NCg0KVGhhdCdzIHByb2Jh
Ymx5IG5vdyAkMC4xMCB3b3J0aCBpbnN0ZWFkIG9mICQwLjAyLiA6LSkgQW5kIEknbQ0Kbm90IHRo
ZSBkZWNpZGVyIGhlcmUgLS0gSSdtIGp1c3Qgb2ZmZXJpbmcgYSBwZXJzcGVjdGl2ZS4NCg0KTWlj
aGFlbA0K

