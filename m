Return-Path: <linux-arch+bounces-14685-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 410F4C54808
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 21:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A106C347F46
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 20:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE5C299AA3;
	Wed, 12 Nov 2025 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="VqXm1vWH"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020104.outbound.protection.outlook.com [52.101.189.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD8B28152A;
	Wed, 12 Nov 2025 20:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762980395; cv=fail; b=uJ7zUefQH4WqOEmhkDSLC6VikGrPQnsXuBfBqc7EGdaRtxfQIUCz62jK7JkS4v6ENL+MtwdRDq1ESXC4pIa8dGMsdK3sKSNfwuteP4MJVr4mhC8w7IpCeYdQUwi6xZ3fzdfFNauD/JHvT42xD8NQPUS1oMdg6vVTCzDTcGs+Lpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762980395; c=relaxed/simple;
	bh=C2hR0fifB/ejcwVYPgFje8LRMYy7eQSskdSoxFe34Jc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p3O61wZ6tUfKY9CPYntn32QXGgdZobe39vc6EDymvbFdJqwAMK/kWFyKwrzzjofqqxHxMFlobYfaKFmUvxJ1/QFB5phZh7x9PodWxfzZhCrYzBXz97mBJncmbbTRY2w12kHuh6NLCcxw0ompyOtB9KqYsvr2G38hz7YZPU2nVko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=VqXm1vWH; arc=fail smtp.client-ip=52.101.189.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxqWcrWyq8zqEopSRAjSXU/cUfL/5ZBbdZ6IAwgKFdG4q9iCEpwMTRI0jhkceuPDfPr0T5qPe6HfuklXGu4RbDtezt1rWfGL4VzWkrVxAxeCN2//6CD9qgDtNlm+wt3cIF6K1bs0PG854jS/w2r/8kDieQkl+2p4yxO8FSh52cq8fvoYTLfp/wv4mHkqzx7yyjwkrzBsAjwAl5O1kT3wh9Ht/0rjqboFmJv9OhY6VWH8tC4GBn8Tb8X1tN1DqMczw48+pRYEWqjLc/IyidIapFqoloDPBDS38j9zff6RZz9T7hHLXXzeeTIQllyca21oB/zfUc3sPwNp0DMOU+Vm2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FcUm0qeTab3S91626aXJAOkj6Nx5357AoPkCl61G5U=;
 b=XqtnCtlQu6fonBKwFOU2O7aEqDoliwEz45is7jrcNt78VEtCOxpt3BrjS25sHQy6hwbf7Lu6wIoFWw0QVRkiKMpVKDLp6BZiWgFMLLhqQfA9C1AAgBiSuacIhB0AC+mMoYwkZ2dK44BhIBoMmsvPHNi96mbGXP8oTlwZ6ybGE+7osTJpXrRj2kQZi2W10WXhcYkDV1LgyChTe9VUYxf0Am53uLT/PLFjZ1aBFwAKMKNFWSeIJcrw/jYHVrf6mnpDlaQfSs2l7w9+STpa1OO+6yTNrF9UWYDYRW70lEF7gFn9bXCzcRGMMBlv+I1vCjXLn7eG+KPC8D43VNljdoW9Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FcUm0qeTab3S91626aXJAOkj6Nx5357AoPkCl61G5U=;
 b=VqXm1vWHR2QSXt/G6/6S4mi7HbCV++0HWW0RC2xWw0CX3/+Zw7PfFSd4sRSKJrU45GU93V3uAmbpW4R07A/Z95A10nhfdnhAfHJUKls1eBujs7hzzhuEQE0GLQjSrUQJBxhN52/EGs78LQSSxnmUd8oJLuagPcVveh30jtTlCgESEA4A4Tixf1Er+0s2YgSrCliZEM8Ta4DaprVi9mpGCq2PTc0Wk1S5a9EklqOrIpfH6MykfilKSrNUxRyL6VO/MmlR25gcnDSBW+Q/qEJ4MgQJfZvk/bBfVb7IxZMQoNbGyL4/5cl3l+pXFE/aJWsRr17rwc0eujpnKKcYMQcLnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB6252.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 12 Nov
 2025 20:46:28 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 20:46:28 +0000
Message-ID: <3a0f1467-7fff-48c6-b0d1-772917cc6143@efficios.com>
Date: Wed, 12 Nov 2025 15:46:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 00/12] rseq: Implement time slice extension mechanism
To: Thomas Gleixner <tglx@linutronix.de>,
 Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20251029125514.496134233@linutronix.de>
 <03687B00-0194-4707-ABCB-FB3CD5340F11@oracle.com>
 <2eee5e37-e541-4ac7-9479-cef3e62f234d@efficios.com>
 <b28c9f26-7a79-473c-a390-f502b74b02ac@efficios.com> <87ldkbdmbu.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87ldkbdmbu.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0157.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::6) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: ca1bede1-027d-44ca-dfc4-08de222c8d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUY3U1hXbkswREc0Z3BLVTdHMzVxL1RHOGI1aDBzSmlWSW44RzFZSlgyS3gw?=
 =?utf-8?B?ZG1BdmEzb2FaV0lCeDVMZjdQemJPOVRCRzNucEhXdjJVN1VXMi9xVTFIK0Yw?=
 =?utf-8?B?aVhXYmdqTG8yMzZEaVY1bWJLdGUxNWFFcmFDTkM2YzBkdGQ4V0g4UmNnV3k2?=
 =?utf-8?B?ak96VFRadEJKWHhKQ0xZbDFCa0dJaGIxUmFFenRUaHJHamdydEEwZlNjckdB?=
 =?utf-8?B?Nm5vU1JsKzUveENsV2dwZFVXYWR3bnlyYjNDR0N6YVVCaUpHQ01yaXkvYzJk?=
 =?utf-8?B?M2Z0UlRoQnFFMndkcks5K1lwUlpSOEZQWWtZTGFNbnJjV2tJcGJZVXBVTGNz?=
 =?utf-8?B?S1RZL2dHNW8rQ04rYU1PS2NCcmhzT1EvZlhCK3NCelBSRFN6bytNcHo4bFZP?=
 =?utf-8?B?ekJMNFVQLytIWGsxSGZmbndKQVN4MVBwUGRodnRNZzVVaTNYQ2lMemNLc2tH?=
 =?utf-8?B?d1R1WS9tNVpYOW05VU52TExYVytvTTE1b3VOL0twNlZNMjZ2Uk1sMUd1U0xr?=
 =?utf-8?B?OURWSHNybnlvSnh2ZngwNDg0dkExNTRJMWZqZ1dLaWtDUmJsbmtHNkZQUjF5?=
 =?utf-8?B?RUVOYVdRcWM1ZzVWNm9IMmRibE1PeFN1OVJiNVF3bmw4N0FUQWJQdWF2RDd3?=
 =?utf-8?B?SjZlODZqV1h6MTJMWWlYK0QyR3drbmJrdTJXVnE4YW00Zm4wZU4zNEV1bFdI?=
 =?utf-8?B?cEUyam1YVzFvdm51OHg0QTVqYnFRMlpzdHNQOWNtS0I1RnJnU28xSlF4ejhI?=
 =?utf-8?B?YVV5VENyQnZiL3J1ZkRpTCs4YnJPR2NTVWJqL0N4d2lMYUpFdFo4NTNCakkr?=
 =?utf-8?B?UHJjSlkvVjVwakVISXM4alFzN29URVY3U0RUa0RHS1BWR0o1clkrKzJRblVx?=
 =?utf-8?B?akw2cXUyb0tIK3JtSnlkcHZZczRrL21nclM1dXlneEVtM0JabWhWMS8vR1Q5?=
 =?utf-8?B?RHVvNUd0U0lXN3hEVGJQczc1Y2dadm9lYU1PMkdoaEtrOURrZS83M1ZHVDY4?=
 =?utf-8?B?UkwwenBQRDAxNkFJdE0wZ0xJQkZ6emtoeWgxaHJRRW9jSEMrbVVub1dGQnQ1?=
 =?utf-8?B?QzlHRWxDY0VFOXYvajJtU3VzdWRibjZvZWkvaDRGallHYU05SEtrc2IzbEJo?=
 =?utf-8?B?ZXZ0S1E2T0tyYS9RaU5UZm9MemZvRytyK29lVHhseU5jak8zdFBOTk9QUVUz?=
 =?utf-8?B?dWtudmpocEpsNzVnbmh3cGhFc1NmbktsWDVWWlQ3aDJBUGw4ZVNSTGtsQmRG?=
 =?utf-8?B?UmsyeUVBYWljOGpsUEVueXJaejF5eWZpZ0svTGVreUhlK2VMMjY3bkg0bmNk?=
 =?utf-8?B?VVZobzlSKzFNQVpFYUphUE1JcWNEUXJkVEx0WCsxRVp1MnpIUDJWcnBDMU1E?=
 =?utf-8?B?QmlhT2FYZ2F1SGdmYUtUS0Y2TjRvR0pKTmF1RTNuLzJSU1ZLZGFKMS9jeG5T?=
 =?utf-8?B?TDVtS0YxM1lQeHdIdCs1d2ZXQ1JTeW5nWTdEQ25lM1llTDlkTHJ3R1lOVmlS?=
 =?utf-8?B?YlIxT2hoelNqV2xwNlNmMzgrcmtqQ2U1L0VOb3ZtU2ZGQnpsY0FBL2c5aDlr?=
 =?utf-8?B?clFJZFVRT0VtOE5vWTZrdTk0SkhnTEh4Um0xRWhvakpjRUZxNjFBWmRhZW8y?=
 =?utf-8?B?VUgwT0hZbVVpR2xPRkJSUEFBSlh3MTdVQjFGWjNyWlRVbzhDT1dhYkhvR2Rj?=
 =?utf-8?B?aTA5OTlPdTQ4WkhnWlFwMVZ1Nk1HV2FOVWswdTcvVWMvYzRzSEpkQzhRVXlu?=
 =?utf-8?B?LytFeEFOWXNSOTcrK0J4MGVnVGw2QklMZk8zYTB0cElTVWZvNC9aZS9RTFRS?=
 =?utf-8?B?V2FtcGlkenFUUVI4Tk1nOTN4TVUyS0pISjFoZUJFTnZNemZqeDJVVXI2TVBL?=
 =?utf-8?B?eVJ6YVFXaU5ZVm03NGI0clRZUEpXT05pcytYUWx1NHdMNlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmZSOWVOTWFuMDFYRjlyb21OOWNPU21DaWFuODNhU2I5M25rL1VKNktrK1h6?=
 =?utf-8?B?NU1kakZKTkwwc1NLMnZnZFIwZ0tvelZ5enJkV3diU25yL280YndhcFdZSmpV?=
 =?utf-8?B?cVZXaXd0aldNUUpiRHgxSWNUZm42UGxXblJPL1ZwUWhoRGVFVVI1MmJJZzRy?=
 =?utf-8?B?MHdlcVd6ZEI0dnpqd2ZJa2dNTUJEbFhkMlFBYS9xcnRURU9TYVFXQmxrY1k0?=
 =?utf-8?B?My85MnJWeTZPclYvMzhIUis1bk0zNFd5K0E4eGdiZytWdkoxNmM5TG4rcjQy?=
 =?utf-8?B?eDBxZkoxa1lXTWtobUlOYTMwVXVSOHZoaURPQ0IwTGVCKzBUMDhhVk5BN3VF?=
 =?utf-8?B?ZFZWeGZXMndWNGlYWFB2d0xNU213YUpOdWdnQ1d1VVFOMVJqMzI0Q1E2bGFX?=
 =?utf-8?B?azRKUUI4bkpKWm96Z1VlNzMzNkRSMC9IVVdyL3pVQVlSUHFGWHZDUTBSc3c4?=
 =?utf-8?B?b3RGR2N6eGpuaTlZYzZMR1p4OWp5a2hnam9zOFZveTdTbEI0TW5xNGZBNFlU?=
 =?utf-8?B?MW9BSW5jbGJRYW8xSjY3bmdLekt4bUMxUnZuVVRpNzFPUFpjT3Z3THVEYXQw?=
 =?utf-8?B?dDVRRUVtdEJQdHl0NVY1NTFGbGQrY1RVMkIyc3dEMnN3SEtsVE9KcVc5emNo?=
 =?utf-8?B?aE5wQm5YVk8zTDNqRGtpY0F6U3lrKzJuNHFSMklBV3RyeEtIUUlsejRJMmF0?=
 =?utf-8?B?Vy9hTjhRVmlWOUFWcmJqbGhLNEJSQkxiVHJLbnJMaDc0OWozYXRzK2x0THNv?=
 =?utf-8?B?SjRGZEFzTUt1U2tuMXVraWJ4Rnd6OW04UzNWSXZYVFdac2NnNGl2dXBnNndB?=
 =?utf-8?B?TjQyUWVMRWVwdmQvTFd2YUd5eVgzWlI5M3A4TVdTaTMxRUQ3V3ZGL1A5MzQ3?=
 =?utf-8?B?MjRwdE5iNmFSbHU5eWttRWw2ak9yL1B0cXN0akhaRHR1ejJGV1FuZ2x6MUxL?=
 =?utf-8?B?QUxuRkw3VGpKbUN0YmRKdE9RQXBreXFGcUN3cVlTU250S0YvRXl4U1VqdlVG?=
 =?utf-8?B?dUpoMmJDbDFtNVl6MWxCLzhsd29wMW9NWWVtaFFlYnJXdmtLeERzMEtpbTVa?=
 =?utf-8?B?QlRYSmxiTnY0eHl4dkF1TUEyNXQyMWROcTl4cHY5ckNWZnlzenY5eTI3c0Yy?=
 =?utf-8?B?Ti9QVGh6MnhrTC9PY3JXUTFCNlhFSGpGWG9NUDg0YVBlRFVDMmQwQ3RvMEJG?=
 =?utf-8?B?RUd6VkIzdXJZMXNQNE9JYlN5dWluaE1qN2RiMUl1VEtyZHVMeVFXbDNEUUhU?=
 =?utf-8?B?amEwRjIySmxkbUt5VTNFUU9wbzUxZlJxYzNuekVNcFVObTk3M0RZbnhIUEkz?=
 =?utf-8?B?SitUVnhIcEdtd3NzVExONGRWLzl5ZzFSMlNGUHJYaVN1ckNnVXRLWERMUzVn?=
 =?utf-8?B?Yk1rY3AzM3dvSVMxT3J0c1phOFZpMktzdldDWlBTUGZDN2YrMnBnRm9HZWVo?=
 =?utf-8?B?aHF4ZmxsUkVURDlGQWd0RXkzNUZWV1M0a1FIdzlIeGpQUWRDLzFweUJYQmg2?=
 =?utf-8?B?VkhHK05nU29vSXBjaFl3cFF0MHdDYUhLQTlqYWZDSmhjRk84SHJBT0hKVStI?=
 =?utf-8?B?SGd2MDdoZmRQdjg1emF4cDk2RVlsWm9YRXlNbWVOQjBDVVNYcjl2QlBYNkMy?=
 =?utf-8?B?MmxNeTRCTVhISlpEWHdHY1pMWjhVdTMwTmNFdE8xUVc0MExZM3F4eCtVRHcv?=
 =?utf-8?B?eSt1UDJpSktrY2xOZ21NRTFqeGdCVWVhVVErQVk2N3ZoTFlHb2NJd0pBbDdh?=
 =?utf-8?B?N2VCY3hoajNKZXNIY2tjbUhTREUxeHBxeUk3dlhCdlVOVjdwaUZ5Um9sSkVW?=
 =?utf-8?B?Tm44bGJmYytDMm9xOUhJV0kzajdCS094TS9XcEQ3akdDTk04YWNpeFhzR1hs?=
 =?utf-8?B?VHdIN2ZZbkliMmF1My9RMFE3eHlOWUR4ZUdUcWNYRTN4NzVVYXJTU01rSGJF?=
 =?utf-8?B?VDhrQVNsM1g2V1diTHZ2czM2UU9jYVBNcVJVQUNhME92N1lXazZ2ek5DOTNJ?=
 =?utf-8?B?ZXZBWTZGZnkzRUo5SE1Hb0xyeThJZURNU3dCc1gyL2s4U0xhSFFUVHUvSWdx?=
 =?utf-8?B?T3NYNmkybERXTWd3R3dkeTk0MkFDNHlMT0p3T2pxZXJYeHMrVnJ5Y09tU2NT?=
 =?utf-8?B?YklWNmlxcklMdDhHOUpXQkpOaURrRTN0bythamlkaElWOFpmRVlZdEdFVlpO?=
 =?utf-8?Q?RGM0OmHaPS283fLyuoLwbFE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1bede1-027d-44ca-dfc4-08de222c8d4c
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 20:46:27.9947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ul5INYL3HRIBBPPKXuR/96qN4oViZhz5lMIvEvAF8jyXhhEsfQd4JjFdrrOxVzFTEX7AgHd+3YOFCrBtjvtAQa5ErqNR+RfVVObX7A4FBWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6252

On 2025-11-12 15:31, Thomas Gleixner wrote:
> On Tue, Nov 11 2025 at 11:42, Mathieu Desnoyers wrote:
>> On 2025-11-10 09:23, Mathieu Desnoyers wrote:
>> I've spent some time digging through Thomas' implementation of
>> mm_cid management. I've spotted something which may explain
>> the watchdog panic. Here is the scenario:
>>
>> 1) A process is constrained to a subset of the possible CPUs,
>>      and has enough threads to swap from per-thread to per-cpu mm_cid
>>      mode. It runs happily in that per-cpu mode.
>>
>> 2) The number of allowed CPUs is increased for a process, thus invoking
>>      mm_update_cpus_allowed. This switches the mode back to per-thread,
>>      but delays invocation of mm_cid_work_fn to some point in the future,
>>      in thread context, through irq_work + schedule_work.
>>
>>      At that point, because only __mm_update_max_cids was called by
>>      mm_update_cpus_allowed, the max_cids is updated, but mc->transit
>>      is still zero.
>>
>>      Also, until mm_cid_fixup_cpus_to_tasks is invoked by either the
>>      scheduled work or near the end of sched_mm_cid_fork, or by
>>      sched_mm_cid_exit, we are in a state where mm_cids are still
>>      owned by CPUs, but we are now in per-thread mm_cid mode, which
>>      means that the mc->max_cids value depends on the number of threads.
> 
> No. It stays in per CPU mode. The mode switch itself happens either in
> the worker or on fork/exit whatever comes first.

Ah, that's what I missed. All good then.

[...]

> 
> There was an issue in V3 with the not-initialized transit member and a
> off by one in one of the transition functions. It's fixed in the git
> tree, but I haven't posted it yet because I was AFK for a week.
> 
> I did not notice the V3 issue because tests passed on a small machine,
> but after I did a rebase to the tip rseq and uaccess bits, I noticed the
> failure because I tested on a larger box.

Good ! We'll see if this fixes the issue observed by Prakash. If not,
I'm curious to validate that num_possible_cpus() is always set to its
final value before _any_ mm is created.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

