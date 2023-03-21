Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4B46C26D3
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjCUBGp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjCUBGd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:06:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52431126E4;
        Mon, 20 Mar 2023 18:06:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B06A618F9;
        Tue, 21 Mar 2023 01:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACAFC4339E;
        Tue, 21 Mar 2023 01:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360750;
        bh=J6OlYBmECTtcqyWm+bmHxpR8sRq5npyiurZDWo3UcqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TFyisV0Jo3FYWEIFVUuGShAuU+wGy5aA4xmKbcXYOP989415NzNmbABpj8/lUqKhX
         L70OSqcIcKTQNWDMrf+JbgV4sxuWxe10nHIxUCv+E49vkGsMDkLlo7Z9NKnQzPJBIr
         1Maot9q4gX8lKZojHrRhiMX8pbexJOSfHlLh5H2M9uiyc4k7cobF2t0+/leCjc+WX/
         kAb7iLKFvyqsxmEmh5v9eT7c5OuvWmAMY4l3MYLpMINC9o6oH24Jbzqpu+hlreArtP
         VrNNsQRBWXgRBb5/OZunp11R/aSnlVCyGMfDZFVAkw8b1cuSvHu3v8mFX9eLeOm3Y2
         kLJRnA1jiG9Ww==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6E0FE154039F; Mon, 20 Mar 2023 18:05:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model scripts 04/31] tools/memory-model: Make judgelitmus.sh identify bad macros
Date:   Mon, 20 Mar 2023 18:05:22 -0700
Message-Id: <20230321010549.51296-4-paulmck@kernel.org>
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

Currently, judgelitmus.sh treats use of unknown primitives (such as
srcu_read_lock() prior to SRCU support) as "!!! Verification error".
This can be misleading because it fails to call out typos and running
a version LKMM on a litmus test requiring a feature not provided by
that version.  This commit therefore changes judgelitmus.sh to check
for unknown primitives and to report them, for example, with:

	'!!! Current LKMM version does not know "rcu_write_lock"'.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/scripts/cmplitmushist.sh | 31 ++++++++++++++++++---
 tools/memory-model/scripts/judgelitmus.sh   | 12 ++++++++
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/tools/memory-model/scripts/cmplitmushist.sh b/tools/memory-model/scripts/cmplitmushist.sh
index b9c174dd8004..ca1ac8b64614 100755
--- a/tools/memory-model/scripts/cmplitmushist.sh
+++ b/tools/memory-model/scripts/cmplitmushist.sh
@@ -12,6 +12,7 @@ trap 'rm -rf $T' 0
 mkdir $T
 
 # comparetest oldpath newpath
+badmacnam=0
 timedout=0
 perfect=0
 obsline=0
@@ -19,8 +20,26 @@ noobsline=0
 obsresult=0
 badcompare=0
 comparetest () {
-	if grep -q '^Command exited with non-zero status 124' $1 ||
-	   grep -q '^Command exited with non-zero status 124' $2
+	if grep -q ': Unknown macro ' $1 || grep -q ': Unknown macro ' $2
+	then
+		if grep -q ': Unknown macro ' $1
+		then
+			badname=`grep ': Unknown macro ' $1 |
+				sed -e 's/^.*: Unknown macro //' |
+				sed -e 's/ (User error).*$//'`
+			echo 'Current LKMM version does not know "'$badname'"' $1
+		fi
+		if grep -q ': Unknown macro ' $2
+		then
+			badname=`grep ': Unknown macro ' $2 |
+				sed -e 's/^.*: Unknown macro //' |
+				sed -e 's/ (User error).*$//'`
+			echo 'Current LKMM version does not know "'$badname'"' $2
+		fi
+		badmacnam=`expr "$badmacnam" + 1`
+		return 0
+	elif grep -q '^Command exited with non-zero status 124' $1 ||
+	     grep -q '^Command exited with non-zero status 124' $2
 	then
 		if grep -q '^Command exited with non-zero status 124' $1 &&
 		   grep -q '^Command exited with non-zero status 124' $2
@@ -56,7 +75,7 @@ comparetest () {
 			return 0
 		fi
 	else
-		echo Missing Observation line "(e.g., herd7 timeout)": $2
+		echo Missing Observation line "(e.g., syntax error)": $2
 		noobsline=`expr "$noobsline" + 1`
 		return 0
 	fi
@@ -90,7 +109,7 @@ then
 fi
 if test "$noobsline" -ne 0
 then
-	echo Missing Observation line "(e.g., herd7 timeout)": $noobsline 1>&2
+	echo Missing Observation line "(e.g., syntax error)": $noobsline 1>&2
 fi
 if test "$obsresult" -ne 0
 then
@@ -100,6 +119,10 @@ if test "$timedout" -ne 0
 then
 	echo "!!!" Timed out: $timedout 1>&2
 fi
+if test "$badmacnam" -ne 0
+then
+	echo "!!!" Unknown primitive: $badmacnam 1>&2
+fi
 if test "$badcompare" -ne 0
 then
 	echo "!!!" Result changed: $badcompare 1>&2
diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index d3c313b9a458..d40439c7b71e 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -42,6 +42,18 @@ grep '^Observation' $LKMM_DESTDIR/$litmus.out
 if grep -q '^Observation' $LKMM_DESTDIR/$litmus.out
 then
 	:
+elif grep ': Unknown macro ' $LKMM_DESTDIR/$litmus.out
+then
+	badname=`grep ': Unknown macro ' $LKMM_DESTDIR/$litmus.out |
+		sed -e 's/^.*: Unknown macro //' |
+		sed -e 's/ (User error).*$//'`
+	badmsg=' !!! Current LKMM version does not know "'$badname'"'" $litmus"
+	echo $badmsg
+	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+	then
+		echo ' !!! '$badmsg >> $LKMM_DESTDIR/$litmus.out 2>&1
+	fi
+	exit 254
 elif grep '^Command exited with non-zero status 124' $LKMM_DESTDIR/$litmus.out
 then
 	echo ' !!! Timeout' $litmus
-- 
2.40.0.rc2

