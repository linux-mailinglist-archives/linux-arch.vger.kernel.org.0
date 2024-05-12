Return-Path: <linux-arch+bounces-4347-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F308C37CD
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 19:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AAD21C20308
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 17:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BA42940F;
	Sun, 12 May 2024 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpJ/Yjye"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFF51E492;
	Sun, 12 May 2024 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715535705; cv=none; b=Nxz++L6KJX5lHF2nYo53h/OmUEqjYdoeXRr1e1g/bF5KQ6CimmiEJRFgIMRkPEIfd+gwOtGLKdWsGUMTOSmnF93wB+gjdD1N787fvsII1aYAsZQLjNgoi/9tRyvTa2NpLKXsc9Uv/6Zu7PLlQR5XzgXV6E7jG2DZ0DTHqUhIbJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715535705; c=relaxed/simple;
	bh=fuKPbrNnpH9TtVLRuzB0G82KzbZ36uIiDLDfs/B8R6c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IjXdKxyOYclFhKkmkDjNwz/oH8zqcVeK5oLi30tsDMNTeDOfY6fAD4kYEd3o0+xw78aFalxqbseCzP7KvuUevlZioftJfrda+cyv0Q8PfQOwYX20M8NcIND76QzFDNLkzmKt9tQF4KeW6y53ZR0nYaZS5CJb+PUIPK2JMcqRiNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpJ/Yjye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590C1C116B1;
	Sun, 12 May 2024 17:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715535705;
	bh=fuKPbrNnpH9TtVLRuzB0G82KzbZ36uIiDLDfs/B8R6c=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=TpJ/YjyemRoG0w6Id6VbCtSoE+HSpOthL9yjTeo7D1kYm4u+Iaub7sQv8NnQMJVkb
	 DxFEjGyZ+7jOdFACbiqH0B/3H4fqDbkxKkfo/1qpjksSo8rnFwyVusDjCUdtrjovKe
	 nWbHyRGJVwqL65e5Uu7kPnuuvdVhUv6FctGR8IpN2jKVfhi0DY7ddK8mxDWLOm562R
	 RUA9rcqQW2kSgm+7bkp0aZp9X5kMIv64ASFFZchVDJ+O1m4X7Tc77O+1YwARwX2ckF
	 dDTCSBfS582I3GDV0FXjqysjTOceww9V1x0xfdUmoHpEreTHsNaSbt8I7WkyH1y58B
	 w8Togiy2p6vgg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B30FFCE105C; Sun, 12 May 2024 10:41:44 -0700 (PDT)
Date: Sun, 12 May 2024 10:41:44 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
	mark.rutland@arm.com
Subject: [GIT PULL] LKMM changes for v6.10
Message-ID: <9a2178f8-a33a-4b0e-a867-30ea44761e8a@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Linux,

When the merge window opens, please pull this LKMM update from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2024.05.10a
  HEAD: 2ba5b4130e3d5d05c95981e1d2e660d57e613fda: Documentation/litmus-tests: Make cmpxchg() tests safe for klitmus (2024-05-06 14:29:21 -0700)

----------------------------------------------------------------
lkmm: Upgrade LKMM documentation

This commit upgrades LKMM documentation, perhaps most notably adding
a number of litmus tests illustrating cmpxchg() ordering properties.
TL;DR: Failing cmpxchg() operations provide no ordering.

----------------------------------------------------------------
Paul E. McKenney (4):
      Documentation/litmus-tests: Add locking tests to README
      Documentation/litmus-tests: Demonstrate unordered failing cmpxchg
      Documentation/atomic_t: Emphasize that failed atomic operations give no ordering
      Documentation/litmus-tests: Make cmpxchg() tests safe for klitmus

 Documentation/atomic_t.txt                         |  4 +-
 Documentation/litmus-tests/README                  | 45 ++++++++++++++++++++++
 .../atomic/cmpxchg-fail-ordered-1.litmus           | 35 +++++++++++++++++
 .../atomic/cmpxchg-fail-ordered-2.litmus           | 30 +++++++++++++++
 .../atomic/cmpxchg-fail-unordered-1.litmus         | 34 ++++++++++++++++
 .../atomic/cmpxchg-fail-unordered-2.litmus         | 30 +++++++++++++++
 6 files changed, 176 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-1.litmus
 create mode 100644 Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-2.litmus
 create mode 100644 Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-1.litmus
 create mode 100644 Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-2.litmus

