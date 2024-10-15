Return-Path: <linux-arch+bounces-8128-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516EE99DA7F
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 02:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB961F2357B
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 00:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB9D23CB;
	Tue, 15 Oct 2024 00:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ym7xCBY/"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E9E28EC;
	Tue, 15 Oct 2024 00:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728950628; cv=fail; b=umMU6RrqAkawZwzG7T3DbnzBU+txK6XfJa6cBMoUi4KBRZcxu69IgchFS4XsFswVOUw5uWQRfY4vbjpUfM5ArsTqTfQA+yApA/ff5tbuPrw4ZGlfYT+epuydvb1ikbWAghl3ASFXMp4AAdOVixS6x7+JMs/4FALNk3FyQt3NHTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728950628; c=relaxed/simple;
	bh=xVsJVE9+icPcQITqNMIHHRDeHpurkBQfNXyJ+/tPbOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NADI3T7XDF6zritsVWeu+zo1PwHofpF0tuOIa8Hcw9BL0P5hpFjzuJ0hAztBtPCXZvjDkkRaxNGE47nExll0oBflGbtpHZbVzqdJ4qM7Lk7ZTlmp8V1DIQIHxi+lZA73YUhp/w05bcHdo+2KquJN7Vx0tQ79oXS5gFCu1rotyqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ym7xCBY/; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baaVS2BrVA0dDCrUTkQS3yAmQ1/Swc752/5D1srQ/bG4EvHvdUr5QOvG9HLJ+KAiYUPoVYq5eSriH8vpWobQuVAL/6QVPiWDTnQqXDtIOoVQUG+IlqY53S6ScLHWu/6SFsveku8kIfd7rAuCJKVwcSik/Wwd2lWhhSj6zMGeKTp9Pp5zhqRmhnw7WhGbqXVZoxd/XNpJ3Noa0ukBOOb3Fjk+KJc6o7tt+G+M8i5IJjbef/Y/HwPbX927W5BhKeGPJBJz8LoxeKLYP9/dhXD6+U8UaNDrCtfeGY4ss7OUteGPRCnVz8z3YK9LB+Vtlzes7teDHb2xvdHN3hl5qETtOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOYk+A0yxMFrElprFSHo5TYz662LnvMMrfhmUsW0Ng4=;
 b=Xx3Ak9sLER8JJzLUCTsikTKCPPtOzjKBf7zRbX05RHVpCZKj7Dfq8QMvrQZt902C0cwT8+v8ypayjXuGfXI2oVdQdrLLNzgY/f3E6DoczWnEOi2uD8/+5zZ1F7JhBbTLgS2NxhTNyanX/nUzqIwAVELNJPof99jLP3onnGlsdhMwxOgsiyK29sZRI4pNO1tIReD2e0d+gUcxsfiQk3x+aKjcqzpAuex0u+WBNOPeKG4/yika0v6NX1KYWKM3Afp7MEaQ7/xqqVzrdznAiBseWQk+KSLZEL1o7EatcGBz90WuyVGlIglI03ovD+P8lWkbe99uPlsDnclbdDRS9aQqFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOYk+A0yxMFrElprFSHo5TYz662LnvMMrfhmUsW0Ng4=;
 b=Ym7xCBY/Bat9IFIy0FHtTaFx1+E/3HaJFrRxem5czFjhHFsN+EQFMk41n0NOnW/jTq0TLAZswJdr+FBv3BphEoPHjiyMt5zcm7a7y6M9zfJMQ24BUkDwEnhpR9MOOE0NFLajEaE3Rgzbb/myLhh3jy3eFVheZIvUkQ0P8MRFRsDK0BwpCEhBrTPKi2R+SNcpehgcmHL5lWRSQOlhAUbyTNgfGQufrY2irTTXedIouowjmXfFrQN0QTxanvvM+oQ4Rqo3hIGBZ7V/2NM7c6OrQGggCCtXHnIuqnhm/ek47WO0uIzrA2sekXmzxLaAQ80j9P6lZ31DuAhqS/4N2JoiBg==
Received: from MW4P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::15)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 00:03:43 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:303:114:cafe::5e) by MW4P222CA0010.outlook.office365.com
 (2603:10b6:303:114::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 00:03:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 00:03:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 17:03:34 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 17:03:32 -0700
Message-ID: <ba888da6-cd45-41b6-9d97-8292474d3ce6@nvidia.com>
Date: Mon, 14 Oct 2024 17:03:32 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] alloc_tag: config to store page allocation tag
 refs in page flags
To: Yosry Ahmed <yosryahmed@google.com>
CC: Suren Baghdasaryan <surenb@google.com>, <akpm@linux-foundation.org>,
	<kent.overstreet@linux.dev>, <corbet@lwn.net>, <arnd@arndb.de>,
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
References: <20241014203646.1952505-1-surenb@google.com>
 <20241014203646.1952505-6-surenb@google.com>
 <CAJD7tkY0zzwX1BCbayKSXSxwKEGiEJzzKggP8dJccdajsr_bKw@mail.gmail.com>
 <cd848c5f-50cd-4834-a6dc-dff16c586e49@nvidia.com>
 <CAJD7tkY8LKVGN5QNy9q2UkRLnoOEd7Wcu_fKtxKqV7SN43QgrA@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAJD7tkY8LKVGN5QNy9q2UkRLnoOEd7Wcu_fKtxKqV7SN43QgrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e7735e6-5132-48d5-bd42-08dcecacd4bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEJtTjJkMTMrRE9kczhIb2M0dEhEUmpCRU01Vks3eFRlZG04dk9QTzZybnMy?=
 =?utf-8?B?WjdicThqWUhRWEhyUlNVSWdBREZKT1lUcnNDRGM0RkVkNkpFTUk0UlMvdjdr?=
 =?utf-8?B?SWJxb292THFjdG1mdVVDazVLQ3BxRS9HamFiRmk3SXY3TWtTUjZpcEcwSGZN?=
 =?utf-8?B?SHdzRkswaHFrYTdsM01CK2ZmS0N5eFJ1N1pTWktwaXBkT2FCTWxqWlptdWQr?=
 =?utf-8?B?RjZra0dKZnNvSExhTGpVekVrTyt1eHhTbjlndXpkNnI1YUMxdVlySklua1By?=
 =?utf-8?B?TG1uZ2VCK0RjY29ZU0o4dzhid1MyTXJESmZEeFFCZ0JheHJwMFJ6eE1DVVJM?=
 =?utf-8?B?QTQvR0UxZnhqN1EvNnY4NXlIRW1uMFFnZmFmak9VOHhHTnlmbkdUalI4TlEx?=
 =?utf-8?B?NE4xYlpOMGNqdzZpWG1ORUdiV3BMNDEvellsblE0L2JwVHRjeityNlZTcXQ3?=
 =?utf-8?B?cnYveitCZ1pyOE1BMWk2eG5qVi9SK0lKL1pzUStZb2JiTVQzRDk2WnRUc1pK?=
 =?utf-8?B?VnN1MjI5bjd1UFVDLzVZN0R3STBYbVU0bkNEZjBvZTVvYldiVi96TEplNmpU?=
 =?utf-8?B?Sk9WazErUEt4UkZiMFE3NHFOeDRGMGFkWEcxdmZmdWZrK292c3pDQjR5YzV0?=
 =?utf-8?B?RHBnay90V1BpUWJRR054NzhQaW5PWjFTenQxYm5KZkl3eThjMVV1U2JUMDVM?=
 =?utf-8?B?UnFTMnBFSW1yZkFOOHVML3JDNk5VZTAvL2VCZDBqMXJldGhpQkhORXp1b3VS?=
 =?utf-8?B?ckhuWjE3Yk9WY2tTZVhKTkEzYVM4dlJMdm9mSHczNDNMT0VydStjeGdWQ3Rj?=
 =?utf-8?B?YkF5QzZITnB3RFYvQkc2VGo5SXF4a1VZNFdybStwcTNVTVFKaHlOQzZiZ3ZP?=
 =?utf-8?B?RUF4QmhYZTlFYTNZWnBnajlXTmFoTHkyaDArUmlmY3Y5TE94ZFFRNkN5QXNw?=
 =?utf-8?B?SXVQakVJVXBZY1c5Y0w0UmtZSWtpUkR6VmNVRkg3enN1QkpQMGlrS1pMMGl5?=
 =?utf-8?B?QzBwZ1N3VVlJYXRHZklpWE9IbmlUNXlMVHp0Y3Z1Y1g1cjlyZUJETHFtNXU3?=
 =?utf-8?B?MWl6Mm1nTElSM3EyLzhteDk3WnM1dml4RnpraGtSUVVoQ3FOOCtJd1o3dHJF?=
 =?utf-8?B?b1hoMmxnRG5TYzQwc3dsUXREeEU3VU5vVGtZUlFXSjY3eTZ1aWp5dWVTdWdn?=
 =?utf-8?B?T09pVU9kMGhqck43UGhLa1ZzenZSYkRZck9pN2RZZmdBQnhseWpxekRRNUVU?=
 =?utf-8?B?SW82NXh6V2J5MzUvOVNzekJ2QjJmQUZ3ZXFTY0R1VGlVUU52ZVo2NEVJY09H?=
 =?utf-8?B?M3hBRFI2b2gxZ2Vwd1VMd2dTMWd3MGtyRDE1YXJOVzNOWUxHS1JZa0hlUTRo?=
 =?utf-8?B?MWlHbXRsOE9jdFJoQXN5OHBVZTdINTNSa2d4cEkvWHlyaUFPaUpWNzRWeVI0?=
 =?utf-8?B?SzZWZURmY0ZOZVRXdlpnOUtmQ3hGUWJSajF1bkUvb3NaSDNUdlZRcEN3M3g5?=
 =?utf-8?B?Y1ZBcCtwUUUwZjNiL01pL3lIcHJGNm53TGF0eEtMeGxQSnFEd1VNWHN2bjY2?=
 =?utf-8?B?SExzZnJaZHh0eFNKalZOSU8zOXhIMHE1Z2lGSE1URlpTNTZ2UFIyMHpCekZO?=
 =?utf-8?B?QXRCbHVKQkxxdnMwQ2kzMkkwY29sUVZsbC9QaHVtc25jSWlHa011RDlOTE9I?=
 =?utf-8?B?Uk02UWtJMjRHYW96N3lWc2s2ZFZUazlSYmdxbk1JbDA4Yk0zSDB4akpNTnh5?=
 =?utf-8?B?cWJidUdjTERxc2RXTThkNVBrNjI3bE1qQ29JR3BxQ0FQamVyenowNVFYN0lN?=
 =?utf-8?B?eFNZQ0oxaEVhQklDc1RDc1ZXWjZpQURkSi9WWmJPSW9lRE9laGVsbFhpczR5?=
 =?utf-8?Q?eIEU59puheoEl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 00:03:42.7008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e7735e6-5132-48d5-bd42-08dcecacd4bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909

On 10/14/24 4:56 PM, Yosry Ahmed wrote:
> On Mon, Oct 14, 2024 at 4:53 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> On 10/14/24 4:48 PM, Yosry Ahmed wrote:
>>> On Mon, Oct 14, 2024 at 1:37 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>>>
>>>> Add CONFIG_PGALLOC_TAG_USE_PAGEFLAGS to store allocation tag
>>>> references directly in the page flags. This eliminates memory
>>>> overhead caused by page_ext and results in better performance
>>>> for page allocations.
>>>> If the number of available page flag bits is insufficient to
>>>> address all kernel allocations, profiling falls back to using
>>>> page extensions with an appropriate warning to disable this
>>>> config.
>>>> If dynamically loaded modules add enough tags that they can't
>>>> be addressed anymore with available page flag bits, memory
>>>> profiling gets disabled and a warning is issued.
>>>
>>> Just curious, why do we need a config option? If there are enough bits
>>> in page flags, why not use them automatically or fallback to page_ext
>>> otherwise?
>>
>> Or better yet, *always* fall back to page_ext, thus leaving the
>> scarce and valuable page flags available for other features?
>>
>> Sorry Suren, to keep coming back to this suggestion, I know
>> I'm driving you crazy here! But I just keep thinking it through
>> and failing to see why this feature deserves to consume so
>> many page flags.
> 
> I think we already always use page_ext today. My understanding is that
> the purpose of this series is to give the option to avoid using
> page_ext if there are enough unused page flags anyway, which reduces
> memory waste and improves performance.
> 
> My question is just why not have that be the default behavior with a
> config option, use page flags if there are enough unused bits,
> otherwise use page_ext.

I agree that if you're going to implement this feature at all, then
keying off of CONFIG_MEM_ALLOC_PROFILING seems sufficient, and no
need to add CONFIG_PGALLOC_TAG_USE_PAGEFLAGS on top of that.

thanks,
-- 
John Hubbard


