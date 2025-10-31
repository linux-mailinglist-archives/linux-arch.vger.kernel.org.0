Return-Path: <linux-arch+bounces-14447-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110BBC26D70
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 20:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF831A28068
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 19:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE01C314D01;
	Fri, 31 Oct 2025 19:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="LJs+zjj4"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020134.outbound.protection.outlook.com [52.101.189.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C765315D41;
	Fri, 31 Oct 2025 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761940391; cv=fail; b=cZUVe+eVB0S3mprjXRb2+Ll/ypwk2cQNu1Mq5tikVRZZCxFmq1IMZyrdlObdvbDwjnSIlurRM+PS7mpeTcoTk9qxTWdFHSzgw7naXbxM3bTvM7OlLYe7ghwvMqjEjNbboSobwDzKKIROc9ex8qn4UspqZK0/AzLW6ib5uTcg3XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761940391; c=relaxed/simple;
	bh=lnDOnXc6Le/ioOEPuTSZUOK2lXweGZUhoixBgeDDTKA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GtZPbpIRNmydcYHDuGS9y3rZpJe/1FOakEsQ1tx+ZrVQoWawiAiZYjv1LVxtQPWNRwlIwRBKvogGacjOUkLQgeLdo3keo3uJocow4ImOiawBDnLFZJ8T1prEyFiadem3PmJft+SAALmK7vBoOQOhmxUseOpXM/bXyk8v7hUy74c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=LJs+zjj4; arc=fail smtp.client-ip=52.101.189.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9rvSYZLIB1Rao0ROODm6I/Jm1JWN1h4eEKNyIfyH/mxtl+EJQV67CLzwTOJ06Ei4DGExSIB94mHj9onjZiQnPKLlEEV6s6R880VXH5wCIfp9UDEH25QzamYuE3M0D7wpCOnKxwh0nQXv1AarXO/z0wzJ0lvKYi1Xz39hTrzwh4GpMItYX9V5y6FOG1GeBT3QjboGoLNFZicav6EuVtYwdu7G/kkZ82ZeaQElz/r9Kly8k9Wsvdru6nygLBGvkXjVlMPu9jNRYIGozB/Z9JmkYK7MyKTDfq/6ccagmyPJs/NPb07T4hLd3nsR/Sr7ihgegDzX7GoM1+B6e9hUII9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e47vcfJBXWc0cPXw/Q/sqZ4ui5oo1pmiiYi0DD5apNY=;
 b=He8m36hcUoAD4n44j/Eib1zXl+6NIbrdaSE4+pUWweSh9nSM+i1E+q6E71oSEq4Tp/hd6WNkGCwSnWuSRoGEO1zju+Y3LEqTTJ7iGybElIM6oNGK01JgWDsrxIzrQaiu+wJftucImVluIOArgyrVyhI6SoYM1iKLErMjsME+Fkl/bIjohoXoxTIxCNF786sIq9QptSf0+oOxIPq7seemQ+5FqoxiMYByspeA5y9JCrxA8JjLtLCrQS3Ek3Hx42LSV488LO9MHGmSme9hijl1V0RoePnNskEcGh5LFM+Dq5dJs6iy2I4YcWBY8ncS62oR4Qvv6kOEKBBISgO4QYWXOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e47vcfJBXWc0cPXw/Q/sqZ4ui5oo1pmiiYi0DD5apNY=;
 b=LJs+zjj4O2pOrq/npTKZ7DgcYIG7Jl3vRDoLYUqIY3Mys157O7D+hhy27w2zm2dmGBEaYlMIFf9CD2pO+0pf5PlSXcvvbjhScbt3YxBUKzwDrF9US/+U4hv9EIp/OYwt59hpMbyzP7+KXJN9FO+/8B+RHJYuZR2Bxz5NxyU5321RXgcZYefYS9WWf3aBzNp9dnmhN0TcqQUA2AxfeDgR01bsx+6ixqrafFAs0Xg624NBXMtr6YJbJg15cHmt46cE5g1ceCCXi0u9K8q09r0wiWL9UAPaYQ+uLSeNUm7NSS/UAgRc1+VS3eIjlOozSrechD1bQKHIxesF6NQHc6R1ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB5813.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:30::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 19:53:03 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:53:03 +0000
Message-ID: <21606ff6-1dbc-4a1b-8e51-2670d4a43fc0@efficios.com>
Date: Fri, 31 Oct 2025 15:53:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 07/12] rseq: Implement syscall entry work for time
 slice extensions
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
 <20251029130403.860155882@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029130403.860155882@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0040.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::21) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fec7e9e-c995-4551-2c27-08de18b71a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnJoQ2lZWVdtR2s2WW1HcTFTQ2FyOVhDTGdZd1BwNTRWQUsxL3d2WExBZlU1?=
 =?utf-8?B?K0k2OWN3eG1ZeVRzRkVxdzF2aUlGT1FjNU80bnM1Z1dMN3BiS1pRWng4Z1ps?=
 =?utf-8?B?ODRIYllaRlNYOTZmUDdQNWJSSmZEdDZUci9Ka1JaaHNuaUhCTnYwN1ZqMUdl?=
 =?utf-8?B?VDhKNlBMQmJPcU1kN2FOSFdPSU5IcTNBS1NtOFV0SlpGdFNjYTY1RmdLNjZP?=
 =?utf-8?B?dlNENXh0Q2p1Zm84MTkyQklTMkNaMnh4QnozOGkwQmpwcFN4bzA4OWNtdExL?=
 =?utf-8?B?RkszM2hkV2l2S2VsQloySktBRzhZUjNoSHM2aEdkZ05laGh6MzVqeGh3MVpF?=
 =?utf-8?B?RlNrK2thdjk4RmFETlV2aUVjQUFZTzRaZ0cwcDZ4RFR3cTEwd1hGNVExNDJa?=
 =?utf-8?B?SEdJRWRXWmFEeHd6K3VDU0REQ2tZU3dFa2FNVUtHV2Jpa3o3dkNGMWo3YVJP?=
 =?utf-8?B?d0lhRkR5QS8xUW93YkNFOWd1WUJQYm5mKzh1bTgzOTJkMWkxZXVURmcvS2Y2?=
 =?utf-8?B?eUNFSnUvdThrdnZXOGhzVURiRFo4TUd6Yy92QWR2RzREM3YwakQxcVRlK1VT?=
 =?utf-8?B?L0JwRmNneUNQT0NIa2lzZTJZaWY1Q2gzZGphQk80N0tXc3V1VTNXK01TZi96?=
 =?utf-8?B?YUNIMXllMEVWTzlwNWZsL2JtR1c3ZFBGMThJSzNMSFRaZTJWSHM0WkZZelcy?=
 =?utf-8?B?MUdkNjU4R3pCZnY4YXU1STMwTEhlajVJcVhkbm1SUkw4REUyZDVoNWxQZ003?=
 =?utf-8?B?OStZY296KzZ4OEtySXFBbjFBTm9BMTZ0czI2U3pnZGc4c0lSd0l1eWROUHpj?=
 =?utf-8?B?TG5kK0tnbE1xYWExQkhtSzBwM2Mwc2xQUnA0aWdrc21TeWhqZi9HbXdWcTNC?=
 =?utf-8?B?dU5SOEFFYXhyaHRWMlo4allvQUNmOVVWZC93L0NLMGFHYTVHNkJhWHBuUFcx?=
 =?utf-8?B?Z0luN1lEekRGSlF2ZnMyMktrUDJYendrT24wUU5WL1k1Q0I1Y0FGakxBUVNG?=
 =?utf-8?B?azZIZ3VzQlNLUjF6U2prRjlnUXFwdW9kMGplWjMybGw2RlVuUlNBV2VGTEhG?=
 =?utf-8?B?eFBQQ0p5Y0hyZ0FoUTMwbCtkenZGQjdlbkVSZEVKd0hxNHArMVlCcy83dEM5?=
 =?utf-8?B?QXlVVS8xM25pQlRBTEQvRTFWaExNSmEwbXlUenUzVmU3VjNuc05hTThZaUtp?=
 =?utf-8?B?NFFwbHFCYkdDSXBDcU41K2tMQlVROWxPRlRmQmlpZXdSUXpLbnJvQWxaS2di?=
 =?utf-8?B?RklndHdoNkVSOUg0bk1iaEhsd0tpVVRqaS94dzhQcE9Tdkt4OWFkbGZ1a1lv?=
 =?utf-8?B?RGp3MEFpb1FqSmdOeGMvNElkK3hZMjZGZENXb1pvQUdkdFNWU3dZdDJacXVk?=
 =?utf-8?B?amtUcitna3pRR0tsdDNiampsbGNxbG03TU4xOXZieE91V1NnRjl1ck5SbUNs?=
 =?utf-8?B?RFVQWGZzNGdkMWhySGQra1JLRHZjL3BHTm5LbytZSnZGTzI3U0tYRkc2dlFF?=
 =?utf-8?B?VXNBa1B5WE94MnVpUnlHUGpNUU80WjFpRWxIM3d6TjlPSjVzRWpiTUlRRWtr?=
 =?utf-8?B?clVVcktMNWFGWlZUVmUxcVhqbDlWT3VBQ3UxcHY4NVB6TUhsN3d6VmpjTHRE?=
 =?utf-8?B?QWFZTmZtZlQwTVBPcDZSTmQvWUhBYTZVeURWWmU2S0ZkSDNLS1NxdDBiNHRW?=
 =?utf-8?B?V2VvUElrYkhMUGlOTi9ZRzRRb0FJeVdLeVBId3hWQjVFcU9iQzRUNUpvVFBk?=
 =?utf-8?B?QW40V0JwVzJJSXZkcVpuR2Rmd1hEYzdQYXg3Q1pMaU14VHNacWdndFdOeG4x?=
 =?utf-8?B?dDBmY1BZOEMrNDVxN21iRUxzSzlSTmR6WFlzdTF6SUNLdWQzWEY1RnFKTmd0?=
 =?utf-8?B?VkU4NEdlRnVEemV5TUVBWnYwdngvRUNPSFhqQmRUUXZJemc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0RtZ3lCM2JkTmgxRnJmVlA4cithaGswQjZlNm9TVXh0WFRjb29DL0VRMDdE?=
 =?utf-8?B?eStIZEQ5VVZPTkY0ZkYrQk4zNkErKzR5UmdveFFiR01FbmRYNTcvTEpHTVNw?=
 =?utf-8?B?WThNU1U0czRrSDBtSXpWTktmbk1RMEhQY09ZcFJ0cG5xU1lTbnhvdmRrait1?=
 =?utf-8?B?dDdxUlZMWWdRSU9jUERQTTBQc1VuakdNOWxWTEdUR054Z3ZZZUlocEZwdnlZ?=
 =?utf-8?B?T21OQXYyQjI3TVBQTk1hNzRBZE9OMjdHRk4vU0tDSXNmSG1PQ3NCRkdGTWtU?=
 =?utf-8?B?d28yZG5VQUNmd1R3VS9MYy9qdkh4YWZiVFpPQlFyTWxWZEdYU1BjNDE0Y0Na?=
 =?utf-8?B?REZUckdlWDIrNmtldXNMSGpLM3ZDcHFscUM2QU82SHdGUU5jYSt5NEZPNU5P?=
 =?utf-8?B?N1lKeTJYZXZzNDBKMGNndTlUSTQ5NHY1c0JsSDlVMmRvdmJqRUV6KzVYOExL?=
 =?utf-8?B?OHdWYm95bFRndzlva3FpYlZHcU1xdkpZRE55VEcwUXRrTGdzMDUvOGpxSkZX?=
 =?utf-8?B?TkgyMFNwTGw5bk9TaklFRHc0dHpOaTgzalVjR0E2TWk4R3JIMWRuanFwSlVV?=
 =?utf-8?B?WFAwZUVvTFNMNFNvZVBiTUhJUm1NK1F3ODdUeitNYklzMVVHTUM1R0tkM01L?=
 =?utf-8?B?R0Y0NHRjSDlNQjBSbDZmYjN6ZFY5eXUxb3hoeG5NUVFtUC9CTDd6eTB0VnY5?=
 =?utf-8?B?ZndsRC9BSFN6NE5CYTVsa2FxYjdqVFJwYlFqOVRweUUvWjRNUVdURG0vaHhY?=
 =?utf-8?B?ckhMVGhIdmFraVRMR3d1QUdqdm1NT3JUS3I0OE5WWk5SN3pETm5YMVgyMDNa?=
 =?utf-8?B?VlcxU3Z3Qk1EbWRVMkF6K0JXdStuR3VzUDhENTdvNlNmZVZqZU9zakZCUmR4?=
 =?utf-8?B?VitPVVI1c1hqS3VmUXRUKzhNUkxnczlSdlFlNlQya1MzTEZSclZWVWdSQ0ln?=
 =?utf-8?B?cTlzczZwT3BmNVhPWUZFRjc5bktnblZoMWRwcXFhKzYzOGlkMUh1MXAzQmFn?=
 =?utf-8?B?ckE0MTRrbFJ6UWFsaUV1a0xNTkgvWVg3SWRxaWFTd0JwUHBOc2hOZ2JMOXdC?=
 =?utf-8?B?d3BMWWtXSThldmMvaW4rcjloRktqWGcxcmJqeGc5NUU1VjNON0pxU2h5SHE5?=
 =?utf-8?B?ZkIrZmJ1dDlERFBPbkM5UVd5c0tKZDZlUlc4Y3Bia25TMmlpOHJISlU1N253?=
 =?utf-8?B?eTB0OGt4UEVWclh5Y0xhSDNSWit6OFRCY2NSUmNGYmZpWDlvRlVheENLMU00?=
 =?utf-8?B?REFKa3QrTVZxdm1qYkhxVnhMWVVrY2pLcW1iL0locDVPdEZDNFBjczhSRXc2?=
 =?utf-8?B?clIxbmRxRGpnUmRyOHBwTHM5aTFUQml2bjd4V2Mvd3VpUmpwWTJCVEkrRjh1?=
 =?utf-8?B?SEtIeFBHakE5NlpLTy95VlpjU08vQm1CZDhjVy9DdmY1MHEvWnlXS3RJbnd3?=
 =?utf-8?B?N3RVZnUxZFZHcXZ6RTNiOUR3NmJhS0ZRT3h0TVhnbkorMkJ0VWpmVDB3a1Bu?=
 =?utf-8?B?NXdnalkyM1p1bHl3LzRtSVdNSm94VTEvbHcxZkwvNDBMYWZCMUx5aHU0NUtm?=
 =?utf-8?B?N25NV2t2cGVlT2RRQ0pZclE3TzJxaGdrY2ZNUTRrNzA2Sm1zWFAzZGl3aXh6?=
 =?utf-8?B?dXRUTzZmOTZRanNlYVlYM2NiWlMrckR3RHZqQlBFQ0prV1FJT0d0a2FNaXJp?=
 =?utf-8?B?aFhuQkRITHM3VnFBZ3JHMFk1RE5rbys4a0ZjeWNIUnhiNFROMkhjS0tIL0RM?=
 =?utf-8?B?SXhEdkhsTzhYOGJ5d1hHZWE2OFlRMFlrNmNRSmFLNGlqMEZsVmhheEdPSnV3?=
 =?utf-8?B?djVDR3VQdVg2dUpXOFZWR3hUN3RMK2pZdjE1b0FtMWRCTEMyRFpqVWs0cklV?=
 =?utf-8?B?OURjUkRrRk1BeWltRVU5Z25paWhYUnA0ZUgwaHBsYzFneDJlNGYyMlVMVUd1?=
 =?utf-8?B?TG80YTVpS1lHVnQyK0Nvb2hnZ1pXTGs5ZkZKUEFmdmRyb1Z4d0FHQlVrOCsx?=
 =?utf-8?B?Mm1UeWRObXRsMzhQb09XV1RoTFhFV1JUT0grZ0dHbDRvM0p5UXd1WlNIZnRa?=
 =?utf-8?B?NWdZMnZZVlNRMXlRanlSY0RUQXZET2tOdUsrMm1UVExlMTFQL1U1YlBpdE9I?=
 =?utf-8?B?SlRzOXZWS2ttMnRHaVoyTENiY0R3MWEyWEoxMnJoYmFMS2FYZmlpZ3BkV2pM?=
 =?utf-8?Q?tB4BTS5Aw1vd6LrMSsSn+0o=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fec7e9e-c995-4551-2c27-08de18b71a21
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:53:03.0976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IMIgtYQE6yR3VKh7TA+D0Aciao6L245fIwf5It4op4ruw9Iwl6Nbg36YP2qcpCUJnUvW1CXTjk80hl0tlrKWZjqZ4BJ8IK8zJIoYdQA1go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5813

On 2025-10-29 09:22, Thomas Gleixner wrote:
> The kernel sets SYSCALL_WORK_RSEQ_SLICE when it grants a time slice
> extension. This allows to handle the rseq_slice_yield() syscall, which is
> used by user space to relinquish the CPU after finishing the critical
> section for which it requested an extension.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

