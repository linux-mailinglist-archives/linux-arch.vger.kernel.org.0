Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894EF44D5E5
	for <lists+linux-arch@lfdr.de>; Thu, 11 Nov 2021 12:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbhKKLiJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Nov 2021 06:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbhKKLiJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Nov 2021 06:38:09 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0745DC0613F5;
        Thu, 11 Nov 2021 03:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PnbX+gQU93tJ4Oopo9HMKbJdOiep79gIINOH60lEP+Q=; b=Y25YDRrKPguEKSeTtTUSYmFzie
        uXPhh8AI174gyUJEzYFhj0TJ/dQg6+lsaH86PhNMqeKZlJuXDKlKV8xN9vLccNk8ghuixW/20cCad
        mETlQ138dCBSEHPY65HbPbce25H4Hg8mJfvqq8GMsLa+L8snnlf0rKMSFg5vK/1LwUXTY/Wrh877q
        4tOU+2QExR/CFrHWKAwsF778j6LUSvHP9QElOM7qMWcNRzlrB3x/AZgY+QiPgUog3NU9pP0H4Z5x7
        HvHZBFwWf4Gly6gVTeieIsXJU8hXwfb6plEGA8NLU78c06J7L8FEnQvfrFySib8nSCOFqDzHQOTW4
        YSpqFf0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ml8MA-00FSKN-3e; Thu, 11 Nov 2021 11:35:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F07A930001B;
        Thu, 11 Nov 2021 12:35:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB9E6203BF719; Thu, 11 Nov 2021 12:35:00 +0100 (CET)
Date:   Thu, 11 Nov 2021 12:35:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH -rcu/kcsan 23/23] objtool, kcsan: Remove memory barrier
 instrumentation from noinstr
Message-ID: <YYz/5BgYwHQceKx4@hirez.programming.kicks-ass.net>
References: <20211005105905.1994700-1-elver@google.com>
 <20211005105905.1994700-24-elver@google.com>
 <YVxjH2AtjvB8BDMD@hirez.programming.kicks-ass.net>
 <YVxrn2658Xdf0Asf@elver.google.com>
 <CANpmjNPk9i9Ap6LRuS32dRRCOrs4YwDP-EhfX-niCXu7zH2JOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPk9i9Ap6LRuS32dRRCOrs4YwDP-EhfX-niCXu7zH2JOg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 11, 2021 at 11:11:00AM +0100, Marco Elver wrote:
> On Tue, 5 Oct 2021 at 17:13, Marco Elver <elver@google.com> wrote:

> > So this is where I'd like to hear if the approach of:
> >
> >  | #if !defined(CONFIG_ARCH_WANTS_NO_INSTR) || defined(CONFIG_STACK_VALIDATION)
> >  | ...
> >  | #else
> >  | #define kcsan_noinstr noinstr
> >  | static __always_inline bool within_noinstr(unsigned long ip)
> >  | {
> >  |      return (unsigned long)__noinstr_text_start <= ip &&
> >  |             ip < (unsigned long)__noinstr_text_end;

Provided these turn into compile time constants this stands a fair
chance of working I suppose. Once this needs data loads things get a
*lot* more tricky.

> >  | }
> >  | #endif
> >
> > and then (using the !STACK_VALIDATION definitions)
> >
> >  | kcsan_noinstr void instrumentation_may_appear_in_noinstr(void)
> >  | {
> >  |      if (within_noinstr(_RET_IP_))
> >  |              return;
> >
> > works for the non-x86 arches that select ARCH_WANTS_NO_INSTR.
> >
> > If it doesn't I can easily just remove kcsan_noinstr/within_noinstr, and
> > add a "depends on !ARCH_WANTS_NO_INSTR || STACK_VALIDATION" to the
> > KCSAN_WEAK_MEMORY option.
> >
> > Looking at a previous discussion [1], however, I was under the
> > impression that this would work.
> >
> > [1] https://lkml.kernel.org/r/CANpmjNMAZiW-Er=2QDgGP+_3hg1LOvPYcbfGSPMv=aR6MVTB-g@mail.gmail.com
> 
> I'll send v2 of this series after 5.16-rc1. So far I think we haven't
> been able to say the above doesn't work, which means I'll assume it
> works on non-x86 architectures with ARCH_WANTS_NO_INSTR until we get
> evidence of the opposite.

Fair enough.
