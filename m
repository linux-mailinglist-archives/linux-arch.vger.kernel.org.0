Return-Path: <linux-arch+bounces-14684-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFB5C547F3
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 21:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 403334E1D3B
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 20:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4823D2D5920;
	Wed, 12 Nov 2025 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="bdmWlBH3"
X-Original-To: linux-arch@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020082.outbound.protection.outlook.com [52.101.191.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983A02BCF46;
	Wed, 12 Nov 2025 20:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762980021; cv=fail; b=BB3UxBKoiurSDFwJQkNZTRwjEmZ1psCb+/6btS1BcU34pMIzZGldnNyFoijX2YZ2t4SQBi1j2P6yWNBg9CT//OTeTOaY5g2N+uStVR9HKODmOrFPCTeO82EdEWmqzrdO9tyW4nUfE6ffduDMLDDbHKHC86BASduCh0XS6EirFhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762980021; c=relaxed/simple;
	bh=Gqoma+gy2H0gAnu78wqjBilLhFG8rAS0kxKTpAxNeUo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qoi3iGQAyohm2oJy8gaVnbwjjZglLkjWupDVgkd14BxD2RbjxzhsQlDpZOfWwbSB8Wl49JMQw2Dn5a3JbeCJivf6H1kKpcbH6JPAhau8jFGklkFPLNgvEqwUcYpVo35cUVfr2c3KRdyiEiGdeJ81oZx8MBOQaWH8RRYwhwUTZe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=bdmWlBH3; arc=fail smtp.client-ip=52.101.191.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBoZ1Ip+s/bJ0W/L2R0iehq5vmwND35ltP0ul8zzZg7V2P9z3eTUA3dY1uYSV5uaIj6ygXewwEEuvTt9JGU67Dmo5UOxxgnzes4r6s8AgtsHEPkJOAEWf/mqG6aC9oYwGmuw6uy6tIHrCosdhjZdPnsyJ7D/0gH9WtbuuLCRlAtVxrEMME4lkomKffpGGxP6ts9HRhfbH64qSZHRTcLCXOlPwe765S+NRLXHMji8m6fPZM2KaxxzKyg4caO8Ag6Jcp1dIczc9oEqqlDph21rc4YD3lWqMaILbRZEYtL84yCHfuLLywNC5+JC3zW/jo2VFDYAu+k4LIidtn6F9kaniQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+qchWotxvcJboi9vvNf0iv9HteCiyNTOdSZMB9GYpI=;
 b=pwplJAaZiEP+Lo7z7GySgPLBYRBh422Wa0j4fdjq1rDAmtKdpOmA0EdK0FlWvL4+DfS4D5t/lrQPfKydFjgGjns8PKo9mx7MKPi0c+bsi1ogU/cdJFrKvzGrR7hi/+84wYxy9GUzqkWvQViH0ZOT/DQJtJbKTzuWPeuSt0le6WxjNt+jt0Hbc7/9bben9hbBuUUmE0ecs9+IA6KOyKsRBBuEXg5+aoFGHKhVX2oLAImXk2xZnvgyh+kmU9fJ7olb5MrgTSGZ4Sq2d6DSBTElu3u4J/XC17WV+GjLwktMyMczKIxLA/MIs0BQM9Kp8cpmyHKH7iEwbGEMgBuabvXx1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+qchWotxvcJboi9vvNf0iv9HteCiyNTOdSZMB9GYpI=;
 b=bdmWlBH3WVvhN3yX4oS7ydyQ2oLUjdDQ33yCcZjABPlZXS+pOD0XiGXrEeZlC29D3zOOTZ5iy6ud+qGIX74Dccaw5MutEmWmac8KQZWyAh48VByZA0bbPUEVmWz/Ea2aDh/5NZ9bwzVkBuccAMfG/Z0UdRO10rsrPLGuXUnWas8LXTnNCReLxopbSYqjBRntF/Tq9OqLsjo3UJ8qWckIcydqFh3ToVCwN9qgNcn0fYpHA+uM0Ey6w1bWgHwsKKueiiMJTbnmATnrD4sFOLt4JVY2n0Ha2s96+VSfuKgQoc6kMEQN5b7NYPJsPcoFnp8rZt/HIU0UZNzsf7Ue7+OgkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB8798.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:59::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 12 Nov
 2025 20:40:13 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 20:40:13 +0000
Message-ID: <f27baf17-87e2-470e-8d09-ad435331543f@efficios.com>
Date: Wed, 12 Nov 2025 15:40:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 00/12] rseq: Implement time slice extension mechanism
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20251029125514.496134233@linutronix.de>
 <03687B00-0194-4707-ABCB-FB3CD5340F11@oracle.com>
 <2eee5e37-e541-4ac7-9479-cef3e62f234d@efficios.com>
 <b28c9f26-7a79-473c-a390-f502b74b02ac@efficios.com>
 <F940B2E6-2B76-4008-98B9-B29C27512A60@oracle.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <F940B2E6-2B76-4008-98B9-B29C27512A60@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::35) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB8798:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f59a3e2-9182-4f87-da13-08de222bae17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkVEOHYzODQ1d3YvSWxqdHZianVzaVRWZmUrc1NSelhOT2tOYjRUdmJ4WVVk?=
 =?utf-8?B?QjJCSUhhaE1VdVdVM0FhUGRwMjhCalM4bngvT3NoYVJoeHdOQ3pwbTQxQm94?=
 =?utf-8?B?WnlDZ0ZMNklsTjRyeUFxTFVxNU1sZGdYQllMWi9iMUpKVXNRWE1WVkV0YjR6?=
 =?utf-8?B?ekhoejFEQU5UTStFNk4ycENIQSthUm9oRDN4QkU0Ym81aEF1U2ZlMVZ5RmlK?=
 =?utf-8?B?U3ROOVdaRklLY1AwbjBWNWZtTSt2VHJzRUxFUnBlR0ZBVk11bWRzRE9JMjNl?=
 =?utf-8?B?US9ra2lFazEydzU4YU5xckEzZGQ5LzRXSHM1VFVFdGZ0QVdER0dSci9JSlVu?=
 =?utf-8?B?SjRVR2hCV0R3TG5TNDhoaTBWbkRvaHBoZ0NKMmM5RElpNlBtSnN5YXl0SnV3?=
 =?utf-8?B?U09jQnhld0I0cXpraFViRFhtUWlsbkZ0UW45WkY4dEFSVjhYczR3aUY2Q3lr?=
 =?utf-8?B?V2h4enlGdDdERS9RSTJtRU1NWXp4U0hyUkltYmpDM3UxRW1ZL05ROG9mRlcw?=
 =?utf-8?B?S0Y3ZndldDNaYStOb0k1OENLUElHZ2F1NEMrbTZLN1dHaUZFWU5YbDdxTTJX?=
 =?utf-8?B?T2V3NWpGcDZyZUh5c1VpUGFqekN5N1VyRjQxU2NhNzJ6aThZdi81SWdMMjdZ?=
 =?utf-8?B?Rm4rMGtZU3kvWWVaUjBlNTJXVThRVDMxMnhNNDh4VjhyME9DcmJ1a2hSOHNT?=
 =?utf-8?B?aFAvaU9lQUFoTE1ZS2lPN1NtSTdVZmtSMFBCWUVvUDRnVk1TcUs0b1VjOFls?=
 =?utf-8?B?Qm05RlVDMW5yY0hpdHZQRUVXTTFhTFlVZktVUWVzQ1ZqRG1tMXJ6S0U2Q2xr?=
 =?utf-8?B?d29reGpDcjZMdDIwb2c2T25JNHlheW13cmtsRC9TcXpGa1V0NkxRSUVNWjM5?=
 =?utf-8?B?cHRuMUpkcXFxcko5TlJLc3krY0NzSG9qZUdlSzNjZVV4YWtERk1yZERRLy9n?=
 =?utf-8?B?THBOejErWWhRUDdrSjcxN2RITmQ0c0dYTFBEbEFER3BuY1ZNR3gvc1FhcFU1?=
 =?utf-8?B?cFZmZDkwc0JDNExHUENNdTF0U3MvdW0vS0pvdzRFbldBNytOMDhjdEVLV3VE?=
 =?utf-8?B?RE9wa2gySG1KTExWWWkrcGdrbmtNaVZvN3Q4bC9zUkpoQk5TSGkvVitYblJ3?=
 =?utf-8?B?RWZEYkdJOXhBU0x5V0V1VUlsY0pQcWNqVDRZd0pxMjNqYnJsanhlTUEvWkhW?=
 =?utf-8?B?ZWZyOHQ0WVRnZGorWDVjZ09DNXVsbXNBYm5CSDIxamwrRVJZNnBRdE1qZkFz?=
 =?utf-8?B?SStmM01RNUxEWmFsSUVRd1B4MFNhNzV4MERYT2hldkFuNjBxMGNydmRjS2Jh?=
 =?utf-8?B?NGNIWThwdG1rOXd0U0VFOHo2WWZ2K3I1by9ENm1KamVqZXNwL29YMDhzVit3?=
 =?utf-8?B?ZEQ1bjkxWll5cmFvOUt6UnZKL1M5ZnkzVXdUUkR6U3hZUUtUd0l2SDlsRmxl?=
 =?utf-8?B?Q0UramQ1TnBCVEFxSXc2dUFNcU9uRDdYd25KMUVHdzRXTnp0V2VudVhzVlAv?=
 =?utf-8?B?U3RPQkxFb09YZmE3dFNjWHBGYTNST1JSQWZIV2w1M2ZMalhsbVJjUTMyYUJQ?=
 =?utf-8?B?bS9UY3QyRTdKTG5oOGJackZOdU42dHZYMU9Qc2tZSjN5ZUNkRS9zVk5RaCtw?=
 =?utf-8?B?ZmdDUTRiaEdVY1dySlRLaUdPMmZ4NEErbzFnV3lrZkdQbEVFWmE4bDNubzQr?=
 =?utf-8?B?WEYwQnZEQmh6RXZwVkEvTTE2UTE5S0luQVNFL3JUUGtTc09UU0xYYXNnUVV2?=
 =?utf-8?B?Qk5xYlZ3bERuMHlLSVg3anpwelQxTnZLdmRmYk4xZnh0dW5HOFh5bHlYZ0VQ?=
 =?utf-8?B?TTliOWVmVjROWWhsamlqVjFNWldzRm9KRHNVSkc5NFlYaE9SSHhGd1JvMFJS?=
 =?utf-8?B?dk1QUUVJWVp6bUlzQzdiQjNRRUk0TmVacGs3RFR6Z1Fnd3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1pmNjUyNTVDVXpXd21wRmUyOEwrTHhUcHlpUThMTHJodFNUQjRsd1Jyd1dx?=
 =?utf-8?B?dzU5U1ZRQWxiN2kvekVkcnJzQ2p0dHpQc2hRekp5YjBCdThSaXNoK210eU5D?=
 =?utf-8?B?TWhqNzNCSGtsRktnQW5JSUhDQXgvcTMwNUx1d25FVm5RM2IzMmhSbGdRMXpD?=
 =?utf-8?B?OUdHVkpyakFtM01tTVI5YXJjbm5RS2ZqZllNeGlpblU2bmM5RTc4OHFUS1po?=
 =?utf-8?B?ZlgwL2FweDd5NTFzWEZpRjkzZ1gxcm54azJSVnpVNDB6STFaRFdRQ090cGdz?=
 =?utf-8?B?Nk9BUWFtVTZQNmg1bFUya3JBTVRlY3FlZDBHeHgyZ25lRmIzMWtjVWg1ci9x?=
 =?utf-8?B?NnJRK0dicThmNjNFdUYxRTJNYTJHUEFLMDczbE95b0svTi83THN0TlZackpF?=
 =?utf-8?B?MnRvdjl5RXVNaFJpemk4MURpWUlpdnlMT1pYODVad080R0J2aDJYYW5vTWQ3?=
 =?utf-8?B?VW5sb3hXbTJ0bjFWd3FXT090bEwvU1BZQXRyeUJuOVoyWldXcERrTjVPK1FX?=
 =?utf-8?B?Yld1SjN0cXp6ZHlQRmkvMHpqNjdXaGVFa2JiYUl1VlJTZUZKRDcwOTR5SjFk?=
 =?utf-8?B?THh1bk1heVFlWnNEOVZjN0FhMllBRlRFeEdGUWV1Wk5uUEJqUXdycm03aUxm?=
 =?utf-8?B?Z0hoVFZxMGlxcFZkb2hWdzgvYXZVc3FhZWk3bndVYUQwbHRlaTk3MExxelZl?=
 =?utf-8?B?VFBZV0ozZnNjUHdoa003U20rUjdSV0ZKRFoycDlZcFpRS3hydHl2Q250OFVO?=
 =?utf-8?B?TkJINTdEZE1WdDNQS3F4TnluSzBtUDVKbTlRdU1WSDlTQ1NQT3d4Zy9TQVVH?=
 =?utf-8?B?YjdjV1NNTXpVOHZFd01PU2RYVjNsSTB4Sld6RlRxM3lNcEFnVVMybzI0c3pK?=
 =?utf-8?B?OEdkVkZFalhIZlgzRm1ad2Z4Q1NOTWNpV1ZmMVpVcmVzditDZG14b0ZnUFdH?=
 =?utf-8?B?MTQ0WkNRcVVJSW1CUGR5Nlhnc1FUTkpIWlUxTVdXVnNYTVBwTStoeVR4Y1lz?=
 =?utf-8?B?RS9BRHZHZUJWdG9hNGVSWjRmMitxSk9nS05kS1ZlMFRrT1pBaVpEQi8xdlpR?=
 =?utf-8?B?RU8xWnJpeWM1clVra01MWHQ2YUpEeEdoRmltZlhGVjBUa3k0TXMweXF2RG54?=
 =?utf-8?B?K3dXbWFMTHUwanI1UkpwVUF4WTNoTWJ6YVp2ZVh0VU8xaFlpM3NJMDY4Tmti?=
 =?utf-8?B?eW1qSGhrMFBpTGFUVkpJRUh5bG9PR0JaUTVZMWt0b2c5N1ZBMVRXT2VTTkMv?=
 =?utf-8?B?eGxzbm5wb3Irdyt4L0liRS8vL2RXVVliUUNXcjVNOTdlZVd5WHRZQ21vYllj?=
 =?utf-8?B?T3pIVEhUK1RHY0NrZ1loZWExT0k5d3pnU25wZSs3NlN4ODU3aGRPa2p1QTFO?=
 =?utf-8?B?OG5WQW0xUE00WU8xaC9DS0tiZ0V4M0l5ZUoxQm82V0I5aFp0a1owL1o2eTAy?=
 =?utf-8?B?NVF3RGRPc2hlR0t4UWRCa0NCcmttcFRhQUIxY3hXNkFzaWtJZ1BmcGNqN3ln?=
 =?utf-8?B?dHJxbmtvbTBvZVVpNmRSN2V6eDMvenZiT1B4bW5uVzNwTkRaNTBNd1UvVlJK?=
 =?utf-8?B?dmRTQ1RHRFN0TzFZZ1ZDazdYRHcwWVFNZVZGaXMrRkppS1c1d1lzeC9Nd2s1?=
 =?utf-8?B?b1ZUVFZ5bFpaOFlCVTk0bGZ6NnAvQ2FodjNhZGVXbXZ3Z3VVa21NWW9hV3hQ?=
 =?utf-8?B?TjhFS0N5a3orRnhqcGk4bDBwMkJILzlEd0NTU2dwM21JY3dXSWRBRlpMb0kv?=
 =?utf-8?B?TUVXd1licTRGOEszWXFYcW9QckpabTY4WS9RNStoZDhFUU9pRXloRldxRkVP?=
 =?utf-8?B?QnM3THVQRmhoVExhMC9CUnNyTmJsL3FSb0ZLbis2WVNEK09iRTA1cGV4VStl?=
 =?utf-8?B?QjBrZ05hZ2dMRzFsQWNlaHFnU2JxQ2I0ZG9GTDFnQjkrdlcvZUhhaC9CbUFJ?=
 =?utf-8?B?WWt6aFVWWHFldEt2Z1VMbUZpeWRsMERhaUs3YVQ2NGxkZ0M5U2RTNWsrYU9h?=
 =?utf-8?B?b2ErSDVveU5iR3g2eEovUEZTWVdsOUl5VmJDN1c0Y1l3RDdvTU95TjRNRWsr?=
 =?utf-8?B?RFVWVHFsclB2RWpPWGQ5SEhxTVJ2a2hlV01xZENudDRaNjRZd0dIVUZCN0JD?=
 =?utf-8?B?alpqNHIrU21oVVREWUdzM090L0xMNnloSWJ3Qkxkd25kSWNqbVBXcGtYbXNP?=
 =?utf-8?Q?alxM3ZKe1aa+V5g+OzGSDdc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f59a3e2-9182-4f87-da13-08de222bae17
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 20:40:13.5052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OeRlGD85E282nhGKSuArWiymEfMVBrwyKrXhx+j0AKFDR1Si7PTuag2KTUFdcJXhjmoK22km1x7WLNcLFo0khJp+q6j9pMqsOc521Wm7Fs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8798

On 2025-11-12 01:30, Prakash Sangappa wrote:
[...]
> 
> The problem reproduces on a 2 socket AMD(384 cpus) bare metal system.
> It occurs soon after system boot up.  Does not reproduce on a 64cpu VM.
> 
> Managed to grep the ‘mksquashfs’ command that was executing, which  triggers the panic.
> 
> #ps -ef |grep mksquash.
> root       16614   10829  0 05:55 ?        00:00:00 mksquashfs /dev/null /var/tmp/dracut.iLs0z0/.squash-test.img -no-progress -comp xz
> 
> 

[...]

> ..
> [   65.143712] cid bitmask ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff 7fffffffffffffff
> [   65.143767] pid 16614, exec mksquashfs, maxcids 175 percpu 0 pcputhr 0, users 140 nrcpus_allwd 384
> [   65.143769] cid bitmask ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> 

It's weird that the cid bitmask is all f values (all 1). Aren't those
zeroed on mm init ?

> Followed by the panic.
> [   99.979256] watchdog: CPU114: Watchdog detected hard LOCKUP on cpu 114
> ..
[...]
> 
> As you can see, at least when it cannot find available cid’s it is in per-task mm cid mode.
> Perhaps it is taking longer to drop used cid’s? I have not delved into the mm cid management.
> Hopeful you can make out something from the above trace.
> 
> Let me know if you want me to add more tracing.

How soon is that after boot up ?

I'm starting to wonder if the num_possible_cpus() value used in
mm_cid_size() and mm_init_cid used respectively for mm allocation
and initialization may be read before it is initialized by the boot up
sequence ?

That's far fetched, but it would be good if we can double-check that
those are never called before the last call to init_cpu_possible and
set_cpu_possible().

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

