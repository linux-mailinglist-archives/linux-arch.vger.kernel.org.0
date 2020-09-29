Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CB527C054
	for <lists+linux-arch@lfdr.de>; Tue, 29 Sep 2020 11:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgI2JAR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Sep 2020 05:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbgI2JAK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Sep 2020 05:00:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9D6C0613D0
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2020 02:00:08 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v12so3942954wmh.3
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2020 02:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=l8n+Qtmools068Op1SBkscZ3rmiXf/OnO40zpDWJvQs=;
        b=HSfJ7A4FNQbt4jfghWagnZ0q3COkKg8qz4BPThTLTJ7eDRMt1DvHHeb7XKEZ522gOH
         eWGtprOnXgZp5uEMLqACAESKMKR8I99jBaCAbi8CJzl/OnYlzX1P6crhIyasKLf4c1bf
         2XybbZVEohhAC+dLedQmm8E/GOTp7GyR5iP8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=l8n+Qtmools068Op1SBkscZ3rmiXf/OnO40zpDWJvQs=;
        b=DRlsgS4LS8ZgvAPXC8eEJ5jbcUzjB8FJ0/gCfKVa+7QLynX5V/sNZrks577RmGBAAC
         4jPQCDoNw2AKuQ9L3jyjnLZIzccMmpyeIZcm+IXwh72VsLK2P5ZzacHet5hJzQjHwXA+
         MuZYQIRhXPmAvftyLSIIk8emKKFtO8+CnTTvCdubNn3QdL5DtRGG4yD2SpyfUPdyETfs
         nqYVp/zbQlX+E1Ebc+0rFk2O680DFTuzW0Tph7ZfF18mOLbic0PXlP6W7GqjglGH5V30
         arj+3EtycK3XP9UsiKluD0Whe2BTf0oNGEUK/3i8ugXe4cHogF+nh98niNTKkyDDu5pi
         BSyA==
X-Gm-Message-State: AOAM5339i9m/uW4y94oeOeMbvnwbKbamka4UCA3E8MAORy7JlQlJn0Cc
        v5zi/fAmuGjnkgFh8KFn4oJmRw==
X-Google-Smtp-Source: ABdhPJxYoSwWp1/Rwj6+DAZKjozJGei8dnC1WhCd/eu2wZIqXPLzEpFDxM+EMdAcXI41uJyANz2nYw==
X-Received: by 2002:a1c:a5c8:: with SMTP id o191mr3465483wme.127.1601370007530;
        Tue, 29 Sep 2020 02:00:07 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z191sm1552480wme.40.2020.09.29.02.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 02:00:06 -0700 (PDT)
Date:   Tue, 29 Sep 2020 11:00:03 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Segall <bsegall@google.com>, Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-hexagon@vger.kernel.org,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Brian Cain <bcain@codeaurora.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mel Gorman <mgorman@suse.de>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Matt Turner <mattst88@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-xtensa@linux-xtensa.org, Shuah Khan <shuah@kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 00/13] preempt: Make preempt count unconditional
Message-ID: <20200929090003.GG438822@phenom.ffwll.local>
Mail-Followup-To: Michal Hocko <mhocko@suse.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Segall <bsegall@google.com>, Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
        linux-hexagon@vger.kernel.org, Will Deacon <will@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Brian Cain <bcain@codeaurora.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>, David Airlie <airlied@linux.ie>,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mel Gorman <mgorman@suse.de>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Matt Turner <mattst88@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-xtensa@linux-xtensa.org, Shuah Khan <shuah@kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <871rj4owfn.fsf@nanos.tec.linutronix.de>
 <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
 <87bli75t7v.fsf@nanos.tec.linutronix.de>
 <CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com>
 <CAKMK7uHAk9-Vy2cof0ws=DrcD52GHiCDiyHbjLd19CgpBU2rKQ@mail.gmail.com>
 <20200916152956.GV29330@paulmck-ThinkPad-P72>
 <CAKMK7uGFyfhEyt=jmdk2jDO-hq0_Pf0ck+cKSELHjr2U3rPuYQ@mail.gmail.com>
 <20200916205840.GD29330@paulmck-ThinkPad-P72>
 <CAKMK7uHL2dMv80b8uBXr=BqHD2TQeODQQM1MGYhAfCYbX7sLrA@mail.gmail.com>
 <20200929081938.GC22035@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929081938.GC22035@dhcp22.suse.cz>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 29, 2020 at 10:19:38AM +0200, Michal Hocko wrote:
> On Wed 16-09-20 23:43:02, Daniel Vetter wrote:
> > I can
> > then figure out whether it's better to risk not spotting issues with
> > call_rcu vs slapping a memalloc_noio_save/restore around all these
> > critical section which force-degrades any allocation to GFP_ATOMIC at
> 
> did you mean memalloc_noreclaim_* here?

Yeah I picked the wrong one of that family of functions.

> > most, but has the risk that we run into code that assumes "GFP_KERNEL
> > never fails for small stuff" and has a decidedly less tested fallback
> > path than rcu code.
> 
> Even if the above then please note that memalloc_noreclaim_* or
> PF_MEMALLOC should be used with an extreme care. Essentially only for
> internal memory reclaimers. It grants access to _all_ the available
> memory so any abuse can be detrimental to the overall system operation.
> Allocation failure in this mode means that we are out of memory and any
> code relying on such an allocation has to carefuly consider failure.
> This is not a random allocation mode.

Agreed, that's why I don't like having these kind of automagic critical
sections. It's a bit a shotgun approach. Paul said that the code would
handle failures, but the problem is that it applies everywhere.

Anyway my understanding is that call_rcu will be reworked and gain a pile
of tricks so that these problems for the callchains leading to call_rcu
all disappear.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
