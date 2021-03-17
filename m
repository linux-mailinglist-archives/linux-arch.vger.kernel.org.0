Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1150733E92B
	for <lists+linux-arch@lfdr.de>; Wed, 17 Mar 2021 06:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhCQFlK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 01:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCQFlA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Mar 2021 01:41:00 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6FDC06175F;
        Tue, 16 Mar 2021 22:40:59 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id s7so37771127qkg.4;
        Tue, 16 Mar 2021 22:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CPSm56QZARIcAtzs4AWdlVXD+HaI2HudQhNYE/bwf0c=;
        b=eNX3/KkKYyE3gNciNxHG2jxNlfRRTV+efiSSrXTJLEM9BLy+T+ER7gUr4lbPR8OQ0R
         kz1iTGN6ch8aqMmCfJKh14wJlkFwDUIynaDTDRD6k1Nj/RQJh5kcusufWUXLk5zVnAwv
         8ua6/rTO3DrDQz7lwNDLuD/e93zzpogPQE+qRZHL471WVAsthqat3wUYnrJyGHHCkLjM
         jungnJ5I9JqlfAb00NcmdfSXlJVR/yRSh3MOrw4WSfPlS+QU+pwVI/N/sUggJAk4xFkD
         xKCt2Di1rIp3seeJrwyS3fF7cOVBKASIm4rQW50jfxw0+qVnUNRn6dDN2w9kwqE1M6Rc
         r3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CPSm56QZARIcAtzs4AWdlVXD+HaI2HudQhNYE/bwf0c=;
        b=gINIYZK2RYg15aCb2ZZFv8wy/GNHe1WI8MBt9imONGJvM0uH1ZlB92eZXNyr8+r/W8
         3FS5SbqQyf3T8MC5O3NrClOZs6ZmCqQYRZsVSZXS5qe+gVKt7iNZOj9DeZFgv9oTYq5H
         DysviNHjkLhY4u6OftgIpQxZwP04kRAMvk2+OjGfPDCGaUO4sphTXp3hs0AQdjPtjuo8
         MP18T0MzmsdPXHURLJNNcx2INxOVWlFlMehIQXuFcc2vd3XAAYPXHK3HoqkgoLBh/Sz3
         BWNfOYMhtUE7cFDi58GawlcB1hH84DByUdw07FIIop2nji/1NdapXXclacomsNURiBtr
         +kLA==
X-Gm-Message-State: AOAM532CIx6+9m2bFW2V0cndigkkk+V9VXLk1hcXv3DVQ/6iC6lFijuA
        3BRQtyq2o8KcOyFilKbBJKQ=
X-Google-Smtp-Source: ABdhPJx92GrckxUs3tyhYdiw3DknldvYvJ6QoejNd2Zc615/JMAkBxamhbbk2bzbYKYBbc0fPf+VLg==
X-Received: by 2002:a37:274f:: with SMTP id n76mr2939792qkn.15.1615959658716;
        Tue, 16 Mar 2021 22:40:58 -0700 (PDT)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id z2sm17499506qkg.22.2021.03.16.22.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 22:40:58 -0700 (PDT)
Date:   Tue, 16 Mar 2021 22:40:57 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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
Message-ID: <20210317054057.GC2114775@yury-ThinkPad>
References: <20210316015424.1999082-1-yury.norov@gmail.com>
 <20210316015424.1999082-5-yury.norov@gmail.com>
 <8021faab-e592-9587-329b-817ae007b89a@rasmusvillemoes.dk>
 <YFCZtUuMYVNeNlUO@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFCZtUuMYVNeNlUO@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 01:42:45PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 16, 2021 at 09:35:35AM +0100, Rasmus Villemoes wrote:
> > On 16/03/2021 02.54, Yury Norov wrote:
> > > BITMAP_{LAST,FIRST}_WORD_MASK() in linux/bitmap.h duplicates the
> > > functionality of GENMASK(). The scope of BITMAP* macros is wider
> > > than just bitmaps. This patch defines 4 new macros: BITS_FIRST(),
> > > BITS_LAST(), BITS_FIRST_MASK() and BITS_LAST_MASK() in linux/bits.h
> > > on top of GENMASK() and replaces BITMAP_{LAST,FIRST}_WORD_MASK()
> > > to avoid duplication and increase the scope of the macros.
> > > 
> > > This change doesn't affect code generation. On ARM64:
> > > scripts/bloat-o-meter vmlinux.before vmlinux
> > > add/remove: 1/2 grow/shrink: 2/0 up/down: 17/-16 (1)
> > > Function                                     old     new   delta
> > > ethtool_get_drvinfo                          900     908      +8
> > > e843419@0cf2_0001309d_7f0                      -       8      +8
> > > vermagic                                      48      49      +1
> > > e843419@0d45_000138bb_f68                      8       -      -8
> > > e843419@0cc9_00012bce_198c                     8       -      -8
> > 
> > [what on earth are those weird symbols?]
> > 
> > 
> > > diff --git a/include/linux/bits.h b/include/linux/bits.h
> > > index 7f475d59a097..8c191c29506e 100644
> > > --- a/include/linux/bits.h
> > > +++ b/include/linux/bits.h
> > > @@ -37,6 +37,12 @@
> > >  #define GENMASK(h, l) \
> > >  	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> > >  
> > > +#define BITS_FIRST(nr)		GENMASK((nr), 0)
> > > +#define BITS_LAST(nr)		GENMASK(BITS_PER_LONG - 1, (nr))
> > > +
> > > +#define BITS_FIRST_MASK(nr)	BITS_FIRST((nr) % BITS_PER_LONG)
> > > +#define BITS_LAST_MASK(nr)	BITS_LAST((nr) % BITS_PER_LONG)
> > 
> > I don't think it's a good idea to propagate the unusual closed-range
> > semantics of GENMASK to those wrappers. Almost all C and kernel code
> > uses the 'inclusive lower bound, exclusive upper bound', and I'd expect
> > BITS_FIRST(5) to result in a word with five bits set, not six. So I
> > think these changes as-is make the code much harder to read and understand.
> > 
> > Regardless, please add some comments on the valid input ranges to the
> > macros, whether that ends up being 0 <= nr < BITS_PER_LONG or 0 < nr <=
> > BITS_PER_LONG or whatnot.
> > 
> > It would also be much easier to review if you just redefined the
> > BITMAP_LAST_WORD_MASK macros etc. in terms of these new things, so you
> > wouldn't have to do a lot of mechanical changes at the same time as
> > introducing the new ones - especially when those mechanical changes
> > involve adding a "minus 1" everywhere.
> 
> I tend to agree with Rasmus here.

OK. All this plus terrible GENMASK(high, low) design, when high goes
first, makes me feel like we need to deprecate GENMASK and propose a
new interface.

What do you think about this:
BITS_FIRST(bitnum)      -> [0, bitnum)
BITS_LAST(bitnum)       -> [bitnum, BITS_PER_LONG)
BITS_RANGE(begin, end)  -> [begin, end)

We can pick BITS_{LAST,FIRST} implementation from existing BITMAP_*_WORD_MASK
analogues, and make the BITS_RANGE like:
        #define BITS_RANGE(begin, end) BITS_FIRST(end) & BITS_LAST(begin)

Regarding BITMAP_*_WORD_MASK, I can save them in bitmap.h as aliases
to BITS_{LAST,FIRST} to avoid massive renaming. (Should I?)

Would this all work for you?
