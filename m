Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0B13D9FA7
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jul 2021 10:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbhG2IhY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jul 2021 04:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbhG2IhX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jul 2021 04:37:23 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCB2C061765
        for <linux-arch@vger.kernel.org>; Thu, 29 Jul 2021 01:37:20 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id go31so9341295ejc.6
        for <linux-arch@vger.kernel.org>; Thu, 29 Jul 2021 01:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I39HGlZFrN5UhSyFUOXgvxsc+tR9efYTD9FAv1y9Ohc=;
        b=A8yhH2LvNOUwO/GyfzLbJ+VPbz3tQFoQercEYn4fzax9sDTVyujF1DbA/mZm0iHpfK
         t6LjpVQrMErDKR+XYsCbPC+qtl6DYPMyND2qZrS15lEZ82heVqrR8tdnbB46cbR7pUx3
         Tu9Ie1Dh8kcJe688z76AB7Cu+rzayU4LQtNeX7OAsUh653tj8lZ5Lee4u+kNS9lCbeMr
         bLf4qWC/VbAprSVBHLn+bOFCkOwjAyZF+KcSJRVQ1NT9akDs4gsEAs/BiEd/xPK80Eat
         CAPeJmxN7rdl/Bb+4wC6xlHVUX1OlkmhreDnDHMFke0LOc5hEy9Y7xlcWjORiZa9SEnU
         8tkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I39HGlZFrN5UhSyFUOXgvxsc+tR9efYTD9FAv1y9Ohc=;
        b=IXotejU97YmDeSHNTkk8IWHTpA5xzCXf+Qqh4SAiIap+cQRpNRVExBRTDHkojUASrj
         v3nljI9UtbV73gXQAWJd3G5HrRhFb+e1bFvFhp25FCxduf697KQbXCSaK2Auw+OIveGn
         whiGc2UsIaLkCogdP808NF7e9XtLLn8nsGkEgj2AXIsafEHoCys//nbI1PPqZWf0GxB1
         IPtdSs2H6nzLsrqZR5Yeu/7z4apGzBJj77t+iEbwirNF7cM3d9X7xdLlzkxCy74Joxam
         uTNkCW0UDRJat2rwd4dmd/ZG14FsV/m0SvPX9rz3O0SrMQsdnct2ufL8yEmlg3aEYm3k
         a3Dg==
X-Gm-Message-State: AOAM5319w91rzIqlmRja15FV7Bh2Ynl6Sqdj5P9pZ/IvAJ3ZGLF+bq/q
        rLP0i3WYQIndMaxPjn9VD4rrurEDYECv6A3yIxXNfQ==
X-Google-Smtp-Source: ABdhPJylPFTHbDAybjAmQBP84+BQr132eQSq+dSrXfsjouMZOUsLZ4pr8INe+wyrzrp3gHv5WqcKdF0VBLe4QhCwTPM=
X-Received: by 2002:a17:906:f15:: with SMTP id z21mr3572948eji.177.1627547839583;
 Thu, 29 Jul 2021 01:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210728114822.1243-1-wangrui@loongson.cn> <YQFUe+QsHfBIgQev@hirez.programming.kicks-ass.net>
 <YQFYxr/2Zr7UclaN@hirez.programming.kicks-ass.net> <YQFZxuwQGiuWHxJL@hirez.programming.kicks-ass.net>
 <CAHirt9hBeLq8jejZZDLQkbc1rb6hDRD9w0QpFGJastrOsYe5vg@mail.gmail.com> <YQJle+vqR4i1wJal@hirez.programming.kicks-ass.net>
In-Reply-To: <YQJle+vqR4i1wJal@hirez.programming.kicks-ass.net>
From:   hev <r@hev.cc>
Date:   Thu, 29 Jul 2021 16:37:08 +0800
Message-ID: <CAHirt9g9wqQcXOXXE9es37O-gLMmezyR464=Nb88XjCBMJoMyA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/5] locking/atomic: Implement atomic_fetch_and_or
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rui Wang <wangrui@loongson.cn>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Peter,

On Thu, Jul 29, 2021 at 4:24 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jul 29, 2021 at 09:58:02AM +0800, hev wrote:
> > Hi, Peter,
> >
> > On Wed, Jul 28, 2021 at 9:21 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Jul 28, 2021 at 03:16:54PM +0200, Peter Zijlstra wrote:
> > > > On Wed, Jul 28, 2021 at 02:58:35PM +0200, Peter Zijlstra wrote:
> > > > > The below isn't quite right, because it'll use try_cmpxchg() for
> > > > > atomic_andnot_or(), which by being a void atomic should be _relaxed. I'm
> > > > > not entirely sure how to make that happen in a hurry.
> > > > >
> > > > > ---
> > > >
> > > > This seems to do the trick.
> > > >
> > >
> > > Mark suggested this, which is probably nicer still.
> > Wow, Amazing! so the architecture dependent can be implemented one by one.
>
> Nah, this is just the fallback, you still need individual arch code to
> optimize this and get proper LL/SC primitives.

Okay, already started. If the atomic andnot_or seems to be ok, I will
send the rest of the patches.

Regards
Rui
