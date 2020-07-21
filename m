Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BB722782A
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 07:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgGUFae (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 01:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgGUFae (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 01:30:34 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B0BC061794;
        Mon, 20 Jul 2020 22:30:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gc9so1006856pjb.2;
        Mon, 20 Jul 2020 22:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4BDQCGagA0NpEa3cY5d8pyOcqpUidmjYVVUsO2rIpy0=;
        b=YEdhwIqX/LSZQJ60N8YqzVjHD4PW0DqTwHyRbKvM6amvhtCDDbMmPI1EsVCfnwkoCV
         1u9tl32h/rw5pCZN8vDiaiH7aCLe2bVmgVQlCXOVEBQhzgZ+npwes0jtV+ILb4VIdEbq
         0Caz8njRgPB/InhlLZ5JZrUEehXC+1mQbC7Mifx9yFKaJNqsE8Q8iIGDLT8ZiSQj5mZA
         TPmFUM+dbUtBXhwjcMEOwDfgxGngr/zOq0yo1kbrIQlEMQDEW0tayMmKKsl8t6c81V1I
         sQkywKkBoyXenMFGLaKGogXW5R04Lc5ic/WG4rVmwAP7Q0oEu2Rh3wy2Hy9OoUvmGByY
         6IBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4BDQCGagA0NpEa3cY5d8pyOcqpUidmjYVVUsO2rIpy0=;
        b=TcOgQqEIQX2ywgiVLmSqZQlqBXJuRhjOL6hqL/Ieer6XYAiPeF5eT5f35HKfpUVJFt
         czXvRWW4sT79UCfL30ZYLkgZ6jYbuXdU6cMlXUqWoE+5yRBQ1iw5PC/P0JTeIEyZorbz
         8Im9Cdvenk7W5dY+fege7s1upWmtB7YNSdqxHqG+J4DZbHqJF1gA45H4GlnaOVitVlLc
         w93nd9W+vsrY1kLWPWPcbuGxlHiCmy8QF6O39lk1v1cyNA2ZrlTP2eR1meEWclp0sj6D
         V/gOEpvGKuqHeJKWlsC2qutug0rjfQ/21W4pdaf7XQUK7p1zaBdMiXrgstwVMLwhIXN/
         5LOw==
X-Gm-Message-State: AOAM530eAMsVQ1d2JxmU+j5/7q+jRHGuFtHzJFz+0510DQxSZD/JSoUo
        34rkUYhv9A2l+VqrdXFlJ026vo6d
X-Google-Smtp-Source: ABdhPJyKPEVtEA4/LCzQMLH3bxoHGU4XQOANoPRjWXsydJIZc2/OF/VY8ia1/k1esHQBxDrm70RkXw==
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr2845260pjp.24.1595309433264;
        Mon, 20 Jul 2020 22:30:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k71sm1515479pje.33.2020.07.20.22.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 22:30:32 -0700 (PDT)
Subject: Re: [PATCH 1/6] syscalls: use uaccess_kernel in addr_limit_user_check
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200714105505.935079-1-hch@lst.de>
 <20200714105505.935079-2-hch@lst.de> <20200718013849.GA157764@roeck-us.net>
 <20200718094846.GA8593@lst.de> <20200720221046.GA86726@roeck-us.net>
 <20200721045834.GA9613@lst.de>
 <eb470677-b569-a6f0-e63b-60149b54863a@roeck-us.net>
 <20200721052022.GA10011@lst.de>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <7fc565fe-411e-6a0b-8aaf-0bf808f0d6a9@roeck-us.net>
Date:   Mon, 20 Jul 2020 22:30:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721052022.GA10011@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/20/20 10:20 PM, Christoph Hellwig wrote:
> On Mon, Jul 20, 2020 at 10:15:37PM -0700, Guenter Roeck wrote:
>>>> -       if (CHECK_DATA_CORRUPTION(uaccess_kernel(),
>>>> +       if (CHECK_DATA_CORRUPTION(!uaccess_kernel(),
>>>>
>>>> How does this work anywhere ?
>>>
>>> No, that is the wrong check - we want to make sure the address
>>> space override doesn't leak to userspace.  The problem is that
>>> armnommu (and m68knommu, but that doesn't call the offending
>>> function) pretends to not have a kernel address space, which doesn't
>>> really work.  Here is the fix I sent out yesterday, which I should
>>> have Cc'ed you on, sorry:
>>>
>>
>> The patch below makes sense, and it does work, but I still suspect
>> that something with your original patch is wrong, or at least suspicious.
>> Reason: My change above (Adding the "!") works for _all_ of my arm boot
>> tests. Or, in other words, it doesn't make a difference if true
>> or false is passed as first parameter of CHECK_DATA_CORRUPTION(), except
>> for nommu systems. Also, unless I am really missing something, your
>> original patch _does_ reverse the logic.
> 
> Well.  segment_eq is in current mainline used in two places:
> 
>  1) to implement uaccess_kernel
>  2) in addr_limit_user_check to implement uaccess_kernel-like
>     semantics using a strange reverse notation
> 
> I think the explanation for your observation is how addr_limit_user_check
> is called on arm.  The addr_limit_check_failed wrapper for it is called
> from assembly code, but only after already checking the addr_limit,
> basically duplicating the segment_eq check.  So for mmu builds it won't
> get called unless we leak the kernel address space override, which
> is a pretty fatal error and won't show up in your boot tests.  The
> only good way to test it is by explicit injecting it using the
> lkdtm module.
> 

Guess I lost it somewhere. Are you saying the check was wrong all along
and your patch fixed it ?

Thanks,
Guenter
