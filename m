Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 098D4164972
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 17:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgBSQGQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 11:06:16 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33207 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgBSQGQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 11:06:16 -0500
Received: by mail-qk1-f196.google.com with SMTP id h4so616523qkm.0
        for <linux-arch@vger.kernel.org>; Wed, 19 Feb 2020 08:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uhi4M2kPWQtaIRnOkT6OXlV4BqN3p0xNbs1d1Zj15X4=;
        b=GzyOGDrLJcrnBQcUrMZ80TNTzBtWlzRzPrxkmbjiOI9pC2KwTjzcOREsMyKigWJ46k
         /RHX7Ks1BbOR0ASTgNB0dYUdDf2zljHrcYOi68tPDKZwWjlI0cFSNKS19kPxsw1U4Yfv
         fn15eOQ6IMYDNr+QBSGrSbP12JRmpJH2SpdRMxVEdtj94dMp3AbFxCsie6a9iHut/SmM
         VLnezzpNvZdCneLOaNK1j4JxsbwDh+L1v4FMD6/2n/DOKQci2klhRiRDT8jUVLd1a7lo
         TxcgdveImX3ek4L6a9XGMxzxqBbo40lOzueSI2tXN2X/gaHRmOrxyXPBydJJeI6602Sr
         ycbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uhi4M2kPWQtaIRnOkT6OXlV4BqN3p0xNbs1d1Zj15X4=;
        b=gddDg5TScaJjD2eScvKZtHWox2jCdUJvUUaBSx07U/VNksPrBjCmPAORCyh/TGUYce
         hhdbZU38pmdLDBovXvmj5Y2ziRp+PC9IXM11dGhVpalt25mxD276qQhG5GMtGDvmUKPm
         bL0vCdbpxJc9Z39XX398KOOLCtpNKe64PykdP025I8Te1IAJz/sIwJd9JcKEVDuLUs/1
         hEP4bWbw37Bllkh9Qyw2i18D+AWbt2ewpoc9YAHPB3UpEYMe31KKEAsMdDwSnTJGZ5Si
         IAxFo4MyOPN3CDw9ilm6KlZNJZ24Evzo3KK0ubEyhwcK1kefSSLmYfS6vHq0XRd0Lv25
         pdxw==
X-Gm-Message-State: APjAAAX24P+p1wBTo6EzLt7P2UMNLXOx20m2KkEa2RM3DNU4IsiS1pF8
        iFCORcnLv3xzTA77x9ShzLCaVK8f4N/KnMxG1aekdg==
X-Google-Smtp-Source: APXvYqwmcJfosb6qUJENX6YBHKmF0qqo2wR0Ifv8vS768JwiEr/utEMlU+l0aopgtrUhlEtfOf9MxSCQ+2t2drIetCY=
X-Received: by 2002:a05:620a:150a:: with SMTP id i10mr2031290qkk.407.1582128375013;
 Wed, 19 Feb 2020 08:06:15 -0800 (PST)
MIME-Version: 1.0
References: <20200219144724.800607165@infradead.org> <20200219150745.651901321@infradead.org>
In-Reply-To: <20200219150745.651901321@infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 19 Feb 2020 17:06:03 +0100
Message-ID: <CACT4Y+Y+nPcnbb8nXGQA1=9p8BQYrnzab_4SvuPwbAJkTGgKOQ@mail.gmail.com>
Subject: Re: [PATCH v3 22/22] x86/int3: Ensure that poke_int3_handler() is not sanitized
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andy Lutomirski <luto@kernel.org>, tony.luck@intel.com,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 4:14 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> In order to ensure poke_int3_handler() is completely self contained --
> we call this while we're modifying other text, imagine the fun of
> hitting another INT3 -- ensure that everything is without sanitize
> crud.

+kasan-dev

Hi Peter,

How do we hit another INT3 here? Does the code do
out-of-bounds/use-after-free writes?
Debugging later silent memory corruption may be no less fun :)

Not sanitizing bsearch entirely is a bit unfortunate. We won't find
any bugs in it when called from other sites too.
It may deserve a comment at least. Tomorrow I may want to remove
__no_sanitize, just because sanitizing more is better, and no int3
test will fail to stop me from doing that...

It's quite fragile. Tomorrow poke_int3_handler handler calls more of
fewer functions, and both ways it's not detected by anything. And if
we ignore all by one function, it is still not helpful, right?
Depending on failure cause/mode, using kasan_disable/enable_current
may be a better option.


> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/alternative.c       |    4 ++--
>  arch/x86/kernel/traps.c             |    2 +-
>  include/linux/compiler-clang.h      |    7 +++++++
>  include/linux/compiler-gcc.h        |    6 ++++++
>  include/linux/compiler.h            |    5 +++++
>  include/linux/compiler_attributes.h |    1 +
>  lib/bsearch.c                       |    2 +-
>  7 files changed, 23 insertions(+), 4 deletions(-)
>
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -979,7 +979,7 @@ static __always_inline void *text_poke_a
>         return _stext + tp->rel_addr;
>  }
>
> -static int notrace patch_cmp(const void *key, const void *elt)
> +static int notrace __no_sanitize patch_cmp(const void *key, const void *elt)
>  {
>         struct text_poke_loc *tp = (struct text_poke_loc *) elt;
>
> @@ -991,7 +991,7 @@ static int notrace patch_cmp(const void
>  }
>  NOKPROBE_SYMBOL(patch_cmp);
>
> -int notrace poke_int3_handler(struct pt_regs *regs)
> +int notrace __no_sanitize poke_int3_handler(struct pt_regs *regs)
>  {
>         struct bp_patching_desc *desc;
>         struct text_poke_loc *tp;
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -496,7 +496,7 @@ dotraplinkage void do_general_protection
>  }
>  NOKPROBE_SYMBOL(do_general_protection);
>
> -dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
> +dotraplinkage void notrace __no_sanitize do_int3(struct pt_regs *regs, long error_code)
>  {
>         if (poke_int3_handler(regs))
>                 return;
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -24,6 +24,13 @@
>  #define __no_sanitize_address
>  #endif
>
> +#if __has_feature(undefined_sanitizer)
> +#define __no_sanitize_undefined \
> +               __atribute__((no_sanitize("undefined")))
> +#else
> +#define __no_sanitize_undefined
> +#endif
> +
>  /*
>   * Not all versions of clang implement the the type-generic versions
>   * of the builtin overflow checkers. Fortunately, clang implements
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -145,6 +145,12 @@
>  #define __no_sanitize_address
>  #endif
>
> +#if __has_attribute(__no_sanitize_undefined__)
> +#define __no_sanitize_undefined __attribute__((no_sanitize_undefined))
> +#else
> +#define __no_sanitize_undefined
> +#endif
> +
>  #if GCC_VERSION >= 50100
>  #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
>  #endif
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -199,6 +199,7 @@ void __read_once_size(const volatile voi
>         __READ_ONCE_SIZE;
>  }
>
> +#define __no_kasan __no_sanitize_address
>  #ifdef CONFIG_KASAN
>  /*
>   * We can't declare function 'inline' because __no_sanitize_address confilcts
> @@ -274,6 +275,10 @@ static __always_inline void __write_once
>   */
>  #define READ_ONCE_NOCHECK(x) __READ_ONCE(x, 0)
>
> +#define __no_ubsan __no_sanitize_undefined
> +
> +#define __no_sanitize __no_kasan __no_ubsan
> +
>  static __no_kasan_or_inline
>  unsigned long read_word_at_a_time(const void *addr)
>  {
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -41,6 +41,7 @@
>  # define __GCC4_has_attribute___nonstring__           0
>  # define __GCC4_has_attribute___no_sanitize_address__ (__GNUC_MINOR__ >= 8)
>  # define __GCC4_has_attribute___fallthrough__         0
> +# define __GCC4_has_attribute___no_sanitize_undefined__ (__GNUC_MINOR__ >= 9)
>  #endif
>
>  /*
> --- a/lib/bsearch.c
> +++ b/lib/bsearch.c
> @@ -28,7 +28,7 @@
>   * the key and elements in the array are of the same type, you can use
>   * the same comparison function for both sort() and bsearch().
>   */
> -void *bsearch(const void *key, const void *base, size_t num, size_t size,
> +void __no_sanitize *bsearch(const void *key, const void *base, size_t num, size_t size,
>               cmp_func_t cmp)
>  {
>         const char *pivot;
>
>
