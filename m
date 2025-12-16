Return-Path: <linux-arch+bounces-15469-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 571D6CC3DDF
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 16:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C68CD3031E64
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 15:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BC53559F5;
	Tue, 16 Dec 2025 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="LvbbGV4+"
X-Original-To: linux-arch@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020105.outbound.protection.outlook.com [52.101.191.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087493559F3;
	Tue, 16 Dec 2025 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897995; cv=fail; b=rmmNe14G2gOX73mDcVxJkdgyrTOhZ5uHowhrvzt13TEDgx8CfiSO+k8eyGOsl++xBoSJrUkdIy6VB20T+/yon69w+6YxyXoRl+MBgI6gde6A1RG2MBtASaBGyqZT6kKS0EBSkFpdnlWPHTEWboUYSQJZlxouVPxxeRXTE4LihBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897995; c=relaxed/simple;
	bh=q4YM/LgXoNB2Uu3wmzdNvSfa0976RgI/xiwurydaokA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pbRIFUKdZcr8OpSTdJx+6LT7x1MUdW/lbfcFNZwrXLKXQiT1M10bc4rSNV71pBHzR6loUaetG8FujSZJ5yQ2jwgzKfo6yHBiHAVaHi68ejr6f8dOHZRn9MltMiKo84vSpftXmS9CGCJ3FsyIU3XzmW+ZtgXsAEu/fOygszVLTXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=LvbbGV4+; arc=fail smtp.client-ip=52.101.191.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdioFrFOkXiT2ifR2jStdK9t1F/U1UPb357Uoqu3ZSrtjjayf27sk/5Q6OtpwKQUrQpL8t88qGFlw8k7o0v3branOFSZFHwatS9ZGVDQDBFXdFgTqxtfJ8Fq+0fvOk883fu7Y1s18TfJLxQ7kMaH63aOZ35GacqfsJGDJLdmvoiMWhLK0bUO8iIGLLmQvMG/Qc+r3k5fcObl9iVL4AccyssNQG71niz68EYHDlKa5kGnJfOyXO5eNk4xI9U6GZifIccgPYWchHmbQywUmphIYm3lHwjoUV8uewRJoL3wYOKyiEu2O8aHWYgaTa9cYxdWgkdvM5mInjAVtEFGZdON4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DzyLg23i5xqOkC+BnS1ugv3ZM1462ETWewrrFM1tYU=;
 b=v99xj179B7jrfXVDH/Iy6OvOcRZo15cOyQkU8JyK2T5oMJo4FPuKm839ssVxSMH8HhAOxhiNX82eO8pCnXWCFONjpBXNSwhMNpne3eRhrnUgU7DJfLCm/vYmVV9oP2VUg15OYerNXlJS3PmMgNKg6XZbIHp7Gf4PBg+teq8AzL2iB3rFvmCeNavSAfn2wgwQAaKygO4pSEOZ4rr4jPH+sR0IsavumpgWNh2DVfCPb4n56D/+9qfua2oSVkz7Why+ZupGk+wNFHPRRe5Z8TFCxpHlFhlblqWKx2bwvrAIh1pPTAHo6ywlgHEWSZMz3kdb913KLGgF/CWcsVgp3ZchJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DzyLg23i5xqOkC+BnS1ugv3ZM1462ETWewrrFM1tYU=;
 b=LvbbGV4+932HrBCP9hw6N1Rmn2dIuDrq2YJ+fiPJSwh6S55ynUdLhW82gl2MrG1llmkd7DstzdcKsxATMrdBaZNNIewJQRL0kbiKx4ah+Nec7UIBS5U6FVCXmSoDHbV4zq0UUAAQJFnjfET/pWYNR0OBVWUvzmtIfr+pzAQ390eXwEM8cUGEQir5Z8FxzDtgNVO5wKO1cWBJ4IOSLEbKA+nwNWWnbx637rf7GUp83IdtVIWecjLJE85i6VJoXlaJeo3CREx55iBVEjnlT5T1q5SSc2YjK5Pcg8qMXll9H14bhdn3IMh3O/fozJSk4giGi8vuKDi4m5VvtxOh/OGiuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT4PR01MB10389.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 15:13:08 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 15:13:08 +0000
Message-ID: <fec7b20b-c002-4496-8323-a7778b57ca4a@efficios.com>
Date: Tue, 16 Dec 2025 10:13:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V6 07/11] rseq: Implement time slice extension enforcement
 timer
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Peter Zijlstra <peterz@infradead.org>,
 Ron Geva <rongevarg@gmail.com>, Waiman Long <longman@redhat.com>
References: <20251215155615.870031952@linutronix.de>
 <20251215155709.068329497@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251215155709.068329497@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0165.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::22) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT4PR01MB10389:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c262e72-0408-4491-4b13-08de3cb59ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWVtWUt5QTAwczdiMnluZFdsRGpldGUzbTJ1RWJNWFB3RzFQYmNyckk5NUpw?=
 =?utf-8?B?YklOZVJoTTNmZHlsbWkvek5Yc2N5eklUTGtRRTJsdXdqT2pLQ3g0ak5vcEVj?=
 =?utf-8?B?MnZ1WDNLQnRCZWpwYUlRanF1RVV6aTJDYktVdHBnRGt2V2pWenFkRGowTk4r?=
 =?utf-8?B?b01xMHV3d3VrNEdGdHMvaHdiQWRibzIvejN6YzAvamsvTEM4VUY4bGhDc1pK?=
 =?utf-8?B?ZVlCNS9OYkUzQnRETHhkd1VPazQrK0NlbzJDNVVMamJxQ2d0TWgrNitQU3ZV?=
 =?utf-8?B?S0VWblh3c05rNmJTcjd6RHl3YUwvbGIvcktYVDUwSlVUY2lBcVZUWGc0ZkVt?=
 =?utf-8?B?U0tZV0RDOWxwcTd6TzhoSnJCNTdackRTYS9pYXZwVW9ZWWM5cjQ5U1FGS3Ba?=
 =?utf-8?B?blQxZzBpYVdwd25kNTZCS3d0V0tBUDFRVTNuWWJuSS9lNW9vOTh1b2FCeTRj?=
 =?utf-8?B?NktQWlhpNFBXNGtiVEhhK0MyUGliOVZ0S2I4aVFrZzI0cTh0dEpJcEkrNmJi?=
 =?utf-8?B?a3ZCSVlXWUZUYjRJMXUrcEg4dVZQRzVRSzdrdG9yUGRMUDRLTVFsckpmWFZF?=
 =?utf-8?B?Rkx6cXNWdyt1UzlNb04wUEJpMUR1dk80OUNUcE9JR2hVOG1iZU1pL2JrMlNj?=
 =?utf-8?B?Q3RTQm1QT1NoUkV4eWxuWWpiTzRQMDZtZkNZa3Z0VU1GaWM3VWR1YnY2dFVq?=
 =?utf-8?B?TlpuekhZdWZORHI0RkE2Rkd6akJPa0JYTDE4a3gzNEQ4b0FRSlExK253Y0pr?=
 =?utf-8?B?TlFnVTZncWRva2VROWVzem51WXhoUjFyaXV3dEhZMm1FV1hKYnZXb2lsVFRs?=
 =?utf-8?B?TVhkSFkwVnhtMkdRVG9EeHA3czc0N1JJRVhJWUtQdDhobXg1QmN2a3dBZjR6?=
 =?utf-8?B?VjViQ0RDV2VDNFlCNFRCYnZHSGpVWEN4eEd5Y0k0Yk5oZ1c3RXRjdVhQUE9W?=
 =?utf-8?B?b3d0MkdlYThwRnZRTnF5NUxnc0xac2s4RXlYanR2TXRCQ0lHY2V0NFZzVVhJ?=
 =?utf-8?B?NGg5b3A4OW5OWnZsZlQwQWw5RitRYWhMR29zS1ZNdXdOSjcwK2lZWUc3VTZB?=
 =?utf-8?B?dFpSdzNrcjI4VWgvaTlBL2FPL05jQWtZQUx2STBUT3F4eE5wclZEakM3dE9C?=
 =?utf-8?B?amtxeEZ1a2t1Wnp4OXJWRkgzaGNnRExsNGFROHMvcXJEV0FRQ1ZjMWpJRGQ3?=
 =?utf-8?B?NjRPanY5bFVFbjZBL2V6cWVGZFNZTk8wQ29wdlBCVlhYTTRPRlpXVXlyNTB0?=
 =?utf-8?B?czh3cjVrTFgwWlRsOHRuUEtLSlV2RDVvcUYxNnZzZnhvZklNSlZCMkplU05U?=
 =?utf-8?B?RGJNWnN4eXc4NitOaEVjNjBBRWFtNzFYRnhuTS9DOXlaa0V2SCt4L0hzQms3?=
 =?utf-8?B?SGdSVlZtRUlKb00rRy9wOXdBZDFsZXQwbkk1SXAxNTd4YnVidENBbGhhZEFo?=
 =?utf-8?B?K24xUlBucWJnaWExWFhEb2xWYWlIemVBdlFyaTdGamhKaUZvd1hTazdZbkZE?=
 =?utf-8?B?Vk53cWdvYXZHMTJPcUxCTk84RWZxSFo3RVVjZGpCZkg1UXd5WkRDdjVOVnkz?=
 =?utf-8?B?TXNvUGlxcm51Z3hVdk1EWG1YMnlGeFRRZDlpOVowRkJHZ3k3RkFaWU90bGZB?=
 =?utf-8?B?aWg2dEFGa0RhQUttVm9Db1l1R2VubXdCWHFkS2g3WFJPZFYwNzFMdm5STzhU?=
 =?utf-8?B?N3c5R0w5QTZUZDdnK1Exb3JFdCtQQ1NVNkNRUDJXNnhMQ3d5NzI3QkxEL0Jw?=
 =?utf-8?B?RFFKZ0IvRU11TStZU29nYU9RNUppODBXVjk4emg4ZkpjbUlrQmd6a1R2SEFi?=
 =?utf-8?B?Ylpjb1h2a1pzZ2x5UHRLMVUrcjNoT0ZKUndEOU02ekZNejU1dElYaE9zRjFI?=
 =?utf-8?B?c3pIN0l6RHFVckZuWHRucU1SYkpraGVsTWUrR3d6dk84M2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eE4zQVh5cFB4SC9FbkNPVVNEMXJKZzF5TTg4dXJkSGVnZm5LUWY3RExGWkk2?=
 =?utf-8?B?Y1lzSXVDdkowTjdHU1dlZnlSRlluYUZORU96STZaMjRtanBrZUZXL1lNUEhY?=
 =?utf-8?B?akdaRHJIM3p5MDJjelVTY3htSXNRcngzSHhqeU5rWEV6TGJWWWtDUXVVSkt0?=
 =?utf-8?B?MGxsaGpoaHVobEk5bkloaEVJWEJrb2YxekJXK2E4OHNiMSsrOU15T0ZmWnk0?=
 =?utf-8?B?UmkzcnlicHk5cEE3SEFsUDZ1TTl5ZnlTMlhvbnRkcEozbTA5MlJvNlJhRFBM?=
 =?utf-8?B?N1dkWTZwLy9VTjRxYWpmYXdFZHMzM2xyQmZac1FZV2ZIcCtNNWlRKy8vQzRq?=
 =?utf-8?B?NnJpcURESU5KV0U3c1dacS9jbFNGcGl6bERFZTNKeGpaUnVwbDU3RFBuV2Z5?=
 =?utf-8?B?YUorWEtQZVFwenVmTWhGZFdJSjJOQmFwNEdQREJVR0hPUUJ6QkxscDlQNE1F?=
 =?utf-8?B?a2NEUjFTUldzZzBzK0VBUXlpUnA0bVdTTTE5b2VpMHJnTEdseUpsWlRuNFp5?=
 =?utf-8?B?YjZvM3ErRTFtYVB4bTRtdGhiT2lCL1IxUml2OTV1dTFyK2FmV1J4OFZxZHls?=
 =?utf-8?B?VHR5NnozdUR5OTlkMDZNMmdrU2xPWjVoR2ZFQUhGeXhwdWx5MXgyczgyWU9i?=
 =?utf-8?B?N1ZZdTcvK0NFemNTcVN6WVZ3eUlHRTBqS2w4VnVVVUdueEJpRllUdTlhd2tC?=
 =?utf-8?B?VW53THY2ek9zWmdVa2tMbjZrYndmeVVhUW91YWlVVCtOMFE5WmR6RlZMRUNv?=
 =?utf-8?B?WGl2TVpjYTJCaGRhQkFEd29OWUpBOER2UU5RdDN5MTNsYmZpRlRMTmduU0Y3?=
 =?utf-8?B?SGYrd2pVaTlVN2wzbFN0cUpxVWlxcVlIYk14dXgvN0FIWmJJVVhQU001Si83?=
 =?utf-8?B?Tnl3dGZaZ2dxQzd3K283S2lyQ0hCaDg1U0d4TVc1KzZ1c29scEdvejc4dXNu?=
 =?utf-8?B?V3FxZmpiRnpzV1RnRUxDTGdQWUUyQTJaWUNVYlJRU21VUDRaKy92WmNpaEdT?=
 =?utf-8?B?eFZ3K0QvbjE3cjJISGNPaDlpNkJLSkJPRUViRFE0Z1BqVW1vNHdUZm1PRUtx?=
 =?utf-8?B?c0FyeUFyYnAxSDZKdXd6TzdRdGRxYmZWMy9JYStIMkZRb1NBT013Nmk1RXJD?=
 =?utf-8?B?QU5aOHB2TEhMTWhwK3ZyUjFUK0g5dm5vK3JuTUNaZGlBRGU3MFlrem5jU3pW?=
 =?utf-8?B?Z2lBRkYyejFuTHNTUDVBL1dXVnEwRkdFL0ZVL21rYkltTVRSbGVSOVJRRFRW?=
 =?utf-8?B?M3FXMXlRT0dINWFCdzNFeEdvZkVZWmw5SnFVZnhkQW1CTTRxekFYejNrTWpo?=
 =?utf-8?B?N1NtcFhjRFVZNEREWlVNT3hKU2F6NWsraEFVQWV6VHVodFAvM2dnRmxWN0dL?=
 =?utf-8?B?VzgzU1ZMWWtnN1c1Y0J6cDlYU0dZcnVDbExhcTBqbWpaUGpOYzZ0MUtYeGxB?=
 =?utf-8?B?SlRST3BVOFNySDRpenliTU9VNXlGZGpSZzIxNWk4cmpZanVTOE13aVhtSnVq?=
 =?utf-8?B?ZWRoZmtkNG10NXN0YVNpZ2FNQ0dsN0gzQjNyeE9LY0ZidEVTTEZvL0kvYm5k?=
 =?utf-8?B?VnJ2UmZHQlZGQXpKWjVQNFVSWFFWT2ltcDJLalIzUjBNS1QrN1lmNllrb0hW?=
 =?utf-8?B?aE9ZVXdWQmJZbU43ZG9UclJJak9XbXpwcUdpRy9QMUJ5OGY3Smh2RTVRclNx?=
 =?utf-8?B?aVNybHkyOXBCS3oxSUZxN3Z5R0xMUDJGa014c21GaU5CWjNZWjE2NTQrbjFR?=
 =?utf-8?B?T1VqWUl4Kzkyd2JFaDlNMmt1dy9Bb0hKQS9HQ29mSVRlcHNRc0Q0UHU0M1kv?=
 =?utf-8?B?akJRRzhFNXp5YUJUK2pFSW90d2FlZFNYRVp6c3dMV2liVEU4UXhIeEtFVVNB?=
 =?utf-8?B?TmxWVmdzZDB2WTdvajFQTHZoSDNVaTdKUVBCRHpGWHNwWUdCc2YwYVJvNHRW?=
 =?utf-8?B?V1VoK0l2QzVCYThBRTZrTTBtTWhtdGRWRFJsN2plYmtJT0dZZ0UvdFkvSDN2?=
 =?utf-8?B?a1NvUG5Qamh5b004RlZoaUJrdDFDYkRQeTZ2dkZja0w4aEJOL21hZTFXcjJH?=
 =?utf-8?B?d3Y2RUo3RHdvaExzaERJc1pmS2xIR1NFdDA4Y21PbVdZM3BqOTdES3M2b1or?=
 =?utf-8?B?cllKYU52am1GWC9lWHBMVU96eFZCY1JHajZSN3V6a0VKRm5CdnFuUkNtSHl6?=
 =?utf-8?Q?va58KE2LoGwXaYxahKnMaCI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c262e72-0408-4491-4b13-08de3cb59ec2
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 15:13:08.5260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czjz6NbnDuawl/63kpM2ZYtvC1sE78sgyuiP/r8hreH1pXXoq8BCISM/Ap1uyIB/Q3JSVp3+AIt2bEbe2iHu4I/TiX5uo6hdah6pKIDat2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB10389

On 2025-12-15 13:24, Thomas Gleixner wrote:
> If a time slice extension is granted and the reschedule delayed, the kernel
> has to ensure that user space cannot abuse the extension and exceed the
> maximum granted time.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

