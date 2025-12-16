Return-Path: <linux-arch+bounces-15465-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B127ACC3A26
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 15:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E60F43031D8C
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 14:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400C734AAE3;
	Tue, 16 Dec 2025 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="WEmdNs6F"
X-Original-To: linux-arch@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020131.outbound.protection.outlook.com [52.101.191.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E609A341064;
	Tue, 16 Dec 2025 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765895824; cv=fail; b=GOH3XsOkcMmLKey5WzqhGWVOzRkDgVv5l7jwKR0y1AOPVUEiVQ96Yjbgpi4Aob5Jm9Q5JlJCajYUXK9/Q/62mdwKXh2Wqwn1LtxROHgU/1ug65tuBCLvJEYTXH82a2TT83/tGV7oC2hQ5iGeIE+mDrPxrnc2S7DN/Ng9om/Q6UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765895824; c=relaxed/simple;
	bh=7zTdDGAFS1JVZsnBqFfRR1kQTjCXr4jr0vfctQN7RmE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aouC87bTrxzjLkS1cSwyXs3sC2ZmIaB1rwOf1qOwSWkPc0fDim7lczGyWQCVZEmUyqyASyUtG6ENorLut8jz8B25ktPXE+N72gqO/8FN1J2EUA9CNBviJPOhAihTyRGrqkYFYfvCgbGJPOIm7AIi6O6WvwJy2mmoamMAWICJ5Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=WEmdNs6F; arc=fail smtp.client-ip=52.101.191.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpHX4HU3yjEIF0HeaCrdZ/oBWCbUR9VE9UFXjvm9ruVDl7ON5TWOISr/4S5pYlTc9whPn2NmQBbmnZ+GWye3bq3yr+b/IhBHocSWLoVHP9bQhWJz4xtODgh0HhFGsNVJagDpjsPvneNl7JDzAeUVxgxU0H0SikhBKCTAYmVFQmzO+FeF9aroZYIaX8KWfFpWj9r70a6aX7rCOqGSJPv7WE6z/yCsCZH1G/iOtovGK4P7jkrSQfSZNW1/vuE2tETi2kv5aL9VN7RTrZ93vnAj5NmO3kDqpIQ2oRrgJvPTRsf0eiU9opKi9qGI0e9Fz3FbuEY/M0JcdgUzU94ryFyTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsbDG6NdEB3+M7EkyOtMDQBIEoRIrVph001IdJYUJLU=;
 b=CTknRIIcmqmx2dSjXiFlUO6T2FY4F1/E9VXRJeOsQyD4SQGWfJuFTaAeGS2nhrLqopUXUHxwUvxEurJgev/Q447REd4IxFNFqTVwf26G5vLd3VVEMkps5Ao02KRS7fUX0B0YaYn9cFefrpltksNQ/+j9GvChWmCad7JAn86HgYxNJUFuKcbfnpmfZY5oAs0qLl8+IWqcrr/erwGd9alinrbWa1v21A/WQQ6pTSaj0WUPZluZk0gjRVbXiAItb2mF79ZN4VWOcaDg8urAxFw/8Iqsd8L8fVDyqJ95esZ1x263PQQgidTPckBbIUJ6oQhb3JnEsqEbaZ5fg3nhlgmrow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsbDG6NdEB3+M7EkyOtMDQBIEoRIrVph001IdJYUJLU=;
 b=WEmdNs6FRyXBArXCPEvrFFJ1HnRjK3X8hlLkD5EYKi4psHe5zb3pz28efy0FZjyd0e7nFfYvVn7wXflRAUDFRhh/FJHJdDIe5kHg0FHS5u8cIMSz5HlN2GoHVDKu3xOItoXu2xgEC5N88gTNLVRPhJq1WqMCvOgoGmtjCYaTzi64cvK5l7sb7CjBkAWUgrTVoCOO9xamR9uF7bF1aiupAIK0IY7rWLqG7j37p4xXdS/4/LmQjgnJ1CcQxV6xTOhevgMKNxR76s5YAfauR5Xne/j2xMG3shzpZhM0/ZmFe0mbXPjsGqrp1VvgKACZtoRYeTAtazqzTicSve67vegSSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB5558.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 14:36:57 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 14:36:55 +0000
Message-ID: <d97944e3-e5f3-4d7e-83ac-89ddd6a4cb64@efficios.com>
Date: Tue, 16 Dec 2025 09:36:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V6 01/11] rseq: Add fields and constants for time slice
 extension
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
 Ron Geva <rongevarg@gmail.com>, Waiman Long <longman@redhat.com>,
 Florian Weimer <fweimer@redhat.com>, "carlos@redhat.com" <carlos@redhat.com>
References: <20251215155615.870031952@linutronix.de>
 <20251215155708.669472597@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251215155708.669472597@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0481.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::23) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB5558:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a825a0-63e8-45ea-4548-08de3cb08fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDFqZ1VOeGl4ZFk0c1pBU1dzc1UrUFVWZ2VkeTJuekRETzl0UTliNVVsSFla?=
 =?utf-8?B?djdZbG54aytKU25EVGNQcDBjazVWcURPRmR1QmVzaXE5b1B0d3dxZlZ6SXA4?=
 =?utf-8?B?MDJZV3kzUWs4dFdFa2dkcVB3bE8vRm5jQ09RQXQ4cDlUenhlU0dWcU1kdXdX?=
 =?utf-8?B?MGh1OXE3S3RwRCtLV0NxTnFmTDNuUEg1WTVNdEhlRGpOWjNieEdwYkhvSlpX?=
 =?utf-8?B?MnhvRnJpU2hRdStTRGtyaDlNaXVZb2NLaGd4MEFjc1Z0bytKSTlZSFZhRCtB?=
 =?utf-8?B?Ym1CY0lhNUhFKzZWZTNsWHlWWm9KT3poUHBhZS9NZFVWRXc3UEY0SWl1b1Vk?=
 =?utf-8?B?ajNlWVcyTjZGamYzaE9BSE5aTzdycmExbFRGZ2NZSE5YUjRhajVEUlpuOFVu?=
 =?utf-8?B?SmJKdWUyZ3dtSVJzelppS2dYRDBjdUlYcFU0M1BZWHhtZ1ZSZWpvZXVGT2I4?=
 =?utf-8?B?aXpaVlFHT21JWW1CODdER1NvR3BJeEh4R2cxb0ZVbDhITjQxMC9XTmxXWUV0?=
 =?utf-8?B?cWtHR0VpVkg2KzZBR3VsVGVxazdub0tFazhPZVNRdk9BdUFzQ0tIdCtJWGxE?=
 =?utf-8?B?RThHbi9XTWloS1BWWnRNL0xabHRGWVpIWGZWMlZMUWo2TE5nbGVkUlp1ZVc5?=
 =?utf-8?B?WTZySWppRTVOV1RTUkdFMnB4T3ZDNHpKZnBtOWIwKzFzWE93a0dRT1BzZVd6?=
 =?utf-8?B?aTZFZW1Cc01wcDZkNWlVK1lkS25qT2cwVUhmb3NSa3hSMjJ4OVMvY0VWSjFw?=
 =?utf-8?B?UzFNaVBoRXd0QUNNY1B5TDF1WmRDd3Jrdy9ILzZsdk0vOFltSUVNa2tBRFZh?=
 =?utf-8?B?Y3lqVkN6clVUYWI0SDNoaS9vWnExQjlWYTJqdzZ5aGwwcktqRHFTSHNVVFNl?=
 =?utf-8?B?dmR1Q01HckRYeU4xeEtTQkZhcUNSa1JpYlB0bERyTG1RMitsZ1NEQ1VJMEx3?=
 =?utf-8?B?eCtCWFdlWmRrKytZa2RLUlh0cGJWaW05aENEWlBnK0R6Q1Z0NlUxYU8rTVc2?=
 =?utf-8?B?aXcyZU0xY25NaWs4cmQwUkFtdjlPMjZYRDBPcERSR3pwQjUzbzZKemxPWTZS?=
 =?utf-8?B?QjdibEJ4aWtPeEVCTE1UeW1JSjlQVjBpWm9LL2liUkY5UlE1R2V3ZkhuT21k?=
 =?utf-8?B?VEMxcUF0bTUrQTRqSytjb3hqKysxVkpVN00xK0dRcGI4bTJIOWRjMjlPaHdv?=
 =?utf-8?B?cW5NNitGRmVVNnRROTcxVzM4N0ZzUTVCd3o1NE9wUFRMNDFETllTK1RTU2Rs?=
 =?utf-8?B?UVpoVVVzMWNsMEdFeUVkalR6NE1XSzJSN0VBQWJDK0NaWXFkY0ZwdWJwbGI3?=
 =?utf-8?B?di84WVJkdHRCL1lWTTl3cmp6UEt5cW9nSFJ5N3h3QjZrbURCaVNQQmdQZzNZ?=
 =?utf-8?B?WWh5V1RwcjVlcWxRNU9mR3VLUlRvSWxNQXpmN0ZGeEV0YWYwR2dXcTBscTBX?=
 =?utf-8?B?M3NMVU5wWDFFWWJLL2ZEaHZ0M3F6UFAwSHZqRk9iZnBHSkp4Z3J1UDZIZE5D?=
 =?utf-8?B?VDdxWnlMZXhKNEpSL09WeUY3RWIycG4xLzdPZjRUTHYwKzJEWEl2MnhVeGQ3?=
 =?utf-8?B?WnY0enBmbnBycVNLWkdBMzVYa25PQnQ5aytZbnh5NkVBME0xdHAvTWdIV3E0?=
 =?utf-8?B?OUxyeGx4VTluWEpDVWZLRXN1Y2U2anQvaER4NktqTnVJVFIvMzlMQWZkRWIz?=
 =?utf-8?B?Q2ZXN3pLM0Q5QVBRd1ZzQkNQREVDWERzK2taUktUZm0rTUJlVExuVTJQWU05?=
 =?utf-8?B?cXhzeGJuQUZJY2lMTlBwalVRWlAyU3owZml6c29LdFNkMUFWNWZkeHpMbjgv?=
 =?utf-8?B?RW93SnBYclRLcVlqNEJnUjZoTXFXK0V2enpWNlE3by9vdk5JWGFkODJ6aVd1?=
 =?utf-8?B?cjdzNDFENXRmUEJFUWpoNzVkSi9EVjkvUHBLZDVvOERvZ3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2dubDZscmZ1aWg3cmdtN0dmMXZXQ2grRElpWlFZdzZEdlF2aFZnemNNZVFG?=
 =?utf-8?B?WFlsOEhFYnJzYVg3QWxEczlvRnEwYUJDSHpFUnVjV3owcnVGbU5UNCs0MVQ4?=
 =?utf-8?B?ak0vYzF0ekZZWVVJV09MMkRKVWp1QUhwVml5L3dpd2RpZzU1UExvVVYvZ2RG?=
 =?utf-8?B?TEgwM2tNSWpNRWxRWkhvbFVDUmRQMDQ4MUg1eW5DTzNZRTlQWkljSk1lUjdx?=
 =?utf-8?B?dmdlem9DWFdIT1lXMnFaOG1Wb1R1VVRXWU1PT2JyZHBqK1p5Tjk3WmdFMjdL?=
 =?utf-8?B?d1NjWjVTaCtsRWRoMzlrK1djeGRpR01PSk5oZHdlYS9nRzFocnVRd25MbnQ5?=
 =?utf-8?B?V3dXMmh2dW8yOVNHeXNaUjJQY1Q4U3FQdHNURXpPOHh2cnl4dUNpOGUzQnhB?=
 =?utf-8?B?c1ZCdU1ySWNWeGJRRXZPVXQzcFAxRlh6NWNsZkx4RTBRS0FIK0ViSFY4VUZF?=
 =?utf-8?B?Z2p1NUZEQWtnM0R1bU5tN3FCRjdCZ0pMSVdadUhwMzQxTndTZHFSL0N2WUJh?=
 =?utf-8?B?aVBLZWNLMWJYYjNFYVVnalhINUMxbm5zYndOSWZjalo3TkpGbWl6OGtURCtL?=
 =?utf-8?B?QW5LTjZ1a001VFd5Y3FTVCtUblNscXJEbXZvN0JBMmJteFpESVBOc1hSUUQ3?=
 =?utf-8?B?WjVqOENWczZmaVFxNTVQTjZYNk1pL3FYcHhYVDhIYVdkWVRsUEU4UnhxaWlS?=
 =?utf-8?B?THhLYmVpTEhPajZXcWZscEcvVFVmSmgvbWdVaXAzWHZFRURWWThrZkl6WW00?=
 =?utf-8?B?MFF2Y2hXRkp6TkQwOEFkM0IwelM5aDA5QkhkZDllNDhxcnAzQmp5YlRCS1Zn?=
 =?utf-8?B?ZXhrY0dJd1dENVdUNjJzV05lR2lFZGg1dGE1VnVxSlJ2dUlFTXlHSXFZaGFI?=
 =?utf-8?B?cW5vV255emtHdUlNVW9OVlgxT2NEVWtUTWh4QktJRzcybzdJVzN2SWJUakw2?=
 =?utf-8?B?V0l2eHZ0VEl3Z2JtUGFUNlQ4K3Q5VUswK21nK09GQlBHUDkxdTZqSm5lUFVR?=
 =?utf-8?B?cXVFODRZdTV5UWQvSTJLOExHdE5iNG1xeS9TRDczckdvL0FlUTRpaW8rbXNj?=
 =?utf-8?B?Z24rczVGQno1azVoMjhGMHhYdHVlNlcwV1d4RFo1bVMxUTRJakl4dkY4MVM1?=
 =?utf-8?B?Ty9MSkwwYmlsbEZTRE1OeEJKdlJpYVEvenB3VjY0NS8xcTE1NmIyYnVNNzJy?=
 =?utf-8?B?YmZmdnFReU1yakhkYVJBRm9DbTJWdlZXNk9pYzh1MUpiOU5DQW9DNWpwTjdC?=
 =?utf-8?B?b2FOSm8xTGtJRVJFNEo3VjNEV253ZWt3TTBxYjBUUE9td3NjY1JxNXJLUysx?=
 =?utf-8?B?ejVnbjJaendxaXRMdExoTWxQQUtUMC84RndSM3k3NksyWTJoeDlQZWJkL3hG?=
 =?utf-8?B?UG9OdzhVa1BOQ29GWjFsNHB5UTR6dUhaY1lDT2lVTERMeE9sZldNRnJ0RGtk?=
 =?utf-8?B?VjBiMzZXNUJZSTlvNUI5MDVoL1Jvb1FTdmFOZVpBVktSSy9xMWtoOVdwak9X?=
 =?utf-8?B?Sk9BRWxYVnNFQVd5a3YreWFZa2pKVU5WUHRLcUxjS05mOGdOMlV4VFBBQmtJ?=
 =?utf-8?B?cFJBOFJUZ1d5ZEtoS0xSSWR0NWJmV0c5eEgxZHd5RGNSU0RWRWZ3Ri80L1NP?=
 =?utf-8?B?VHR0WE1icWR3TWlRMXAxY0dtSU9Gem55dVNoYndWWU51bEtYK2xjK1BPNDd1?=
 =?utf-8?B?WUcvQkJaclFPQkg3aythelp4M2pDZ2FNQWQ4MmpSTm5qTFdzVjllOHh4SElT?=
 =?utf-8?B?dlp3UU9QN05VdkIrNTBrTmNtZnBLdWhTckZTMzBNSTNDWW5GdHMvZDNsV2dq?=
 =?utf-8?B?Ky9NS3F4ZDZCRWxHbWI3YzRZck4yTEZiUllMQ0l4dzh6TVVyQ0h4VytkZXkv?=
 =?utf-8?B?cHNvT3BkRnlLampBaVBTZS9iclpBMmZUY0RKWExUeDlpbGU2dmt5L2ZVL0ZF?=
 =?utf-8?B?S3ZTRnlYb3VHUlhPRGlXbkozS1Q3bEZpQnFhSDc3NGZ5Uzd0YTRFZ2g4enVB?=
 =?utf-8?B?M3pObWV4K0RnWE5mRUlEMThKcWlRQnBCVnF1R3I3SS9XZGEwQXg1WGtXQTBw?=
 =?utf-8?B?cUEveGxaVVdkaGM2dDFOVnE0MDNxcEtkalJLQ2F6WDU5VUFiQmdCUm9BVkhT?=
 =?utf-8?B?M2pPS1lkMnl3eTVXN0ZGbjdtTEhVTG10NHNWekFjMCtQaGVhVkRzN2FpUldN?=
 =?utf-8?Q?aOEVETVsm9mgnhb+L1ssa90=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a825a0-63e8-45ea-4548-08de3cb08fc8
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 14:36:55.9063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbjV1AeUe0sma+vdj9eQ6HODLzREpVePM4tIP+O8ve8xw9Exjt5UyFWyLppZ14OTHZyEXu+P+7fg6++jRJs2CrC8ImAtH3nbwRkdxTdb5f0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5558

On 2025-12-15 13:24, Thomas Gleixner wrote:
[...]
> +The thread has to enable the functionality via prctl(2)::
> +
> +    prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,
> +          PR_RSEQ_SLICE_EXT_ENABLE, 0, 0);

Although it is not documented, it appears that a thread can
also use this prctl to disable slice extension.

How is it meant to compose once we have libc trying to use slice
extension internally and the application also using it or wishing to
disable it, unaware that libc is also trying to use it ?

Applications are composed of various libraries, each of which may want
to use the feature. It's unclear to me how the per-thread slice
extension enable/disable state fits in this context. Unless we address
this, it will become either:

- Owned and used by a single library, or

- Owned and used by the application, unavailable to libraries.

This goes against the design goals of RSEQ features.

[...]

> --- a/include/uapi/linux/rseq.h
> +++ b/include/uapi/linux/rseq.h
> @@ -23,9 +23,15 @@ enum rseq_flags {
>   };
>   
>   enum rseq_cs_flags_bit {
> +	/* Historical and unsupported bits */
>   	RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT	= 0,
>   	RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT	= 1,
>   	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT	= 2,
> +	/* (3) Intentional gap to put new bits into a separate byte */

Aren't there 8 bits in a byte ? What am I missing ?

> +
> +	/* User read only feature flags */
> +	RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE_BIT	= 4,
> +	RSEQ_CS_FLAG_SLICE_EXT_ENABLED_BIT	= 5,
>   };
>   

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

