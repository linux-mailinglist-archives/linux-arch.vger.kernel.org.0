Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566F9699F93
	for <lists+linux-arch@lfdr.de>; Thu, 16 Feb 2023 23:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjBPWDZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Feb 2023 17:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBPWDY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Feb 2023 17:03:24 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4A43E60C
        for <linux-arch@vger.kernel.org>; Thu, 16 Feb 2023 14:03:22 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id bt4-20020a17090af00400b002341621377cso7347706pjb.2
        for <linux-arch@vger.kernel.org>; Thu, 16 Feb 2023 14:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tk54cGH4LqQLVC9wacMRd+1/MbtH+DDbz5meeqWmlLg=;
        b=Cn/Z8dptlM1o5l8Qv2p3Oaokark0bEAl1MucuaCKlVeM+0nhegqv6XBQSJ7iLJkXtE
         cQpSFXJsZsnqKjyy1NVXcMCPM8yVsKLZIY1IXS7NLrGMbScUo5PmC6krigekwmd/lx2O
         pc1qgDKmO0d6YsxcPD/c6i18hhvWvWng7n9BRq2rs9lKMlp46D+6wCgng8wUOp7JUlS8
         ITkvtg1QaQJCfndc1GwCoZx7zw3v3BljoOu33hQQQPv0Oae8m0Qi025g/G0ouXCDH0HB
         8WoCU6zMHYKSuwklsq/FTsCnJ0F3o2zfMnQeNVO2j7SvoPxgwNoAlz9YqmsXkxCPhC7g
         Uw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tk54cGH4LqQLVC9wacMRd+1/MbtH+DDbz5meeqWmlLg=;
        b=Y+FEzNfiRo4b9mNPxiMF8S0blZCGUMlWQu1OqnpTS8JKFGeT4J0wXWAhjOgkhVZSYk
         EgAiXOcG0ktXXelXgSo2w8yEfRgglwe4AFxYLs7kKlBdODI23bBB7p7XlmemW5J5FjFV
         uDdp+//mzMcKWOFux6tRWBM/kroYBnjEhPuTRlWt1np8BLWgD8mCvZcEYTE9dPzZYVyn
         VC/JP8GRnPntAifQgYdNOzsXA+UN9jf/QbUg0L6Xt0dlJpZ5ll/p3BBcJlj98kio8kFT
         8FpBPo3xy1X7JavVQ2za5R6R0sKv6wngf5AC/1omcqcR5BqqQHUkK5wHtHdAoVkskXs6
         vyww==
X-Gm-Message-State: AO0yUKWasR+TaDV+lyGKX2ITx4ATRiBX6GE5LozNNlZD9dBYTgsOLg1l
        AmkJS8H0nrfeCt4BJpY3CHw=
X-Google-Smtp-Source: AK7set/O7mi33sTg65iC+16XhIxGTaiqxvui8Y6X+Ehn5Zki9wIVvuZcanngN2uUvi/EFQX18Bb5iA==
X-Received: by 2002:a17:903:2844:b0:19a:9797:1631 with SMTP id kq4-20020a170903284400b0019a97971631mr5811307plb.3.1676585002264;
        Thu, 16 Feb 2023 14:03:22 -0800 (PST)
Received: from ?IPV6:2001:df0:0:200c:8dff:a3c:def2:5826? ([2001:df0:0:200c:8dff:a3c:def2:5826])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902ee4d00b0019919b7e5b1sm1789528plo.168.2023.02.16.14.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 14:03:21 -0800 (PST)
Message-ID: <a1783a1c-b599-0e44-e88c-181470c5675f@gmail.com>
Date:   Fri, 17 Feb 2023 11:03:16 +1300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 15/17] m68k: Implement the new page table range API
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch@vger.kernel.org
References: <20230215000446.1655635-1-willy@infradead.org>
 <20230215200920.1849567-1-willy@infradead.org>
 <20230215200920.1849567-2-willy@infradead.org>
 <84c923f7-c60b-068d-bb06-48aea1412f53@gmail.com>
 <Y+2wdSxVgS6HmFRy@casper.infradead.org>
Content-Language: en-US
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <Y+2wdSxVgS6HmFRy@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Matthew,

On 16/02/23 17:26, Matthew Wilcox wrote:
> On Thu, Feb 16, 2023 at 01:59:44PM +1300, Michael Schmitz wrote:
>> Matthew,
>>
>> On 16/02/23 09:09, Matthew Wilcox (Oracle) wrote:
>>> Add set_ptes(), update_mmu_cache_range(), flush_icache_pages() and
>>> flush_dcache_folio().  I'm not entirely certain that the 040/060 case
>>> in __flush_pages_to_ram() is correct.
>> I'm pretty sure you need to iterate to hit each of the pages - the code as
>> is will only push cache entries for the first page.
>>
>> Quoting the 040 UM:
>>
>> "Both instructions [cinv, cpush] allow operation on a single cache line, all
>> cache lines in a specific page, or an entire cache, and can select one or
>> both caches for the operation. For line and page operations, a physical
>> address in an address register specifies the memory address."
> I actually found that!  What I didn't find was how to tell if this
> cpush insn is the one which is operating on a single cache line,
> a single page, or the entire cache.
>
> So I should do a loop around this asm and call it once for each page
> we're flushing?

Yes, that's the idea. I'm uncertain whether contiguous virtual pages are 
always guaranteed to have contiguous physical mappings, so no point in 
trying to 'optimize' and shift the loop into inline assembly.

Cheers,

     Michael



>
