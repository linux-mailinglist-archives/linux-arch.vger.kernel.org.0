Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8804209ABE
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jun 2020 09:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390439AbgFYHq2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Jun 2020 03:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390410AbgFYHq2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Jun 2020 03:46:28 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0F0C061573;
        Thu, 25 Jun 2020 00:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2aQ/V3CRB+JTPOL3qC/HxsWm+wJhkXGBtq9FiN50dxw=; b=MVs61XR8PHT2An2kAHFoVGpNaN
        L4hxfCHN0na+bXYcmoGM6fWmmaLm7d3p6PumUpigGZx4NET8Y22MadCNhuDD2tjz4bsAx+YeRr8US
        rO5Ph/sbzdu4v7rVC1aVaiLtBk178mbNOCE6uWemg8h/W8LV+TH9FVvH8ZqN2vdqTAt5dRcG3NIfV
        szFdqm0VJ59PkYZYpIY6zdlwCdeWCvhK56AovRtjFjyPn0yqF3yhfbzwmorhqV4KQ1ma6vlIdDuje
        xB9TwF6459hMixZkCdI6jdbxggiKReKLnIA3sI0gv2cMZe/rxoUPK9GVPLyTKxrBYihPvtqUYvTp7
        UeOTNh3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1joMZg-0007WT-Ba; Thu, 25 Jun 2020 07:45:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E3B15304BAE;
        Thu, 25 Jun 2020 09:45:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D836B203CDC50; Thu, 25 Jun 2020 09:45:30 +0200 (CEST)
Date:   Thu, 25 Jun 2020 09:45:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
        x86@kernel.org
Subject: Re: [PATCH 04/22] kbuild: lto: fix recordmcount
Message-ID: <20200625074530.GW4817@hirez.programming.kicks-ass.net>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-5-samitolvanen@google.com>
 <20200624212737.GV4817@hirez.programming.kicks-ass.net>
 <20200624214530.GA120457@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624214530.GA120457@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 02:45:30PM -0700, Sami Tolvanen wrote:
> On Wed, Jun 24, 2020 at 11:27:37PM +0200, Peter Zijlstra wrote:
> > On Wed, Jun 24, 2020 at 01:31:42PM -0700, Sami Tolvanen wrote:
> > > With LTO, LLVM bitcode won't be compiled into native code until
> > > modpost_link. This change postpones calls to recordmcount until after
> > > this step.
> > > 
> > > In order to exclude specific functions from inspection, we add a new
> > > code section .text..nomcount, which we tell recordmcount to ignore, and
> > > a __nomcount attribute for moving functions to this section.
> > 
> > I'm confused, you only add this to functions in ftrace itself, which is
> > compiled with:
> > 
> >  KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
> > 
> > and so should not have mcount/fentry sites anyway. So what's the point
> > of ignoring them further?
> > 
> > This Changelog does not explain.
> 
> Normally, recordmcount ignores each ftrace.o file, but since we are
> running it on vmlinux.o, we need another way to stop it from looking
> at references to mcount/fentry that are not calls. Here's a comment
> from recordmcount.c:
> 
>   /*
>    * The file kernel/trace/ftrace.o references the mcount
>    * function but does not call it. Since ftrace.o should
>    * not be traced anyway, we just skip it.
>    */
> 
> But I agree, the commit message could use more defails. Also +Steven
> for thoughts about this approach.

Ah, is thi because recordmcount isn't smart enough to know the
difference between "CALL $mcount" and any other RELA that has mcount?

At least for x86_64 I can do a really quick take for a recordmcount pass
in objtool, but I suppose you also need this for ARM64 ?
