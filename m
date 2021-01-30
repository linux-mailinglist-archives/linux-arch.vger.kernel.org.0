Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BCC309923
	for <lists+linux-arch@lfdr.de>; Sun, 31 Jan 2021 01:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhAaAAh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Jan 2021 19:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbhAaAA0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Jan 2021 19:00:26 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C095C061573;
        Sat, 30 Jan 2021 15:59:45 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id q5so12128796ilc.10;
        Sat, 30 Jan 2021 15:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=TndpLZJEfWm95krAvP7q/f2+/niJwKNQ4ohWKnizHws=;
        b=pG3OBS6P6sxyLGqdMPhVdv6DCzuoXHMFLao2Gk2Tcizu28pZRlVpx4G3zepbwqN2c4
         GchnP9s68+8vxieK8xUs617WL8qX/4g3M8BJqMREFxFRjAlul41QUW+Q7+1bV3SS9FEb
         5/xextOA7YABghTjqwJgB5Wp3DElKcTC3BzQy5iooNOG/IlTJaIfH6V8yVWgsIzuZbDG
         27ofChdRHvTAHMqmCVAm7ACnnE5PgnBdhbd0P39Cub/ekdn6Viqz3Xb7SMLfiOhJUvv1
         I3LZ2rZulzuUM5OmSHV9MiGBcCWe7Qgsds9QCfeLSffiVnMKBpukwxGZxTC7N3Dm7bUo
         d0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=TndpLZJEfWm95krAvP7q/f2+/niJwKNQ4ohWKnizHws=;
        b=aRRZX29ln9126XFkUPadIbi4NzOG6QFQ4qApzgPdR+C5o0GxqWl9XZMhpl4or3wEqF
         56X6jslVih7c1VRUUy5lAfRyVWmvPKkRgD3wFEavcz+EYEICq9umNN15Hfppw4mqg/1T
         J00b+GHpsY1jVG6nN5Z915GaRgZyFxol+6mVOdDkePKNholSSwDAnwFc8WJjBf9ml0nk
         0GwAO+a4RmzK19BcWAi3463EleXm3NofQNv/LTMomjbTyjFruzAnfx2+0p05Di9fQAzA
         wzzXa4XjYhiYZ/TWU8XfDzz5wAENuQMgCQI9E/pqdhsvJgc/2Zw60+TV1ixXhlpT3tpC
         NwoA==
X-Gm-Message-State: AOAM5301V6SKCtyvNjVc5b4pJTCnz4n2pXPrW1Rot2icSuquUwkth6xK
        AEIvxGGH/5kQoh8TLxNvfb6mXeYC5SDUGjKSPMF5J4xfXaQHqg==
X-Google-Smtp-Source: ABdhPJyYZENOezz2iOdmyGc2/+OxOJ4x8reGza3Hd9X9KlvTUKvXtPSxSosTemyHHBITwIFAeLNGUMJ8gpRAT2Q1WCA=
X-Received: by 2002:a05:6e02:e94:: with SMTP id t20mr8175994ilj.10.1612051184077;
 Sat, 30 Jan 2021 15:59:44 -0800 (PST)
MIME-Version: 1.0
References: <20210130004401.2528717-1-ndesaulniers@google.com>
In-Reply-To: <20210130004401.2528717-1-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 31 Jan 2021 00:59:32 +0100
Message-ID: <CA+icZUXNx8fGi1_fEbmZFhMXp2DVmXgNrFm3hVW7r3VZoKM6Qw@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Kbuild: DWARF v5 support
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 30, 2021 at 1:44 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> DWARF v5 is the latest standard of the DWARF debug info format.
>
> DWARF5 wins significantly in terms of size and especially so when mixed
> with compression (CONFIG_DEBUG_INFO_COMPRESSED).
>
> Link: http://www.dwarfstd.org/doc/DWARF5.pdf
>
> Patch 1 is a cleanup that lays the ground work and isn't DWARF
> v5 specific.
> Patch 2 implements Kconfig and Kbuild support for DWARFv5.
>
> Changes from v6:
> * Reorder sections from linker script to match order from BFD's internal
>   linker script.
> * Add .debug_names section, as per Fangrui.
> * Drop CONFIG_DEBUG_INFO_DWARF2. Patch 0001 becomes a menu with 1
>   choice. GCC's implicit default version of DWARF has been DWARF v4
>   since ~4.8.
> * Modify the test script to check for the presence of
>   https://sourceware.org/bugzilla/show_bug.cgi?id=27195.

Just as a note: GNU Binutils 2.35.2 Release is now available

- Sedat -

[1] https://sourceware.org/pipermail/binutils/2021-January/115150.html

> * Drop the clang without integrated assembler block in
>   0002. Bumps the version requirement for GAS to 2.35.2, which isn't
>   released yet (but should be released soon).  Folks looking to test
>   with clang but without the integrated assembler should fetch
>   binutils-gdb, build it from source, add a symlink to
>   binutils-gdb/gas/as-new to binutils-gdb/gas/as, then prefix
>   binutils-gdb/gas/as to their $PATH when building the kernel.
>
> Changes from v5:
> * Drop previous patch 1, it has been accepted into kbuild:
>   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/commit/?h=kbuild&id=3f4d8ce271c7082be75bacbcbd2048aa78ce2b44
> * Trying to set -Wa,-gdwarf-4 in the earlier patch was the source of
>   additional complexity. Drop it that part of the patch. We can revisit
>   clang without the integrated assembler setting -Wa,-gdwarf-4 later.
>   That is a separate problem from generally supporting DWARF v5.
> * Rework the final patch for clang without the integrated assembler.
>   -Wa,-gdwarf-5 is required for DWARF5 in that case otherwise GAS will
>   not accept the assembler directives clang produces from C code when
>   generating asm.
>
> Changes from v4:
> * drop set -e from script as per Nathan.
> * add dependency on !CONFIG_DEBUG_INFO_BTF for DWARF v5 as per Sedat.
> * Move LLVM_IAS=1 complexity from patch 2 to patch 3 as per Arvind and
>   Masahiro. Sorry it took me a few tries to understand the point (I
>   might still not), but it looks much cleaner this way. Sorry Nathan, I
>   did not carry forward your previous reviews as a result, but I would
>   appreciate if you could look again.
> * Add Nathan's reviewed by tag to patch 1.
> * Reword commit message for patch 3 to mention LLVM_IAS=1 and -gdwarf-5
>   binutils addition later, and BTF issue.
> * I still happen to see a pahole related error spew for the combination
>   of:
>   * LLVM=1
>   * LLVM_IAS=1
>   * CONFIG_DEBUG_INFO_DWARF4
>   * CONFIG_DEBUG_INFO_BTF
>   Though they're non-fatal to the build. I'm not sure yet why removing
>   any one of the above prevents the warning spew. Maybe we'll need a v6.
>
> Changes from v3:
>
> Changes as per Arvind:
> * only add -Wa,-gdwarf-5 for (LLVM=1|CC=clang)+LLVM_IAS=0 builds.
> * add -gdwarf-5 to Kconfig shell script.
> * only run Kconfig shell script for Clang.
>
> Apologies to Sedat and Nathan; I appreciate previous testing/review, but
> I did no carry forward your Tested-by and Reviewed-by tags, as the
> patches have changed too much IMO.
>
> Changes from v2:
> * Drop two of the earlier patches that have been accepted already.
> * Add measurements with GCC 10.2 to commit message.
> * Update help text as per Arvind with help from Caroline.
> * Improve case/wording between DWARF Versions as per Masahiro.
>
> Changes from the RFC:
> * split patch in 3 patch series, include Fangrui's patch, too.
> * prefer `DWARF vX` format, as per Fangrui.
> * use spaces between assignment in Makefile as per Masahiro.
> * simplify setting dwarf-version-y as per Masahiro.
> * indent `prompt` in Kconfig change as per Masahiro.
> * remove explicit default in Kconfig as per Masahiro.
> * add comments to test_dwarf5_support.sh.
> * change echo in test_dwarf5_support.sh as per Masahiro.
> * remove -u from test_dwarf5_support.sh as per Masahiro.
> * add a -gdwarf-5 cc-option check to Kconfig as per Jakub.
>
> Nick Desaulniers (2):
>   Kbuild: make DWARF version a choice
>   Kbuild: implement support for DWARF v5
>
>  Makefile                          |  6 +++---
>  include/asm-generic/vmlinux.lds.h |  7 +++++-
>  lib/Kconfig.debug                 | 36 +++++++++++++++++++++++++------
>  scripts/test_dwarf5_support.sh    |  8 +++++++
>  4 files changed, 47 insertions(+), 10 deletions(-)
>  create mode 100755 scripts/test_dwarf5_support.sh
>
> --
> 2.30.0.365.g02bc693789-goog
>
