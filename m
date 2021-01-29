Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0104308E0C
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 21:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhA2UFB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 15:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbhA2UEU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 15:04:20 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667DDC061574;
        Fri, 29 Jan 2021 12:03:39 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e1so9624652ilu.0;
        Fri, 29 Jan 2021 12:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=YaCjUlgtnJbuF7k3Cdbe1kjQpNgRK/ArnNzFGruCqYY=;
        b=UVhSwPvM3QfUFfCm8lm4IU8Y599dLV63eUv/RYVretCABjCdN0pObZgCIh8pdrch8X
         oW2i+VJ3AQn3b3zhp+9lFruHewVfWG4zcQmLUDGN8QxmMnBpJ4YF0OYQiftFN65+cdJo
         kmpFF2LdS3gcr5ss0GlXVdaWhxByYrLF+7nlf/IqB+pnHwyf38J7VFRrMaLshaOSL9I1
         QQlW9Wmxu6abTS/XCXx0Sx5IRVCXya50UXzNX0iNJvMi+wa28BgFg1kEVBP2/eFsxkZj
         7C8eiSDDXCxdGj/qFtdPyoYQX6Q0mZuwxg80yu6U6z5KUvV5ses22iRgUWaBZNOZQ/fj
         UrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=YaCjUlgtnJbuF7k3Cdbe1kjQpNgRK/ArnNzFGruCqYY=;
        b=ZfSOiyej/MkUFJp7vGRtnXjdPYxwtVPX2De4FqjFCWYK5bmT2+19Lp1oWWgxYD0Dln
         9kbE6rosLwIGnzLpprzyxWJwK4McpqaSe2yHXPa9jZ1HJibDDFz5H7WpveNdRFlG+rXG
         qvaOhrFut2kcbD6+P79asEbqe4RwMylHPXerAAd53hbjWEz6GNeRw23QDT5iKvX8r3yF
         eHHYeNO2Uv218W9KqDNQ9C45esRe/jU4P5OFIH+79JJqypeYjGdTLF6pF9gNgGIrphIB
         fBSJ8P9luUAMBMGTLdC6NnfGx7y/pNcfM/zQjukU3OTzViSEXu8+fLvWI6Q5UQbHy5Cy
         GcEw==
X-Gm-Message-State: AOAM530d56IQ0rs8o1FK9BdmLdUWahAdPNp7AX0Ck/K/MyzErKcQG/yk
        GYU37qgaqSua+nPeC5Fy3GHdTEhPfPZ33KvQBa8=
X-Google-Smtp-Source: ABdhPJzbTlPSm+UXMrYtD/lP36ixWyWD5Y62dzM4WvwAnxawQwS5lCxewpOAm6sZYPRsHYr7Gce/9A93nGfbb1z7JyI=
X-Received: by 2002:a05:6e02:e94:: with SMTP id t20mr4497910ilj.10.1611950618603;
 Fri, 29 Jan 2021 12:03:38 -0800 (PST)
MIME-Version: 1.0
References: <20210129194318.2125748-1-ndesaulniers@google.com>
In-Reply-To: <20210129194318.2125748-1-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 29 Jan 2021 21:03:26 +0100
Message-ID: <CA+icZUUfpDwWf4xErSHXmeGDoT1VRWda+q1z+SRnets_NnUyGg@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Kbuild: DWARF v5 support
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
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 8:43 PM Nick Desaulniers
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

Thanks for v6 - I queued it up in my custom patch-series.

- Sedat -

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
>  Makefile                          | 16 ++++++++++--
>  include/asm-generic/vmlinux.lds.h |  6 ++++-
>  lib/Kconfig.debug                 | 41 ++++++++++++++++++++++++++-----
>  scripts/test_dwarf5_support.sh    |  8 ++++++
>  4 files changed, 62 insertions(+), 9 deletions(-)
>  create mode 100755 scripts/test_dwarf5_support.sh
>
> --
> 2.30.0.365.g02bc693789-goog
>
