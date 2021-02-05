Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4388C31125E
	for <lists+linux-arch@lfdr.de>; Fri,  5 Feb 2021 21:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhBESlw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Feb 2021 13:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbhBESkq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Feb 2021 13:40:46 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C60FC0613D6
        for <linux-arch@vger.kernel.org>; Fri,  5 Feb 2021 12:22:31 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id e5so6871957qkn.2
        for <linux-arch@vger.kernel.org>; Fri, 05 Feb 2021 12:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=JkiU6LubiRQMiRTUkzQ3xqlvscsZlRnvwncDVkGj4+8=;
        b=rRrebpAL4dPbI8AaS2ldSzHnzsLzMqVHOKpPxQ6HCIgGLFfsCX+3l9oKDT0/RNXj0I
         jpn7PrLJ6s/aXTSB81qSw/Yvrh2JcB07gt/TccdR6O21J/+CkBXlfgcfLn5Z23J9B+qU
         9lK+mBQEwoW6LtRMXQwPKyr8Yh+3nC7nK3VD3Jr44Vwq0yQHiH/2yogmTZ5UmHJHSN62
         AMIm/X7p0G04XK+GbxT3h6n3fiLNHfdAs4lwNOCh9u7wIBeMxaxxjlrwzvvlwXVSXz1n
         mjQVjpVeNT+x9tlzTj6sbwfxqnKPchVV6trcpuDSIiHRugFo2i48ClTaGvuDFX+IR3e9
         NP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=JkiU6LubiRQMiRTUkzQ3xqlvscsZlRnvwncDVkGj4+8=;
        b=CIXM4tbg6UIOD3Jjy2L2xikMa0Mh/9W15zquox5XnwtdTF7R22GngEdaLVek83Hm2d
         S53G0KgOEl1h021HxiYHu9xKfREpFvZdrV/VQIpfcehsSqIVHNEv57tVkGso28L1TRDT
         PnJCOcZ8aIhd2behTEv7eIHmVRCu+IQ++xoIQN6AMl1CRbvy9LY6x9f1ARhn4GjF0j9B
         oodRLeqUbJ8UwnhmaapmYjAPA1OX/GuN/U3orJH0qUYmRgHDg2puWhy6wApLUb7YDqhe
         cCCOOYAfwciKbUbXgllb2EtaZDh9Ci/K+jOPm1jWaMvm8j/Z8uDpB6gkxP5wTMLiqHlh
         19Lg==
X-Gm-Message-State: AOAM532nj/lr3UrEUVDlGsSU5aiMl+F3PrzrmQq43sSh5OF3mXGa98hA
        yaCZmZGfKcEAfO7v/HWSiRiCqYP2EfkMVbyUfEE=
X-Google-Smtp-Source: ABdhPJxjyhQcTVKXyi8QxMs0J/iUleLIs8/Q7zrtBiY36TrxxBeGn8chzArDZJ1st/J1z8x1RkCfNhb7fXw+3rczCfg=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:fce9:1439:f67f:bf26])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:abce:: with SMTP id
 k14mr6218548qvb.23.1612556550018; Fri, 05 Feb 2021 12:22:30 -0800 (PST)
Date:   Fri,  5 Feb 2021 12:22:17 -0800
Message-Id: <20210205202220.2748551-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v9 0/3] Kbuild: DWARF v5 support
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
        Mark Wielaard <mark@klomp.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DWARF v5 is the latest standard of the DWARF debug info format.

DWARF5 wins significantly in terms of size and especially so when mixed
with compression (CONFIG_DEBUG_INFO_COMPRESSED).

Link: http://www.dwarfstd.org/doc/DWARF5.pdf

Patch 1 places the DWARF v5 sections explicitly in the kernel linker
script.
Patch 2 modifies Kconfig for DEBUG_INFO_DWARF4 to be used as a fallback.
Patch 3 adds an explicit Kconfig for DWARF v5 for clang and older GCC
where the implicit default DWARF version is not 5.

Changes from v8:
* Separate out the linker script changes (from v7 0002). Put those
  first. Carry Reviewed by and tested by tags.  Least contentious part
  of the series. Tagged for stable; otherwise users upgrading to GCC 11
  may find orphan section warnings from the implicit default DWARF
  version changing and generating the new debug info sections.
* Add CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT in 0002, make it the
  default rather than CONFIG_DEBUG_INFO_DWARF4, as per Mark, Jakub,
  Arvind.
* Drop reviewed by and tested by tags for 0002 and 0003; sorry
  reviewers/testers, but I view that as a big change. I will buy you
  beers if you're fatigued, AND for the help so far. I appreciate you.
* Rework commit one lines, and commit messages somewhat.
* Remove Kconfig help text about v4 being "bigger."
* I didn't touch the BTF config from v8, but suggest the BTF folks
  consider
  https://lore.kernel.org/bpf/20210111180609.713998-1-natechancellor@gmail.com/
  that way we can express via Kconfig that older version of pahole are
  in conflict with other Kconfig options.

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

Nick Desaulniers (3):
  vmlinux.lds.h: add DWARF v5 sections
  Kbuild: make DWARF version a choice
  Kconfig: allow explicit opt in to DWARF v5

 Makefile                          |  6 ++--
 include/asm-generic/vmlinux.lds.h |  7 ++++-
 lib/Kconfig.debug                 | 48 +++++++++++++++++++++++++++----
 scripts/test_dwarf5_support.sh    |  8 ++++++
 4 files changed, 61 insertions(+), 8 deletions(-)
 create mode 100755 scripts/test_dwarf5_support.sh

-- 
2.30.0.365.g02bc693789-goog

