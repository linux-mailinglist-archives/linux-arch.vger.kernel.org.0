Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5D820DB34
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 22:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbgF2UEf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 16:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388810AbgF2UEe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 16:04:34 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37FCC03E97A
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 13:04:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a127so8336925pfa.12
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 13:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dTLUsyi9EoNBvYop+SAQkhC6GYIREzqCPpDVHlef0N4=;
        b=iyegTPlbjhn5HlYQVhbZw8XqrIU7lJKRRk5bmuxEeuSQzinLKXX6CuU8egSe3yPdKD
         hN4x0leCH3AyDKiaTF3Nb59aff4r2LF1aPPEwtqGfIEB+oZD9/0TJ9jhmlHrykRvmJnl
         a6cjSj2v7FpsBA9YWOnvcv54vPdfr5mhHAKW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dTLUsyi9EoNBvYop+SAQkhC6GYIREzqCPpDVHlef0N4=;
        b=JuWY6DYWPFWaaL/0l2RQwhsKWpOsylpLPhLrdO1sVIYTBSkLfN5ryl5Y9QKWFGsDF8
         yHWRJ+JOQyKV/qSbkcAoUt3PKw9mZ8lpdPGYurTadpV33BmC3v7voqOBjL6CrNgGdGd9
         Ou/TUxTzpaPGxyVYzSyhstpytbJPTxj/u8pxpwBjogm8fClz7M7Y7URXvpU+l/qcOlLQ
         4BMykGgCg49oQkbubOfM2USBN8vEG2AhtIMG8xpDxRJWE852bIugrMMF3pLfCwjNjdls
         2asTqJ3zGGyEi7mgUZeuI+9TczpKLEpGs/ag6Q9eMM8A36WoVjBunsoTY0nrBKGYYUE/
         7gdQ==
X-Gm-Message-State: AOAM530TufJgsfYy1VguLAewURxi6aPc5hjOeJArziwLmNoweO93hytk
        /afoUAhF9r7hNucHRuUsmcZ8NQ==
X-Google-Smtp-Source: ABdhPJzdUinj83wjxemEYOkw00z16gQNGulknaX544OOjyQoDtiBgCLUR8nqCuc5q1pH8hR406oB2w==
X-Received: by 2002:a63:4c08:: with SMTP id z8mr11413821pga.201.1593461073426;
        Mon, 29 Jun 2020 13:04:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h130sm446526pfe.200.2020.06.29.13.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 13:04:32 -0700 (PDT)
Date:   Mon, 29 Jun 2020 13:04:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v4 08/17] arm64/mm: Remove needless section quotes
Message-ID: <202006291301.46FEF3B7@keescook>
References: <20200629061840.4065483-1-keescook@chromium.org>
 <20200629061840.4065483-9-keescook@chromium.org>
 <CAKwvOd=r6bsBfSZxVYrnbm1Utq==ApWBDjx+0Fxsm90Aq3Jghw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=r6bsBfSZxVYrnbm1Utq==ApWBDjx+0Fxsm90Aq3Jghw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 29, 2020 at 12:53:47PM -0700, Nick Desaulniers wrote:
> On Sun, Jun 28, 2020 at 11:18 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Fix a case of needless quotes in __section(), which Clang doesn't like.
> >
> > Acked-by: Will Deacon <will@kernel.org>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Yep, I remember bugs from this.  Probably should scan the kernel for
> other instances of this.  +Joe for checkpatch.pl validation.

I think the others are safe because they're in macros:

$ git grep -4 '__section("'
include/linux/compiler.h-# define KENTRY(sym)                                           \
include/linux/compiler.h-       extern typeof(sym) sym;                                 \
include/linux/compiler.h-       static const unsigned long __kentry_##sym               \
include/linux/compiler.h-       __used                                                  \
include/linux/compiler.h:       __section("___kentry" "+" #sym )                        \
include/linux/compiler.h-       = (unsigned long)&sym;
--
include/linux/export.h-#define __ksym_marker(sym)       \
include/linux/export.h: static int __ksym_marker_##sym[0] __section(".discard.ksym") __used
--
include/linux/srcutree.h-# define __DEFINE_SRCU(name, is_static)                                \
include/linux/srcutree.h-       is_static struct srcu_struct name;                              \
include/linux/srcutree.h-       struct srcu_struct * const __srcu_struct_##name                 \
include/linux/srcutree.h:               __section("___srcu_struct_ptrs") = &name


> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks!

-- 
Kees Cook
