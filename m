Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921A2546C90
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jun 2022 20:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350409AbiFJSfm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jun 2022 14:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350072AbiFJSfU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jun 2022 14:35:20 -0400
X-Greylist: delayed 72 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Jun 2022 11:35:00 PDT
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632273ED30;
        Fri, 10 Jun 2022 11:35:00 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 25AIX5TL020882;
        Sat, 11 Jun 2022 03:33:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 25AIX5TL020882
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654885986;
        bh=9V5ZtNuA93j8Q20aLKhJjsp/qlA4DxrP5ew51lWbprM=;
        h=From:To:Cc:Subject:Date:From;
        b=EiMGDoVxhBnNAUwmy9Pw4D8rmphe8eCNo0y+s4fv97gyda6/4gSz7svrcCC6tDIQW
         aP0vbki01SCpg1hqhOCJc4naCcSl0SfPT+qJU7xSLOBGfdpcT+Ret0MBFozRLn5XIp
         UVOJrKlfMMp/pEzmmedySfSmWAXRkowNr8dxMvxmjVqMgpXrRm3B52le1YCUqlnDBs
         2NZDyLIkqRMlZyvrMhzWQv9MSgxNZ7474xOBSyN1ger4f19kJWCP1zXBV6tX7vTDy8
         zzBTSPJRj8Gbv2W92g931cV6L+rKVyDjDTRdAJoThsRtiCCFLpVtndbszNtF06H1QM
         4e+Hs+bAbBl0w==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Nicolas Pitre <npitre@baylibre.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alessio Igor Bogani <abogani@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Unify <linux/export.h> and <asm/export.h>, remove EXPORT_DATA_SYMBOL()
Date:   Sat, 11 Jun 2022 03:32:29 +0900
Message-Id: <20220610183236.1272216-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


This patch set refactors EXPORT_SYMBOL, <linux/export.h> and <asm/export.h>.

You can still put EXPORT_SYMBOL() in *.S file, very close to the definition,
but you do not need to care about whether it is a function or a data.
Remove EXPORT_DATA_SYMBOL().



Masahiro Yamada (7):
  modpost: fix section mismatch check for exported init/exit sections
  modpost: put get_secindex() call inside sec_name()
  kbuild: generate struct kernel_symbol by modpost
  ia64,export.h: replace EXPORT_DATA_SYMBOL* with EXPORT_SYMBOL*
  checkpatch: warn if <asm/export.h> is included
  modpost: merge sym_update_namespace() into sym_add_exported()
  modpost: use null string instead of NULL pointer for default namespace

 arch/ia64/include/asm/Kbuild    |   1 +
 arch/ia64/include/asm/export.h  |   3 -
 arch/ia64/kernel/head.S         |   2 +-
 arch/ia64/kernel/ivt.S          |   2 +-
 include/asm-generic/export.h    |  83 +------------------
 include/linux/export-internal.h |  44 ++++++++++
 include/linux/export.h          |  97 ++++++++--------------
 kernel/module/internal.h        |  12 +++
 kernel/module/main.c            |   1 -
 scripts/Makefile.build          |   8 +-
 scripts/check-local-export      |   4 +-
 scripts/checkpatch.pl           |   7 ++
 scripts/mod/modpost.c           | 139 +++++++++++++++++---------------
 scripts/mod/modpost.h           |   1 +
 14 files changed, 182 insertions(+), 222 deletions(-)
 delete mode 100644 arch/ia64/include/asm/export.h

-- 
2.32.0

