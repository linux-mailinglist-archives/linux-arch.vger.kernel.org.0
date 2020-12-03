Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCF52CD155
	for <lists+linux-arch@lfdr.de>; Thu,  3 Dec 2020 09:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgLCIei (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Dec 2020 03:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgLCIeh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Dec 2020 03:34:37 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82998C061A4E
        for <linux-arch@vger.kernel.org>; Thu,  3 Dec 2020 00:33:51 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id jx16so2165544ejb.10
        for <linux-arch@vger.kernel.org>; Thu, 03 Dec 2020 00:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9dfbprICCCrSs+WBMIlheF+1A8ZYjR+D6Ak7ORnabGY=;
        b=NJFoncHy+4AOXb8Innv/FCULVy0+N8C7fKWW18kIlWveSqghbWln7vhBxVw1/MrCbP
         muzrjYmmSF/uZXoGtZoHS3YpuHHXFjBdvVyCorQAXPpE+ZblkanGJzdANqXD+bhDTu0R
         PKs+K6h1GAnSl7O5Qc4QYird35hgdQ2EcSawU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9dfbprICCCrSs+WBMIlheF+1A8ZYjR+D6Ak7ORnabGY=;
        b=c/ZhGPXvSQlIKnwgTf3PWwQ4HUNdsJi+LTckR+YO1CEupoP9m7qWc+zTv22HUOpggw
         szCDo0immvOPipWEA6Pw9Yy9KCWgymxVpaAQ1IPETCRr9Kx1Cty6L4KDtdhz36mrE/Et
         M3MdM28Oyksdy3/tAJcAIYaBDAnuJsFzCyPk1ELLlT4x2Uq9RW1GWy91wG92IBS/sUtC
         4qI3gAxgpBKEqvMbjtUqLIIdHzakCAmXAuDzDGbmkf79uITzaTskU6yR05Ac60yAR/ME
         cZAiQPB00+8Vhm72LHf7i/nvUQC9ldt29hkK5xY0upQiJBKJvLLXEJicBf7c2nGeEPNK
         ozVA==
X-Gm-Message-State: AOAM532AO98qUdMRC1kFOiQBWbhksvYhw5g7x3ZIan9Z1kGixceWWxOU
        JVUVLHEJkcyxs52PYdnpnvPoww==
X-Google-Smtp-Source: ABdhPJxJC4Mpzmvk9poq0MRvOlTyj0t4lWAiJRRdC5e51eVHa2ZMJdwHDTK5SUyyNI0IlJIvmWLboQ==
X-Received: by 2002:a17:906:6010:: with SMTP id o16mr1518630ejj.55.1606984430082;
        Thu, 03 Dec 2020 00:33:50 -0800 (PST)
Received: from [192.168.1.149] (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id n4sm641113edt.46.2020.12.03.00.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 00:33:49 -0800 (PST)
Subject: Re:
To:     Yun Levi <ppbuk5246@gmail.com>, Yury Norov <yury.norov@gmail.com>
Cc:     dushistov@mail.ru, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        richard.weiyang@linux.alibaba.com, joseph.qi@linux.alibaba.com,
        skalluru@marvell.com, Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <CAM7-yPQcmU3MM66oAHQ6kcEukPFgj074_h-S-S+O53Lrx2yeBg@mail.gmail.com>
 <20201202094717.GX4077@smile.fi.intel.com>
 <c79b08e9-d36a-849e-d023-6fa155043aa9@rasmusvillemoes.dk>
 <CAM7-yPTsy+wJO8oQ7srjiXk+VjFFSUdJfdnVx9Ma_H8jJJnZKA@mail.gmail.com>
 <CAAH8bW-jUeFVU-0OrJzK-MuGgKJgZv38RZugEQzFRJHSXFRRDA@mail.gmail.com>
 <CAM7-yPRBPP6SFzdmwWF5Y99g+aWcp=OY9Uvp-5h1MSDPmsORNw@mail.gmail.com>
 <CAAH8bW-+XnNsd9p3xZ1utmyY24gaBa0ko4tngBii4T+2cMkcYg@mail.gmail.com>
 <CAM7-yPQCWj6rOyLEgOqF3HGkFV1WKtqyVhEtDbS3HW=2A-HuBA@mail.gmail.com>
 <CAM7-yPTtiVnUztE=xpNYgRcZTGd1aX_V9ZHd=2YZYc1uQNBXtw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <a0cc0d2e-9c55-8546-f070-26feed5de37f@rasmusvillemoes.dk>
Date:   Thu, 3 Dec 2020 09:33:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAM7-yPTtiVnUztE=xpNYgRcZTGd1aX_V9ZHd=2YZYc1uQNBXtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 03/12/2020 02.23, Yun Levi wrote:
> On Thu, Dec 3, 2020 at 7:51 AM Yun Levi <ppbuk5246@gmail.com> wrote:
>>
>> On Thu, Dec 3, 2020 at 6:26 AM Yury Norov <yury.norov@gmail.com> wrote:
>>>
>>> On Wed, Dec 2, 2020 at 10:22 AM Yun Levi <ppbuk5246@gmail.com> wrote:
>>>>
>>>> On Thu, Dec 3, 2020 at 2:26 AM Yury Norov <yury.norov@gmail.com> wrote:
>>>>
>>>>> Also look at lib/find_bit_benchmark.c
>>>> Thanks. I'll see.
>>>>
>>>>> We need find_next_*_bit() because find_first_*_bit() can start searching only at word-aligned
>>>>> bits. In the case of find_last_*_bit(), we can start at any bit. So, if my understanding is correct,
>>>>> for the purpose of reverse traversing we can go with already existing find_last_bit(),
>>>>
>>>> Thank you. I haven't thought that way.
>>>> But I think if we implement reverse traversing using find_last_bit(),
>>>> we have a problem.
>>>> Suppose the last bit 0, 1, 2, is set.
>>>> If we start
>>>>     find_last_bit(bitmap, 3) ==> return 2;
>>>>     find_last_bit(bitmap, 2) ==> return 1;
>>>>     find_last_bit(bitmap, 1) ==> return 0;
>>>>     find_last_bit(bitmap, 0) ===> return 0? // here we couldn't

Either just make the return type of all find_prev/find_last be signed
int and use -1 as the sentinel to indicate "no such position exists", so
the loop condition would be foo >= 0. Or, change the condition from
"stop if we get the size returned" to "only continue if we get something
strictly less than the size we passed in (i.e., something which can
possibly be a valid bit index). In the latter case, both (unsigned)-1
aka UINT_MAX and the actual size value passed work equally well as a
sentinel.

If one uses UINT_MAX, a for_each_bit_reverse() macro would just be
something like

for (i = find_last_bit(bitmap, size); i < size; i =
find_last_bit(bitmap, i))

if one wants to use the size argument as the sentinel, the caller would
have to supply a scratch variable to keep track of the last i value:

for (j = size, i = find_last_bit(bitmap, j); i < j; j = i, i =
find_last_bit(bitmap, j))

which is probably a little less ergonomic.

Rasmus
