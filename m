Return-Path: <linux-arch+bounces-13439-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AC2B49FB6
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 05:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9787B4E69A0
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 03:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A1625A2D1;
	Tue,  9 Sep 2025 03:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HBVDedBs"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4FA258ED1;
	Tue,  9 Sep 2025 03:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757387445; cv=fail; b=CulVHGTecqafKtjJZZqV5YBnfsiHCOnjEb1FCMwOUSkgettHXDxUpPuZwMNgECqdiGmhAsT0IK5XatpfExFTDadRqD7ZyKMStqBNIMNzaAVzCNy+PvvjyJMvwTicojxHc9rWU3czV8p6WR4JUgzirsAmZlo/qhPKaF2iwo4iPwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757387445; c=relaxed/simple;
	bh=wUihOv2uQFPH/CbqBgWCGETxZhDOjkZHIVDcbSFvujo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N0QkaR33tW+Kd0e6sPSfbY1WhefheoyL8z8kvSQLBk18qkEW5nOLWbO+04AN6iBYWDUHyAynvez8QtK0zZ2Xghx5ZAj2t8VYkA5vW2f05l7nqhSc5nzsorMDlNYNdpdNnOySMzPTIuWED7JgY4cAA4qcwG5sZiYQqf2biEz+w4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HBVDedBs; arc=fail smtp.client-ip=40.107.100.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHqwDFPhQY+88RTW7WOk19IjDskGW/qe4T+3TWEOiKHrZhXJzEyNyfexDC2nQ8UCHo7G/OTr5dD9jxpgnZrnnAUrQKQJ25UUZZTD2TaBf9RpnT6Ne+pF+ldiBIhs4gJhyNGSFGlSCSvtrEWaXeoe0ro5mWcxVpCCaPgTGEri4d9weGTwvRJwvYkvW8PXfloGeEhuajyf1UDZJvl0crNeHme7V/RsjgbMTEC5w0uayqfJ0xUuM8P2bX8+e/W2Ym8423Yb2uvwe8Ygw1hN/XUMneqJ0XR9mYZRTvW6RmTJ+Ukk7+e9widSd1wWX4qK2NZG7cQjjWy+j5OqKA8hb5gEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0ohToPwcMmnnIYbNZjeJ7wFtngGtv9PJZygVfCaANs=;
 b=dU6TNaq724WcwCPEuPoiloQh/kIpFQuhBkRCQrTqbWZt9X3yxzvylZ16vf3IEesee0cQlhgdE3syNpr9aFgmg0EST80nbKJ54QOiqpIol6jble6+gnn3ny2YrZBOUqxCRnB9w4eIWGCNIpvnHrJpcbdagWw4PMqtjeD0co3LkayIr5pP0WQgDiWgnayuMYaNyTz2ztWiYIGx5m/NFTVE3+5uVrpgD1vL2Pgoe8pbe59WsMPrnzPHswaMw8f7sSm+5xV0Z8YXMdWCyJX/z/RY3Vt4/R7pHR54ZnWaf/BxZ1ai48FTBRmpK7AJeopEYohDhrBhFbgrrATQq1W9kmYqfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0ohToPwcMmnnIYbNZjeJ7wFtngGtv9PJZygVfCaANs=;
 b=HBVDedBsPXFysBX4ag2/qnw3/NNdjIbM29urCB/z5DFJ9CPw4opKVK5Lbbl0yXZtrdnhKdvqOqpek9eJZwwyieo/Brkjn33tcC5YZbaKrDwdCEwYf1g+FvJLD5nb1LOBIlPm6XikHFwoZMhnHouPSr7lEBNJORNgBf7Go6WtCcg=
Received: from DS7PR06CA0031.namprd06.prod.outlook.com (2603:10b6:8:54::11) by
 BY5PR12MB4226.namprd12.prod.outlook.com (2603:10b6:a03:203::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 03:10:39 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::7) by DS7PR06CA0031.outlook.office365.com
 (2603:10b6:8:54::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 03:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 03:10:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 8 Sep
 2025 20:10:38 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Sep
 2025 22:10:38 -0500
Received: from [10.136.43.237] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 8 Sep 2025 20:10:34 -0700
Message-ID: <0f28cc54-1f84-4f28-bd61-ee9e0b9d0d0c@amd.com>
Date: Tue, 9 Sep 2025 08:40:33 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 03/12] rseq: Provide static branch for time slice
 extensions
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
	<peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
	<boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Prakash Sangappa
	<prakash.sangappa@oracle.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
	<linux-arch@vger.kernel.org>
References: <20250908225709.144709889@linutronix.de>
 <20250908225752.744169647@linutronix.de>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250908225752.744169647@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|BY5PR12MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 9657b137-2796-4855-dc71-08ddef4e740c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVZoUnFkdFhOL2tJdDdBd2pISmtmeFJ4NGxKd2YxK0xoa2Y5V3BsalFFVkF6?=
 =?utf-8?B?ajdNRWdFdjF1dVh3WVNGQVhVZllkakx1cFBRT0xJTGdlVEo1bXFnbkJJY3Vu?=
 =?utf-8?B?RnZzWE4zekpad1ZxcmlxYVRJS3V5U1lQNVRqOC9zWERnMytFZURJTTNsS3Rr?=
 =?utf-8?B?T3JMRnpKZXQwRHJQZzZRTHFRSWIzeFYyMk5ic0hSSVA4RlFXZmpGZzIwRk1G?=
 =?utf-8?B?cEdORWZjMGNRRExQaW1DMEJqaU1xaGNnTS9rRit3cmRVc2w5MkRMb3pqZzNi?=
 =?utf-8?B?MkRYbmhMdkIrU0MrQlJWSXlOdGVoUDB1RGdlVWlqSk5STzRJV3VHR2w0d0w4?=
 =?utf-8?B?UWU0cFZmMGpOS2NLaTdTSjUrMWJCNVRxT2paaDZUMWVBNTVWZFFibVNQNEFZ?=
 =?utf-8?B?U3RuMTNLRmZwT2h6MlZMd2RUaW9HZWUreFhoQWkyeWQ2c1JMWVhzZ3JzNi9r?=
 =?utf-8?B?cVJwSVhiRTRsSklnL2dQdS8yNnJCcnQ3WHEvOWRyaHA4RmUzTmxzNkZZWTZB?=
 =?utf-8?B?dUNEb2wzY1l5OVRYR2VlcVRRaFNaYkNjNzkvbFJhRVloM0N5ZUwrVVdsUlZO?=
 =?utf-8?B?dkhabHFnNitrVnEzYzF6dllONGMvTGNqMTlLaDYwVG94bXE2NHk1UkxHSFV5?=
 =?utf-8?B?bklwSmlwS01naUxvNlM5bklrN3FzSGRVaHUrSGFMc0xGanRTbUFTc0lwZ1N6?=
 =?utf-8?B?SWxLcUFXaDA4Y3Yyc2xQZldhb2luVklpNnNIZndoWTNkbm9iV2FFM3pJaTEr?=
 =?utf-8?B?ektCWU8ySVRPV0VJZ0gwT2JrUm4zRHBDTWMrQ05IM3ZmRjNwamY4TzZwQS9r?=
 =?utf-8?B?bWFrVU5reGozdVI1U0VvVUNVbGRUWFlyTGZtTEM2eGhYTjVjWCsrVWgvc09R?=
 =?utf-8?B?NWdXcTYvZUViVDJCYWN1NFpEQ1Z0c3RIYWlkVFg0WWtHeWh6aHRzT3FUL2Ru?=
 =?utf-8?B?L09CTUZOa1R4bXZFaGxrVlJxOTM2YUg2SGlDUVhXVm0rZ3VjenVtbUU5UTgr?=
 =?utf-8?B?OEJaL2Q2M0JmbDhNTmxGYnBvN1R3YTl2THRFQUtDY3M2bU1nZDFLR2g5YmxI?=
 =?utf-8?B?Q1JjSFloZjMxSVRpOElYeGZvVDVManUzaFlmS0FqS0x1cUpFZ2ZYSzBRdmNi?=
 =?utf-8?B?aFlzTVhsOHUwOXg5RXU1K1FidDVSTGtEc3pTZ2cybFFJSmtWU0pmUDBDanJt?=
 =?utf-8?B?dnFEeCtaRHhpWE9IWmV2bjk5MVhvSnoxWjFMaklXT25Da3JBakRzd21DZk1p?=
 =?utf-8?B?Yk5TMDhRZUc0YkIxVndWeFV2dC9MalZ2cWVBTDhRWU9vU3VrMW1wSm00dnRl?=
 =?utf-8?B?R1VTSVZibXVCZXRCZXRyck5vSjhHZWs3NzI2UzN1MHcvZjA0N1lzdHRiZlky?=
 =?utf-8?B?L0pxbWhvMkVBb2JXQWxMZUR1S2FFTDFWRmdrczNNbWhNN3JIUFIzNEljZmxQ?=
 =?utf-8?B?VVhEZW5IVUIyempjUXY1dE02QlY5M3pDNUZ3dXVucUE5Zytyd1Q4cGd4YzJN?=
 =?utf-8?B?ZVVyc2dIWHQ4aEx0eHp6S3paa1lQaTFVRkYzNDY5K016OGd2RzlxWTd3UktV?=
 =?utf-8?B?djR2bkVDbStXMDBoNUJrWlU3WHlWN3hEMVZsZkRQSHUrNDdHWnk3NlRYQkJK?=
 =?utf-8?B?ZUl5eDM2b0lzL1hmTHdkRDhicTRFNkNlOVRqZXAyMTB1WlQxNElpOUwxV2JF?=
 =?utf-8?B?dTd6bTlvOUk2dGRHL21ESTlCZU1SSmFtMlhpQk9Ualh6dVlRZUNqZHZnK3Ix?=
 =?utf-8?B?eGtSVi8vbjFhVDJycDlDaWpTVGkxU0ZaTFZiK3M5R0NYK0VtQXBaT2ZVMFlF?=
 =?utf-8?B?ZHRLdWpUUlNIQnQ4MTU3N3kxTDMreHVHa05qMFVhUUlhaWIyM2FWNUxaSndm?=
 =?utf-8?B?NnNkbkZObjM5aDZRVW1CU2NkblUrL2JjV1lrOEZvNTZJVnVMVHhHeXA0RndY?=
 =?utf-8?B?NEJZWGxSS3V3VFR0K1NJcXRQaW9nelhVL2N3d0hNU1ErQlVSM2xaaTNYKzhk?=
 =?utf-8?B?V0hyMlpWK2Vwa0JpbUh2TDhyUGJkTE1vVHJZTjZrUG1nZTVndkxGQXZNSlFI?=
 =?utf-8?Q?a60nHG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 03:10:38.9097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9657b137-2796-4855-dc71-08ddef4e740c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4226

Hello Thomas,

On 9/9/2025 4:29 AM, Thomas Gleixner wrote:
> +#ifdef CONFIG_RSEQ_SLICE_EXTENSION
> +DEFINE_STATIC_KEY_TRUE(rseq_slice_extension_key);
> +
> +static int __init rseq_slice_cmdline(char *str)
> +{
> +	bool on;
> +
> +	if (kstrtobool(str, &on))
> +		return -EINVAL;
> +
> +	if (!on)
> +		static_branch_disable(&rseq_slice_extension_key);
> +	return 0;

I believe this should return "1" signalling that the cmdline was handled
correctly to avoid an "Unknown kernel command line parameters" message.

> +}
> +__setup("rseq_slice_ext=", rseq_slice_cmdline);
> +#endif /* CONFIG_RSEQ_SLICE_EXTENSION */
> 

-- 
Thanks and Regards,
Prateek


