Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BEC3B698A
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 22:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbhF1UQJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 16:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236965AbhF1UQI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jun 2021 16:16:08 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9BCC061574;
        Mon, 28 Jun 2021 13:13:41 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id a7so5713566pga.1;
        Mon, 28 Jun 2021 13:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vaR0ZHeLh3Rgpq/oOLze5JOk9+DRbDxLmGgrRMNd4Ls=;
        b=JK/dcwlV5HtjZwqC4/JKo2T5Iu8KcG9Kcd0VQ5ut3njx9t8wLXG9YHp25nmsBb6aKA
         QFK96qg/LIuguGMS5VsnxqiR3trE5g/dNI1VqluPWV2qMtM1ykGmJeBeHCyrv+5mj+1r
         W6Vh6SPJHhb9MBqFzMFGTyck3DLP+ZSHxn91KB6neU6wzP39XgV1HpGfm/BiJ7JHBYI/
         ZNJ+wbclln4o63iRuhoRlW+yVD+wQDCajjefih3eqnQFROwySSE/gtCb7APBz1ul6PFJ
         XoEX1OWC2IVXgrl6NQXaTbivO5f+1TEv0Rq+1tu9bEk21eThKtcAOW8r2qMbgiDm+aYG
         TdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vaR0ZHeLh3Rgpq/oOLze5JOk9+DRbDxLmGgrRMNd4Ls=;
        b=uPykcR5n+xSHCwkR1CukKeJJdLxX+pmugPTrIh3QcoSggSHr7N0LUrAK4w1QU8CvJS
         Bf4Lo6QyfeF2Aa+ZIwZ+z1BnjZOlflkC4/ipiyqEQBcWSw9SgPmot+ac/WdbwXyvMWmH
         BenXdHgHoHFyaBZ9R5aRMedMMQPajD8CbPRjbWuJI7WyAOB6Rj8kzTjJdY6t0xC3Rk+R
         Qc0hw36XW/sD6TpTo0uoPU6Xye42kcyAwBxyxo77Llag6TdhLr+Lmwch6/hW2WCUs3hd
         l9dKit2czj9FL6yj4XwwvKDuwV5UAgnB+fwzHAoRtvQ0Z6OtJ+fhOezib4nD5BnAVhyc
         WUKQ==
X-Gm-Message-State: AOAM530+9pUkDa2/JYfrD4Fvyv9Xw7TK8jQilRFl/8MAchdJQGcBlrE3
        FE0cy6kEeghZyqX9Ujg3i6Q=
X-Google-Smtp-Source: ABdhPJxyQ/1DoRnjU5lf6igsVabo2ZeY13D7p5RiA9jKlGU/j2Sut1YGa+bd6AiG1JPX6EHy2PoRwg==
X-Received: by 2002:a62:7cc4:0:b029:302:f75a:69ab with SMTP id x187-20020a627cc40000b0290302f75a69abmr26829379pfc.74.1624911221022;
        Mon, 28 Jun 2021 13:13:41 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:1c9b:7d7f:b312:1fae? ([2001:df0:0:200c:1c9b:7d7f:b312:1fae])
        by smtp.gmail.com with ESMTPSA id ga1sm981249pjb.43.2021.06.28.13.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 13:13:40 -0700 (PDT)
Subject: Re: [PATCH 0/9] Refactoring exit
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>, Tejun Heo <tj@kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
 <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
 <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
 <87a6njf0ia.fsf@disp2133>
 <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
 <87tulpbp19.fsf@disp2133>
 <CAHk-=wi_kQAff1yx2ufGRo2zApkvqU8VGn7kgPT-Kv71FTs=AA@mail.gmail.com>
 <87zgvgabw1.fsf@disp2133> <875yy3850g.fsf_-_@disp2133>
 <YNULA+Ff+eB66bcP@zeniv-ca.linux.org.uk>
 <YNj4DItToR8FphxC@zeniv-ca.linux.org.uk>
 <6e283d24-7121-ae7c-d5ad-558f85858a09@gmail.com>
 <CAMuHMdXSU6_98NbC1UWTT_kmwxD=6Ha5LJxFAtbSuD=y78nASg@mail.gmail.com>
 <7ad6c3a9-b983-46a5-fc95-f961b636d3fe@gmail.com>
 <CAMuHMdUi5Ri=GmWzS8hb7dkfPyAE=HpQHg6OsKSLDse_364E=g@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <dbb4ca2d-a857-84f0-f167-5ad4e06aa52b@gmail.com>
Date:   Tue, 29 Jun 2021 08:13:32 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUi5Ri=GmWzS8hb7dkfPyAE=HpQHg6OsKSLDse_364E=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Geert,

On 29/06/21 7:17 am, Geert Uytterhoeven wrote:
>>> The warning is printed when using filesys-ELF-2.0.x-1400K-2.gz,
>>> which is a very old ramdisk from right after the m68k a.out to ELF
>>> transition:
>>>
>>>      warning: process `update' used the obsolete bdflush system call
>>>      Fix your initscripts?
>>>
>>> I still boot it, once in a while.
>> OK; you take the cake. That ramdisk came to mind when I thought about
>> where I'd last seen bdflush, but I've not used it in ages (not sure 14
>> MB are enough for that).
> Of course it will work on your 14 MiB machine!  It fits on a floppy, _after_
> decompression.  It was used by people to install Linux on the hard disks
> of their beefy m68k machines, after they had set up the family Christmas
> tree, in December 1996.
Been there, done that. Wrote the HOWTO for ext2 filesystem byte-swapping.
> I also have a slightly larger one, built from OpenWRT when I did my first
> experiments on that.  Unlike filesys-ELF-2.0.x-1400K-2.gz, it does open
> a shell on the serial console, so it is more useful to me.
>
>> The question then is - will bdflush fail gracefully, or spin retrying
>> the syscall?
> Will add to my todo list...
> BTW, you can boot this ramdisk on ARAnyM, too.

True. I can't find that ramdisk image anywhere - if you can point me to 
some archive, I'll give that a try.

Cheers,

     Michael


>
> Gr{oetje,eeting}s,
>
>                          Geert
>
