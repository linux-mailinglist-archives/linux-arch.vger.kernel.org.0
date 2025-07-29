Return-Path: <linux-arch+bounces-12979-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CD6B14551
	for <lists+linux-arch@lfdr.de>; Tue, 29 Jul 2025 02:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C653BC12A
	for <lists+linux-arch@lfdr.de>; Tue, 29 Jul 2025 00:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B953A11187;
	Tue, 29 Jul 2025 00:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QrLoxLef"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2029.outbound.protection.outlook.com [40.92.42.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE0DF510;
	Tue, 29 Jul 2025 00:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753748641; cv=fail; b=PPTLeZMUUXtdp5DuFonejwSgRMEtt0mKd19SOpqtXPRUINjhsoR1UA23cSUkjXCJV195DnGlCTK6iEKGAvyYpyEDCfk1SCWG7YONlrzbtgWBBLxsM2ZYeiuA0jbxeGDJ7yTXVuJ4dLb7D5lAkp8twTewQHNzfgLdfa7CfDE1rcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753748641; c=relaxed/simple;
	bh=qjBCv4HcsBPik3y9cWQD0eCB09q+Fxzx7mWnHPvOjF8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WAkAKiRignerZ337RZGOCugZcErd1YsB9yOBjbTunLTRiRwdYlKgVz3qPa6f7no7xWVJmMrtpmCl14wuxwhNdynUqQJCetnj1LjJyBO8jZi/63hw7QASeh1pwcO1QLtn44ttRcwbZ5z/Bw4+6s7llzBsoc4GkORHS1p8HPQC8yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QrLoxLef; arc=fail smtp.client-ip=40.92.42.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owtZ0eH42OnU4+I9gDGSyEyqvHOS+PvPWbhJYs81T+7lb6ntN4E65+LXk9XKxeg2G6akE4Pjz3C/oeSN4d0+A0p6AFxLnh52OZpMaJGt8o64kGnNUsQx24L2HtWLzfUuj85lvgkhLDe3B5pcrKJOqK0Rr20yv+0Q72Co2etVOcifaqmL0XfM3gz8jUUwKvejQXswOB0tyFOV2zshjaLl9vcrfNSQKkc7wRfMu58qoiT4GsIuIztkhGTQZ+joq9u+QpBvZpW2wMZe2b12oyf5vfPkk5OaZhbbaj8rOAQvdoUbNAPBP0GRyH4PvGzpVNA6qtsQ2YSdohBsiDHePYc6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjBCv4HcsBPik3y9cWQD0eCB09q+Fxzx7mWnHPvOjF8=;
 b=ejTe+1A2XP1o/hLMWxH86PC9w+BLp7RERwyy7TGzB9MWlIzOh5E+rxojO3mEpuIW9yhXEHNTD5U/oLfHYmTJoPtwT/BWiGO+t1TKSb7f71adfv8I3S3+1ms8hNIYkNhE31bacnxNoztLIpG6gOS9Num3wrxYRrO+t+oNvw++wMy/ZYKfkpSLY8WGiQzvx1s1bXGAkTCE+kfd+gc0ql+rbl2sE7TwldPRL7q+4x+T5i9AGqAXNXJAuwS9B1I4AXk6dP7vZ4O5FjnggfSeBo1XoyoUsnYJfOOV1Jyto65AFZLZc9wGPUd54aNFUhNHC9MaqOjIdKCfN/DkNhA/8ls3OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjBCv4HcsBPik3y9cWQD0eCB09q+Fxzx7mWnHPvOjF8=;
 b=QrLoxLefBCbGrGKpmk6y0/eXoIWu/P4cruSlXS14tHFmSuZydZb8qNO7Hejjqw6IDLyB2oLkj4La1TwpL+8LWrxvogM5F191laV8J0YNA4bQcxOyGxYVyfxkMTMNSUv/ofSJf5lJi1aAQcg7W1CATLv7dSUi6YXv/xxGOWJMcIT2eS/zVscxPcMyK7DwuB2J4wL5KPpno3Iqs7SVAhE3oMLAgRsFpPwo8OZm1xsHf9qJxf3q1s7s5ZPLtpBj0MQLhWwEsTz/h/5uDlcP+LM/eVa3lyiE69Ldzx9daR91S6x5GmfAQx9ZPtBTP+A+bY8ZMuBJC/KrjG6Da7SsS+1Geg==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by IA1PR02MB9520.namprd02.prod.outlook.com (2603:10b6:208:3f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Tue, 29 Jul
 2025 00:23:56 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%6]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 00:23:56 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
Subject: RE: [PATCH v4 4/7] Drivers: hv: Use hv_setup_*() to set up hypercall
 arguments
Thread-Topic: [PATCH v4 4/7] Drivers: hv: Use hv_setup_*() to set up hypercall
 arguments
Thread-Index: AQHb96Bu5DqKlInms0ePntsT4dFqVLRH048AgAB1qPA=
Date: Tue, 29 Jul 2025 00:23:56 +0000
Message-ID:
 <BN7PR02MB414807A1A9174D1215AA365FD425A@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20250718045545.517620-1-mhklinux@outlook.com>
 <20250718045545.517620-5-mhklinux@outlook.com>
 <1303b11c-0d84-4f42-995e-6dd2c5a528c7@linux.microsoft.com>
In-Reply-To: <1303b11c-0d84-4f42-995e-6dd2c5a528c7@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|IA1PR02MB9520:EE_
x-ms-office365-filtering-correlation-id: 51059605-3379-4364-3cbc-08ddce363497
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799012|8062599012|15080799012|8060799015|41001999006|40105399003|3412199025|51005399003|440099028|12091999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yk01U2NueG8wRUJqNWhxYk1xMGdGZ2pNRTh2dGdXcmlQazlpWjNaazN3dS9Y?=
 =?utf-8?B?QUlkMWFtV0J1aHNCR3dtZkQvaU9UWWJJZjBVcTJPc0ZCN1p2ZW1ycVQ0RXc3?=
 =?utf-8?B?ZHBXeUFqTHdhY1pjRjdlMnFJYjM1Q0h6bTFjZkM1YkpUQ3oyS2E3MVlRbXZk?=
 =?utf-8?B?SUxWZW1RejlXVjRvYnkvOEFhcFdTa3NjT0lBRTN0Y3VlUnBQYnhwaDJYL3Uw?=
 =?utf-8?B?bS9BMDgvSmszY2NDQ2hmNXM2ckJTaDVSKzBsdHdhdVFHQ0JiZjVuVVpsNHZX?=
 =?utf-8?B?aFExOTFxUk5hZ002dnJIdG4wajVOWmNpTXBreVFodDdhVStFRGhrNXRLNUpG?=
 =?utf-8?B?clNnRXRiS3F4SmVIQ1RzbXhGT2Z1ZHE5dGZnalZLS2IvQ3FadUpISjU4Um4w?=
 =?utf-8?B?V2FrNVpKdGpGVlJlc1ZYNVU0Y0l3NUo3RnJzaGFHV0crTmpLOE1Cd2xQSUxT?=
 =?utf-8?B?OHhEWkVBNnVSS1RjRmsxdUlxKzZUWUgvNlViUTRIZCsyZENkSUtFTkpnZ21K?=
 =?utf-8?B?NVp3Y1BCSFd6YlJ4SzVOMXdlY3FQYUI0S3Q1KzVZRURHLzdNOXMvczBRZkNl?=
 =?utf-8?B?MnlRMkV4L0Z2UENETUwxZ0Ezcy9ianMvc2hzVjdZMTYxUmhIRW1hTUpaUzJl?=
 =?utf-8?B?aW0xMG9UVUFmMUlzZnhYdmNNSTNNYXJIWGdkaUxjL0dsUFRML1NCOGhqT0gv?=
 =?utf-8?B?bDB4TVFBa3RXNGNVRlBhZ2IxWmx5cXFweE1KeUhpRzFPRzdybWplaGVta3g5?=
 =?utf-8?B?b2lhc1ZMVHpmM0tZUjFxOG5kWjNCdkxKWWhwaXExNjJKY0FpTmdSdWxOanpJ?=
 =?utf-8?B?U0ZsQVJaeDdJZFF6am5BVWYydTFqUXQ5TWxUY3ozd3RXc1pXdmloZXVZZHR6?=
 =?utf-8?B?eTVaVXlCcS9wMzFhc0xYOXVuL1Jja1hQMGNVL2VXTi9GcC9FekJ6T05zREdx?=
 =?utf-8?B?MHMvVWtmd0taYnczM0R5Y2tUUG5VMTFTKzJadm52YjNuQUJYT0Rpa3QweDhT?=
 =?utf-8?B?YzBKd1RGSEZuLzlCNDFhL3lOYTB4Qlpuc3c5SFdSVnFYS2psdHMvREpEM2R4?=
 =?utf-8?B?b3BXZXBYT0JiSGo1bWVMQ1FIS1I3bHloOXlBOEpROG9ueXZmd0JpanQySlcv?=
 =?utf-8?B?VEN6RnBSNW9scndFQkdCempqTW1ieHFHejVRUS90TW5MWVNCaDB6eWxuUUhZ?=
 =?utf-8?B?dXFOSjVGaVl0WTJWdzF4RmdPdzRJOTlLUFBqdGovbTduNE1yVVpFQnFBbEdB?=
 =?utf-8?B?enFQMTJ3dFpJSm5CaEQ4aDFGY0wycFhWdTE0RWFjN0krTHdCQ0E2K1E2UVVG?=
 =?utf-8?B?cmdBQXV6dTBrU1RpVHRpRmRrNG1kbmoveVpMNFBwYlJrVmxlZVJiQ29nYytM?=
 =?utf-8?B?YjhrZ2Z2MHNncERpSVVPTEM3TDJMMnFGVDN0Y28vTzZpWFJFakhST1psTUJV?=
 =?utf-8?B?MmFLTzFLTndSd1lKdmZ0NnlNNHMzY3d2VFU4ZG4yRVQxMmF4UkpaNkxkbGhC?=
 =?utf-8?B?WURhM3dVVjZPaXBoQzk0VTdCakpFRFc5UUxJTk9Hc0N5b2w1OUQwQzNYUWZY?=
 =?utf-8?B?V09rSUhLblY4UUdCUEFXZTQ5bUU2alByc0IwNi90VUhqYk9WTStybXE1WG0w?=
 =?utf-8?B?K1p0bTVHSENTK1d3WWFSNWd4QUVXQXc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SjBEZE83cVRweXRrY0NvK0VkT21LMWRNQzloRlJobXg1VUVkUlkvMUhaNXRL?=
 =?utf-8?B?RWEzQ0czK0ZaMGJzQkw0RnJPeDl3VENST093MHNKeUcvckxUaVZYak1KeTBL?=
 =?utf-8?B?L3VabXZES1dnKzZuNXlndGFpVDNjOGdpS2dSZVVMRFk0MzJoZkE1UFlRVHdN?=
 =?utf-8?B?WU9lcGtBc0F3a09uNUkxdWZUcTFWVHF0V0VXUWZrSGVBNlF4TEN0V0xuYjlx?=
 =?utf-8?B?eit3clZmTkIvRXZmOHRjVmJyNlRYKzQrWDdQcnVnV0tEdG40ZDhyZ0MvTFVG?=
 =?utf-8?B?d0lhMjUzeFN0UTJwTHAyTjBsVkUwd2NtSjQ1UVNmRkVCdkNESVYrV0FscU9y?=
 =?utf-8?B?WHlkNkNJTHdLcDg2bmxFTC9OY0VuVGxnUWl6NEIxK3pNMFNTclhrWjhwZ3N2?=
 =?utf-8?B?bEVRRGlCczh1MFg3OWVkTE9lbFczaXRNSDhoSUtpK1lDRXZ1akdDR21sdGlP?=
 =?utf-8?B?M2RiYzRlaTF5aDl4Uk1FWnk3WWdSZmgrSEhDOWVOUWVoaUtkRTU1aVdmSjJS?=
 =?utf-8?B?NThadFZlUEtlL0FUaGhZWUxYeStrbDl5Qzd2N2lqOTB6d0xDU0VCK3RPUXk2?=
 =?utf-8?B?dEFDWm04KytlNjRmM1NFc0JOUndTRUl4NUJONG8vSWk2NW11aXNSdmlyL3FG?=
 =?utf-8?B?aGlMMzZWdFFPdFJmVnRyR1g5SW9KdTJ1Q2NjZkdsK3M4VFREQ3dkNGE0bE4w?=
 =?utf-8?B?U3JmN3RKZXc1VisreXV5azZ0amF5V0ZyMHZNRkwwTmJ1ZSszVDBJNnF6SjI0?=
 =?utf-8?B?S1lGNm4rSzJNN1cxY3h1SHBQazZxdVNwYlA3cG9DclV0LzBKSDZEN3BHYXJ2?=
 =?utf-8?B?ZWFpck5IY1dKMWt4YTBpdldLTDQ4eWx1cmpYVnFic3FzU1kreVp4WEN0TGFJ?=
 =?utf-8?B?cENLMnhkMlhOZHIrTFBMTmdzV1kyYWp6dTdWMGxsRHVjZUZiWm9VeENKWFRy?=
 =?utf-8?B?aWtBNEtnRmxsdnRZcG9tbmlJV25QQm9mTG1sVHNvWlRMaXJsd2t6MnRBU2hD?=
 =?utf-8?B?RDd5M1N2QVRjNE82WG5JckVlZDZMdzdIbVpIUGZKSm1XNS9UR25IV2lxSG81?=
 =?utf-8?B?Z0FLVkNFWjBlZXFxNFgwdVNzVWo1MVBONmkwcklsdml6d0g2T3M4KzZnWGpL?=
 =?utf-8?B?MkVXbUhYL3pQVFc3Z2ZnOEZNakZ4RGFwRzdDUElpQlVMcmZCQnRLZDBidjVB?=
 =?utf-8?B?c1pTQTlkVUQ0YnBnUlZSZ2Zab1JQNDV2TlNFNjUvbm4wTHIvMzN3VGpxQ1FM?=
 =?utf-8?B?dFFuSlR6ejZKVzExSkFUN2tTc1g4YXJGNzlLYzlwcGxGZkE3THJ2b0JRbXE4?=
 =?utf-8?B?MEQrNkQ2aFgxNkRxa0J2TlVQYXdVQmhmb1ZDUTZZb3U1eWhNMHFEa2U0MHNG?=
 =?utf-8?B?N1V1aGJPYjA3NDRoZS9YOWo2NUtCR0dGRlh5eWsrbW1sYTVzQlFsSFpXYlZY?=
 =?utf-8?B?TVVwWG05ZkdDdzNEY0VHb2dzekI3UDBwL1Q3MlBiQVhTRHR4dGFvc201Mnl1?=
 =?utf-8?B?RmtWY21yamw2OTZEL3VGVzRoWGFwM28wUjZ4TWZVNzgzV29DUGc3T0xqOUZu?=
 =?utf-8?B?aVlxNWora0swcHVDYVU0RGJ3MndNbjdSOFlxbm9kdnVSTTBXUE9QRFZQbVdW?=
 =?utf-8?Q?z4gTx8fXCoqFLS22H2CByw6+7m3YmP1k7XT2xgW09Hnk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 51059605-3379-4364-3cbc-08ddce363497
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 00:23:56.1734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9520

RnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBT
ZW50OiBNb25kYXksIEp1bHkgMjgsIDIwMjUgMTA6MDMgQU0NCj4gDQo+IE9uIDcvMTcvMjAyNSA5
OjU1IFBNLCBtaGtlbGxleTU4QGdtYWlsLmNvbSB3cm90ZToNCj4gPHNuaXA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaHYvaHZfYmFsbG9vbi5jIGIvZHJpdmVycy9odi9odl9iYWxsb29uLmMN
Cj4gPiBpbmRleCAyYjQwODBlNTFmOTcuLmQ5YjU2OWIyMDRkMiAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2h2L2h2X2JhbGxvb24uYw0KPiA+ICsrKyBiL2RyaXZlcnMvaHYvaHZfYmFsbG9vbi5j
DQo+ID4gQEAgLTE1NzcsMjEgKzE1NzcsMjEgQEAgc3RhdGljIGludCBodl9mcmVlX3BhZ2VfcmVw
b3J0KHN0cnVjdCBwYWdlX3JlcG9ydGluZ19kZXZfaW5mbyAqcHJfZGV2X2luZm8sDQo+ID4gIHsN
Cj4gPiAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4gIAlzdHJ1Y3QgaHZfbWVtb3J5X2hpbnQg
KmhpbnQ7DQo+ID4gLQlpbnQgaSwgb3JkZXI7DQo+ID4gKwlpbnQgaSwgb3JkZXIsIGJhdGNoX3Np
emU7DQo+ID4gIAl1NjQgc3RhdHVzOw0KPiA+ICAJc3RydWN0IHNjYXR0ZXJsaXN0ICpzZzsNCj4g
Pg0KPiA+IC0JV0FSTl9PTl9PTkNFKG5lbnRzID4gSFZfTUVNT1JZX0hJTlRfTUFYX0dQQV9QQUdF
X1JBTkdFUyk7DQo+ID4gIAlXQVJOX09OX09OQ0Uoc2dsLT5sZW5ndGggPCAoSFZfSFlQX1BBR0Vf
U0laRSA8PCBwYWdlX3JlcG9ydGluZ19vcmRlcikpOw0KPiA+ICAJbG9jYWxfaXJxX3NhdmUoZmxh
Z3MpOw0KPiA+IC0JaGludCA9ICp0aGlzX2NwdV9wdHIoaHlwZXJ2X3BjcHVfaW5wdXRfYXJnKTsN
Cj4gPiArDQo+ID4gKwliYXRjaF9zaXplID0gaHZfc2V0dXBfaW5fYXJyYXkoJmhpbnQsIHNpemVv
ZigqaGludCksIHNpemVvZihoaW50LT5yYW5nZXNbMF0pKTsNCj4gPiAgCWlmICghaGludCkgew0K
PiA+ICAJCWxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsNCj4gPiAgCQlyZXR1cm4gLUVOT1NQQzsN
Cj4gPiAgCX0NCj4gPiArCVdBUk5fT05fT05DRShuZW50cyA+IGJhdGNoX3NpemUpOw0KPiA+DQo+
IA0KPiBJIGRvbid0IHRoaW5rIFdBUk5fT05fT05DRSBpcyBzdWZmaWNpZW50IGhlcmUuLi4gdGhp
cyBsb29rcyBsaWtlIGEgYnVnIGluIHRoZSBjdXJyZW50DQo+IGNvZGUuIFRoZSBsb29wIGJlbG93
IHdpbGwgZ28gb3V0IG9mIGJvdW5kcyBvZiB0aGUgaW5wdXQgcGFnZSBpZiBuZW50cyBpcyB0b28g
bGFyZ2UuDQo+IA0KPiBJZGVhbGx5IHRoaXMgZnVuY3Rpb24gd291bGQgYmUgcmVmYWN0b3JlZCB0
byBiYXRjaCB0aGUgb3BlcmF0aW9uIHNvIHRoYXQgdGhpcyBpc24ndCBhDQo+IHByb2JsZW0uDQoN
ClllcywgSSBrZXB0IHRoZSBleGlzdGluZyBmdW5jdGlvbmFsaXR5LCB3aGljaCBpcyBzbGlnaHRs
eSBmbGF3ZWQuIEJ1dCB0aGVyZSdzIG5vdCBhDQpyZWFsIHByb2JsZW0sIGJlY2F1c2UgIm5lbnRz
IiBpcyBhbHdheXMgUEFHRV9SRVBPUlRJTkdfQ0FQQUNJVFkgKHdoaWNoIGlzDQozMikgb3Igc21h
bGxlci4gU2VlIHBhZ2VfcmVwb3J0aW5nX2N5Y2xlKCkuIEZ1cnRoZXJtb3JlLCB0aGUgSFYgYmFs
bG9vbiBkcml2ZXINCmZ1bmN0aW9uIGVuYWJsZV9wYWdlX3JlcG9ydGluZygpIGhhcyBhIEJVSUxE
X0JVR19PTiB0byBlbnN1cmUgZXZlcnl0aGluZyBmaXRzLg0KDQpBZGRpbmcgYSBiYXRjaGluZyBs
b29wIGFyb3VuZCB0aGUgaHlwZXJjYWxsIGhlcmUgaW4gaHZfZnJlZV9wYWdlX3JlcG9ydCgpIHNl
ZW1zDQpsaWtlIG92ZXJraWxsIHVubGVzcyBQQUdFX1JFUE9SVElOR19DQVBBQ0lUWSBpcyBjaGFu
Z2VkIHRvIHNvbWV0aGluZyBsYXJnZXIuDQpIeXBlci1WIGhhcyByb29tIGZvciB0aGUgdmFsdWUg
dG8gYmUgYXMgbGFyZ2UgYXMgMTI4LiANCg0KVGhlIHZpcnRpbyBiYWxsb29uIGRyaXZlciBkb2Vz
IGEgc2ltaWxhciBjaGVjaywgdGhvdWdoIGF0IHJ1bnRpbWUsIGFuZA0KdmlydGlvX2JhbGxvb25f
cHJvYmUoKSBmYWlscyBpZiBpdHMgY2FwYWNpdHkgaXNuJ3QgYXQgbGVhc3QgUEFHRV9SRVBPUlRJ
TkdfQ0FQQUNJVFkuDQpUaGUgSHlwZXItViBiYWxsb29uIGRyaXZlciBjb3VsZCBkbyB0aGUgc2Ft
ZS4gVGlkeWluZyB0aGlzIHVwIHNlZW1zIHRvIG1lDQp0byBiZSBhIHNlcGFyYXRlIHBhdGNoIHRo
YXQncyBvdXRzaWRlIHRoZSBzY29wZSBvZiB0aGlzIHNlcmllcy4NCg0KTWljaGFlbA0KDQo+IA0K
PiBOdW5vDQo+ID4gIAloaW50LT5oZWF0X3R5cGUgPSBIVl9FWFRNRU1fSEVBVF9ISU5UX0NPTERf
RElTQ0FSRDsNCj4gPiAtCWhpbnQtPnJlc2VydmVkID0gMDsNCj4gPiAgCWZvcl9lYWNoX3NnKHNn
bCwgc2csIG5lbnRzLCBpKSB7DQo+ID4gIAkJdW5pb24gaHZfZ3BhX3BhZ2VfcmFuZ2UgKnJhbmdl
Ow0KPiA+DQo+IDxzbmlwPg0KDQo=

