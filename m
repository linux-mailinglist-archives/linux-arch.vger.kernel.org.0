Return-Path: <linux-arch+bounces-13471-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F94B51554
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 13:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF263ABCED
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 11:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF292797A1;
	Wed, 10 Sep 2025 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NlNGZNXK"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D179245005;
	Wed, 10 Sep 2025 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503224; cv=fail; b=B4SLpc3/JA+OSVZzsCGi5o41IrY+ODkMZueYbqHT0o00cFU/4P4NKoXfjatu1+WBvbdDIMmQtC4U4sWWb7f8VKqQXrOAUggLtkmvxpUnTH2+qkbSq4yWSLk8IP31IWN1y680lsaSeE8qXzKuRRQ3r79+XMWmo8p4HP+9c1KLCYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503224; c=relaxed/simple;
	bh=WAwUmVKqsUm+RRdRqo5TNaaA7PWkS/lUOYvwMbfey7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LYAoLOy04Dc503cs/KvQGAlBEgqFsddjWrMYtZhsWGjMK/SDoQrAAbUNnsYXRQgXsmyXoG+rHWm5Rhvg48S0WpP7qTkCs/qgpovh1eNVioOLdLUNd1LFFDnOG9HaWX3dtkdaJ6gTO6xitfYwIQPDpnPoFkBMHy6ubvU4lbQ4m80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NlNGZNXK; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDupi+FcErLeo1eahbq+iXX9OtB2JFEJVwVYmtU594uDpULXQ9v5KrYxy5+iBcP4s/rzQo5RBlw1F2TzT3X7vdEPKjRjf/MFcg7G0wurpaM+9kDrP8y7hTB7k+8Qaiu4JLuBqmkBZ+w4/iGV1CBz4gOjBY1vVyTkFiNVZLzKoVGVQW7gG51em4Oy4SgthrWdQeXniFnr7trywSphzeTEscAoub6q3GMHVtxETcQZT2HuF1XtTuOLyNprawAkzRyfQIBCcnOiyVsnjY6Xd0xIM8gXsSyRaqu7jHfYoAJH2BggM5mQUWeJaycScnL/8KliLV940OVZU+BV+6dUO8X22w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3LG7ctCzek9pDgk9ylT7FeHeKYCJyPs7gCuJcZlXL0=;
 b=GTqFSHF0GABxiEUt5mUk91dIlMihTXOHOTplZnZ0bcUEWi+BYJ3y5ngq3vPhp+N93xUMcKN8kKDpjGIwYvvC9wMqE8QwJ+Yrv80sEnVZ5nSJm+x3w2ZUg0Jfj3qEGngD2Mv795DDNNjMdidOy5pIE3ceGyN+WWNx07d3ZjhGdjRzfb2vVi9B5NSdGxynG6o1NeBli8LN6C/u0lepzgeT4xPl168pwh6o2mvaLlFZ9fMcHfvz6f/QX29dXoUAo8hNzPyAP1RAQ8vvwcTj9/gtVXHzOV1S5Qc5mS1z5qtrHTQEyioG8gWI6D2sliYmhYfh3KiudIp5s6LZVZFDP8xV9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3LG7ctCzek9pDgk9ylT7FeHeKYCJyPs7gCuJcZlXL0=;
 b=NlNGZNXKG4CnVoIm/wUFDowqeK1eOth98ns8Nv7bVMGPHjFy1fQSGJauFLVzTjHQPKdBVbpwHj9tWn4jfMzd/d4vREaZFUOr+CnR2SDl7wvQaTlD/r0LKvNyc6jUESk9CWRJZUX5nYS0aoUKlEcQP4oTuytebo+6IxwdkscA0ug=
Received: from MN2PR01CA0011.prod.exchangelabs.com (2603:10b6:208:10c::24) by
 SJ1PR12MB6196.namprd12.prod.outlook.com (2603:10b6:a03:456::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 11:20:19 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:208:10c:cafe::78) by MN2PR01CA0011.outlook.office365.com
 (2603:10b6:208:10c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 11:20:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Wed, 10 Sep 2025 11:20:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 10 Sep
 2025 04:20:18 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Sep
 2025 06:20:18 -0500
Received: from [10.85.34.232] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 10 Sep 2025 04:20:14 -0700
Message-ID: <eeb87b48-aec9-4b3d-a0c1-afc83346b624@amd.com>
Date: Wed, 10 Sep 2025 16:50:13 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 08/12] rseq: Implement time slice extension enforcement
 timer
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
	<peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
	<boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Prakash Sangappa
	<prakash.sangappa@oracle.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
	<linux-arch@vger.kernel.org>
References: <20250908225709.144709889@linutronix.de>
 <20250908225753.077967162@linutronix.de>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250908225753.077967162@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|SJ1PR12MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1c4b16-f63c-4f65-f091-08ddf05c0661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFY3dWxjbUhMNUJGVDU1U0o2UHVYVnYyRjBSU2IzRzJ4UjMzQlRHanRPbFNM?=
 =?utf-8?B?Tisxdkp2a1QrTEtSaEJRdDNZSmJiQXBaZXEwaDBtRVN0cDhiK1hkcndFRHlG?=
 =?utf-8?B?eFlEbkpKRkhiVUJocWxsY0lVaDBuS29vZ2tKTVozSlk3WjN6cVpteVNINVZ0?=
 =?utf-8?B?cjVpV3B1RnlPcXdSMHEwWTNtNnNZZFlZYkUyOURqQzhJY0QxSkRpamxXMUxL?=
 =?utf-8?B?TEZKK29QeHg4c2hlVWN4Z1NDcUgzUW9Wb3k4YkZxQUwwNTFrbFhNVEd3S1JC?=
 =?utf-8?B?cGdPamVRbThidFAwM01MWGZUcnBDcW5OTCs4TlJYdmNSSU1TS3pKcU4xNkxt?=
 =?utf-8?B?cEtHL2NPQnVYaEQrTDFWR3hnUVRTdjMraTc0K3VkbUhvemk2aXFFY241bXhr?=
 =?utf-8?B?NXdzL1dvRUZadjdWejdmaSthclFHdXNLbExhdHVIUlYvVXRIUytYcExKWC9E?=
 =?utf-8?B?VHV6Z1hLVXQ3YXJBM3R1MWpHd0hMRStsVUE5VGR2aFdEWldnRHl5TnNRSDc5?=
 =?utf-8?B?aXdRdmNoWGhyekI0Yk15ZmxYcWRVUHNxaXQxcXNFQkt0bS9RanYxWUIxeWp4?=
 =?utf-8?B?djZFbFJJNC8wc1JqMXJnS1VMK0FXMTV6L0tNNlJzSStjYmQ1K2NLTG5TTzVC?=
 =?utf-8?B?eWhrR2FHb0VNVGttWFBtRWNoRWluMlNNdEE3RENhbTEzQnliblR6Lyt6SFJF?=
 =?utf-8?B?azdQdnQ3NVU4U0xCeDJUbjdpaDhLWDU4YXM1MWdYV0puSEJ4OHNtcXlka0RI?=
 =?utf-8?B?Rm1hSnVOeWtUdTdOVzJhVVdVL3JGYUpxb29JZmM1UnI1aVkzYlBEZlRBbW1k?=
 =?utf-8?B?bWppRkxTTllqZGJzTXM0WGV0cTFZMWtmT2VuTVlnUmljR0pJNWEzTDhSYnVl?=
 =?utf-8?B?a1BhY2lrNlN5eVVlZmZTd25NdSszUW0vai9qbkJGTXNoNjV4a29uQmZlWDhM?=
 =?utf-8?B?cjJJZzdyVmdKaFEvQTk5cFVvUVd3aXBWa014czlQWXpVTmdpcVQxc0ptOTkv?=
 =?utf-8?B?TlpRMWtLcFRXaDFyemtncm5CQUVXOVpkWW13RC91ZEhzbjBCaVpNUXBCWUc5?=
 =?utf-8?B?YS9sU3NrNUhJSG5XN0V3UWlETXhScFZwQmRtd01md1VXTUxvRXViTUJzVG11?=
 =?utf-8?B?UVM5NGo3aDc3S0JHSi9keHIzelV6d0dRRlM2QzFsby9peU5MMDZnYUZBMFln?=
 =?utf-8?B?cTJQS3VZcSs1WmFab0UvOCt4ZGsrYXliTDBPc1ZDQjlRUmNYUnFRcEtFMWR2?=
 =?utf-8?B?ZGU5UnZwU0NMUGZ4WnRENEYxU3Y4UnJXVktsTmJCMG55eXZPK0VmVllWQWZF?=
 =?utf-8?B?RzEwOUFDSE1zdFFCc2E5Y3M3bmtXeGliQUw5NVJnMGt4KzFOM0xQVDdRekx1?=
 =?utf-8?B?NXNnVHh6VEtkV3F5cTk2QUpnL1lPZ1Z0NUk5MFVQM2RqNWEzdEZDblRhUS8w?=
 =?utf-8?B?akJCTlJTOEM3dCtPa2pDTExUN1VhZFExaTZPM2szL20wbkcyRTlUNmpnOHhC?=
 =?utf-8?B?ZHlucHlsdEwvVTNsVHNNL2ltMzdJbDBEZnk2ZWdBSkNUdXJ0dFdsQkUxN2Zx?=
 =?utf-8?B?NEVtNVRETDMxUmpKbFEranZ1eGNlZGYwRlhSenNwbGx2aVFHckM0dTE3OWZG?=
 =?utf-8?B?Q21sa3ZuSW10dittNWhJYys4bm5YcHZXMHlVVVZqenJXU0g1ekpFZVE5ekU2?=
 =?utf-8?B?b24wRnk1YmVETFloMTNZa3MzbzlQNURVVGFDbnh0QU1PQUpRYTFVaTFNaVBR?=
 =?utf-8?B?a2grVGM5TkVNVjA2cjdKYXVsbWNVSU1RU3RTNytXc2RLVVBoYXBoZWo5dS9v?=
 =?utf-8?B?WnFyY1E0WmNYWnpLblEzcE1pclViWWQxNnd6V3BKZTNxYjRyRUlWWlBkblA3?=
 =?utf-8?B?cGs0bFVkdWdnaU5ISnpoZUp1RVlIVVhURU15K3FoWklpTWRhSUhncVEydVVw?=
 =?utf-8?B?Nll5aG9lV3dpTExzMjYyelJpZS9rUHZzUXBTUmxNZm9BYWRHME9GMHRqSzNK?=
 =?utf-8?B?cnVkN0lCMjcxWDk5WmJPU1ZvR1FVNzVEMFZBeU5LSXNHS3hYSjZlYVN6MURr?=
 =?utf-8?Q?AS0yVg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 11:20:19.0797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1c4b16-f63c-4f65-f091-08ddf05c0661
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6196

Hello Thomas,

On 9/9/2025 4:30 AM, Thomas Gleixner wrote:
> The timer is armed when an extenstion was granted right before actually

nit. s/extenstion/extension/ 

> returning to user mode in rseq_exit_to_user_mode_restart().

[..snip..]

> +static void rseq_cancel_slice_extension_timer(void)
> +{
> +	struct slice_timer *st = this_cpu_ptr(&slice_timer);
> +
> +	/*
> +	 * st->cookie can be safely read as preemption is disabled and the
> +	 * timer is CPU local. The active check can obviously race with the
> +	 * hrtimer interrupt, but that's better than disabling interrupts
> +	 * unconditionaly right away.

nit. s/unconditionaly/unconditionally/

-- 
Thanks and Regards,
Prateek


