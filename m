Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E597130EC9A
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 07:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbhBDGlh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 01:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhBDGlZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 01:41:25 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F95CC061786
        for <linux-arch@vger.kernel.org>; Wed,  3 Feb 2021 22:40:45 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id s66so1745846qkh.10
        for <linux-arch@vger.kernel.org>; Wed, 03 Feb 2021 22:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=kfhAID8FntM38gEbpNWw0Qb4/ZW9dFPJ6TFlpp5/51k=;
        b=c5tviGsRoAVHOIRw2d4vtpDIPjcg+4ClYGroIy+eaUzpEQEjqjd3fij+6fWrV818jS
         BfmPn7NOFlUA4zs8yN4L2zY6bjeut/zE/1ikOEW861sQKxhd+aCyJtzmX2Ago89YnDqF
         tggLrPhCU3w3HslhguiRB6/+JRZX+m2cq/MZl79Vsuatzqw12mwM7FMXM6X0l+usb566
         EfAW/t9cC6gRe0P80N+sV0P7oZMjEmQ9smDKI4cebeQUGTFliOkJwMGFsby9PX+XY2L6
         UpiNr1UqKuuQH8Yv958doiui65kPlx4gYZ5xo5mu/rEdspV3IjhisbKRCOcvXPF8kF8Z
         lmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=kfhAID8FntM38gEbpNWw0Qb4/ZW9dFPJ6TFlpp5/51k=;
        b=XbVuSPZ6haRFmcaniv09tLkVD+OWEq4bWZv/Nk6PPYHBBuFMXowllCosd0GTZJpoy9
         usml2gPF4fgYE4exBLpY4wbYtX50NeYNhxVzjSHFW4g0JyNkjZNRx5lZ18pHXhxPMf32
         xpXdGsFvelXobtnAXGk5n00VsBuhrNpNHk8nebhz5dmzM8sjnskwWMcqU5s9uRyMmzfM
         peLt9Vcu0U19yeOmTdNb+2N+1oP4VXAh2TdhKFnQ5WFhZE86mY9BE4JkKh1x9i+ogFrs
         wyBQaTHDE16a66Hzq2bIcd3tvZRRJ7bj0mCXHpHpvw4qdy99akZfPxbv5OsorjW0xZxX
         j+Fw==
X-Gm-Message-State: AOAM532wZMKDefk437rZxrWqoYPvtKpa/9D1Xs9nIcilW4MxYVJFjohc
        sll6339l14pxq5NnfQ2WJoKZe6iq//6CBHNKBtQ=
X-Google-Smtp-Source: ABdhPJx9MrKKUwnHEkYMA8ueJoXMU2xY+DSGc706gxlFo3X0rOXOgZPqFXyT3P9i/Ed4JG9l5vCwh0Gajw0sUqvhxo4=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:e070:bc84:c4fd:eb02])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:f7d2:: with SMTP id
 f18mr6141066qvo.39.1612420844219; Wed, 03 Feb 2021 22:40:44 -0800 (PST)
Date:   Wed,  3 Feb 2021 22:40:35 -0800
Message-Id: <20210204064037.1281726-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v8 0/2] Kbuild: DWARF v5 support
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
        Chris Murphy <bugzilla@colorremedies.com>,
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

Changes from v7:
(Strictly commit message changes)
* Pick up Nathan's reviewed by tags for both patches.
* Add note about only modifying compiler dwarf info, not assembler dwarf
  info, as per Nathan.
* Add link to Red Hat bug report and Chris' reported by on patch 2.
* Add more info from Jakub on patch 2 commit message.
* Reorder info about validating version, noting the tree is not "clean"
  in the sense that parts mess up existing CFLAGS, or don't use
  DEBUG_CFLAGS. I will not be adding such cleanups to this series. They
  can be done AFTER.
* Update note about 2.35.2 (rather than include the full text Jakub
  wrote on it in https://patchwork.kernel.org/project/linux-kbuild/patch/20201022012106.1875129-1-ndesaulniers@google.com/#23727667).
* Add note that GCC 11 has changed the implicit default version.

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

