Return-Path: <linux-arch+bounces-4125-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 244D98B9238
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 01:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D351F22459
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 23:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51580168AFA;
	Wed,  1 May 2024 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYTtNkxc"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24170168AE4;
	Wed,  1 May 2024 23:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605695; cv=none; b=FuNbdhJS4tvYv9I+l9bkWjQIVZxwKDreO5ydnpQBwBXF6qk5ngeEZEgHjGjGZ4TpOJWtPP0a3QuL0Gs+X/ZJhY/iTg/LlFilhRdZ4G+vwm0qruwu7/y4bWSslDI472/6EPYsvn8lVyHvrH7SkRgyyWqAu/MKBLx13/0ag0Fca1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605695; c=relaxed/simple;
	bh=M3rljuLjY3UhKUT1g/wRug4MwuxiMyvh+qPJzdYy2n4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PYBEZMFBvKj1gsLau7O9NJvYNH+Uyf6RG8Lnsyz4fw7K/FYs+UGXste0eKfysqAVmq9iyv4yiw3nsaJK59PIYPQFPgnujVz10T9RINc9DIFwCMldWs1N0eXrhnGLXmSph+XEoMSriOjt6+oyp4QqosKaQkBFrfdET5Qsd73/0Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYTtNkxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C658FC4AF19;
	Wed,  1 May 2024 23:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714605694;
	bh=M3rljuLjY3UhKUT1g/wRug4MwuxiMyvh+qPJzdYy2n4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XYTtNkxcIF5q4iFu1XBRlQYGdaxLZWZJ8F6KFhl5o9Snvpvdb+dJ1dR6L83txqSRF
	 NtHxoQMzq4v3IsZupeVTZBd3OPEwx0omr5rgnPUyu1TyirQ+97ZyDXl5ADF1XcC1fS
	 e/fiyecpV7QjniY+q1u/MWyPkDqPYnI7AV3qqaMYXzSEa4qXTrYdY4/a0nVUdpcGmu
	 VQS6pHNkdwqfTfs+ivFH+mevHSitULh1foSkbLQl4pevPWgKrr3LIOerYVFgWmxXNO
	 oeFlVmL58qCv9N5RlSJJd7yUGkyaCn9dFC9luH0UWwGL/YVKPwO0DnctLgFPt73acY
	 plqXwLCNADlXQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6DAF0CE1A05; Wed,  1 May 2024 16:21:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
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
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 4/4] Documentation/litmus-tests: Make cmpxchg() tests safe for klitmus
Date: Wed,  1 May 2024 16:21:32 -0700
Message-Id: <20240501232132.1785861-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <42a43181-a431-44bd-8aff-6b305f8111ba@paulmck-laptop>
References: <42a43181-a431-44bd-8aff-6b305f8111ba@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The four litmus tests in Documentation/litmus-tests/atomic do not
declare all of their local variables.  Although this is just fine for LKMM
analysis by herd7, it causes build failures when run in-kernel by klitmus.
This commit therefore adjusts these tests to declare all local variables.

Reported-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../litmus-tests/atomic/cmpxchg-fail-ordered-1.litmus         | 1 +
 .../litmus-tests/atomic/cmpxchg-fail-ordered-2.litmus         | 4 ++--
 .../litmus-tests/atomic/cmpxchg-fail-unordered-1.litmus       | 1 +
 .../litmus-tests/atomic/cmpxchg-fail-unordered-2.litmus       | 4 ++--
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-1.litmus b/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-1.litmus
index 3df1d140b189b..c0f93dc07105e 100644
--- a/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-1.litmus
+++ b/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-1.litmus
@@ -23,6 +23,7 @@ P0(int *x, int *y, int *z)
 P1(int *x, int *y, int *z)
 {
 	int r0;
+	int r1;
 
 	WRITE_ONCE(*y, 1);
 	r1 = cmpxchg(z, 1, 0);
diff --git a/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-2.litmus b/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-2.litmus
index 54146044a16f6..5c06054f46947 100644
--- a/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-2.litmus
+++ b/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-2.litmus
@@ -11,7 +11,6 @@ C cmpxchg-fail-ordered-2
 
 P0(int *x, int *y)
 {
-	int r0;
 	int r1;
 
 	WRITE_ONCE(*x, 1);
@@ -20,7 +19,8 @@ P0(int *x, int *y)
 
 P1(int *x, int *y)
 {
-	int r0;
+	int r1;
+	int r2;
 
 	r1 = cmpxchg(y, 0, 1);
 	smp_mb__after_atomic();
diff --git a/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-1.litmus b/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-1.litmus
index a727ce23b1a6e..39ea1f56a28d2 100644
--- a/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-1.litmus
+++ b/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-1.litmus
@@ -23,6 +23,7 @@ P0(int *x, int *y, int *z)
 P1(int *x, int *y, int *z)
 {
 	int r0;
+	int r1;
 
 	WRITE_ONCE(*y, 1);
 	r1 = cmpxchg(z, 1, 0);
diff --git a/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-2.litmus b/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-2.litmus
index a245bac55b578..61aab24a4a643 100644
--- a/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-2.litmus
+++ b/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-2.litmus
@@ -12,7 +12,6 @@ C cmpxchg-fail-unordered-2
 
 P0(int *x, int *y)
 {
-	int r0;
 	int r1;
 
 	WRITE_ONCE(*x, 1);
@@ -21,7 +20,8 @@ P0(int *x, int *y)
 
 P1(int *x, int *y)
 {
-	int r0;
+	int r1;
+	int r2;
 
 	r1 = cmpxchg(y, 0, 1);
 	r2 = READ_ONCE(*x);
-- 
2.40.1


