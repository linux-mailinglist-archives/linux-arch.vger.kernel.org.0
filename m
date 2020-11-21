Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04D82BC1FF
	for <lists+linux-arch@lfdr.de>; Sat, 21 Nov 2020 21:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgKUULb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Nov 2020 15:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbgKUUL3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 Nov 2020 15:11:29 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC85C0613CF
        for <linux-arch@vger.kernel.org>; Sat, 21 Nov 2020 12:11:28 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id b6so720658pfp.7
        for <linux-arch@vger.kernel.org>; Sat, 21 Nov 2020 12:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2E/G1+BC++eqc5/VVuVWg3zAaLSLEIJOC7i/xjg7VSs=;
        b=d6GrwcPvUVOPqv9gOqNrM/bSP2HBSSL4qRmWjJIA4m3hlxWzzEj5T+lfuVhxoorPwR
         NB2BxSopAcepiomrLE56aIQhqr6iGtiFG6DXeV6iIvBvUM0uetc94YKKaGPVURg9KuKK
         wPaVmZ+dITTlnTfMDAnpXhgP+pbbnBqLxnBaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2E/G1+BC++eqc5/VVuVWg3zAaLSLEIJOC7i/xjg7VSs=;
        b=JpzOA3qxW3tn0C3csBhU2jBwQVhnATblwopUyG+RA0KQ+FR6GrG0pNpTuFtwT8Dfg2
         2DXubgjnEhyBRR5fIqpmpOyyDpiRLneGvWJxWfac7LwTSsIo/+DPyWUgNRXFvcRw5s6Y
         nI05BYl24CEhXteJVOo4DDL366e90qnKW5A1j08rateJlGUhrj4wnxoQngZyjYIrLWE7
         okbrfeBHPm0FfqBFzWXiz/qGrWyRhPsnNxXutXglPXgsCGqaWgiTN2reg6d1N0m8AG9Q
         8zM9sVlLPUg6zi3iekLONXgY037tsg8+aLVDwGtbfSJF4GILUO0/tV4WFTjAtRVcNADQ
         aBiQ==
X-Gm-Message-State: AOAM532AiwXjm3j2K2RLAbNjwPSpln894E5WJxAfIijoFYGhoIN0WKFy
        1k3DXMPiukxmamJ7Ng/tqNLzcg==
X-Google-Smtp-Source: ABdhPJxD+jcfx423cWLQ4O6Da2CSyrYt2pnWQlkBVEKwXqI/6a+7t8fMpRLZBlqwuFIT6m30Fbuv4Q==
X-Received: by 2002:a17:90a:f406:: with SMTP id ch6mr15105294pjb.134.1605989487549;
        Sat, 21 Nov 2020 12:11:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y10sm8724624pjm.34.2020.11.21.12.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 12:11:26 -0800 (PST)
Date:   Sat, 21 Nov 2020 12:11:25 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 02/17] kbuild: add support for Clang LTO
Message-ID: <202011211204.211E2B12@keescook>
References: <20201118220731.925424-1-samitolvanen@google.com>
 <20201118220731.925424-3-samitolvanen@google.com>
 <CAKwvOdnYTMzaahnBqdNYPz3KMdnkp=jZ4hxiqkTYzM5+BBdezA@mail.gmail.com>
 <CABCJKucj_jUwoiLc35R7qFe+cNKTWgT+gsCa5pPiY66+1--3Lg@mail.gmail.com>
 <202011201144.3F2BB70C@keescook>
 <20201120202935.GA1220359@ubuntu-m3-large-x86>
 <202011201241.B159562D7@keescook>
 <CABCJKucJ87wa73YJkN_dYUyE7foQT+12gdWJZw1PgZ_decFr4w@mail.gmail.com>
 <202011201556.3B910EF@keescook>
 <CABCJKudy5xFfjBFpFPR255-NAb1yOSuVqsL4fFUwJGGWKDnmQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKudy5xFfjBFpFPR255-NAb1yOSuVqsL4fFUwJGGWKDnmQQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 20, 2020 at 05:46:44PM -0800, Sami Tolvanen wrote:
> Sure, this looks good to me, I'll use this in v8. The only minor
> concern I have is that ThinLTO cannot be set as the default LTO mode,
> but I assume anyone who selects LTO is also capable of deciding which
> mode is better for them.

It could be re-arranged similar to what you had before, but like:

config LTO
	bool "..."
	depends on HAS_LTO
	help
	  ...

choice
	prompt "LTO mode" if LTO
	default LTO_GCC if HAS_LTO_GCC
	default LTO_CLANG_THIN if HAS_LTO_CLANG
	default LTO_CLANG_FULL
	help
	  ...

	config LTO_CLANG_THIN
	...

	config LTO_CLANG_FULL
endchoice

Then the LTO is top-level yes/no, but depends on detected capabilities,
and the mode is visible if LTO is chosen, etc.

I'm not really sure which is better...

> > +config LTO_CLANG_THIN
> > +       bool "Clang ThinLTO (EXPERIMENTAL)"
> > +       depends on ARCH_SUPPORTS_LTO_CLANG_THIN
> > +       select LTO_CLANG
> > +       help
> > +         This option enables Clang's ThinLTO, which allows for parallel
> > +         optimization and faster incremental compiles compared to the
> > +         CONFIG_LTO_CLANG_FULL option. More information can be found
> > +         from Clang's documentation:
> > +
> > +           https://clang.llvm.org/docs/ThinLTO.html
> > +
> > +         If unsure, say Y.
> >  endchoice
> 
> The two LTO_CLANG_* options need to depend on HAS_LTO_CLANG, of course.

Whoops, yes. Thanks for catching that. :)

-- 
Kees Cook
