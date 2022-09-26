Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8DA5E9CE0
	for <lists+linux-arch@lfdr.de>; Mon, 26 Sep 2022 11:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbiIZJEA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Sep 2022 05:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbiIZJD6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Sep 2022 05:03:58 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C22B9B;
        Mon, 26 Sep 2022 02:03:57 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 28Q92Yo0010468;
        Mon, 26 Sep 2022 18:02:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 28Q92Yo0010468
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664182956;
        bh=yaPt91/rxKPwYcQ48BpGmlDGPrqfKbzBUcHywF68xIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WX+YXol16U6ujac+IClQQdI6dWqXOjpMJMxM7za/05S9+TR4PkZSDc8sYQG7niMfJ
         JydDQwYPipooGHK+zZExaA7PmmM1jdgkwjvrdC8k43Udb22Ktja7BagU/6+csbFZZv
         C47bajakysNkw35/fNVNsUIm2dpUSPXPLIDHFHBEcbpsRbnrXcw+hNC+hQCzkhkAZC
         P+w30ueUzohv7wF+YQvSPHGC1kQWvzjUqH5tpFx7w1luBF4KyRsui4wE9qBWIuRcwb
         TRXz13RxqskDrFvPSLbUvvoC+ik7kZf3ZDCQVRwjCzZ/L/XNyc4kXF+07q1Q1NNDnT
         LWuLktuGv/IBw==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Fuad Tabba <tabba@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH 3/5] kallsyms: drop duplicated ignore patterns from kallsyms.c
Date:   Mon, 26 Sep 2022 18:02:27 +0900
Message-Id: <20220926090229.643134-3-masahiroy@kernel.org>
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

Now that kallsyms.c parses the output from mksysmap, some symbols have
already been dropped.

Move comments to scripts/mksysmap. Also, make the grep command readable.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kallsyms.c |  3 ---
 scripts/mksysmap   | 14 +++++++++++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index f18e6dfc68c5..313cc8161123 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -107,9 +107,6 @@ static bool is_ignored_symbol(const char *name, char type)
 
 	/* Symbol names that begin with the following are ignored.*/
 	static const char * const ignored_prefixes[] = {
-		"$",			/* local symbols for ARM, MIPS, etc. */
-		".L",			/* local labels, .LBB,.Ltmpxxx,.L__unnamed_xx,.LASANPC, etc. */
-		"__crc_",		/* modversions */
 		"__efistub_",		/* arm64 EFI stub namespace */
 		"__kvm_nvhe_$",		/* arm64 local symbols in non-VHE KVM namespace */
 		"__kvm_nvhe_.L",	/* arm64 local symbols in non-VHE KVM namespace */
diff --git a/scripts/mksysmap b/scripts/mksysmap
index bc5396e255d8..75f3dfd1c156 100755
--- a/scripts/mksysmap
+++ b/scripts/mksysmap
@@ -40,5 +40,17 @@
 # 'W' or 'w'.
 #
 # Ignored prefixes:
+#  $                    - local symbols for ARM, MIPS, etc.
+#  .L                   - local labels, .LBB,.Ltmpxxx,.L__unnamed_xx,.LASANPC, etc.
 #  __crc_               - modversions
-$NM -n $1 | grep -v '\( [aNUw] \)\|\(__crc_\)\|\( \$[adt]\)\|\( \.L\)\|\( L0\)' > $2
+#
+# Ignored symbols:
+#  L0                   - for LoongArch?
+
+$NM -n $1 | grep -v		\
+	-e ' [aNUw] '		\
+	-e ' \$'		\
+	-e ' \.L'		\
+	-e ' __crc_'		\
+	-e ' L0$'		\
+> $2
-- 
2.34.1

