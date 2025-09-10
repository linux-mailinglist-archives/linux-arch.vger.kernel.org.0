Return-Path: <linux-arch+bounces-13468-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C16B50D19
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 07:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356AD3B8893
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 05:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6893826E158;
	Wed, 10 Sep 2025 05:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ShhnhUE8"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A143C31D39F;
	Wed, 10 Sep 2025 05:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757481794; cv=fail; b=Cl6VGGZUgYcCytxo8ZoeAta8ahJ/Nv6KU6vUUXXKnlQuXLOM6nGl+zVhSn/ytAeUmVWlnzlYfRPJcnCjX4KilJEK7pcJWUJTBGFMdw384ZuTPE0YObzlroshQz2EC5kK4xUskk1zYjWPxSADluun0jnionaaJwCNEzrR7EYV6d8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757481794; c=relaxed/simple;
	bh=RIrSzzmzTrXTJ9Ujvzs6WC9eBl23CxiI1KRN5f3dicg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QxWjwE/B6uR2p04MHSpQ2Nk5zelxsesqzY6mfeeq5xitkHjubom3NdeQXTirUnR6GguO/DsBNv6sEwSgcUMS0ybdMzGoxM8fl3eoyKSKPgP3m9LDM2OHgUfqm7phf6QEOTHdDmzpNdYTdOFV2FZyBz8s4HLLR3qm5eaKdMv2aDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ShhnhUE8; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvKJKd5HkvSw5A2+E0WdUus9CIz53sE6rKY8hGz5NkATJfysHTD7HdtAOLlbdOGDW9ZyCE5PaSoIprIE6zhPMrIylV5C0UKSjlsAxKn69eJiESXmA+irr/Ts+0j/qfA14m9YtmTwzb9dkuvrbzffm1tmeFfmfFMkpxwrPjnLuYQKFIkGPeqLwVeI1qDBidH6zobsmiJKVBiW1pu/+3K+VV0DhBcZagybWV7rnqIjWMdV3A+qiShVbQ8RjxvmvtcS4zPtmYDcPiJbNHfYtL8BtAO9km2GC9MOd0uWKe101wZ9dVn5OlH6P3JkOnqAdiSZKH6XQU9z264udhqHQTCq1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxMY3cqctP/ebaQP/tRkaJ7pR0Rfe8M3PVOLyTVh+/I=;
 b=CJWgb0j2bObHIDYGoUcgRaEf1UqSTU6/xf31B2SU1Nlr0hfMPYk0qadorCDtqvlifoJdbgT07Ul/kIy4TYxvAm33D/3Rrxsaz+ef6GeFU4E91BjCNvHhqSqPBOYgo3uODBL7xmtmEQqfk0/aumswFf7K0D6u2qFYMKnZTMozBzbnftXHZ5tYZF1OBuewS5j4i+XKTYCne9lNr369fQmA8Rh7OlCJaDby2UIQuZtLxOjjI578SnmuI+3Q0dSHAn1L2Mxo9A8Wp+T0l8JyVqUyj5YjmuSAYrdXOCt1Eb4uEGNFFPA2Z47WzBC9FHzIWT4aXnwzTKPqQTYTVP4OxjIVKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxMY3cqctP/ebaQP/tRkaJ7pR0Rfe8M3PVOLyTVh+/I=;
 b=ShhnhUE84YBg/ZtgXi9zw1WHsRC9DL3StGtyBBVRoRVlzXPiYuy5GkpE1ofk2KyG9e76MPBYfEaszhed1DpaJiegeCR0Avew6Xz+LhHbOE6kz1JnPIQ+J5CyPVm1zPD0FhXIMkzGQBDwLgcEE5YQxH6pxqTd9BXGUNWsRxvLo9Q=
Received: from MN0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::9)
 by IA0PR12MB8894.namprd12.prod.outlook.com (2603:10b6:208:483::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:23:09 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:208:52e:cafe::bd) by MN0P220CA0029.outlook.office365.com
 (2603:10b6:208:52e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Wed,
 10 Sep 2025 05:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:23:09 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 22:22:55 -0700
Received: from [10.85.34.232] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:22:51 -0700
Message-ID: <45b4a0db-dab6-4b9d-9ee8-f564eaa202bf@amd.com>
Date: Wed, 10 Sep 2025 10:52:50 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 07/12] rseq: Implement syscall entry work for time slice
 extensions
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Prakash
 Sangappa <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
	<linux-arch@vger.kernel.org>
References: <20250908225709.144709889@linutronix.de>
 <20250908225753.012514970@linutronix.de>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250908225753.012514970@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|IA0PR12MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 3930a424-150b-4981-b01b-08ddf02a212b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0RRc0hoZHNXNTVjMkZ0bGFlRm04Qy85ckhLTER4OHkvWmRCNU1UMjhvM053?=
 =?utf-8?B?NzNaNEd1UytpalE3MC9pK1JtTEZ6VlNlTVFTRG9STUV2TWR6ZmpPRm1DTVdj?=
 =?utf-8?B?aXBvNUhyaElsSVNJWlZvZGNmMTZzR0xhYk1hc2ZRQVhZVnh0d2RkdVR0aTI2?=
 =?utf-8?B?V0dpelF0UXZFb2NMZDBOV08wWmNPbGFaQktyZlNFV2kzRVJHM2FmUzhEYXIz?=
 =?utf-8?B?REJ6QXhjcFlKUUx2VzlvMXFGc0EyTTZWK1AxTThmMVc2TkpkbHlpd3lOSVND?=
 =?utf-8?B?Mm8rb3V6WThrL2RlanlycHVodHR4dlJqL0hnTHJscGovQUxNOSs4dDBrNkMw?=
 =?utf-8?B?bVQzR0pFd1JTdWtOdFRWN2U5V0Fac3ZkTG5UZ0Y0UjZ2REpHT3JZMlJVaERu?=
 =?utf-8?B?TGNmQTgwL1gxRHl5UUVkT3g0QkxBeUZJaE9RaW1XalFUbzIrTzl6UnBwV25u?=
 =?utf-8?B?MEswR0JrU0Y4WlpNWU1KME1hWDZBNXg4cnpCS0NVRXBzdWRLWDJhcG1Td1pp?=
 =?utf-8?B?Ull0UUhUQzEycGpRVFE1WFplbDROY3FFclpQamc0Q1hDemVtOTUyNUZyOWJw?=
 =?utf-8?B?V1psdDczNG92a2VWSDlEQkJBWVBqYVJKSFhObUJ1K0I2REIvVDAxTmpjdkQy?=
 =?utf-8?B?ZkdXYU9EbGkySjBpNVdkWmcwUEZzSU9rYSs4dXZ2YlRuTmZZa0tKS20ra0N5?=
 =?utf-8?B?bXo5Uzc2RFBWb2d2b1hXc3RCaGRiZTlrcnJIM1VGdEJjeU9Ndms0akh0RUpQ?=
 =?utf-8?B?ai9xZ0JwcWZjNVFyaXFTNWxjSFB0eGtzdDdlV2JrK0srUWNtNUVaSk1yM0Yv?=
 =?utf-8?B?N294amRDc203UGRZM0wvY0JzMmtJV2FvL044M0hJMXkwRVVpdmEyYlpCMjRn?=
 =?utf-8?B?RkZ1QTc3bmRoZWpWYll2SmNGRzk3QloxUk1QYXVITTczQzV4L3RaNkV2aDQ4?=
 =?utf-8?B?T0pPSUFUeW5hWWt0cHNtb3YydzUyRmdEb2g4MnQ1SHJlaWhkeU4vQnR5Ym52?=
 =?utf-8?B?ZlVDZVRQQ2syNGYyVkdLNk5ZRFFtU3ludWR3bG1WdE5ZQ2poZGs3eGRwdHpa?=
 =?utf-8?B?eHJaZjJvNi8rOTE0N2dDWlVOYU04WWR1S3p0cU5odWNFWkczalhoc1JtNG5P?=
 =?utf-8?B?RE5jRUE5dnR6NnhtOWRuU3VHemY5NGh2b3JPQk9HTzQxYkl5QWQxeGJXdkkx?=
 =?utf-8?B?dFc1OERYWVhmUVVaV0dwMnFkd3VaUG9oa0NjVU9DWUYyYk1sTVdVOTFDcThh?=
 =?utf-8?B?WitWTlZ6ZHhtOWpMK0NWUldGNkFIRUFzbkJieU9DWGc4eG42UWEwTmZHVmpH?=
 =?utf-8?B?cFNtUWQ4YUZPU3RIV3hPNXByN1EyeEFlTkRBK0RUbTh4d2Fib0NsSWU4S1ZW?=
 =?utf-8?B?RlZCNWx1QytueU5vb1YreUxLZk95NVgzbzg4WTZJOXZvd2dsRE1odExWajVr?=
 =?utf-8?B?TGpTR3lIS1BTZlN4TnluZWJqTVNKMnFkTGZpSENYVFY0eDBjOFRRMEtxVkFl?=
 =?utf-8?B?WlBWa1ZuODdlR05WeHVFdzkrZFRqQkN1dmVZTktwSGgzcC9JS1lpV29KTk5C?=
 =?utf-8?B?VVBqSXVMWTM5N3Y2YWZxWjcxaVBNYkpBV016VCs3RWtFYmI5N0d6aFFtUzd1?=
 =?utf-8?B?ZnlLR3VGa2M3cW5zTXNEclFtUlcxbEVIeCtpaDZjek5BWm9MR2FyZjE1QlQx?=
 =?utf-8?B?UnVzdFZ3d3N1OU8wMmFZVkRMTk4rWmdOSHRKaytzQ1ZpS0pDTFpWekwwSXhR?=
 =?utf-8?B?V1p3WTJNY2Y5ZmJxRkpPQ2lPMm9qUkx0VlRYdEpUcDlCOENrS3ZBSmltaHVB?=
 =?utf-8?B?ak1xdDlGTU1qWFprQkZ1cFpHSWpBS0FIRy9TZnJPMjBRZDVpZ0FlbWdpYkdN?=
 =?utf-8?B?bWR0V0NlL2MrZUl0UDZ4cmFOdy9lcGJyKzdZL3BPekJSWGdERzBucVJ6VnhO?=
 =?utf-8?B?Uld1SENSSzdLdldON05zNlRvU0s5aFllM1JyZVZ5NFJoOHJyT25SK3VhaVl0?=
 =?utf-8?B?UVplYm5RWTdTdDg2U2haMEtLbXVlSWxtcnUwVS83MDFTTlVrK3lsdVBXNktm?=
 =?utf-8?Q?9Ai7Mo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:23:09.1861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3930a424-150b-4981-b01b-08ddf02a212b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8894

Hello Thomas,

On 9/9/2025 4:30 AM, Thomas Gleixner wrote:
> +static inline void rseq_slice_set_need_resched(struct task_struct *curr)
> +{
> +	/*
> +	 * The interrupt guard is required to prevent inconsistent state in
> +	 * this case:
> +	 *
> +	 * set_tsk_need_resched()
> +	 * --> Interrupt
> +	 *       wakeup()
> +	 *        set_tsk_need_resched()
> +	 *	  set_preempt_need_resched()
> +	 *     schedule_on_return()
> +	 *        clear_tsk_need_resched()
> +	 *	  clear_preempt_need_resched()
> +	 * set_preempt_need_resched()		<- Inconsistent state
> +	 *
> +	 * This is safe vs. a remote set of TIF_NEED_RESCHED because that
> +	 * only sets the already set bit and does not create inconsistent
> +	 * state.
> +	 */
> +	scoped_guard(irq)
> +		set_need_resched_current();

nit. any specific reason for using a scoped_guard() instead of just a
guard() here (and in rseq_cancel_slice_extension_timer()) other than to
prominently highlight what is being guarded?

> +}

-- 
Thanks and Regards,
Prateek


