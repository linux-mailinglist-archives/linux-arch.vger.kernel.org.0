Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BBD1B5B90
	for <lists+linux-arch@lfdr.de>; Thu, 23 Apr 2020 14:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDWMh0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Apr 2020 08:37:26 -0400
Received: from foss.arm.com ([217.140.110.172]:39054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgDWMh0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Apr 2020 08:37:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42E2431B;
        Thu, 23 Apr 2020 05:37:26 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 458F23F6CF;
        Thu, 23 Apr 2020 05:37:24 -0700 (PDT)
Subject: Re: [PATCH 2/4] mm: Add arch hooks for saving/restoring tags
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Hugh Dickins <hughd@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
References: <20200422142530.32619-1-steven.price@arm.com>
 <20200422142530.32619-3-steven.price@arm.com>
 <edd132f8-c39b-9586-1714-19a335ccea5c@intel.com> <20200423090919.GA4963@gaia>
From:   Steven Price <steven.price@arm.com>
Message-ID: <380bdf0b-aa7c-399c-d16d-b2aecd3f363c@arm.com>
Date:   Thu, 23 Apr 2020 13:37:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423090919.GA4963@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 23/04/2020 10:09, Catalin Marinas wrote:
> On Wed, Apr 22, 2020 at 11:08:10AM -0700, Dave Hansen wrote:
>> On 4/22/20 7:25 AM, Steven Price wrote:
>>> Three new hooks are added to the swap code:
>>>   * arch_prepare_to_swap() and
>>>   * arch_swap_invalidate_page() / arch_swap_invalidate_area().
>>> One new hook is added to shmem:
>>>   * arch_swap_restore_tags()
>>
>> How do the tags get restored outside of the shmem path?  I was expecting
>> to see more arch_swap_restore_tags() sites.
> 
> The restoring is done via set_pte_at() -> mte_sync_tags() ->
> mte_restore_tags() in the arch code (see patch 3).
> arch_swap_restore_tags() just calls mte_restore_tags() directly.
> 
> shmem is slightly problematic as it moves the page from the swap cache
> to the shmem one and I think arch_swap_invalidate_page() would have
> already been called by the time we get to set_pte_at() (Steven can
> correct me if I got this wrong).

That's correct - shmem can pull in pages (into it's own cache) and 
invalidate the swap entries without any process having a PTE restored. 
So we need to hook shmem to restore the tags even though there's no PTE 
restored yet.

The set_pte_at() 'trick' enables delaying the restoring of the tags (in 
the usual case) until the I/O for the page has completed, which might be 
necessary in some cases if the I/O can clobber the tags in memory. I 
couldn't find a better way of hooking this.

Steve
