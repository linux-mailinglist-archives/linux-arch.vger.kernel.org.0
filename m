Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25B5215FAA6
	for <lists+linux-arch@lfdr.de>; Sat, 15 Feb 2020 00:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgBNXbl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Feb 2020 18:31:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:57644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbgBNXbl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Feb 2020 18:31:41 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E6E82086A;
        Fri, 14 Feb 2020 23:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581723100;
        bh=mgPBTx2sVc9kiylto9Sw00yZE9WqdXxtqel2zgtm9Og=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=iCWvNBl0aNd1IUvF/ZEFzLq04hX6tZ6jb2ElE3WEu6FLLlpcHyoPl/qtC+9P4lsC0
         URBcEdtZAfY0wCINC1Yb7psDKd7O2OQDVR58Yq7OauwbMwAprpdisCTDTeahTby7Eg
         25EBbHWO8Cu6cCmliCs5SnqmOakGmdaq2dhMXy2E=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 12E7B3520D46; Fri, 14 Feb 2020 15:31:39 -0800 (PST)
Date:   Fri, 14 Feb 2020 15:31:39 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: [PATCH memory-model] Add recent references
Message-ID: <20200214233139.GA12521@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This commit updates the list of LKMM-related publications in
Documentation/references.txt.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

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
