Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C4630ECDD
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 08:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbhBDG7i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 01:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhBDG7h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 01:59:37 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE99CC061573;
        Wed,  3 Feb 2021 22:58:56 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id f8so2145883ion.4;
        Wed, 03 Feb 2021 22:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=SQ3u9i9q5D8QjR1iu0LCTn0usPDvt2B5f9qi7+PYlHs=;
        b=jFntBNx7YoQ+SGvrIhBOXeJVL/mWL06558GnBtTFatcxbva0y5Sr8wpZ32+ejqj22p
         kJjLl6r+kvxccZWG8RXt94JppYBHh/MByv/qya8HjDCdVlw9GWMV3siw4XbxuKny9c53
         FHI94rSPcdHiwNfbOwrL9iq2IpTNHu6eNd1neZQRVfbXFEwyammqh/jq1jF/G+dZlz3h
         SJQnlFWjaRjYIX0CbjuMts/KIxo8aqfA2qxoy8S4iZmt+XRdaTCFQWE/E//fabYP2k02
         4CH7W54LgLbu/6da9EAjAkdHIzd5C/hZ7XlsrewqNew2hqQC5spqNseecTfoD3TKtqik
         Ll2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=SQ3u9i9q5D8QjR1iu0LCTn0usPDvt2B5f9qi7+PYlHs=;
        b=s3vHBReP+QIwWl3iBUyPsdXyyVpl3SKHZ0F0ovO1HIqibhBYwhJUj0o9xiKgB44wnG
         /tQl9NzaI6FYSBK+lYHTC4aBmvp9S0o36wYtjqb47Hc05ePQc+hRxUMWphbPuMOYtLWm
         4T/gdrVBHFPoDKUGs+OSnCHTsR8pe7iEtcflDUq46CHcevjYqTq6W7Kgm+4H8Kcl8nBR
         /6NFu4mQGPZWeFpXvO9MqmMi/m1D0LYYQbyceb9nOHJOaeogsz+aurKRxrZhAGy6vak6
         TgxciENtb86/TNYNKnAYjeZVZb8dZPvfr1pd681TqTCofLFUJ+V16IXZnPZlfyeIxTE8
         /hcQ==
X-Gm-Message-State: AOAM531/C1h41aWHyG030l1WYi3yxuUjKTCn7hQCSjqJLO1W+I1DF+ul
        nmy0I+zH9aV81L/5FuXdBkcOa8VGcYrLzb0AIW8=
X-Google-Smtp-Source: ABdhPJyCAb2finNxETHrnNmoK+3ofOoDzahH3SlZwUu2HV/KusbAptMCR5ncvN55a+0r6QZM78XjI6AqxQcRA5A/gtQ=
X-Received: by 2002:a6b:f112:: with SMTP id e18mr5554686iog.57.1612421936168;
 Wed, 03 Feb 2021 22:58:56 -0800 (PST)
MIME-Version: 1.0
References: <20210204064037.1281726-1-ndesaulniers@google.com>
In-Reply-To: <20210204064037.1281726-1-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 4 Feb 2021 07:58:44 +0100
Message-ID: <CA+icZUVVcP5MSUSDM18Wab46n-20eskRE59akdwfxXKpKXDOFg@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] Kbuild: DWARF v5 support
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
        Arvind Sankar <nivedita@alum.mit.edu>,
        Chris Murphy <bugzilla@colorremedies.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 4, 2021 at 7:40 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
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
> Changes from v7:
> (Strictly commit message changes)
> * Pick up Nathan's reviewed by tags for both patches.
> * Add note about only modifying compiler dwarf info, not assembler dwarf
>   info, as per Nathan.
> * Add link to Red Hat bug report and Chris' reported by on patch 2.
> * Add more info from Jakub on patch 2 commit message.
> * Reorder info about validating version, noting the tree is not "clean"
>   in the sense that parts mess up existing CFLAGS, or don't use
>   DEBUG_CFLAGS. I will not be adding such cleanups to this series. They
>   can be done AFTER.
> * Update note about 2.35.2 (rather than include the full text Jakub
>   wrote on it in https://patchwork.kernel.org/project/linux-kbuild/patch/20201022012106.1875129-1-ndesaulniers@google.com/#23727667).
> * Add note that GCC 11 has changed the implicit default version.
>

I have intensively tested a lot of versions of this series and some
other issues reported and got fixed.

So my comments for followers:

[ Download v8 with b4 ]

link="https://lore.kernel.org/r/20210204064037.1281726-1-ndesaulniers@google.com"
b4 -d am $link

[ Pre-Patch before applying v8 ]

"kbuild: Remove $(cc-option,-gdwarf-4) dependency from DEBUG_INFO_DWARF4"

https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/commit/?h=kbuild&id=3f4d8ce271c7082be75bacbcbd2048aa78ce2b44

[ DEBUG_CFLAGS thread and fix ]

https://marc.info/?t=161233893400006&r=1&w=2
https://marc.info/?l=linux-kbuild&m=161233892923723&w=2

Feel free to be more verbose and include links (to patches).

I guess I need to test harder to get a Tested-by credit :-)?

Thanks for v8, I will use it for some testing with BTF/pahole.

- Sedat -

> Changes from v6:
> * Reorder sections from linker script to match order from BFD's internal
>   linker script.
> * Add .debug_names section, as per Fangrui.
> * Drop CONFIG_DEBUG_INFO_DWARF2. Patch 0001 becomes a menu with 1
>   choice. GCC's implicit default version of DWARF has been DWARF v4
>   since ~4.8.
> * Modify the test script to check for the presence of
>   https://sourceware.org/bugzilla/show_bug.cgi?id=27195.
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
