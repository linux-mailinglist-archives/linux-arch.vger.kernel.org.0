Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F298A3DE0AC
	for <lists+linux-arch@lfdr.de>; Mon,  2 Aug 2021 22:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhHBUaP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Aug 2021 16:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhHBUaP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Aug 2021 16:30:15 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35191C06175F;
        Mon,  2 Aug 2021 13:30:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so724844wmb.5;
        Mon, 02 Aug 2021 13:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=maODhYRPhde4BMWcrZ6/qErSkGLuv+PbRaEyxJhDMo4=;
        b=atODWd2WYUDiR/Yh8mbWci3AG5X+a80G2Q4BLWNFefPGVYYcIpMvWLouyf1ZAf6Njz
         mS8/6gVxf1P3kEdbhzo7tn18wqFDBh+uPpGnO+dFOW5aCzhPaAYz4qoWSgW+pBVd7UwK
         XmBzgBbBFQR2HMtig2PmSXx3J44FoIK33CmJ0g8q9xzgMGEhiw4QpYmuukC0gfX9KGas
         F9xCz3IbIYTj8BaM2LsmhXaQIKI6vIIX1ku7hoqSpP1VqjpBZOLfM0ZA8po18OgoyTFY
         iOkwzV8j6AGKlUnVUx7nwtGpXzaV/d5CzZJaCWTUjcO3Yd5LbZT3SrtadnOT/frT5l/0
         S9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=maODhYRPhde4BMWcrZ6/qErSkGLuv+PbRaEyxJhDMo4=;
        b=SEFufI1CBp/OSAlY3H8EOW296yPPrIgZBLyk45iyMQE6W+5fwxToBOpQTidpusz9x2
         GfVbcltk1HGTbHiOZeCl0/8j34k1rsHtzWLOrWriDRHfB0Oc53HhkLai/9iynw5VwpuR
         u4YtPWI8zN1U4FZvddSRHbY4jyrbWJ7NlLe0shQ0yzC697gDTd9WKT78onqayGpx0rB6
         wEjBs4Tb0IDzoaaT1Q05KPWgrntvxWT2A05DKWv2O/6WQT2iK0D+BAz2bNalxjYdTYzf
         BtkRSS0gD+GXzVdHsnokEPEleEog96eaoNVE0f+gSSSx+ROYLwc5AswAVA/yWYruQWi2
         mCew==
X-Gm-Message-State: AOAM531sYZ7WZihCYzzSp7DYvFaMtcWNM0QHvGxEXNFoAxZv2o3Q7kEi
        +HMZDY3MRee4OeTmMg47+Q==
X-Google-Smtp-Source: ABdhPJy3nJeqk03qeWAxAMHHcYXnIQ/OnlFxxyu/cuy0wKqXLfdqCXGwTCnG87w460nh7BOq4V8nFA==
X-Received: by 2002:a05:600c:3041:: with SMTP id n1mr654363wmh.19.1627936202860;
        Mon, 02 Aug 2021 13:30:02 -0700 (PDT)
Received: from localhost.localdomain ([46.53.249.181])
        by smtp.gmail.com with ESMTPSA id z20sm10875371wmi.36.2021.08.02.13.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 13:30:02 -0700 (PDT)
Date:   Mon, 2 Aug 2021 23:30:00 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     akpm@linux-foundation.org, linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        masahiroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] isystem: delete global -isystem compile option
Message-ID: <YQhVyOdQKUnvz1n5@localhost.localdomain>
References: <20210801201336.2224111-1-adobriyan@gmail.com>
 <20210801201336.2224111-3-adobriyan@gmail.com>
 <20210801213247.GM1583@gate.crashing.org>
 <YQeT5QRXc3CzK9nL@localhost.localdomain>
 <20210802164747.GN1583@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210802164747.GN1583@gate.crashing.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 02, 2021 at 11:47:47AM -0500, Segher Boessenkool wrote:
> On Mon, Aug 02, 2021 at 09:42:45AM +0300, Alexey Dobriyan wrote:
> > On Sun, Aug 01, 2021 at 04:32:47PM -0500, Segher Boessenkool wrote:
> > > On Sun, Aug 01, 2021 at 11:13:36PM +0300, Alexey Dobriyan wrote:
> > > > In theory, it enables "leakage" of userspace headers into kernel which
> > > > may present licensing problem.
> > > 
> > > > -NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
> > > > +NOSTDINC_FLAGS += -nostdinc
> > > 
> > > This is removing the compiler's own include files.  These are required
> > > for all kinds of basic features, and required to be compliant to the C
> > > standard at all.
> > 
> > No they are not required.
> 
> This is false, they *are* required, whenever you want to use these
> features.  If you do not include the required headers you get undefined
> behaviour.
> 
> > Kernel uses its own bool, uintptr_t and
> > static_assert, memset(), CHAR_BIT.
> 
> Yes, and it occasionally gets it wrong.  Great fun.  See c46bbf5d2def
> for the latest episode in this saga.  (Yes I know this is uapi so maybe
> not the best example here, but it isn't like the kernel gets such things
> wrong so often these days ;-) )
> 
> The kernel *cannot* make up its own types for this.  It has to use the
> types it is required to use (by C, by the ABIs, etc.)  So why
> reimplement this?

Yes, it can. gcc headers have stuff like this:

	#define __PTRDIFF_TYPE__ long int
	#define __SIZE_TYPE__ long unsigned int

If gcc can defined standard types, kernel can too.

> > noreturn, alignas newest C standard
> > are next.
> 
> What is wrong with <stdalign.h> and <stdnoreturn.h>?

These two are actually quite nice.

Have you seen <stddef.h>? Loads of macrology crap.
Kernel can ship nicer one.

> > This version changelog didn't mention but kernel would use
> > -ffreestanding too if not other problems with the flag.
> 
> It is still true for freestanding C implementations, you just get a
> severely reduced standard library,
> 
> > > These are not "userspace headers", that is what
> > > -nostdinc takes care of already.
> > 
> > They are userspace headers in the sense they are external to the project
> > just like userspace programs are external to the kernel.
> 
> So you are going to rewrite all of the rest of GCC inside the kernel
> project as well?

What an argument. "the rest of GCC" is already there except for stdarg.h.

> > > In the case of GCC all these headers are GPL-with-runtime-exception, so
> > > claiming this can cause licensing problems is fearmongering.
> > 
> > I agree licensing problem doesn't really exist.
> > It would take gcc drop-in replacement with authors insane enough to not
> > license standard headers properly.
> 
> There does still not exist a drop-in replacement for GCC, not if you
> look closely and/or rely on details (like the kernel does).  Some of the
> differences are hidden by "linux/compiler-*.h", but hardly all.
> 
> > > I strongly advise against doing this.
> > 
> > Kernel chose to be self-contained.
> 
> That is largely historical, imo.  Nowadays this is less necessary.

I kind of agree as in kernel should use int8_t and stuff because they
are standard.

Also, -isystem removal disables <float.h> and <stdatomic.h> which is
desireable.

> Also, the kernel chose to *do* use the compiler include files.  It is
> you who wants to abolish that here.
> 
> > -isystem removal makes sense then.
> 
> -nostdinc -isystem $(shell $(CC) -print-file-name=include)  makes sense
> for that: you do indeed not want the userspace headers.  Maiming the
> compiler (by removing some of its functional parts, namely, its generic
> headers) does not make sense.
> 
> > It will be used for intrinsics where necessary.
> 
> Like, everywhere.

No, where necessary. Patch demostrates there are only a few places which
want -isystem back.
