Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A4B5F5F35
	for <lists+linux-arch@lfdr.de>; Thu,  6 Oct 2022 04:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiJFCzj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Oct 2022 22:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiJFCzT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Oct 2022 22:55:19 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3132B8992F;
        Wed,  5 Oct 2022 19:52:48 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f193so744533pgc.0;
        Wed, 05 Oct 2022 19:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=A1VbCAXIYbfneAnNEMFHKQ0qqjQfqURaDKyX/Tusj6A=;
        b=gwVXdp4WTb32v4iigii12jJNfK/9jLMKDlfHJixd9CUlkpjBiuFYVqly6GDED8ReEP
         HWmTq5CMeWmsOOZnV8DcyPMDJ0PNDZyTXiTA2ez6FqBJ1tsPtYwfpJ5x9IdqlCbm/bH0
         bEHcPJiBozmxDbyKyCXxxUz8yM2Nz1fleuA6W8mRUl7WiM9xBZPWK72udVHicgrcS+nd
         zsUYH75zsP4H06ADpWt/CMP3JD+872gyBBhgCN8ZcfK98OR3XCVf0eQlNOGdZSXjuzC+
         yiuQ8rB7SZP46Ta2wIYjDpf5qYZXaHGX582RQrWSCWXHqpB2fz7W7hGUpwCGvA+9pv1o
         JBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=A1VbCAXIYbfneAnNEMFHKQ0qqjQfqURaDKyX/Tusj6A=;
        b=3hOxPWj6WNRzHQIq5kySFVdeQwhQf2CgkOhDk9olaE49FR/vDqZvgNfBoPromB7sO6
         Ehup9lt3I/8pTzCYLJfWO7eRNenttvc5tWYC6Ufysqp0kgGN2ZbXRPDsl5GrRDnvFLQS
         qUtQafUdl3Mwbo6kbNprD9AR8ZkhwAqIhWzg1v2rb3K7gQAflhvPY54hItXrhdeJaFqp
         ERxlEaZuvhv0n1ATyhLlAuX6E73swZMNOMuRpo7vyQOOcwRJeAf1lNojr0/Gf/K/sBDX
         EVqjwRuTG3oEtbGBHy5WIBoej5XHL8e58WAKjLM62zexGAbp6g4XFLcSUCqBAwuT00w0
         eChQ==
X-Gm-Message-State: ACrzQf1kXX4OxQRKBtf6gdRJvya+NLBwIk2FBT0P07NfHtx+C7MWkeNd
        Z60L408R+lo3ANLSWT6DMaU=
X-Google-Smtp-Source: AMsMyM6Mwheb7z9+PAaDCQ6TpRI278byfyhz9jDEgYn7iFsvcuPIqRaBbejSjNmRCS0L8m/5qnAkhw==
X-Received: by 2002:a63:5f58:0:b0:458:802:d24b with SMTP id t85-20020a635f58000000b004580802d24bmr2478666pgb.401.1665024755647;
        Wed, 05 Oct 2022 19:52:35 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id k7-20020a63ff07000000b00439f027789asm496649pgi.59.2022.10.05.19.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 19:52:35 -0700 (PDT)
Message-ID: <fca75232-bf18-e6e8-0072-0906a618ea9c@gmail.com>
Date:   Thu, 6 Oct 2022 11:52:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] locking/memory-barriers.txt: Improve documentation for
 writel() example
Content-Language: en-US
To:     Parav Pandit <parav@nvidia.com>
Cc:     bagasdotme@gmail.com, arnd@arndb.de, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@kernel.org,
        dlustig@nvidia.com, joel@joelfernandes.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <20221005104749.157444-1-parav@nvidia.com>
 <6a6941fb-53a0-cdd2-9783-590cb959d4e7@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <6a6941fb-53a0-cdd2-9783-590cb959d4e7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 6 Oct 2022 11:48:04 +0900, Akira Yokosawa wrote:
> Hi,
> 
> Maybe I'm too nit-picky, but see below:
> 
> On Wed, 5 Oct 2022 13:47:49 +0300, Parav Pandit wrote:
>> The cited commit describes that when using writel(), explcit wmb()
>> is not needed. wmb() is an expensive barrier. writel() uses the needed
>> platform specific barrier instead of expensive wmb().
>>
>> Hence update the example to be more accurate that matches the current
>> implementation.
>>
>> commit 5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example")
> 
> You can cite the commit in the Changelog text.
> Just say:
> 
>     Commit 5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs.
>     MMIO ordering example") describes that when using writel(), ...
> 
> Also, a blank line is needed above S-o-b tags as a delimiter.
> 
>> Signed-off-by: Parav Pandit <parav@nvidia.com>
>>
>> ---
>> changelog:
>> v1->v2:
>> - Further improved description of writel() example
>> - changed commit subject from 'usage' to 'example'
>> v0->v1:
>> - Corrected to mention I/O barrier instead of dma_wmb().
>> - removed numbered references in commit log
>> - corrected typo 'explcit' to 'explicit' in commit log
>> ---
>>  Documentation/memory-barriers.txt | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
>> index 832b5d36e279..49e1433db407 100644
>> --- a/Documentation/memory-barriers.txt
>> +++ b/Documentation/memory-barriers.txt
>> @@ -1927,10 +1927,12 @@ There are some more advanced barrier functions:
>>       before we read the data from the descriptor, and the dma_wmb() allows
>>       us to guarantee the data is written to the descriptor before the device
>>       can see it now has ownership.  The dma_mb() implies both a dma_rmb() and
>> -     a dma_wmb().  Note that, when using writel(), a prior wmb() is not needed
>> -     to guarantee that the cache coherent memory writes have completed before
>> -     writing to the MMIO region.  The cheaper writel_relaxed() does not provide
>> -     this guarantee and must not be used here.
>> +     a dma_wmb().  Note that, when using writel(), a prior barrier is not
> If you permit a slightly long line here, this hunk would be much easier to
> compare:
> 
> +     a dma_wmb().  Note that, when using writel(), a prior barrier is not needed
>       to guarantee that the cache coherent memory writes have completed before
>       writing to the MMIO region.  The cheaper writel_relaxed() does not provide
> +     this guarantee and must not be used here. Hence, writeX() is always
> +     preferred which inserts needed platform specific barrier before writing to
> +     the specified MMIO region.
> 
> That said, I don't feel comfortable with the sentence you added.
> It looks to me it is redundant because such a guarantee of writeX() is already
> covered in the section of "KERNEL I/O BARRIER EFFECTS".
> See the relevant explanation quoted below:
> 
> 	3. A writeX() by a CPU thread to the peripheral will first wait for the
> 	   completion of all prior writes to memory either issued by, or
> 	   propagated to, the same thread. This ensures that writes by the CPU
> 	   to an outbound DMA buffer allocated by dma_alloc_coherent() will be
> 	   visible to a DMA engine when the CPU writes to its MMIO control
> 	   register to trigger the transfer.
> 
> Also please not that this document should not describe any implementation
I meant       note

> details of those accessors. This document is not meant as an implementation
> guide, but a guide for kernel developers who use them. This is clearly
> mentioned in "DISCLAIMER" at the top of this file.
> 
>         Thanks, Akira
> 
>> +     needed to guarantee that the cache coherent memory writes have completed
>> +     before writing to the MMIO region.  The cheaper writel_relaxed() does not
>> +     provide this guarantee and must not be used here. Hence, writeX() is always
>> +     preferred which inserts needed platform specific barrier before writing to
>> +     the specified MMIO region.
>>  
>>       See the subsection "Kernel I/O barrier effects" for more information on
>>       relaxed I/O accessors and the Documentation/core-api/dma-api.rst file for
