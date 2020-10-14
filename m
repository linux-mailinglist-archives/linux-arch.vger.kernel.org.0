Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6C128E4CE
	for <lists+linux-arch@lfdr.de>; Wed, 14 Oct 2020 18:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbgJNQuJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Oct 2020 12:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbgJNQuJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Oct 2020 12:50:09 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50142C061755;
        Wed, 14 Oct 2020 09:50:08 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dt13so5758330ejb.12;
        Wed, 14 Oct 2020 09:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+kKooy8y3/ieceX7ZqDJ+1+nZaa9FZpK4qlfOAJ4xg4=;
        b=q+bPhxgYA+ZTPkLdf43AbfDU/NVUXp5l+vHvOvwwCnu8EDI0ZTBBe5x7CS7iqFgW6U
         RPKNLv5TazIRXEB8zpXJfYYNIb0vbS++16n0Vl70eRtBPcT0r/UwvHw/ZjW87DDaUfSx
         +Xd0/NTf1ApzUVFxGl+8MloHTritdnRiWIjqML6JVm6nZY9VgaoijQM+t1N7K/GhHURP
         NkTvh6uJwsD2wsYWhoNFsSwxTukwKXmEPyAzgpia3QQ/t+EzYmGkVMjooaxT9iBZyUhX
         VeofVZViwdeEOym4e9lpV9fWnoiFgWXqxdPZT/fx4VJS8nzxptdXq5xzDzIorjQDqzDq
         iifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+kKooy8y3/ieceX7ZqDJ+1+nZaa9FZpK4qlfOAJ4xg4=;
        b=N6s8FxpV/uBCy0lEPmHWjyvVxw+CgLcqKjBU/ZOG3pFCtW/kAfLHT/t4xJe4eSFxBP
         G9YJYuhECXMoivy1Sn3e2bxc/0JLeqGjx1eRXRSz6XDwBS4XY1KGcPvixDZDXf8dytEh
         Hi1kaz3hGumG1SqmK3oi76YZmIPFlEiqKhMFkLyX14CEiYbhxqyBVjcdeKYMFtIRQMwq
         TiNNc9Lyp1Au6ssmJRZQZiA9BDQJKjhQTtStwjxgxx654GJQQSSdyG3gCi7BsumkQ8Bs
         ogyPdFsdPnqur9BC7Z1zpwTB3RpqcHaWDmXr951Z0ZQAeIDC/AGX+9AP7+jsgayja1IB
         YM/w==
X-Gm-Message-State: AOAM5304db6T0ABBuYRRGW3+wE0HtSo7ieCBc3Fz7lzPIzF1dExqb7PR
        5+izUCrdy/OroHruAW9dA/w=
X-Google-Smtp-Source: ABdhPJxnZz/JvSQgt+bP4GraqaDvLe+xrlEutFj8lORQJcvNdI3kXKHdjhRXRnIr61+pk7L2rCm3hg==
X-Received: by 2002:a17:907:43ed:: with SMTP id ol21mr6121680ejb.279.1602694207048;
        Wed, 14 Oct 2020 09:50:07 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id c19sm44446edt.48.2020.10.14.09.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 09:50:06 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 14 Oct 2020 18:50:04 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v6 02/25] objtool: Add a pass for generating __mcount_loc
Message-ID: <20201014165004.GA3593121@gmail.com>
References: <20201013003203.4168817-1-samitolvanen@google.com>
 <20201013003203.4168817-3-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013003203.4168817-3-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Sami Tolvanen <samitolvanen@google.com> wrote:

> From: Peter Zijlstra <peterz@infradead.org>
> 
> Add the --mcount option for generating __mcount_loc sections
> needed for dynamic ftrace. Using this pass requires the kernel to
> be compiled with -mfentry and CC_USING_NOP_MCOUNT to be defined
> in Makefile.
> 
> Link: https://lore.kernel.org/lkml/20200625200235.GQ4781@hirez.programming.kicks-ass.net/
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> [Sami: rebased, dropped config changes, fixed to actually use --mcount,
>        and wrote a commit message.]
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  tools/objtool/builtin-check.c |  3 +-
>  tools/objtool/builtin.h       |  2 +-
>  tools/objtool/check.c         | 82 +++++++++++++++++++++++++++++++++++
>  tools/objtool/check.h         |  1 +
>  tools/objtool/objtool.c       |  1 +
>  tools/objtool/objtool.h       |  1 +
>  6 files changed, 88 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
> index c6d199bfd0ae..e92e76f69176 100644
> --- a/tools/objtool/builtin-check.c
> +++ b/tools/objtool/builtin-check.c
> @@ -18,7 +18,7 @@
>  #include "builtin.h"
>  #include "objtool.h"
>  
> -bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux;
> +bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux, mcount;
>  
>  static const char * const check_usage[] = {
>  	"objtool check [<options>] file.o",
> @@ -35,6 +35,7 @@ const struct option check_options[] = {
>  	OPT_BOOLEAN('s', "stats", &stats, "print statistics"),
>  	OPT_BOOLEAN('d', "duplicate", &validate_dup, "duplicate validation for vmlinux.o"),
>  	OPT_BOOLEAN('l', "vmlinux", &vmlinux, "vmlinux.o validation"),
> +	OPT_BOOLEAN('M', "mcount", &mcount, "generate __mcount_loc"),
>  	OPT_END(),
>  };

Meh, adding --mcount as an option to 'objtool check' was a valid hack for a 
prototype patchset, but please turn this into a proper subcommand, just 
like 'objtool orc' is.

'objtool check' should ... keep checking. :-)

Thanks,

	Ingo
