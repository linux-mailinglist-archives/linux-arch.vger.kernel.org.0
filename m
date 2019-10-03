Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38275C959A
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2019 02:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbfJCA04 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Oct 2019 20:26:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729594AbfJCA0z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:26:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7456E222C2;
        Thu,  3 Oct 2019 00:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570062414;
        bh=UIer+ImWbhsfE6eMP+vM/96a+xdplZcwIyzpX0e1Eow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MphmhYOQYust02njgzkLT1s8+5hjkouQobysLlQDpNgfzaR8ZzEtNXtkrTd/gF6wa
         xSdWRstnsjeEJFDAb4vr9fwL/lF16BCaJmvzR94qv+7XqnbvOj0fPhJ6EVvY0FEtMz
         XDTaLRIY/fr/ywVM6h9AOWJlERzlzbZPUs3iekSI=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 08/32] tools/memory-model: Make judgelitmus.sh detect hard deadlocks
Date:   Wed,  2 Oct 2019 17:26:26 -0700
Message-Id: <20191003002650.11249-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

If a litmus test specifies "Result: Never" and if it contains an
unconditional ("hard") deadlock, then running checklitmus.sh on it will
not flag any errors, despite the fact that there are no executions.
This commit therefore updates judgelitmus.sh to complain about tests
with no executions that are marked, but not as "Result: DEADLOCK".

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/judgelitmus.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index d40439c..84c62ee 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -83,6 +83,14 @@ then
 		fi
 		ret=1
 	fi
+elif grep '^Observation' $LKMM_DESTDIR/$litmus.out | grep -q 'Never 0 0$'
+then
+	echo " !!! Unexpected non-$outcome deadlock" $litmus
+	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+	then
+		echo " !!! Unexpected non-$outcome deadlock" $litmus >> $LKMM_DESTDIR/$litmus.out 2>&1
+	fi
+	ret=1
 elif grep '^Observation' $LKMM_DESTDIR/$litmus.out | grep -q $outcome || test "$outcome" = Maybe
 then
 	ret=0
-- 
2.9.5

