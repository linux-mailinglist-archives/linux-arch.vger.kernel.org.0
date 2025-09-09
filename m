Return-Path: <linux-arch+bounces-13447-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9FBB4A4E2
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 10:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274CD1BC5F97
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 08:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C58239E60;
	Tue,  9 Sep 2025 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u67XS7Qu"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D688230BCC;
	Tue,  9 Sep 2025 08:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405724; cv=fail; b=CMtOMS2z1NOubgrExZIEslzpcK3SoDhppQg9NB+XBZoJmQk1OjfCSg1nD2kybAFGiZxaEMxi15rjTuYsph8XIQHImT4/wFczHNvWAaT2vvtdi02TzJ/VeAB8AHthZeAW0yt3JB03m9dwUYMvGyq2PtlDhPQTgnMGiBt4rkNyJjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405724; c=relaxed/simple;
	bh=ItgphSsu+TNrCo9L7RUjYlY/fombkOd2FCSwhud8NLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EUuJMcizOCz9+ZXYr+NPEYHon3ekDdQiBNULI0aAYfQA9dJ+gvXDu9j0CbquqMUT/nrv9b7SgqQrXx61zlRl5elVURC3F5dJNTOethotEA7y9LwYJ3uNhx5w3XzwsCR/kFvxUtP41Qv+A8EGeLsnry/gLB5749cRut0kiQYLvv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u67XS7Qu; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Om3u4hkwWx/sJ6OKZZJzQbBY9so/WjX/kln5FS55/nEiorbMhVZJZqEnTWQGsF0U3v4o78r7WtGVGscayazp8WoB0F8o1zaVZ187zhje4HtVmHqgQ5wBQ7ew3adQdatIbRgFbqBHCk4HslgVlk8JMj4HgdCOOx0B0//0XKLjNlgp6gFhCwEf1+nvkGaMR+mz/ikkCXrM/8ijUjlZBL1n/0i/680gqJ1OeXfLBlSu+rZBrcVyDOIBLCxh9eAT9d7hveEX73R/3lV7ITLIHEn80ZkTHtm+zQT1uD4Jg4nBhSXjV8w41OFuZMbH3zTPUzBLnfpKsktjWVYXy5j06shzOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1qR7a6fVRr5jF6Pr6RgfUBtT8TKd90g3s6NUD/JdqQ=;
 b=odoExkuOTKiEcyFh0zG4wCx9wO7PauYkXinMS8WHxr7v4/DvyeC/EznQI7dNlEGHy2EUd9492fR+zDyAN1WV1FkowZnSPpHZUO15g6SHsd6tjOOkMBXEM2G3jIRy7OPDiOviqGgFUYazZZx1es7XK288ZyNXiQXyVZCBP9tUYLku2n+YjOL4u/lGwy0v62pZW/XGNyTAQEY7Jv4P8HTmnvReEMOdwR4qgopimD7MAiS5No1kBm7/CD/a0i9e8Phw8IGznAcpBg3ebL1qXiiYw8jAr7Cutm6swRi7a+xrxxAAgSh3UkBBQz4zv79Mz/GqjS0CMc09yOl+pbaw1yUIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1qR7a6fVRr5jF6Pr6RgfUBtT8TKd90g3s6NUD/JdqQ=;
 b=u67XS7QuJur9ltk5q54cFy5ifmpsFs5QJME2S5apq7V3B9dVCpMZtue0/RoiFxQ/krFyOOBVSbZlGhNEx+VyVZ8Ng0VxELX6VgNGuyQ804vcWWtPmF6uQJqkVM50QhaEqZctt0sNk0wDDgudv1r9SydHwXzSSFVMv2zp7mA8J1s=
Received: from SJ0PR13CA0054.namprd13.prod.outlook.com (2603:10b6:a03:2c2::29)
 by DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 08:15:19 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::76) by SJ0PR13CA0054.outlook.office365.com
 (2603:10b6:a03:2c2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.14 via Frontend Transport; Tue,
 9 Sep 2025 08:15:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 08:15:18 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 01:15:04 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 01:15:04 -0700
Received: from [10.136.43.237] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 01:15:00 -0700
Message-ID: <18383aa8-5774-4805-ba98-46b292f3a2a1@amd.com>
Date: Tue, 9 Sep 2025 13:44:59 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 10/12] rseq: Implement rseq_grant_slice_extension()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
	<peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
	<boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Prakash Sangappa
	<prakash.sangappa@oracle.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
	<linux-arch@vger.kernel.org>
References: <20250908225709.144709889@linutronix.de>
 <20250908225753.205700259@linutronix.de>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250908225753.205700259@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 0192d318-f3cb-4658-441e-08ddef79037e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U20vNEFHUytaOHZMTGtXTEl1MzBNYWpSQnhFZ0tidlBxWTQ3Q054UUpMeHF2?=
 =?utf-8?B?MVlISms2eS9TT1cvaWlJRW92RjF4bGUyaFZaWXdRMUlKSGdVc3Y1czg3Z08y?=
 =?utf-8?B?TlhmZFdQa3JCVHFvU3R6bEUzd3E0VTlQRTk1WUxnbzc1aW9ERldnVG51M09X?=
 =?utf-8?B?cjRLbXgwZ2RGbHJWTW9FNC9JbnV0TmhVQ1dXVStLRFZ1aXRDT2t6eUtIN1E1?=
 =?utf-8?B?SXNmWnBpbEZycEVxOTVHQlY0ekZ4QmkwRlJjb3g0dG1yYjZHNXFDRkQ1ek9J?=
 =?utf-8?B?T24rcEthdVRkS2pOc21qSFFueEZVaHZaZVgwMEdLTGxiNTJUdjRxNG16SGxN?=
 =?utf-8?B?RVByQ1ZzUC9nbi9YVmsvRXNPUHNDL0l2NDlzR1hFRUl1TlN4NTA0SHNSSnJx?=
 =?utf-8?B?TXBqS3BNM1VLWDlUSGlwbTNrSmozZTB4ZWxPZWJRNTVSRGtuUkRZN2pRRzZj?=
 =?utf-8?B?YjlQQjlOUUc4dm9XUVRPWHVKa1ROVitCNkRGRVNRaUczRHhqQVB5RVA1dkhL?=
 =?utf-8?B?WVRSVm1STGVpdk9hSXdJVVNsd3Y3Mi9IREtlTkM2dlpOd0ZFQWVqMXlGVTB4?=
 =?utf-8?B?dExMUk1LTi92MHVCbHpPSFVyaGFXNFdWcGRVUzFxOGhDTnIxWkk4MytXTERp?=
 =?utf-8?B?ZTRxYmhGSm5KUUgrQTJqQ0RiUlVoMnliQU03QW8yRzlGdHoydm9COWhDQThI?=
 =?utf-8?B?TVZjTEo1MjVOOU8yQlFjL01LOFAxWk5ISENSSGozMkdKbW9kK3VvZnBaSzQy?=
 =?utf-8?B?ZXB6Nk9pdGR3ZUR2RkNpM2Vmblc0MjF3ZENYK25GQXF1Si9GS0RjTnVZbmZ6?=
 =?utf-8?B?Rlpaajk3S0ZTaVc3cEY0UlpIS05OUzkzME1pMUtBcURZb0NVclluaGxHLy92?=
 =?utf-8?B?SXF4ZUNOSndVUlJxdUY2eWNnekhOalJ3eWV6dm5yZE9ZWmlqSFlFc0w2a1RB?=
 =?utf-8?B?M0poMHprOTlYSWdNclNwOXVnbGxKVlpUUHRNdnorMW9KY3IweGNUN2tqRXJl?=
 =?utf-8?B?V0F4UnNWbG4zTGllblIyOUV4ODdMZHByT1d6YktOVjVMZnpNN2lVVWtiM0I3?=
 =?utf-8?B?K25wcFhMSG42N0VxWmQvZTVpdytGUHlSRzhUbGFnWjNEenBLS2haV0Z5S3Jm?=
 =?utf-8?B?YmhDdlV5ekcrQ2F5S1V2UHUweExXeU4vVmdFcWRjeFVXTkUvcVBmaEdMTVF6?=
 =?utf-8?B?elZ0NlYzQTZ4VzNMcE5kQWZ5Q3Jhdk1WZjVrT0k2THh6YmMxTjJqRlNIeVlj?=
 =?utf-8?B?emlUeUxpUzd1YjJrR2FjMjNUVlpnbG0xeXB0Y1plOHRmSmlsU0FEWFhtNEFI?=
 =?utf-8?B?MW1Mc2hYU1h5bmszVElOWHBFT1NoaWJwL090WGF1cXdNYmxMUjNHQUMzNU1m?=
 =?utf-8?B?UFc3ZlVpaHlXNld5TjB5em5zUXBYV2MwSTErL1VwbUpRUS9zeEwwakxVa2hT?=
 =?utf-8?B?amdTZWtKdkhDcThZVUpCRzdSTHlMOTJQekRpdzgvUHVVbUZuV2o3NlJ5WW92?=
 =?utf-8?B?dnBwaUNJMU91UnVCcGpSV05KVmkxTURtaFMrMkZVV0VUMWtEbWNwNXRGdkxS?=
 =?utf-8?B?dDUrN1hjNERab252MS9raGxLZzB2OFZQdmYyUzVuK0dPaWVxcFpFRTlJM2lQ?=
 =?utf-8?B?V0FzU1Q1NzlMMnJlYzZyL3VmSGNIdkN4NzBnVUVrY0lOMnJCTU9ZSWVyYmdw?=
 =?utf-8?B?UW5UV09JV05jM0dCdmV2WTdnSzljdWh4REdVV2NxSm5FeFB3SDZQWmpNSmw1?=
 =?utf-8?B?bVFWZFlQZVltT0tKb1ZMRG9ac1JSbnNSbjZHUlZSckJDU1lWN2tjRndiR3ZP?=
 =?utf-8?B?ZG1zdDg2dnJqOW9EdUdnUkhzWlBNc1dqUzNPQTFpVkMvaUxyRE91WUw4UDNw?=
 =?utf-8?B?TVdWMFZDZWxEcElKNEw5QjN3dEVKZWUwbXhxMWY2UWNyZkUwbWxOY0VoYzA0?=
 =?utf-8?B?eWhMQ2djNWRiT0JiRkw4T3loR25VRHRJS3hTSUliWEJURERPWnZhclpramhP?=
 =?utf-8?B?MWtLZDYxbzBWYmNFTXhNSHRFWEJTajcybmpJY3hTVllPZzFJWDlzSkpxbDRG?=
 =?utf-8?Q?r1CcRZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 08:15:18.3831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0192d318-f3cb-4658-441e-08ddef79037e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229

Hello Thomas,

On 9/9/2025 4:30 AM, Thomas Gleixner wrote:
>  #else /* CONFIG_RSEQ_SLICE_EXTENSION */
>  static inline bool rseq_slice_extension_enabled(void) { return false; }
>  static inline bool rseq_arm_slice_extension_timer(void) { return false; }
>  static inline void rseq_slice_clear_grant(struct task_struct *t) { }
> +static inline bool rseq_grant_slice_extension(bool work_pending) { return false; }

This is still under the CONFIG_RSEQ block and when building with
CONFIG_RSEQ disabled gives the following error with changes from
Patch 11:

    kernel/entry/common.c:40:30: error: implicit declaration of function ‘rseq_grant_slice_extension’ [-Werror=implicit-function-declaration]
       40 |                         if (!rseq_grant_slice_extension(ti_work & TIF_SLICE_EXT_DENY))

Putting the rseq_grant_slice_extension() definition from above in
a separate "ifndef CONFIG_RSEQ_SLICE_EXTENSION" block at the end
keeps the build happy.

>  #endif /* !CONFIG_RSEQ_SLICE_EXTENSION */
>  
>  bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr);
> 

-- 
Thanks and Regards,
Prateek


