Return-Path: <linux-arch+bounces-13705-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A439B8F0EE
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 07:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A986C17591B
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 05:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DD323D7FD;
	Mon, 22 Sep 2025 05:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fO2ZwGku"
X-Original-To: linux-arch@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012020.outbound.protection.outlook.com [52.101.48.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C1434BA47;
	Mon, 22 Sep 2025 05:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758520673; cv=fail; b=swNZbSUfOH/cQjz6mUpUskrKz4NwMJk0962eX0evNAE0gYJ/uprSc0WX7d0aCCNVtQgBmObS6VNTRRHzVJOKpJaSnLV5FHfj88JWu+/6AYcKeij65/yS3mc45oJSw+zQRx7JApzQ6KCwCIyNxBQJUfsksO2j1SZl3LxM/KYzggI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758520673; c=relaxed/simple;
	bh=EjcoRVV9h4bzuK56lWnZYVux98kuB9XnOHY11qonPsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=StbhkceJ7cha5RWVC0FoCMDPr70vJwORPaMuPHBz66KhkjKMlgbP9Bp9Tv9Fl92hbxIszJLbZ0ZlQjnQhF/0J0cuC9A1qUDgkf19+UszlXtXfkKV0VQxwSSkbw9hPVxQngwFGwQOHwOAipWzrhpZQm6+e8edm2EnNs2r8S9wzT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fO2ZwGku; arc=fail smtp.client-ip=52.101.48.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGWENzl78xcY/QWYhvbVpmOxkkEjFJ/1xX/XwAcUJiSk+dHRtHZhLSuvxcNDg31KjReK9RTbmV/95cZ1RtrKDlBUG5GVhfsRlszfAnu1yEp8DxgOStDSOkA07q6U6dSHEYP0ZQQaaMP9grTR8xCSDg+Ib2fnNfat7HCmbGufAPuPr7N2uaTc/jBwBqsGLJpvC5URC1HYJU75iwh0VI6AAoul67F99h2HRfGSt3dVUDdjAO7uTMCsiWv8cLBQtbd+VafD3ew36rZXz2YOxij0OQ1iET2a0ZVWaRvQmyTlHeb7ARsDNEW2eXTaROJ3/uNdrQ8gIXyCxyipJKRv2QCKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRkJfYTNyU2Uuczde5wcwKndGAmUQzYUGBCep6a+HF0=;
 b=LHilzVTAqgOwtEpsIe28QZ+SSe17QRnLCuLEjkY3wnsHR8QG0PK0L8jWNcftAfx7N7O0FDwZbCEeUi27KwmNDPyjdy2uyKpcrbGrNsTSGn2pXBpM56zHYOWo2tiVMIvV/KaX9va+R8SRCFoqAI5HenGedVufDC1Ky44hEqqdQ0JvDwF1IdsqBMNgfXRfzk2RdOqUApLPX0syQUE6k5s0k0mmlUAsYSLGM5AyQ4nkLvrnPyakCO5PKSgzlMwCn/yY8zR0R1CHNbRaoFJGEhGl7KwuB2K+Rz4c285wjtzlTyyMEE4vicUSldJya0E6zvalz+XbBgH3WQGFFCbKkIczrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRkJfYTNyU2Uuczde5wcwKndGAmUQzYUGBCep6a+HF0=;
 b=fO2ZwGkudF4t6GiQaIXB7FVY43t9haiZP6OjIgQIHGitBi7V8PYsDQFzVvBkRGxUgqB5ZjCApqKpM4hQvwPQuPw0NQxN257fP+TkCOAHiGcr2AE8OSe6qzMlofR0NSrWMBUlFc9ZhQr4kDjl71UPrZQWJs4w7bJO5whCLzYTc58=
Received: from SA9PR10CA0003.namprd10.prod.outlook.com (2603:10b6:806:a7::8)
 by IA1PR12MB8466.namprd12.prod.outlook.com (2603:10b6:208:44b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 05:57:48 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::8d) by SA9PR10CA0003.outlook.office365.com
 (2603:10b6:806:a7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 05:57:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 05:57:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sun, 21 Sep
 2025 22:57:47 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 22 Sep
 2025 00:57:47 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 21 Sep 2025 22:57:43 -0700
Message-ID: <228e2fb7-e141-462c-8796-3cf78aa01902@amd.com>
Date: Mon, 22 Sep 2025 11:27:42 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 02/12] rseq: Add fields and constants for time slice
 extension
To: Prakash Sangappa <prakash.sangappa@oracle.com>, Thomas Gleixner
	<tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20250908225709.144709889@linutronix.de>
 <20250908225752.679815003@linutronix.de>
 <736A5840-3372-453F-8F78-5861AFA0F140@oracle.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <736A5840-3372-453F-8F78-5861AFA0F140@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|IA1PR12MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 793b8416-e552-4005-7dab-08ddf99cf517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnZOSFRmak9EVXp2OUdSaCttTXFzOG5QeFI3UlpBODYxTkJsZ0VLbFh6a2NL?=
 =?utf-8?B?aTkwVHAyNUxjKzRQTC9hUHhmOTdsOGRXN2NhOGxsZXFRWHhwczJxTk5oSmtp?=
 =?utf-8?B?dm4wYWlaSEVKSE9qMnkyMi9FcHAvejNHbFFQWnRKZUdlR0dzSTNvM2RFMGVZ?=
 =?utf-8?B?ZWRNV09aOTRtd05mVE1kT3pscGpXVm00TGlOM2JzOEZwUGVwTmprWGE5NEJs?=
 =?utf-8?B?U2VYQmFHYVVCd3RUVHQ5YXVMcWZJVjcvZDNxdzNGUnAvT0tmU0RBYVVSQUhL?=
 =?utf-8?B?RitISU5lbytja1hITkJLUlhkbXZ1NVhwTncxd0pFMUx3ZmE5aE56REdVNjUv?=
 =?utf-8?B?dVhkci84RWFuM0UwbEFsczJrRHBvTWsxZjcyWUlBS0pWdHZIaWY4VkpSWVlT?=
 =?utf-8?B?RWZYbVEyUGxzbVRxTVppUFc4cFdwM2xacjIrZzdOTGlEdE0zdjdIUzYxMmlp?=
 =?utf-8?B?QkdYb2tSbmorQWdOMFZUMFB4NTZjVVZtV0RJWjFrQ0ZlbHFsQjhwWVZUT3BS?=
 =?utf-8?B?NjFFRGFiTDdjOUpUMU5DY1dQNGN4TUNkTVNpeGxPMlNDZ0QrT0Uxa3V0WU5v?=
 =?utf-8?B?cXdXdDUzSUlSV29FZG9GQUdCZllFZ3c1WnN3YUpDTG9GR1lTSVVITmU3TUVD?=
 =?utf-8?B?WW9md1kzdVNsQVhZWGtBUFdUTWJlaFJhU0Z0b01jaEd5TkhoQ3R5T2x4UldR?=
 =?utf-8?B?a3hHK0QyZmFEWFdJejdkLzRtcWE3T0JIdXBQdDFRWjhVWlNic0lZTGxGT1pP?=
 =?utf-8?B?bkN0VGNoUUgwK1ZUQzByWGN2QU85RHdHMlg3dXUyQnE1NE84ZXNGTk9HYmpq?=
 =?utf-8?B?TnJQSTF5bVlsVHc2T3VZQm1pWVZpWFkrd3Q2WnE0QS93ZW5yMFFGTlVKTFp1?=
 =?utf-8?B?WDQ5VENMdktjcHJZOHpTR1dsNUgwdWdxZ0xzczNuRjVWbXlBVmxGRnAvNFhm?=
 =?utf-8?B?QUhYNWlLbU5haHZxc2RicSsxRFRya2NaWFNIc3F4R1RtajBOSVA5cUU0RVJ4?=
 =?utf-8?B?ZDJEZTdoU1ZlejFmaDVpS3ZhK3NsU2ZRdlBGUTJ2eklsdjduVmVhdXI0T3Vv?=
 =?utf-8?B?dkRzYkZEc2JTK2YxL0VPWHoyRXFvQnhyMnIxWGRpVTFJOFlpMC81M0lCTnpT?=
 =?utf-8?B?c3ZKV1FtRDRJemFpb1MybWw4Zm9nazNYNEpYTFpWemdwSzhWdFhtWGdCS09Q?=
 =?utf-8?B?Tk1Remk4clNvc04raW0yNTUxbm4xY0VVYjBRcjM0TmVPUU94M0NyRlpEL2ls?=
 =?utf-8?B?MFRCdlE4bm5wVmtYbG9EbUhUSlR3eVYwL3VweCtrKzFjd0xnTzR4d3k1bS9U?=
 =?utf-8?B?REx6UmJ1WjRoUG1CS1NLbWRRV3U1NzFHVklUekFVRmxkeWpDOUdUQnlBdjRr?=
 =?utf-8?B?VE5oNFMvUG84V3QxYjI0ZG9OaWJhZms4L3p3cnAxd3lhdXJSWTBLNHJQb0dm?=
 =?utf-8?B?c0ZZRlZENXZJU2J0OXNaeWZaZ3k3cFJoblhZcUxrT1dUR2o3a0JWVnFMNTlu?=
 =?utf-8?B?eFZCNWRONlJLajN1RDZjOEVZa1BDdHU2ZHdUYjN0eXl4Y1UramhaOHBoZzhj?=
 =?utf-8?B?RnBETHJWdFk0VW1iRE5IK2t5OFU0bTc0NTFINlA3aHNuT2FRdWJkb3oydE9M?=
 =?utf-8?B?MTl5QzRvNFovb04zV1czRmlxQ1p3RFVQU0ZoN0hxL2xnVVJ2dFN3SEd2R2pq?=
 =?utf-8?B?R1VKS2t4S3R5MlFsZWdhL09URVQ1RDNESlNDak1lWmYxVWVRNnZmMTR1U1dp?=
 =?utf-8?B?SXFwNHVhZ0FnSDFzZ1ZmY2YzNjVSeGNiYnRRdkJKd0FMR1hUbkpROXBQMlNt?=
 =?utf-8?B?UUZTWXphMWtKVEJIMnhKNnVXd3RpWXExKzhGd1lGSi8yZzhLbHhaQjMrSm1J?=
 =?utf-8?B?NDhOQ3NlaXNZRFhuSFQrd0pLemxhSXhHNWlkd1F6OVJhTGQxWHplQXRHRDRo?=
 =?utf-8?B?c2V4bDJaMktSVUUyazM2cE1abXdUUVFIOTNWWTBtUFZTS2JPYVVXc3c2aUhy?=
 =?utf-8?B?dDhzb0hrWEl3WHhjeWlJUEROQWRTUkZ2QlFsNjVDZzdWdzZUT1JJYzdxbzJO?=
 =?utf-8?Q?ywND5G?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 05:57:47.8036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 793b8416-e552-4005-7dab-08ddf99cf517
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8466

Hello Prakash,

On 9/22/2025 10:58 AM, Prakash Sangappa wrote:
> With use of a new structure member for slice control, could there be discrepancy 
> with rseq structure size(older version) registered by libc?  In that case the application 
> may  not be able to use slice extension feature unless Libc’s use of rseq is disabled.

In this case, wouldn't GLIBC's rseq registration fail if presumed
__rseq_size is smaller than the "struct rseq" size?

And if it has allocated a large enough area, then the prctl() should
help to query the slice extension feature's availability.

-- 
Thanks and Regards,
Prateek


