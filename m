Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E53422FC56
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 00:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgG0WnU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 18:43:20 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:43873 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbgG0WnT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Jul 2020 18:43:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0U40bDB8_1595889792;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0U40bDB8_1595889792)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Jul 2020 06:43:16 +0800
Subject: Re: [patch 01/15] mm/memory.c: avoid access flag update TLB flush for
 retried page fault
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Yu Xu <xuyu@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hillf Danton <hdanton@sina.com>,
        Hugh Dickins <hughd@google.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>, mm-commits@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20200723211432.b31831a0df3bc2cbdae31b40@linux-foundation.org>
 <20200724041508.QlTbrHnfh%akpm@linux-foundation.org>
 <CAHk-=wguPA=pDskR-eMMjwR5LDEaMXrqbmDbrKr0u=wV1LE4rg@mail.gmail.com>
 <CAHk-=wh4kmU5FdT=Yy7N9wA=se=ALbrquCrOkjCMhiQnOBLvDA@mail.gmail.com>
 <0323de82-cfbd-8506-fa9c-a702703dd654@linux.alibaba.com>
 <20200727110512.GB25400@gaia>
 <39560818-463f-da3a-fc9e-3a4a0a082f61@linux.alibaba.com>
 <eb1f5cb4-7c3d-df42-f4aa-804e12df45e2@linux.alibaba.com>
 <CAHk-=wha6f0gF1SJg96R77h0oTuc_oO7-37wD=mYGy6TyJOwbQ@mail.gmail.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <89c6671a-39ba-d1cc-9bac-2e6717916220@linux.alibaba.com>
Date:   Mon, 27 Jul 2020 15:43:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wha6f0gF1SJg96R77h0oTuc_oO7-37wD=mYGy6TyJOwbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> On Mon, Jul 27, 2020 at 11:04 AM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>> It looks Linus's patch has better data. It seems sane to me since
>> Catalin's patch still needs flush TLB in the shared domain.
> Well, my patch as posted never built at all, I think.
>
> Looking back at that patch, I used FAULT_FLAG_RETRY. But that's not
> the correct name for any of the bits.
>
> So you must have fixed it. Did you make it use "FAULT_FLAG_TRIED"?
> Because that's the right bit - don't flush if this is actually the
> second (or more) attempt.

Actually I didn't have access to that test machine and I didn't try to 
build your patch, Yu Xu helped me test it. I will double check with him 
once he is back online. However that data looks sane since my patch 
(skip pte update) achieved the similar result.

>
> But I'm a bit worried that you would have used one of the other bits
> (FAULT_FLAG_ALLOW_RETRY or FAULT_FLAG_RETRY_NOWAIT), and that would be
> wrong. Those get set on the first attempt to say "you _may_ retry",
> but they get set on the first one.
>
> That just shows how much I tested the patch I sent out. It was
> whitespace-damaged on purpose, but I still want to check.
>
> The "FAULT_FLAG_TRIED" bit I believe is reasonable to test. That one
> literally says "I've gone through this once already, don't bother with
> spurious faults".  But I don't think it triggers much in practice. We
> seldom actually retry faults, it needs a page that we actually start
> IO on (and dropped the mmap lock for) to happen. It wouldn't happen on
> the "turn existing page dirty" case, for example.

With the commit ("mm: drop mmap_sem before calling balance_dirty_pages() 
in write fault") the retried fault may happen much more frequently than 
before since it would drop mmap lock as long as dirty throttling happens.

>
> The "FAULT_FLAG_WRITE" bit is what we test right now. I think it's
> wrong. I think it is a "this happens to work" bit, and cuts down on a
> lot of common cases, by simply skipping something that might be needed
> but basically never is.
>
> So I think a lot of this is dodgy. It doesn't matter on x86, and
> nobody cared. Because x86 will always re-walk the page tables before
> taking an architectural fault (the same way it walks them for
> dirty/accessed bit updates - you could think of x86 as doing all the
> things everybody else does in software, they just do in the hw walker
> micro-fault logic instead).
>
> A local TLB invalidate of a single virtual address should be basically
> free. We're talking single cycles kind of free. The problem here isn't
> the flush_tlb_fix_spurious_fault() itself, the problem here is that
> arm64 (and pretty much everybody else who uses the default fallback)
> does something horribly horribly wrong, and doesn't do the free
> version.

Yes, I do agree global TLB flush seems overkilling for some architectures.

>
>                 Linus

