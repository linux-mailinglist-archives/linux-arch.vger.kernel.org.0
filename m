Return-Path: <linux-arch+bounces-5390-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E670930AC7
	for <lists+linux-arch@lfdr.de>; Sun, 14 Jul 2024 18:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1981F2145E
	for <lists+linux-arch@lfdr.de>; Sun, 14 Jul 2024 16:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49EA13B580;
	Sun, 14 Jul 2024 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLqGDGKJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EBA7346C;
	Sun, 14 Jul 2024 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720974524; cv=none; b=bOdhNWPduTeBToNgoVJk2BUSrlZuFlNHuPBGZzgvYfRDmxBaaWJufwzA4dS2s5LtBzDSLJ1A8Q6YLFKKt9fJ6TYzfADKsX9cmdWvNLX59eFuakzrFhaCaKDfnshWsMcTotLYCAmx30X0t9Fd7xQq2CV/VuZb+K+fW6+FgpFUhPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720974524; c=relaxed/simple;
	bh=YVh0TOFrc5B40PsDndvksJEx8IfAjErNBYJ/3kByK2M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WlfEgsK7Gub5S4VklviTrFwjHJARhdn9j0tOgnNGbyppklGjlDj4mWd5zxZ5ALCYxroqPJyt4Dr0PaA5gl72+PVr+6mshdjTqjCTApCaMndm9im+ftKRFinEJZ1A+XQmz+r+oZUldwGFC0CAl7Yro9ZuyokpmQrt9xbQWILQ5fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLqGDGKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221FDC116B1;
	Sun, 14 Jul 2024 16:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720974524;
	bh=YVh0TOFrc5B40PsDndvksJEx8IfAjErNBYJ/3kByK2M=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=kLqGDGKJ2KKxccVrx8HBp5UGlEVSv6V5UvacMXAmZVrTZsvPJ01Pvm83Inqy8cTg2
	 VEfCEcmssIy1gSJ8fQrNiomJgVesKbgXe+w37/5YdhzIsHOx/JWunZsXY2r0bLUmVa
	 OzFKiWkZBiY/oHtKHiOegd99GQYw6nQlP4LS8AcyTBBjlN76Hc+G6w/X65bjjH8ONC
	 CodpcwddxmMIdDwzyxTaBe1C9JNYPNyppoLMX7aQcbwt8M2HTlo4L5dnBtmUadEM4d
	 EPAWUg0WuwfPJj8ko5vny9/25nGSFo2UhKs1t78DNgHyyqN2hEVLvNDts5SkKKP/3y
	 FKglO/dwWPx1A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B27B1CE0B34; Sun, 14 Jul 2024 09:28:43 -0700 (PDT)
Date: Sun, 14 Jul 2024 09:28:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, stern@rowland.harvard.edu,
	parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
	boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
	dlustig@nvidia.com, joel@joelfernandes.org
Subject: [GIT PULL] LKMM changes for v6.11
Message-ID: <583d22d2-a123-4131-b4ac-20980357592b@paulmck-laptop>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2024.07.12a
  # HEAD: ea6ee1bac6034cb4e91bcc229ed1354ca1a024d5: tools/memory-model: Code reorganization in lock.cat (2024-06-06 11:24:58 -0700)

----------------------------------------------------------------
lkmm: Fix corner-case locking bug and improve documentation

A simple but odd single-process litmus test acquires and immediately
releases a lock, then calls spin_is_locked().  LKMM acts if it was
a deadlock due to an assumption that spin_is_locked() will follow a
spin_lock() or some other process's spin_unlock().  This litmus test
manages to violate this assumption because the spin_is_locked() follows
the same process's spin_unlock().

This series fixes this bug, reorganizes and optimizes the lock.cat model,
and updates documentation.

----------------------------------------------------------------
Alan Stern (2):
      tools/memory-model: Fix bug in lock.cat
      tools/memory-model: Code reorganization in lock.cat

Paul E. McKenney (2):
      tools/memory-model: Add KCSAN LF mentorship session citation
      tools/memory-model: Add access-marking.txt to README

 tools/memory-model/Documentation/README            |  4 ++
 .../memory-model/Documentation/access-marking.txt  | 10 ++--
 tools/memory-model/lock.cat                        | 62 +++++++++++++---------
 3 files changed, 49 insertions(+), 27 deletions(-)

