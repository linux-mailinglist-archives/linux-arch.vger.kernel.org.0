Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BDD355B1A
	for <lists+linux-arch@lfdr.de>; Tue,  6 Apr 2021 20:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbhDFSPx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 14:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbhDFSPw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Apr 2021 14:15:52 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6EAC061756;
        Tue,  6 Apr 2021 11:15:44 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id j3so5593116qvs.1;
        Tue, 06 Apr 2021 11:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SM97r+t3B/0Sl/bYA0tAxXDl/DGgw9Hc/stwzaVm5lI=;
        b=YOnnxLVuQaP7gy9jJQJLgrNK82zoXWf8BKOEjRJ7IknEJnviHryc81DEfIrUQ2knNP
         t7CWrMmMQ/nSJ3DSO7ARiS/oVSwoh6DfpmQdW4bP5zqOl9UPAYoNH8AzMdrhse9M1CPg
         eTatcmId3o1g/amVnAm+GCwV3fz5Ulrn6qrcTqmCy7jyBQenHfp9njNJNZYBjxTIMXYi
         YvOqNe8/p6M4/7VLBZ/cXo+5NVQxtvrgMbPCnKBopU/mP1ulBJmHZQ+WxKbfcW7CMJ4t
         EzH6Gnws74T25wZJ5mXDXiXgOnlm5SLanoUas2KBieAwKiYhG/+F6yKSSray6shbE5xV
         ITAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SM97r+t3B/0Sl/bYA0tAxXDl/DGgw9Hc/stwzaVm5lI=;
        b=CL49Cs5hqFnVG/MWPgcHiimqhwkazJTH5fCBqMQ3zpd8HxcsUi34O85uteuV6SryHx
         JQXx1QgVmjqO+2NyTyAZo6Bf6fsP15OMvx7JtHSj9pRGYE5JxS3CH7UbnYUqounmNHo9
         UY5+UQBNq6+PxI3vxopvc5nY+ujKZ1sEAhQVwmiYQCCWegO+EHHVnFsMuuzJMCzmmmUf
         KxAjWyM3je6IXp6+5x0dWXOR8TUdaksEDslF/9L3eoyB13NTRvPFSU6ioBXvWljHoELA
         2ENJWye7TdgmT1/jLniKgqyw7XLmdbDXTtihaOm0VwtnZ7Oyr/d9dBQuHWcXuvCpD/Qd
         H2MA==
X-Gm-Message-State: AOAM5309Gk8HZLpY9ZrGlKyeQdE5cS77b3HujlYciMh/2hcFR9l9YG70
        adxKKAzYVH4dSYMPnI6Z6ro=
X-Google-Smtp-Source: ABdhPJxZVb3/MGOAQygSnVOhur7hk5+nMcz2n4FNAYRLIh6ssKrcLFMnM34XpTY2HYgow8rrUtppdg==
X-Received: by 2002:a0c:eda7:: with SMTP id h7mr19509145qvr.26.1617732943021;
        Tue, 06 Apr 2021 11:15:43 -0700 (PDT)
Received: from localhost ([2601:4c0:104:d5fc:c1b1:fa44:c411:7822])
        by smtp.gmail.com with ESMTPSA id w5sm16371237qkc.85.2021.04.06.11.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 11:15:42 -0700 (PDT)
Date:   Tue, 6 Apr 2021 11:15:41 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
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
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH 11/13] lib: add fast path for find_first_*_bit() and
 find_last_bit()
Message-ID: <20210406181541.GA792963@yury-ThinkPad>
References: <20210316015424.1999082-1-yury.norov@gmail.com>
 <20210316015424.1999082-12-yury.norov@gmail.com>
 <20210406160327.GA180841@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406160327.GA180841@roeck-us.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 06, 2021 at 09:03:27AM -0700, Guenter Roeck wrote:
> On Mon, Mar 15, 2021 at 06:54:22PM -0700, Yury Norov wrote:
> > Similarly to bitmap functions, users would benefit if we'll handle
> > a case of small-size bitmaps that fit into a single word.
> > 
> > While here, move the find_last_bit() declaration to bitops/find.h
> > where other find_*_bit() functions sit.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  include/asm-generic/bitops/find.h | 50 ++++++++++++++++++++++++++++---
> >  include/linux/bitops.h            | 12 --------
> >  lib/find_bit.c                    | 12 ++++----
> >  3 files changed, 52 insertions(+), 22 deletions(-)
> > 
> > diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
> > index 4148c74a1e4d..8d818b304869 100644
> > --- a/include/asm-generic/bitops/find.h
> > +++ b/include/asm-generic/bitops/find.h
> > @@ -5,6 +5,9 @@
> >  extern unsigned long _find_next_bit(const unsigned long *addr1,
> >  		const unsigned long *addr2, unsigned long nbits,
> >  		unsigned long start, unsigned long invert, unsigned long le);
> > +extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long size);
> > +extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
> > +extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long size);
> >  
> >  #ifndef find_next_bit
> >  /**
> > @@ -102,8 +105,17 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
> >   * Returns the bit number of the first set bit.
> >   * If no bits are set, returns @size.
> >   */
> > -extern unsigned long find_first_bit(const unsigned long *addr,
> > -				    unsigned long size);
> > +static inline
> > +unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
> > +{
> > +	if (small_const_nbits(size)) {
> > +		unsigned long val = *addr & BITS_FIRST(size - 1);
> > +
> > +		return val ? __ffs(val) : size;
> 
> This patch results in:
> 
> include/asm-generic/bitops/find.h: In function 'find_last_bit':
> include/asm-generic/bitops/find.h:164:16: error: implicit declaration of function '__fls'; did you mean '__ffs'?
> 
> and:
> 
> ./include/asm-generic/bitops/__fls.h: At top level:
> ./include/asm-generic/bitops/__fls.h:13:38: error: conflicting types for '__fls'
> 
> when building scripts/mod/devicetable-offsets.o.
> 
> Seen with h8300 builds.
> 
> Guenter

The patch is here:

https://lkml.org/lkml/2021/4/1/1184
 
Yury
