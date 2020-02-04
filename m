Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A363152306
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 00:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgBDXfW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Feb 2020 18:35:22 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42688 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbgBDXfW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Feb 2020 18:35:22 -0500
Received: by mail-yw1-f67.google.com with SMTP id b81so626957ywe.9;
        Tue, 04 Feb 2020 15:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a0Zh5A5UVxi7kLLHGfwoywGVILuqTGw6v50Ysx9v2pg=;
        b=pXCavDKVVuw9mEkjafbCaKO5pjGoKu6fDxeJnvd1MP4Ho/MclHwZFj5TW3BUrhBfmQ
         1SmqmXVWfty49DriNJQ95H35dObsy498Oq0YoIpQ4xoJcFv0qQQM42YWPwm1cuVFhRqi
         gwGbaDmTBoJgvutLWDYXQjgZvPTMGnASlyiY45aU8e7IrERrhJzIdzIYilgXMBI45TcA
         NZbjj1XZ83DjOMTwSxD1+p5WgZhPEX+LU5siBJWHTgRilJ7uHCRgjmbbG/BeQwqY3M7I
         mr//gJt8IbDaSMZ6o1EXESADBXmSj+iZbjbNuFBCJVG+KsPbFb6nK5xrG1maymE9EjS2
         Jwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a0Zh5A5UVxi7kLLHGfwoywGVILuqTGw6v50Ysx9v2pg=;
        b=pGHYRc536rlxJE/iKM95Mdt4R5SfTKTdbTAlxyrGInQR5ZUhePuk64hbeOI5v5JNqF
         97Tw0Le4cayQl9KPhkm4cThp0yCLl4zAHL/z7QYcFoA3G6h2iGiBlIwR6WJSuK9Y93X7
         KfIlG4k7Gf+i77heywRTKC/SFHtCOXrt2CT7VLSaJIAULVrhMZSa314hryipfZbEeY58
         myvakjO/jhrq35evaE9joeEh6JTWSRaRu7MF2lgY20jHdtqoj5HnM1IGQlONdDbgfU5B
         aJxRbQpxFWUJiDZZYy8MAfu5yNo/QoXSzCMYZJKeLl8YE8vVneGGpaMsPZ9xpmyVuXRB
         2juQ==
X-Gm-Message-State: APjAAAXjjoNdB3JqYdXkTddQFdNVKT0cGSMvQ1k7JD2qB3ZN97IQFBYW
        jSDvm5Q8xbCmp0m35SqzXR0=
X-Google-Smtp-Source: APXvYqxDpSKKSu2un/TP0Ysy4WFWa6lTEAL6/sexOdBqb4s9dfVx7yM35vus7F6YnJ3GRb+1LFZYCA==
X-Received: by 2002:a81:9912:: with SMTP id q18mr7487623ywg.383.1580859319894;
        Tue, 04 Feb 2020 15:35:19 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id o69sm10579207ywd.38.2020.02.04.15.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Feb 2020 15:35:19 -0800 (PST)
Subject: Re: [PATCH v2 0/7] kunit: create a centralized executor to dispatch
 all KUnit tests
To:     Brendan Higgins <brendanhiggins@google.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>, rppt@linux.ibm.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Knut Omang <knut.omang@oracle.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20200130230812.142642-1-brendanhiggins@google.com>
 <20200204071915.AF32B21582@mail.kernel.org>
 <CAFd5g44ZG+E==gT24w49oKc6nHv4nBQFeipikKxXJH3oHdO99Q@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <4d0f42f7-8dbe-3d47-e0df-3e31cc8ebf52@gmail.com>
Date:   Tue, 4 Feb 2020 17:35:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g44ZG+E==gT24w49oKc6nHv4nBQFeipikKxXJH3oHdO99Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/4/20 1:35 PM, Brendan Higgins wrote:
> On Mon, Feb 3, 2020 at 11:19 PM Stephen Boyd <sboyd@kernel.org> wrote:
>>
>> Quoting Brendan Higgins (2020-01-30 15:08:05)
>>> ## TL;DR
>>>
>>> This patchset adds a centralized executor to dispatch tests rather than
>>> relying on late_initcall to schedule each test suite separately along
>>> with a couple of new features that depend on it.
>>
>> Is there any diff from v1 to v2? I don't know what changed, but I see
>> that my Reviewed-by tag has been put on everything, so I guess
>> everything I said was addressed or discussed in the previous round.
> 
> Oh yes, sorry about that. I have gotten a bit lazy in regard to
> changing logs. I noticed that a lot of people don't seem to care. I'll
> make a note that you do.

Please ignore those who don't care.  Just always include a change log.

You may encounter bike shedding about where the log belongs (in patch 0,
in the modified patches, in both locations).  The color of my bike shed
is simply that they exist somewhere, but my most favorite color is both
places.

> 
> Changes since last revision:
> - On patch 6/7, I flipped the include order and removed braces from the if
>   statements.
> - On patch 7/7, I removed the periods from the short descriptions.
> 

