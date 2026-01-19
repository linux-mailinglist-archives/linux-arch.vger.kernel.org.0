Return-Path: <linux-arch+bounces-15859-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40312D3A51F
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 11:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FA813019BDC
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 10:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC9E2D9EFB;
	Mon, 19 Jan 2026 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="c+y+lw0i"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021124.outbound.protection.outlook.com [40.107.192.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73582D8DDB;
	Mon, 19 Jan 2026 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768818663; cv=fail; b=bEp6D37wXmbSjmEKFxID2DRfNMw4tpABwVwaO8z/rA/kBUMtXTTNnGMRTIhvlEUfoware7ItAZAPDndZmZ82CH0Fp+QsDjbT1TVfQF9UMhWY1UiQ9e9W2r56Ux6ceMO8zmGPeR+RtkFc7ydIUVR2zb3r1PXJYnKc43MTfDmfiSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768818663; c=relaxed/simple;
	bh=yx6Yk6jw738JgwgKjinofQgx/Zx/MNbgHBrgDHVHYxQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M8akWdVs517rnn8dIOS7M4Aznj0Kn5DPVIPjx7n8yY7mxHIwja9PAUq/ksX6/K9tZwlwrOdDlGaPa1yVXsAwTVSK/2uonhCW2qnjhgvVENVo3pkArfFvrNwbfD/rOI+01iIE/A+4RFFtZqLXSmobNcW5c3pm+Pr9ZsEvP960Cj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=c+y+lw0i; arc=fail smtp.client-ip=40.107.192.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOLrCEZP8f+P7CyaQuafyQJXOIaHzEtnv9S5VbmOQ321165lgqEdjhuEoNEfHh2KzgGBHnIw6Yf1tsvafNVrKeE+TWHRpDzGJuhIOhpW8MURVpVwCXdrblx0njTX2duleYQ1AlcjkhkZTsmIr14lhfk6GQaSoanBatobGk0AoOGAYBhkXA21oF5Fhxax2p6+wZzfHFKZcSi38YHjlXUQk3hORADTRj9L+w/4hn3f5X7Z2+EZW0S6Q2ORO36usNZxyg7LlU7l0HCVQWn1cWUGtTsuY2Ya36eePDTDQgUXeIKIlCBrXfHt3Lk0vvzyFtl8g6t7J1Jip3U2GLyuC5QdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63aN0W+VGwmsW9SCsQFcx9gpkW/TfYiMi6+gSJpV7+M=;
 b=voRbE16fLVI6L1ryG2LAQpCWAwYjmVbPr6lZgSVavzHX52W/uUCd2GETCsMOJXOi51bOgIL1ieLLg1sI2NbuG6ctiPYh4pU1fOP0gg3fvBv+u3KkKH2Io01tbZGJqPBC6D0AqHqii87Ql9zVoMGBfZsU4txHqzPWuQxlhJlAozNhXwnDOL8TUVCdA4dYY+wWxJ9PoLFX/GrN1LLfCPe4/+fjMPg2Aki6edmILAxeXR02rd9ZAPaKo8QVCqap8EpHp1USD5WpR2J3Pe6r/lhpQvH4ndrkmAJvnu9QyUDJDFMFG8cC4R4f8ElnHin5jZ+rvd57+pLg2XVOMIfDvKQcgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63aN0W+VGwmsW9SCsQFcx9gpkW/TfYiMi6+gSJpV7+M=;
 b=c+y+lw0iSc7Wu9wzM41upDC65hXpz7BM29/YPaQQ5a/tO4y269jDchPSdla4XKyjO6IepB3PYK0jlQ/Fn+mfek/4MijThAWJ3/kIvSJKKObNM2V0hmhEvHleMHolt3FE8C4IR48NKyDOx/j1Rct5rQmrROCUldLuYC4PsFDkK+4pqH2LWWO1B9AjmKhtHdOhdIHL4JvqFlFWKsu68SU8VWSk+Xn/C1jlRFa0XO6HYJPBIbIcuYuOTFB5rxvaUrpiJ85JoRD0e3BeOmsegi5m3+dihAN3JkNlT6hihGHpX/37mqus3zXFzYJsWK9c3jjd3PFxURT7wKm43ZjVH6OCAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB10954.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:12e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 10:30:59 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 10:30:59 +0000
Message-ID: <5d2f428d-4fdc-486d-90e1-474f3ee9f54f@efficios.com>
Date: Mon, 19 Jan 2026 11:30:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V6 01/11] rseq: Add fields and constants for time slice
 extension
To: Peter Zijlstra <peterz@infradead.org>
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Ron Geva <rongevarg@gmail.com>,
 Waiman Long <longman@redhat.com>, "carlos@redhat.com" <carlos@redhat.com>,
 Michael Jeanson <mjeanson@efficios.com>
References: <20251215155615.870031952@linutronix.de>
 <20251215155708.669472597@linutronix.de>
 <d97944e3-e5f3-4d7e-83ac-89ddd6a4cb64@efficios.com> <87jyyjbclh.ffs@tglx>
 <225b9868-4ab7-4a90-8acb-8d965626f6a7@efficios.com> <87ldi4gjm3.ffs@tglx>
 <lhua4yhcc0d.fsf@oldenburg.str.redhat.com>
 <45fd706a-86be-42b8-879e-11bbe262e159@efficios.com>
 <20260119102138.GQ830755@noisy.programming.kicks-ass.net>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260119102138.GQ830755@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF0001DBED.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::307) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB10954:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b6c5a00-ae49-40a3-6248-08de5745d66f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlFxVXhqTWRzSFduMUxaSHlMVFhBQ1IxM1lWSDlrZXNNY1grNmRBR3BodHcz?=
 =?utf-8?B?aFZDSlFiR3FvTjk0TlU1MUVCUFJOSTVXN2xnNU42M3BYUkhwNmNYaGJWYTdG?=
 =?utf-8?B?RCtXWU1zNFlzRThvUFQ3Nkd5Y2JrcFdva1dCbFh3Mk9JajBzWmVhNzdiNkht?=
 =?utf-8?B?S0EvTTdMTnVoRitEemttMUlRNTIvQThpWFBYdFRWbXAvb2xyeDRsYWVudmI1?=
 =?utf-8?B?MVZtTHZxZWd0ZDRvTHNjN25NeHBnNXltZXBkWTJFejZvOENMSWY5SUhRZWFm?=
 =?utf-8?B?MU1nQlZYZXA4UXdidFk3U1dYeWRFVEsrTnp6NndNYktLMG9yV0Q1cFpmd1lT?=
 =?utf-8?B?NjhwemtZblRIWCt5NDJqcVlRRXVjMkZ3OFNmRnBjUU1WSEpVTmpuT08rK3ZH?=
 =?utf-8?B?KzhYSEFtejVVZ3JNd3NGNm9vMXRVRlBLZ1JKb3A0YTZ6aTZGN2R3M3hncElJ?=
 =?utf-8?B?WVFWMzNZUld4T0tBR3hzTXhleUZTQWZHZG9IMWdVOFFjSFRucGFOYjdYaFow?=
 =?utf-8?B?VDRJYVREckxXWkcvMEJsQWxJQ2wrRVJReURGU3pxR05RLytVaEFPYUVhQkNv?=
 =?utf-8?B?bkhFRkN1YnpkWXY1czRMYzZKK1B5YVF6TEJpR0QyV1ZuZVA2NHdFMXJPa25V?=
 =?utf-8?B?d0NEeWJINEtlTkZDUmhaWllDejdpbkNJM0hFUU9IRHNlblE3YTJWdkNsdzFw?=
 =?utf-8?B?ZElCc1BEMHBUeFNDcjE0ZHJoZlN2dWlEYlV5Q1E0alQxZ0Q1MHlibnp6OUo0?=
 =?utf-8?B?OWdYTTkwZE9EdHlKY0hLYVZuOGxvVGNMNmNhSTVJUHRkM1Z6WlZ3TmlZKzBh?=
 =?utf-8?B?eUlBQUk3MTRMcUJoTmZFRGorWkE5YjVKc0xYWlBOZUEwS0xtOHJ2ZE16VTha?=
 =?utf-8?B?WU04elBDMFRWRllLaVpYT2FlQjFhemFrRjlpYUlqUG5lMDlCUmY3YWQ1OHdV?=
 =?utf-8?B?SXZ1QW5wZHFRQlpyVWxGTlV5VlROVkdXNU1RSUs4SjVWaUhUaUowSmVFekRv?=
 =?utf-8?B?bHprUE1McEpUWkxhMzIvWlNMYUVsNW9EZWJZM3RHYU43aFZ5NSsySng3N0U0?=
 =?utf-8?B?OS9HRDdxRWUzRitVK250RmJsakFGWGNjYWpKM1Bzejc4TXdzN25WOHMxMVMy?=
 =?utf-8?B?ZGVBaVpHaGtMUmU5OXByb2pKbk5wanFlRnFrbkg5cS9mUWcyTnVWa0dRdXVi?=
 =?utf-8?B?aDl2RDlEKzdoZFpMVmtRVmJpdWdqdGQ2dTU3aTByY3RtUGZyVWZublVWQ1hj?=
 =?utf-8?B?M2dIL01ockc1WHZic04vQ0duNFY2c01oVVZja3krN091SnR0d3pZYVIvYXp1?=
 =?utf-8?B?ZHNPck8wL1R3cnZkb2g2ZWRXWlVBYmJNbmRQWnVRUDNGK3lQWWZTbS9McEdO?=
 =?utf-8?B?OHNYWFd5ZmprQVBiTmd6ZmpzVUc3VTZ3V1pBWHNiTC9UN2c1cTlSL0t0M2JR?=
 =?utf-8?B?Q0djSWJNUGtNOTZ5a0Fhd3FkTGE5cERxZkEreHVISE5KLytJcTRraTg4OUxI?=
 =?utf-8?B?a0ZvbzZhL1JqbWYyVUZ1Ti9WQUh2aDlyaW5ZZ1Y2RCtrWUc4ZkhlUDhGWk5R?=
 =?utf-8?B?K285QWhZZ2psc1p3dEI0QitlTE5XUWl1NjUycjJkcFdGYmRXSStYQnF3Y1k2?=
 =?utf-8?B?Rlp5UDEzdnV5MDJyZk0weGdzL0lHTE9aZkdBeUdtWXl4b3hWZHdvMWpFU3F0?=
 =?utf-8?B?T3RxSlZQRlJ0TTNSSytBUzJzTDZhbGZOczA1U2xEcS9EZitRMlpYSFNPeEdM?=
 =?utf-8?B?T1lLb3RaUExuSEZUUzBjQjZraFgwUytlN1hLVkJGRXpuN2pOeWYrVSttbk1S?=
 =?utf-8?B?OFM3WERBZmVIaW5pZnBRZG52ZmFUaEVzMjB3QmdTMFduMVBOMlZuTFI5SkV0?=
 =?utf-8?B?aG5BOTFpdXdaZlQvU3dwaXN3RVB3YThKU0FWeE9oY1pvQnJ2akMyeE5HZUtH?=
 =?utf-8?B?RTZkeSt3a0Z6R21mSHNnUDd1eXpISkRsUFJGcHhXNFdQMnQwR2JLQk15MWFa?=
 =?utf-8?Q?BNLHm8HFZCCRV+bTpSUOvrwwJSZ0CY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djhYS1UwV1B4dWNFYTh1OGp2ZmlyMCtVYU1BTnRCbFJHV295QjRibzkxVW1l?=
 =?utf-8?B?VCtjaE9STGhFSEZ5b21kNUtCZi9td01JQVN5K21XQlBMdnI2ck15eFpSdWtF?=
 =?utf-8?B?TGFJTkNUa0o2QkJoV1d4eFpIWTZoZmNaR2VVSmFQL2grUUVZVmVZVXlycjhU?=
 =?utf-8?B?MzlHU2VSSFpMK2Q0dTNaRnlVWHpXeEpFN2VwUjd4NFlJUlRiZkpnbmZ4WDZD?=
 =?utf-8?B?K3NwQ0pUZFVYT2o5cmc1cm5PUllZNWZSOGtXMVVZcnVpSlgxM2t0dVRyMTRH?=
 =?utf-8?B?UWFuUHpoMVFOR0xTQzhsTklCWERwRXdsYy9ya0h4cVp0Tk1vS0c0a0pMYVpi?=
 =?utf-8?B?V0dURVJSVEluZkRPdzVJWUNqSzF6V0lOL29QL2VTMFFXMmN5U0h5dU4rUEpU?=
 =?utf-8?B?eWVmblVPS3RnUUUvN2VxSGxjQUU5L1dUeDNJandZU1htRXpRN1JoTmM0NzRG?=
 =?utf-8?B?dnBBSlNoc3l3bzdieU5kM1Ftb05sbUFvWWlXa2VGcDBpOXQrQTdXR1gwL2dN?=
 =?utf-8?B?ZmR4N2t0L1pDcVdwL1Yyakg0OUNwSWFOUHBrWFRSeXE1b04wY3pMWTJxZnZZ?=
 =?utf-8?B?RDhiNnRtVlo0a3g0VVc4SGxwMFN3L3BpM2FEaHpYNnNhZ3JVV0NRbG9QaEpR?=
 =?utf-8?B?Y1JVOVltTFJFaEhua1ZXRWE2Ly82SEUwRjJ0eXIwb3FvNkNlR0w4LzFKZndq?=
 =?utf-8?B?ZkcvM1B1VjJRQWdwajZLODJGMnpnaTBEMm8xMGR4QWpidTdTbEpuR1pSTG41?=
 =?utf-8?B?MFZvZGpqd1ZRblkvamgxTkwwV0hTbDgzTUFTMk9jR0N4SzBiSmx0UGUrUG1G?=
 =?utf-8?B?aXBqNVU5TTQzQlo0QUJSbmhPZW9pblpHTE9FM3dhbGozTzdBdHlMRzE0RDND?=
 =?utf-8?B?WHpES2svUFAwMEpmeWVqZ1J6R0VjSnNoSE42SkVNMlZxU0JiaHYvTVVOTkFy?=
 =?utf-8?B?aDhUdlcxQVcvL25aWGEwMDhyZFdHWDk5UERzMS9XYmIvQ1lXdzRSOFRYTU1Z?=
 =?utf-8?B?NU9aQWJHRWovYVRXbEpZeERIU080YmpDRTBJeC84bm9udlJoQis1NXNpK01L?=
 =?utf-8?B?QTNJSHBURVNXcVFyRTFZSzlrUHNJcWRHVUVyOFFYdTlJemZGVDhGeXNSRW5s?=
 =?utf-8?B?a2pZVTVuSnQzd21GZlNkc3o2c0xiK1dCSGk2eS9BQzkySkg5TmM2NGtLdktJ?=
 =?utf-8?B?NUl5d1dWeTdQaytubDQ1N2pIVkpnRi9RZVhnM0NhaEE2YmZuRU9KS3k0SmxZ?=
 =?utf-8?B?TEJmbXFXMnBNRDF0bHpxVERMOUIrZjRPYXhKOExqalhlNkppU2U5RTdIT3Ux?=
 =?utf-8?B?M1czcmZJYWRsTlZZWHE5eWFQZTZ2UEExKzBZMjJlWWJVRUFkQnNDWk5QNk1v?=
 =?utf-8?B?QUZzSno1WCtxS2RQcHRNQWF3UTIydUVnZ1RQL0c5SXJ6RjZ1WWF0elhFNGgr?=
 =?utf-8?B?clBHUFd3UzAvTHFJTUhab2F6YjlNeHNQeWVpS0lFRE9iUjNiL3B6TXJiZDNN?=
 =?utf-8?B?YnRlTVVZZGI3aWdGNGxDT3JFN2U0VXZDOHBCNEhqcGp3bDNPSkFHN0xwOFZR?=
 =?utf-8?B?c1VjWkpBYmNxQkwwUWw0WlFXK0d1WHNIeW94MHdyeEp4YXU5RXlPWVRSSzB2?=
 =?utf-8?B?b0FFY2N6SGIvbzlSWWRxc2hmbW9HdFAxbFUySFpwRjFyNTF5cjFXOEVCQ3Nw?=
 =?utf-8?B?NVpBWnU5SXFha3F6QnVmOVc3blBQOHZpbk14YmtScTh6MDhHeEhRMlRIUzZr?=
 =?utf-8?B?em8xbGo4WlVHdnRkZzFxYTNyUk9HQ0ptcWk3dFM2Yi9TWUFOYXpGM2N4Q1Rs?=
 =?utf-8?B?YVprQnlVVGpTWll4U0Fxd2J1cTJrRW5mcVdkRjI3eHNnNG9iN3FYVEEwTkNX?=
 =?utf-8?B?VVc3TlJpaWpYcVgyRUF0dlNUdmdsTytmdUtzOXRBR0hoUTM2NHFhejNkRXRT?=
 =?utf-8?B?NVpwTkxTd0RCK285c3BJQ1dkMDE2MGlLR2c0emM5K2xjeUh2aWluWkRUMG1h?=
 =?utf-8?B?QjZDNzJ2N0UySlpQNCtkTEV6eDZwWmJVQTZmU2o1Z2NiQWRNMktMaVlMV05r?=
 =?utf-8?B?cHltZHM3QlVNUnhKOEtUcENTcXpvSWNjZ2huYURxRFVTaGtsc1ZIMnVzd0Ni?=
 =?utf-8?B?VmFnSFY0NzI3ZWNxMlhzanZEdGJ4M2tKU0dURkh2OS9RVHdDQWlmM0drNUJJ?=
 =?utf-8?B?RkJyeWRwb3hKLzlqQ0F1UFpxWndJUnZ3aTBWRXVBTGthNDFQZWpWT3BOZjFv?=
 =?utf-8?B?Rk9ha3N1Z29FZW01bFM1ZnpPNi96L0NhMXVSa0VwOU5BcUgzT2dZWWVmY3hM?=
 =?utf-8?B?eFppb2FCdGdGN2l6VWxRQS9pUDZMUS9BSjJpT0N6LzJNaUdQbXBSYkRDQ0tX?=
 =?utf-8?Q?HkMPG1IKXhtoeJx0=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6c5a00-ae49-40a3-6248-08de5745d66f
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 10:30:59.7192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYWfAdofwYwL9ghqe767ck+YCnQj0VCwEDI1OtOTsMk3/v1yhqw5JkLmlJaBS7btK3bjjS4qNDiJVx27JviXeEU0HwqdyYBecbU7Bsu6nzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10954

On 2026-01-19 05:21, Peter Zijlstra wrote:
> On Sat, Jan 17, 2026 at 05:16:16PM +0100, Mathieu Desnoyers wrote:
> 
>> My main concern is about the overhead of added system calls at thread
>> creation. I recall that doing an additional rseq system call at thread
>> creation was analyzed thoroughly for performance regressions at the
>> libc level. I would not want to start requiring libc to issue a
>> handful of additional prctl system calls per thread creation for no good
>> reason.
> 
> A wee something like so?
> 
> That would allow registering rseq with RSEQ_FLAG_SLICE_EXT_DEFAULT_ON
> set and if all the stars align, it will then have it on at the end.

That's a very good step in the right direction. I just wonder how
userspace is expected to learn that it runs on a kernel which
accepts the RSEQ_FLAG_SLICE_EXT_DEFAULT_ON flag ?

I think it could expect it when getauxval for AT_RSEQ_FEATURE_SIZE
includes the slice ext field. This gives us a cheap way to know
from userspace whether this new flag is supported or not.

One nit below:

[...]
> -	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION))
> +	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION)) {
>   		rseqfl |= RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
> +		if (rseq_slice_extension_enabled() &&
> +		    flags & RSEQ_FLAG_SLICE_EXT_DEFAULT_ON)

I think you want to surround flags & RSEQ_FLAG_SLICE_EXT_DEFAULT_ON with
parentheses () to have the expected operator priority.

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

