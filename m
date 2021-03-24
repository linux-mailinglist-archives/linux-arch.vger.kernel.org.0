Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7CA347CA7
	for <lists+linux-arch@lfdr.de>; Wed, 24 Mar 2021 16:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbhCXPbd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Mar 2021 11:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236678AbhCXPbW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Mar 2021 11:31:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655A3C0613E0
        for <linux-arch@vger.kernel.org>; Wed, 24 Mar 2021 08:31:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r12so33601285ejr.5
        for <linux-arch@vger.kernel.org>; Wed, 24 Mar 2021 08:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fckQzWuJnvD6S/jFF8HUa1PwKAcbSDOKJ4gWr/ndvyk=;
        b=OlKQtU1q2ZxhFAsb1Cs2Js3zE+ZJzDOEI4+bnRMrr1+uVB7P/Iu6eKckjnXg8zK56l
         Irrft7thQGCzqA32QFBdXE4+uBuO6iQgfPeDjc1NS4TUbZsPKk2pdNdVY5R9tx4z25Dg
         ozY6uLy7niX57VhmCVl+dE8zMrZFu7sQlODj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fckQzWuJnvD6S/jFF8HUa1PwKAcbSDOKJ4gWr/ndvyk=;
        b=WkMTiNdK4WmOK2lPpJhID6/OcnZfWujMrVmj/Toyn6JnNQQlqo6Z+i9k9H5GsdTr2S
         Tu6yyijbH0RKjKe3N6ogMF2HOJO+OokJR1QO5pH336KIxyM1CkaaFS9FY1VOeW7V6N4c
         5RZO7kSFV+M0Trz5HhDoDuV1ijvNphEwz8FOsE/lGWTI6UcZlLQvO5QbrkxQRXQUgrZO
         gqQDSmxxQ/TLAy/HGGmPrgmK8930746IH3tXi4ve46Tdm+/qg2bDE0YRpfD+ipSjlRW0
         qL+McflZXfMedcMnnbBCAbja+jzvWtTIAPTk0aHWzCMMWb3mLyU0+C4WPopmAoKMdNgR
         oWXw==
X-Gm-Message-State: AOAM533jLWf7MWQ5u1zKf/iNrog1wiEKXDwOZVmq6pWagPDzszA0fDSg
        r7auww43PO6X+8L6Ek6zegmOEQ==
X-Google-Smtp-Source: ABdhPJwQj/wpq3nFF6bQFT/Rz0xc2jmEi77W566MBeimLH4Wx2lLOahfvWOwYafWC5mURjTYGhXuXw==
X-Received: by 2002:a17:906:358c:: with SMTP id o12mr4397574ejb.156.1616599878962;
        Wed, 24 Mar 2021 08:31:18 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id b12sm1262238eds.94.2021.03.24.08.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 08:31:18 -0700 (PDT)
Subject: Re: [PATCH v3 02/17] cfi: add __cficanonical
To:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210323203946.2159693-1-samitolvanen@google.com>
 <20210323203946.2159693-3-samitolvanen@google.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <92afcbea-1415-2df1-5e78-4e9a7a4d364b@rasmusvillemoes.dk>
Date:   Wed, 24 Mar 2021 16:31:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210323203946.2159693-3-samitolvanen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 23/03/2021 21.39, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler replaces a function address taken
> in C code with the address of a local jump table entry, which passes
> runtime indirect call checks. However, the compiler won't replace
> addresses taken in assembly code, which will result in a CFI failure
> if we later jump to such an address in instrumented C code. The code
> generated for the non-canonical jump table looks this:
> 
>   <noncanonical.cfi_jt>: /* In C, &noncanonical points here */
> 	jmp noncanonical
>   ...
>   <noncanonical>:        /* function body */
> 	...
> 
> This change adds the __cficanonical attribute, which tells the
> compiler to use a canonical jump table for the function instead. This
> means the compiler will rename the actual function to <function>.cfi
> and points the original symbol to the jump table entry instead:
> 
>   <canonical>:           /* jump table entry */
> 	jmp canonical.cfi
>   ...
>   <canonical.cfi>:       /* function body */
> 	...
> 
> As a result, the address taken in assembly, or other non-instrumented
> code always points to the jump table and therefore, can be used for
> indirect calls in instrumented code without tripping CFI checks.

Random ramblings, I'm trying to understand how this CFI stuff works.

First, patch 1 and 2 explain the pros and cons of canonical vs
non-canonical jump tables, in either case, there's problems with stuff
implemented in assembly. But I don't understand why those pros and cons
then end up with using the non-canonical jump tables by default. IIUC,
with canonical jump tables, function pointer equality would keep working
for functions implemented in C, because &func would always refer to the
same stub "function" that lives in the same object file as func.cfi,
whereas with the non-canonical version, each TU (or maybe DSO) that
takes the address of func ends up with its own func.cfi_jt.

There are of course lots of direct calls of assembly functions, but
I don't think we take the address of such functions very often. So why
can't we instead equip the declarations of those with a
__cfi_noncanonical attribute?

And now, more directed at the clang folks on cc:

As to how CFI works, I've tried to make sense of the clang docs. So at
place where some int (*)(long, int) function pointer is called, the
compiler computes (roughly) md5sum("int (*)(long, int)") and uses the
first 8 bytes as a cookie representing that type. It then goes to some
global table of jump table ranges indexed by that cookie and checks that
the address it is about to call is within that range. All jump table
entries for one type of function are consecutive in memory (with
complications arising from cross-DSO calls).

What I don't understand about all this is why that indirection through
some hidden global table and magic jump table (whether canonical or not)
is even needed in the simple common case of ordinary C functions. Why
can't the compiler just emit the cookie corresponding to a given
function's prototype immediately prior to the function? Then the inline
check would just be "if (*(u64*)((void*)func - 8) == cookie)" and
function pointer comparison would just work because there's no magic
involved when doing &func. Cross-DSO calls of C function have no extra
cost to look up a __cfi_check function in the target DSO. An indirect
call doesn't touch at least two extra cache lines (the range table and
the jump table entry). It seems to rely on LTO anyway, so it's not even
that the compiler would have to emit that cookie for every single
function, it knows at link time which functions have their address
taken. Calling functions implemented in assembly through a function
pointer will have the same problem as with the "canonical" jump table
approach, but with a suitable attribute on those surely the compiler
could emit a func.cfi_hoop

  .quad 0x1122334455667788 // cookie
  <func.cfi_hoop>:
	jmp func

and perhaps no such attribute would even be needed (with LTO, the
compiler should be able to see "hey, I don't know that function, it's
probably implemented in assembly, so lemme emit that trampoline with a
cookie in front and redirect address-of to that").

Rasmus
