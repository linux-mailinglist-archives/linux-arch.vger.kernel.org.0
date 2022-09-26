Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4325F5E9CD7
	for <lists+linux-arch@lfdr.de>; Mon, 26 Sep 2022 11:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiIZJD5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Sep 2022 05:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbiIZJDx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Sep 2022 05:03:53 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86CA3DF28;
        Mon, 26 Sep 2022 02:03:49 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 28Q92Yo2010468;
        Mon, 26 Sep 2022 18:02:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 28Q92Yo2010468
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664182957;
        bh=A9rjJTx/1HLx31R8GgAjlfENvJtf39g+fxcn+LvStLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GFBrPIGue3lq/+yk97SX0hd/1VanvBTKluhi+zk11JTgVnn8mbi9GDr4IkAlIcezO
         G0pCLT13UDNceCJzOicyOBcmTqXMKoANTtyfD2vJaSk4IY3KV3oIiXc1SHm+iHBMkA
         mLeuni+198HJ9I/6ijmdONog1/SzYJnpR2IDjQmfXbP8frLTmMnMlWjWg/foWnjkKK
         hFZ+idGqgH+rI3myVYbpZzN/LLu3zhL/qWlkLbzMshFFs1KEDHhRKu6fbYhQ079Efc
         /PAxD+PGrSAlgKaxYPa5jVfRR7HND7YqZN33H2uIpc/KpSzBALSLznvlQGA/mlcvra
         oabTs/wYtgkJA==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 5/5] kallsyms: ignore __kstrtab_* and __kstrtabns_* symbols
Date:   Mon, 26 Sep 2022 18:02:29 +0900
Message-Id: <20220926090229.643134-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926090229.643134-1-masahiroy@kernel.org>
References: <20220926090229.643134-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Every EXPORT_SYMBOL creates __kstrtab_* and __kstrtabns_*, which
consumes 15-20% of the kallsyms entries.

For x86_64 defconfig,

  $ cat /proc/kallsyms | wc
     129527    388581   5685465
  $ cat /proc/kallsyms | grep __kstrtab | wc
      23489     70467   1187932

We already ignore __crc_* symbols populated by EXPORT_SYMBOL, so it
should be fine to ignore __kstrtab_* and __kstrtabns_* as well.

This makes vmlinux a bit smaller.

  $ size vmlinux.before vmlinux.after
     text    data     bss     dec     hex filename
  22785374        8559694 1413328 32758396        1f3da7c vmlinux.before
  22785374        8137806 1413328 32336508        1ed6a7c vmlinux.after

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mksysmap | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/mksysmap b/scripts/mksysmap
index 75f3dfd1c156..16a08b8ef2f8 100755
--- a/scripts/mksysmap
+++ b/scripts/mksysmap
@@ -43,6 +43,8 @@
 #  $                    - local symbols for ARM, MIPS, etc.
 #  .L                   - local labels, .LBB,.Ltmpxxx,.L__unnamed_xx,.LASANPC, etc.
 #  __crc_               - modversions
+#  __kstrtab_           - EXPORT_SYMBOL (symbol name)
+#  __kstrtabns_         - EXPORT_SYMBOL (namespace)
 #
 # Ignored symbols:
 #  L0                   - for LoongArch?
@@ -52,5 +54,7 @@ $NM -n $1 | grep -v		\
 	-e ' \$'		\
 	-e ' \.L'		\
 	-e ' __crc_'		\
+	-e ' __kstrtab_'	\
+	-e ' __kstrtabns_'	\
 	-e ' L0$'		\
 > $2
-- 
2.34.1

