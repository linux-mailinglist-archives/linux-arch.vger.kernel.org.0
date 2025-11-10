Return-Path: <linux-arch+bounces-14609-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B284FC483D7
	for <lists+linux-arch@lfdr.de>; Mon, 10 Nov 2025 18:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149AB3A99C1
	for <lists+linux-arch@lfdr.de>; Mon, 10 Nov 2025 17:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966722882B4;
	Mon, 10 Nov 2025 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mUzbrF+g"
X-Original-To: linux-arch@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020119.outbound.protection.outlook.com [52.101.191.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E932720ADF8;
	Mon, 10 Nov 2025 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762794356; cv=fail; b=ZmO0ZjeSgWIiobhF439fCtEGB4JllRquVV/r3W1kJ4dwLfWnR4dKJWUMDJxdwLPYHFw7lB3uInw9RiRrc8kgZA5VCpWQeXZxXxLL9KlYPhsZDiOFlejA2ISwkIk9bn12teaQiKowv+e5KdS6VqWVYl4bFgLn7dz4rLodhV/neWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762794356; c=relaxed/simple;
	bh=dgAV+f/CfVj5xLmAIdbdHOKTPTQe5umnPD18H+lviLo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RnUWGtQXin/YhiKWKxsQ28uQ2QRWluFf2+DIoicjzgAF+eLVvREuURcE63JHiJCuu/0+JjhoDs9G0r5/PW9rEa4oHN2OCoOYBg4y2/3m2mmGb9j4Ve0OJpHvV4frmcR75hBsbyIKE0b+zOFN3XugqDWYbXTlEtMTjG31iW1nJEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=mUzbrF+g; arc=fail smtp.client-ip=52.101.191.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1MyV8FwmCPlntKp2x9hiUSi0BmbXfUtZkkymYEH36R8238/k1ygQ4n9s0ABNJIqIeR4/rVqjBOKVn1zSxtZOz5L5pNTWUwKWwDDis8EoXJfUAe6rBJa391INC7Pl63Z6NnC1jHVjN6ciczSq092vi+KUUOx2IjAhbWLJuU1QBrQKlX/mxBgrXx+R7VMcBBuLoaNZ/xIV0b3FKFsvxyHNm7dCSbWwWv8B/hm/eB0vVEK+0UNW8n+cSz5bNxHvi3LrnPkmPqMVVWJ2jGLQkg2UlxqzESaD1qjJFqoHv4YhoC6dUXYt0bg2fn0zAmThYbgajBNCOIbSosXlHk0npJ+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jO4onzoHHCv+L1A2qRrQs9PMr8jbwdZgb76blRp7YIc=;
 b=YMQGmrzhMP9qlw6buwuEJ59kCYbPcACCz9Uv8v4/iDg4LTahQZwGuWUE6Es3wbuqSC0GCiteNoPXMUVt0DL+A2i7o9ElFfeLidC5LpYS2sMc+D6Lk4wijxzcU3Kg+SkSs7BiXHAGGgUrE2UW2uR4AK/bDccLITfR/d6eQNQd+hPIPdBl94IdT3FpDZmdWbdlvvn5J0IyLbhvAKxdwWcrHB09ZTK+sryYgF1fUp9x31EcjAq0PGqGQ2c9R7cr+w6gGw+t5lEHN22CDPa7md6oQtUvQ5mHotFXwG+aKcWrQkO2cgtIf7di7M5W50ulBSlAltvAS4nCZzWaFrXdLfIkdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jO4onzoHHCv+L1A2qRrQs9PMr8jbwdZgb76blRp7YIc=;
 b=mUzbrF+gGZDgYq3uCrgTu43QuXae8754hBJrsg3sJchCvinGv9k45lQnU9oRcrMPCSfEt4B7EEDmxXc5FplVHjtvPgOKQqOP/3k/OLglzAmTi55AsNC5X2o14emfYzEmX1ktoa4a1KEReZ1uhZ2BYZ99lL9mIP6QGHwoLzQQJX4mfoPcmbarUYRfFj7Fv2xZhqQxwBBdTA9KV0BZI3/Q4ijRtreXNALPhBkzfMoa4osqv9uOMezbDTRuE/xmJvs+hPEymOwtNWlqjTVeFg/PXAGFuCOU48z4F9N3aq5LKWBzOjZSoyXOHyqgmzqgxVqeNQK9/vq2RPTUOovgc4kgUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB6310.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 17:05:51 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 17:05:51 +0000
Message-ID: <24cde7b7-a03e-4ea0-a75a-e3717e316413@efficios.com>
Date: Mon, 10 Nov 2025 12:05:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 00/12] rseq: Implement time slice extension mechanism
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Prakash Sangappa <prakash.sangappa@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20251029125514.496134233@linutronix.de>
 <03687B00-0194-4707-ABCB-FB3CD5340F11@oracle.com>
 <2eee5e37-e541-4ac7-9479-cef3e62f234d@efficios.com>
Content-Language: en-US
In-Reply-To: <2eee5e37-e541-4ac7-9479-cef3e62f234d@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0180.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: 798efb2e-ee57-4a98-e2d2-08de207b66e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDRHRWJ4UzVBUHBPVnJVK2pyb29xclNWRDZKNGhKd0Z0QlV3cEc3bzBNaytX?=
 =?utf-8?B?L2c2dThIUHIzS0c2c3lPTThTSDl4Q0VJVVlPQXBaWmkyREVSNEF3WEJqSmVK?=
 =?utf-8?B?STNESGNmL0tvWTcwK25ZamtBVzlma3FpbTZ6MW9LcUlvNndzcVdCVnZjam5V?=
 =?utf-8?B?OXh6MVp0K1gwanF1cXNYbnpIOWwyTExLUU83T3RuQ2QwaSt4RnZrOEg0OEZW?=
 =?utf-8?B?U0plK0lvOEtIRW9yRTRGa2ozd3ZTWnB6R0pCL3ZpN1dJSzNUNEl1dzMxUUV1?=
 =?utf-8?B?ZFhNS0pPQXM3RmZ0NXBpamZ2T3BmYTFKM0pNRmRUeW92c05GYnZSWGpVMzh3?=
 =?utf-8?B?dTJsR3h4TGdlUTNLUVU4dzZQcFI3bGFUc0JHaFJLTHNFZzJ3S3lvZ1V1dCtG?=
 =?utf-8?B?TzdQcGlUTjVCbFFDM3p4amtLQWhIRk1pVUFWMDVkc2dyMG1ZKzVTczFMM1lH?=
 =?utf-8?B?bk04MjVQcjlwKy9jU2hURFQxSWV2ZmlwSS9wcjRVN0NSMlBoY2VBQWtpcGdL?=
 =?utf-8?B?WkxoaHUyL1FuUDBaZkwrM29pVWZ5WXBCNFAyQ0tDaGZ4OXhYSVEzbk1oRGJw?=
 =?utf-8?B?bVM1MndvTzJ1T1hMNlpONzlIZXdPQ3BGSlFadTJjMnhiWFNmaXpRMnFoNlNp?=
 =?utf-8?B?OXFQM05mT2VKbUVSd1I0b3BPZ3hzWUtKVXVRNGk0cEtUMUV0c1grWnpkdHpk?=
 =?utf-8?B?dVFtKzVRcXdRbHNCVmtlZzZ6akFYT3VqbFM1bWhPZStZMlBFeEJsS1VKOTEx?=
 =?utf-8?B?azFYTHNLWWJJWkdHNnF4RGhSQm9NVnY3RHNlVVBIbkliZUNIZjFJYkU5dVZ4?=
 =?utf-8?B?WUQ3d2pmNXNyTGxoODJjdUxSTlE5SVZqWE1uSUxpNTBxd2VGNWVJaEQ3YzRI?=
 =?utf-8?B?cFRiS1hvbWk2RTV4UERMTFRaMGNQRHc5SDYvN1V3Y2RDMnRmQjVhdnk3blMz?=
 =?utf-8?B?cE5yQVhaVFZDczg0aEU1b3U1cHdBMGxBYjZSVUpIamRQNVBBSUd2a0ZKbkF2?=
 =?utf-8?B?L3hSZEZVc1g1ZFozdXlhRFdRZGswNE5WanJqOGhOMXd4MjFnWk9jZ0tFWVBt?=
 =?utf-8?B?K0trcjgzUm54NWRmQUxmWUhqL2ZRUDdpUGJYWHRpWnN4SkNZaFFhSm5oYjZl?=
 =?utf-8?B?dHFzTUs4Rkp2Uk1DV0xWbmlSYnhuTDV4VFRYeERDQWZ6SkMzTW4yRUZ4ZEE4?=
 =?utf-8?B?Y3piMHdTa2dQSnpwWGJJWGxOUTNKa1hLUnRtUHlZNGcwaERDSFdGaTBSb0ht?=
 =?utf-8?B?U1VwUklEbVYvMS9kYzV5MXBtdXZWRUpLbDFMcGJzWjUzNXZBSkhTYkd2d2JP?=
 =?utf-8?B?YnltSmREVDdwald4aEMwZUhzMGRzOWlTdWR2eEdCL1huZDNjTXpOK2RaZGlM?=
 =?utf-8?B?YVF0MjU3M0d5ZkVEQ3oycXJpQUpFeWlXM1drYmpuYU9ZekJCWlM2b0s5YUN4?=
 =?utf-8?B?WlFvTkNMMGRQUFRiaVJRTVpsNksvODlhNW5CcEs5WmlkRjFXWDlnUkl1TVZJ?=
 =?utf-8?B?VmhRSXVONnZvSkJRbXNTM2dEUW43RVpPVHJwc0VQSVppZGZyTDVkQ1lFUnNr?=
 =?utf-8?B?emhIQ0FuSHZuOGVuVVBBWFc1Si90Z0pQY3h3aUdFQ01jM2dFYkNJMk5nWFVj?=
 =?utf-8?B?OSttSExkSXdPS3JlN2JIVzFJMWtrejFZNmtpOW4xTkdkUnhUMFRMbzIzZTMr?=
 =?utf-8?B?cW8ySUcxMTNUNCtjdjE0MGJEeU1EVjR6Vi90ay9RaDdISjZsVFFla3hqTTBT?=
 =?utf-8?B?Q1NRL0dYbVRqTlJWaklWa3VEN0tzMlNpR2xFcm1aNXQ2R1RUNzlEbFh0ZGZK?=
 =?utf-8?B?dDNQVUxCeTJYZTlKTzRDQW9ZNGZtZ25tWWU2dmdCNC9wbzdSRWcxU0hpTHFH?=
 =?utf-8?B?ZE0xdFFha1BzSitObDJxeGRzaEszcWZ1dHc5aDF4UFRrOWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkgyS0pkc3I3K0FQRnEvRmVmR2F1dXBjQi9kYzE3QTBLNUxuRGtXYnJsZlNU?=
 =?utf-8?B?ZGd5MDl0TUZhaFBvTGRGcHpsVCtNZHJUanFsZmptZDBIQi9FVjBHWDN0aVFz?=
 =?utf-8?B?eG1tVkZtSnFveDZaTjZZVzRKVUtyT3FQa2tQeW5IbitVVDVrWHYvRGhGdU1I?=
 =?utf-8?B?VVpTTHBsdjBIZWk3OW44ZkJmQUlrK2tqRU8wK3R4QWtMaXIwdjZSajRPVi9M?=
 =?utf-8?B?TmxYZVREVERHYlQrYkRVZ2JTWkh6QXk3VERVYVpDV1RFT0VoV0FQdFVOTmRx?=
 =?utf-8?B?Y2tmSE8zUG9yS3ZaSXI5dWROK3hOV1MrTXRUdW12WUVRZVNaNFZ1aGxzbVlz?=
 =?utf-8?B?UE1PcXdYc0tycmo1L0EvQTJjVU44eCtheWx3WXZ5Slg5THhlTFlPZm9uUncz?=
 =?utf-8?B?aENyQWFETTNVWDhKelhlVGZ1MVJobmdyUHdudUVlaEE0cHZyT0hncXZIRzk3?=
 =?utf-8?B?UHJrbSt5clU3QXpzNE5BK2xiU2xZVzdXVWtPVW9pU1NoaG8xaHI0UGpsZ3FY?=
 =?utf-8?B?NnE2NHZiWW03RGsyRzNGUGJ4cThZclZkRUhLTVE3ZmdqakFRTEI0d3RTaXJR?=
 =?utf-8?B?SFp1REdKV1h3T0RVN0t0NmQraXR2TzhOOUg5UVBYdzZHN2d4R1ZvdFg2aUVV?=
 =?utf-8?B?blJ4bUh4bEhXQ2hhZ25ublJNL0p2Tk9aUWdlTmxEbU5HbVNUdXhWUDV3RWt2?=
 =?utf-8?B?RlJJM0dZSlNKaExJYStjeUh4b3V3b29iVHNrVTF3QjJrRzRuZDdzcjhPSlNP?=
 =?utf-8?B?S2RQWkVLRmprU0ZzMXdLc09nVktCbys4MndjL2E3QjRrUUZidTNWOGxwNmlx?=
 =?utf-8?B?WlIzTEtYNG1YUHVJTWQ0Y2UrcU5kUU91cjhHRWV4OGJqYmRPRzA3NDFyejJa?=
 =?utf-8?B?akQzVVNGNzBkcVBtdWh2K3JDejJpU21JMVkvaWtJOHJFWWdyU1l1Z04wNmRw?=
 =?utf-8?B?YTAxeXg0VllnN2NpTUsxZDdQMzlWQThtRnQ0dnRWUE9hSkVmQlhyNUpJK0Jy?=
 =?utf-8?B?WnBkb0ZPUitLYjFyS09oNDZQTFJFZUhXWENFZC9JcFU1alFRS0FtdThiYlow?=
 =?utf-8?B?aU9wOUdERlFYeDRwV3lsaWE1UkJDTzlyUjVCZlJDWHlsR0RJZnFyN0tHcXdw?=
 =?utf-8?B?N2NReDdZM0FiemFGcENXQUozMy9ZSm00ei9OM1RPR2V4eVZoT1JHYXQvK2w4?=
 =?utf-8?B?YnJhRDUvd09jdVE3a3pQYzJHUmh2NUVKNitvYWVNbWZ3cFVtbG9pN2RKZ0Fs?=
 =?utf-8?B?L0RSVmRQSVRqemtkYndIUEcyKzZUcHUvUHZPY2RZbUFQdXRBVzRnVWJaVllv?=
 =?utf-8?B?N2xCY0x6WmhmL003R0hDWlVEcndYcGFYQkFsNVRzTDE1SFFPSitNQW9COE03?=
 =?utf-8?B?bTBOaWRIdGl0OVZCdFo1VTUvV2J2UStoRTNVTmxUYlBFb3BBWWxDcUFPeVJK?=
 =?utf-8?B?QmlVYVRzb2Z2a3JqajhxNDYyYlpVWWpWcTcxa3FPM0FKTDFQNk16ZXdJbFQv?=
 =?utf-8?B?Z2toS1ZObUI1NjNOQXNJZ0hpSytFU251NzdNYndvZWRqaER3SVRwVUxaTTlz?=
 =?utf-8?B?aUFJbUFkczB2Mkd6c3ppdS93N1MwVzNURGIyTU43dUJpUEF2YlJIZGthZ0RE?=
 =?utf-8?B?YzcrR0VmM0x6VjZqNWlNOG9rMkRKUDdkczhiUmNXWHpJNjhEbEZrQzNSdUt6?=
 =?utf-8?B?S2R4ZDZBOExOUUZFcTc5ZzNxekFDaUFoR1RjQk1CSTVSK2YyTTBtbzlRRC9E?=
 =?utf-8?B?SElqN2FOcElRT1FQd0x5S1Nwa0l3enl1R0NDUGNLN0VQSWhuZWk4RW1BRytW?=
 =?utf-8?B?OHJHU0ZLOHZ4U3lmbVVDN1R6cFc4WVB6NVZtZnlDbzE3UVh0c3JScnZMNENz?=
 =?utf-8?B?Z21HNVR0OHJFbFVpVFpVRHVSbC9uVXN1WEVhbmRoL05TQnRhdkQreFpVVmpx?=
 =?utf-8?B?RzNpaXZhNWtxcDg0WjJhSHl0OFA3MHJUZzFSdTRzR0dlZi9JRUVHTUhSWEZV?=
 =?utf-8?B?clZQbzNqVlJaM21aUCtXTGp1YnZYbC9sbTR1M3RxTEUxelByeWtUSno1c3o5?=
 =?utf-8?B?ZVovZXJDQXg0d0tWaWRLTTF3eDZNMnA1cXE3NG80VXZhL2trMHV2V1pwZ1Rv?=
 =?utf-8?B?K1BOM2FlelFLNG1zZjRCRzZmUzZuTy93QTVzZTl1aEdnZFIrQlBQbHh6NlUy?=
 =?utf-8?Q?W7ctPaO05xVZoo4pX/yXDM0=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 798efb2e-ee57-4a98-e2d2-08de207b66e5
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 17:05:51.4041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlmA+O2SH6ijpYXEH8ZCm7JZCOAd/TGKr3Rx5uSNBsUmRiRme936H/Sr2zxiihbGJcsm2DE+R/dNX3u5WmEyFiGh5Q/+2aXgtqhWaEgeh9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6310

On 2025-11-10 09:23, Mathieu Desnoyers wrote:
> On 2025-11-06 12:28, Prakash Sangappa wrote:
> [...]
>> Hit this watchdog panic.
>>
>> Using following tree. Assume this Is the latest.
>> https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/ rseq/ 
>> slice
>>
>> Appears to be spinning in mm_get_cid(). Must be the mm cid changes.
>> https://lore.kernel.org/all/20251029123717.886619142@linutronix.de/
> 
> When this happened during the development of the "complex" mm_cid
> scheme, this was typically caused by a stale "mm_cid" being kept around
> by a task even though it was not actually scheduled, thus causing
> over-reservation of concurrency IDs beyond the max_cids threshold. This
> ends up looping in:
> 
> static inline unsigned int mm_get_cid(struct mm_struct *mm)
> {
>          unsigned int cid = __mm_get_cid(mm, READ_ONCE(mm- 
>  >mm_cid.max_cids));
> 
>          while (cid == MM_CID_UNSET) {
>                  cpu_relax();
>                  cid = __mm_get_cid(mm, num_possible_cpus());
>          }
>          return cid;
> }
> 
> Based on the stacktrace you provided, it seems to happen within
> sched_mm_cid_fork() within copy_process, so perhaps it's simply an
> initialization issue in fork, or an issue when cloning a new thread ?

One possible issue here: I note that kernel/sched/core.c:mm_init_cid()
misses the following initialization:

   mm->mm_cid.transit = 0;

Thanks,

Mathieu


> 
> Thanks,
> 
> Mathieu
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

