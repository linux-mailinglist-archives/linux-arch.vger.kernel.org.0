Return-Path: <linux-arch+bounces-3045-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6624788051C
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 19:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07121F23978
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 18:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD8839AC9;
	Tue, 19 Mar 2024 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="vuSmIBYW"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2122.outbound.protection.outlook.com [40.107.243.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924C1EBB;
	Tue, 19 Mar 2024 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710874268; cv=fail; b=VBkyWhL2W5WUqnBfZkEAMUZdXGcJOhfc+eFgj7axFJ1VBNNYQyK95qSO3ZTKY/WfV2YzLuEpJYm9m+dgn6GOJc/9vSNWypj4qTcW+H+yMVTvCAleTN6W/EZJmrtgVIer02ylxaToe+rTSKKI7CbECmE6+HpS8/XNHZUAZFwYBrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710874268; c=relaxed/simple;
	bh=/PuzUM1k5YyQLZsvd5SehDquP3jJ46PpO6Ei+P9+Rtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZwPCWXraNWAqxg+5ZJl+VgmZOOk7N7gFb5IDs7oZAM2heZBKGR654TayM3mLEbDzgJ5w9fZdIWRGgYjRt/ernmBrw7/0/D27cVLSLgWQMBaiunL4CT0p74x1eKAJJSmUhomA7KrRrVJM0/cOR+ZhIfwgiAt8O8Vf6LtVctkG6MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=vuSmIBYW; arc=fail smtp.client-ip=40.107.243.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fe7rJQeECXXvvUIP1qNfM6pTNUvqWCbUnL9yDKUo1t5y3nz9LoXl2njRoQg6BYQqC1xGFXW4JX2UCzDbUC8rDh0MW/Eobqr/L1L17Dhuul+SSEAyjyy0JUTBotySXuS2O1Pa2W9U6Ihdp9nfllzbI8C2c0F1bKQJNNbtUUeXeLhoz7TzExR3eRAXSp2k9sLxpTwL1FppYIYgiBPn8K7FYRS8lfvgHs/KkgHmkH2PNeoMd0y4cNQUTPpjO3VZBI/XNXfD/nwy2v+/YbwJRaDTB7Re+pYCxIzRuW9C/9u+uNCVli8iUWslpc5wCmkgi+BpWbJnd9lFYmjIBwE7n2G+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WTX3q7QwB9onNtwcX5ACYitLJFLZ4jZbOxilS0O8/s=;
 b=crIvq0fcyVf5lyY7hOevvdlXMf2kclGC97lB667UfJayivt7cw6pN2oU5eJOk9vZiOSzMfAY6vcdG/+tYhdHb9PNcUymCxEbEiXA7W0KNNzIaIwJkiH0t6saZr9u36cF87A0ei04UP392SeqznVCs5Lec6yf8uOjOUv04vtd8ZOHoHPcVT4EaPUOykxA/KDyLZs5xNvTyjfxu9tlFsOxOu5PaWVzL0Wo6rez3pg1HQjsPIN351Kcrvwl4SSgMFQPOXXT1bnKX/W/fClEmEWRtoW8tfQ27+QVGWZaDe7nIulfHtqCAdohyYC2ZUCN15yrNjKRB3189+alHDYkC+azCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WTX3q7QwB9onNtwcX5ACYitLJFLZ4jZbOxilS0O8/s=;
 b=vuSmIBYWGvqKGOUXx35HkMFxSEfBUZXl560QQypt4v+3/bDU2a3+Dicq+51JZf/cdCpuWSCvcr0DKw1EiFEvTwIBOYYkvVokHf8REzuQduzbxHZfzRwLgMGOYOGOOSMXBuEaoq81pWZ83kOn9Ss790t5V1DG4OW/nzrOAipAwsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SA3PR17MB7177.namprd17.prod.outlook.com (2603:10b6:806:39d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 19 Mar
 2024 18:51:02 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b%5]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 18:51:02 +0000
Date: Tue, 19 Mar 2024 14:50:54 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	ying.huang@intel.com, dan.j.williams@intel.com, honggyu.kim@sk.com,
	corbet@lwn.net, arnd@arndb.de, luto@kernel.org,
	akpm@linux-foundation.org, shuah@kernel.org
Subject: Re: [RFC v3 3/3] ktest: sys_move_phys_pages ktest
Message-ID: <Zfnejn+G9kfoqb6T@memverge.com>
References: <20240319172609.332900-1-gregory.price@memverge.com>
 <20240319172609.332900-4-gregory.price@memverge.com>
 <ZfnQ7n_7cZvk9BkC@casper.infradead.org>
 <ZfnWCRwcZJ4KBmSH@memverge.com>
 <ZfnXcbd3h3Rj4IIS@casper.infradead.org>
 <ZfnaMa6x/O68ENsP@memverge.com>
 <Zfnbn8H4O9neZhcm@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfnbn8H4O9neZhcm@casper.infradead.org>
X-ClientProxiedBy: SJ0PR13CA0164.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::19) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SA3PR17MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: c4870b15-7b25-4d32-4322-08dc48458661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	seSGTCTiEpH5/doWd9SSVGxsfpqW7UHJ4kZ1Pg/sJ1eLFO1xp14ZkxrOMTGQRxn1y24hivg5xfl4i/s/tCW5i55U6YmXx5afQy0RIuj22FczORtkr1BJHwVFR2jh9rUYL4f44RDJIlhfFHYCm6Gxb08cEGh3rzOL8jrmpNXSIoHHNR6AtDjAWeHismUP+xxsyqFJiJighcUFJTVMPD/g/IZ9t97PZ0svFgv178UzdjyTVFmKE5qcgGXA3Jo79KG0rBygaIlUoKtzxRjhbG9rzDzggy+L6A+D4upU1M3iEBu40chnc7+K/l2IXCFb4PvzyO1W6NwZe0UNaeb0hiJJ4MfVi6HEyIq+nrH98V2MaZOm0AoSi+i9sed+AWh6dQcXfHBr71wEvIRM0B3qbkj4gQaMJ1Ws2RTeJyeHH9vJSZrvpcniT9j52zJMJu7c/nqPm6VndaKqxM+eRGAUf7FKBFZaR+MObJcvvXoOHeGOowCa1p3UntEZZ9o/ww+AayFofMvlgzamKD0OS4AzGsrRmPrbqSyIL0khTT8Y83Muy45boBm2xiA4qJtFOX+5qtjXUp7L4Ii+1tVeSaA6MZwyeX2EebruSsBz2F3YTexrvnel3LfpJ86C9CMVBKDkAHU0jzlXPVoY/iwR2FP+q8werMIf34WwWg742y3D1noVxqo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/MYQAc2ddPMLW1cZvnx8S2kgUjxE3wrRsvq+qHu6D8iGNWSIWQW2jq07j4UQ?=
 =?us-ascii?Q?q4s2Sm5unSGFK7qHZ0j4nZvGuJ41eJqrOJC4gdybI0qGQ034T2cO9mLx9ukg?=
 =?us-ascii?Q?5xqWtfajoJhU9csz2+Oy8+yvDmUGPm3OfqRe+VirflpE26dF7tfn1VbcZncV?=
 =?us-ascii?Q?a2+2pluGwkDnPAE8yoe2CBgLFsFnQ1RNMn2zzVFwZ98UalpkfAHgGTCmCl6P?=
 =?us-ascii?Q?dGa1CP6lJ1EzmfOC5n6BKuIK2GkSOMB5zf9HrfUGsEEq5Xz+yaBdDh0fBf2E?=
 =?us-ascii?Q?LvOJdeGY0BvaTOEkUVGztgICSnXN3L+QIISsMHxo4jiOD/WrAbueEpf8HEVU?=
 =?us-ascii?Q?Uuk+3sr65V6WLxSDNkEDxcCaiIHVX+TOKoGzhUb/eebaeV5hD5o/JZlyiu4T?=
 =?us-ascii?Q?0hxVFOlA3vvci9CbBPHS016DMarjvgZ8YgRJ7GMQ4lfex8wzPVuH1/hFBuYR?=
 =?us-ascii?Q?knf5RyPkvnThiVQ2Xxqv3cEZ9dhkCSrrD8NJs2tzcSTXSc2j7iyQs6KlmUDr?=
 =?us-ascii?Q?aBelklDanI3ZJSJAzOYEWGFYgp4MvgxixuX0Z1XoMksuUIm9H1wmiHxauc4Q?=
 =?us-ascii?Q?NoSb7mib/3mlIJXi5thBOBoB7405OJZLfX6DFlEcYQ21hvDmPM4mnSR5B6iF?=
 =?us-ascii?Q?rGCEA2PSsMa8GCSQlSRU6jmgFkg1wM7/WemSQ5lwVhQZaKyjqiUHk7p7chXD?=
 =?us-ascii?Q?4yg+AOggfG8m8bwmWZWpKDixgMdLHPFDDss0GsEJth2uBMTlJF2d0RMR4J9f?=
 =?us-ascii?Q?Xy5s4vvX/MZ0XzxRWmcMJdR0oqVms9LsiH4S5IPaM1OhFQrqTQz46FZlR5RI?=
 =?us-ascii?Q?n8PHkF+lNReOUrvQFfEdwC6iESkHb0mL2lYhVa0/nGqF1zIP+j5cn0BhOtoZ?=
 =?us-ascii?Q?3zSsDRz9TpWq068a7i7YLjM/Lc+lhmFVO1cLSx1wmSnDaWwFUFktVdZCmq7w?=
 =?us-ascii?Q?VCOPamLo5G9Sx5wjgU4iwPlopdNT2zZytcNERx+fhwQDnEVrzyG7886ORSQZ?=
 =?us-ascii?Q?hD5pBrCUJlPWSZcvv3v4Gb00c61sPrh8eX/5GO6MrTl73yrWmF+S4SU22cK5?=
 =?us-ascii?Q?pglySVaIF0p7d4LNuRowdVqFAY1UA9MREl+7sJ6x8CICmbr+AvGNzkUXTDSJ?=
 =?us-ascii?Q?8V+aFottxahXpn7aMCJzG01F5o9JN4fZSf1o0YLHdASeecteFzgrQwZvaWnZ?=
 =?us-ascii?Q?weqNpW/T53rBDeCtQTqjfCwiumDDEgAKD0/UxTX10pDS+oP6TwoLMKNQdUsS?=
 =?us-ascii?Q?6Om66ME0BHGxgsDP5wyV5ReCUekjNfAe78k1dzIEuVwdu/c25no2LsgV0UDx?=
 =?us-ascii?Q?ZJwpwWeWa3wC8yx/yPo4x6EH9n+bR0xTlQXvx4Kw+gfCc8cmriSdFE3ElQAN?=
 =?us-ascii?Q?OCCjvFg3W53e8kwseJn9VnrTlxCuxw9SoV+UCUPAL0lwLc38R+/nCXJLHBqx?=
 =?us-ascii?Q?7BsbQBzdPE0a9zQNOKA/mfSjPeGvUb1zsUFeLgi0Yxbr2wKVxhVrSvqbDzNf?=
 =?us-ascii?Q?ruR3VFjkyhUAT8XMjmEsfqqf5+Fn073/Kclox379trjLKF7HQpLWQY5gj/or?=
 =?us-ascii?Q?+X3oLElQ3NJteLDQvkCWXRm+mVN4xY5vaOM1wBIaz0nLz/WctR8AaQvOQ1wr?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4870b15-7b25-4d32-4322-08dc48458661
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 18:51:02.5495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBS+WBmKaID8keRI2JQX8J4i4rsstmTA9GWas9FJa0fJqgRkRte2Aw2n6IdenSri2pbCMh/fmxRfCrXyKoUOys4CibkasX2S10irwaGhX+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR17MB7177

On Tue, Mar 19, 2024 at 06:38:23PM +0000, Matthew Wilcox wrote:
> > The syscall design is mostly being posted right now to collaborate via
> > public channels, but if the idea is so fundamentally offensive then i'll
> > drop it and relay the opinion accordingly.
> 
> The syscall design is wrong.  Exposing physical addresses to userspace
> is never the right answer.  Think rowhammer.
> 

1) The syscall does not expose physical addresses information, it
   consumes it.

2) The syscall does not allow the user to select target physical address
   only the target node. Now, that said, if source-pages are zeroed on
   migration, that's definitely a concern.  I did not see this to be the
   case, however, and the frequency of write required to make use of
   that for rowhammer seems to be a mitigating factor.

3) there exist 4 interfaces which do expose physical address information
   - /proc/pid/pagemap
   - perf / IBS and PEBs
   - zoneinfo
   - /sys/kerne/mm/page_idle (PFNs)

4) The syscall requires CAP_SYS_ADMIN because these other sources
   require the same, though as v1/v2 discussed there could be an
   argument for CAP_SYS_NIDE.

> I'm vehemently opposed to all of the bullshit around CXL.  However, if you
> are going to propose something, it should be based around an abstraction.
> Say "We have 8 pools of memory.  This VMA is backed by memory from pools
> 3 & 6.  The relative hotness of the 8 pools are <vector>.  The quantities
> of memory in the 8 ppols are <vector>".  And then you can say "migrate
> this range of memory to pool 2".
> 
> That's just an initial response to the idea.  I refuse to invest a
> serious amount of time in a dead-end idea like CXL memory pooling.

Who said anything about pools? Local memory expanders are capable of
hosting hotness tracking offload.

~Gregory

