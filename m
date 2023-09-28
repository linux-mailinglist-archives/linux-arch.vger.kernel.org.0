Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082A47B128A
	for <lists+linux-arch@lfdr.de>; Thu, 28 Sep 2023 08:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjI1GTK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Sep 2023 02:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjI1GTJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Sep 2023 02:19:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4D899;
        Wed, 27 Sep 2023 23:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695881946; x=1727417946;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=yPoRTff1W8kHOZj6MIgWTa4FPEtV7El2Duzf1zGYqoI=;
  b=XCmh6lMezJrCbdiEj6brvfLLN+4eo4r0uPrIBptu38VyOV1oYDG6UJI9
   do2V5wVo0YxP/em7YTb0rKomZqAHoHKP41Ccv47kW5MBFB+2yfnlkNq51
   X92JODOz5PFxUzxfwKV8rpdrpjK8KZzBv2eRlgo1VElZIbBAVyVOKHmYF
   qkCX1Ouz4f0JUTsZDmhFmI1J+5p6CkzjhiqQAp9t1Lp0lJ/hR+L1U1GN9
   52bTwBaeQPbrzcJJwMlwZdlsNl3oLkQpDlY+EqhGSw1QFTmPb/9NvfYRw
   yPYbFY6TUoFZOuJ9yQnlDf9U80BK6g7a25NLdazkyARnsmTJB3cvNAGIu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="446139326"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="446139326"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 23:19:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="726120975"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="726120975"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 23:19:00 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Ravi Jonnalagadda <ravis.opensrc@micron.com>
Cc:     <linux-mm@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <luto@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dietmar.eggemann@arm.com>, <vincent.guittot@linaro.org>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <arnd@arndb.de>,
        <akpm@linux-foundation.org>, <x86@kernel.org>,
        <aneesh.kumar@linux.ibm.com>, <gregory.price@memverge.com>,
        <jgroves@micron.com>, <sthanneeru@micron.com>,
        <emirakhur@micron.com>, <vtanna@micron.com>
Subject: Re: [RFC PATCH 0/2] mm: mempolicy: Multi-tier interleaving
References: <20230927095002.10245-1-ravis.opensrc@micron.com>
Date:   Thu, 28 Sep 2023 14:14:32 +0800
In-Reply-To: <20230927095002.10245-1-ravis.opensrc@micron.com> (Ravi
        Jonnalagadda's message of "Wed, 27 Sep 2023 15:20:00 +0530")
Message-ID: <87v8burfhz.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Ravi,

Thanks for the patch!

Ravi Jonnalagadda <ravis.opensrc@micron.com> writes:

> From: Ravi Shankar <ravis.opensrc@micron.com>
>
> Hello,
>
> The current interleave policy operates by interleaving page requests
> among nodes defined in the memory policy. To accommodate the
> introduction of memory tiers for various memory types (e.g., DDR, CXL,
> HBM, PMEM, etc.), a mechanism is needed for interleaving page requests
> across these memory types or tiers.

Why do we need interleaving page allocation among memory tiers?  I think
that you need to make it more explicit.  I guess that it's to increase
maximal memory bandwidth for workloads?

> This can be achieved by implementing an interleaving method that
> considers the tier weights.
> The tier weight will determine the proportion of nodes to select from
> those specified in the memory policy.
> A tier weight can be assigned to each memory type within the system.

What is the problem of the original interleaving?  I think you need to
make it explicit too.

> Hasan Al Maruf had put forth a proposal for interleaving between two
> tiers, namely the top tier and the low tier. However, this patch was
> not adopted due to constraints on the number of available tiers.
>
> https://lore.kernel.org/linux-mm/YqD0%2FtzFwXvJ1gK6@cmpxchg.org/T/
>
> New proposed changes:
>
> 1. Introducea sysfs entry to allow setting the interleave weight for each
> memory tier.
> 2. Each tier with a default weight of 1, indicating a standard 1:1
> proportion.
> 3. Distribute the weight of that tier in a uniform manner across all nodes.
> 4. Modifications to the existing interleaving algorithm to support the
> implementation of multi-tier interleaving based on tier-weights.
>
> This is inline with Huang, Ying's presentation in lpc22, 16th slide in
> https://lpc.events/event/16/contributions/1209/attachments/1042/1995/\
> Live%20In%20a%20World%20With%20Multiple%20Memory%20Types.pdf

Thanks to refer to the original work about this.

> Observed a significant increase (165%) in bandwidth utilization
> with the newly proposed multi-tier interleaving compared to the
> traditional 1:1 interleaving approach between DDR and CXL tier nodes,
> where 85% of the bandwidth is allocated to DDR tier and 15% to CXL
> tier with MLC -w2 option.

It appears that "mlc" isn't an open source software.  Better to use a
open source software to test.  And, even better to use a more practical
workloads instead of a memory bandwidth/latency measurement tool.

> Usage Example:
>
> 1. Set weights for DDR (tier4) and CXL(teir22) tiers.
> echo 85 > /sys/devices/virtual/memory_tiering/memory_tier4/interleave_weight
> echo 15 > /sys/devices/virtual/memory_tiering/memory_tier22/interleave_weight
>
> 2. Interleave between DRR(tier4, node-0) and CXL (tier22, node-1) using numactl
> numactl -i0,1 mlc --loaded_latency W2
>
> Srinivasulu Thanneeru (2):
>   memory tier: Introduce sysfs for tier interleave weights.
>   mm: mempolicy: Interleave policy for tiered memory nodes
>
>  include/linux/memory-tiers.h |  27 ++++++++-
>  include/linux/sched.h        |   2 +
>  mm/memory-tiers.c            |  67 +++++++++++++++-------
>  mm/mempolicy.c               | 107 +++++++++++++++++++++++++++++++++--
>  4 files changed, 174 insertions(+), 29 deletions(-)

--
Best Regards,
Huang, Ying
