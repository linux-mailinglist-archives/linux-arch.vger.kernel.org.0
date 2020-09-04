Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF0F25D528
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 11:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgIDJcH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Sep 2020 05:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730031AbgIDJb2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Sep 2020 05:31:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE16C061245;
        Fri,  4 Sep 2020 02:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AmeBKqJuZ2TYIisYso2pvDzyPT9l4D3l0ti74pdTg0Q=; b=X6cu6bl5JfSrh+TTxe5dm2zPRs
        AiQRbmkSz8bxctpcVVoJUTd01rMGXmOZD1xc0lycH34bN7CSlyCqLAmrwqwCvYEoUSY+xKfGld4VF
        JCRTmA9yOGr8HSQxXZZp0fcn1pu0evfCQDOhepKW7Fvx2z1bnS0GryJLJoZGx3ZlwXYUUOxjPfb7o
        kNuyepr5MwWnzwadfXwDZlwm4lYlcJEpHE5ups2L1YChLhEQMmrIhMWEID06+tzQcEqI7jmdr7sob
        gpJDg9cOQ61U1G3nEJzIW6pFYKekrsm8QtKX7dNM5NR2hG8PpFQEbMW+z/TGELU/RTLT1iNbZlPUN
        SqJu+eqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kE83m-0006Ta-7X; Fri, 04 Sep 2020 09:31:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EA057305C11;
        Fri,  4 Sep 2020 11:31:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D727B214D7E3D; Fri,  4 Sep 2020 11:31:04 +0200 (CEST)
Date:   Fri, 4 Sep 2020 11:31:04 +0200
From:   peterz@infradead.org
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        X86 ML <x86@kernel.org>
Subject: Re: [PATCH v2 05/28] objtool: Add a pass for generating __mcount_loc
Message-ID: <20200904093104.GH1362448@hirez.programming.kicks-ass.net>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-6-samitolvanen@google.com>
 <202009031450.31C71DB@keescook>
 <CABCJKueF1RbpOKHsA8yS_yMujzHi8dzAVz8APwpMJyMTTGhmDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKueF1RbpOKHsA8yS_yMujzHi8dzAVz8APwpMJyMTTGhmDA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 03:03:30PM -0700, Sami Tolvanen wrote:
> On Thu, Sep 3, 2020 at 2:51 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Sep 03, 2020 at 01:30:30PM -0700, Sami Tolvanen wrote:
> > > From: Peter Zijlstra <peterz@infradead.org>
> > >
> > > Add the --mcount option for generating __mcount_loc sections
> > > needed for dynamic ftrace. Using this pass requires the kernel to
> > > be compiled with -mfentry and CC_USING_NOP_MCOUNT to be defined
> > > in Makefile.
> > >
> > > Link: https://lore.kernel.org/lkml/20200625200235.GQ4781@hirez.programming.kicks-ass.net/
> > > Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> >
> > Hmm, I'm not sure why this hasn't gotten picked up yet. Is this expected
> > to go through -tip or something else?
> 
> Note that I picked up this patch from Peter's original email, to which
> I included a link in the commit message, but it wasn't officially
> submitted as a patch. However, the previous discussion seems to have
> died, so I included the patch in this series, as it cleanly solves the
> problem of whitelisting non-call references to __fentry__. I was
> hoping for Peter and Steven to comment on how they prefer to proceed
> here.

Right; so I'm obviously fine with this patch and I suppose I can pick it
(and the next) into tip/objtool/core, provided Steve is okay with this
approach.
