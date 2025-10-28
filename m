Return-Path: <linux-arch+bounces-14373-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73919C13A2B
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 09:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739DA1892875
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 08:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5892528E571;
	Tue, 28 Oct 2025 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W6cDwCBg"
X-Original-To: linux-arch@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50E6246327;
	Tue, 28 Oct 2025 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641501; cv=fail; b=bs2awQE/zF/wpoiinPLVNEAjmaOdYy5m/HIa4I5xU5v+xj3AfjxR3Q3AMVl7cAWxC7wV74LIxWhUyt1Y4QV+5yQJ28Gtw2v23IB78aKTu0tEVH11Dur6OhsffSc5bF6XjnExWFRav2FwAdUD3vfHEJmgFVnoHjo9IXYdmLHV/O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641501; c=relaxed/simple;
	bh=J3FyFkSfhI24wgWicVuyRpniqa5jaG0aLOg00YgAlyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u9TnK4ao/rLJQRUM2fFGt7bgSrv70w4F9SOY6HDxxdKofbKXrS5hxU7VLLpiQxKU2aAbG1FhKCzC/fOlFfQRuHQr7e8cSeVtLw1ILz74OVMoDMg10iQNDmeHV7nIeRNiOiTZ1iaGNR1pdQ56pyy71pBMRVEa8PcPNia7oHWL1xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W6cDwCBg; arc=fail smtp.client-ip=52.101.52.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5GqFw/8iFanWnK0H1BDIMexE+RYlfjtC5kq9636pu5w4Dk3450d2eBOjXtA/7zkvWSuuAkdi0zcVghKjFX2CJ2eXXA3cC+HONHYk3Csxw1pZ28GygmQSDq49m622VErRwCswdo3MWuSKqjr69cnyy3+Yjk4XVnyRsoaAUjlt7Y5E4A2D+bAX/ILgwJej8PHr2rQThQtFClYZkUmC6xjP3OXzwwuqw7k+xTtV1xW4nDqvLBfOrEjfehxEhohP9nWUbv0E5plKHj4tbHl2LLj6HSs7umU2yoomaVFGLGnQPeEq9EKdVoAlGZ/1DHEhEIZlWiML/F5ospbhlBXiZ1QOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJmRMpXsYqo/r+SSFgkCrHJ9A4DDeTkz5gzNtsjcD50=;
 b=tZhwgc+T45eE2NsMUox1RKNRxJmaR4s1nbDSED/cNBYFbT157OerBlgO8lTO6IKQ8sWiM7pjBVD6ojyvgfSQ1oCddg2NQmIBm8pACoJukkGUNn0mvXngdTGjX5MtEzNB5R1l6wpBKEeki2pLTzWUfoQL+CjcLOdM1miOue1xYQPQBb4sIq/YkTgrlnG5ptcqN5aZsbZ4cZ3LzKTbKTb8jYF81zhx/1yCsbYT0XfAK5aYKnY830H6K6qpVuN1az9VwVwXHHrG/Rj30138NEOVVEt/Z43iUZr2xfDgN08VvHwOUhXiKwAnbNavYJLOk8GAATNXDyt27j8NuwzdiBqdug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJmRMpXsYqo/r+SSFgkCrHJ9A4DDeTkz5gzNtsjcD50=;
 b=W6cDwCBg4PLbBudXFW5ZOI9c5pW8HtMy1a62YTqwfnS9zDxSRN88CwMbjoia3yEEiKQaXJAJGGdDcqMjOaFYnbfXpZYRSKgFPtOExNj+eZFZnnOBFZmM85gDFL0YCmRGRWdBLZS0pY+Hsrgodqgdmj9iAN3Qbl+df6vPOVFq0CA=
Received: from SA1PR02CA0018.namprd02.prod.outlook.com (2603:10b6:806:2cf::26)
 by PH7PR12MB9175.namprd12.prod.outlook.com (2603:10b6:510:2e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 08:51:35 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::8) by SA1PR02CA0018.outlook.office365.com
 (2603:10b6:806:2cf::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 08:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 08:51:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 28 Oct
 2025 01:51:34 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Oct
 2025 03:51:33 -0500
Received: from [10.136.37.11] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Oct 2025 01:51:30 -0700
Message-ID: <db7f7264-6ccf-4f55-929a-4c2e813dd8f5@amd.com>
Date: Tue, 28 Oct 2025 14:21:24 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 08/12] rseq: Implement time slice extension enforcement
 timer
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
	<tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Prakash Sangappa
	<prakash.sangappa@oracle.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-arch@vger.kernel.org>
References: <20251022110646.839870156@linutronix.de>
 <20251022121427.406689298@linutronix.de>
 <20251027113822.UfDZz0mf@linutronix.de> <87cy68wbt6.ffs@tglx>
 <20251028083356.cDl403Q9@linutronix.de>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20251028083356.cDl403Q9@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|PH7PR12MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa4b299-fe0c-49ba-213b-08de15ff331c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnU1U1RwaGNOVTZMYkRMa01SMjVLZ0VKT1B0TFFCbkNRK3NzdUxpbDNMbnJi?=
 =?utf-8?B?T3pIRWFtM2k1TkpBN2hIdklza0UrMFdmRk1pR09PdXhkblhKSlBsMndLSmVI?=
 =?utf-8?B?YTUwZVhpZFlqUVJSK2xCaFQzMktxelREOWtJQktPUW5CcTRPSVRKdUl0ZzZS?=
 =?utf-8?B?RCtlUFR6TDRQVVdTZUo5clpXaXRXUlQxRU1BeEFUTkN6QTFyQVZYbWdhWjYw?=
 =?utf-8?B?VG9EdjROSGd6cWJhQStLOVAxdnJ5MElCdG1WRW1mQTRFdG1mUGFKMGp1MzQ4?=
 =?utf-8?B?RWdEMnRRbXdrV1hiRlpZTVZuaWk4VE05ZmJyUmRuaE0vNzhpMkQrQXcwZnJU?=
 =?utf-8?B?R3Fyd0JJTVNncjhsUktobkQ4Y2wrTEZtSjdzRFdyVC9ZV3VaaVNHLzR2MnRN?=
 =?utf-8?B?cW1YU0RtamNxZnpoVmo1WHhLSjZxWGFNcVRXL01nNG14VFh4MWJwSDdLdkdE?=
 =?utf-8?B?TDBwSDh1b0hLVHNoZXR1NUN6cGFqMVBZOFBzRS9Cd2xNckhTYmFhZG5MdTJW?=
 =?utf-8?B?TitsSCtmNHZ2UDJneU5DanIxSmsydmpvRUJtazlSYksrckVFTkNXL3E0WUJv?=
 =?utf-8?B?RE05SmE4eCtBUjRuR1hHS3pZVmlqcHJCcDF3d3pKcjBPdmV1endCRDB2U1g5?=
 =?utf-8?B?bzFXdTB1WS9Jc05QQlFWMlZKOG1HcjV0Y1hhMC9ZNk5sMENpSkVnSjcyY1hE?=
 =?utf-8?B?YWpNendPNXJ1Wmpld3MyUXpaR2dRYkN1d0pFa0JsUy9QeU1od043SjJtL2Qx?=
 =?utf-8?B?Uy94M0RCTGFuTEI3T1dkM2NIVlRDOGJBbEFYZXRHRWthSXNJZWdESFMrRmpn?=
 =?utf-8?B?Mk1vNmZqbTdSK25nN0U0Y1ZDb01jQ1BLc2UrWExUc0JyZFhWZzVuWjAvczZ6?=
 =?utf-8?B?QitFY0VKL0IrK3BpK295TDRvZDgramtjdVNDNmdSZTlGdkdESUpsRzZrZnJ2?=
 =?utf-8?B?bWtzbUQxRXBmcHVBMmJSZldWSG1CMUhpMEhnMUR1UUNNR1hra0w2V0pWTm45?=
 =?utf-8?B?WHRiSlFrcXFWTDFNbDJBL0FSbkVJYlFpUXU5R2QzOTFSSEtOR3d1b3BGNTR6?=
 =?utf-8?B?MHJSUXRtZU1aMUUvckpVSk9ub2s4eEtCMkZUZlMybFBwbmdsNVRNSFk3WWkx?=
 =?utf-8?B?VUpZRHZFMXJkUkF6ZlVnOWpvek1YUHhOem1UVWNmKzk0Z2tYQjFuOXJZTDVx?=
 =?utf-8?B?elBjVExlc2NRVWNHcEJGYjlEZTJXQXV5MXlLYVR6SVFSeVhTUWU0aUlCbnVY?=
 =?utf-8?B?VTR5OUcwbmFFK2tKMThjbEVRTmdpWTkvOStTcGhhWmJ0V1RQL05kN1NCR1ZV?=
 =?utf-8?B?YmNxQ0JlWi9jTEtkS29uNHZ0V2U4Q05WNytnZ3hHalRDTnVldHovWEo0enBL?=
 =?utf-8?B?TkZZU3BLNlQ2NEhRUEd5ekgwYkFuTWhOeGFLVUlYNXgxRHR5clBNb1pwaVZ4?=
 =?utf-8?B?a2tUVnEyOXc2ZDEzMVh2cGlCUmZSdlNGSjJQZGd6Rm1hQ1dhTGMvbVNEakt3?=
 =?utf-8?B?TUlmMFkrVFh2Z1dJSG1sRTJDcm00ajRldnFUWEpsT2lYcVQ1NGhNdUo4VU5S?=
 =?utf-8?B?VXNGQm1HMlAzekRNZG1MTDhSYVZzdTJQWXlabVZJbHBaN3hrcjhBOVdFUmEr?=
 =?utf-8?B?L2ptVzdkMlppVmxFcnhIZnowaXF2eGxKMUdoa05RYTIya1NBVTJxTzREWTVT?=
 =?utf-8?B?NWY1aDVrcWlGSzFjdU9MZzdodnRXQ3lNaVE0dGdtUWwrUTgyaUFzU1BEYzFt?=
 =?utf-8?B?ZSswS0o3Rk4rekppRmdHVm1EWjkxS0pBOVNmYTFnNkFEL28wb1FYN1ZkS0F2?=
 =?utf-8?B?MmZVSGpVdTRzOHhDUlhobW1DbS8wemNTODE4VGxVdTA5WUJzaWJiWTZjU2pM?=
 =?utf-8?B?dlc0VnExajk1MWg1WDZhRGkvQkdVZzhQdjlrQ2kxTWg2bW9PQmtlQ01kdDAv?=
 =?utf-8?B?UXppd3dqSHpUdURpMmxJMXhrVERCaGN4bytRTXV4QXNjeXQyRmdIbDJpcUxn?=
 =?utf-8?B?OVBjemlVVGtyN201ZWRZK2FXcnFIWm1oT2ovMThlVUQ1UWJzV0pkMVY4SDFJ?=
 =?utf-8?B?UkZMRUlvQ2s2cVdSTW1jeWlnYzRVaHZDWDVzL1UvVFE0d0ZQVTAxZlJIRGVk?=
 =?utf-8?Q?qqAg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 08:51:35.0904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa4b299-fe0c-49ba-213b-08de15ff331c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9175

Hello Sebastian,

On 10/28/2025 2:03 PM, Sebastian Andrzej Siewior wrote:
> On 2025-10-27 17:26:29 [+0100], Thomas Gleixner wrote:
>> On Mon, Oct 27 2025 at 12:38, Sebastian Andrzej Siewior wrote:
>>> On 2025-10-22 14:57:38 [+0200], Thomas Gleixner wrote:
>>>> +static enum hrtimer_restart rseq_slice_expired(struct hrtimer *tmr)
>>>> +{
>>>> +	struct slice_timer *st = container_of(tmr, struct slice_timer, timer);
>>>> +
>>>> +	if (st->cookie == current && current->rseq.slice.state.granted) {
>>>> +		rseq_stat_inc(rseq_stats.s_expired);
>>>> +		set_need_resched_current();
>>>> +	}
>>>
>>> You arm the timer while leaving to userland. Once in userland the task
>>> can be migrated to another CPU. Once migrated, this CPU can host another
>>> task while the timer fires and does nothing.
>>
>> That's inevitable. If the scheduler decides to do that then there is
>> nothing which can be done about it and that's why the cookie pointer
>> exists.
> 
> Without an interrupt on the target CPU, there is nothing stopping the
> task from overstepping its fair share.

When the task moves CPU, the rseq_exit_user_update() would clear all
of the slice extension state before running the task again. The task
will start off again with "rseq->slice_ctrl.request" and
"rseq->slice_ctrl.granted" both at 0 signifying the task was
rescheduled.

As for overstepping the limits on the previous CPU, the EEVDF
algorithm (using the task's "vlag" - the vruntime deviation from the
"avg_vruntime") would penalize it accordingly when enqueued.

The previous CPU would just get a spurious interrupt and since the
timer cookie doesn't match with "current", the handler does
nothing and goes away.

-- 
Thanks and Regards,
Prateek


