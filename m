Return-Path: <linux-arch+bounces-3450-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBCF898EFB
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 21:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26F4AB29C7B
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 19:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B52A135A7D;
	Thu,  4 Apr 2024 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qT22pEbP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56699135A5C;
	Thu,  4 Apr 2024 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258812; cv=none; b=QHesjsBH7tzMOcype03eMzq9vckLVJVim2+aEXftRwfTmZvCJv1TnCF7f5pMate4F7PsFH7qh6uTeoOJjwzmkgJQta2mMnYc1kg7zFneEmvYlvQVO2pwvi5INojTmrbabGQwQBDc4nXHbK4yU9Y4Q9l6+ZqWOMJsimQcfwK0H7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258812; c=relaxed/simple;
	bh=tN99QeAtJ9rSCHUuXKIZr5kPNcQaT1UKModjibckfc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qRhHp33iyenvwrF8/glXtCDxK4ZEONkblJEmUWCSJflDZFvEJpLJu/nLj0Vk7RSbUTJCSAOv9OFMYbf9tkttgItZHCmsoE0XloflssQdmy6f2/QHxv9ZM/HLxYIGMrMOruQyP8YjJt35e6+NonTPR8eeIj3qQ8wLKALLWdSmEAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qT22pEbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEC7C433A6;
	Thu,  4 Apr 2024 19:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712258812;
	bh=tN99QeAtJ9rSCHUuXKIZr5kPNcQaT1UKModjibckfc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qT22pEbP/E2OyGwVmTYn6ssiRlW0RAqkAHI9aW112G6dZKGZ9fd42U+fUw7SJrzsd
	 tHHUXWOy8nzUcvRDlHdyVUxxUn0T0cEE0QIaC3lNqQoowL0b7cv6glRyXNqNoId9+l
	 fwEUIGRluAnCAYwKPH9a5zln4a7yXL9tT0OzrL3ntFYUPNXv/AzhMQTsge16ohyyWH
	 r420UN+KjmJY+ICpoCD95byx65G1HNVlKGDeueiKpxkQavXt8iojAdjhsBtNL4Jq8Z
	 JBv5mFEaY14qc2B6OYijDeijlDeaQir9ID/mU8WoBJnDkiI0Q3OqEFwsPuSH2zoLka
	 gPALKQ6pNIUqw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 98770CE13D0; Thu,  4 Apr 2024 12:26:51 -0700 (PDT)
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
Subject: [PATCH memory-model 3/3] Documentation/atomic_t: Emphasize that failed atomic operations give no ordering
Date: Thu,  4 Apr 2024 12:26:49 -0700
Message-Id: <20240404192649.531112-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8550daf1-4bfd-4607-8325-bfb7c1e2d8c7@paulmck-laptop>
References: <8550daf1-4bfd-4607-8325-bfb7c1e2d8c7@paulmck-laptop>
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


