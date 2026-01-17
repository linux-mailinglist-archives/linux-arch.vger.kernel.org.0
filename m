Return-Path: <linux-arch+bounces-15840-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB4BD38FB3
	for <lists+linux-arch@lfdr.de>; Sat, 17 Jan 2026 17:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 189DE302AE1D
	for <lists+linux-arch@lfdr.de>; Sat, 17 Jan 2026 16:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE13A22D7B6;
	Sat, 17 Jan 2026 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jfy7vOPk"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021076.outbound.protection.outlook.com [40.107.192.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2651D238D52;
	Sat, 17 Jan 2026 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768666588; cv=fail; b=J9FOTA1JQ/LKi+z542aoE0mMlYTr0UyzCk6vyIZmNtAF9w1DslJMqQqWWQz2sF9Evqt1R7yDZKaMl1UHvEI4AWZd8ElxQI8Wn5rptMYDQDwJrF7w3YUXSVv3tUnNGnK/PjnW1Oj68iji3eAzRYjK0qFoCTNApl/tExckfIT7ykw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768666588; c=relaxed/simple;
	bh=I1afuWKfrIL3ul3p2NxcWSCpJg6ZBvbFfGdwXQkkACA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sv9NZ25V1bewHYiMa+O6kKDO3rbinIOz1PBqwkDdLWK5Z11F6/kHKm9CytaD7+bzifTcSpjcbjGC4spThoekETbFTYNASmr+yXdkZl5hpjgJwR3Ycdo2KXvPF5vugdv/0CLQLz5w4QZcN2RXonvAQHQCqHFMgJaxticC2Roc6Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=jfy7vOPk; arc=fail smtp.client-ip=40.107.192.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkJxt8PvyVUSDdfd1yaxLuMtBpPyWcg7Tp9L+DoyWFOE985lv3HV6RkvHgVBJQUV0dV9vuFwRALfS5C88rTceEX5TljDMZTK04odYOEgvkCiGl4X1Ga+SlYetBrCrhRrVQchoG5vmv/F7tJzbQQWbxH2QHogAW0DKDVBbSN8bj3qBtAhWOYb3ZCQaHoFPwqIuwCdczVKxumsm1p4s2At1aveOdTExgWAdtPlecTpZJL17BzBMm2nXkOhhTjzKFr9aFuS/d5wTR3RE0pi6SdNq1QspoG/5UvwXFmq05q69Ou9TfSdpMDok18NOuzbYGVYZWpvAW5nEuJa/ixyRKG8aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJQkfsbLbCZqNYIZC25dEQa2ibcMPiws8efspP3aw5c=;
 b=MzzrQT3IxgmV2WVbKVct5ZA3SaHOK/lLoyCsH4e2NF7h2wwhXwGmNyixqafIPuV1laCTYnIyKvbWZpT3HDK6NsHdMOSWLJ1zX5uXVjG0QTR9I7EOsNf5dJI564L+YmDfPUtZSR2EcjPknTgvQJNVZKqAxTvSIqRTnSvd+OuabKxhn8rf6YGhf7+I2qrik1rSwHN3Ezj9AIaITyD71BfhGB+Msvx5H6sZ9GMsf7FOl6yIMI11wGvvg81ovArI8K1LtfT7+HXAChhsQauBEATBY3rq2AVa1vy8ZszAPy+pym62UxWVf02jA1tnPUyFAY9qcFej3XluTWdryiCoR91kjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJQkfsbLbCZqNYIZC25dEQa2ibcMPiws8efspP3aw5c=;
 b=jfy7vOPknfSIYGypGw2zdtsEJn+2GTd8M3r2n29nQ7UVQVteRNG6mCJuHDgG19UudA23T/r87jiayCGOml4lQi0XfAJ3uim49mJrWPYp+hY1L+shR4vmqrtwj+2+XxlJ/fccUAFORbpeOV7HkAqcrdqxoq+95cVJaxP52n/8PhezqmgjwOzzqVCPq+Femsg6RoLSsUMalfHMOev4UZEKrm/I4uYF1dpaO1zKR8OXvFlr7nC7muqqXRR3A+CFv85yTG1dGUJ2CHfM1E5RQeFiGEgW0V6iC4L8LDDdevq5543aEzCPWANs8wq4YXdm57vJ65omhGH2ggHMLMUvoWOoqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB6307.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sat, 17 Jan
 2026 16:16:22 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9520.009; Sat, 17 Jan 2026
 16:16:22 +0000
Message-ID: <45fd706a-86be-42b8-879e-11bbe262e159@efficios.com>
Date: Sat, 17 Jan 2026 17:16:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V6 01/11] rseq: Add fields and constants for time slice
 extension
To: Florian Weimer <fweimer@redhat.com>, Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Peter Zijlstra <peterz@infradead.org>,
 Ron Geva <rongevarg@gmail.com>, Waiman Long <longman@redhat.com>,
 "carlos@redhat.com" <carlos@redhat.com>,
 Michael Jeanson <mjeanson@efficios.com>
References: <20251215155615.870031952@linutronix.de>
 <20251215155708.669472597@linutronix.de>
 <d97944e3-e5f3-4d7e-83ac-89ddd6a4cb64@efficios.com> <87jyyjbclh.ffs@tglx>
 <225b9868-4ab7-4a90-8acb-8d965626f6a7@efficios.com> <87ldi4gjm3.ffs@tglx>
 <lhua4yhcc0d.fsf@oldenburg.str.redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <lhua4yhcc0d.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF0001A053.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::489) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: b16dd131-58e8-47f2-775a-08de55e3c168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEZOQ0hVR0YwMnJHV1RvVmRDem41dUUwL0dSTHJlOGVVRGR0TENScHY0NHpz?=
 =?utf-8?B?c1k3dmQzTHBsTThHSWVnSTR2cWpQWGQ5TjlhZHBMdEJvcFF4RDA3NnMxd1RZ?=
 =?utf-8?B?WWtXakdsLzFwNFZpNUk5Z3ZDaE1sZ0J4Wk5CWUJUdnNPY1h1SExWYjk2NENz?=
 =?utf-8?B?dmkwaWlkQzNLSzNUc2FOU2FxcmZRd3lnVGFzQ3NkMU5nTXpoWTJJcnkyM0R6?=
 =?utf-8?B?ZE5sdEFZK1ZsaWY2Q0lhdDYrMHVNdjhIdUM3TnczZCs4Z2ZUL1JCN29iVXpo?=
 =?utf-8?B?OExHc3pXaDljME8rY0NGV2hXZExsaVR6eitPUWFFVEREdUJ3elhvWU9LZ3hh?=
 =?utf-8?B?NFNNdDkrUEVWcG5RbHVrWlhjdXRpZTVFVFF1SFlXTWtkaGNabHk0UjY4VzZ1?=
 =?utf-8?B?M09zZkdHZ25TZHpLZ3hLOUFkMnN6TitncFh6eUxCazZqRlR5ZS9ENitLZ2Jz?=
 =?utf-8?B?UGRPUjZ1cWF2VXpNWmxkdFdNcnRjREhVUVI4K0RyS21TUmVJMzdIdHpvelJG?=
 =?utf-8?B?ejAxSTEwM2trdjlmT3RyUFBTRVJ3Q1lhM3hVOFBkV1BaUW91MnhoU0p2TlN2?=
 =?utf-8?B?cU5McGx4YkhFNWk0T2phSkxzVy91TmZWYWxtRmJTUXczVmJQdTVpYXptV0J5?=
 =?utf-8?B?c09rNG93WnU0d1Ewa2JMcGNmUU83cFUwUGVCUk4vUnBJMnBtOFl0RHcrTnRH?=
 =?utf-8?B?aXAvaGI2MnVXdFF5cHNzVnR4bTg4SGZhK1RJdCswMVBncTh1T2U1QWF3WFVS?=
 =?utf-8?B?aEVvcmtGallRODgzUWgxdWp1N3QrQVJSUzRnMElXZ3RibytyNXlvdTQ4OUlN?=
 =?utf-8?B?KzdWcmdQQjFqbzFxRlVHUzJIdStKVG5YV2VOSzdJeit3aSs5dnN2dTJnU05M?=
 =?utf-8?B?alFFV1RocEF1WmVHMUxuQUt5bEZHYVFNMllsR1hQeFNna3FuZ1lPcmxGMzhi?=
 =?utf-8?B?U2xva3QyQ1pEamFYcmtDRHZUZE5IL0ptRGRsSURpTmZ1RThyNGZ4Wmdsemw5?=
 =?utf-8?B?VFBKWTFnNHFNR096U0R6dWowM3lucEwzaGxxU3F4UndsajkyRDFCR1hLZEJk?=
 =?utf-8?B?NkZodDhnSkRSKzc1SWZHbWw1Vi95UFBJZWxzN2xkc1UxNFRudVJOMzVXNFVw?=
 =?utf-8?B?a2h6OEcwRi9seGtkeWNITlk2UWFJWEY2K2ptNWZCRWQxd2J3Rmd3Rzc5T09v?=
 =?utf-8?B?SmtiQWdnN21iM0Z6K083NVdQTEpIQ05tVXZPUVBUNmUzVDVtbGQzU3ArbVds?=
 =?utf-8?B?bTFQWXhDYWZ5N3pmYWJ3YkFyQ1NRNGNuQjl3WlpCc3VXT0daMmhpRjVpOXZU?=
 =?utf-8?B?QU16eU9qOVJNM29GbWVNeHNTZ29kVGV6blpXYmRKTWlXL0JsY3hsT2xIZmZ1?=
 =?utf-8?B?L0Qxc0s3emt4U0x5UXpMTStCNENiUDBPcWU0aXdoS21jbVd3ZnRVdzVFelhD?=
 =?utf-8?B?V1F2cXllSXdxNkZvVUlkbDB0TCtlWWhUcXZ1ZC9lUGNwaktrSHVmVkVMWS9F?=
 =?utf-8?B?QVJSRys2TmhNR25jZXNRQkNIR1IrdDYyMklnRWFmYmIrd21BeXNmNHNjRzAx?=
 =?utf-8?B?L09ud21EUDRscS9aUk5saU1teldTeFcwbGZQK01iYWlqK2M5VWVPWDVTcXVX?=
 =?utf-8?B?TW5wS1l6dFNTdzZ3bFlUQzhzcnFoR1k2VjJ4UkJTOVJxaFdnSk1lVkpwREd0?=
 =?utf-8?B?QWsyWGJ4SlZwZFRqcnBVZW9ZVVRzRkRiS25WeVlJWmRGbHErNVVzeGNYZmNB?=
 =?utf-8?B?eDZLR2xuVEJTanlPM0FlaGhiSnB4TW5pRllRdE11MVFCUFZ6L01kRm05Rk41?=
 =?utf-8?B?YStXTmVGUlBPSGZueUlDb1BqaS9yRDZydHhYcUxNOEtWeENnOSsxTVEvOFdB?=
 =?utf-8?B?WUpXWjlHZ3BpdVp3SXBkTUJYNVVIL3lheEdUUmYydGpvaEJLb2dCUDhCWnNB?=
 =?utf-8?B?SUNwZzRoQmRVN0tmY21oT0lFeVN5TEVML085akV3aHJoNGNMNGlza0pScFJF?=
 =?utf-8?B?TkhBM2l3VzdiYkwyT1RiOGNaWkllNmpZUDNjdjlHODV2K0pEZ0g2M0xuVXBP?=
 =?utf-8?Q?39xtwC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFZodFRxS3p1Qlpkc1NENVZ1Y1Y5dSs1ZVUxYTdFc0xIWGxBY0xmdjJKYkcv?=
 =?utf-8?B?eGpHWFJBdFdRUHMyd3BPTWNFWlVsU29XY085SWJGQWVJUFhNRmJCU281bVFG?=
 =?utf-8?B?ZDJGaEVqbnBlWTFYaXpxSXpwaEFtWU9SQk9GQ0t6UUlLdFZwK1pRTWwwTFJO?=
 =?utf-8?B?RjczTTdsc1NWZnJTQWRyUkJtbmJ5T3JqUTRQTGk0U1lXN2pWQTNQc0R5M29i?=
 =?utf-8?B?VS9ad2c0RHNhSjdrV0o3N29TNVhiWWN2NUpQMW9RYi9GVDlDNWl0RTExR0FN?=
 =?utf-8?B?dUovUHBkVTVtNEFobzlPM2NyeThvSm9aVkVkUXFBT01DSzZkd002QjI1Z1hm?=
 =?utf-8?B?dytOYUdhRzJqemZ6b3NnekprQkhTK21vWGhKSVFDMThvbDBsNmpTVzFLZnRk?=
 =?utf-8?B?YTg4SitrM25INTd3OVFDVHJWQS9JNlJobXgvcTlkL3pxVUM1RzlhMTdnVDM3?=
 =?utf-8?B?elk5dlFIaXJrREUzTG1XekRCWktkY09kVkgvLzRxTkN3TWw1RDc5Rm9McXNQ?=
 =?utf-8?B?WWZ0aEtpNFk5UXF3UldPUGxFQkxmczZFaFFhcm1jVXlPUXh6QUhHZEs2V05P?=
 =?utf-8?B?ZFU1bS93MnQ0aHEzeE1mSnUrNnpSOXdIMFdvWnAwTFhETklpVnd3cmVDSldJ?=
 =?utf-8?B?TDlGNE5FOG1oVk1WR0hJa2N2dTlzOHRQTFR0QzZIc0diVjEvOS92ZjdIMVox?=
 =?utf-8?B?alVqVTRQQzExcjR4VExvQjVqL0dWU01sek5CK016dFVFWVY4cUc2S1BPL1J4?=
 =?utf-8?B?ck1RZWtNTDhMM3I4cytPdUUrUHV4N1hXM2hVa1dwcDQ2SFlkNVRWcjVFQktB?=
 =?utf-8?B?QnVnVVlpanN4YlVFUDlSelRybTE2cGZHT25TUVdSSkdTL3pzSXlTRUhYS1pH?=
 =?utf-8?B?SldtNTA5cHYyK0RRSU5iR3V4UEpEaFlaVldiZFYyYng2UGpWbGR5Q2dxczhi?=
 =?utf-8?B?aXkrcjQ0MG5sWWZ4NzNCSnBjR1l2VzgzdlZhbzJhaHpaK0VYTnZsV2M3NkZj?=
 =?utf-8?B?aDh0aUFFQlp3NXJvcCtmTVd1V2VzRDVoeXFMeWVHL1VHNFdNMzNxVWdUSldQ?=
 =?utf-8?B?eE1xZDRSeGFqSjE5dWdzMENjUmNpNXRGWkdvdzRQZFRNekpvVnpVRlNqNFhO?=
 =?utf-8?B?d3RMNElDWEtvSFg3ZEM5RGlMbVc3Tml4blFENXlBVzc3MGlGYU5EWlFLUDdG?=
 =?utf-8?B?UXZ6KyswbXpSeUFPQTk0YWdsMnZWeXpOTzFIcUZjYjU2THYwME1oMGswcW9N?=
 =?utf-8?B?MTFWRkRicE52Tjd0TjEvK0RHOU8zU3dOQll4bUw2aU4yN1BJdVJMeWdMT3J0?=
 =?utf-8?B?NlMxVkQ1WFh2TVNjWjRtdlRyaHBXTXYxOW12MWxEV2JsVUNwKzJpOFc4L3lR?=
 =?utf-8?B?OEVDS1lLMkQvTlhoaTBEdVNnMXRBWTdBZmJVbHJLLzNkejg1a0Fzbnh5QmFO?=
 =?utf-8?B?L1FDNi9XUVBhQ3pXdVArL0pTVlNrODdLdUFVWUozOGZ3RmdubW5ackcvVEg3?=
 =?utf-8?B?RXd6VWlBQWRJeDF2bVdMTnNqaytZcTIxVDN2SFpXZVJQaWdQNm9MdmY2eU04?=
 =?utf-8?B?UjVkeXBCVEZlS3J4MlhTL1I2aTR6djJRR1lHOGZDSVhVSUNnd1YxQ3M4eE0r?=
 =?utf-8?B?Y2gyTVNPVFVvS0txWi90Z0FJRnJkZitIdXlqOXpmQ1BUazdYMWJrOEZJcXhH?=
 =?utf-8?B?L2RWbzZuc3BkeTFRb1krZEh3L0NIKzlETjhwUnBkYnA4b0tyN0RuVlgydytL?=
 =?utf-8?B?NGtTcDRxSllQbDhzTXF1RG9qZE1CWDBwRTl1ajIwVUhNbHhxbUdWY3U0MFVS?=
 =?utf-8?B?MjZZU2RyRjlCUm5jZE14VDMzajJiQ3dzUHhrUE5BYTJnTFNSTUtkbmN1aXBv?=
 =?utf-8?B?Vk9WMW5uSXlJQmNBbDdjNHdobURTS1NhdG1YcnNIbzJHNVArcTdLMXFyV3lG?=
 =?utf-8?B?SXpqbzRYT3VpV3A4R0V0Q1pQd1dYTlFLWEZKOExJUGpNRCt6dUVwY2d6WUhQ?=
 =?utf-8?B?MWk5dUdsbHJ1S2NIOUhEMUxYMnF0N1FyRDFOUkg1ZStSN2Ruang1WVlLc0xj?=
 =?utf-8?B?SmJUYTZHUnJUMHlEb2pacytVcmFpL1R2SU9leFhVZUJsaU1lSW5sKzg5Umx1?=
 =?utf-8?B?Ry9GaFo3RUtkT2dkTlk0dFM3amNLbmpYMmdKaUtHV25kZ200L1kya1NKbm5F?=
 =?utf-8?B?WldDalJVcURxQ2xQN0NicTZFNjJjMU9aWkhHVFljc0tkQXdCb0xVQjFnNktW?=
 =?utf-8?B?WDUrWVU5RUo1RUY1bTNHUWgvVlh4NWV4YVQvSEIvOFNTLzB2Rk4rRVFLbGVv?=
 =?utf-8?B?UjhObmFVV05TMTFHejhnYStUNHZ2ZklZRlZuSndzOVdMcDhYSDFJMkNXaVhO?=
 =?utf-8?Q?DsG8SX6R+ed+RUUQ=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b16dd131-58e8-47f2-775a-08de55e3c168
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2026 16:16:22.5980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QpD+3PrTd+JyX07CTX4FDebH6bxaqSdnpGXtqzFlep+nYbjf81fUo7e6lLlA+0tABM4mpzStDenIN9JW2q8YSgfBfA36i9Otd0cpXOwK8XU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6307

On 2026-01-13 18:45, Florian Weimer wrote:
> * Thomas Gleixner:
> 
>> I'm not completely opposed to make it process wide. For threads created
>> after enablement, that's trivial because that can be done when the per
>> thread RSEQ is registered. But when it gets enabled _after_ threads have
>> been created already then we need code to chase the threads and enable
>> it after the fact because we are not going to query the enablement in
>> curr->mm::whatever just to have another conditional and another
>> cacheline to access.
> 
> In glibc, we make sure that the registration for restartable sequences
> happens before any user code (with the exception of IFUNC resolvers) can
> run.  This includes code from signal handlers.  We started masking
> signals on newly created threads for this reason, to make these
> partially initialized states unobservable.
> 
> It's not clear to me what the expected outcome is.  If we ever want to
> offer deadline extension as a mutex attribute (for example), then we
> have to switch this on at process start unconditionally because we don't
> know if this new API will be used by the new process (potentially after
> dlopen, so we can't even use things likely analyzing the symbol
> footprint ahead of time).
> 
>> The only option is to reject enablement when there is already more than
>> one thread in the process, but there is a reasonable argument that a
>> process might only enable it for a subset of threads, which have actual
>> lock interaction and not bother with it for other things. I'm not seeing
>> a reason to restrict the flexibility of configuration just because you
>> envision magic use cases all over the place.
> 
> Sure, but it looks like this needs a custom/minimal libc.  It's like
> repurposing set_robust_list for something else.  It can be done, but it
> has a significant cost in terms of compatibility because some
> functionality (that other libraries in the process depend on) will stop
> working.

My main concern is about the overhead of added system calls at thread
creation. I recall that doing an additional rseq system call at thread
creation was analyzed thoroughly for performance regressions at the
libc level. I would not want to start requiring libc to issue a
handful of additional prctl system calls per thread creation for no good
reason.

I don't mind that much whether we enable slice extension per
process or per thread, but what I do mind in the case of per-thread
enabling is whether the enabling scheme can be batched, so a user
enables a set of rseq features in one go, ideally at rseq registration.
This is missing with the prctl approach proposed by Thomas.

If the enabling is per-process, it's not so bad because there is
already a lot happening on exec, so I would not mind a prctl that
much, but for per-thread enabling I see the many individual system
calls as an issue we need to address.

> We need the prctl to unregister for CRIU, though, otherwise CRIU won't
> be able to use glibc directly (or would have to re-exec itself in a new
> configuration).

Good point that the unregister is needed. Which means the prctl is
probably needed then. But it does not solve the "handful of prctl
per thread creation" issue, which probably calls for something more
at the rseq system call level.

So I wonder if we could extend the rseq thread registration to also
specify a set of "features to enable" somehow ? This would still be
per-thread, but would not require additional prctl on thread creation.

Thanks Florian and Thomas for your input, this helps me corner the
issue that's nagging at me.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

