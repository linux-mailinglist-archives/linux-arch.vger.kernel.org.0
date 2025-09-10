Return-Path: <linux-arch+bounces-13467-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988D3B50CDE
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 06:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3FE465279
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 04:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916002BCF7F;
	Wed, 10 Sep 2025 04:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QqRYxGev"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E377D1F30BB;
	Wed, 10 Sep 2025 04:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757479355; cv=fail; b=RRUHWbT/SHEeU0U4VC86DMWLggvSEbM2IcqlCtowAMZQgUpHxHI7kw8cKDAckpDTGcDTQJIsVNBdTIDwFVZMhKIG4CT1psctDQnFuXiot4FzaKjFu/ehjKIawbgI920717950yZ1qdUglDOTO4ybJ2IM7zw+omozBoiuK95y/Eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757479355; c=relaxed/simple;
	bh=LzfYaemeGy7J3nBvZWmuTLXBxlP5GLyb81Q+bfLL7ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z4f+3Qf6ugALMiJ0sInNkK/RUw7Ex41AZ8tbU/SmrpCmjhlJBh+alYWmhMabq5MYZKdZXEfrqtjwj5e5S+BlniC8m6xR2ZQnIK+FLTQXwoCVBJuxM40awhRWyf4A/WOqIBmXpyKWXurxNRy6a1S8iM3lQWQE35gKN1HG48Kdu88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QqRYxGev; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoWvALvRvmk6bHA9VxkVkOERBtlZqZuI16zGJhH6J1IHwle5lgimRx8ZeCGBMNog93xnmE5rpHd5FBUgKF9fqV/xbW+KbVRiDrIZQ1ifdhtG2g9qKxsMHLNPlV2PlL/r0mbz4rbguh0Nugpzh4bllDwkhsDO59ZLKUVOZUoeA4H92KGEmtDPRUYziWX9jD+iL/gFCbaPSdqNPcz/0gLk3D12Od9rugPIsmgcbzEyivEWTzEy2HDA+SnWLdYbCyFXJspufrLas5DlDBjxgoE9i3SYLx88zPF50miXPXmuybLITDYEgNmORAtgMIJYS/EFUIYufqxnwFQdURxs4a4MOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uGGlUVYBucNt0v9638C7TYkBKuHsuG4LerbndhhGXI=;
 b=nrxGApjAqHoNpBAL7zeTk5O+NVU/Pwuyh8li0OpFWlVuQ0FCZbo6196/yNgbjaSLq17O9cUj81SDBwfBpRqBjBGMOcGti8YqyEhLvO6VhH4goRVP0kYJRuDgMPp0tX1pxf9pXfA2rSPXmGzVLHuxqnfhTuZXclrAlsL42VXhrws3zbX2HbuVFGlmdQmC+HZD2hjJa63Vdu0KyUV512GymGoXH7AoIooyUMXZ49/arsL4mHmFr5YLRNtit9b/OSzytkrPpPzd5hEcbagzY7dsn+ggMCnxHyFwLu5paFLt2c//EyP9daja3ti48aCb3xLdm77W27I6NH4NmzaefZQXWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uGGlUVYBucNt0v9638C7TYkBKuHsuG4LerbndhhGXI=;
 b=QqRYxGevfgYH5VJuWmZA6kwgElKqjxZ6Mno2AJd2hBYYsxULKikwmXsEpDgc1kYmD2FZ4ZeQPRwEIzeBEgmHPDoP4S3Aan+eoeXPY4xQaCORld0eFndGD0PYcCycGEQtqDCRsxCHSoaqhG80vc119CnxrxlupkfztGuyl7o8nWs=
Received: from SJ0PR03CA0352.namprd03.prod.outlook.com (2603:10b6:a03:39c::27)
 by IA1PR12MB8406.namprd12.prod.outlook.com (2603:10b6:208:3da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 04:42:28 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::a1) by SJ0PR03CA0352.outlook.office365.com
 (2603:10b6:a03:39c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Wed,
 10 Sep 2025 04:42:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 04:42:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Sep
 2025 21:42:27 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Sep
 2025 23:42:26 -0500
Received: from [10.85.34.232] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 21:42:22 -0700
Message-ID: <c3caa913-910d-4717-89e0-625959faf12c@amd.com>
Date: Wed, 10 Sep 2025 10:12:21 +0530
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
	<linux-arch@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>
References: <20250908225709.144709889@linutronix.de> <87ms73vm1q.ffs@tglx>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <87ms73vm1q.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|IA1PR12MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: 398c362d-e6ab-4a18-9528-08ddf024722c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHBCMjRrT3lQOERRN25hUUJHQWtTdU5lU1Q3NElkUTU3dzlMMHIwVnZ4d2w3?=
 =?utf-8?B?M1E5RDhoMjVtWDg1a1NNZ0ZPL3lvNXUwdjVrY3E2QUZLZ1RrbDkzK2ZnU1dL?=
 =?utf-8?B?ZGNxcEFyaXk0N2ZWWUhjRXJQZDdFcmFHdXhoSHZ5L29KZ3Z6UmVUaFc2R2xM?=
 =?utf-8?B?SWhENzloa2d2bUh6ZVdnbTZURE1kc0tVRnRPUnpoWnpuYVY1YUhtMER1S1lL?=
 =?utf-8?B?VVZVYm9RUFFkc0xQWi90d3k3QnBFREtkdFY5WEFNYUkyeHBvSTk2Mk80dEhJ?=
 =?utf-8?B?Wmc0SVhSa1BSZVJVQ1lubGpCazNnYWhXY0Y0M282bWZ6NFlabGVjVmQzZDd2?=
 =?utf-8?B?RzByUG43Q1dwNWxPWi8wL3AzMDFVSVg3ZFgydHdjUCtqSHE3ZTBmMEJKSm04?=
 =?utf-8?B?UkVRYzFSS2xzVm5VSHZZNW52V3BVOG5Uemt5RXJNdEtHQTB5UGkva0t2RzlY?=
 =?utf-8?B?RWpLQXVJLzRDcFg5NC9RaERneEQrQXhxdlM4M25pMFU4cVAvWVJ0ZkNXaTFJ?=
 =?utf-8?B?SnEvcHpmcU1BSDFsUC93eGNZeTBoZis2dHVxVWpia0UzNnhZUEM1aTJuc1hq?=
 =?utf-8?B?L3c5WFByWkM1SDJFYVZWUDJnckRsWEpja2ZUZmExd3dTUlJkWWlSU0JQRmJk?=
 =?utf-8?B?RTJmVTNjNHN0VmZTRFpiTWE1bmVyRFZla29jWE9YYWpMaTlvRko5bmFxQUYx?=
 =?utf-8?B?YjlXMGdPa1h1aVNReWRIcUVJV3E5ZlJHeXhXUlFkRUxmc2RhQUs5d0NZS0xi?=
 =?utf-8?B?dlJNZDNMeldsRU1TNjloNXJBWmhFVmJoRTF1aUo5enJmUTdQV0RKNndzQ2Rl?=
 =?utf-8?B?akYyUjhMSUpTR0x6V1dOV2lZMEl4R1JBcTdPSDJSR0RWdXplSFEwRzdiMWpD?=
 =?utf-8?B?aUVTYjBJRnhpWE9pTUN2b3ZUWENCdzJJUE1HQ0tROXV2NU1oSGhuTGVlWUdH?=
 =?utf-8?B?UjB0K1R5elRxUGpPdmhPY3R5UWEramR3UkQ5U0QxY1RDbWZIbUV0R25xVUV0?=
 =?utf-8?B?dHBKOWRGelorNll0bUdaSFRCVUpnVXQ4TEh6M3JRZ1JDb0JTS1pURS9UWVZW?=
 =?utf-8?B?WjllSTFqYzBlRXJQQVlnVDFsODFoRGt0c1FUbjY2bDJGTnQzRVZCeGkzdWdz?=
 =?utf-8?B?ZkhQaG5PSzdtUDd1cm9EZ3lvU2VFZkpUb1RwODEwKzlyOU5xYkdJc1NQcjQ5?=
 =?utf-8?B?ZXRCbERpR2pzQkxqcnpWOWtHdmZSUUtTcUZJcjE2WW1BUWhKenVqV0xQYkE2?=
 =?utf-8?B?M01iTExOYWU3ZFhDYW12WXZTNEs2WWYyMVlrcktpbW4vbVZnc3lOdTZsYWJZ?=
 =?utf-8?B?UE05cXhvamE4QnBYSU81UWdKR0ZZbG94THNmanFWd1pZZ1FhVzRzM1B6bWN6?=
 =?utf-8?B?OXhDNjBSdyswRUduN1dDV3BDWVluV2RuQnBUVUlmeWcweWY5dFdnb3MwQ2NC?=
 =?utf-8?B?ZHdGb3ZTd0NpT3g2TVhINytNdGFyM1JQaGxwU2EvUGgwWnl2b2ErVFh1aGR6?=
 =?utf-8?B?T1A0TGZlMW9ndmhNdUk3ei9OUHVta2hDRUtFUmh3UkdYVjJwY0NJTXl6dVhO?=
 =?utf-8?B?WFBGVFBvWFEwcnhjcHVjL1Z1YjZOQ1JGeGhQVW4rQ0pYYUtvNEo4NThPS2ZI?=
 =?utf-8?B?Tk03ckgxYWtjZnlJWE5pTnhyRGtEY0xwM0hWSkt2UzZqcnlqWURvUHJxOFBx?=
 =?utf-8?B?TkpIU3pIUTRWS2g1TVU1NytURTNJUTlsejFoaHNnY1NUdVdtMnlnemRSS0NZ?=
 =?utf-8?B?a0Y3VEJSS092OTlDdWpLd2ZLRHRRaGJwaTRhUjVZTDRENFRwK1pvQkN2VEdn?=
 =?utf-8?B?ZWZwaXh4TEhUR3FOZCtEM3ZyMU1Da2tGQU51bGFqVWpJbmJXcDRhZlNTeFNX?=
 =?utf-8?B?K1BtRHVibG95QWdHZkU5cjlRUTdPMDQrZzZwS3N1VGdlQ09jWnBnOTNYZmJo?=
 =?utf-8?B?NFFseGZkbFN1aEY2ZEkxL1JaempBOEp4eDJuaTdDM2dYSUtsZlJkM3h2bEdE?=
 =?utf-8?B?MTR4VTVPT2EzZmFVU29DV0pxR292dDRzNjJnM1QvSmsrOEhqZFlJR0pkYzlq?=
 =?utf-8?Q?8p3Cy9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 04:42:28.0619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 398c362d-e6ab-4a18-9528-08ddf024722c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8406

Hello Thomas,

On 9/9/2025 6:07 PM, Thomas Gleixner wrote:
> On Tue, Sep 09 2025 at 00:59, Thomas Gleixner wrote:
>> For your convenience all of it is also available as a conglomerate from
>> git:
>>
>>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/slice
> 
> Force pushed a new version into the branch, which addresses the initial
> feedback and fallout.

Everything build fine now and the rseq selftests are happy too. Feel
free to include:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek


