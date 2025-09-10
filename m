Return-Path: <linux-arch+bounces-13472-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5F0B51562
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 13:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF05E4825EC
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 11:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5942F287272;
	Wed, 10 Sep 2025 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ePouYyEh"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5628274FD5;
	Wed, 10 Sep 2025 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503406; cv=fail; b=Oc1nO/0S7sPpZW+j5H7sxEUa47YxGO5yQbftiuPDznaqrA7WVVDP7TyBo8DHZeAq9jtcyk17YOKTjuzxvYpDsQ3YtiliLChffaB59KXldWm2KS9lwaS4zd6z9XqhBPNafUYKcVQYdLnn90D4No8v1VmhCvYfHSvB/+7QOfVM+Z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503406; c=relaxed/simple;
	bh=ysX0KofEHKE7SDp3D+McrbAjjS+X8UQuN7bOpfsAWWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bnHl2MGcLcYsst7RjX2qUtfPBr/3Ujy73D7JBZ6VE0MgaZ2d5sI9o2zlb9FoPdHqK7SGjzlJMvwhyURfswtAJVto3OSF4KCisETcmmOcBprRI/c9U0Wk7YDQQwS52JBRtZu4VAeOEf3NiqcspMaEleSlJsjXga5qj9xX1VR0ELw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ePouYyEh; arc=fail smtp.client-ip=40.107.96.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBby0cCKj4N34Z6+gvsWYU9xfQCOOd0ARBPZfpP4x7Kwzs9f5ZRy8atoatDXzz6lPL27nMpBseKa9DG2oqu5f9H+yjdxWqRWBgBHKtHYpws/DrV2KsmA48jxOipTRU+d8+eMPQwJMqrZs8zSJMsYt6GGIbQJgmn/J01OfhUlzKcbDElJ3rHqUaAYdJR7/YcI8zcH2yQjCFVGRazq9s6jUEc2qjXHYMhiUw4IgS++zgxvvKI2f1CDQckbnrKuUrYfZl6yjhNayKDbLc/yKo2+d/abxpmNH3MpljOd+Q3lk5p0+gJpZliwPMjiyhe5cSg7MKRJZIqsioX1fBYp8Vjgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkKCvhrkMAg6pZccNTMiY9E0Awglr8Bl/aIY7A8yigA=;
 b=JCgRmzmYX3YYZswdtDwzMe4agwx3Z9HQnf0JCgyYIyTLLNilaW5aftJXHcw96mw5mcL1z2Vsyu+jMhCSIALK6k6NuXvlNAP0vAytf+Q0IQgtmq/g0IIXsE1S/vOmrBvM9bIhpl5RWNtoSKZbs/WtJwJD6hR9mC4XUdtFGSBZrVLxduZFyoNy+Kz4o7vl7EM7MRejNIGfHjmgJ5g7tWjq61XnlN05usdNySP7GQwkNsp3ck6Tfwtj6BmhCdnWEOfRPoFQQcWEhMvlHkD8p/qD56i9dD2/j6a/YZctiEkB49NT59W20KBmWo4XP6yCHqBv4wJq3mx+xJqV7/1e0HpnSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkKCvhrkMAg6pZccNTMiY9E0Awglr8Bl/aIY7A8yigA=;
 b=ePouYyEh2dzsevNp/CBWbp6dbO7FPnz4CY164AS8pPZrXg5roUH1+73IsALAcel7XbRsa7EaQelFCUj6z9o5BKlit0xY8JR9T4yYz4SFMfXhmjD7UvjmgLNHfl4yfcemgPOak71tJRzZ+OrsH/uDajAq/UcMI4y1d61F6hJTnkU=
Received: from BN9PR03CA0595.namprd03.prod.outlook.com (2603:10b6:408:10d::30)
 by IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 11:23:22 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:10d:cafe::31) by BN9PR03CA0595.outlook.office365.com
 (2603:10b6:408:10d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.23 via Frontend Transport; Wed,
 10 Sep 2025 11:23:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Wed, 10 Sep 2025 11:23:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 04:23:21 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 04:23:21 -0700
Received: from [10.85.34.232] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 10 Sep 2025 04:23:17 -0700
Message-ID: <15213575-f329-49b2-8e32-2b137e4221f0@amd.com>
Date: Wed, 10 Sep 2025 16:53:11 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 12/12] selftests/rseq: Implement time slice extension test
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Peter Zilstra <peterz@infradead.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, "Prakash
 Sangappa" <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
	<linux-arch@vger.kernel.org>
References: <20250908225709.144709889@linutronix.de>
 <20250908225753.332052396@linutronix.de>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250908225753.332052396@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|IA0PR12MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: 454426e6-da02-4439-62f6-08ddf05c7385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2FvVGtQeVJ3SkhOMlJnS1BacFpXVkprZGpnaW84MWFwZVhBd0RmZ2Y3MUVH?=
 =?utf-8?B?MW5CLzVnZmlmZUpNVkVIUXdjVEdKQnh5QW9JOVJpTVltcjY0NjhOOGJtTzd1?=
 =?utf-8?B?ay9sejhHWFBHbDkxQkNiMGVvandDNFNOUGtwSS9BZU90YW1rNUY2TERkTlFh?=
 =?utf-8?B?blltWkE1elRXUllIak5hTzlFWGFCN3QxK0lCT2k3ektSVkVQTkt1RnRnN2dE?=
 =?utf-8?B?d2lObExuSXdPTUN6b1hVd0FGK01SeHdka3MvYzZPekNUMDFvTkhqNXhaSjBY?=
 =?utf-8?B?YmR1cVBkVzFHTWtwaDg3aHN0dUV1NHBVRkZEOXFtSUE4NUpaZzhTb1ZEZlps?=
 =?utf-8?B?cVpTR1ovV1BQUWREWDdVSGVaR2gyL0x5NXFiWThSYktLT1RMSjZxSTdzNzVD?=
 =?utf-8?B?NjRMZWVqenZCdVhOSVlQL1BuVStPb3JYSUN1eSs5SUZMOFlCVFBPTEpWZWRy?=
 =?utf-8?B?akpBeXBmak9XN3VtcytpbVlJZU1QblpXMmtNNnFNM1RFUkVUd2laWVdmVzBu?=
 =?utf-8?B?b010aEd2UE8wK2lsQ0NMVjAxTkVXM293Zm5aYVdQUXdEY2orVG1DQXRXSFAv?=
 =?utf-8?B?ckYrQTR0V21FeG1SdWplS24xL09icit5NU1jTlE5dWFvRUNjS1RhRkdnUDFX?=
 =?utf-8?B?emw3RmtSRkJiMmZPZlpHdkVsQXlmL29BRnFCWVZRT0RXNndVOEtQN1lpYnJs?=
 =?utf-8?B?dm90MXdyTitOdmlUUXVYcjg1d2tZblo2YTZYdEN1c0pWSFZML09pUXo2YVVW?=
 =?utf-8?B?dzBubnpFU3hFV29DZ3FMQkpTaVVvTGZheUZDSVA1NU5nZjJYcjRFNXRrNmQ2?=
 =?utf-8?B?UTJQL1B5V0NVc1VlWFN0OXZZMEJvcDJMNjA5cFI5Z21PZlJsOU1ZaFE4NnZW?=
 =?utf-8?B?ZC9uWEpzNXFnbi9GT09VLy9rVEF5K1gzNmZjc2dxTVIxd1UzMkJQaGN0Rm0z?=
 =?utf-8?B?L2F0dkY5Rm1IQU1FL290VlN6UkNWUWp0eWtZUVZORHZndFd6WDREWkh0ZzB1?=
 =?utf-8?B?Ui9mSE03RHplS3RkRStIeTQzTGE3SFZxUnR5dUtLQ21SdEY2SkhhYzhKVXNk?=
 =?utf-8?B?eW90WXh1NEVuejREbmltTGRuRkM3MFNSb2hZRTViaU1mNXJLdkw5RFVNNGY2?=
 =?utf-8?B?azg1TlZjY2hQaGNQTGFsN3Y4T1grM3Jubk1oT2d2UGhvZzl5STYxZzYwM2Fa?=
 =?utf-8?B?SlZDZm40dDkydERURE9KU2NEUDBnQnRHSDhHUWVjR3NNd2M4dVB3TGdtVklh?=
 =?utf-8?B?Q2RoK2xnYzdoRGFQZ21VMUNMV2loOE5FeVBSSXdySlRxZ3puV0FrYkpXUm0r?=
 =?utf-8?B?eTRrekFEaC9LOGFTT29LN1M0Y2E4VEdGVWZsY3Zra21IOUJYMHJ5bitNRlN2?=
 =?utf-8?B?UlJkSkVjNjRPT3UvVkJqd0Y3cnVJTXpuUW9ZVGRkTDdQdDAwbXlsM0FabldH?=
 =?utf-8?B?RXEwWlRzODdiYUtiRmhrcVNoK1hnbEZCQ2VlMHFuMzhTODlnTHlzRWk0TnFZ?=
 =?utf-8?B?L0F3b0RKT2lqQStTaDJDOFNLODhhMFpVQXJudXNlNmV2dUtiYzdXV0ZkMnA2?=
 =?utf-8?B?ZE1YMk45MXN2WnlwSkdxZlNOU3ZLbFlIbG13dDBZVEljSWw2a1hvdGtZcHA3?=
 =?utf-8?B?T1psblVxUFoxTi9WbXJPQWc2UEJSbjN3dnN4bHRlYWllWnlqZ1JWcjkxK2ZW?=
 =?utf-8?B?K1JEMzdrekF6bFhTV3ZlOE9GYXFPWlowQUUwNkFqOTVGek1Sa0NITXl1TTFM?=
 =?utf-8?B?aDlKQ2pWbmlkQ3czUlBETGhmVW1WdGUzVGhyWk9GRnBSTW8rbGtEZ01VVHhH?=
 =?utf-8?B?YXJxbk02TFhGVjZWSXhrUndNVGhKVkhxeTdnZHlrbXdpL21IUitnL3A3YUsw?=
 =?utf-8?B?RjU4NlJYQ1R0OVdmWElNWmloM2kzeko3VWk4dHZMemVjSDFuZitqYjcraHZt?=
 =?utf-8?B?aTZxZ1NadmZWNHRnUXI3aFZuWDQvV1k5MG9paVptV3hCemZZSkhKZEVBbVEy?=
 =?utf-8?B?YXpIbkNZRFdpY2RhTFJaeFhhd2dxV09SRGdjV0VralVYdnpPcyt5cmNRVkJK?=
 =?utf-8?Q?JR5gXk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 11:23:22.1838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 454426e6-da02-4439-62f6-08ddf05c7385
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8647

Hello Thomas,

On 9/9/2025 4:30 AM, Thomas Gleixner wrote:
> Provide an initial test case to evaluate the functionality. This needs to be
> extended to cover the ABI violations and expose the race condition between
> observing granted and ariving in rseq_slice_yield().

nit. s/ariving/arriving/

I finally managed to trigger that cheeky race condition too :)

# Starting 2 tests from 2 test cases.
#  RUN           slice_ext.n2_2_50.slice_test ...
# Success        2088616
# Yielded          45097
# Scheduled          174
# Raced                2
#            OK  slice_ext.n2_2_50.slice_test

-- 
Thanks and Regards,
Prateek


