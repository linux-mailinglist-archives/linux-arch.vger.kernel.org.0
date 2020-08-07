Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5EE23F294
	for <lists+linux-arch@lfdr.de>; Fri,  7 Aug 2020 20:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgHGSMm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Aug 2020 14:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgHGSMm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Aug 2020 14:12:42 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5ADC061A27
        for <linux-arch@vger.kernel.org>; Fri,  7 Aug 2020 11:12:41 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o1so1449059plk.1
        for <linux-arch@vger.kernel.org>; Fri, 07 Aug 2020 11:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kL3mR5oBZa4t2i/MKwrasxeLRvGcBc/sHQnLPXjcDwY=;
        b=qDDCzqQMNn82CNd4xcit662vHZMflfcl/cJjl2y6Rf2h/iJ2NYCm4uQUJpzhbCTiSM
         Upi8GVx8qDBBIy7VW2aAlhkTAhgdCSF3EA4Tu77gjdit1+LwN4QDoKiA1ObOYgyjp9kN
         t6gouN/unOljNDNCvakHHUz7sz6hdnpaT9YUS7AJMnMGCdUZ1OmKUfF9TaOJVz503CU+
         H8G5muLfTUVHpQd9uoHosckOHKYXWEbaqaRwUTFxsDR7BfjbJ5K8DePBafMyUIAwuuM1
         Aq3DYpyMSGZnVJeUj2RpcjoWOGoTGaNoFWMb2xWDtzfb77+fWq/WZxo9a1WpYNz6wjcT
         8tvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kL3mR5oBZa4t2i/MKwrasxeLRvGcBc/sHQnLPXjcDwY=;
        b=fXOQtw/cqtTeTnWcDWNkzUbw+VPOiQfSCNuFzYO9WaTxUipI8MPsFJ3PTTq63E+FZr
         BrUyW3PMAGqKwrRVUrpLRtU8zf8Jcp7O4mxHWZfiMtjJ1CgPL3CxqMk2oCiUC8yAYTCA
         Rc6d+xK/kbrPg+2LN0sNGk0bOLZfQhvjdnZK5cdt9KImw9O/Luq4rq5P/Ehpg7CTJte9
         iZvXyki6Xo7cPVWNZVl2qmoYJSLy0S00HqRcddkypd6zESAQ/FCw+z1HKnmlUcLnIJQo
         zPDEWGTeicjb0SIZW4Ltpwgzv84VcZ2jB/kPbbIZK4qyLajZbENcpiDPh2ORY8eRZHx/
         Ndkg==
X-Gm-Message-State: AOAM531sBA+G3LD2RDp1Iyn7n8YdJdxT0umV+2zf4hkF15s7LwnukFhG
        j4jtHpJbqB7NijQakRlwrXD//v5TjXfG5LKEp5ypUA==
X-Google-Smtp-Source: ABdhPJzUP9BycNEANV1ccydFSurHQBFr1fKt53c4Ly+onOxBQysLPnMNlFrz2Xmne8b9+/GR+N3sOSeUyLSCzZN+QsY=
X-Received: by 2002:a17:902:cb91:: with SMTP id d17mr13384373ply.223.1596823960860;
 Fri, 07 Aug 2020 11:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200731230820.1742553-1-keescook@chromium.org> <20200731230820.1742553-7-keescook@chromium.org>
In-Reply-To: <20200731230820.1742553-7-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Aug 2020 11:12:29 -0700
Message-ID: <CAKwvOd=mY5=SWjGKA_KpvKnOPmJky_qMcyBYeFhskx6J=aJmNA@mail.gmail.com>
Subject: Re: [PATCH v5 06/36] x86/boot: Remove run-time relocations from head_{32,64}.S
To:     Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 31, 2020 at 4:08 PM Kees Cook <keescook@chromium.org> wrote:
>
> From: Arvind Sankar <nivedita@alum.mit.edu>
>
> The BFD linker generates run-time relocations for z_input_len and
> z_output_len, even though they are absolute symbols.
>
> This is fixed for binutils-2.35 [1]. Work around this for earlier
> versions by defining two variables input_len and output_len in addition
> to the symbols, and use them via position-independent references.
>
> This eliminates the last two run-time relocations in the head code and
> allows us to drop the -z noreloc-overflow flag to the linker.
>
> Move the -pie and --no-dynamic-linker LDFLAGS to LDFLAGS_vmlinux instead
> of KBUILD_LDFLAGS. There shouldn't be anything else getting linked, but
> this is the more logical location for these flags, and modversions might
> call the linker if an EXPORT_SYMBOL is left over accidentally in one of
> the decompressors.
>
> [1] https://sourceware.org/bugzilla/show_bug.cgi?id=25754
>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Fangrui Song <maskray@google.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/boot/compressed/Makefile  | 12 ++----------
>  arch/x86/boot/compressed/head_32.S | 17 ++++++++---------
>  arch/x86/boot/compressed/head_64.S |  4 ++--
>  arch/x86/boot/compressed/mkpiggy.c |  6 ++++++
>  4 files changed, 18 insertions(+), 21 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 489fea16bcfb..7db0102a573d 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -51,16 +51,8 @@ UBSAN_SANITIZE :=n
>  KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
>  # Compressed kernel should be built as PIE since it may be loaded at any
>  # address by the bootloader.
> -ifeq ($(CONFIG_X86_32),y)
> -KBUILD_LDFLAGS += $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
> -else
> -# To build 64-bit compressed kernel as PIE, we disable relocation
> -# overflow check to avoid relocation overflow error with a new linker
> -# command-line option, -z noreloc-overflow.
> -KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
> -       && echo "-z noreloc-overflow -pie --no-dynamic-linker")
> -endif
> -LDFLAGS_vmlinux := -T
> +LDFLAGS_vmlinux := $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)

Oh, do these still need ld-option?  bfd and lld both support these
flags. (Though in their --help, they mention single hyphen and double
hyphen respectively.  Also, if we don't build this as PIE because the
linker doesn't support the option, we probably want to fail the build?

> +LDFLAGS_vmlinux += -T
>
>  hostprogs      := mkpiggy
>  HOST_EXTRACFLAGS += -I$(srctree)/tools/include
> diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
> index 8c1a4f5610f5..659fad53ca82 100644
> --- a/arch/x86/boot/compressed/head_32.S
> +++ b/arch/x86/boot/compressed/head_32.S
> @@ -178,18 +178,17 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
>  /*
>   * Do the extraction, and jump to the new kernel..
>   */
> -                               /* push arguments for extract_kernel: */
> -       pushl   $z_output_len   /* decompressed length, end of relocs */
> +       /* push arguments for extract_kernel: */
>
> -       pushl   %ebp            /* output address */
> -
> -       pushl   $z_input_len    /* input_len */
> +       pushl   output_len@GOTOFF(%ebx) /* decompressed length, end of relocs */
> +       pushl   %ebp                    /* output address */
> +       pushl   input_len@GOTOFF(%ebx)  /* input_len */
>         leal    input_data@GOTOFF(%ebx), %eax
> -       pushl   %eax            /* input_data */
> +       pushl   %eax                    /* input_data */
>         leal    boot_heap@GOTOFF(%ebx), %eax
> -       pushl   %eax            /* heap area */
> -       pushl   %esi            /* real mode pointer */
> -       call    extract_kernel  /* returns kernel location in %eax */
> +       pushl   %eax                    /* heap area */
> +       pushl   %esi                    /* real mode pointer */
> +       call    extract_kernel          /* returns kernel location in %eax */
>         addl    $24, %esp
>
>  /*
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 11429092c224..9e46729cf162 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -534,9 +534,9 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
>         movq    %rsi, %rdi              /* real mode address */
>         leaq    boot_heap(%rip), %rsi   /* malloc area for uncompression */
>         leaq    input_data(%rip), %rdx  /* input_data */
> -       movl    $z_input_len, %ecx      /* input_len */
> +       movl    input_len(%rip), %ecx   /* input_len */
>         movq    %rbp, %r8               /* output target address */
> -       movl    $z_output_len, %r9d     /* decompressed length, end of relocs */
> +       movl    output_len(%rip), %r9d  /* decompressed length, end of relocs */
>         call    extract_kernel          /* returns kernel location in %rax */
>         popq    %rsi
>
> diff --git a/arch/x86/boot/compressed/mkpiggy.c b/arch/x86/boot/compressed/mkpiggy.c
> index 7e01248765b2..52aa56cdbacc 100644
> --- a/arch/x86/boot/compressed/mkpiggy.c
> +++ b/arch/x86/boot/compressed/mkpiggy.c
> @@ -60,6 +60,12 @@ int main(int argc, char *argv[])
>         printf(".incbin \"%s\"\n", argv[1]);
>         printf("input_data_end:\n");
>
> +       printf(".section \".rodata\",\"a\",@progbits\n");
> +       printf(".globl input_len\n");
> +       printf("input_len:\n\t.long %lu\n", ilen);
> +       printf(".globl output_len\n");
> +       printf("output_len:\n\t.long %lu\n", (unsigned long)olen);
> +
>         retval = 0;
>  bail:
>         if (f)
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200731230820.1742553-7-keescook%40chromium.org.



-- 
Thanks,
~Nick Desaulniers
