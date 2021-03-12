Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68514339955
	for <lists+linux-arch@lfdr.de>; Fri, 12 Mar 2021 22:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbhCLVxl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Mar 2021 16:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235488AbhCLVxi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Mar 2021 16:53:38 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5840AC061574;
        Fri, 12 Mar 2021 13:53:38 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id d20so25968370qkc.2;
        Fri, 12 Mar 2021 13:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9Ef5EY2WMrKCR6YQJjvJccCPLCTaOpepUxDNfS7WTGo=;
        b=tjjBW8j2bo/jen8nkSMnG+TdHfhLmzrUK7o1rk3vK96G0IpIxYfAwtS4Wtq1p3NUWg
         WbZy4AB7w0vnRvtXc5mbl+/aY9FUBRS94KHCWupN3J6saDc3KnMEvsKcJRPPdhFypfYj
         ZZHTLijqqGENsbuC356dpSkGNcySYXCcKLMyPqsNcTORKfpXvohtdsIT+UBXeA3JyGrD
         0KJ5xP4c2oPFv6rWr3osEdndh860EXuZ3FU/t/p+Hy+Cp2AkYNP2fFHKgkvCi1mHwhCd
         57LJ66TvNRjJuGyTrcZH1XKT/5piUQPPT+zCNujfJ2e9/SISYPTv9jt59NXJdejKi/oh
         jUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Ef5EY2WMrKCR6YQJjvJccCPLCTaOpepUxDNfS7WTGo=;
        b=ixMvB4XbjAoSOQWbCokZ8GtgM1eULI6A4sENMZVzmgmzVupfSUp4mQG479GzC3kyMH
         lT35vFh8nPf4RmaMigXvT0+wbD6cb0UsnjfpxFXtBsbqzvXKG3YRRCGjAhwvwyv5eCqk
         UOHsfqk3putof8fNQjJBpRW15ycbNlt09R2U6onhfH0bI72CbdOpD3ODLohEx+XYmxcE
         n7hGJwVXu99pUFuBr5urpetgOypmiDGlY8QXL1OoRfr6N00EVBt2fHf8LowlMBCDFg4v
         3JeOSCshfd07TWPhLxwHbqO4sFmRw9laQ3I/Eq34WyWgI4aDjbG7JTbOS+Z57twngwTx
         bdEQ==
X-Gm-Message-State: AOAM533p0RDGJlNZPl7rPdYrDOzteFFyUpjpX50qUL6Y5vmL6G5a/UDE
        HpwxcbdijbFzwmNEcc4c/MM=
X-Google-Smtp-Source: ABdhPJyB61QmOAM1xkM7zp9iyyydvZwe9L+k8hjEI9bjJ/F+iikmGnqQCe8EI+Cnk01d/LQ/tIOHfg==
X-Received: by 2002:a37:9b01:: with SMTP id d1mr12132300qke.337.1615586017485;
        Fri, 12 Mar 2021 13:53:37 -0800 (PST)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id 66sm5319791qkk.18.2021.03.12.13.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 13:53:37 -0800 (PST)
Date:   Fri, 12 Mar 2021 13:53:36 -0800
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
Subject: Re: [PATCH 06/14] bitsperlong.h: introduce SMALL_CONST() macro
Message-ID: <20210312215336.GA249694@yury-ThinkPad>
References: <20210218040512.709186-1-yury.norov@gmail.com>
 <20210218040512.709186-7-yury.norov@gmail.com>
 <55f1e25a-3211-8247-9dd3-3777e29287db@rasmusvillemoes.dk>
 <20210312052812.GB137474@yury-ThinkPad>
 <c672b661-1921-f61c-a118-d51c650e41f4@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c672b661-1921-f61c-a118-d51c650e41f4@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 12, 2021 at 10:12:22AM +0100, Rasmus Villemoes wrote:
> On 12/03/2021 06.28, Yury Norov wrote:
> > On Fri, Feb 19, 2021 at 12:07:27AM +0100, Rasmus Villemoes wrote:
> >> On 18/02/2021 05.05, Yury Norov wrote:
> >>> Many algorithms become simpler if they are passed with relatively small
> >>> input values. One example is bitmap operations when the whole bitmap fits
> >>> into one word. To implement such simplifications, linux/bitmap.h declares
> >>> small_const_nbits() macro.
> >>>
> >>> Other subsystems may also benefit from optimizations of this sort, like
> >>> find_bit API in the following patches. So it looks helpful to generalize
> >>> the macro and extend it's visibility.
> >>
> >> Perhaps, but SMALL_CONST is too generic a name, it needs to keep "bits"
> >> somewhere in there. So why not just keep it at small_const_nbits?
> >>
> >>> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> >>> ---
> >>>  include/asm-generic/bitsperlong.h |  2 ++
> >>>  include/linux/bitmap.h            | 33 ++++++++++++++-----------------
> >>>  2 files changed, 17 insertions(+), 18 deletions(-)
> >>>
> >>> diff --git a/include/asm-generic/bitsperlong.h b/include/asm-generic/bitsperlong.h
> >>> index 3905c1c93dc2..0eeb77544f1d 100644
> >>> --- a/include/asm-generic/bitsperlong.h
> >>> +++ b/include/asm-generic/bitsperlong.h
> >>> @@ -23,4 +23,6 @@
> >>>  #define BITS_PER_LONG_LONG 64
> >>>  #endif
> >>>  
> >>> +#define SMALL_CONST(n) (__builtin_constant_p(n) && (unsigned long)(n) < BITS_PER_LONG)
> >>> +
> >>>  #endif /* __ASM_GENERIC_BITS_PER_LONG */
> >>> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> >>> index adf7bd9f0467..e89f1dace846 100644
> >>> --- a/include/linux/bitmap.h
> >>> +++ b/include/linux/bitmap.h
> >>> @@ -224,9 +224,6 @@ extern int bitmap_print_to_pagebuf(bool list, char *buf,
> >>>   * so make such users (should any ever turn up) call the out-of-line
> >>>   * versions.
> >>>   */
> >>> -#define small_const_nbits(nbits) \
> >>> -	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG && (nbits) > 0)
> >>> -
> >>>  static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
> >>>  {
> >>>  	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
> >>> @@ -278,7 +275,7 @@ extern void bitmap_to_arr32(u32 *buf, const unsigned long *bitmap,
> >>>  static inline int bitmap_and(unsigned long *dst, const unsigned long *src1,
> >>>  			const unsigned long *src2, unsigned int nbits)
> >>>  {
> >>> -	if (small_const_nbits(nbits))
> >>> +	if (SMALL_CONST(nbits - 1))
> >>
> >> Please don't force most users to be changed to something less readable.
> >> What's wrong with just keeping small_const_nbits() the way it is,
> >> avoiding all this churn and keeping the readability?
> > 
> > The wrong thing is that it's defined in include/linux/bitmap.h, and I
> > cannot use it in include/asm-generic/bitops/find.h, so I have to either
> > move it to a separate header, or generalize and share with find.h and
> > other users this way. I prefer the latter option, thougt it's more
> > verbose.
> 
> The logical place would be the same place the BITS_PER_LONG macro is
> defined, no?

Yes. This where I placed SMALL_CONST() in current version.

> No need to introduce a new header for that, and all current
> users of small_const_nbits() must already (very possibly indirectly)
> include asm-generic/bitsperlong.h.
> 
> I do prefer to keep both the name small_const_nbits() and its current
> semantics, which, although not currently spelled out that way anywhere,
> is "is BITMAP_SIZE(nbits) known at compile time and equal to 1", which
> is precisely what allows the static inlines to unconditionally
> dereference the pointer (that's the "exclude the 0 case") and just deal
> with that one word.
> 
> I don't like either SMALL_CONST or small_const_size, because nothing in
> there says it has anything to do with bit ops. As I said, if you have
> some special place that for some reason cannot handle
> nbits==BITS_PER_LONG, then just add that as an additional constraint
> with a comment why.

OK, I'll move small_const_nbits() to the bitsperlong header and
resubmit shortly. My concern still is that nbits is too specific 
for bitsperlong.h, but if you're good with it, I'm OK as well.
