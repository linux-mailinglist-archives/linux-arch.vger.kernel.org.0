Return-Path: <linux-arch+bounces-14442-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EC1C26C6E
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 20:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1CE1A61B2F
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 19:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9002FA0C7;
	Fri, 31 Oct 2025 19:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="kljkZzqL"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021101.outbound.protection.outlook.com [40.107.192.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3E72D876A;
	Fri, 31 Oct 2025 19:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939287; cv=fail; b=alGK3XIho16y6xo1jkhCz6/8Nw6dhTeyZ7abnyAKvEmkgHZW4HJe3Ellpms2Hry1L7qNetMmppyb2YH9MGDHGZMrO8y7KlBgCAwyS62dIXeb87Imy15VhPvqC4j+tQDkkW6WJltv10fMnvaVcSWL/ypjSyeIOxZC69gBcOM/lVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939287; c=relaxed/simple;
	bh=RKs2sCcu/INAHiZdG5uTe5cwI/QGT7jbxH0oX7TD/MY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RxEARlDGMGss+15BARuqUvJbCXswZBKGnLA3GKA5UT9/53ACgPM14aH5UJf2N3RQIRYKwBeNODmoUC3zLh5jNeytWpz2qcAzC1jIjcf4ZN1DMQ9GJIVR4wrgtPoNBmp4OmnzOQSWgrwonMaiiGkxc/Lz98KiNqn3ct2wtVxeMTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=kljkZzqL; arc=fail smtp.client-ip=40.107.192.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OoroiAwccBx/XmpIAJiTZpt9ZHR+lmhv/LFf9r78DxdWdiO3EAvMQc0BERQ0vKDltdjjogzEFgi5Mbu/oNwh8POt6NzF5VEV+94O1bWh0OsTOijRl9NEJ2+YxzxGTMwLasRF0/QNo4yLkA0M67H+ITTjlG+AroyOH0UAvLigGUPZe4X8oLfo0E02gQgkhbYSiSk3p5F/imc0DC4LMwna3YUS0rSoJ1QJ1LjUxNJoNKswq2yYxln2K3fPfoZj/edILSnsu6j+iLJ1tHeHpban7hBJn5pHvyDBuRjgDzNhD1KuVaxF5k4YiL1W9pQL2kcCjEdOQkfRa0c5pXUK9ybRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxLrPElSO2C2bDzaOTioMidb8uBDBHeq3K4A68HXXQA=;
 b=Tj6B9opyo/QdCy5oJSm3NqTUFfKnHEbaQnXyP6T6YbjzBNHyOBeMVWB6KIDm7XMHi+WSGcBEP9YeYYfJeVecOuWQZV/NAwDaPQIa0VEdlUaJCdeS+SMsTWNV7r/5UwML/MlzVqQyba4r7GKbe8HEcUe4SDmEi+ZMGUsbTZ7CaRMjqAJdMM+YmCxxGkWSMcQ5Qx7f6g8LZH0Rqs6Q16bm025BxgLmGEkgGc6atcnU+8tiBAKQPhJ1bCVnqkqIy/IFgjfyhs1KOWx8R/xGfD0QTWPojoA3CHfXPLiUtbHnoAVmJ59gIWL+JC+iQYHUuObXqnSvCCQYyAkoYmmoehwr4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxLrPElSO2C2bDzaOTioMidb8uBDBHeq3K4A68HXXQA=;
 b=kljkZzqL2HqGfs7i2jI/9GrRjY16vW7Gpm0E3LhZ4l9afR5XNG1SeZxCxakZJqV91zM5dU5sOLfMRxKr52VQ5T21sd2qA6ZNYyk21/9vqYzhBx5Osgv5+7itRX/CXDBHsTNYKa5BeGxBnw52R478dQveZG1Wv5wAOd5+Daute8yG++OosgvXKULMP6WzlAgJTfnUk6kjZCifuZtNVGYKaGQF9X4dxbpDXvYpDVqBfh8yP9G1Y6t1d6Gs2Q/iQUwLiiW/CwfVy7wsHp9HTf38/IBOqOfXfq0iGhuyVv7crAxM1fplnTSXlYZsoT4HdQddqxbEBEvttbbPmbHsBrmZvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR01MB10799.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 19:34:41 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:34:41 +0000
Message-ID: <e6bd7a59-a96e-4db2-9b19-68e0d4e34824@efficios.com>
Date: Fri, 31 Oct 2025 15:34:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 03/12] rseq: Provide static branch for time slice
 extensions
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
References: <20251029125514.496134233@linutronix.de>
 <20251029130403.606732100@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029130403.606732100@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0265.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::29) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR01MB10799:EE_
X-MS-Office365-Filtering-Correlation-Id: 37eb1171-b011-4ac8-48b8-08de18b4899c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHRQa3pjbFkvMy9LZkljb1pEMXVoTkZzUEVNZEVKV3RLcVY4SUhHVHNKYkkr?=
 =?utf-8?B?NkIvZUsyTHMrU2RRck9RK3NPN0JxQ1lNZzRSZ3F2UXBjUUZLandTTXBVNVIx?=
 =?utf-8?B?Y1Z5d2FraW95MVYvNUFtY1lTVlpXOUpTY2piMXdTSVowUS9XUWorZnh3YzEr?=
 =?utf-8?B?WnF3WTFKcnVpcmJpWUdGSjhZZHkrQVBvU29UcjRvZHpCQUVHM1NOUmlPY3FE?=
 =?utf-8?B?MmlBZmVMNzRaUzRpNjJFTitjRGY5SzB3aW5CdXdRS0x4M1V2ajBWaUt3ek9N?=
 =?utf-8?B?UlYvT0RqNEN2YTloS1AzY1ZZOWYxWGFYeGRkaTZFYmd1L01BMTBJaXFZV0g3?=
 =?utf-8?B?dDhkTVBZU2RENXZiRE1aMHN0bXRyYS9NR2tENFZjZFNDZ0ZyeC9yWHpTSURl?=
 =?utf-8?B?OWFsMzE3VlNWV2h6WHkvaEtaeXdvcGtyYnhEdjBibjZBcC96bDFuc3hVUTBr?=
 =?utf-8?B?UjFVNjBBdGIyVmRRWExjNW91ZmZSN2tON1NXMEVjR1R2bHVlMThwR25Tbk01?=
 =?utf-8?B?QkJpNzJaaVRGK2c2Z3h3ZlJyL09DSHljODRnN2l6b3d5bFZveVFVWHAyNUFO?=
 =?utf-8?B?dU5Jbk0zcWM2UWlMbEVESEVYRnlPTDc1TWxwUUt4d05MODhLR0NvWUxyNXlt?=
 =?utf-8?B?R1lWNGRMRS9oUWFGNFpETkJHcEMwS2lvQ3V1c0Q1TWtQRHNvTGNic28xeWZu?=
 =?utf-8?B?enVrS2JSZ09zRUpZZTYxc05QVGZBdlhyRHdEWGdqc3BTcmNvY1lUUTdzb1cy?=
 =?utf-8?B?WHdPbk01cTZQRHlZZWFLcENYTnhJZllyVXVkYWwwamxTdGFKclFNa0t2Zyta?=
 =?utf-8?B?REpZTnY0TGFscW5IcCt3Y2p0d3N5emJsSGZmcURGVDEzUEFvT2d6ODRCOVov?=
 =?utf-8?B?YTY5ak5FSHp6N0tjZjgzUWpHWi9uOGlSWU5INS9vNDlZT3BKZHMvbjZUWk8r?=
 =?utf-8?B?Y3FLMnJEUHVESXEvWHdtbXV6bldLak83Kzc3MC94Ry8xLzZqejJZd2tyR3lR?=
 =?utf-8?B?SzZUUXF4eitHMFFyR0Vqd0ZjbnBoSHNERTRQNFQ0T2VSMXpnZyt0K1BTMVhT?=
 =?utf-8?B?cFdRY00vZW90UXdqekw1TkM0UU9sZXFkN1JLQzdhTGhVWVpwYlQyWHVoVjJI?=
 =?utf-8?B?NUVGaFYrYUEyMksyQ3p0UXF2TGNZeUp4U05yMU56YXNZaE4wSmpvdE9SZFll?=
 =?utf-8?B?S3lHTjlES0JVdmI3Uis4ZXlsdjRBZGkxTm45MzdTbUVHN1dtVHBrYzJLWWt2?=
 =?utf-8?B?VFF5MElZdVZ1aDRqL1N3ZUtPU3dqWjFudUhmeDh6Q05lL1R5V045emMvbUt2?=
 =?utf-8?B?Wkh6cCt0QU9oTVF1UUQ1amhLUkROWk0rYTY5c2R5OUtoMjNQQmhXYm5Lc1VW?=
 =?utf-8?B?d0JDZ1lYZEJNVVhFb3dyK2NtY3BWSkFlR3JHS3I1MlVpWmVycGRrektTem5P?=
 =?utf-8?B?cC9MejlSZEM1K2dpV0FzWkI0SUNrekorOWdLQ1UvYU40WWR2TUYrTy9MSVQr?=
 =?utf-8?B?bTJyWGY2aHNFT0NQZGdJMjZUb0V0b1V1M2ZTK3hPQUxXZlFRZklXaU9KcnUr?=
 =?utf-8?B?SEhBSkthbzhpenNtbDVpTXFzN1hHcnpqaHNVWVMvaStFYmRnZjJ1d2ZZelBh?=
 =?utf-8?B?NGNsczl5VTB2dElkWW5YWmFUeUU4S2VCRnlRRnE4WENtL3hHbUlVNVc1c2U2?=
 =?utf-8?B?SEVFM2hBYjVtRW5mczE0K3Exa1VVY0tuT1Ivb2JWSFZmWGdEZEJNY3hDYUZm?=
 =?utf-8?B?SlBCNTh6MDVBT0xQQnlOcjQ0cVFhUmZIK25uV0hKTnh3SWRyNWprYjlZbUZp?=
 =?utf-8?B?Ry8yZmdiQ2czbzY0bmVlRklSRU5uZ1R6SzJ5VnRRWEVlWVdyZlZFTHlvWHov?=
 =?utf-8?B?cE0zTHFGTUFya3dFWExOZlR4RzZRL1lCRHBuTEhlYUNaV0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3U4RWRBa1N4TnhZMVV6UGppeElHMklMMEM0ZVpENHlrMVBlZU55dytoZXFp?=
 =?utf-8?B?ZEFOUkF4TkpGYWlDWDdkK1JOT3RGN2hET0hmQm42SmZDbXhDRDc2Y3N1VjlP?=
 =?utf-8?B?ckRjQTJHY0RtWXprdWRFMTlMdkh5bDA0ZEs1cnFIaHpHUXRxS3dVZGxOVlJK?=
 =?utf-8?B?WGkwbjNNdTlIQjAxQmdZUHNpOVl4akNCTEZ0Q3NBdGNNNng3LzJLR29UUGgy?=
 =?utf-8?B?Y3d4M2dCZnVmbFkrY1VXeWg5RytNWExiMlFjYWxFWDhBemtnUS9kaG14OStO?=
 =?utf-8?B?UzBnQWpLc0xSMjhlMGNQeGRNeHVMMkUvRmh3WWFsTjhoeVhub0JUbHRta3dl?=
 =?utf-8?B?QUdVNHZHbnQyUW9tM1NSSzJ0V0ZRV0Q2RE5UaDdweHRPMlUrUEZQR1RvTVhn?=
 =?utf-8?B?NlhKVFV3SW9rT2ZLRFkrSEo2YzE2aHBGa3E4QmVYUm5TOHdJeldNNW9NUk9V?=
 =?utf-8?B?dXpNVTN3RmF0Wkd2MisvNDR0VnQxUG9tdWJ0QTVSdnZ4WnlyL0tFWXVNRm5a?=
 =?utf-8?B?bGI1aWZYVGt5VU9zSlgyeDdJTUFIb0pEZ1hneE9TRE5rM1kxVDVnSkQyTEtw?=
 =?utf-8?B?UXJVeEpvQ2hmdEVGeDhuckhIazFQRHpWYU5TY0c2ZEt5dThPeFIreWg2Tllq?=
 =?utf-8?B?TXdpTWVaQWc5eHdVSUZjOGE1V0ZkZHFXZEpNQzE4NFlBY204Z0tRL0VjV0dX?=
 =?utf-8?B?RmFOSE5Md1VTSDBsR1ZxbDZoWE9BY0JONWJTY1BWRGdDbTI5bHpERDlBTEdk?=
 =?utf-8?B?dUtDcjFxdlVBWDEvaTRHUnIzWmxGeDhGUXNNLy9WYjNMaUJhdGRsN1dHbEkz?=
 =?utf-8?B?ZUFZRWRPWUIxMW94SmVGV3R6ZjdrdlIzSHRETURoRlcwRERxMTVYcmo2WUxE?=
 =?utf-8?B?VE1sQ1M4NUduL01vQXhoM2hEVUdKelNyeXBXMWREbEpUam1ab2ZRT2hWUjIv?=
 =?utf-8?B?V29zaGV6NFMvejVtNGxCL2c3VUgwU2ttUG5yc0lZVE9OcmZTNU9WaWhkM1VD?=
 =?utf-8?B?Z3ZYVUlSbzBldjJJRjQ1OTVJbStQMzd6YWw3cFFESlZtWkFPS0hjMG1Gekdl?=
 =?utf-8?B?VHdGc0tTRjd5d0wvUzN6QlQ1VTRUdzNST2xzSjk3VFRYZUx6aTRJeURYeXVk?=
 =?utf-8?B?QnZ3MWJVc2JWQXhWa24weU5mTlJhNitteXgvS1owNEY1c0dVL01NVGJOZGxN?=
 =?utf-8?B?YmJzK3pMQTB3UDhpalU4MC9TMVJCVVlSdnBVQTVpbTZoM2pkVGxGVWdqbUR4?=
 =?utf-8?B?VjJhWDZTa0lOMUxIc29qc25IaVE4N1ZGeHQ2c3ZNcTNPVi9xVkpFSGxWYXFK?=
 =?utf-8?B?NkNPNlFxTHpPUzRMY0RtS1FBYXdQMzBFV1NVcndzVUh3Q21JTGd1aDRmNGVm?=
 =?utf-8?B?UHVoZytjSGlod095cUdJaC9xU3FRMUxBd1pORGlTc0wzVDNjQks1blZJUE5x?=
 =?utf-8?B?K2cwM0xYTTJTSzlOVWdPUFBLZkJGQVc0ejkwQW52WVhVRUozM1pvSEo3Vldy?=
 =?utf-8?B?OXg1WEs2MHNYOEJGZFp0Q1hUcTVVWHMxQkxQUjAwL000QXMwNkE0ZjZDaS91?=
 =?utf-8?B?RVpDdW5uaU4zZTNZMzJKamJ5VlNKN29NTFdwZWhqRERBS2oxamg2N3RaN2Y0?=
 =?utf-8?B?UE9RUVFrV2NXd1JXTklQRndUdis5SUptdTQ2WE1HNmNSS21YTE90ejh5Q1d4?=
 =?utf-8?B?ZG80amxkSk9FVmFpbHlZdmowYXVHcEpzR2llNE5PQWVzSHdKT2JQU2luQWpo?=
 =?utf-8?B?RHpJckQzSXU0dXNzb0JUUEZ3QWlXS2FKdEhqZnVMQXVubjhGSUIxQkpNbXBn?=
 =?utf-8?B?Nk85b1QzUXRmYnpKdmF5RWI2bUVXanFFOHVSdjZHZEkyQ3hQWFFvUjlhYlZN?=
 =?utf-8?B?ZTcxZW5pZDZhM2VBOXJlYkR4ekQ2MHFVQjZmNUxuNWpPMFZuSkEzKzlQVmhZ?=
 =?utf-8?B?OXc2QURBOGJiRkNqSWVFWGUrTlB6OW1MeFlIWEx5eFR6dkE1cDYvU09WU2ho?=
 =?utf-8?B?Q0t2aG1nVDZkZHJrTHY3TWNTU0l2ZDJ1OC9VZExsMGZWUjhNUS9TQWhzbEhY?=
 =?utf-8?B?U3hsNFFicWZVRHhLL2ZaYmt1U3NvSG95Q29Ia1NjaHkvUnlQcWE2Sm1BczR5?=
 =?utf-8?B?Q0FacC9mSUl6dURyN3hVVVhRRTI4YWxTN3R6a081VU5uQVQvR0lpS3RTc1Ju?=
 =?utf-8?Q?G52ELNeH7PXoYAWS3xMQbqc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37eb1171-b011-4ac8-48b8-08de18b4899c
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:34:41.6570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3avU4U/4r4E5ghFmQbhdWpFpGFuolCLL16C4kY1XmNn+ZMzigYuB0kanh6jVRDuWaUjp462JGwoe+o3zhAf4OkpaSNHUS1ui2Tm2xkjIC4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB10799

On 2025-10-29 09:22, Thomas Gleixner wrote:
> Guard the time slice extension functionality with a static key, which can
> be disabled on the kernel command line.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

