Return-Path: <linux-arch+bounces-13473-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A0EB515B1
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 13:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15C7B7BA395
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 11:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD633090D1;
	Wed, 10 Sep 2025 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YnNLdWNh"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9AA30596B;
	Wed, 10 Sep 2025 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503708; cv=fail; b=hkcnC8V3lRdmYaEC8y6ax0yisujDtmMm9Uh4AicfIp+33jT/SBK+vDa0qgVh2JXePg6dQ+6pqcM2qBynhDP4HSWcSO8ZJ2gRac3E7MNMgcb60lV4C+7w436szLF4UB+asTNau2haC2WJ+AVA6pDIZWaUG1yOQB2OdsWo4DAwngI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503708; c=relaxed/simple;
	bh=uoQxTlAHcNlEvXjPH11CrF+tiIdqud0fEuLcuRLJ+xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I0hsbR5YOlKcOaLXO3CP8/xCqhCe7/BcFz9ABW4aIwd5eI7vxqNZNtXEbnLD/cW28JC1nIwo6Q2B5kW9G7CVLjfGQdTXnpStY0MhDGLGVc1IBDAoBpEyJvzAMR6xTcbg307F2GSgJnvVFjio3QlGDQjPADZmpWgxVslDtNCTSxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YnNLdWNh; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVf+a/nVYOlEDAAiixQ9RD7RQ/jROPGspzDgGrWSDc5uz1yHmwDsamnAo8S7CAH42yrLQmVxvEnuVaWJTmnVVOwFqwK8EPBQ/Ldm+5TLcnSazSK++PyI1ijmvLpJuLCv4enCCxcVNPa4Iq+0KN5jGB5zT4mXeS0yWrFRLFmrE70XcPI+fODdRhFVwQbgz4gq7rBfBMXGXtP3WAuRFOhjHz4Rw0KmoqyjRzwfQuZgah38K7cbKu4WDBxASz8aoBixHpYVWjrOdM3CvEUzsgv9Km43MUm6R6ezOzxqTo5HtdCHE4I/xxr2uWmuUquvfpkuEKUguWGYnqhFhNYT6uvgUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KH154ENAJB6GlASFEGH4pN/T80tK/8jqwe0bHWUY3Us=;
 b=wDUSzSaus5S/2pidz7BOe8gYOHaJYlhEhHY59fyV5O/O+Zi/lB60eUYq1RR2Nuydu78HfGJ3iEMoFXStjIa9E+KbQF881+zhlGu7c2WQSdRa7HJt6FBbshZX5edyENg6A7D69MuMo57GxZQ2VRZn//izISYYl3s7tCn0n8SACqO++oW7BkKy41hKA8fITKBsR7dIJaGfB3J1nHmHJknrv6yN/x/iRXR296YyqLQmLllht3UzXfAN7iWdv3c/uJ3uHPw3DTR9K/wsXF1NxiCqa+d2ucJwTeNLxTwTbrB0r/bZy/UnMBrP/3cvLEDvns7i/l+uCkUdWqSdKqBbYGJw6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KH154ENAJB6GlASFEGH4pN/T80tK/8jqwe0bHWUY3Us=;
 b=YnNLdWNhCbpdxJ24YhTkeYjM4j5ZprCZUk34lhCxCKeSjaJv35S+P0cJz+MmWu4HgOkvVgT9XRT4zOtgdc0kkBY73CKapS/xK2IJ9+GIsGPeoM1TbQSWA5EwQVatgOD1X0+iIhS7mTmTvmNS3NgpAfGCTjyqXI/0O4zXwg/ViCw=
Received: from BN9PR03CA0306.namprd03.prod.outlook.com (2603:10b6:408:112::11)
 by SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 11:28:22 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:112:cafe::93) by BN9PR03CA0306.outlook.office365.com
 (2603:10b6:408:112::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Wed,
 10 Sep 2025 11:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 11:28:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 04:28:21 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 04:28:21 -0700
Received: from [10.85.34.232] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 10 Sep 2025 04:28:17 -0700
Message-ID: <e2b2d2dc-adfd-46db-85ec-a09590fcb399@amd.com>
Date: Wed, 10 Sep 2025 16:58:16 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 00/12] rseq: Implement time slice extension mechanism
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Peter Zilstra <peterz@infradead.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, "Prakash
 Sangappa" <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
	<linux-arch@vger.kernel.org>
References: <20250908225709.144709889@linutronix.de>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250908225709.144709889@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: f78d5dd8-8943-4cbb-3e2f-08ddf05d2656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bU9kYlVhcUc3N0hNcnpTdzM0YVQvR1JLb3ltYTd1ejN0eTVnT2xKWXFWTEFW?=
 =?utf-8?B?dW5sNTNLcnNXSG9qVk9tZlI3eVpaVmczMnpBcVNtVU1tOUF0WUU1c1pIMkww?=
 =?utf-8?B?UmdhNlFISXM0cmUvWDhnKzNleFRXVUo3ZVRDSG1mTm1palV3RGhMcjBqMEVp?=
 =?utf-8?B?RW1mQ2pSK2NjMmFoUGREUU5DVEFwemlESmtQWjZTWXluY3FxbXJVSjZuVGl4?=
 =?utf-8?B?TEVpOXJ5MVpMT0pQeW93cjlWNkxSKytTdUhqZEZ1aXFIRUdjMjQ3SFd2Wmcy?=
 =?utf-8?B?VzdheTdpbE8xMzZrZHd6eVhNUDcvRG1hTVRlQUZtUXFhSHdqdlVUY05QSzk3?=
 =?utf-8?B?YnRjVGtwTjFhT2dsNnpCRXA3MGRqaUY1L2NtQ0hxdjA2dzJxTEZTRjNuZHJE?=
 =?utf-8?B?SDhOaWJXL3k2cm0wOVZreEZMUCtSNnA0NWxiSUxsc1pnOVJjTys0V254SDNU?=
 =?utf-8?B?UjgvNWhXM3VIVHBrRHNyWWFISjgwYmpUa2k3clJxbTFCbE5MbkVTVE1sUzJq?=
 =?utf-8?B?SnVPK2xEazJ0RXhhYnFLS1ZqYVlLdERWUWJ0YzN4TTQ3eWhwVWFHU0k2TjZH?=
 =?utf-8?B?ekQ3SWU2eHM2NXVadCsrUE9vQ29Qb0Fja2UwbkpJVGZQemVad3lQTEpMcmZo?=
 =?utf-8?B?SVpNS0M1SGJ0d2ZCTlNCVFpjZmVvbjBZUG8vUXlOeTdrblEyRFErZGxLaGZv?=
 =?utf-8?B?UkJxUGpnVEROeld0c2lrSFFNN1M1THA4WXU3WGlaYnFrTmdGTm1YTXF3b1U0?=
 =?utf-8?B?RGd0ditqZVlleTlIQ3lHOTFOVjVHTDJsd3JZYUZIVDluSTR4NS9Ld3VhbmR3?=
 =?utf-8?B?a2dCU2pIK0NlV3NjNElvZkdhQnhYTkVqeDBZbVNWc3ErQmZsSjE3N1ZiTXd2?=
 =?utf-8?B?ZkRjUGZJSGo3WjVZeWJjOC9rM29NVmZxRFVYSHVJb2lBU09UUTF3ZnhMMDFi?=
 =?utf-8?B?SzFpdHBOOVBKbWZhWXY1L2xEUytlbHNPMFczYmw3R3lxaHlwK2V6ZDF4ODc0?=
 =?utf-8?B?eG12VzI2aWdCTjBwdUU2MEt4eVNyUGFCNFNhaXRVbzVwQkhIeWtTQU96L09B?=
 =?utf-8?B?dDh6VHdObkVXWCtwZlVYSDVoM3ZMQUJMMElRVkEwV0cvNW1VR0RUM3hCaXQ0?=
 =?utf-8?B?Z0dLV05MWER6MHhaUGJJQjdJVlFvM3FVQkV2bm5ORVZNK3FUQ014Tm9ZQUJX?=
 =?utf-8?B?b3AvSTZObm90MW5GUTZTdTk0RE9wSHAzR3I4SWJidUhFanB1V3VVR1RLT21W?=
 =?utf-8?B?Y09JbUNOVGdZMlJzc1M2OW5iZHZqaEdZSDNnbHFLL1pYS1VJQjVvK04xNEN1?=
 =?utf-8?B?cW9IR2RIejNiVm9QRnJsN25KbXNWWEx5ZU0zOFBVTTZSYmx2MEVRYzcrYVNK?=
 =?utf-8?B?YkNVKzgvVzIxVUZScWsrUUIxRDVqNmNjcjFxdTMwRGIvbnhQWXlwbExaRm42?=
 =?utf-8?B?NnhlY3VIa2hpSENLZWkyRjJrVHpyS0JUVDg3RnhGTjJqUjdxOGpjU2EvUmlQ?=
 =?utf-8?B?K3BQT1kxRnhjL2tuQnRhd2p5Z01VNlJwVFZrc3ZmS3hYeTFnRXcxL3JFZWpv?=
 =?utf-8?B?aDZOUFpncmVUcXpoc09ITGZlbk5TZ2kyZXNpaGt4OWhFbUc5WFBUOWNvU1Bu?=
 =?utf-8?B?ZDB5d1JjcEczWjliQXNrM1k1NW54MkZOTnhta1FvbkpUdlJFa1JTRGt4dXBR?=
 =?utf-8?B?V3lEb2E1L202OUtiU0tHc3NidG9FZXU3S1R5akVsRG1iSGdPQzNUZTJZanBx?=
 =?utf-8?B?aHdyMm1JZEFDbmVWU2JTdUc1eDd2S1licWtnTmdqaklBVzdDalo2KzZVSC90?=
 =?utf-8?B?ckFiREwrV2o3UzduUnFjdmRnZnpvTjRXdk9IK3hIMzlsaEljbzFDY2xOM21m?=
 =?utf-8?B?dHo3T2hjd1k5REhFMUw5NGhoSCtFZkJlZjhJT0pGZ0FaZlpyTVAreVZ2b2ZH?=
 =?utf-8?B?Tm1DOGNXRUtoMGNpMmZRV0FCVHI2MzhMWXB6SzRRQm9iVjlqSzBRWEMzcVI3?=
 =?utf-8?B?WXdWVFZyN0FxNXBITDZISm0xS3dva1FBVmFXOU53b1V2SnVjOWJHOVR4ckhI?=
 =?utf-8?Q?NIacEi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 11:28:22.1851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f78d5dd8-8943-4cbb-3e2f-08ddf05d2656
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963

Hello Thomas,

On 9/9/2025 4:29 AM, Thomas Gleixner wrote:
> For your convenience all of it is also available as a conglomerate from
> git:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/slice

Apart from a couple of nit picks, I couldn't spot anything out of place
and the overall approach looks solid. Please feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek


