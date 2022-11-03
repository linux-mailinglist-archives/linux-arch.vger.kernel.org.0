Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A67617A47
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 10:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiKCJxq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Nov 2022 05:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiKCJxo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Nov 2022 05:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CBC63EB
        for <linux-arch@vger.kernel.org>; Thu,  3 Nov 2022 02:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667469167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aI/nsBdIJq/KxhD4Raxc4CwIaTT63mvtTzDOA0DnrVU=;
        b=O1hZkpZFS18D0VPsPeClEPPlRJf3oZMh/VBb9F6iVzxIcKliRqeEitzMPdkpSTMF7K84s4
        JeaPXIOmlyLy1gQb3La4Fz4s7Geuegk5q/k79nuzSuuEy5NAJZW1BoEbWZB+R+7BYjW0G/
        RVIUDRmbA3xKG8qIKwhzgevl7qS0Zog=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-515-G8pVpvjbMkqUZDFFaAq8SQ-1; Thu, 03 Nov 2022 05:52:44 -0400
X-MC-Unique: G8pVpvjbMkqUZDFFaAq8SQ-1
Received: by mail-wm1-f72.google.com with SMTP id z15-20020a1c4c0f000000b003cf6f80007cso278190wmf.3
        for <linux-arch@vger.kernel.org>; Thu, 03 Nov 2022 02:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aI/nsBdIJq/KxhD4Raxc4CwIaTT63mvtTzDOA0DnrVU=;
        b=PXMI2Bz5fV7RdIZBcJaKOf4AN1kY/mGZuhwmupd4BnlHdlB0AVnW+mSEaQ6SK+Oe/9
         2aHzU2rJFYdWlF31zjH7PjhJvsWARAPao6BszoQEkhUh7IYonx+pc+afazJ86B6ylj0G
         gYWZJeA2JiOzM7o1g5Zm2WLAzWgRz58Cuj2RY9vu280uhKnql9yDxyMuO0W8czqrtT0U
         ZW87NvW25/8AT+t+G8sHwdF6cNoOHw1C83fpZADkPisj5b5tW+uGXbMNMufS0Nm13ZS3
         k8lNOtAYyud71ZnWnnuf8Eq74+4IHUkx+r2+5IDiNtdFMqn2KzAlvrB7Sh6eAZLWRU3b
         Cn4A==
X-Gm-Message-State: ACrzQf3EzAzHayxN93rMmygwnPqWpPv50hEJLJt99AEg10p/hRa87JfN
        iCTxeYIo9Blp0kZodPtU4Lk/pPwwt1er3QKkxjLoExUGXa9AEjFbQZD3hNDKp5y5m+L8SKYDvdI
        gC/cpKWAybTmX+O3r3CfSIA==
X-Received: by 2002:a5d:6688:0:b0:238:3e06:9001 with SMTP id l8-20020a5d6688000000b002383e069001mr1770181wru.308.1667469163424;
        Thu, 03 Nov 2022 02:52:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5KkrKgbb3XOO6+/a6+n0NrIKf/x0VQGYxL1f39jwyafE67d1Pfvlw11Xfu/Llx7ijyIysmtw==
X-Received: by 2002:a5d:6688:0:b0:238:3e06:9001 with SMTP id l8-20020a5d6688000000b002383e069001mr1770154wru.308.1667469163083;
        Thu, 03 Nov 2022 02:52:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:a400:e2d7:3ee3:8d35:ac8? (p200300cbc707a400e2d73ee38d350ac8.dip0.t-ipconnect.de. [2003:cb:c707:a400:e2d7:3ee3:8d35:ac8])
        by smtp.gmail.com with ESMTPSA id c6-20020adffb06000000b002366dd0e030sm403224wrr.68.2022.11.03.02.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 02:52:42 -0700 (PDT)
Message-ID: <4f6d8fb5-6be5-a7a8-de8e-644da66b5a3d@redhat.com>
Date:   Thu, 3 Nov 2022 10:52:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>, Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Uros Bizjak <ubizjak@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        linux-arch <linux-arch@vger.kernel.org>
References: <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
 <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com>
 <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
 <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com>
 <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
 <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
 <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com>
 <Y1+XCALog8bW7Hgl@hirez.programming.kicks-ass.net>
 <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com>
 <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: mm: delay rmap removal until after TLB flush
In-Reply-To: <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 31.10.22 19:43, Linus Torvalds wrote:
> Updated subject line, and here's the link to the original discussion
> for new people:
> 
>      https://lore.kernel.org/all/B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com/
> 
> On Mon, Oct 31, 2022 at 10:28 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Ok. At that point we no longer have the pte or the virtual address, so
>> it's not going to be exactly the same debug output.
>>
>> But I think it ends up being fairly natural to do
>>
>>          VM_WARN_ON_ONCE_PAGE(page_mapcount(page) < 0, page);
>>
>> instead, and I've fixed that last patch up to do that.
> 
> Ok, so I've got a fixed set of patches based on the feedback from
> PeterZ, and also tried to do the s390 updates for this blindly, and
> pushed them out into a git branch:
> 
>      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?h=mmu_gather-race-fix
> 
> If people really want to see the patches in email again, I can do
> that, but most of you already have, and the changes are either trivial
> fixes or the s390 updates.
> 
> For the s390 people that I've now added to the participant list maybe
> the git tree is fine - and the fundamental explanation of the problem
> is in that top-most commit (with the three preceding commits being
> prep-work). Or that link to the thread about this all.
> 
> That top-most commit is also where I tried to fix things up for s390
> that uses its own non-gathering TLB flush due to
> CONFIG_MMU_GATHER_NO_GATHER.
> 
> NOTE NOTE NOTE! Unlike my regular git branch, this one may end up
> rebased etc for further comments and fixes. So don't consider that
> stable, it's still more of an RFC branch.
> 
> At a minimum I'll update it with Ack's etc, assuming I get those, and
> my s390 changes are entirely untested and probably won't work.
> 
> As far as I can tell, s390 doesn't actually *have* the problem that
> causes this change, because of its synchronous TLB flush, but it
> obviously needs to deal with the change of rmap zapping logic.
> 
> Also added a few people who are explicitly listed as being mmu_gather
> maintainers. Maybe people saw the discussion on the linux-mm list, but
> let's make it explicit.
> 
> Do people have any objections to this approach, or other suggestions?
> 
> I do *not* consider this critical, so it's a "queue for 6.2" issue for me.
> 
> It probably makes most sense to queue in the -MM tree (after the thing
> is acked and people agree), but I can keep that branch alive too and
> just deal with it all myself as well.
> 
> Anybody?

Happy to see that we're still decrementing the mapcount before 
decrementingthe refcount, I was briefly concerned.

I was not able to come up quickly with something that would be 
fundamentally wrong here, but devil is in the detail.

Some minor things could be improved IMHO (ENCODE_PAGE_BITS naming is 
unfortunate, TLB_ZAP_RMAP could be a __bitwise type, using VM_WARN_ON 
instead of VM_BUG_ON).

I agree that 6.2 is good enough and that upstreaming this via the -MM 
tree would be a good way to move forward.

-- 
Thanks,

David / dhildenb

