Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300A2229F65
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 20:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgGVSmH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 14:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgGVSmG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 14:42:06 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66197C0619DC;
        Wed, 22 Jul 2020 11:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DqMZf+NKxev5DHoTyVPRSIfA19GkA4kV6jf4PNYb+Nw=; b=f2QZ2qtibGlJEp42Nw1cOpOp54
        xbjG6CyuAnifkHhoaLv3ELLYaPI+boJBEqUHwPU8IRo3DgqZB0dDkl95wHJ3Axyeoto9wfj7/AslF
        9aPPV/YLLSrMT4llswvO23XJiYK29HD1OetvJXWSZcPxxR+MdkO8QvG++Vlqc/nBAoJhsojJbIiHo
        SI/70lKuy3BslY5UiNJn0bADWU41eswtFmSrIoBoLcUK+SyrYfBMQ5U6RrsOJxJAMH0reIgx8ltdR
        3ypKp2jtlWDYKldYYGBc79YEfFgyCydN57+ohspjNE9DQ9wgkd6pv9IRLS98rE9bYGad90A2JdWZ2
        ZzlpB7wg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyJgU-0002Lw-27; Wed, 22 Jul 2020 18:41:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AD0533006D0;
        Wed, 22 Jul 2020 20:41:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 96CE828B5B17B; Wed, 22 Jul 2020 20:41:37 +0200 (CEST)
Date:   Wed, 22 Jul 2020 20:41:37 +0200
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
        x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        mhelsley@vmware.com
Subject: Re: [RFC][PATCH] objtool,x86_64: Replace recordmcount with objtool
Message-ID: <20200722184137.GP10769@hirez.programming.kicks-ass.net>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-5-samitolvanen@google.com>
 <20200624212737.GV4817@hirez.programming.kicks-ass.net>
 <20200624214530.GA120457@google.com>
 <20200625074530.GW4817@hirez.programming.kicks-ass.net>
 <20200625161503.GB173089@google.com>
 <20200625200235.GQ4781@hirez.programming.kicks-ass.net>
 <20200625224042.GA169781@google.com>
 <20200626112931.GF4817@hirez.programming.kicks-ass.net>
 <20200722135542.41127cc4@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722135542.41127cc4@oasis.local.home>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 22, 2020 at 01:55:42PM -0400, Steven Rostedt wrote:

> > Ha! it is trying to convert the "CALL __fentry__" into a NOP and not
> > finding the CALL -- because objtool already made it a NOP...
> > 
> > Weird, I thought recordmcount would also write NOPs, it certainly has
> > code for that. I suppose we can use CC_USING_NOP_MCOUNT to avoid those,
> > but I'd rather Steve explain this before I wreck things further.
> 
> The reason for not having recordmcount insert all the nops, is because
> x86 has more than one optimal nop which is determined by the machine it
> runs on, and not at compile time. So we figured just updated it then.
> 
> We can change it to be a nop on boot, and just modify it if it's not
> the optimal nop already. 

Right, I throught that's what we'd be doing already, anyway:

> That said, Andi Kleen added an option to gcc called -mnop-mcount which
> will have gcc do both create the mcount section and convert the calls
> into nops. When doing so, it defines CC_USING_NOP_MCOUNT which will
> tell ftrace to expect the calls to already be converted.

That seems like the much easier solution, then we can forget about
recordmcount / objtool entirely for this.
