Return-Path: <linux-arch+bounces-8382-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FED79A720A
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 20:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFCA7282E9D
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 18:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC7B1F8936;
	Mon, 21 Oct 2024 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iwalgQxK"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B330E1991AE;
	Mon, 21 Oct 2024 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729534377; cv=fail; b=aInriUwoc7r6foZSnX0LG1Xs64oKyw52LlIR7LNWxk65EC4MAdVGltWX8ecEeBKH3i2ggloMdqRy7oO2flWvU+OW6z0v9QJtkRzJg8sdQmm1Km/FqAJGf5yxQv+9UpZsJe3LtM7u2nACflLkpohKAJD3j3QHmdORCY2GtySLJ5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729534377; c=relaxed/simple;
	bh=sBXTHVzf2a1OH0E1JPaXRiGKFSPuyIVrWTij6B0+vZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u8fLMeNQXGZOFxnok38ZcKOvV19XNLkzBYGpyaWHbRTwo8t9HQTdlmeoPhmU50wnIJ7ME+bL29qhx50aZ/ibrLiK+EFW1Mrct9B51sF/6HPFUARq61NPKemUPjv1wtZcgTssSMjzROC6agzJUpInO/kon/EaF/QHp0Xw00dINSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iwalgQxK; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sToiMXhWmdGU9CNbGTbiO9jEKXhyB9ys0wwc+KiQV0h4YMAc6UG5jLjbTA3HWIfBZXxYWrTBzd2PqO/S7uIGm6S0c0yY5hawXZUwFMzONFd6lAKY3jwj77Ri4Nm5tZXodmhl803z0Tf6kvT2DhoDu4QySp8kBS+tMC8zCbvJKVyApARIhuL/W85/MRvj6Jwj4xK4kdOZsknBDSVSggj+Pa0Tr5XZxBqEYJq+wxMz2L69V8/2zhmV3wnqfBlFF6VQf8Sai/XCmkfxOkdJ3FZvuZw7/K2yhTsdTiIZrHf4gXZpdaEW/7ct2IhpE420M9rTJesb64ObAGkMY8np5J3tiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lBcmYQ45pe5xV772KWwOhdZxCGYv5Mn6uzzeUbMyIk=;
 b=RscFT/xkN+EPI+ZW7PSrNEG9SVUAYqKwpuNgg9lUGHrSaCfsmLxjBvR5HzD8vUa5Y1pf6BgUGXUM3PP3faKPwlTPIYOb2SCZLE4G9c/6UWzSnMPBDFRTHCD+VpI3lAYsQOqlQv+Mc6aWZSBVcgnzSsGzxxGb9IvuiqJ6A6jB17/2f2yNCgIPT0h9SGQ4mxSmFMjKHrsXkaoMjsouRqxMxnGAiSERctI7CfJhbmJmMrMcCIUSxuIRcTVKnhHTUKWnFKP/TUEj4cItpGgoIhxp6Q+/RNstHxDYqjSQqqObeDP34NEA5sW3W9xCUqFQtZSvl6BZjuF63X1XoI1YVdiJfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lBcmYQ45pe5xV772KWwOhdZxCGYv5Mn6uzzeUbMyIk=;
 b=iwalgQxKrsBVvHDQW2yQkTm39TrQ9X6of0b9wsrVC+IXtq1aJWauq2u+aKNOOyE9QOUSD14aydYP9YpGqsNAdPJVXSdLgle5xDbQV3eobqVattNHlpniZs/49mv/VYVieTvgZNFMwzVJOjHhHiliVacHm+xE9/8BZfkFPaOjaFAQj5B6L81bBipbwWmK1WfWqbCbfiSmkgwpgtiLw0iuMYoy4QGWFSdXosmTmJ7FMXbF8J92TPvwadYMbR5ZUR5NTnw9xkgpfcE+B7aoJNQ/571+SqOjP/O5+0dY3T+1fXdwLOHarMYsHXKqy2AzedQVri3FDSjxPwzBbiRAg/UHgw==
Received: from MW4P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::23)
 by SN7PR12MB6743.namprd12.prod.outlook.com (2603:10b6:806:26d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 18:12:51 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::62) by MW4P221CA0018.outlook.office365.com
 (2603:10b6:303:8b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 18:12:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 18:12:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 11:12:34 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 11:12:33 -0700
Message-ID: <47da3771-12d4-4621-a22f-3756d1b692aa@nvidia.com>
Date: Mon, 21 Oct 2024 11:12:33 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] alloc_tag: config to store page allocation tag
 refs in page flags
To: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
CC: David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>,
	<akpm@linux-foundation.org>, <kent.overstreet@linux.dev>, <corbet@lwn.net>,
	<arnd@arndb.de>, <mcgrof@kernel.org>, <rppt@kernel.org>,
	<paulmck@kernel.org>, <thuth@redhat.com>, <tglx@linutronix.de>,
	<bp@alien8.de>, <xiongwei.song@windriver.com>, <ardb@kernel.org>,
	<vbabka@suse.cz>, <hannes@cmpxchg.org>, <roman.gushchin@linux.dev>,
	<dave@stgolabs.net>, <willy@infradead.org>, <liam.howlett@oracle.com>,
	<pasha.tatashin@soleen.com>, <souravpanda@google.com>,
	<keescook@chromium.org>, <dennis@kernel.org>, <yuzhao@google.com>,
	<vvvvvv@google.com>, <rostedt@goodmis.org>, <iamjoonsoo.kim@lge.com>,
	<rientjes@google.com>, <minchan@google.com>, <kaleshsingh@google.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-modules@vger.kernel.org>, <kernel-team@android.com>
References: <ZxKWBfQ_Lps93fY1@tiehlicka>
 <CAJuCfpHa9qjugR+a3cs6Cud4PUcPWdvc+OgKTJ1qnryyJ9+WXA@mail.gmail.com>
 <CAJuCfpHFmmZhSrWo0iWST9+DGbwJZYdZx7zjHSHJLs_QY-7UbA@mail.gmail.com>
 <ZxYCK0jZVmKSksA4@tiehlicka>
 <62a7eb3f-fb27-43f4-8365-0fa0456c2f01@redhat.com>
 <CAJuCfpE_aSyjokF=xuwXvq9-jpjDfC+OH0etspK=G6PS7SvMFg@mail.gmail.com>
 <ZxZ0eh95AfFcQSFV@tiehlicka>
 <CAJuCfpGHKHJ_6xN4Ur4pjLgwTQ2QLkbWuAOhQQPinXNQVONxEA@mail.gmail.com>
 <ZxZ52Kcd8pskQ-Jd@tiehlicka>
 <CAJuCfpFr2CAKvfyTCY2tkVHWG1kb4N2jhNe5=2nFWH0HhoU+yg@mail.gmail.com>
 <ZxZ_99yLDhRMNr3p@tiehlicka>
 <CAJuCfpFk+1R8JQc+w6r6NUDsmjFnh9K1_42AvG+qTZq4vimwKg@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAJuCfpFk+1R8JQc+w6r6NUDsmjFnh9K1_42AvG+qTZq4vimwKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|SN7PR12MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: e57a546d-b449-4354-022c-08dcf1fbfa11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDBrcVBQWjRyTG1TTW1sRzk1MjBEbENkVnlobVpXVCtsUVFBeVhqYmxpdHRw?=
 =?utf-8?B?NG1HOEtabFpaSS9HVGJMK3F3cWxzN0dzTjExb0R6ZDd5cW85YXg1UHNuUlBZ?=
 =?utf-8?B?a040RU9IeHhCUjdqeVVrd1RQV1ZMK1N0UGhwa3cwQk5xbFNSOXY0T1FxeVJP?=
 =?utf-8?B?SEdmVTV2REkzNVg4NDBYM2tGd1ZaaTJqUDFPckEwbHc5VmlhdTZ3ZDA4ejNa?=
 =?utf-8?B?RFJWMTNoVXNTS010MGFDenoxNmJBcyt2RHBQaEdvWHZmTjdkU3F4aDlqOFU5?=
 =?utf-8?B?WE9Ta1Z1US9CVVZ6MTR5cnBWcFd1VVY5V3M0UHRqSkNoalZaVXM2NHRFcFF0?=
 =?utf-8?B?cGFocWIxMUgzaFZWcWJkOXZXVndhRG13Y0lTMlFaNmVMalJtclplWDJBMnNB?=
 =?utf-8?B?VTdSeUM4UlhjSHVwNW5Gd2s5d0Q0eTNxUGVqR2xqMkVXdERTZ3dGLzFTdDFR?=
 =?utf-8?B?VS81aEgwMFd1cS9ESVAzV2FoMWNWcGhxc0dId2dKSFU1elcveDdiT29tb1Nu?=
 =?utf-8?B?Q1VmaTBKM1kxTFZtNElmc1RvWUhLU0FVYTl6WTg3cktWZmxiY2xVMUZDWjUz?=
 =?utf-8?B?eWtyVjVINU5hbHBoa05vTDZIM0ZzT3hacWo1bXVPbHAxb2J2UytKUkdObG9x?=
 =?utf-8?B?Y00zWThvZ2p0RVZRQlZxUzEvak9Hd09mdnRjTXkrd3dkTExHR0Jhei9acHpN?=
 =?utf-8?B?bXRzODBIMFRFc0NRbHJGWk50eWg1MDcvMDE5S2x3d0lNZjl3cWVvYmczMkpU?=
 =?utf-8?B?ck1Ma2JLTU1hOXhwY1kwS01jVWRoVXZRSWlKY2pFM0U3WlVvMkRGcGdveTJE?=
 =?utf-8?B?T2FQaW9zTE1aQjJGTE4zdzNCZzdoeUhqMkc3Ym9XZXY0M1pFZlpJRGQ1TGFl?=
 =?utf-8?B?a1VaRkRIYlliK3U2WVZqTHB6ak5EWjMrSGhkVmYya200eWlFc1Y5dEM5N2pU?=
 =?utf-8?B?YWlETjVkci9obnM4VjJZWXZzNTIxdS81MnBIQzBTeUxZcW01RnZHNFNFZ2N2?=
 =?utf-8?B?ZFdZRmJRU2FPazZIVG5kLzAzV3BjcmhBQWhoZURtUHNHVGpqRmZmcE03N0Rk?=
 =?utf-8?B?a0dvM2dhUGNnekdZSFE3OElBdThMcEZBV2JWQ040ZGdJMmZjdGJSRmp0RFJt?=
 =?utf-8?B?RnFQcGJoaXN6NlltR29sRk5aWVY4aE5PcCtFNzE3QlpEdk5hSGdRa1FJcm5R?=
 =?utf-8?B?Ykp4U25pUjltbmQwY3ZUZFkxZmJEVnROdUdFbXJyRG1VS0p6WlI3Y1ZDZVdQ?=
 =?utf-8?B?TUpIRlFmRFJMS3NBeEdWMWxjN3Ztb2orS25pN0tOOHorWndCcHVaWUtCaU9u?=
 =?utf-8?B?WTZ3bEYvV2UrVlNDcEJ5aWpNM1BLUmVQVzI3N1VHUCtacWh3emY0c2VMZmJO?=
 =?utf-8?B?WHZ3eDlubFlkWXFNSlNoei9IOHF0UDFKdUQ5KzNmZzlsd1ZFVXdyZElBaVBL?=
 =?utf-8?B?WnFrZmFxY2l0R25tYUNxNmd0dkxwYmlVSys5RG9zd3M2RGNGQXJUelBqZDZn?=
 =?utf-8?B?QVNCL0JTNENoV1BtWUVoRDFPL3p5dGVRdTBOZjVNbzgzekpVRVU5MjExK0Rj?=
 =?utf-8?B?SUtTR0hMZEYvTnA2UUlKb3FzVTdtWmQyblNZeWI0eTNmR01BWmU2ZWlIUXow?=
 =?utf-8?B?NSsyS3FSTDlZelNSL0d0QklSWnpxL29lYVA2VFR1eE9UdXNyTHJ6dzRtaVBk?=
 =?utf-8?B?eUZsdVhXcFVHR0w1WEtxWHlJL3pMZ2xScHhJLzhQUzM5emg2WlVXaVkxMCtD?=
 =?utf-8?B?QTUzbmRiYVRuVnBiVXlWeGlpV0h5VXVvM0dMdWJTUUw5ZHZmaXlhMSszRExY?=
 =?utf-8?B?ZTlyOXlweTZ5YUYzUURCL1V1b2xBNmdmUzF2WFJPRVM2My9VemxydWIzVExt?=
 =?utf-8?B?Y01Mdk1tNUYxRjJaMEIwRHNaTUIrRnhxNzZ1dFkxWCtIdUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:12:51.3490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e57a546d-b449-4354-022c-08dcf1fbfa11
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6743

On 10/21/24 9:32 AM, Suren Baghdasaryan wrote:
> On Mon, Oct 21, 2024 at 9:23 AM Michal Hocko <mhocko@suse.com> wrote:
>> On Mon 21-10-24 09:16:14, Suren Baghdasaryan wrote:
>>> On Mon, Oct 21, 2024 at 8:57 AM Michal Hocko <mhocko@suse.com> wrote:
>>>> On Mon 21-10-24 08:41:00, Suren Baghdasaryan wrote:
>>>>> On Mon, Oct 21, 2024 at 8:34 AM Michal Hocko <mhocko@suse.com> wrote:
>>>>>> On Mon 21-10-24 08:05:16, Suren Baghdasaryan wrote:
>>>>>> [...]
>>>>>>> Yeah, I thought about adding new values to "mem_profiling" but it's a
>>>>>>> bit complicated. Today it's a tristate:
>>>>>>>
>>>>>>> mem_profiling=0|1|never
>>>>>>>
>>>>>>> 0/1 means we disable/enable memory profiling by default but the user
>>>>>>> can enable it at runtime using a sysctl. This means that we enable
>>>>>>> page_ext at boot even when it's set to 0.
>>>>>>> "never" means we do not enable page_ext, memory profiling is disabled
>>>>>>> and sysctl to enable it will not be exposed. Used when a distribution
>>>>>>> has CONFIG_MEM_ALLOC_PROFILING=y but the user does not use it and does
>>>>>>> not want to waste memory on enabling page_ext.
>>>>>>>
>>>>>>> I can add another option like "pgflags" but then it also needs to
>>>>>>> specify whether we should enable or disable profiling by default
>>>>>>> (similar to 0|1 for page_ext mode). IOW we will need to encode also
>>>>>>> the default state we want. Something like this:
>>>>>>>
>>>>>>> mem_profiling=0|1|never|pgflags_on|pgflags_off
>>>>>>>
>>>>>>> Would this be acceptable?
>>>>>>
>>>>>> Isn't this overcomplicating it? Why cannot you simply go with
>>>>>> mem_profiling={0|never|1}[,$YOUR_OPTIONS]
>>>>>>
>>>>>> While $YOUR_OPTIONS could be compress,fallback,ponies and it would apply
>>>>>> or just be ignored if that is not applicable.
>>>>>
>>>>> Oh, you mean having 2 parts in the parameter with supported options being:
>>>>>
>>>>> mem_profiling=never
>>>>> mem_profiling=0
>>>>> mem_profiling=1
>>>>> mem_profiling=0,pgflags
>>>>> mem_profiling=1,pgflags
>>>>>
>>>>> Did I understand correctly? If so then yes, this should work.
>>>>
>>>> yes. I would just not call it pgflags because that just doesn't really
>>>> tell what the option is to anybody but kernel developers. You could also
>>>> have an option to override the default (disable profiling) failure strategy.
>>>
>>> Ok, how about "compressed" instead? Like this:
>>>
>>> mem_profiling=0,compressed

Yes. The configuration options all fit together nicely now, and the
naming seems exactly right as well. And no more "you must rebuild your
kernel" messages. Great!

thanks,
-- 
John Hubbard

>>
>> Sounds good to me. And just to repeat, I do not really care about
>> specific name but let's just stay away from something as specific as
>> page flags because that is really not helping to understand the purpose
>> but rather the underlying mechanism which is not telling much to most
>> users outside of kernel developers.
> 
> Understood. Ok, I'll start changing my patchset to incorporate this
> feedback and will post the new version this week.
> Thanks for the input everyone!
> 
>>
>> --
>> Michal Hocko
>> SUSE Labs



