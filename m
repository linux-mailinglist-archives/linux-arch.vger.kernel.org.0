Return-Path: <linux-arch+bounces-14376-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04674C13C47
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 10:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39271A24F9F
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 09:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD832D5C91;
	Tue, 28 Oct 2025 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m2Qheq1x"
X-Original-To: linux-arch@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DED2BDC34;
	Tue, 28 Oct 2025 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643342; cv=fail; b=PVKHMRzcmtUB96JuygbvhXj1e967ZWE5glP4YoKzOFtbvnAFElnQXYPYqk0uGG31xxUqUVINfT/lQHZfxRa8782vwEOrpmcS/bamFtjPDbjJ7BiLxVTy7/9k3UDhmSNtaoc6ha/wUrRZaGh4HugHLirEc3vqSWJVGFt5aZZxEgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643342; c=relaxed/simple;
	bh=llSI2aPfmLT8voI7iKBCY+OwHFpg1bA+Qax2Aj1MXR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MBdYNurNBjN7tGqwpx8a5XTx8bqRU5Nts3oDFBa1f7CCNJAlEJK41sUkKqUZNZkeMDse5IwMq4Pav/5RMrkUaW7S/Ey2kInvTBEVbnogpFGULRJ/KlKrHBVrhqikIvSPltu//+qioRo2kSnHSIWSoS/NAOq6Iv+UTR5KLSp2N5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m2Qheq1x; arc=fail smtp.client-ip=52.101.46.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5ZxWQJpB85VQCxNeMly+97u9pzJK3tsfr059Z2hmLkfy8NyuqCsC/ue3LBZICZREc4t91EmAraMi9EHrF9JA22szOkxxs8F1joq6RJTyCSB6KESIEGT/ewx2Prtb2eXixFI1A3BkFr6ZfGpeWAFXnnPY9g5v/yOhjGpAgnP38KABTVTHKEwNfEmJlNktQYWGM92DbfTS3t14RK+wAjSFoLKjvy8Ayg/ZU7woqsOMHIreQqZ43fGGyLQQ9d1lSWavXaSraCYqpSd+Ld3MIRrAlQ1tEVlj6Fgh46EkV2EJ9ZJaCBT+9MMoR3sNnCPLzYRfj0vmA99KkBRhtagsf6isA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtySrbupAR7Km0Ffs8UGvb+PwcBnlQ367KIhnbxwHrQ=;
 b=bBrJwNIuqQTKhb83faMGyuHB+ahQEEmCa9pityW2Bu5V5OCpL1MmuKinhutMfjfmK1Y8Je4szX+o8PXMJbkJkQgzf4RdGrUSYTm+clbjwm6yWdOOmSoChei3nL0Jx60dqDUDk5pwvWql7yDlFLodOUvLHENsScYEGUpJKDbyhtXInMnUClGofrgfKiFlGVx+oXInGoY4Eh9G36ew0MTELRAFSeX642U1HwdapAF+o34szbL7F0Zr4vvMkv1D9aenX6OzkNwTVdiiU+pyRbhmUUp3WikKyQ8mnIMfBVo9L21tUGubyYgLKgdqi3DIr0W7eOzJspg6i9zh0IlEKJCGmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtySrbupAR7Km0Ffs8UGvb+PwcBnlQ367KIhnbxwHrQ=;
 b=m2Qheq1xHXPGVaZL+2m8xBDtKfFN7bRrgBxYnPdPzYZZ6QNWr8Zyd2crfX0Zaex9sODliBLP6YHCsCLa8nnx2yjMl30TxPLdgjmpZAWrOs7gNgkZEZiO2q28shDdUwc8QSZRkOzgsHCgRwToH7ZZdctQhwHtI8MJi8X3yD6j1m0=
Received: from BY3PR03CA0018.namprd03.prod.outlook.com (2603:10b6:a03:39a::23)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 09:22:14 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::ee) by BY3PR03CA0018.outlook.office365.com
 (2603:10b6:a03:39a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Tue,
 28 Oct 2025 09:22:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 09:22:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 28 Oct
 2025 02:22:13 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Oct
 2025 04:22:13 -0500
Received: from [10.136.37.11] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Oct 2025 02:22:10 -0700
Message-ID: <f27bc532-f87b-4a46-9ffb-b38409b02c97@amd.com>
Date: Tue, 28 Oct 2025 14:52:09 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 08/12] rseq: Implement time slice extension enforcement
 timer
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
	<peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
	<boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Prakash Sangappa
	<prakash.sangappa@oracle.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-arch@vger.kernel.org>
References: <20251022110646.839870156@linutronix.de>
 <20251022121427.406689298@linutronix.de>
 <20251027113822.UfDZz0mf@linutronix.de> <87cy68wbt6.ffs@tglx>
 <20251028083356.cDl403Q9@linutronix.de>
 <db7f7264-6ccf-4f55-929a-4c2e813dd8f5@amd.com>
 <20251028090015.hcvhq9YP@linutronix.de>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20251028090015.hcvhq9YP@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|DS0PR12MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: ce647185-4e59-4c14-d104-08de16037b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clhpaG5QbUphWCtxY21Za0hObmVkZW1FaVZhZHdGRWdTUFhvRHdyYmpBRXNa?=
 =?utf-8?B?ZnN5MmZGVlVhWnZka1A4WFB0WkZaU1V3a2xuMVVNUlBlcUsrYjU0WHlBMEF1?=
 =?utf-8?B?WkNNZTI1Y1U2cHNsV2swMU5ObHZUVjlpUVpiZlVmL3grT1NhR0w0TFQweDE2?=
 =?utf-8?B?RVZBanR3dm1xeHBPdHQySmdtTWVBTk9JbFAvRkdDWGF3T2M5VldpQWRlRnQ1?=
 =?utf-8?B?a1dlOWlYbERwczBZbTdsYWFDREFVSEU1ZnRETjB3SVMzVHVBdTJVakJJaGlx?=
 =?utf-8?B?NU1SeEtZL1pjVmVmejFiSVpvblV3aW9USW1GVkpwQTBCeGlsNGNzVUEyTE9F?=
 =?utf-8?B?TmZkdVRyYlNhU2RIV0NQWUUwcnNsN3paUEVhMVkvNm4wZDg4TVpzMEc1ZWRM?=
 =?utf-8?B?SlhqUWpYUGhtMm1HYll0QjhGTExZWEVDUG5sR1o1NXRiUzhxdTZMWklJOVFj?=
 =?utf-8?B?a2laWCtOdXh3d21FVlhPUU5vT3YxMTZoOW85OHRLNUx3UXRZVXBxUnQ3NkxO?=
 =?utf-8?B?RU5CbUNFQWxvZExJNkpTMFF3Mm02T2xTa2lnWm83WnUvdjdDY1p1Wk0wdUtD?=
 =?utf-8?B?anQ5eUZRYXpnWkZ0dElGaXgrN1Q1aW1EbEJQUkp4dURiSzJ5WE5PcmxFcG8x?=
 =?utf-8?B?OFZSTzFVYXA2bFpHZkVjWTZBcFc0RHBlUFdVdWY2ekl1WTJZUVgvS2dQNUE4?=
 =?utf-8?B?Ym5CbGJacnJlKzlNNVlFZjg2akRrV0JnczE1T0FjODNHcXdEWWJyQ0kwUXRi?=
 =?utf-8?B?QXZnYTcvQmx5MUF3SGJsME5mUGF1Y2lXZjByRUdoNDB3TXE1UmFjbmI5dW9Q?=
 =?utf-8?B?U3JVVXIxSEM0eGI5NU9Kc1J6ZmhlcmVyZk12NU8vYzVvVnBvRUszQjB4bDBZ?=
 =?utf-8?B?VHdkdStrdnBOV04yWnB1enEvLzdBR3JSV1ZndU1KWEt0WXAyZEQrSCsrZlFL?=
 =?utf-8?B?R1Exc3VzQkZ0Vndhd0FhNFZ5QWZFVGVzSXpobUZsdzAwblFCMWxvSjJkUll3?=
 =?utf-8?B?a2xicVBqV2xrSE9JMnBLdDc4YWVNMndTb3o0amZ5ZWFpQVBRaXVoNUZQbmpK?=
 =?utf-8?B?TEFiSU14MWpDMGJvcHB6dWZkTmVoY2ttcnl4eFpGUStIa3dCdmdOVkp0YzVW?=
 =?utf-8?B?dEpWMEU5UHE1TEpJaGZTUzBsRi9yaEpJd3FrSWR6bnBhcFhMaDJaZGhHRUNM?=
 =?utf-8?B?RzRkYzQ3QzZHd0Rpam53SThzaHpRak5yVGVDcGp4ZElXanpYZmV2MlFsTkdx?=
 =?utf-8?B?RmRqOHAzQUExK1U0Nnp1aEs2UEhsZURUSVdST2g3Y1UzdTNJLzl1VEUxTlFP?=
 =?utf-8?B?ZE85STBsS1FpLzVDNEFCRXovYzVSRWFNbE8zK3VhbE9MVXV6TGpmbExlb2Q2?=
 =?utf-8?B?SDY2MUVpQ2NmVEZMd0R0b0oyNWg3TVhRUExETWlub1lwWmhtNzBNQURVSVNR?=
 =?utf-8?B?Y1pDZjJxd3JVbkYxdVMzUVZxanc5R2ZuanY4OXlFVlJvei9JZDBpaVVhQUxX?=
 =?utf-8?B?Mk5mUkgwK0RwTk9JYnMzck1lOE9XcmxQN2Qzc29BdCt0V2d0NzhYWk5MUy9N?=
 =?utf-8?B?a1BMMFN1b3JXeXZDUmNGdkpZVGFYQXU5R2FWU2FMM3VaRGZiTUF6MkRtTDRJ?=
 =?utf-8?B?OERBOW5jaHpRcWViK1JJaUp2L09rcHVNcGZSYWZXN1JQVDVIbnBnOG5nd281?=
 =?utf-8?B?ZGwzZzgwbmRXOTdhM0JTbzBWejV3L1h0SWxHbXArVjZYL3liTW5rOW1tZHU2?=
 =?utf-8?B?Vm95SzEwM0xTMVExeWZudHAxRXBXdDBnSXdQQ1NRazhIR2JtRmVmc3BFZ2JZ?=
 =?utf-8?B?bEZLMEtUbURwbjlTVTlmOWZwenVkMy9vR1VaUWpLMS9DR2FPaXFMTE4zZ2t3?=
 =?utf-8?B?SkNWY2VEZnA1T244T3htR1RKa0kzOFJiQW5NVjdDK1QrQm4wZ0g4T0tLSDQz?=
 =?utf-8?B?Ri83Snp3UVlQMHpzQzBFcW1IUTlON1luSkpyRUlWVkpXdVF6ZnVWcmxNN051?=
 =?utf-8?B?S1A2bFZiQkxMYnV4WlU2bVdIdEp6ZWdrMUFUTkhySjByL2cwSVhSSzRSa2tt?=
 =?utf-8?B?QjFwS2FtVTlOb1VScDFWV0I1Q2pPQ2Vvb1RJTERSeENDbC9mRkJoWE5UY2xX?=
 =?utf-8?Q?yQ3k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 09:22:13.9888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce647185-4e59-4c14-d104-08de16037b38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632

On 10/28/2025 2:30 PM, Sebastian Andrzej Siewior wrote:
>>> Without an interrupt on the target CPU, there is nothing stopping the
>>> task from overstepping its fair share.
>>
>> When the task moves CPU, the rseq_exit_user_update() would clear all
>> of the slice extension state before running the task again. The task
>> will start off again with "rseq->slice_ctrl.request" and
>> "rseq->slice_ctrl.granted" both at 0 signifying the task was
>> rescheduled.
> 
> I wasn't aware this is done once the task is in userland and then
> relocated to another CPU.

The exact path based on my understanding is:

  /* Task migrates to another CPU; Has to resume from kernel. */
  __schedule()
    context_switch()
      rseq_sched_switch_event()
        t->rseq.event.sched_switch = true;
        set_tsk_thread_flag(t, TIF_RSEQ);

    ...
    exit_to_user_mode_loop()
      rseq_exit_to_user_mode_restart()
        __rseq_exit_to_user_mode_restart()
          /* Sees t->rseq.event.sched_switch to be true. */
          rseq_exit_user_update()
            if (rseq_slice_extension_enabled())
              unsafe_put_user(0U, &rseq->slice_ctrl.all, efault); /* Unconditionally clears all of "rseq_ctrl" */

-- 
Thanks and Regards,
Prateek


