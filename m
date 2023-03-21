Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24FD6C26F4
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjCUBIx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjCUBIZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:08:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A6D37F35;
        Mon, 20 Mar 2023 18:07:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85F7561924;
        Tue, 21 Mar 2023 01:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE88C43325;
        Tue, 21 Mar 2023 01:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360751;
        bh=lZo/BQz3UIZjSWUToPVQVl7BhO510z3+z/kZFOpr6Do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eqH28SQSZKbpDOkcDXEuR9n9DoC9/lhPx6oY3OJ09y0e2EgLc8/8siVxIpq3z+066
         DQhmvXe7CeSZ9kSGO70GgnF1dt+96TKc32kATHQQsev9T+NzG38vywHrh7LR9Ke0vi
         GbpUf9IJrR7AIumjRQL9zxqOZxincyBfcBWRrdmdUhovNMdWuYL2B0+Zsvn3Y8O7N0
         PSL1xNt7rO7ViZfDs2jZKxTwWZH30BlGIP4sA1lTrac5eHavwsyA4XtrziyFs7AV+0
         F+eWSFJnIpiaUECVdP8Yp3GTwQB0qc36u516f0YzFonUrsBTJ3sK/M/5C+btsu+Wv9
         2El8nmZJsoSvA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E733315403D3; Mon, 20 Mar 2023 18:05:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model scripts 31/31] tools/memory-model: Document LKMM test procedure
Date:   Mon, 20 Mar 2023 18:05:49 -0700
Message-Id: <20230321010549.51296-31-paulmck@kernel.org>
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

This commit documents how to run the various scripts in order to test
a potentially pervasive change to the memory model.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/scripts/README | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/memory-model/scripts/README b/tools/memory-model/scripts/README
index cc2c4e5be9ec..fb39bd0fd1b9 100644
--- a/tools/memory-model/scripts/README
+++ b/tools/memory-model/scripts/README
@@ -76,3 +76,35 @@ runlitmushist.sh
 README
 
 	This file
+
+Testing a change to LKMM might go as follows:
+
+	# Populate expected results without that change, and
+	# runs for about an hour on an 8-CPU x86 system:
+	scripts/initlitmushist.sh --timeout 10m --procs 10
+	# Incorporate the change:
+	git am -s -3 /path/to/patch # Or whatever it takes.
+
+	# Test the new version of LKMM as follows...
+
+	# Runs in seconds, good smoke test:
+	scripts/checkalllitmus.sh
+
+	# Compares results to those produced by initlitmushist.sh,
+	# and runs for about an hour on an 8-CPU x86 system:
+	scripts/checklitmushist.sh --timeout 10m --procs 10
+
+	# Checks results against Result tags, runs in minutes:
+	scripts/checkghlitmus.sh --timeout 10m --procs 10
+
+The checkghlitmus.sh should not report errors in cases where the
+checklitmushist.sh script did not also report a change.  However,
+this check is nevertheless valuable because it can find errors in the
+original version of LKMM.  Note however, that given the above procedure,
+an error in the original LKMM version that is fixed by the patch will
+be reported both as a mismatch by checklitmushist.sh and as an error
+by checkghlitmus.sh.  One exception to this rule of thumb is when the
+test fails completely on the original version of LKMM and passes on the
+new version.  In this case, checklitmushist.sh will report a mismatch
+and checkghlitmus.sh will report success.  This happens when the change
+to LKMM introduces a new primitive for which litmus tests already existed.
-- 
2.40.0.rc2

