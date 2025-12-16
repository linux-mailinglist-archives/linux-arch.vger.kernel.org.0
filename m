Return-Path: <linux-arch+bounces-15467-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B09CC3D72
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 16:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54D45301989B
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 15:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6614E34250E;
	Tue, 16 Dec 2025 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="YyIvBURD"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021085.outbound.protection.outlook.com [40.107.192.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0253334683;
	Tue, 16 Dec 2025 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897531; cv=fail; b=s9sNcKjSGSAdU6w01VsJoIhFQby6zl6c8oC9k8KKk7RC15CM6/8BKynz/pYvt5W1jK8nU1oMn7Eds9aJFjMLnfiIv2TTfI+2i8C/e8aY6DGRfUf5/2NzGAHefHhBMJb7maI3v0O5cpSQH6Y9wXEs1xURYwIBdezkw6000EZy+1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897531; c=relaxed/simple;
	bh=cKp8vVVFd5NO1HZAytWv1gZR0s6/Kr7tC6AmNjW68/c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p/BGoa2ujRjcwVXh1lmz3LkfAxJ3ODzR/R1+J4keBYdD8FPZFmxGfis3ZqlfygxvWbTJ1SKaUHtiCI+MXi3no5q5g8U1RUepBI/A5uW5vq7mnvAU7xXuG9/TE0SPJqJWCDkswsDnrfLpOVa7yGfsjchq7RKj21EXlXRm+XmVB3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=YyIvBURD; arc=fail smtp.client-ip=40.107.192.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSkrsYsuOYm4ulcUeKln48F9sFW3zEBY67LnlpEpoOnuFoisWinRq1EsuhZPOl8uRdoi/cc1ePYeEU46Fa6CJaHkB3YdUzB+8aivLthWWFwxsLQ9sI3VSNu2+SM8yA1opPDJdxKDedNjLaqmjU7oXS1/4DEGYhl/HzWyeU9uAdCHe4/MwWJz3GtfuyN1rcFLihbDJPRAmkh6eiOu8VDlecgNoqD96snf0VmygBzrSPuE4gD+M386FNjksLiZXF0gzjNC4gxFpOVmV+O6v44M70dPYufqZ1g3GtKRdkC9eSTmi1SLXn2kzvgE+dXpkoeZ1OqEdoqHfJS/OdiYYuXXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGcHywLZ+QDKBghCVQCt505UFCa/5LRICVyQBeX3L0g=;
 b=DzAEAMmSSVGE1c5qhqp1Gu69aElA3DjGf6XRTV8kWhqzOKNku549miK9rFS8ebW2tXLwjKwCRlYolLpj63c9UKfRJ3g52AXmLTAvYnpOd6cKdICYjSaC5Iw0sWbHQdwtNJKu6rON+0sohRuZk0yu1/J+Og/gHNOFis6GvllvpuP/Q8My8dY39Ba6NATWznH4+hIAakvfPVBcEpBq0x/PCQiiAjg/61wZE0Q4FAz16mVD2E/Dy+fd18LqEcEYIlgWNygeK1eqEcjGIKiwD4WQWL59ygDcCVsQPAB8xhSNt3AIMZKKoxsCWz3r8H7N99EPZ330omEn7FNQt9dspeGOaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGcHywLZ+QDKBghCVQCt505UFCa/5LRICVyQBeX3L0g=;
 b=YyIvBURDZgHLBS/XP4shYUf7L/2+/NoCgfB4RQZy653QxFjnN33WR6umYl/O/4LuyjPJFW5aeRi47ghE0arWoAU3VXzveBuvE2iWrzCW5yYjGe/i4wlw/8vzGzweiDVCmG+lCkgvXgzRR9oJhUwU7kfn7Biq2DcDBwy1Qlng3S6ySIbfJdcq64ycXHHTH28ITXgS3e8vybHuVTnWWllPZgTB2TlgyXNO0Rfh7O+o4tx4qpQDjyDgpaZxjpGJdoPVyfUnHm3V3d7Q60l2bxNjMehgCbZSOiBWGFyXMIBNMFq+TIU2JZTRQP/FdX6rdFMfs+mB0d4Vgv/6grARJvUalg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PR01MB8185.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 15:05:24 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 15:05:24 +0000
Message-ID: <6a0344be-e105-4f09-bf41-02940e730293@efficios.com>
Date: Tue, 16 Dec 2025 10:05:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V6 06/11] rseq: Implement syscall entry work for time
 slice extensions
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
 <20251215155709.005777059@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251215155709.005777059@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0327.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::7) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PR01MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 97cfdf82-2bc2-4039-3ba8-08de3cb489f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkUyUHVLV2pjN25JQmlUa0EzaTl2WXpUWUNBVnhmR0dBc2xZbXV5ZzBmWnhW?=
 =?utf-8?B?UlZRN3NvMlM5SHRTekY0U1NoaG05U2V1bkwzZEtlTFd2RlNsMlBBSHpKWGRN?=
 =?utf-8?B?MmFBUFF6RUltM0lKdTVyV3ozMGxiaTRiVEpxSHozNkI3QlpFcGF1UCtybUFN?=
 =?utf-8?B?NUZweTVTL3MrN3ZUWUdsVVVqeUs0VG1WclRLSnFRM1hGMmQ1UVY3eUJYUXV3?=
 =?utf-8?B?VWpraFg0c2FXN21tQzN1c1BnWVBFZUVsTDd2bE9mNkQ3dHA2WG1UWlJYWTlR?=
 =?utf-8?B?WUluZkh2Ukx6WklZS0tTTE1kZk9UcE1xSmxUaGtyS2FKNmhvYy9YYjBTM20v?=
 =?utf-8?B?MFhWZUhldDlEc2NIUXJQQktLZEtKRWdLeTZPbTVIbENMeWMyai9Fd3FkSits?=
 =?utf-8?B?b3c2QlJpdkpibjc0TCt5a2hyYnQ2Zm5iQzUrbkhJU0R1aUJNcHRjTTRQYjNj?=
 =?utf-8?B?YUhxWUJ4RHNwRTZROFdQbUhUemZyNE5ZeVU0cVh3REZ4elhKc2t3b3lRYlh3?=
 =?utf-8?B?d1pJVGZNcHFHY3A4RUI4MjV0aEl0VUVHMDhwRXYvVUpRckZJQXhFMHFKMmUr?=
 =?utf-8?B?eDRUejYyR3dtbjlIQXFZSmJPTzlTUi8wVDJ2VS9ndTZwMksyemxUa0lGbUly?=
 =?utf-8?B?bTI1UGx4dDluQmdlQVBseFlVTEFwZEtkZkhGNDdoY1F1enEwNHBwNzNJbm5y?=
 =?utf-8?B?dGwzNTFwUlJPZnhFdTd4UHhXTmJnZnVNa3dEcDNHZS9ZVW9zRitVNm05SUtT?=
 =?utf-8?B?blpVY3czSm1sVDAzVHdqbnZ1a21pRTRWT0hvZ291SkFwRktVdWJFQktzdzB3?=
 =?utf-8?B?NDRRL0k0UlFyQUN4NVd0TjNDQkVpeFVIRjlkbkwraEZvSDlwa1pqb3owVWxj?=
 =?utf-8?B?RVJtbzkzQlQxT01oRU5DYzlwbXlRd1M4YmM4MXQzSU00dEM1dnFSQlhIK1Rr?=
 =?utf-8?B?dk1vd2lDYVBmNEV0UUZNbngxRkY2MDQxZGZLZHdrWTM4N3IrUzR6aklERUhY?=
 =?utf-8?B?aTFES1JMb3NOa0NYbkgzOStaaGFCZDlWcU5weEJHd0NNV096ZzdWNW84ZzJ0?=
 =?utf-8?B?SEgzUXZGR2MxeHE0V1RnUVJOcW5QYmI1WC9WY0htejEyNkpjQ0NUeFQ5a3Vq?=
 =?utf-8?B?WTVaZ2ppZjRRZWV5SjIxd1Q5MmZ6Slk3dWpTb0VIYkxEQUR3UHFyMmRiQmZL?=
 =?utf-8?B?VHpFVlpmWUl4VTRxbVNvVCtYMUlpSDVMRGF5cytENmw5MDhMeldMUTNtNWpO?=
 =?utf-8?B?Zm9ROXVTU1U5elRFaktyeDM5MUd2ckgzajdPa1JwdUdvdDdKYXl5ci9oaTFB?=
 =?utf-8?B?bmpPTytzNGp2U1Niem9nZ1pDMlVla2NFNWJuVHhXbG9ucXArMmlza0Y4dmdS?=
 =?utf-8?B?N2s4cnB4MXVJb0ZMY2xtUk5CRWpLa0NqM1Q3YlZPZ2JKTDk5bDBCNW1CdHhB?=
 =?utf-8?B?Z0RnYTJwM2dhS0dIQlZjeDRjS3VFRmhTWWNFZWRVR2JSVlc3TmRqZVhNUjN1?=
 =?utf-8?B?dkw5VVkwTlBuSXJic1kyZmRORitnQ3FZQ0x4Rm9ZM2JQSVhHM3hkcW5xNXov?=
 =?utf-8?B?UXRWbWltTyt5ZnByTmVRbFE4bzNvRXpBUEN2UVlJNmdKZERmWjdRdHpoSm9u?=
 =?utf-8?B?OFdWRE9uc200a3A5NGw4ZWNYRm52RVNxNFlmcThoRnlqaDdHZW1pVE92QmpW?=
 =?utf-8?B?OE1QTnVnN2FkaUZMY0d0WU1WaW16bWNrMGRvcEVNME1ES1QyZG4xdHJGNWdT?=
 =?utf-8?B?bVFuallVSnVwSFo3QUUxRlJ0akhENlIrNDRFM0NtazVPZThMS3A4OE5zN3Q4?=
 =?utf-8?B?WHB3NFZHLzNyWWxuZlVPL0pLUXRHSEV1SnZFb1BrdjUyTk90MDlKbVVmVFQ4?=
 =?utf-8?B?RjcyaFVmejJMZVNZcDk5QllKdUIvY1hVd3V2Ym15RFRUVWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bC9HYUJaU0JyUnFsT3VNL1BDVVZYczA0bmdPVXBBMEZWSnJ1NTM0aTJxS0tZ?=
 =?utf-8?B?WjUzZHpCNU1GOHA0dnJTSXBFbUxTZjhCcjJ2RjVoVEhkWkRVTVZCazgzQmwr?=
 =?utf-8?B?NnM3OXRaaUtiWER2Z0FodnRUS3ZkY21PVTBpMkdlT1B5WlZCOGM2TE02T1FS?=
 =?utf-8?B?TTA4YnhoQVh4bmNLWDlRbGx1MUNTdFMzVWM0V2Q4RllYUjRGVkVFa0xHMUQ5?=
 =?utf-8?B?UjlXNGhSaDNaTzlCMHJ6NlJmS1p6WnZkTkF6K0gweFE2KzUzTk9KdjhzVVZp?=
 =?utf-8?B?N2dBaG83Q2pLbkV6dk9IMWljeHRQNU5RVnpxUzFQZ2xxRWdGRkVlOTFRd0lm?=
 =?utf-8?B?WFhWT2dhZldBNTdhdC83QUdDaHJBU1pudk1obzlvcXRyd1dPL051ZzE0REpJ?=
 =?utf-8?B?a0NEUGVUUW80OWFyeUM5Q3U4TDZLMlVYU0F4THE0dWJibmFNUG1NOW5rUjFY?=
 =?utf-8?B?cUgzM2lIOHcveEQxN1BKWHNTUFk5eUwrKzN1ZytzaGpEZ3lPNzAwYXBwcGpi?=
 =?utf-8?B?TmVjRTlTdjk5YmJLc3BDV3p0Z0x3dzVtV011TUlmZE5zQnVyeittSGJUN2hG?=
 =?utf-8?B?d2dGWW5kTjRSbU5oUWxNWFZ0SW5YenJNbzdzQVJXNk1LRzFSc3IzVWRXeVRM?=
 =?utf-8?B?R25CbkJ3aVE0eDh1T0htYWxGMnc5VDE1d0ZHbEJaSVVEQnR2RDNsRE9yeE5J?=
 =?utf-8?B?ek1BcHBFdTk4TUVjNENoeDB6Z0R3R2hZUEQ1c2pXSTBoakc0b1o0S1I1a3Bp?=
 =?utf-8?B?b1VxV3dXM1lBSmtuMWtML1oya1B2Qk5SUlVaZmNnbXdBc3RVMTIxZkwraTE3?=
 =?utf-8?B?bVJxVGVaMzZvUVk1YmFRcER0UzJIb21HeW15MGJXeG4xUmtibVhVNzVhcjJr?=
 =?utf-8?B?SUVSVUJRdllpSjVJbnRaZmg3OVZ5OFhoTzAwZnpLcU9sZnRWdjZRampjVy8r?=
 =?utf-8?B?QVVkRHhieFA2M2FEUktmbTM3QS9aY2U3aVBRdjZWMjJvTjN4WEJ6WmEyZ2ts?=
 =?utf-8?B?dzRtelRDaGt1c1lGK1JqTWR0OFpQdG1uRElPNXYrT1Z5MUdBdXNlQWlhQlVE?=
 =?utf-8?B?a2Y2N2hVZENtblNqeHg1RUxtMnVKR0dKVjFDMElLR0J6UTh4WEpNcXdsZm1s?=
 =?utf-8?B?SmQwOXNKMGxWL3FQNXlaVmYyUnFVZjFaczFrd2ZQWEZlNE5vN1JDSFNBa2Mz?=
 =?utf-8?B?OHhOdXJLRHQvUEs1c29XY08zZzY5dWFhUzQvUFc0R2lSb2hBUkQ5Mzkzd3pH?=
 =?utf-8?B?OGtvYnl2NFlkWWtsMkZQMlc4QVRuckJJYUtWUlpDTDJTSTNaUlpzZFliTEda?=
 =?utf-8?B?N2w0Z0dkQVJUaGx0ZXF3allzRktaUXE3WTFaY0NMTUczYTI5eG11SGdqMGhj?=
 =?utf-8?B?MVhRY2tqN2d3WmNuNy82YjF3QnpQak05QW1YN2NGa0I4dG0razBndGdESjBu?=
 =?utf-8?B?VGo5RjJnN3FQNXVoQll3aStEcTJjQ3dsQWVwVEN2R1hORmR2YS9ZaVRWR0Fp?=
 =?utf-8?B?WXBIMUlvb3Y5dlMrWDRGeFE5blhRK2pEK1N0cDhIaGJzeEZaTFZsQmlUa2xS?=
 =?utf-8?B?N2I1eEFOaWZ3Zk9OUkRudVlnWTE5d05vempaOTJDS2dNYXZDRG1KamtsUERI?=
 =?utf-8?B?RXJ4NTEyTnBzYVJXeDdHNVpZeFFDTmVpWmw0TTVVL3ZZODc0UlJ0eHl3OGdR?=
 =?utf-8?B?THJZdll5V1pwN1dlb3JMM252TFQySHhCWEgwUWhRTlBHMjNtQjBGT2lpM1pL?=
 =?utf-8?B?aFMvNTJ1Nk04R2UzdVNOc1YxejBTdFYwRHJMdVRUZTZBekVIYWw3Z3A1ZTZI?=
 =?utf-8?B?KzI5Ull0ODYzdXdZcVNpT3h6bnR3NlBTVWx4Y3Z1dXlCYU9GbnNoVkR2N3VJ?=
 =?utf-8?B?U2h0Z25ubEVCaEY3MGNhL2wzK0VYRk9Vd3FveFN3MWJtVnJQM09NY0xCbHA0?=
 =?utf-8?B?bi8zZ2p6MUM0dll1VUpraTZmYzhIZEJ1U2JvM2hQd3VpRy80UjBHcmZObVpo?=
 =?utf-8?B?K0RjeU93S3I0Q1F0WjJVNjlnRG55VVdjc3pJMGZhYnZ5dEhQQy94RGxZRWZm?=
 =?utf-8?B?RE1PbC8xV2pVYlpTaEhFU0phd1Fzbm1MSG8xQnlnUWFucDdXcWxvOGk0VjA1?=
 =?utf-8?B?VW51SnNvQmZBQ0dlUjFKQStiVGNrR3NIWDNNWUxYWnorWGlrQ0JYM2tuc0RY?=
 =?utf-8?Q?NeixOCcrXs+X72azfDjlzQ8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cfdf82-2bc2-4039-3ba8-08de3cb489f9
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 15:05:24.1340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGxgRvoIRe/kwVcPnfrt8qzTNXAmkuOEWKjsDSAwEbSK/JJnUzA+l99dhO351MU72doK1KnPbCW8LXcbYQMhfcp41IJZCfD7vVjoBJqWkYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8185

On 2025-12-15 13:24, Thomas Gleixner wrote:
[...]
> 
> If the code detects inconsistent user space that result in a SIGSEGV for
> the application.

With these last updates that allow userspace to call arbitrary system
calls to terminate the grant, the only scenario which triggers SIGSEGV
is if the put_user() storing to the rseq area fails. Perhaps we should
update the wording above to be clearer on which situation triggers
SIGSEGV.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

