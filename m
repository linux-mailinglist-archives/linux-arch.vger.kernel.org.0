Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297D32EC26B
	for <lists+linux-arch@lfdr.de>; Wed,  6 Jan 2021 18:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbhAFRhV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Jan 2021 12:37:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbhAFRhV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 6 Jan 2021 12:37:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B372E20657;
        Wed,  6 Jan 2021 17:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954600;
        bh=wj3HaNixVkUoCdMWDV3gqv9RNsgUKYMMrBr4rQ/Li34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vvz7yoO0xg9KXBbwJe7xVTaDIeW9yGAwHPnxiR8yi1h0bcHkV/E9ngKR6CohYbIDk
         s7WYdd5YzS1C9MMgW9MuOtq8hAGbmE3eR8ddR9bvQMVpEyloBr0gtwklHSLxU5Rv7O
         ETHZA4g59Ojjrw004DZvrPxe2UmqvTrf1AGWkCqYqPVoB9EZLejPzEiiH95mqSWTli
         +yICFjxcyN8GuSnnBZ8v0kDdUwuDYQiqn1AsGajz0itNXg1Eglrn+rb3KwqDlfOVgd
         g2JJ05vGMpViuNVU/sxNrYhrDALBhtjyPwC6cj8ps3xM0JaTR0kdpSgpXac22ImAuu
         OvQuvCP2D7QYQ==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/3] tools/memory-model: Tie acquire loads to reads-from
Date:   Wed,  6 Jan 2021 09:36:36 -0800
Message-Id: <20210106173638.23741-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106173548.GA23664@paulmck-ThinkPad-P72>
References: <20210106173548.GA23664@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit explicitly makes the connection between acquire loads and
the reads-from relation.  It also adds an entry for happens-before,
and refers to the corresponding section of explanation.txt.

Reported-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/glossary.txt | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/Documentation/glossary.txt b/tools/memory-model/Documentation/glossary.txt
index 79acb75..b2da636 100644
--- a/tools/memory-model/Documentation/glossary.txt
+++ b/tools/memory-model/Documentation/glossary.txt
@@ -33,10 +33,11 @@ Acquire:  With respect to a lock, acquiring that lock, for example,
 	acquire loads.
 
 	When an acquire load returns the value stored by a release store
-	to that same variable, then all operations preceding that store
-	happen before any operations following that load acquire.
+	to that same variable, (in other words, the acquire load "reads
+	from" the release store), then all operations preceding that
+	store "happen before" any operations following that load acquire.
 
-	See also "Relaxed" and "Release".
+	See also "Happens-Before", "Reads-From", "Relaxed", and "Release".
 
 Coherence (co):  When one CPU's store to a given variable overwrites
 	either the value from another CPU's store or some later value,
@@ -119,6 +120,11 @@ Fully Ordered:  An operation such as smp_mb() that orders all of
 	that orders all of its CPU's prior accesses, itself, and
 	all of its CPU's subsequent accesses.
 
+Happens-Before (hb): A relation between two accesses in which LKMM
+	guarantees the first access precedes the second.  For more
+	detail, please see the "THE HAPPENS-BEFORE RELATION: hb"
+	section of explanation.txt.
+
 Marked Access:  An access to a variable that uses an special function or
 	macro such as "r1 = READ_ONCE(x)" or "smp_store_release(&a, 1)".
 
-- 
2.9.5

