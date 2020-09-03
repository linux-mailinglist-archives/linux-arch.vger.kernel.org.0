Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604A725CC9B
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 23:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgICVr3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 17:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbgICVr0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 17:47:26 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF95C061245
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 14:47:26 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v15so3172039pgh.6
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 14:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sW3+i9jb9GQGw/rihL3rmHov3DBg+oJBsubVzV/94sk=;
        b=dNJhSL8+ekFbBcMLYdOiVh2ALsNUoTTm1VSxi4CeqOTnyYIMwnEHHJ7S/BtXgtuNOk
         9HqSyGbwVU8WVdgO3Jvvq84XO+8XGzQl7x2oGWzDQCtlULUhdTtXclp3ZyOgcr4wIXRy
         ix3S72ob+JcdrTSNj6CS0A74L/1LVWKFX9qdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sW3+i9jb9GQGw/rihL3rmHov3DBg+oJBsubVzV/94sk=;
        b=Z+h9edynnTcQRvIbMNQXzsbeT+UsC1q1pSEMkNSBr2MGRLTRZAkHMSriRRqLO5SRF7
         N0psYYdJCJCk82Kv67pj6SD04tDqUE6uXbV2+3nFVrzvSBMNLe8JIQp2UdlHvQtj5vCC
         GuJgipV58YvyTL4HaUx2Q7Yt0jcZhG5Ox1FL9xmtdhg5chIsXDDqg/Rj1eO9iiuekyvt
         7us4IObNeD/wf+13T1pyxyvW8KKrowzl/70pSmEtHBF2dsqVPnsrOcoczwNkLLXQjEAs
         IRnMFrUHXrNu17CHPwG/rbz06Q9lgMIBrVWx27GcNNpPTGNuLozYn8Ks34HmzykqVwmi
         QYVA==
X-Gm-Message-State: AOAM5334OeKAhhaK3rXQNqE3m+JXHKpDXPQ3aIMKeoaerCknPIgn95UQ
        EmZWs7LJwlQETl3bX//7mzMzAQ==
X-Google-Smtp-Source: ABdhPJxA6AeZszGsabAFYmE7VAtam1/8zONcRaynFdaMlGHOxLgKqDQnRgIOet6kCjwYkvC+MGEMtQ==
X-Received: by 2002:a63:e157:: with SMTP id h23mr4839131pgk.239.1599169646252;
        Thu, 03 Sep 2020 14:47:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e1sm3391485pjv.17.2020.09.03.14.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 14:47:25 -0700 (PDT)
Date:   Thu, 3 Sep 2020 14:47:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2 03/28] lib/string.c: implement stpcpy
Message-ID: <202009031446.3865FE82B@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-4-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-4-samitolvanen@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:28PM -0700, Sami Tolvanen wrote:
> From: Nick Desaulniers <ndesaulniers@google.com>
> 
> LLVM implemented a recent "libcall optimization" that lowers calls to
> `sprintf(dest, "%s", str)` where the return value is used to
> `stpcpy(dest, str) - dest`. This generally avoids the machinery involved
> in parsing format strings.  `stpcpy` is just like `strcpy` except it
> returns the pointer to the new tail of `dest`.  This optimization was
> introduced into clang-12.
> 
> Implement this so that we don't observe linkage failures due to missing
> symbol definitions for `stpcpy`.
> 
> Similar to last year's fire drill with:
> commit 5f074f3e192f ("lib/string.c: implement a basic bcmp")
> 
> The kernel is somewhere between a "freestanding" environment (no full libc)
> and "hosted" environment (many symbols from libc exist with the same
> type, function signature, and semantics).
> 
> As H. Peter Anvin notes, there's not really a great way to inform the
> compiler that you're targeting a freestanding environment but would like
> to opt-in to some libcall optimizations (see pr/47280 below), rather than
> opt-out.
> 
> Arvind notes, -fno-builtin-* behaves slightly differently between GCC
> and Clang, and Clang is missing many __builtin_* definitions, which I
> consider a bug in Clang and am working on fixing.
> 
> Masahiro summarizes the subtle distinction between compilers justly:
>   To prevent transformation from foo() into bar(), there are two ways in
>   Clang to do that; -fno-builtin-foo, and -fno-builtin-bar.  There is
>   only one in GCC; -fno-buitin-foo.
> 
> (Any difference in that behavior in Clang is likely a bug from a missing
> __builtin_* definition.)
> 
> Masahiro also notes:
>   We want to disable optimization from foo() to bar(),
>   but we may still benefit from the optimization from
>   foo() into something else. If GCC implements the same transform, we
>   would run into a problem because it is not -fno-builtin-bar, but
>   -fno-builtin-foo that disables that optimization.
> 
>   In this regard, -fno-builtin-foo would be more future-proof than
>   -fno-built-bar, but -fno-builtin-foo is still potentially overkill. We
>   may want to prevent calls from foo() being optimized into calls to
>   bar(), but we still may want other optimization on calls to foo().
> 
> It seems that compilers today don't quite provide the fine grain control
> over which libcall optimizations pseudo-freestanding environments would
> prefer.
> 
> Finally, Kees notes that this interface is unsafe, so we should not
> encourage its use.  As such, I've removed the declaration from any
> header, but it still needs to be exported to avoid linkage errors in
> modules.
> 
> Reported-by: Sami Tolvanen <samitolvanen@google.com>
> Suggested-by: Andy Lavr <andy.lavr@gmail.com>
> Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> Suggested-by: Joe Perches <joe@perches.com>
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

As you mentioned, this is in -next already (via -mm). I think I sent a
tag for this before, but maybe akpm missed it, so for good measure:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
