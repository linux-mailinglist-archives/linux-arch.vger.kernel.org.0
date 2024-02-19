Return-Path: <linux-arch+bounces-2477-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AC3859BE4
	for <lists+linux-arch@lfdr.de>; Mon, 19 Feb 2024 07:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65F18B21548
	for <lists+linux-arch@lfdr.de>; Mon, 19 Feb 2024 06:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32C02030D;
	Mon, 19 Feb 2024 06:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jOsposL2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593331E514;
	Mon, 19 Feb 2024 06:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708323063; cv=fail; b=LCyS0D4msQ/Jm7t5/aFYQptUil1sqoav7GwpnZvYDo5lNNeQdE6A7W6Xiec7WitEiEMMyUHagtu5aoMi6Nw0iwyA7bDpphv8RI1tFcf7+Brhfq/5I3ZtoL0HQ/fgQt9j6YNudViMwVgj5vwlayuQU2gTcU0GOGNvyvXzrKSvfdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708323063; c=relaxed/simple;
	bh=Gk8G10JnJSuCCaGKuTD4RY/96/1qNJ2mgSDbCvxtYWc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NO5jpsco7DmztA6utcImONo1RNC+2Vl/dcnQ8xY3NPxxNPBqlCgw1ggWGejuPOJIUrPB0/buaH2dH+Ydf3gWRYAKndTIacA7/u3jvd+u7H1YgfjQBh/W7Us20C/S8wk6hPUbtWaiI4orBP2zySNVr8oHVBwQzrVUp2gGuJ6fHs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jOsposL2; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708323061; x=1739859061;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Gk8G10JnJSuCCaGKuTD4RY/96/1qNJ2mgSDbCvxtYWc=;
  b=jOsposL2DLj8SyacL4WejvhksH7RXAXORGs/q+IUr9unkR9zH1Mr+ld7
   wBaklwZeLBKUXPFHeFZpeETfi2HgF21Hz6BVRax9k65b8zL/cGRzd2x7G
   EfR3Ztw7beu6WgNvESDvoWq7KmkUzysAPZ8lUaRkoA3EKuKxpkn7DM6lS
   lj27GuDsUuIc6GklVUzx59wJ8y4vyHUh4FfeRBI3UFClnH5NQgvbB2bTf
   zeD8QNVquxWcOfdYPEO6pyVto/UEeAjIN8gsfq5g58BSPYtXYXpU69QoC
   kFfimOLpcEItv/4hEootVqCp+FJKO0T9IkX1KwdgdkPh+hRpXbMHMvwDZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="19916317"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="19916317"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 22:11:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4347495"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2024 22:10:59 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 22:10:58 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 18 Feb 2024 22:10:58 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 18 Feb 2024 22:10:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYtzkW7b+fmIJxfnC6XnLQ/sh9Gb5ZIxB3QVwWT8VGYsMwGkgBfVkWJmd2ZYjki2j0QkRznKpvikZPQXsCifEf9wwqnTxgbKznA2a2kExTIYqvDNW+/+q0j9RKUrS2c1c4iwCQMdlhQXTpvvJqNv7uf5ljTmMByhhi5cSQcPSrjOdr0y/vJ3O7piGp/b1O95B2b1h2e/GJS0KEny6CVQKwAul8pEOMpDgz2UzFH2mHFJljK2VZvlV/ZoFm4FfkGaM+LQ7itKBYLUenASvX+Lmk/84jm0Gev01CR7jgmLZgPtpcHkI/nsFcbKWm28JoXvW/rczFHkGgHbBD8nDXzgSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwbGZCZonDyybS14DNY1hugTTJ3Yf/lDhv+Xk1YeVzo=;
 b=N2HBUek5pDjRNJTJMSLLpBzx7xH6iC3cFeLHELURghTcsTFy75o1wU7TUrUhX27gcJS18lpVdqsHNxEwOcrijSD3HLeQcRAPOpBuE5Q70RS5Tk/N8MwzI+VgwZQpIVRNOKOAOC9CjYFGetn9jtCs1lVjFygiPXKBSkTaHMRAx/bhvkPW2AMCyS56SoLybWyKOuBp+NqcnI1l64qSFoX153NgFK657W8C62e4mSaedOqQXfI3Kbc0HJUnht32SB/T88iNa+y2AjV0T130G6aCl7JoN03400j3KbmxMylwZJ3jMCwIoOVR0od1bbSvkx4vns0W0egkk7f7Z0Pz1lPSrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB7968.namprd11.prod.outlook.com (2603:10b6:510:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 06:10:56 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 06:10:56 +0000
Date: Mon, 19 Feb 2024 14:10:40 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Valentin Schneider <vschneid@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Josh Poimboeuf
	<jpoimboe@kernel.org>, <linux-kernel@vger.kernel.org>, <ltp@lists.linux.it>,
	<kvm@vger.kernel.org>, <linux-arch@vger.kernel.org>, <x86@kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter
 Zijlstra <peterz@infradead.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, "Ingo Molnar" <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Vitaly
 Kuznetsov <vkuznets@redhat.com>, "Arnd Bergmann" <arnd@arndb.de>, Jason Baron
	<jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel
	<ardb@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, Feng Tang <feng.tang@intel.com>, Andrew
 Morton <akpm@linux-foundation.org>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, "David Hildenbrand" <david@redhat.com>,
	"ndesaulniers@google.com" <ndesaulniers@google.com>, Michael Kelley
	<mikelley@microsoft.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2 2/5] context_tracking: Make context_tracking_key
 __ro_after_init
Message-ID: <202402191313.3276317d-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240206173911.4131670-3-vschneid@redhat.com>
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: b8dbcd4d-46d2-48bd-b4d7-08dc311188bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MG/r8B7JlTvU5L/ImUj12MpKmRkgos0jmzXmo7T0YhDeobX+AYZlNj4/Irr1NZtxORBSQ9a4tG+BoQcpKNTqVk8k7ErEe0OfIXRkSUvb27nYZsY1Ev3gKIgeAzSD8Fp3hhWuY6GQRtbFFcImP7RXhLYe8laerOv5imRRWlnl+RBaBkHHllFjd4Y0AYv9QPvBjURBVXgc1VxdVZ88Xxyn7ezcOG95tHgmfjmvwil4JyBs/js3S0sqYIjw1kbm+kXr5Q0tuZhtem36O9xEES7QLUkdXVgTr3Mz5gQuBZd5P3H5nSkiwW55Q4StSvZVaR1icYmTAbAgOSuAvxBegeRpnFfzsDjfvEpeo8Y/wlWOznFAGDIH72E9+FYrUrVYYXACTK7c5py/74+pLay8f9SOtGWZIUaVK5u+m0LYtp7AxbvaO0oW9ZKgbmom+HY9+CYpumhtPj/H/PaKzwjgbD/SE6gjn5/C9tsh/9o4VjJoRy65G2tow0KJZa09uV21nE0cqnNluHBW23k9MiB7YEI8bGvBNdSpt+D081WmpxvxjLWtZYtMyT7ZonQgz6mqdwHm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(230273577357003)(64100799003)(186009)(451199024)(1800799012)(38100700002)(54906003)(26005)(1076003)(316002)(8676002)(4326008)(6916009)(66476007)(66556008)(66946007)(86362001)(82960400001)(36756003)(2906002)(8936002)(7406005)(7416002)(5660300002)(83380400001)(41300700001)(45080400002)(2616005)(6512007)(966005)(6486002)(6506007)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IlIeP4OBicUhtsFA86snTn/QzDVtisj5koVFqXuuSdQlva+fgvuztT3VkH/v?=
 =?us-ascii?Q?Jmj5YIFpfCFGvonlPNA2+LSRbh6pJ9Ew4IRpCyGhJj2a5ipOExaWdRbXEToW?=
 =?us-ascii?Q?4AKemohKPESAdIJs5viJc1rDsLq6XZq5+9xF+CiWaS7YBv/caIOvo5YZEd2u?=
 =?us-ascii?Q?x0kUNGqNmV/mx1TIf3+8Ppv284orzr7c6w2p4RkIpn/sUcowXVFzE+l9sFzR?=
 =?us-ascii?Q?0vrkd9s9ckPoMhAHsdDSt5cxqZtyRd8wBC/X2HqMHd9N9G7h3UJeuug8tzqD?=
 =?us-ascii?Q?5C6v5ctfpuDVNXLRlqAW3D0VH5jqtIci7hZuKAdLekdVQwclRUk2ChQyaDQe?=
 =?us-ascii?Q?0cKsvXJHJHJNK3CTH8Vy6ADAhTPd+U3vrCs34vBYqj3QO1wAPmkZQEQcEJ7q?=
 =?us-ascii?Q?vE/tje8aKskur7/0I6SXni37jgDUQ8qIsPeWkO2t9Kgs8HARMbeuswcmKutK?=
 =?us-ascii?Q?PDQ4rzOYsud71Qgs24hGP7Ya02HFPykEL6BuXP62hL4xACpE25VgOi+XxdHN?=
 =?us-ascii?Q?p7ajt9kmtPwVL6XehwdwyTysSAsHao1N45qhvXFG+pV2OggE4dbi/W+xx49f?=
 =?us-ascii?Q?XkpUTt0EJrxktZNMuxJDhLg0SfTEBDql+NVk20FYQ1VN3qrfwYIvq2YxqYdv?=
 =?us-ascii?Q?Q0tnhs2rlIk9eGvh2Uvwkf0/u/QKCltiSfAO0x4Q1WlelR0xlQ9c6/QgP2se?=
 =?us-ascii?Q?+egxRSJTofw4p73xJxVaDUjOORKehFVyVc8JqqE6xNRA/2jndHwOS12UoQdN?=
 =?us-ascii?Q?IWV8bSra2RvzQngcKtghVgxWQr6wsxQwIyWwD16OEB0u+2U3TzXX6uMsOnaw?=
 =?us-ascii?Q?WtTRRMJHgh65WMtkTLAw51/+mqtA283WKm0wjd+6dOqNwYi2eZTWkgz/bnzC?=
 =?us-ascii?Q?eRwYNRVmw8A5AUJiCSUs1rOEnYmeybyy2cyZnmG41WX0RAt31NfaoBtj9qK8?=
 =?us-ascii?Q?h1l2RVYRCxlRyJgYE2P5SbDWDl8ZT1BMFdtw7L8S0QfUArtq/102ioryAgXs?=
 =?us-ascii?Q?jAf7Jr79FhV88ehuasb979u1PL9W/gqCgYLWWMuqRynyrBFQsJMrRdu6nqqs?=
 =?us-ascii?Q?I74j8KzCWMT2LOpe0ZJJmNoUObYdaaxG7sbKjEG0QQeIYiD0nasIIFcmhpP1?=
 =?us-ascii?Q?67yR/M27TBNLnEBtkqPPJwciVbfPUZzl5hJyIvsRlIc3gFgDxqrbyQ/pNrJz?=
 =?us-ascii?Q?K/fct02sus+8oVQV91Et7AbGUhz9bQ22nYTLaXb/5oHnO0WYJyB863mHwjqm?=
 =?us-ascii?Q?J5ZBzhore1T5XDpAK8+efs8gSxb09O7T0k5OC9eino6ZnFAJZfwSLRrdgkbF?=
 =?us-ascii?Q?YpTBuYHDzvKDe5SVBir2KD+0CMhEhlKj+p/wqyR56HZ5kYWZXObl8ZX0ALRM?=
 =?us-ascii?Q?1kGsSxQcTQeZHAXqzHnJdu9vdzxpYam3egFFV77FUl922DlSNsXxNBUgh57P?=
 =?us-ascii?Q?kQa2/7RZzkjGv4c8l9XrEBIyR3hi6UCwCZ/rC/wKr/tiFX0mc/sqXCex8rAr?=
 =?us-ascii?Q?PEHlBU61JSo1Q9U1UXXDdDO3exwG/poV+3gQoDjlfGoEx32In2ubM1BydrW4?=
 =?us-ascii?Q?RvasAEt+tPGSM1Zts0BBK/ZUo2pFCqWWsVNvVwwc2eECYrq8Wtb9boix5Rmc?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8dbcd4d-46d2-48bd-b4d7-08dc311188bf
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 06:10:56.1457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sra+4nT+3haXSZgv6+XwC+I2S3aSbrmjFS7VjCkNa3qHhVhfnCngT+Rc/3y3oeF1k6jJTAVLFIL+Rhx5dNu4fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7968
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/jump_label.c:#jump_label_del_module" on:

commit: b42c2f5e8e4d403b5891b566b015177c8f471858 ("[PATCH v2 2/5] context_tracking: Make context_tracking_key __ro_after_init")
url: https://github.com/intel-lab-lkp/linux/commits/Valentin-Schneider/jump_label-module-Don-t-alloc-static_key_mod-for-__ro_after_init-keys/20240207-014501
base: https://git.kernel.org/cgit/virt/kvm/kvm.git queue
patch link: https://lore.kernel.org/all/20240206173911.4131670-3-vschneid@redhat.com/
patch subject: [PATCH v2 2/5] context_tracking: Make context_tracking_key __ro_after_init

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20230715
with following parameters:

	test: kernel_misc



compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz (Ivy Bridge) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402191313.3276317d-oliver.sang@intel.com


[  215.214621][ T3608] ------------[ cut here ]------------
[ 215.214849][ T3608] WARNING: CPU: 1 PID: 3608 at kernel/jump_label.c:764 jump_label_del_module (kernel/jump_label.c:764 (discriminator 1)) 
[  215.215123][ T3608] Modules linked in: rcutorture(-) torture netconsole btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp sd_mod t10_pi coretemp crc64_rocksoft_generic crc64_rocksoft kvm_intel crc64 sg ipmi_devintf i915 ipmi_msghandler kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 drm_buddy rapl intel_gtt intel_cstate drm_display_helper mxm_wmi firewire_ohci ttm ahci firewire_core libahci drm_kms_helper intel_uncore crc_itu_t libata i2c_i801 video i2c_smbus lpc_ich wmi binfmt_misc fuse drm ip_tables
[  215.216369][ T3608] CPU: 1 PID: 3608 Comm: modprobe Not tainted 6.7.0-rc7-00234-gb42c2f5e8e4d #1
[  215.216637][ T3608] Hardware name:  /DZ77BH-55K, BIOS BHZ7710H.86A.0097.2012.1228.1346 12/28/2012
[ 215.216918][ T3608] RIP: 0010:jump_label_del_module (kernel/jump_label.c:764 (discriminator 1)) 
[ 215.217162][ T3608] Code: 03 75 35 83 e6 03 48 09 f0 4c 89 fe 48 c1 ee 03 80 3c 2e 00 0f 85 cf 01 00 00 49 89 45 08 e9 bf fe ff ff 0f 0b e9 6b ff ff ff <0f> 0b e9 64 ff ff ff 0f 0b e9 e2 fe ff ff 0f 0b eb c7 0f 0b e9 19
All code
========
   0:	03 75 35             	add    0x35(%rbp),%esi
   3:	83 e6 03             	and    $0x3,%esi
   6:	48 09 f0             	or     %rsi,%rax
   9:	4c 89 fe             	mov    %r15,%rsi
   c:	48 c1 ee 03          	shr    $0x3,%rsi
  10:	80 3c 2e 00          	cmpb   $0x0,(%rsi,%rbp,1)
  14:	0f 85 cf 01 00 00    	jne    0x1e9
  1a:	49 89 45 08          	mov    %rax,0x8(%r13)
  1e:	e9 bf fe ff ff       	jmpq   0xfffffffffffffee2
  23:	0f 0b                	ud2    
  25:	e9 6b ff ff ff       	jmpq   0xffffffffffffff95
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	e9 64 ff ff ff       	jmpq   0xffffffffffffff95
  31:	0f 0b                	ud2    
  33:	e9 e2 fe ff ff       	jmpq   0xffffffffffffff1a
  38:	0f 0b                	ud2    
  3a:	eb c7                	jmp    0x3
  3c:	0f 0b                	ud2    
  3e:	e9                   	.byte 0xe9
  3f:	19                   	.byte 0x19

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	e9 64 ff ff ff       	jmpq   0xffffffffffffff6b
   7:	0f 0b                	ud2    
   9:	e9 e2 fe ff ff       	jmpq   0xfffffffffffffef0
   e:	0f 0b                	ud2    
  10:	eb c7                	jmp    0xffffffffffffffd9
  12:	0f 0b                	ud2    
  14:	e9                   	.byte 0xe9
  15:	19                   	.byte 0x19
[  215.217593][ T3608] RSP: 0018:ffffc9000159fd38 EFLAGS: 00010297
[  215.217877][ T3608] RAX: 1ffffffff089982f RBX: 0000000000000000 RCX: ffffffffc14dc060
[  215.218140][ T3608] RDX: ffffffffc1c6b580 RSI: 0000000000000002 RDI: ffffffffc14dc000
[  215.218409][ T3608] RBP: dffffc0000000000 R08: ffffffffc1c6b8b8 R09: fffff520002b3fa6
[  215.218636][ T3608] R10: ffffc9000159fd37 R11: 0000000000000001 R12: ffffffff844cc178
[  215.218935][ T3608] R13: ffffffff844cc170 R14: ffffffffc14dc008 R15: ffffffff844cc178
[  215.219166][ T3608] FS:  00007f5e44068580(0000) GS:ffff888348080000(0000) knlGS:0000000000000000
[  215.219459][ T3608] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  215.219717][ T3608] CR2: 00007fceb9a28008 CR3: 00000001a718e005 CR4: 00000000001706f0
[  215.219956][ T3608] Call Trace:
[  215.220126][ T3608]  <TASK>
[ 215.220307][ T3608] ? __warn (kernel/panic.c:677) 
[ 215.220503][ T3608] ? jump_label_del_module (kernel/jump_label.c:764 (discriminator 1)) 
[ 215.220745][ T3608] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 215.220961][ T3608] ? handle_bug (arch/x86/kernel/traps.c:237) 
[ 215.221126][ T3608] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 215.221288][ T3608] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 215.221543][ T3608] ? jump_label_del_module (kernel/jump_label.c:764 (discriminator 1)) 
[ 215.221835][ T3608] ? jump_label_add_module (kernel/jump_label.c:787) 
[ 215.222061][ T3608] jump_label_module_notify (kernel/jump_label.c:32 kernel/jump_label.c:807) 
[ 215.222255][ T3608] notifier_call_chain (kernel/notifier.c:95) 
[ 215.222433][ T3608] ? mutex_unlock (arch/x86/include/asm/atomic64_64.h:109 include/linux/atomic/atomic-arch-fallback.h:4308 include/linux/atomic/atomic-long.h:1499 include/linux/atomic/atomic-instrumented.h:4446 kernel/locking/mutex.c:181 kernel/locking/mutex.c:540) 
[ 215.222603][ T3608] blocking_notifier_call_chain (kernel/notifier.c:389 kernel/notifier.c:376) 
[ 215.222845][ T3608] __do_sys_delete_module+0x32a/0x540 
[ 215.223066][ T3608] ? module_flags (kernel/module/main.c:698) 
[ 215.223239][ T3608] ? __x64_sys_close (fs/open.c:1590 fs/open.c:1572 fs/open.c:1572) 
[ 215.223526][ T3608] ? kmem_cache_free (mm/slub.c:1826 mm/slub.c:3809 mm/slub.c:3831) 
[ 215.223772][ T3608] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 215.224010][ T3608] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[  215.224246][ T3608] RIP: 0033:0x7f5e44177847
[ 215.224423][ T3608] Code: 73 01 c3 48 8b 0d b9 85 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 89 85 0c 00 f7 d8 64 89 01 48
All code
========
   0:	73 01                	jae    0x3
   2:	c3                   	retq   
   3:	48 8b 0d b9 85 0c 00 	mov    0xc85b9(%rip),%rcx        # 0xc85c3
   a:	f7 d8                	neg    %eax
   c:	64 89 01             	mov    %eax,%fs:(%rcx)
   f:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
  13:	c3                   	retq   
  14:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  1b:	00 00 00 
  1e:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  23:	b8 b0 00 00 00       	mov    $0xb0,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	retq   
  33:	48 8b 0d 89 85 0c 00 	mov    0xc8589(%rip),%rcx        # 0xc85c3
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	retq   
   9:	48 8b 0d 89 85 0c 00 	mov    0xc8589(%rip),%rcx        # 0xc8599
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[  215.224940][ T3608] RSP: 002b:00007ffedaff1e88 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  215.225209][ T3608] RAX: ffffffffffffffda RBX: 0000562acd24d150 RCX: 00007f5e44177847
[  215.225467][ T3608] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 0000562acd24d1b8
[  215.225754][ T3608] RBP: 0000000000000000 R08: 1999999999999999 R09: 0000000000000000
[  215.226033][ T3608] R10: 00007f5e441eaac0 R11: 0000000000000206 R12: 0000000000000000
[  215.226303][ T3608] R13: 0000000000000000 R14: 00007ffedaff1ec0 R15: 00007ffedaff3378
[  215.226579][ T3608]  </TASK>
[  215.226794][ T3608] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240219/202402191313.3276317d-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


