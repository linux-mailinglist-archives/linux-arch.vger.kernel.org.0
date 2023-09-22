Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E247AB328
	for <lists+linux-arch@lfdr.de>; Fri, 22 Sep 2023 15:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjIVN4i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Sep 2023 09:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjIVN4h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Sep 2023 09:56:37 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43715E8
        for <linux-arch@vger.kernel.org>; Fri, 22 Sep 2023 06:56:31 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79f96830e4dso15725939f.1
        for <linux-arch@vger.kernel.org>; Fri, 22 Sep 2023 06:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695390990; x=1695995790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l4ucugCATkzwXuMI23OkOn2TmVsi6Gz/cX1EPcaz7Pc=;
        b=OXfNquCIOcbqGFkW8h4CwCOrqp13I/OO5Ey9q0Ta9VHoviE5FI1wY5XxB0J3PW+sHg
         0ltGtSn3TC7n4L1Neos1SZdAPGDeEE9q1binQlp4zP3fZTzyO2Z8btQ0Mdh+Kz5gTuRV
         6HB1b2DI88yO9o8DRswBiRulqaqsYRk4sOEzRb0kDoOBJyefZSqYjocWUbdz9dXPOGYn
         WNJJUfOV3uYi8Xt5jBqr+cJjshrbnCa+TZAkDfGiSmSSQgrxYG8hxe9Ygjs5xs0y+hKF
         VRub7/r03NVK5HT2ojyWTwPCMq7sjh4UjxDmYNWQePXMOPvXefCapWgoMPHa+m/KkmiX
         fT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695390990; x=1695995790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4ucugCATkzwXuMI23OkOn2TmVsi6Gz/cX1EPcaz7Pc=;
        b=OJrzT9SAQO/UT8nZVw9e1SgiifYv74Cj7+4xGwspgoJXysMy4/Df7RfqlPXXSfCs2d
         ddEdu9YSJvA63d2cKxdpzt/TWcu1o+JFujeuKMhmb/pjopPahmmSeP0X91UC4bKngUn0
         9DKzCsMy3CB6CshLux+9JU9Tje6i3xgfIvQEYbYEgMzaE4vr9k+8JtiKsnSZhqMccxIp
         ZtIPpuiEUvfgHyHL1dxt7i7UvuZ8Hx4nhdKhTAoHML/4HbjMq49RrhfVpftkYBOgWniw
         g99jhyIlQd8nP59IMPT2hygXl7mSZpKziO8tUZcitMXRqvJm18LWVuR7jpvKIekf0o7Q
         9v4Q==
X-Gm-Message-State: AOJu0YznxhQ9r4zx1LPp3XwK9WZwz0qRg06PeBnJP+F1IOGCxtwy5bUB
        FXJYq3FKaYe4Lreyj1wTao7f6g==
X-Google-Smtp-Source: AGHT+IGjSQ4+X2lvYsCJzmEr2bY8Ksct5WoXMUIbuCCLm87x5DFFi7/n497IxFMbPn45HSyCkxKdYQ==
X-Received: by 2002:a05:6602:13c2:b0:79d:1c65:9bde with SMTP id o2-20020a05660213c200b0079d1c659bdemr11422024iov.1.1695390990588;
        Fri, 22 Sep 2023 06:56:30 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l13-20020a02cd8d000000b0042b05586c52sm1028681jap.25.2023.09.22.06.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 06:56:29 -0700 (PDT)
Message-ID: <ec7cf6ad-3081-47a8-be83-af6eb7befa35@kernel.dk>
Date:   Fri, 22 Sep 2023 07:56:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] futex: Add sys_futex_requeue()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de, Geert Uytterhoeven <geert@linux-m68k.org>
References: <20230921104505.717750284@noisy.programming.kicks-ass.net>
 <20230921105248.511860556@noisy.programming.kicks-ass.net>
 <ZQ1fx29+b8PmLVk6@gmail.com>
 <20230922110335.GC7080@noisy.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230922110335.GC7080@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/22/23 5:03 AM, Peter Zijlstra wrote:
> On Fri, Sep 22, 2023 at 11:35:03AM +0200, Ingo Molnar wrote:
>>
>> * peterz@infradead.org <peterz@infradead.org> wrote:
>>
>>> --- linux-2.6.orig/kernel/futex/syscalls.c
>>> +++ linux-2.6/kernel/futex/syscalls.c
>>> @@ -396,6 +396,44 @@ SYSCALL_DEFINE6(futex_wait,
>>>  	return ret;
>>>  }
>>>  
>>> +/*
>>> + * sys_futex_requeue - Requeue a waiter from one futex to another
>>> + * @waiters:	array describing the source and destination futex
>>> + * @flags:	unused
>>> + * @nr_wake:	number of futexes to wake
>>> + * @nr_requeue:	number of futexes to requeue
>>> + *
>>> + * Identical to the traditional FUTEX_CMP_REQUEUE op, except it is part of the
>>> + * futex2 family of calls.
>>> + */
>>> +
>>> +SYSCALL_DEFINE4(futex_requeue,
>>> +		struct futex_waitv __user *, waiters,
>>> +		unsigned int, flags,
>>> +		int, nr_wake,
>>> +		int, nr_requeue)
>>> +{
>>> +	struct futex_vector futexes[2];
>>> +	u32 cmpval;
>>> +	int ret;
>>> +
>>> +	if (flags)
>>> +		return -EINVAL;
>>
>> Small detail, but isn't -ENOSYS the canonical error code for functionality 
>> not yet implemented - which the unused 'flags' ABI is arguably?
>>
>> -EINVAL is for recognized but incorrect parameters, such as:
> 
> IIUC 'unknown flag' falls into the -EINVAL return category. Here we
> happen to have no known flags, but that should not matter.

Yep, -ENOSYS is for not having the syscall at all, -EINVAL for unknown
flags set.

-- 
Jens Axboe

