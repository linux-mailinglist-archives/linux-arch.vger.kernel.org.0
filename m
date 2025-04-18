Return-Path: <linux-arch+bounces-11452-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C2BA93BEE
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 19:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8772D1B675A2
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 17:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80C7215F4B;
	Fri, 18 Apr 2025 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoFCYTOr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7993C8F77;
	Fri, 18 Apr 2025 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744997394; cv=none; b=rTYlPw+Xx89rNJtE0bv3vt2sMJdqMpNC5hM+miPaRqHxWgCBbFB0lNHkb+/0anlS52RbZUhlTxHiNSSLrwc4D5UN/r6sQV7fCc9Gtu0kLoUNQ1dcXjXjPTk1SvERzNXYwGsCIOBe7WaKJa4VgGhbaiyb1Ydkz3TFVIOurIYS360=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744997394; c=relaxed/simple;
	bh=q/VMpMOrShaC4kIIzEW0+DiDJm2wb+w/RJEb0qX+gy0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d4xDlCA4A5wz6n/El9ESfgTbnLOkvkt1Mtw9mmGlHy75oMqkovB2kiH5q9OkMoi5Aky1qM2xJmw/lO4AUDsZ9ogV1cKPjylnqfPA+e30jDcTy4Ashnp8ClaZS/gOA22HpSq4KA7V/CbdCnC4F+1/LBFoWc0I7n4UgT5RrvsNXCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoFCYTOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D20C4CEF1;
	Fri, 18 Apr 2025 17:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744997394;
	bh=q/VMpMOrShaC4kIIzEW0+DiDJm2wb+w/RJEb0qX+gy0=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=UoFCYTOrLg5dTsIxXrid7NOVRKb823ARyacpt2ubITP194DEgTCBaYUJl58eksBIA
	 BXfb89ufdAwJgQ/S1tu9OosA4wBw+YGvB/hKoYG9cSArR6kFojSKU3fvZa7Iws+KVd
	 YmqvNE4RLY85de6PQX/HYQU47AaMDUb95f5CDT6+cR5n8fcaZogvzykrQBD9SQdOfj
	 jrmGV0tqL+Xut7fUsxWlYNNRwaz3nEcfyNfm8z3Sgr5ihMiHvh3/8A8PfBtrWFmkae
	 31Vaz8rD+nhrC6Sh4CN63SKvOaj0YxMl6c3jBZqxfYeMA8UHU64U+XDV1q8cNwqE9T
	 Cayx7d/wDQQEw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 83434CE077B; Fri, 18 Apr 2025 10:29:53 -0700 (PDT)
Date: Fri, 18 Apr 2025 10:29:53 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, kernel-team@meta.com, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com
Subject: [PATCH 0/4] LKMM documentation updates for v6.16
Message-ID: <cd7fb2c4-1895-455c-84f8-8ed7252b93ff@paulmck-laptop>
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

This series provides the following documentation updates, all courtesy
of Akira Yokosawa:

1.	docs/README: Update introduction of locking.txt.

2.	docs/simple.txt: Fix trivial typos.

3.	docs/ordering: Fix trivial typos.

4.	docs/references: Remove broken link to imgtec.com.

						Thanx, Paul

------------------------------------------------------------------------

 README         |    7 +++++--
 locking.txt    |    5 +++++
 ordering.txt   |   22 +++++++++++-----------
 recipes.txt    |    4 ++++
 references.txt |    3 +--
 simple.txt     |    4 ++--
 6 files changed, 28 insertions(+), 17 deletions(-)

