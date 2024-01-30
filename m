Return-Path: <linux-arch+bounces-1850-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39DE84273A
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 15:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D912B2A103
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 14:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22067CF2F;
	Tue, 30 Jan 2024 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8ju5eRW"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827187CF1B;
	Tue, 30 Jan 2024 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626419; cv=none; b=eFb3K5KFQuWryM4meATt5085SToCnBdOVx27lWKHGPaFDy4QXG+zYJg998rGKUAaWFB8k8f/XiQnEvuVAwlerB5Zg9urhr2bDamCYXAMfOTL44Nh9fULd7lkKxZKvvemLdXuerFQwp05UFhxFdh8DUhXY/01r7UFciS12Z8Z+i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626419; c=relaxed/simple;
	bh=9747lo1ACtZ69uqd/Du/K2ueykmtwq0G3JAvq6Ljn74=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=onsDwQYj9p/yv7xQVPH+/kpb62UmxV086amhDRwWBK4MZhO0/ByerxcjdRcrTIJ/wUxGogAR/3hqJzw3jJDtIGkFF+nSAmiNbUU/N8HNtNfsvNpmnvHNfjkhBTa63ABWM3EvNrUHp0BIIBPVVNDdLPWYJbLO8OS/MGUyAJGZ4mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8ju5eRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7EAC433C7;
	Tue, 30 Jan 2024 14:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706626418;
	bh=9747lo1ACtZ69uqd/Du/K2ueykmtwq0G3JAvq6Ljn74=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=A8ju5eRWurZvU2Dc8lpdduA8a2oA/6N9GFuFVu4kbXUu8WaaP1kkTCk3X1diQ0aPH
	 rAhrECUO8+wS2JFptCTYzpP6zQ9yjpifvCqfngdbXrX9rAtzOE/v1PD9ZrgxQGArMb
	 3TxfMzgK5SXWrZENSbcr6oaPEJ/rQaU/mCAl7rUFgjwPr3upDLD4zhlPFTU7py6xNZ
	 vUAnN6ms2Qn6wo/W5yH8UrV8DF/XeHSLR6hjEiaP0Iqu6TIy+oIB5bH3ZR4NQTbCQB
	 RDiss8vNX55DQczZ2oGO1m5B8Qc3Ox+HMmHCuhSExkxw7yUsEjmWGWboUGTrEC6Agq
	 QrK3sUj0ufwXg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 794B0CE0975; Tue, 30 Jan 2024 06:53:38 -0800 (PST)
Date: Tue, 30 Jan 2024 06:53:38 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org,
	"E."@paulmck-thinkpad-p17-gen-1.smtp.subspace.kernel.org,
	McKenney <paulmck@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Paul@paulmck-thinkpad-p17-gen-1.smtp.subspace.kernel.org,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH doc] Emphasize that failed atomic operations give no ordering
Message-ID: <63d9d6f6-05e8-473d-9d09-ce8d3a33ca39@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The ORDERING section of Documentation/atomic_t.txt can easily be read as
saying that conditional atomic RMW operations that fail are ordered when
those operations have the _acquire() or _release() prefixes.  This is
not the case, therefore update this section to make it clear that failed
conditional atomic RMW operations provide no ordering.

Reported-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: <linux-arch@vger.kernel.org>
Cc: <linux-doc@vger.kernel.org>

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index d7adc6d543db4..bee3b1bca9a7b 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -171,14 +171,14 @@ The rule of thumb:
  - RMW operations that are conditional are unordered on FAILURE,
    otherwise the above rules apply.
 
-Except of course when an operation has an explicit ordering like:
+Except of course when a successful operation has an explicit ordering like:
 
  {}_relaxed: unordered
  {}_acquire: the R of the RMW (or atomic_read) is an ACQUIRE
  {}_release: the W of the RMW (or atomic_set)  is a  RELEASE
 
 Where 'unordered' is against other memory locations. Address dependencies are
-not defeated.
+not defeated.  Conditional operations are still unordered on FAILURE.
 
 Fully ordered primitives are ordered against everything prior and everything
 subsequent. Therefore a fully ordered primitive is like having an smp_mb()

