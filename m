Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7084A5937
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 10:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbiBAJc2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Feb 2022 04:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbiBAJc1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Feb 2022 04:32:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EBCC061714;
        Tue,  1 Feb 2022 01:32:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08D9BB82AD7;
        Tue,  1 Feb 2022 09:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE75DC36AE3;
        Tue,  1 Feb 2022 09:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643707944;
        bh=AX5somM9ZpbRE7b0I2Lmk0rkdReJYL8a9M+tig0TLFs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SSiLe4o9haMmIAkdRuEORI4WZaVph3IcGlXieSxr9iiRCK71b35eDd0Ex2kDLx929
         IID9As7MbUFVe75HVZD8cRhKQGbUKPNdrQsrzjg68Bj4iHO8Y8dQGY5wMrESbcMKcG
         wIH+uEcAudYv5cJxUnpsaulrXFa2qAdQEeOaLRCvFzcBSXZrpql9s1CP5I6WwXtf+i
         iZswmfWbcwra7QMIm92GR+qNtfd9XYT4X5LwjWjbc/sHJ6fZMuLcHO+BSi2U9xdhSg
         zpTfbEhKScjRD67LDb0d9dV7zryz522cy7tjLsxpmcYejPgeqjYA34ClgDZEyXfy77
         OfMFFt3ZJEjyQ==
Received: by mail-wr1-f41.google.com with SMTP id f17so30737724wrx.1;
        Tue, 01 Feb 2022 01:32:24 -0800 (PST)
X-Gm-Message-State: AOAM5303o761S63vFlCMMkTnNfe7rDH9CPAMnVj+8nYnkGMG3ioEdRKs
        rqGeI0yHy3i6Xk2tGcCKRyXqOrwTzUzglTJxfnE=
X-Google-Smtp-Source: ABdhPJwPbFQyADbHX6NBehgklXNB/sGBG6xqpbNp+H91J3tdwdx+DOF+NKX+twmrmAyYD4mXONWoLrvDT2Sy8/0OizE=
X-Received: by 2002:a05:6000:15ca:: with SMTP id y10mr20731709wry.417.1643707943102;
 Tue, 01 Feb 2022 01:32:23 -0800 (PST)
MIME-Version: 1.0
References: <20220131225250.409564-1-ndesaulniers@google.com>
In-Reply-To: <20220131225250.409564-1-ndesaulniers@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 1 Feb 2022 10:32:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHz9psgjP7qQpusLOOL5Nm7TO+LauD_-mK=Fxe_g7mmsQ@mail.gmail.com>
Message-ID: <CAMj1kXHz9psgjP7qQpusLOOL5Nm7TO+LauD_-mK=Fxe_g7mmsQ@mail.gmail.com>
Subject: Re: [PATCH] docs/memory-barriers.txt: volatile is not a barrier() substitute
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, llvm@lists.linux.dev,
        Kees Cook <keescook@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Len Baker <len.baker@gmx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 31 Jan 2022 at 23:53, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Add text to memory-barriers.txt and deprecated.rst to denote that
> volatile-qualifying an asm statement is not a substitute for either a
> compiler barrier (``barrier();``) or a clobber list.
>
> This way we can point to this in code that strengthens existing
> volatile-qualified asm statements to use a compiler barrier.
>
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Example: https://godbolt.org/z/8PW549zz9
>
>  Documentation/memory-barriers.txt    | 24 ++++++++++++++++++++++++
>  Documentation/process/deprecated.rst | 17 +++++++++++++++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index b12df9137e1c..f3908c0812da 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1726,6 +1726,30 @@ of optimizations:
>       respect the order in which the READ_ONCE()s and WRITE_ONCE()s occur,
>       though the CPU of course need not do so.
>
> + (*) Similarly, the compiler is within its rights to reorder instructions

Similar to what? Was this intended to be the second bullet point
rather than the first?

> +     around an asm statement so long as clobbers are not violated. For example,
> +
> +       asm volatile ("");
> +       flag = true;
> +
> +     May be modified by the compiler to:
> +
> +       flag = true;
> +       asm volatile ("");
> +
> +     Marking an asm statement as volatile is not a substitute for barrier(),
> +     and is implicit for asm goto statements and asm statements that do not
> +     have outputs (like the above example). Prefer either:
> +
> +       asm ("":::"memory");
> +       flag = true;
> +
> +     Or:
> +
> +       asm ("");
> +       barrier();
> +       flag = true;
> +

I would expect the memory clobber to only hazard against the
assignment of flag if it results in a store, but looking at your
Godbolt example, this appears to apply even if flag is kept in a
register.

Is that behavior documented/codified anywhere? Or are we relying on
compiler implementation details here?


>   (*) The compiler is within its rights to invent stores to a variable,
>       as in the following example:
>
> diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> index 388cb19f5dbb..432816e2f79e 100644
> --- a/Documentation/process/deprecated.rst
> +++ b/Documentation/process/deprecated.rst
> @@ -329,3 +329,20 @@ struct_size() and flex_array_size() helpers::
>          instance->count = count;
>
>          memcpy(instance->items, source, flex_array_size(instance, items, instance->count));
> +
> +Volatile Qualified asm Statements
> +=================================
> +
> +According to `the GCC docs on inline asm
> +https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Volatile`_:
> +
> +  asm statements that have no output operands and asm goto statements,
> +  are implicitly volatile.
> +
> +For many uses of asm statements, that means adding a volatile qualifier won't
> +hurt (making the implicit explicit), but it will not strengthen the semantics
> +for such cases where it would have been implied. Care should be taken not to
> +confuse ``volatile`` with the kernel's ``barrier()`` macro or an explicit
> +clobber list. See [memory-barriers]_ for more info on ``barrier()``.
> +
> +.. [memory-barriers] Documentation/memory-barriers.txt
> --
> 2.35.0.rc2.247.g8bbb082509-goog
>
