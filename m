Return-Path: <linux-arch+bounces-13501-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9621FB5380F
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 17:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90CC16883C
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 15:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2637345752;
	Thu, 11 Sep 2025 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="sq0x0bfr"
X-Original-To: linux-arch@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020131.outbound.protection.outlook.com [52.101.191.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556762D97A8;
	Thu, 11 Sep 2025 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757605413; cv=fail; b=BQpfO/CX7Zy5Yhz1YeiP89po3jlfCn0xqEfZE4oElgo9zi3y5bRd1x3TYwgp7RBerNC8suHKIWVmupzUgaQaQP0pYpws0HW3r0oN7nfCphKEDHI2Sb5W+5yTP2/9i73xfLd8epO6bRJAP+L15Ov1OYU95GOUwTeHw9NHtKIpBoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757605413; c=relaxed/simple;
	bh=z0F8IRAVd1vkxjvXtmfYM6+WfG6CMnsoI8f3YTSnEvA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s9WV2gax7C87pwZI77jmNbzSkj+YLKpDOTJfAU6iIw7eXtrCoTTU290M9vVV1CurZT41G8zezdfeWHix/b52XwMz+pTmxEREarEVmaBHv2nUQcaiZRHdPu+NkkvTl2hJJ5lA96BJbQUCGJbdJNvlOMVMtlJRVV7Z6h2lYjDyeBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=sq0x0bfr; arc=fail smtp.client-ip=52.101.191.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKDdJUbXLP0c2smKV6LCOnG30xnEKO5+pVmchLuuNkF6nm0YpbYNo8MNJJrIzJ/ICDdu2c7RNcnI2lWus6WWdkgdQiiDUweXO+LhMMGNOiO3WUBmdIWlLNTK/kJ4XX2Ss9B1K78HfFeh8/utystuZkUb3jA4y9W2A3Vaa7ApZ6lZhDmUavp15NSJ22LX7vkn2QxiHKHuzJf5ontEsEopB0H51uZ7Xve/N7hkTze5gudrw9XIFLB7dnZlMr2DT80JL75da7Q/SC2Uo0xc+cpe778jcNTK6nj5COOffyn2rymyLcKU64Xpyd6McNFqkxOLoTrECVGELlrRi07arpoLjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91zpUfUWbtPCUCEnjccYTok2ItogP6LuHM3FBdL3QK0=;
 b=Rq3OOtud9sIMXHfE/9+qUouIdk7ZohEU7NxfgDFuhlPHUwkzf1BYAbTukj0ZljYNH9HIRUqRhmAsl/3M1BXPwWz9KKWOj1QGbhsdQFKyyMie4ZNbPkDIWS7z+jDKf8XYrhlBuqxbkyBYaUw2kQxZZRtI5F1lmyRuQ/VRF3kQhfMv3xUrxdIH3CYPxAHxy/SPKnr1bxVzOcsULj7FqNWDQNcGtggOQpH7XxcJU1GAqvb/0+OU4ijeiDHLJ0/Yo36WD9hzzmRFbAS+7/DzdHkaeZ6+Cn6T65lvMN8lXJCbHMpZByU6nFPymnJL9Iv7XMvU+s8o9t/De9bGtxjMwEPjOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91zpUfUWbtPCUCEnjccYTok2ItogP6LuHM3FBdL3QK0=;
 b=sq0x0bfrLG1Y+bq70UAibGgUH4wn5rfJFJHbqi66vwJo5ykeLcBCd0fzHd13ys0tvIsu4SVs4t/esAukRGEj+wo/7+YJpuaFODqKQkMc1ctjK5ZNxA/uIbHyBDDLLqa7ulkX5o12Q8PfL8l5s97Ll23WpRP/4N+ApBetUHFOB2cyNTvmUqM9XirB3+fpe9LFNEiHM8KfTJipD46viH8vJS0lwnBkn+l2wf1PK6Fd9rpxJxBDTm2csY0pxVjs3RXT5OndTGbnq9bTwFlCJ5ouJcarxzEV3nwIgs4X2Vec0F5qxh9BGsP04LBJyleA7TwBaSD8ffWK0Q/S8IcZKfi6ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR01MB11226.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 15:43:30 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 15:43:30 +0000
Message-ID: <725bf4f7-f671-4050-bc28-b629631682b7@efficios.com>
Date: Thu, 11 Sep 2025 11:43:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 04/12] rseq: Add statistics for time slice extensions
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zilstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
References: <20250908225709.144709889@linutronix.de>
 <20250908225752.808973324@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250908225752.808973324@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::37) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR01MB11226:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c9b637-6d0d-45ed-bda2-08ddf149f510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czFSK3JrRmVCOXRUQVpUa2NRSS9yVHY3cnlib3pUbUpPRmdSLy9ad3o1KzdP?=
 =?utf-8?B?cjB5cUMzenJxRjdHelVzT2g2MWFYVDQydjhpMHhBWjlEM3Y1QkFvV3VpbGRI?=
 =?utf-8?B?bUVWR2NiZUc2dDhidUtNOXFTOGNEdldYQ0RKYUI2bXhPTjhCVEtGeE51WDhI?=
 =?utf-8?B?UGMwS3ZtUVVabU0zYWJ6LzlwcGJiRkVZZUVqeFNsbmdJaHd6SW1tMlJVRS9x?=
 =?utf-8?B?QmtMdDZ1cGdpaSs4MW1hQUlpUmd2S3JhaitCeThIZGtBUG9ES3MvMkZ1NEZI?=
 =?utf-8?B?U0wxaThZN1BPTnlZUlZsUHI4Q2t4K1cvd0YzdHlla3ZYaHplaDVJYmJIUENR?=
 =?utf-8?B?QmZoUHQ2RHVEN3dQYzRYc0pnUFZJUm1xQVY1UkdXd1BrdFlDZXFsNU1FbkhG?=
 =?utf-8?B?Y00xdWxNMFdMR2R2RERwRTg4TlB2WnZsVm5wbHI1cVFqZzMzbkFZN0NyQ0ZV?=
 =?utf-8?B?L1BtWE54VEZjMkFvRG9RS2dhU0VSK3I2eGxaVVcxOCtjUGxpejRveTQ0N05P?=
 =?utf-8?B?Tm1EREpCTXlraExYU21KZk93a29wc2xYMEE4T0NJRXAzMTdzNU4vNzRNNkpY?=
 =?utf-8?B?cVZNNVFicTNaSUd4TDlkcHhqT3ZrR2ozdTk1cVNVai9mQW0xSHM0UCs1cElD?=
 =?utf-8?B?dTZMcWlNanVMcDNyVVErbkp0R3k0d081bHFiZTBaQkVoREplWVg0bXkrTW5s?=
 =?utf-8?B?MUI1YzFqeGlmRUtpTFFCenpCUEZ5Z0VBeVVRWVN2bTBCTWFFd24wOUlidzM2?=
 =?utf-8?B?cFVmUE1hNFZ5YXNSMTZYWjUweTlHZDdlWkdXQ1RiNlJVbjVzRWRxMXdFcUR1?=
 =?utf-8?B?L0lSVER3NzRRMWhVK0hEMGIwOFJTN2N5RTNyN2ZMdnVrY1RFVzRsK3NEdENN?=
 =?utf-8?B?amU2dWhBdWpWakFXQVpFUG1oYUdlc3B3ZHpIZDY0MTRRTkJHK2NOdUZqQVNT?=
 =?utf-8?B?bW9YcmZmUU9DR3c4THQvSFRHekluc3FkYlRSbVhTNU8zcmt1R1NEOVl3TFFC?=
 =?utf-8?B?RytiS05yY1BVdDYxUWdwdzJ0UXRHZHB2Y3lrVFRmZnRJSE5jMzE0aldPUzM2?=
 =?utf-8?B?Q01oS0EzcDBVR1R5YnBlMmxOaWRUNndjL1M5MEFwcVRCTHE2L2VxVytqdzVD?=
 =?utf-8?B?ZklWMWtBOGhMUGpzWlBpb0VaZGM3S1JNTHZUc0plcERybkF5OUxyRUpIZk94?=
 =?utf-8?B?L0NqYm5qcEg4M0N0cnlHa3pPcW5lZ01UOHY5VmF5emFwU01pRGY5cHEwL2RP?=
 =?utf-8?B?QUgwcWdiSGJjbVo0dlpIamxPSERGbjQ4bVNUZnlSQzcwRmt3cEZmZFlpdDIy?=
 =?utf-8?B?aGVlSW5JelFFYTN3MU4ySVd2aDhkb1BmNmQvWWhGb25SRWE4bVV6YW13aTNz?=
 =?utf-8?B?WlFQTlBvY3dKUlA2VUJkOXhEV3A2bzQ0NE00UmsvMXhqRGdEMUFIZFd5MDRW?=
 =?utf-8?B?MitzUDJ3Ym8zTGVrUkpaQmc1aUtnM2NXamxIUjdkbFJWNkhrcEUwNitwZUlZ?=
 =?utf-8?B?dVkxYjFQTDUweFIxUjl4MnV0bnh3ak5yUzI0R1VJOVlvRjlxdUlUK0h4Njk2?=
 =?utf-8?B?SmM2Q2FHNkdBVjVFcEVuREVOd2xFczZTOWlVM05nbGZOazRwYXdPbDNXUmRI?=
 =?utf-8?B?RUJJWE92bDJKNDUyR2dCTWVRQUlXYkE1Sm9xT1RGZ3hXWEVUZS9jQUdRaVF6?=
 =?utf-8?B?dWxYUDFJcTQ2YWoybnRiVWE1YkU3YUQ3ckRDMW1sOWFwVVBIS0dnMDd6WVov?=
 =?utf-8?B?Y3VsbkFBN0Z0WDBhK21mYkNrV09DM2NmK1kzMm9CZ1Nxazd1WnFhcnkrNTRu?=
 =?utf-8?Q?ABbRZTvUf+MWD3xJPVztEuAzVlFuJPmUtK76M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWFrY1pLTFNacmR2RG1HMWhmN1ZoYzBVeE1pN1dQZWV5Z0JrODNDSmlXZ3VN?=
 =?utf-8?B?aFR4VXJiS3hZWk9BbWZRckRMdTROU3FxQXhOUUhad0FHMVA4RlhtTkswOUFX?=
 =?utf-8?B?dXV0YzcyWnJ6WmxaYnhmU1VGQXJBSnhsYlBGN1dUQ3dkRDBSYW1Cb0U1NTRS?=
 =?utf-8?B?aHBpMDB4SVl5TmFzelVPYm9OekJ5OWxrTDVTSzJvSTdhdTZhQ0lwaFFZNjBa?=
 =?utf-8?B?REtFSnozNjU4N1BIOG43U3pxdlRJWHNaK0JUMDg0a05GckdHaW5uZVFDaC82?=
 =?utf-8?B?ZEFYdE1KWnJ0OG5aODZ3U3NPejVuNG1kbXRObUhDRVJHNkNvZTQ1cUMrRVBs?=
 =?utf-8?B?YmVHWWU2RTR2OHlKa3dJRzFjd3JHbWd4cTEwWWVWNUZGcUhjRFZnckVRNVY3?=
 =?utf-8?B?RzJXUHVTSDBqUDNVdkVkT29QRHl0eFg5Ky80YlJGVFZRL3JmM3UwTlFWWFMz?=
 =?utf-8?B?VFNUN0VLdENGdngyRk84VENJYW5Tb0FycW9rTldyU0F1aVpOckx6aks3dHhw?=
 =?utf-8?B?Tit6cFV5d2JLcml3d0JCd0NzL1dHOFBaY3dlOXU3aSs1ZzZBWm9FZEgxTExw?=
 =?utf-8?B?RFNMWmVSZ1NqZ052RFZNU3J6K3JUNmdDallxb2FGRGhDN3VsWXhERlAxTUdL?=
 =?utf-8?B?cW9Oc1ZOR3VadVZGR0pNSEU2bXJCZExDUFhuTkpjZ2pIbkI4MVpJRW04R29F?=
 =?utf-8?B?aHhLMUEwRGx6ME4vaytUV2oxT1hYU0RTQkdEMCtDSXlyTTZSdXd5QlI1YXVr?=
 =?utf-8?B?NGNBUkplUTdvVVhIbms3VWE4UlNtV01TeGdCRDJqYXBHL25HdytrUzBldHhw?=
 =?utf-8?B?eGhaM1FJbndJdVFkRUk1aEllck9FL1cwN3QzUDBlOXUyREpzQmJMTFE4L3Zi?=
 =?utf-8?B?Y082TFMrTjNxOHNtYSt1ZnBkQTEwaTdMQkRWSC92cWY1T2o3RHNqdlg4NVEr?=
 =?utf-8?B?NnhpeXNjWEZFaTh3WVRKbXBBcTlyd1VwbytwQXVwTHd3eUFEL0pwV1JQZ2Ex?=
 =?utf-8?B?SkFFalliRjlRMGdaamVIT1hOMk1UcytPRDFRN3JuTXNzU2xVMHNHcVdSN1pX?=
 =?utf-8?B?N0ZXSDRSemZydk8zTHBYWUZtSEY1c3BNVHJZVWczbngwNXhQZlFuWVF1eXl2?=
 =?utf-8?B?TzdLRTYvZnZIMnJJK3ZlQlkybTFjblUzR1NLbEx2eWJHMi9PTE5ScWJlQ05r?=
 =?utf-8?B?SFBQREFXYlJHZ0RkWElmTGMyS0F5UG9HS05COFJKU0JNdDJzQk5yMDZINUkw?=
 =?utf-8?B?emFLVFo1TG9mV3dxQzN1RXlRbzlkaGZ1d1JMVGl4cmRWcXRjQTVGMlBnQklm?=
 =?utf-8?B?SlRJRlFBOFBlRzRLQUVsUUZ6dHJMUTYrQlRsZW9iQkF3ZW1sY0JRWm03QlRk?=
 =?utf-8?B?UU9TQTVHL2JNWXExRkhjZktCYlovaVRmK28rdUtSVjJhMWRtSW5iSU91Q1NJ?=
 =?utf-8?B?M0RYRkFWdmlTNkJWL1RQN3ptRU5IazZBY1JTWjRqbzNXVTJEeGpuM3pTbHkx?=
 =?utf-8?B?WnBRWXR2K0VqSWJkYThKZjBZY3RwVG0vY1JjMUE3eElod3BDR1owbVdQTFF4?=
 =?utf-8?B?ZTNadkVWOHlWNTRJcUh3emJMWVF3UHNGQ3g1V3JJV0Rwa3Fqek9UYSt1U2gy?=
 =?utf-8?B?QXA4SHk2YnYvbmxpUzY1THBCQVl3c1hEOWRDSnhoUERBOStwSUdKY3pqOHJx?=
 =?utf-8?B?MVpkbUZnYlFlUmhLaUxKNlZINU94VnNSTFU2RzBHZ1YwMHdHSXYyalZUd1hP?=
 =?utf-8?B?MGF5VkI1VnZTek0xcEt0ZmNudTd5QjBBY1RGRG9Fb09YOW5ldEhJN0d4UEdY?=
 =?utf-8?B?Yno0bmRKS3hYeUVFYnBhVE5mSTR2RUFUM1dSUnl4N05rbVB4M213ZC9HeVRy?=
 =?utf-8?B?UWV3R2dYcFVSWHc0MHgrK01FQ29HVzF2NGNOWWUzdmNNYkpDUGpDSDIrL20x?=
 =?utf-8?B?UHIxZW1tSDBKdk1Da085ZlZsUGM0V0V6ZnRqRlJIQXpkazgrclpXN1BKKzVB?=
 =?utf-8?B?RGl1b1d0RHZ2ODFPZ3FLR3pzc09BMkJYc2VoQjJ4UFZ5N0RjSUN1cmRzYnRh?=
 =?utf-8?B?VlpueU9EOXhqbDFxd0xQOFBuWG9yaGtTc0IxYnAyeTdDZkpOU09qYTA1ZkhP?=
 =?utf-8?B?WUtxNmxQZml0RzF5NjdqNUJyWDdHNjcvb2FYektRRmNXVW1NRUFtS1V0Tk9v?=
 =?utf-8?Q?RM7GvVm4bPYi4lTgLJIERhw=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c9b637-6d0d-45ed-bda2-08ddf149f510
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 15:43:30.4500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyphGPqKBZs+EM4R3jQX1G+zRGUI1f8oCEbx06V9bi0Y5acxHsRIxyem+sQaDXuGCdnmmFeC3Fm7gLuUHKxuvYwKip0X2rhfNKYC/BTVlCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB11226

On 2025-09-08 18:59, Thomas Gleixner wrote:
> Extend the quick statistics with time slice specific fields.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>   include/linux/rseq_entry.h |    4 ++++
>   kernel/rseq.c              |   12 ++++++++++++
>   2 files changed, 16 insertions(+)
> 
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -15,6 +15,10 @@ struct rseq_stats {
>   	unsigned long	cs;
>   	unsigned long	clear;
>   	unsigned long	fixup;
> +	unsigned long	s_granted;
> +	unsigned long	s_expired;
> +	unsigned long	s_revoked;
> +	unsigned long	s_yielded;
>   };
>   
>   DECLARE_PER_CPU(struct rseq_stats, rseq_stats);
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -138,6 +138,12 @@ static int rseq_stats_show(struct seq_fi
>   		stats.cs	+= data_race(per_cpu(rseq_stats.cs, cpu));
>   		stats.clear	+= data_race(per_cpu(rseq_stats.clear, cpu));
>   		stats.fixup	+= data_race(per_cpu(rseq_stats.fixup, cpu));
> +		if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION)) {
> +			stats.s_granted	+= data_race(per_cpu(rseq_stats.s_granted, cpu));
> +			stats.s_expired	+= data_race(per_cpu(rseq_stats.s_expired, cpu));
> +			stats.s_revoked	+= data_race(per_cpu(rseq_stats.s_revoked, cpu));
> +			stats.s_yielded	+= data_race(per_cpu(rseq_stats.s_yielded, cpu));
> +		}
>   	}
>   
>   	seq_printf(m, "exit:   %16lu\n", stats.exit);
> @@ -148,6 +154,12 @@ static int rseq_stats_show(struct seq_fi
>   	seq_printf(m, "cs:     %16lu\n", stats.cs);
>   	seq_printf(m, "clear:  %16lu\n", stats.clear);
>   	seq_printf(m, "fixup:  %16lu\n", stats.fixup);
> +	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION)) {
> +		seq_printf(m, "sgrant: %16lu\n", stats.s_granted);
> +		seq_printf(m, "sexpir: %16lu\n", stats.s_expired);
> +		seq_printf(m, "srevok: %16lu\n", stats.s_revoked);
> +		seq_printf(m, "syield: %16lu\n", stats.s_yielded);
> +	}
>   	return 0;
>   }
>   
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

