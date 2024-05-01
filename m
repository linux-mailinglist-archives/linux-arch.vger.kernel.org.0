Return-Path: <linux-arch+bounces-4127-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B308B923B
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 01:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478F31F2225A
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 23:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5504A168B01;
	Wed,  1 May 2024 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AS96LH93"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2420E168AEC;
	Wed,  1 May 2024 23:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605695; cv=none; b=aOEp/5GZ9VZMzAluGnLbh4w6yKo3ji+ktEf/qK7vN5/GPYru6ZEFB/f1YEH8xHjGRJqGBVxYVUhTS96R1CuaoIYfXWFDjIw4c52QFsM7yVeY01BgUg+EmfvakGXl+MKIIgO0Ti/Orj6gj1caN5S8y0+3AzUctNytFkKxFWD2qT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605695; c=relaxed/simple;
	bh=tN99QeAtJ9rSCHUuXKIZr5kPNcQaT1UKModjibckfc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HDyBrj9pKijnCeS6FPM1hXl565JnqZtoKQL2R2lK+opNc10yF2oSSUKDwebPNIVFNoiKSC/4TKK00quOzLq5dyx8lnZOpuC94gjV8DZ7RWvi5z6BxwYuJYWf8yGOM57lVVAswzdj3fAtsCgB/Zgs0S0YV3N1Ne8jP/RjM4insc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AS96LH93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B9EC4AF1A;
	Wed,  1 May 2024 23:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714605694;
	bh=tN99QeAtJ9rSCHUuXKIZr5kPNcQaT1UKModjibckfc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AS96LH93+Xv7uqyFVwP7Ifz/QqcBdBaP5BGxQ4L0EAKdW6laZio2vPkeRSX6XRuKE
	 xZJvNqkbdAOtJLv6R/FSAflXrHWOP5kQS4UFIE6lCBffZuLWzagw0pvF3rHTIysJ62
	 hBcLQcvkVn8NWM+SoK5K0vkJATmyO7aVfGwvAKRJrBSxWANKtyE2slV8h30k98amrx
	 +rCjY+9VY+m9Vlc7LOAmKOZqhCK3H5xnkh5SzAE3LRfmaN+xlVItrgESbIVnMLO41l
	 ATk9IXV/NjDDBos5BU++QwnyulVUIwu9SOHINzQBhyP65F6c+UdwggBy02KOwdq3iM
	 G3bcO0UI+DoXg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6A93DCE1415; Wed,  1 May 2024 16:21:34 -0700 (PDT)
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
	"Paul E. McKenney" <paulmck@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH memory-model 3/4] Documentation/atomic_t: Emphasize that failed atomic operations give no ordering
Date: Wed,  1 May 2024 16:21:31 -0700
Message-Id: <20240501232132.1785861-3-paulmck@kernel.org>
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

The ORDERING section of Documentation/atomic_t.txt can easily be read as
saying that conditional atomic RMW operations that fail are ordered when
those operations have the _acquire() or _release() suffixes.  This is
not the case, therefore update this section to make it clear that failed
conditional atomic RMW operations provide no ordering.

Reported-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
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
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/atomic_t.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.40.1


