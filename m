Return-Path: <linux-arch+bounces-7448-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E66BA98682E
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 23:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC872850A2
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 21:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354CF15383F;
	Wed, 25 Sep 2024 21:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2a9RFKZc"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893E21D5AD5;
	Wed, 25 Sep 2024 21:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727298780; cv=fail; b=cdwyecU0qn+ldPh6NtovnkRVjShQp+KjJD/Dh5Na25BaqpUaxh0myHBdW17WjNcqJ9fuaXW1GENDQ3Vlxfe/P3JOhWisK0Rut48WtbK4H+b7YyZpbELapAMKyMJ55wLY0cp8qxGT6lODqfT2z73553UOVPts7laa6WPtbhW7paU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727298780; c=relaxed/simple;
	bh=MRuvYRKDuThrJoBb+1lZ4jkgQ3/784bKkbAI2wm0/Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Dag4mShxckhRhQjJLRrgbBoEvKPKvhOie0IOt+LSERee0goXJjTzH0zz6n9IWsXq0l7Gv0bwyrJpRpNqW0bDlCHJi/S3rahM7982A1D01wLrv/FFpyk/6t1vUKc4hUcfPY3s0fb355RessxxqSn+ewGyYURb67rQ8Jqb0TtSPjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2a9RFKZc; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1CyvXCUjXqbEgAD4/VZRask0GCIyWRXPX8KMa9dRa1X0wZbsbM7N1VKSDFgbR/qrwoNDycBljk0q7/Aw7OTsKV1aSWgnkfAN5D9FdTa+Bna55q5b2f/+kFelBDFnwVdntfikLH3n1o5I6bp/+K/P4/lfP/3tyUEXPC3+/RYsXppZHlTva3ElZT3AJC/ztwppWsTyw62b+gf4dfW5CgMuZ5L0JrdUTuNnZSHb5pGLCKUdh1rGNPXSwsgvB1BayxZgor9mLkb+Hj0jvYXb3E9Su6HEDDYWXliExfo7rBvUDmdQskgRnrQEtVbPqSzGtHKaANp5ddM/hcAsJndpFe31g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o27dxBRXuZ+4jCUFs4ZeVgNjzLT5Saz5jMSaDeWCRf8=;
 b=pgrs/TWjc+ozl3mZ8El55t+SYeNu9Cu5IVr1JH9g9x2oSmeaBRjh8jiAyIn2ykphOU58oD6+lF45rW27j/QSg8MQ1ut74cbCLcn5sAusun89oSqeUCoa0M6bxzcZFJ4ZRfSepfSk4DLpK2cbjsX5L1kP8SPp0Q5hPmvkg8XVc2B+/CkS6+A4AGkG/PlXPV/QTDSF1+nnsJ4vVgAxqINq95PSEMxeKGlykynmHoKYLKnrjEotOmRRTK10ZyZrG2v3WITfrufpXpdOMGYV/c1Qlj7rf4OWm8Cb9j0mJvZ8hK1gvRJFMJMAPw9q7C/QcK115T6W/uYO62j6zZujNTLtlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o27dxBRXuZ+4jCUFs4ZeVgNjzLT5Saz5jMSaDeWCRf8=;
 b=2a9RFKZcHtoJY+0jmlCh6qTgIDHBQz+heojripxsqzKlld/FPT2J1lhmmNPem73qIUGZ7796Jj4oghp8dPF3PeXoNQEupd0nl1V7pqsQ51IpNrRYIQY6hB4N7TSAwv3B3nBfT0YhyfmXyLpQMD/8rl2pIF0Eg9H4slLQr1XpWJU=
Received: from BN9P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::10)
 by LV8PR12MB9360.namprd12.prod.outlook.com (2603:10b6:408:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 21:12:55 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:10a:cafe::3e) by BN9P221CA0028.outlook.office365.com
 (2603:10b6:408:10a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26 via Frontend
 Transport; Wed, 25 Sep 2024 21:12:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.0 via Frontend Transport; Wed, 25 Sep 2024 21:12:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 16:12:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 16:12:54 -0500
Received: from [172.18.112.153] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 25 Sep 2024 16:12:51 -0500
Message-ID: <1258d32d-ee54-4a5d-bc92-6c1f8179235a@amd.com>
Date: Wed, 25 Sep 2024 17:12:51 -0400
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/28] x86/pvh: Call C code via the kernel virtual
 mapping
To: Ard Biesheuvel <ardb+git@google.com>, <linux-kernel@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, Dennis Zhou
	<dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter
	<cl@linux.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada
	<masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, Nathan Chancellor
	<nathan@kernel.org>, Keith Packard <keithp@keithp.com>, Justin Stitt
	<justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, "Arnaldo
 Carvalho de Melo" <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	"Jiri Olsa" <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>,
	<linux-doc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<kvm@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
	<linux-efi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-sparse@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
	<llvm@lists.linux.dev>
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-31-ardb+git@google.com>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20240925150059.3955569-31-ardb+git@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: jason.andryuk@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|LV8PR12MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ea1ed0-686e-47fc-1992-08dcdda6d310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHh0aS9xdXBOWkNYSmRtcUEvWUYyanpaQi9sTFNreTBnMmJFUC8yRld0SnlN?=
 =?utf-8?B?RUVrekREVWR3cllESzZHZTVnM21qZVlGWER1dTdTZEt6d1JUU2ZBQ1JxcWE4?=
 =?utf-8?B?aW5XbDJzM3NZRUN6anRYR2xIZkI4R29QSXdmTmRKb0U4ZGRpS0NqZVd5Ny9T?=
 =?utf-8?B?dnZxaVI5dmFaeXRORmc1YzhncWllZDZJcWNpQmpPSkc3aGUzeVV1UnBoemxE?=
 =?utf-8?B?RTNaSjNESStZV011TE1aRTluUjNjMHNzeWlOdG12VXF2dUJEUS9KUEFHM2Ex?=
 =?utf-8?B?WkJ5M2pud1RsdGE5UXVXRndXK2NyT1I3U0xJR016VHRCWkU0cmM0OVdhTVJO?=
 =?utf-8?B?U1hIRWtSMFZ4R29MbTlOT2c2aXZqWDk1V2hUTkNuZlBSMVVsTFZWemo4c3dx?=
 =?utf-8?B?VFV2SWJlRnBJWUY5aFJtMzJmZDVISVJwUlBEaTE1TDlEb0dwdEdpeDZ2b3Rq?=
 =?utf-8?B?aDdzeU5CTWYxYytEWGVFNkx5SlRDN3BHOE9wV2VHZ3lOTENtOVAyQ0FTNWgr?=
 =?utf-8?B?ekVxMjZ0TllDOVBTaHRjTFE3V3VlSHJyWVRDSkI5R1A5elBESm8rZGFsWkE3?=
 =?utf-8?B?SG5IWmFJZ1dJVXlNMStvVnFKZnA0alVxVitHOWhhOWVFL3Y4M1BsSkV3UW1k?=
 =?utf-8?B?QWxRNWdZZjhIbE1yTzE5ZGFTNy9EcjZOS083cWVmTllSV09yWUZWZTZvWEYy?=
 =?utf-8?B?WTZibGFiMXNrQVY0UTA4SGhRVDlqemV4SjlNd2JSYnNMdHo0VnRlczhNd3ZE?=
 =?utf-8?B?Tlh1b3htTTg1d2JtMDhVejRDYWJnbThTUHRycEFCWlJmb2drcS9YbGtQL0c3?=
 =?utf-8?B?MldyTHVYMUZwQ0FBaGw4TlYrL0dDQVhSdnVwYVBIUHltYXhSUnFvem1EQ055?=
 =?utf-8?B?bG04RlBiaXMwNGMzR1lrRURPK2UwYjV4ZHZIVXMrenBtS29rR094Qk5sS2Vl?=
 =?utf-8?B?eWlWLzQxZHlFcnlVY3gyRXZNSGVSODlwSzF4alM1eFRWeFBrOUJBOXc1QTBB?=
 =?utf-8?B?MEs1SWQwc1NjRmFuSHFRa0ZiVkpnVDJiRVBwRlNrTDl1bVcyRFpaT3U5b3pm?=
 =?utf-8?B?SzR4ZTl5WFRmZngrRUFxRHdwQkExK1AxaG9sNkQ2L0NJNGJ5NXhkSzNSNGR4?=
 =?utf-8?B?d1dkNVd0NjQ1eTVlTWE0dHkveDRBZi9LQmR6dkpTZU1JNjAzOXNjR3dpT0NI?=
 =?utf-8?B?b05Pcmw5ZXVWaGdPcWpzV1NONXN6bzROekF0UnVxbEFSTmRrZFowK2U5QSts?=
 =?utf-8?B?ZVlUR2R4SEJGUVgyODg1WlN3U0ltSnNFVWZWcnY2OXcyODhweWlsc3cwVFFw?=
 =?utf-8?B?K1RlZ3hrUzRST2VnUDJoMTYxT0VCODlTN0dwenFMV0V3R21ndzBNOU5ZNEh5?=
 =?utf-8?B?YjlyaHIvTXZraXo0S3o0WStzd3VyeElsRGJiVExkU1Jyc3REK29Va25aUVhy?=
 =?utf-8?B?UTVpYjhkQkRJTy9hNnA4SHQzSlFzSkwrd21SUndaVVJNNmFjVWhRR2tNb0FT?=
 =?utf-8?B?a2FzWnRXT1BvbUVtUkljVGxXMlJVd0pkTWtITFZKMXFCdHJFWE5lcGE4ZGtG?=
 =?utf-8?B?QTAvWTRrVjNCVTY1bFFtcE1ialpvRCsvVUNPTG4yQTc1T1BKRXNqeWNJTEZI?=
 =?utf-8?B?QkswK0VGWEh1cUk3WGFKTmJ0eG5jWFNQbFk2R1NlUXFDOEJueW9YT2lmUVht?=
 =?utf-8?B?NHNIYlJtTjZUcndCMnJ6NVpjb283b1RpTXJkcU5yNGw5TE53SnJjbjNXSnVX?=
 =?utf-8?B?Y1lYdlpacVFEdE9DSmxSam53d3dzYWpOK2didlptL0p2YTF3V3ZwQlg0MmJD?=
 =?utf-8?Q?mAG5gbbmFUCO6ntA+6BmX721jACkTf9uoy1CE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 21:12:55.4187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ea1ed0-686e-47fc-1992-08dcdda6d310
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9360

On 2024-09-25 11:01, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Calling C code via a different mapping than it was linked at is
> problematic, because the compiler assumes that RIP-relative and absolute
> symbol references are interchangeable. GCC in particular may use
> RIP-relative per-CPU variable references even when not using -fpic.
> 
> So call xen_prepare_pvh() via its kernel virtual mapping on x86_64, so
> that those RIP-relative references produce the correct values. This
> matches the pre-existing behavior for i386, which also invokes
> xen_prepare_pvh() via the kernel virtual mapping before invoking
> startup_32 with paging disabled again.
> 
> Fixes: 7243b93345f7 ("xen/pvh: Bootstrap PVH guest")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Tested-by: Jason Andryuk <jason.andryuk@amd.com>
Reviewed-by: Jason Andryuk <jason.andryuk@amd.com>

I found that before this change xen_prepare_pvh() would call through 
some pv_ops function pointers into the kernel virtual mapping.

Regards,
Jason

