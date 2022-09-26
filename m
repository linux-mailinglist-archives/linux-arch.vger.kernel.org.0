Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864865EB289
	for <lists+linux-arch@lfdr.de>; Mon, 26 Sep 2022 22:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiIZUpF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Sep 2022 16:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIZUpD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Sep 2022 16:45:03 -0400
Received: from condef-03.nifty.com (condef-03.nifty.com [202.248.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322546052F;
        Mon, 26 Sep 2022 13:44:58 -0700 (PDT)
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-03.nifty.com with ESMTP id 28QKbh0O030098;
        Tue, 27 Sep 2022 05:38:02 +0900
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 28QKaWu0018737;
        Tue, 27 Sep 2022 05:36:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 28QKaWu0018737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664224593;
        bh=lb3a5drEKLdeXLqemWkYG7kTPErJKgT8MUmB5b6StBw=;
        h=From:To:Cc:Subject:Date:From;
        b=a0YahL0BCSGVdAPKTAvRLbUz1CEmuSqTisgJkZhpPdf5aOB/6N3O7lfN8i6WkILYH
         /tMFaRU/7p5oMro4eu7J3wmU/ugb8CldXDvypeUz8UwVQQzTotVmzHrejPOpnd8coZ
         weoiQBHgYWpZuSAIsxGidIM6A0+mD1hPpTcRdEx4Lsd+AiLcuDayy6f1AdWh/qKve7
         HSO3sHYh67nj4r+EIC1g7lookLFpd/TILUGwwzUxMLy0q+nCDMz84bv7Jd/XXVpai8
         jDQhhALoBKsisEs8gB/2qRd6VSdDcA/ItUPryjxJNBtZHDeBJj18XQajVT4ZPZEJAn
         lkX62AmoE/DfA==
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
Subject: [PATCH v2 0/7] Unify <linux/export.h> and <asm/export.h>, remove EXPORT_DATA_SYMBOL(), faster TRIM_UNUSED_KSYMS
Date:   Tue, 27 Sep 2022 05:36:18 +0900
Message-Id: <20220926203625.1117261-1-masahiroy@kernel.org>
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

This patch set refactors EXPORT_SYMBOL, <linux/export.h> and <asm/export.h>.
Also, re-implement TRIM_UNUSED_KSYMS in one-pass.

You can still put EXPORT_SYMBOL() in *.S file, very close to the definition,
but you do not need to care about whether it is a function or a data.
Remove EXPORT_DATA_SYMBOL().

In v1, I broke ia64 because of missing distinction between functions and data.

V2 handles it correctly.
If the exported symbols is a function, KSYMTAB_FUNC is output.
Otherwise, KSYMTAB_DATA is output.



Masahiro Yamada (7):
  kbuild: generate KSYMTAB entries by modpost
  ia64,export.h: replace EXPORT_DATA_SYMBOL* with EXPORT_SYMBOL*
  modpost: merge sym_update_namespace() into sym_add_exported()
  modpost: use null string instead of NULL pointer for default namespace
  modpost: squash report_sec_mismatch() and remove enum mismatch
  kbuild: implement CONFIG_TRIM_UNUSED_KSYMS without recursion
  kbuild: move modules.builtin(.modinfo) rules to Makefile.vmlinux_o

 .gitignore                      |   1 -
 Makefile                        |  24 +---
 arch/ia64/include/asm/Kbuild    |   1 +
 arch/ia64/include/asm/export.h  |   3 -
 arch/ia64/kernel/head.S         |   2 +-
 arch/ia64/kernel/ivt.S          |   2 +-
 include/asm-generic/export.h    |  83 +-----------
 include/linux/export-internal.h |  67 +++++++++-
 include/linux/export.h          | 114 +++-------------
 kernel/module/internal.h        |   1 +
 kernel/module/main.c            |   1 -
 scripts/Makefile.build          |  15 +--
 scripts/Makefile.modpost        |   8 +-
 scripts/Makefile.vmlinux_o      |  26 +++-
 scripts/adjust_autoksyms.sh     |  73 ----------
 scripts/basic/fixdep.c          |   3 +-
 scripts/check-local-export      |   4 +-
 scripts/gen_autoksyms.sh        |  62 ---------
 scripts/gen_ksymdeps.sh         |  30 -----
 scripts/link-vmlinux.sh         |  12 +-
 scripts/mod/modpost.c           | 228 ++++++++++++++++----------------
 scripts/mod/modpost.h           |   1 +
 scripts/remove-stale-files      |   2 +
 23 files changed, 258 insertions(+), 505 deletions(-)
 delete mode 100644 arch/ia64/include/asm/export.h
 delete mode 100755 scripts/adjust_autoksyms.sh
 delete mode 100755 scripts/gen_autoksyms.sh
 delete mode 100755 scripts/gen_ksymdeps.sh

-- 
2.34.1

