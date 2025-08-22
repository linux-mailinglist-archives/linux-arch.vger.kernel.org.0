Return-Path: <linux-arch+bounces-13252-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D45BEB30BBF
	for <lists+linux-arch@lfdr.de>; Fri, 22 Aug 2025 04:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69AE81D00250
	for <lists+linux-arch@lfdr.de>; Fri, 22 Aug 2025 02:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88517E792;
	Fri, 22 Aug 2025 02:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MTkwpqDn"
X-Original-To: linux-arch@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012049.outbound.protection.outlook.com [52.103.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD9714286;
	Fri, 22 Aug 2025 02:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755829021; cv=fail; b=ozk+d/nE7XDVZS/xd8ZnvVRe1FDbHgZY4h4fCwfNocw7q9a6rHu6Z/rvjZNlCJjuLdpvFBKvikEmsw7hdsnyTL9fNf1E7X8N9lpiQMQaCmJ5zyucxVu3XzFS/johsQG3b0sTvUAx+GR2YLhUIg9WU2RBankXciSzx78H1RWKYM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755829021; c=relaxed/simple;
	bh=+Pw8M06hQpdR5ZWbpq2x6lv6tdcUvGzTwjVpozWuk6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mCEIAbMd1iRhKSHtJkGMmJElErskKRm5C8QT7k9ayMDMvSqkDEv2edFX+dbE/FhrFMKdvwKM0g9PtnrZ38zndIkqoh1vJqEaiAlVr4xHhWq0dqgGc4tdkEqut2k2qEq1HdTHHN778bxMD8y6rasMw2Iu17ysOGQsXut4vwEUmVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MTkwpqDn; arc=fail smtp.client-ip=52.103.20.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMbw87308WcUdmEmzyDNjjJS5FMegi0MvpV1Dn1BJDud/FBN7Y1h7MdrOU+u3maigrZAsyOEYOjizg5ugBwPhe0hMIcP0TXKTWRiiGtSaPK9A9yfn0aYs52ylsGW8NHwsdoUHg7KdjHgnp1dqChqi6Su6MFLXMOi16oHscNWSesOeeLC8sxuJcJPr028dTBeKIvb/muwpc6bLl5rWpc7viA8x94W5+A7liovJ3KVGyjJJzAEj/sLLZYg+4ywmFvBB7tizF6tY13HmLC5gddqvU4mWmCxr523P50+P8RP0EqgooZY8btclM0bBeFJOcAiYiVC/QLAzpf1hil2FwTeiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Pw8M06hQpdR5ZWbpq2x6lv6tdcUvGzTwjVpozWuk6Y=;
 b=DVL+gCBnsu8pjILpzZHFHACUWxt4FrBgaTrg8nToilPH/gGTDe2IscWCScGgAkKSXFNXZd9cgeqTBpCyzO4p0FIZqG8Vs5ajA6yyjUT7DKRcQiKISRsYBzYTFIIZWu5l20yCRltQ3mXBNcRiwD6mwVAr/LgCGYmBz62nsFq0C22PZOUm8pFWyBnc4xpCKhKVzYby0PM+QVVNATXTOk8EcVb/VL7/tTA+lYCMHIp9KEy9doFug4HaikRjmNOqDrHxgVLcRjQa/0DgIkRj3TtsSF1jL5TUra70YcNTPS3yaBbv19adDLKl41jVk2Xq5lzymGlzaILfc7lSMuWFfLkxzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Pw8M06hQpdR5ZWbpq2x6lv6tdcUvGzTwjVpozWuk6Y=;
 b=MTkwpqDnbaU9Cwf05BvlZW+uA4hbFkzyepRGYAzuYwvLgHL2lRyKXQ4TqzP8ikBvi7x2VBIHQjHOUeYHg4HFi6vE6K7RcTF/UcEhGfC0LPlrBLzGQKq9nS37MTbDlAMEhtm0tA9AUeKe3/rddBwOTAx4QtKC8viWqlyravYrbgxo4HKVIdejZDo1NxVJUId+sVLTd3+nm7+eOedMijKvzigSNjHoM9aaR1pFqTJkX8XZSxYcy8i1AobIvbAMPwRlgEYvxjLuDkEY5UQBvKRMFJJzG8cHCW3pYWyrqgUjEolZw0C858AsLlIaMHIUxsj4Qc+P6ZjnHE9w0NAWeZMkcQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA3PR02MB9945.namprd02.prod.outlook.com (2603:10b6:806:397::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 02:16:56 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 02:16:56 +0000
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
Thread-Index:
 AQHbrjFiyn0GJkB9FUywLGBELxbpZ7RtCZwAgAAo6gCAAQmaEIAAIayAgAAHYgCAAFI2sA==
Date: Fri, 22 Aug 2025 02:16:56 +0000
Message-ID:
 <SN6PR02MB41576739C778676C009D5A86D43DA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250415180728.1789-1-mhklinux@outlook.com>
 <20250415180728.1789-2-mhklinux@outlook.com>
 <f711d4ad-87a8-9cb3-aabc-a493ff18986a@linux.microsoft.com>
 <33b59cc4-2834-b6c7-5ffd-7b9d620a4ce5@linux.microsoft.com>
 <SN6PR02MB4157376DD06C1DC2E28A76B7D432A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <833a0c96-470f-acff-72e7-cc82995fbc2f@linux.microsoft.com>
 <133c9897-12a8-619a-6cf4-334bc2036755@linux.microsoft.com>
In-Reply-To: <133c9897-12a8-619a-6cf4-334bc2036755@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA3PR02MB9945:EE_
x-ms-office365-filtering-correlation-id: 0a9f7207-eb1b-43df-8412-08dde121f7fe
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|15080799012|19110799012|13091999003|31061999003|461199028|8062599012|8060799015|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?SFZuYVBLTEdIMGljbUtrMnJMenUyeXVYVzdISWxNaW0wK1dNeWF5emphL2N5?=
 =?utf-8?B?bDBFU1ZLd2dXWHZQb2J2aTFUR0V4SGpldkh4RUR3bWdvOUtPeEhFL2g0Qk9x?=
 =?utf-8?B?aldFWWZOemYzcWVveWlETWxqeXBQQlFOeFdzTVprbGl1Y21Bd1BIM0JMbFgr?=
 =?utf-8?B?QncwRHFEblVmOXg2bWQwNEowYjJDaVNlQnd6emtRSjc4cTFRdzRjQWhVbHpJ?=
 =?utf-8?B?WlRmMzdhYU5iZ21tK2loQWt5OE9ZdXplY1R3QXBRdWpNY0NXalVXdzhXNnNF?=
 =?utf-8?B?bjU3QVJFVXY3aHRiVXJ1b1UrRFVyUE5FNm1kT2UwK0JlRmZPL2VXbFFqQ3Zw?=
 =?utf-8?B?R2pJQzErdGZSL0U0Q09ZZ0NOMjZZdzZZc3pRSGdTbllYak5GWnBYSGRCUmpk?=
 =?utf-8?B?WlBUQUNORzFRNDhvcytKbGhtdkJWSDFPTUVOZTdyTVlaQTl1NnFEY0V3ZjJt?=
 =?utf-8?B?RFZXdGloK3BJMGZyYXpJNTBwTGNQNHkvYWtNTDFiL1lrWk5GWHEzMTQ1TXZP?=
 =?utf-8?B?blJ6NUdIZHJJRUx4OWVwajMwczZSUXJqVVVmaGZvS1BoUDVPcjlGSmw2Vm5o?=
 =?utf-8?B?Y2MzelZaWnhtVFo5bUJnQlFIQXBpZ29hd3hBWDV4YTczZjBaK2l1bnZHc2Zw?=
 =?utf-8?B?SkxMVnhKVHlsUS8xMjdGVXhTSTZnaUpzSEtGdFM2a0ZMTW1tMGlOZkQzRVhJ?=
 =?utf-8?B?ZDJuNkVWWEs3NmJRY1B4cVM2OGNrUUlHSHVyd1BFZmVWdnlhRy9kcDZSK01z?=
 =?utf-8?B?VWpieTQ4OE1EVEhTa2dWWEpjbHlCUy80a3RnSm9peWR5aXRxZUUxVWM3bWhO?=
 =?utf-8?B?S2VtNWViZSs3aXYvMWdoYkpIcEdUUlBmVU5ncG9WY2lYOHFDYXpERTRsSld3?=
 =?utf-8?B?TWgzMXRSc3hPYi9kLzhnNmpQMzhRenNPVGd3b1BsRDZETGRkdnJVUENLejUw?=
 =?utf-8?B?N0xLei9OY0g5MzZTMHpiWUhjRC9GeFNpR3hZWWV0dUdBZk9TSDdDd2V6dW9S?=
 =?utf-8?B?eVU3YllINldQL3dqaFE4S3pueTVLd3JXbng0eVdJMUxTRG90bHMxY0xWMmJC?=
 =?utf-8?B?eEl5di9VTVFQSlNEaWNPbm12amRzSkVkTjRCSWJxSCtscnliRDhJUHJEUFN4?=
 =?utf-8?B?TUtUMm1IR2prWUdGL1BIOGJ1UjU0M0R3b0xPRHpxdGNrN0dBdUdpV2lrcnAy?=
 =?utf-8?B?RlUxVnliZjdINGlrVmlyNVlxbklPQWMxWDRWVHFzb1psb1Z3a3Jzd3RWVFdF?=
 =?utf-8?B?a2ROaE95b1dCRVJSRmV1WXNnQ0VCZ201eFg4VEZqeGVRSFgzQ2FFSnFwVHFh?=
 =?utf-8?B?K3JEOHp6L3pLWGg3Vi9WWkY4RWN5Q2RCMmhNWGFYZUJKUjc2R3VRcVZXRktw?=
 =?utf-8?B?OVZ0NGt3enZraXJ1ZkVCVmNOY29YRHpnZkRTN0xCZ0dOWUdKbDVoT2JrZmI5?=
 =?utf-8?B?RHB0aWRSL1pTOUZuQWFad3ZacW5vWjh2bTJBdTZ5ZnRNT1dGUVlxazh0Q042?=
 =?utf-8?B?V2xFNkoxVWpHaXpqUUtxV0hHeGdKRHphanAzQ0pSUnVyNHJkOS80RVUzYjFL?=
 =?utf-8?B?WlhyaTY5cFI2T0FTaXI2VDRaRU11L3lGRU90eW5LcWFkMDI1UDk0endUMmdq?=
 =?utf-8?B?dnNHKzkrUVJSWmpRNGd1MkdjTzl0alE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejhJelVkc2NCNURYejU0OGk4MFNuaXVJSFJBYmhNa1A1SHVySVptaUNCbGdj?=
 =?utf-8?B?cVZtTmVIdTg5L0xqTUVJcTVJazV0UFQ3UVhTZ2hmRDkxeVdpRlVJNUwybGVS?=
 =?utf-8?B?SXZWT3d4MG5CdmhPTWc4ZlZKU0hnV0I4eGczNnZ0WnFzYUVuMFdTNThja0l1?=
 =?utf-8?B?eFFvRFRWa1duNmJMcUlSMzdVRFpOWmRqMXpZREFMeWFNL20vdVhWYktWTXJZ?=
 =?utf-8?B?STJWTDliZGFmZEl0VXlVRHp2ZEZoRGlXM3BOaURzczZ2Mm55c2s1ODhUS285?=
 =?utf-8?B?Yk0wYkg3eEpYVmFneGxkWmtwcHN3aGtWamF3UUZwZkY0UWhDUWp2SXNyM1Nz?=
 =?utf-8?B?ZHF2SzE2Z2hONjlUZzAyN216MzBzTlhlSmxoVjF4SmpMSkt6S2J6VFVyQU1T?=
 =?utf-8?B?bTJ3TUJqeWF5RVdWTlNlQXFPTkVGRnA0UjYxWW05cGlkT3U3VU5tVFBBS3or?=
 =?utf-8?B?bWxGVWRMc3JjNnV5ZkJiVUNnWFErNjQxQmZiNTMwZU5WS3lnUC9oSXpKV01J?=
 =?utf-8?B?SEZCUWU1Nm5taWpGVHRyeVdTaVNzQjQzSlhRVnJvNHQ1V1VMQVUyS0c5VjhC?=
 =?utf-8?B?RWxaTVNTT0RJTTVpaXBJcWh1RjBSelhzZVgxQk4vMTg5aWpQbVJVL09ncUFH?=
 =?utf-8?B?QklKNkd3d0xqMkM3S1IrRFhaQlRSWEVWUmErSHFpN1lLWk43bm45RGdqR2ZH?=
 =?utf-8?B?YUhhbWNSTGphNWI2RkF2QlZtM1c5T3ZoNmFZR2hJMkVhemFJUThJR0xCSHcz?=
 =?utf-8?B?UVFOZzZXQU1TdHdMV0hDRTJ0QWxDM2FUallaUEdpK2VGdFBGc3R6NTkzT3Mw?=
 =?utf-8?B?ckYxOGNpN3pEODhNVGcwTEU5cDhnbnRqa2JLZGVnWGtlNUszeTVsYnFWdXlH?=
 =?utf-8?B?bk0ySGZNZUo2NjQ2UlB3SjVxbEN4VndKdndCbjREWHpiYUNuOWNWQ2dEcFVY?=
 =?utf-8?B?MDlrc2R5NWtlUUFuVDdlSzBFb0VZSWFFZWR0Yzh4eWxmWTgyVFFhOFN1bXBu?=
 =?utf-8?B?aUtSK2tIWWVOU3VJRVdFSDRBWFBhSDMrK20rcmRXWVNOVC90T1l1WFlEeTZE?=
 =?utf-8?B?d1J4aTdicnVIUkpGUDlzK1piZXVGSFFCcUpGanRqdzYvaXhUZ3p4UWp5MElm?=
 =?utf-8?B?aCt4QkNhbUZCZTB4VVA5SVp6TnAvQnlibU5VSmY0ZFo3YXVLc1BPU00yOHhI?=
 =?utf-8?B?V0hMaDQ2TFZiODVJVHdPOFFDVW1NOE9NTW03Y1FKRWJSQmJQVXZjY2tiYXBT?=
 =?utf-8?B?SndhYnY5Q2J3NUM2ZXZNTTBQd2U1MVdSU1JkbkhZR1RJVnFzV0VINEU0UWRS?=
 =?utf-8?B?a3ZSSnFLbDYxdVg5ZVhNRzlwVUkzZ2p5RzhRM1lEOE0zN0FDOVlrVDd2QjEr?=
 =?utf-8?B?OHdYYjNuTW5lMk96YXQrY3FUS0JTeTg5STlZNXpseFJiQ1BMQVFlVVVRWEZm?=
 =?utf-8?B?T0ZlY3lzUDBqalZZOWNVa2M1c3kySFduM3pwbHl4blNLWjhFSUtkdWZlL1J4?=
 =?utf-8?B?R25DMjIxVGhJTEhORmMyUitna3ZPTVlqQkYyK3k1UlZGem03UWpieXZQME5D?=
 =?utf-8?B?NzFRYjlXWFN5NVl2L0pEdDVHZ0Q4QTJDU3ZOeVE4V29KYktrMWNadTF0cEx5?=
 =?utf-8?Q?YYrW61bqkzkVprumkT32a94hXmOazM7EuRNAwjaInnVI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9f7207-eb1b-43df-8412-08dde121f7fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 02:16:56.7213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB9945

RnJvbTogTXVrZXNoIFIgPG1yYXRob3JAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogVGh1cnNk
YXksIEF1Z3VzdCAyMSwgMjAyNSAyOjE2IFBNDQo+IA0KPiBPbiA4LzIxLzI1IDEzOjQ5LCBNdWtl
c2ggUiB3cm90ZToNCj4gPiBPbiA4LzIxLzI1IDEyOjI0LCBNaWNoYWVsIEtlbGxleSB3cm90ZToN
Cj4gPj4gRnJvbTogTXVrZXNoIFIgPG1yYXRob3JAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDog
V2VkbmVzZGF5LCBBdWd1c3QgMjAsIDIwMjUgNzo1OCBQTQ0KPiA+Pj4NCj4gPj4+IE9uIDgvMjAv
MjUgMTc6MzEsIE11a2VzaCBSIHdyb3RlOg0KPiA+Pj4+IE9uIDQvMTUvMjUgMTE6MDcsIG1oa2Vs
bGV5NThAZ21haWwuY29tIHdyb3RlOg0KPiA+Pj4+PiBGcm9tOiBNaWNoYWVsIEtlbGxleSA8bWhr
bGludXhAb3V0bG9vay5jb20+DQo+ID4+Pj4+DQo+ID4+Pj4+DQo+ID4gPHNuaXA+DQo+ID4+Pj4N
Cj4gPj4+Pg0KPiA+Pj4+IElNSE8sIHRoaXMgaXMgdW5uZWNlc3NhcnkgY2hhbmdlIHRoYXQganVz
dCBvYmZ1c2NhdGVzIGNvZGUuIFdpdGggc3RhdHVzIHF1bw0KPiA+Pj4+IG9uZSBoYXMgdGhlIGFk
dmFudGFnZSBvZiBzZWVpbmcgd2hhdCBleGFjdGx5IGlzIGdvaW5nIG9uLCBvbmUgY2FuIHVzZSB0
aGUNCj4gPj4+PiBhcmdzIGFueSB3aGljaCB3YXksIGNoYW5nZSBiYXRjaCBzaXplIGFueSB3aGlj
aCB3YXksIGFuZCBpcyB0aHVzIGZsZXhpYmxlLg0KPiA+Pg0KPiA+PiBJIHN0YXJ0ZWQgdGhpcyBw
YXRjaCBzZXQgaW4gcmVzcG9uc2UgdG8gc29tZSBlcnJvcnMgaW4gb3BlbiBjb2RpbmcgdGhlDQo+
ID4+IHVzZSBvZiBoeXBlcnZfcGNwdV9pbnB1dC9vdXRwdXRfYXJnLCB0byBzZWUgaWYgaGVscGVy
IGZ1bmN0aW9ucyBjb3VsZA0KPiA+PiByZWd1bGFyaXplIHRoZSB1c2FnZSBhbmQgcmVkdWNlIHRo
ZSBsaWtlbGlob29kIG9mIGZ1dHVyZSBlcnJvcnMuIEJhbGFuY2luZw0KPiA+PiB0aGUgcGx1c2Vz
IGFuZCBtaW51c2VzIG9mIHRoZSByZXN1bHQsIGluIG15IHZpZXcgdGhlIGhlbHBlciBmdW5jdGlv
bnMgYXJlDQo+ID4+IGFuIGltcHJvdmVtZW50LCB0aG91Z2ggbm90IG92ZXJ3aGVsbWluZ2x5IHNv
LiBPdGhlcnMgbWF5IHNlZSB0aGUNCj4gPj4gdHJhZGVvZmZzIGRpZmZlcmVudGx5LCBhbmQgYXMg
c3VjaCBJIHdvdWxkIG5vdCBnbyB0byB0aGUgbWF0IGluIGFyZ3VpbmcgdGhlDQo+ID4+IHBhdGNo
ZXMgbXVzdCBiZSB0YWtlbi4gQnV0IGlmIHdlIGRvbid0IHRha2UgdGhlbSwgd2UgbmVlZCB0byBn
byBiYWNrIGFuZA0KPiA+PiBjbGVhbiB1cCBtaW5vciBlcnJvcnMgYW5kIGluY29uc2lzdGVuY2ll
cyBpbiB0aGUgb3BlbiBjb2RpbmcgYXQgc29tZQ0KPiA+PiBleGlzdGluZyBoeXBlcmNhbGwgY2Fs
bCBzaXRlcy4NCj4gPg0KPiA+IFllcywgZGVmaW5pdGVseS4gQXNzdW1pbmcgTnVubyBrbm93cyB3
aGF0IGlzc3VlcyB5b3UgYXJlIHJlZmVycmluZyB0bywNCj4gPiBJJ2xsIHdvcmsgd2l0aCBoaW0g
dG8gZ2V0IHRoZW0gYWRkcmVzc2VkIGFzYXAuIFRoYW5rcyBmb3Igbm90aWNpbmcgdGhlbS4NCj4g
PiBJZiBOdW5vIGlzIG5vdCBhd2FyZSwgSSdsbCBwaW5nIHlvdSBmb3IgbW9yZSBpbmZvLg0KPiAN
Cj4gVGFsa2VkIHRvIE51bm8sIGhlJ3Mgbm90IGF3YXJlIG9mIGFueXRoaW5nIHBlbmRpbmcgb3Ig
ZGV0YWlscy4gU28gaWYgeW91DQo+IGNhbiBraW5kbHkgbGlzdCB0aGVtIG91dCBoZXJlLCBJIHdp
bGwgbWFrZSBzdXJlIGl0IGdldHMgYWRkcmVzc2VkIHJpZ2h0DQo+IGF3YXkuDQo+IA0KDQpJIGRp
ZG4ndCBjYXRhbG9nIHRoZSBpc3N1ZXMgYXMgSSBjYW1lIGFjcm9zcyB0aGVtIHdoZW4gZG9pbmcg
dGhpcyBwYXRjaA0Kc2V0LiA6LSggICBJIGRvbid0IHRoaW5rIGFueSBhcmUgYnVncyB0aGF0IGNv
dWxkIGJyZWFrIHRoaW5ncyBub3cuIFRoZXkgd2VyZQ0KdGhpbmdzIGxpa2Ugbm90IGVuc3VyaW5n
IHRoYXQgYWxsIGh5cGVyY2FsbCBpbnB1dCBmaWVsZHMgYXJlIGluaXRpYWxpemVkIHRvIHplcm8s
DQpkdXBsaWNhdGUgaW5pdGlhbGl6YXRpb24gdG8gemVybywgYW5kIHVubmVjZXNzYXJ5IGluaXRp
YWxpemF0aW9uIG9mIGh5cGVyY2FsbA0Kb3V0cHV0IG1lbW9yeS4gSW4gZ2VuZXJhbCwgaG93IHRo
ZSBoeXBlcmNhbGwgYXJncyBhcmUgc2V0IHVwIGlzIGluY29uc2lzdGVudA0KYWNyb3NzIGRpZmZl
cmVudCBoeXBlcmNhbGwgY2FsbCBzaXRlcywgYW5kIHRoYXQgaW5jb25zaXN0ZW5jeSBjYW4gbGVh
ZCB0byBlcnJvcnMsDQp3aGljaCBpcyB3aGF0IEkgd2FzIHRyeWluZyB0byBhZGRyZXNzLg0KDQpC
dXQgSSBjYW4gZ28gYmFjayBhbmQgY29tZSB1cCB3aXRoIGEgbGlzdCBpZiB0aGF0J3Mgd2hlcmUg
d2UncmUgaGVhZGVkLg0KDQpNaWNoYWVsDQo=

