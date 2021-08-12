Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C32A3EA3EB
	for <lists+linux-arch@lfdr.de>; Thu, 12 Aug 2021 13:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbhHLLlj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Aug 2021 07:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbhHLLli (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Aug 2021 07:41:38 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1205C061765
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 04:41:13 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id a13so7886837iol.5
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 04:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dGZqoLTk7yiLcb0Z3SQY+NszGZr8eUe6JRLvTtfRu3I=;
        b=HL8ITKNqYj+tQ9EEJ+b6N5TjbE/brduyq8C2hdPd5hE09o44A7ZoMB8uvugYLjaO2i
         d9ioWEXbyFcVbxpAZTsHvAROyVlykXYbFehmmL/BaT5wiom35FAGTbzT3P+gqHA+0XlU
         2S0LdeXrBbG01mpaCwt9eQUyz1kmsuSwfOM/d7GvTJ3i88yALmVsFjGnQnLZ/6hmqtdt
         pjAyT3T9DqPljRrov640JhAB/k+VQycm2Ni6LfJCzqGa59cd0LkwoW253p3pvrUtLu3/
         cwdu/xtpi0ZPB5ZlCOQw68Q1zBhWjuZgDiqRz2h6bT5Ix9pxkY3Yb4FfSNTcO9YDHBj5
         4gsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dGZqoLTk7yiLcb0Z3SQY+NszGZr8eUe6JRLvTtfRu3I=;
        b=TZXwckaqeSouwzMTCj81+9SAgMs2aRUDjTNu6V9oBx3kLr9MrfMEgjtdqVqKYEzirv
         gv2BdYCSlKnbXQjvi48rMJCd3ozVTxaasYzPHGcb9qrrAD+3IVvAlC46l83tQ5NkBTZX
         6k/w+kdBkax2zxlyIsdl6/ZJFZbUaOE61eLx9cBWhifLmyXkdtHaMD1B6NSp+BWDpZVC
         yln+OIdomCdPgOgzVuM7ic8ldSGc3MBK0UOMt339HrFMvYC1ik10zqhjkpzTqs8//0EL
         UqGWziSmXBHA1Z2CQembovOdXaul+CztATnX19gUoTh+Sbd0NQLKUIVW1Hr/nasjSOWZ
         HDng==
X-Gm-Message-State: AOAM5329CT7Yd1iIJWzyuL9kBU+Y7BK7auBO4G22X7svIi5/wwK/ArRB
        bIiYc9rLwLwndRHxtouFwWpTL2F/UkfpT95WZd8=
X-Google-Smtp-Source: ABdhPJwHG1fOymfryspZ4lykWEmPmOB4w2xkJ9pcXN1PbRW/N6jj3xYognmDxBvJV0ICnzDqEF62RG4PiDmJCeD5g24=
X-Received: by 2002:a02:cb45:: with SMTP id k5mr1029892jap.112.1628768473289;
 Thu, 12 Aug 2021 04:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-18-chenhuacai@loongson.cn> <YORfNeAKG8tvOvjm@hirez.programming.kicks-ass.net>
In-Reply-To: <YORfNeAKG8tvOvjm@hirez.programming.kicks-ass.net>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 12 Aug 2021 19:41:00 +0800
Message-ID: <CAAhV-H6P3OCr3JCCQh6A8CbnoZQPWiMNHEhF3aTp8EYJmxcfNw@mail.gmail.com>
Subject: Re: [PATCH 17/19] LoongArch: Add multi-processor (SMP) support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Peter,

On Tue, Jul 6, 2021 at 9:48 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jul 06, 2021 at 12:18:18PM +0800, Huacai Chen wrote:
> > +/*
> > + * Loongson-3's SFB (Store-Fill-Buffer) may buffer writes indefinitely when a
> > + * tight read loop is executed, because reads take priority over writes & the
> > + * hardware (incorrectly) doesn't ensure that writes will eventually occur.
> > + *
> > + * Since spin loops of any kind should have a cpu_relax() in them, force an SFB
> > + * flush from cpu_relax() such that any pending writes will become visible as
> > + * expected.
> > + */
> > +#define cpu_relax()  smp_mb()
>
> Guys! You've not fixed that utter trainwreck ?!? You've taped out a
> whole new architecture and you're keeping this?
It is ugly of course, but it hasn't been fixed now.

Huacai
