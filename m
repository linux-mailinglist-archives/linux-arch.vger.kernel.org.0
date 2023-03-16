Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC286BCA2A
	for <lists+linux-arch@lfdr.de>; Thu, 16 Mar 2023 09:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCPI5u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Mar 2023 04:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCPI53 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Mar 2023 04:57:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C22B855F;
        Thu, 16 Mar 2023 01:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678956985; x=1710492985;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jfdxhk1RwEvFfimDfsyITAIQjollvnKSk7jJVrihtOM=;
  b=LOZ9gllnKUM29uY4DE/RpHrz9uNJtmbQ6LDFPcGQP+vLYOYwuEObmuS3
   cR4FFI/nj8Crdmn2ZPNyW6GJraC+8KUzF9+4Dkf8CrQ3Qxw1hD/Ke1Oy9
   9MvBlNaUxd2sgN/phFKFhDmsZHDDOTNyZKXF4fQJou7seuw9bt33aBVdT
   v7FEaJX5RX/oFR+tA1qTpZCnRb0as2tO2OCCqXZkA0zuRzPUpBqzx2kyx
   PvZTO7ygKfGWjgIEPG1pjwpe2WacYNsWGLzKvcgl1eKF6FKl3bh112gUl
   dvTkopeSl6cUUweEecXE1xE2pLF3V9tHZPURVGJAZUVu0V/JfbZcot5IY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="321769830"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="321769830"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 01:56:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="925691736"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="925691736"
Received: from kflynn1-mobl3.ger.corp.intel.com (HELO [10.213.236.25]) ([10.213.236.25])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 01:56:01 -0700
Message-ID: <4be7cbc0-dab5-eecc-1cea-8a6ffb831f10@linux.intel.com>
Date:   Thu, 16 Mar 2023 08:55:59 +0000
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
 <f2f35037-d662-19c4-722a-02ec10f86f85@linux.intel.com>
 <20230315153855.aeqyxncf3k6yqipl@box>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20230315153855.aeqyxncf3k6yqipl@box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 15/03/2023 15:38, Kirill A. Shutemov wrote:
> On Wed, Mar 15, 2023 at 03:35:23PM +0000, Tvrtko Ursulin wrote:
>>
>> On 15/03/2023 15:28, Kirill A. Shutemov wrote:
>>> On Wed, Mar 15, 2023 at 02:18:52PM +0000, Tvrtko Ursulin wrote:
>>>>
>>>> On 15/03/2023 11:31, Kirill A. Shutemov wrote:
>>>>> MAX_ORDER is not inclusive: the maximum allocation order buddy allocator
>>>>> can deliver is MAX_ORDER-1.
>>>>
>>>> This looks to be true on inspection:
>>>>
>>>> __alloc_pages():
>>>> ..
>>>> 	if (WARN_ON_ONCE_GFP(order >= MAX_ORDER, gfp))
>>>>
>>>> So a bit of a misleading name "max".. For the i915 patch:
>>>>
>>>> Acked-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>>>>
>>>> I don't however see the whole series to understand the context, or how you
>>>> want to handle the individual patches. Is it a tree wide cleanup of the same
>>>> mistake?
>>>
>>> The whole patchset can be seen here:
>>>
>>> https://lore.kernel.org/all/20230315113133.11326-1-kirill.shutemov@linux.intel.com/
>>>
>>> The idea is to fix all MAX_ORDER bugs first and then re-define MAX_ORDER
>>> more sensibly.
>>
>> Sounds good.
>>
>> Would you like i915 to take this patch or you will be bringing the whole lot
>> via some other route? Former is okay and latter should also be fine for i915
>> since I don't envisage any conflicts here.
> 
> I think would be better to get it via mm tree.

Ack for that. But as I saw that by the end of the series you also change 
this back as you redefine MAX_ORDER to be inclusive you could even 
simplify things and just not do anything for i915. I am pretty sure we 
never call this helper for > 4M allocations otherwise we would have seen 
this warn.

Regards,

Tvrtko
