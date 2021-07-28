Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B063D9029
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jul 2021 16:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbhG1OMz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 10:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236671AbhG1OMz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2021 10:12:55 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B700CC061757
        for <linux-arch@vger.kernel.org>; Wed, 28 Jul 2021 07:12:53 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id go31so4846024ejc.6
        for <linux-arch@vger.kernel.org>; Wed, 28 Jul 2021 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/kKRjCxopM8CkRMr4454ANstYPAv6D8HKTh0ZierECM=;
        b=L2uJr1MQKghT3ab4sSk4dze+O9j9Xgbz6p7ykN5TpJQtSXGd5Ra2mXQepbnEg3CsWd
         BUs28X/bc3+ABhDPkhiBwAUFzJOB+a65wRVU0hvAsSfDoEO4tp0rg90s7jhd4V0BFcB6
         34Cew36g7LMtFDAyq6gV+Qw5mCme1rdtj+8rBjtO9Rhx2Nb21cSviQsmKCSTG6BZgeSM
         YqsuRd6BQCDBOw9Bcorf+Gou7G0PfzCzFagvEMYXQuy3rFvE05w7gtdPjnq9wBQGRYbH
         5zFuPHgc/7SbaIlKXu66oaajtTa8aGKumdsLZZ6H8QzK2tPX4OVx3jdt0kr+yEJksurP
         CnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/kKRjCxopM8CkRMr4454ANstYPAv6D8HKTh0ZierECM=;
        b=oOVFkEGC1luCdIQBKyLE8HD4nqa3aewfNgZCL26xQyciOI0XejRJstCcjb7Ax/lWa0
         Q2zVMDG/AT2Rw2YVu8kDkFGP7e91nvdnAs24Q6//wo8kNOuGp733PVz1JeWBqtL8pMGA
         P7y+f47swoaeIMLCt76lev38nPRMarVLxHrgDvIDFwFHRjqHJz/c7/Jcfl20sBYlEbSM
         3bxv4XFSliADMvWg7zV9VLEX8ruv1prE92ZgSjrcXE3wjwaAeOaZ/W+nnjrRd219hjb1
         4ev2H0BLJXVdAoBiWoHiv7mS49GVUWcEr4qYMOS6uvg/I2xD50ZYchcTVO8hpFYXBFLG
         G9nQ==
X-Gm-Message-State: AOAM533793+M99N3Y9OqTvbOQFrk4U3H2LFTzc5K1hNnSxycE6BbNc6N
        r6n4bTeIJdn9N48qqIGXaRhokYm73PNG+DjfOoq1Eg==
X-Google-Smtp-Source: ABdhPJyIsQJ99idYHjog4sLH7SuUbrJrJj5wlhQV0jtVGnHGdvRupAYNriNUkcK6hQhfLu1z58/mSd0pxgw58i8M0+A=
X-Received: by 2002:a17:906:c0d1:: with SMTP id bn17mr17229751ejb.511.1627481572316;
 Wed, 28 Jul 2021 07:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210728114822.1243-1-wangrui@loongson.cn> <YQFKNcyHHWph8SjO@boqun-archlinux>
In-Reply-To: <YQFKNcyHHWph8SjO@boqun-archlinux>
From:   Hev <r@hev.cc>
Date:   Wed, 28 Jul 2021 22:12:41 +0800
Message-ID: <CAHirt9irQ8bio3HE-xTtQcDa5wJB1yXhZ4BJsgU7vW-FEYhLcA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/5] locking/atomic: Implement atomic_fetch_and_or
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Rui Wang <wangrui@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>, Guo Ren <guoren@kernel.org>,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Boqun,

On Wed, Jul 28, 2021 at 8:15 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> Hi,
>
> Thanks for the patchset. Seems that your git send-email command doesn't
> add the "In-Reply-to" tag for patch #2 to #5, so they are not threaded
> to patch #1. Not a big deal, but archives or email clients use that
> information to organize emails. You may want to check the command. Also,
> note that you can always use "--dry-run" option to preview the headers
> of your patchset ("--dry-run" won't do the actual send).
Thanks for your advice.

>
> On Wed, Jul 28, 2021 at 07:48:22PM +0800, Rui Wang wrote:
> > From: wangrui <wangrui@loongson.cn>
> >
> > This patch introduce a new atomic primitive 'and_or', It may be have three
> > types of implemeations:
> >
> >  * The generic implementation is based on arch_cmpxchg.
> >  * The hardware supports atomic 'and_or' of single instruction.
> >  * The hardware supports LL/SC style atomic operations:
> >
> >    1:  ll  v1, mem
> >        and t1, v1, arg1
> >        or  t1, t1, arg2
> >        sc  t1, mem
> >        beq t1, 0, 1b
> >
> > Now that all the architectures have implemented it.
> >
> > Signed-by-off: Rui Wang <wangrui@loongson.cn>
> > Signed-by-off: hev <r@hev.cc>
>
> First, this should be "Signed-off-by" ;-) Second, is the second
> "Signed-off-by" a mistake?
Beginner's luck :-)

>
> I will look into this for a review, in the meanwhile, but please add
> some tests in lib/atomic64_test.c, not only it will do the test at
> runtime, also it will generate asm code which helps people to review.
>
> Regards,
> Boqun
>

Regards,
Rui
