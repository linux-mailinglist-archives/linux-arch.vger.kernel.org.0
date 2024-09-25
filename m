Return-Path: <linux-arch+bounces-7447-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF9898681D
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 23:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE461F257FD
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 21:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DB414D430;
	Wed, 25 Sep 2024 21:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h6Z48oLx"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A417B22EE4;
	Wed, 25 Sep 2024 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727298668; cv=fail; b=Am4+LQmF5FKO2G6qDd3ZFcc9e0L767CLY+37zUIDkKcQPMbMIhN3/0Wi+SAa+ALmNF2ecBQEYgPr1AIXW9e75frIirR8xZzukDQIyl7FzfXfqRkIOCYWN5S0JZPG4ntPrhzjtR1MoGNQgJSWSl2zxiZIMw/Sv39eDGEMqOuMctg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727298668; c=relaxed/simple;
	bh=ssIs9WtPLkYu01Dj+z1Mc0lHQSYIPGLQzn3LK0r2/QY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nmZubnjtzeo37Vd0oyCEeADQhdp7jZcYPsplNXarjctQjsSfiTAN053gDItAUxlL2MGWEp65jgbWO8anyWR2QXWdh94wBvIikBukvO8Vstuv2S7XLkgMJc2ndLtG/vX6ge36KxNAIj8eBB7rOS3RgEXwjGL6Pc9ktxBv5ccRQP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h6Z48oLx; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqT95vw/VV8DqM7+q5RQ6kDVcqMAiEwJReRSupa/k+gLdONpBQdJ2y/3AW7axB8SHameZOsfWdjlVxIYzNAqaHreHmaY9F9tzniJ9wnXWAF+NaLP3JHsCBXkyzHHy1jkmekYqo1N/P2yPFozWn5j1L+uVxF/LdoiBzgh3auZ9vEeImmmXhPvIFpbqIezwOfyjlYfCN7OIiQxAJHxS7szfrt0/ZmQwbnylt6y6+fFwGiGI75GSVBwz13RxfGcgZ22H1N/SYMHL7NjtMJVcE5Bf5QmjtWEXv05+HQH8XGuQi3N3MSEsW1tEvpl/Y7/biiR6Xl+udnyb2sxoX4Dba8ryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0seTHlNHKQRCkaKgJf0QsO+AMWS+fi600xH0eeDjsI=;
 b=VS5xwu3RXucPSM5uqoxfFbbVTpKUyM9XXS179XfKTfjvz61gR88GBCEkvycxDmVJQ3pyOJkxFSXgVqzTzoA8b/z5wZHyZHR09xUU2JkcB0aHrhpWxM9exJhz4ryCF2cRrTbD3lk792bx5lEfgehNxJtq97Giskga75h5UPWdsWeURwf1DziEkpaOvwQCiboUxPnsVSitPD+klPLSXDKUjx6GK0z6UZUC6a4Ez0AnFFME3mmeO+SSsleGm9iEyCcUJElA8lKYor8nQYdAmCwcJZcob50HvTQTH4TW9NaZ5VNOkBYEQCMWYXy3ekKXuyJCKzG/DirZhxPD9s/y9swvig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0seTHlNHKQRCkaKgJf0QsO+AMWS+fi600xH0eeDjsI=;
 b=h6Z48oLxyTskg8BvMmpDA2Eomh1ZNb0XlNtkZW9UttutjmeSvHlMuO41N/vpI4bAu+2QspT6lYEOmybH4l/+K+E6ekA4vKGZyIoHda+WMm/d/w4LWhSY18YifIqOHyerA2eBy8YhFqt25NEiVzW9bIv7JRmi2aLL0jtb2ZzwKDM=
Received: from BN9P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::19)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 21:11:03 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:10a:cafe::3a) by BN9P221CA0014.outlook.office365.com
 (2603:10b6:408:10a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26 via Frontend
 Transport; Wed, 25 Sep 2024 21:11:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.0 via Frontend Transport; Wed, 25 Sep 2024 21:11:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 16:11:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 16:11:02 -0500
Received: from [172.18.112.153] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 25 Sep 2024 16:10:59 -0500
Message-ID: <81fb3f6b-4ded-41d1-be66-d86af4f22171@amd.com>
Date: Wed, 25 Sep 2024 17:10:56 -0400
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/28] x86/pvh: Avoid absolute symbol references in
 .head.text
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
 <20240925150059.3955569-41-ardb+git@google.com>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20240925150059.3955569-41-ardb+git@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: jason.andryuk@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|SA0PR12MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a8b3ce5-d2b6-407b-9a44-08dcdda69057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEJwb29wcWhNT2x0SDFYTTlrdFNpeXNaNG1QcnFKM2hsMDlQS2RMOHNXSWNw?=
 =?utf-8?B?QTZrKzVTaytRaWk2WFU0Z1RHWjJxNkJ3ZGNoeTNtYVBGQXU5TkxNZDJPZWtO?=
 =?utf-8?B?ZXFSNm5xQm50blV0UGpWaUlXQy9XZC9wZXAzL3Avd09mdHZ5MjFGTEZ5czlU?=
 =?utf-8?B?Tmtidk93YjdEc0xScG1qYXJtcUNTNjI5NDlCbmZZWHM2TUxZVE9NK3ZmWFZk?=
 =?utf-8?B?b2crQlBOOFdJa3VUWkZXQkd6T2Yyb2wzTThLbDUxVTJMN205azNmWEQzUzlS?=
 =?utf-8?B?UVluRmtYNXp5eEYwL0c1TXVJb2RXSDAvdjNmTC8ramFpVmVNZGdqY1Nma2RT?=
 =?utf-8?B?WFB5ZExVdDdYd0pJTGtGNGdra2lJMkE4emxBdk9HZTNRR3BwQk5pdk83L1Rl?=
 =?utf-8?B?UVNTNE9Nakc0SDZQZ3crVFNoZjFKZkhjRVoydStBQmQxeDl3RnN3MDFQVXlP?=
 =?utf-8?B?ZEpxbndkZDlqMjY0VzBhUENpQWFlMTlGcTFxNzV4aEJHV1Jnai9jelpOMGRR?=
 =?utf-8?B?eFk2WWh5c3pOTmpYN2ZhVVg5aWhoTVV4Sm5BcWhod3RVOEROWVcwaHcrYWxQ?=
 =?utf-8?B?WGdLZEovZFRjSWx2NFlRdlorclQwdUg5TG9KS3pxTEhkbUFPMGFNeUhhb3d3?=
 =?utf-8?B?bkxxYUpZbkMxcnpJby9hTGpkNnRyVEdHSDczeUlYNUgwYU9HYnF1OHE2emZU?=
 =?utf-8?B?OXpNMEZnVXJjNmpKY3hQbVhMT3Awc3lzVmE0andMbVU4Sld1d2Rqa3VSZGp3?=
 =?utf-8?B?MS9jTk8yVW5NbGVkZU1yZ1BIVTE1UVZ2UlRlL0EwN0VwZ2lySEdqbktHK2M2?=
 =?utf-8?B?bExaZ0pIcHR1OTlIcGNDYTE4ZnFoTGFiR2dqOW1JWXVhdWl3YVNJZDJTeWpR?=
 =?utf-8?B?YzlpaEk3UEszMWw5cUd0RmpOb1ZuMU41N3pHQ28zRVdDNVhaTGFFeS9MbVI1?=
 =?utf-8?B?Z2ZyVTJsYU43cUlkT21scHN5OHVFWUlraSs4OHVFWnRLVzhNL1lxVEJDNTZm?=
 =?utf-8?B?OEdKTmk1dmw0eHM1U0c3QzkxT0ZRL0Y4Uks0T21mc1RsNXB0WjMxdCtnN2ZN?=
 =?utf-8?B?OEpxZU43c2F0UVhnSXlaSGYwZjFrWkNzQ0tOMzFCQnhZYnJYY1VqVmVsN2Ex?=
 =?utf-8?B?ZG9xajlZU0ZpNndCWHI5Z2gyOFF6M3pNODNKcGE4blgrYzA4Wk55eFViN1RT?=
 =?utf-8?B?WndIZ3RGTDhDSWNBYnM3S0toOVd5OWdzY3JlODhFdTFHaGF0RUp5RkcwWVk5?=
 =?utf-8?B?NTNjL3laaFNBUDVFd3hPYVZTajZ2Ykk3OUJBM1I2aHl4bzdYZGlieUp0NDdi?=
 =?utf-8?B?T3dTT25XNHBZbnBsTlMwNzZzWFdUNkVkWWxrTWJCbDFvUkZ4VVNtTzc4cXB4?=
 =?utf-8?B?VUFuVmh0b2FsbzY5dlhXWTBCMS9IMzY4TjVZSTNpZjU1c2NFRVNBUC9OdTFQ?=
 =?utf-8?B?NzFvRjYrTDlrbjFRWWIrTzFvYTVvN2pBOEJacnQ0UkYrQUczUWRONVc1eVp0?=
 =?utf-8?B?aHVwQW5sOU9uWWtJeExZSFlKQU9hVE8rT2dxbUVuRCt4bVFjNmF5VHlGTEhZ?=
 =?utf-8?B?bjQxY0tadnlMb0hYVUlBOG5PZTBMSEdCdDdmTUVSRmRDRXVqamNxRVpjYkRp?=
 =?utf-8?B?aC9BQ0RuUWJ1VzRwTmpmamtNWVJocUxnRkxGajQyZ3M4THl0cUJOQVhtaEFI?=
 =?utf-8?B?UHJ0bWs1bkluR0xVOWJMUnJBMDRibXcwVFN5S05kajZJdE43aWtQS1Qwa2J5?=
 =?utf-8?B?c2JsblY3Um5TY1g3SUgrTWN5bStOdkVpSmxjK3RRaStBUS9XL3ArR3NVcndr?=
 =?utf-8?B?cVp5S0pZTHNBd0lZM2oxOHVRVkFiS2FUWXY1YzFJVnkvOFRCUmhhZjhNdXpJ?=
 =?utf-8?Q?quEuBNmFiQ/hN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 21:11:03.4956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8b3ce5-d2b6-407b-9a44-08dcdda69057
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430

Hi Ard,

On 2024-09-25 11:01, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The .head.text section contains code that may execute from a different
> address than it was linked at. This is fragile, given that the x86 ABI
> can refer to global symbols via absolute or relative references, and the
> toolchain assumes that these are interchangeable, which they are not in
> this particular case.
> 
> In the case of the PVH code, there are some additional complications:
> - the absolute references are in 32-bit code, which get emitted with
>    R_X86_64_32 relocations, and these are not permitted in PIE code;
> - the code in question is not actually relocatable: it can only run
>    correctly from the physical load address specified in the ELF note.
> 
> So rewrite the code to only rely on relative symbol references: these
> are always 32-bits wide, even in 64-bit code, and are resolved by the
> linker at build time.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Juergen queued up my patches to make the PVH entry point position 
independent (5 commits):
https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git/log/?h=linux-next

My commit that corresponds to this patch of yours is:
https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git/commit/?h=linux-next&id=1db29f99edb056d8445876292f53a63459142309

(There are more changes to handle adjusting the page tables.)

Regards,
Jason

