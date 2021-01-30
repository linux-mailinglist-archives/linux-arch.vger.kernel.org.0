Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20731309436
	for <lists+linux-arch@lfdr.de>; Sat, 30 Jan 2021 11:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhA3KQa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Jan 2021 05:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbhA3A4i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 19:56:38 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB8DC0613ED
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 16:44:06 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id t10so6707833pjw.4
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 16:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=KUXeI+hUBsy7nEA8u/qXzMH2pARJzoFj2ZnLfkMfS+w=;
        b=RaMAhkkjJ6XXcx39LcayZ9JymrrAyOz5zkWjZRqV4utzddyd8pH6WdzlF9btd3T/Oo
         fELDgxldzytr4XIYs5Q4gD3m3Uxg3AcnED3O3M8qKnGLHDseXHzHd5HeeCrQAK/iyO6u
         iDRVgpMY6JgZZdUqdPP2yaVhwuScXM2LvswF64lKX+OtD19NY2BDvLE6jtJ/khJ7LNWk
         VpxcpeKvw2SQ+2XcDurv9Ux7ncsPqxLpcOHCUs3h444+K55k6qIvgTH350/i8OY+y2Cr
         QwNMHxdRNBhKojn+PJhlZG9HGnCdaOIGA2S/ucU0EhVIxBcvbFWAZAmGXrRExTYXQJGm
         cEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=KUXeI+hUBsy7nEA8u/qXzMH2pARJzoFj2ZnLfkMfS+w=;
        b=lQ5h+CYkwy7EkeeSI1w09Nf7Bkq26qcu7bbqxginqfFSaJ/D/SQ4E1txA/6h07yo5c
         fmVjViT/PrepgN9vL2QMwME7RBcRmF8OE9D0Wqga2WKOnBn07aDEdPMhZDE+d3lE0LUL
         0E1bpxq3+6SmHH0+SbOU8UzjzyyK6htjVm6TVIaxCB+Jzj0nDCHaiyZzZ0+ZvrjnwX2K
         KbSvkpyI/F8mx5XxHK8CajFTHGBHTuHeSV9fg1qAwDHybUi+/W48ZsBblIcGAWf29lgK
         SQjpYXmZ3jR7jd3ewN/ODk0fqbcA45T1e01srDFcm2adVoYZsy/I1dmWIwJ181uvMxkZ
         DXnA==
X-Gm-Message-State: AOAM5331uaBAT2PVuq/tx2ZF3KP+ToyzBLPrmshAoJZeAb6JM0MD2R7n
        IgyCCpKeXMDpIk+PL2DAtTBRQofGnwqxXkRGMsc=
X-Google-Smtp-Source: ABdhPJxQfJZpO9vz0fLj+qXDqghR9+04BT6hTxwsLMbhr0n3YRIf4MoQMLuvKp/xyFo3YUpYvXauAyGgczWq1z6ti6E=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:aa7:8713:0:b029:1bf:ee0:34c4 with
 SMTP id b19-20020aa787130000b02901bf0ee034c4mr6604326pfo.55.1611967445701;
 Fri, 29 Jan 2021 16:44:05 -0800 (PST)
Date:   Fri, 29 Jan 2021 16:43:59 -0800
Message-Id: <20210130004401.2528717-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v7 0/2] Kbuild: DWARF v5 support
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DWARF v5 is the latest standard of the DWARF debug info format.

DWARF5 wins significantly in terms of size and especially so when mixed
with compression (CONFIG_DEBUG_INFO_COMPRESSED).

Link: http://www.dwarfstd.org/doc/DWARF5.pdf

Patch 1 is a cleanup that lays the ground work and isn't DWARF
v5 specific.
Patch 2 implements Kconfig and Kbuild support for DWARFv5.

Changes from v6:
* Reorder sections from linker script to match order from BFD's internal
  linker script.
* Add .debug_names section, as per Fangrui.
* Drop CONFIG_DEBUG_INFO_DWARF2. Patch 0001 becomes a menu with 1
  choice. GCC's implicit default version of DWARF has been DWARF v4
  since ~4.8.
* Modify the test script to check for the presence of
  https://sourceware.org/bugzilla/show_bug.cgi?id=27195.
* Drop the clang without integrated assembler block in
  0002. Bumps the version requirement for GAS to 2.35.2, which isn't
  released yet (but should be released soon).  Folks looking to test
  with clang but without the integrated assembler should fetch
  binutils-gdb, build it from source, add a symlink to
  binutils-gdb/gas/as-new to binutils-gdb/gas/as, then prefix
  binutils-gdb/gas/as to their $PATH when building the kernel.

Changes from v5:
* Drop previous patch 1, it has been accepted into kbuild:
  https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/commit/?h=kbuild&id=3f4d8ce271c7082be75bacbcbd2048aa78ce2b44
* Trying to set -Wa,-gdwarf-4 in the earlier patch was the source of
  additional complexity. Drop it that part of the patch. We can revisit
  clang without the integrated assembler setting -Wa,-gdwarf-4 later.
  That is a separate problem from generally supporting DWARF v5.
* Rework the final patch for clang without the integrated assembler.
  -Wa,-gdwarf-5 is required for DWARF5 in that case otherwise GAS will
  not accept the assembler directives clang produces from C code when
  generating asm.

Changes from v4:
* drop set -e from script as per Nathan.
* add dependency on !CONFIG_DEBUG_INFO_BTF for DWARF v5 as per Sedat.
* Move LLVM_IAS=1 complexity from patch 2 to patch 3 as per Arvind and
  Masahiro. Sorry it took me a few tries to understand the point (I
  might still not), but it looks much cleaner this way. Sorry Nathan, I
  did not carry forward your previous reviews as a result, but I would
  appreciate if you could look again.
* Add Nathan's reviewed by tag to patch 1.
* Reword commit message for patch 3 to mention LLVM_IAS=1 and -gdwarf-5
  binutils addition later, and BTF issue.
* I still happen to see a pahole related error spew for the combination
  of:
  * LLVM=1
  * LLVM_IAS=1
  * CONFIG_DEBUG_INFO_DWARF4
  * CONFIG_DEBUG_INFO_BTF
  Though they're non-fatal to the build. I'm not sure yet why removing
  any one of the above prevents the warning spew. Maybe we'll need a v6.

Changes from v3:

Changes as per Arvind:
* only add -Wa,-gdwarf-5 for (LLVM=1|CC=clang)+LLVM_IAS=0 builds.
* add -gdwarf-5 to Kconfig shell script.
* only run Kconfig shell script for Clang.

Apologies to Sedat and Nathan; I appreciate previous testing/review, but
I did no carry forward your Tested-by and Reviewed-by tags, as the
patches have changed too much IMO.

Changes from v2:
* Drop two of the earlier patches that have been accepted already.
* Add measurements with GCC 10.2 to commit message.
* Update help text as per Arvind with help from Caroline.
* Improve case/wording between DWARF Versions as per Masahiro.

Changes from the RFC:
* split patch in 3 patch series, include Fangrui's patch, too.
* prefer `DWARF vX` format, as per Fangrui.
* use spaces between assignment in Makefile as per Masahiro.
* simplify setting dwarf-version-y as per Masahiro.
* indent `prompt` in Kconfig change as per Masahiro.
* remove explicit default in Kconfig as per Masahiro.
* add comments to test_dwarf5_support.sh.
* change echo in test_dwarf5_support.sh as per Masahiro.
* remove -u from test_dwarf5_support.sh as per Masahiro.
* add a -gdwarf-5 cc-option check to Kconfig as per Jakub.

Nick Desaulniers (2):
  Kbuild: make DWARF version a choice
  Kbuild: implement support for DWARF v5

 Makefile                          |  6 +++---
 include/asm-generic/vmlinux.lds.h |  7 +++++-
 lib/Kconfig.debug                 | 36 +++++++++++++++++++++++++------
 scripts/test_dwarf5_support.sh    |  8 +++++++
 4 files changed, 47 insertions(+), 10 deletions(-)
 create mode 100755 scripts/test_dwarf5_support.sh

-- 
2.30.0.365.g02bc693789-goog

