Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C9F348227
	for <lists+linux-arch@lfdr.de>; Wed, 24 Mar 2021 20:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbhCXTth (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Mar 2021 15:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbhCXTtO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Mar 2021 15:49:14 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624B6C061763;
        Wed, 24 Mar 2021 12:49:14 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id y2so16063111qtw.13;
        Wed, 24 Mar 2021 12:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HfV0wOGmQ26SsikmoIMguClgPW1zILB1cVxRdwigOiY=;
        b=JLoTzk2WXjByHa5k7axUCaDd0QeYo8TrHLnhJq43tIc4kRg5MJn2h1u8mvJXhbohtL
         dQqL3TinR1Aw3Fgh55PSJvsevSMBCYEEbVgJV7OWhS864XWPia+clGwwU1+reSqSVw+g
         tpQt+s+y+3PMaXDbzs90Nb+KRLTF3lWHBla3MG4h3GsnLyqKGq96T7grQ5hmzYyT33ib
         9ZefdiCMSwNXUEg95kWWGseSyB0Cz2ZHkgOMngBsAjznl/ER6JCzEzoZRiosYc6AIeZP
         slDU8DbyYK6bD4N6/mBy3Qs9ZmqMfDSLt1pRo60G/b7Fxa9Yt1oLpVVS5lE3YxOGNQtB
         A1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HfV0wOGmQ26SsikmoIMguClgPW1zILB1cVxRdwigOiY=;
        b=hwJkeUrI50qWowyYBmMcYcm8JNVhrshxj5scRNDUkqChnuhSpU3cUn5GHQ1ue6YayJ
         cKIO82oJOzV2MJZj2f9LN8VSTAygbacFxIarZ18Yn/hPwpODsjbcsXcNMzq5xhSHsZIx
         G0rcM0MAKaQfKlsCsRSyVBxsKXLvKrprH2rUKcRe/lIg2jlnVaryqLlrbUCPqO35/u86
         S1syfMegzoEZ1Yl327dAt/XHDJSE18+a5+JEAOe7we5r7AUcvkSEB1ykHxyPWTEJxCuf
         bLYHL0Kj8ghFeBtRHIuSB+9V7SVWD62KyZ5DMomWyzGvlHanqr5QpMmzlaDv80HLY40Z
         JnGA==
X-Gm-Message-State: AOAM533x5VKcIuftBkF4OaB9O/7owUnz9xUA2z5qgv9JeqZMMEEUmW1A
        ov4woYdsdF4eA/CjDdaSXP9zja9qe1FP5g==
X-Google-Smtp-Source: ABdhPJyUWElQN/siMTKHKdFWw68DH3tqryjL/puR1rebMThbAtxb4udbjBWoKwKwVtyPbz6aCSBXrw==
X-Received: by 2002:a05:622a:114:: with SMTP id u20mr4482752qtw.317.1616615353446;
        Wed, 24 Mar 2021 12:49:13 -0700 (PDT)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id l6sm2534625qke.34.2021.03.24.12.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 12:49:12 -0700 (PDT)
Date:   Wed, 24 Mar 2021 12:49:11 -0700
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
Subject: Re: [PATCH 06/12] tools: sync small_const_nbits() macro with the
 kernel
Message-ID: <20210324194911.GA18844@yury-ThinkPad>
References: <20210321215457.588554-1-yury.norov@gmail.com>
 <20210321215457.588554-7-yury.norov@gmail.com>
 <ef470d38-073d-2c6c-f9f8-909689a52212@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef470d38-073d-2c6c-f9f8-909689a52212@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 22, 2021 at 09:34:47AM +0100, Rasmus Villemoes wrote:
> On 21/03/2021 22.54, Yury Norov wrote:
> > Move the macro from tools/include/asm-generic/bitsperlong.h
> > to tools/include/linux/bitmap.h
> 
> The patch does it the other way around :)
> 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  tools/include/asm-generic/bitsperlong.h | 3 +++
> >  tools/include/linux/bitmap.h            | 3 ---
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/include/asm-generic/bitsperlong.h b/tools/include/asm-generic/bitsperlong.h
> > index 8f2283052333..f530da2506cc 100644
> > --- a/tools/include/asm-generic/bitsperlong.h
> > +++ b/tools/include/asm-generic/bitsperlong.h
> > @@ -18,4 +18,7 @@
> >  #define BITS_PER_LONG_LONG 64
> >  #endif
> >  
> > +#define small_const_nbits(nbits) \
> > +	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG)
> > +
> 
> Well, the movement is consistent with the kernel, but shouldn't the
> definition also be updated to exclude constant-zero-size? It's not that
> they exist or ever have, in tools/ or kernel proper, but just if some
> day some oddball CONFIG_ combination ends up creating such a beast, I'd
> rather not have code like
> 
> +	if (small_const_nbits(size)) {
> +		unsigned long val = *addr & GENMASK(size - 1, 0);
> 
> blow up at run-time.
> 
> Other than that (and the above commit log typo), consider the series
> 
> Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Thanks for spotting out this. The proper version of the patch is
below.

Andrew, it seems everything else looks good. If so, should I resubmit
the series, or you can pull it as is, including this patch?

Thanks,
Yury

From 7558697d4448f01a8ef73cd31def5d3e68b44b61 Mon Sep 17 00:00:00 2001
From: Yury Norov <yury.norov@gmail.com>
Date: Wed, 17 Feb 2021 20:05:05 -0800
Subject: [PATCH] tools: sync small_const_nbits() macro with the kernel

Sync implementation with the kernel and move the macro from
tools/include/linux/bitmap.h to tools/include/asm-generic/bitsperlong.h

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 tools/include/asm-generic/bitsperlong.h | 3 +++
 tools/include/linux/bitmap.h            | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/include/asm-generic/bitsperlong.h b/tools/include/asm-generic/bitsperlong.h
index 8f2283052333..2093d56ddd11 100644
--- a/tools/include/asm-generic/bitsperlong.h
+++ b/tools/include/asm-generic/bitsperlong.h
@@ -18,4 +18,7 @@
 #define BITS_PER_LONG_LONG 64
 #endif
 
+#define small_const_nbits(nbits) \
+	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG && (nbits) > 0)
+
 #endif /* __ASM_GENERIC_BITS_PER_LONG */
diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 4aabc23ec747..330dbf7509cc 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -22,9 +22,6 @@ void bitmap_clear(unsigned long *map, unsigned int start, int len);
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
 
-#define small_const_nbits(nbits) \
-	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG)
-
 static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
-- 
2.25.1

