Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59500C95A9
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2019 02:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfJCA1Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Oct 2019 20:27:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729713AbfJCA1B (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:27:01 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D97B2246E;
        Thu,  3 Oct 2019 00:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570062421;
        bh=NQW3CehBtAInTJZqDZIxpnB6Y/qdFSCg+MVonkzAHFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B2d/yzvlfxDGLkFD1jiq5K+00Kd8qPQBCoApFP5Ybjh00iYprcypGTHhTdiWaUz/7
         9iboLgUMyk9/AoAIujIMLSnb+ybgOgo7PqZaN/0gVkylL8O0hu0p++vp3uSbA400YC
         sM6IytEf2V50/E6K3yJjnAo0an+Xv13i6vmXIbpQ=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 31/32] tools/memory-model: Make judgelitmus.sh handle scripted Result: tag
Date:   Wed,  2 Oct 2019 17:26:49 -0700
Message-Id: <20191003002650.11249-31-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

The scripts that generate the litmus tests in the "auto" directory of
the https://github.com/paulmckrcu/litmus archive place the "Result:"
tag into a single-line ocaml comment, which judgelitmus.sh currently
does not recognize.  This commit therefore makes judgelitmus.sh
recognize both the multiline comment format that it currently does
and the automatically generated single-line format.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/judgelitmus.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index 2700481..1ec5d89 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -57,10 +57,10 @@ if grep -q '^Flag data-race$' "$LKMM_DESTDIR/$litmusout"
 then
 	datarace_modeled=1
 fi
-if grep -q '^ \* Result: ' $litmus
+if grep -q '^[( ]\* Result: ' $litmus
 then
-	outcome=`grep -m 1 '^ \* Result: ' $litmus | awk '{ print $3 }'`
-	if grep -m1 '^ \* Result: .* DATARACE' $litmus
+	outcome=`grep -m 1 '^[( ]\* Result: ' $litmus | awk '{ print $3 }'`
+	if grep -m1 '^[( ]\* Result: .* DATARACE' $litmus
 	then
 		datarace_predicted=1
 	fi
-- 
2.9.5

