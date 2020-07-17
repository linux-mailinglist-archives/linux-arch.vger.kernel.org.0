Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CB32242E0
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 20:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgGQSFu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 14:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgGQSFu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Jul 2020 14:05:50 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65C06206F4;
        Fri, 17 Jul 2020 18:05:47 +0000 (UTC)
Date:   Fri, 17 Jul 2020 14:05:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: Re: [RFC][PATCH] objtool,x86_64: Replace recordmcount with objtool
Message-ID: <20200717140545.6f008208@oasis.local.home>
In-Reply-To: <CABCJKuda0AFCZ-1J2NTLc-M0xax007a9u-fzOoxmU2z60jvzbA@mail.gmail.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
        <20200624203200.78870-5-samitolvanen@google.com>
        <20200624212737.GV4817@hirez.programming.kicks-ass.net>
        <20200624214530.GA120457@google.com>
        <20200625074530.GW4817@hirez.programming.kicks-ass.net>
        <20200625161503.GB173089@google.com>
        <20200625200235.GQ4781@hirez.programming.kicks-ass.net>
        <20200625224042.GA169781@google.com>
        <20200626112931.GF4817@hirez.programming.kicks-ass.net>
        <CABCJKucSM7gqWmUtiBPbr208wB0pc25afJXc6yBQzJDZf4LSWA@mail.gmail.com>
        <20200717133645.7816c0b6@oasis.local.home>
        <CABCJKuda0AFCZ-1J2NTLc-M0xax007a9u-fzOoxmU2z60jvzbA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 17 Jul 2020 10:47:51 -0700
Sami Tolvanen <samitolvanen@google.com> wrote:

> > Someone just submitted a patch for arm64 for this:
> >
> > https://lore.kernel.org/r/20200717143338.19302-1-gregory.herrero@oracle.com
> >
> > Is that what you want?  
> 
> That looks like the same issue, but we need to fix this on x86 instead.

Does x86 have a way to differentiate between the two that record mcount
can check?

-- Steve
