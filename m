Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3566D30B870
	for <lists+linux-arch@lfdr.de>; Tue,  2 Feb 2021 08:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhBBHLD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Feb 2021 02:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhBBHKy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2021 02:10:54 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B30C06174A;
        Mon,  1 Feb 2021 23:10:14 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id q5so18117980ilc.10;
        Mon, 01 Feb 2021 23:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zmSuw7wDu6a3wNmrLo/hehSg5Yx/sWDPdhwepqYWewQ=;
        b=jmGBdch1E0RYAJSsIuQKYd/7GqQSCYar8lmsR3O4nlZjMjz/mS+iLV8WB3TN+m+4//
         E/QWSg2+PpaAjC7/92+P85CLbqpTmNWw7vcoGWP70xKSCL4R8UzbL/2lNs826ubbqhd3
         zdSP2Omj+LHhgyGSRJvuynEKJojEKr30uKIk0zMLIyhEhRgCeEn7Yjs6Rx4l1ym0J8Vs
         Cg/JrdNsSE2xqxodw4sverEW1vhLEcirvkwiMGhA8f9IjOXmA0vy3/+ZC2V6R61NNszf
         +zFE/NC7/bjaBxYYdneLUDjzPIcrKjBXXwDNA8t3hGFIosjTh+M92UxiXnf92b/kej8L
         B3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zmSuw7wDu6a3wNmrLo/hehSg5Yx/sWDPdhwepqYWewQ=;
        b=g8u1LeUsiuOLHLCIXc/BlXmkFLyNLLhsNFciRzWtHQFFxCTuKSt2xZkKRqlnQVkxdL
         TidIPU0XhL9hjWpoiw9eQTMsKccVtU+WqguemGLPD0oLsiVkORh8Sd5OtztVKIkw4ngM
         cEGed8/Q+ywNR3Xoh8p3zUYAiitrKLijjw6i6BnlBXl8uOCR6/62eeaiL99RMNMuNbUu
         HPg+B0vY/5VwdlHn7pp9Oxx3EXaNpQ4ixjwkNYndbxtc5sN5wIBYQ7V1QxziRRBrY79i
         Ks9L61UzVDrs4V7gn/XGCC9hqXhTwCUXBxxngZcI8Nf+HMKcuwKMccJgj5J1zczv7VHx
         Un2g==
X-Gm-Message-State: AOAM533cepLw0kKpmpzzBeRmI92gpVBd9KgKxJtoClo4X3kSfSYYTybP
        3o8rhrJ2nf6cO2EVdJiJl05CuUxX89ens9hodZHNtpVI/ltFuQ==
X-Google-Smtp-Source: ABdhPJz2VpiyzoIfttXg9MvJMNS9zPgO0x9UhiGqOhJ/5rolRWPoNgq4omjMpEyBcebchyReWcuBEdIM+H1hVrBgozA=
X-Received: by 2002:a05:6e02:cb:: with SMTP id r11mr17996768ilq.116.1612249813762;
 Mon, 01 Feb 2021 23:10:13 -0800 (PST)
MIME-Version: 1.0
References: <20210130191719.7085-1-yury.norov@gmail.com> <20210130191719.7085-6-yury.norov@gmail.com>
 <YBgF3RYQ5F6xmpj8@smile.fi.intel.com>
In-Reply-To: <YBgF3RYQ5F6xmpj8@smile.fi.intel.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Mon, 1 Feb 2021 23:10:02 -0800
Message-ID: <CAAH8bW8VP+gjY7+nu6aAXOOTtZqrb1ForPJUBNMYW-_JFdX9-w@mail.gmail.com>
Subject: Re: [PATCH 5/8] bitsperlong.h: introduce SMALL_CONST() macro
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-SH <linux-sh@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Sterba <dsterba@suse.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 1, 2021 at 5:45 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sat, Jan 30, 2021 at 11:17:16AM -0800, Yury Norov wrote:
> > Many algorithms become simpler if they are passed with relatively small
> > input values. One example is bitmap operations when the whole bitmap fits
> > into one word. To implement such simplifications, linux/bitmap.h declares
> > small_const_nbits() macro.
> >
> > Other subsystems may also benefit from optimizations of this sort, like
> > find_bit API in the following patches. So it looks helpful to generalize
> > the macro and extend it's visibility.
>
> Hmm... Are we really good to allow 0 as a parameter to it? I remember we had
> a thread at some point where Rasmus explained why 0 is excluded.

Now we pass (nbits - 1) instead of nbits, which is ULONG_MAX in case
of nbits == 0

> > --- a/tools/include/asm-generic/bitsperlong.h
> > +++ b/tools/include/asm-generic/bitsperlong.h
>
> Tools part in a separate patch?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
