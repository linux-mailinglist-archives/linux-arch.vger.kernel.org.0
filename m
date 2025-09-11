Return-Path: <linux-arch+bounces-13504-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5C6B539A9
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 18:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED34858833B
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 16:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0175B35A29D;
	Thu, 11 Sep 2025 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="geKIAQcA"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D2A2877DC;
	Thu, 11 Sep 2025 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609551; cv=fail; b=jnBlWSWelOQn+6nucqlPkWJsiNMPSO/O7GLvoX+gb+28bHpdUfb5hUhlVCURJ7fVaPRubeQPTLNpSlE6aBk3+qW6UVs50JXQBGIrk+6hRiwVBbKFhvwNnx/bl3htCL+nMsYrqMJXo5plJYP5Fu7YuiOKkCt7l4aNqWvypVVBSik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609551; c=relaxed/simple;
	bh=gcS4A8k1hL1a3yCQfEtE8kad1bu17Zha20wAG9oz8gI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Frp+0zHngq+WwWAmOP2dbe0ZK7SFyL+gKcx6sp3qmXtxKyvDiozHi10xrtJEOgxVUP3iiDbhAq7MZjQzazoaPgw2SbVnMpS40cZlJGjwk/PM644t+naAoCgRwGIILhUkl3uyy2yIlwExYMAX/oZ24MMGsoRUKZC1ZE6JfBhCPh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=geKIAQcA; arc=fail smtp.client-ip=40.107.100.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZyDrnubEa5IVRXxHOllzPCYfZlDZ2mWcsXXrbHQ0sd0FPPG7ZuI6ZJ9W/7zMR1fsvhlUOdSOVhh1W9nZwcSdSZjKYTLahPcBLzv37Jq3tZnZfc+2vHI42zhv/0vNByEJf1UpJs0wcBdKYjXSXSVlsjMVpEQtqAIAnnwHsrdphXO+ou5DkW3mRKSccCVEJbL+IaXJvI4o+/pvPMqH+gmOv+tprdSIWZ0aSJ4i0HX8jZQmmEZV+EKcdOckhq0g9epRPBWDOs3t10btDluelLzbMUAdCO3bhXZx6Z+jobJ+F+5LsVjQhiQqdlxPsdrEbuOehvACby/gsE+iVD8vPADFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07F1o9gfExswj4DpRj2zIYP6CElOkuh6lfqADNs3jqE=;
 b=yNzKFUhlJ5LYnfpqnfwLM9xHHL94ywEJ7v69+zIvUxkGeR5YYMfkTBQ4gWWgQQTU11Ii3A+QLnxA5ry5JlgLl/qVssVk45KlQMOlfjB483H391xQDEM1Vnr3AEAN1krnOySU5QhR9nrfHoWsdnprNh5SlFCcej5KTyxDOuzSVPM2JXXYyweBftRyKkAw6Yhqybx/AOp9E2+ttblQDVYMPN++ut+7jX15uIRye8E/JVVI63YMTZ4BfWorNrPZohJ8hrQZPqo0XZHpD0vajcbsZ0qn7osFGlSKqXC34ErkE3yxlPrg2onbsIqGBz2u2DWEI2YG391k+Qjb9DsJzVXZ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=efficios.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07F1o9gfExswj4DpRj2zIYP6CElOkuh6lfqADNs3jqE=;
 b=geKIAQcAyQYwEJkJzktHe4rW38TrvIl3YqSdsZEEXTZIPww6ZtizHqBZtZtITr4/A/mFodcCiMinHH9Xm3TQ2crNOKEcS/bFj+HxGx+akuovDX4nvp7AVVRj/lxw2bsOLGQIATPO+5S0TkWH1H0DcbR8S/6TOlEcXbpp8CJUM/c=
Received: from BN8PR07CA0015.namprd07.prod.outlook.com (2603:10b6:408:ac::28)
 by CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 16:52:25 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:408:ac:cafe::61) by BN8PR07CA0015.outlook.office365.com
 (2603:10b6:408:ac::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Thu,
 11 Sep 2025 16:52:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 16:52:24 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 09:52:24 -0700
Received: from [172.31.178.191] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Sep 2025 09:52:19 -0700
Message-ID: <16fae242-8eec-473a-b040-5c6d35ddcb4f@amd.com>
Date: Thu, 11 Sep 2025 22:22:18 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 05/12] rseq: Add prctl() to enable time slice extensions
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner
	<tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
	<paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet
	<corbet@lwn.net>, Prakash Sangappa <prakash.sangappa@oracle.com>, Madadi
 Vineeth Reddy <vineethr@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann
	<arnd@arndb.de>, <linux-arch@vger.kernel.org>
References: <20250908225709.144709889@linutronix.de>
 <20250908225752.872081859@linutronix.de>
 <3951a525-8fce-484c-bdc3-3da4e6160c75@efficios.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <3951a525-8fce-484c-bdc3-3da4e6160c75@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|CH3PR12MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf5f9c7-4f19-4fa3-8e4d-08ddf153957b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTc3M0VPSEFMcDB2bHJZYWo4V3ViVFhGN2FTeHg0RlFhUDNXS3RHd3lXd3Jq?=
 =?utf-8?B?U2x3MGFRVDYrU3dYQmplZ1BlUTZ2dW93OW5YRXhTN2RVV1lNWnBNM256Uy9Q?=
 =?utf-8?B?eFVMMytiTmlwdnNLT2p2Nm1xVFpLVUFZRjk4WlRLKzFsVStPRS85TVRydWIr?=
 =?utf-8?B?ckZGUXVHT0dWMjFGUVV1RlVyTDFveWIxRGsvRXlLc2xyb3F1ekRUKzljN2dv?=
 =?utf-8?B?ZldYWWhtbjk4Tktnb2NISHlwbnljRVNBWU45ZHgyTVZSUjZWZzdweGtWd1lD?=
 =?utf-8?B?ZHZnczlWcjM4WTJldG1tMk5jS0kyRlVOOTlzaUZXSXBONEl1Q0VZVjJmRDA4?=
 =?utf-8?B?VTJ1TDZaK0JaZXFXa3dNS1Q0bk9GN2dqcEhHclRFWUpQb2RmcUx6Sjdib2dP?=
 =?utf-8?B?MlVjbnJiejZGTEh4bUVMc2UwMkdvbk85c3cxTUpvMllTVDYyaHNpcTcvNWpm?=
 =?utf-8?B?RllLK1FsTWJXdzY2UG93bU01WkZzZDNHVCtHQUE1Z2lWemhUdTNkNXJDd3M2?=
 =?utf-8?B?MVJueWZWS0ZJV3lMNGk1YXBHV0RHZHk3ZDB5UkZKd3NVcC9xSzFBdi9BYXdP?=
 =?utf-8?B?WTNFUHVIajdud3YrN0ZuMTRkYktKSWFleHppc1Y2RWx4YzdsaTROMFZlaXpp?=
 =?utf-8?B?NWM3eDlkSGIyaGNjS3RKdFJ1cHY3eEZBNHJSZUhFejczZWRXMm5aQnhLMVor?=
 =?utf-8?B?ZXZ2R3Y4U25la1RzNXBZV0dUVXJ4RFZFL1hMMXlsMjJlUlYrSUdYV2J3QUp4?=
 =?utf-8?B?S0hEckFmVGlPVGRiUGplUGNaNUU4dUZraTBWQUhiRUpZdWZkcFduVXJDdE1L?=
 =?utf-8?B?djhQLy8yZ3RHOWVleWcxbDRaVWd0QWFJYVVKQ1l6enl0U3R6TFEyayt4RmUy?=
 =?utf-8?B?c0pWRmw2NC9rU0FEZDRjQW9CQmNxcHp5dnZzLzBoTkJkdWFQU2hWTGl1UmxF?=
 =?utf-8?B?cVhZZTlIMTh5SXR4SVQwY09VRmplb2FmeU1vOERseGVFR0NMMVJ2ZUdseU9Y?=
 =?utf-8?B?SkU3aWJHcmhtMnlTdEFPZS9Nc0t0QmVRRklxOGFscU5meFZaVDZwSzQzRi91?=
 =?utf-8?B?cUFWOE5iT011ZEVKamo4dks4eW1VNXA1SjJBVXJnTVdLYmlCRzFsMXFvVHM5?=
 =?utf-8?B?ckVYdkN5QlN5NG5uUnRXckxpSUw4aGZJaUFmSWdPYTV4RG4veTRnMzJIU3dv?=
 =?utf-8?B?SmdLMGpBTG1yMFJtUjR2eFRoQnYzVUJ0T1Q2bzJqOXUxUVB2ZzRYS0M0RWl1?=
 =?utf-8?B?ZnJVWlorVy9JUTB0L1U4azBzRGV3UmpaMnZpM29VaE1xaFZ4M3pPU0xyamJq?=
 =?utf-8?B?M1RFVUd1dFRDNHFETmk3enI3NVI3RWErVzRMNkJxNmJuQ2dtK2NjdG5Famgz?=
 =?utf-8?B?MDlPY2VFdENIVzRvQXhhUEJvVllmRFNzSklibmZLRG9oOFNMUlQ2MTlGd0dz?=
 =?utf-8?B?dW93L2s2MXhXR0djVW5ncHk4SHVhajZHREZwNVp3TEJtWDg2ZmZBYlFJd0t1?=
 =?utf-8?B?bXM1SGl1QzRhZXM4c0Y5Qm1PLzc0dDZYTy9FalB1SjBUd0VMaWRjejZvazl5?=
 =?utf-8?B?MmdmRlJzU2xSN0I2Tit1cGttbUFzV0wyTk9GN0x3eE1KQk0xeFpOUzYrUDhl?=
 =?utf-8?B?SjNtNWdSdmZuOTF5YkdyWlRkTERCS28xOFc3K1Bvbm1CNUw2c1V4UkVUSFIw?=
 =?utf-8?B?UU5DSVJIUlgwTDlxVlJvL0hidWdybW5tbllVTFFlNk13UzFuaHVVQkFyUE13?=
 =?utf-8?B?Kythaks0ZjFmQlBHR0hxZEFwZlM5VnBFWGJLamFPOTRTY1NjbUxnWHMvS2Ju?=
 =?utf-8?B?bHVtQ2NHT1IvMk1XaCtsakptc0JGaFBBREMzbWc1Y29KUWtPVnJOQnRKbXlh?=
 =?utf-8?B?Y2E3UEYrdnNkWjYySzZRcDRjZGNpclVLNCtMaVpZdHNGRHlVZ3oyUHplSERq?=
 =?utf-8?B?UkdWaGxYQkdkbmZxdkE2Qk9xMlBLbUZKeHdkUkZleGRuWnBLSExjS0k0MHlu?=
 =?utf-8?B?STlOb0hTK1lBTkdQUHp2SmZPTDFOK2RyeGVsZEl1cXd3aC9Ec1ZOR01BbThN?=
 =?utf-8?Q?vz0T1d?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 16:52:24.8527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf5f9c7-4f19-4fa3-8e4d-08ddf153957b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909

Hello Mathieu,

On 9/11/2025 9:20 PM, Mathieu Desnoyers wrote:
>>   +int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3)
>> +{
>> +    switch (arg2) {
>> +    case PR_RSEQ_SLICE_EXTENSION_GET:
>> +        if (arg3)
>> +            return -EINVAL;
>> +        return current->rseq.slice.state.enabled ? PR_RSEQ_SLICE_EXT_ENABLE : 0;
>> +
>> +    case PR_RSEQ_SLICE_EXTENSION_SET: {
>> +        u32 rflags, valid = RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
>> +        bool enable = !!(arg3 & PR_RSEQ_SLICE_EXT_ENABLE);
>> +
>> +        if (arg3 & ~PR_RSEQ_SLICE_EXT_ENABLE)
>> +            return -EINVAL;
>> +        if (!rseq_slice_extension_enabled())
>> +            return -ENOTSUPP;
>> +        if (!current->rseq.usrptr)
>> +            return -ENXIO;
>> +
>> +        /* No change? */
>> +        if (enable == !!current->rseq.slice.state.enabled)
>> +            return 0;
>> +
>> +        if (get_user(rflags, &current->rseq.usrptr->flags))
>> +            goto die;
>> +
>> +        if (current->rseq.slice.state.enabled)
>> +            valid |= RSEQ_CS_FLAG_SLICE_EXT_ENABLED;
>> +
>> +        if ((rflags & valid) != valid)
>> +            goto die;
>> +
>> +        rflags &= ~RSEQ_CS_FLAG_SLICE_EXT_ENABLED;
>> +        rflags |= RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
>> +        if (enable)
>> +            rflags |= RSEQ_CS_FLAG_SLICE_EXT_ENABLED;
>> +
>> +        if (put_user(rflags, &current->rseq.usrptr->flags))
>> +            goto die;
>> +
>> +        current->rseq.slice.state.enabled = enable;
> 
> What should happen to this enabled state if rseq is unregistered
> after this prctl ?

Wouldn't rseq_reset() deal with it since it does a:

    memset(&t->rseq, 0, sizeof(t->rseq));

-- 
Thanks and Regards,
Prateek


