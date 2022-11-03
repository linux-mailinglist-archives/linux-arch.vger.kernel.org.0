Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94252618649
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 18:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiKCRhO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Nov 2022 13:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiKCRhN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Nov 2022 13:37:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F161055C
        for <linux-arch@vger.kernel.org>; Thu,  3 Nov 2022 10:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667496975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wqHDCfVM36OPNbloym/8DLeITW3uuDn/ofViGZw+9QU=;
        b=hf1a3n0EBFUNxU0mFwCTcsyvGl5pdnO049M8t9JCjjiwhiokGn8jNZmuyFRya/45OhPQUY
        ooX04286Hik0w+APUsg+cuFRay5KQOcOTZQLRmE2s680opqpL1JNLp9b5Q0D1AuJFlkoDu
        sc2ovXUGIZX6KCIAV8vkchptaRgwNrQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-bak6DaaIM260CLX9FbnRvw-1; Thu, 03 Nov 2022 13:36:13 -0400
X-MC-Unique: bak6DaaIM260CLX9FbnRvw-1
Received: by mail-wm1-f70.google.com with SMTP id s7-20020a1cf207000000b003cf56bad2e2so769006wmc.9
        for <linux-arch@vger.kernel.org>; Thu, 03 Nov 2022 10:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqHDCfVM36OPNbloym/8DLeITW3uuDn/ofViGZw+9QU=;
        b=QdSXOen0IxwDb3hMbX9TymHYojB4W3DOIFEX7Sj5p6MqpUVa9TUkSqO0Utaqa1hlQ2
         Cy//qSDwRjEGvDG4itDc4pEWemZsqkCKsgE6+5NXqTRhjdUqN3SbDKvrjfIGw7JJ1Bkv
         ESpPVSA2h/cEkZoj4NyQnrXrXAP56j4DQosmQg33uVEMvZro16Q3Vvh/tgcb0uMEGHuZ
         Snw+3wCml5ibSk9XDOFrNT05jiEQil/96fyvLAlm1BgdR2Xi1BK84PsCaXa6YCVsv/nB
         XQX0AIL8n+TEccBSWc1OxQoVT+xyQbvOZrBciTJlMwx0w4trfTepa3CnXoL475akSLi6
         GRpg==
X-Gm-Message-State: ACrzQf1dwv7b8fEh1CWuhLJlZ1UjIK41UhufcC3VG4tcsEvFPjVsw1Ty
        Fa4q51ESaTuCMr3Dr42PqGsNZhvJtrP3lStoYLhI7wp04eRQsD/DX7go3HhcM9YqCzjlgMfCwsp
        tDrjnegop8rRm4m1lme/fBA==
X-Received: by 2002:a5d:4c43:0:b0:236:547f:bd3c with SMTP id n3-20020a5d4c43000000b00236547fbd3cmr20124909wrt.380.1667496972001;
        Thu, 03 Nov 2022 10:36:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM54lgh3dosJh+SDteCIDf+oND5iNc6bun/TfT30kj1hNLHlkbIfHxe0Djb4bu9ZHb48FSA7qw==
X-Received: by 2002:a5d:4c43:0:b0:236:547f:bd3c with SMTP id n3-20020a5d4c43000000b00236547fbd3cmr20124874wrt.380.1667496971580;
        Thu, 03 Nov 2022 10:36:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:a400:e2d7:3ee3:8d35:ac8? (p200300cbc707a400e2d73ee38d350ac8.dip0.t-ipconnect.de. [2003:cb:c707:a400:e2d7:3ee3:8d35:ac8])
        by smtp.gmail.com with ESMTPSA id bq7-20020a5d5a07000000b0022e035a4e93sm1379834wrb.87.2022.11.03.10.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 10:36:11 -0700 (PDT)
Message-ID: <3259ad30-c129-84fc-9643-0aeaeeb3c806@redhat.com>
Date:   Thu, 3 Nov 2022 18:36:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: mm: delay rmap removal until after TLB flush
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jann Horn <jannh@google.com>,
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
 <4f6d8fb5-6be5-a7a8-de8e-644da66b5a3d@redhat.com>
 <CAHk-=wiDg_1up8K4PhK4+kzPN7xJG297=nw+tvgrGn7aVgZdqw@mail.gmail.com>
 <CAHk-=wgReY6koZTKT97NsCczzr4uYAA66iePv=S_RL-_D-9mmQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHk-=wgReY6koZTKT97NsCczzr4uYAA66iePv=S_RL-_D-9mmQ@mail.gmail.com>
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

On 03.11.22 18:09, Linus Torvalds wrote:
> On Thu, Nov 3, 2022 at 9:54 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> But again, those changes would have made the patch bigger, which I
>> didn't want at this point (and 'release_pages()' would need that
>> clean-in-place anyway, unless we changed *that* too and made the whole
>> page encoding be something widely available).
> 
> And just to clarify: this is not just me trying to expand the reach of my patch.
> 
> I'd suggest people look at mlock_pagevec(), and realize that LRU_PAGE
> and NEW_PAGE are both *exactly* the same kind of "encoded_page" bits
> that TLB_ZAP_RMAP is.
> 
> Except the mlock code does *not* show that in the type system, and
> instead just passes a "struct page **" array around in pvec->pages,
> and then you'd just better know that "oh, it's not *really* just a
> page pointer".
> 
> So I really think that the "array of encoded page pointers" thing is a
> generic notion that we *already* have.
> 
> It's just that we've done it disgustingly in the past, and I didn't
> want to do that disgusting thing again.
> 
> So I would hope that the nasty things that the mlock code would some
> day use the same page pointer encoding logic to actually make the
> whole "this is not a page pointer that you can use directly, it has
> low bits set for flags" very explicit.
> 
> I am *not* sure if then the actual encoded bits would be unified.
> Probably not - you might have very different and distinct uses of the
> encode_page() thing where the bits mean different things in different
> contexts.
> 
> Anyway, this is me just explaining the thinking behind it all. The
> page bit encoding is a very generic thing (well, "very generic" in
> this case means "has at least one other independent user"), explaining
> the very generic naming.
> 
> But at the same time, the particular _patch_ was meant to be very targeted.
> 
> So slightly schizophrenic name choices as a result.

Thanks for the explanation. I brought it up because the generic name 
somehow felt weird in include/asm-generic/tlb.h. Skimming over the code 
I'd have expected something like TLB_ENCODE_PAGE_BITS, so making the 
"very generic" things "very specific" as long as it lives in tlb.h :)

-- 
Thanks,

David / dhildenb

