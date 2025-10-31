Return-Path: <linux-arch+bounces-14444-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AB1C26CFB
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 20:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06D3A4E51EB
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 19:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA4D30147F;
	Fri, 31 Oct 2025 19:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="L67JYJk0"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020117.outbound.protection.outlook.com [52.101.189.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B572B2D47E6;
	Fri, 31 Oct 2025 19:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939830; cv=fail; b=X1vaGgfkrZ66/o2Rhga8nQqJ0IzhKDSnmjpnGRNJSRi92DzTUzoiu/XTX/NDP5AByuYCj83RhJD+mOWQSSy8iwi9bdga9jtytQ6mbbpMfmFDBVBtruVYUYmIN7RmT1OslsHc0yKMCiPoYTnDPTW+KK1LwjGaLDY1NYYyadqIacw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939830; c=relaxed/simple;
	bh=2UBgPg8eNnI2xk3HYAwwXhDO5rElsiQzDIzyvoBlm1I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XGyhoSiXldFC5OfXvqwgIoRauPG6kGWpzvf8hKysBSalPQ42QGmhTOhFMM06zOs1GWGcl6xs+qcX10QMNvRaM3W1cW8OR2hw4q9uW8Hhwd7sN91PsI90Gvofx4xILNJ834f8zvipAreCEl4NjCBAdmAcVOAVVUz1PI5oSfKCL3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=L67JYJk0; arc=fail smtp.client-ip=52.101.189.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AloO4/HTGUJmMbhnGEDqCDSBWgIoVYjkl8RkCeJpYR/7f+YxDUNnLbJlVprF3YfDiiO8OKn8nbl1O4rDuD44wt60wBeWQkbo2ZVFLkVKI/nUqdq4O/CEpeKsrilQBvYTT88P6D5ogji1JGOQGcWpQgVKGjyC1DpQLXrs8vx5XxzWnqqJnR3iPY5N03twSHvrzh5MiVH5cUDh3KYebeWy/P5pIRS36EWRRcaoKvbYb1MXvaNUR8sVbbDmxUnS8IOTeQv9C+XJiC/P/P8NhIW4jVHw6FjCU79t+xPlyBAbhSmYrbE32sisIxWTdk0l4dJWbQtaxPSme3NWzNHnjB0qtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6H670EXTBYXvSVbdBms8hBtxKzq8sHnWxxDOh14GTc=;
 b=yYd+N6ULTDCLWlJAbDLb4KX0M+JS+Vn9bMPdRTcCow5VCDw0nrcaPvoYL70vj3eMjzfmlqshUrOEUl8fzMEm02mm70FgTQzEdF+Ge4un6EwsUva7TBIFI8UbhRG/MQY2XavvBpiqxJ0/25INrxxWVecfnasvH1/w0yvMIliZpSSO2tVDEIGeBu8EnVNPY4SUJs28Vcw9EXoi3drgrhTvMJoPW502RAJZTMPXCl6XOObzKTeq9G9hRl6q3BvydMWr6KnMmFNxG1XRaGHCkTbaZxP8be0J8Y3efknHK+ghR1ACU9vEjLwaEg2O73a6AlV2Wd/IZuUkwH1QTKUTnbCKnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6H670EXTBYXvSVbdBms8hBtxKzq8sHnWxxDOh14GTc=;
 b=L67JYJk0qe5t9TlbZg1SR+vVcmHvUyKHpIESel5yerXf8Y2KEau6WDQqRkgFgC+Qe92nbBNVB4knTsm9SP/fCo8TpNNLMSSUh8rP6/8oJWKM8ahsedJiIeACVS+hCF2FncbHwWeR5EgQRfsCWg4Bnx7QPY9UEI+pyfWJ0Hv0lx//Q6r8PZJ9OS1H94mYXJ81lQNf+UigdHe8UJTmUsHg3yMrpwInQeFpea9DT3RW69T2yPk23CGt+CGJfpcfoWuXt0rMK3U5Hi4mRSnLYA2Mzc8xg5BtcqPY5vwJpo8KvPlpDdgdXmPNk51M6AkFhb5iBZ9dzTJ1KtfsptoZXm8rmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB8432.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:57::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 19:43:42 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:43:42 +0000
Message-ID: <68bafe10-23db-4885-b4d7-7d8126da76d7@efficios.com>
Date: Fri, 31 Oct 2025 15:43:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 05/12] rseq: Add prctl() to enable time slice
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
 <20251029130403.733465222@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029130403.733465222@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0410.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::16) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c25b20-5f8f-4a68-50ca-08de18b5cc06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkgvYkxZZ3B3YU10UVVMN2JMSktsaU4zWEtWeXBmSnZERGRkSmZ5VkxMcFg3?=
 =?utf-8?B?QVRFRmdPaXNHbFV3VTlrdzNNN3YzSnhIZzJmSm5Sb3NYQzRBSy9CN09sMjNF?=
 =?utf-8?B?RGVZMk9VU243Q1VTT2t2cFRod0NaQjZYOVlBN1FDQ2tvQjBBYmVaeXEyV3g2?=
 =?utf-8?B?eXIrWlJ2YXNkMi91U21aOTc2RWgraFBCM2dMblhKOFlEMmhvcFl2L0JWS1dj?=
 =?utf-8?B?VWZISFZUQmxXTWY1SldPakFuaU1WVHhLS1dyak5GYWN6YmpLYXF4cktEN1RP?=
 =?utf-8?B?RjJKRzFwQkV5bEt4LzloOHN4MjFpYjhROWo5N3VndkRJY3ZUeFpGZklpWTRs?=
 =?utf-8?B?SDNjMGZsYklHQlF3cGxSVXpkdlpaUmttbWpmeEdxMm1LUTIyOXl5dmRSdnF3?=
 =?utf-8?B?TnJtR1RhV0JUNFc1UjFTdXNPZzc0VTVTTU5wMmFDVkoyUnhMV1A4c1g1anRu?=
 =?utf-8?B?S0NmUWpkUUkzYzNEbXlVUGtlZFlBdWV4R1ZveG0vQXgrYmdOeGdCc0cwUndZ?=
 =?utf-8?B?QUJRWDdjMVRpamprTDNRL1gxK2FNOEtoZWx6d3ExdUgxTTVQdVcwWHVGR3E4?=
 =?utf-8?B?MTdad1Q4RllibndtV3BXT2xxMlU0QXo1a3JGZTl2UlJLUVJHeWY4QjlqdjlF?=
 =?utf-8?B?cjRyZVJVS09BNitFU05HS3pidmtTd1NIdTNKeTg1Njdkb2hxWFVhVUZac0FS?=
 =?utf-8?B?Q1NocytQYklJRHovbXVsY2d4d2lremRsc2F6WU5MK29ibE1kVkpOQjhHUkpB?=
 =?utf-8?B?R3VrckMrMWd0VmNGeFEyamRoSHhreld6bjBhUTEzdUUxc2x2RER3bUVmMzhX?=
 =?utf-8?B?MmVTUC92Q0Jya2pWdVd5Uk1Vb3l3dzVNKzcvaVVPSjAzNEloZkU4Zyt2YzJi?=
 =?utf-8?B?eUl1alc0LzdZT3N4K1FOSHM3TjVMTWRQMzFYQW03ME9nbnNxbHdITEppSEI3?=
 =?utf-8?B?OGx1T0pZcndsakhwYklTR0lkamZjWDV3WnNDUjc1SDRvNWhXU3NtZ1dzNnYw?=
 =?utf-8?B?WUFWOW5tRjNtR2pQeFZYWHZ5OW45bFhVM29IQ3hxRkx5QWJKTzhzK2JZNWlS?=
 =?utf-8?B?aHcyRlZINnlKMTltVG5XeUljcWRUdFdhWDRXcU01SVJnVkZPTlR6ZTF5anJU?=
 =?utf-8?B?YWVvbnpFdkduanJuSFhHZnM1d2lPYVlhcklDYno0ZVJvTnB4SzVMSHVzd25j?=
 =?utf-8?B?cFR5MlpieDdqUUg0Z3Vpd1MrcytOakNva0U4amM1MGl2Qy9pNXVVRUthYU1a?=
 =?utf-8?B?aEg3Z0tsZ0YwbkduUkViMEhoQzJiWG5kUUVZMmZ2eGRtSVltS3FDYVQycDRl?=
 =?utf-8?B?QWxhTFBHZ011U0tDR3JzTDlFOG5QaTUrcWVSZ0NZYnErM0x2bXl1SjBUUUIr?=
 =?utf-8?B?U1RwcGViVm4rWUlPSHVJSmExcXRUUjN6TmFQSXJlS3dQWFFhRTROSnBiR1pr?=
 =?utf-8?B?VzBYRmpEWWpLZTZnM0VSZHEyckhPRXJJV3R3Rk1iNWNNdFlIKzF1OVRkQmR5?=
 =?utf-8?B?dUhWa1g1Rkh3MjUxMmNHb1AxL1QxaW5xUEk3Tm9iQ1FNa1VXQjQ0MVRacTJa?=
 =?utf-8?B?Wlh0enQzM0wzZG50bzNFQkdBTWU4QjBTRGJ0dEZiUXRObTkyYkFhajl0MlZx?=
 =?utf-8?B?TUJuRjBTTi9sUWhVYWRMTVZvdlJnQVBWdU1Eam5HKzZPajNQMW9sYzZiTjlj?=
 =?utf-8?B?clgvVWtmLzc2Z2dzQ0Z6UWt4L1NlbXExVllETEhrcmxpL1NGaE1ObTZQYUd0?=
 =?utf-8?B?b3c5ZkJwazBiVHNJS3N2dEhTSkIwVVlhdVVCN09kTFE5ZkJSM2hkSC85MHdD?=
 =?utf-8?B?REZOaUNJZENwZzBiMmNyQTl3S2V3bitKVmEvNmUxazBBNWY1eWF1bXVoTXF2?=
 =?utf-8?B?SEFQaERPVm1zOWkvbmEyekZLMGdWTjI4ODFFQk1IWlVaSkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0thU3RvVGRMbFlMbEYxZXliR1oxZERJeUlVb2F1dkFneHRmMlE3bTgwOFpk?=
 =?utf-8?B?TlVGUGNvTW9yQmdwZlE5Y2tOWktFd1pwZmJ0cDFVTWJBV3Nzc1dNdU1qd1NB?=
 =?utf-8?B?VFNyMTBHeEpncVlXSjNvUDMzNVdQL3psZUNQMElqZWxXWEFaa1JNeDRUN1gy?=
 =?utf-8?B?SVUrNVh0TGRJbWFWcW5IbitSb2ttM1U3OFFoNGl2cW52L3UwbncwYzRLZW0z?=
 =?utf-8?B?WmNzbXFsMzIwTGxEVmdtOVhHTk5TekE1OTVWczdnTXFObHpDM2pibFJoRWxa?=
 =?utf-8?B?VkdBTGVUL3dLZzV4RlNQV2J6MC8zK0JWWDdzUEJFb2F6UVdtNjgyQ0R6emRM?=
 =?utf-8?B?UVpwcnFOQkF5N25sRjY3MDJTbkpQdDNPTUdoYXAvZUNLQmxJeSsxTVZzRE1C?=
 =?utf-8?B?SVAwQTVnMU9sM0p4bzJLdVdUZ1g2NkMzVU92NGk2bm1rODlKWGlFUFEzQ1VU?=
 =?utf-8?B?RWJGUDdIV0R1enFMcStpMXNmcEF5aHpvQmt5ZWVpTXdmeFc4TXBZdTVyUG1v?=
 =?utf-8?B?VFdhYnRTN205ZkdyYktIZ3hjVUxqck1CdE1WNjhMcHVhUStHQkpiaWsvUFJ1?=
 =?utf-8?B?L29kWWs5elhmSTNlV1FLdE5Va3RWd2ZWWmxOck9zMHV1Zy83QmNuaDJoZG5U?=
 =?utf-8?B?U2puNUVpWmJLOGlQUXQrQlBWL0NNaWNKTFQ4eVVFUExjRUF3anFQQmZhY0ov?=
 =?utf-8?B?U3JTOUVEaDN5YVdybTdZd2V5RlJYNlVQRWdvaEFoSmtCWGNDcnlwblRFZDln?=
 =?utf-8?B?TUZlbWczOTk1YW8xZkt0OXlrcHlEMS8zclpRb0w3MlRpZFd3c0U1QzBVcTl4?=
 =?utf-8?B?ZTRnUzdDd1RHUVNRenRQYUJZSXRZUTA3WENzV3RDK3hlaklJcnl6SlVweDN2?=
 =?utf-8?B?bE5oaTJKQlVPcDFjVWxsdWdZZ1R0bmZicEJxY1NleERLWWhmQ2YrdUJQT0hj?=
 =?utf-8?B?R0VwK2RrZDRRN1VybERBZVVDbnNFSTVqbnZjZzFVcU5DdTdvMUxXTFpBdHB4?=
 =?utf-8?B?WVpiYnM0SG14SHZiRmwyTVNvUlpaTHVOTHZqVHlHTEh1emo3Z1dxenBVK0lS?=
 =?utf-8?B?OWpkYzNxcVpQN0tVQWpnb2dsVXNYTlBvUGJRSWRDUkc4cFlrMTRacEN0cEJ3?=
 =?utf-8?B?T1UwbmVXRmttZEs2dDdnaUdSZXdmcDhpWWwzU0RXZFVMY0xpdWc5RnNHNEx5?=
 =?utf-8?B?dUhvblhnd3VQTFRJWG91bzN6dGg1QmdhRXRWa2tQZ0pyd2IxYmgvaWpCZFlX?=
 =?utf-8?B?NjQ1cGxMc2ZyUFdaSUlORUNkSHNzNjN5VHZOYW9jKzVQUUVraVZTMFkzd2RP?=
 =?utf-8?B?Um0xZml6UXVJWkkwcWtKcnNjMFdZcnhDUHN0LzRpeExibGlUWi9vMlUrTE4w?=
 =?utf-8?B?TGV6aGR5YWZ5Q1pEbDZDbEhXZGtKelRUYTNRR1ZTaHVKYklCQ1FXUG02a25t?=
 =?utf-8?B?aW1qZ1pOZFBJSkV0L21UR0hxZ3ZNMEw5N3VFSFdFa0lJcnVHT3FMTDl1Wkd4?=
 =?utf-8?B?NzBVVlgvSVhvMHkycm5vUFAzcEVRMlNRUEFJdUU3Q2xmeWNqOEFJUkdLazZp?=
 =?utf-8?B?OUIxZzNMWmRZVkxzVmZnYVgxL3NrR2pRSDUzZXpKMnVtem1VTnRaWm5YMUJl?=
 =?utf-8?B?Z3hXbUN4a2dqYXlXdjJma3I4QndDYnRleWNBOXo3ZUg2M0ZrSjlLOHlhNFhB?=
 =?utf-8?B?cHNmREE3bmxSZ2pHMCtZZmhhNFZwREYwYUZ3VGxZVEorZHRDRncyc3R0NDB1?=
 =?utf-8?B?bDFvc0N0TDV4OEtucmpKSTV5UXNLaW5haFp6MUJGSS9WVVA0OVR3NWxHMlRh?=
 =?utf-8?B?M3lnakNrYS9md1FWNmIrTDdOWEVvQnV1R3dLbE9maGlLcitKSUI4MmlxbUd5?=
 =?utf-8?B?MXNPOW5pUVV3UXNSZkdaa2NUZFdZRWxVMUkxNnp6ZjdPSTFsRUlkNm1EQjFO?=
 =?utf-8?B?cHdWZUg5eGNYNXB1bXRnK2dmaE5JNXZ0ZE5BVWR4eEdFZk5tb3lTSHNwOEM1?=
 =?utf-8?B?RTlvV1pNYUQwZ3BVa0MwRHozWDNTakYvdmNxK3NuQ2ZqZTlxSjVJNnBLMTBG?=
 =?utf-8?B?VzQ3TDdLeHNmT1ZFRkZnUndUMnQ2M1VGM2FaejdhbnNUMkNZK3VwMWNBZDZ1?=
 =?utf-8?B?Zy9tcVBLWE1iTVBKZHJIUmFBekRpdklqTmV5d3lsQVpIbDc1dFpLUzhLckY4?=
 =?utf-8?Q?dGeO6ITaw6uMUA3wi+mzEKg=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c25b20-5f8f-4a68-50ca-08de18b5cc06
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:43:42.6041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MiGHVrn5N9o+cvPDHUZUj1ufpu4Acd6CyEBlJwYDwCUG4ms6l4zxq7B1y5SwEHBu50y6Y5nNN8vbeE+DPOI+FxmTZTJ1Zzm03bvI3O20C3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8432

On 2025-10-29 09:22, Thomas Gleixner wrote:
> Implement a prctl() so that tasks can enable the time slice extension
> mechanism. This fails, when time slice extensions are disabled at compile
> time or on the kernel command line and when no rseq pointer is registered
> in the kernel.

I'm still unsure that going for enabling per-thread vs per-process is
the right approach. Enabling per-thread requires to either modify each
thread's startup code, or integrate this into libc's thread startup.

Enabling per-process makes it easy to invoke from program or library
constructor.

[...]

>   
> +int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3)
> +{

[...]

> +	case PR_RSEQ_SLICE_EXTENSION_SET: {
> +		u32 rflags, valid = RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
> +		bool enable = !!(arg3 & PR_RSEQ_SLICE_EXT_ENABLE);
> +
> +		if (arg3 & ~PR_RSEQ_SLICE_EXT_ENABLE)
> +			return -EINVAL;
> +		if (!rseq_slice_extension_enabled())
> +			return -ENOTSUPP;
> +		if (!current->rseq.usrptr)
> +			return -ENXIO;
> +

So what happens if we have an (unlikely) scenario of:

- thread startup
- thread registration to rseq
- prctl PR_RSEQ_SLICE_EXTENSION_SET
- rseq unregistration
- rseq registration
--> What's the status of slice extension here ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

