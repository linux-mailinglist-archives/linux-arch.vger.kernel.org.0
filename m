Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D376C26E5
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjCUBII (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjCUBHS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:07:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5257036681;
        Mon, 20 Mar 2023 18:06:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50B306190F;
        Tue, 21 Mar 2023 01:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F8BC433B4;
        Tue, 21 Mar 2023 01:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360751;
        bh=YOH+IMMMfmEIxn685uTHBEdxIh0ZkUcdFkY/5zEgfDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IiNzFNKu51/d8O1GxAG7DHXiMC9/f4NBIlxXRbe++/BQOoxD0HbF3ETZo+ugDNo4S
         vr09+wcT6bjIFqaQuOJTYVPWrd1yWPhMlHTupcWwLjBn0YmETWX27BvJ8C2MjFlVl6
         fKbhTrtuXtLH+ez+7mQPGJgKTpt4OSYEyXVTXy0gGIfQhIWE5LyulY1ZjqAhmUlzuf
         wnP09W2xUp2ZKMgvfNeNnYz+iYpaUsxCTg/TgiY1T3lxzKhP6Fqs4/leH7/gPwvpIu
         H663auVe6CD6kUoro+q1UHFE1AXd1mXD90/FOHS7CGQqWCL2g0DZwpwrMHUQjbRl9J
         rWMsWATUUXT/w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A1EB715403B9; Mon, 20 Mar 2023 18:05:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model scripts 17/31] tools/memory-model: Allow herd to deduce CPU type
Date:   Mon, 20 Mar 2023 18:05:35 -0700
Message-Id: <20230321010549.51296-17-paulmck@kernel.org>
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

Currently, the scripts specify the CPU's .cat file to herd.  But this is
pointless because herd will select a good and sufficient .cat file from
the assembly-language litmus test itself.  This commit therefore removes
the -model argument to herd, allowing herd to figure the CPU family out
itself.

Note that the user can override herd's choice using the "--herdopts"
argument to the scripts.

Suggested-by: Luc Maranget <luc.maranget@inria.fr>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/scripts/runlitmus.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/memory-model/scripts/runlitmus.sh b/tools/memory-model/scripts/runlitmus.sh
index 62b47c7e1ba9..afb196d7ef10 100755
--- a/tools/memory-model/scripts/runlitmus.sh
+++ b/tools/memory-model/scripts/runlitmus.sh
@@ -53,7 +53,6 @@ trap 'rm -rf $T' 0 2
 mkdir $T
 
 # Generate filenames
-catfile="`echo $LKMM_HW_MAP_FILE | tr '[A-Z]' '[a-z]'`.cat"
 mapfile="Linux2${LKMM_HW_MAP_FILE}.map"
 themefile="$T/${LKMM_HW_MAP_FILE}.theme"
 herdoptions="-model $LKMM_HW_CAT_FILE"
@@ -70,6 +69,6 @@ fi
 # Generate the assembly code and run herd7 on it.
 gen_theme7 -n 10 -map $mapfile -call Linux.call > $themefile
 jingle7 -theme $themefile $litmus > $LKMM_DESTDIR/$hwlitmus 2> $T/$hwlitmusfile.jingle7.out
-/usr/bin/time $LKMM_TIMEOUT_CMD herd7 -model $catfile $LKMM_DESTDIR/$hwlitmus > $LKMM_DESTDIR/$hwlitmus.out 2>&1
+/usr/bin/time $LKMM_TIMEOUT_CMD herd7 $LKMM_DESTDIR/$hwlitmus > $LKMM_DESTDIR/$hwlitmus.out 2>&1
 
 exit $?
-- 
2.40.0.rc2

