Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3506720D7F3
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 22:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbgF2TeV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 15:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733224AbgF2Tcn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 15:32:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEB9C02F004
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 07:43:38 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q90so7352159pjh.3
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 07:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yi6JXAo1ZyKdvYW2lysqRB4X8J5GEgjfQlw9nhW0Ebg=;
        b=FcI9HcFNnmkS7xOHrCLlNWmbbi80f8MLjkp0bTXWTdF+IBlRUCurEMLoVIR7Yt57B0
         mhPSrFkFF78lCAtSinaJ6aJX97k5zhtcFaxInJWiI7oACyaPmRvWRoa5/N4zzTpu+TPl
         VXPrT6yEUnDqZ0d1u9easG3Ru3Qjw96EneDF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yi6JXAo1ZyKdvYW2lysqRB4X8J5GEgjfQlw9nhW0Ebg=;
        b=ly2Ld4TJmPwKFLMUp2zcXjKdk6501ir6i3MVX9PbJXt8iD36jIxwjxTd2Z5srLOq6e
         yTtgpO2luN3jLc3dL/SSU486G/R8KFcqzDQFG852XEY6hlDIExYvA9wRKGbnZf8nM4s3
         JJFldmisLa5YogV6wedxMQmhF8UX9CJMxwTO5pRSLNKAmapMR+1LAYnN6jz/4l6t+QZn
         TlJwnpbu4fQ7cQpDcqyo7bUmLxfr54Hu7kXZJhxc0rnOFlaHgVYvc6HKFpM/DIho0lF1
         nfN74+A15RX7ikGK+Ej/CzVYHPGVt+aDiUyXg03SbeQX3LhPlw4OtZ//yw25vdDnAoW3
         ezlQ==
X-Gm-Message-State: AOAM532c1OwevPrlcgnZNx2JGhJn0UTCT3UHoiu4H9F7pzA4BIS+oN8j
        8L/qYiGxHl2bcfk5L6+wG+jvMQ==
X-Google-Smtp-Source: ABdhPJwybf+0t6W88LuU35gXB6jzrCSMoNi9aseWcKSgTK9Lcgit7BB1R8CrmUhMywtQcxnrnSW8RQ==
X-Received: by 2002:a17:902:9346:: with SMTP id g6mr13542327plp.19.1593441818365;
        Mon, 29 Jun 2020 07:43:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 25sm58832pfi.7.2020.06.29.07.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:43:37 -0700 (PDT)
Date:   Mon, 29 Jun 2020 07:43:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/17] ctype: Work around Clang
 -mbranch-protection=none bug
Message-ID: <202006290742.92EC7235@keescook>
References: <20200629061840.4065483-1-keescook@chromium.org>
 <20200629061840.4065483-6-keescook@chromium.org>
 <CAMj1kXE+toCd=Bx-zw7D9bvDRNB2aPn5-_7CY7MOKcVGA-azVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE+toCd=Bx-zw7D9bvDRNB2aPn5-_7CY7MOKcVGA-azVg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 29, 2020 at 10:15:47AM +0200, Ard Biesheuvel wrote:
> On Mon, 29 Jun 2020 at 08:18, Kees Cook <keescook@chromium.org> wrote:
> >
> > In preparation for building efi/libstub with -mbranch-protection=none
> > (EFI does not support branch protection features[1]), add no-op code
> > to work around a Clang bug that emits an unwanted .note.gnu.property
> > section for object files without code[2].
> >
> > [1] https://lore.kernel.org/lkml/CAMj1kXHck12juGi=E=P4hWP_8vQhQ+-x3vBMc3TGeRWdQ-XkxQ@mail.gmail.com
> > [2] https://bugs.llvm.org/show_bug.cgi?id=46480
> >
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Dave Martin <Dave.Martin@arm.com>
> > Cc: clang-built-linux@googlegroups.com
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  lib/ctype.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/lib/ctype.c b/lib/ctype.c
> > index c819fe269eb2..21245ed57d90 100644
> > --- a/lib/ctype.c
> > +++ b/lib/ctype.c
> > @@ -36,3 +36,13 @@ _L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,     /* 224-239 */
> >  _L,_L,_L,_L,_L,_L,_L,_P,_L,_L,_L,_L,_L,_L,_L,_L};      /* 240-255 */
> >
> >  EXPORT_SYMBOL(_ctype);
> > +
> > +/*
> > + * Clang will generate .note.gnu.property sections for object files
> > + * without code, even in the presence of -mbranch-protection=none.
> > + * To work around this, define an unused static function.
> > + * https://bugs.llvm.org/show_bug.cgi?id=46480
> > + */
> > +#ifdef CONFIG_CC_IS_CLANG
> > +void __maybe_unused __clang_needs_code_here(void) { }
> > +#endif
> > --
> > 2.25.1
> >
> 
> I take it we don't need this horrible hack if we build the EFI stub
> with branch protections and filter out the .note.gnu.property section
> explicitly?

Correct.

> Sorry to backpedal, but that is probably a better approach after all,
> given that the instructions don't hurt, and we will hopefully be able
> to arm them once UEFI (as well as PE/COFF) gets around to describing
> this in a way that both the firmware and the OS can consume.

Okay, will revert to the v3 solution.

-- 
Kees Cook
