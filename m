Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF10A204655
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jun 2020 02:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbgFWAxl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 20:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732334AbgFWAwd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jun 2020 20:52:33 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17EA220720;
        Tue, 23 Jun 2020 00:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592873553;
        bh=CbY2F3LfZp/8PhR4hXRU/7Ytt7h8LlhQM+094/Tri6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RsXxS/raW/VOpdiQ+ZPWiAiRIaBiUyjOhrtVcy1/bqJydX989Cd4Gn5tj8u4F9mcj
         qLno+lFf0/GiDgjf+t2COBgdj/y1LIUHb3l+wE/VGctJNsgVzwLJUYjgPhJVXK+dJp
         g4Vur3mMki3bo3Kf2BbI4fHa17nyxpy8eBnF1tAc=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/14] tools/memory-model: Add recent references
Date:   Mon, 22 Jun 2020 17:52:18 -0700
Message-Id: <20200623005231.27712-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623005152.GA27459@paulmck-ThinkPad-P72>
References: <20200623005152.GA27459@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit updates the list of LKMM-related publications in
Documentation/references.txt.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
---
 tools/memory-model/Documentation/references.txt | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/Documentation/references.txt b/tools/memory-model/Documentation/references.txt
index b177f3e..ecbbaa5 100644
--- a/tools/memory-model/Documentation/references.txt
+++ b/tools/memory-model/Documentation/references.txt
@@ -73,6 +73,18 @@ o	Christopher Pulte, Shaked Flur, Will Deacon, Jon French,
 Linux-kernel memory model
 =========================
 
+o	Jade Alglave, Will Deacon, Boqun Feng, David Howells, Daniel
+	Lustig, Luc Maranget, Paul E. McKenney, Andrea Parri, Nicholas
+	Piggin, Alan Stern, Akira Yokosawa, and Peter Zijlstra.
+	2019. "Calibrating your fear of big bad optimizing compilers"
+	Linux Weekly News.  https://lwn.net/Articles/799218/
+
+o	Jade Alglave, Will Deacon, Boqun Feng, David Howells, Daniel
+	Lustig, Luc Maranget, Paul E. McKenney, Andrea Parri, Nicholas
+	Piggin, Alan Stern, Akira Yokosawa, and Peter Zijlstra.
+	2019. "Who's afraid of a big bad optimizing compiler?"
+	Linux Weekly News.  https://lwn.net/Articles/793253/
+
 o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
 	Alan Stern.  2018. "Frightening small children and disconcerting
 	grown-ups: Concurrency in the Linux kernel". In Proceedings of
@@ -88,6 +100,11 @@ o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
 	Alan Stern.  2017.  "A formal kernel memory-ordering model (part 2)"
 	Linux Weekly News.  https://lwn.net/Articles/720550/
 
+o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
+	Alan Stern.  2017-2019.  "A Formal Model of Linux-Kernel Memory
+	Ordering" (backup material for the LWN articles)
+	https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxMM/
+
 
 Memory-model tooling
 ====================
@@ -110,5 +127,5 @@ Memory-model comparisons
 ========================
 
 o	Paul E. McKenney, Ulrich Weigand, Andrea Parri, and Boqun
-	Feng. 2016. "Linux-Kernel Memory Model". (6 June 2016).
-	http://open-std.org/JTC1/SC22/WG21/docs/papers/2016/p0124r2.html.
+	Feng. 2018. "Linux-Kernel Memory Model". (27 September 2018).
+	http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p0124r6.html.
-- 
2.9.5

