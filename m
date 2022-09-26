Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FE75E9CDA
	for <lists+linux-arch@lfdr.de>; Mon, 26 Sep 2022 11:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbiIZJD6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Sep 2022 05:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbiIZJDw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Sep 2022 05:03:52 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCF63DF1F;
        Mon, 26 Sep 2022 02:03:48 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 28Q92Ynx010468;
        Mon, 26 Sep 2022 18:02:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 28Q92Ynx010468
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664182955;
        bh=bWNxIkYeKhJ+jjZFjH5QZ0u9UbaVyBZ+HfmYzagXKlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B1wDi8GFZx33CELt2BDYTIIdGOyg6chwDAks8pKR15NM+t36nSohLvufmi0wAu5z0
         sO94spo729lp7xtdESGzQa6q5PH10TeroaBaPshbMP/mpfFo+9wgZIfMQWTmTMJ/EZ
         VjHhxNVkauL6okzM/zRw9Q855QiGKfzY0UnX8D8H1tiMuIpw2Jb/E8gECL7WFHZxRm
         Jmz7wSPzl/9qP9knmNxuZmEooc5PbCUb4pfB44Q9UQUvN1ruY4YkYRM9qrKpQJJS2J
         jknXy64QsxuA0s4irZcvpEU3/ipn6BA4YBG4xyxzLADzdXRYvIOrPXXrw6cbTP9RaA
         JzzcL0IpNTBHw==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 2/5] kbuild: reuse mksysmap output for kallsyms
Date:   Mon, 26 Sep 2022 18:02:26 +0900
Message-Id: <20220926090229.643134-2-masahiroy@kernel.org>
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

scripts/mksysmap internally runs ${NM} (dropping some symbols).

When CONFIG_KALLSYMS=y, mksysmap creates .tmp_System.map, but it is
almost the same as the output from the ${NM} invocation in kallsyms().
It is true scripts/mksysmap drops some symbols, but scripts/kallsyms.c
ignores more anyway.

Keep the mksysmap output as *.syms, and reuse it for kallsyms and
'cmp -s'. It saves one ${NM} invocation.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/link-vmlinux.sh | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 23ac13fd9d89..6492c0862657 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -157,7 +157,7 @@ kallsyms()
 	fi
 
 	info KSYMS ${2}
-	${NM} -n ${1} | scripts/kallsyms ${kallsymopt} > ${2}
+	cat ${1} | scripts/kallsyms ${kallsymopt} > ${2}
 }
 
 # Perform one step in kallsyms generation, including temporary linking of
@@ -170,7 +170,8 @@ kallsyms_step()
 	kallsyms_S=${kallsyms_vmlinux}.S
 
 	vmlinux_link ${kallsyms_vmlinux} "${kallsymso_prev}" ${btf_vmlinux_bin_o}
-	kallsyms ${kallsyms_vmlinux} ${kallsyms_S}
+	mksysmap ${kallsyms_vmlinux} ${kallsyms_vmlinux}.syms
+	kallsyms ${kallsyms_vmlinux}.syms ${kallsyms_S}
 
 	info AS ${kallsyms_S}
 	${CC} ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS} \
@@ -182,6 +183,7 @@ kallsyms_step()
 # See mksymap for additional details
 mksysmap()
 {
+	info NM ${2}
 	${CONFIG_SHELL} "${srctree}/scripts/mksysmap" ${1} ${2}
 }
 
@@ -283,7 +285,6 @@ if is_enabled CONFIG_DEBUG_INFO_BTF && is_enabled CONFIG_BPF; then
 	${RESOLVE_BTFIDS} vmlinux
 fi
 
-info SYSMAP System.map
 mksysmap vmlinux System.map
 
 if is_enabled CONFIG_BUILDTIME_TABLE_SORT; then
@@ -296,9 +297,7 @@ fi
 
 # step a (see comment above)
 if is_enabled CONFIG_KALLSYMS; then
-	mksysmap ${kallsyms_vmlinux} .tmp_System.map
-
-	if ! cmp -s System.map .tmp_System.map; then
+	if ! cmp -s System.map ${kallsyms_vmlinux}.syms; then
 		echo >&2 Inconsistent kallsyms data
 		echo >&2 Try "make KALLSYMS_EXTRA_PASS=1" as a workaround
 		exit 1
-- 
2.34.1

