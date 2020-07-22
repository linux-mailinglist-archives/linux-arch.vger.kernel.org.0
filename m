Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2008522A36C
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 01:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733112AbgGVX4u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 19:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbgGVX4u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 19:56:50 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1319CC0619E1;
        Wed, 22 Jul 2020 16:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+o+RK6ajhbuXa8t53WrOJ/qO/QqSI4MSwqISfWHz0Bo=; b=AOTr95qzy3NNS7ydya0oEhrj0x
        IXsE0BLHInLxK7LMENdQilIfh2cpaGkvHT95pCgdQwNllmzwOLo3+ojeCbEeS4ONogdi/FdZvcsKA
        vAAlb2nO3vfaHmXrCG9JS/bvR5nFxAh//2dmSV204vs1qw1GWAabgr/uWXOtCYgSy/mF0P8ZAPH1a
        0M834X7yscfS6C56SWvXovBm3e9oXECz2XoS4GyQhiQw3PA9SiSIXRP8eb+3AJdmfYbzvrwZxEpS7
        UoeZWuAa/x/uCWzeKIKFz1PRB4jr7Bgi4tjCA67T2axhMjY8cp+HgOR0/H1DXp/uKqGGDB/OHYF0s
        5GlHzNUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyOb0-0007ot-PD; Wed, 22 Jul 2020 23:56:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A4C193060EF;
        Thu, 23 Jul 2020 01:56:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E31729BEC9E1; Thu, 23 Jul 2020 01:56:20 +0200 (CEST)
Date:   Thu, 23 Jul 2020 01:56:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC][PATCH] objtool,x86_64: Replace recordmcount with objtool
Message-ID: <20200722235620.GR10769@hirez.programming.kicks-ass.net>
References: <20200624212737.GV4817@hirez.programming.kicks-ass.net>
 <20200624214530.GA120457@google.com>
 <20200625074530.GW4817@hirez.programming.kicks-ass.net>
 <20200625161503.GB173089@google.com>
 <20200625200235.GQ4781@hirez.programming.kicks-ass.net>
 <20200625224042.GA169781@google.com>
 <20200626112931.GF4817@hirez.programming.kicks-ass.net>
 <20200722135542.41127cc4@oasis.local.home>
 <20200722184137.GP10769@hirez.programming.kicks-ass.net>
 <20200722150943.53046592@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722150943.53046592@oasis.local.home>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 22, 2020 at 03:09:43PM -0400, Steven Rostedt wrote:
> On Wed, 22 Jul 2020 20:41:37 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > That said, Andi Kleen added an option to gcc called -mnop-mcount which
> > > will have gcc do both create the mcount section and convert the calls
> > > into nops. When doing so, it defines CC_USING_NOP_MCOUNT which will
> > > tell ftrace to expect the calls to already be converted.  
> > 
> > That seems like the much easier solution, then we can forget about
> > recordmcount / objtool entirely for this.
> 
> Of course that was only for some gcc compilers, and I'm not sure if
> clang can do this.
> 
> Or do you just see all compilers doing this in the future, and not
> worrying about record-mcount at all, and bothering with objtool?

I got the GCC version wrong :/ Both -mnop-mcount and -mrecord-mcount
landed in GCC-5, where our minimum GCC is now at 4.9.

Anyway, what do you prefer, I suppose I can make objtool whatever we
need, that patch is trivial. Simply recording the sites and not
rewriting them should be simple enough.
