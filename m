Return-Path: <linux-arch+bounces-15061-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78333C7F284
	for <lists+linux-arch@lfdr.de>; Mon, 24 Nov 2025 08:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E9424E142C
	for <lists+linux-arch@lfdr.de>; Mon, 24 Nov 2025 07:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADC22E0B6E;
	Mon, 24 Nov 2025 07:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wsoQOR/P"
X-Original-To: linux-arch@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E9F299920;
	Mon, 24 Nov 2025 07:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763968255; cv=fail; b=XmtPahwk7nDD3xKu/5sCjXAaWLoyzFM+2k1FwDUoRjtRm2cZGEzRYLlbyTbGgv6MpbG3u5aoCylpalNXcRBc91cITpzVR1R6pJad1Q2eptnKh/iznb9amdDwMT3tLJB04c8U8NcZOM42O22AaMtMh3v57H4mwP1rY0JCbWpi078=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763968255; c=relaxed/simple;
	bh=zmIMVUzdvli4Ff0kINYre81DVGiB4tuscrlhntc27P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EUNdnTtnWyRr8pTV+rVdu/Za/uAxZy5INTEnhC08ZCxIFHQX5BYhSrnonkJQjL4hyuy2OSmP97nC3CZVa7OaNs9u+G/H2KfWn0/O7R0I9T6LottjroiyUHlS6X6GKLrcdhRJozFLDhwyRsuU7gW4EcgnOVCd7K2UgEP5PrWO4xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wsoQOR/P; arc=fail smtp.client-ip=52.101.43.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mR1UnKDKkA8+PNt3sQq7axDXriqFmPKwQ+pSTABt6tMKkNHtjxhLDxhB9ZjSJ4mFJ0dNUJxCXwyzx+/WL7VqvmrlpWfLmMXs2bENXnpKkwVN47pNYQjN73hwwfJi/HfSk8MI8AgIoWNkC4CuLQRPj0w42xDTB+xBZLDvF8zmFVCrC4HFnyEpX8UXv95nQMt3+9Uk2Ypse6rTMDiNcXR7sXy6pfS16lS48ZqYPTmsVryxC54fKohZy/pHWwd51piE9SAUhLgdqYu8DFfwa5GNcI3KrcfWZIdPZTSi7Lsg7prKSwhY77AxFspHmDm4iXzNjbLx+hadYCPbPRcbmpyNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iOcgWuJCSbiPy1SONlOskpprIjlIi9hSHB79HW08ZQ=;
 b=R9K1farJx+6ez9AFpPA7ojVk/fEtPvQ1HxabtDTO5BGJYuWbUstdto+qvuNdnqEV2Nx7yldEUlVvJX9FW2ZXF0jc2d1sTy9F7xYYZ4XKcceYg0bs5i+YiLf2ceJb1zRzbrzBytFlB9cVKhRcy94jwRLuuGlc9EWbxE1OJ6aepXbniN6wrIWDf0qJZrOn/MH9FMmpDhdZTjO8p+GlbctcC3BCmZi1+hPFNhEDZ0NHLidYLUvITiH3Cf68CfrXBDdfA1vjPXwgsehDf68njzQe0accyKVpUchCq0PhIOAVGACEVttAOXrDFn3YA3ZefZjudE2hjA+Z1dXXhulo1nCntQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iOcgWuJCSbiPy1SONlOskpprIjlIi9hSHB79HW08ZQ=;
 b=wsoQOR/P4+295IT12f/4ozwBngKc86Y/5bJefuG2WON7ORZQtcPdQ8+pzdgiFrVPhHMAslSFzK7htRz7E0d8lz2PfL0Ga1x2SneZ9eI5RX0p6vChRjPxjt2qLa3PMg9R84HzMbx6wuahfyiYKXCxZui8PCc8iuQ/Ivh+DYeTPCw=
Received: from SJ0PR03CA0164.namprd03.prod.outlook.com (2603:10b6:a03:338::19)
 by CH3PR12MB7596.namprd12.prod.outlook.com (2603:10b6:610:14b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 07:10:49 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::df) by SJ0PR03CA0164.outlook.office365.com
 (2603:10b6:a03:338::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 07:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 07:10:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 24 Nov
 2025 01:10:48 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 23 Nov
 2025 23:10:48 -0800
Received: from [10.136.36.40] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 23 Nov 2025 23:10:45 -0800
Message-ID: <8cefc4be-b11a-414c-b3f4-280c900be67b@amd.com>
Date: Mon, 24 Nov 2025 12:40:44 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V4 00/12] rseq: Implement time slice extension mechanism
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet
	<corbet@lwn.net>, Prakash Sangappa <prakash.sangappa@oracle.com>, "Madadi
 Vineeth Reddy" <vineethr@linux.ibm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>, <linux-arch@vger.kernel.org>, Randy Dunlap
	<rdunlap@infradead.org>, Peter Zijlstra <peterz@infradead.org>
References: <20251116173423.031443519@linutronix.de>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20251116173423.031443519@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|CH3PR12MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e1b3d4-2f58-41ef-1dfe-08de2b28987a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|30052699003|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEZkTnZpYVgyb3g4V0U4dmtqaVBnc0d1RG9HeDRwT3NQdkp2bG02TFgzd3p6?=
 =?utf-8?B?OHM2Ty8xc3g5ajlTZTd4WmRkcWxzQkYxUnZpZUNLN3Q1VFJ4ZHVYQkltQnVX?=
 =?utf-8?B?a2JJZ1RRN0JpQkJrdnZlSlFxYmpGdzM4R2NoMUl2UXpoK3c2U2d6blB5RXpB?=
 =?utf-8?B?ckhaMDdKWkhnaTB6REdPWFdYeFFtU0lmc1lPaHlDcTFmeHR4c2V1TjcxT1h4?=
 =?utf-8?B?Q2E5VmRhL2F5VlpLNjRSUzlhelBlcnFpM25wNFNaRHEvLzlYVWNWb3JrVGpI?=
 =?utf-8?B?N3pLbDU5KzBGb0FVWDB1WStBRUtnalZ2b1hqZVV4SkhEZ0R3ZTVIbStnRndW?=
 =?utf-8?B?TGhEMWxOa3pVYzQ0aTZEODhaK29lclJveEN4NG9UQ2g3NzVmYVVFK0hUMjcw?=
 =?utf-8?B?YTlDeDlLYkZpR2VRd1U5TjgvdnhqSGJyY0R1NjlWbFBZc0gwY3lCcU1qY0VW?=
 =?utf-8?B?UkxwekZsYnF0aGZGVXQwejljZDMzTE1DWHMvamlCZXRhbXJWNW9HQSs1aTlv?=
 =?utf-8?B?Z2ZOMGMxS0lPdXpvcEdwdzJyYktkbWRWNDdwaWFDVGI3T0RSSmZReUQ1cnp2?=
 =?utf-8?B?dVltdDN6V0ovS1NJazBnYlRJUFUxZ0toNG5ZenVrbWdDTERyZk0yUEZzRlRr?=
 =?utf-8?B?aGN3R1NCQ3RFMDd4YnREOGFLZlNsc1lXTmxDM2YxTDVRcHVuOXNXWXFoM0RB?=
 =?utf-8?B?MDQzVk1SN0xidlRXb3R4RmhXOEZMM2Yra2NmYWl5STNpN2RQNTBPdHNiQWs1?=
 =?utf-8?B?TG1hYnNWcVg0dUNmekJ1UWU0MEV5ZG5VaG9kcnNWNEdWZVFUZDJZMGV3MlNN?=
 =?utf-8?B?eW5ER2FVZExuWm9KU2tqMDdkUVpYSVJMbEk0dFVyTmJPT09lcUhXZW5hTnF6?=
 =?utf-8?B?MSsxUVErTTQ2T1RQeXg2M1BxTSt5MzhXSU5FeGxuaURJa2U4Z3Z5b010bGVH?=
 =?utf-8?B?RWZyeEF0WGF4RDFUaEV2Q2tyRXQ5ekUvaWpsRHNZTUVhdkl4bEZ3ZVYxYkxm?=
 =?utf-8?B?VEpwcWljTWpqOUpnam9jRk5MU3M2UllEaEk2MmE3amYwZy96OVNYYlFhV2J0?=
 =?utf-8?B?T2pCclZwbG5vakc2OTNxOWQrSzVrM0tvZnkzTkV3QW1LYVJwTWFvZ3lRYU1k?=
 =?utf-8?B?L3hlYnhzN1p2VTRjTjZrd3czak10bThjYkVRM0RsZFRxRUVUM2NJdUVmaS8x?=
 =?utf-8?B?MXNlOW85UlVOcmU2U3hmTU00YnVSTi9GUjF6RWpmUFNzTXJIM25HWjI5MWUz?=
 =?utf-8?B?dG00RUNSOW05bjlZRmlta0xTL0dnMW5RNzNxSUNxVWRKOGpHK3p3TFQ3amlp?=
 =?utf-8?B?MC9nOFFobllIeVAwNVlyWDFHY3c4VlFMcW4vS1FHZkJvRCtVOHRoZEpvRFht?=
 =?utf-8?B?bGowSEc0VkNIUEtqL2I1TmpXVHkydmI1QWdxY3VZb1JVYXRkYTdjcGNjb1BN?=
 =?utf-8?B?MjFnUjBZMkQ3S0pCeXdpOXF6RUwvbk84R3ZHbkhPUmRhcWdoMG9ocUNVMkw1?=
 =?utf-8?B?YkovWTh2K21pS2VoOGpuZXIyemxCb083U2h4VG90WTE1UER6UDZYUGVoeGY1?=
 =?utf-8?B?MVJjM3grd2JpaW1qK2g3cEZUWWdYU3Y2RFJtaWNQbkE4UE1GMnJOdHhRc1Vp?=
 =?utf-8?B?WHZmWVB0dVpkWHZCZlgxUzdhSW9iNGhnZHBKMkNUSjhvWDU3aEwzUm1sNnM3?=
 =?utf-8?B?R1UrTXcrMWx4bThPVzJ2aWFmYUtVNFdhYmhtV3pjZXFZWmgvd3RtdnlsZk9L?=
 =?utf-8?B?WFZtSmR3bGw5eTQyQmhpZzNqZUpTRzdoM1dRN0REV01tbTV4K1VYR1JoVUVl?=
 =?utf-8?B?cXc4emcvUzVIRUFwai9Ld3hPbjQra054TUQzZUtKemRHWnNXQmRtQzl4c0w2?=
 =?utf-8?B?dzkwVG5iZng4L2hHYkY1UnN6ZkFSRGJBUVBXVjkvaWUzQ2UrYS9na0IwbjVq?=
 =?utf-8?B?WUpLOUZkZkt4VmhneXNyVUU3dGQ5Qi9oVS9ORlRBYzIreHRwLzBhT1hNYXRn?=
 =?utf-8?B?RWlObkNrZEUzRjJ6Q0RhOXhENW0zVkZqWU1vYUtsQk5iSE1QRUtCcTYzNm9a?=
 =?utf-8?Q?RfDSOL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(30052699003)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 07:10:48.9265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e1b3d4-2f58-41ef-1dfe-08de2b28987a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7596

Hello Thomas,

On 11/17/2025 2:21 AM, Thomas Gleixner wrote:
> For your convenience all of it is also available as a conglomerate from
> git:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/slice
> 

I got a chance to test the series with Netflix's userspace locking
benchmark [1] which ended up looking very similar to the test
Steven had written initially when discussing the PoC except this
can scale the number of threads.

[1] https://www.github.com/Netflix/global-lock-bench/

Critical section is just a single increment operation. Metric is
average time taken to run a fixed amount of critical sections across
#Threads over 3 runs.

Here are the results of running the test with the default config on
my 256CPU machine in a root cpuset containing 32CPUs to actually hit
the contention:

o rseq/slice with no benchmark modifications and "rseq_slice_ext=0"

  | Threads |    Threaded (s) |   Threaded/s |
  +---------+-----------------+--------------+
  |       1 |         .026103 | 383493128.79 |
  |       2 |         .086320 | 116134267.40 |
  |       4 |         .669743 |  14937390.67 |
  |       8 |        1.105109 |   9053764.30 |
  |      16 |        1.863516 |   5366809.94 |
  |      32 |        7.249873 |   1379590.12 |
  |      64 |       14.360199 |    696486.76 |
  |      96 |       21.909887 |    456458.03 |
  |     128 |       29.126423 |    343358.95 |
  |     192 |       43.112188 |    231980.16 |
  |     256 |       57.628748 |    173554.39 |
  |     384 |       86.274354 |    115909.73 |
  |     512 |      114.564142 |     87289.97 |


o rseq/slice with modified benchmark and "rseq_slice_ext=1"

  | Threads |    Threaded (s) |   Threaded/s | %diff (s) |
  +---------+-----------------+--------------+-----------+
  |       1 |         .036438 | 274437690.71 |     40%   |
  |       2 |         .147520 |  68851845.82 |     71%   |
  |       4 |         .829240 |  12176948.03 |     24%   |
  |       8 |        1.259632 |   7993476.42 |     14%   |
  |      16 |        1.988396 |   5029209.62 |      7%   |
  |      32 |        9.844307 |   1015837.43 |     36%   |
  |      64 |       14.590723 |    685979.41 |      2%   |
  |      96 |       18.898278 |    529171.84 |    -14%   |
  |     128 |       23.921747 |    418033.09 |    -18%   |
  |     192 |       33.284228 |    300673.66 |    -23%   |
  |     256 |       42.934755 |    232934.87 |    -25%   |
  |     384 |       61.794499 |    161924.64 |    -28%   |
  |     512 |       82.005069 |    121951.34 |    -28%   |
  
  ( Lower %diff is better )


Until the contention begins (> 32 threads), there is a consistent
regression which I believe can be attributed to the additional
overhead in the critical section from setting the slice_ext
request, however, once heavy contention begins, there is a clear
win with slice extension.

Feel free to include:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek


