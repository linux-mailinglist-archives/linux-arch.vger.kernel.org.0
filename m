Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2620033F502
	for <lists+linux-arch@lfdr.de>; Wed, 17 Mar 2021 17:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhCQQG0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 12:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbhCQQF5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Mar 2021 12:05:57 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BFAC061764
        for <linux-arch@vger.kernel.org>; Wed, 17 Mar 2021 09:05:56 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id z65so1324914vsz.12
        for <linux-arch@vger.kernel.org>; Wed, 17 Mar 2021 09:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v2KL8kozO5erdsP6tss56cJzIGTvQeUixy1fwBfyf9E=;
        b=L+sKGzrqRGkayjrIbx3UhJgUwtMmmzJiP7xVkweSApuxYoYxI4LeRgqnM7E2cVNFT2
         L45AC/pwNU1fz3kkRnhcRp5Khlan5/Osp695ao4Zeq1DMR4U7/JYz+4t7MEdHv1+9qwG
         zwxXB5v4s7x+iSvmDyAA8j6J5F/LEkxHHfS2qwphtbLFYhEDWUv95/kvZL3Trdu79AyT
         NNZbI9fnUQcz8+iyHBFSLC3Wa55Q+r5QDMMipTfIOHdnYaK4LSCdSwlrvXeW0lhZ4AF5
         WXtzd1I3zdoC7C//HbblJCanoQNzLOyg1wur/OGHsKtTZ3gw78PQ17RnksLC/ossk+fU
         fcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2KL8kozO5erdsP6tss56cJzIGTvQeUixy1fwBfyf9E=;
        b=D5fSDJGCccPY05sAByKRE6f9BXcHyY7UqrH7tpugDGyijLaGiI8vez1uLhyOsKQwKj
         bQ2YYO6BhDVV0IRmw6ekZtMSQC/gAlxAtHclTKBc4kOLTlMHfS0WXmIJVoAjAtCYPmeH
         iCXjGnuAUDrsIkkZ0qlEzRaBDdGbMpc/s6rnjwvHgiPivDZN/o9lLjYpvHNzuVDRltdv
         92ZTRAAavAQxt9dOz/V+cN6x+KTwvIEzcPTC5j/FGGE4tQO+Nunn/rcakrr1fowMlP39
         KlRUFUkMtf9fC131qLpMp2BX1XSqXJlFKrZfuhJWwZrx8M9OQ+FG9K9iFwAjf1cAkGxw
         7ZdA==
X-Gm-Message-State: AOAM530hYOLqMdGMR9W2NKXK/z8NyLg023CoeOpNlU0cLp5xuc2i9sr8
        Cp/vT9m3P+l52T/EKzpPzIK/lc6GZa4nnrjdhKRRUg==
X-Google-Smtp-Source: ABdhPJxaHsoJ+bz7hvftL5zgwqX9DbDHuTiz3ir8dA5jWQPZop9wwdoJTujQjPIzJwP11rynhQBtRWijCPDqibIFRy4=
X-Received: by 2002:a67:db98:: with SMTP id f24mr4264884vsk.13.1615997155510;
 Wed, 17 Mar 2021 09:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-7-samitolvanen@google.com> <20210312061304.GA2321497@infradead.org>
In-Reply-To: <20210312061304.GA2321497@infradead.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 17 Mar 2021 09:05:44 -0700
Message-ID: <CABCJKud-wRfmRLFv71QQ6etUMFX6KXsErmL6u0dPH4SU8HS-BQ@mail.gmail.com>
Subject: Re: [PATCH 06/17] kthread: cfi: disable callback pointer check with modules
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 11, 2021 at 10:13 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Mar 11, 2021 at 04:49:08PM -0800, Sami Tolvanen wrote:
> > With CONFIG_CFI_CLANG, a callback function passed to
> > __kthread_queue_delayed_work from a module points to a jump table
> > entry defined in the module instead of the one used in the core
> > kernel, which breaks function address equality in this check:
> >
> >   WARN_ON_ONCE(timer->function != kthread_delayed_work_timer_fn);
> >
> > Disable the warning when CFI and modules are enabled.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  kernel/kthread.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > index 1578973c5740..af5fee350586 100644
> > --- a/kernel/kthread.c
> > +++ b/kernel/kthread.c
> > @@ -963,7 +963,13 @@ static void __kthread_queue_delayed_work(struct kthread_worker *worker,
> >       struct timer_list *timer = &dwork->timer;
> >       struct kthread_work *work = &dwork->work;
> >
> > -     WARN_ON_ONCE(timer->function != kthread_delayed_work_timer_fn);
> > +     /*
> > +      * With CFI, timer->function can point to a jump table entry in a module,
>
> you keep spewing this comment line that has exactly 81 characters and
> thus badly messes up read it with a normal termina everywhere.
>
> Maybe instead of fixing that in ever duplication hide the whole check in
> a well documented helper (which would have to be a macro due to the
> typing involved).

Sure, that sounds cleaner. I'll add a helper macro in v2.

Sami
