Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A7A6C26DF
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjCUBHo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjCUBHK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:07:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8197A35245;
        Mon, 20 Mar 2023 18:06:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15ECC61904;
        Tue, 21 Mar 2023 01:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20477C433A7;
        Tue, 21 Mar 2023 01:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360751;
        bh=ms3u43L6F35Rla/Tr4gwblmtg7jpfVpUfhMDcsOc/Ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j7EYsJxS49U5MeolVim8U6SGA/Nf3E9CDYeylBCZSKcYKCtfilRUxrhOkoB0WdeFt
         lK7DjDVaUAEmyfmeQi4np2Av9Dm8taxv8FMPHIm4nCzcQC9gdONlC4Xdga+XVUVfkV
         xStyMhiyo+RxYSIgz3qJTE/3/u8Xa9TO9avetSetAE20HZzxk4Ae81rsBicDLWsyPH
         /7L3b0KOZboXe97Ms+bRWCD4Ty4ZYJb+7iJ8hgX4JZZPaO8C0S89XRCkUqizSGEn2h
         OLjPcKkv1Hnkg+jfyfWKXxm8xlKWg+xs3mCPyw+YNEpdatCePHN17D24TyVYFgocXG
         DJt5mc7Uwa54w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7E57915403A7; Mon, 20 Mar 2023 18:05:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model scripts 08/31] tools/memory-model: Make judgelitmus.sh handle hardware verifications
Date:   Mon, 20 Mar 2023 18:05:26 -0700
Message-Id: <20230321010549.51296-8-paulmck@kernel.org>
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

This commit makes the judgelitmus.sh script check the --hw argument
(AKA the LKMM_HW_MAP_FILE environment variable) and to adjust its
judgment for a run where a C-language litmus test has been translated to
assembly and the assembly version verified.  In this case, the assembly
verification output is checked against the C-language script's "Result:"
comment.  However, because hardware can be stronger than LKMM requires,
the judgelitmus.sh script forgives verification mismatches featuring
a "Sometimes" in the C-language script and an "Always" or "Never"
assembly-language verification.

Note that deadlock is not forgiven, however, this should not normally be
an issue given that C-language tests containing locking, RCU, or SRCU
cannot be translated to assembly.  However, this issue can crop up in
litmus tests that mimic deadlock by using the "filter" clause to ignore
all executions.  It can also crop up when certain herd arguments are
used to autofilter everything that does not match the "exists" clause
in cases where the "exists" clause cannot be satisfied.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/scripts/README         |  8 +--
 tools/memory-model/scripts/judgelitmus.sh | 75 ++++++++++++++---------
 2 files changed, 51 insertions(+), 32 deletions(-)

diff --git a/tools/memory-model/scripts/README b/tools/memory-model/scripts/README
index 095c7eb36f9f..0e29a52044c1 100644
--- a/tools/memory-model/scripts/README
+++ b/tools/memory-model/scripts/README
@@ -43,10 +43,10 @@ initlitmushist.sh
 
 judgelitmus.sh
 
-	Given a .litmus file and its .litmus.out herd7 output, check the
-	.litmus.out file against the .litmus file's "Result:" comment to
-	judge whether the test ran correctly.  Not normally run manually,
-	provided instead for use by other scripts.
+	Given a .litmus file and its herd7 output, check the output file
+	against the .litmus file's "Result:" comment to judge whether
+	the test ran correctly.  Not normally run manually, provided
+	instead for use by other scripts.
 
 newlitmushist.sh
 
diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index d82133e75580..6f3c60065c8b 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -1,9 +1,14 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Given a .litmus test and the corresponding .litmus.out file, check
-# the .litmus.out file against the "Result:" comment to judge whether
-# the test ran correctly.
+# Given a .litmus test and the corresponding litmus output file, check
+# the .litmus.out file against the "Result:" comment to judge whether the
+# test ran correctly.  If the --hw argument is omitted, check against the
+# LKMM output, which is assumed to be in file.litmus.out.  If this argument
+# is provided, this is assumed to be a hardware test, and the output is
+# assumed to be in file.HW.litmus.out, where "HW" is the --hw argument.
+# In addition, non-Sometimes verification results will be noted, but
+# forgiven.
 #
 # Usage:
 #	judgelitmus.sh file.litmus
@@ -24,11 +29,18 @@ else
 	echo ' --- ' error: \"$litmus\" is not a readable file
 	exit 255
 fi
-if test -f "$LKMM_DESTDIR/$litmus".out -a -r "$LKMM_DESTDIR/$litmus".out
+if test -z "$LKMM_HW_MAP_FILE"
+then
+	litmusout=$litmus.out
+else
+	litmusout="`echo $litmus |
+		sed -e 's/\.litmus$/.'${LKMM_HW_MAP_FILE}'.litmus/'`.out"
+fi
+if test -f "$LKMM_DESTDIR/$litmusout" -a -r "$LKMM_DESTDIR/$litmusout"
 then
 	:
 else
-	echo ' --- ' error: \"$LKMM_DESTDIR/$litmus\".out is not a readable file
+	echo ' --- ' error: \"$LKMM_DESTDIR/$litmusout is not a readable file
 	exit 255
 fi
 if grep -q '^ \* Result: ' $litmus
@@ -38,69 +50,76 @@ else
 	outcome=specified
 fi
 
-grep '^Observation' $LKMM_DESTDIR/$litmus.out
-if grep -q '^Observation' $LKMM_DESTDIR/$litmus.out
+grep '^Observation' $LKMM_DESTDIR/$litmusout
+if grep -q '^Observation' $LKMM_DESTDIR/$litmusout
 then
 	:
-elif grep ': Unknown macro ' $LKMM_DESTDIR/$litmus.out
+elif grep ': Unknown macro ' $LKMM_DESTDIR/$litmusout
 then
-	badname=`grep ': Unknown macro ' $LKMM_DESTDIR/$litmus.out |
+	badname=`grep ': Unknown macro ' $LKMM_DESTDIR/$litmusout |
 		sed -e 's/^.*: Unknown macro //' |
 		sed -e 's/ (User error).*$//'`
 	badmsg=' !!! Current LKMM version does not know "'$badname'"'" $litmus"
 	echo $badmsg
-	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+	if ! grep -q '!!!' $LKMM_DESTDIR/$litmusout
 	then
-		echo ' !!! '$badmsg >> $LKMM_DESTDIR/$litmus.out 2>&1
+		echo ' !!! '$badmsg >> $LKMM_DESTDIR/$litmusout 2>&1
 	fi
 	exit 254
-elif grep '^Command exited with non-zero status 124' $LKMM_DESTDIR/$litmus.out
+elif grep '^Command exited with non-zero status 124' $LKMM_DESTDIR/$litmusout
 then
 	echo ' !!! Timeout' $litmus
-	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+	if ! grep -q '!!!' $LKMM_DESTDIR/$litmusout
 	then
-		echo ' !!! Timeout' >> $LKMM_DESTDIR/$litmus.out 2>&1
+		echo ' !!! Timeout' >> $LKMM_DESTDIR/$litmusout 2>&1
 	fi
 	exit 124
 else
 	echo ' !!! Verification error' $litmus
-	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+	if ! grep -q '!!!' $LKMM_DESTDIR/$litmusout
 	then
-		echo ' !!! Verification error' >> $LKMM_DESTDIR/$litmus.out 2>&1
+		echo ' !!! Verification error' >> $LKMM_DESTDIR/$litmusout 2>&1
 	fi
 	exit 255
 fi
 if test "$outcome" = DEADLOCK
 then
-	if grep '^Observation' $LKMM_DESTDIR/$litmus.out | grep -q 'Never 0 0$'
+	if grep '^Observation' $LKMM_DESTDIR/$litmusout | grep -q 'Never 0 0$'
 	then
 		ret=0
 	else
 		echo " !!! Unexpected non-$outcome verification" $litmus
-		if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+		if ! grep -q '!!!' $LKMM_DESTDIR/$litmusout
 		then
-			echo " !!! Unexpected non-$outcome verification" >> $LKMM_DESTDIR/$litmus.out 2>&1
+			echo " !!! Unexpected non-$outcome verification" >> $LKMM_DESTDIR/$litmusout 2>&1
 		fi
 		ret=1
 	fi
-elif grep '^Observation' $LKMM_DESTDIR/$litmus.out | grep -q 'Never 0 0$'
+elif grep '^Observation' $LKMM_DESTDIR/$litmusout | grep -q 'Never 0 0$'
 then
 	echo " !!! Unexpected non-$outcome deadlock" $litmus
-	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+	if ! grep -q '!!!' $LKMM_DESTDIR/$litmusout
 	then
-		echo " !!! Unexpected non-$outcome deadlock" $litmus >> $LKMM_DESTDIR/$litmus.out 2>&1
+		echo " !!! Unexpected non-$outcome deadlock" $litmus >> $LKMM_DESTDIR/$litmusout 2>&1
 	fi
 	ret=1
-elif grep '^Observation' $LKMM_DESTDIR/$litmus.out | grep -q $outcome || test "$outcome" = Maybe
+elif grep '^Observation' $LKMM_DESTDIR/$litmusout | grep -q $outcome || test "$outcome" = Maybe
 then
 	ret=0
 else
-	echo " !!! Unexpected non-$outcome verification" $litmus
-	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+	if test -n "$LKMM_HW_MAP_FILE" -a "$outcome" = Sometimes
 	then
-		echo " !!! Unexpected non-$outcome verification" >> $LKMM_DESTDIR/$litmus.out 2>&1
+		flag="--- Forgiven"
+		ret=0
+	else
+		flag="!!! Unexpected"
+		ret=1
+	fi
+	echo " $flag non-$outcome verification" $litmus
+	if ! grep -qe "$flag" $LKMM_DESTDIR/$litmusout
+	then
+		echo " $flag non-$outcome verification" >> $LKMM_DESTDIR/$litmusout 2>&1
 	fi
-	ret=1
 fi
-tail -2 $LKMM_DESTDIR/$litmus.out | head -1
+tail -2 $LKMM_DESTDIR/$litmusout | head -1
 exit $ret
-- 
2.40.0.rc2

