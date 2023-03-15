Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72056BB7FA
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 16:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjCOPft (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 11:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjCOPff (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 11:35:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5922A5FA49;
        Wed, 15 Mar 2023 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678894532; x=1710430532;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XVCvNq00AzxeDiW1CII0hPanv823+0JJywCY93Le2ww=;
  b=H/rQgEV1cIk28+BLMd7HcT5xVTZjh7kj0PhTFG962CtyTQwkUCo0IJ7R
   7xxC59OwwsaVCurCiq24MzIuurFUhe+t462/QxnyQmc+LuKDLK6T3nF4h
   HXBG1svPrf85FWavUpmwmV8P1mHJpxYurv5AmyoXjqOyR8QJILl60T9Tc
   rP1w3HUWe8v5RkAWGZ8b6nGmIvPxXwsFwAiV/3yQDicNO4aMZjg5udxhl
   gzcNDJXy5ZdjZhBf8ZANSi4phsPE949K96L35WndJsYnE3jgC9FBnMo10
   D7CxLloq0KGZl7maNK9zu2iDJ8hzIOCe/IeCzZvy0Z1aT9nVfXe/VqTDB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="365422302"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="365422302"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 08:35:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="1008877812"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="1008877812"
Received: from rhdahlex-mobl2.amr.corp.intel.com (HELO [10.212.59.168]) ([10.212.59.168])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 08:35:25 -0700
Message-ID: <f2f35037-d662-19c4-722a-02ec10f86f85@linux.intel.com>
Date:   Wed, 15 Mar 2023 15:35:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 04/10] drm/i915: Fix MAX_ORDER usage in
 i915_gem_object_get_pages_internal()
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-5-kirill.shutemov@linux.intel.com>
 <7fe9a4a0-9b30-38db-e739-1dc1f7a8f74e@linux.intel.com>
 <20230315152802.gr2olzji5zhu6vdo@box>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20230315152802.gr2olzji5zhu6vdo@box>
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


On 15/03/2023 15:28, Kirill A. Shutemov wrote:
> On Wed, Mar 15, 2023 at 02:18:52PM +0000, Tvrtko Ursulin wrote:
>>
>> On 15/03/2023 11:31, Kirill A. Shutemov wrote:
>>> MAX_ORDER is not inclusive: the maximum allocation order buddy allocator
>>> can deliver is MAX_ORDER-1.
>>
>> This looks to be true on inspection:
>>
>> __alloc_pages():
>> ..
>> 	if (WARN_ON_ONCE_GFP(order >= MAX_ORDER, gfp))
>>
>> So a bit of a misleading name "max".. For the i915 patch:
>>
>> Acked-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>>
>> I don't however see the whole series to understand the context, or how you
>> want to handle the individual patches. Is it a tree wide cleanup of the same
>> mistake?
> 
> The whole patchset can be seen here:
> 
> https://lore.kernel.org/all/20230315113133.11326-1-kirill.shutemov@linux.intel.com/
> 
> The idea is to fix all MAX_ORDER bugs first and then re-define MAX_ORDER
> more sensibly.

Sounds good.

Would you like i915 to take this patch or you will be bringing the whole 
lot via some other route? Former is okay and latter should also be fine 
for i915 since I don't envisage any conflicts here.

Regards,

Tvrtko

