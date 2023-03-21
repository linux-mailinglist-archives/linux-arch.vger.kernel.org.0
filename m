Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274E36C26DD
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjCUBHk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjCUBHK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:07:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E831435EC1;
        Mon, 20 Mar 2023 18:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 346EBB80EE1;
        Tue, 21 Mar 2023 01:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8303C433EF;
        Tue, 21 Mar 2023 01:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360750;
        bh=66fYO9OVQplP/m4cZx4nY/W+d2lsgc9WphuPkVI1Jl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lz00lwvBbrizCwyi9/H+KmA7hoeOPl+uI61gEPfF5XBZMG5p/q9D7eOIWAQQw7ic1
         2kU2L8/RPXxMkmKQ4ST2RbDcBt+5SKl7I7wG3XTupNQBJnDsDl7+P39prMHuPt5Bf+
         lxTxI2wYdrlt46gwt5gV9XtubLI1Z3QJJ+HosH1KPhNi8983a305hJrURCzRqGOncj
         g51icQ2iraFdfAMFxtWcEYZ/OQOhXcS9+xEOQTbGsBD4ALA2hpE7779ifT1yOmUNrE
         kVw0qVkWEEneMkufTvRL3rCfgfAB/n20CSkfzXHattpzkhjX8nG4Ru/q4Oru6ECz49
         jMJdKsg47bN8Q==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6A1EC154039D; Mon, 20 Mar 2023 18:05:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model scripts 03/31] tools/memory-model: Make cmplitmushist.sh note timeouts
Date:   Mon, 20 Mar 2023 18:05:21 -0700
Message-Id: <20230321010549.51296-3-paulmck@kernel.org>
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

Currently, cmplitmushist.sh treats timeouts (as in the "--timeout"
argument) as "Missing Observation line".  This can be misleading because
it is quite possible that running the test longer would have produced
a verification.  This commit therefore changes cmplitmushist.sh to check
for timeouts and to report them with "Timed out".

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/scripts/cmplitmushist.sh | 22 +++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/memory-model/scripts/cmplitmushist.sh b/tools/memory-model/scripts/cmplitmushist.sh
index 0f498aeeccf5..b9c174dd8004 100755
--- a/tools/memory-model/scripts/cmplitmushist.sh
+++ b/tools/memory-model/scripts/cmplitmushist.sh
@@ -12,12 +12,30 @@ trap 'rm -rf $T' 0
 mkdir $T
 
 # comparetest oldpath newpath
+timedout=0
 perfect=0
 obsline=0
 noobsline=0
 obsresult=0
 badcompare=0
 comparetest () {
+	if grep -q '^Command exited with non-zero status 124' $1 ||
+	   grep -q '^Command exited with non-zero status 124' $2
+	then
+		if grep -q '^Command exited with non-zero status 124' $1 &&
+		   grep -q '^Command exited with non-zero status 124' $2
+		then
+			echo Both runs timed out: $2
+		elif grep -q '^Command exited with non-zero status 124' $1
+		then
+			echo Old run timed out: $2
+		elif grep -q '^Command exited with non-zero status 124' $2
+		then
+			echo New run timed out: $2
+		fi
+		timedout=`expr "$timedout" + 1`
+		return 0
+	fi
 	grep -v 'maxresident)k\|minor)pagefaults\|^Time' $1 > $T/oldout
 	grep -v 'maxresident)k\|minor)pagefaults\|^Time' $2 > $T/newout
 	if cmp -s $T/oldout $T/newout && grep -q '^Observation' $1
@@ -78,6 +96,10 @@ if test "$obsresult" -ne 0
 then
 	echo Matching Observation Always/Sometimes/Never result: $obsresult 1>&2
 fi
+if test "$timedout" -ne 0
+then
+	echo "!!!" Timed out: $timedout 1>&2
+fi
 if test "$badcompare" -ne 0
 then
 	echo "!!!" Result changed: $badcompare 1>&2
-- 
2.40.0.rc2

