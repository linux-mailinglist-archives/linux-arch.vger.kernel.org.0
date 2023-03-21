Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEE46C2BCB
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 08:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCUH5o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 03:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjCUH5m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 03:57:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4231B24BE4;
        Tue, 21 Mar 2023 00:57:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F2BFA21A70;
        Tue, 21 Mar 2023 07:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679385460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1q9SltzaNL/CztkM+LEm5N5o8JYoAuWjcQL502qSi0w=;
        b=K0kBe0Un7tE4Cxf+WG+rdePp4x/6z//9O/xOeH9XdEcw4anU+TNkPzIyWaKWz0siSLyLye
        jZc8L8LJ2kJMBnq949X7XfqTIjrrlAyg4qgAd4e5+HD89NX4uW8RGA3x9v4ecV6hrIiliQ
        WNlKmBLQ4UBw6hK+HnBVgSEx40xquAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679385460;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1q9SltzaNL/CztkM+LEm5N5o8JYoAuWjcQL502qSi0w=;
        b=LAmaTyfErAm6uEygmOyqEzjKDteTqxKMzkzqWmv18w2U144b0aZxpThEtv02aMUCLGg13Q
        ZBznbMg1cRMgVtAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C92CA13440;
        Tue, 21 Mar 2023 07:57:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VeI9MHNjGWSFOAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 21 Mar 2023 07:57:39 +0000
Message-ID: <71905d5b-9e83-c123-f81b-de595bb06fe0@suse.cz>
Date:   Tue, 21 Mar 2023 08:57:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 04/10] drm/i915: Fix MAX_ORDER usage in
 i915_gem_object_get_pages_internal()
Content-Language: en-US
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
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
 <4be7cbc0-dab5-eecc-1cea-8a6ffb831f10@linux.intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <4be7cbc0-dab5-eecc-1cea-8a6ffb831f10@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/16/23 09:55, Tvrtko Ursulin wrote:
> 
> On 15/03/2023 15:38, Kirill A. Shutemov wrote:
>> On Wed, Mar 15, 2023 at 03:35:23PM +0000, Tvrtko Ursulin wrote:
>>>
>>> On 15/03/2023 15:28, Kirill A. Shutemov wrote:
>>>> On Wed, Mar 15, 2023 at 02:18:52PM +0000, Tvrtko Ursulin wrote:
>>>>>
>>>>> On 15/03/2023 11:31, Kirill A. Shutemov wrote:
>>>>>> MAX_ORDER is not inclusive: the maximum allocation order buddy allocator
>>>>>> can deliver is MAX_ORDER-1.
>>>>>
>>>>> This looks to be true on inspection:
>>>>>
>>>>> __alloc_pages():
>>>>> ..
>>>>> 	if (WARN_ON_ONCE_GFP(order >= MAX_ORDER, gfp))
>>>>>
>>>>> So a bit of a misleading name "max".. For the i915 patch:
>>>>>
>>>>> Acked-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>>>>>
>>>>> I don't however see the whole series to understand the context, or how you
>>>>> want to handle the individual patches. Is it a tree wide cleanup of the same
>>>>> mistake?
>>>>
>>>> The whole patchset can be seen here:
>>>>
>>>> https://lore.kernel.org/all/20230315113133.11326-1-kirill.shutemov@linux.intel.com/
>>>>
>>>> The idea is to fix all MAX_ORDER bugs first and then re-define MAX_ORDER
>>>> more sensibly.
>>>
>>> Sounds good.
>>>
>>> Would you like i915 to take this patch or you will be bringing the whole lot
>>> via some other route? Former is okay and latter should also be fine for i915
>>> since I don't envisage any conflicts here.
>> 
>> I think would be better to get it via mm tree.
> 
> Ack for that. But as I saw that by the end of the series you also change 
> this back as you redefine MAX_ORDER to be inclusive you could even 
> simplify things and just not do anything for i915. I am pretty sure we 
> never call this helper for > 4M allocations otherwise we would have seen 
> this warn.

I think it's better the Kirill's way as the redefinition patch then isn't
also a silent bugfix. In case some of the bugfixes would need to be
backported to stable (maybe you don't seen the warn, but something else will
change and start seeing it?), it's better if they are separate.

> Regards,
> 
> Tvrtko
> 

