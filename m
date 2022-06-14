Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD1154AEB9
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jun 2022 12:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241449AbiFNKru (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jun 2022 06:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242207AbiFNKrt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jun 2022 06:47:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198811F600
        for <linux-arch@vger.kernel.org>; Tue, 14 Jun 2022 03:47:48 -0700 (PDT)
Date:   Tue, 14 Jun 2022 12:47:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655203666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2AQL2EEBToXQ50m/4ttscxpZCFuANbpstIl/Ku3QhLg=;
        b=Oil0xWmm84kD6/sT7GeJI4d8oiWAvxCcXuSasgv6oYMdAu0Wy9eBDSYgP1tfwTP2pne0w4
        XPnoazoBhOXBVstD+f4RmcazjVP829X5g6dsbdkzmZwgdWw4n7YLiZdAMnmFLh4lfcNzOw
        k1gghNa583ZpgoGlXecMtmsm/zgJdz4I3jH+3TMyP9eo2cnvcCj2zg6/tXsBrv+nC03CFp
        QxoAaTytW9unWyNxPnuKveHeAgQeYDodxQ4BEBRg+TflBJeYB8sGbg83I2xkp97lfQgoJy
        ZjvnR2MEGfPg2vuspXPYmiiM5SAG3p0ZZalcAMvxqHx6Mnjw41yzuen35nXUjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655203666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2AQL2EEBToXQ50m/4ttscxpZCFuANbpstIl/Ku3QhLg=;
        b=k0X2sGNVaJqzG+L1Fs9gfoQccpSUpkawuJpzbfCDYf9+melV47DIWyPkARtvX4kswJJfDE
        d+dVal9c/0IJWoCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] generic/softirq: Disable softirq stacks on PREEMPT_RT
Message-ID: <YqhnUNzINOkhvfRb@linutronix.de>
References: <20220613182746.114115-1-bigeasy@linutronix.de>
 <CAK8P3a18cCESYki+4_3UgALRUq1MKmjSZvfXEyKHxgSENYfnXw@mail.gmail.com>
 <Yqg0sNLrtyMvhMNY@linutronix.de>
 <CAK8P3a2KxBgdu66tbc4YEUDsjZrRRs3t78NNPLj3K9XFB+BFAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a2KxBgdu66tbc4YEUDsjZrRRs3t78NNPLj3K9XFB+BFAg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2022-06-14 12:07:48 [+0200], Arnd Bergmann wrote:
> > So where do I put this patch to? If I remember correctly then arm64 is
> > using this. ARM has its own thing and x86 has this change already.
> 
> I don't see HAVE_SOFTIRQ_ON_OWN_STACK for arm, parisc, powerpc,
> s390, sh, sparc and x86, but not arm64. I would suggest having a single
> patch that does the same change across all architectures that don't already do
> this, and then merging it either through tip or through my asm-generic tree.

Oh. I posted the ARM bits with my other ARM patch as a mini two patch
series a few secs before this.

I could group this softirq change for all architectures in a single
patch. But then powerpc didn't want the "PREEMPT_RT" annotation for the
warning/ stack backtrace and they may not be too keen about this. So for
powerpc I was thinking to present them all at once.
Looking at sparc and parisc, there might be more to it than just this.
Both were never tested while I have the missing bits for arm* and
powerpc in my queue.

Eitherway, if you want I can regroup and send you the softirq bits for
all arches.

> > - ksoftirqd thread.
> > - in the force-threaded interrupt after the main handler.
> > - any time after bh-counter hits zero due local_bh_enable().
> >
> > The last one will cause higher task stacks.
> 
> Does this mean it only happens when a softirq gets raised from task context
> (which would be predictable), or also at an arbitrary time if it gets raised
> by a non-threaded hardirq or IPI?

If the softirq gets raised from non-task context (hardirq or IPI) then
it will be deferred to ksoftirqd (and not invoked on irq-exit path).

>         Arnd

Sebastian
