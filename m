Return-Path: <linux-arch+bounces-3447-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF78898EF4
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 21:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87A81F21B8A
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 19:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6641E134438;
	Thu,  4 Apr 2024 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ubo7Ap3m"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D7134434;
	Thu,  4 Apr 2024 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258801; cv=none; b=D4hCaClkkqW8e7THKmOKKtGmAcURNjU7ypd+ZLtzK8fwxd/65JfYDxwm9UHd9S5L/R4iq6pcJmeI+QHt31Ky61ftCW4/ncUlffS0dzh9KATmv2ht4cXpsxuUDdUY5gjDj3WgI6hGADo1Bp3D1gEd0L+n7tfcpA/epr239FTZCE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258801; c=relaxed/simple;
	bh=ssP3YZU5waXQiH22YNGD9yi3Jxi9Fignl3F7DVlkXhE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OcvZxndPgUoLm5lVGDfr7fmVG1J2n2is/lLsUkR1/aa/1EqlXAeD4AoMuwmnut0l+lkyLW6eNdyO2u5SQ/N5ISy9269uWahsQOLkshFo9T/qdpMmclxw/ypWF6HFCWvVq8Pkdl+KMq5biMM5AZ4kJSgv35khYiG8eoV6LDhJl7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ubo7Ap3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4B3C433A6;
	Thu,  4 Apr 2024 19:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712258800;
	bh=ssP3YZU5waXQiH22YNGD9yi3Jxi9Fignl3F7DVlkXhE=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=Ubo7Ap3msJY2jhF+Fdpiy/tPVJqdY2ghywksCUmuOxIcWarKKCFIGLCSLmCcFWQFy
	 z7+EaZXi/KipZzeLXfqmMNv8SdAckGxUiPyjPU6mz5Q+KPFzwWGQN+Qpq4dAClxKMa
	 asq1j+4scmaJMTATIrLpHkJMPK/Sinig8MhoBmwC6JeSb4XrRnipAaNsBGaTxnLVnV
	 mBZhpVj0J9CAP4qFrbyrqY/mGAOa27vkZ6NcjF9uv0vPL4BZpIiycl9tC4hFVRG7Om
	 pT9jMwnFF1saTqf6Q7vC2Awrar6ksf2d/RMAsen53kDcSesmkjmvkc3Q8W6+RGJUi9
	 Kul/ENOo9QqYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 46CE1CE0D0C; Thu,  4 Apr 2024 12:26:40 -0700 (PDT)
Date: Thu, 4 Apr 2024 12:26:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com
Subject: [PATCH memory-model 0/3] LKMM updates for v6.10
Message-ID: <8550daf1-4bfd-4607-8325-bfb7c1e2d8c7@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series contains LKMM documentation updates:

1.	Documentation/litmus-tests: Add locking tests to README.

2.	Documentation/litmus-tests: Demonstrate unordered failing cmpxchg.

3.	Documentation/atomic_t: Emphasize that failed atomic operations
	give no ordering.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/litmus-tests/README                                   |   48 ++++++----
 b/Documentation/atomic_t.txt                                        |    4 
 b/Documentation/litmus-tests/README                                 |   29 ++++++
 b/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-1.litmus   |   34 +++++++
 b/Documentation/litmus-tests/atomic/cmpxchg-fail-ordered-2.litmus   |   30 ++++++
 b/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-1.litmus |   33 ++++++
 b/Documentation/litmus-tests/atomic/cmpxchg-fail-unordered-2.litmus |   30 ++++++
 7 files changed, 190 insertions(+), 18 deletions(-)

