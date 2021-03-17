Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBEB33FBD7
	for <lists+linux-arch@lfdr.de>; Thu, 18 Mar 2021 00:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhCQXdq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 19:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCQXdS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Mar 2021 19:33:18 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102BBC06174A;
        Wed, 17 Mar 2021 16:33:18 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 130so256398qkh.11;
        Wed, 17 Mar 2021 16:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CTJaMlQSiMda9wS6PbGSduWsk+5KDzusHCnU+3d0jm0=;
        b=djlmQ8pUhxNxAgRR98cEdxY23SwSEiJoZdvQQh1UUIPjpxD+Qp5zYc4TA2IIrImXzK
         A3g/o2Zw+D6fda/7wbgdyfUREJbZeyh7jny4MKH7UCiDZzgWhj0FLb/zFA5z1hduukJl
         TfZVU3nTiX8H/06vXh9A/ymnpqK1iCZW6sHeQDFDOk2x8uHMxJtSRo/7ZhL/9LVGs6xU
         dtIwugQKWt4mI6atvd1M9Vph6e7PdC1VlG9RSI70NUzVgnqaugAdsB1SWRS+lrUNhwMq
         R5qQHlEnY1tnpY/ynnjD0J83pjrLv7B1xjH039KkxVDdDZfCzvJ0PtiwyB9xvSAwlqN2
         jpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CTJaMlQSiMda9wS6PbGSduWsk+5KDzusHCnU+3d0jm0=;
        b=GUItIJZvR7AS/OnSrUUz3gYtt5e8SoDsMBz20bYfbZLvRmllXCwtb3oRyP31KuRdSh
         huEpCYHhioLXE6aPxhRNOsSBSLCjtnGkMRNxJ3M8Vr5U1+lbRXouVP1FsDLXjWPrDHJ5
         KyYBaK1cbbHIS5HEUsQ13hw9zE0Pj9kbnQoXiS2V9jU0wUejK7tkx3E+mqYyfqjzMuJt
         L4q3GSypWFS+6cnE9E1ZiGaOPNQ7eDcd5Rb6TsMRBZn3haJBiDxSvPkfrR8Kczw+P2rR
         pzHF/bKmjOPUUIAS1dNh75e4/jadcVFMa1kOi36UQJY5zwSI7VRdzDoro3vOerOnXegp
         fMkA==
X-Gm-Message-State: AOAM532XslUtzbTl08pIJj2AGrKFMuDu13xCJePzqpza7QPgGYorXhQf
        wUxllL6Yj+snOzgsZjFOoE+5orMcCME=
X-Google-Smtp-Source: ABdhPJwoRZLRSJVxCNeSHdaCTiiTWHJm1H362nK1rqbLXZlfe4JY2rNGLZX4d17lcesKowHV7JpGEw==
X-Received: by 2002:ae9:d60a:: with SMTP id r10mr1721376qkk.411.1616023997113;
        Wed, 17 Mar 2021 16:33:17 -0700 (PDT)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id l129sm457525qkd.76.2021.03.17.16.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 16:33:16 -0700 (PDT)
Date:   Wed, 17 Mar 2021 16:33:10 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 04/13] lib: introduce BITS_{FIRST,LAST} macro
Message-ID: <20210317233310.GA2186246@yury-ThinkPad>
References: <20210316015424.1999082-1-yury.norov@gmail.com>
 <20210316015424.1999082-5-yury.norov@gmail.com>
 <8021faab-e592-9587-329b-817ae007b89a@rasmusvillemoes.dk>
 <YFCZtUuMYVNeNlUO@smile.fi.intel.com>
 <20210317054057.GC2114775@yury-ThinkPad>
 <8bcffb72-f9cb-7ca0-950d-527dda6545ac@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bcffb72-f9cb-7ca0-950d-527dda6545ac@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 17, 2021 at 08:58:04PM +0100, Rasmus Villemoes wrote:
> On 17/03/2021 06.40, Yury Norov wrote:
> > On Tue, Mar 16, 2021 at 01:42:45PM +0200, Andy Shevchenko wrote:
> 
> >>> It would also be much easier to review if you just redefined the
> >>> BITMAP_LAST_WORD_MASK macros etc. in terms of these new things, so you
> >>> wouldn't have to do a lot of mechanical changes at the same time as
> >>> introducing the new ones - especially when those mechanical changes
> >>> involve adding a "minus 1" everywhere.
> >>
> >> I tend to agree with Rasmus here.
> > 
> > OK. All this plus terrible GENMASK(high, low) design, when high goes
> > first, makes me feel like we need to deprecate GENMASK and propose a
> > new interface.
> > 
> > What do you think about this:
> > BITS_FIRST(bitnum)      -> [0, bitnum)
> > BITS_LAST(bitnum)       -> [bitnum, BITS_PER_LONG)
> > BITS_RANGE(begin, end)  -> [begin, end)
> 
> Better, though I'm not too happy about BITS_LAST(n) not producing a word
> with the n highest bits set. I dunno, I don't have better names.
> BITS_FROM/BITS_UPTO perhaps, but not really (and upto sounds like it is
> inclusive). BITS_LOW/BITS_HIGH have the same problem as BITS_LAST.
> 
> Also, be careful to document what one can expect from the boundary
> values 0/BITS_PER_LONG. Is BITS_FIRST(0) a valid invocation? Does it
> yield 0UL? How about BITS_FIRST(BITS_PER_LONG), does that give ~0UL?
> Note that BITMAP_{FIRST,LAST}_WORD_MASK never produce 0, they're never
> used except with a word we know to be part of the bitmap.
> 
> > We can pick BITS_{LAST,FIRST} implementation from existing BITMAP_*_WORD_MASK
> > analogues, and make the BITS_RANGE like:
> >         #define BITS_RANGE(begin, end) BITS_FIRST(end) & BITS_LAST(begin)
> > 
> > Regarding BITMAP_*_WORD_MASK, I can save them in bitmap.h as aliases
> > to BITS_{LAST,FIRST} to avoid massive renaming. (Should I?)
> 
> Yes, now that I read these again, I definitely think the
> BITMAP_{FIRST,LAST}_WORD_MASK should stay (whether their implementation
> change I don't care). Their names document what they do much better than
> if you replace them with their potential new implementations:
> BITMAP_FIRST_WORD_MASK(start) is obviously about having to mask off some
> low bits of the first word we're looking at because we're looking at an
> offset into the bitmap, and similarly BITMAP_LAST_WORD_MASK(nbits)
> explains itself: nbits is such that the last word needs some masking.
> But their replacements would be BITS_LAST(start) and BITS_FIRST(nbits)
> respectively (possibly with those arguments reduced mod N), which is
> quite confusing.
> 
> > Would this all work for you?
> 
> Maybe, I think I'd have to see the implementation and how those new
> macros get used.
> 
> Thanks,
> Rasmus

I looked at this with a fresh eye this morning. All the noise we
discuss I made to just call BITS_FIRST() 3 times in find.h. I think
that for the purpose of this series, in find.h, it's worth to use
GENMASK(size - 1, 0) where needed.

Regarding the general view on this, all the problems come from the
fact that bitmap API is split between linux/bitmap.h and
asm_generic/bitops/find.h. Find.h is naturally a part of bitmaps,
but because of the split, it's hard to use handy bitmap.h macros
in find.h.

Joining the headers is far out of the scope of this series. If no
objections, I'd prefer to drop this patch now, and later carefully
figure out how to join find.h and bitmap.h.

Yury
