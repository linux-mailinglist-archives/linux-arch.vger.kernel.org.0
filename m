Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C696BB5CB
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 15:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjCOOTM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 10:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjCOOTJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 10:19:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9A12135;
        Wed, 15 Mar 2023 07:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678889939; x=1710425939;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QLmbsiwvupMvAjcg/HjKbM+oTZqTZfEMbms/hcTaWtk=;
  b=ILQ9S1vF5W/DqmZuIFC4g4UXfq3YGX7B2YqfqSbP8FiVjO7YucNRHaC2
   Wwa7ZmefZS46DMyDpwfj79Waej0UtSXF0nDiSmqhATUSxsZLG5/1gROyq
   lDgwGl1FGTJjYT/ffYWsiiqAlb2oz3Ze70JSGvWM5t2MQ3P6f4LTf6f6Q
   BU0ty6Xr9QYfutGN5n4GlLCSgO2FOh2OYyJVTE7rkwWCSeRMNQwTePOqr
   eyweQK8jWsZ6eyz6oBUCGcg4BG3BhJKEQDeLJVflmJ2tBb9tnjqQo7Lsf
   /0gfn902evOsfAYyqtrKk6ZIDGwUwxmKBBF9vndSE4XhP+WBe+oT23Wpv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="365397272"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="365397272"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:18:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="822786477"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="822786477"
Received: from rhdahlex-mobl2.amr.corp.intel.com (HELO [10.212.59.168]) ([10.212.59.168])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:18:54 -0700
Message-ID: <7fe9a4a0-9b30-38db-e739-1dc1f7a8f74e@linux.intel.com>
Date:   Wed, 15 Mar 2023 14:18:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 04/10] drm/i915: Fix MAX_ORDER usage in
 i915_gem_object_get_pages_internal()
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-5-kirill.shutemov@linux.intel.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20230315113133.11326-5-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 15/03/2023 11:31, Kirill A. Shutemov wrote:
> MAX_ORDER is not inclusive: the maximum allocation order buddy allocator
> can deliver is MAX_ORDER-1.

This looks to be true on inspection:

__alloc_pages():
..
	if (WARN_ON_ONCE_GFP(order >= MAX_ORDER, gfp))

So a bit of a misleading name "max".. For the i915 patch:

Acked-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

I don't however see the whole series to understand the context, or how 
you want to handle the individual patches. Is it a tree wide cleanup of 
the same mistake?

Regards,

Tvrtko

> Fix MAX_ORDER usage in i915_gem_object_get_pages_internal().
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_internal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_internal.c b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
> index 6bc26b4b06b8..eae9e9f6d3bf 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_internal.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
> @@ -36,7 +36,7 @@ static int i915_gem_object_get_pages_internal(struct drm_i915_gem_object *obj)
>   	struct sg_table *st;
>   	struct scatterlist *sg;
>   	unsigned int npages; /* restricted by sg_alloc_table */
> -	int max_order = MAX_ORDER;
> +	int max_order = MAX_ORDER - 1;
>   	unsigned int max_segment;
>   	gfp_t gfp;
>   
