Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D04820A2C4
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jun 2020 18:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390750AbgFYQWf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Jun 2020 12:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389522AbgFYQWe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Jun 2020 12:22:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDEDC08C5C1
        for <linux-arch@vger.kernel.org>; Thu, 25 Jun 2020 09:22:34 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so547406pgf.0
        for <linux-arch@vger.kernel.org>; Thu, 25 Jun 2020 09:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cYEaM8fKpZG71PCkfHkApRmPtCwvXrrY+JocHC3nIv8=;
        b=XvqTcKvUnBqjH+Xq2/BDnD76lMTzDE39N73VPsal3e7jDR5L9CqPzEwi/HtJXxg5pZ
         sSViKozmxlxfRjR5junnpvtTtyW6G2rRQEW8ZFvCQk6aCeqvQ+zuO9yimSN9sFS7QooW
         PvXgArAb+SfCZcIY+Pqu9KdLFcAqo8UvqBCXGiy9t48Z69ZF5FReGe2odlppsG/6UARl
         Mdd0bQaWJWxZe0j9OL67jRPrRKjRhuCt16S32a8eOmCrvrHTXERopZ1dh0M2Ua2NwCSI
         Ek6M040jALm4P02V4qkx9xuhsfQb+UTvzenYTCIy4JIByKPSb7KkGeYN6II1dO0BKO5s
         5Xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cYEaM8fKpZG71PCkfHkApRmPtCwvXrrY+JocHC3nIv8=;
        b=HCCMQSP2PZIpg7PzJ2zwyRaW7wj2WTwqre67WFMiiv7slENAt3OsXaY0Eowl9K4MYn
         cDyuzwCUpdKwbg5D01Gt9E3Peczs/kUYZy9S11LhGv8fIgrbHU6oXpBxe7+ZhgLJSBEQ
         Gw/R6AefmgmUsrmcn3ifKdBwznRPlo31oPwmlkq7Ni5kNa42E4yM7mM4ts+Qxa+lQRej
         RmoF6+aSTOSXCQgpK8psqub/3P62Q4i+HyHntgzNSv7agjkSZWR17dmN0t6ZynXxSRIx
         ana/NJYev3rU0LLzitVj3ZOs4egQ3Rei4Ew0cBtoKk1AJidhlozR18+E28CytTKbKw0P
         DFeQ==
X-Gm-Message-State: AOAM532e1hZBuSrgED1xqVol0vDU//WY/zidz8ix+ZFfb5DsvqLciJol
        b61rwvMgw6uHmvfzkjjRn2BlPw==
X-Google-Smtp-Source: ABdhPJyBu5UBNmD93hBhA1nGG7iT9G95iHuvLnDzS07QCS69km8HMKCSBSO/u5bBKV8BF6Gd+7YLGw==
X-Received: by 2002:a63:7313:: with SMTP id o19mr27664372pgc.307.1593102153849;
        Thu, 25 Jun 2020 09:22:33 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id 7sm10151225pgh.80.2020.06.25.09.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:22:32 -0700 (PDT)
Date:   Thu, 25 Jun 2020 09:22:26 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
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
Subject: Re: [PATCH 05/22] kbuild: lto: postpone objtool
Message-ID: <20200625162226.GC173089@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-6-samitolvanen@google.com>
 <20200624211908.GT4817@hirez.programming.kicks-ass.net>
 <20200624214925.GB120457@google.com>
 <20200625074716.GX4817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625074716.GX4817@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 25, 2020 at 09:47:16AM +0200, Peter Zijlstra wrote:
> On Wed, Jun 24, 2020 at 02:49:25PM -0700, Sami Tolvanen wrote:
> > On Wed, Jun 24, 2020 at 11:19:08PM +0200, Peter Zijlstra wrote:
> > > On Wed, Jun 24, 2020 at 01:31:43PM -0700, Sami Tolvanen wrote:
> > > > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > > > index 30827f82ad62..12b115152532 100644
> > > > --- a/include/linux/compiler.h
> > > > +++ b/include/linux/compiler.h
> > > > @@ -120,7 +120,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> > > >  /* Annotate a C jump table to allow objtool to follow the code flow */
> > > >  #define __annotate_jump_table __section(.rodata..c_jump_table)
> > > >  
> > > > -#ifdef CONFIG_DEBUG_ENTRY
> > > > +#if defined(CONFIG_DEBUG_ENTRY) || defined(CONFIG_LTO_CLANG)
> > > >  /* Begin/end of an instrumentation safe region */
> > > >  #define instrumentation_begin() ({					\
> > > >  	asm volatile("%c0:\n\t"						\
> > > 
> > > Why would you be doing noinstr validation for lto builds? That doesn't
> > > make sense.
> > 
> > This is just to avoid a ton of noinstr warnings when we run objtool on
> > vmlinux.o, but I'm also fine with skipping noinstr validation with LTO.
> 
> Right, then we need to make --no-vmlinux work properly when
> !DEBUG_ENTRY, which I think might be buggered due to us overriding the
> argument when the objname ends with "vmlinux.o".

Right. Can we just remove that and  pass --vmlinux to objtool in
link-vmlinux.sh, or is the override necessary somewhere else?

> > > > +ifdef CONFIG_STACK_VALIDATION
> > > > +ifneq ($(SKIP_STACK_VALIDATION),1)
> > > > +cmd_ld_ko_o +=								\
> > > > +	$(objtree)/tools/objtool/objtool				\
> > > > +		$(if $(CONFIG_UNWINDER_ORC),orc generate,check)		\
> > > > +		--module						\
> > > > +		$(if $(CONFIG_FRAME_POINTER),,--no-fp)			\
> > > > +		$(if $(CONFIG_GCOV_KERNEL),--no-unreachable,)		\
> > > > +		$(if $(CONFIG_RETPOLINE),--retpoline,)			\
> > > > +		$(if $(CONFIG_X86_SMAP),--uaccess,)			\
> > > > +		$(@:.ko=$(prelink-ext).o);
> > > > +
> > > > +endif # SKIP_STACK_VALIDATION
> > > > +endif # CONFIG_STACK_VALIDATION
> > > 
> > > What about the objtool invocation from link-vmlinux.sh ?
> > 
> > What about it? The existing objtool_link invocation in link-vmlinux.sh
> > works fine for our purposes as well.
> 
> Well, I was wondering why you're adding yet another objtool invocation
> while we already have one.

Because we can't run objtool until we have compiled bitcode to native
code, so for modules, we're need another invocation after everything has
been compiled.

Sami
