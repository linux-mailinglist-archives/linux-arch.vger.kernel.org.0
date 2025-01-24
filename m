Return-Path: <linux-arch+bounces-9881-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EC6A1B3E3
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 11:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15AA216AE2B
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 10:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0911D0B8E;
	Fri, 24 Jan 2025 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QtCnc4hW"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B04A17FE;
	Fri, 24 Jan 2025 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737715729; cv=fail; b=Nb2KgtlWgUKdA8eSYrT/XU+u+aA0Chl7NOqJZ9KdWmJvuNvdd3/l4TnnpxWgspM5EfEVokIp86iizBFQClRXNA+UDRbhdudivL/0Hjoi29idfNfcGBWnRncIWh0dX/0OmCPNfL5CgXo0hBOLlkZfhNgv009YlzvVTMT9jjvG3iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737715729; c=relaxed/simple;
	bh=9Tg5dYt3qQlUcXE7Fyydvm7ZctFfDt9d9Ff2o4IKz+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J0DjEChgjs4+XgTdmyUgQvduew0sWVN+/7jRX3Y9jh+PW3iD10rayTDPX3wEzNpdo2M7zbQYTbonV8XI5Aj/DbK29qn/kUkkrVwA/zQwiAyeVRmkJOEKOAP2p7AC+ygV1tMDJjObn9EkTpfZ/TVNQS26ScCxIBKhFvIuyePkI+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QtCnc4hW; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSEBHvK2N2aor+hK5LGetpqh/Roq4RE062Ied/RYZyeLMmNWjiBCxaOAdrZL0Pl3SIzQUG4sjtxOb23rwqcmoXZQ8vk8vLCAa1vfXpdSvzPSxnSmaZw4QcesJOH1bDQJGUjREyQRuvUWo+fGuecvBv+A6Ia8NqosO1abjj76gAyiYDf+itdlb0+Ne28y1o00hSnKvS33knadF0uX9s11psvW4KaHxRU63+dq9kJKyBONOdR6GdSMbOGqL3H+cIUxFukqoxxT2sb5Y/RCvLw1Bqz2L8J80Xs1PGDoKbXdxtinc7zLCmv4seGnYuHVhMGmq8xpzIRzBEnrTBLMulhFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwVvFaV9aZnIyo9GynOO/BvAClq3gm1jIac8yqCvAwc=;
 b=J1f8q0nZHpw8h9cOW6AYg+muF8gXT6maM0qXPSBmdcdyo8sjtXUMgghcNMU9c9mJGzN8xxeA4xEZinsZPsIdCJVSCisw4NRqzmomsQpwloxel4O2ilL3bhGhz2PMwqMpOyc/6w4kYH899OK5ltirhlWy1CfSIxDY4E/92NVIEaTLARXyRysbqWjO6Fy2uFPzCsWrzVFHxP4g/KZQ23YaQPEeyQr6FKi8BFP4hBCr1i8VVCftJXoDSHEU+RrjrhNupRsXdIP0SgvRFxlwZrguddMkXdyuQ9QVL3zQFRqsefw2hwk0z3qchVuih+31lIwtRqQ2JJX0ooYQ5YPG3BF+2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwVvFaV9aZnIyo9GynOO/BvAClq3gm1jIac8yqCvAwc=;
 b=QtCnc4hWjSJiYO68q+59zcxwqbjygQLbPhpdGpjQYfKLf723X+8ycyiTSPnIQ+ssntv4+KBQi/MfL+/3JMxEpbeZnbp8aYbdPbfr9c2R4ABg6zPf0YNP0WsXAU/fkHwBMt1QTGSqNRKSwKsFEHdcZZCoL3C402yDcmEWPw20MVg=
Received: from PH8PR15CA0019.namprd15.prod.outlook.com (2603:10b6:510:2d2::21)
 by SA3PR12MB7806.namprd12.prod.outlook.com (2603:10b6:806:31d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Fri, 24 Jan
 2025 10:48:43 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::1f) by PH8PR15CA0019.outlook.office365.com
 (2603:10b6:510:2d2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Fri,
 24 Jan 2025 10:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Fri, 24 Jan 2025 10:48:43 +0000
Received: from [10.136.33.41] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 24 Jan
 2025 04:48:22 -0600
Message-ID: <8c298b9e-d7c2-4a27-b993-e3bca28f8237@amd.com>
Date: Fri, 24 Jan 2025 16:18:19 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 25/30] context_tracking,x86: Defer kernel text patching
 IPIs
To: Valentin Schneider <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <virtualization@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<xen-devel@lists.xenproject.org>, <kvm@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <rcu@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>
CC: Peter Zijlstra <peterz@infradead.org>, Nicolas Saenz Julienne
	<nsaenzju@redhat.com>, Juergen Gross <jgross@suse.com>, Ajay Kaher
	<ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Russell King <linux@armlinux.org.uk>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Huacai Chen
	<chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Liang,
 Kan" <kan.liang@linux.intel.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan
 Gupta <pawan.kumar.gupta@linux.intel.com>, Sean Christopherson
	<seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski
	<luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker
	<frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Jason Baron
	<jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel
	<ardb@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel
 Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
	<jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Juri Lelli
	<juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair Podemsky
	<ypodemsk@redhat.com>, Tomas Glozar <tglozar@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Kees Cook
	<kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Christoph
 Hellwig <hch@infradead.org>, Shuah Khan <shuah@kernel.org>, Sami Tolvanen
	<samitolvanen@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl
	<aliceryhl@google.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Samuel
 Holland <samuel.holland@sifive.com>, Rong Xu <xur@google.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Yosry Ahmed <yosryahmed@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, "Masami Hiramatsu
 (Google)" <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, Luis
 Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Tiezhu
 Yang <yangtiezhu@loongson.cn>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-26-vschneid@redhat.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250114175143.81438-26-vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|SA3PR12MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: 600ffd5d-1ae7-41e0-e57b-08dd3c64abd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGI4dEMxdFNsNzRsU2VWVmlmOTM0OVQ0cm1QdjlOTDlxa2tWcjR4NHlEOXZW?=
 =?utf-8?B?b3UrcW5BamtEb1Nya0pWRDFPY3hRZDViek1ERGg0eVgzWXJmYkh4WVJRLzdR?=
 =?utf-8?B?MEc3NWNTaTNobU9EckwyajdiMkVxQUJBYlZjYU5LajVVSmlQOWlDaGs0alBk?=
 =?utf-8?B?cWlONUUyVlQ3c0hsS1ZTb0ROV0VsUVhVWmprTmxnZm1MNGhYRFpmRlJnVVFK?=
 =?utf-8?B?UEdlOThNUC96dkNGQXJFSmRBU2JmTXdmRnBBWHNNS3Jhd3piOGpQTGJtUmhY?=
 =?utf-8?B?R3FZdHd1R3V5UVZVS25GWjJISm5uYjlRMmhuVERUWERqZ1V5bHFCdURjdlNW?=
 =?utf-8?B?R05Ua3dlUFcrUktoVDUvVnhoeGdQamtSQ3l4RDBGT25EU2w1dkJLbHhldGJp?=
 =?utf-8?B?YUxFTTI3Q3FlRDFwT3hPMUI0Sjl4R1JMbStQZEt6R0c2WWlSMDc1azlmNzY3?=
 =?utf-8?B?MmQ4NTdsd3JjWjJZUDZRVSs3d3hhMXlBVVVMai9nY0VMSHlRMjNvMkJYbkFq?=
 =?utf-8?B?RVkzcWZOczNLYWprR1Ryb2lRbFkxQ2ZHY3RMN0xkY3lpOVFqS3QwSnQyRElJ?=
 =?utf-8?B?SEt4TjhLWm00YWl0NUlQeVA0b2paQTM0azBleHVLcE9USTJEYlo4WnZFNkFv?=
 =?utf-8?B?c2VtZm1wRW42TVRiK3BxWlFDS3NkT0t3SWNrYmZ6N3lRd3FFZjNKYWdQaXJQ?=
 =?utf-8?B?Wml2ZE1qaEpxdEVxcDBiK2x1T21RVWJZZXhGVmlEOFVOVzIxZTV2a21zeUFa?=
 =?utf-8?B?UlVRR2hpM2xJcGFETkpxMGd6MGtiTFNmSE8yQ2lBY1k3TmtYM0lzZkN0Q1Ry?=
 =?utf-8?B?cG9FYlFlb2w0QXJBV3VGdnNXaWl5VThoc1VGVEFWSTQwRHZvUitCRTJCaFBB?=
 =?utf-8?B?eTRuRFMxblZ5OHZ6Zm5MbU82N1NPdVRYZllvNU5XM3UrYkdPOC91VUl3dnRL?=
 =?utf-8?B?aVdZazAzVyt4ZXozVzJqaGFFZjYxMXc4bXhRVVFhMXBCaXdGdkg5VjEyemR2?=
 =?utf-8?B?cTNCS0owUDZvQit6bHpjbkYwYlZOcU5CdzlkVS9Jc2hCMXhXS080ci9qL1Vs?=
 =?utf-8?B?Rk9sTmZNdG9mZ3FlTndKU2trK2l0ME1VaTl1Rkd0MzltbWhNZ1pPMTU0Y1pp?=
 =?utf-8?B?ck1PNytGcTlUWmpoV1RpY0JGZFdIcDJ6UkdNdTRsR3JxMy9xY2ZEMmtBRkFT?=
 =?utf-8?B?MkN2TVBiYWpaWXR2S2UrZG01blNiaFdrRStiR0k0K3ArRTc2UkMzaHVnRnIx?=
 =?utf-8?B?RTFjc1RZa1lhWTdJb2IxZ0ZFeUhBbFl5NHFJSmg1eENEV24yUDV1dkZ3S0xr?=
 =?utf-8?B?eUdhclkvRGN5ekRwVmY1QVMwNWd6d3g4SzdVOVl5WnQ3NEFFQ2dMYUorOXhk?=
 =?utf-8?B?Nkw5OTZyZ2ZLZGhwV0lmdzNLaW5QS1ora2pBSXlvUlJGWWNVaXB6bFBFZUJ5?=
 =?utf-8?B?WENVOFd5ZVMvaFZsU25mb1BQNXF3cE5lRzN4eUM1dzdzenBEbFMwVXR0TjZN?=
 =?utf-8?B?T24wK3VyLzFBMW50a21KUllmSmQ3MEJPdW9sQ1hDc0VHN2ZTVm9zTTJXTWZW?=
 =?utf-8?B?ck9Kc1ZMRXlEcDZzQnBnTG9weWt6MDNDbW5jOFdnVlpReDdCTXlJMFl4WCtO?=
 =?utf-8?B?SGxHQUZaRmxlR2xibmJiT3VPTElNUEhGcnp2Q0UrTHFHd3VtdzhWKzl6b2k5?=
 =?utf-8?B?MTl6UGZNWWovM3pMcmRvTjFHbFk5Njk0QVZZcnNWOUhtZ011S2YvSVBCWU1G?=
 =?utf-8?B?U1I0NVlrR3lnUEl2ZFM1b21UQ2d3YVF2OVZoOFQ4S0pLRGRudTZ4ZHBmNE95?=
 =?utf-8?B?am9UaGFHTTNnL2pORlRpVDZJdDlHUS9TYVVVRzFpem5FdXBDNk9rOHBKVjhr?=
 =?utf-8?B?eDMzTWQ4d1A4U1VaUmRUNmNsNHJuaElOQWdlZXVWaEk1L0tPSTVaMUgvN2N5?=
 =?utf-8?B?MUkwRjdvdnFHa0VUeXlMVEtPUlRzRm1QNFI3V2p0OFpwNm81dlJ5SHp5aVpt?=
 =?utf-8?Q?VrP+GI9ukCMThuvNcrCduETSHbKQ3Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 10:48:43.2233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 600ffd5d-1ae7-41e0-e57b-08dd3c64abd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7806

Hello Valentin,

On 1/14/2025 11:21 PM, Valentin Schneider wrote:
> [..snip..]
> diff --git a/include/linux/context_tracking_work.h b/include/linux/context_tracking_work.h
> index c68245f8d77c5..931ade1dcbcc2 100644
> --- a/include/linux/context_tracking_work.h
> +++ b/include/linux/context_tracking_work.h
> @@ -5,12 +5,12 @@
>   #include <linux/bitops.h>
>   
>   enum {
> -	CT_WORK_n_OFFSET,
> +	CT_WORK_SYNC,

nit.

Shouldn't this be "CT_WORK_SYNC_OFFSET"?

I believe it gets fixed in Patch 29/30 when "CT_WORK_TLBI_OFFSET" is
added but perhaps that can be moved here to preserve bisection.

>   	CT_WORK_MAX_OFFSET
>   };
>   
>   enum ct_work {
> -	CT_WORK_n        = BIT(CT_WORK_n_OFFSET),
> +	CT_WORK_SYNC     = BIT(CT_WORK_SYNC_OFFSET),
>   	CT_WORK_MAX      = BIT(CT_WORK_MAX_OFFSET)
>   };
>   

-- 
Thanks and Regards,
Prateek


