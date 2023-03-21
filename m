Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA2B6C26D6
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjCUBHH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjCUBGn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:06:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F9E3029B;
        Mon, 20 Mar 2023 18:06:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1340BCE1745;
        Tue, 21 Mar 2023 01:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB747C4331F;
        Tue, 21 Mar 2023 01:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360751;
        bh=TZ/HARgy2h040ZnfHsCeMp2AvhKFuiI8pmwwADeA4vE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PfIudBR6f5u5j2wiIDbYIX5bnTglR4QomDedyfgFDH575mdR3JgpyUgc7zrxeMJ5x
         BJiUmDmkAH2/pGlju4O0ZxnsiqhjuHR7r8ZgwLPYgiLiGLq3crQjqhM0n1i8wmh8ZQ
         KgInFrOSB/lN+YYcIfTXjj4icJrT60oHSWXFYHS1BKjr5uE0xIOSgePdewYIGlU11B
         zp84khUvxTmvUhm30jYqKIMmtj3fKQOzGmAWnD03TG574E2e11nsYi57xIFwzGyqZu
         m42jJp43sDbPe3EeXootZW3aa6P8ext/8OHzu2TJ2Ez+blmjLIRCpgnLfHI4gWXAkG
         yrDJ8kCfEHG+A==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C931915403C7; Mon, 20 Mar 2023 18:05:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model scripts 24/31] tools/memory-model:  Add "--" to parseargs.sh for additional arguments
Date:   Mon, 20 Mar 2023 18:05:42 -0700
Message-Id: <20230321010549.51296-24-paulmck@kernel.org>
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

Currently, parseargs.sh expects to consume all the command-line arguments,
which prevents the calling script from having any of its own arguments.
This commit therefore causes parseargs.sh to stop consuming arguments
when it encounters a "--" argument, leaving any remaining arguments for
the calling script.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/scripts/parseargs.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/scripts/parseargs.sh b/tools/memory-model/scripts/parseargs.sh
index 25a81ac0dfdf..7aa58755adfc 100755
--- a/tools/memory-model/scripts/parseargs.sh
+++ b/tools/memory-model/scripts/parseargs.sh
@@ -83,7 +83,7 @@ do
 			echo "Cannot create directory --destdir '$LKMM_DESTDIR'"
 			usage
 		fi
-		if test -d "$LKMM_DESTDIR" -a -w "$LKMM_DESTDIR" -a -x "$LKMM_DESTDIR"
+		if test -d "$LKMM_DESTDIR" -a -x "$LKMM_DESTDIR"
 		then
 			:
 		else
@@ -127,6 +127,10 @@ do
 		LKMM_TIMEOUT="$2"
 		shift
 		;;
+	--)
+		shift
+		break
+		;;
 	*)
 		echo Unknown argument $1
 		usage
-- 
2.40.0.rc2

