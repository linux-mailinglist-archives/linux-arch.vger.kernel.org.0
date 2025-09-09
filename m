Return-Path: <linux-arch+bounces-13448-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58A6B4A8E3
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 11:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB2C179098
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 09:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38AF2C235F;
	Tue,  9 Sep 2025 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MjynBoWN"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8782D0C91;
	Tue,  9 Sep 2025 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411561; cv=fail; b=ax5lOpOqvFbkDdkuc+3jOQzrwKyR+CAIn20p6d3LL9py6bXsZI361GSTMzs9hiSCXWfWr4/QG8ijcARu97pcnXG5c2YrCX88rseBzQre4xi8D6IEVZdYsgC08b1WVKOXEAuyyu+tcUoihde0bBJ+emfyHDkbXmXHEy1O6IYuf3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411561; c=relaxed/simple;
	bh=qWxn5f27Cm11XpfhGnCVYFCDq8NL8gqPlIB+K4/9S6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YeiQX/FJ626JKimlYBPI6WCySMOAQFfvEqztrp6ybKt2B58GVk/eq5eYdBL/BTKgjG7HsWOM3QUl5YcfTReSp9AUgWMPYlAuljJGzsre/aKVgCAPopaKPje29bi9/lNPuV4ApYIT+0Ng4TJX7XeVb+OqyD+W3SXxjm2aReDsa6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MjynBoWN; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXcBpDE2pyXHjMuOhWIBjiE3MhEJQ5FWEFHPcAYEgRChe8pRM5Jt/bh5dxkuBKMnOwL3u88zvk5jGXTq3vQu+fFjzl5onrquYTZ4Tk/f8ga8VJPyKcAuGjoeoeUAm6nr5ALiP/2XV5L6v1a15uiQdL1HNLQjc4NJhpug5aHMcFthrC4Jd0pLWrUh3WtuwPQIcPPyu6PfmJqQOCryXX19mkfrbj4rXnhfzQwi+2oJaoEy7aAvxnKlj+tedRi6jL63eXxgZxfbqHs5Eu4kbWmfFypP2x1qGgisNDLY3rCXmOksuQr0V+A09wK2V19p1IHVR9P25ZhZP3wKDmwL/6Ze5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nr9p762kJ6JAeZRy4NgLwedg4fEz0jj0+N6d25boNQQ=;
 b=yWHhrqg2bknA8Dii0jcXAL4eQASZudiw77O5A2FUQNVhT5Cw/YhftN1DymJCKnEgpU+i9Sv4wow0qNpWP8w0yLN1DCjMtBFnBeNh9+fSBOeEVY325/dKtFL/z8zoAlrqGCwv8VeFI/9GgLzlY98Ey36ZCsr/7UDQgOWSt2+mZU0oNkfdL276HQx/XV1up4G9+M6ulnHU6VQAORHR4HO4eABUH/kaIg6tm57B+FGwy1f44s6CcsjrnNkqPYsIy3ejcrnjQHcaV7PMO9TFy1r3nmx+9ylZRKcJqeb2F3EOCyxvnZKRKzCesPxrF7nIX7BWjLt8njdqhvxY+PWWkn4vZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nr9p762kJ6JAeZRy4NgLwedg4fEz0jj0+N6d25boNQQ=;
 b=MjynBoWNOGHnGwC5nC5ot/cqkjMqJEftp9wcAYs9J9cNg2/+MCQOq9AlfJfqvHy/aNjm/KJVDcLDale8srBRsal2kCACFHxqAkeTjdx5VMZ5jNDPI/MBbEu1HiHEpvDFm0BS+6S+XbvgSLbwFO51Xv1WLvG2DXNdLJTlI6wwbBI=
Received: from MN2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:208:134::14)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Tue, 9 Sep
 2025 09:52:38 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:134:cafe::c6) by MN2PR16CA0001.outlook.office365.com
 (2603:10b6:208:134::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 09:52:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 09:52:36 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 02:52:36 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 02:52:36 -0700
Received: from [10.136.43.237] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 02:52:32 -0700
Message-ID: <47499513-7bf0-4393-ba89-5efd9c115c43@amd.com>
Date: Tue, 9 Sep 2025 15:22:31 +0530
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: 30959a2c-edb5-447f-893b-08ddef869b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXBsbWJhTjdTNXRBRWJSWmx5VEdmWXA5czNZcGMxRDdPL3JEc2NDMmtLa2Jq?=
 =?utf-8?B?Nk84U2U3Mi9PNGJTbzVVbE9Ldk40REIzeDlRVEV5WEZuUER4NzZteUtPWUtF?=
 =?utf-8?B?UXRodWpWWmlZZU40RWRoSXJ6MElvTHlRWFpVanZmN0hCaElkTVBnWnJEb2Iv?=
 =?utf-8?B?a3o3UVNQZWZiRUVLbko4SWRzdXhoODVTOGRkNUkzTU54eGEzNDBTMlhNTVJ3?=
 =?utf-8?B?TGthVjRGajE3NU5ucjRHSjBWN2tTb3RDYjAvK0pqZG1ralBTZlY4S3VjZHRu?=
 =?utf-8?B?MXFZRXozTW5tblQwdENqbzFta2dTbEUyUmh5TjlwcGpLMFpVQUN3UU5jaWtX?=
 =?utf-8?B?TGptclM0OTdUaEJMRk5qTURzamV3Tlp2blVKQ3BSeGxiSldaN0JaLzZHLzU2?=
 =?utf-8?B?QS84ZExaTjEvTkMvbHV5b1RNNXVadHZ3a3FRYTNLdDdLUnlnR2YxTXRxYmZ2?=
 =?utf-8?B?Mld5OXpyT3JxbjVuL3pSM2VrZGtaRUhiaE96dnRiYTBKYmlTWHNvMUltcDVR?=
 =?utf-8?B?MmNCR1NjNzhwU0hkRS82ZjJwTEhsV1JiaW9nSFlvWWxGUXc0N1ZodXRkYmhT?=
 =?utf-8?B?SUsvb25NdHptVmJJOXVZbmNXcHJ0ZXYycDVubzVuNmk0M3dQRVlVY3dSdHR3?=
 =?utf-8?B?Z0p5c0lySk4yV21tOVlyTjEzMnhzUVR2bU5wbnlER2JxWEJwZko1bWxBM3A3?=
 =?utf-8?B?dUFVQ0xCTXhZaTA3YnNNWEpWMWxGZVhxNGI0Y1JZRXBoVVhVcWNjWUNWalBz?=
 =?utf-8?B?WE53WFZMS3ZEdXhCVy9TSWpjaUJrNWVTeXRFS1MrL1ltQnhUdWRWa3ZpL1g2?=
 =?utf-8?B?OVN6Y1V4SFVPK2RkcnlwdTlFSGhuaU82Q3R0TFNDQTJUM0NvNks3VXNHMzJj?=
 =?utf-8?B?bFlRNlA0ZzJVT1k3cHFXRWl1cmRZZ2xIU054dHpiejdWaTlSVDFEUUM2WmVM?=
 =?utf-8?B?Nm1UMSt0MW1aVmxRUjRpT0tIajdUL3BIOUVQMG5NOWllOUxLemhhV0szNnpY?=
 =?utf-8?B?OERpT1Z1aDVVV2QrZXBNQTdQZ2JyOERlQ0lIWXBjV1BHL0dvTGo3QjVnY3ov?=
 =?utf-8?B?YVEwcmhyc2xYdFlzS2RZRm4yQlFhdEdJU0dxV1hZeG9HdTdnc0R4Mk5IMjFZ?=
 =?utf-8?B?UEErc2RadWRDNGo0anB0WHNDWCtDbmovdmh4cXdBTnRRYldKTDUwSTFGcDBr?=
 =?utf-8?B?dTlsckM2STJ6WW1lS3VlL1JlNmdoc1Vac1RJNEJBTEUxWm5LNVpqVGYyNVZk?=
 =?utf-8?B?TkMvM2ovaE84WXQ3bUxpYXdiMVVrWlkzYUl6eElLeE1kUTRXM2w5VzVScWdV?=
 =?utf-8?B?RmsxMExUQ0NDSXJiTDFMZlA5ZUEvd214MC8zZVA0ckg3TDNzRGU2VWxPb0lm?=
 =?utf-8?B?MVdoSm80M01mZHhwekJLVjA4b1FUVFJEdjZpV0RsbzZZdCs5QUhONFJnbzE5?=
 =?utf-8?B?ZDdkRHlYaVdFMFVpVzM0UnAwcjQzN3VjQ2hmUEE0bEF5ckJvSTVnWk50eTFE?=
 =?utf-8?B?QkdBeW1tMWpSeVR4L3d4UVpXdXlMdmNRQ01RWVNZVlB5ZFVNL001b0M4SklI?=
 =?utf-8?B?NnFqMVZtWXcvYTc1ZHFzMFRNdnZLNER1azJPNFozMU1IVXg3RXJuS3pDdm9u?=
 =?utf-8?B?QnlLSVhmNEl6LzA1ZDBuY3oyZUVGeFRYalFBa21wV09hbS8vdFdpTmZ5Sjdw?=
 =?utf-8?B?MDU1NkFPUm5WOENhb3Z3MG5reDMvVXJMWlEvMUVkR2JrMFBQRXRTOFFnbklL?=
 =?utf-8?B?cUM2QWlEQ3UvbkE3b1kvK3p6SUQreGlKakZhQlU4ZmFUaGY4TFJqdFVlRmxv?=
 =?utf-8?B?SXJNbXZUeVdUSy9uK1NveW52NEN2QzZsSkQ4cFY5TTlUVHdPMGd6TTNheHZO?=
 =?utf-8?B?cDROR1Y1Tk0xMkpCZ2ZlbTRaVmo2ZzM3aDRVbkxZTGdaMDlwdkp6MS93ZldG?=
 =?utf-8?B?VDFWUlo2Mk5Ed0dRWHZTZjZvSTZxV3hGYi8zSjdraEVRVmRoTytYWERIYmFj?=
 =?utf-8?B?SUtYVjVaZk5Lc21mbkd4eEhpZDdCNmZyL0hhVmM4WFUxUXQ3WUxNRVlxSVVq?=
 =?utf-8?Q?zxjuEJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 09:52:36.9281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30959a2c-edb5-447f-893b-08ddef869b7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382

Hello Thomas,

On 9/9/2025 4:30 AM, Thomas Gleixner wrote:
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -542,6 +542,15 @@ int rseq_slice_extension_prctl(unsigned
>  	return -EFAULT;
>  }
>  
> +SYSCALL_DEFINE0(rseq_slice_yield)
> +{
> +	if (need_resched()) {
> +		schedule();
> +		return 1;
> +	}
> +	return 0;
> +}
> +
>  static int __init rseq_slice_cmdline(char *str)
>  {
>  	bool on;
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -390,5 +390,6 @@ COND_SYSCALL(setuid16);
>  
>  /* restartable sequence */
>  COND_SYSCALL(rseq);
> +COND_SYSCALL(rseq_sched_yield);

I'm not sure if it is my toolchain but when I try to build a version
with CONFIG_RSEQ_SLICE_EXTENSION disabled, I see:

    ld: vmlinux.o: in function `x64_sys_call':
    arch/x86/include/generated/asm/syscalls_64.h:471: undefined reference to `__x64_sys_rseq_slice_yield'
    ld: vmlinux.o: in function `ia32_sys_call':
    arch/x86/include/generated/asm/syscalls_32.h:471: undefined reference to `__ia32_sys_rseq_slice_yield'
    ld: vmlinux.o:(.rodata+0x12d0): undefined reference to `__x64_sys_rseq_slice_yield'

I would have assumed the COND_SYSCALL() above would have stubbed this
but that doesn't seem to be the case. Am I missing something?
P.S. I'm running with:

    gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04.2)
    GNU ld (GNU Binutils for Ubuntu) 2.38

-- 
Thanks and Regards,
Prateek


