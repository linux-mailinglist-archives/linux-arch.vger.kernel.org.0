Return-Path: <linux-arch+bounces-13470-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEA1B5153A
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 13:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E3B3AA747
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 11:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6595D1FE47B;
	Wed, 10 Sep 2025 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cdPJSWuG"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9E425FA1D;
	Wed, 10 Sep 2025 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502922; cv=fail; b=D+zD2xeoW41O15+l2+Jy0kG+8eFQEfuYIcQxyIx4FOdRO/vShqSl7UdxoXcezl7ZUhdO8yjDxaLRGSn6hvr/kCD3VErv0Q1UxChcKIMGhUOSS4wnruclbx2oNfCKxAJXOKsZAYunt43XnRGfeFqAA9dHVVgKI0xapdtOaM+v0FM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502922; c=relaxed/simple;
	bh=Q/575BUW+F+kjkOTRG3CHifRoUKPy6AK82sizh2lgaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TGoOU1uDxAOMhkrTKTgB3Dx9ZEn5n+GWhoPzz000uHMs9y6MR4AW5EfOdn5Eza3oluFetXAPbVQSJTHUL+y0GOwwtJr2TitZILsKDH1aqthI+zrzlFFddMy0OCkkGCxd10mXx+cVa9DD+hlMkE45F2nCNPyiUtJp8oUoHyCuHXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cdPJSWuG; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+7n6U2E7OYCYp+xpaqr1fF6ZwLxyk8RvMaBj3N8JiedfSYZbHHVmz2YZa+vShVMLM6Rf4+P+SfARMCXJJvNY5iWAgQDFOlZ4tJCr2WOvgOk3X0Quv0ltnce3YyVMJeHZOo0POYOOprL6L7qAVVtArIi6V5RYd9H/U3pBi/yl0SfiU+A0EGuCNU9uWj5di6mVY3xLiQaIHhwm7NDukAOHgZJy8XQIL81bZUsbtIwr+pByEC/v6iZEWEpDIvFz7rSwWxvLtJhVy/6kfMuLbLM1R48fq1ff/C5PSPbGy6/UsNY7ZomltKqsY48AWy9jzU49+PCSpRPGuclC+VdV/yYNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pdkr507djNLM5gYA+3uzP1wSRUhn5taWd3QEr/QuFfU=;
 b=fqz1id6oRhlXZJ1Mq/PIkxBHbmXVUFUjf9oE0dZi79EyjqO1Bb6GqPlKc84di0PLstMFO8Ejro5ZZERk3CSy+1Wh6dQ09VkgVXRQ9h4L3TpAdJyGoEVorhS6/wbyBN6dvQsHyB7GxqxSkwkR6nImHzxjpXqs3DlMEiBkLVWqxyfxf6sF9vTgwlDtfMw0b4WWTBZjDU1P+v9Dn7onlmtYW71n7oN5vcE5cxz9gnzZWrq8llNOBQfsjsQrym6bhn/OBRpNqczlziS5GS3k7I0s3NzcRq4F/QRcqNAOyaQx/hRB+KW9XVVpL0Yh3m53umnf+m8kWNXHeK+pZhnUPYYYBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pdkr507djNLM5gYA+3uzP1wSRUhn5taWd3QEr/QuFfU=;
 b=cdPJSWuGQJs7CQHdLbRnU6igStHGUs2Um0sr7/kZqYGpYjLkYucqh1+aUo/yCAjgQPshdLbVIoc4IDoZQDZrCpVXwr9YWX4Y8s+M5R9lT2+Og41Wf0y08BItaxDIP7+ZujSUhBjK7PXPjfrpzsVzC8lTS2Pai/2RLKROIu/x2RE=
Received: from MW4P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::8)
 by DS0PR12MB8526.namprd12.prod.outlook.com (2603:10b6:8:163::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 11:15:16 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::e6) by MW4P220CA0003.outlook.office365.com
 (2603:10b6:303:115::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Wed,
 10 Sep 2025 11:15:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 11:15:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 04:15:07 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 04:15:06 -0700
Received: from [10.85.34.232] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 10 Sep 2025 04:15:02 -0700
Message-ID: <e61943a6-0005-4146-a5bd-485d3b32e709@amd.com>
Date: Wed, 10 Sep 2025 16:45:01 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 06/12] rseq: Implement sys_rseq_slice_yield()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, <linux-arch@vger.kernel.org>, Peter Zilstra
	<peterz@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Prakash Sangappa
	<prakash.sangappa@oracle.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
References: <20250908225709.144709889@linutronix.de>
 <20250908225752.936257349@linutronix.de>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250908225752.936257349@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|DS0PR12MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f228b9-d56e-4dca-61ea-08ddf05b51c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkxqd0ttRVFDTTBnNlJhZEYzZnExanZod2JmT3Zhb0ZITzcvUUc4dmRaK3pB?=
 =?utf-8?B?eWJEdStxV2dTMGgySUxLTFh1a2JuV2k0YURUNFVQanJsYzBnQUpHVjlQMERK?=
 =?utf-8?B?ZjZLZ20rM1NNQzJlMFB4eDJSWExCcHBVOFhqS0tzc2x4ekZad0RFQmxmY3RU?=
 =?utf-8?B?ajVPUHhnMmQyM1ZaRHRQZ0g0bjRUazEzVXdBbThDQWRQbUJxQXZpZUNTNytX?=
 =?utf-8?B?Q0lxWGZ5SER0d3VUaVZwa0ZFcVFnM3lhRzJKcHFWTlB0TW9wb25FS3FqTzhl?=
 =?utf-8?B?Z1phVytCRkROWE5ONFhkdFEvZk9Td3hRUWRFS05ObFl1SUpjY3l4QjNGNHlU?=
 =?utf-8?B?dzdleEpsclFzcG5zT0R2OVJha1JMVjBjVGRKQWlSZGZoTVBlTFNkdksxalJ2?=
 =?utf-8?B?YXFSbC96TTFqUUpFbHQwL1JrZld3elMydDF6OGtmb0xYajJXZVJUVWRKT2JG?=
 =?utf-8?B?ZGVXUGdWbnVmRjZGdXV4OHY3dFA5WjAwQ3p1cnFVTUg3T1YwRzYrRmgyaU1X?=
 =?utf-8?B?TW5UUVhIdWxJSHhSeTBTMmNoTWM0RVZlaDVJYVJwRVVNc3pBYmZUeElKQzB4?=
 =?utf-8?B?VHVVakxIdGpiU0MvZTBzR0RSY0V0TEJCUXRWbiswV2xzbzhlRmZUa3hwTnFV?=
 =?utf-8?B?dDZ6ZjRER3J4aERrdDNub2dyN1VFbW9lcWc3QWsrNFVrYXlYRFRGSUZjQWd6?=
 =?utf-8?B?eTE4clo4REFnUWVTdWRiS0NhOUIzSTU3MzYzNWdNRFgzdmhEeEYzZTVNemNT?=
 =?utf-8?B?bEI5cXViNGxZeFRZTFN6V3YrU2dZNWtNOENPVlJzdkhDQWVnK1hNUDBlK3h5?=
 =?utf-8?B?ckEwdWxUa1Q0NEdJNVV5QUJIREIyUXRyc0JkSElMZFVWYVM5b25VaVI5Vmk1?=
 =?utf-8?B?aXhwS0piTndnM1dWUXBleVVxWlNRWUZRMktBaDJtVHBNbWZ4NnROU0Nlempx?=
 =?utf-8?B?N1FvcHh3Qm1VeDhzWnk5MEpjWmg5VTJUTGE1ejBsM0xlaHhMVVYxdmNiajlN?=
 =?utf-8?B?dVFHcEFheXV5Q2hneE0xR1pzOFdmQkx1bVd2VW5UNWRTZkdVZ2pNaWl5eWtw?=
 =?utf-8?B?UzlMY3l3VWs2TVlqdzZ4L0dLUUtVaWF5VGtGNjk4dWw5M2pFQzB6MEVrZGpv?=
 =?utf-8?B?MnJheFphai9zTjhrc2xSVzB4b2pTd3h2TEJlMUtQT3JhRVFKc0I1eVJWWUxV?=
 =?utf-8?B?Ym9uaWlFd0FrVllNTk54eXlRT1VGa2c3b0RKVHFIOHNQVFRkd1FXSU54ek4x?=
 =?utf-8?B?V25xWnAzNVMwN1BjMjRRTWpPRWMxSDhnZWtLRElBQlNNK1R5RTlzWE9Rb0pW?=
 =?utf-8?B?WnRLb25EdCtqZ0JhRGt6Q2NDSmJGdlJodE9FUC8rNWlFenFwZkpUMDlrVzJl?=
 =?utf-8?B?S0xWRVZ5YkFOanVjUWlVdmEwb0k3OVAya2NGeDUyWE9HZHZteGlFN3IxL0dK?=
 =?utf-8?B?STJySGtRSmQxR0RzRDMvSDY0R3duUlpUOGNsZDB4WC9BajJGa2VoWUJVbU1J?=
 =?utf-8?B?T2FkSy9MVU9pdTJIdFVZQi9tVnBBNElNV1UvQUVvZHY3OUJDQkF4UDIwZWV2?=
 =?utf-8?B?NUdRTWRZRzhFMnFvM3o3Vmt3Zmoxa3NzQlR6SEJxc2dyU0JIbTZBYWp6VUdm?=
 =?utf-8?B?aG9ZaXhIVUpPcHJUS2pON3lYYW1MOHhnbVZjbzFSWHNuT3AzTHdXR3NUZjh4?=
 =?utf-8?B?dmhXMTc4YjNFbUdTL24xQVh1RlAzWUJjZE0zUUJaYTJXZnFKU21Wa3ZlYjg4?=
 =?utf-8?B?ejVXYzZ3Y0ZwK2xwaHpISlBHZVBjbXdSN0xpcUgzcTl2WUsrbUhSdEQyU2Rq?=
 =?utf-8?B?eitWcWtyYmhVYk1NaTB3bFoxbWMwUk56U1BZOGVuR3ZoNkROaU9HdzNPNE9Q?=
 =?utf-8?B?VGRBV29wUmtoSzFZTjFocGZQTTYyWGMvZ0VyN2dvbEFSSGtiZmRSWWJxaGVP?=
 =?utf-8?B?RFRKUm9Hdk5mN244S0NkckJxWmxLZVJTcnZzN3FiNVRPWU5VZE00MHAvRTNq?=
 =?utf-8?B?QXQ1Z0NPMTl5dzQwMEpZeVNGcVo2T05Hc1pqVjN6bWp5bWpldTJDM0VYbUow?=
 =?utf-8?Q?t7PW5O?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 11:15:15.9522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f228b9-d56e-4dca-61ea-08ddf05b51c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8526

Hello Thomas,

On 9/9/2025 4:30 AM, Thomas Gleixner wrote:
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -542,6 +542,15 @@ int rseq_slice_extension_prctl(unsigned
>  	return -EFAULT;
>  }
>  

nit.

Perhaps a small note here to highlight how need_resched() is true
for tasks who had the slice extension granted. Something like:

/**
 * sys_rseq_slice_yield - yield the current processor if a task granted with
 * slice extension is done with the critical work before being forced out.
 *
 * This syscall entry work ensures NEED_RESCHED is set if the task was granted
 * a slice extension before arriving here.
 *
 * Return: 1 if the task successfully yielded the CPU within the granted slice.
 *	   0 if the slice extension was either never granted or was revoked by
 *	   going over the granted extension.
 */

> +SYSCALL_DEFINE0(rseq_slice_yield)
> +{
> +	if (need_resched()) {
> +		schedule();
> +		return 1;
> +	}
> +	return 0;
> +}

-- 
Thanks and Regards,
Prateek


