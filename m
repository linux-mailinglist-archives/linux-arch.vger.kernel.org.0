Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2867B7BCCE8
	for <lists+linux-arch@lfdr.de>; Sun,  8 Oct 2023 09:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjJHHI3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 8 Oct 2023 03:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJHHI2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 8 Oct 2023 03:08:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8934EB9;
        Sun,  8 Oct 2023 00:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696748906; x=1728284906;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=KTPw61wG3P2AJ1S8Su/VEBjqtFfzGDoGvaQfHfCkP0Y=;
  b=eTTXDHYHYJND0KVe0nfs+/PugxYTcBxMGiWYMZVZSQqihVFdOow/eAsz
   f0Dfy6nou6difX40i2q+Yqkhgr8oC6wOzljlT4uFzxmXbtuUMdBz6HMrz
   qGVdRaTPotug/qjnkEYu1DEnsP0E1dp+zmAZCWPB5rQ+jnTwGD1mxh28P
   aUN22ohaN+zmumLl0XnclvjhrrVJfdazXJFQ7IEODUTEyZw4bPlmB0NNj
   HVwQHzsV4ycJPqddxRVZlfVmY5E7EbYJbH+wt55S6QJ2iiXPx/9XPcnRy
   RK6SPggTiOjp1WRjd0w3Kt/lhhRdU8pVP87ZcGpv1SNzbQJId6owKodnM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="387848584"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="387848584"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 00:08:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="752678421"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="752678421"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2023 00:08:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 00:08:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 00:08:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 8 Oct 2023 00:08:24 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 00:08:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Obplx7aHMqd8zw0r6atlPzxG9lYN6NyqF0H6T7OJKq5MP3K/JezQFnWqxzoKQN/BLQTlWSuPCufnpcZhENmkw5cP2sgTzjwsjIhbdimdWZtsdmDR54xiP7Vd4zEEqt6oK1rtwv8JRLucqjO22WbcEljp/xXk7Tttmyxm3nTQrmGnDHS5fbuVFQY6ejT8bK3C/nkiePRzWS70aZ6PSI4kXsOdSBbwyyI1QE4VSaVpQvRfMHlM2FknxKFr4a5dHYdXPwZQ30CZx9UJE/iqCGwdQmQyKXlCxWpccoAiwHjgRVlhHUalgkWLyXKOJKwPqAH/ixG4Qxd5IST1g+Eqk5WiPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhFzym9O+b3WidHBZ7unSrVRSPWR9LHcPIIIk1ZYtVA=;
 b=XQEAilzl5BFc9MA3YFEH9WXkBIVtEYvGG6XsestILAP7D4I/QTE2/0BUYXNEHip8lxf8EWJfYCXth2QChHYT3nsPb1TrtoRYWCAmriypDWCiB4e73l+jhBiK5lgAUv+N0PLYtHpy3YlKWxlP+OESHTlHprZxMWB6y34/KZtzYgB6a0Ght37tGacjeYz79zaKv3wG+uesqUIfLDZMAElotHJZbgK6qHQSEsgwIYt+3OoVi67qM5aMvDKzjOzcudqJmUJnDI4wZiRegATGwMRvMR1al4VMEI3CCQN6qEYYq6EHTgqx5RWGTssO+wTfteyZCIGmFGoc3DSeUR6FP7tGDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH8PR11MB7990.namprd11.prod.outlook.com (2603:10b6:510:259::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Sun, 8 Oct
 2023 07:08:22 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6838.029; Sun, 8 Oct 2023
 07:08:22 +0000
Date:   Sun, 8 Oct 2023 15:08:09 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        <linux-alpha@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-ia64@vger.kernel.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-mips@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
        <linux-sh@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [tip:locking/core] [futex]  cb8c4312af:
 will-it-scale.per_process_ops -3.2% regression
Message-ID: <202310081429.a30c99f2-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH8PR11MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a134e3-49c4-41f4-a2af-08dbc7cd5b99
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9OmmVcCBow4Bm24+KZa/qQ2iVNoihIp1u02ICfFD/rhaQr5KQw0Ty2hEAnjwsd/Q6p3jicO4BCE274N1JNPhOWCdguxyjJ5UTPKY+JtPxAwfmv/NIdyYlPzB+9Yr0vOjFNnZ2pa7doK8RBTR2MepAAyj4VXV382vOzUfoDz5tnDqUvI8x4Z5T0mxox5ooQFuUKXYS7WZ/nEbSWsIT3pCQHppTskf1vaxjCwnUhUDD+UEHEBTevOWhP9LCmzQ/Ca9oU628RpooeQA52X2R+ysCEqMzTkN2Vu/Xyq4AHKg8sbo7JSAFHKTh9eJQfdJ5nAt+W+wXhCQRMtQyaNbKxHvj0iqLJsFUHlGyvwLMk9+ugWQIgYzNN7fGqIe+WfVVSZfTERtQC610ko0vL3QpbqEwD810u5KJdM40F1M36+pMxdPUoHEsIPpe8GhJ4DFDtSo6lLdq0YW/ViAn0WecODy8J5V4EdmpHJ6WUSg+SoNSIdqjvkJ8FUffOC9Q4+YnPjgSji6yneKyiph3nrYwTkYbKIl+vSNbAT3lOgvtPQBLWYIEZYz/EgkWWwk3/5vXBbdfQOEEt4Uvyn7s4VvseDhUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(38100700002)(82960400001)(86362001)(36756003)(2906002)(6512007)(6486002)(966005)(478600001)(41300700001)(5660300002)(8936002)(4326008)(8676002)(6666004)(6506007)(83380400001)(2616005)(1076003)(107886003)(66556008)(66476007)(66946007)(7416002)(54906003)(316002)(6916009)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MFmQud+Y7tiLvhLsVjPZ8tQSr9eXTf2exHjXqPZaZoEpuzDF89NU8NuLpP?=
 =?iso-8859-1?Q?6qfFqQdenjQBqe8as7s+9csAcbKSpkjhgfZh9Ra8KJtkUcqN6O2ug4OlSK?=
 =?iso-8859-1?Q?JfIjtElexBmEILLtucjgOj4mh3yBjqsvPsF6M7UFl967vWczgLQQqmOtpU?=
 =?iso-8859-1?Q?t6uSj0KbVC42zbQTilS/upUPzkChpJrzN15sbmTsMrAwhbjLXOp1afbhR/?=
 =?iso-8859-1?Q?m5mCfmwYNcVRV9p15AO0dWGjisTiTxtOLDbQSD/zWC1lXVlo8DnxBu3SAM?=
 =?iso-8859-1?Q?ERom4L+b8Yi1ENPVDBXLBy/YF64mCA69eKdPMenZ3HWTGVioctdDdw8d22?=
 =?iso-8859-1?Q?e/0J7yP6MHqUtageFCUI6VDSBp53J7wUMU5HtwoHpE/bDDtvEw4tbyvMSy?=
 =?iso-8859-1?Q?2cEHXpg5DL/Z0se/UIt3zzC6CgY47loalTjUoUfVK3HBSMxxL5JQaGckof?=
 =?iso-8859-1?Q?fgJfda9OXTkqD1v7EMNtiDB7S7gHTPFr9xTSjBt4Q4C1og8GA9TyzvttL9?=
 =?iso-8859-1?Q?7qP/Z876sbVHSZYCkR29eXXWDgDZ0sI8pBAEoxRGPxputSaEPYZhfW5DHR?=
 =?iso-8859-1?Q?9BgZ8THA4U2pxCj8O46/WYe9DchHxbfF0cKytyxmKH24ygjGP6lMvm77mh?=
 =?iso-8859-1?Q?0xsbP811Ssu1I2w8e1fWbndN8Po+eSI0mPijCI625PkpMDHIyn7Ymd0eh8?=
 =?iso-8859-1?Q?XbS8InZzutL8G2WZrrJCT0ogV0kjz164/z9gb0VaBrykInD+utWWoPg/oO?=
 =?iso-8859-1?Q?FDhHf8vofqcpDXrAu5x9FQSln1Waz1X9vSVzmWAc8PjPG3VvRawzTK/ceT?=
 =?iso-8859-1?Q?i7bfmcFvoQJFmzo0UA7tis/JDGEInlYOkIGcod09QucQf1KO4yt1w2kbfr?=
 =?iso-8859-1?Q?VNyXXgsIRO4mG0Mk940DVswFNX6g2BX+CcqyK8VPQTfoRQHj/i+WfThOuC?=
 =?iso-8859-1?Q?8Y6w1rkGcAY0fXlAJN0MSdxFGdSDovL8LHaWV3m7qTXiconWG0T9SvoCNl?=
 =?iso-8859-1?Q?1CQYcyVB/cBcK28i70gKbbewN95NMt47VkC9K2DIeLbECuoQvOEMhGOfCM?=
 =?iso-8859-1?Q?Vdx9xre1O7vO5BwearrywN/LKNb08UafZY60p+oRwsO43wCu1aBhdMdk8G?=
 =?iso-8859-1?Q?s1E/ob07cfuFmBAkMxm06FkwOiqyKm4Fya7nWPZuC89zLyaRz/WPV7WcQ2?=
 =?iso-8859-1?Q?eEoCkeSL0dC3dVhHgBxt6GjNE+SGm1gFhCpJlbr9Xk0QpE3mcfZtT3IBzv?=
 =?iso-8859-1?Q?Dh07XCrl9PbT4/hEQLzHCOjSQy3ElNoki5lhipwvZz64Oi/oIrvPqlGwGR?=
 =?iso-8859-1?Q?qsYBmL6DaEQ30zaYA15RidEFOA9yQVF6qNET9oLeziKUiN5bIwoNg5aZF9?=
 =?iso-8859-1?Q?/XnHtZavccLzk8Rrr8dwC2GqD2rTVKYRAmLJdUowX7yJL2xsp5O0jB0h1C?=
 =?iso-8859-1?Q?W37Zo0JqmPZ3Wib1vi1SEYW91p9E7kuns+LzrWQjexINnjWvqqCE7sc/om?=
 =?iso-8859-1?Q?MeOGqj3oE9HGQ+/tkbZmyGd1VdCgqBbKr2ADwVVE5ccAI+NKr8UHiHKi4y?=
 =?iso-8859-1?Q?05DNpCBZ0U8Kt/Axn7l0kILt7xfDXmy61b6/WRUyCWXaz1T+KdHNSiUuFW?=
 =?iso-8859-1?Q?8r3PCz8ZDiFqcjqdmapIBoCT5wiUNXJyzVenRLJxaBdGTLjiSY9d3OZQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a134e3-49c4-41f4-a2af-08dbc7cd5b99
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 07:08:22.5068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hqjiYDg1PF97YTfwF7G9jXGsMLXFp5CoW/x11mvlZS4xJRFuzF4FKNq26kIszVcF5nI63HUCMRTRxZSm+8JVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7990
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Hello,

kernel test robot noticed a -3.2% regression of will-it-scale.per_process_ops on:


commit: cb8c4312afca1b2dc64107e7e7cea81911055612 ("futex: Add sys_futex_wait()")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git locking/core

testcase: will-it-scale
test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
parameters:

	nr_task: 16
	mode: process
	test: futex4
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310081429.a30c99f2-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231008/202310081429.a30c99f2-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/16/debian-11.1-x86_64-20220510.cgz/lkp-cpl-4sp2/futex4/will-it-scale

commit: 
  43adf84495 ("futex: FLAGS_STRICT")
  cb8c4312af ("futex: Add sys_futex_wait()")

43adf844951084c2 cb8c4312afca1b2dc64107e7e7c 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 1.339e+08            -3.2%  1.296e+08        will-it-scale.16.processes
   8367312            -3.2%    8102637        will-it-scale.per_process_ops
 1.339e+08            -3.2%  1.296e+08        will-it-scale.workload
      0.61            -0.0        0.59        perf-stat.i.branch-miss-rate%
  72599095            -2.7%   70647352        perf-stat.i.branch-misses
      0.80            -1.8%       0.79        perf-stat.i.cpi
 2.073e+10            +3.8%  2.152e+10        perf-stat.i.dTLB-loads
  1.72e+10            +2.2%  1.757e+10        perf-stat.i.dTLB-stores
  66739031            -5.4%   63102078        perf-stat.i.iTLB-load-misses
   2080892            +2.4%    2131032        perf-stat.i.iTLB-loads
 8.203e+10            +1.6%  8.337e+10        perf-stat.i.instructions
      1231            +7.3%       1321        perf-stat.i.instructions-per-iTLB-miss
      1.24            +1.8%       1.27        perf-stat.i.ipc
    222.58            +2.4%     227.82        perf-stat.i.metric.M/sec
      0.61            -0.0        0.59        perf-stat.overall.branch-miss-rate%
      0.80            -1.8%       0.79        perf-stat.overall.cpi
      1229            +7.5%       1321        perf-stat.overall.instructions-per-iTLB-miss
      1.24            +1.8%       1.27        perf-stat.overall.ipc
    184025            +4.9%     193123        perf-stat.overall.path-length
  72373935            -2.7%   70427711        perf-stat.ps.branch-misses
 2.066e+10            +3.8%  2.144e+10        perf-stat.ps.dTLB-loads
 1.714e+10            +2.2%  1.751e+10        perf-stat.ps.dTLB-stores
  66517376            -5.5%   62888454        perf-stat.ps.iTLB-load-misses
   2073911            +2.4%    2123876        perf-stat.ps.iTLB-loads
 8.175e+10            +1.6%  8.309e+10        perf-stat.ps.instructions
 2.464e+13            +1.6%  2.504e+13        perf-stat.total.instructions
     29.29 ±  2%     -29.3        0.00        perf-profile.calltrace.cycles-pp.futex_wait_setup.futex_wait.do_futex.__x64_sys_futex.do_syscall_64
     12.17 ±  2%     -12.2        0.00        perf-profile.calltrace.cycles-pp.futex_q_lock.futex_wait_setup.futex_wait.do_futex.__x64_sys_futex
      9.21 ±  2%      -9.2        0.00        perf-profile.calltrace.cycles-pp.futex_get_value_locked.futex_wait_setup.futex_wait.do_futex.__x64_sys_futex
      6.61 ±  2%      -6.6        0.00        perf-profile.calltrace.cycles-pp.__get_user_nocheck_4.futex_get_value_locked.futex_wait_setup.futex_wait.do_futex
      2.03 ±  2%      -0.1        1.88 ±  3%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      0.00            +2.0        1.98 ±  4%  perf-profile.calltrace.cycles-pp.get_futex_key.futex_wait_setup.__futex_wait.futex_wait.do_futex
      0.00            +4.0        3.96 ±  3%  perf-profile.calltrace.cycles-pp.futex_q_unlock.futex_wait_setup.__futex_wait.futex_wait.do_futex
      0.00            +4.1        4.09 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.futex_q_lock.futex_wait_setup.__futex_wait.futex_wait
      0.00            +4.4        4.35 ±  3%  perf-profile.calltrace.cycles-pp.futex_hash.futex_q_lock.futex_wait_setup.__futex_wait.futex_wait
      0.00            +6.1        6.14 ±  3%  perf-profile.calltrace.cycles-pp.__get_user_nocheck_4.futex_get_value_locked.futex_wait_setup.__futex_wait.futex_wait
      0.00            +8.5        8.52 ±  3%  perf-profile.calltrace.cycles-pp.futex_get_value_locked.futex_wait_setup.__futex_wait.futex_wait.do_futex
      0.00           +11.3       11.27 ±  3%  perf-profile.calltrace.cycles-pp.futex_q_lock.futex_wait_setup.__futex_wait.futex_wait.do_futex
      0.00           +27.4       27.44 ±  3%  perf-profile.calltrace.cycles-pp.futex_wait_setup.__futex_wait.futex_wait.do_futex.__x64_sys_futex
      0.00           +31.3       31.33 ±  3%  perf-profile.calltrace.cycles-pp.__futex_wait.futex_wait.do_futex.__x64_sys_futex.do_syscall_64
     29.80 ±  2%      -1.9       27.91 ±  3%  perf-profile.children.cycles-pp.futex_wait_setup
     12.68 ±  2%      -0.9       11.74 ±  3%  perf-profile.children.cycles-pp.futex_q_lock
      7.49 ±  2%      -0.6        6.93 ±  3%  perf-profile.children.cycles-pp.__get_user_nocheck_4
      4.38 ±  2%      -0.4        3.96 ±  3%  perf-profile.children.cycles-pp.futex_q_unlock
      4.74 ±  2%      -0.4        4.35 ±  3%  perf-profile.children.cycles-pp.futex_hash
      4.62 ±  2%      -0.3        4.33 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.48 ±  3%      -0.2        0.32 ±  5%  perf-profile.children.cycles-pp.futex_setup_timer
      1.71 ±  2%      -0.1        1.57 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      1.24 ±  3%      -0.1        1.14 ±  4%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.52 ±  5%      -0.0        0.47 ±  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.35 ±  3%      -0.0        0.31 ±  3%  perf-profile.children.cycles-pp.syscall@plt
      0.00           +31.5       31.46 ±  3%  perf-profile.children.cycles-pp.__futex_wait
      7.88 ±  2%      -2.4        5.48 ±  2%  perf-profile.self.cycles-pp.futex_wait
     10.37 ±  3%      -0.9        9.46 ±  3%  perf-profile.self.cycles-pp.syscall
      7.46 ±  2%      -0.6        6.91 ±  3%  perf-profile.self.cycles-pp.__get_user_nocheck_4
      4.20 ±  2%      -0.4        3.78 ±  3%  perf-profile.self.cycles-pp.futex_q_unlock
      4.56 ±  2%      -0.4        4.19 ±  3%  perf-profile.self.cycles-pp.futex_hash
      4.44 ±  2%      -0.3        4.16 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      3.54 ±  2%      -0.2        3.29 ±  3%  perf-profile.self.cycles-pp.futex_q_lock
      1.71 ±  2%      -0.1        1.57 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.40 ±  3%      -0.1        0.32 ±  5%  perf-profile.self.cycles-pp.futex_setup_timer
      1.18            -0.1        1.10 ±  3%  perf-profile.self.cycles-pp.do_syscall_64
      1.00            -0.1        0.94 ±  4%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      2.14 ±  3%      +0.2        2.31 ±  3%  perf-profile.self.cycles-pp.__x64_sys_futex
      0.00            +3.5        3.50 ±  3%  perf-profile.self.cycles-pp.__futex_wait




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

