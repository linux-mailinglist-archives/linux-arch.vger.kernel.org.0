Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65026D9CBE
	for <lists+linux-arch@lfdr.de>; Thu,  6 Apr 2023 17:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjDFPwq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Apr 2023 11:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239308AbjDFPwo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2023 11:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1446B4220
        for <linux-arch@vger.kernel.org>; Thu,  6 Apr 2023 08:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680796318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rXGtO/ZmgcxJ+0cLf6d2t80Dy16O6Eu74rSJdt26LEE=;
        b=ZkW7pc7pNo/dlO7QBx4P32TuqKNP8zf6eEJ6IE+1MdR8tveiAxWthyFotoyaCz2nXi1AjD
        Wq879Vg8C58sG8tm0ZJlSf4zc6PSGWMXY5Jv451m9F817dX5u5JC21NRrkXeeVtI5KcRNc
        xm8qfY1u2GWD9bmjhlgcxS7Tzfj4iMg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-vwwYnMkmMh2VyKtdMt-kIg-1; Thu, 06 Apr 2023 11:51:57 -0400
X-MC-Unique: vwwYnMkmMh2VyKtdMt-kIg-1
Received: by mail-wm1-f71.google.com with SMTP id iv18-20020a05600c549200b003ee21220fccso18466745wmb.1
        for <linux-arch@vger.kernel.org>; Thu, 06 Apr 2023 08:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680796316; x=1683388316;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXGtO/ZmgcxJ+0cLf6d2t80Dy16O6Eu74rSJdt26LEE=;
        b=HY9M7WOGEn9QVScSBZSqW47pBn64B4MJtfEHzCDocch7F9iBTOCYHDoALxmVY1rhPF
         03Oq3k0maylHPEEMHkl92AKDD55xJprX6Yjot7O0WA64etLKdF1KC0eUsXy9kEHEDFiS
         0FTIj8V9LIUAPOY/unvsCHJuDWIy9FfUtCydaxGVbImdFefYMu2HTZedsxuspzcBnH0u
         YncL8LA79N6MsCeLjM0KqU9ikQnZZArAMLoVJEDiAPQ7q7DtlEzcSz7YaU1r5dOV2poI
         Z8q8XWRjFHokfMFeFthkfN/sTW5MKEH8PSPCHOLWT4ZlWQnw3IBvRiH4Ety0wN52Cbf6
         NBag==
X-Gm-Message-State: AAQBX9eKZaBfgmqjMAxjppF3MLHl7AfPVCgL8llDWiSVc+wRk9J3kGot
        Ip7kQavW5ioyT8H5t8pABf1r214IJGjQPbxFSC21mfqwrON8yhzB3liQPN5+QHQYKXFGoO3QG4a
        /G2Uim5l1bRu/VKyVOJueiA==
X-Received: by 2002:a5d:4b48:0:b0:2c5:5349:22c1 with SMTP id w8-20020a5d4b48000000b002c5534922c1mr4313679wrs.5.1680796315809;
        Thu, 06 Apr 2023 08:51:55 -0700 (PDT)
X-Google-Smtp-Source: AKy350ay4SJLqt5fA44R22zdeLYwjok7IPAqD9HIjt6I2uRSHvro/TvSjV0I+pG8tJTj7AgJtBYNWg==
X-Received: by 2002:a5d:4b48:0:b0:2c5:5349:22c1 with SMTP id w8-20020a5d4b48000000b002c5534922c1mr4313662wrs.5.1680796315457;
        Thu, 06 Apr 2023 08:51:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:6300:a8be:c1ad:41a1:2bf7? (p200300cbc7056300a8bec1ad41a12bf7.dip0.t-ipconnect.de. [2003:cb:c705:6300:a8be:c1ad:41a1:2bf7])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d668d000000b002e61e002943sm2031659wru.116.2023.04.06.08.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 08:51:54 -0700 (PDT)
Message-ID: <248392c0-52d1-d09d-75ec-9e930435c053@redhat.com>
Date:   Thu, 6 Apr 2023 17:51:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To:     Peter Zijlstra <peterz@infradead.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Yair Podemsky <ypodemsk@redhat.com>, linux@armlinux.org.uk,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, arnd@arndb.de, keescook@chromium.org,
        paulmck@kernel.org, jpoimboe@kernel.org, samitolvanen@google.com,
        ardb@kernel.org, juerg.haefliger@canonical.com,
        rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        tony@atomide.com, linus.walleij@linaro.org,
        sebastian.reichel@collabora.com, nick.hawkins@hpe.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, vschneid@redhat.com, dhildenb@redhat.com,
        alougovs@redhat.com, jannh@google.com,
        Yang Shi <shy828301@gmail.com>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com> <ZC1Q7uX4rNLg3vEg@lothringen>
 <ZC1XD/sEJY+zRujE@lothringen> <ZC3P3Ds/BIcpRNGr@tpad>
 <20230405195226.GB365912@hirez.programming.kicks-ass.net>
 <ZC69Wmqjdwk+I8kn@tpad>
 <20230406132928.GM386572@hirez.programming.kicks-ass.net>
 <20230406140423.GA386634@hirez.programming.kicks-ass.net>
 <20230406150213.GQ386572@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to CPUs in kernel mode
In-Reply-To: <20230406150213.GQ386572@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 06.04.23 17:02, Peter Zijlstra wrote:
> On Thu, Apr 06, 2023 at 04:04:23PM +0200, Peter Zijlstra wrote:
>> On Thu, Apr 06, 2023 at 03:29:28PM +0200, Peter Zijlstra wrote:
>>> On Thu, Apr 06, 2023 at 09:38:50AM -0300, Marcelo Tosatti wrote:
>>>
>>>>> To actually hit this path you're doing something really dodgy.
>>>>
>>>> Apparently khugepaged is using the same infrastructure:
>>>>
>>>> $ grep tlb_remove_table khugepaged.c
>>>> 	tlb_remove_table_sync_one();
>>>> 	tlb_remove_table_sync_one();
>>>>
>>>> So just enabling khugepaged will hit that path.
>>>
>>> Urgh, WTF..
>>>
>>> Let me go read that stuff :/
>>
>> At the very least the one on collapse_and_free_pmd() could easily become
>> a call_rcu() based free.
>>
>> I'm not sure I'm following what collapse_huge_page() does just yet.
> 
> DavidH, what do you thikn about reviving Jann's patches here:
> 
>    https://bugs.chromium.org/p/project-zero/issues/detail?id=2365#c1
> 
> Those are far more invasive, but afaict they seem to do the right thing.
> 

I recall seeing those while discussed on security@kernel.org. What we 
currently have was (IMHO for good reasons) deemed better to fix the 
issue, especially when caring about backports and getting it right.

The alternative that was discussed in that context IIRC was to simply 
allocate a fresh page table, place the fresh page table into the list 
instead, and simply free the old page table (then using common machinery).

TBH, I'd wish (and recently raised) that we could just stop wasting 
memory on page tables for THPs that are maybe never going to get 
PTE-mapped ... and eventually just allocate on demand (with some 
caching?) and handle the places where we're OOM and cannot PTE-map a THP 
in some descend way.

... instead of trying to figure out how to deal with these page tables 
we cannot free but have to special-case simply because of GUP-fast.

-- 
Thanks,

David / dhildenb

