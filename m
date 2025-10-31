Return-Path: <linux-arch+bounces-14448-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E386C26D9E
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 20:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 965713517F2
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 19:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F4D3101B4;
	Fri, 31 Oct 2025 19:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="K3Y8dXur"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020123.outbound.protection.outlook.com [52.101.189.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6167E1F130A;
	Fri, 31 Oct 2025 19:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761940771; cv=fail; b=rz3C4pPWVpaV+GS2aGx+WtFSAcH9DyHYsOrbEFrXmXIdkWNlOKmn/wflnK2DTNo12F6qxXtxIrrzcYGvFUALk7bVBowph242SPBbWf5C9OUKT4I9ocbyegLwPy95Tg54E3NVIhFdbwOETgYY8aDuZsb09ySdToMT6W1ASBYhnC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761940771; c=relaxed/simple;
	bh=It8gm8I2ba249rzFAOIMqXXHlfyzqmlrNsM+d1q9zn4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p+XfkCDCtR/1QqRNMqHsPBvzDaDQPceVcTSra34S5c+SlVAmuuEmLI9909zQFo9wc434K9bNwbVq9+3b+5/NvwqeP1X8Fek3CPbiCpul7r0GzF+IsXCgdQZiCe8OWVSX3Q2IeibGUSkKt8tidR3WTeEHfz/uPmgXPkaLe/4+xxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=K3Y8dXur; arc=fail smtp.client-ip=52.101.189.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRRh/YCBd31j7dYdHyNWpPE9ocFugZZ6txiLWLwg+ZCC/P9scV+j73n/HNKmo9DOBiRyXT6l55IeMC2TVYL4KFjDQaH01KfPLnvU78Zw1iO6+h6goNtdbd7STJyKi5yT7bj1jrHc4iY+9gzzzn3H3vrxZcpOW0RvaG59OkQQAMQ3i/mcmmcreIpTahidHnFUTS1qN3QKxZeuhNW71+9KiW4yyQEnEBatb2MwgVtcNItrDUq7i21SCpXmMEmbjPruDvnQxP9G2jjfg7V33gBytsYgg81qtz8C3JX5fBMpHgd7mjA8teJHaQkl7sG4FsMBwS+rGZjOup2CgMjFMK9SlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+R5fpTGiNW0gq3AC/1UUz3+gisvlgUQbeltDLqqql4o=;
 b=cEfH0bSA0BmfI7Kg6Y2RDI2fZtLHErJDkt9eUN8fFLYy/obYLSk+JTIkXVuJSxTa8b0wXGBmMawzvB1TjRu9VAMpb0JQi3wJWKjYo2oVFrWoFlyOhzp3a2gg1FMQPW9aP3cLMNynfqnwviDyYXnPhAZzBIaUJgW71xuwcIqVFYjrFGyxBjE96FS58V64OEiH2wv7vbwx7TmN4Mk2+WefNNQhVeX0tMKvjOFSnd+L2JOvMn7QhNtISWEjBzs5UFd83KleRqwTo0ReZNTzFQQc1PJ6gD9gSpW6yQhzO9DcH+fONza+aT/6C9jyDy1zqLwmfbfZvCNJ9CaT43fe+y6V0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+R5fpTGiNW0gq3AC/1UUz3+gisvlgUQbeltDLqqql4o=;
 b=K3Y8dXurcBSRzn873jeL5VnEbvP9cchrd+vBUKiPrZ7P5FBwpGQLrn8cmtoevA+iro8GD7yIlGhyC3hBf19SU+4NKegwm2d8K+8iAQVj6xd3piiy4gxtuWKy7gMfYBNrgBAxRN1lQQ7mi/ElV2ku8/NtL/yxbP37NTMc1fxeRTp7dAZ5F44uYSjjtOqQEPM6Ug2EVKknw2L5GsoNrtbMeGpnDiOGqFg0s0uyxb/wS+0E1WWrn2SI9MPFUH6bFhnE3TXMhydMnHlMvexD5Dgrc8UbBeBssxOIxNczMxF1BfWaTUGRBUDfwFLnSkWEqCLk1lIZXfur9XnNim9FHjr6ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB5813.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:30::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 19:59:28 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:59:27 +0000
Message-ID: <b2119e7a-fd82-47ab-b0ae-87fd30a368b1@efficios.com>
Date: Fri, 31 Oct 2025 15:59:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 08/12] rseq: Implement time slice extension enforcement
 timer
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
 <20251029130403.923191772@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029130403.923191772@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::20) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b00e59-c9a3-4fbe-516a-08de18b7ff4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUFyeW5qU0k5QmlpRkFTcytFODJNUll3TUZqekZTTlpUcjY5bkx0czdjMWh5?=
 =?utf-8?B?VEhWekZGNkR1b01aR3V1WUNmcHRuZ3VQMUhYbXZzZjVHcDA2TW42L2pnNHV3?=
 =?utf-8?B?YVlqOXkwY1NlejJNbWNEOXlMbUZ4T2NTc2YwK3FVeXBOQkEvbFdhSTNFbyto?=
 =?utf-8?B?b2JXU0NmQTQ4bHRrNUVPVXgrZXN3R3FXb2I1QlJpMHNNdTh4ckdiY0EwajFi?=
 =?utf-8?B?Rmc2cVR4Z3dMWmpLRHNpbkl4K2dMUmlxZjBjK25PM2ZqRitxTkU1Z2VmSCtx?=
 =?utf-8?B?RU1LdkNZNnJlVXkzUU10ZHFpVTJ3MGN1b05jWWoyRFBxNERpYzh6L1luSFJx?=
 =?utf-8?B?Mldla2pXOVZhaTFiS281LzY1T2JJcE1DckkyVCtPNjhqZ25vOFlPa2ZCZlRS?=
 =?utf-8?B?TkdRVVp1RmE0WFFGV3BHQlhVZ2FLUnRJZGtEa2tyc29vOUZ5dUVhb0ZqakRi?=
 =?utf-8?B?cWpxQmorMzM4WHl2a1h2SDZTUEx5b1FkaE54RUlGa2JGUXp3OEtzMUU1V1Bl?=
 =?utf-8?B?SzdtcHF6MDlBQlREeVhkK095cHAvWUhBRXJ6MXRzRStFcE1uODRDSUs4azNK?=
 =?utf-8?B?MmlhVDRva3VNREo5VVZWRjYydDMySXJCTHg1NlZKS1RybEdXVEx4c05RRTBr?=
 =?utf-8?B?dTROM2p0UlpxUnQ2N29OVzE5cTZHNkRHbExYcWV2b0tZbDk0cGFXUVU3Q3hH?=
 =?utf-8?B?bHpYRDZWeUJvZFB5ZXdGbitJUnZzeUJhaW9PZVJRUWR4VFVXbVZQSVNPYnZi?=
 =?utf-8?B?SERmR2JRYWpJUStNc3Rnb2xCUk5mTUI3RWZqSmNZSHlVVVhveVBZdXZpSG96?=
 =?utf-8?B?T0NBd2FIeUtkMFl4TnVmMHQrQnVoZmpaVU5ZSFBsWXNxSVEyM2N2UkJ2RlJE?=
 =?utf-8?B?dk5SR2lLSHA5SlM5YU9QTmhhdjRqMGVSWGN3ZnNXU2sxcXFDSjVoTkUreSt0?=
 =?utf-8?B?a3hpT2FFMWM4RFRoSzh3MmxmaHRVMnVhS2Z2MUpmc0dPMmpVMkR5b3FpQXJa?=
 =?utf-8?B?T3RPYUtvazRoVUtWeVg1d0N1YTZqbElTRG5EMmgrZGZUWUs4VXFuOUN6SnZi?=
 =?utf-8?B?bDdhYzdqYy8rTHpUQlVqVjBlTFFGUTNCcVJwaVdwM2VVaWxuVnBVb2JNTmRK?=
 =?utf-8?B?WGMwSGtVM0VEbnh4cXNKVzdZREFhZFpqMDFROFZRU05MUzdOb09DWXJUbjgw?=
 =?utf-8?B?K0FaL05UMlcyRGg2Vzd2U1pwZC84TzM4and1eG9nOUFTejdLVWpHTjhSbUUx?=
 =?utf-8?B?dkxaMVkvMzNCYS9xZWhvM210ck1YL3hlVnRMSnlOTkQvc250QkZGaHBnMXpH?=
 =?utf-8?B?Vm85YnBZQ09GaDhoNnZoV1Q2TW5NMFptM25wakZIN3BVbXZFZEg3eVMvM3k0?=
 =?utf-8?B?N0x5dkVmZHlJZ0NoTWgvbUllUDdFejllQTJBVmZTRW5lb093Y0poZXN2YVYz?=
 =?utf-8?B?WVVXVzdpUG05TytQYlZldXhSWGMyWkNBTkZNT2YvaGJFVkdKcEJnYXZUSmM5?=
 =?utf-8?B?ckhwTHVhQTZIMEhaM1M5VXUxT0JkOFFaYkx3YWg3dERFaFVySEsrcmtqOS9m?=
 =?utf-8?B?V1NiMXdGbGs3R3hSSFRQZXVhNkVZaHplQUJ4UG5sK3ptV3VXaWhibFpDV0hV?=
 =?utf-8?B?MmFRUE15RmM5cEJXVUtWeHFFUFZFQzBVdWpiY20rNTBQUk1Rb2ZhbWxQVEdO?=
 =?utf-8?B?L2dwSzYvYmJySkRPeTZPSy9iemExSkhna3h1a3J0QXg4QVBZYWpvSHg3N3hS?=
 =?utf-8?B?R3o0QTZ3eGMvTGduRHRMZnFVSyt4SWNyWHJxNkJiU0RQekdhV1BZVFRDOHFi?=
 =?utf-8?B?ZjR6d1VzZVVxdjJ2SlZLSXFkLzJrcTZRRitIVGFOa0lyMFB1Ty9oL1E3bllP?=
 =?utf-8?Q?UztQDVhJIDJbV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3Q3QWxGM2dPMW1WcTBmWnZ0dUlQNEdMM3crQnEwL0pwRSt3NXVuallZUXdn?=
 =?utf-8?B?RkwxTjM5c1RBUllicUxZanJTQ2lXTnVHcWlzdFBuK3NkcDZuQWZ3S0pDVmti?=
 =?utf-8?B?cjE5SWNURHJjT0ZZL1RtLy9uWnNucTJBekh3M0xFTjVlOCtlTnBFTFhSUzhJ?=
 =?utf-8?B?NWZYN05rTXhMWU1DNWFqR0EzbE1vMEdCUzVoVmN1Kzd5WWM4R1dYeHB3SzVK?=
 =?utf-8?B?UmsvUjFEUThuUzJjYms4eEZ1cFRKM0pUNU0veEh2d3R1VnNPbU45RlF6SW9a?=
 =?utf-8?B?alpYQTdvNWVlOEhucEFWMnl0ZjM4dU1GNFNHZEthU3ZPVDF3Y2hhSVlZbm9p?=
 =?utf-8?B?bTVMajQwMGcrYmlxWHpyamdCZGtrSG55endTWDdobFRRbmQwdkZhRmVxemMv?=
 =?utf-8?B?bFFvcmxWLzZWWWpGK0RldVdBNFp1UWRWeU81RDRHV1ZyRnRTejEzVUt3MFRF?=
 =?utf-8?B?eU1samQ5OWFJWVpsTnlvVVFPTlNhR3h0QWZrcmpYSEpYMXN1akgxSWp5dVVo?=
 =?utf-8?B?ZmRSY24rck45eGF2Nk5zODVnUkJ6azhVcWI0QUdhZFV2TmJma0lqTG0ybzdh?=
 =?utf-8?B?SjZJUkVJTi9PYXo4Wkw3U000K2plMTR0ek1NdWlVVGNLNFB1T3Aram1UMHdI?=
 =?utf-8?B?NG9jNDNNZk5IV3FUOEhrbkg4Y2VSdlhsQlV1akZaSkVrdlQ2OWdLOWhQRDEy?=
 =?utf-8?B?dXB6RDM0NVNZbnVKb3B6ckprN2FoK2hKcUxHZWdxaE1Oa09abDRDVDJWMzhM?=
 =?utf-8?B?djFsVlJ3cERPSVErcnZnMjduQU1qeTdrTFVLQmdFVXdPN21oSksvNFB2VGRC?=
 =?utf-8?B?ck1GSERyN1hLUUNqZ0pHdTR1amNGczh6U0FOZ2lzWS9DQXZSMmdVZndwM21I?=
 =?utf-8?B?N2dXWlNKUE10OThlTFlFeVRFNEIyYWVId2ltT3pWYWdkamt6NXcwQ2c2ODhl?=
 =?utf-8?B?UjMrVlZ3anhBMEF1U0ZySlVEaVBLQi8rb1p1WmhJMVhMSVhSUDUySjBIQ1BW?=
 =?utf-8?B?ZzdrRU12UVFveW1uY0tPRXE1K3N0dHdmaG93TXNIbXY2OWE0dWd6bk5mWW9a?=
 =?utf-8?B?Q0FjaWRsT1FkZkd0MktiSmRQMDNIaHY3MU9BaGdWbjB3aklyYjhZMDZ3R1d5?=
 =?utf-8?B?bmhrdkk1UW5hRVV5R3gvZGdQUWExYWNhcGFpVks3MTJrVlJjYWxqV084Tjkx?=
 =?utf-8?B?UXkxQWdIS1Mxdis2ZEpqS3lrdUFzN1pMWkJkTUYzSzlZZ0REUGliZk9QUWR3?=
 =?utf-8?B?OEliUFF1aDNoeVNYN2pudFdQMU5zZ0xGcklHT3AwRzlOalNJQWkvNFVTRWdU?=
 =?utf-8?B?UXVjZHhmZ2l2SnZlbUxna0k3eUMxUXdYbkl4c25rTXZ5UWoxTTRBcXM3U3dO?=
 =?utf-8?B?aDZzblQvUlQyRHRKOGpLR3BWSTRjOTJRdHM3RnNZcFo5aWJQaGI4SHVzZ1V0?=
 =?utf-8?B?aHVxL2ZycDF2dDdrQVpUN3hjcFJzcWxqYWFDNXZVTjFEV1U1RmthNTgwU1VC?=
 =?utf-8?B?Qzh2QlNxRnU1Wi9lYXlaUkwxZXd4M1MvT2xFVFlZQ21TbkVzb3pCaFU0V0lV?=
 =?utf-8?B?cUhydU5qdmtMRVY2dWlwKy82U285L3lJZEExVWFHaVVmc3hTYytOT09lZ1Rw?=
 =?utf-8?B?cWhWUzRxTjE2SWw4Q3dKTGVOaTFLekJsTG1sS2w3Q3JSYVhGcFgzUU5HMXpo?=
 =?utf-8?B?Q2J2TmdXb1BXTHlFaVdXaHBJWUFLSEJKVDVNVWc5aGJJQWJoMDV3VzdTencr?=
 =?utf-8?B?K2pmVWR1b2ZNTU92K215bXQ3eXUwSUN5UjFVYm9WSmxaSnVNU1NHWXJ4TEF2?=
 =?utf-8?B?Z1NDcGorZ3hCKzd3MWx1ckluMVVtV09nanBiUlE2RENNWU5rRXN1c0VFTEJk?=
 =?utf-8?B?WGtwOFlldmRGUDk1b1dOaHZtSDZGNlY2Q1ZIUVA3ellRbXVwbjFuUE8vLzR4?=
 =?utf-8?B?T2gzNlZ6OCtWWkxFMExVdXZUYmhPYVZMOGVlTUxTRjNLUEE4eE9JN09pcUVp?=
 =?utf-8?B?MitRZXNVSnJiMVprdHk0QXdyaTNtZjlzZXlvZHpBNXJxMmpQNmxrODBoMmxI?=
 =?utf-8?B?aFFVZjk0S253bGh5Um95bDZSLzNoYUxVdlprUWZnaWw4YktOV2gvdlZySEtp?=
 =?utf-8?B?NjdkTW9XeDVFVG5aNU14MjZCdGNQWmlqTXNKemRiQ2ZmZytqMy93ZFhZcTJw?=
 =?utf-8?Q?Mpgrn2IqwjKfCxHbq2gU2EE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b00e59-c9a3-4fbe-516a-08de18b7ff4f
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:59:27.6502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxXK8cTBvYU5MoxwPuzDNaegd3ydMJ/qNW/xXjquoA53jZPM19VsPX88NIQjYqWUC9M9Eiv7eYGA6Yiwdz+NxHJOSzF7jIUV3vNCw2UKGrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5813

On 2025-10-29 09:22, Thomas Gleixner wrote:
> 
>     3) The function is calling into the scheduler code and that might have
>        unexpected consequences when this is invoked due to a time slice
>        enforcement expiry. Especially when the task managed to clear the
>        grant via sched_yield(0).

Do you mean sys_rseq_slice_yield here ?

> ---
> V3: Add sysctl documentation, simplify timer cancelation - Sebastian

^ cancellation

Other than those nits:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

