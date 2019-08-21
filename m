Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 801A696E8D
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2019 02:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfHUAu2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Aug 2019 20:50:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfHUAu1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 20:50:27 -0400
Received: from oasis.local.home (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 542C3206BB;
        Wed, 21 Aug 2019 00:50:26 +0000 (UTC)
Date:   Tue, 20 Aug 2019 20:50:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Drew Davenport <ddavenport@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Feng Tang <feng.tang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] bug: Move WARN_ON() "cut here" into exception
 handler
Message-ID: <20190820205020.1fc22706@oasis.local.home>
In-Reply-To: <201908200908.6437DF5@keescook>
References: <20190819234111.9019-1-keescook@chromium.org>
        <20190819234111.9019-8-keescook@chromium.org>
        <20190820100638.GK2332@hirez.programming.kicks-ass.net>
        <06ba33fd-27cc-3816-1cdf-70616b1782dd@c-s.fr>
        <201908200908.6437DF5@keescook>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 20 Aug 2019 09:33:24 -0700
Kees Cook <keescook@chromium.org> wrote:
> > > > diff --git a/lib/bug.c b/lib/bug.c
> > > > index 1077366f496b..6c22e8a6f9de 100644
> > > > --- a/lib/bug.c
> > > > +++ b/lib/bug.c
> > > > @@ -181,6 +181,15 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
> > > >   		}
> > > >   	}
> > > > +	/*
> > > > +	 * BUG() and WARN_ON() families don't print a custom debug message
> > > > +	 * before triggering the exception handler, so we must add the
> > > > +	 * "cut here" line now. WARN() issues its own "cut here" before the
> > > > +	 * extra debugging message it writes before triggering the handler.
> > > > +	 */
> > > > +	if ((bug->flags & BUGFLAG_PRINTK) == 0)
> > > > +		printk(KERN_DEFAULT CUT_HERE);  
> > > 
> > > I'm not loving that BUGFLAG_PRINTK name, BUGFLAG_CUT_HERE makes more
> > > sense to me.  
> 
> That's fine -- easy rename. :)
> 
> > Actually it would be BUGFLAG_NO_CUT_HERE then, otherwise all arches not
> > using the generic macros will have to add the flag to get the "cut here"
> > line.  
> 
> I am testing for the lack of the flag (so that only the
> CONFIG_GENERIC_BUG with __WARN_FLAGS case needs to set it). I was
> thinking of the flag to mean "this reporting flow has already issued
> cut-here". It sounds like it would be more logical to have it named
> BUGFLAG_NO_CUT_HERE to mean "do not issue a cut-here; it has already
> happened"? I will update the patch.
> 

 BUGFLAG_HAS_CUT_HERE ?

As it shows it was already done?

-- Steve
