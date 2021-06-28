Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DC83B6B83
	for <lists+linux-arch@lfdr.de>; Tue, 29 Jun 2021 01:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbhF1XpC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 19:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbhF1Xov (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jun 2021 19:44:51 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BA5C061760;
        Mon, 28 Jun 2021 16:42:24 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h4so16865748pgp.5;
        Mon, 28 Jun 2021 16:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MnOd9iaFXNVD5FJdstRfyB3AFTdce3B7edCsrT/B65c=;
        b=pqa8SXQ/hrN3EE8tWnQaXTgQQ3IZBW/4UPp07rsEpJERt1vDmlBqwfOVQJuTRyq0Am
         H/71eemQRinvfC1+TvsMm3hta9jb1/e0qATCWojjxQKaLzr4Oml0uSu5Xq0jVZVXJqER
         MDi/VtgB+XdWcx9atuL8LQkkSpJ0xM/te+EfGO7nhhSi9Mhs8zUsnBMZEpBTkGIA4Fpk
         3pUjAvMP3WS/7h60szKRz131Yf2UsqM8p6CgL0/4ZV5qJrWEmM56TyOTQZFHm/pbrDd7
         L/MwUK09uULPkJsmlecXAHPFUVAJaGDsqbKUmRTCqPFtorFVPxlMJpH98IJ4wEi9vvlQ
         LPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MnOd9iaFXNVD5FJdstRfyB3AFTdce3B7edCsrT/B65c=;
        b=TNez5IS3LfJtyEnxoDKGADLQ8Q8dnbpj3OnyWSiq0qUn/01e9vw0xlKWoD9VGrsKlp
         o26i3qsumxN4kOjYHMaPqqzFt68h9M5/EUe6ZWc9oU0aDR7u6KEUY8COUSfijQ9LBP0/
         s1VpnriQiVVRS1AHuEB4VEhplEA+9wbVENZVrwnJPaxmcab0+fGjw0i7xAlXkFIgJMdM
         81Qk7GOWcTX7M9wRSphZpc1wvZqLUYvATo4RjVdU8flCkRBY4eYU8xeZ2meTagEMAKPX
         sbL9qQKOwBcZchO53lTJT/4xs4EiFPYcLEwXn1rbhsnrpjLIWQSqptc5xWC5fq3tYNZ2
         U3FQ==
X-Gm-Message-State: AOAM531fJ8lMeXKelxFTjUSAG1DkuxsLvK0sx99hSfYuw+4ECugoVXCT
        B08hKFtj2qzUzq0GTyd7U1I=
X-Google-Smtp-Source: ABdhPJz/f2/QHZHxYzQmy+94Nkod9KHgsQwGFSUCdzNUYFhI6D1IVCfUxlSeGgG7NhfUSC7zGxB1OQ==
X-Received: by 2002:a05:6a00:23d0:b029:2de:c1a2:f1e with SMTP id g16-20020a056a0023d0b02902dec1a20f1emr27465201pfc.60.1624923744460;
        Mon, 28 Jun 2021 16:42:24 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:1c9b:7d7f:b312:1fae? ([2001:df0:0:200c:1c9b:7d7f:b312:1fae])
        by smtp.gmail.com with ESMTPSA id m21sm15768932pfa.99.2021.06.28.16.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 16:42:24 -0700 (PDT)
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
 <dbb4ca2d-a857-84f0-f167-5ad4e06aa52b@gmail.com>
 <CAMuHMdVKdZNBU-cTUY0zotA5DmtQ=dxH+iFY0_GX=4DzqpycZQ@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <36123b5d-daa0-6c2b-f2d4-a942f069fd54@gmail.com>
Date:   Tue, 29 Jun 2021 11:42:16 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVKdZNBU-cTUY0zotA5DmtQ=dxH+iFY0_GX=4DzqpycZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Geert,

On 29/06/21 9:18 am, Geert Uytterhoeven wrote:
>
>>>> The question then is - will bdflush fail gracefully, or spin retrying
>>>> the syscall?
>>> Will add to my todo list...
>>> BTW, you can boot this ramdisk on ARAnyM, too.
>> True. I can't find that ramdisk image anywhere - if you can point me to
>> some archive, I'll give that a try.
> http://ftp.mac.linux-m68k.org/pub/linux-mac68k/initrd/

Thanks - removing the if (func==1) do_exit(0); part does give similar 
behaviour as before - kernel warns five times, then shuts up (without 
change, warns twice only, and /sbin/update no longer runs).

Removing the syscall from the m68k syscall table altogether still gives 
a working ramdisk. /sbin/update is still running, so evidently doesn't 
care about the invalid syscall result ...

Cheers,

     Michael


>
> Gr{oetje,eeting}s,
>
>                          Geert
>
