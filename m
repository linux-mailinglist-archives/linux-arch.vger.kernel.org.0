Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D060540389
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jun 2022 18:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344793AbiFGQQK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Jun 2022 12:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344795AbiFGQQI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jun 2022 12:16:08 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CD1101708
        for <linux-arch@vger.kernel.org>; Tue,  7 Jun 2022 09:16:04 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id v22so31973030ybd.5
        for <linux-arch@vger.kernel.org>; Tue, 07 Jun 2022 09:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KNz0hVj8TG6Qzpx0G5NqXTIz0xDB0KuRYCCZOpgg7qY=;
        b=a0XfGH8keS8BNyDEJAqFX9LsZ0KYzMl9tMyc2KvxF8rj4cWg0GMKO1iFWzd8v9SxGh
         qeIGa7tW6ioE5zIZGl5FYOjoz+A6163+aI5rfjTQtS9RxzeK+6WSGvKy5pAfcBuUr9MJ
         ec5u64qTYW2PApKtNVs5bfEdbrtZ0uyvJDmbDvgGnCoeD3qE5oZLj5NRvjZbEBJlshJ0
         ML9wJ2nRCTgilIbJEv6Hf/wiuwZTGMiZaMU1q2szNU6afrSmDAqT459SmwiFHetNHJFE
         daT7TEHdSe4s7CoKN8HEXNZR4uRd6mhonRnzMVLn2mpCFZvPe1SSt7D0eQpOqJdI60iN
         m+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KNz0hVj8TG6Qzpx0G5NqXTIz0xDB0KuRYCCZOpgg7qY=;
        b=WcEMO8oof5Tiq1CO61M1kjw1gQacjeDTJIf3OUfwRtAJl9ZIMvWF2rP4/9MSFQPcxm
         cKQq5MAREQaujAmkET3PuThvQvAAPc+GVxcA0Lm6KkpjI9YVkPDDfAgd+eF9vYCS64RX
         uUqfMUILwEDiKsAJdATqIcQbTGkx2yxM/xM9RUuvmElHdYlDCddemTXXYh4ILyIIDIYv
         BUKZnDjR98SuQ600tR/9rCp9+zSSm34UtDXCKTX7MSBsM6G1Ua9SNFHbiy1mleSpIH2I
         nWdQrEHv8OEiLpxGUp1jGD9z12NThYmomGReGw9wouAn4qCNYScO5C2tfMTvMlGiKyF8
         sukQ==
X-Gm-Message-State: AOAM531sD2P2yqGFT+4j+u1AzDkgA1ZVMFPHj1E8fynVfk/z5/Z4Ra9z
        aZdb/Te2rwiFgErlKcmRqd9LkPj+k6Dsxy1tBJ02/A==
X-Google-Smtp-Source: ABdhPJyTF15h5DVfmYl2uUZTtWHgfXtFmwbH8H44XY+k9hFqHuby4m37s7CBYMHQBZwu0pbvq5OJzmjb8kkAoLIbdWo=
X-Received: by 2002:a5b:49:0:b0:656:151d:a1e3 with SMTP id e9-20020a5b0049000000b00656151da1e3mr129130ybp.425.1654618563958;
 Tue, 07 Jun 2022 09:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220606114908.962562-1-alexandr.lobakin@intel.com>
 <20220606114908.962562-4-alexandr.lobakin@intel.com> <Yp9WFREfdfkho0hm@elver.google.com>
 <20220607155722.44040-1-alexandr.lobakin@intel.com>
In-Reply-To: <20220607155722.44040-1-alexandr.lobakin@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 7 Jun 2022 18:15:27 +0200
Message-ID: <CANpmjNOZRGW7CutQDAzWKKhYT4W_AotBFWpmgci8O4xMpDPrqw@mail.gmail.com>
Subject: Re: [PATCH 3/6] bitops: define gen_test_bit() the same way as the
 rest of functions
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 7 Jun 2022 at 18:05, Alexander Lobakin
<alexandr.lobakin@intel.com> wrote:
>
> From: Marco Elver <elver@google.com>
> Date: Tue, 7 Jun 2022 15:43:49 +0200
>
> > On Mon, Jun 06, 2022 at 01:49PM +0200, Alexander Lobakin wrote:
> > > Currently, the generic test_bit() function is defined as a one-liner
> > > and in case with constant bitmaps the compiler is unable to optimize
> > > it to a constant. At the same time, gen_test_and_*_bit() are being
> > > optimized pretty good.
> > > Define gen_test_bit() the same way as they are defined.
> > >
> > > Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> > > ---
> > >  include/asm-generic/bitops/generic-non-atomic.h | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/asm-generic/bitops/generic-non-atomic.h b/include/asm-generic/bitops/generic-non-atomic.h
> > > index 7a60adfa6e7d..202d8a3b40e1 100644
> > > --- a/include/asm-generic/bitops/generic-non-atomic.h
> > > +++ b/include/asm-generic/bitops/generic-non-atomic.h
> > > @@ -118,7 +118,11 @@ gen___test_and_change_bit(unsigned int nr, volatile unsigned long *addr)
> > >  static __always_inline int
> > >  gen_test_bit(unsigned int nr, const volatile unsigned long *addr)
> > >  {
> > > -   return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
> > > +   const unsigned long *p = (const unsigned long *)addr + BIT_WORD(nr);
> > > +   unsigned long mask = BIT_MASK(nr);
> > > +   unsigned long val = *p;
> > > +
> > > +   return !!(val & mask);
> >
> > Unfortunately this makes the dereference of 'addr' non-volatile, and
> > effectively weakens test_bit() to the point where I'd no longer consider
> > it atomic. Per atomic_bitops.txt, test_bit() is atomic.
> >
> > The generic version has been using a volatile access to make it atomic
> > (akin to generic READ_ONCE() casting to volatile). The volatile is also
> > the reason the compiler can't optimize much, because volatile forces a
> > real memory access.
>
> Ah-ha, I see now. Thanks for catching and explaining this!
>
> >
> > Yes, confusingly, test_bit() lives in non-atomic.h, and this had caused
> > confusion before, but the decision was made that moving it will cause
> > headaches for ppc so it was left alone:
> > https://lore.kernel.org/all/87a78xgu8o.fsf@dja-thinkpad.axtens.net/T/#u
> >
> > As for how to make test_bit() more compiler-optimization friendly, I'm
> > guessing that test_bit() needs some special casing where even the
> > generic arch_test_bit() is different from the gen_test_bit().
> > gen_test_bit() should probably assert that whatever it is called with
> > can actually be evaluated at compile-time so it is never accidentally
> > used otherwise.
>
> I like the idea! Will do in v2.
> I can move the generics and after, right below them, define
> 'const_*' helpers which will mostly redirect to 'generic_*', but
> for test_bit() it will be a separate function with no `volatile`
> and with an assertion that the input args are constants.

Be aware that there's already a "constant_test_bit()" in
arch/x86/include/asm/bitops.h, which uses 2 versions of test_bit() if
'nr' is constant or not. I guess you can steer clear of that if you
use "const_", but they do sound similar.

> >
> > I would also propose adding a comment close to the deref that test_bit()
> > is atomic and the deref needs to remain volatile, so future people will
> > not try to do the same optimization.
>
> I think that's also the reason why it's not underscored, right?

Yes, the naming convention is that double-underscored ones are
non-atomic so that's one clue indeed. Documentation/atomic_bitops.txt
another, and unlike the other non-atomic bitops, its kernel-doc
comment also does not mention "This operation is non-atomic...".
