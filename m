Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EE32D0203
	for <lists+linux-arch@lfdr.de>; Sun,  6 Dec 2020 09:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgLFIqQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Dec 2020 03:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgLFIqP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Dec 2020 03:46:15 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD10C0613D0;
        Sun,  6 Dec 2020 00:45:29 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id e7so9579759wrv.6;
        Sun, 06 Dec 2020 00:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VFydP16aQgSOYZnYU7/OlYLKjUicVKh61lfiFMpnZts=;
        b=jqNgAhpbTyB50/v0hzFe7KzXFtpZOthuqD3u07KgsEbduNLeqWxJBHKIfEB0G8R0JS
         FMy7Xlz2zszv2GmDBDwbUbpP0zWQrI32hIUoRagrWLl2/pBgX95gMpmfHC+m/PdUJsZZ
         fA9OWn2ZSkED5NFpNgu8EP5uqbxnOgRvqT98mccNmpMhgJFvOjf6+Y9BML134UiIcQty
         PHmv5+rQb8uydoE0cGIvrW58v6YQWwhyOwiezAq1zBodNo9Bk0qK6LQm+GVVXomTfUJ6
         hEWtDePoZNMV79aGUIO0cUv1nTKkNmKtfbQRw7lfN/yz6j1fmh9lOjWXHU5BbXVr1URU
         6Zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VFydP16aQgSOYZnYU7/OlYLKjUicVKh61lfiFMpnZts=;
        b=Lii+dSaSC7uwxSYOcaV3RFEkx73tlj7fu5a7Ku4RdXtPV1rVkVTDF6y64BxrCI9Ftf
         EV8o5p9rJqRXOKueZGgqmHBK6GEsaivst9P90hRdQUpSOO/jlaRy8pmY9JF38pZaa6yZ
         wGeNRy/7Ea6Ff7iYY+KAuHzmHWisfpi03BEAx14daFOIXC6sgWTnumQurhTxA3maJnSs
         A1Py4dSNRL+L52v2YRJeg+5cycD28MCAcaRRRjf+rWExwAYqUBJHHeb+Xt5MYnZScZUJ
         uO3sPvI+P0grUleG7dip2uZGzqy16wdxByz3niegTjgsKtnYjY3/32ml0r+TLCTciIDX
         1I0w==
X-Gm-Message-State: AOAM533OXaZNEYsKbOeaAIqDmuFAVrZcmnoBy+L2bk5ZMQN5K2qDJGqY
        hW7rYEv6YEt6HKK63E/OpISTPFNxWgMKoGR9oUg=
X-Google-Smtp-Source: ABdhPJyx/rqejwi9S49Zw3m5y1kznKAsmMF4SEWOKLs4TkvxGb/+CuRHTVP9NVskbOod8rOFO+vN+pumquIRqEEhsgA=
X-Received: by 2002:adf:bd84:: with SMTP id l4mr14090824wrh.41.1607244327663;
 Sun, 06 Dec 2020 00:45:27 -0800 (PST)
MIME-Version: 1.0
References: <20201206064624.GA5871@ubuntu> <X8yWxe/9gzosFOam@kroah.com>
In-Reply-To: <X8yWxe/9gzosFOam@kroah.com>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Sun, 6 Dec 2020 17:45:14 +0900
Message-ID: <CAM7-yPSpqCUEJqJW+hzz9ccJbU5OnOZj1Vpyi8d5LG5=QbCTjA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] lib/find_bit.c: Add find_last_zero_bit
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        richard.weiyang@linux.alibaba.com, christian.brauner@ubuntu.com,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, rdunlap@infradead.org,
        masahiroy@kernel.org, peterz@infradead.org,
        peter.enderborg@sony.com, krzk@kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Kees Cook <keescook@chromium.org>, broonie@kernel.org,
        matti.vaittinen@fi.rohmeurope.com, mhiramat@kernel.org,
        jpa@git.mail.kapsi.fi, nivedita@alum.mit.edu,
        Alexander Potapenko <glider@google.com>, orson.zhai@unisoc.com,
        Takahiro Akashi <takahiro.akashi@linaro.org>, clm@fb.com,
        Josef Bacik <josef@toxicpanda.com>, dsterba@suse.com,
        dushistov@mail.ru,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sorry, in 7'th patch (not 8th).


Thanks
Levi.

On Sun, Dec 6, 2020 at 5:31 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Dec 06, 2020 at 03:46:24PM +0900, Levi Yun wrote:
> > Inspired find_next_*_bit and find_last_bit, add find_last_zero_bit
> > And add le support about find_last_bit and find_last_zero_bit.
> >
> > Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> > ---
> >  lib/find_bit.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 62 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/find_bit.c b/lib/find_bit.c
> > index 4a8751010d59..f9dda2bf7fa9 100644
> > --- a/lib/find_bit.c
> > +++ b/lib/find_bit.c
> > @@ -90,7 +90,7 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
> >  EXPORT_SYMBOL(find_next_zero_bit);
> >  #endif
> >
> > -#if !defined(find_next_and_bit)
> > +#ifndef find_next_and_bit
> >  unsigned long find_next_and_bit(const unsigned long *addr1,
> >               const unsigned long *addr2, unsigned long size,
> >               unsigned long offset)
> > @@ -141,7 +141,7 @@ unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
> >  {
> >       if (size) {
> >               unsigned long val = BITMAP_LAST_WORD_MASK(size);
> > -             unsigned long idx = (size-1) / BITS_PER_LONG;
> > +             unsigned long idx = (size - 1) / BITS_PER_LONG;
> >
> >               do {
> >                       val &= addr[idx];
>
> This, and the change above this, are not related to this patch so you
> might not want to include them.
>
> Also, why is this patch series even needed?  I don't see a justification
> for it anywhere, only "what" this patch is, not "why".
>
> thanks
>
> greg k-h
