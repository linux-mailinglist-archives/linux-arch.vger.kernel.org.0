Return-Path: <linux-arch+bounces-13515-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 793BEB55347
	for <lists+linux-arch@lfdr.de>; Fri, 12 Sep 2025 17:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41BA81890492
	for <lists+linux-arch@lfdr.de>; Fri, 12 Sep 2025 15:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162D4221D87;
	Fri, 12 Sep 2025 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cdGXbzyg"
X-Original-To: linux-arch@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011006.outbound.protection.outlook.com [52.103.1.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B30B155A4E;
	Fri, 12 Sep 2025 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.1.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690765; cv=fail; b=PxMM/M4qqYlh2II2/J+qA4be4tVSkXLCxFEDmm9KCNdZ/VKRVvARXzzo3LQkOCFK2Fv9WCKV7anjlwD4tWdLR53HwE/k899b+hFiX8XP7MOs0cdwXssPslvuwA1kXO42A/VOit9oiOv5GLE9nl2lAW5s8xu84wU5pvxRKUr+7A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690765; c=relaxed/simple;
	bh=E5M8RJpW5OEy8IyxYt1FhrMlqN8Dz9fyTtJJakNPgNs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dq2gNNjIb+zRr0tTImPp77HtcN5UZ1C3lz8lof5ErgwkXqR389BIohSSrAKE0zmw/YwzMltfTrunMGmPCGTQb0MzDmXe61Q3eHKDHpM+D4llcbWuDv8YArF4CS5rT8Ta5gso8JIWxhJ4LRd5rv6FrP/D1TEY94vMA4B6fz7Hc20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cdGXbzyg; arc=fail smtp.client-ip=52.103.1.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUiJQEUSRM7eAp30/HqnuzJt5oOqAifZ19AeNf9E6iEUdRqzs18huJb5cdnsJehDiCHscemv1AmuXclrkgYo+m6gLbM5mEGOgWhMDO+qHfA1xH8eKhqwQlYBS8Hebu6G5Wuk1JSKazMF4dy2PNAsW/sWzBnLCTSwyT6ChWUb8NTg6bhU7jS/Z0MfIYpKfAJKBFSpB/o2gJbVvQ/NvrriAZbYjyNZt4Uj2xTYfrENv+JG8RabaLSAZg0oaffi6h6JX+Tskk9QDvDd5aKDsVRxKJmiqLvC7BXl8qTpaSOUunZkYoUSimQKkGplqIBtvqmdsoIB5E9MvUeCegg12LRjJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5M8RJpW5OEy8IyxYt1FhrMlqN8Dz9fyTtJJakNPgNs=;
 b=AGQOr0rrZUqGpH3FTq4cTC9AXUV+ioyl1p10Pd4lbwGM/miUNsEXX6ibFiaphYcOR2tQaWsEFlHPvEvmt4ZLrIV6BNP1ANRv2T2xDu57oRcZvhq9ImrfQL6QO7u2sY8H53HupG+y5eaZD24hhPtVhiXbBiRSyImNr/Qvt0hkiJ9C/zA+DE6wFKneh+tqvhapTeDIoNWKrQZyzwGobRNPFfWrJY6TTqOSVdqjLyS6bxUX8kuxBV9ByowuROLSFl36jSnP6inXhuLiAEaR9xofQgec6ik44BxjkQpMcbUybCwraT76mxYJqvTDUwhuoNypRihbBUe1TJwhpj/VajQFQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5M8RJpW5OEy8IyxYt1FhrMlqN8Dz9fyTtJJakNPgNs=;
 b=cdGXbzygOz/n7pUYSBBtdS1rEWUKSkdkkUHd9rjH68R1P9RSKatiIlpQW3Jhyyrma0OfcSBMKHClGY7SKOsyGCsanokIsWc1LtpjMso4RjQgxWHmGNiuCI32K3dNIAUuclZVgUlVQWItZbRa2ik4VF1mOJs7kcZhGiy7ihzlwNLMPvnp5r78eP0PE0H9DLgiFw55Iqk+jDnE8VS26jQuFBcz4YuZvV68RCD6PeD2YUVM5id/xqPihI2zTw2kB0HFFSW6xFmf5XaE6XYDb3cFcI8nHwsyDsoKdsxe9XAg6QES04mECyZmtMBgOJBhAwodT5NFm2eQ1snKApWVtkCG7Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS4PR02MB10865.namprd02.prod.outlook.com (2603:10b6:8:2a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 15:26:00 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 15:26:00 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Kelley <mhklinux@outlook.com>, Mukesh R
	<mrathor@linux.microsoft.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
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
Thread-Index:
 AQHbrjFiyn0GJkB9FUywLGBELxbpZ7RtCZwAgAAo6gCAAQmaEIAAIayAgABU6fCAAZsygIAEU29AgBvzZ5A=
Date: Fri, 12 Sep 2025 15:25:59 +0000
Message-ID:
 <SN6PR02MB4157BF605BE8EE1777AE1860D408A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250415180728.1789-1-mhklinux@outlook.com>
 <20250415180728.1789-2-mhklinux@outlook.com>
 <f711d4ad-87a8-9cb3-aabc-a493ff18986a@linux.microsoft.com>
 <33b59cc4-2834-b6c7-5ffd-7b9d620a4ce5@linux.microsoft.com>
 <SN6PR02MB4157376DD06C1DC2E28A76B7D432A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <833a0c96-470f-acff-72e7-cc82995fbc2f@linux.microsoft.com>
 <SN6PR02MB4157875C0979EFF29626A18CD43DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <d6e63ef3-bdd2-f185-f065-76b333dd1fc3@linux.microsoft.com>
 <SN6PR02MB41575CDB3874DB0867FF9E8FD43EA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB41575CDB3874DB0867FF9E8FD43EA@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS4PR02MB10865:EE_
x-ms-office365-filtering-correlation-id: fe928f39-f6ab-41ea-287c-08ddf210ad79
x-ms-exchange-slblob-mailprops:
 dx7TrgQSB6fOgpu0AmRux6KMzGkolm4j37l0vOyGSs2gMyQe2qm9+ZOXNTyvsZqyssPF8JB96y1P8Lu0+Sub/cDIyZZBy4x/ZUFzmjZOSzAh2VpNEzjsRegFznW1piCD/rFDNk4BNt5hfB7AYX35O77JMdHXa1SvU9TnqVl3NBQsKs0jKsMsIHbak2ylZrCKiU/s3y1tN35tnOLck4eG9nPBkEuEWlGrrv/iI719cirC0ZwD4HsX56gmsMJqyRSajyeSxrLjkvilnZMHrarteuiwsLDHpDCubWQSYwyPXaAFx/pTr8FDcJNEddzat0HaXL7TweHUO2HOwCzaU+aKTsGSR8ahNdNY9cIZHvtafVXkOauuQ+JUpP4LYTo/HuQJHn5IR2WYihmSOFRcDf2viDQZpAkZTAP5pWPubaQpkW7H92svkUH4Tcw6bG24p/7fcn/4xNAJOZ6aL6L8vlJvMo8A1C6zAAdzvRoSyWG/hMdO8y9iA7LYAlGKP3318W1V+bOAE8n39s3Y0sRmBWI2pe/qY0klf37YBN+ukXD1X9eWWQr9xazw7aWXgsGDuLBbN7+EbGjBHGW+M/CQDOQSbrFtoa4cvRCvuvMx1qF7h2Tqj5O3w7L4Ebbh4yPwpPs3rSIQ0NuEuU6e/nZ+K3Ul7s7lPrSzxW/tTLtSd95f2iZkXgznZbKL3kgAcsnIGp4VQreLhqFRdPpqwoMrTi2aaxiB0l4fCUWgVtB1vGAsc1D2ra05oGXjhBiSANUvWPz4LlGL5/C21bk=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|19110799012|31061999003|461199028|8062599012|13091999003|15080799012|41001999006|51005399003|3412199025|40105399003|440099028|12091999003|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?ekV6Y1pRNXpxTFpuWFFQVHBtaTdHZjJpR2F5dVJnSE5XdnZmcWEvMWwzdjR0?=
 =?utf-8?B?c0pFMm9NVDRCVDkreGFneWJocVlvSU53K1AyU2JiWVhhNGN2bVNGVlZRVmx2?=
 =?utf-8?B?ZTltMkxsVURDQ1dvRlMzUWMveml5cVVKeTJ6dlRLL2VLNmp0dVBGR2VzRmJi?=
 =?utf-8?B?STFOcEFoTUdCd08wRUlCeXZ5U0ZNb2dPeDhzaG1RUDBsNERHQXdMTG0vUkxq?=
 =?utf-8?B?U2puZFpoSzFmMkRHWi9VcGE5ZHZReS9FWFNucDVQRUllYkRNSTV3VHJienlB?=
 =?utf-8?B?TnRsbHFHa1VEYURRTnVPbVBldFNXNmhTdmpZNEFBVHdFSzg2VGMxb2E0RHZ1?=
 =?utf-8?B?Wnd3UU1TYk9pWWl6Y3ROVVFCQ0RGWkc0UDZJM0F3ZlUvNjl5czZQRXhkb2pq?=
 =?utf-8?B?R0JDcDBGTTlYOUE5d3NrZEsvRW1DMVA2T2tlcDBKTEFLSkVqZnl1dkNGZTRl?=
 =?utf-8?B?SUdFSkRJU2x4S3VodzlLWklvcFhVUWJXWFZwTktwYSs1akgwbWhLUVpQN3hW?=
 =?utf-8?B?bE5VcDVRaXoxUHRVR1huTWVjclNOb3I5Y0hrR0hqQWN5ajZJRXBuTnF3ZkJK?=
 =?utf-8?B?RG5SWU1vNk92WGJWN0Q5Rkl6d0ZWdk9HZjRpd29VVk9iMUN2eVl3bUlvYkFE?=
 =?utf-8?B?cHF3eUk4c2w5bjNFdElXUEZ3MmlpdldEWXVhbGpLSmRxWFhsaCtFanRoQnI5?=
 =?utf-8?B?eHJHaVdORGNkSFozOFVtR0dnSWJINVQwR1FCZ2FNQjNWWUdHWUJXbzV4ZDdT?=
 =?utf-8?B?d1VHOGtrZElLU3ZiU3l3Z2poZWpnR2dVc0lteGtDVEhIaEIxL0Fua1ZRMCtP?=
 =?utf-8?B?UFhxaDFQYkNYS2p3V3lMLzJQcDFCS3VYbE1BSFZjRkR5YWYybTF3YkN3V2dZ?=
 =?utf-8?B?Znd6cDhCQzdxa0tqSlc2bGt2dHJHUTdFeTE4aEdxMTYzMjMwQjUxV2M3UVZL?=
 =?utf-8?B?UktQOXJnRStFcUxTNytvdkdwdks0WDVncVNScWgxNUQyM2hwbUg3YnpONVlP?=
 =?utf-8?B?L0szUW42NHVTMERGZ0FKbjRBM1cxY3ZSYnZGMUVIQjJJcHA5RlhJSGlkS25H?=
 =?utf-8?B?dUlrRnUvUkpzcUxUR1oraEh0UE8xTmcvT1oyQW5xTXN6ZktWRm05c1ZXZktW?=
 =?utf-8?B?WjA5RDBhdjUxMVBzZlZVWGtCNTFzMkQ4VFJpSTF1K3ROR1RwWndIOEc4QnNY?=
 =?utf-8?B?bTlUNElkM0RTOEQ5MFBTUmVhRTRSckV0bk1TMHZPbnBHMEF1eERuYTVhTisw?=
 =?utf-8?B?Y1hVNncvTk41SHdITW1nTTNKZDU5Qi8xYXlaaFRtWHdTZmQxWjYrbXFTVkZQ?=
 =?utf-8?B?WEM2eU5RNmVDZzZyWmRsMzVkNzM4WUxnTHV0Rk01Nkp2VExLNlZrODRSSmUv?=
 =?utf-8?B?TlIvUE5FRzdOVnJtL1Y3VWYyY09XZTRpUS9tVjVlYmZtcWpHUEhkajRhY1JE?=
 =?utf-8?B?U25HWXljYXE0VTFTWG9UbGgwUjk3bkNMNFpHYkE2OGlHekNyQkZqUmIxZ2dW?=
 =?utf-8?B?MlhUb3lMWU83K3NkTmkzZFhlOWkvQllvSGFNVVpRN2krbWc1Qi9hZnhsU0hv?=
 =?utf-8?B?QUxiaEVTTmw0V3dGMkU5c1Ztd2poRmQ2VENBdmViSVRxb1V2eGErd0pTYW5F?=
 =?utf-8?B?Z0kxWlQrNTd0TW9QTEFwUThmdmlNQnpCckxoR0NLZ0hta0tRQmVDbE5JdmR0?=
 =?utf-8?B?eXZFVGlWdEtUQXZvRVpsNFhvKzBxUkdCRWJGalUvNHlQSUhNUi8yK0NlQk5N?=
 =?utf-8?Q?IeDTeoFKjP4IzlBUePd5o7oCgSPs0wH5UmTmaKw?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NVRWdXpTVWY2eFVtVDFNY3ZGRDVEQTdzWEFSdDdndUQ1OFdzVUt3b2xSSUFr?=
 =?utf-8?B?MEJGNHJzSW4ySlBpU212eEQxdlFnOWpxZ0ptenIyQllGaWJaZVRMZHg2ODZk?=
 =?utf-8?B?QkZIMndhdTNkZFdwclZWNUdBVjl5Y0dlTkRwSmZJLy95MlUxMHRzcUp5MitB?=
 =?utf-8?B?c25iMlJDSklkQS9rZmVKYklkTlZCTnNJUXNCRCtsZUNXYVl5Q21mOEQ1K0xt?=
 =?utf-8?B?T0ZsL2Y4c1VkSCtJQUdJZkN1cHFVY2J5bWNPYXplZ2N1UVRDTmtwQ29iMGFB?=
 =?utf-8?B?dWpDNVR4azB6cTVOV1RoYzg1SkVNNmJENHhqL1NNaVptdVVVWjVCTkdXUkVN?=
 =?utf-8?B?dnpqRXdKYURBdTNJV2FPSnNVU1IrUGM1bTRsb0U0QzBaQmdOMVNvK24wcjMv?=
 =?utf-8?B?Q05JUTYwN2FDaGJUSEhvczFFNXdPaFpOcFlaeVhjd2tVU093NWdXYXJWREwz?=
 =?utf-8?B?UFIraVMxYWJ1WStnaS9VckhNZlBHdTZ6RUwvVERhS3JwUzhVaFNLUkloVER2?=
 =?utf-8?B?MVdzaVpYRTVCU25NYkVnYmwxU2I0eUJvbmhJMkFaV2o0dXlXVGxlYXFzWFdr?=
 =?utf-8?B?SlpTMXI2dVg3aUZ6VjF1K0NSS2JqOGh3cjVuRTVlVGVzNmc0RSs1aGR2RmZq?=
 =?utf-8?B?ZENESE14UkpveG5LRVV2bnB6cXpNbHRRQWtTTktweHZQdi9Oa1BCYkJFUHhJ?=
 =?utf-8?B?SDJKeUJQZktRQWFWdDdpWjF0ODlaZzMyMCs3dmhaUnpDZERKUzgyTnAyRUhX?=
 =?utf-8?B?YzM3eXNESnMxeHg1aVN3d2FQK0VJbkxsNzZlUWJJbStVbkVxTFZXQmFCZGJY?=
 =?utf-8?B?RmROWVhselpEa1FEQk5mZXNWQzJBd0R6cktDQ05zQWVwZE9OTjBDdzhMS25J?=
 =?utf-8?B?MXhDc29WaURpSXV1aFMxYnRxcDE5R3RQdmQ2UnAxVHJlUjJSQW9DNjNkc2tK?=
 =?utf-8?B?bysyb24yOFRRMER6SXQyWnEzWVZ6VU1qckxPdEVtUExQSkJ1VzY5V0l0R055?=
 =?utf-8?B?RU55TXRBSlJEbTZ1QXBZTlNyNVRuS0NKWHcvSnQ4cjJwRnB1V2k5SU1uMmU4?=
 =?utf-8?B?WitiUHUyQTlWUkJGbk9qcHJNU0NjbDEweG5VZ2JZZ3RvbzM0b0tiaForWUVM?=
 =?utf-8?B?aTV0ek00MTRXSjdKcXl0VU5CY0FYSzZyWS9pNVpOc3BqZk5HczhEOWo4c041?=
 =?utf-8?B?QjM0eExVZFBGNmhIbzVqU2tKN3ByUUxjbUpmU0VHMkErR0NjYXBOaVBtczY2?=
 =?utf-8?B?aFJFUVNDOVErQVFDekd1dFdpbFdwYm1lcElURGFaNVc3ejh3cktNLzRHT0Uz?=
 =?utf-8?B?eWIzVC9wbk84N1BoODBONXAxdEJQMjZBN3N6UmJwRXhVTFFON0tZSEkrUm5m?=
 =?utf-8?B?QUZLZmJjVm5XdUVMTFQ4VDg4MS85ZUxUSDh2TkxrcFN5U1hsazJIUHVtamdp?=
 =?utf-8?B?NlR4RDlHN2JhcEhnQXdUOWF5M0ZIcjhpbmUvSkF1cHA4NHNEVzFLOS8vK1ZK?=
 =?utf-8?B?YU1hL21Mb0xFbTEySk9tdHhtWnJwYWlpL2UzU0g3UDFoS3ZXMnFPQlNua0lQ?=
 =?utf-8?B?ZThPOUVkTGhtVXh6QTZnQ0t6amR4Mm9iWjJvV3EyWlhHUXkwQTZYcTRRa3Fq?=
 =?utf-8?Q?Z4Jgt21Q3lS3qLDUdICwmZLU0hxKEcrokT2eRvvpkxVk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fe928f39-f6ab-41ea-287c-08ddf210ad79
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 15:26:00.0040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR02MB10865

RnJvbTogTWljaGFlbCBLZWxsZXkgPG1oa2xpbnV4QG91dGxvb2suY29tPiBTZW50OiBNb25kYXks
IEF1Z3VzdCAyNSwgMjAyNSAyOjAxIFBNDQo+IA0KPiBGcm9tOiBNdWtlc2ggUiA8bXJhdGhvckBs
aW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBGcmlkYXksIEF1Z3VzdCAyMiwgMjAyNSA3OjI1IFBN
DQo+ID4NCj4gPiBPbiA4LzIxLzI1IDE5OjEwLCBNaWNoYWVsIEtlbGxleSB3cm90ZToNCj4gPiA+
IEZyb206IE11a2VzaCBSIDxtcmF0aG9yQGxpbnV4Lm1pY3Jvc29mdC5jb20+IFNlbnQ6IFRodXJz
ZGF5LCBBdWd1c3QgMjEsIDIwMjUgMTo1MCBQTQ0KPiA+ID4+DQo+ID4gPj4gT24gOC8yMS8yNSAx
MjoyNCwgTWljaGFlbCBLZWxsZXkgd3JvdGU6DQo+ID4gPj4+IEZyb206IE11a2VzaCBSIDxtcmF0
aG9yQGxpbnV4Lm1pY3Jvc29mdC5jb20+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDIwLCAyMDI1
IDc6NTggUE0NCj4gPiA+Pj4+DQo+ID4gPj4+PiBPbiA4LzIwLzI1IDE3OjMxLCBNdWtlc2ggUiB3
cm90ZToNCj4gPiA+Pj4+PiBXaXRoIHRpbWUgdGhlc2UgZnVuY3Rpb25zIG9ubHkgZ2V0IG1vcmUg
Y29tcGxpY2F0ZWQgYW5kIGVycm9yIHByb25lLiBUaGUNCj4gPiA+Pj4+PiBzYXZpbmcgb2YgcmFt
IGlzIHZlcnkgbWluaW1hbCwgdGhpcyBtYWtlcyBhbmFseXppbmcgY3Jhc2ggZHVtcHMgaGFyZGVy
LA0KPiA+ID4+Pj4+IGFuZCBpbiBzb21lIGNhc2VzIGxpa2UgaW4geW91ciBwYXRjaCAzLzcgZGlz
YWJsZXMgdW5uZWNlc3NhcmlseSBpbiBlcnJvciBjYXNlOg0KPiA+ID4+Pj4+DQo+ID4gPj4+Pj4g
LSBpZiAoY291bnQgPiBIVl9NQVhfTU9ESUZZX0dQQV9SRVBfQ09VTlQpIHsNCj4gPiA+Pj4+PiAt
ICBwcl9lcnIoIkh5cGVyLVY6IEdQQSBjb3VudDolZCBleGNlZWRzIHN1cHBvcnRlZDolbHVcbiIs
IGNvdW50LA0KPiA+ID4+Pj4+IC0gICBIVl9NQVhfTU9ESUZZX0dQQV9SRVBfQ09VTlQpOw0KPiA+
ID4+Pj4+ICsgbG9jYWxfaXJxX3NhdmUoZmxhZ3MpOyAgICAgIDw8PDw8PDwNCj4gPiA+Pj4+PiAu
Li4NCj4gPiA+Pj4NCj4gPiA+Pj4gRldJVywgdGhpcyBlcnJvciBjYXNlIGlzIG5vdCBkaXNhYmxl
ZC4gSXQgaXMgY2hlY2tlZCBhIGZldyBsaW5lcyBmdXJ0aGVyIGRvd24gYXM6DQo+ID4gPj4NCj4g
PiA+PiBJIG1lYW50IGRpc2FibGVkIGludGVycnVwdHMuIFRoZSBjaGVjayBtb3ZlcyBhZnRlciBk
aXNhYmxpbmcgaW50ZXJydXB0cywgc28NCj4gPiA+PiBpdCBydW5zICJkaXNhYmxlZCIgaW4gdHJh
ZGl0aW9uYWwgT1MgdGVybWlub2xvZ3kgOikuDQo+ID4gPg0KPiA+ID4gR290IGl0LiBCdXQgd2h5
IGlzIGl0IHByb2JsZW0gdG8gbWFrZSB0aGlzIGNoZWNrIHdpdGggaW50ZXJydXB0cyBkaXNhYmxl
ZD8NCj4gPg0KPiA+IFlvdSBhcmUgY3JlYXRpbmcgZGlzYWJsaW5nIG92ZXJoZWFkIHdoZXJlIHRo
YXQgb3ZlcmhlYWQgcHJldmlvdXNseQ0KPiA+IGRpZCBub3QgZXhpc3QuDQo+IA0KPiBJJ20gbm90
IGNsZWFyIG9uIHdoYXQgeW91IG1lYW4gYnkgImRpc2FibGluZyBvdmVyaGVhZCIuIFRoZSBleGlz
dGluZyBjb2RlDQo+IGRvZXMgdGhlIGZvbGxvd2luZzoNCj4gDQo+IDEpIFZhbGlkYXRlIHRoYXQg
ImNvdW50IiBpcyBub3QgdG9vIGJpZywgYW5kIHJldHVybiBhbiBlcnJvciBpZiBpdCBpcy4NCj4g
MikgRGlzYWJsZSBpbnRlcnJ1cHRzDQo+IDMpIFBvcHVsYXRlIHRoZSBwZXItY3B1IGh5cGVyY2Fs
bCBpbnB1dCBhcmcNCj4gNCkgTWFrZSB0aGUgaHlwZXJjYWxsDQo+IDUpIFJlLWVuYWJsZSBpbnRl
cnJ1cHRzDQo+IA0KPiBXaXRoIHRoZSBwYXRjaCwgc3RlcHMgMSBhbmQgMiBhcmUgZG9uZSBpbiBh
IGRpZmZlcmVudCBvcmRlcjoNCj4gDQo+IDIpIERpc2FibGUgaW50ZXJydXB0cw0KPiAxKSBWYWxp
ZGF0ZSB0aGF0ICJjb3VudCIgaXMgbm90IHRvbyBiaWcuIFJlLWVuYWJsZSBpbnRlcnJ1cHRzIGFu
ZCByZXR1cm4gYW4gZXJyb3IgaWYgaXQgaXMuDQo+IDMpIFBvcHVsYXRlIHRoZSBwZXItY3B1IGh5
cGVyY2FsbCBpbnB1dCBhcmcNCj4gNCkgTWFrZSB0aGUgaHlwZXJjYWxsDQo+IDUpIFJlLWVuYWJs
ZSBpbnRlcnJ1cHRzDQo+IA0KPiBWYWxpZGF0aW5nICJjb3VudCIgd2l0aCBpbnRlcnJ1cHRzIGRp
c2FibGVkIGlzIHByb2JhYmx5IGFuIGFkZGl0aW9uYWwNCj4gMiBvciAzIGluc3RydWN0aW9ucyBl
eGVjdXRlZCB3aXRoIGludGVycnVwdHMgZGlzYWJsZWQsIHdoaWNoIGlzIG5lZ2xpZ2libGUNCj4g
Y29tcGFyZWQgdG8gdGhlIHRob3VzYW5kcyAob3IgbW9yZSkgb2YgaW5zdHJ1Y3Rpb25zIHRoZSBo
eXBlcmNhbGwgd2lsbA0KPiBleGVjdXRlIHdpdGggaW50ZXJydXB0cyBkaXNhYmxlZC4NCj4gDQo+
IE9yIGFyZSB5b3UgcmVmZXJyaW5nIHRvIHNvbWV0aGluZyBlbHNlIGFzICJkaXNhYmxpbmcgb3Zl
cmhlYWQiPw0KDQpNdWtlc2ggLS0gYW55dGhpbmcgZnVydGhlciBvbiB3aGF0IHlvdSBzZWUgYXMg
dGhlIHByb2JsZW0gaGVyZT8NCkknbSBqdXN0IG5vdCBnZXR0aW5nIHdoYXQgeW91ciBjb25jZXJu
IGlzLg0KDQpbc25pcF0NCg0KPiA+ID4+Pj4gRnVydGhlcm1vcmUsIHRoaXMgbWFrZXMgdXMgbG9z
ZSB0aGUgYWJpbGl0eSB0byBwZXJtYW5lbnRseSBtYXANCj4gPiA+Pj4+IGlucHV0L291dHB1dCBw
YWdlcyBpbiB0aGUgaHlwZXJ2aXNvci4gU28sIFdlaSBraW5kbHkgdW5kby4NCj4gPiA+Pj4+DQo+
ID4gPj4+DQo+ID4gPj4+IENvdWxkIHlvdSBlbGFib3JhdGUgb24gImxvc2UgdGhlIGFiaWxpdHkg
dG8gcGVybWFuZW50bHkgbWFwDQo+ID4gPj4+IGlucHV0L291dHB1dCBwYWdlcyBpbiB0aGUgaHlw
ZXJ2aXNvciI/IFdoYXQgc3BlY2lmaWNhbGx5IGNhbid0IGJlDQo+ID4gPj4+IGRvbmUgYW5kIHdo
eT8NCj4gPiA+Pg0KPiA+ID4+IElucHV0IGFuZCBvdXRwdXQgYXJlIG1hcHBlZCBhdCBmaXhlZCBH
UEEvU1BBIGFsd2F5cyB0byBhdm9pZCBoeXANCj4gPiA+PiBoYXZpbmcgdG8gbWFwL3VubWFwIGV2
ZXJ5IHRpbWUuDQo+ID4gPg0KPiA+ID4gT0suIEJ1dCBob3cgZG9lcyB0aGlzIHBhdGNoIHNldCBp
bXBlZGUgZG9pbmcgYSBmaXhlZCBtYXBwaW5nPw0KPiA+DQo+ID4gVGhlIG91dHB1dCBhZGRyZXNz
IGNhbiBiZSB2YXJpZWQgZGVwZW5kaW5nIG9uIHRoZSBoeXBlcmNhbGwsIGluc3RlYWQNCj4gPiBv
ZiBpdCBiZWluZyBmaXhlZCBhbHdheXMgYXQgZml4ZWQgYWRkcmVzczoNCj4gPg0KPiA+ICAgICAg
ICAgICAqKHZvaWQgKiopb3V0cHV0ID0gc3BhY2UgKyBvZmZzZXQ7IDw8PDw8PA0KPiANCj4gQWdy
ZWVkLiBCdXQgc2luY2UgbWFwcGluZ3MgZnJvbSBHUEEgdG8gU1BBIGFyZSBwYWdlIGdyYW51bGFy
LCBoYXZpbmcNCj4gc3VjaCBhIGZpeGVkIG1hcHBpbmcgbWVhbnMgdGhhdCB0aGVyZSdzIGEgbWFw
cGluZyBmb3IgZXZlcnkgYnl0ZSBpbg0KPiB0aGUgcGFnZSBjb250YWluaW5nIHRoZSBHUEEgdG8g
dGhlIGNvcnJlc3BvbmRpbmcgYnl0ZSBpbiB0aGUgU1BBLA0KPiByaWdodD8gU28gZXZlbiB0aG91
Z2ggdGhlIG9mZnNldCBhYm92ZSBtYXkgdmFyeSBhY3Jvc3MgaHlwZXJjYWxscywNCj4gdGhlIG91
dHB1dCBHUEEgc3RpbGwgcmVmZXJzIHRvIHRoZSBzYW1lIHBhZ2UgKHNpbmNlIHRoZSBvZmZzZXQg
aXMgYWx3YXlzDQo+IGxlc3MgdGhhbiA0MDk2KSwgYW5kIHRoYXQgcGFnZSBoYXMgYSBmaXhlZCBt
YXBwaW5nLiBJIHdvdWxkIGV4cGVjdCB0aGUNCj4gaHlwZXJjYWxsIGNvZGUgaW4gdGhlIGh5cGVy
dmlzb3IgdG8gbG9vayBmb3IgYW4gZXhpc3RpbmcgbWFwcGluZyBiYXNlZA0KPiBvbiB0aGUgb3V0
cHV0IHBhZ2UsIG5vdCB0aGUgb3V0cHV0IGFkZHJlc3MgdGhhdCBpbmNsdWRlcyB0aGUgb2Zmc2V0
Lg0KPiBCdXQgSSdtIGhhdmVuJ3QgbG9va2VkIGF0IHRoZSBoeXBlcnZpc29yIGNvZGUuIElmIHRo
ZSBIeXBlci1WIGZvbGtzIHNheQ0KPiB0aGF0IGEgbm9uLXplcm8gb2Zmc2V0IHRod2FydHMgZmlu
ZGluZyB0aGUgZXhpc3RpbmcgbWFwcGluZywgd2hhdCBkb2VzDQo+IHRoZSBoeXBlcnZpc29yIGVu
ZCB1cCBkb2luZz8gQ3JlYXRpbmcgYSAybmQgbWFwcGluZyB3b3VsZG4ndCBzZWVtDQo+IHRvIG1h
a2Ugc2Vuc2UuIFNvIEknbSByZWFsbHkgY3VyaW91cyBhYm91dCB3aGF0J3MgZ29pbmcgb24gLi4u
Lg0KPiANCg0KQWdhaW4sIGFueSBmdXJ0aGVyIGluZm9ybWF0aW9uIGFib3V0IHdoeSB3ZSAibG9z
ZSB0aGUgYWJpbGl0eSB0bw0KcGVybWFuZW50bHkgbWFwIGlucHV0L291dHB1dCBwYWdlcyI/IEl0
IHNlZW1zIGRvdWJ0ZnVsIHRvIG1lDQp0aGF0IGFuIG9mZnNldCB3aXRoaW4gdGhlIHNhbWUgcGFn
ZSB3b3VsZCBtYWtlIGFueSBkaWZmZXJlbmNlLA0KYnV0IG1heWJlIEh5cGVyLVYgaXMgZG9pbmcg
c29tZXRoaW5nIHVuZXhwZWN0ZWQuIElmIHNvLCBJJ2QgbGlrZQ0KdG8ga25vdyBtb3JlIGFib3V0
IHdoYXQgdGhhdCBpcy4NCg0KTWljaGFlbA0K

