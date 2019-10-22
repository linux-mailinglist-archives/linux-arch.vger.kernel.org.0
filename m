Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3EA9E031A
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2019 13:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388703AbfJVLit (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Oct 2019 07:38:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36267 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387871AbfJVLit (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Oct 2019 07:38:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id c22so6714417wmd.1;
        Tue, 22 Oct 2019 04:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=H4XHYqow4rWm5szIAWV5ylZxrQNb9J+QDV/Ex9kAv0Y=;
        b=SgD20YDE+/6l37I1jIjKBbZoFyZfhe6b58UML64rAMe89hiiS5XRewxX22ywknxOky
         YMlXK5T5On7UbqekNwOAj9/jhUfDN0juJIlkoay+Hfc3pkeXWknc4Zy4N+EuPun6MxXp
         j3zS5q5gskdoATj7AlD7hGcNzH7JWsjLHd/JXc+7R46fJAyuCtoFIaBHj1j8te4bqVNt
         38ZsMmqo+nuW7fVgXALpFmhytczXBxY0rnsCECw2vzbOMZYaNqHhSoK+R0lyvq11Tldw
         5HSFjEUd8YxwykdlDL25pgsBw0LhKaX3B7krv/wAsDPL2G/zJUZh+asgYDReS+i8EgfA
         tuiQ==
X-Gm-Message-State: APjAAAXbANpAsvmThuAgtkMeU3kNusz5jyeGY72W2l0YNuRkmIhLUY77
        ZXhPFs7P0D0OFoU1DRzX7Mw=
X-Google-Smtp-Source: APXvYqzWW8cBeW5KJZJ14BkS8q1bBVAJppXvnNoimiMDRZ/j4pBjN2CJfQ/+9cvDjRSx1A80au14AQ==
X-Received: by 2002:a1c:1a4b:: with SMTP id a72mr2609572wma.17.1571744325690;
        Tue, 22 Oct 2019 04:38:45 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id l18sm16340820wrc.18.2019.10.22.04.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2019 04:38:44 -0700 (PDT)
Subject: Re: [PATCH] x86/ftrace: Get rid of function_hook
To:     Borislav Petkov <bp@alien8.de>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     tip-bot2 for Jiri Slaby <tip-bot2@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-arch@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
References: <20191011115108.12392-22-jslaby@suse.cz>
 <157141622788.29376.4016565749507481510.tip-bot2@tip-bot2>
 <20191018124800.0a7006bb@gandalf.local.home>
 <20191018124956.764ac42e@gandalf.local.home> <20191018171354.GB20368@zn.tnic>
 <20191018133735.77e90e36@gandalf.local.home> <20191018194856.GC20368@zn.tnic>
 <20191018163125.346e078d@gandalf.local.home> <20191019073424.GA27353@zn.tnic>
 <20191021141038.GC7014@zn.tnic>
From:   Jiri Slaby <jslaby@suse.cz>
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f8dcb3dd-a8a6-5326-ea4a-bea2eb1c4651@suse.cz>
Date:   Tue, 22 Oct 2019 13:38:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191021141038.GC7014@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 21. 10. 19, 16:10, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> function_hook is used as a better name than the default __fentry__
> which is the profiling counter which gcc adds before every function's
> prologue. Thus, it is not called from C and cannot have the same
> semantics as a pure C function - it saves/restores regs so that a C
> function can be called.
> 
> Drop the function_hook symbol and use __fentry__ directly for better
> alignment with gcc's documentation.
> 
> Switch the marking to SYM_CODE_START/_END which is reserved for
> non-standard, special functions.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Slaby <jslaby@suse.cz>

On the top of Steven's comment:
Acked-by: Jiri Slaby <jslaby@suse.cz>

Thanks for taking care of this while my tooth was causing me pain.

> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86@kernel.org
> ---
>  Documentation/asm-annotations.rst |  4 ++--
>  arch/x86/kernel/ftrace_32.S       |  8 +++-----
>  arch/x86/kernel/ftrace_64.S       | 13 ++++++-------
>  3 files changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/asm-annotations.rst b/Documentation/asm-annotations.rst
> index 29ccd6e61fe5..f55c2bb74d00 100644
> --- a/Documentation/asm-annotations.rst
> +++ b/Documentation/asm-annotations.rst
> @@ -117,9 +117,9 @@ This section covers ``SYM_FUNC_*`` and ``SYM_CODE_*`` enumerated above.
>    So in most cases, developers should write something like in the following
>    example, having some asm instructions in between the macros, of course::
>  
> -    SYM_FUNC_START(function_hook)
> +    SYM_FUNC_START(memset)
>          ... asm insns ...
> -    SYM_FUNC_END(function_hook)
> +    SYM_FUNC_END(memset)
>  
>    In fact, this kind of annotation corresponds to the now deprecated ``ENTRY``
>    and ``ENDPROC`` macros.
> diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
> index 8ed1f5d371f0..77be7e7e5e59 100644
> --- a/arch/x86/kernel/ftrace_32.S
> +++ b/arch/x86/kernel/ftrace_32.S
> @@ -12,18 +12,16 @@
>  #include <asm/frame.h>
>  #include <asm/asm-offsets.h>
>  
> -# define function_hook	__fentry__
> -EXPORT_SYMBOL(__fentry__)
> -
>  #ifdef CONFIG_FRAME_POINTER
>  # define MCOUNT_FRAME			1	/* using frame = true  */
>  #else
>  # define MCOUNT_FRAME			0	/* using frame = false */
>  #endif
>  
> -SYM_FUNC_START(function_hook)
> +SYM_CODE_START(__fentry__)
>  	ret
> -SYM_FUNC_END(function_hook)
> +SYM_CODE_END(__fentry__)
> +EXPORT_SYMBOL(__fentry__)
>  
>  SYM_CODE_START(ftrace_caller)
>  
> diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> index 69c8d1b9119e..3029fe4f8547 100644
> --- a/arch/x86/kernel/ftrace_64.S
> +++ b/arch/x86/kernel/ftrace_64.S
> @@ -14,9 +14,6 @@
>  	.code64
>  	.section .entry.text, "ax"
>  
> -# define function_hook	__fentry__
> -EXPORT_SYMBOL(__fentry__)
> -
>  #ifdef CONFIG_FRAME_POINTER
>  /* Save parent and function stack frames (rip and rbp) */
>  #  define MCOUNT_FRAME_SIZE	(8+16*2)
> @@ -132,9 +129,10 @@ EXPORT_SYMBOL(__fentry__)
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  
> -SYM_FUNC_START(function_hook)
> +SYM_CODE_START(__fentry__)
>  	retq
> -SYM_FUNC_END(function_hook)
> +SYM_CODE_END(__fentry__)
> +EXPORT_SYMBOL(__fentry__)
>  
>  SYM_FUNC_START(ftrace_caller)
>  	/* save_mcount_regs fills in first two parameters */
> @@ -248,7 +246,7 @@ SYM_FUNC_END(ftrace_regs_caller)
>  
>  #else /* ! CONFIG_DYNAMIC_FTRACE */
>  
> -SYM_FUNC_START(function_hook)
> +SYM_CODE_START(__fentry__)
>  	cmpq $ftrace_stub, ftrace_trace_function
>  	jnz trace
>  
> @@ -279,7 +277,8 @@ trace:
>  	restore_mcount_regs
>  
>  	jmp fgraph_trace
> -SYM_FUNC_END(function_hook)
> +SYM_CODE_END(__fentry__)
> +EXPORT_SYMBOL(__fentry__)
>  #endif /* CONFIG_DYNAMIC_FTRACE */
>  
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> 


-- 
js
suse labs
