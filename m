Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BB86C26D9
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCUBHG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjCUBGn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:06:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D162F787;
        Mon, 20 Mar 2023 18:06:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B54DAB81193;
        Tue, 21 Mar 2023 01:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C87C4339C;
        Tue, 21 Mar 2023 01:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360751;
        bh=BcCJ+qSBUKa4G2l6JvwxjG9mad7Ur5MYs+xW5IuzN/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ePPi1fJSo7DeYmKzI/bJNrPO4/9Km+oNdko67AUdmQw67RbW6VB/85Qn3jGs7LFbQ
         b+KFqVXnNTu0Z9LZuup6jSC80+jIrI6FR7Wln12My6aW9imRGx8nzcSkAZS9xygMFE
         Syx6fJOqJ+yCVau5I0RejWvfUCdbgDDtB8sXSUG9cA3zfvwo31Dplw4vU0BsSC1IA8
         zh/uEZGFmOR9SfO4n5S7R/XgTbcbPE46Ceh7ZTZNyukuNJTdCpC27l5Jxy1Wihsd4F
         Bv1ZFSkPSEDREQgbKgyp6UDFbmXTWlqsRMUJHG/yXILjEHDCHp+MDK4CoGAAxTDuoL
         7vu2UcmooxXpQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7A4A215403A5; Mon, 20 Mar 2023 18:05:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model scripts 07/31] tools/memory-model: Update parseargs.sh for hardware verification
Date:   Mon, 20 Mar 2023 18:05:25 -0700
Message-Id: <20230321010549.51296-7-paulmck@kernel.org>
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

This commit adds a --hw argument to parseargs.sh to specify the CPU
family for a hardware verification.  For example, "--hw AArch64" will
specify that a C-language litmus test is to be translated to ARMv8 and
the result verified.  This will set the LKMM_HW_MAP_FILE environment
variable accordingly.  If there is no --hw argument, this environment
variable will be set to the empty string.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/scripts/parseargs.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/scripts/parseargs.sh b/tools/memory-model/scripts/parseargs.sh
index afe7bd23de6b..5f016fc3f3af 100755
--- a/tools/memory-model/scripts/parseargs.sh
+++ b/tools/memory-model/scripts/parseargs.sh
@@ -27,6 +27,7 @@ initparam () {
 
 initparam LKMM_DESTDIR "."
 initparam LKMM_HERD_OPTIONS "-conf linux-kernel.cfg"
+initparam LKMM_HW_MAP_FILE ""
 initparam LKMM_JOBS `getconf _NPROCESSORS_ONLN`
 initparam LKMM_PROCS "3"
 initparam LKMM_TIMEOUT "1m"
@@ -37,10 +38,11 @@ usagehelp () {
 	echo "Usage $scriptname [ arguments ]"
 	echo "      --destdir path (place for .litmus.out, default by .litmus)"
 	echo "      --herdopts -conf linux-kernel.cfg ..."
+	echo "      --hw AArch64"
 	echo "      --jobs N (number of jobs, default one per CPU)"
 	echo "      --procs N (litmus tests with at most this many processes)"
 	echo "      --timeout N (herd7 timeout (e.g., 10s, 1m, 2hr, 1d, '')"
-	echo "Defaults: --destdir '$LKMM_DESTDIR_DEF' --herdopts '$LKMM_HERD_OPTIONS_DEF' --jobs '$LKMM_JOBS_DEF' --procs '$LKMM_PROCS_DEF' --timeout '$LKMM_TIMEOUT_DEF'"
+	echo "Defaults: --destdir '$LKMM_DESTDIR_DEF' --herdopts '$LKMM_HERD_OPTIONS_DEF' --hw '$LKMM_HW_MAP_FILE' --jobs '$LKMM_JOBS_DEF' --procs '$LKMM_PROCS_DEF' --timeout '$LKMM_TIMEOUT_DEF'"
 	exit 1
 }
 
@@ -95,6 +97,11 @@ do
 		LKMM_HERD_OPTIONS="$2"
 		shift
 		;;
+	--hw)
+		checkarg --hw "(.map file architecture name)" "$#" "$2" '^[A-Za-z0-9_-]\+' '^--'
+		LKMM_HW_MAP_FILE="$2"
+		shift
+		;;
 	-j[1-9]*)
 		njobs="`echo $1 | sed -e 's/^-j//'`"
 		trailchars="`echo $njobs | sed -e 's/[0-9]\+\(.*\)$/\1/'`"
-- 
2.40.0.rc2

