Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9659E29A6A5
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 09:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894964AbgJ0Idv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 04:33:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2894962AbgJ0Idu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Oct 2020 04:33:50 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AC2822265;
        Tue, 27 Oct 2020 08:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603787629;
        bh=i7rzCbC9onXmLrxSCC+6EcM1f+ti0laeKu36miZDlRs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=csD2Ek4pR9o3WHz6JQMmZ+RTLsjf3cWyKctHjnB6zSrJKoGkBwuGfASMLOvz/6yfQ
         GACa7TtJJ4T8i9mISOoMsTLEeRfvZi/SlkDuQNoAFlKnWhPO0Tr1TVGfmSA/U+7zlw
         Hhd1wCJe3F0+sqqKzUBajpL33VPWBT+BMpeXvNTU=
Received: by mail-qv1-f41.google.com with SMTP id w9so290157qvj.0;
        Tue, 27 Oct 2020 01:33:49 -0700 (PDT)
X-Gm-Message-State: AOAM532md1A2RGJltmkMDQPOD7hv7e/izBR6UczQgTXHNoxFX+OeJzwf
        rwRINGpphfrZsFr0PQoKw5XoqLOXnlunSL0cz14=
X-Google-Smtp-Source: ABdhPJz13ydy8/9dXZDdNYjaBfB/KKNCkflbBtxp7UOj3mXiSYoZO9O/a760ocpoHi1mp0pZ2xcHlJto9I7aoR3+5ck=
X-Received: by 2002:a0c:c187:: with SMTP id n7mr1160171qvh.19.1603787628695;
 Tue, 27 Oct 2020 01:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201026165807.3724647-1-arnd@kernel.org> <022365e9-f7fe-5589-7867-d2ad2d33cfa3@redhat.com>
 <20201027074726.GX2611@hirez.programming.kicks-ass.net>
In-Reply-To: <20201027074726.GX2611@hirez.programming.kicks-ass.net>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 27 Oct 2020 09:33:32 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2vUK5scbtcRTE98ZvwxMF3xMBT61JODV__RHMj+D0G2A@mail.gmail.com>
Message-ID: <CAK8P3a2vUK5scbtcRTE98ZvwxMF3xMBT61JODV__RHMj+D0G2A@mail.gmail.com>
Subject: Re: [PATCH] qspinlock: use signed temporaries for cmpxchg
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 27, 2020 at 8:47 AM Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Oct 26, 2020 at 02:03:06PM -0400, Waiman Long wrote:
> > On 10/26/20 12:57 PM, Arnd Bergmann wrote:
> > Yes, it shouldn't really matter if the value is defined as int or u32.
> > However, the only caveat that I see is queued_spin_lock_slowpath() is
> > expecting a u32 argument. Maybe you should cast it back to (u32) when
> > calling it.
>
> No, we're not going to confuse the code. That stuff is hard enough as it
> is. This warning is garbage and just needs to stay off.

Ok, so the question then becomes: should we drop -Wpointer-sign from
W=2 and move it to W=3, or instead disable it locally. I could add
__diag_ignore(GCC, 4, "-Wpointer-sign") in the couple of header files
that produce this kind of warning if there is a general feeling that it
still helps to have this for drivers.

In the current state, there are a handful of header files that cause 90%
of all the W=2 warnings, making it impractical to ever build a driver
with W=2 and get anything useful out of it. I find some of the warnings
in the set useful in finding actual bugs, but much less so if they are
drowned out by noise from known false-positives.

     Arnd
