Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D9420E512
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbgF2VcH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbgF2SlJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:09 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B89ED23384;
        Mon, 29 Jun 2020 08:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593418559;
        bh=kHCTNEXUyN8B0i7mtdAtCASa7aFVkRNOlTjU61Qvi8g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iR8AkUrJ8uJTcHsJSxMy0UcTjFtkJ9CtoOzw9CDJECbJqvGLr6CyFmAqXStRv7POD
         6KDhS8R3LKvLvawvij6UHEgvp9577txcsOM2Fq7CSNONTcNHrT6xBWAZ6BbC7WbVBG
         /y7RBWq4JT31ARk1yXY23NdWEThNGd3OWYcImJ1U=
Received: by mail-oi1-f173.google.com with SMTP id j11so11025154oiw.12;
        Mon, 29 Jun 2020 01:15:59 -0700 (PDT)
X-Gm-Message-State: AOAM53144uwm8O4YdX6NQeO/RnnY1fbSKzNir8CwQ4eU9oP6Qif1sA+k
        1+XKHDWhiK3mIY3xIiEGVrO2Poz4DOw333NqixY=
X-Google-Smtp-Source: ABdhPJxkX75XfyaMVAOo1BZKHbdu4+gQkiHahScl4+cEIiVwwe65YHthK6RMwDPaoLa2k9UavFx3J2NWS6VhWDX9BCw=
X-Received: by 2002:aca:b241:: with SMTP id b62mr10654472oif.47.1593418558905;
 Mon, 29 Jun 2020 01:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200629061840.4065483-1-keescook@chromium.org> <20200629061840.4065483-6-keescook@chromium.org>
In-Reply-To: <20200629061840.4065483-6-keescook@chromium.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 29 Jun 2020 10:15:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE+toCd=Bx-zw7D9bvDRNB2aPn5-_7CY7MOKcVGA-azVg@mail.gmail.com>
Message-ID: <CAMj1kXE+toCd=Bx-zw7D9bvDRNB2aPn5-_7CY7MOKcVGA-azVg@mail.gmail.com>
Subject: Re: [PATCH v4 05/17] ctype: Work around Clang -mbranch-protection=none
 bug
To:     Kees Cook <keescook@chromium.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 29 Jun 2020 at 08:18, Kees Cook <keescook@chromium.org> wrote:
>
> In preparation for building efi/libstub with -mbranch-protection=none
> (EFI does not support branch protection features[1]), add no-op code
> to work around a Clang bug that emits an unwanted .note.gnu.property
> section for object files without code[2].
>
> [1] https://lore.kernel.org/lkml/CAMj1kXHck12juGi=E=P4hWP_8vQhQ+-x3vBMc3TGeRWdQ-XkxQ@mail.gmail.com
> [2] https://bugs.llvm.org/show_bug.cgi?id=46480
>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Dave Martin <Dave.Martin@arm.com>
> Cc: clang-built-linux@googlegroups.com
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  lib/ctype.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/lib/ctype.c b/lib/ctype.c
> index c819fe269eb2..21245ed57d90 100644
> --- a/lib/ctype.c
> +++ b/lib/ctype.c
> @@ -36,3 +36,13 @@ _L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,     /* 224-239 */
>  _L,_L,_L,_L,_L,_L,_L,_P,_L,_L,_L,_L,_L,_L,_L,_L};      /* 240-255 */
>
>  EXPORT_SYMBOL(_ctype);
> +
> +/*
> + * Clang will generate .note.gnu.property sections for object files
> + * without code, even in the presence of -mbranch-protection=none.
> + * To work around this, define an unused static function.
> + * https://bugs.llvm.org/show_bug.cgi?id=46480
> + */
> +#ifdef CONFIG_CC_IS_CLANG
> +void __maybe_unused __clang_needs_code_here(void) { }
> +#endif
> --
> 2.25.1
>

I take it we don't need this horrible hack if we build the EFI stub
with branch protections and filter out the .note.gnu.property section
explicitly?

Sorry to backpedal, but that is probably a better approach after all,
given that the instructions don't hurt, and we will hopefully be able
to arm them once UEFI (as well as PE/COFF) gets around to describing
this in a way that both the firmware and the OS can consume.
