Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794856C26DB
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjCUBHj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjCUBHK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:07:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135CF1A650;
        Mon, 20 Mar 2023 18:06:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A8F461902;
        Tue, 21 Mar 2023 01:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DAFC433A1;
        Tue, 21 Mar 2023 01:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360751;
        bh=vZ6Pz1PKh0WTymN7JYe3wWXpRMV+Iv9Ig+pyu93inaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XGIeTiTOfudRsodlK5j6XICuMR3vxJ9Mf70sQFLPOsiSHs3ciru/6S/aS7VQ0qJB9
         1gNWayQm2GHRpEIxSTr3uz5HhomtPVkk/mt1C4lhDORiUNvzO8WE6OGnhJyy7JQm5M
         eG5uPqYqbGlTN3K6S9sv87GYAaXa6gsPxOHtVMzzyE4GwL+TnAuJpDD2IkAn9i9CXa
         iuHkvQdVo74UPIQpIhQuGhRUo4WK9CmYicYvADZymyHR0aG591ekvbim0mAQnTeK5X
         oEzY9QKImvMvktw3mAJGmdJ1L/eI9g2yPO+K0ccrkt7+3MvEaHsFXZUaXQMhu8L+FO
         aDNMDv9o7aILg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8246315403A9; Mon, 20 Mar 2023 18:05:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model scripts 09/31] tools/memory-model: Add simpletest.sh to check locking, RCU, and SRCU
Date:   Mon, 20 Mar 2023 18:05:27 -0700
Message-Id: <20230321010549.51296-9-paulmck@kernel.org>
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

This commit abstracts out common function to check a given litmus test
for locking, RCU, and SRCU in order to avoid duplicating code.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/scripts/simpletest.sh | 35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100755 tools/memory-model/scripts/simpletest.sh

diff --git a/tools/memory-model/scripts/simpletest.sh b/tools/memory-model/scripts/simpletest.sh
new file mode 100755
index 000000000000..7edc5d361665
--- /dev/null
+++ b/tools/memory-model/scripts/simpletest.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Give zero status if this is a simple test and non-zero otherwise.
+# Simple tests do not contain locking, RCU, or SRCU.
+#
+# Usage:
+#	simpletest.sh file.litmus
+#
+# Copyright IBM Corporation, 2019
+#
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
+
+
+litmus=$1
+
+if test -f "$litmus" -a -r "$litmus"
+then
+	:
+else
+	echo ' --- ' error: \"$litmus\" is not a readable file
+	exit 255
+fi
+exclude="^[[:space:]]*\("
+exclude="${exclude}spin_lock(\|spin_unlock(\|spin_trylock(\|spin_is_locked("
+exclude="${exclude}\|rcu_read_lock(\|rcu_read_unlock("
+exclude="${exclude}\|synchronize_rcu(\|synchronize_rcu_expedited("
+exclude="${exclude}\|srcu_read_lock(\|srcu_read_unlock("
+exclude="${exclude}\|synchronize_srcu(\|synchronize_srcu_expedited("
+exclude="${exclude}\)"
+if grep -q $exclude $litmus
+then
+	exit 255
+fi
+exit 0
-- 
2.40.0.rc2

