Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD4A5E8F35
	for <lists+linux-arch@lfdr.de>; Sat, 24 Sep 2022 20:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiIXSUc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 24 Sep 2022 14:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiIXSU1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Sep 2022 14:20:27 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7F12E9FF;
        Sat, 24 Sep 2022 11:20:24 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 28OIJItQ005682;
        Sun, 25 Sep 2022 03:19:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 28OIJItQ005682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664043559;
        bh=7O1zNbb37gHsk88UbIF8BQdtRIn/7u/0EkM8udldGLc=;
        h=From:To:Cc:Subject:Date:From;
        b=T5lXEuxxEAdJ0dawvvQQL6k52NKk5pH803QUMqgdiKNNMOlZ/WOWDZvk9PUdH8G45
         DJUMxltvyDQSY3tRZ7b85R0fuzgTcIOIJrKcyY3Vdn6Dst5+dtjSLPT6hiJsftBH9l
         lk26V2+Xtc48J0A5DX3y6v457glP+RCSfJc0Y+3nTcLT9f8QwxmUgUAFsVdoXsSVeL
         pKdz4yXDPxxHjwcruWIduLbYNyVdJCD3ohQDdf1/YkyOFb863x26/kyD62ts9ylvlT
         2v9UHneXR/uO/+FlPHszmKyqi4ljShEbRu4ILS648qll3EHiTgz+Y3Cd4fRYp7v5xP
         9BB3LkXzvfFWQ==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v3 0/7] kbuild: various cleanups
Date:   Sun, 25 Sep 2022 03:19:08 +0900
Message-Id: <20220924181915.3251186-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

 - Link vmlinux and modules in parallel
 - Remove head-y syntax


Masahiro Yamada (7):
  kbuild: hard-code KBUILD_ALLDIRS in scripts/Makefile.package
  kbuild: list sub-directories in ./Kbuild
  kbuild: move .vmlinux.objs rule to Makefile.modpost
  kbuild: move vmlinux.o rule to the top Makefile
  kbuild: unify two modpost invocations
  kbuild: use obj-y instead extra-y for objects placed at the head
  kbuild: remove head-y syntax

 Documentation/kbuild/makefiles.rst          |  27 +----
 Kbuild                                      |  24 ++++
 Makefile                                    | 119 +++++++++++---------
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
 arch/m68k/kernel/Makefile                   |  23 ++--
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
 arch/powerpc/kernel/Makefile                |  20 ++--
 arch/riscv/Makefile                         |   2 -
 arch/riscv/kernel/Makefile                  |   2 +-
 arch/s390/Makefile                          |   2 -
 arch/s390/kernel/Makefile                   |   4 +-
 arch/sh/Makefile                            |   2 -
 arch/sh/kernel/Makefile                     |   4 +-
 arch/sparc/Makefile                         |   2 -
 arch/sparc/kernel/Makefile                  |   3 +-
 arch/x86/Makefile                           |   5 -
 arch/x86/kernel/Makefile                    |  10 +-
 arch/xtensa/Makefile                        |   2 -
 arch/xtensa/kernel/Makefile                 |   4 +-
 scripts/Makefile.lib                        |   2 +
 scripts/Makefile.modfinal                   |   2 +-
 scripts/Makefile.modpost                    | 112 ++++++++----------
 scripts/Makefile.package                    |   5 +-
 scripts/Makefile.vmlinux_o                  |   6 +-
 scripts/clang-tools/gen_compile_commands.py |  19 +---
 scripts/head-object-list.txt                |  53 +++++++++
 scripts/link-vmlinux.sh                     |  34 +-----
 55 files changed, 273 insertions(+), 314 deletions(-)
 create mode 100644 scripts/head-object-list.txt

-- 
2.34.1

