Return-Path: <linux-arch+bounces-9325-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9E89E9A0E
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2024 16:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736461889ED7
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2024 15:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D5A1BEF6D;
	Mon,  9 Dec 2024 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b="VRTaDCjC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out.freemail.hu (fmfe28.freemail.hu [46.107.16.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255CF1B424E;
	Mon,  9 Dec 2024 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.107.16.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756845; cv=none; b=PFkxFwgcsT+ZwiRQC+N/8ry5OcKLn1MO8dw7swRhQmQMGAsa3hDCAFbZyG81O2gSTOGKT9oPPAQepcCoK462fvxFuMDwAIpRmA7N7yYaLWhCyMILzutxwM2W2sByBCDEUIYznqNDRQb7KDLnRMd3YF/03pglK8sZ1y+ZpPq4s9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756845; c=relaxed/simple;
	bh=omwpng1i8gxHWfLCQAszdvv0/rfHLpmaQ3YHCWoyioY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h7Dej3zBXs7tWsTGo3S6vpUH28V659A2RGeuvXDJx/9ribZ/6e5nvKS9t6pV7W79K199Hxuz+9z3/4YBgKahl8DKvtmD2lRFxal+7SKD/W0j4EN1aP2tdtfkyQ3Mxfglma3257UVif3FR8tu1xfrHwFpmO2sZgnNCyFSYtFAZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu; spf=pass smtp.mailfrom=freemail.hu; dkim=fail (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b=VRTaDCjC reason="signature verification failed"; arc=none smtp.client-ip=46.107.16.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freemail.hu
Received: from localhost.localdomain (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4Y6Q770QRXz12YW;
	Mon, 09 Dec 2024 16:01:38 +0100 (CET)
From: egyszeregy@freemail.hu
To: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	npiggin@gmail.com,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	paulmck@kernel.org,
	akiyks@gmail.com,
	dlustig@nvidia.com,
	joel@joelfernandes.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev
Cc: =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH] tools/memory-model: Fix litmus-tests's file names.
Date: Mon,  9 Dec 2024 16:00:44 +0100
Message-ID: <20241209150044.766-1-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.47.1.windows.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1733756503;
	s=20181004; d=freemail.hu;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	l=4399; bh=VCNo93+SR6kYKMk9U3TzOw7N+/lFY0qfFZtD+RCCluk=;
	b=VRTaDCjCBaJl6ylXyEA9qtKpXkANb1JYzMWXqk7dPwHzI79AF3o5Od0Az9tfYzNX
	n04vsH/Y13eWdj8ludVV66BBXcZ/NyRUaUjbzFcvP6Os2DSUVHITqyOYZqz2TpwfWPg
	vBUFhudDHcVvpOR0svuXkmb3QNoUnZqHe5y064b73y9jgKY8W5kBI1ixzg7PEiV5BMK
	cez5ZNUmnm8RF1oQk6G4i1Y/oK1lOP3ef4IXmSllXgW5sIptVGF9iHdtl9E4y0qxVp5
	R0cFq/utEe1JvLSoNXYr/QiN7NnVTQiHHqC+RiQhcfx5poCO2V8G75q2UdwdPEvZwgb
	hnU4tgmfEQ==

From: Benjamin Szőke <egyszeregy@freemail.hu>

Makes a greater Hamming distance for name of Z6.0+pooncelock* files.

Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
---
 tools/memory-model/Documentation/locking.txt                  | 4 ++--
 tools/memory-model/Documentation/recipes.txt                  | 4 ++--
 tools/memory-model/litmus-tests/README                        | 4 ++--
 ...ncelock+pooncelock+smp_mb__after_spinlock+pombonce.litmus} | 0
 ...s => Z6.0+pooncelock+pooncelock+spin_lock+pombonce.litmus} | 0
 5 files changed, 6 insertions(+), 6 deletions(-)
 rename tools/memory-model/litmus-tests/{Z6.0+pooncelock+poonceLock+pombonce.litmus => Z6.0+pooncelock+pooncelock+smp_mb__after_spinlock+pombonce.litmus} (100%)
 rename tools/memory-model/litmus-tests/{Z6.0+pooncelock+pooncelock+pombonce.litmus => Z6.0+pooncelock+pooncelock+spin_lock+pombonce.litmus} (100%)

diff --git a/tools/memory-model/Documentation/locking.txt b/tools/memory-model/Documentation/locking.txt
index 65c898c64a93..c213aa4a8668 100644
--- a/tools/memory-model/Documentation/locking.txt
+++ b/tools/memory-model/Documentation/locking.txt
@@ -151,7 +151,7 @@ Ordering Provided by a Lock to CPUs Not Holding That Lock
 It is not necessarily the case that accesses ordered by locking will be
 seen as ordered by CPUs not holding that lock.  Consider this example:
 
-	/* See Z6.0+pooncelock+pooncelock+pombonce.litmus. */
+	/* See Z6.0+pooncelock+pooncelock+spin_lock+pombonce.litmus. */
 	void CPU0(void)
 	{
 		spin_lock(&mylock);
@@ -184,7 +184,7 @@ ordering properties.
 Ordering can be extended to CPUs not holding the lock by careful use
 of smp_mb__after_spinlock():
 
-	/* See Z6.0+pooncelock+poonceLock+pombonce.litmus. */
+	/* See Z6.0+pooncelock+pooncelock+smp_mb__after_spinlock+pombonce.litmus. */
 	void CPU0(void)
 	{
 		spin_lock(&mylock);
diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
index 03f58b11c252..3c55146e8fe4 100644
--- a/tools/memory-model/Documentation/recipes.txt
+++ b/tools/memory-model/Documentation/recipes.txt
@@ -126,7 +126,7 @@ However, it is not necessarily the case that accesses ordered by
 locking will be seen as ordered by CPUs not holding that lock.
 Consider this example:
 
-	/* See Z6.0+pooncelock+pooncelock+pombonce.litmus. */
+	/* See Z6.0+pooncelock+pooncelock+spin_lock+pombonce.litmus. */
 	void CPU0(void)
 	{
 		spin_lock(&mylock);
@@ -159,7 +159,7 @@ lock's ordering properties.
 Ordering can be extended to CPUs not holding the lock by careful use
 of smp_mb__after_spinlock():
 
-	/* See Z6.0+pooncelock+poonceLock+pombonce.litmus. */
+	/* See Z6.0+pooncelock+pooncelock+smp_mb__after_spinlock+pombonce.litmus. */
 	void CPU0(void)
 	{
 		spin_lock(&mylock);
diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index d311a0ff1ae6..82e5b58b8ac6 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -144,12 +144,12 @@ WRC+pooncerelease+fencermbonceonce+Once.litmus
 	The second is forbidden because smp_store_release() is
 	A-cumulative in LKMM.
 
-Z6.0+pooncelock+pooncelock+pombonce.litmus
+Z6.0+pooncelock+pooncelock+spin_lock+pombonce.litmus
 	Is the ordering provided by a spin_unlock() and a subsequent
 	spin_lock() sufficient to make ordering apparent to accesses
 	by a process not holding the lock?
 
-Z6.0+pooncelock+poonceLock+pombonce.litmus
+Z6.0+pooncelock+pooncelock+smp_mb__after_spinlock+pombonce.litmus
 	As above, but with smp_mb__after_spinlock() immediately
 	following the spin_lock().
 
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+smp_mb__after_spinlock+pombonce.litmus
similarity index 100%
rename from tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
rename to tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+smp_mb__after_spinlock+pombonce.litmus
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+spin_lock+pombonce.litmus
similarity index 100%
rename from tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
rename to tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+spin_lock+pombonce.litmus
-- 
2.43.5


