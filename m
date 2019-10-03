Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0527DC95BA
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2019 02:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfJCA2D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Oct 2019 20:28:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729670AbfJCA06 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:26:58 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40C19222CA;
        Thu,  3 Oct 2019 00:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570062418;
        bh=IYs0tzMDjFCdBz8ZzedtPcEK/e++vPXg5ifgdRrKJF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KETAYtH1jVMf6cW0Tuqpk9vb4j9qx0l1GhsEJgx9RnsYpvd7zjbIq7xalZqbW3elV
         ssFzJHNU7LSHGYtMMckFbPpuvO+n84ijr2e/mYzKBgzHZw1+NG8htLh38ctm4EfYcY
         /niGDcwXy5zY1wSnmTwP5srmzmXlrdMimWdUEkp8=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 21/32] tools/memory-model: Make runlitmus.sh check for jingle errors
Date:   Wed,  2 Oct 2019 17:26:39 -0700
Message-Id: <20191003002650.11249-21-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

It turns out that the jingle7 tool is currently a bit picky about
the litmus tests it is willing to process.  This commit therefore
ensures that jingle7 failures are reported.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/runlitmus.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/memory-model/scripts/runlitmus.sh b/tools/memory-model/scripts/runlitmus.sh
index afb196d..5f2d29b 100755
--- a/tools/memory-model/scripts/runlitmus.sh
+++ b/tools/memory-model/scripts/runlitmus.sh
@@ -69,6 +69,11 @@ fi
 # Generate the assembly code and run herd7 on it.
 gen_theme7 -n 10 -map $mapfile -call Linux.call > $themefile
 jingle7 -theme $themefile $litmus > $LKMM_DESTDIR/$hwlitmus 2> $T/$hwlitmusfile.jingle7.out
+if grep -q "Generated 0 tests" $T/$hwlitmusfile.jingle7.out
+then
+	echo ' !!! ' jingle7 failed, no $hwlitmus generated
+	exit 253
+fi
 /usr/bin/time $LKMM_TIMEOUT_CMD herd7 $LKMM_DESTDIR/$hwlitmus > $LKMM_DESTDIR/$hwlitmus.out 2>&1
 
 exit $?
-- 
2.9.5

