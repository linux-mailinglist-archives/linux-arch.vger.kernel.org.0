Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5994759A9F7
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 02:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242718AbiHTAUr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 20:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242543AbiHTAUq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 20:20:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3B5B14F4;
        Fri, 19 Aug 2022 17:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660954845; x=1692490845;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ppiNH3/8zOgRRZ4VODvQXyt9/aa99fZxQF+1AoKV3C4=;
  b=PEeX0nJXOhEcy7TS1Qg7b7Twv6BvMDQGMvweKXdyNRoam6AGLyKUWOk1
   csUjv/Lnchbo+nGnAYhHB1Ns/+LwR+sjdcHJgr2bKifLPtp43dvDZuWby
   0ltOYRUyn8l09HqCZN8BMa3JRoD4jaqc/H4eGq2FeBcjebkYJaazUYUqd
   I6jGbmkdHUvSlrwcniD5AEjvPtVC23eOLag1zvE9loDkKoLfnUV5z88bK
   /XhW7evIjPhj8nOaBApk8rH9T+zZREr5Hx2RSbWOI0lZX6Z0Ydshv8n72
   P7QOWuf4UbuZNwDvkMxJQbUFNu104J3J98POQ+XDMkLifhiHb1+7wJrB1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="280094158"
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="280094158"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 17:20:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="641430077"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 19 Aug 2022 17:20:45 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 19 Aug 2022 17:20:44 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 19 Aug 2022 17:20:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 19 Aug 2022 17:20:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Fri, 19 Aug 2022 17:20:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iF/NUiW5Zb1Dcemf32LDFfMQA0RlvcbRx/iflhZen8ie8MkD8l1LIROh00vK7yl4Agzt5mQv+rQm6RMdnsBm2IxxvRlF30IxQw1BOnR1Mlz5YM1ACdoBlVgbAuOwFl/WuPqwxFCaXpfSqeJ3D+s+OicHFjuOXuP4FAZal9byrurlNRRscVzIwmrSyq4Fs0qZLiyZAnua1CNHbLHw5Tm5a99rp4gnn0LY21SADBEQoU3SgzFqkDZTAaOuDh9X3/BqdHCEjCSJJyMvh9Lx6BPvd4iKsCLklCggOALbaOb9jKv6bsOc+5W5IB/nRwFZkzXXJjBXw5saiMRY+fnZ1Fzqog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dj9ayF6dFNAH75gZUg8M4OzxDWAcvRfKdnCPKagkT9k=;
 b=FQ6VIfRK6GL3O2TaE7rks71q4q4knSi8VRjbCcFjoSX2cnASpsi5f8gxettm0mWPjh7ApE8PBezIo9PHQRzMRGLMhJMGwUp8Q8H1+9D7EiQ3ZmqDwfvWTrNJiYUsUfNEBCL2LmWhoQ+qRen3xzoHvWbBX+dpWchlJdDQbN3R59m3NYjLjiYSnlRaODCg16eO6fONxJT1decQH7Zsf4zAkYqP7PZCs9UFdYNw17Y9UwqxiUWfL7TzWZtNX4jEpbTsPpioNzpNSwocnm/VxGDH+odkUCiss9NoYy4okvATOmFPWVtilUfiAOXJEQiOi1sT1fESVzklF9HMll2lVg0LdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BN8PR11MB3571.namprd11.prod.outlook.com (2603:10b6:408:8f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Sat, 20 Aug
 2022 00:20:41 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4ef:8e90:8ed9:870]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4ef:8e90:8ed9:870%5]) with mapi id 15.20.5525.011; Sat, 20 Aug 2022
 00:20:41 +0000
Date:   Fri, 19 Aug 2022 17:20:36 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <linux-arch@vger.kernel.org>, <dan.j.williams@intel.com>,
        <peterz@infradead.org>, <mark.rutland@arm.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <a.manzanares@samsung.com>, <bwidawsk@kernel.org>,
        <alison.schofield@intel.com>, <linux-cxl@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <x86@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arch/cacheflush: Introduce flush_all_caches()
Message-ID: <YwAo1Ec13hjiBOat@iweiny-desk3>
References: <20220819171024.1766857-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220819171024.1766857-1-dave@stgolabs.net>
X-ClientProxiedBy: BY3PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:217::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d1a30ed-6e64-4e91-0279-08da8241d0a6
X-MS-TrafficTypeDiagnostic: BN8PR11MB3571:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pf7LOt/rgBg2pf7VhiPSWo7hX59vP34PdZ4dFetr7KYvNMvtGPMAJ9U+Yfiq3NlQIJrKda3DYCl//QrZDAOtcM2aEISNd8/dr45yMBGFsQcuVHRL0FXhfDQK3rqaIEv+WQkQ8+1Mny2q26GRxls+l5w7DWHmo4ZQGltW1801o6zKYpMts06vum71u3BQgctICYCmzVb8YI0R1PYCwz7kWuzx4OjU7wAz+7RD4xVoyRU66HOCFB7iUNPfO+4pjB0kVSWLnY9fAvIWFfJj3zkoWWRb8VjLq9HqGJNYJ2M4RGe9RXTopEc6pKHgDRib5QAj86dNvUWS1FcoVbal7dur4gt+LG8h/sAmTQZC/rQcCmfGVXfsTaYOVaAv2ll7ytesHC1tkn/RfJoawR42EwMPNsnLk7ECzZwgB1emnJEDItMk+pwEQ2UbpZT0sjPY3E8kW6CYkFn81BApPZmpjxL07iMJIV75WdyDsqF/k4/hF4FPGfoxzIZzimkW/nOQS4jsNTV553xXlnXf1Az4px7pPedvmR6WL31KJbXAoH8Bcs3iB5bBVocNIWiw3wMpLw4sp82CUzUoPAjmGEJ7nFs3yseUdvmvYPMnAvoD3/01cUM4PsrO3mcLrKfjO8rug6lwY7DyneWEmYijIpp6sZKv0x5qpBqbg3n08COc6aTpGyjQ5FuncYy6EH4Bvmzy4cIfIqlFh7Zo9Zjo+dWMcJHqRnuxN17ItNPeMyQe6xMuPIlb3EicSA6PAJSyLtRj3j1h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(366004)(346002)(396003)(39860400002)(376002)(7416002)(6916009)(38100700002)(86362001)(83380400001)(186003)(8676002)(6486002)(66476007)(66946007)(66556008)(4326008)(316002)(82960400001)(8936002)(5660300002)(44832011)(9686003)(6506007)(2906002)(26005)(478600001)(41300700001)(6666004)(33716001)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?30d0/F33/EI060Ajh8CVZ54ngsmKjzoLd94XOufO2+OTsbTzIOe+lHGDM09j?=
 =?us-ascii?Q?0d0TDy/94jIHnWEgwa1iSCqwZzT2ODHpDETcYuH0L/qy1x0Wn/BzOvFDJJD8?=
 =?us-ascii?Q?5K+LZdXgjX/j96UEW1rSyM0QhD1pI5cNMzreu44tf9NjzQ+hf4BHhj8SZM2v?=
 =?us-ascii?Q?EEzTVLAQkZkM9x/iN+tMBbv08e+vBEKskTJRtzss35yx2Fj9PKicpNZ/uot2?=
 =?us-ascii?Q?1bYAChidhkp25uDbNzMh2vabG+zYhiynYzNV4oXxzpYhMKGnXLw+tIdwRYLd?=
 =?us-ascii?Q?paT8EHPKzNMJyn0ZuQBxrI5yjSFPad+viHlyCvied23tgH6DtO35tblpmFYQ?=
 =?us-ascii?Q?n7ZIhIGuAb8mgmEL1RvcQqNMPMbjsmiOHsVUdI0P88k0OqzTP5Tm++/Pzyph?=
 =?us-ascii?Q?Bs6asYOfFZhBaDCBzJ3J/gFrGX4bCcL4uQGeHV+d7mWhUcduUe7kEJqAf7aw?=
 =?us-ascii?Q?wiBZsfJ7QdXyr+t8ZFVmjnIAY8oZ+KElg3LcGmnZ6Y9OQs8guxAEUJ3kGXy5?=
 =?us-ascii?Q?DoXsjrjK29mtTp+yo2dllCOjG9G6wknB7SHiPnXXqo79FuhnjoTr7rToP1l9?=
 =?us-ascii?Q?xu9FZe3tHrskigAwPBRjgByhG2VczR4MgrXmYHzgpRP/pri1tlES2pylAzTS?=
 =?us-ascii?Q?iLlq9SeWsLCkiuPXHezTWlN4qe7zS3q8Wll6I2GBEhzvyIxIV27/HcN18nuL?=
 =?us-ascii?Q?ReNlctoRD+1qhwUfuaSmFbxqAfNZ5k55JBQCC+SJE35LXMxLEpdt+8dbE1qa?=
 =?us-ascii?Q?oV6RN/5yvR8PlVQz1xiDv+cGlrXAtZzPzoHoaT48F/DPqCYHaaraZj5d66YE?=
 =?us-ascii?Q?eKT4puCwMamABLNL8lTmA1oDB+LZ2bAdjBrg5Q9U9yRTSdfNq/VHDbiymjzG?=
 =?us-ascii?Q?ZsEl2qmBFVp6IwkhvKGQ35bXfLbpIUVAJDyaZzzQUZUunFCWN4e6cyKz9y1r?=
 =?us-ascii?Q?GPxO+QmS2bs8Yn1UFKx/DWfMrDBJJWwo0NCRl+ZaYEcJ9xtnmbQHQGqkLnMj?=
 =?us-ascii?Q?ubBz/RuE9Jm26RUHJRGBSgM5R2ovWC6mC95Wc74X2ABXNpiYgVq7NjXEp1Tn?=
 =?us-ascii?Q?lA9cDS249TOMHoLkIM5TTmlkpP5rmMeFf+qCyZon8JbatFANssLQWVun/qm6?=
 =?us-ascii?Q?2b7L2B4yAPZpSdfBZEDE4fbfUUcVwR0tDZ0uB/0Zb2c7g2gBHGcNVKvi+TWu?=
 =?us-ascii?Q?SIz0gvdEF8dh8JOsGQ0u2IHv6rMgnbrgc0WLjQVdsqxc/hpN3GJcpuFblSWp?=
 =?us-ascii?Q?xUeRXixvBtItTxdp+HKNQao/QdrT8Db5HUZ8ZcJOglVjbxtT97fiWIXBw+62?=
 =?us-ascii?Q?IaAB03P5r7bOIhfoZFRnleQoiuSU1rga1nUxt+WFz5hu82SYQnCQRa9Xfsyu?=
 =?us-ascii?Q?Os1GEL5Qo0A77QwddLxs5PyppxXE+v50Hf9+1IWvg7Vc+X3StdfoOklkmhaH?=
 =?us-ascii?Q?UfqGhiI0gnNsVL6qff6C0HmYWSfPjYGmfWABhmYlNLcWkh1unVd5Xp6l2vYB?=
 =?us-ascii?Q?3dL5NrUIVnxWLGBH1X4XVYayHjkUIg6n87/HM5hoXfLR9n++m9n5QYDYDO6F?=
 =?us-ascii?Q?Ceqan+S3zvdXr2RHu7aud18aFjeU0DuNIq0sx0wJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1a30ed-6e64-4e91-0279-08da8241d0a6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2022 00:20:41.2309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1qgSnbd/jSfOIBSnTmNM446d6rHUjkMX/3/GqYYAyvvqyzaU5qREV8X6ftj1FcpkwRVJsd8Qn4B4VOV6caXVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3571
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 19, 2022 at 10:10:24AM -0700, Davidlohr Bueso wrote:
> With CXL security features, global CPU cache flushing nvdimm requirements
> are no longer specific to that subsystem, even beyond the scope of
> security_ops. CXL will need such semantics for features not necessarily
> limited to persistent memory.
> 
> The functionality this is enabling is to be able to instantaneously
> secure erase potentially terabytes of memory at once and the kernel
> needs to be sure that none of the data from before the secure is still
> present in the cache. It is also used when unlocking a memory device
> where speculative reads and firmware accesses could have cached poison
> from before the device was unlocked.
> 
> This capability is typically only used once per-boot (for unlock), or
> once per bare metal provisioning event (secure erase), like when handing
> off the system to another tenant or decomissioning a device. That small
> scope plus the fact that none of this is available to a VM limits the
> potential damage.
> 
> While the scope of this is for physical address space, add a new
> flush_all_caches() in cacheflush headers such that each architecture
> can define it, when capable. For x86 just use the wbinvd hammer and
> prevent any other arch from being capable.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> 
> Changes from v1 (https://lore.kernel.org/all/20220815160706.tqd42dv24tgb7x7y@offworld/):
> - Added comments and improved changelog to reflect this is
>   routine should be avoided and not considered a general API (Peter, Dan).
> 
>  arch/x86/include/asm/cacheflush.h |  4 +++
>  drivers/acpi/nfit/intel.c         | 41 ++++++++++++++-----------------
>  include/asm-generic/cacheflush.h  | 31 +++++++++++++++++++++++
>  3 files changed, 53 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
> index b192d917a6d0..ac4d4fd4e508 100644
> --- a/arch/x86/include/asm/cacheflush.h
> +++ b/arch/x86/include/asm/cacheflush.h
> @@ -10,4 +10,8 @@
>  
>  void clflush_cache_range(void *addr, unsigned int size);
>  
> +/* see comments in the stub version */
> +#define flush_all_caches() \
> +	do { wbinvd_on_all_cpus(); } while(0)
> +
>  #endif /* _ASM_X86_CACHEFLUSH_H */
> diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
> index 8dd792a55730..f2f6c31e6ab7 100644
> --- a/drivers/acpi/nfit/intel.c
> +++ b/drivers/acpi/nfit/intel.c
> @@ -4,6 +4,7 @@
>  #include <linux/ndctl.h>
>  #include <linux/acpi.h>
>  #include <asm/smp.h>
> +#include <linux/cacheflush.h>
>  #include "intel.h"
>  #include "nfit.h"
>  
> @@ -190,8 +191,6 @@ static int intel_security_change_key(struct nvdimm *nvdimm,
>  	}
>  }
>  
> -static void nvdimm_invalidate_cache(void);
> -
>  static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
>  		const struct nvdimm_key_data *key_data)
>  {
> @@ -210,6 +209,9 @@ static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
>  	};
>  	int rc;
>  
> +	if (!flush_all_caches_capable())
> +		return -EINVAL;
> +
>  	if (!test_bit(NVDIMM_INTEL_UNLOCK_UNIT, &nfit_mem->dsm_mask))
>  		return -ENOTTY;
>  
> @@ -228,7 +230,7 @@ static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
>  	}
>  
>  	/* DIMM unlocked, invalidate all CPU caches before we read it */
> -	nvdimm_invalidate_cache();
> +	flush_all_caches();
>  
>  	return 0;
>  }
> @@ -294,11 +296,14 @@ static int __maybe_unused intel_security_erase(struct nvdimm *nvdimm,
>  		},
>  	};
>  
> +	if (!flush_all_caches_capable())
> +		return -EINVAL;
> +
>  	if (!test_bit(cmd, &nfit_mem->dsm_mask))
>  		return -ENOTTY;
>  
>  	/* flush all cache before we erase DIMM */
> -	nvdimm_invalidate_cache();
> +	flush_all_caches();
>  	memcpy(nd_cmd.cmd.passphrase, key->data,
>  			sizeof(nd_cmd.cmd.passphrase));
>  	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
> @@ -318,7 +323,7 @@ static int __maybe_unused intel_security_erase(struct nvdimm *nvdimm,
>  	}
>  
>  	/* DIMM erased, invalidate all CPU caches before we read it */
> -	nvdimm_invalidate_cache();
> +	flush_all_caches();
>  	return 0;
>  }
>  
> @@ -338,6 +343,9 @@ static int __maybe_unused intel_security_query_overwrite(struct nvdimm *nvdimm)
>  		},
>  	};
>  
> +	if (!flush_all_caches_capable())
> +		return -EINVAL;
> +
>  	if (!test_bit(NVDIMM_INTEL_QUERY_OVERWRITE, &nfit_mem->dsm_mask))
>  		return -ENOTTY;
>  
> @@ -355,7 +363,7 @@ static int __maybe_unused intel_security_query_overwrite(struct nvdimm *nvdimm)
>  	}
>  
>  	/* flush all cache before we make the nvdimms available */
> -	nvdimm_invalidate_cache();
> +	flush_all_caches();
>  	return 0;
>  }
>  
> @@ -377,11 +385,14 @@ static int __maybe_unused intel_security_overwrite(struct nvdimm *nvdimm,
>  		},
>  	};
>  
> +	if (!flush_all_caches_capable())
> +		return -EINVAL;
> +
>  	if (!test_bit(NVDIMM_INTEL_OVERWRITE, &nfit_mem->dsm_mask))
>  		return -ENOTTY;
>  
>  	/* flush all cache before we erase DIMM */
> -	nvdimm_invalidate_cache();
> +	flush_all_caches();
>  	memcpy(nd_cmd.cmd.passphrase, nkey->data,
>  			sizeof(nd_cmd.cmd.passphrase));
>  	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
> @@ -401,22 +412,6 @@ static int __maybe_unused intel_security_overwrite(struct nvdimm *nvdimm,
>  	}
>  }
>  
> -/*
> - * TODO: define a cross arch wbinvd equivalent when/if
> - * NVDIMM_FAMILY_INTEL command support arrives on another arch.
> - */
> -#ifdef CONFIG_X86
> -static void nvdimm_invalidate_cache(void)
> -{
> -	wbinvd_on_all_cpus();
> -}
> -#else
> -static void nvdimm_invalidate_cache(void)
> -{
> -	WARN_ON_ONCE("cache invalidation required after unlock\n");
> -}
> -#endif
> -
>  static const struct nvdimm_security_ops __intel_security_ops = {
>  	.get_flags = intel_security_flags,
>  	.freeze = intel_security_freeze,
> diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
> index 4f07afacbc23..89f310f92498 100644
> --- a/include/asm-generic/cacheflush.h
> +++ b/include/asm-generic/cacheflush.h
> @@ -115,4 +115,35 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
>  	memcpy(dst, src, len)
>  #endif
>  
> +/*
> + * Flush the entire caches across all CPUs, however:
> + *
> + *       YOU DO NOT WANT TO USE THIS FUNCTION.
> + *
> + * It is considered a big hammer and can affect overall
> + * system performance and increase latency/response times.
> + * As such it is not for general usage, but for specific use
> + * cases involving instantaneously invalidating wide swaths
> + * of memory on bare metal.
> +
> + * Unlike the APIs above, this function can be defined on
> + * architectures which have VIPT or PIPT caches, and thus is
> + * beyond the scope of virtual to physical mappings/page
> + * tables changing.
> + *
> + * The limitation here is that the architectures that make
> + * use of it must can actually comply with the semantics,

	"must can"?

Did you mean "must"?

> + * such as those which caches are in a consistent state. The
> + * caller can verify the situation early on.
> + */
> +#ifndef flush_all_caches
> +# define flush_all_caches_capable() false
> +static inline void flush_all_caches(void)
> +{
> +	WARN_ON_ONCE("cache invalidation required\n");
> +}

With the addition of flush_all_caches_capable() will flush_all_caches() ever be
called?

Ira

> +#else
> +# define flush_all_caches_capable() true
> +#endif
> +
>  #endif /* _ASM_GENERIC_CACHEFLUSH_H */
> -- 
> 2.37.2
> 
