Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AC45A3B0E
	for <lists+linux-arch@lfdr.de>; Sun, 28 Aug 2022 04:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiH1CpI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Aug 2022 22:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiH1CpH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 22:45:07 -0400
Received: from condef-04.nifty.com (condef-04.nifty.com [202.248.20.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA6A13DDC
        for <linux-arch@vger.kernel.org>; Sat, 27 Aug 2022 19:44:58 -0700 (PDT)
Received: from conuserg-11.nifty.com ([10.126.8.74])by condef-04.nifty.com with ESMTP id 27S2eRxw013979
        for <linux-arch@vger.kernel.org>; Sun, 28 Aug 2022 11:40:27 +0900
Received: from localhost.localdomain (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 27S2e6Gi030639;
        Sun, 28 Aug 2022 11:40:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 27S2e6Gi030639
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661654407;
        bh=ocidS8XFOfEEmbYSEB7PbP5TSOCw4R4WsbL4pz/6neY=;
        h=From:To:Cc:Subject:Date:From;
        b=bPD+Cd/zVbPh7T0NQdMUOA5P+rhcaqnY0CMBNs0winyjqdC17dDXLrD/PiHC705ZD
         UqhTAwTy4d0R0709nVMDi/e7hIL7KKqv1XfyqSl9VWEf3be9Xx1gawCHfCARE24Tz+
         GyYEH4tmUVXCSFw3yjBcV4mRTAV6Rpy1Qcwy3R789JDYnZYkGrCVoykupDZgx9jPrk
         u4C2JoBsTwfjARnwTZNBdGifWainPetMXUpduMj7ATZLOXqX9K6xRz3DYWO6rqD+ay
         93wU39xVn7ttWVgQbnmjZ4LPeAX1Il9GvBo3yNmFzHbyPUzpp5BA1O9wCxPoX/FxdW
         vIK/keTPW1CTQ==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 00/15] kbuild: various cleanups
Date:   Sun, 28 Aug 2022 11:39:48 +0900
Message-Id: <20220828024003.28873-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

  - Avoid updating init/built-in.a twice
  - Run modpost just once instead of twice
  - Link vmlinux and modules in parallel
  - Remove head-y syntax

These are ground works to make the further refactoring possible.

This patch set is applicable after the following series:
  https://patchwork.kernel.org/project/linux-kbuild/list/?series=669437


Masahiro Yamada (15):
  kbuild: remove duplicated dependency between modules and modules_check
  kbuild: refactor single builds of *.ko
  kbuild: move 'PHONY += modules_prepare' to the common part
  init/version.c: remove #include <linux/version.h>
  kbuild: build init/built-in.a just once
  kbuild: generate include/generated/compile.h in top Makefile
  scripts/mkcompile_h: move LC_ALL=C to '$LD -v'
  Revert "kbuild: Make scripts/compile.h when sh != bash"
  kbuild: rename modules.order in sub-directories to .modules.order
  kbuild: move core-y in top Makefile to ./Kbuild
  kbuild: move .vmlinux.objs rule to Makefile.modpost
  kbuild: move vmlinux.o rule to the top Makefile
  kbuild: unify two modpost invocations
  kbuild: use obj-y instead extra-y for objects placed at the head
  kbuild: remove head-y syntax

 Documentation/kbuild/makefiles.rst          |  27 +----
 Kbuild                                      |  16 +++
 Makefile                                    | 120 ++++++++++++--------
 arch/alpha/Makefile                         |   2 -
 arch/alpha/kernel/Makefile                  |   4 +-
 arch/arc/Makefile                           |   2 -
 arch/arc/kernel/Makefile                    |   4 +-
 arch/arm/Makefile                           |   3 -
 arch/arm/kernel/Makefile                    |   4 +-
 arch/arm64/Makefile                         |   3 -
 arch/arm64/kernel/Makefile                  |   4 +-
 arch/csky/Makefile                          |   2 -
 arch/csky/kernel/Makefile                   |   4 +-
 arch/hexagon/Makefile                       |   2 -
 arch/hexagon/kernel/Makefile                |   3 +-
 arch/ia64/Makefile                          |   1 -
 arch/ia64/kernel/Makefile                   |   4 +-
 arch/loongarch/Makefile                     |   2 -
 arch/loongarch/kernel/Makefile              |   4 +-
 arch/m68k/68000/Makefile                    |   2 +-
 arch/m68k/Makefile                          |   9 --
 arch/m68k/coldfire/Makefile                 |   2 +-
 arch/m68k/kernel/Makefile                   |  21 ++--
 arch/microblaze/Makefile                    |   1 -
 arch/microblaze/kernel/Makefile             |   4 +-
 arch/mips/Makefile                          |   2 -
 arch/mips/kernel/Makefile                   |   4 +-
 arch/nios2/Makefile                         |   1 -
 arch/nios2/kernel/Makefile                  |   2 +-
 arch/openrisc/Makefile                      |   2 -
 arch/openrisc/kernel/Makefile               |   4 +-
 arch/parisc/Makefile                        |   2 -
 arch/parisc/kernel/Makefile                 |   4 +-
 arch/powerpc/Makefile                       |  12 --
 arch/powerpc/kernel/Makefile                |  22 ++--
 arch/riscv/Makefile                         |   2 -
 arch/riscv/kernel/Makefile                  |   2 +-
 arch/s390/Makefile                          |   2 -
 arch/s390/boot/version.c                    |   1 +
 arch/s390/kernel/Makefile                   |   4 +-
 arch/sh/Makefile                            |   2 -
 arch/sh/kernel/Makefile                     |   4 +-
 arch/sparc/Makefile                         |   2 -
 arch/sparc/kernel/Makefile                  |   3 +-
 arch/x86/Makefile                           |   5 -
 arch/x86/boot/compressed/kaslr.c            |   1 +
 arch/x86/boot/version.c                     |   1 +
 arch/x86/kernel/Makefile                    |  10 +-
 arch/xtensa/Makefile                        |   2 -
 arch/xtensa/kernel/Makefile                 |   4 +-
 init/Makefile                               |  55 ++++++---
 init/build-version                          |  10 ++
 init/version-timestamp.c                    |  31 +++++
 init/version.c                              |  37 +++---
 scripts/Makefile.build                      |  20 ++--
 scripts/Makefile.lib                        |   8 +-
 scripts/Makefile.modfinal                   |   2 +-
 scripts/Makefile.modpost                    | 112 ++++++++----------
 scripts/Makefile.vmlinux_o                  |   6 +-
 scripts/clang-tools/gen_compile_commands.py |  19 +---
 scripts/head-object-list.txt                |  53 +++++++++
 scripts/link-vmlinux.sh                     |  51 ++-------
 scripts/mkcompile_h                         |  96 ++--------------
 63 files changed, 393 insertions(+), 457 deletions(-)
 create mode 100755 init/build-version
 create mode 100644 init/version-timestamp.c
 create mode 100644 scripts/head-object-list.txt

-- 
2.34.1

