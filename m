Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F78170BE31
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 14:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbjEVM2l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 08:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjEVM1R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 08:27:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E8F310F3;
        Mon, 22 May 2023 05:25:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 347DC1515;
        Mon, 22 May 2023 05:26:02 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A6683F59C;
        Mon, 22 May 2023 05:25:15 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        keescook@chromium.org, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        mark.rutland@arm.com, paulmck@kernel.org, peterz@infradead.org,
        sstabellini@kernel.org, will@kernel.org
Subject: [PATCH 16/26] locking/atomic: scripts: factor out order template generation
Date:   Mon, 22 May 2023 13:24:19 +0100
Message-Id: <20230522122429.1915021-17-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230522122429.1915021-1-mark.rutland@arm.com>
References: <20230522122429.1915021-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently gen_proto_order_variants() hard codes the path for the templates used
for order fallbacks. Factor this out into a helper so that it can be reused
elsewhere.

This results in no change to the generated headers, so there should be
no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
---
 scripts/atomic/gen-atomic-fallback.sh | 34 +++++++++++++--------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index 7a6bcea8f565b..337330865fa2e 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -32,6 +32,20 @@ gen_template_fallback()
 	fi
 }
 
+#gen_order_fallback(meta, pfx, name, sfx, order, atomic, int, args...)
+gen_order_fallback()
+{
+	local meta="$1"; shift
+	local pfx="$1"; shift
+	local name="$1"; shift
+	local sfx="$1"; shift
+	local order="$1"; shift
+
+	local tmpl_order=${order#_}
+	local tmpl="${ATOMICDIR}/fallbacks/${tmpl_order:-fence}"
+	gen_template_fallback "${tmpl}" "${meta}" "${pfx}" "${name}" "${sfx}" "${order}" "$@"
+}
+
 #gen_proto_fallback(meta, pfx, name, sfx, order, atomic, int, args...)
 gen_proto_fallback()
 {
@@ -56,20 +70,6 @@ cat << EOF
 EOF
 }
 
-gen_proto_order_variant()
-{
-	local meta="$1"; shift
-	local pfx="$1"; shift
-	local name="$1"; shift
-	local sfx="$1"; shift
-	local order="$1"; shift
-	local atomic="$1"
-
-	local basename="arch_${atomic}_${pfx}${name}${sfx}"
-
-	printf "#define ${basename}${order} ${basename}${order}\n"
-}
-
 #gen_proto_order_variants(meta, pfx, name, sfx, atomic, int, args...)
 gen_proto_order_variants()
 {
@@ -117,9 +117,9 @@ gen_proto_order_variants()
 
 	printf "#else /* ${basename}_relaxed */\n\n"
 
-	gen_template_fallback "${ATOMICDIR}/fallbacks/acquire"  "${meta}" "${pfx}" "${name}" "${sfx}" "_acquire" "$@"
-	gen_template_fallback "${ATOMICDIR}/fallbacks/release"  "${meta}" "${pfx}" "${name}" "${sfx}" "_release" "$@"
-	gen_template_fallback "${ATOMICDIR}/fallbacks/fence"  "${meta}" "${pfx}" "${name}" "${sfx}" "" "$@"
+	gen_order_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_acquire" "$@"
+	gen_order_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_release" "$@"
+	gen_order_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "" "$@"
 
 	printf "#endif /* ${basename}_relaxed */\n\n"
 }
-- 
2.30.2

