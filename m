Return-Path: <linux-arch+bounces-6995-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F9A96AE67
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 04:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3394D1F25888
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 02:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA37B38F91;
	Wed,  4 Sep 2024 02:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HDQtA6x8"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E807BFBF0;
	Wed,  4 Sep 2024 02:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725415578; cv=fail; b=XFhFJLnm/HARHeTcpC3ECOGm1oQoEhLMZhDA+zZ2+ZkTP++/CGvCxAorQaqi5tSjIH7zjIRvTqLKNbDPFdYYaZ4dV/egf5lST9IUPJOsTXnY94CNnVWGGHw+64kCNWy9A4UJrPkMh5CzUfq9vphSDwhponacvBZsfW2onSeoLSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725415578; c=relaxed/simple;
	bh=mwKFwvIJRXmjWuu/AJaoq40/ah75a10JPVmAMawvBJw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=WAVTL3RaB0dasjRrqstqijmX+gxFViqbuY3bE2XPTHewMNQESA6hopUbMqzz0Cn0v6qZhIJW6KeVNUqdf+a9ZmeW/7wVYUF7Sl+V/qLRCSGJJGu9nQxzW8ZyGW9EQ1ecHTBOr1M/rqLNjZ3P6kwG5jL2NqiZpxg2TniDm6YSNl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HDQtA6x8; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBmd3VYk05pCjgRLBIIenr/MnoKXBtXOTPvoYYnjy5o9QcEvAjIKfnwrw2Vri59vRRcqqXQVnc1RwAKRfit2MVsj4zdWMKmCWGd0rhcbQ1muhZDm03lsnJuk3nvuphxOGX3sZ2IrmUF2CEm2x0u3nVLarMjuchdOrsjCTDcuEreFrQRxD/xXC+nI3AoyBJzuVtMeH4qwjr8gKH/cicoTn3fmR+koLmlAs+5m4YB/IILEAZVolAlKI1wQ63WBtoW7TPgPoRfr4hCWc5pHQJuQ9TSR2l9PrS08GFz0wHxGFrdCyvqU4lNQfqUxMn3U3LFpsIs1yfjIZBlj4/w/nYH9qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzQcsiU1rmq1/r+nMBf4+oJmNzQPJjZj6fJAarFPbvk=;
 b=ekWO2Zpo/8Pce2scCBxG4AIgcQUlJs2ZQVHHdIvTjfoGeHNIhD02tR4vlYK0ylacvKbJm2T133wJ66I90BQjWRHSFzqenMH7KYxYylKOFWZubtbokOjo96HZAve2Cew+hoMPxFdQdrvG7E9539LklLhkqt0r2TXtjfGfoxfLX7Wp3Uv0fNLmtYeyGfNkZVX/pdgwvGmyqvpBVdqAUlVJyGESorX+9QvIqw/0VB69WlOO+JvxR7e38FSmQ9ImOOy5YTzwUyQ+1/oDkKPRpV1NG94nbWIttB5NjTsJHnyHuMuVOAoUeELrzyn6mjd3+NuDuPwzKhuBg8IQSn+55c0KEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzQcsiU1rmq1/r+nMBf4+oJmNzQPJjZj6fJAarFPbvk=;
 b=HDQtA6x8TziZ+JG0zt/rnNkro+Ksot53NFit3RLqNBkBN6jwAL7flTZ/rWcrXgIrlm5q2FOCVjw9Zc7V4VyAZnnRaPUICW4UksDRWkAV+QuixzKwzAf//NBXDPN/bb748wT8rAJA4C6nf1xpEAGWkRdgShP9oWRk3+oivZ4y55ivxSuFZEzr/tZkWVSEmPz+GbLTG4lun9Zvtapz+I5kP3obYBVtVWCbNBD3kwsWfLfoWza5YjwwAWcGgq1al6Rgl6VqeDA6qPtOkMaSArcLqvd9CX3tyGi6K7DZgEJApMpUXRaqvVd4W48J3tzvvxnnGYpj8Yr6quyOdNPnp5UHsA==
Received: from BY5PR17CA0034.namprd17.prod.outlook.com (2603:10b6:a03:1b8::47)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Wed, 4 Sep
 2024 02:06:10 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::be) by BY5PR17CA0034.outlook.office365.com
 (2603:10b6:a03:1b8::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26 via Frontend
 Transport; Wed, 4 Sep 2024 02:06:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.2 via Frontend Transport; Wed, 4 Sep 2024 02:06:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Sep 2024
 19:06:00 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Sep 2024
 19:05:58 -0700
Message-ID: <70ef75d9-a573-4989-9a9d-c8bc087f212b@nvidia.com>
Date: Tue, 3 Sep 2024 19:05:52 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] alloc_tag: config to store page allocation tag
 refs in page flags
From: John Hubbard <jhubbard@nvidia.com>
To: Suren Baghdasaryan <surenb@google.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <kent.overstreet@linux.dev>, <corbet@lwn.net>, <arnd@arndb.de>,
	<mcgrof@kernel.org>, <rppt@kernel.org>, <paulmck@kernel.org>,
	<thuth@redhat.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<xiongwei.song@windriver.com>, <ardb@kernel.org>, <david@redhat.com>,
	<vbabka@suse.cz>, <mhocko@suse.com>, <hannes@cmpxchg.org>,
	<roman.gushchin@linux.dev>, <dave@stgolabs.net>, <willy@infradead.org>,
	<liam.howlett@oracle.com>, <pasha.tatashin@soleen.com>,
	<souravpanda@google.com>, <keescook@chromium.org>, <dennis@kernel.org>,
	<yuzhao@google.com>, <vvvvvv@google.com>, <rostedt@goodmis.org>,
	<iamjoonsoo.kim@lge.com>, <rientjes@google.com>, <minchan@google.com>,
	<kaleshsingh@google.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-modules@vger.kernel.org>,
	<kernel-team@android.com>
References: <20240902044128.664075-1-surenb@google.com>
 <20240902044128.664075-7-surenb@google.com>
 <20240901221636.5b0af3694510482e9d9e67df@linux-foundation.org>
 <CAJuCfpGNYgx0GW4suHRzmxVH28RGRnFBvFC6WO+F8BD4HDqxXA@mail.gmail.com>
 <47c4ef47-3948-4e46-8ea5-6af747293b18@nvidia.com>
Content-Language: en-US
In-Reply-To: <47c4ef47-3948-4e46-8ea5-6af747293b18@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|MN2PR12MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e64cb3a-f5d6-4e9d-8cd5-08dccc862547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mjl3eE5PS3hpTTcyb3dMc3B4alRiRE14ampjT25EUnRrUXdFZjVNWHBJRThU?=
 =?utf-8?B?WXZHM1dPYkZQaXhlU25relFSb0JIazZDWHpZZjg1ZnlLK3JBalg3aWtTRmJG?=
 =?utf-8?B?NHdOWUxzQ3VoOFJjaXd5MXhIclJqRnhZYmVWaERkcjh3ZVR0MkgxWHIyc0xY?=
 =?utf-8?B?aHRhSGFaUlV4b290Njl0M20rY1ZKQlkyOUVqZDdtSFNNNHRiVGdGQlRwU29P?=
 =?utf-8?B?K1BPeC9kUzZHU2ROOHFIY3pWVTZYUS9wTW9HU2d2YUtyN2dhL0NMS2ovYVpR?=
 =?utf-8?B?anBreDFKNkdvMWdZQTJDOEp1aFhvTzh2QVEreGcrZGR5cG9lQVVSZThtR3J6?=
 =?utf-8?B?Y2Q0WWRyUDNNcS9jc0V6RCswQ2xXWVZ5aE8zQktaQThDL05GbkRRMVBMMFc2?=
 =?utf-8?B?N1B5WlJhS0h2bWJVenJiaHhEemplY0E3RUVvMWhjL3NMVTVQRis1MEYyWGJC?=
 =?utf-8?B?YW5UVmx1cS9WdS92VUJTcmdCdUhCanE0eUtTbVQvU0FhRHA2RENUSHNqcEll?=
 =?utf-8?B?c3QrOXZ1Q2VpUzVGUFFmOEsrRHRBZGNyTUVhYXRLb0Fkdk45M3E2UmpTaFhF?=
 =?utf-8?B?SDc4SkhOS1lPb08wa0g3c3Y4c3BZZVg1L2pIaGxFeHRUWFFPa3dSK3pYLyt6?=
 =?utf-8?B?Qzl1OGpWdnBCQkF6YjA3Tit6NFovL0FNaGxxYzZaUGRJd0w0Q0dwSFdZSE1i?=
 =?utf-8?B?cEZxM3QrcEtER2h6ZW5qYTh3UFQ3UUdpUEw2ZHVSM2FjODF3Wk1hc3Ztbllr?=
 =?utf-8?B?Zk81VlIxeEduSDlmS29ucmEyZVJ5YlVGWTZ6Sk1oaUNkcUl5eDRFbTRQOUsr?=
 =?utf-8?B?cDhtWlNNNFp1Y2V4Mk1XS2lENC8wZDBRejZESXZVa1FXOW8xWGE1OWpsZGk1?=
 =?utf-8?B?UFI1ZmZEOEdhSnNhaGNpeVJ3VGxiMkVkZmIyNlJkejFIb1dOWjVuYUFENXR0?=
 =?utf-8?B?Z05qcVY1UjZwSHJnbHN2T21jSzEyNjFqN00vTjYxSGJ0YzhHRUkxSWgwTCtJ?=
 =?utf-8?B?bmVBOWdjM0UxTm1wLzBOQUZkMW0vYlZpSnRGSWxrejRsMkdjdEtjT0J0NSts?=
 =?utf-8?B?b2FiSzh2OERiakg0Wk02bkhWRnh1Y2pLOHVwTFlXc0xVQ09rVXpuUFRDaEg4?=
 =?utf-8?B?ZlZtRjV5aWwyZExVY2pNcDk4OU5qSTR5TjZhTE9VL1ZtdFluSGZydHYxNkY3?=
 =?utf-8?B?bTBWc0dHaWRIVGs5V09tVDB0L1U2dFM5UjRidGdHWUlFY2hkR1RUaXpJYVRE?=
 =?utf-8?B?aTNLWG9OaTM3bDlEZjRMa0d5VjFrQnRuTWsrTy92QnEwa284Zmc3UGdDM2Ni?=
 =?utf-8?B?SFZLVEhoSHkxRktHNTRQV2FxazFZOVJUZ2RNRXJJajRya1U1blRzQytNTCtI?=
 =?utf-8?B?UVB2SzdzcWdoU1FNS1dJaEE0N3hqU25kdFJzOVJtNXNLTEs2YjJaeERpRkoy?=
 =?utf-8?B?STdTR1RUeHVGTDJycVdzeFBJOXBwTm0rK29mNXNQZ1ZHOGJCTnRiaU4xakJS?=
 =?utf-8?B?ZFNEc1ZiOEZSa3U5cFVzS3JHNnRxNGZnVm1Wa1NobVRCY1pteUFwUkk2dW1m?=
 =?utf-8?B?UFlDd29SRUFYNVFJRG1rUnllVlIrQlJMWDdUMncyVEcrZ1Z2WnRqcnpnL29Z?=
 =?utf-8?B?SlVGbUFzamRodE12anB6b3ZxTVY5RUJkS0N5VDV1enIydjI4S1dlNVdESVlE?=
 =?utf-8?B?cS9GRnhLWi9Pd2FmODJ1WTRQQmRvejIzRXBrV2JQMVpFeEdqY2N3MzY5UVlY?=
 =?utf-8?B?WmEvclJTcVZQVk8rY1lyU2FWMjdKYmxpSnljOTYwSkI0ZlZyLzFhSlpNbXdM?=
 =?utf-8?B?ZTc0T3ljNjNQdXlxNmZjdit2T2U2MVBOcFNkWjI4SkkxSzZNVjRCblNVN1FR?=
 =?utf-8?B?UUJOMzNzRi90SVh5VDV4dExBSXZOektMZFA0ZHVkU1pmcUt4d0htN2VmMU83?=
 =?utf-8?Q?DrvBRyy/pfvAh7dckfsT0Ss9cmNG2cgN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 02:06:10.1960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e64cb3a-f5d6-4e9d-8cd5-08dccc862547
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176

On 9/3/24 6:25 PM, John Hubbard wrote:
> On 9/3/24 11:19 AM, Suren Baghdasaryan wrote:
>> On Sun, Sep 1, 2024 at 10:16 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>> On Sun,  1 Sep 2024 21:41:28 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> ...
>>> We shouldn't be offering things like this to our users.  If we cannot decide, how
>>> can they?
>>
>> Thinking about the ease of use, the CONFIG_PGALLOC_TAG_REF_BITS is the
>> hardest one to set. The user does not know how many page allocations

I should probably clarify my previous reply, so here is the more detailed
version:

>> are there. I think I can simplify this by trying to use all unused
>> page flag bits for addressing the tags. Then, after compilation we can

Yes.

>> follow the rules I mentioned before:
>> - If the available bits are not enough to address all kernel page
>> allocations, we issue an error. The user should disable
>> CONFIG_PGALLOC_TAG_USE_PAGEFLAGS.

The configuration should disable itself, in this case. But if that is
too big of a change for now, I suppose we could fall back to an error
message to the effect of, "please disable CONFIG_PGALLOC_TAG_USE_PAGEFLAGS
because the kernel build system is still too primitive to do that for you". :)


>> - If there are enough unused bits but we have to push last_cpupid out
>> of page flags, we issue a warning and continue. The user can disable
>> CONFIG_PGALLOC_TAG_USE_PAGEFLAGS if last_cpupid has to stay in page
>> flags.

Let's try to decide now, what that tradeoff should be. Just pick one based
on what some of us perceive to be the expected usefulness and frequency of
use between last_cpuid and these tag refs.

If someone really needs to change the tradeoff for that one bit, then that
someone is also likely able to hack up a change for it.

thanks,
-- 
John Hubbard

>> - If we run out of addressing space during module loading, we disable
>> allocation tagging and continue. The user should disable
>> CONFIG_PGALLOC_TAG_USE_PAGEFLAGS.
> 
> If the computer already knows what to do, it should do it, rather than
> prompting the user to disable a deeply mystifying config parameter.
> 
>>
>> This leaves one outstanding case:
>> - If we run out of addressing space during module loading but we would
>> not run out of space if we pushed last_cpupid out of page flags during
>> compilation.
>> In this case I would want the user to have an option to request a
>> larger addressing space for page allocation tags at compile time.
>> Maybe I can keep CONFIG_PGALLOC_TAG_REF_BITS for such explicit
>> requests for a larger space? This would limit the use of
>> CONFIG_PGALLOC_TAG_REF_BITS to this case only. In all other cases the
>> number of bits would be set automatically. WDYT?
> 
> Manually dealing with something like this is just not going to work.
> 
> The more I read this story, the clearer it becomes that this should be
> entirely done by the build system: set it, or don't set it, automatically.
> 
> And if you can make it not even a kconfig item at all, that's probably even
> better.
> 
> And if there is no way to set it automatically, then that probably means
> that the feature is still too raw to unleash upon the world.
> 
> thanks,




