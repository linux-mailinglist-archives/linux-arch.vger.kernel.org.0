Return-Path: <linux-arch+bounces-13251-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD59B30BB1
	for <lists+linux-arch@lfdr.de>; Fri, 22 Aug 2025 04:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78ED7241E4
	for <lists+linux-arch@lfdr.de>; Fri, 22 Aug 2025 02:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A4E140E5F;
	Fri, 22 Aug 2025 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Saevbz66"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2057.outbound.protection.outlook.com [40.92.41.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071A419CC27;
	Fri, 22 Aug 2025 02:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755828614; cv=fail; b=PXpOwdLVklyHtQqUpHrwIv5+ptMSv3Kwc1jGm9RRmx6uEAWiHLXhvbdr0MAaQXO0pLGiZX7xX1i3pLb23cS4LCy7kX8NejEVuYay8mg4ivsWuNKZWn9p2/dA04y9cUV4TsAiekU67hGnCc9Aa3+gt9ZjIkWcUUstsGEMvxBM3w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755828614; c=relaxed/simple;
	bh=5rcCkpZ6qgfxcUOl0Ip4+0URv73HDmXDGIYuR79vbD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EAw65+VTBMIxlHoWaZ7digIPhOLd85WwFKNNRJcBbIv2Kg/fH8kplClRE/7g8xjc5SRdRrpSI/hnbwDqg6FzQiS6QV77NXcSmXXdatIYNT2DqJEnAkzebm/T1/eTNqGxkvxpr2napFG4fg8Kj+z4pO+XvKBL9EB/MuMeserc89I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Saevbz66; arc=fail smtp.client-ip=40.92.41.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYa+lT86hDmH4BOyG/YHvUzkKlSQihK6TH42R9akyEYFreBHBH7gl1hLEn5Qp+97zFTg5hMFpC1s1iif7HWprYx14qHgbj7aYUDLQxqa3mprXWFg1uhmF7dx9bnschGWWVrEYboBdvNFpwZS9/hmY/NnytX4Ml1LoG+pWPMECWmqk/R7ohZWrpnKr5Gop5nyiN6oM12aTA3gGYGOP29qR4h1N1Lykgky8v3ASC2DbS06QW89E7ny2ecK1XDDXWpqpVUahfLBvo82mL/8F2A55E5O3h0ukIKY4+WObpnYWbR3kNHf+fhVHcx31QGZcK8Q5w39BCJFojUupReANontBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rcCkpZ6qgfxcUOl0Ip4+0URv73HDmXDGIYuR79vbD8=;
 b=Sme6SHo3u5CSAe207SN1LnsMrfalCXX1C1tmOQv+z7cNni2eRVb7s6ZiT4S5QgdlrilORQjnXwq71DQZK57++WTsEjHEgvUq9Vep0NhT0UAV+JzMbxC9KZH/iJbF3frkyVjw1KEqjhVwlvM+vPeIiML8Ih9Bh/qFpNTEVCFVE4fxuKkcbpBady+uhRX2n+Ao22+ebT6QCQ1TuxM4TP40jrScRv8WanBKdzP6x/2w31yeyBexFPw8efdMI4WRv6TIKeodHQidiCJL+lpiPO+/dux128ZeS5CZtcqUstHzIwFp044gKpAy1xkjnokmPCWolpqdaxQ/uituJb0w8NkpkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rcCkpZ6qgfxcUOl0Ip4+0URv73HDmXDGIYuR79vbD8=;
 b=Saevbz66z4rdVDlqLtt1vEzpwyMluekUmIXTH4h+eoJX2WKwQg0PHg01l3y4vl88m/2WazxUzqmzzlmrMiSmGItg0G/Wu3Id6Z/HOOzp7ApXEljPiTELDpUqIuqaGCtbY25iskUqrXT6ju8fB3vOLsq5LhQZaY0cdH0LQesGBv1B39/EP1Rpf6aHhnlqkmweQspCI4UDlhTf7C/dl2mqGK8+m5VUi2vFTrv0cihC1uMWMcNsBzjgu4peMcIB8rl8htg16muIH1aIOGiwm3bBJoDUHSDARSiIj1zktRLcxs+nYa43wyjKdi8hG+IzDQ0svdCjBc9A9bCQyz+k9mX0lQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8534.namprd02.prod.outlook.com (2603:10b6:510:10d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 02:10:07 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 02:10:07 +0000
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
Thread-Index: AQHbrjFiyn0GJkB9FUywLGBELxbpZ7RtCZwAgAAo6gCAAQmaEIAAIayAgABU6fA=
Date: Fri, 22 Aug 2025 02:10:07 +0000
Message-ID:
 <SN6PR02MB4157875C0979EFF29626A18CD43DA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250415180728.1789-1-mhklinux@outlook.com>
 <20250415180728.1789-2-mhklinux@outlook.com>
 <f711d4ad-87a8-9cb3-aabc-a493ff18986a@linux.microsoft.com>
 <33b59cc4-2834-b6c7-5ffd-7b9d620a4ce5@linux.microsoft.com>
 <SN6PR02MB4157376DD06C1DC2E28A76B7D432A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <833a0c96-470f-acff-72e7-cc82995fbc2f@linux.microsoft.com>
In-Reply-To: <833a0c96-470f-acff-72e7-cc82995fbc2f@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8534:EE_
x-ms-office365-filtering-correlation-id: b7cd9ea8-3961-41dc-fdf6-08dde1210437
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|19110799012|13091999003|461199028|31061999003|8062599012|8060799015|440099028|40105399003|3412199025|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?MGRrL2RvMUcySmYycVlHcWZWNEh0RHBhc2IyVnZGNC8xa2NxZVB4QXNFNlNF?=
 =?utf-8?B?T0JFMTVkZDZFc1dtNFdRdUhiZ2J6VG9sNUdXazJkNDArN3F4MThBbUZtb3dW?=
 =?utf-8?B?cFNZb2d3ekRpMndPK3pRT2UzV2FPK254YnhUZDc2Lzkxb0k0blVJbm1EODcw?=
 =?utf-8?B?eEREY3NPbllXb1BKSkdVSWZpREV3MWhQZlpzUFhoSXFZWmVvRnRINEFQWDF3?=
 =?utf-8?B?amJNMmdLNEY2SXU1bXlsNjBwS2hzbEVBYU9zaXBmdVJ0K3FCL0RnQ2JWTWgx?=
 =?utf-8?B?UWh2K0xna3N3VWtsRWd3bVdYbHBwK2N4NGlkRENKcHRJQ08vajlDMkdkTTNB?=
 =?utf-8?B?WTVLOEw5dnB5WDNIbHhTWEVJaEJodEthcFU1NzY3Z0xISG5NZ3d1d0tMNVJm?=
 =?utf-8?B?WUt2ZS9TcGZUb1dnSFp3NkhBNHdkTS9BR05nZHFNN2NJcVJXek1QbkFsTXVn?=
 =?utf-8?B?TWs3cjlhRHJIL1IwNm5IaFFNMjFXN2dEcjlmQ3VqR1lJNHhJWlZtdkJHYVBj?=
 =?utf-8?B?VG9mVndhVmQ1bitlVTlra0xvRk1SajhrL3AyZk44R1c0QjhDa2ZLcXJFcm51?=
 =?utf-8?B?MnI0bExHRmpzYk5uMEhrN1NZc0xEMzVOUTI1eC82dnVCZzFGendEREJjQ3Ra?=
 =?utf-8?B?dDFxa0VmKy9Qc1JlMThuVTZKUmk1TDh3UU5LbW56eDBlc1JYVkdQUmdIRDFF?=
 =?utf-8?B?bC8xbGFtc0x4RUd5T1ZleFZwVndhY0JtMHhTeW8vQTl5QkZPNFd6VWNPdXlt?=
 =?utf-8?B?eHYwbTR0VlRiZlMxajV3VDNNQnRCWTcxTFNqdUJtZU5ZNUNGQ0RselI0R2R4?=
 =?utf-8?B?ek9TKzdZRkNNTWhQNEc5U0tDYmpHNUtKeHFic0p1c0NYVnptblc5V1kyMGkw?=
 =?utf-8?B?VUswZngzMU8xWjJGN2tyVE1EYmY0Y1M5SThzdTVhbmlKdElKSjVaSDk3cmRG?=
 =?utf-8?B?SUhqdWY4Vk5STVIyVmVIWWw3THNsWWUrUVczK2dKUDhJQTVKTTVscURxV2d4?=
 =?utf-8?B?ay80MDA3S0tXM3Jic0FSS1FLV3VmOERmQk1VV01MNXlKYUU2OFRHYmRQN0Jo?=
 =?utf-8?B?QnBKbDU5K3Jjb2tuR1FWc2lKZWoyM0pzOW5mRVhXOVkvZ3dnZmFiV2kvYkox?=
 =?utf-8?B?clZ0cDhKYUxsSElZMTJXZGRNL1kzdmM5NXdIWU5BTFVnRVRydWtWVDFnUTZL?=
 =?utf-8?B?MU1VRU5RQysrTExTZTVmeDQ3bDJqTDE5ajg5MW5wRG5COE52d3RhUUlycDM4?=
 =?utf-8?B?NGQxM3J3QjJrYTMyUCtGR0xqU0dDVDhBUlZFNXBiUnBocmlHWGpma0JOcHRt?=
 =?utf-8?B?Ui9sN00ra2d2RGRJc0lKbXU5dGJYTlZTL2phcUF5L2JiN3ozbHd1YzB2Zncw?=
 =?utf-8?B?WXo4K2pTdGZNMm1qRVlZUUpiVlIvb0w3NnRySzA4cHVnZHJSTGlaWFd6dFZQ?=
 =?utf-8?B?dERxYm9uRldXMEsvVnk1WXNBa1kvTHV6UDBWMnFPVkpSRmxxNVNSWUszNmh1?=
 =?utf-8?B?TmkvVElsMWcwVnZiZkc2TEtaOURXeVUvZlRIRlNnRFhvNE4wa0ZIb2NYYVp0?=
 =?utf-8?B?dEo4ekNMNDMwc3ZpeDVLRjU5L1pyMGZkaHA0V2o5dFFPOVMzSFFKR1IyOVE3?=
 =?utf-8?B?cVdPTjVLNC9XcGxISHZBMWgyYXN3dEE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TlBiUkJBVURPNEE0WVVOMkNkUEI3d2xmTlRXUHNBZWVqK1BJWnU3Q25BWUQv?=
 =?utf-8?B?a3cxbWc2cmhreExkN1llMml6WjNnYTNJWjVQeUk2NDkybUZxSlZpTk93TmpZ?=
 =?utf-8?B?b3ZoeStSMngrNVhtYXNjTGtWS0ZCMlRlcnc3c2xxbFhRZjllakl6YUlCb2g4?=
 =?utf-8?B?MXRUaWNaK0JLVWMzTnVQS09UaFNKQjZlUG05TzRkUzE0OUJCblJVNVNVYkha?=
 =?utf-8?B?S3l1TVlBMFlwcWhXTDB5Y2JCSmN2SlVlbENCYmV4dmJQNWdrRTROMkQvQm1s?=
 =?utf-8?B?b25QdDYveS9MRTJ4ZmVXSUIvYXRFTHdhQ3RHdHdQb2hOYmc0Y3YycC9NVlp5?=
 =?utf-8?B?bzRFSG1PUzhSK1Z1K3lDdGZCQnVsWVczU1hwYXdyMU5DVWRDekdhcDFXeTVP?=
 =?utf-8?B?TEtJelJLMFJVdzVhY08rUWNheEVjNTJFd0piZklQUVBiTHlpRkJOUUsxQU1u?=
 =?utf-8?B?RzJSRSs5WU1OejRRRGc4dXFPZXRQQmQxcHlTMW9GVDdENHBNd3FVTTFBUkxN?=
 =?utf-8?B?a1ZVY3NQbkpiUm5yOUprZWpuNmhBckZJMDkxcE04K0VmeDRBZ0pHbm9ISDVD?=
 =?utf-8?B?UUQvVkl2bXlreUxBd3loWEtnU3hLN3hXRGZRUHhkMW5SU2JpdnVVdTd4azU4?=
 =?utf-8?B?TTRYMnhmc09abDlRRG5MR2RtVHl5dy91YitSUlBxSlhSa01lMlNyMGx4UytW?=
 =?utf-8?B?U2dlODhFb2QyeVFaWi9zejJ3cWlzUk5JbzB4OFo4M05XSmdHcDdIRVhoSmt2?=
 =?utf-8?B?UzJ1Z0JCaHAwcUo0a1ZZMUZQMEo1c0d1TFFpVER0S3dqM1ZQVWJYdkFseHBC?=
 =?utf-8?B?N1BUaVAxdm1KemJrNnNXbmoydjgyVmxUVzhqVGk4d0ZJbWkrTXIvcHJBYmxY?=
 =?utf-8?B?NXNHZmt6cStnRXQrTEdaYy9lMEp0ZjJwOEJ6bUVjaVRKVDF3MXVhQUNOdllM?=
 =?utf-8?B?SkRtYlNNbFpPdDdTRklqWlh2MkdiUGU1eHRlR0YyWTFUczNwaWZJZ1pGK2dO?=
 =?utf-8?B?ejRjQjB2WDZEcWNBanE2TXViYW9XRGtTbnUycTRKcW9CTUgyYjRRRmt2WEZt?=
 =?utf-8?B?aEhSQVl5MXhJTWNYL1RJNHJCYjVWK2dSaktqZk9WT1RDdHR1YTFqL2VWQlZt?=
 =?utf-8?B?OGVFaFVZaDRRSDZhVHVQcklNT3Vuc3cyVlo4b1VEZG0zMkdza0FZZzlnYytB?=
 =?utf-8?B?ckp1ZmFaRkxReHlhK1pmTStuTmFmM0gzeXYzY2NZYlBUcCtwT0NKdVJ2UndL?=
 =?utf-8?B?RFJZalRZRGg4Z3Z1WXB6azRDRzViTFowYWdSS1lhOHJueGZxK3Bnb2pXaHc5?=
 =?utf-8?B?WlphMTcvQmh5L1dpSzExamNvNUpsU2llTHlPZFhSZnpJSUZTSHdFRG42QVZG?=
 =?utf-8?B?S1JWeURPRkgxL3JQeFlORUNYSDNSNG1WTDYzYU40Nk93UmhQcVNOcGFidTNy?=
 =?utf-8?B?ZXpvUDdPUHByRnVoNXpMN2VmOXZUYjZRY0szUlRyb2lCcE1UakhEMVVGTjNJ?=
 =?utf-8?B?bk0yVm81SllrZjM4R3Jtb0hPMlJkdnQwNlNydit6dHpvclpFUUJSQmRNZVVH?=
 =?utf-8?B?ejlRd1hVSCtQcjZZVVhGd2lGcGlpVnd1RDN2RC9Ucm0ramtzMndLSy9iZTh2?=
 =?utf-8?Q?MMDOFxon1zYlveVxDSf4h3EFIWhgcVflrbAEqUXsegO0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b7cd9ea8-3961-41dc-fdf6-08dde1210437
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 02:10:07.7288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8534

RnJvbTogTXVrZXNoIFIgPG1yYXRob3JAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogVGh1cnNk
YXksIEF1Z3VzdCAyMSwgMjAyNSAxOjUwIFBNDQo+IA0KPiBPbiA4LzIxLzI1IDEyOjI0LCBNaWNo
YWVsIEtlbGxleSB3cm90ZToNCj4gPiBGcm9tOiBNdWtlc2ggUiA8bXJhdGhvckBsaW51eC5taWNy
b3NvZnQuY29tPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAyMCwgMjAyNQ0KPiA3OjU4IFBNDQo+
ID4+DQo+ID4+IE9uIDgvMjAvMjUgMTc6MzEsIE11a2VzaCBSIHdyb3RlOg0KPiA+Pj4gT24gNC8x
NS8yNSAxMTowNywgbWhrZWxsZXk1OEBnbWFpbC5jb20gd3JvdGU6DQo+ID4+Pj4gRnJvbTogTWlj
aGFlbCBLZWxsZXkgPG1oa2xpbnV4QG91dGxvb2suY29tPg0KPiA+Pj4+DQo+ID4+Pj4NCj4gPHNu
aXA+DQo+ID4+Pg0KPiA+Pj4NCj4gPj4+IElNSE8sIHRoaXMgaXMgdW5uZWNlc3NhcnkgY2hhbmdl
IHRoYXQganVzdCBvYmZ1c2NhdGVzIGNvZGUuIFdpdGggc3RhdHVzIHF1bw0KPiA+Pj4gb25lIGhh
cyB0aGUgYWR2YW50YWdlIG9mIHNlZWluZyB3aGF0IGV4YWN0bHkgaXMgZ29pbmcgb24sIG9uZSBj
YW4gdXNlIHRoZQ0KPiA+Pj4gYXJncyBhbnkgd2hpY2ggd2F5LCBjaGFuZ2UgYmF0Y2ggc2l6ZSBh
bnkgd2hpY2ggd2F5LCBhbmQgaXMgdGh1cyBmbGV4aWJsZS4NCj4gPg0KPiA+IEkgc3RhcnRlZCB0
aGlzIHBhdGNoIHNldCBpbiByZXNwb25zZSB0byBzb21lIGVycm9ycyBpbiBvcGVuIGNvZGluZyB0
aGUNCj4gPiB1c2Ugb2YgaHlwZXJ2X3BjcHVfaW5wdXQvb3V0cHV0X2FyZywgdG8gc2VlIGlmIGhl
bHBlciBmdW5jdGlvbnMgY291bGQNCj4gPiByZWd1bGFyaXplIHRoZSB1c2FnZSBhbmQgcmVkdWNl
IHRoZSBsaWtlbGlob29kIG9mIGZ1dHVyZSBlcnJvcnMuIEJhbGFuY2luZw0KPiA+IHRoZSBwbHVz
ZXMgYW5kIG1pbnVzZXMgb2YgdGhlIHJlc3VsdCwgaW4gbXkgdmlldyB0aGUgaGVscGVyIGZ1bmN0
aW9ucyBhcmUNCj4gPiBhbiBpbXByb3ZlbWVudCwgdGhvdWdoIG5vdCBvdmVyd2hlbG1pbmdseSBz
by4gT3RoZXJzIG1heSBzZWUgdGhlDQo+ID4gdHJhZGVvZmZzIGRpZmZlcmVudGx5LCBhbmQgYXMg
c3VjaCBJIHdvdWxkIG5vdCBnbyB0byB0aGUgbWF0IGluIGFyZ3VpbmcgdGhlDQo+ID4gcGF0Y2hl
cyBtdXN0IGJlIHRha2VuLiBCdXQgaWYgd2UgZG9uJ3QgdGFrZSB0aGVtLCB3ZSBuZWVkIHRvIGdv
IGJhY2sgYW5kDQo+ID4gY2xlYW4gdXAgbWlub3IgZXJyb3JzIGFuZCBpbmNvbnNpc3RlbmNpZXMg
aW4gdGhlIG9wZW4gY29kaW5nIGF0IHNvbWUNCj4gPiBleGlzdGluZyBoeXBlcmNhbGwgY2FsbCBz
aXRlcy4NCj4gDQo+IFllcywgZGVmaW5pdGVseS4gQXNzdW1pbmcgTnVubyBrbm93cyB3aGF0IGlz
c3VlcyB5b3UgYXJlIHJlZmVycmluZyB0bywNCj4gSSdsbCB3b3JrIHdpdGggaGltIHRvIGdldCB0
aGVtIGFkZHJlc3NlZCBhc2FwLiBUaGFua3MgZm9yIG5vdGljaW5nIHRoZW0uDQo+IElmIE51bm8g
aXMgbm90IGF3YXJlLCBJJ2xsIHBpbmcgeW91IGZvciBtb3JlIGluZm8uDQo+IA0KPiANCj4gPj4+
IFdpdGggdGltZSB0aGVzZSBmdW5jdGlvbnMgb25seSBnZXQgbW9yZSBjb21wbGljYXRlZCBhbmQg
ZXJyb3IgcHJvbmUuIFRoZQ0KPiA+Pj4gc2F2aW5nIG9mIHJhbSBpcyB2ZXJ5IG1pbmltYWwsIHRo
aXMgbWFrZXMgYW5hbHl6aW5nIGNyYXNoIGR1bXBzIGhhcmRlciwNCj4gPj4+IGFuZCBpbiBzb21l
IGNhc2VzIGxpa2UgaW4geW91ciBwYXRjaCAzLzcgZGlzYWJsZXMgdW5uZWNlc3NhcmlseSBpbiBl
cnJvciBjYXNlOg0KPiA+Pj4NCj4gPj4+IC0gaWYgKGNvdW50ID4gSFZfTUFYX01PRElGWV9HUEFf
UkVQX0NPVU5UKSB7DQo+ID4+PiAtICBwcl9lcnIoIkh5cGVyLVY6IEdQQSBjb3VudDolZCBleGNl
ZWRzIHN1cHBvcnRlZDolbHVcbiIsIGNvdW50LA0KPiA+Pj4gLSAgIEhWX01BWF9NT0RJRllfR1BB
X1JFUF9DT1VOVCk7DQo+ID4+PiArIGxvY2FsX2lycV9zYXZlKGZsYWdzKTsgICAgICA8PDw8PDw8
DQo+ID4+PiAuLi4NCj4gPg0KPiA+IEZXSVcsIHRoaXMgZXJyb3IgY2FzZSBpcyBub3QgZGlzYWJs
ZWQuIEl0IGlzIGNoZWNrZWQgYSBmZXcgbGluZXMgZnVydGhlciBkb3duIGFzOg0KPiANCj4gSSBt
ZWFudCBkaXNhYmxlZCBpbnRlcnJ1cHRzLiBUaGUgY2hlY2sgbW92ZXMgYWZ0ZXIgZGlzYWJsaW5n
IGludGVycnVwdHMsIHNvDQo+IGl0IHJ1bnMgImRpc2FibGVkIiBpbiB0cmFkaXRpb25hbCBPUyB0
ZXJtaW5vbG9neSA6KS4NCg0KR290IGl0LiBCdXQgd2h5IGlzIGl0IHByb2JsZW0gdG8gbWFrZSB0
aGlzIGNoZWNrIHdpdGggaW50ZXJydXB0cyBkaXNhYmxlZD8NClRoZSBjaGVjayBpcyBqdXN0IGZv
ciByb2J1c3RuZXNzIGFuZCBzaG91bGQgbmV2ZXIgYmUgdHJ1ZSBzaW5jZQ0KaHZfbWFya19ncGFf
dmlzaWJsaXR5KCkgaXMgY2FsbGVkIGZyb20gb25seSBvbmUgcGxhY2UgdGhhdCBhbHJlYWR5IGVu
c3VyZXMNCnRoZSBQRk4gY291bnQgd29uJ3Qgb3ZlcmZsb3cgYSBzaW5nbGUgcGFnZS4NCg0KPiAN
Cj4gPg0KPiA+ICsgICAgICAgaWYgKGNvdW50ID4gYmF0Y2hfc2l6ZSkgew0KPiA+ICsgICAgICAg
ICAgICAgICBwcl9lcnIoIkh5cGVyLVY6IEdQQSBjb3VudDolZCBleGNlZWRzIHN1cHBvcnRlZDol
dVxuIiwgY291bnQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICBiYXRjaF9zaXplKTsNCj4g
Pg0KPiA+Pj4NCj4gPj4+IFNvLCB0aGlzIGlzIGEgbmFrIGZyb20gbWUuIHNvcnJ5Lg0KPiA+Pj4N
Cj4gPj4NCj4gPj4gRnVydGhlcm1vcmUsIHRoaXMgbWFrZXMgdXMgbG9zZSB0aGUgYWJpbGl0eSB0
byBwZXJtYW5lbnRseSBtYXANCj4gPj4gaW5wdXQvb3V0cHV0IHBhZ2VzIGluIHRoZSBoeXBlcnZp
c29yLiBTbywgV2VpIGtpbmRseSB1bmRvLg0KPiA+Pg0KPiA+DQo+ID4gQ291bGQgeW91IGVsYWJv
cmF0ZSBvbiAibG9zZSB0aGUgYWJpbGl0eSB0byBwZXJtYW5lbnRseSBtYXANCj4gPiBpbnB1dC9v
dXRwdXQgcGFnZXMgaW4gdGhlIGh5cGVydmlzb3IiPyBXaGF0IHNwZWNpZmljYWxseSBjYW4ndCBi
ZQ0KPiA+IGRvbmUgYW5kIHdoeT8NCj4gDQo+IElucHV0IGFuZCBvdXRwdXQgYXJlIG1hcHBlZCBh
dCBmaXhlZCBHUEEvU1BBIGFsd2F5cyB0byBhdm9pZCBoeXANCj4gaGF2aW5nIHRvIG1hcC91bm1h
cCBldmVyeSB0aW1lLg0KDQpPSy4gQnV0IGhvdyBkb2VzIHRoaXMgcGF0Y2ggc2V0IGltcGVkZSBk
b2luZyBhIGZpeGVkIG1hcHBpbmc/DQpXb3VsZG4ndCB0aGF0IGZpeGVkIG1hcHBpbmcgYmUgZG9u
ZSBhdCB0aGUgdGltZSB0aGUgcGFnZSBvciBwYWdlcw0KYXJlIGFsbG9jYXRlZCwgYW5kIHRoZW4g
YmUgdHJhbnNwYXJlbnQgdG8gaHlwZXJjYWxsIGNhbGwgc2l0ZXM/DQoNCj4gDQo+ID4gPHNuaXA+
DQo+ID4NCj4gPj4+DQo+ID4+Pj4gKy8qDQo+ID4+Pj4gKyAqIEFsbG9jYXRlIG9uZSBwYWdlIHRo
YXQgaXMgc2hhcmVkIGJldHdlZW4gaW5wdXQgYW5kIG91dHB1dCBhcmdzLCB3aGljaCBpcw0KPiA+
Pj4+ICsgKiBzdWZmaWNpZW50IGZvciBhbGwgY3VycmVudCBoeXBlcmNhbGxzLiBJZiBhIGZ1dHVy
ZSBoeXBlcmNhbGwgcmVxdWlyZXMNCj4gPj4+DQo+ID4+PiBUaGF0IGlzIGluY29ycmVjdC4gV2Un
dmUgaW9tbXUgbWFwIGh5cGVyY2FsbHMgdGhhdCB3aWxsIHVzZSB1cCBlbnRpcmUgcGFnZQ0KPiA+
Pj4gZm9yIGlucHV0LiBNb3JlIGNvbWluZyBhcyB3ZSBpbXBsZW1lbnQgcmFtIHdpdGhkcmF3bCBm
cm9tIHRoZSBoeXBlcnZpc29yLg0KPiA+DQo+ID4gQXQgbGVhc3Qgc29tZSBmb3JtIG9mIHJhbSB3
aXRoZHJhd2FsIGlzIGFscmVhZHkgaW1wbGVtZW50ZWQgdXBzdHJlYW0gYXMNCj4gPiBodl9jYWxs
X3dpdGhkcmF3X21lbW9yeSgpLiBUaGUgaHlwZXJjYWxsIGhhcyBhIHZlcnkgc21hbGwgaW5wdXQg
dXNpbmcgdGhlDQo+ID4gaHZfc2V0dXBfaW4oKSBoZWxwZXIsIGJ1dCB0aGUgb3V0cHV0IGxpc3Qg
b2YgUEZOcyBtdXN0IGdvIHRvIGEgc2VwYXJhdGVseQ0KPiA+IGFsbG9jYXRlZCBwYWdlIHNvIGl0
IGNhbiBiZSByZXRhaW5lZCB3aXRoIGludGVycnVwdHMgZW5hYmxlZCB3aGlsZQ0KPiA+IF9fZnJl
ZV9wYWdlKCkgaXMgY2FsbGVkLiBUaGUgdXNlIG9mIHRoaXMgc2VwYXJhdGUgb3V0cHV0IHBhZ2Ug
cHJlZGF0ZXMgdGhlDQo+ID4gaW50cm9kdWN0aW9uIG9mIHRoZSBodl9zZXR1cF9pbigpIGhlbHBl
ci4NCj4gDQo+IFllYWgsIEkgYW0gdGFsa2luZyBhYm91dCBoeXAgbWVtb3J5IHRoYXQgbG9hZGVy
IGdpdmVzIGl0LCBhbmQgZHVyaW5nIHRoZQ0KPiBsaWZldGltZSBpdCBhY2N1bXVsYXRlcyBmb3Ig
Vk1zLiBXZSBhcmUgb3BlbmluZyB0aGUgZmxvb2QgZ2F0ZXMsIHNvIHlvdQ0KPiB3aWxsIHNlZSBs
b3RzIHBhdGNoZXMgdmVyeSBzb29uLg0KPiANCj4gDQo+ID4gRm9yIGlvbW11IG1hcCBoeXBlcmNh
bGxzLCB3aGF0IGRvIHRoZSBpbnB1dCBhbmQgb3V0cHV0IGxvb2sgbGlrZT8gSXMgdGhlDQo+ID4g
cGFyYWRpZ20gZGlmZmVyZW50IGZyb20gdGhlIHR5cGljYWwgc21hbGwgZml4ZWQgcG9ydGlvbiBw
bHVzIGEgdmFyaWFibGUgc2l6ZQ0KPiA+IGFycmF5IG9mIHZhbHVlcyB0aGF0IGFyZSBmZWQgaW50
byBhIHJlcCBoeXBlcmNhbGw/IElzIHRoZXJlIGFsc28gYSBsYXJnZSBhbW91bnQNCj4gPiBvZiBv
dXRwdXQgZnJvbSB0aGUgaHlwZXJjYWxsPyBKdXN0IGN1cmlvdXMgaWYgdGhlcmUncyBhIGNhc2Ug
dGhhdCdzIGZ1bmRhbWVudGFsbHkNCj4gPiBkaWZmZXJlbnQgZnJvbSB0aGUgY3VycmVudCBzZXQg
b2YgaHlwZXJjYWxscy4NCj4gDQo+IFBhdGNoZXMgY29taW5nIHNvb24sIGJ1dCBhdCBoaWdoIGxl
dmVsLCBoeXBlcmNhbGwgaW5jbHVkZXMgbGlzdCBvZiBTUEFzDQo+IHRoYXQgaHlwZXZpc29yIHdp
bGwgbWFwIGludG8gdGhlIGlvbW11LiBUaGVzZSBjYW4gZ2V0IGxhcmdlLiBXZSB3aWxsIGJlDQo+
IGV4cGxvcmluZyB3aGF0IHdlIGNhbiBkbyBiZXR0ZXIgdG8gcGFzcyB0aGVtLCBwZXJoYXBzIG11
bHRpcGxlIHBhZ2VzLCBub3QNCj4gc3VyZSB5ZXQsIGJ1dCBmb3Igbm93IGl0J3Mgc2luZ2xlIHBh
Z2UuDQoNClRvIGJlIGNsZWFyLCBpZiB0aGUgaW9tbXUgaHlwZXJjYWxsIGRvZXMgbm90IHByb2R1
Y2UgYW55IG91dHB1dCwgdGhpcyBwYXRjaA0Kc2V0IHVzZXMgdGhlIGVudGlyZSBwZXItY3B1IGh5
cGVyY2FsbCBhcmcgcGFnZSBmb3IgaW5wdXQuIEZvciBleGFtcGxlLA0KaHZfbWFya19ncGFfdmlz
aWJpbGl0eSgpIHVzZXMgdGhlIGVudGlyZSBwYWdlIGZvciBpbnB1dCwgd2hpY2ggaXMgbW9zdGx5
IGFuDQphcnJheSBvZiBQRk5zLg0KDQpVc2luZyBtdWx0aXBsZSBpbnB1dCBwYWdlcyBpcyBkZWZp
bml0ZWx5IGEgbmV3IHBhcmFkaWdtLCBvbiBib3RoIHRoZQ0KaHlwZXJ2aXNvciBhbmQgZ3Vlc3Qg
c2lkZXMsIGFuZCB0aGF0IHdpbGwgbmVlZCBhZGRpdGlvbmFsIGluZnJhc3RydWN0dXJlLA0Kd2l0
aCBvciB3aXRob3V0IHRoaXMgcGF0Y2ggc2V0Lg0KDQpJJ20ganVzdCB0cnlpbmcgdG8gdW5kZXJz
dGFuZCB3aGVyZSB0aGVyZSBhcmUgcmVhbCB0ZWNobmljYWwgYmxvY2tlcnMgdnMuDQpjb25jZXJu
IGFib3V0IHRoZSBzdHlsZSBhbmQgdGhlIGVuY2Fwc3VsYXRpb24gdGhlIGhlbHBlcnMgaW1wb3Nl
Lg0KDQpNaWNoYWVsDQo=

