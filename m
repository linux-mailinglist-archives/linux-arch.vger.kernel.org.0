Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3049D7D148B
	for <lists+linux-arch@lfdr.de>; Fri, 20 Oct 2023 19:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377639AbjJTRFf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Oct 2023 13:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjJTRFd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Oct 2023 13:05:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C553A3;
        Fri, 20 Oct 2023 10:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697821530; x=1729357530;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=cDtWy2nss5m9Zyof1V4eqllGFE0vC2AQerCK0SKM3tA=;
  b=L2u0uWlIOP5Gk7o0vd11qLmACej2Rt1FgxkdAVrIC9U7QqS3NhNI0aOK
   CQ5lVoIt0vaxBeLjvwn4QYLixE69mOKeEwS4QMoRTOmK5bUsHbAtmigy6
   igYn3RSzEHFzsXGpOQDVK+jjrivLS+Qxx3NhVG7liCW/5OF/QklG4fUkR
   Vwt8r7mll35YWjnSrqxMFCBK3m1M8r5eXfW/ilFAhq0sYPTa3UrDyymXb
   RHYSl7H/23U9RDQ9Yw/Q4vQDO3FtEz5YP9YqXRIT7DrjYovBcuwXshG+/
   loKsvh9CBbFGXRAPiiSHPRFNWRpGGr0N7zTcZ+NFqwNdP6Fa/2g42G2i5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="417666108"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="417666108"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 10:05:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="881122959"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="881122959"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 10:05:28 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 10:05:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 10:05:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 10:05:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVXIgxfDrqUj6bcowwm4X9cH9/+jT0ylx5tnuu+5/Fh5u+lJR/WvoIBKYH9WE/l7b3DxDA5FCjZBaJlzj6ec48mqcdQ6GeQykzTvwbtpDgLurZqVBm+S2j2AYQJrHzM9Nl+72wh7spvo2xCgDATfwQxGIbGMett5VdYaXWmhOXcTGPwudTzCGyUnEJUdMwbK+WoVSLpKMXLPZ4ZDOMZruLZnYDSHiYyC88cXT0HwYkDAPQn01mWqoTMdrsG8dvxlpw+io+nxXnEo7B3V/yzL5bwb7yu7JpUdzxaeN5uLeO9zdSS5bz820+TpmTPzK8YRllSPEO3uqY2cvwjcw7nOvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEhGuvy4vBBb4a4BPgwJK3hIXIEPg0ygN7GlCKRmbh0=;
 b=dKZeCb9KrI8U9yvPfs5IA3ffOXsE6tSgB+Rva52xkSzPdQwR8Exg56H72/2DZ6eL7z781PWzSkZsNOW2tBulR2aIsAs+kuGSfa79u0XN5qP4GLDbiHPzm/ezCKH8TVM6Zc8US5uErADyXxtViETKTUCRH9jiX27Xld/ZhW4AZvC9nYbPC60dwhy/bY+B7zUvJZ1XFuTSJUXFHWrV+ISOTYQB/dHegwLS7dKdRO/Byz6gYPQB4RKn42Cr7CfKW1eQcN+oWcHz9YmMJcyQ2DvJU+Y/sBDwoC+WdZE/sGfMNpLmYq7bUG0zSx2+V0jQUB+d5zhmYJIDmBgCcV/fVtnedQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Fri, 20 Oct
 2023 17:05:25 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17%5]) with mapi id 15.20.6863.046; Fri, 20 Oct 2023
 17:05:25 +0000
Date:   Sat, 21 Oct 2023 01:05:11 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Ravi Jonnalagadda <ravis.opensrc@micron.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Ravi Jonnalagadda <ravis.opensrc@micron.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-mm@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <luto@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dietmar.eggemann@arm.com>,
        <vincent.guittot@linaro.org>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <arnd@arndb.de>, <akpm@linux-foundation.org>,
        <x86@kernel.org>, <aneesh.kumar@linux.ibm.com>,
        <gregory.price@memverge.com>, <ying.huang@intel.com>,
        <jgroves@micron.com>, <sthanneeru@micron.com>,
        <emirakhur@micron.com>, <vtanna@micron.com>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH 2/2] mm: mempolicy: Interleave policy for tiered memory
 nodes
Message-ID: <202310210005.51e08d62-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230927095002.10245-3-ravis.opensrc@micron.com>
X-ClientProxiedBy: SG2PR01CA0184.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::9) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH7PR11MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: b70af2ac-52d0-43d7-0a3f-08dbd18ec068
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5AN7kLlTlMBDmJIm+cyy25XA6fTIYhKe4d0DEfVymvV+aGv6nYcy8++SRZDjZCh7AjUOpjKkpM2Pa0e3roV7ZXqVBE+QcXzaAKWv5cu2/rPZ3HA9nO0B9CblxHJyIZBlxsoJL7KabDc7sqGjC+uLfxXIF/9kWKUr03MbHrShaVymzRCPzgSukm6o57v7+OJ8L5uBJtsnZ5Wn0+9SG4b0DbrLtAeeWC+9TIIbshSrzGHZ4GaR2AQwfAKrnY/LLQm2aBMw1CE0CxH/9kS+RMHhS9lKhSW5DInAlajlPIYazhc3CrrVttleHM1smBfVbdiWyreqONNnDHDSfztpxhoKpdp/y/5siEv2Kw99lw+TXVWNt/uZ6BA3cbQhHfenKcew9nwZ+la9lQagKQGC5yUylZdJ7ljOg6fnMV1WKoYRcrLeD/QNkdWcGGvO2cxQ5FRL2m12xqgnfvherIOMPMAsQdu73FHBme6Kkg4/ZOxBE53cdAmF8aChemIFog2z5uHIuO30//UtNpWi270ETtUobYVOyfvXdzQ97BoEO6rDMjkRsP4PY4eovCXZwyIcs6dgQlgOrj8T7W87DgaMu2TRvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(366004)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6916009)(2906002)(7416002)(316002)(86362001)(6666004)(66476007)(6512007)(38100700002)(82960400001)(26005)(6486002)(6506007)(66946007)(66556008)(5660300002)(83380400001)(478600001)(8936002)(1076003)(2616005)(41300700001)(36756003)(966005)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?owtu9CvqGTJH3vrakr4iebSkVCjkWUerUyXxPoOhm1HH1DaQeqR92hs7+Jz4?=
 =?us-ascii?Q?DLBsPfVXhEh+ILOI+8FC3Pod6o7oKljCNtIELrMxwhoiJzfxU6W2/VpM+OwF?=
 =?us-ascii?Q?RNW28kGaAxxbnRlzxT1Znq12WlvW6S46Gh+BQ/LVk2RAeIagskuyjWLrN8NW?=
 =?us-ascii?Q?/mHMHWHgzRUHNTZiAWZQG+m3qghVRYZ31J1fgsaqqdBjVczzOE7v54av04ME?=
 =?us-ascii?Q?SHDsB4rHs2X9+brbTLjPxHYOmMmDy/g6updNP40t/OAQdem3rUStXD9hN059?=
 =?us-ascii?Q?6HA5ep51K/yandygpJ+EpBIHoP3XBHaVB9TWXv8BldaBU30B1ozkyMXt97oQ?=
 =?us-ascii?Q?tdEpvEhkTduGSzEszTGwEUKHO6lwJskivaNW2NMKQFKHabZTMi0TqSQAv48J?=
 =?us-ascii?Q?hveC+x5jjjc1MoAH+f1u9g5gPW5ETpUl/yOY4SrrKMdCo021aG1G2PORMcR9?=
 =?us-ascii?Q?MaOk7xnrqruA8bfrPg7EQdy0thmHOkIlYCVi7yhaQC+KBwkmePZWejwDyC+6?=
 =?us-ascii?Q?6nnGPDNPExvvdnz7afV7WmT+08wwmJ/MmDfC6+uAO0WC71+j9IZ5KfawXaWz?=
 =?us-ascii?Q?foCLfq8IeJmsCmrt8x9XGO9oH4aBMLDJZcjawpd4G/bTV13MmAs2hiwZvZLC?=
 =?us-ascii?Q?d29nZNijutE1uo5XC29/x01WbFCLsDQY5nuGOgNkAtUf21ZtrlgdEAmrOoeR?=
 =?us-ascii?Q?WfhZ/Fd3m8e1psryXo32xN3VzDC471/K8d0Grq8TjsMo8u/zjhRkVyur2L9e?=
 =?us-ascii?Q?hxO7oojQ6jaOnI9B0N3z4Pwb/X1NVLGaNYAF0R4bxHKZDPM6sURW95bCGV4h?=
 =?us-ascii?Q?kjgBDV3mNNQ7/oid/sGImxWVpy7BvvYesATZX0U+bTuqLW/md+5bZ01QA0gI?=
 =?us-ascii?Q?RvnHSqjINjyFlob2maAU+429Og8xbk18KzTuqXww/M/3a2UcVI9M6vKmSA+p?=
 =?us-ascii?Q?HQGpM7VkQu9o/gxVWuXOSb3m65mI1HZCM6/xM9U98w5EOYsrL+2GSLNRTyO2?=
 =?us-ascii?Q?jjCF/EerWAD6YYfzhIfkFxyvH53vuQzSBC0epAMNL8aXerotlHlwuO7N9M9c?=
 =?us-ascii?Q?iX8Vd4NMkd96VFqnWO36EtmtdOM4qykxaBod2E3sW0Iv0iP+LV0nN3/ZVqJW?=
 =?us-ascii?Q?1KlaiphpAI+eoLVtTFK+25S+vimebKx69lAOWaIDDezuEhqJoL7xITRyH7rj?=
 =?us-ascii?Q?zlWy3t6nEmU4xigBQ64OruiZFaME56c2D4FkXtMK0RTY7L6dhBAJmHem2g+x?=
 =?us-ascii?Q?cWVHgIo+D2dQ1OhWqRtKhS4SECP93Y0AG589gXy0yAmgUsF+MF5yomYf65uP?=
 =?us-ascii?Q?DcUWInRXl61+TL8a2ka8GuwnGP+oGFpYF0iYn1HzsUW7JG2FDHvhsETALF2E?=
 =?us-ascii?Q?YcyXjM/qb7jX/2w1n7gqKRKZuI0dtIpysGpuo4rqraGDGgCtGB9QJ4bTaqX2?=
 =?us-ascii?Q?/tkh0yRaF+XYJNOjaO8ToNpcEdSLkF4uHhG1oTEOzqaaVjMpRwUxjLxcnhXl?=
 =?us-ascii?Q?mNtWrenim/z4fI5F0e5ijZe54MWO0/hdyr1Av9MGAoiB2dGqUyNhcVtjqo32?=
 =?us-ascii?Q?5rOWIsWJDWrt+x64GSgAOkVhy71JTnY3HsjQaovD+A2lcIR6S7iGSZfDOlwr?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b70af2ac-52d0-43d7-0a3f-08dbd18ec068
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 17:05:25.0202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Te1egKXmJuPEUDKMQL4uIuEdJwX2AJRFSswU8ENh3vZHeDrx6ZSX5gheg6Ng0s+xAkLFtEVSbAREGpfP61/LgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5941
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:suspicious_RCU_usage" on:

commit: 8536fe0dad4ce46984d207cd53583e7c36bc94b1 ("[PATCH 2/2] mm: mempolicy: Interleave policy for tiered memory nodes")
url: https://github.com/intel-lab-lkp/linux/commits/Ravi-Jonnalagadda/memory-tier-Introduce-sysfs-for-tier-interleave-weights/20230927-175208
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 612f769edd06a6e42f7cd72425488e68ddaeef0a
patch link: https://lore.kernel.org/all/20230927095002.10245-3-ravis.opensrc@micron.com/
patch subject: [PATCH 2/2] mm: mempolicy: Interleave policy for tiered memory nodes

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310210005.51e08d62-oliver.sang@intel.com


[    3.474923][    T0] WARNING: suspicious RCU usage
[    3.476322][    T0] 6.6.0-rc1-00038-g8536fe0dad4c #2 Not tainted
[    3.478100][    T0] -----------------------------
[    3.480319][    T0] mm/memory-tiers.c:258 suspicious rcu_dereference_check() usage!
[    3.482562][    T0]
[    3.482562][    T0] other info that might help us debug this:
[    3.482562][    T0]
[    3.484325][    T0]
[    3.484325][    T0] rcu_scheduler_active = 1, debug_locks = 1
[    3.488321][    T0] no locks held by swapper/0/0.
[    3.489732][    T0]
[    3.489732][    T0] stack backtrace:
[    3.491424][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.6.0-rc1-00038-g8536fe0dad4c #2
[    3.492304][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    3.492304][    T0] Call Trace:
[    3.492304][    T0]  <TASK>
[ 3.492304][ T0] dump_stack_lvl (kbuild/src/rand-x86_64-3/lib/dump_stack.c:107) 
[ 3.492304][ T0] lockdep_rcu_suspicious (kbuild/src/rand-x86_64-3/include/linux/context_tracking.h:153 kbuild/src/rand-x86_64-3/kernel/locking/lockdep.c:6712) 
[ 3.492304][ T0] node_get_memory_tier (kbuild/src/rand-x86_64-3/mm/memory-tiers.c:258 (discriminator 11)) 
[ 3.492304][ T0] node_interleave_weight (kbuild/src/rand-x86_64-3/mm/mempolicy.c:1921) 
[ 3.492304][ T0] ? __orc_find (kbuild/src/rand-x86_64-3/arch/x86/kernel/unwind_orc.c:110) 
[ 3.492304][ T0] ? secondary_startup_64_no_verify (kbuild/src/rand-x86_64-3/arch/x86/kernel/head_64.S:433) 
[ 3.492304][ T0] ? orc_find (kbuild/src/rand-x86_64-3/arch/x86/kernel/unwind_orc.c:242) 
[ 3.492304][ T0] ? secondary_startup_64_no_verify (kbuild/src/rand-x86_64-3/arch/x86/kernel/head_64.S:433) 
[ 3.492304][ T0] ? secondary_startup_64_no_verify (kbuild/src/rand-x86_64-3/arch/x86/kernel/head_64.S:433) 
[ 3.492304][ T0] ? unwind_next_frame (kbuild/src/rand-x86_64-3/arch/x86/kernel/unwind_orc.c:682) 
[ 3.492304][ T0] interleave_nodes (kbuild/src/rand-x86_64-3/mm/mempolicy.c:1969) 
[ 3.492304][ T0] mempolicy_slab_node (kbuild/src/rand-x86_64-3/mm/mempolicy.c:2007) 
[ 3.492304][ T0] __slab_alloc_node+0x195/0x320 
[ 3.492304][ T0] slab_alloc_node+0x67/0x160 
[ 3.492304][ T0] kmem_cache_alloc_node (kbuild/src/rand-x86_64-3/mm/slub.c:3525) 
[ 3.492304][ T0] dup_task_struct (kbuild/src/rand-x86_64-3/kernel/fork.c:173 kbuild/src/rand-x86_64-3/kernel/fork.c:1110) 
[ 3.492304][ T0] copy_process (kbuild/src/rand-x86_64-3/kernel/fork.c:2327) 
[ 3.492304][ T0] ? kvm_sched_clock_read (kbuild/src/rand-x86_64-3/arch/x86/kernel/kvmclock.c:91) 
[ 3.492304][ T0] kernel_clone (kbuild/src/rand-x86_64-3/include/linux/random.h:26 kbuild/src/rand-x86_64-3/kernel/fork.c:2910) 
[ 3.492304][ T0] ? rest_init (kbuild/src/rand-x86_64-3/init/main.c:1429) 
[ 3.492304][ T0] user_mode_thread (kbuild/src/rand-x86_64-3/kernel/fork.c:2988) 
[ 3.492304][ T0] ? rest_init (kbuild/src/rand-x86_64-3/init/main.c:1429) 
[ 3.492304][ T0] rest_init (kbuild/src/rand-x86_64-3/init/main.c:691) 
[ 3.492304][ T0] ? acpi_enable_subsystem (kbuild/src/rand-x86_64-3/drivers/acpi/acpica/utxfinit.c:192) 
[ 3.492304][ T0] arch_call_rest_init+0xf/0x20 
[ 3.492304][ T0] start_kernel (kbuild/src/rand-x86_64-3/init/main.c:1019 (discriminator 1)) 
[ 3.492304][ T0] x86_64_start_reservations (kbuild/src/rand-x86_64-3/arch/x86/kernel/head64.c:544) 
[ 3.492304][ T0] x86_64_start_kernel (kbuild/src/rand-x86_64-3/arch/x86/kernel/head64.c:486 (discriminator 17)) 
[ 3.492304][ T0] secondary_startup_64_no_verify (kbuild/src/rand-x86_64-3/arch/x86/kernel/head_64.S:433) 
[    3.492304][    T0]  </TASK>



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231021/202310210005.51e08d62-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

