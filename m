Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508964367A9
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 18:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhJUQ1y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 12:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhJUQ1x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 12:27:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B916CC061764
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:25:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id oa4so884338pjb.2
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zLyHkZJxv9AuckTXl1aFGO1wqCnZzuTOb4ASGakK8zU=;
        b=jdG0sXg+e5z7+9YUsZpsO8v14PCLj01j7Zd+6xMXVIcGrV2OizvK3wWHqqDcJrmxap
         RLERx1HyuKSZmD5zmBcddvnYTudha9TyiDp5UoVDtRW3NSacwc1Cx3f21nLMIegaFu6X
         ZSIS59bdZtXPUjbgVM3FbaHycvfaXmcZn6+hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zLyHkZJxv9AuckTXl1aFGO1wqCnZzuTOb4ASGakK8zU=;
        b=6pDawqOnZRUTC8S52jzjrrZBDpAPrvAau6d8a48eNtFGnhZSffNQ1C98hmXcgPiMxG
         2Ob1HvEuz0LSr7p8Tc99jSBpLOinEYMn8XTrXfG7/YB9bKHNJZQNB3LjOhbwDgw3wWzp
         hF+qqC/7ERSP3o/73zK761nQS2PkuuGI8fU88LvuTXn8I4AaBbA5ciL34yNN3HMl/Y0/
         yGwmJ9YS/4BloF7GHdWptI597U1GJELx45cB34rOvTTLkjNNiK4d+Bdwk5GlVOpxABAd
         GVDMKclEmCpQRvQTxAnea+4mTMKLINRpQ2/6NsK++Sv+WG31BjCLDjzIigQRo7DrgB3/
         P/6w==
X-Gm-Message-State: AOAM532c8HRLLaHJci3AjAsHfMqYliiDOiQMWBNQxqRAmF29oJxnJ1pI
        7/yvOllqIesX9Zaa+fsn0n1FmA==
X-Google-Smtp-Source: ABdhPJy0qiFIEXxxtmTn5++MkdPedI7wi1p1o7iOA0FoFON5kUhfAjCBUbZp9PpGAgo7A66DW1Oa0w==
X-Received: by 2002:a17:90a:7893:: with SMTP id x19mr7765866pjk.197.1634833537254;
        Thu, 21 Oct 2021 09:25:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b18sm7815177pfl.24.2021.10.21.09.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:25:37 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:25:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 14/20] exit/syscall_user_dispatch: Send ordinary signals
 on failure
Message-ID: <202110210925.9DEAF27CA@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-14-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-14-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 20, 2021 at 12:44:00PM -0500, Eric W. Biederman wrote:
> Use force_fatal_sig instead of calling do_exit directly.  This ensures
> the ordinary signal handling path gets invoked, core dumps as
> appropriate get created, and for multi-threaded processes all of the
> threads are terminated not just a single thread.
> 
> When asked Gabriel Krisman Bertazi <krisman@collabora.com> said [1]:
> > ebiederm@xmission.com (Eric W. Biederman) asked:
> >
> > > Why does do_syscal_user_dispatch call do_exit(SIGSEGV) and
> > > do_exit(SIGSYS) instead of force_sig(SIGSEGV) and force_sig(SIGSYS)?
> > >
> > > Looking at the code these cases are not expected to happen, so I would
> > > be surprised if userspace depends on any particular behaviour on the
> > > failure path so I think we can change this.
> >
> > Hi Eric,
> >
> > There is not really a good reason, and the use case that originated the
> > feature doesn't rely on it.
> >
> > Unless I'm missing yet another problem and others correct me, I think
> > it makes sense to change it as you described.
> >
> > > Is using do_exit in this way something you copied from seccomp?
> >
> > I'm not sure, its been a while, but I think it might be just that.  The
> > first prototype of SUD was implemented as a seccomp mode.
> 
> If at some point it becomes interesting we could relax
> "force_fatal_sig(SIGSEGV)" to instead say
> "force_sig_fault(SIGSEGV, SEGV_MAPERR, sd->selector)".
> 
> I avoid doing that in this patch to avoid making it possible
> to catch currently uncatchable signals.
> 
> Cc: Gabriel Krisman Bertazi <krisman@collabora.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> [1] https://lkml.kernel.org/r/87mtr6gdvi.fsf@collabora.com
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Yeah, looks good. Should be no visible behavior change.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
