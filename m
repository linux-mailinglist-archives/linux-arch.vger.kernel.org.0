Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6BB6C26D4
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjCUBHG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjCUBGn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:06:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6092B2ED5E;
        Mon, 20 Mar 2023 18:06:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4665B811C3;
        Tue, 21 Mar 2023 01:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B91C43324;
        Tue, 21 Mar 2023 01:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360751;
        bh=wa5pYtC5SYWp9ZShIu2HSy2OIsdx39BjnrLPgX+Su3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AtpyVMekd3m51PaRDe+rVxdlIheIptFu7ri+D5Cd5GUFhkPqtpQFpbmcVQwG6RDoI
         Rlt7ea8SmHEvnoUJd2DxiIQeYgDPBC9OJFYHcP5bGIYoBnMCkJmMtVDpvZPNGdnDXb
         ySFCxdWHpFMk9LNQSSNMpjLyJ1SxWyWYUXL1zCOI1749PoGTrleh/Bth5YMwmsnJlK
         i/N9TwUD9itnAKnzFvz4CnjJ2YAFA3U+btHMNfoHDUsDRan8f2V5YlhtXTgXv8UMGi
         C+S0ZFxz30e8fn4qPrKTpiYAr7+0M2RwzPWndU/2iinwYKJmm2SsHOYMOezYDOuHuM
         J6T1yY1ZP6jaw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DF22315403CF; Mon, 20 Mar 2023 18:05:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model scripts 29/31] tools/memory-model: Use "-unroll 0" to keep --hw runs finite
Date:   Mon, 20 Mar 2023 18:05:47 -0700
Message-Id: <20230321010549.51296-29-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <4e5839bb-e980-4931-a550-3548d025a32a@paulmck-laptop>
References: <4e5839bb-e980-4931-a550-3548d025a32a@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Litmus tests involving atomic operations produce LL/SC loops on a number
of architectures, and unrolling these loops can result in excessive
verification times or even stack overflows.  This commit therefore uses
the "-unroll 0" herd7 argument to avoid unrolling, on the grounds that
additional passes through an LL/SC loop should not change the verification.

Note however, that certain bugs in the mapping of the LL/SC loop to
machine instructions may go undetected.  On the other hand, herd7 might
not be the best vehicle for finding such bugs in any case.  (You do
stress-test your architecture-specific code, don't you?)

Suggested-by: Luc Maranget <luc.maranget@inria.fr>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/scripts/runlitmus.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/scripts/runlitmus.sh b/tools/memory-model/scripts/runlitmus.sh
index dfdb1f00fcc0..94608d4b6502 100755
--- a/tools/memory-model/scripts/runlitmus.sh
+++ b/tools/memory-model/scripts/runlitmus.sh
@@ -75,6 +75,6 @@ then
 	cp $T/$hwlitmusfile.jingle7.out $LKMM_DESTDIR/$hwlitmus.err
 	exit 253
 fi
-/usr/bin/time $LKMM_TIMEOUT_CMD herd7 $LKMM_DESTDIR/$hwlitmus > $LKMM_DESTDIR/$hwlitmus.out 2>&1
+/usr/bin/time $LKMM_TIMEOUT_CMD herd7 -unroll 0 $LKMM_DESTDIR/$hwlitmus > $LKMM_DESTDIR/$hwlitmus.out 2>&1
 
 exit $?
-- 
2.40.0.rc2

