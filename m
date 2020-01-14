Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1D913B435
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2020 22:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgANVW2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jan 2020 16:22:28 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36278 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbgANVW2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jan 2020 16:22:28 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so16067786ljg.3
        for <linux-arch@vger.kernel.org>; Tue, 14 Jan 2020 13:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sA09QfXfHalAafAysRZFEbl/WyLTN07MU6TFhyXENpY=;
        b=ZuB9kWPAPxoZGiuuomw2iudECT1rt4Q/HncS4ElvHzHC6yUT2oQ0HUnEnUGkTmGfs5
         jSF+DX0BEvuJ4HATwr4M5/u+JM7dyP0AtYM8/eZRZWfxVC069BAzSr0Gdwlw9jjgh6al
         CCB0j1K9REL8bGh8CtUBoa4q17ax6w7GJvMoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sA09QfXfHalAafAysRZFEbl/WyLTN07MU6TFhyXENpY=;
        b=mYigVqgUFrVdRKAyrQm4K5Ptq1r0Cm0lBGfVKxMx6HFUd2C7tlgj/VLvlMskhgiDPc
         aL7csPrUHtgRTWNH1sprJym5jSh2gFx+KeviBHvqgkWlxhk+D1VUqPzzWXpD2FeQHA/0
         LtqWkp3Q22HQ4ToibDjueps66yWaHkkFrBHx+aHjEwYvA9COKkRzArV3CWEpML1tguw/
         7Qef1jOd5HJTwdvymuvkGgN2UFoRU9FgEsvenv1n16JYLYegAwSixmGwu1qTvyvhOToO
         eiZK3OEpuk4goUJMBq3ClxoE4FH5wSt3y/teQ4cZVg/WWNO1TYPHFuoMPJiLyrwCPDWA
         xzRw==
X-Gm-Message-State: APjAAAV75SwgaMyTZy4D4/eSDuGoiNypS5t+jZNXbCkbU35kx45jMwqK
        OrBw8moFhUU3rpS4VIXlmzjwGMo+RhM=
X-Google-Smtp-Source: APXvYqzWKPZFm/d5TARL3zvUW0pa+yBm8AiL7YKDUvS036VJVKupqXCLKyEct6fJ0GOAjJpAI/JvmA==
X-Received: by 2002:a2e:96c6:: with SMTP id d6mr15621507ljj.4.1579036944876;
        Tue, 14 Jan 2020 13:22:24 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id p12sm7732427lfc.43.2020.01.14.13.22.24
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 13:22:24 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id r19so16067727ljg.3
        for <linux-arch@vger.kernel.org>; Tue, 14 Jan 2020 13:22:24 -0800 (PST)
X-Received: by 2002:a2e:800b:: with SMTP id j11mr15632652ljg.126.1579036943823;
 Tue, 14 Jan 2020 13:22:23 -0800 (PST)
MIME-Version: 1.0
References: <20200114200846.29434-1-vgupta@synopsys.com> <20200114200846.29434-3-vgupta@synopsys.com>
In-Reply-To: <20200114200846.29434-3-vgupta@synopsys.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jan 2020 13:22:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgoc5DaF6=WxsAcft_Lp4XUYTiRhhCJGcmM5PwEDXY6Gw@mail.gmail.com>
Message-ID: <CAHk-=wgoc5DaF6=WxsAcft_Lp4XUYTiRhhCJGcmM5PwEDXY6Gw@mail.gmail.com>
Subject: Re: [RFC 2/4] lib/strncpy_from_user: Remove redundant user space
 pointer range check
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-snps-arc@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 14, 2020 at 12:09 PM Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
>
> This came up when switching ARC to word-at-a-time interface and using
> generic/optimized strncpy_from_user
>
> It seems the existing code checks for user buffer/string range multiple
> times and one of tem cn be avoided.

NO!

DO NOT DO THIS.

This is seriously buggy.

>  long strncpy_from_user(char *dst, const char __user *src, long count)
>  {
> -       unsigned long max_addr, src_addr;
> -
>         if (unlikely(count <= 0))
>                 return 0;
>
> -       max_addr = user_addr_max();
> -       src_addr = (unsigned long)untagged_addr(src);
> -       if (likely(src_addr < max_addr)) {
> -               unsigned long max = max_addr - src_addr;
> +       kasan_check_write(dst, count);
> +       check_object_size(dst, count, false);
> +       if (user_access_begin(src, count)) {

You can't do that "user_access_begin(src, count)", because "count" is
the maximum _possible_ length, but it is *NOT* necessarily the actual
length of the string we really get from user space!

Think of this situation:

 - user has a 5-byte string at the end of the address space

 - kernel does a

     n = strncpy_from_user(uaddr, page, PAGE_SIZE)

now your "user_access_begin(src, count)" will _fail_, because "uaddr"
is close to the end of the user address space, and there's not room
for PAGE_SIZE bytes any more.

But "count" isn't actually how many bytes we will access from user
space, it's only the maximum limit on the *target*. IOW, it's about a
kernel buffer size, not about the user access size.

Because we'll only access that 5-byte string, which fits just fine in
the user space, and doing that "user_access_begin(src, count)" gives
the wrong answer.

The fact is, copying a string from user space is *very* different from
copying a fixed number of bytes, and that whole dance with

        max_addr = user_addr_max();

is absolutely required and necessary.

You completely broke string copying.

It is very possible that string copying was horribly broken on ARC
before too - almost nobody ever gets this right, but the generic
routine does.

So the generic routine is not only faster, it is *correct*, and your
change broke it.

Don't touch generic code. If you want to use the generic code, please
do so. But DO NOT TOUCH IT. It is correct, your patch is wrong.

The exact same issue is true in strnlen_user(). Don't break it.

              Linus
