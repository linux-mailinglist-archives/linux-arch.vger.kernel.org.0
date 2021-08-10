Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D3E3DDDDD
	for <lists+linux-arch@lfdr.de>; Mon,  2 Aug 2021 18:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhHBQlU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Aug 2021 12:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhHBQlU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Aug 2021 12:41:20 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E39C061760
        for <linux-arch@vger.kernel.org>; Mon,  2 Aug 2021 09:41:10 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id h2so34848545lfu.4
        for <linux-arch@vger.kernel.org>; Mon, 02 Aug 2021 09:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mpn7PG82ctGVboEylkUCiZGj+PBEuHBMPwSjZySIC0s=;
        b=Iqhh7BSh+B86kg39xX8VkoRpnOqC8KFwDcrhQ+zu0THerTrxEbIkP37rvWmRxSw7jE
         84lg7TEWZymIsscS6kgojGiOacOUw4zLVFhs2xve/OiqUmzeLsTg07NjjN3CVTJhSyiz
         pP0W7M6r5fBu60lsQqlydDLgx8LXb271JeGxPQLKu37ohhWTDKPuHKqtGLxsb3xqmkB/
         99vi9xftpRnY2i6z97YkD64tr66TpzVS7o8SkKEq2nnxlRyl1Uowv9hYmvXLoTZaLH4q
         tCHu6hKlqbaPMTGB5hQ+K5mOikgCrJcOm+byKWkPw7KLMkShqXUuX191a/bqzjxirdiV
         g66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mpn7PG82ctGVboEylkUCiZGj+PBEuHBMPwSjZySIC0s=;
        b=lwJbun6JsxSNyT1a2RogcrAEVAJUs6C6BJoBbeQUqkEXLc955UZs4+eufdGD53IylD
         HGvrCsTkihi/FOPdKoktjQ+bewSlBlRnt3Gnh8JShf0pALetRw2iOwIZEvIdyOKu2uD2
         h8+aS97isQY4cOCXaTM590Qdp3RCOdDFRbACHjInpCBuT9WAGu3L0hnxgyluelrF4IUS
         uY648N9YFlLQbT3rz6xhsa+/XF81vdZE6UC/jpG/+VECgGSDo7vNqItc/9AqAkTX0can
         qke4Aax3xjWPq3nYPf+KXHdSMqpSDuxlT7qXW7EBWeejdHG7SUlB/qgNtdQKXS8ZG5m/
         I2OA==
X-Gm-Message-State: AOAM533MDDzUPyNgS2iqmbi0sMoRh6BykjQPVmql0EbywDfcKzhrxeVY
        swKPyHhQqD+rLARgNP/efnZtrsrXs6rv4+FRM44vjw==
X-Google-Smtp-Source: ABdhPJxcWZ3/edYohvI2qN/BMlgCfpbBTKLphlDwAwEibDj4bMGfgUBLri9N30FjU8r1bPCjZL8QI6BDpfvzPzbGFsg=
X-Received: by 2002:ac2:4ac6:: with SMTP id m6mr13931061lfp.73.1627922468420;
 Mon, 02 Aug 2021 09:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210730223815.1382706-1-nathan@kernel.org> <20210731023107.1932981-1-nathan@kernel.org>
In-Reply-To: <20210731023107.1932981-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 2 Aug 2021 09:40:56 -0700
Message-ID: <CAKwvOdk3xPjqidz=wmxuRjkSR0Q51Lygg1kkC1tn8vZWWc9NOA@mail.gmail.com>
Subject: Re: [PATCH v2] vmlinux.lds.h: Handle clang's module.{c,d}tor sections
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Fangrui Song <maskray@google.com>,
        Marco Elver <elver@google.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        clang-built-linux@googlegroups.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 30, 2021 at 7:33 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> A recent change in LLVM causes module_{c,d}tor sections to appear when
> CONFIG_K{A,C}SAN are enabled, which results in orphan section warnings
> because these are not handled anywhere:
>
> ld.lld: warning: arch/x86/pci/built-in.a(legacy.o):(.text.asan.module_ctor) is being placed in '.text.asan.module_ctor'
> ld.lld: warning: arch/x86/pci/built-in.a(legacy.o):(.text.asan.module_dtor) is being placed in '.text.asan.module_dtor'
> ld.lld: warning: arch/x86/pci/built-in.a(legacy.o):(.text.tsan.module_ctor) is being placed in '.text.tsan.module_ctor'
>
> Fangrui explains: "the function asan.module_ctor has the SHF_GNU_RETAIN
> flag, so it is in a separate section even with -fno-function-sections
> (default)".
>
> Place them in the TEXT_TEXT section so that these technologies continue
> to work with the newer compiler versions. All of the KASAN and KCSAN
> KUnit tests continue to pass after this change.
>
> Cc: stable@vger.kernel.org
> Link: https://github.com/ClangBuiltLinux/linux/issues/1432
> Link: https://github.com/llvm/llvm-project/commit/7b789562244ee941b7bf2cefeb3fc08a59a01865
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> v1 -> v2:
>
> * Fix inclusion of .text.tsan.* (Nick)
>
> * Drop .text.asan as it does not exist plus it would be handled by a
>   different line (Fangrui)
>
> * Add Fangrui's explanation about why the LLVM commit caused these
>   sections to appear.
>
>  include/asm-generic/vmlinux.lds.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 17325416e2de..62669b36a772 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -586,6 +586,7 @@
>                 NOINSTR_TEXT                                            \
>                 *(.text..refcount)                                      \
>                 *(.ref.text)                                            \
> +               *(.text.asan.* .text.tsan.*)                            \
>                 TEXT_CFI_JT                                             \
>         MEM_KEEP(init.text*)                                            \
>         MEM_KEEP(exit.text*)                                            \
>
> base-commit: 4669e13cd67f8532be12815ed3d37e775a9bdc16
> --
> 2.32.0.264.g75ae10bc75
>


-- 
Thanks,
~Nick Desaulniers
