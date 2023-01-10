Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112BB663717
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jan 2023 03:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbjAJCKo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Jan 2023 21:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbjAJCKl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2023 21:10:41 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111EF3AB36;
        Mon,  9 Jan 2023 18:10:38 -0800 (PST)
Received: from [IPV6:2601:646:8600:40c1:c1a6:29dc:ac72:b87b] ([IPv6:2601:646:8600:40c1:c1a6:29dc:ac72:b87b])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30A29A831162371
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 9 Jan 2023 18:09:11 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30A29A831162371
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1673316565;
        bh=kYuTxVGdJeZQ71LtcvKU+xibL3tZdH1q8UEMIgJzYL8=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=Ua3iPSxblNvQokL81qPCOUC/5E5qPA5nHglOBrh0afmZlsyriW80nKnpEOFV38Gw8
         2a1i+XBNAtW0vbK8rhzrNz1Qr47ANVjBmZBUkV7u6GBj/A/sA4zV5D0pPhCUu+NZ49
         tb5dMmJ0usiuqsYVjaqkurWbWjsWLur1JbX6N5ge81qBaGVbgnm1PnElMb6RTlPnWZ
         w9+GkyyQceF+0d679wgf4DzuSdLBxU1uatTBCjGvHkPyn/1/GgCqg8BVHVBytI/XSO
         crfqV5ocmSLZ14MmZa+4JSmgaPl9p5XBEtYWaZaUkorNmvcjjQphvbXtdSK+bYycCQ
         YlN1xM/i/K23Q==
Message-ID: <13ad2c02-c7db-f32f-b085-b92b7dceefa4@zytor.com>
Date:   Mon, 9 Jan 2023 18:09:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC][PATCH 11/12] slub: Replace cmpxchg_double()
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>, corbet@lwn.net,
        will@kernel.org, boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, joro@8bytes.org,
        suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        Arnd Bergmann <arnd@arndb.de>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
References: <20221219153525.632521981@infradead.org>
 <20221219154119.550996611@infradead.org> <Y7Ri+Uij1GFkI/LB@osiris>
 <CAHk-=wj9nK825MyHXu7zkegc7Va+ZxcperdOtRMZBCLHqGrr=g@mail.gmail.com>
 <Y7xAsELYo4srs/z/@hirez.programming.kicks-ass.net>
 <CAHk-=whm+u8YoUaE9PKugYBxujhDL5twz6HqzqLP8OTXjKuT4g@mail.gmail.com>
 <3C179EF2-0B8A-47F0-8FE6-3BF97A4442BA@zytor.com>
Content-Language: en-US
In-Reply-To: <3C179EF2-0B8A-47F0-8FE6-3BF97A4442BA@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/9/23 14:22, H. Peter Anvin wrote:
>>
>> Another alternative is to try to avoid casting to "u64" as long as
>> humanly possible, and use only "typeof((*ptr))" everywhere. Then when
>> the type actually *is* 128-bit, it all works out fine, because it
>> won't be a pointer. That's the approach the uaccess macros tend to
>> take, and then they hit the reverse issue on clang, where using the
>> "byte register" constraints would cause warnings for non-byte
>> accesses, and we had to do
>>
>>                 unsigned char x_u8__;
>>                 __get_user_asm(x_u8__, ptr, "b", "=q", label);
>>                 (x) = x_u8__;
>>
>> because using '(x)' directly would then warn when 'x' wasn't a
>> char-sized thing - even if that asm case never actually was _used_ for
>> that case, since it was all inside a "switch (sizeof) case 1:"
>> statement.
>>
>>             Linus
> 

> I wrote a crazy macro for dealing with exactly this at one point,
> basically producing the "right type" to cast to. It would need to
> have 128-bit support added to it, but that should be trivial. It is
> called something like int_type() ... not in front of a computer right
> now so can't double check.
Right, it is called __inttype and is defined in 
arch/x86/include/asm/uaccess.h (and, apparently, a few other 
architectures; probably should be centralized.)

It has been rewritten since my first version using a nice little macro 
called __typefits, also would we worth centralizing.

	-hpa
