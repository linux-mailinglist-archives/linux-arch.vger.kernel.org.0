Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A6F6C26EC
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjCUBIl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjCUBII (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:08:08 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CDD37734;
        Mon, 20 Mar 2023 18:07:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CF3B9CE173F;
        Tue, 21 Mar 2023 01:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C88FC43442;
        Tue, 21 Mar 2023 01:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360751;
        bh=oT4l9yMcAJkQzBuPV8xL/8r1YT5hPfxeVf6gwstrxpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQCXemlZnLyBJkKiBe8GSH5LRmnXcPYS5+VdLsRmP0XU/IWOTZnfwV9KeNf2AEvug
         Mbs2L8Y9NgAZR+BP/dDtQJKi43tUHQXGtGC/11TUZkXDSxxonfxhBc5vTm2UwTVG54
         obidjWrf21VjL7+vOHfmy431X7cbOlujyG1odZ0dX4R8BX8oCFq/KFIaolGd2/fNbN
         Z8DA69qLViSOc+8sEqiu4L35lHNfNKpu9GcqrVgM12haYKFQc5IGVcxQCmTPuXSYiY
         rq/G71WIClZgYqxzVUgrR55wJSBKTOe6ywC7jvAvA7rQZonOIYQSHO8IolYDhcJmkJ
         8pIc5PyDe9C8w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A61DD15403BB; Mon, 20 Mar 2023 18:05:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model scripts 18/31] tools/memory-model: Make runlitmus.sh check for jingle errors
Date:   Mon, 20 Mar 2023 18:05:36 -0700
Message-Id: <20230321010549.51296-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <4e5839bb-e980-4931-a550-3548d025a32a@paulmck-laptop>
References: <4e5839bb-e980-4931-a550-3548d025a32a@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It turns out that the jingle7 tool is currently a bit picky about
the litmus tests it is willing to process.  This commit therefore
ensures that jingle7 failures are reported.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/scripts/runlitmus.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/memory-model/scripts/runlitmus.sh b/tools/memory-model/scripts/runlitmus.sh
index afb196d7ef10..5f2d29b460ff 100755
--- a/tools/memory-model/scripts/runlitmus.sh
+++ b/tools/memory-model/scripts/runlitmus.sh
@@ -69,6 +69,11 @@ fi
 # Generate the assembly code and run herd7 on it.
 gen_theme7 -n 10 -map $mapfile -call Linux.call > $themefile
 jingle7 -theme $themefile $litmus > $LKMM_DESTDIR/$hwlitmus 2> $T/$hwlitmusfile.jingle7.out
+if grep -q "Generated 0 tests" $T/$hwlitmusfile.jingle7.out
+then
+	echo ' !!! ' jingle7 failed, no $hwlitmus generated
+	exit 253
+fi
 /usr/bin/time $LKMM_TIMEOUT_CMD herd7 $LKMM_DESTDIR/$hwlitmus > $LKMM_DESTDIR/$hwlitmus.out 2>&1
 
 exit $?
-- 
2.40.0.rc2

