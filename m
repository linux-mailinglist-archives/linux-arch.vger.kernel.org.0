Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C82283D5C
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 19:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgJERgW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 13:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgJERgW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Oct 2020 13:36:22 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77086C0613CE
        for <linux-arch@vger.kernel.org>; Mon,  5 Oct 2020 10:36:22 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h6so5764526pgk.4
        for <linux-arch@vger.kernel.org>; Mon, 05 Oct 2020 10:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGneaUPSfmwmZclVabdMQtlpK5P/Q67PdE+cZq4zgcM=;
        b=GBwOGDWDRut7KhZTbQ6/Yi5l7rHvibdoTP1rWlTv094qtnCKgxidxIjLDZIspampjB
         dEWxjaqxkI2E/pLxBwkz5mNnUeWikWSVhEc0F4xiw4LQqc0VI+I/Gpd4Kw0BxlVF7DvU
         sCs3d4yP1p+CFlSyF9mp7MdSst1cLCLOTL++2rVcqvUzrV6Qqb3lrSTYJ1tpzX6QbWqf
         LlxpmqrhyBE54li2VPtdndcbISMNFKzaemvvZkv8UnyrU86L3/cXE6fMebI+Bb0oaqvY
         iMjhvjfAnZDS7s06AEcd/aUI/xi+GG8yG7ggyZ2pIr3MbiSjAuXsVuF/5jGVm+q8wydN
         XmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGneaUPSfmwmZclVabdMQtlpK5P/Q67PdE+cZq4zgcM=;
        b=b+5J6NC4ch6pf3oEMmIaEN+cayVk1rl7Evx9G5dWgcfB1XTWrZF58wC944KjbCq5bT
         UsnVi4oRXFTH/8mDe1WEg9JvAmZNnCFIn57KV119asfLOc1LvXyC0O89WwRCH1HosBDF
         ZG9mtiNrCY1FW9gFPo4hwjgA8V8jLxPdhJhsMUb3iXoOcoIJHyFEZyn/DthQCDfsBh0j
         X5Vj1W7NSVjp08RQxRtPhmgUTueGGNezoc7tYaVa9rQsRfeuBLufLaI3jR9DqBkZe5CC
         +aG5EFfGPxU4JGQyiLoveI2bmWLPhd7h4b7uV5vnJZeuCSDlGczN3RR7FXTqimuW9Atp
         2TiQ==
X-Gm-Message-State: AOAM531zuqsduEmNIHqjiggqW2bV9i1gMmuQbohxaUL8fkukOZbOOFto
        Y1a0sTNHSGITwZqfQkj6pZPivEWcCnmY10QAbUbCng==
X-Google-Smtp-Source: ABdhPJxn56caBLZKbrVaopjudCJE86MNDFRX0mqIhB6Pn1QzmCP8YlqsezxHYWQwvGujFEdbYWR/mgySkQY/MAL1pbA=
X-Received: by 2002:a65:6858:: with SMTP id q24mr596445pgt.10.1601919381716;
 Mon, 05 Oct 2020 10:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201005025720.2599682-1-keescook@chromium.org>
In-Reply-To: <20201005025720.2599682-1-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 5 Oct 2020 10:36:11 -0700
Message-ID: <CAKwvOdnVJW0wDuMvgfKUE248gbDTT1CYmDY=hczaFNQ_39OfjA@mail.gmail.com>
Subject: Re: [PATCH v2] vmlinux.lds.h: Keep .ctors.* with .ctors
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Oct 4, 2020 at 7:57 PM Kees Cook <keescook@chromium.org> wrote:
>
> Under some circumstances, the compiler generates .ctors.* sections. This
> is seen doing a cross compile of x86_64 from a powerpc64el host:
>
> x86_64-linux-gnu-ld: warning: orphan section `.ctors.65435' from `kernel/trace/trace_clock.o' being
> placed in section `.ctors.65435'
> x86_64-linux-gnu-ld: warning: orphan section `.ctors.65435' from `kernel/trace/ftrace.o' being
> placed in section `.ctors.65435'
> x86_64-linux-gnu-ld: warning: orphan section `.ctors.65435' from `kernel/trace/ring_buffer.o' being
> placed in section `.ctors.65435'
>
> Include these orphans along with the regular .ctors section.

It's very curious to see different behavior based on whether one is
targeting x86_64 via native compilation vs cross compilation.

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 83109d5d5fba ("x86/build: Warn on orphan section placement")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2: brown paper bag version: fix whitespace for proper backslash alignment
> ---
>  include/asm-generic/vmlinux.lds.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 5430febd34be..b83c00c63997 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -684,6 +684,7 @@
>  #ifdef CONFIG_CONSTRUCTORS
>  #define KERNEL_CTORS() . = ALIGN(8);                      \
>                         __ctors_start = .;                 \
> +                       KEEP(*(SORT(.ctors.*)))            \
>                         KEEP(*(.ctors))                    \
>                         KEEP(*(SORT(.init_array.*)))       \
>                         KEEP(*(.init_array))               \
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
