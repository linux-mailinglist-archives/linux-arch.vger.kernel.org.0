Return-Path: <linux-arch+bounces-14443-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37176C26C92
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 20:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FEE4401A6A
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 19:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6008630E0EB;
	Fri, 31 Oct 2025 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="m9IfdX35"
X-Original-To: linux-arch@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020127.outbound.protection.outlook.com [52.101.191.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD28F3081AB;
	Fri, 31 Oct 2025 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939376; cv=fail; b=m24X/9r/hTT6xQaqlEaAhrx7PWAWQn083eRgJPZvLeyvC+ABchaIWYGhvfClzYEb15zVkZlRKejaf32+ufVyuHi9VYVSV+oGLTFo8LYuqGuXJ5lVeW6Nfh3d2sNrxs4d4lBKbT1VKGnQNnPX/85MFbH6UDte58hsyKuQPH6Tq30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939376; c=relaxed/simple;
	bh=okuYRPbdf73l1ab3hLs3VVm1+ixlKogNq6sWRpOHBno=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZBEOs750i2vcsiyvOxpvJfWbBGzxZHhTdM8t9gdFFgsmkX8Xi4wRBA9jeASDXEyuBTEJvDW1VxWTYVCLIkgCdh0l79WwVqsDnq4W9WxMWW9V9nqsze3kUKEVYDKQWn/2Ze0eOoIwqPRD93/akaJST08CuImrrs0TMHh6AM/sdro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=m9IfdX35; arc=fail smtp.client-ip=52.101.191.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvLhsNlA8vMdU5de7ydZcQ+/t+wb49AMmfJMjujBr1KLtWdtonDtmYod1HN7QqcJwFJMLTtW2wSKDnzHO6geoayjHuTHODoWBmo3BaaeRCQsxVsGtNsIGeIywW0FrwCWcrJR0cjahBfHb1+za8JnPCm6eIPRYiXVSaX1zGzfZW/GPcWpfp6McChHfg+QbIBomBvZY6QDPAwSNXT5f8KbaLaXFrpNflxnl+z6SzGM6YG7C94q9d22CYkkDkZIbl9aTO9v7lYUpJlthlZl4VDsZ5936xfF39PbNySAJexyat0D26cKFtAvwjcLsC2JXc16VbJ167Kcl7Khu+/Ccico2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7J+MNiVKNSuUMqrNI7lJipGgMO2Lz1613QjskwNQaY=;
 b=IRK8QRoCmYQqKdyozUprMQUmYctRKnjSshii4V8lOBCS2iFSXh13505Ux1Urh5uH4OJ7FScaw56E4gh7sjqNQdkv64PIgz4sTCLY5caS1pVhC5kicjt3CO88fMgiYeAnpNYHi625wWvQg1doX9f7oRWlbzRA4/Uv9AqteticJlzUDS9+zv/RoWmZyiqV2Z1cZsoMn9/e/CvBYprifCI0UGRn3Tb/ftoAWINGQmsFG1zAeDZrid0meVYaUO6hMy0uUWsueIM8P5AlLJq7pEHCbrTFdojwXuWd7XkhGMQ3ROKntA6ALW91EYXs61aVELiLR6QeRmbgtPkwEO7LwgXI4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7J+MNiVKNSuUMqrNI7lJipGgMO2Lz1613QjskwNQaY=;
 b=m9IfdX35Kpdszp+b4dJ9sbvxdvRLwF+DfR+gQoNI+EFDKsmS7+ADOZT4gMD4r6/cIxfOWEmBEOMGQWngJz4X7XklBqAWaF9+srLkfPxrzI9f1TEpfSiLLRnqo4CVbXBHlmF09gkMSu4dNNwttyIvxhiAXW/lBF1diXPdkqmFz8s43RNSJz7hrShaYkHsH/YvzahuS3XJ6Yi9HofAGiDt49JWEIWX2lhsnjB3AYx9LPIyLPXZkDwHOwWf3jtqvcvduZJYyYHnZLQ+VRmHgPfot5uOO27b0rK36PJ+5Pb0L/buonpl2pAAu1z5IvX7TQyi2kZPPOKamSOB/viNsTUnAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR01MB10799.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 19:36:11 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:36:11 +0000
Message-ID: <38c04848-7a99-41d4-9068-e4471da16718@efficios.com>
Date: Fri, 31 Oct 2025 15:36:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 04/12] rseq: Add statistics for time slice extensions
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
 <20251029130403.670613644@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029130403.670613644@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0273.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::21) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR01MB10799:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c16e77-3ff9-4d2e-c1b1-08de18b4bf0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWRQMFIwMTR3RmZtVm5oakJUV3lnTEFVQTZLRmtObXBKLzhnTGZlRTdrNnhi?=
 =?utf-8?B?d0NoNWJiUFVzMzdiWDlFeG50cXROUGt4SnltMWIwK0U2NGNudEpTcmx3by93?=
 =?utf-8?B?VVBxYTNpYkl0WTBBZnE2VlFucFRjbkc5REZlOWdHbXRjQjZBQWUxOUVyQVJR?=
 =?utf-8?B?L2czV2szRnF1dFdrcjVyeWpzYUovOEtUWGJxdXd3a2t5SDhEVVVScnBCZUpj?=
 =?utf-8?B?TjBRRThaK0l0YVM4N292SEo4cXZQeXF5bzVPQW1VWXc4cDVJV3VUNkRxdG1r?=
 =?utf-8?B?QzVTN0dBYmJ2STMxbFhaZzNsS2Mxb2hUTXBTNUxadzFhWGJLYXlWVDlLMWVN?=
 =?utf-8?B?MDE0cHZudk5NRlFxWjVQSW14VVdhQzBwVVB3NlF6UU1pSFdvbVl0a1hycm5k?=
 =?utf-8?B?Vkt4QUV5MG8vSDlDTVdidEdsQnkxVWREclVXK1BieE1tU3dLTVZ2VGNqcDVo?=
 =?utf-8?B?cHRLd0NhR3JrNG9NSTh4Z3hYVTV0ZnNQUUtHdURSSzNpSDhTQWJxcnpLZWJw?=
 =?utf-8?B?UFRRNXBCaHpNSmtucTFvZTdiRUZ6UElSVHFjWUFNR3IveUM3b2Q1VEJ3WTBX?=
 =?utf-8?B?RGpoTFdGc0FHWCtHYlcwZEdBT0pQSWR0OUVzMENzcFNCNnRxR25kMzlkTjFa?=
 =?utf-8?B?WGttNnhsZUl3Mml3R21ONWl6M2pvUEtyRmkxZTZocmpYZnd6blJxV1hHV3lB?=
 =?utf-8?B?UjFUVkFaeWh0OHhtcVhKTDZsMTk3cDZ1RGM0TkR5ejJwVjllTlNBWExOUXF6?=
 =?utf-8?B?d0dBWjBjT1A4eHF5QWo4NjM3aG9jRDBkdzVJbHhPYmQvMkg0RmFpbFdUZ1Ex?=
 =?utf-8?B?S2RhL3Y0dk94TldHbW9HUGNzZW55ME9RLy9IMDkvRzQrcU15NndTUnhOVklF?=
 =?utf-8?B?N2xIdENGVkQxN3Fvb1RNNElRUGZPbUhRc3RqTkFMcXVtRURjSStxdncwSzhH?=
 =?utf-8?B?Z21uNEVydW9IbVp4a1NWRUljRFM4V1p3dTg1Nm5ycEQ3OVFZaGJnbmh6aEtv?=
 =?utf-8?B?WVNGT2tUdVVXOWFzNi9rUW9rbzdndys4dVBzMUJuTDg4TFVCdklWV2IrK1V6?=
 =?utf-8?B?UnBTNmRHalliVmVUZkVhVFZFMDlKNWJBNVpreTJ1b3NIcTRveFFXbnVncE1J?=
 =?utf-8?B?b0NNUlNjdFQwV2NsYWFBN0dRM0hhRko4MnlvNzBZSlhWeThPTHdkV1BOVnNF?=
 =?utf-8?B?VW9OOHNZMzZtWWF1SXh2U0w1NzdRSEVVeU9SYUhzQk9CZ2x5THdEdjd1dWQ5?=
 =?utf-8?B?WmFLdDN1NGZXeWJpWTlqckd1WUc2aUtYakhxQjFxcDIwcHdoaUZyZEg1SmZ2?=
 =?utf-8?B?cEh2L0RaazZoMkdoWm1EbDB2OWVmeHQ4Z29PeE4xTktESFlDRVdkMHlJSWxG?=
 =?utf-8?B?RGVQdmwrenl1a3NGNmVyVXE0endTYkFCcVpWdTU4R1ZNK2dxM3JoUU9jMXYy?=
 =?utf-8?B?NGxQUW81d3MyRDJhR3NwNlVTVEtYZkpmOVVDZkRKOStUUDFhU1Q1aHJsbFd1?=
 =?utf-8?B?bzFFNG42Z3R2SmpzZklHeHA0U1VVaVlkRUE1MUo0L2d3cHAxQ2hXQlJUTlZI?=
 =?utf-8?B?S0dZQXlLeUg2RFd6RklLbTZZTUE4ampJbU1seThFNjFrUUNMQndvS1dnU2ZW?=
 =?utf-8?B?aGdZTXVTM2g1SEx4RDVPcENvVlpHQkhSb0ZoR2VKd0JIdGY1dmQ1aFBMNEp4?=
 =?utf-8?B?NDF1dUlIbndZcWZ0U2U0MUFxcWVpT3BGblhBWG5GdzJSRHdpQkx4K2V4ajIv?=
 =?utf-8?B?dXNMY0U3b1liMk9lWjhZWkJCeHBEUUpzKzg4S2J4STg3VGlZNmV6RjZMV0Rz?=
 =?utf-8?B?ZkhmV2cwcE9ZMi9QRG9RS3l1cEpYcDR1NTI0QjFuSEpUVlk2WXVOdW94UUhs?=
 =?utf-8?B?LzlscWtIVzc1VnFBUExKNWY4a1ROL3djL2QwaitNY1VaOGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXQwYkF4N2NwSXFUcE92alFqYnE4R1J5d1hvVVEwa3E0MjZmSmdhSFFwdWQ3?=
 =?utf-8?B?YVZubUkvUXFUVlFuVXZDSy92WFIxbXFud3F1MVh3aXgwaDJMUDlVbzExUncw?=
 =?utf-8?B?Q2o2Z1pWRUFLeVp4Z2IzZXVSb3E2YVM0cGNKMUE1V0J2Y1FEWnZVd3RzQnc1?=
 =?utf-8?B?Rk40UGxtVDY3c1ZENXNISE0zeWRnc05pT1B2Z1IzZWpuSU8rcU00L203M09O?=
 =?utf-8?B?dDlnWTNublFxTUMydkdPaVo1Nkh0TmlPTW8xYllCL0lPbWxEUFdpUWd1NUF2?=
 =?utf-8?B?anJlUmxOT3hScjY1bkQ5NVc5YWVvdGgrN2xSZU0ybWlyeHZndlo3a1NocFFB?=
 =?utf-8?B?TWpncE50SjBzd3BWQTVKcllmbFhONzI3YW5qcXUyZDFjR2tLMVM5ZTZHcCtD?=
 =?utf-8?B?cjNWU0UxSlVjcXNBbll6WHh6c0tBTVd3MjFmZlVVcmIrSmpQVVdHYTAxWTMz?=
 =?utf-8?B?NDBqdFBuVFNLNm84WmU0ZDBldDZaYk5KTVl2TFdsSnJVdW83RitSTFBrM1JN?=
 =?utf-8?B?UUVwdVQ0c3RvRVpKZGpySTBLeEptRHZ2RUFpRDJ5N3NqMEtIU0Q4dnoxeW9G?=
 =?utf-8?B?UitGZWMvNFBLMFlyUURqL3Z1ZjUydmZoVXdZOE10cnppZ3N6WEhMSkdEWHFn?=
 =?utf-8?B?L1gzMzYremM5RFl6ZG9GTGZDRXZTK1cwK013N25Pd1Q2RXp4OGdXNUM5Ymsz?=
 =?utf-8?B?UHdhd1BUa085dUJYSDF2dFZ5OHRNVGh2UldUMlFIblQ1MlkraHBGOCtmZXg3?=
 =?utf-8?B?NkVZQndZWTdxenF1aUVCMFVBalZBcW9tQjlwWTVObDVFeHhSeGRqcTd5YVhL?=
 =?utf-8?B?eHhHYzV4eVlFVlJVcmFJRHBLVGx4WVVUUXNJSDc2dm5kMFo2TTQzVmNQUEpM?=
 =?utf-8?B?cTJ2OG4wcTFHcWxzbDlzNWQrWWhYZkZpZEszZHZxbHVWMFFpSUtPSDFUWUhN?=
 =?utf-8?B?Y1I5RmU0L1pRVUVyUzBDMUdFZzZyejJ3MEM3TEtTMGNuY2pJMWI1c1R6L1Fv?=
 =?utf-8?B?SmVWNFRQTkNwWkZGVGdlRW5sT2Z0WEVIMU5TSjAzbkRYYWN1TitwRDhvZlJE?=
 =?utf-8?B?TlZZZkxKZjk5RkdFZVB3eDJuVTRyd2FwRVg1NEVFSE9YZnRQK1NyRTVDcHdF?=
 =?utf-8?B?OSt1dExDR2s0Q3NvYVFvbWVSbE1tbm9nYmU5UndhR3NKMTJUUzJZTU5ZT3R0?=
 =?utf-8?B?T042OVhTTWtXdGNBUnorbHc3N1pUSFBRb2dYU2xyZEo2Mm8yY2lvK0YxcXps?=
 =?utf-8?B?elJvUk0yK3FKVkJZZk1qV2FsTW1mbDU3TEZ2SmIvWlBXYlVRa1RsYmh4c0NW?=
 =?utf-8?B?amFkcjZiWGRJL2pRQis0V2hZVmlNQm1ieGpnZ2dTSFR6T0NZOWl3c2NGTnlB?=
 =?utf-8?B?aW1sZlR2NERoMGZudHhUNnEwQ0tnZU1VUWtxZld4aGY0VmFmVDJ3eitXcTBw?=
 =?utf-8?B?bGlnV1hzSk5CVUlsb0U4cEswUEZ4enZ4V0M4VEpkOGFhbkNEaG43MzEyN2ZU?=
 =?utf-8?B?R3VHbUpYYmxhTW9uWUtKOFFXWFhqQzRpYmJ2eUU3L0ZxRi9ONDBHeVRtckJu?=
 =?utf-8?B?aWdlVXN4RlUybHZPSU93MHhLVjY4M0xDcEpOc2xIRjBHUVluc2U4aGg5N2Na?=
 =?utf-8?B?N25WbE9yS2NKL0prbUNJYnpIUm9YOUIxN0lKRkp2S1BVcWcrVTJrN2lUMVFM?=
 =?utf-8?B?bW9Yc0k1RG1IRzUwU1J6aG8zTmRUZy9lcyt6bUR0V0kybHl3REJLVHpubHRP?=
 =?utf-8?B?TE55enU4ZlY0RUdCOHdoMW5mbnU1WDJTUUhWYW9sdSs4dWwydTV4WVNQYzIr?=
 =?utf-8?B?MXhURVVneCs3c1BDVERzdlhRZDBNS3RpUzV1VVVSWkNjYTVBVTUvU2dwSDhm?=
 =?utf-8?B?Ni9WL05tMEtTMkJRWjhlTTNSbVZwYjNwTHVvaGsrUGMwa1RPOEJYdnFBanRB?=
 =?utf-8?B?bTBpVFhpeVh4ZDFlblMzbkV6OWhVVmZhZ0V3N1RTdmhPenJuQi83akJPKzY1?=
 =?utf-8?B?dzRxWnNiVnBuR1ZEUFhja1dVNnVkQktzL1FvdlAvVE9oNWRGT2t4MHRCZXBi?=
 =?utf-8?B?MjlyOEgvdzgvQnh3d3BxU3pCSXEvaHRzTXlzcG9SWVNVZmVnQm9pZHJvT2l3?=
 =?utf-8?B?cGZpLzNYbHJxVE5WaTcxdDJjUkFmNzJiYTBJZTdTNTljOFpnaXZocEljbGpQ?=
 =?utf-8?Q?TcjE7vlcfdvBhdrJbEhAm7o=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c16e77-3ff9-4d2e-c1b1-08de18b4bf0d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:36:11.3128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nz8Kds+PRmDYgSLxk7AJwhWtuQE88qZPklZYwYv59Jwp3dmBJ6x3AeOrbrKGBH0uQfhFAMSi8dEMkIaI+jXAj1SiO66R0VSy6vd8UoWouXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB10799

On 2025-10-29 09:22, Thomas Gleixner wrote:
> Extend the quick statistics with time slice specific fields.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

