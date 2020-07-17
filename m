Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC2E2241EA
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 19:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgGQRgv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 13:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgGQRgv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Jul 2020 13:36:51 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A01420717;
        Fri, 17 Jul 2020 17:36:48 +0000 (UTC)
Date:   Fri, 17 Jul 2020 13:36:45 -0400
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
Message-ID: <20200717133645.7816c0b6@oasis.local.home>
In-Reply-To: <CABCJKucSM7gqWmUtiBPbr208wB0pc25afJXc6yBQzJDZf4LSWA@mail.gmail.com>
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
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 17 Jul 2020 10:28:13 -0700
Sami Tolvanen <samitolvanen@google.com> wrote:

> On Fri, Jun 26, 2020 at 4:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Jun 25, 2020 at 03:40:42PM -0700, Sami Tolvanen wrote:
> >  
> > > > Not boot tested, but it generates the required sections and they look
> > > > more or less as expected, ymmv.  
> >  
> > > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > > index a291823f3f26..189575c12434 100644
> > > > --- a/arch/x86/Kconfig
> > > > +++ b/arch/x86/Kconfig
> > > > @@ -174,7 +174,6 @@ config X86
> > > >     select HAVE_EXIT_THREAD
> > > >     select HAVE_FAST_GUP
> > > >     select HAVE_FENTRY                      if X86_64 || DYNAMIC_FTRACE
> > > > -   select HAVE_FTRACE_MCOUNT_RECORD
> > > >     select HAVE_FUNCTION_GRAPH_TRACER
> > > >     select HAVE_FUNCTION_TRACER
> > > >     select HAVE_GCC_PLUGINS  
> > >
> > > This breaks DYNAMIC_FTRACE according to kernel/trace/ftrace.c:
> > >
> > >   #ifndef CONFIG_FTRACE_MCOUNT_RECORD
> > >   # error Dynamic ftrace depends on MCOUNT_RECORD
> > >   #endif
> > >
> > > And the build errors after that seem to confirm this. It looks like we might
> > > need another flag to skip recordmcount.  
> >
> > Hurm, Steve, how you want to do that?  
> 
> Steven, did you have any thoughts about this? Moving recordmcount to
> an objtool pass that knows about call sites feels like a much cleaner
> solution than annotating kernel code to avoid unwanted relocations.
> 

Bah, I started to reply to this then went to look for details, got
distracted, forgot about it, my laptop crashed (due to a zoom call),
and I lost the email I was writing (haven't looked in the drafts
folder, but my idea about this has changed since anyway).

So the problem is that we process mcount references in other areas and
that confuses the ftrace modification portion?

Someone just submitted a patch for arm64 for this:

https://lore.kernel.org/r/20200717143338.19302-1-gregory.herrero@oracle.com

Is that what you want?

-- Steve
