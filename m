Return-Path: <linux-arch+bounces-8971-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBC79C4304
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 17:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441D81F254EE
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 16:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4D41A254F;
	Mon, 11 Nov 2024 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b="g52+/9sB"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out.freemail.hu (fmfe38.freemail.hu [46.107.16.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0932C1A706A;
	Mon, 11 Nov 2024 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.107.16.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731344000; cv=none; b=C1b+nxLGlBSPiPOj1MlR9ulWShXD+zkBqDq+OM+JaAx7Y80NQkXH3BKXvDlLT2q2lxe8gvZyDhPY/K0qylQz+jvzhXt8JhIkDOrVSPd7fV6ZRzbkPAiIaMXxV72tB1DVLFe3OzV99nb0/h1BqeyIoxiSEtg2KFzSzA3yjQ0S0EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731344000; c=relaxed/simple;
	bh=my6kpv51R2cZYX7QWBuaiZ5YJ3cTY+lUC8c8KSMPStY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fah51Ta2Nnhx/H9lxNWD98Sms2gippdZVknx3ceq+k8ioQDcQy+SB4N1+RZJlr/Wi03BOVb9E4jkW6dPh0qSS7svGwkzbkKpA6rINHDgRFqIi7uyrsGs5ZVpzC6yM7hy4jveWdtFlc0R/BMkpk3Ir39gVs8HsWwh0DAkCh2T3RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu; spf=pass smtp.mailfrom=freemail.hu; dkim=fail (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b=g52+/9sB reason="signature verification failed"; arc=none smtp.client-ip=46.107.16.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freemail.hu
Received: from localhost.localdomain (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4XnFlH3WNQzRRG;
	Mon, 11 Nov 2024 17:44:59 +0100 (CET)
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
Subject: [PATCH] tools/memory-model: Fix litmus-tests's file names for case-insensitive filesystem.
Date: Mon, 11 Nov 2024 17:42:47 +0100
Message-ID: <20241111164248.1060-1-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.47.0.windows.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1731343500;
	s=20181004; d=freemail.hu;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	l=2944; bh=cCPkD+u0S/L0jyUmIwbYJI+sFNNB67K8RH+1NXOKewo=;
	b=g52+/9sB+0+XIfF0eM+kfn7QoNqU6pZ5WWAYlEjZldfna8PP3uR+ZpL+Xq88znJA
	R1wgMjAtIPHRGoDubremxQyfjfSZ8mrga88kBJ5bPbzkU5MmxSzMjBny1JSq8UJXtmP
	YIDsuMD6G18niuEtkDOFrzEliBvtT/Zox6vNuEw6SP/JXE/BgoPhxnOXpqI475zwyUZ
	5jB51etvXr6KBKnqd/PjC5ahZjC7N+f7S8seEzlRGP/WTNyhofonPGc1S5dXzIFwIZK
	q88zFe8VflFmswH60Tl99g7dD2CA8sR7jjIH/gJe6EHsKhvuCsMrT6p6OvYGmgoW+Rh
	rc/gAf/c2g==

From: Benjamin Szőke <egyszeregy@freemail.hu>

The goal is to fix Linux repository for case-insensitive filesystem,
to able to clone it and editable on any operating systems.

Rename "Z6.0+pooncelock+poonceLock+pombonce.litmus" to
"Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus".

Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
---
 tools/memory-model/Documentation/locking.txt                    | 2 +-
 tools/memory-model/Documentation/recipes.txt                    | 2 +-
 tools/memory-model/litmus-tests/README                          | 2 +-
 ...> Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus} | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename tools/memory-model/litmus-tests/{Z6.0+pooncelock+poonceLock+pombonce.litmus => Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus} (100%)

diff --git a/tools/memory-model/Documentation/locking.txt b/tools/memory-model/Documentation/locking.txt
index 65c898c64a93..42bc3efe2015 100644
--- a/tools/memory-model/Documentation/locking.txt
+++ b/tools/memory-model/Documentation/locking.txt
@@ -184,7 +184,7 @@ ordering properties.
 Ordering can be extended to CPUs not holding the lock by careful use
 of smp_mb__after_spinlock():
 
-	/* See Z6.0+pooncelock+poonceLock+pombonce.litmus. */
+	/* See Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus. */
 	void CPU0(void)
 	{
 		spin_lock(&mylock);
diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
index 03f58b11c252..35996eb1b690 100644
--- a/tools/memory-model/Documentation/recipes.txt
+++ b/tools/memory-model/Documentation/recipes.txt
@@ -159,7 +159,7 @@ lock's ordering properties.
 Ordering can be extended to CPUs not holding the lock by careful use
 of smp_mb__after_spinlock():
 
-	/* See Z6.0+pooncelock+poonceLock+pombonce.litmus. */
+	/* See Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus. */
 	void CPU0(void)
 	{
 		spin_lock(&mylock);
diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index d311a0ff1ae6..e3d451346400 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -149,7 +149,7 @@ Z6.0+pooncelock+pooncelock+pombonce.litmus
 	spin_lock() sufficient to make ordering apparent to accesses
 	by a process not holding the lock?
 
-Z6.0+pooncelock+poonceLock+pombonce.litmus
+Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus
 	As above, but with smp_mb__after_spinlock() immediately
 	following the spin_lock().
 
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus
similarity index 100%
rename from tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
rename to tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+after_spinlock+pombonce.litmus
-- 
2.47.0.windows.2


