Return-Path: <linux-arch+bounces-5902-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7094994554B
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 02:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295F1286737
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 00:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FC3C156;
	Fri,  2 Aug 2024 00:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rx547oAj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE5DA92D;
	Fri,  2 Aug 2024 00:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558138; cv=none; b=XDiAqTNJYnqQUYfMKljKV8mHGAopSo6QkjA5FvUz/RFFb/sFMyDRgxWAd3B7WqrtuMhqA8An514+3rkvbhVtVantjhBjVGhgdE7ddKohCruwtx+oj/wWpUC9Yv0X4E7DJDEBQIASBDQBCi/S/0fh35i5IXx0yl7Dp/6gl6VgGbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558138; c=relaxed/simple;
	bh=HWgXzYpJ7/mbDcOQ+89qAzkXxLhuNy9Ezr+ijzp8aQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E8Uwn24jqAr7CbkHqYS7WBs17fBV4OlppAqE7V//h2bYdEaZLF0FoXtKriYgElAOvfFhuQjopd+Fsy6vm4Y21VlaPL5qRAATNjmXPbLsS9RUSpL2EHsIx3Q9l0XrPXpeWosYW4ORkbq7HkMv/Wyan/I+F6oCdAwbb+T37L7k6tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rx547oAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A22C4AF0E;
	Fri,  2 Aug 2024 00:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722558137;
	bh=HWgXzYpJ7/mbDcOQ+89qAzkXxLhuNy9Ezr+ijzp8aQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rx547oAjhx0eCaJSEDCH1dUI0bkjyduk0/5k/th+eB5774fuQUS4wY4bPDix780dw
	 yexIIUSusFf/0thrndRb6/j1M586ecscemJZmDUqHX1EcTxXOdr6Jh2mkUVC7pAEKF
	 tipcKybyht6iE+dC1kWFzTATYDErokkwL25TWktIuz5BlqEYwlbdBfwuEaBGbMqXnv
	 AJHv2+vlLlj1sY0K436g/7L1wFfxZobI/VtFKlvcib1mvcbr2ETrXhtxLQQfjVUTiH
	 Z4ID0Q8faVmp3i0j2JgrpYFVn7vNYaT7jA+48yk7WCmiRSC4jWU/AhXMJLTG80lqbs
	 /jyyGGb4Iqerg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 385E2CE0E0B; Thu,  1 Aug 2024 17:22:17 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	kernel-team@meta.com,
	mingo@kernel.org
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	npiggin@gmail.com,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	akiyks@gmail.com,
	Marco Elver <elver@google.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 4/7] tools/memory-model: Add locking.txt and glossary.txt to README
Date: Thu,  1 Aug 2024 17:22:12 -0700
Message-Id: <20240802002215.4133695-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e384a9ac-05c1-45d6-9639-28457dd183d9@paulmck-laptop>
References: <e384a9ac-05c1-45d6-9639-28457dd183d9@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Akira Yokosawa <akiyks@gmail.com>

locking.txt and glossary.txt have been in LKMM's documentation for
quite a while.

Add them in README's introduction of docs and the list of docs at the
bottom.  Add access-marking.txt in the former as well.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Cc: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/README | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
index 44e7dae73b296..9999c1effdb65 100644
--- a/tools/memory-model/Documentation/README
+++ b/tools/memory-model/Documentation/README
@@ -9,6 +9,8 @@ depending on what you know and what you would like to learn.  Please note
 that the documents later in this list assume that the reader understands
 the material provided by documents earlier in this list.
 
+If LKMM-specific terms lost you, glossary.txt might help you.
+
 o	You are new to Linux-kernel concurrency: simple.txt
 
 o	You have some background in Linux-kernel concurrency, and would
@@ -21,6 +23,9 @@ o	You are familiar with the Linux-kernel concurrency primitives
 	that you need, and just want to get started with LKMM litmus
 	tests:  litmus-tests.txt
 
+o	You would like to access lock-protected shared variables without
+	having their corresponding locks held:  locking.txt
+
 o	You are familiar with Linux-kernel concurrency, and would
 	like a detailed intuitive understanding of LKMM, including
 	situations involving more than two threads:  recipes.txt
@@ -28,6 +33,11 @@ o	You are familiar with Linux-kernel concurrency, and would
 o	You would like a detailed understanding of what your compiler can
 	and cannot do to control dependencies:  control-dependencies.txt
 
+o	You would like to mark concurrent normal accesses to shared
+	variables so that intentional "racy" accesses can be properly
+	documented, especially when you are responding to complaints
+	from KCSAN:  access-marking.txt
+
 o	You are familiar with Linux-kernel concurrency and the use of
 	LKMM, and would like a quick reference:  cheatsheet.txt
 
@@ -62,6 +72,9 @@ control-dependencies.txt
 explanation.txt
 	Detailed description of the memory model.
 
+glossary.txt
+	Brief definitions of LKMM-related terms.
+
 herd-representation.txt
 	The (abstract) representation of the Linux-kernel concurrency
 	primitives in terms of events.
@@ -70,6 +83,10 @@ litmus-tests.txt
 	The format, features, capabilities, and limitations of the litmus
 	tests that LKMM can evaluate.
 
+locking.txt
+	Rules for accessing lock-protected shared variables outside of
+	their corresponding critical sections.
+
 ordering.txt
 	Overview of the Linux kernel's low-level memory-ordering
 	primitives by category.
-- 
2.40.1


