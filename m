Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E92F5ADF8D
	for <lists+linux-arch@lfdr.de>; Tue,  6 Sep 2022 08:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbiIFGOM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Sep 2022 02:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbiIFGOJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Sep 2022 02:14:09 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E10B6F55A;
        Mon,  5 Sep 2022 23:14:06 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 2866DVI6023845;
        Tue, 6 Sep 2022 15:13:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 2866DVI6023845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662444812;
        bh=jRNW/6MkakdZhX+bgAEHGE9SzlsuHJxmAVwGHamj+aM=;
        h=From:To:Cc:Subject:Date:From;
        b=w1UnMoaUIuReuKI2eMZzCPjTnxsRdprDSUfq/6X3t2IYxODOoOsEKNbQtfBG+SURY
         dwn7gjWZqqqVEEIqSX38PM0ugsgsVE+X29VqftNjodm/7fiILr2e7qUwTMtdRqJdwi
         hGv4hfCkkW5I+6EQyxVBaL+rGOgr/3iNoVD1SemDiGsyd8Sz9V2ryFffx3/CkW4b2F
         xASTL4dcRq2KbEKYmndp60EnhkDv8S/Jbc13YpB+OTg5j29RiiO5U5yTMPOITZgi1v
         M3+RcUd+t9AiFfqA+5ITwjUgYL+MOR6qad3WbJoMoCU4ewUK3XQB57bi8r/ac04z4+
         Sh9PEq3ZYzs0g==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 0/8] kbuild: various cleanups
Date:   Tue,  6 Sep 2022 15:13:05 +0900
Message-Id: <20220906061313.1445810-1-masahiroy@kernel.org>
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


 - Refactor single target build to make it work more correctly
 - Link vmlinux and modules in parallel
 - Remove head-y syntax


Masahiro Yamada (8):
  kbuild: fix and refactor single target build
  kbuild: rename modules.order in sub-directories to .modules.order
  kbuild: move core-y and drivers-y to ./Kbuild
  kbuild: move .vmlinux.objs rule to Makefile.modpost
  kbuild: move vmlinux.o rule to the top Makefile
  kbuild: unify two modpost invocations
  kbuild: use obj-y instead extra-y for objects placed at the head
  kbuild: remove head-y syntax

 Documentation/kbuild/makefiles.rst          |  27 ++---
 Kbuild                                      |  23 ++++
 Makefile                                    | 113 ++++++++++++--------
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
 arch/powerpc/Makefile                       |  12 ---
 arch/powerpc/kernel/Makefile                |  22 ++--
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
 scripts/Makefile.build                      |  70 +++++-------
 scripts/Makefile.lib                        |  10 +-
 scripts/Makefile.modfinal                   |   2 +-
 scripts/Makefile.modpost                    | 112 +++++++++----------
 scripts/Makefile.vmlinux_o                  |   6 +-
 scripts/clang-tools/gen_compile_commands.py |  19 +---
 scripts/head-object-list.txt                |  53 +++++++++
 scripts/link-vmlinux.sh                     |  34 +-----
 55 files changed, 304 insertions(+), 349 deletions(-)
 create mode 100644 scripts/head-object-list.txt

-- 
2.34.1

