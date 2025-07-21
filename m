Return-Path: <linux-arch+bounces-12880-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A57B0BABB
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jul 2025 04:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87355189D448
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jul 2025 02:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C897223DED;
	Mon, 21 Jul 2025 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rdXt37k4"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2024.outbound.protection.outlook.com [40.92.41.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F7D1D5ACE;
	Mon, 21 Jul 2025 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064400; cv=fail; b=hx1uf64rKmiWa+g+8WLnVhXvZ6YWPQAl2me+BmHhjHoUjvm5yD9cuhVi7hL1aLY0mdZN4CbIjERfBROrmVfq5zKy0WL5B6uoJaymUwSdgLGJIKgCWHpiguwU15UtrqodRe8J38Tm3XfYreYzZkVC+eMF1hO87v5HDOdTmwaQzn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064400; c=relaxed/simple;
	bh=3w233CEpiILgucnCUv+a8eKGy0a6KxLHkQxkNhWPktk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I5h3U5N9mb3Kd03w8Ap1gxFOtFTUHyM1qkmKxdgYgxWzMSOTauqcSwn+RJKa5yEw6toybR8RlEkiyDhmzcc4xeMEPTZqg9pdKfanYfd2zsOmpVza8Us7H5ERNWbTPl3Jrq+2PrPhrm+4inHVDmTzO/JYMWNvlg3k5w5qmVtQzeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rdXt37k4; arc=fail smtp.client-ip=40.92.41.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCaRkD+S+YAR3z2LiwC7KBQrrki/tYTd8CburogxTH2zBmBXaykKpzy2S91i6GnDaQ7PIQFcsFxUfsPS2xoAN85NFUdBhuHFrpDRmOzCVWQhSXveReHIxWkyTy9hJnvacVkmcezmqzkaIQS0pScuPyf+1ZZYDKjFoiGFgXKTsgbjh/DekG4CvclVCul9xIBkkHoK87Mq6PLwpRTgBA12hf4KQ5peOesS4eZYv186wMJlKAnCIZKUEv4BBrGjo+/U4N6DXWFQGp5AFH1r5B6vIG/ygp2But/S8rRPeJbQu8om+bGHE9hxHOeYnjXmfOpwFeelLvNG/Z+qeK0qwvl93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3w233CEpiILgucnCUv+a8eKGy0a6KxLHkQxkNhWPktk=;
 b=uf0ltC7Kuv7Jv4WgVPtzfLOV/nJ21ekVfAa7UUb/ZumruTxJmkabdFozlSo/XN3M7jk5m2g5jEVRhWnPVINpwdIitsoctIOznCY2ty1RtcxvP8w7YIFTwBvsIxML3uNBiERTDTp4JDuKwh3oYpMrdKADO6BhJueXb7mV1BXH2Ql+q9Wh0FrzlwXJqyegq+mPHSFCch+7ClzkBY+Ua0xHWPO+XYX3hh1bgy3Lq2YXi5UTAa4mrnkeuLI9U12XP2+BouigJ1Lpiul6jS4A0A5gJB3XgfrV0FHFQA0hRYUOGXPD6rGwWoFsILuwb2eoIXyC3Aq/93aXNwKl7m6s6h9QiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3w233CEpiILgucnCUv+a8eKGy0a6KxLHkQxkNhWPktk=;
 b=rdXt37k4n9n39YHusnBSwdZljsceFoKcuX+IQdm+HCFs7A28HniWO2bDnVFjI9dhZe7GmmyqxKDG8Zx95hH++Le9Gg7BwEO4n9hhlOj+9DT7tnJ/0ndGUDsAWGVCguR3ojQWZsdPRLgsPxh8Dp2TtIz7lUvsizc1/o3M6qqlPFDakEc3ZRrNcVR9zOn4z61xgbcdkBTH/2mBJEPPTlcK4tj6Prsrn9g1nxb7qw52kmSd5CeEiwAbG1zW8wQzvUsw8AgDIMPsNwLtuzU/S23mR8CkkBpxL11nOfqAuHGmhkBNlOwZ1wzPjBz4jZRkS92g1gidgm/aAPbHUWNsiTnwIw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB10581.namprd02.prod.outlook.com (2603:10b6:610:205::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Mon, 21 Jul
 2025 02:19:56 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 02:19:56 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, Easwar Hariharan
	<eahariha@linux.microsoft.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, Naman Jain <namjain@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>, "x86@kernel.org"
	<x86@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
Subject: RE: [PATCH v4 0/7] hyperv: Introduce new way to manage hypercall args
Thread-Topic: [PATCH v4 0/7] hyperv: Introduce new way to manage hypercall
 args
Thread-Index: AQHb96BLaxI7ZKQtcEykvxaiGfmaJ7Q4FA6AgAAJxBCAADcfgIAAURsAgAMyUgA=
Date: Mon, 21 Jul 2025 02:19:55 +0000
Message-ID:
 <SN6PR02MB4157A2A90910918AE9B6327BD45DA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250718045545.517620-1-mhklinux@outlook.com>
 <c5d4d351-a7ff-4762-8bb3-61554d4f9731@linux.microsoft.com>
 <SN6PR02MB41570625E2F061C5E494C7F4D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <43f8be57-a330-455f-8f9e-f5718ff1aa1a@linux.microsoft.com>
 <ed1e8508-7085-4620-af25-3a8795c1afe8@linux.microsoft.com>
In-Reply-To: <ed1e8508-7085-4620-af25-3a8795c1afe8@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB10581:EE_
x-ms-office365-filtering-correlation-id: 26ff4d28-411e-41f3-c6ef-08ddc7fd15a0
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmrST/aUJU0/Qa6VQDo48Tgyqv1fm0A63JSq8KwfkhFikwE936D9LM5/qmvzHHG9nEzDmc07o6Ehy96PR7pR2v1K8lrr1ZZXWDuLmjXNcN3txQbHd1j7bwVDQQeH/DXrL7RGFELhHZfgJCkeHMOlnw4Xtd0/U9iTn/SfuTRh75jtNED340PGr4OkuKVz1HbkQY/DbhSgqG5MV6/K8qoS0BSYBlChhl2fsj6NBezyl+YUu1OHbmRZDDURn0UmBwy+4WmmWwP+ztO+w2vXW7Oh9hw5PVLBuJws2U31u946auNY8EYH6qg86bjLpcnddudXZqODYDFBbTGFgGlKW95075J0bsa4GdDc5lBEoiaK6hkb/evMFO96NETGnQW7toORbk85P7dmpvWHKkX9pSG5CJwZjqMcIPZj7lei+ia0AzkRTzhdaHwQlZMRbf88u2GUeSv5y4iEInln4uy8JXBaR41MCLctr5Paj46v6GgdnolZRTFbJw1XdmeN3ayHje4OiAbzkKlDQxZ/TOqy3WeXxHgvSnnAxVPz3Slm6xnuw7YUEroz520MrsP+D4P16I12Z+up5cpeepNH1BdDRLsOMeLcl6MyUJYE5EUilzJSSDgC11AqzC7FypE2EREggmzmzHC5LlaME/8x6BLHYQZLiL+B7pnGUBoO/LGvvcHLtiUqauRF+uzH8YXCAdb9aocOBgHsKkkPEmy1Stciqij+nYfiknKyUW2Nu4Tv8v+OF6xXI9PIuEIh/oltx9efeBCsdZw=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799012|440099028|3412199025|40105399003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?VVUxZDRQNmxmYWIxbHhlMkw3WmJ4cmV2bE5lYzFlZzJzUDdZVGQ1RmdFbVFo?=
 =?utf-8?B?YzErUVRlME1WdndUQzdid0dEVlhhRUFXYW1hSkc2a2Zkb0daR1c2c1FUSk8z?=
 =?utf-8?B?bnNlUVBLdjlReEJqUTZJWGlCTUx5SHdYMUNsR2FBSUV1ZVd4R2xEbjdaRzFD?=
 =?utf-8?B?bG5STHJCc1JOVisvckI4OW5DNkFiTVlzMXZYbUZYTnZWdWhnNmI4NGJVWGRL?=
 =?utf-8?B?UENrNG1ERzduWFJkZGdHdVlaeTZ1Vm81NWhWbFFXRExtWkEySlphR1pGcjBq?=
 =?utf-8?B?bjNGbDBTbEIxU25LdVpiY2dPbGlLUjFQNC9xU29lZzZxaVJwRG0rV0tUekIy?=
 =?utf-8?B?eHZFalUvWmk4ejBHUzg0MnhzNURPZXJ5L3dHVFJ0U0xPTFpoQ2J2N3orb0oz?=
 =?utf-8?B?Y2NMQ2JPVkg3M0hQSGY2enQ3cHFVUk4yRTVwMmsyZS96cDVaU2lVY2FESDl5?=
 =?utf-8?B?cjYvK1VNVkt3RkdYd28xVysxQzlCbWZpTXk3a1dCelBlZFA3STcxd2g2ZUIy?=
 =?utf-8?B?WUhpWUVNT1g0TWo4amVIVitoWTE3Y25LUVpQQnhnWXNkOXgreDR3VDVSOEpC?=
 =?utf-8?B?ckZrQVRnK0c0cEJyekQ5aW9IK1liRXZEZytXZVZEdTQwOTBNSmluOTcvVHFG?=
 =?utf-8?B?R1lRblprc0Urb3B0OTVsMnZHb0xZeUFKZzFVOTV4UUd0THgwVzNDamhPRURJ?=
 =?utf-8?B?MWJhOWg2QkpBYUJ3WWhoZlBtcXlMSE8wcWFYL0dqQ0tyQWhnMGtFcGNBQmMr?=
 =?utf-8?B?VDhaWHIwOHZFRkxCZVloaFpLL0lQdTVEaFV4Wmx6bS9oZkd1eWVqUW5Jdmp5?=
 =?utf-8?B?NkQ3aFRtdXZXaFhCZW5rSTdQTlhEZkFoT0wrcmcydmRjN3NZSzVZR1BCcW9N?=
 =?utf-8?B?c2VVMWxaVyszN090b3JmbWFsbkRtMWM2blhobW9uNzRtZit6V3MzVjBaUTJo?=
 =?utf-8?B?R1VoTHFoRmk1Z0RXZzRBalVtcWx4WHBERzhtSllWYk9oekI5Vlo1S2lYbW5F?=
 =?utf-8?B?Qkd1QmxZQmVjVTlBdGtRWXlsS0J3eVRMT1lLd3B1bjNnZWdGOWFvZlUzQmpP?=
 =?utf-8?B?OEFkSmVCYysxckM3TlZZaUgwQi9uM0wzVlBtc1pYZHc2elF4MHgxcmJhZnlT?=
 =?utf-8?B?VEIrbTdsT1phalQ5cTdFRCtyeFFNemJncTJIamJIcTFuTnhyV1pjRUVadkdz?=
 =?utf-8?B?RTdiaEJ1ZnRhV3RRN09lVXg0dWVPZERtMjJ5NXF2RlRDRFJqU1NaQklIVmYv?=
 =?utf-8?B?cERxWDJXcDFHSlZpWG5VR2c3cStPNDhRekxsVVltZE1aZ0F0bkozL2F3dzRt?=
 =?utf-8?B?UnIvSnVNM3N6SGM3eUhuL01NR09GQXRHWHkzRFlGSGd3VWpZd1pKRyt3Ry9a?=
 =?utf-8?B?TXFaQjVGK0djTk5jbXRRR0FiSStPSGMwOTI4SW5qeFR5UmxuN0xwWGpyMmFj?=
 =?utf-8?Q?us852V/t?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZjJFVFRnM0toTE5xdHpTWTd3UUlYL0lVb1BUS3BBMVg0Qk00ZWxkY3FTSC9D?=
 =?utf-8?B?akFHY1pkNXcrTDBGQmdOLyt2SFgzS2wrd2dsRlBSUUpoWGMvbndpZUk5R0V6?=
 =?utf-8?B?STJnMkwwTVoxQ2Z3Nzc5dGxyQmxLTUpodUJnbUdkVnlJcklOK2I3c3pKQXB3?=
 =?utf-8?B?NU90YTZVMjNoRHF3ZE8rcHQ1bVNUMm1ac0x2Yi9rTlFjRHc0aWZwMmZsdm1s?=
 =?utf-8?B?R1hhY0VjKzhjejRwODh3d21XTmNneExZaU9DWUdDM3BzN0V5V0RVUzFjMmh2?=
 =?utf-8?B?RUJuVmRId3dTdU53M1YxcTYvRjZpNks5VmxBOFVpZ2VvQVdZbUdseERzQjVp?=
 =?utf-8?B?MkhWQ2ljNHVCbk1tdktmVDZGV2JFN3RvcnpRRnFyaVhOQTZkeE8ySDFwWUJZ?=
 =?utf-8?B?VmVSbXJvWm9OczM2em1QSXZxY1c4MFNCWFlzQ1dlYUpUUEd1S2JwYzAxQW5s?=
 =?utf-8?B?dktwZEJPbW5LdlBuVmtZYkluS2V5eEREeHQ3aUFjWGtja0RLWU9HYWZDaU1Q?=
 =?utf-8?B?Y001N1J4MGdGNEtBSGp2bW5wa3JKc3JCUUpRWjVWTzhPTmU3U0p6Q3BDWjBR?=
 =?utf-8?B?VHd2TlVWdkZyTkFiZFo5dWRJVk1MdnRCZmQ0c0JIcHFYZFlVMnFDWDZsSGsy?=
 =?utf-8?B?b3ZqRmducnptQ1RoMUpaTXRoL3h0d0xzajdtaE9aeTV4RU5McUdoV2pOdmR2?=
 =?utf-8?B?emRkRVJYSCtEd3NJSFViN1pqcmFBSmVNRDhtR2dpYm5MQzdRR2ZQbHVmRzhl?=
 =?utf-8?B?eXp0WmIvRkI5M0lOQlBqQ2dadXF6cW5CZTJ3a1ZVVTEyWnI3eVpEVnlHcXF4?=
 =?utf-8?B?Nk5nQ1lLa3krY0ZzK29ZYlk2R1Nha1BzSUpMeFQ0NWxxRncwUExnVC9WM3NZ?=
 =?utf-8?B?T29VbWpTQjYvZVhabUlBeTVWcWpwNktVMktHTXk1ZUl6ZGlKUGN4QWZieHQv?=
 =?utf-8?B?cWVHU1p5L1puYTIvRlFyRHE4bCtmWDdiQitjYkFCbk9oUHRidUQrOFN6UU0v?=
 =?utf-8?B?UmRJV0xFclJDMENVNVIvMlF3VjQyalBkbkJXK25GTjJJbnRwc2krc3VvbmFT?=
 =?utf-8?B?VE9NMWY2WGRTZTRKZXh3ZFZ2WXA0ZEtBNWVxK1RhSXFXSDNRaXJDREwxd1Jo?=
 =?utf-8?B?eGFsaWVFNGxXVnRXdFpVbFFxSkcyUTA1WGhCWnNWSndDMjZOWlcwaXhpOEtE?=
 =?utf-8?B?ZjhrUlJyL0VWV3ZzUVQ2eDBHRi95RTJzM3hrV2VrM3lGdDMxcFNqcGQrT2sr?=
 =?utf-8?B?cW82cHFBYjAxeWxma0hpZHJqLzd6dlhUREx2S2hvT3BzWC96VUxISjBlL3Qv?=
 =?utf-8?B?SVM3dDY5S2hPK2ZrSWNPZEhkMnBvRkthYkRJVGt2VTA1TjFXTkp1RDBzNWpC?=
 =?utf-8?B?Rm16TDRJRUxLMm10ekRjQUo1dGg4d2c4ay9XKzRFUkZCMUlyY2g5N2ZkR1Fu?=
 =?utf-8?B?U21kdHl3OERWK0x1QjJWbURFM3lDbVV4dFZGazlweVlpMXNyYTRscU9vU25Y?=
 =?utf-8?B?RmpXUUxVdXkzWmQrQUFHWXBVbTlpbmgzWTZieEk4cnF3SWVvbFRmL2hPZTFG?=
 =?utf-8?B?aW1ZTXNKT0o5TTdtaGJGeVIyd2VzRjFhS1pHUXFvNmNhaVk5Q3lKZkZzdW9M?=
 =?utf-8?Q?BCCDcCnRZaC7l2s0D1Mz0WDFofXFi/OrQiY3+G9HWQxw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ff4d28-411e-41f3-c6ef-08ddc7fd15a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 02:19:55.9835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10581

RnJvbTogUm9tYW4gS2lzZWwgPHJvbWFua0BsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBGcmlk
YXksIEp1bHkgMTgsIDIwMjUgNjoxNiBQTQ0KPiANCj4gT24gNy8xOC8yMDI1IDE6MjUgUE0sIEVh
c3dhciBIYXJpaGFyYW4gd3JvdGU6DQo+ID4gT24gNy8xOC8yMDI1IDEwOjEzIEFNLCBNaWNoYWVs
IEtlbGxleSB3cm90ZToNCj4gPj4gRnJvbTogRWFzd2FyIEhhcmloYXJhbiA8ZWFoYXJpaGFAbGlu
dXgubWljcm9zb2Z0LmNvbT4gU2VudDogRnJpZGF5LCBKdWx5IDE4LCAyMDI1DQo+IDk6MzMgQU0N
Cj4gPj4+DQo+ID4+PiBPbiA3LzE3LzIwMjUgOTo1NSBQTSwgbWhrZWxsZXk1OEBnbWFpbC5jb20g
d3JvdGU6DQo+ID4+Pj4gRnJvbTogTWljaGFlbCBLZWxsZXkgPG1oa2xpbnV4QG91dGxvb2suY29t
Pg0KPiA+Pj4+DQo+ID4+DQo+ID4+IFtzbmlwXQ0KPiA+Pg0KPiA+Pj4+DQo+ID4+Pj4gVGhlIG5l
dyBjb2RlIGNvbXBpbGVzIGFuZCBydW5zIHN1Y2Nlc3NmdWxseSBvbiB4ODYgYW5kIGFybTY0LiBI
b3dldmVyLA0KPiA+Pj4+IGJhc2ljIHNtb2tlIHRlc3RzIGNvdmVyIG9ubHkgYSBsaW1pdGVkIG51
bWJlciBvZiBoeXBlcmNhbGwgY2FsbCBzaXRlcw0KPiA+Pj4+IHRoYXQgaGF2ZSBiZWVuIG1vZGlm
aWVkLiBJIGRvbid0IGhhdmUgdGhlIGhhcmR3YXJlIG9yIEh5cGVyLVYNCj4gPj4+PiBjb25maWd1
cmF0aW9ucyBuZWVkZWQgdG8gdGVzdCBydW5uaW5nIGluIHRoZSBIeXBlci1WIHJvb3QgcGFydGl0
aW9uDQo+ID4+Pj4gb3IgcnVubmluZyBpbiBhIFZUTCBvdGhlciB0aGFuIFZUTCAwLiBUaGUgcmVs
YXRlZCBoeXBlcmNhbGwgY2FsbCBzaXRlcw0KPiA+Pj4+IHN0aWxsIG5lZWQgdG8gYmUgdGVzdGVk
IHRvIG1ha2Ugc3VyZSBJIGRpZG4ndCBicmVhayBhbnl0aGluZy4gSG9wZWZ1bGx5DQo+ID4+Pj4g
c29tZW9uZSB3aXRoIHRoZSBuZWNlc3NhcnkgY29uZmlndXJhdGlvbnMgYW5kIEh5cGVyLVYgdmVy
c2lvbnMgY2FuDQo+ID4+Pj4gaGVscCB3aXRoIHRoYXQgdGVzdGluZy4NCj4gPj4NCj4gPj4gRWFz
d2FyIC0tDQo+ID4+DQo+ID4+IFRoYW5rcyBmb3IgcmV2aWV3aW5nLg0KPiA+Pg0KPiA+PiBBbnkg
Y2hhbmNlIHlvdSAob3Igc29tZW9uZSBlbHNlKSBjb3VsZCBkbyBhIHF1aWNrIHNtb2tlIHRlc3Qg
b2YgdGhpcw0KPiA+PiBwYXRjaCBzZXQgd2hlbiBydW5uaW5nIGluIHRoZSBIeXBlci1WIHJvb3Qg
cGFydGl0aW9uLCBhbmQgc2VwYXJhdGVseSwNCj4gPj4gd2hlbiBydW5uaW5nIGluIFZUTDI/ICBT
b21lIGh5cGVyY2FsbCBjYWxsIHNpdGVzIGFyZSBtb2RpZmllZCB0aGF0DQo+ID4+IGRvbid0IGdl
dCBjYWxsZWQgaW4gbm9ybWFsIFZUTDAgZXhlY3V0aW9uLiBJdCBqdXN0IG5lZWRzIGEgcXVpY2sN
Cj4gPj4gdmVyaWZpY2F0aW9uIHRoYXQgbm90aGluZyBpcyBvYnZpb3VzbHkgYnJva2VuIGZvciB0
aGUgcm9vdCBwYXJ0aXRpb24gYW5kDQo+ID4+IFZUTDIgY2FzZXMuDQo+ID4+DQo+ID4+IE1pY2hh
ZWwNCj4gPj4NCj4gPg0KPiA+IEknbSB3b3JraW5nIGFsbW9zdCBlbnRpcmVseSBpbiBWVEwwLCBz
byBJJ2QgY2FsbCBvbiBOdW5vLCBOYW1hbiwgYW5kIFJvbWFuIChjYydlZCkgdG8NCj4gaGVscC4N
Cj4gPg0KPiANCj4gTWljaGFlbCwNCj4gDQo+IEknbGwgdHJ5IHRvIHNxdWVlemUgdGhhdCBpbiBk
dXJpbmcgdGhlIG5leHQgd2Vlay4gRm9sa3Mgc2hvdWxkIGZlZWwgZnJlZQ0KPiB0byBiZWF0IG1l
IHRvIHRoYXQgOikgVGhlIGNhdmVhdCB3b3VsZCBiZSB0aGF0IHRoZXJlIGFyZSBzY2VuYXJpb3Mg
dGhhdA0KPiBhcmUgYmV5b25kIHRoZSBjYXBhYmlsaXRpZXMgb2YgdGhlIGhhcmR3YXJlIHRoYXQg
SSBoYXZlIHJlYWRpbHkNCj4gYXZhaWxhYmxlLCBhbmQgd291bGQgbmVlZCB0byBydW4gaW4gdGVz
dCBjbHVzdGVycyBpbiBBenVyZSwgYW5kIHRoZXNlDQo+IGFyZSBwcmV0dHkgYnVzeS4NCg0KVGhh
bmtzIGZvciBhbnkgdGVzdGluZyB5b3UgY2FuIGRvIG9uIHN0YW5kYWxvbmUgdGVzdCBtYWNoaW5l
cyB3aXRob3V0DQpuZWVkaW5nIHRlc3QgY2x1c3RlcnMgaW4gQXp1cmUuIEl0IHdpbGwgYmUgaGFy
ZCB0byBnZXQgdGVzdCBjb3ZlcmFnZSBvbg0KKmV2ZXJ5KiBoeXBlcmNhbGwgY2FsbCBzaXRlIHRo
YXQgaXMgbW9kaWZpZWQgYnkgdGhlIHBhdGNoIHNldCwgYnV0IGRvaW5nDQpiYXNpYyBzbW9rZSB0
ZXN0aW5nIG9mIHJ1bm5pbmcgaW4gdGhlIHJvb3QgcGFydGl0aW9uIGFuZCBpbiBWVEwyIHdpbGwN
CmNvdmVyIG1vcmUgdGhhbiBJIGNhbiBjb3ZlciBydW5uaW5nIGluIGEgVlRMMCBndWVzdCBvbiBt
eSBsYXB0b3Agb3INCmluIEF6dXJlLiBGb3J0dW5hdGVseSwgdGhlIGNoYW5nZXMgb3ZlcmFsbCBp
biB0aGlzIHBhdGNoIHNldCBhcmUgcHJldHR5DQpzdHJhaWdodGZvcndhcmQsIGFuZCBteSB0ZXN0
aW5nIG9mIFZUTDAgZ3Vlc3RzIGRpZG7igJl0IHR1cm4gdXAgYW55IGJ1Z3MuDQpJJ20gaG9waW5n
IHRoYXQgYWRkaXRpb25hbCBzbW9rZSB0ZXN0aW5nIGlzIG1vcmUgYWJvdXQgZ2FpbmluZw0KY29u
ZmlkZW5jZSB0aGFuIGZpbmRpbmcgYWN0dWFsIGJ1Z3MuICAoRmFtb3VzIGxhc3Qgd29yZHMgLi4u
LikNCg0KPiBWVEwyIGN1cnJlbnRseSB1c2VzIGEgbGltaXRlZCBudW1iZXIgaHlwZXJjYWxscyB0
aGF0IGFyZSBzZXQgYXMgZW5hYmxlZA0KPiBpbiB0aGUgT3BlblZNTSBjb2RlIChgc2V0X2FsbG93
ZWRfaHlwZXJjYWxsc2ApLiBZb3UgY291bGQgdGFrZSBhIGxvb2sNCj4gYW5kIGNvbmNsdWRlIGlm
IHRoZXNlIGh5cGVyY2FsbHMgcmVxdWlyZSBhbnkgYWRqdXN0bWVudHMgaW4gdGhlIHBhdGNoZXMu
DQoNCk15IHBhdGNoIHNldCBhbHJlYWR5IGNvdmVycyBhbGwgdGhlIGh5cGVyY2FsbCBjYWxsIHNp
dGVzIHRoYXQgb3JpZ2luYXRlIGluDQpWVEwyIGNvZGUuIEFnYWluLCBhIGJhc2ljIHNtb2tlIHRl
c3Qgc2hvdWxkIGhlbHAgZ2FpbiBjb25maWRlbmNlLCBvcg0Kc2hvdyB0aGF0IGFueSBjb25maWRl
bmNlIGlzIG1pc3BsYWNlZCA6LSkNCg0KPiBNeSBvcGluaW9uIGhhcyBiZWVuIHRvIGhhdmUgdHdv
IHBhZ2VzIChpbnB1dCBhbmQgb3V0cHV0IG9uZXMpLiBBcyB0aGUNCj4gbmV3IGNvZGUgaW50cm9k
dWNlcyBqdXN0IG9uZSBwYWdlIEkgZG8gZmVlbCBhIGJpdCBhcHByZWhlbnNpdmUsIGdvdCBubw0K
PiBoYXJkIGV2aWRlbmNlIHRoYXQgdGhpcyBpcyBhIGJhZCBhcHByb2FjaCB0aG91Z2guIElmIHdl
IHR3ZWFrIHRoZSBjb2RlDQo+IHRvIGhhdmUgMiBwYWdlcywgcGVyaGFwcyB0aGVyZSB3b3VsZCBi
ZSBubyBuZWVkIHRvIHJ1biBhIGZ1bGwtYmxvd24NCj4gdmFsaWRhdGlvbiwgYW5kIGV2ZW4gc21v
a2UgdGVzdHMgd2lsbCBzdWZmaWNlPyANCg0KTXkgdmlldyBpcyB0aGF0IHRoZSAxIHBhZ2UgdnMu
IDIgcGFnZXMgaXMgbXVjaCBsZXNzIG9mIGEgcmlzayB0aGFuIGp1c3QNCnNvbWUgY29kaW5nIGVy
cm9yIGluIGludHJvZHVjaW5nIHRoZSBuZXcgaW50ZXJmYWNlcy4gVGhlIDEgcGFnZSB2cy4NCjIg
cGFnZXMgc2hvdWxkIG9ubHkgYWZmZWN0IHRoZSBiYXRjaCBzaXplIGZvciByZXAgaHlwZXJjYWxs
cywgYW5kIHRoZQ0KZXhpc3RpbmcgY29kZSBhbHJlYWR5IGhhbmRsZXMgZGlmZmVyZW50IGJhdGNo
IHNpemVzLiBTbyBJJ20gbm90IGFzDQpjb25jZXJuZWQgYWJvdXQgdGhhdCByaXNrLiBXZWkgTGl1
IGluIHRoZSBtYWludGFpbmVyIGhlcmUsIHNvIEknbGwNCmNlcnRhaW5seSBmb2xsb3cgaGlzIGp1
ZGdtZW50IGFuZCBndWlkYW5jZSBvbiB3aGF0IGlzIG5lZWRlZCB0bw0KYmUgY29uZmlkZW50IGlu
IHRoaXMgcGF0Y2ggc2V0Lg0KDQpNaWNoYWVsDQo=

