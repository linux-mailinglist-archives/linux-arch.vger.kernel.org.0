Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458E5207E3C
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 23:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390096AbgFXVOA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 17:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390034AbgFXVN7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 17:13:59 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B04AC061795
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 14:13:59 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d12so1651109ply.1
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 14:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=omCkUcZNHVXP0sWRywzjOwxTXZ4YyisMAxm749WU5GU=;
        b=ogyMpgi9tPFXqD3+b4TskFtzlAE3qRSfSFlhxLkMzfZQl068z8vqJlL5I/k1hQA4j2
         8+KaTuQNKpStTyBjn2ssQsUKa/GWq7f607kaEaeXU2o8/Ft2sUgUsqmcJHltC+KgIKVl
         o3jZ4P3X6AywcFpecW/k8P5ZOrqPI9Z99iVivwkxvFoyUq4G2KcudRcYQ4mOacJiN+sQ
         WfzuwRbr7it+GIQZRqsNndeZ4kbhXyBxzlSPEB5SEo0dkcZcdM6751ifbYi1L0YxNGzl
         zLZYU7QD65uDvjwEcqlKMDaY6jKyUjhUxCFnXE3C+lzv6bRpSkWGLHXOkAgDh/7Se2CC
         j7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=omCkUcZNHVXP0sWRywzjOwxTXZ4YyisMAxm749WU5GU=;
        b=VWBzktrj9C29YKrLRV5Vc2ANonO9SrsEXscgMqLUZYxFLwKs8P29IBujbinPooIwlR
         58mjoVjkdGqYG9eyC6gtl2IEznTo6q9aPau5fTFkn7RQfCW8sazYq2wbjdxyP59VMA8L
         zUZkvHJZfqR3wXlW31K0KzwWoSVBjc5Y3rV03DeGZrjzRDoTuO/g3xITZWG0rzY318y5
         zlNbFvnDHhnl00jRwKRc+wJm9ft+HFu7JEpZUj0Q8TUDGeQh6me/VKwk8kzdKIMvZzah
         933qE+w8MsU/d452TL0VqEBggNRTNqZ9Xm8ZaTZNvqs6BeT0zJPMH3xP36f9+Xj3PV9y
         sxIQ==
X-Gm-Message-State: AOAM531PJE0OsIKVNj9iTtaGGHDoyyiJrF7uUJKm0dtPUIZ6K95mRuV7
        iwBEmXPeoDQJjb79R4D16p2fAo/kvc45Sm7+nUR+zQ==
X-Google-Smtp-Source: ABdhPJyvmG5uGb8Lyk5i53Q9bt53kqBtuDjO8DoRXX4pnhndW+Y4vnp4+GK0S4oFxok0KRSkaflUBQ+yOxnxS3G2Ct0=
X-Received: by 2002:a17:902:b698:: with SMTP id c24mr29536869pls.223.1593033238474;
 Wed, 24 Jun 2020 14:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200624203200.78870-9-samitolvanen@google.com>
In-Reply-To: <20200624203200.78870-9-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 24 Jun 2020 14:13:46 -0700
Message-ID: <CAKwvOdmcDxa+h9i6_XQc8ZDQjD9cTrD7s9eNU0fSxZbXciKhDQ@mail.gmail.com>
Subject: Re: [PATCH 08/22] kbuild: lto: remove duplicate dependencies from
 .mod files
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 1:33 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> With LTO, llvm-nm prints out symbols for each archive member
> separately, which results in a lot of duplicate dependencies in the
> .mod file when CONFIG_TRIM_UNUSED_SYMS is enabled. When a module
> consists of several compilation units, the output can exceed the
> default xargs command size limit and split the dependency list to
> multiple lines, which results in used symbols getting trimmed.
>
> This change removes duplicate dependencies, which will reduce the
> probability of this happening and makes .mod files smaller and
> easier to read.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  scripts/Makefile.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 82977350f5a6..82b465ce3ca0 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -291,7 +291,7 @@ endef
>
>  # List module undefined symbols (or empty line if not enabled)
>  ifdef CONFIG_TRIM_UNUSED_KSYMS
> -cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | xargs echo
> +cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | sort -u | xargs echo
>  else
>  cmd_undef_syms = echo
>  endif
> --
> 2.27.0.212.ge8ba1cc988-goog
>


-- 
Thanks,
~Nick Desaulniers
