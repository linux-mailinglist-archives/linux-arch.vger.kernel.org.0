Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE677801A2
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 01:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356054AbjHQXWn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Aug 2023 19:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356063AbjHQXWT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Aug 2023 19:22:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F265935A9;
        Thu, 17 Aug 2023 16:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692314538; x=1723850538;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jjim20PHoNcuWFjwQTxJ802NzhAvwG3kqWFOP4bvdkg=;
  b=Xfx9DpapC1fnXVTp8NGGnogkZoCB82d4M/how0rpJStftf0h81LCo+AI
   +Gp+BlO4NuhzoqbsSRvtdKs+kDP1OuUB1LMs2k3QcORu0nlu7wRkX57jF
   EnE2U+ibgVO6Oykz5xK7XGrQ/UEFRfSdiNpnsZsDXJoyOznGCMxMwArsV
   6a9p8e63177lFlkVaGUYgJCIre5MQJMrDpHYTPbMbh6nDWZm+tRJCrgcE
   gUxtUHzO8WCX9RHf1FurjnYLybmyGj1x3SlIGsFKgXDdST98G5vfqxiBB
   2ESh2GOILGuPCRm7vxJ9Nl/sTDUqphncP//T1BdXegXdQuCbBlEaOjPiV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="376718395"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="376718395"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 16:22:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="728358086"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="728358086"
Received: from lacoffin-mobl.amr.corp.intel.com (HELO [10.212.196.192]) ([10.212.196.192])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 16:22:16 -0700
Message-ID: <3b1ca61c-fa3f-a802-6705-a8c1f37ad58f@intel.com>
Date:   Thu, 17 Aug 2023 16:22:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 03/15] mshyperv: Introduce
 numa_node_to_proximity_domain_info
Content-Language: en-US
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Cc:     patches@lists.linux.dev, mikelley@microsoft.com, kys@microsoft.com,
        wei.liu@kernel.org, haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1692309711-5573-4-git-send-email-nunodasneves@linux.microsoft.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <1692309711-5573-4-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/17/23 15:01, Nuno Das Neves wrote:
> +static inline union hv_proximity_domain_info
> +numa_node_to_proximity_domain_info(int node)
> +{
> +	union hv_proximity_domain_info proximity_domain_info;
> +
> +	if (node != NUMA_NO_NODE) {
> +		proximity_domain_info.domain_id = node_to_pxm(node);
> +		proximity_domain_info.flags.reserved = 0;
> +		proximity_domain_info.flags.proximity_info_valid = 1;
> +		proximity_domain_info.flags.proximity_preferred = 1;
> +	} else {
> +		proximity_domain_info.as_uint64 = 0;
> +	}
> +
> +	return proximity_domain_info;
> +}

Pop quiz: What are the rules for the 30 bits of uninitialized data of
proximity_domain_info.flags in the (node != NUMA_NO_NODE) case?

I actually don't know off the top of my head.  I generally avoid
bitfields, but if they were normal stack-allocated variable space,
they'd be garbage.

I'd also *much* rather see the "as_uint64 = 0" coded up as a memset() or
even explicitly zeroing all the same variables as the other half of the
if().  As it stands, it's not 100% obvious that proximity_domain_info is
64 bits and that .as_uint64=0 zeroes the whole thing.  It *WOULD* be
totally obvious if it were a memset().
