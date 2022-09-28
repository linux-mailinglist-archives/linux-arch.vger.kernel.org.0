Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DD55ED521
	for <lists+linux-arch@lfdr.de>; Wed, 28 Sep 2022 08:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbiI1Gmk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 02:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbiI1Gl4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 02:41:56 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9789FCF;
        Tue, 27 Sep 2022 23:41:33 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 28S6e0G1004120;
        Wed, 28 Sep 2022 15:40:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 28S6e0G1004120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664347202;
        bh=bMCdFStQWZxbQk1gnDYL3CYDG5GATkG7hQ6PvF/Ni/8=;
        h=From:To:Cc:Subject:Date:From;
        b=zf8famM/zizOFxIt3oYqdutBJGCGMDtkJOGKUlSLT9VRrbo9zHExkpzA1iVxSLOh/
         Oyt8iYIg532sXu1vuU1NUJy+TmrspHKQa50z7G1Jl7qjk/pem8zJB3O1/lPEzKI4SS
         L8GwUNl26Vqk3PNauHk2YIv19nEf2yJJRCKrzqT6qxewU16Ddn4ZbpsSY+DxbguJF7
         yEAuEbH1vrMESkNhAnrfQdF33O0/BrtmuH07MPMaeIm4uwvLrPybNhgVvtYX274aPD
         rghIvbMv6VoszIUPOuddyty09b8Q3pHnJd95hTqhbWTgO520iTtQrI3oUlDbQBptbq
         yf0pYtaWX6FGw==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-modules@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v3 0/8] Unify <linux/export.h> and <asm/export.h>, remove EXPORT_DATA_SYMBOL(), faster TRIM_UNUSED_KSYMS
Date:   Wed, 28 Sep 2022 15:39:39 +0900
Message-Id: <20220928063947.299333-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


This patch set refactors EXPORT_SYMBOL, <linux/export.h> and <asm/export.h>.
Also, re-implement TRIM_UNUSED_KSYMS in one-pass.

You can still put EXPORT_SYMBOL() in *.S file, very close to the definition,
but you do not need to care about whether it is a function or a data.
Remove EXPORT_DATA_SYMBOL().

In v1, I broke ia64 because of missing distinction between functions and data.

V2 handles it correctly.
If the exported symbols is a function, KSYMTAB_FUNC is output.
Otherwise, KSYMTAB_DATA is output.


Changes in v3:
  - Move to the head of the series
  - New patch
  - Move struct kernel_symbol to kernel/module/internal.h
  - Some cleanups

Changes in v2:
  - New patch
  - Use KSYMTAB_FUNC and KSYMTAB_DATA for functions and data, respectively
    This distinction is needed for ia64.
  - New patch
  - New patch

Masahiro Yamada (8):
  kbuild: move modules.builtin(.modinfo) rules to Makefile.vmlinux_o
  kbuild: rebuild .vmlinux.export.o when its prerequisite is updated
  kbuild: generate KSYMTAB entries by modpost
  ia64,export.h: replace EXPORT_DATA_SYMBOL* with EXPORT_SYMBOL*
  modpost: squash sym_update_namespace() into sym_add_exported()
  modpost: use null string instead of NULL pointer for default namespace
  modpost: squash report_sec_mismatch() and remove enum mismatch
  kbuild: implement CONFIG_TRIM_UNUSED_KSYMS without recursion

 .gitignore                      |   1 -
 Makefile                        |  37 ++----
 arch/ia64/include/asm/Kbuild    |   1 +
 arch/ia64/include/asm/export.h  |   3 -
 arch/ia64/kernel/head.S         |   2 +-
 arch/ia64/kernel/ivt.S          |   2 +-
 include/asm-generic/export.h    |  83 +-----------
 include/linux/export-internal.h |  49 +++++++
 include/linux/export.h          | 114 +++-------------
 kernel/module/internal.h        |  12 ++
 scripts/Makefile.build          |  15 +--
 scripts/Makefile.modpost        |   8 +-
 scripts/Makefile.vmlinux        |  21 ++-
 scripts/Makefile.vmlinux_o      |  26 +++-
 scripts/adjust_autoksyms.sh     |  73 ----------
 scripts/basic/fixdep.c          |   3 +-
 scripts/check-local-export      |   4 +-
 scripts/gen_autoksyms.sh        |  62 ---------
 scripts/gen_ksymdeps.sh         |  30 -----
 scripts/link-vmlinux.sh         |  12 --
 scripts/mod/modpost.c           | 228 ++++++++++++++++----------------
 scripts/mod/modpost.h           |   1 +
 scripts/remove-stale-files      |   2 +
 23 files changed, 270 insertions(+), 519 deletions(-)
 delete mode 100644 arch/ia64/include/asm/export.h
 delete mode 100755 scripts/adjust_autoksyms.sh
 delete mode 100755 scripts/gen_autoksyms.sh
 delete mode 100755 scripts/gen_ksymdeps.sh

-- 
2.34.1

