Return-Path: <linux-arch+bounces-10222-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1516A3C5B1
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 18:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208363A48CE
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 17:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE73214228;
	Wed, 19 Feb 2025 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PcIAafat"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDA22862B2;
	Wed, 19 Feb 2025 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739984944; cv=fail; b=t16b+Ph+UjlCsfe6ROiGWZ6M2Yn0uNFdhKN3LpDP5PuOTUbWffXsKzov49gPPtiNihcp7DXLq1DQ/waWTlrQKFhDU3aaWt/nm5txsTv/oJgOcQkP9hY/UjsxikhW9TMLFg1fhxK+nhpnmMpHcG8jyXt+a1FL2/9KPT4aClJfJ2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739984944; c=relaxed/simple;
	bh=+g2iqS7gxNKDGKjCrOh+NNsr62KDCK8zIhbL9qRQS/Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p/f3DfQaQgH/1pRtmiDfwVZyBkMU9CrWrAkuBf9XP4Y0HsUsd4ZczHrnq7l2rwy3oJnXuOQ9U2UCnqVGm16+RtYFBbqE+O6T8u+CNrkSSX42xTrqqf56hLUqYcu2DGjYzdWUKTmMbqLsioNRMg7X6zt1BGadEWPNg6hMMJ5Ag54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PcIAafat; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhEdIPwfVVwAv8rljE8SxK8GW9KWf0SLx+k1Yn8U8cDXV8zeGOUUU5tiNKVjgg1im51ajVrsgK1lw5HDQ7ApHqBRc2gSG8qUMLqoQlqyRffnEoj8mXBqmoGzJLMDQQCa6zaSekZvP3CqkGX2gPWdtVB1hT+bAAwHeDDONArQwRjyPcFlweGRVtPi/+Qqx3IogTAMBg8jwqvJnwyKWF1h8vEKv+txXbtm7R7sNSpHxRM41zO22FUXtvJgBD23CQuImxa2KUG2xq13ddf/IXJg/okpgJQR+ijxU+ReYVS1DQr8XrcuXPwZoCapH8VGBrgafh8ZDp/kcWwHuDoraIGd2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a71Dy6govVGCK2C4BT/D2qhMEQcwf3/MOIxsWp/NsjE=;
 b=ZyNNOM9ElvZfPFNfglEQUOLEegGiaH0XlWpv0OZPZQ1Sc6pvMYswZhpVwv80xJ8mjSIBNb/k45oJK8AOjVtPrah5tH4PF6LHFREP2MgdmYv8sEXM5KGmLK8jsuMq7algEPRCagJ9wMMIoQazxHPd8Jvrpp+8B1rqa1pdBgAGLGG8l8BJ9v7crWkZafi84w6x/B9445QOc9X0raz37WXC+hS5moRF9OFAfZH1aSIoLrZ7TSOsCwXrF4ulnOu8FKeecs2oJ3CLITctkeu20TqnlL68CzS00uQxbT4644000YHBS6NanS15d/lC4xS5N3KkVyfirIXXyd2RG4JIatEOrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a71Dy6govVGCK2C4BT/D2qhMEQcwf3/MOIxsWp/NsjE=;
 b=PcIAafatks0d49krke/tF/+jeCas3jCRsBx7ZdOOv99wpQS3m7JPCMdX6AeZcmSmd6M5OqFtJycPBC3rAKhQ/pBItJ3vIiGxMy8IjORfam7Lr0RvGAWJExJ+b8utfvQ3HW5pJRBSD6KSTBsCqme/JQ3FyiHLru7hOL4w48kttrDYwYbvZNB4qzpxVsuKsLkEwBU1P9Hmkzgi6DlW395Es/7/MJKBGP7zpBBHcFhp7kk1Uf59UkIMbgKJ7z63TRAFu+XTHgJ76TGBE93owMAb7QCq3cvg1MvXH7+to3aOWvZK+cDWnvohzJmegzgq9DAaDxBwAQuhpCn2aQ4SkrbD7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SN7PR12MB8791.namprd12.prod.outlook.com (2603:10b6:806:32a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 17:08:58 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 17:08:58 +0000
Message-ID: <adcf012e-57ef-4b54-8b19-2273aca41ec6@nvidia.com>
Date: Wed, 19 Feb 2025 12:08:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer
 flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
To: Valentin Schneider <vschneid@redhat.com>
Cc: Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, rcu@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, Juergen Gross <jgross@suse.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.amakhalov@broadcom.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Jason Baron <jbaron@akamai.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Juri Lelli <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>,
 Yair Podemsky <ypodemsk@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>, Shuah Khan <shuah@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>, Rong Xu <xur@google.com>,
 Nicolas Saenz Julienne <nsaenzju@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Yosry Ahmed <yosryahmed@google.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Jinghao Jia <jinghao7@illinois.edu>, Luis Chamberlain <mcgrof@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Tiezhu Yang <yangtiezhu@loongson.cn>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez3H8OVP1GxBLdmFgusvT1gQhwu2SiXbgi8T9uuCYVK52w@mail.gmail.com>
 <xhsmhzfjpfkky.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250219145302.GA480110@joelnvbox>
 <xhsmhecztj4c9.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <xhsmhecztj4c9.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0508.namprd03.prod.outlook.com
 (2603:10b6:408:130::33) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SN7PR12MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a04553-16df-484a-fc0e-08dd51081954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTNROEVvZVFZU21NZ3RVS2lMaFNFN09ZUjVnZlZkWG1WL2QybGxkNzNqNzRC?=
 =?utf-8?B?UjlwVkFYS29uQU9sM1BzSlVaWk5kdWJZYWNKK2xwL1BhYUV0RThGVVBvOWly?=
 =?utf-8?B?WjgxbEEreit4aDJQSEx5VG5YMEh2aHpVU3FTK3JKZGZ1a1RDWFA5QTIwTzdy?=
 =?utf-8?B?d2w0eklQTnBUQkhwRHN0QWxCZTd1TFRTWlJCbUVKdDJnN1dwbzRyanFaSW9X?=
 =?utf-8?B?cUlxWlIzdUZUdHU1dlQ4MU5YQStLRE9CK3BtdGZzZG9TTXhxVFJLUzg5TGRm?=
 =?utf-8?B?cWFBeGJrLzEyL2FlSDU0TVZGdlpIYitCS2RlWCt5L0I4VXQ2VW5TY243UVZh?=
 =?utf-8?B?dFF5VlpWdTkwN0U4Qzc1MStEMkV2cnUvM29MNldnK25DazNkZ3RXYm5nOVAv?=
 =?utf-8?B?TjBhbHphUWhlR0YxRm5kV0VIMXRaMUNoUHJjWENpMjUvQmo4S2xOelRqaFkv?=
 =?utf-8?B?dnhqWlZ2QW9CYXZtTHVyWmR5a0hkeVAyVE1Bdm4rZlRYSGUyZndndTJheEQ0?=
 =?utf-8?B?MFRGamNjU0hISDcxSW5YZllsdEM1NktUdG9SZnFxT2t2ZG9MUzVyL1J2WlU3?=
 =?utf-8?B?WkZFYkxzY3lSNEdqLzFjaXZZWlk2OHlVZ1dkTm5nZzluSHZHZWc2Mkk2NXpH?=
 =?utf-8?B?TkFCcEZ1TldVaWtrNnZ3TlJrWDhkTkpLeG9tYTBSaVpydSt5c2lTVHAxeUg1?=
 =?utf-8?B?N2hUc2JWZ24rakw1L1RsZlZDVHVzeEs4c1c1MDk2Z0lTSEQybjh4OE1CRytp?=
 =?utf-8?B?S0NPSXJIQjJiaTFrSUJmQ29NaC84WXlwQ1ZTbTVXYXdhRmVTVGpVR0NnRk1q?=
 =?utf-8?B?WFBPb2RWMlZUWDlWTWwydUZkaTZuc2JhZjRuWkpOM0J4RzhyckdUUWNGYm5B?=
 =?utf-8?B?VXZFWkUxK3Z4WDQzNkJidWlDTHdHSWRscHBsR0NsZ25MWi9IZmY5bkxkQzhF?=
 =?utf-8?B?QW9hcGd2SDNxTVFSWlBRZnJZekNwZVVZd3cvdzg1aTlTVHViM0U3RkJiR0xy?=
 =?utf-8?B?SEcyY1VYaW9YN0R1R0VNaHlZb01WTjhxcitQUkFLbk9wL1VhUkF4MUVCc2N3?=
 =?utf-8?B?UjdSdFR4RHMwbjk3RlZveG5HcVMwZGxuMUYybVc0ZTBYU0Z4OVRGN255T0dK?=
 =?utf-8?B?OTB6Mjd5T1pnRk9mWFlHN0lsR0swc3FsL1BsZTZmUkg2MHU0cjZJMVZnTVl0?=
 =?utf-8?B?QXBwSDhkWFNSVklhUzlYZEVtMEN3ZWF0ZHFSNVhUZmY0bVpXV3M2RXVJR2ds?=
 =?utf-8?B?aG15Qk5yK2FCZlFhWUxnaUNuYmVYKzY4R3UyVmMzT1lRL3dSeXJMWU12SmlX?=
 =?utf-8?B?M3ZGSGZLMTdnZTJ0eVNrWUpqa3ppY21WK0Z5UXdsTkFQSk8vVGxVZFNXN0Yy?=
 =?utf-8?B?TW15ZSsraHlFZ2lWSmVFT0JHbVR0Y3lVVmpNMmRFVmFDN2R0emRHYWdNUDJl?=
 =?utf-8?B?NElwcXZWRjJjREQxL05sWFVZejA3cWN0WVhka2Y3bkd0c2lUZkpmZ0JuYnJt?=
 =?utf-8?B?RFYya21sL1hVOHAySFFxWWxDdTJXWllJblRXb3N1SU14MTZNcndXYmgwMFRy?=
 =?utf-8?B?aUNIQ1R6MktvMG9XOUdGTnBGOForSXlrSWRSTmNyaDJUMm9mU3JzelVhYi9u?=
 =?utf-8?B?d3hPaS93Ym1CZXluQ0NRNUkyOURPbDBHTjhKcnNDRjlGOHBqajdtNk5FRGVU?=
 =?utf-8?B?WW5qSkNZVG5md1hGNGEwVHhIKzREUnVWOHh2RXZEQjN0bEpiZVhOV0NPeVV0?=
 =?utf-8?B?NDk0OHJLS3ZHYVZwb1FxUzFtVjJMMGlpbnNhVnRDVmk4YUowMGFIQVk4ODRu?=
 =?utf-8?B?cjliVzlud3JvWVhrZUUwTm01bXh1cFJwR2FKTDJYWk9zb3dxVkFKQmRObDdk?=
 =?utf-8?Q?QK2simDBBEOC0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S09NWnJEbEZxTVZYemVXN1lxNGFGbjMreUhlWW5sdSs4VmQzR25ZemM5MGpk?=
 =?utf-8?B?dnljRjg1azhEKytSZkg4eFRLYVJsbXNxcjRPZXdRRnhEczVyYTNJay8wSFZa?=
 =?utf-8?B?cXV5Q2EyeFVQc0VLMXJkOVlOV3BiWFFYUkgrdHdxbTRZc2V3aDdZbER5a3Jo?=
 =?utf-8?B?RSt3ZVcyM0x5aWNMZm1HaHNNcGU3ZFNEM0xBSzFmUEtQS1hEU0dOYk5GNUto?=
 =?utf-8?B?ZzIwaS9xajBVK0dKQTU5aERiamVGTVFWdUpKWWZEMVJ0VWZJemVzcmZHN25k?=
 =?utf-8?B?TlNNZnAxYUNmcDlFblhjMUpSUnRITHBWZ1cwSXlsTXYwZnViUWhQcjQ1N3pT?=
 =?utf-8?B?S2tkZjl2aGIxMk1PZlFQZngwa2FxWkl5L1kzNjh5Nm42UU5wU2wxQnhYLy9v?=
 =?utf-8?B?ZTdUT2pxWkQwTDg2S3M3WWRFaGUyRlF4aE82d0ZqTWY5Rmhkc1hHZnhHVEJE?=
 =?utf-8?B?WmNJSGRpOXduNnRBeVI2RTYyb2ZPUDVsRE04Rkp4L2xxV0ZVRi93b2h1QURi?=
 =?utf-8?B?ZUFLWEJwR2FzdHAwZEVRa2o2TUJkL1NWZjJZMEFua2VFMkFsQy80bVBVN21Z?=
 =?utf-8?B?K0hQRis4UEJ4M1dNSGRlSFI5M29UM2VqcExFMFFXOENjbkFaN0kzeEFVd0tO?=
 =?utf-8?B?Y1JLMWZSWWppc1BkZmtGdVNxL0VOZmlNdWZlampoM0ZhNURCeU1BOFZ4OGli?=
 =?utf-8?B?eUQvVjRaYkRRbGxGM3NLRytoaTNpWWE2MmExdkFEQkk1RVp1MitxSndPM3Rv?=
 =?utf-8?B?eUIvSWF5S0d2c1VDNTdBbGp1RkgxTnoxUm56ZWJVaEdEVFYxSmZmV3F5aiti?=
 =?utf-8?B?RERVT2xzTnZhVG9RaGh6NjVCVlFPd0hHckhybzR2QmRTMzZOcllzZ09vanlw?=
 =?utf-8?B?T2dGck1jYkZWSzNJQ0lFZzVudnBDY200eGxpTi9uQUlyeXJZWFJIRVBWVVBH?=
 =?utf-8?B?a3JMSlNhTEo3NjdwYWlsMVVvRkZvSkdOMHMyakVGVzU4aXVtZnFCRWVVdzBZ?=
 =?utf-8?B?WHRWNVpaaFRZZDZuR21DUEM5c2tzUzE4Nklwa0FRN0E2ckd6YmhWK09OdHFk?=
 =?utf-8?B?bFh0NnZpSDkzZWFGakRHeURZUkNsVVhiRzhaZWtnTFo5aC8xSGJ1OVdIdW5j?=
 =?utf-8?B?VWdpZ0hhcVcwSFY2YjRaTUJ5TWN6MjBGSzFhRDJiaStjdGdqanZwYWF3eFYx?=
 =?utf-8?B?Y0NQUjNxN2Z3dWZGUTQyYzdGUkFLUXU5VTRoYXRxcHFuTGVOK3hSMVdEcS83?=
 =?utf-8?B?dzUxUS82T1pCWDg1WkZQSG5WN2pxbS91SWpMelZIT0MvMGF1NU9oSjZuMXhR?=
 =?utf-8?B?K2JMWDBSaTJEVlNKQlovK2l1M09sV2pZNzZpM1NubDdSSmNMcFRkWGNtZlRV?=
 =?utf-8?B?OEVreTRtZVNIVTc1OE9nay9aSkYxV0NiUGxKZjNkR0hYN1VLMUtuVzJWZ3E4?=
 =?utf-8?B?Q3NRRFRycXpGOGtYNm9VeXdJQVFKdUdNd1FJVkQ3dGtjaWs4cndNckVPYkNt?=
 =?utf-8?B?dzI5T3RaNzZFc0ZVQk1ZY1VLYThMcWgrVkkrRkFwYjhDTFZqQVZiaWhWdkdo?=
 =?utf-8?B?SDd3a1JPdHM4MWFJcGNjMXdzVzBQVXRuVHVCY29Fa2VBSzlTQW1nUWhSTHZT?=
 =?utf-8?B?Ymh2dHBYR1MxTFY3dmF1YysyOHM1eWt0WkxUaUpoVW9yVUdaei9ZNFdQWXdp?=
 =?utf-8?B?VWZET0YvWmwyOUY1WVV4ekg5alFsQmZGeTVtZ1AwM2lhSjhvcVNFR0N5UThS?=
 =?utf-8?B?VkgrNHBEd0NTaUZnRjk2VHlZRFpiSTEvK3U2ZGZZc1Y5RVo3dFRyREZyV1Uy?=
 =?utf-8?B?dUlhWTZDTm1HRXdXaitkODlBVnpMT2d0dWpUUnVDbmhtTGNGQXE4RXJLTGhX?=
 =?utf-8?B?VWROUTloQytWcERsaXVlb2srLzVqMlppajNyK2F4UUZLWGxQMWJmbXM2NlFG?=
 =?utf-8?B?L2M0K1A1UTRhdlBad1RYNEZBdFZDcGZ1RUhMZGFoT3BXNnBGRU8rSEx0bFJP?=
 =?utf-8?B?K0V2eGRBQlFialVhRTdVenZYNjkwMTl4WmRQUE42cnEzZWI4b245R0tlbnlq?=
 =?utf-8?B?ekRUL25ZRk82aitQb1BrLzB3bm05OHN0UE8yYS9Rdi81bDFrZlhpKzNDV3ps?=
 =?utf-8?Q?bxxoboLhp81jX5XyI3OZ92N8h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a04553-16df-484a-fc0e-08dd51081954
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 17:08:58.5442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtOCbLN5mBwxeNT2wo6/ysIHFlRbIu1bJHIYLN+BTf6uBnYzMazev/cV31RgYeIC7NTsOki1riW1f1/ghuRh1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8791



On 2/19/2025 11:18 AM, Valentin Schneider wrote:
> On 19/02/25 10:05, Joel Fernandes wrote:
>> On Fri, Jan 17, 2025 at 05:53:33PM +0100, Valentin Schneider wrote:
>>> On 17/01/25 16:52, Jann Horn wrote:
>>>> On Fri, Jan 17, 2025 at 4:25 PM Valentin Schneider <vschneid@redhat.com> wrote:
>>>>> On 14/01/25 19:16, Jann Horn wrote:
>>>>>> On Tue, Jan 14, 2025 at 6:51 PM Valentin Schneider <vschneid@redhat.com> wrote:
>>>>>>> vunmap()'s issued from housekeeping CPUs are a relatively common source of
>>>>>>> interference for isolated NOHZ_FULL CPUs, as they are hit by the
>>>>>>> flush_tlb_kernel_range() IPIs.
>>>>>>>
>>>>>>> Given that CPUs executing in userspace do not access data in the vmalloc
>>>>>>> range, these IPIs could be deferred until their next kernel entry.
>>>>>>>
>>>>>>> Deferral vs early entry danger zone
>>>>>>> ===================================
>>>>>>>
>>>>>>> This requires a guarantee that nothing in the vmalloc range can be vunmap'd
>>>>>>> and then accessed in early entry code.
>>>>>>
>>>>>> In other words, it needs a guarantee that no vmalloc allocations that
>>>>>> have been created in the vmalloc region while the CPU was idle can
>>>>>> then be accessed during early entry, right?
>>>>>
>>>>> I'm not sure if that would be a problem (not an mm expert, please do
>>>>> correct me) - looking at vmap_pages_range(), flush_cache_vmap() isn't
>>>>> deferred anyway.
>>>>
>>>> flush_cache_vmap() is about stuff like flushing data caches on
>>>> architectures with virtually indexed caches; that doesn't do TLB
>>>> maintenance. When you look for its definition on x86 or arm64, you'll
>>>> see that they use the generic implementation which is simply an empty
>>>> inline function.
>>>>
>>>>> So after vmapping something, I wouldn't expect isolated CPUs to have
>>>>> invalid TLB entries for the newly vmapped page.
>>>>>
>>>>> However, upon vunmap'ing something, the TLB flush is deferred, and thus
>>>>> stale TLB entries can and will remain on isolated CPUs, up until they
>>>>> execute the deferred flush themselves (IOW for the entire duration of the
>>>>> "danger zone").
>>>>>
>>>>> Does that make sense?
>>>>
>>>> The design idea wrt TLB flushes in the vmap code is that you don't do
>>>> TLB flushes when you unmap stuff or when you map stuff, because doing
>>>> TLB flushes across the entire system on every vmap/vunmap would be a
>>>> bit costly; instead you just do batched TLB flushes in between, in
>>>> __purge_vmap_area_lazy().
>>>>
>>>> In other words, the basic idea is that you can keep calling vmap() and
>>>> vunmap() a bunch of times without ever doing TLB flushes until you run
>>>> out of virtual memory in the vmap region; then you do one big TLB
>>>> flush, and afterwards you can reuse the free virtual address space for
>>>> new allocations again.
>>>>
>>>> So if you "defer" that batched TLB flush for CPUs that are not
>>>> currently running in the kernel, I think the consequence is that those
>>>> CPUs may end up with incoherent TLB state after a reallocation of the
>>>> virtual address space.
>>>>
>>>
>>> Ah, gotcha, thank you for laying this out! In which case yes, any vmalloc
>>> that occurred while an isolated CPU was NOHZ-FULL can be an issue if said
>>> CPU accesses it during early entry;
>>
>> So the issue is:
>>
>> CPU1: unmappes vmalloc page X which was previously mapped to physical page
>> P1.
>>
>> CPU2: does a whole bunch of vmalloc and vfree eventually crossing some lazy
>> threshold and sending out IPIs. It then goes ahead and does an allocation
>> that maps the same virtual page X to physical page P2.
>>
>> CPU3 is isolated and executes some early entry code before receving said IPIs
>> which are supposedly deferred by Valentin's patches.
>>
>> It does not receive the IPI becuase it is deferred, thus access by early
>> entry code to page X on this CPU results in a UAF access to P1.
>>
>> Is that the issue?
>>
> 
> Pretty much so yeah. That is, *if* there such a vmalloc'd address access in
> early entry code - testing says it's not the case, but I haven't found a
> way to instrumentally verify this.
Ok, thanks for confirming. Maybe there is an address sanitizer way of verifying,
but yeah it is subtle and there could be more than one way of solving it. Too
much 'fun' ;)

 - Joel



