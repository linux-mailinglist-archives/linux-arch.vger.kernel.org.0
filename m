Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2492F87F8
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jan 2021 22:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbhAOVyN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 16:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbhAOVyN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jan 2021 16:54:13 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2F2C061757;
        Fri, 15 Jan 2021 13:53:33 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id b19so18514641ioa.9;
        Fri, 15 Jan 2021 13:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=QGgWdRhGlMRkOeIpOovebewRZU6OcvKJKaY936bfj8M=;
        b=HeIuPg6FTdGEmh+d9FY5EwtF4rLQW+LXH364RVzngBdhKa6ETh+YEOiTWXxmPEEzsu
         AeaXKeIXkCZUyKopa+1LJMNV0no7OEZ+fli3UfvRWw/N4MG9i3LeuUjC9W64eDgovb9D
         snGKnsgfnvjSTelvI8k9MuiPP/Co7b2JOT+HLA/wZC8EEv6cjWs2GywOOx0fEMqbexUJ
         YCo6SfxqEXtkeuf4K9LJOgBRaHQlmqvpIE4UZY/KVx1KK09krEUMEQm4K/fro6OtakSR
         n1TKPD7fHQSCERyoHCZDyQ14cU3JYRKWPSoYEouEnhae7AnV4tuyyl1UMO5iu7fosep3
         5aoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=QGgWdRhGlMRkOeIpOovebewRZU6OcvKJKaY936bfj8M=;
        b=HZdFmEDmdDkRjklP2sbjIHRJYw1JviViin4++XOHMPzmD1Li9Dek+HekQoEFOcT2p2
         Z+kuXW9U5CQuF9If5eK1vebgYDsPsszO1zFbIZTTeQmjavQY3MjINafrAoi+6PWWKQxE
         ZkPiIuDZcNKs7/r5cC4cT6oJ/BmByceUxbZl9s8x6UZoBrycd6bY8J0A2JpT7IQLWkRO
         wXO8A23fD1T1ON3KI/QN53YE/0kbazPHjYWK0QT2wGUxQkU0wPOHzwhRdYQhBqV3uXBV
         qay1i4za4oD3bAZcycYCvRYzO0RGkWX69tdVeH0f0ViPEdcoqgYK6/BNoZ986RA/h/JS
         pq9A==
X-Gm-Message-State: AOAM530FdffQfqK8D81j3xBgvLnrX7nisrZFGXnFvHxQpIN4tOpXNvjx
        aPO+VUylCN6eWDDqz5i2++Grv8l4V0M3ToHfDCg=
X-Google-Smtp-Source: ABdhPJxln8CIUWXmSmXFVncexVKeB01GyfAU5+JXqmzqepstvWhc3yxpmHjhBEMcQMbDdFOKNc8ynNai4sFcUJj606A=
X-Received: by 2002:a02:2ace:: with SMTP id w197mr12068965jaw.132.1610747612529;
 Fri, 15 Jan 2021 13:53:32 -0800 (PST)
MIME-Version: 1.0
References: <20210115210616.404156-1-ndesaulniers@google.com>
In-Reply-To: <20210115210616.404156-1-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 15 Jan 2021 22:53:21 +0100
Message-ID: <CA+icZUVp+JNq89uc_DyWC6zh5=kLtUr7eOxHizfFggnEVGJpqw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Kbuild: DWARF v5 support
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

On Fri, Jan 15, 2021 at 10:06 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> DWARF v5 is the latest standard of the DWARF debug info format.
>
> DWARF5 wins significantly in terms of size when mixed with compression
> (CONFIG_DEBUG_INFO_COMPRESSED).
>
> Link: http://www.dwarfstd.org/doc/DWARF5.pdf
>
> Patch 1 is a cleanup from Masahiro and isn't DWARF v5 specific.
> Patch 2 is a cleanup that lays the ground work and isn't DWARF
> v5 specific.
> Patch 3 implements Kconfig and Kbuild support for DWARFv5.
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

En plus, I encountered breakage with GCC v10.2.1 and LLVM=1 and
CONFIG_DEBUG_INFO_DWARF4.
So might be good to add a "depends on !DEBUG_INFO_BTF" in this combination.

I had some other small nits commented in the single patches.

As requested in your previous patch-series, feel free to add my:

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -

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
> *** BLURB HERE ***
>
> Masahiro Yamada (1):
>   Remove $(cc-option,-gdwarf-4) dependency from CONFIG_DEBUG_INFO_DWARF4
>
> Nick Desaulniers (2):
>   Kbuild: make DWARF version a choice
>   Kbuild: implement support for DWARF v5
>
>  Makefile                          | 13 +++++++---
>  include/asm-generic/vmlinux.lds.h |  6 ++++-
>  lib/Kconfig.debug                 | 42 +++++++++++++++++++++++++------
>  scripts/test_dwarf5_support.sh    |  8 ++++++
>  4 files changed, 57 insertions(+), 12 deletions(-)
>  create mode 100755 scripts/test_dwarf5_support.sh
>
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>
