Return-Path: <linux-arch+bounces-10219-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6C5A3C307
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 16:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8011887928
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 15:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7FD1F3D53;
	Wed, 19 Feb 2025 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fj9DPHjt"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA9E1F3BBB;
	Wed, 19 Feb 2025 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977556; cv=fail; b=LNICMc0RfHU0nRH9Wpdeypy8HGJXcFSurx16IcviInI1ASxtnb2rJTEVSEEZ3MbNheSjksF3ddYag/JUP8IkELc50t4kr8Am89Z3M6UAyWrhl+3ckKUW024mYfSLH4fUyT6PiVQcKFu/HEYFVKrp5oXsZ5BO9x+wT51dRZRQTDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977556; c=relaxed/simple;
	bh=6tV2Fnr8hRB5oyPLcltcpH6wnEo7heKapHqoi3wauFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OPwa08XkWFmbKY776i20XvEpNy1bVbtNTurfHKnyrnb5+Lna/Ov3HtgDDEhdUgVgd5xAJNtdHWU5RtQtL5dK7o0d4OILnFukunXwtu4MJLZxt6hmHFHW4/iWyjGF2lbzcy0rCivPvbkF0awjKW5RHjnUxpjcJg2dJUO9Cjciq2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fj9DPHjt; arc=fail smtp.client-ip=40.107.102.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKAsFn867LSBUrRDJRgLFFcPuio7g1kVjax6/5B3BxnD0mNuzin6h5zIkyj+1kkBfP20/PYEZl78XAAuVXtV/8JhTTv8Ye2FTDBOcX1At7bF/CKblzCwCvqUdClYox/JR/+k9mfHJTS9zIwl5GGUkPkRIfW8dQODkLBuMPM2JL/BkhGOcyy5ZWRkr2+bH2sAKpYZi2qXMLICJhcYOFmtzJQ6JrPLhB8kXWtWoJViYO/+2fm1xH9xaSt37BuzaPrOXw+6uDkpQmTeaRhbjSW+Xr7KiVGPhF4a9NkeMh79IS4/u8HisN5cyzQFHYZUHvaAKmBPHw+Sm8NL7oglePKu8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1iOID2bcXBamzPTPoVujjbZLDwoclMiI2auzlDjDSo=;
 b=I85RKatiZQHPpuolBakFVS11n8M3WGNuWjC+VksaKcPWHqrkYJM8oeL4MqgHhIyrYgvTmAjGfFcV8lSgBNvC70BFUwH5lD///njvN8vD4fqauGvGJl2zSNQH++yWxug118rdBLMHz2v0DbKyvPqu574bdY6d4oA4TfsAR6bCWfWL+QXrccxYu/1PSDASPA8Zj/lC19a7vTnImjdxHU5WmmjtwWSIEzrOuKzrDYS7Dz79SaIJ7joZBJI0XNc+5/6FzY63RRzsWPLNGWSiEkKaQxK6ohMTm3oRjCw+zqJ5wNct5jWFZMWP1tS1YxkHFNpsfU8P3A+QoRBpPx03gvbUDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1iOID2bcXBamzPTPoVujjbZLDwoclMiI2auzlDjDSo=;
 b=Fj9DPHjtaPs3OTzO7PDyEwIr0fW8Gz9vCl1el9BDTe4MuD2iQ/7s2ibQICNGHSs09onYv1adA2uEnZ9LwXDupyWfUm7FAqLlZ8L/DVr8nBNyrzfX/9apfbw3PBgxKhAIvecBFLDQc4o4vm0dr9nDpgVpjSlaPZUw2OvPjFwvzlP6F6DD6No/P64jZTWnYkvNCoGWGwHvPDIdn13+8OFpb9WfS+ZfxneL+1k8L9L+S/5yGitdkFCRhfxa/7kfhRcUZ+ZYBFK6rOvOxI8u+N7KtMVNe9Ym20kF9X5iC2DlKWQsFNZljEd+vHtQR0P9Bj0IhMVbZQeCOJjgTRDx7hvzIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA1PR12MB9029.namprd12.prod.outlook.com (2603:10b6:208:3f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 15:05:50 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 15:05:50 +0000
Date: Wed, 19 Feb 2025 10:05:47 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
	linux-arch@vger.kernel.org, rcu@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Rong Xu <xur@google.com>,
	Nicolas Saenz Julienne <nsaenzju@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Jinghao Jia <jinghao7@illinois.edu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer
 flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
Message-ID: <20250219145302.GA480110@joelnvbox>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez3H8OVP1GxBLdmFgusvT1gQhwu2SiXbgi8T9uuCYVK52w@mail.gmail.com>
 <xhsmhzfjpfkky.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhsmhzfjpfkky.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
X-ClientProxiedBy: MN2PR18CA0005.namprd18.prod.outlook.com
 (2603:10b6:208:23c::10) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA1PR12MB9029:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c25bda2-da56-4557-f687-08dd50f6e56c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkhIL1FkR2JpVzRHUFVNR1R2VzhJRGMwTW1xdlRCU0JVMk4rZ091MnNnQjZ4?=
 =?utf-8?B?NXdkclVldTdJY1NjTnBjYUNDOG1MUjF3em8vR0lOcFJsWTFGL0xhS1BqbDVY?=
 =?utf-8?B?S0xTdERaaFFGekFheFN5YjRrU2Z5ZURTSXBmRXcyK0tpTUxvaTBDNmk1Sjh1?=
 =?utf-8?B?WjdIalJ1cURXYlBwMzM2V2k4SG5JRG9uT0M4bjdBMlJna0J3S2JCWVFmYW9V?=
 =?utf-8?B?V1Joa1JHUEJ0eFJvdjRJenlPbVRDNFRDajF4SFMxRWNOVEljeFA1RVgvVHpR?=
 =?utf-8?B?K0xFMVExdHZXKzk3bFFBTkk1OVo2TzRQUm42S3BiU3ZJK0pBNDRaRlEzbVBm?=
 =?utf-8?B?Z3B3NmtTbk5LaHpkMDNuRnMxRjIzRFl6OFVkT1lsSG1aQnRVcHJUVWdXSXlU?=
 =?utf-8?B?TDFmZTczTmlVTndTQ2I5WnhMdklDbU5FcFZscmNVMXhqcUUvcU5RRm9ENmxL?=
 =?utf-8?B?ck0zeHZLcUIyMERLUFNaQWd4UTVmWHorc3FzNFl3dGl1ZjEwWjRBclozcGlB?=
 =?utf-8?B?NDVtTTcxeGhWUDNtTnZrTE5JVjJpSXpxVko2c2IwcVR1eUV3MG1zb3Byb3hV?=
 =?utf-8?B?Ynk3a3gzZWcwS2oyVitMVWdRVS8xMU1mcUtkUlVTbXk2QktyVm9GV01DU0VS?=
 =?utf-8?B?K1MyUkhHR0FQaE5sV1RsUEhkeEpISnJ1T0xGRndxc3dkaTZDZFZRWGZkNmdO?=
 =?utf-8?B?NXNxenNjLy9YdjJTa05ITThxVkdReGUrdHhOdkZOTjZLWXJHNmE2Z3N1VXJ1?=
 =?utf-8?B?bmhUUGpzR3dsaVB3a3NQMWp6MCtnTFdjM3c0OUN3ZllHekpFMkl6RHh6STE4?=
 =?utf-8?B?ZjdOTGE0Mjk1RHdHLzNZM245VDlScFd4WkZKYW5VQ2x3dlg5WGNwNTExTDd3?=
 =?utf-8?B?ZUU0VmlZYXo5dUNOMjMzUDlRR25EbVEyMnhJQlhLR201emphN0hab0xGSStN?=
 =?utf-8?B?ZHEwOVVzQVB1UjQwTTE3QkRqUDg4RU9LOEgwZkZ0VUR2LzRMNHB6anhDNldB?=
 =?utf-8?B?QTFkWUVudFhHcE9lZlFGS0JXdHZnUGtuNC8rRHFkSExJdHpXbzZIMUNxcDVq?=
 =?utf-8?B?ZGl3bVh0cDVKRzl0QnZyZENZM2xuNmJxSVFXT0lDdzRScW8vWjlEblp3RERI?=
 =?utf-8?B?ZU9hZ0EwZDFlNFk5K0xvalVQMFo3OWtGcmNyVG04dFE2MEltbU5qNUtsMDBy?=
 =?utf-8?B?OTY2NUZKWkFxZXBvT3YxTWw3a2o2R3ExL2l3VFlYZjdHT1BQeThJdElicHcx?=
 =?utf-8?B?dlphMDNCVGtnQ1FKbjFkRHJEdFlEQWtQV2lzbVZMbVpGWmsyaDVzVlVteVYv?=
 =?utf-8?B?RnhXc3JQdjc5MWJGWDlUSzRMQXcyYklEQnh2YkxkNGtVVFdhTnkzVU44OGNk?=
 =?utf-8?B?dXMvNHZBdjI5bFBjb1RYemJCMmFvT1NrWFl3YThnU2VwZG10TFM1ZFdTZ0lj?=
 =?utf-8?B?VXlLK1dNUXh4YzE1TTZnbi9jQ1JxUEhHbzViblBtblJxRWpHcEMyMzNacmFl?=
 =?utf-8?B?TmVOdVlpMlpjbndPY0hqNkJaV20xaU9wazRqM21hZWlUUXM0TE9XU2twQm4v?=
 =?utf-8?B?aWFzWnhkZS9ITTNETkVtQUQ3ZlJFdm43RU9OYlRGaTJJTWorVHZTR3Q0YUlK?=
 =?utf-8?B?dUlyOVFyN2ZOSTZKeHdWUnUyU2w3alI0ZkdKdTJkcG5FTjJpTkJwVTlVWE1L?=
 =?utf-8?B?VDlyTU5JSXdIZFJDa1JMWTYvRkFGZkUwb1ZXQWs2bkRTaWpScVB6RjltdnFD?=
 =?utf-8?B?TDJBMktqM2tnRjRJekxNL2FIUW5SUDVEZkQvQ29qSnR3amppbzNZVG9FanFi?=
 =?utf-8?B?OEI5Z24rSTN1dll0ZTJZWFc4Wk03eUd4by9KR2VEci9Nci9NRWdzTk1xZmpW?=
 =?utf-8?Q?DKrgDoGj60ipC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dG5QQjRJRTdQMXJBS3BQOUNjU21LdWw5SzdyRFlQakRERlFib3JuclBOOERN?=
 =?utf-8?B?UWc3U0VTUFlLVVFGMFFGUEpyWWlRZTlUc0xieDAwbHYrblkvTys1dnVCZ0l1?=
 =?utf-8?B?Y1pnWUI3Q0pSY1ZaL1htNThQekg2UCtTMEhTZ0MvWjliYlRtVXVPejRybnd3?=
 =?utf-8?B?Q1RRdi9aV0ZxVjMwdUdVWEZ1ajFYak9ZdFlINU12WDFqN043SXhtSFFnVVpo?=
 =?utf-8?B?NWNXeXJwSWd4RkxsYlUxa3FtSVNZRkpjT0RjMmlyck9QVDI2ZnZaQ2hoMHEz?=
 =?utf-8?B?OUVQNVBsTnk3VjFoUVp2bmszNjRSTWVxdVIxdlZNbE5QL1U3S09PaU5BaDRE?=
 =?utf-8?B?RERBTjNJS25INVFYSGRhVzYvUHRBMlVVRHgwRU85QitiUjI0cTJ0RzN3eU9s?=
 =?utf-8?B?Q2FkTDY1ZEtzRHIxRk9Bd2R1SUJzaW1uek10Tm1BcXlyamFYVW4zV05WMnVw?=
 =?utf-8?B?YzZtTThnelZDTmwxSGgwOWt3dy8zcVl3NEhTQi9iV1NpK1hUdndObEsrT0lq?=
 =?utf-8?B?Y0VjNXBuYU5tRU5LRnBhRkpVV25EQzlBL0FxdU5MeHVPRndQa05ZaUliTmN4?=
 =?utf-8?B?QVkwdGswQkxZb0lxUHV5RGwxdXNUNTlGNjcyRTdER0x1TEN2TXF0aGNPTWJ6?=
 =?utf-8?B?aWUzTjFjWGNBMEszeUVLQmdhZ3FVdm85amgxSGloZWVZRDd1WFZwNXhKMTdt?=
 =?utf-8?B?SEp0S0wvcS9kb2cvdWVnKzVyUjk3N1dIaWUycVZjWU84Q3E0S00zYUZxWkNZ?=
 =?utf-8?B?VC84UGlEdE1qTTZMQnUzWlJzbE5KTjlLL3cwWi8zUFAvNWFzb09HWjR0Yzln?=
 =?utf-8?B?ZXM1Q2RwUmhmR2puUHpuTWI1WUV4NFh0VG1VSTBYZUg0ckcxeGljZll6d2tQ?=
 =?utf-8?B?c0lEUkZRSFpSdWg3WEJZbm9XQndiZ0hIallnODFjVGxnQ3RHTTN5WGFmdmxX?=
 =?utf-8?B?M1JhL28vV3NBYmk0TmhjMkZZQklYRW4vWWd4aC9YaktXUWxUQW83ME9MRkxn?=
 =?utf-8?B?dDZ5a1JIVmUrOWZRNmd2VnFHY1h4KzRKKyszcmh3MElmbHpTYlpzQmZmZlRr?=
 =?utf-8?B?QUgrS0NMN1Z6Q2RDV3NRWUwwWnQ0elZMQlVBWSt2VDE4RHBSM293TmtEdlNQ?=
 =?utf-8?B?MVFnZldMVWJTMTNLY3FBZWRvM0NnQ3phSzlWM3U4dVlKZkNlU1o2Z0Fnc0JO?=
 =?utf-8?B?ZjR3T3VNZ2ZTNHJUUkVaamNnRHhvU3VyRVM2ZitrRlIxV1hIbEpBUFptRUtU?=
 =?utf-8?B?OWF5R0tPUEdZRWFuWGtOUEVmSUpUclVSV3lVMXpVdlpHVWhSeGdxRkd1RFMx?=
 =?utf-8?B?VUgzUVZ5d3gwQlhPK2FTZmU5SUVCSi9EMXNkZGNaditxRzc0SER2SkEwRDEw?=
 =?utf-8?B?RDVhWHlJUEtaNmp1eHlUVVNSZWllTmh5TGJYcm8wNU5ua3kya1dTL2V2Q3Nj?=
 =?utf-8?B?YnorRUw5UmM4K3MrbEVJRTdhZGFoNkdtVmRwRlpDUmxrYnNTSVlXbStuOGVZ?=
 =?utf-8?B?c0luRGpqYXdDRHozcW5wYlI0bkNYUXhUZnJrR0NHMzFWY3hjM3FidEtYQUJQ?=
 =?utf-8?B?Ri9GV3pMQ3RsVUVZSmF4SGhGOHExMjY0ajRyaGs2MTBkQ0h0Nzc3QlNlVVhw?=
 =?utf-8?B?UmdoYkd0U0RwNVBWeHZ3S3VaeWUwNDZxSkhmcUI4U2RDdVVGZHlKcXU0VGRy?=
 =?utf-8?B?QzhlcVlCclJZU3RmU0lMV04wOVhUWVhvMDZtYXE5TGdoRUJlV245dERQNnFQ?=
 =?utf-8?B?OE1XUk1CaWRhNHhzSllPNkxBRytSTE9hcmNCeXVTSGhvQjRhenJ2OGdFMU9C?=
 =?utf-8?B?KytoQlpNUkg4RnhHZm4zOXh6MWNtTWw0T1ZlMUdFdnEwVXZ5WGtkUDFRS3pH?=
 =?utf-8?B?clM4Z1hweG5lSGdhTnlhUUlzZEQzWWEvejlvOTliS0xtR2ppK3p6QWZsTE1O?=
 =?utf-8?B?MFBCVEExTWRhbXRPNWFmM3JaazcxSFVSODFIc2N4Znl0UVZEbGkwQXBhdnZ3?=
 =?utf-8?B?Zk9RMU8wdTZrbSsvOTlvajc0VmpTOGxwb1U3NzBTczV0QjlpYU1ia0hoaHNU?=
 =?utf-8?B?QWJYT1M0MjZrMUpNYjFRR0ZBMWthYlhmcUNES1lwdEUvZkZSUUpjMjJhUUxC?=
 =?utf-8?Q?f37H3uFx36Kce1SweEEnpii7O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c25bda2-da56-4557-f687-08dd50f6e56c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 15:05:49.9907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vENyi1BqIDH2Vmt4z2lQDPuELFOWe5ymrHLk0eJ/9UyBz/j89j0TliQZuvZyk7Hk6bMN/M4gsP9X/jwzE3I/VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9029

On Fri, Jan 17, 2025 at 05:53:33PM +0100, Valentin Schneider wrote:
> On 17/01/25 16:52, Jann Horn wrote:
> > On Fri, Jan 17, 2025 at 4:25 PM Valentin Schneider <vschneid@redhat.com> wrote:
> >> On 14/01/25 19:16, Jann Horn wrote:
> >> > On Tue, Jan 14, 2025 at 6:51 PM Valentin Schneider <vschneid@redhat.com> wrote:
> >> >> vunmap()'s issued from housekeeping CPUs are a relatively common source of
> >> >> interference for isolated NOHZ_FULL CPUs, as they are hit by the
> >> >> flush_tlb_kernel_range() IPIs.
> >> >>
> >> >> Given that CPUs executing in userspace do not access data in the vmalloc
> >> >> range, these IPIs could be deferred until their next kernel entry.
> >> >>
> >> >> Deferral vs early entry danger zone
> >> >> ===================================
> >> >>
> >> >> This requires a guarantee that nothing in the vmalloc range can be vunmap'd
> >> >> and then accessed in early entry code.
> >> >
> >> > In other words, it needs a guarantee that no vmalloc allocations that
> >> > have been created in the vmalloc region while the CPU was idle can
> >> > then be accessed during early entry, right?
> >>
> >> I'm not sure if that would be a problem (not an mm expert, please do
> >> correct me) - looking at vmap_pages_range(), flush_cache_vmap() isn't
> >> deferred anyway.
> >
> > flush_cache_vmap() is about stuff like flushing data caches on
> > architectures with virtually indexed caches; that doesn't do TLB
> > maintenance. When you look for its definition on x86 or arm64, you'll
> > see that they use the generic implementation which is simply an empty
> > inline function.
> >
> >> So after vmapping something, I wouldn't expect isolated CPUs to have
> >> invalid TLB entries for the newly vmapped page.
> >>
> >> However, upon vunmap'ing something, the TLB flush is deferred, and thus
> >> stale TLB entries can and will remain on isolated CPUs, up until they
> >> execute the deferred flush themselves (IOW for the entire duration of the
> >> "danger zone").
> >>
> >> Does that make sense?
> >
> > The design idea wrt TLB flushes in the vmap code is that you don't do
> > TLB flushes when you unmap stuff or when you map stuff, because doing
> > TLB flushes across the entire system on every vmap/vunmap would be a
> > bit costly; instead you just do batched TLB flushes in between, in
> > __purge_vmap_area_lazy().
> >
> > In other words, the basic idea is that you can keep calling vmap() and
> > vunmap() a bunch of times without ever doing TLB flushes until you run
> > out of virtual memory in the vmap region; then you do one big TLB
> > flush, and afterwards you can reuse the free virtual address space for
> > new allocations again.
> >
> > So if you "defer" that batched TLB flush for CPUs that are not
> > currently running in the kernel, I think the consequence is that those
> > CPUs may end up with incoherent TLB state after a reallocation of the
> > virtual address space.
> >
> 
> Ah, gotcha, thank you for laying this out! In which case yes, any vmalloc
> that occurred while an isolated CPU was NOHZ-FULL can be an issue if said
> CPU accesses it during early entry;

So the issue is:

CPU1: unmappes vmalloc page X which was previously mapped to physical page
P1.

CPU2: does a whole bunch of vmalloc and vfree eventually crossing some lazy
threshold and sending out IPIs. It then goes ahead and does an allocation
that maps the same virtual page X to physical page P2.

CPU3 is isolated and executes some early entry code before receving said IPIs
which are supposedly deferred by Valentin's patches.

It does not receive the IPI becuase it is deferred, thus access by early
entry code to page X on this CPU results in a UAF access to P1.

Is that the issue?

thanks,

 - Joel


