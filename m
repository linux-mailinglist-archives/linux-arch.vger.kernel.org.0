Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E138338551
	for <lists+linux-arch@lfdr.de>; Fri, 12 Mar 2021 06:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhCLF2j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Mar 2021 00:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhCLF2P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Mar 2021 00:28:15 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD40C061574;
        Thu, 11 Mar 2021 21:28:15 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id g8so3731554qvx.1;
        Thu, 11 Mar 2021 21:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oaarikhpXaaQj6GcaKajb/NyREh5GUqd73uWAOucvZw=;
        b=HhkX9bKlm2Mbi362XTsvxmYPx+H11+/L5AUazrGh4nfrfUFLAKSL1dUs6V+m8hYD1e
         iu03Ni4GIXyuzidQERjESzBYO6S2CdXo2tB3dk5XAMAxz2yPq0XtQS7Vsoda5nNuyGqJ
         9Ky2QvuZADUZluwH9E3LKrfnLqCDoQ7kj1LJxse4e188ZLpa24KkskDZhBCTBiRveOpe
         FcD9SQim7/0+wJce4Boa1VUY+PjA7lwQuQi3YKcCAwahM6mpD4eRtSdUbclGERH+JUGS
         erGKCmFku3+Z4YYg0nudJG3K1x4XvpWsLmSumcHf9JggFab3FCtwh0NCnOZrhv1H4wdM
         xHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oaarikhpXaaQj6GcaKajb/NyREh5GUqd73uWAOucvZw=;
        b=glaOwC6aNw9phJZ5wpkAI5UOTlmmeuVox1A0/hr4edY1tHlJwa3aNWo/fl/uQTzoSa
         uugqDlUiBq4qykm9O+Vdyc5j+K0E9v2xHvaE3MRYgiFDXpTSh/2m3MrCGiRhYu87oGaL
         FwNmMDYOZRHdEQJm/vCMqhgiNOz+o9rf6L8eB7V6wvKR+BM3/6hOCiHPUA4hPyUyEvOU
         jtkUDTaWJQRRfHJ55/up4lOVp+sTfrIePeTDOed4egUtrNWzp2/rYuHuZyZfiBb5GISV
         k56fP9JLkja1U9XT8ygh3mjPpN4eODmdDkbhSxY+RjyypiXMLFSKgB24SLG9ks5cx4yW
         LRnQ==
X-Gm-Message-State: AOAM533IMs8wfdtjqGPcUqBsx1nF3fzZDfDLvy15c0lyQv+glelMARV4
        6WUyWXsuc08FUkWO32MaCB4=
X-Google-Smtp-Source: ABdhPJzwFyPrMa5sASEXwN8SICEZ43Y7GzTMKybpYyydce66kWjt34n7EzmnZMjy1JbEW28RNyFkNA==
X-Received: by 2002:a0c:b218:: with SMTP id x24mr11049374qvd.55.1615526894069;
        Thu, 11 Mar 2021 21:28:14 -0800 (PST)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id q125sm3711558qkf.68.2021.03.11.21.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 21:28:13 -0800 (PST)
Date:   Thu, 11 Mar 2021 21:28:12 -0800
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
Message-ID: <20210312052812.GB137474@yury-ThinkPad>
References: <20210218040512.709186-1-yury.norov@gmail.com>
 <20210218040512.709186-7-yury.norov@gmail.com>
 <55f1e25a-3211-8247-9dd3-3777e29287db@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55f1e25a-3211-8247-9dd3-3777e29287db@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 19, 2021 at 12:07:27AM +0100, Rasmus Villemoes wrote:
> On 18/02/2021 05.05, Yury Norov wrote:
> > Many algorithms become simpler if they are passed with relatively small
> > input values. One example is bitmap operations when the whole bitmap fits
> > into one word. To implement such simplifications, linux/bitmap.h declares
> > small_const_nbits() macro.
> > 
> > Other subsystems may also benefit from optimizations of this sort, like
> > find_bit API in the following patches. So it looks helpful to generalize
> > the macro and extend it's visibility.
> 
> Perhaps, but SMALL_CONST is too generic a name, it needs to keep "bits"
> somewhere in there. So why not just keep it at small_const_nbits?
> 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  include/asm-generic/bitsperlong.h |  2 ++
> >  include/linux/bitmap.h            | 33 ++++++++++++++-----------------
> >  2 files changed, 17 insertions(+), 18 deletions(-)
> > 
> > diff --git a/include/asm-generic/bitsperlong.h b/include/asm-generic/bitsperlong.h
> > index 3905c1c93dc2..0eeb77544f1d 100644
> > --- a/include/asm-generic/bitsperlong.h
> > +++ b/include/asm-generic/bitsperlong.h
> > @@ -23,4 +23,6 @@
> >  #define BITS_PER_LONG_LONG 64
> >  #endif
> >  
> > +#define SMALL_CONST(n) (__builtin_constant_p(n) && (unsigned long)(n) < BITS_PER_LONG)
> > +
> >  #endif /* __ASM_GENERIC_BITS_PER_LONG */
> > diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> > index adf7bd9f0467..e89f1dace846 100644
> > --- a/include/linux/bitmap.h
> > +++ b/include/linux/bitmap.h
> > @@ -224,9 +224,6 @@ extern int bitmap_print_to_pagebuf(bool list, char *buf,
> >   * so make such users (should any ever turn up) call the out-of-line
> >   * versions.
> >   */
> > -#define small_const_nbits(nbits) \
> > -	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG && (nbits) > 0)
> > -
> >  static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
> >  {
> >  	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
> > @@ -278,7 +275,7 @@ extern void bitmap_to_arr32(u32 *buf, const unsigned long *bitmap,
> >  static inline int bitmap_and(unsigned long *dst, const unsigned long *src1,
> >  			const unsigned long *src2, unsigned int nbits)
> >  {
> > -	if (small_const_nbits(nbits))
> > +	if (SMALL_CONST(nbits - 1))
> 
> Please don't force most users to be changed to something less readable.
> What's wrong with just keeping small_const_nbits() the way it is,
> avoiding all this churn and keeping the readability?

The wrong thing is that it's defined in include/linux/bitmap.h, and I
cannot use it in include/asm-generic/bitops/find.h, so I have to either
move it to a separate header, or generalize and share with find.h and
other users this way. I prefer the latter option, thougt it's more
verbose.
 
> At a quick reading, one of the very few places where you end up not
> passing nbits-1 but just nbits is this
> 
>  unsigned long find_next_zero_bit_le(const void *addr, unsigned
>  		long size, unsigned long offset)
>  {
> +	if (SMALL_CONST(size)) {
> +		unsigned long val = *(const unsigned long *)addr;
> +
> +		if (unlikely(offset >= size))
> +			return size;
> 
> which is a regression, for much the same reason the nbits==0 case was
> excluded from small_const_nbits in the first place. If size is 0, we
> used to just return 0 early in _find_next_bit. But you've introduced a
> dereference of addr before that check is now done, which is
> theoretically an oops.
> 
> If find_next_zero_bit_le cannot handle nbits==BITS_PER_LONG efficiently
> but requires one off-limits bit position, fine, so be it, add an extra
> "small_const_nbits() && nbits < BITS_PER_LONG" (and a comment).

Sure, it's my bad. I need to fix it.

What would you prefer, moving the small_const_nbits() to a separate
header, or introduce something like
        #define small_const_size(n) SMALL_CONST((n) - 1)

to avoid mistakes like this? I think small_const_size() is better
because it might be potentially useful for someone else, but I can
go either way.
