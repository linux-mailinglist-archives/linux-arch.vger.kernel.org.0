Return-Path: <linux-arch+bounces-6637-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE7495FD5B
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 00:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D961B233F1
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2024 22:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F0B19DF53;
	Mon, 26 Aug 2024 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YcAh79LX"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786C0199E9E;
	Mon, 26 Aug 2024 22:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712391; cv=fail; b=nqyuA1MYaevHgCgndYvTKWuSzx5B2iiHH9M3L0LLD84RQO11yXtkj6pKqsXtIMPLGTYGfWHnGFUVWfXo2gpjK4+o0KMRRf2fa6SlXVn5PjOSqPomoqQO5cyAvAyBzPamhWQnGVAyvcafvKdyO09BTD5C4lwC1sFwTFHsGkIV86g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712391; c=relaxed/simple;
	bh=CvsnoZOnhatFHpsGg4jpXg2L/nnzElWsi8E41Qc7GNA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tnqy6SNow3mn9yD81q0TUd4X8fYEzyK//0ujeBwX//vMFd4xealfj1yJeQmi/GTj2lvN7l7imgpnzBlSEj1ZK1PvNZSPmXUun6J+XsC+dcZ51vy9EEfJ+qRc5pcSJvt8cXxO+EuVj4X9NtLf7AeLnUDNv3t9rQMhnLe4f7T8U9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YcAh79LX; arc=fail smtp.client-ip=40.107.96.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTrIedz8XmWUyD90/Pqe6EtM/pIbSyt32coRCHdR8Td6sqE6OMWSyZ/gUp6+llzBjyn/iL8Da4q3nBpu0KuSdNxbaLDDG9rJ94BzjtFsD6EnnZOLDham2pU5X7/rqA1m/zytBqa8XiZwWoX+cbcxNvstOg2SX9MS/rE02aZSuhDYhm/qVJ/iOHz7lI1l7/RbAWJLHCCulxrzc+64wSnioMCvX5TRvPNPQSDxr97Z07nHgsMzO3d2mvjPmp2u4lDOMtAwI2BVvg//++nl34A5kpZfiJbQitUsezQSsIW40TkO/waARTw413csfXR1knYJc4oJxOk3hz9ZH2anBWaU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvsnoZOnhatFHpsGg4jpXg2L/nnzElWsi8E41Qc7GNA=;
 b=ksV0y2Bvp59QHlY/tazyCcUGKPoLi+1SvibpSYbxpSC5xU8JyhX9IoFTPoRmTM7bmtlPf4kampX+rA6OApnovb9vQF9wrqi0Y0E36Voo/hVY9+wlJmh3QnwhxlZ7vRp18kRePjANpvfE7lwKU2v8Bbxw4UE7HoaUWk7j28HV4Ax3qgk+5eVHYDj8+dMcbjRmVqMsQjxtynP0Gwo/ElBiTuQ2/H4aH/rHcyib93HFMALHGDFzHqtqkC7CQPS/fyr5lznuYaUJQAs6r5WvQj03D2Zalpox40Z90FfRuw66aEfynXABraYSCg4oOj12M1oGj1yo3kxfulMq66vzYkM2zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvsnoZOnhatFHpsGg4jpXg2L/nnzElWsi8E41Qc7GNA=;
 b=YcAh79LXVztSVyfxDirKpGYkP2NNuouSaM1DBKZ2WEP0p7M5pQAqZPW6Q/j0oPfF3jIKy5wgl3/qBc5Yx6L9jhdDC96P4lnmJj9KJbWFGok+XJUWSVjGeEHMrrS/h2SkLTYHYZymu9pajqTg0Gy0tkrOIVqKJopruhBFFuDX92x+H00ZWtiVcYUHHe2xgXFyDfySxTcuqdn/aX3tjsaf1DJK/RbbJfloJ0DTPXHCj4nfbSfF1lS7kLajHz5+WCDQGsf/zn6cZ8NDXsyElCRyViUFHnC5q/uj4sQUj1T0r7eB2Bt4PRUXjcE4wyxTYiUKEsB6HT5GeDfZYOBxOOwXDQ==
Received: from MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 22:46:26 +0000
Received: from MW4PR12MB7261.namprd12.prod.outlook.com
 ([fe80::d231:4655:2e3d:af1b]) by MW4PR12MB7261.namprd12.prod.outlook.com
 ([fe80::d231:4655:2e3d:af1b%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 22:46:25 +0000
From: Bruno Faccini <bfaccini@nvidia.com>
To: Mike Rapoport <rppt@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dan Williams
	<dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David
 Hildenbrand <david@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	Davidlohr Bueso <dave@stgolabs.net>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Heiko Carstens <hca@linux.ibm.com>, Huacai Chen
	<chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jiaxun Yang
	<jiaxun.yang@flygoat.com>, John Paul Adrian Glaubitz
	<glaubitz@physik.fu-berlin.de>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Jonathan Corbet <corbet@lwn.net>, Michael
 Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@dabbelt.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Samuel
 Holland <samuel.holland@sifive.com>, Thomas Bogendoerfer
	<tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, Vasily
 Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, Zi Yan <ziy@nvidia.com>, Bruno Faccini
	<bfaccini@nvidia.com>
Subject: Re: [PATCH v4 24/26] arch_numa: switch over to numa_memblks
Thread-Topic: [PATCH v4 24/26] arch_numa: switch over to numa_memblks
Thread-Index: AQHa+AnIRBd2eSXrZ0i2X6o1hDRrJQ==
Date: Mon, 26 Aug 2024 22:46:25 +0000
Message-ID: <1DDED2FB-35F4-4159-B46B-0F3846DCF98E@nvidia.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB7261:EE_|BL1PR12MB5898:EE_
x-ms-office365-filtering-correlation-id: b75fd6d2-6a02-4a56-8fdb-08dcc620eabf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZjRQeGFoQWdlckUvUERuV3dPMWJjNW1VU0JFc3dVR0ZNVFdUaWF5Y3ZkenJr?=
 =?utf-8?B?R2drcnhMZUpCeWhIekNJcXdQNUJwanFvbGJlV3lnQVpoRFZvV3ZhOHBDMnhB?=
 =?utf-8?B?UlBDVVhKYUZ2RUwyd0M5TTZmY2htYUpnaXhvbCs2R251blA3YnNRUWpjV3o3?=
 =?utf-8?B?MnhiR2wxOW9WbU1zdndwdGtSVmVxaGNiU1R0alZDZzczYXpMVWNYOU50aEdO?=
 =?utf-8?B?bmNtTGMveHkwaWNOZnZLemF5b1pQWUJrRHN0V2l1QTRMRVVwK0YyS1E2czlR?=
 =?utf-8?B?Z1E4Tlh5OWVzMjRiVExZcHhxbWh5VUM1ZkQva3h3OTlzL1Q2OWs5YVQwYmVp?=
 =?utf-8?B?cjBUY1BMMnpqcVhEaUtZUTZvN3NwaG5wVGRvNHF5R0lnOWJnTWJweVN0OWlD?=
 =?utf-8?B?Rms3TC9WRm9ZWlcxR1YvSnpYZWwxdW4yZGRHMytEaW8yamo4SGRPVXp3Qldk?=
 =?utf-8?B?Slk5L1JORmhKMG9wL3Q5M3luaHNPQ3hKbURQbTV3dWhneWhXZVg5L1A1S1A0?=
 =?utf-8?B?SG1JQThxamJKNWJUbUIzMlEwbU5pUjhGaUZiRGRkdnJvZURCdzMwL3VZbHJF?=
 =?utf-8?B?eFYrUnhFRUtvUFY5OUtJWXdJbFFVV1NlSE5wVHFxTUlWTG03eDdpa3V5R0hX?=
 =?utf-8?B?TUhPeHNXTVpVVlRPMXFyTUVjd0hSM1R0TmRqcE9xMWJ2MW5nd0N4WWZ5L2J2?=
 =?utf-8?B?YU5xMVk0WTRYdHdjVTl1YzZ0a2NwOWM2UlhybSsrMEFIU3p2eTBUaHRxKyta?=
 =?utf-8?B?UmUrZ3Y3bE1YMU96RmU2cmxIdllhWnFid3gxNWMzMXVxZHh1RCswSGFHVEIv?=
 =?utf-8?B?VTRBdUJoaHlZSzN6bUtxQnFEb1dLNGprSlc0ckMyUmNCYXFFaUFFSmQyeDhv?=
 =?utf-8?B?elI5YUd2bUpWSFNPQVhlVmxYWmxNYXVRZSszelpnamVGMm55TEpVb3llVlZa?=
 =?utf-8?B?R29ybG9XR2wybVkvdHNRMlhTS08vNUk1SHcxck96MFFEK3ZlZW5lZ1V0a1Fy?=
 =?utf-8?B?OU1iZFh1clF5czMzaXF4djdXMnMwdGNtSGZheGxYSlJabm5BM1FXSXhQc1dh?=
 =?utf-8?B?ckg0a1NEZzZFb2kvdVdOdW9DRHViUTR6TzJaaUdBSUY0dklPbk85dWxlMGFu?=
 =?utf-8?B?bDA1MWdEbGVhMGlrbXA3YVlsVmFqWXpJaE1ZTEFpMGpJSjJ4NDcrSE9FWEgv?=
 =?utf-8?B?aW1TRGs5bDA2ZTlxbXdnWStMKzdUQUN0Qm1WcVVuTHNtN1dZdEIxM04yajZN?=
 =?utf-8?B?S3NlN0k4OUduZHFBVEhScFI4T21MTlczNGdRNndOWEM3Ri9aa2wrcTNZQklo?=
 =?utf-8?B?dG02NTB1aEcwQ0I1SEZWbFA3VHYxaGdlUVpIQkl5ajA1M3UxVlZNazdBaFll?=
 =?utf-8?B?R05jR2dJVkhmVUJmSkhLeVRpdmlGMUhJdldjWUUyUWFmM3NTNTFybU9yTitE?=
 =?utf-8?B?NUFXNUQ2MEsxdkFuaUpVV3hUSjlxR1ZPMTIxcEowcE5uTGp6NVR5b2R5Z0Fx?=
 =?utf-8?B?djA0Y0laWlgyakJaK2t2NGRqelBlNkJQdlJ0VDAzUUxyT3Y3NXhPUEl2ZUV5?=
 =?utf-8?B?a0ExbTNHWDk5QjRETGtOdVN3dnVTYXcxTzZmOTYzVk1sb3NUcWFiZTRFcFZ4?=
 =?utf-8?B?VmNJZjZQNVc5Rm80RkVEQXE2YmduOS9uMzdSU1l5VWVUWThBdWR4ckRoYnRx?=
 =?utf-8?B?N2IrZmw0cmM2RnJIVktoUnBwTnRJOUhVYWN1OEpMVk82NklCODBmTnVBUThF?=
 =?utf-8?B?QXpmajR1M3Q1UVlFMTJ0OHBSV2F6YndrWmRqRktkUTJENW1tRmpPRWszZnNm?=
 =?utf-8?B?UGlXY3JqVDI0bmpLVWlQd3N6bEV5Nm0zZHp4ZVNkYmtMeXFaMlF1QU90SUh2?=
 =?utf-8?B?aW00M3VrRXlSZHpxVmlwUmZaeG45STg4U2pMeURTUFhFUFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7261.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlVnaWFuakxjOE5OTk5rb0ZTRkhIS3NJVVNNdForOGYrK1NSSTJacEdvZmE0?=
 =?utf-8?B?aTBwbUZtVGh4OHp6ZStERUlCM0NVLzF4KzZMSklOR3FsUjEwdUcxb2YzYnl5?=
 =?utf-8?B?TFByWkJqbnV1YXBsbDI3Tjd0TDU5VGZqU2lPdjZNK2ZENGVKUlovTlJmVGgw?=
 =?utf-8?B?ZVRWUEpjeVl1KzhieTNjb2VSa0ZxTENGNURoUmI2Z3N3bmhETVdEcnRWNzBX?=
 =?utf-8?B?bDBhMkw4ZDZQZmF3Wk5IWHdiWmdIS3h6ck5BUTMvaTB0WXZOSGVyTkE1c0FD?=
 =?utf-8?B?eEQreXhnZTZ2TUxwREpleGt6czU1OFZrQlN4cXFCUDR4RHdtc3MxVVl5KzBh?=
 =?utf-8?B?TWVGa0I1MEdrUUlXK1NkV3pHaE5IZUoxak9HSDczMWVtWkV3aWtISk9wWFRP?=
 =?utf-8?B?WU0xN0ZpbEZBN24rbjR4SUZYY3V1cmhmd3ZzM0JoRXVuR280SzljRFBVTVd5?=
 =?utf-8?B?NGRxZHI1UnhhZHpobVUwREluQVNqSUtQbUwwVTZNeHgrcy9NZXdFRXcrczgv?=
 =?utf-8?B?YkJBcGVtRWZ1N1owRC9vc2MvTHNvTWdMUVpsNHhCZVlncDFpcURHZHRBTlVQ?=
 =?utf-8?B?TGE1L3I1anlHd2paWmM0SWZhaXVvajJsUk5SeUJGRU1ZVytzTmkyOFJoaUE5?=
 =?utf-8?B?MHJ5NkR3bllwSHhkSVk0UkxqMWt3R25CajFPYVIxSExtaTIzbDVodVIvTFRM?=
 =?utf-8?B?RXlhSFZkWnJpenZpS21tQVJPamppcnF4UEtzZDNQc1BxYXlCVWNtUSttZ3Qz?=
 =?utf-8?B?c0pzYTFGZ21uSVJOSk5sYXM0ZkVpQVFrb09FbDhHSzAyVlN6MHNDMk9TVkNa?=
 =?utf-8?B?VEh6T1FUWFlOZ0IrT0xtdzUyR3NCOU1TZ0NwVUNKc0xuU1NvazlJaDludHQ2?=
 =?utf-8?B?K1UzOVJnQXpnMHFRYThkNEpMM1d1cFVyQzZUb1RHWUVUSGU4ZHV4R2Rtb3dz?=
 =?utf-8?B?UVlUYnl1SUFsTDZIempHWDJDSGhBU0U3cG52U0t6SSt5QktnTTluOGwzSEJP?=
 =?utf-8?B?dERBMHZ0NzdlMkdXUFM1NmthWUx1LzEzVW5URVZiamQ1cU5xN3FuMnNGYmxK?=
 =?utf-8?B?Z1Q0VDNMVDU1cUw0Qk92blVxOHluVzF3RGFQTjYxT29KTWd0U1lWYkxUdzNL?=
 =?utf-8?B?cFpxbTVXMWZYanJ5MDF6MmZkdTBCQWptQ3RSdjc2UHZmYkV0ZnVSTG8zSjFC?=
 =?utf-8?B?cHZ6OWZjVGVBdXQ1OHM5MTQzcVRDb2hMV1pYNlU4T25yQnFQeUpvT1dUKytp?=
 =?utf-8?B?dUIyMU5GTVNwRy9yeU5aOWFnaExvN1hZUzFoQks5NlNtd1VvbmpLK3ZINGhW?=
 =?utf-8?B?bDlPYTB0RG9pMHp4QkQ5dUNtZjdoVHVzN1hHbXJmaE5Ed2RNbElRTWUrdUoz?=
 =?utf-8?B?WUo2akxUNzk0WFp3TXY5WlFEbVpHdDlxd3lpeGFXNWQycTAxRGxIcnVNcGdq?=
 =?utf-8?B?L04wWEh2ME1xK2p4WnJhb1UvYzlQTEV5RHdFUmh3V0dJQTNXWFRFNGxKNmNo?=
 =?utf-8?B?WjlBNmFYMS9xSjlGbnZDcmNxcFAvNDd3QmV6dGU4dmVoeGRISVhYOEFrcXNL?=
 =?utf-8?B?ckRISDdKVi9LN1MyTUtZOEpLMmdJQnBaOVdTYWpYamtaSW9ZZDhKYmhwaDA5?=
 =?utf-8?B?cW5Oc0FNaHBvK25lc1F2Q0JnS1JQMVc2MmZFQnpPeWxlZXNwSnFMakhuZTls?=
 =?utf-8?B?dDRGYVVaczJhM3hCZ09kZ1lvYktFZjBNRmFSUDUxdDJmdk4wNzFSejc5UGVD?=
 =?utf-8?B?MXhHTGJBSWhjdFU2bDhDc0tHR3BFNEpXNzIrUTQyMWN0N0xZRU45N20xdjBu?=
 =?utf-8?B?U3ZRd1FPNWVzcEppZzBRWFN0WXc1cWZCaGc5WjlGVEpsWlBpRnFsSGoxWDFk?=
 =?utf-8?B?ZnNnZnkxZTVURnlTM0dyMi9pSmFYYjdvWGlUMG8xWllEUHZFUXVLV25tbkhD?=
 =?utf-8?B?WGwyNjZieE1rdGtuN0VQRWFvaVpGZDN2QnprbUo3RE9oODIrQmhhTUllTklU?=
 =?utf-8?B?SlBOWFlZWGFiTG9LaWJ2SXl5WEpXTVNMbjBlS0c1cndDL0s4TFhPMi9EU0hT?=
 =?utf-8?B?TmZjZmxRN1o3MW9rQjdYS1c2L1J5WnVLMm9DeGF6M1cwUWZscW9KQVgrai80?=
 =?utf-8?B?ZjlvQkgzZm9sTDlxd1dENldWRy85bEtmL2taUnlCVEVpeHEyMjRjeDE3aHBB?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F4492824914CA4FA50DC0267F51BB56@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7261.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75fd6d2-6a02-4a56-8fdb-08dcc620eabf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 22:46:25.9148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wi0Dfi/63jsXvLarc8o7ASUEHowwfoiQMYoZLqlu59h29J6rQnEETTrBrEKSHueUDnyk13A+f+gnM8UJgLFBIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898

T24gNyBBdWcgMjAyNCwgYXQgMjo0MSwgTWlrZSBSYXBvcG9ydCB3cm90ZToNCg0KRnJvbTogIk1p
a2UgUmFwb3BvcnQgKE1pY3Jvc29mdCkiIDxycHB0QGtlcm5lbC5vcmc+DQoNClVudGlsIG5vdyBh
cmNoX251bWEgd2FzIGRpcmVjdGx5IHRyYW5zbGF0aW5nIGZpcm13YXJlIE5VTUEgaW5mb3JtYXRp
b24NCnRvIG1lbWJsb2NrLg0KDQpVc2luZyBudW1hX21lbWJsa3MgYXMgYW4gaW50ZXJtZWRpYXRl
IHN0ZXAgaGFzIGEgZmV3IGFkdmFudGFnZXM6DQoqIGFsaWdubWVudCB3aXRoIG1vcmUgYmF0dGxl
IHRlc3RlZCB4ODYgaW1wbGVtZW50YXRpb24NCiogYXZhaWxhYmlsaXR5IG9mIE5VTUEgZW11bGF0
aW9uDQoqIG1haW50YWluaW5nIG5vZGUgaW5mb3JtYXRpb24gZm9yIG5vdCB5ZXQgcG9wdWxhdGVk
IG1lbW9yeQ0KDQpBZGp1c3QgYSBmZXcgcGxhY2VzIGluIG51bWFfbWVtYmxrcyB0byBjb21waWxl
IHdpdGggMzItYml0IHBoeXNfYWRkcl90DQphbmQgcmVwbGFjZSBjdXJyZW50IGZ1bmN0aW9uYWxp
dHkgcmVsYXRlZCB0byBudW1hX2FkZF9tZW1ibGsoKSBhbmQNCl9fbm9kZV9kaXN0YW5jZSgpIGlu
IGFyY2hfbnVtYSB3aXRoIHRoZSBpbXBsZW1lbnRhdGlvbiBiYXNlZCBvbg0KbnVtYV9tZW1ibGtz
IGFuZCBhZGQgZnVuY3Rpb25zIHJlcXVpcmVkIGJ5IG51bWFfZW11bGF0aW9uLg0KDQpTaWduZWQt
b2ZmLWJ5OiBNaWtlIFJhcG9wb3J0IChNaWNyb3NvZnQpIDxycHB0QGtlcm5lbC5vcmc+DQpUZXN0
ZWQtYnk6IFppIFlhbiA8eml5QG52aWRpYS5jb20+ICMgZm9yIHg4Nl82NCBhbmQgYXJtNjQNClJl
dmlld2VkLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQpUZXN0ZWQtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNv
bT4gW2FybTY0ICsgQ1hMIHZpYSBRRU1VXQ0KQWNrZWQtYnk6IERhbiBXaWxsaWFtcyA8ZGFuLmou
d2lsbGlhbXNAaW50ZWwuY29tPg0KQWNrZWQtYnk6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEBy
ZWRoYXQuY29tPg0KLS0tDQogIGRyaXZlcnMvYmFzZS9LY29uZmlnICAgICAgIHwgICAxICsNCiAg
ZHJpdmVycy9iYXNlL2FyY2hfbnVtYS5jICAgfCAyMDEgKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KICBpbmNsdWRlL2FzbS1nZW5lcmljL251bWEuaCB8ICAgNiArLQ0KICBt
bS9udW1hX21lbWJsa3MuYyAgICAgICAgICB8ICAxNyArKy0tDQogIDQgZmlsZXMgY2hhbmdlZCwg
NzUgaW5zZXJ0aW9ucygrKSwgMTUwIGRlbGV0aW9ucygtKQ0KDQoNCjxzbmlwPg0KDQorDQordTY0
IF9faW5pdCBudW1hX2VtdV9kbWFfZW5kKHZvaWQpDQorew0KKyAgICAgICAgICAgICByZXR1cm4g
UEZOX1BIWVMobWVtYmxvY2tfc3RhcnRfb2ZfRFJBTSgpICsgU1pfNEcpOw0KK30NCisNCg0KUEZO
X1BIWVMoKSB0cmFuc2xhdGlvbiBpcyB1bm5lY2Vzc2FyeSBoZXJlLCBhcw0KbWVtYmxvY2tfc3Rh
cnRfb2ZfRFJBTSgpICsgU1pfNEcgaXMgYWxyZWFkeSBhDQptZW1vcnkgc2l6ZS4NCg0KVGhpcyBz
aG91bGQgZml4IGl0Og0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9hcmNoX251bWEuYyBiL2RyaXZl
cnMvYmFzZS9hcmNoX251bWEuYw0KaW5kZXggOGQ0OTg5M2MwZTk0Li5lMTg3MDE2NzY0MjYgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL2Jhc2UvYXJjaF9udW1hLmMNCisrKyBiL2RyaXZlcnMvYmFzZS9h
cmNoX251bWEuYw0KQEAgLTM0Niw3ICszNDYsNyBAQCB2b2lkIF9faW5pdCBudW1hX2VtdV91cGRh
dGVfY3B1X3RvX25vZGUoaW50ICplbXVfbmlkX3RvX3BoeXMsDQoNCnU2NCBfX2luaXQgbnVtYV9l
bXVfZG1hX2VuZCh2b2lkKQ0Kew0KLSAgICAgICAgICAgICAgcmV0dXJuIFBGTl9QSFlTKG1lbWJs
b2NrX3N0YXJ0X29mX0RSQU0oKSArIFNaXzRHKTsNCisgICAgICAgICAgICAgcmV0dXJuIG1lbWJs
b2NrX3N0YXJ0X29mX0RSQU0oKSArIFNaXzRHOw0KfQ0KDQp2b2lkIGRlYnVnX2NwdW1hc2tfc2V0
X2NwdSh1bnNpZ25lZCBpbnQgY3B1LCBpbnQgbm9kZSwgYm9vbCBlbmFibGUpDQo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQoNCg0KDQohISEgSSBo
YWQgYSBsb3Qgb2YgdHJvdWJsZSB0byBzZW5kIGluIHBsYWluIHRleHQgZnJvbSBPdXRsb29rIG9u
IG15IE1hYywgc29ycnkgZm9yIHRoZSBub2lzZSBhbmQgdGhlIGR1cGxpY2F0ZSBjb3BpZXMgISEh
DQoNCg0KDQo=

