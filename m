Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B439170BE36
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 14:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbjEVM2o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 08:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbjEVM13 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 08:27:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E410D1FE2;
        Mon, 22 May 2023 05:25:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADBC1139F;
        Mon, 22 May 2023 05:26:14 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0F7F23F59C;
        Mon, 22 May 2023 05:25:27 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        keescook@chromium.org, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        mark.rutland@arm.com, paulmck@kernel.org, peterz@infradead.org,
        sstabellini@kernel.org, will@kernel.org
Subject: [PATCH 21/26] locking/atomic: scripts: split pfx/name/sfx/order
Date:   Mon, 22 May 2023 13:24:24 +0100
Message-Id: <20230522122429.1915021-22-mark.rutland@arm.com>
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

Currently gen-atomic-long.sh's gen_proto_order_variant() function
combines the pfx/name/sfx/order variables immediately, unlike other
functions in gen-atomic-*.sh.

This is fine today, but subsequent patches will require the individual
individual pfx/name/sfx/order variables within gen-atomic-long.sh's
gen_proto_order_variant() function. In preparation for this, split the
variables in the style of other gen-atomic-*.sh scripts.

This results in no change to the generated headers, so there should be
no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
---
 scripts/atomic/gen-atomic-long.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-long.sh
index 75e91d6da30d3..13832171f7219 100755
--- a/scripts/atomic/gen-atomic-long.sh
+++ b/scripts/atomic/gen-atomic-long.sh
@@ -36,10 +36,15 @@ gen_args_cast()
 gen_proto_order_variant()
 {
 	local meta="$1"; shift
-	local name="$1$2$3$4"; shift; shift; shift; shift
+	local pfx="$1"; shift
+	local name="$1"; shift
+	local sfx="$1"; shift
+	local order="$1"; shift
 	local atomic="$1"; shift
 	local int="$1"; shift
 
+	local atomicname="${pfx}${name}${sfx}${order}"
+
 	local ret="$(gen_ret_type "${meta}" "long")"
 	local params="$(gen_params "long" "atomic_long" "$@")"
 	local argscast="$(gen_args_cast "${int}" "${atomic}" "$@")"
@@ -47,9 +52,9 @@ gen_proto_order_variant()
 
 cat <<EOF
 static __always_inline ${ret}
-raw_atomic_long_${name}(${params})
+raw_atomic_long_${atomicname}(${params})
 {
-	${retstmt}raw_${atomic}_${name}(${argscast});
+	${retstmt}raw_${atomic}_${atomicname}(${argscast});
 }
 
 EOF
-- 
2.30.2

