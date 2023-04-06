Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240B76D9ADE
	for <lists+linux-arch@lfdr.de>; Thu,  6 Apr 2023 16:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbjDFOoJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Apr 2023 10:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239384AbjDFOnu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2023 10:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3072FE55
        for <linux-arch@vger.kernel.org>; Thu,  6 Apr 2023 07:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680792128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gj/7YiiNEEJ4+hsVKCJkj1HvadHLyL0uUxvEtZRASmc=;
        b=MFH7ILfxbxZqwO0kUF9n0x6w2yOBze1MxGq/VEeatz4ioSpLISS87DxB3FDvicAARR+9QA
        s51Ge5pm9TdLPJglEADJtgBgdA4ozmMs2yKsILr6cyhqVmd86lXUWM4E+u/lLbT2p3E3tI
        QkYVLP3BjATwNTZLVt1NF8ymBEekAZo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-PCHzLndhMGSUinbtjeOZzQ-1; Thu, 06 Apr 2023 10:42:07 -0400
X-MC-Unique: PCHzLndhMGSUinbtjeOZzQ-1
Received: by mail-wr1-f69.google.com with SMTP id c3-20020adfa303000000b002d5737d3835so5001262wrb.21
        for <linux-arch@vger.kernel.org>; Thu, 06 Apr 2023 07:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680792126; x=1683384126;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gj/7YiiNEEJ4+hsVKCJkj1HvadHLyL0uUxvEtZRASmc=;
        b=5e7kx+Yaj5TcmowVCZaEUtxMXGD6/45h7Lruc1j3ClD3YUlq6WAEAaXPPWQH43pSuI
         FdWtjE93pXokCsLAkiGMbZ2HGubBgpNhW/HhIaHi6ZX6Gr9aXMHgzBxhlqHlK+wOf0+l
         wIHsfWj/U28vO3BkDz7HVe/oCHrJXF+bla3HRIf2eOU8zOpvUgh5bIqWVynK7J9zS5SZ
         gM90loHxD4xT4b6agX6QenLdZkCvDRt3bJKclxh5jfLUkGhT3xheRTuq7GAmgtidFau5
         r5+q+dyZtGF7PtRVgUFkeZNxfaBuFnEdU9hmZwa48EmHBZ7mfzl13tm9FanN8h//YpEa
         +LMg==
X-Gm-Message-State: AAQBX9cTvo2mR4b7ejYpDf0pDz5+Kz9+qHq4Pks6jaD5CMxN4xScZcC4
        2Vdza3L1FqAhlvt7CSx91vgB/eJSF9P73lx7+6JLNR4ITrPeLufELK4YRVvqZGG+vb9GrOMmRQC
        WZBD6jiju1znRZ0vKQNgXjg==
X-Received: by 2002:adf:edd1:0:b0:2cf:e436:f722 with SMTP id v17-20020adfedd1000000b002cfe436f722mr7362221wro.64.1680792125934;
        Thu, 06 Apr 2023 07:42:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350aYtbTmofQf/bI+zulYGKU6rzEaLaSQD1iMgTDT9wELk7OW8105qv2TVrk0E+k02OOZTiYupA==
X-Received: by 2002:adf:edd1:0:b0:2cf:e436:f722 with SMTP id v17-20020adfedd1000000b002cfe436f722mr7362204wro.64.1680792125568;
        Thu, 06 Apr 2023 07:42:05 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id m8-20020adffe48000000b002c55521903bsm1942945wrs.51.2023.04.06.07.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 07:42:04 -0700 (PDT)
Message-ID: <1654e2d5-5a32-a253-e335-0ee42f69f5ef@redhat.com>
Date:   Thu, 6 Apr 2023 16:42:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
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
        alougovs@redhat.com, jannh@google.com
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com> <ZC1Q7uX4rNLg3vEg@lothringen>
 <ZC1XD/sEJY+zRujE@lothringen> <ZC3P3Ds/BIcpRNGr@tpad>
 <20230405195226.GB365912@hirez.programming.kicks-ass.net>
 <ZC69Wmqjdwk+I8kn@tpad>
 <20230406132928.GM386572@hirez.programming.kicks-ass.net>
 <20230406140423.GA386634@hirez.programming.kicks-ass.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to CPUs in kernel mode
In-Reply-To: <20230406140423.GA386634@hirez.programming.kicks-ass.net>
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

On 06.04.23 16:04, Peter Zijlstra wrote:
> On Thu, Apr 06, 2023 at 03:29:28PM +0200, Peter Zijlstra wrote:
>> On Thu, Apr 06, 2023 at 09:38:50AM -0300, Marcelo Tosatti wrote:
>>
>>>> To actually hit this path you're doing something really dodgy.
>>>
>>> Apparently khugepaged is using the same infrastructure:
>>>
>>> $ grep tlb_remove_table khugepaged.c
>>> 	tlb_remove_table_sync_one();
>>> 	tlb_remove_table_sync_one();
>>>
>>> So just enabling khugepaged will hit that path.
>>
>> Urgh, WTF..
>>
>> Let me go read that stuff :/
> 
> At the very least the one on collapse_and_free_pmd() could easily become
> a call_rcu() based free.
> 
> I'm not sure I'm following what collapse_huge_page() does just yet.

It wants to replace a leaf page table by a THP (Transparent Huge Page 
mapped by a PMD). So we want to rip out a leaf page table while other 
code (GUP-fast) might still be walking it. In contrast to freeing the 
page table, we put it into a list where it can be reuse when having to 
PTE-map a THP again.

Now, similar to after freeing the page table, someone else could reuse 
that page table and modify it.

If we have GUP-fast walking the page table while that is happening, 
we're in trouble. So we have to make sure GUP-fast is done before 
enqueuing the now-free page table.

That's why the tlb_remove_table_sync_one() was recently added (by Jann 
IIRC).

-- 
Thanks,

David / dhildenb

