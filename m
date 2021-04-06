Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3DF354F09
	for <lists+linux-arch@lfdr.de>; Tue,  6 Apr 2021 10:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244548AbhDFIvV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 04:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbhDFIvV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Apr 2021 04:51:21 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83A3C06174A;
        Tue,  6 Apr 2021 01:51:13 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c204so6175920pfc.4;
        Tue, 06 Apr 2021 01:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3s3OaRvgpy/TZIHwX6L6iy09Z97u8+dAODkZWJWz5kI=;
        b=drOm0AhBZgUdpIqEdIBofvJMXa1uF5tw8a7cBmW1ztc+qdtPP9uPQeSvZ8Jzu3k50f
         kANNA7ftms9q+521RHPDkK1GMgurSEHEBmirCZYsBQ38gTh+KNbDBKz4NJZIpSWm6Tcl
         yOW6/RymAKvlT2UNXJDV/HDi53FweuR6y+fKKezBaDMRtsd6KUQ/W+Af41wME5kNpmbc
         wbxiFJPEy939djZlx2R6YLI0qADTjIyjrd6ekd5HDVYkkBtuqefZIrEthOQ0pVNrSE1i
         pMAs6nbOipZ8vDoeX0cWQZRXM5bgVKRo5sZTgtMgimOOOytP0Q9VROUvUfK3Us1lRb4r
         0EKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3s3OaRvgpy/TZIHwX6L6iy09Z97u8+dAODkZWJWz5kI=;
        b=cnHZDaNQNm/2sUjgcUm4baTEKyl8NZ6KCUI7kSTucnHOrow2uqP9EnSrro14/mJEoU
         MmrVzKdsHAgmSs+G1qqoiqDny+MugwkFCUyTseLpQuiliTGjpBU6GYxGa1r3j/87VmGr
         bL0b92V/+xzDoZ+Xkw7BaJ2UpMtRqfF4mIU1JBk5qgDrouKI1fgyarMJJapuaFkFj45c
         5vAMW2A+vH1bqqQb+7immFmmhnbRThk+pmFPgP0uEP52K/DnvlfqiKRkQj4kFXNrNsrM
         ybTRIWJRJOb6824P/pt7siv8ODR/nkmlUOIF4jFKHAUpTKQELqvyopyBxPNkFblRga/g
         Zv/w==
X-Gm-Message-State: AOAM531YmJOKqE4c9ECPVJAw+7Lz9cUAaXtAq8TpivUxPCFvlnFdyokz
        zycaDQr2VW8pQHKmqn3u4ho=
X-Google-Smtp-Source: ABdhPJxlmcgNGraqfD41wyW8CXG4LKOYjNrrHUrbmV1G5tnOG/PBzweJ0HEoZ1rCS0Uqw5DHe6+M8w==
X-Received: by 2002:a63:f950:: with SMTP id q16mr2968746pgk.138.1617699073451;
        Tue, 06 Apr 2021 01:51:13 -0700 (PDT)
Received: from localhost (g139.124-45-193.ppp.wakwak.ne.jp. [124.45.193.139])
        by smtp.gmail.com with ESMTPSA id l10sm17133549pfc.125.2021.04.06.01.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 01:51:12 -0700 (PDT)
Date:   Tue, 6 Apr 2021 17:51:10 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Message-ID: <20210406085110.GD3288043@lianli.shorne-pla.net>
References: <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net>
 <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net>
 <CAJF2gTRncV1+GT7nBpYkvfpyaG57o9ecaHBjoR6gEQAkG2ELrg@mail.gmail.com>
 <YGNNCEAMSWbBU+hd@hirez.programming.kicks-ass.net>
 <20210330223514.GE1171117@lianli.shorne-pla.net>
 <CAK8P3a0hj2pYr-CuNJkjO==RafZ=J+6kCo4HTWEwvvRXPcngJA@mail.gmail.com>
 <20210331123107.GF1171117@lianli.shorne-pla.net>
 <CAJF2gTRZOFL_LECFcg6nEzNaDA_MR4dhxygFwm1_sDKY9CzBPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTRZOFL_LECFcg6nEzNaDA_MR4dhxygFwm1_sDKY9CzBPA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 31, 2021 at 11:10:53PM +0800, Guo Ren wrote:
> Hi Stafford,
> 
> How do think add ARCH_USE_QUEUED_SPINLOCKS_XCHG32 in openrisc?
> 
> https://lore.kernel.org/linux-riscv/1617201040-83905-7-git-send-email-guoren@kernel.org/T/#u

Sorry I missed your mail here.

It is true that OpenRISC doesn't have xchg16, so using the xchg32 code is better.

Acked-by: Stafford Horne <shorne@gmail.com>


> On Wed, Mar 31, 2021 at 8:31 PM Stafford Horne <shorne@gmail.com> wrote:
> >
> > On Wed, Mar 31, 2021 at 09:23:27AM +0200, Arnd Bergmann wrote:
> > > On Wed, Mar 31, 2021 at 12:35 AM Stafford Horne <shorne@gmail.com> wrote:
> > > >
> > > > I just want to chime in here, there may be a better spot in the thread to
> > > > mention this but, for OpenRISC I did implement some generic 8/16-bit xchg code
> > > > which I have on my todo list somwhere to replace the other generic
> > > > implementations like that in mips.
> > > >
> > > >   arch/openrisc/include/asm/cmpxchg.h
> > > >
> > > > The idea would be that architectures just implement these methods:
> > > >
> > > >   long cmpxchg_u32(*ptr,old,new)
> > > >   long xchg_u32(*ptr,val)
> > > >
> > > > Then the rest of the generic header would implement cmpxchg.
> > >
> > > I like the idea of generalizing it a little further. I'd suggest staying a
> > > little closer to the existing naming here though, as we already have
> > > cmpxchg() for the type-agnostic version, and cmpxchg64() for the
> > > fixed-length 64-bit version.
> >
> > OK.
> >
> > > I think a nice interface between architecture-specific and architecture
> > > independent code would be to have architectures provide
> > > arch_cmpxchg32()/arch_xchg32() as the most basic version, as well
> > > as arch_cmpxchg8()/arch_cmpxchg16()/arch_xchg8()/arch_xchg16()
> > > if they have instructions for those.
> >
> > Thanks for the name suggestions, it makes it easier for me.
> >
> > > The common code can then build cmpxchg16()/xchg16() on top of
> > > either the 16-bit or the 32-bit primitives, and build the cmpxchg()/xchg()
> > > wrapper around those (or alternatively we can decide to have them
> > > only deal with fixed-32-bit and long/pointer sized atomics).
> >
> > Yeah, that was the idea.
> >
> > -Stafford
> 
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 
> ML: https://lore.kernel.org/linux-csky/
