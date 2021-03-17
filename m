Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27D933E896
	for <lists+linux-arch@lfdr.de>; Wed, 17 Mar 2021 05:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhCQExz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 00:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCQExb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Mar 2021 00:53:31 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E98FC06175F;
        Tue, 16 Mar 2021 21:53:20 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id r14so546707qtt.7;
        Tue, 16 Mar 2021 21:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8uPciXrxKYp/GK5rUz7+ZeunCu/N9gdPWdYS1DNkkl8=;
        b=i0ulZGykEfEvFpAjVk/Bm5gF9ypuFa3LFbIOw16pnebTgMxEwqJZ+11U6AQ4f+vVQ+
         qJEp3bYDgZlFg0HUB+us4m1xwBpLpYeqcLqP0T33pUS6D2qvHqQQQrFBbTf2t8/m6nFN
         /+6UGsqBqgZD3dhkiWUP/iLRbFJB7zFqiOANjoXqDqrz5NzuHGRfujyFL731+OUjjCFc
         p4YcWpqE+Nj/ZeyZiSkEYa0KyXOkCT68VMcbhV/RjOLfnLyVua34xLdAGUXgzIyEGGCC
         gql7S2iYJauQkPRN6OT1HjjOJUhnda3ZAz5vE1Bwt3IRucRN90TXBybo6crj86zDcp+n
         Y9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8uPciXrxKYp/GK5rUz7+ZeunCu/N9gdPWdYS1DNkkl8=;
        b=L19ndGzZg3YEWhcC3NG4aCJVMOjg8F+TLnYWoTJvYEArtZSrHCFkUT5Vm5iUUhmMqg
         +V+VfHiZM3ifIH3MOw3lGLt7aadTHUEWyIISr80BM2LbbB6sFv3YrDogf881GxJeSbG3
         mJ9+g/G8D8Ja/Pq6YEyhA+FaL4YfPftSv/ES441USh3yBZK6YeFqBdA8X4oed1dGG1Ya
         TlweFdK+IMopIqoRUGT5BMyQc/qOoToaJJf2fu0x8nDUIsoCNmtJy4GAftiof37hzZFc
         G23HihBXSN0nMuqmbtR9xG6KTr6BoN9osu7Tb7Zt0kmfCwvpwKrBTczdkkKp1LiPF8DQ
         W5gw==
X-Gm-Message-State: AOAM530iez6ife9k3e2X+zfX28BHZz70k8hczTnG/YhlDp+vRwlClNCk
        BpoYKdtyyvoHwn2+PBsz6MI5L6jLwWtw4w==
X-Google-Smtp-Source: ABdhPJyGbcIW9+KXy5fCL3XEgc7BPX2VUFzLWG98e4l58+squ7rlmLLF8Rd8dbeFfoRu4xfMn/l+Kg==
X-Received: by 2002:ac8:53c2:: with SMTP id c2mr2138933qtq.166.1615956799404;
        Tue, 16 Mar 2021 21:53:19 -0700 (PDT)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id k7sm14200771qtm.10.2021.03.16.21.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 21:53:19 -0700 (PDT)
Date:   Tue, 16 Mar 2021 21:53:18 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH 06/13] lib: extend the scope of small_const_nbits() macro
Message-ID: <20210317045318.GB2114775@yury-ThinkPad>
References: <20210316015424.1999082-1-yury.norov@gmail.com>
 <20210316015424.1999082-7-yury.norov@gmail.com>
 <e89b04d4-c2d5-1999-ed72-45bdc03a7bab@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e89b04d4-c2d5-1999-ed72-45bdc03a7bab@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 09:56:49AM +0100, Rasmus Villemoes wrote:
> On 16/03/2021 02.54, Yury Norov wrote:
> > find_bit would also benefit from small_const_nbits() optimizations.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  include/asm-generic/bitsperlong.h | 9 +++++++++
> >  include/linux/bitmap.h            | 3 ---
> >  2 files changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/asm-generic/bitsperlong.h b/include/asm-generic/bitsperlong.h
> > index 3905c1c93dc2..96032f4f908f 100644
> > --- a/include/asm-generic/bitsperlong.h
> > +++ b/include/asm-generic/bitsperlong.h
> > @@ -23,4 +23,13 @@
> >  #define BITS_PER_LONG_LONG 64
> >  #endif
> >  
> > +#define SMALL_CONST(n) (__builtin_constant_p(n) && (unsigned long)(n) < BITS_PER_LONG)
> > +
> > +/*
> > + * The valid number of bits for a bitmap to be small enough, or in other words,
> > + * fit into a single machine word is 1 to BITS_PER_LONG inclusively. 0 is not a
> > + * valid number for size, and most probably a sing of error.
> > + */
> > +#define small_const_nbits(n) SMALL_CONST((n) - 1)
> > +
> 
> I still don't see the point of introducing SMALL_CONST and still don't
> like the much-too-generic-name - especially since AFAICT you don't
> actually use it anywhere outside the definition of small_const_nbits()?
> 
> >  #endif /* __ASM_GENERIC_BITS_PER_LONG */
> > diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> > index adf7bd9f0467..bc13a890ecc1 100644
> > --- a/include/linux/bitmap.h
> > +++ b/include/linux/bitmap.h
> > @@ -224,9 +224,6 @@ extern int bitmap_print_to_pagebuf(bool list, char *buf,
> >   * so make such users (should any ever turn up) call the out-of-line
> >   * versions.
> >   */
> 
> You added another comment near its new definition, but the left-behind
> comment in bitmap.h is now somewhat confusing, no? I suggest expanding
> your new comment a bit so it's clear why we're interested in whether a
> bitmap is known at compile-time to consist of exactly one word:
> 
> /*
> small_const_nbits(n) is true precisely when it is known at compile-time
> that BITMAP_SIZE(n) is 1, i.e. 1 <= n <= BITS_PER_LONG. This allows
> various bit/bitmap APIs to provide a fast inline implementation. Bitmaps
> of size 0 are very rare, and a compile-time-known-size 0 is most likely
> a sign of error. They will be handled correctly by the bit/bitmap APIs,
> but using the out-of-line functions, so that the inline implementations
> can unconditionally dereference the pointer(s).
> */

Ok, make sense

> > -#define small_const_nbits(nbits) \
> > -	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG && (nbits) > 0)
> > -
> >  static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
> >  {
> >  	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
> > 
> 
> Rasmus
