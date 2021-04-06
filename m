Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA421354F25
	for <lists+linux-arch@lfdr.de>; Tue,  6 Apr 2021 10:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbhDFI4i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 04:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbhDFI4i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Apr 2021 04:56:38 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98558C06174A;
        Tue,  6 Apr 2021 01:56:30 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d8so7099954plh.11;
        Tue, 06 Apr 2021 01:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9xdIx72BUryR8S57j/82YwQXQXS2KpU1UgBOV30ECIY=;
        b=TgIHqrGywgKnXMNklZnPmsxbnxfQhVs1/eip8i8YiMxdQR4RjRlUfUxvxL630b2ohO
         rj2MijmqaoRwFrfwquFATd9n3hub69GPxaoNcqnBz2I7sZK6VJYlluvXsDtx5mHIhdhs
         ZNb8vVejIeFztXXuQziXLhO2PBkkuOPLaeAZQ1hJVhNn/vgj04P4CaddpoOm6SftW7YY
         mCSjyGZWcprkJpY1wYgKpI/0r6PjQN0c36Ji2kzFWI7fulQOkeaQxbkYvtYeOHDTT01N
         oSjFXgnoLMaxPKM3mKNKMvqL16eyPYfI2+5st9Fnd4OUC03rXpzroRXoDUX8jVZr9GwA
         DHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9xdIx72BUryR8S57j/82YwQXQXS2KpU1UgBOV30ECIY=;
        b=lII6vAxennsFxOCVPzre1p0/Dp+vtziFsq+ahJoAtHgP5TL+ChpG6ms2Rlim6elxnF
         Y8peYr4dJ7bc3pTEg7e7+5wCOmbkqv5IKy2v7TzFKpi9YaIgOjsGWtCwQOZHWXl+s8Vm
         Giy7mJOdrSDIPqsred7S1g3a0UOtoHQ4qy8PUrf6XalVmgLPMYhJGbNQaHlAA262y4pa
         g3ZoafCKx+ZiCJILzQ/Znh0TgGPuLmaJGtIXzkevf6k+AtJLxkyHj0Lp1o0G5lxSNBK3
         0vRIi4ur3NH0ZauOQKwKAHSnnX6vAIyF3qex5ww7mysy1W1lBNIIKyJjV5dGVObHEQhl
         Kyuw==
X-Gm-Message-State: AOAM532ePoRQ1MOi33WH1ANZE4Tlt4yDtfVTVpRRMCw19J35Qp6ijklN
        FMYoSJtvWL0gBAhD5nyzWGY=
X-Google-Smtp-Source: ABdhPJzAV+gapYt2uFLFIiAFJ65qO40DcQUfQ8+y2O+oaBxM0IvPkfh4oGm033rNZm2YGkXRZY273A==
X-Received: by 2002:a17:902:d30b:b029:e8:dc10:86fb with SMTP id b11-20020a170902d30bb02900e8dc1086fbmr13105385plc.46.1617699390137;
        Tue, 06 Apr 2021 01:56:30 -0700 (PDT)
Received: from localhost (g139.124-45-193.ppp.wakwak.ne.jp. [124.45.193.139])
        by smtp.gmail.com with ESMTPSA id s2sm2010583pjs.49.2021.04.06.01.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 01:56:29 -0700 (PDT)
Date:   Tue, 6 Apr 2021 17:56:26 +0900
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
Message-ID: <20210406085626.GE3288043@lianli.shorne-pla.net>
References: <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net>
 <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net>
 <CAJF2gTRncV1+GT7nBpYkvfpyaG57o9ecaHBjoR6gEQAkG2ELrg@mail.gmail.com>
 <YGNNCEAMSWbBU+hd@hirez.programming.kicks-ass.net>
 <20210330223514.GE1171117@lianli.shorne-pla.net>
 <CAK8P3a0hj2pYr-CuNJkjO==RafZ=J+6kCo4HTWEwvvRXPcngJA@mail.gmail.com>
 <CAJF2gTRxPMURTE3M5WMQ_0q1yZ6K8nraGsFjGLUmpG9nYS_hng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTRxPMURTE3M5WMQ_0q1yZ6K8nraGsFjGLUmpG9nYS_hng@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 06, 2021 at 11:50:38AM +0800, Guo Ren wrote:
> On Wed, Mar 31, 2021 at 3:23 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Wed, Mar 31, 2021 at 12:35 AM Stafford Horne <shorne@gmail.com> wrote:
> > >
> > > I just want to chime in here, there may be a better spot in the thread to
> > > mention this but, for OpenRISC I did implement some generic 8/16-bit xchg code
> > > which I have on my todo list somwhere to replace the other generic
> > > implementations like that in mips.
> > >
> > >   arch/openrisc/include/asm/cmpxchg.h
> > >
> > > The idea would be that architectures just implement these methods:
> > >
> > >   long cmpxchg_u32(*ptr,old,new)
> > >   long xchg_u32(*ptr,val)
> > >
> > > Then the rest of the generic header would implement cmpxchg.
> >
> > I like the idea of generalizing it a little further. I'd suggest staying a
> > little closer to the existing naming here though, as we already have
> > cmpxchg() for the type-agnostic version, and cmpxchg64() for the
> > fixed-length 64-bit version.
> >
> > I think a nice interface between architecture-specific and architecture
> > independent code would be to have architectures provide
> > arch_cmpxchg32()/arch_xchg32() as the most basic version, as well
> > as arch_cmpxchg8()/arch_cmpxchg16()/arch_xchg8()/arch_xchg16()
> > if they have instructions for those.
> >
> > The common code can then build cmpxchg16()/xchg16() on top of
> > either the 16-bit or the 32-bit primitives, and build the cmpxchg()/xchg()
> > wrapper around those (or alternatively we can decide to have them
> > only deal with fixed-32-bit and long/pointer sized atomics).
> I think these emulation codes are suitable for some architectures but not riscv.
> 
> We shouldn't export xchg16/cmpxchg16(emulated by lr.w/sc.w) in riscv,
> We should forbid these sub-word atomic primitive and lets the
> programmers consider their atomic design.

Fair enough, having the generic sub-word emulation would be something that
an architecture can select to use/export.

-Stafford
