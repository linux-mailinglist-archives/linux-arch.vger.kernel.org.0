Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8671D224290
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 19:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgGQRtQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 13:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgGQRtQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 13:49:16 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB81C0619D3
        for <linux-arch@vger.kernel.org>; Fri, 17 Jul 2020 10:49:16 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id k27so7043952pgm.2
        for <linux-arch@vger.kernel.org>; Fri, 17 Jul 2020 10:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UmBYnpJxLOKWnlQafaq4C6F9spEh+E46qapMdJKdqIk=;
        b=jGmpJbFeB/mWj5s08JrCEpmPrV70zk0iTrM1SwiDc7+x09ybNxYSjiRZRaCoAi76lN
         0xgvyFMiLQs/gjLKvXL9xklDnnClPU+OuYnQ7oQhSr3KOT+mv8YST83YVjeNEhJjlN+s
         vj2un2SxZ6x6CLOG8xk18RT0iCO7YnKwd/D+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UmBYnpJxLOKWnlQafaq4C6F9spEh+E46qapMdJKdqIk=;
        b=fw77ooe/aTn9OErCk2SkOoc60KFbqaY5zgE3omLW03Uk05LwlkZRfU+Dl7Q+Q856Bz
         Ea0gBUMOqA97N3YtksRUH+LPZhvV0zvBeWNl1HH/joUERrrDx4zqGmh1gcskEhoMhe3t
         l4gWxrHVgevdX7IQNKmmIexngGu/6uiQAHiiVDMeWWRLAYrukzdo4II3U+I4D/DTyL5C
         tOJG+l7ZJBHd5X361W3bn/4TBBQBIg5aZqpIGSoJtuniIDostXfuHSez/Z6yF1E7ZpKK
         409OS3DmL5lRmLO/Ls/GBTkPS3gIgWF1Z3nEkl5pcjnVXej99XqxqOUcm5oxm3fTZ8kH
         OBbg==
X-Gm-Message-State: AOAM532VF17nMIeLsFBFu0xC3XvZqSPOX4hN5ZzBtbUZv5T21y2NRsDr
        f3EZp1+uooqoeqTTrToKPil91Q==
X-Google-Smtp-Source: ABdhPJzpf9/ZajaIEXyFjFi2Ba7LeZk4ZttZruqVO8DSt3fEPjVmPRj3vBVymqSJ3TNgQl5mmN3v+w==
X-Received: by 2002:a63:8c5d:: with SMTP id q29mr9353865pgn.249.1595008155556;
        Fri, 17 Jul 2020 10:49:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s30sm8709549pgn.34.2020.07.17.10.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 10:49:14 -0700 (PDT)
Date:   Fri, 17 Jul 2020 10:49:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [patch V3 01/13] entry: Provide generic syscall entry
 functionality
Message-ID: <202007171045.FB4A586F1D@keescook>
References: <20200716182208.180916541@linutronix.de>
 <20200716185424.011950288@linutronix.de>
 <202007161336.B993ED938@keescook>
 <87d04vt98w.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d04vt98w.fsf@nanos.tec.linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 16, 2020 at 11:55:59PM +0200, Thomas Gleixner wrote:
> Kees Cook <keescook@chromium.org> writes:
> > On Thu, Jul 16, 2020 at 08:22:09PM +0200, Thomas Gleixner wrote:
> >> This code is needlessly duplicated and  different in all
> >> architectures.
> >> 
> >> Provide a generic version based on the x86 implementation which has all the
> >> RCU and instrumentation bits right.
> >
> > Ahh! You're reading my mind!
> 
> I told you about that plan at the last conference over a beer :)

Thank you for incepting it in my head, then! ;)

> > [1] https://lore.kernel.org/lkml/20200716193141.4068476-2-krisman@collabora.com/
> 
> Saw that fly by. *shudder*

Aw, it's nice. Better emulation! :)

> 
> >> +/*
> >> + * Define dummy _TIF work flags if not defined by the architecture or for
> >> + * disabled functionality.
> >> + */
> >
> > When I was thinking about this last week I was pondering having a split
> > between the arch-agnositc TIF flags and the arch-specific TIF flags, and
> > that each arch could have a single "there is agnostic work to be done"
> > TIF in their thread_info, and the agnostic flags could live in
> > task_struct or something. Anyway, I'll keep reading...
> 
> That's going to be nasty. We rather go and expand the TIF storage to
> 64bit. And then do the following in a generic header:

I though the point was to make the TIF_WORK check as fast as possible,
even on the 32-bit word systems. I mean it's not a huge performance hit,
but *shrug*

> 
> #ifndef TIF_ARCH_SPECIFIC
> # define TIF_ARCH_SPECIFIC
> #endif
> 
> enum tif_bits {
> 	TIF_NEED_RESCHED = 0,
>         TIF_...,
>         TIF_LAST_GENERIC,
>         TIF_ARCH_SPECIFIC,
> };
>         
> and in the arch specific one:
> 
> #define TIF_ARCH_SPECIFIC	\
> 	TIF_ARCH_1,             \
>         TIF_ARCH_2,
> 
> or something like that.

Okay, yeah, that can work.

> > There's been some recent confusion over "has the syscall changed,
> > or did seccomp request it be skipped?" that was explored in arm64[2]
> > (though I see Will and Keno in CC already). There might need to be a
> > clearer way to distinguish between "wild userspace issued a -1 syscall"
> > and "seccomp or ptrace asked for the syscall to be skipped". The
> > difference is mostly about when ENOSYS gets set, with respect to calls
> > to syscall_set_return_value(), but if the syscall gets changed, the arch
> > may need to recheck the value and consider ENOSYS, etc. IIUC, what Will
> > ended up with[3] was having syscall_trace_enter() return the syscall return
> > value instead of the new syscall.
> 
> I was chatting with Will about that yesterday. IIRC he plans to fix the
> immediate issue on arm64 first and then move arm64 over to the generic
> variant. That's the reason why I reshuffled the patch series so the
> generic parts are first which allows me to provide will a branch with
> just those. If there are any changes needed we can just feed them back
> into that branch and fixup the affected architecture trees.
> 
> IOW, that should not block progress on this stuff.

Ok, great! I just wanted to make sure that didn't surprise anyone. :)

-- 
Kees Cook
