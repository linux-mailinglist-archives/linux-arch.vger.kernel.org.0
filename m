Return-Path: <linux-arch+bounces-7451-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C272A98693A
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2024 00:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E001F25804
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 22:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0CB1607AC;
	Wed, 25 Sep 2024 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WNoVklUE"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220B815C133;
	Wed, 25 Sep 2024 22:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727304058; cv=fail; b=fIJfIvloeIj5KeCPQ1/p5lN5TTg1VP8gCQ2+OPoZ2TuT2YmWXJACHvomtzVQoRZVXs8tMB2Gjq2q/kRB3YzC3/thJcdxXFLJ/Kjx63qhoCkhEHRGf/PfyGLlVk+aZdK+Ln+z9xrqUJt2w5yk35CYATkZR7bVOYWATpCL5o9be/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727304058; c=relaxed/simple;
	bh=wFDAI4i4iEu9knLRlPvDBBnFMufgUtxiF8a51eS84VI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xzn+Nou4dwOm+TFNnDMpasyH5EqEJ12/3SLvDnyuF9BdfTEFXgn3PADHhNnm3VLnN7MaCplll8rMPd9zJl2AkYzU6ox89XgiGjUhfTFDBesh0fzC1njDYC30jJVGEG8ZJtECaCn7z4bmr5eYSVpx6YlSHCg5x6LT9lMt4xAycEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WNoVklUE; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ry0DGXR+EbMbYoHA6Mbzfa4BFhL5j29lMBn3la5tl430ZuFU3UfGD6ED8tVIJG1HEz8qsYaSmBxzzuksS9+z2ejCHRDGH286AH9xoLE8eSBaqaUrKnHhnEi91LxP6WUYQTPrsKzkV7PqUf4GcKms2hcP56m1yVb6SCXCcy7AkJj0efm19AYRTFp89Qy8gjd2h5a7SnzYRRntmi4BstmDHSoPylVbAridFhEeUQ7r4EccQ9LMsZJK2bHiY6ZT9qr2YvEqZmY5AHZQ9NUsdl+udh7Bfk0krOzkvPjXmS6A1mFl7eT4lPFTTmNd2DEG9KP5QJKi9pgLVW97v5A1eTIUjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rl6AKP923I8dkv2kMMrFSBC2YeHH2GTEwv2onPaCH38=;
 b=qk9QYaHVs+kLDPGzmz0lmpa3O/I07Cdg2udMH/mdAWic7PqnIFSmxNwZk9HiogHrRe64pTJ/asSVy13wvCrg6c7jV2NIt1EYW63CjP2iceUIGWZBIvwhfQDIfyfZLvQqioFELqfgZ73xcvB10yeT3l5q3D/K8llsNcu9ESxugmEYafElK29jgQYR3804nPUXbSf+5knqVq985jVfmRYhgM0/VrtCprigEoVQzY4Xu+fMUGizdQRE4zuzwacJCpjS1itasBzJsI575Y8i4VfD8KPlOLeWGQLkdV23WM+wgX4AIbyvWlkhKcFx/sPMH0VVsMXj5PNXTJiPxFWueyGMMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rl6AKP923I8dkv2kMMrFSBC2YeHH2GTEwv2onPaCH38=;
 b=WNoVklUEqHW9BB0KQS8C/L+aVcvX/Yjl9oLM7DQjq2LBgjBGWz1GnkNgrT6FTZNG8C8EDJQVDrmXlC3VbsG8kOhUCJLdYU1gFuPeiAB4OX1AX2XS333S3lIQeDysxD5tQ2Fdy4sT15LEvW/ak1Svw9MPh0Xk9Ux29B3CiEq6KMc=
Received: from CH0PR07CA0015.namprd07.prod.outlook.com (2603:10b6:610:32::20)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 22:40:53 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:32:cafe::d5) by CH0PR07CA0015.outlook.office365.com
 (2603:10b6:610:32::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Wed, 25 Sep 2024 22:40:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.0 via Frontend Transport; Wed, 25 Sep 2024 22:40:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 17:40:53 -0500
Received: from [172.18.112.153] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 25 Sep 2024 17:40:49 -0500
Message-ID: <b626206f-d730-4d28-a2e8-dfbb908c7c1f@amd.com>
Date: Wed, 25 Sep 2024 18:40:49 -0400
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/28] x86/pvh: Avoid absolute symbol references in
 .head.text
To: Ard Biesheuvel <ardb@kernel.org>
CC: Ard Biesheuvel <ardb+git@google.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Uros Bizjak
	<ubizjak@gmail.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo
	<tj@kernel.org>, Christoph Lameter <cl@linux.com>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, Vitaly
 Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada
	<masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, Nathan Chancellor
	<nathan@kernel.org>, Keith Packard <keithp@keithp.com>, Justin Stitt
	<justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>,
	<linux-doc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<kvm@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
	<linux-efi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-sparse@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
	<llvm@lists.linux.dev>
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-41-ardb+git@google.com>
 <81fb3f6b-4ded-41d1-be66-d86af4f22171@amd.com>
 <CAMj1kXGj25bn2R9vWPqG5+SSSjJp6rzopssDbjk8uOvi=cAiUw@mail.gmail.com>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <CAMj1kXGj25bn2R9vWPqG5+SSSjJp6rzopssDbjk8uOvi=cAiUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: jason.andryuk@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: b0926808-4162-42a9-1582-08dcddb31d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVFxT1ZMb01IcG9zNE51UkNoSE5Rd2dmLzIvN3k2eldBTVVCUGZ6WFFudEpI?=
 =?utf-8?B?dWJRU0J4MEpRWnZkZ1I5Y3hDcFZDWDRGLytUOFNOYVhtd1BFS1dNa05qdTBZ?=
 =?utf-8?B?a1o4WHVJS2V5YW95RENybGpHeFVuaWxIY1ltaGNRam5VL1EzTGRwMmxYUjlJ?=
 =?utf-8?B?aGFRaG4xdGdET0JkL2tSQlRlLy9qa3JKZ2pRamRPeWhRT3g4THhkd1RsVXky?=
 =?utf-8?B?dS9vNHg3QUlRRDlYbmhqRHQxdDk5K2VmQ0Y0czBJZiszOWVTbzlxSEFXZHpO?=
 =?utf-8?B?ZzA1TTdYcU5XRmlSdDNtQjlqMG4zd2YwaGlSM2FiWStxTzdWTC81SXdETDE2?=
 =?utf-8?B?NW85S3EvZURlNERTa2EzM1RKRHp6YXVaejNrclZEM2dzMTZWRFdYT1lFRThV?=
 =?utf-8?B?Z210aTVaaGtrVml4VXVnRFhtNmcydDBKZm5yS2NnU05RSmlTc2tpa2Fmc3NR?=
 =?utf-8?B?UnlOUGRKMm43NkJZUGFTWVNuaTAwdFU0c3hNdWNyMnFhVUlCcVNUWS9ZYVBs?=
 =?utf-8?B?cUtWNE81QUlOYTZpUUthUitiWk1RbDlFbExteklBaHF1MGVYcHVLWC8yeDVV?=
 =?utf-8?B?U21rKzM5R2JQSDhXRGNmWmduQnJCYThFYlZ1dVhmSW9JWkJRTTF0MHdMampV?=
 =?utf-8?B?MHFFcUlYa0MyWjUwSmRVSWJ0NTlWTnRSc0M1MVZ2RlRDTnJqSzQ2bHhXODJp?=
 =?utf-8?B?MDg1dlVqZkVNSXd0bjZJMUVKOEkxMllzUlBmdlNOUStxLzZVRnkyUVJFdXdG?=
 =?utf-8?B?STg4UEJIQkhuazZxbjhETXplRUd2dE1ZNStaUVRxN05DMTR2MmxSOUVmUUhm?=
 =?utf-8?B?ZmljeURwQ0x0NnI0ZldvS3pTSFNCWXN5QjczbzhUWVNmM25jUWpPNlZCSkxx?=
 =?utf-8?B?aG1ua0RXa1JYa0RjTis1TGpsVkR5d09LUTBQQTBTeU50czljczhlTS9KY1pN?=
 =?utf-8?B?ZTk3Und5NXZQQ3M0Q2Z2MDBZY291ekp1dTFJQ2ErU0dzZjBqai9nTXpXYkZU?=
 =?utf-8?B?MG5GT2p1YVR0ZERUVDNCbTYvU1B5N2JoZG1UcWRuOUZTNTloZEZRMDIzK1RM?=
 =?utf-8?B?U3gxUFkzNFFBVFZhTXdwdGVrakpucEFkYXg2cWxaR21UL0JMekVqTUxLc3Jl?=
 =?utf-8?B?b05kYTBlUkp4MU4rTVhTWGdjSGxBK3VVeFAxSjJPZFRZVjBrbmwvS1VucXBw?=
 =?utf-8?B?V0pzU0pwcFA0YjlGcTRlZ0x4TEtKNEJ1a0FtTDlyd1E1WWpjQnF5dEF2RFdy?=
 =?utf-8?B?WkE0aGFRemtJaCtVc2JiMWxTc2YrMnFmVTZhMUdIWml4b1c2ZkIvcHJOclcw?=
 =?utf-8?B?L0k2ZkNYTHJjS0FMZk4rZ2p2cEo4V0tKM3I4Nlp1dEV4Q0pxUG5lQjU4bW1T?=
 =?utf-8?B?UjdBYlNvQlZEL3JkdVVsMjg1NkF0cHJ5VDZkdW42RkFtUkg3Q1ZLNFg2RlA3?=
 =?utf-8?B?S2VOdkV0bWxJTjA5NTBOalcyRDlPNXJ4cjdsakExbXNMTnhUK0R5ZnBVSkhz?=
 =?utf-8?B?RkpWcWdZVkUwK1hCSVBpYlljaytYckJXdzZSUnQ2Y2pyOEdpSUd2cXVzMUpY?=
 =?utf-8?B?Rkl2aFB1TGtMa012NFZxRStTVnFLYUVMRUJENTJTejZzK3lEc0JsNjhZVUtX?=
 =?utf-8?B?cTFmN1JYdVZvMVhSbUl0WE42ZGs4Y3hnZVdkYnovVFJTZUVGWGpCdE9UTzh6?=
 =?utf-8?B?dDJYeVVuMGJVTTFCVHRNZHM0WncwRlVWRkVpeHlDRXFBM1M5LzVZbzZBVy9h?=
 =?utf-8?B?UC9xaGZqQlF1LzFjd2V2aW1RTVVOemYyME45RGdTQnFEZTBlbmFsMDhCSlpM?=
 =?utf-8?B?VlJ0Qm9NYzI1ZjRST3JySFp2amJIcVdQQUlWblNXc1o4U0l0U2JHczA2VVh3?=
 =?utf-8?Q?xASx6xq1GoepA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 22:40:53.6316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0926808-4162-42a9-1582-08dcddb31d1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783

On 2024-09-25 17:50, Ard Biesheuvel wrote:
> On Wed, 25 Sept 2024 at 23:11, Jason Andryuk <jason.andryuk@amd.com> wrote:
>>
>> Hi Ard,
>>
>> On 2024-09-25 11:01, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> The .head.text section contains code that may execute from a different
>>> address than it was linked at. This is fragile, given that the x86 ABI
>>> can refer to global symbols via absolute or relative references, and the
>>> toolchain assumes that these are interchangeable, which they are not in
>>> this particular case.
>>>
>>> In the case of the PVH code, there are some additional complications:
>>> - the absolute references are in 32-bit code, which get emitted with
>>>     R_X86_64_32 relocations, and these are not permitted in PIE code;
>>> - the code in question is not actually relocatable: it can only run
>>>     correctly from the physical load address specified in the ELF note.
>>>
>>> So rewrite the code to only rely on relative symbol references: these
>>> are always 32-bits wide, even in 64-bit code, and are resolved by the
>>> linker at build time.
>>>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>
>> Juergen queued up my patches to make the PVH entry point position
>> independent (5 commits):
>> https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git/log/?h=linux-next
>>
>> My commit that corresponds to this patch of yours is:
>> https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git/commit/?h=linux-next&id=1db29f99edb056d8445876292f53a63459142309
>>
>> (There are more changes to handle adjusting the page tables.)
>>
> 
> Thanks for the head's up. Those changes look quite similar, so I guess
> I should just rebase my stuff onto the xen tree.
> 
> The only thing that I would like to keep from my version is
> 
> + lea (gdt - pvh_start_xen)(%ebp), %eax

If you rebase on top of the xen tree, using rva() would match the rest 
of the code:

	lea rva(gdt)(%ebp), %eax

> + add %eax, 2(%eax)
> + lgdt (%eax)
> 
> and
> 
> - .word gdt_end - gdt_start
> - .long _pa(gdt_start)
> + .word gdt_end - gdt_start - 1
> + .long gdt_start - gdt
> 
> The first line is a bugfix, btw, so perhaps I should send that out
> separately. But my series relies on all 32-bit absolute symbol
> references being removed, since the linker rejects those when running
> in PIE mode, and so the second line is needed to get rid of the _pa()
> there.

Sounds good.

Regards,
Jason

