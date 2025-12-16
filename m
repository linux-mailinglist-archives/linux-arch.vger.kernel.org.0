Return-Path: <linux-arch+bounces-15470-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEDACC3E3A
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 16:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0940304249A
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 15:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F845343D66;
	Tue, 16 Dec 2025 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="fdDDmMBN"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020073.outbound.protection.outlook.com [52.101.189.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BA8325701;
	Tue, 16 Dec 2025 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765898289; cv=fail; b=hqjCaZLIhPtDicY3ZiLhQ6kPnDpIeNqEzrGgs775/wZxOSti74btOIawYkPXWBj8U9uutZkeKNH70yBHFChQvJZHxiVqqAWB3S5dDB8ShZ68jjNDTq7Oa6czcx3YSl3E3Lojj/gIr8RdP8IwG6qwwKmzI9UYsvlpYr/Wrinnh5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765898289; c=relaxed/simple;
	bh=iEB4ds+QxGVKc5BKi4Dc4ftG0R+fmhqJj+bl5yJfFxs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XBP5+jCXjNfS1s22+RELjQuS+PoYRha4ibjXDIKKPvgs/xj/0TfShW1PiquaVNiVofR3EBXQ8k5o4ks1wbqIJP71bds8Z16azk+67lpmhpDzyPepEIhDrpTeDxHyUql8M+85aDzWFfrOHQrxJxZgmNhzqERN30PdksLIKQYloAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=fdDDmMBN; arc=fail smtp.client-ip=52.101.189.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHDkjwR6gWoLS/hdegaF00W27vH6CDg2/gvjzYV0ZMRIv/XE+TW5nKsxkIQsinlm0ppHTFTaxOkbxCtPJGOcODzrMPU6Hu1dUx1vjS+++bFxSn7CZSpz5lH9gorvEGrLoQ0Hx9FzRp6ORSB0khHlvkkJeWnuzCjB65NkMoABrCSpFraxDZfyhcuQ32KD2Vyp332yfARZBbhTFGsVNVf72C+4d14BZlDELD2C3h3T0tp3T6/JWz06SVjqOxvN1FNeQStDGZrp/tJimBKt/kZeyC6Fv6y0jqB+HI+rrmQDOHLxC8Uum3rr1cQzYnR51yojZnDnU+SQq70h7JYLESF0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyKCOShc4sguzSvW5UVz3F0HDaU6pRgNy6f/25AST3U=;
 b=w22cQw+yGTmyF6veJb7I4SvzDDjDB+Qw1Hm/xpAdXa0Xff5sFauUm3Fui/MpBfX9I20P02bWJ7H6sLD1iLsptrLuqK3Z/eEAsNB77wKcpuJ0M3uPMivho8emwLFUoLcPQGAWK1/fhFI1Zw1VY3WlGTxEx8px95ueQnUcOqxiyy96N4dcOcOrd1f/beOSqJ5HswTnn+DqNCJQDX5IDV0h2uPim31oWs+swda3Eq7RdFoTiEsxAVKs6f1AE0eOUqpJtqdzqs9GQfPOzKfI5kYy1p5DOWWmOP3dl9YVYOsI1g4qaz9fhm0q8Owtx0BBr/xXobuB+D4vtqyZEvFZOJX4rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyKCOShc4sguzSvW5UVz3F0HDaU6pRgNy6f/25AST3U=;
 b=fdDDmMBNnl1AbtEm5MyKt4kxlYO6U5CI6NsrtUJbsCgPG+88s1dyv+me+5Jxc5rwjD5nu3ftBUtb3ZJJ/FlKLHsivV3FeeAy33fJ8pzW6MEFi0C99ACXMaK/7APl6qWqYb/RMY1m1UQsJ9Mxp+J6/Jc8zqqcQQtSrHPmXmbP1ElyD/g7ybGwmIrElyxPjOJvEAW7+WXB12wtPirGwjCa1TTjQetUIND9UPA48yQlz/k9DiQv0/KOFKpVe9E3sIm8QsgUB3xIozghqzYMjGV60PU7saLhRqV1fCjdTw7tUyh70Ae12aqIb+dnSb2/bafee2KflEX6jPcQG92ewr3hfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB9376.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 15:18:01 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 15:18:01 +0000
Message-ID: <b1a1ff6c-622b-49c5-8c5e-ca245ea6a52e@efficios.com>
Date: Tue, 16 Dec 2025 10:17:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V6 08/11] rseq: Reset slice extension when scheduled
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
 <20251215155709.131081527@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251215155709.131081527@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0418.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::26) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB9376:EE_
X-MS-Office365-Filtering-Correlation-Id: 902553f8-db7a-458f-0c0d-08de3cb64d7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czduUWxQM2ZMZnJsVmlvdXR5MGN0eHBPdVFHdzZSbUhEdytFZ0d4Um5pR1oz?=
 =?utf-8?B?YWFqekpKYlp6QVcvekIyWU1lSU8rRVh3eCt2V3pQSUNEYXVGSUF6cUlhNjdq?=
 =?utf-8?B?eVZTeEV1aHN6NFNkUUFMMWJoMmMxdXVDcXdWaEVVNENmaW8vcERVRFpya0sv?=
 =?utf-8?B?Mml4YjdjWTdCZUErTmI4eXJVK2F6Nnc0bTlNQmVYbHJRbFJ4R3pWSHJPSnZY?=
 =?utf-8?B?d3BzZitiQmFHYUxvR3N2Vm8xcXB0S05BL2dPSjFUU0JvZ1Njc3dBQy9RYVl1?=
 =?utf-8?B?SUszNkMxL2NXd3NUbS8zeHU2RmpCM2hTUlFIczNjS3hKTDNXcGtoT1FSalNM?=
 =?utf-8?B?QWZrT2pidGlNVTZ5aGlGZEFpTVQrR2UxKzZXZDJoY0pmUVpNN2JoWmk5eWxl?=
 =?utf-8?B?VGt3WVkwenB3ZEtPcjgzdVg5SjhVdU81RitXbXJITmtzSGszRXZlbW9uMDFo?=
 =?utf-8?B?QVRJZ3BpYkFGa1JJNWJZOVZJTzU4Y3JENksvbzhMSFA4RDBndkxreVc4YUJD?=
 =?utf-8?B?Y3R3N0hGcEhKTzdOZk5qTHZIbTJhRCtxVEUxdzVOdUVJeWhwc3JqdENRZ0JF?=
 =?utf-8?B?Q2dUUDFtTjlaY3N6WngvakNpeXpHQlpHQnhhVXBsclh6QnEyT0ZJellHa1ZE?=
 =?utf-8?B?VDNEcklPYjVYMExQVlhUb0FMRzRTM3pWOXFpdHl4a1M4L25IWWtTcC9GbHFF?=
 =?utf-8?B?SU0yWkk4a2gxZWJxOVMzN2JYYTdaTDF5QlhmZWR1T3RUMisyd3hoU0lFRU5C?=
 =?utf-8?B?TWk5c3FCQ3cvYStFeFdKQnQxSVBYdHpsY1BBdzlSeWl6Q25lQTNsS01nMDV5?=
 =?utf-8?B?ZDdvQVhNRVJkNE54SmwyMmt1cnJxUGFhN2U4a29wcGRjd28vemhZQ290QnRl?=
 =?utf-8?B?WnJQZzJaa3o2eGt4QzhDQTVmcDc3MlU0NWpxY0dzQnZmWXcxM1FBUno2QnVw?=
 =?utf-8?B?eUVqOHhwV2ZZbXdUdXk0YlF4WWRXcGJYZHBpUW5EOXBTbW5KVWY1OC9HMnRs?=
 =?utf-8?B?Uk5hcktGUUpSd0lDM0JRSnhYSVVuTlJpUUtiNUlKZksybFZJbEp3ZXJVZ01q?=
 =?utf-8?B?YmRtbWlBamFBUE1DK1F1dnZabGl5ekhtNVlySzZiQXgrTnNhQit0TERwd3RM?=
 =?utf-8?B?cFpRQk5Od2psS3YzYWhrczFKMVNlTCs3VWtRc0xKbGtHZDBtZURZckhMUXlu?=
 =?utf-8?B?bTA3eFBRWm16YzNWU0lTTEd6ZHNmM2g2RW1TMmd4WENlZU5uNEkyS21rRHdM?=
 =?utf-8?B?Y0lidmVlbTlpMEJiT0JUTEZRNGxrT2hvWTRuL0Vmcm4rYzdyVENXbnJBS1Zx?=
 =?utf-8?B?bE1rRm9wRjBRRDUyU0Z0d2F6TVd1eTA1RVRaNzk0bU50NnlzNlNkV3QrOEZi?=
 =?utf-8?B?MEp6RnZMSHhkNkkzWUNIQkxjNHpUenlOR1F0Q2pNMmsyN0hCZEszVzBsTGpJ?=
 =?utf-8?B?MjdUZ1lWOWR5MUgrMzdXc3VrUXRPUHRicmEvMWdzaWxLd1g0ZzRkdVV3Y04r?=
 =?utf-8?B?NHhMN3Z5MnNMZVBOLytOaExFRXovZC9aVGFLbmx3SWhmZS9FQi9uMmhVck5r?=
 =?utf-8?B?U1h4Q2lzZWFBYXR3SHFEbXhPcm1iOTRFVm1vTS9rSnV4dHpVRldvY2dRUmlj?=
 =?utf-8?B?RnNrT1EzS2FkU2VMT01XUmZxeVZPNEE2aVdFUG1yR2pRYmpCM1ZzdlR3LzFD?=
 =?utf-8?B?MklLTHkvMSszRzBScTFFUk9ON3JiUW9IMGovQnR4c3hCbnkvRTJlaXg3UE81?=
 =?utf-8?B?clpjUnVyL2xmam1iOTNjbHRvQVdGc3lkbjlrcjBRM0V4Y3FYT3pZWklZaktO?=
 =?utf-8?B?d1hXaDJFYlBTbmt1VmswN2JtQXIyVm0zeVFxVVlvTGNVQzkwR0Q1QUtCQTAx?=
 =?utf-8?B?Sm4vS1hsNGs5UEJsUVVyTzJIQTRxbUpQeG5zVTNKcTN3cVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVViYUJSTlhjaUwyK2FDZkNEQVJGMVlTeVFzaTFIbVg1VHIrNFA4MXNsZXJX?=
 =?utf-8?B?c1M4R3k2dGt5VHpHSndqRlFWSWVsUG5mSGtTZnBwL1pDa0dNUVBRMTJPc3hT?=
 =?utf-8?B?RkhjT1huNldsUmQxREFrZVNkTTFPd1FRSXgxSFVOMjE5Yy93VHZWY292cnJV?=
 =?utf-8?B?VHQ0amR4czdrV1RnYk9oUXdtT09GNXk1TzJNUm80UXREajRDWk5jS3JHdjIx?=
 =?utf-8?B?Z3lDNU41Q1dCckR6b2NtaWMvT1g4bVlWQzFOTDVIQUY4ZHpaZGpyeVhDZVJY?=
 =?utf-8?B?dEY0U3FzalllKzlRTlNnbXpNZVJDQTIxRERpT1JMdWlPK3dQbml5VnpGVDJV?=
 =?utf-8?B?RWVLSFR2OCtyblM5YWpBMjk2N3gyK25GNU8wVTJUUGlQUWVWWnY4aXZVeE8x?=
 =?utf-8?B?ZzhDejJHOFZiZ3UwSC85cDRuWGY4VnJlb3pzdzBCZHh0YS9mVXQwWm55eGRw?=
 =?utf-8?B?UFpZMkpwRFhlaFB5dXdEVURTRUkwVVpTa3h1ZWRGT2hwdXZlZkxldTlDYjBu?=
 =?utf-8?B?K0xpMUlOQ0ZhTUJhd2lidmp1SFhURkpvQkVqWkx1KzQvU2gwQVVDa1IrZnIv?=
 =?utf-8?B?a0I0V3JYTS9YSStaT2dpdVpZMThXMGg5SzJqSWpPZkx3cFBoY2RLRUM2TTFy?=
 =?utf-8?B?aVFKR2srL3pHcDFQa3l0NjVDOVZROG1LYkU1SjNXYlJuakkzN1BVdnRnZWs2?=
 =?utf-8?B?WWhLa3RYOWM4SElIbGRBWFA0d2VnM29oSGcyR1JYWHZiL3E0cTVZN0drbitn?=
 =?utf-8?B?Z3NvK2dUc0ZQcnRQM3g3S2xLVXNNb0NrekFkdXR0c3IwMi9KRVUvdU1jR0Zp?=
 =?utf-8?B?UWxZNUJTVE5XWGxXd3YvK0NsalpXQURBMzhqejlQeGZwN21vcllZcXFXaDN1?=
 =?utf-8?B?V0VTczFyYnJCUlJxbnNkR2ZHeExGSXczTEQrTjE5NkZseWkrdjduSktmSzY2?=
 =?utf-8?B?VzdlK0JVN2t1T2xmR1QrY3Z5RWYvVUw5K01UcUhpcnQ1amkySjlHc002VXVq?=
 =?utf-8?B?SElYVnRhSWl0RGNoeVQ5RURxS3lIaTdnK1pRWnJuR3N0S0Qzc1ZXcmluUVBK?=
 =?utf-8?B?b21lRHcyUTNtTG8yZEdDK0tENithZGhzL0drQ011d3A3Y1I5WHoxazQ5d0hw?=
 =?utf-8?B?d3RqVnFKd3hLUTk2YlRLZVN3dGYydm40NmdDSjJJb2xFTHZzdFJPbWNYdmxU?=
 =?utf-8?B?VzlLUnVoazZadlpRakF5Zm1GRGFCSTM5bEpKVjZzRiswRis5V2N5UnFrN3Vz?=
 =?utf-8?B?all6OWhlM2xEcVdWZ0VOaEZzdUhQbk9NVUxwNy9ZUXd6RXFNc1NiL3VkMzNk?=
 =?utf-8?B?cFBOUDBvNUxRaDFaeWQvbThTZ1FSN0ZXYW9GUWM2aDl2M1I1MTBQbjc5UDYy?=
 =?utf-8?B?OGp0dUplUWlwSEFVdUkvb1ZieFJDNC84THhaTHBvZnBvcHZKS1E3djBGUVJ2?=
 =?utf-8?B?WCtuWFVySkt6WWZ5d29wT1pDdEFZWFE2MEZ0OVlMd0J6MzlCbldnZVJCclZp?=
 =?utf-8?B?MDR3MXhEZk5zS0NaQ21zaHRKRWZEdWF2b1d2ZHQ1ald5U01CUkkzYlNPUTk2?=
 =?utf-8?B?WEllUWduKzhLY3BsM21VWUQrSEd3TjNrNlk4eERpUTA4ak5KVGFab3A0WjQ3?=
 =?utf-8?B?UktmWlQyZnlyTTJvUVVWNFVUVFZjTWsvVE1SRlpIOE1kQzJTTDVEUWQyYzY3?=
 =?utf-8?B?ZTBWenNIdkQzK3JhZEU5MzNGaC8xV2Q4anR5RnE4NEFjd3FUUUYxWmRUWnVC?=
 =?utf-8?B?UUIwbGNENzhTS0ZSczlKdm9EWUplMXlEK1A4ZWxDWXFlaENxc3FwUThjSnZk?=
 =?utf-8?B?dXZZbngzWVZPTDJxM0lvR3AvUjRkdGx1ZmNMcGRvZm92OTc1Z1JxWE4xUzFG?=
 =?utf-8?B?aHI4b2REUnhUc01oQnREdVBRQUhnRXpyMHZSVHhYMFJVZ3ZDQ25EOEZ5Si9y?=
 =?utf-8?B?WmRUeHVuUjdCeXVONjlpZ1NwYzlHekRCOGtSdzZ6Q055Y2NlNGlvMWgySGRa?=
 =?utf-8?B?QVlBdlJ1SHByLzRpRW41bmFxZytBOGxrdmc2SUhwcGczZXBydldwRnpOWjRu?=
 =?utf-8?B?QVhlVTlmQnIzWHhOZkxlcDNEc3Z3QWE2NDdqN0JmUzNDcEZYa1JDOXh3ait3?=
 =?utf-8?B?TDZpZkJreE9QTEZvOTYzbW5GcVpyUHNsMW4xZjRXS2s2WUppMlp0d3FuamV4?=
 =?utf-8?Q?h9QsOXePFhVoI3Lv+MedQRE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 902553f8-db7a-458f-0c0d-08de3cb64d7d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 15:18:01.6326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibzHI6aZisC8ek772CXzaz77hfXTQAOVHG6j/FhOdvNoA0UqHLGI6MNvzpnmqw+6Hu1jpoVSEGy1rO9gpN9+riYlY6YeyvDqOMmaNurTJn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9376

On 2025-12-15 13:24, Thomas Gleixner wrote:
> When a time slice extension was granted in the need_resched() check on exit
> to user space, the task can still be scheduled out in one of the other
> pending work items. When it gets scheduled back in, and need_resched() is
> not set, then the stale grant would be preserved, which is just wrong.
> 
> RSEQ already keeps track of that and sets TIF_RSEQ, which invokes the
> critical section and ID update mechanisms.
> 
> Utilize them and clear the user space slice control member of struct rseq
> unconditionally within the existing user access sections. That's just an
> unconditional store more in that path.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

