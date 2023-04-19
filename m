Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2749C6E78AA
	for <lists+linux-arch@lfdr.de>; Wed, 19 Apr 2023 13:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjDSLbu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Apr 2023 07:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjDSLbt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Apr 2023 07:31:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709501FE2
        for <linux-arch@vger.kernel.org>; Wed, 19 Apr 2023 04:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681903862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dPuQPsleEjjBeSq0BvDdXkwF3D8bnmU80K+kHEWN1i0=;
        b=S/jDl74isdKbaLWMnU5Ag4ajZ9OX3Zpnll/Y9HOXypP/ClW8YpGe3zq1F4pp2WFqMLl0/E
        yjoovhOxnSKOtII4B6orjOmxapGZHThrAtRb3hKICvf5hfA7Bw1nx1qvWYTbKd3uXaX02t
        CIqPeeyxoPNOC8LYhOI7dTYnJDAf8RU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-ioz-sxz3N-W_pH08WjkIUg-1; Wed, 19 Apr 2023 07:31:01 -0400
X-MC-Unique: ioz-sxz3N-W_pH08WjkIUg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-2fbb99cb244so1022279f8f.3
        for <linux-arch@vger.kernel.org>; Wed, 19 Apr 2023 04:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681903860; x=1684495860;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dPuQPsleEjjBeSq0BvDdXkwF3D8bnmU80K+kHEWN1i0=;
        b=Ypi/S1DcEZbyfPFbaLzr4IDglnzGmneQ/I6skEDMXC0wcPR+6s3LxPN430PyUBj5UC
         PkdddGRjMhvqnPgGhnYPJx1mp3Y6GDU9IDb6mBjuWhr5uZQnmPeAOGlce/4m5CPQHeEk
         MLJ6mXr1ekeRpbi0NcVfv9YfKgQ3t7GkzX25XfPPRznf0JWlxD4X7VSPsAf3lj7w6SWL
         dCsUR5C0T8RgRCHhnT+ugBD7PF5eO0VUrucu1yrsVPaAnsd6ALJa2BOjno9p+7OYPoNI
         i5d9DsmS8Oo5F5L5rfDx+FAcd0+/i+otIDNmnH+QQ7mhtZ2t27zXRK41eBWd+WkoF41N
         xjtQ==
X-Gm-Message-State: AAQBX9cLWouTRRQQPTzkF9flBRH107i7kAB+mJ2WeKsn2B64Q/rvgHzR
        11LSV1AJTlmcL/rRV1xkqj2JAHzSt0mFvG8FhgGgbQyr516ylkc0+2U3zryJtiLmhX0qpOqeEVK
        xAnnKu2m67Jhs0L7jKZuXXA==
X-Received: by 2002:a5d:69d0:0:b0:2fe:c0ea:18ad with SMTP id s16-20020a5d69d0000000b002fec0ea18admr1723929wrw.47.1681903860455;
        Wed, 19 Apr 2023 04:31:00 -0700 (PDT)
X-Google-Smtp-Source: AKy350bzhkcwsfhrSQkvGUIm/JW8RoVL0p90cvfrRI4bamTYUVPg7DxfHt0wqA8rK9Mz1QlqY1RVnA==
X-Received: by 2002:a5d:69d0:0:b0:2fe:c0ea:18ad with SMTP id s16-20020a5d69d0000000b002fec0ea18admr1723910wrw.47.1681903860074;
        Wed, 19 Apr 2023 04:31:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:7b00:7c52:a5fa:8004:96fd? (p200300cbc70b7b007c52a5fa800496fd.dip0.t-ipconnect.de. [2003:cb:c70b:7b00:7c52:a5fa:8004:96fd])
        by smtp.gmail.com with ESMTPSA id v17-20020a1cf711000000b003f16fdc6233sm1880494wmh.47.2023.04.19.04.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 04:30:59 -0700 (PDT)
Message-ID: <914e826e-3fab-4540-d3a1-24ca39b1cf0a@redhat.com>
Date:   Wed, 19 Apr 2023 13:30:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
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
References: <20230404134224.137038-4-ypodemsk@redhat.com>
 <ZC1Q7uX4rNLg3vEg@lothringen> <ZC1XD/sEJY+zRujE@lothringen>
 <ZC3P3Ds/BIcpRNGr@tpad>
 <20230405195226.GB365912@hirez.programming.kicks-ass.net>
 <ZC69Wmqjdwk+I8kn@tpad>
 <20230406132928.GM386572@hirez.programming.kicks-ass.net>
 <20230406140423.GA386634@hirez.programming.kicks-ass.net>
 <20230406150213.GQ386572@hirez.programming.kicks-ass.net>
 <248392c0-52d1-d09d-75ec-9e930435c053@redhat.com>
 <20230406182749.GA405948@hirez.programming.kicks-ass.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to CPUs in kernel mode
In-Reply-To: <20230406182749.GA405948@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 06.04.23 20:27, Peter Zijlstra wrote:
> On Thu, Apr 06, 2023 at 05:51:52PM +0200, David Hildenbrand wrote:
>> On 06.04.23 17:02, Peter Zijlstra wrote:
> 
>>> DavidH, what do you thikn about reviving Jann's patches here:
>>>
>>>     https://bugs.chromium.org/p/project-zero/issues/detail?id=2365#c1
>>>
>>> Those are far more invasive, but afaict they seem to do the right thing.
>>>
>>
>> I recall seeing those while discussed on security@kernel.org. What we
>> currently have was (IMHO for good reasons) deemed better to fix the issue,
>> especially when caring about backports and getting it right.
> 
> Yes, and I think that was the right call. However, we can now revisit
> without having the pressure of a known defect and backport
> considerations.
> 
>> The alternative that was discussed in that context IIRC was to simply
>> allocate a fresh page table, place the fresh page table into the list
>> instead, and simply free the old page table (then using common machinery).
>>
>> TBH, I'd wish (and recently raised) that we could just stop wasting memory
>> on page tables for THPs that are maybe never going to get PTE-mapped ... and
>> eventually just allocate on demand (with some caching?) and handle the
>> places where we're OOM and cannot PTE-map a THP in some descend way.
>>
>> ... instead of trying to figure out how to deal with these page tables we
>> cannot free but have to special-case simply because of GUP-fast.
> 
> Not keeping them around sounds good to me, but I'm not *that* familiar
> with the THP code, most of that happened after I stopped tracking mm. So
> I'm not sure how feasible is it.
> 
> But it does look entirely feasible to rework this page-table freeing
> along the lines Jann did.

It's most probably more feasible, although the easiest would be to just 
allocate a fresh page table to deposit and free the old one using the 
mmu gatherer.

This way we can avoid the khugepaged of tlb_remove_table_smp_sync(), but 
not the tlb_remove_table_one() usage. I suspect khugepaged isn't really 
relevant in RT kernels (IIRC, most of RT setups disable THP completely).

tlb_remove_table_one() only triggers if __get_free_page(GFP_NOWAIT | 
__GFP_NOWARN); fails. IIUC, that can happen easily under memory pressure 
because it doesn't wait for direct reclaim.

I don't know much about RT workloads (so I'd appreciate some feedback), 
but I guess we can run int memory pressure as well due to some !rt 
housekeeping task on the system?

-- 
Thanks,

David / dhildenb

