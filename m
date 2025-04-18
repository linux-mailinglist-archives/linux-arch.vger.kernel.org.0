Return-Path: <linux-arch+bounces-11456-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB0AA93BF3
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 19:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42D617B008D
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 17:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908D421B9E9;
	Fri, 18 Apr 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8YqGgud"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC9821B183;
	Fri, 18 Apr 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744997403; cv=none; b=b0CqTd521fpcapcKvyUe0ntgepdb4t0Sps/8Nc8Rn02BmvJlVUyBYqyVVV4VnO10aYPsWe1DoNVUDnqUYE9J29SS+9oz/Q24+NGXOCm7Irt/1zbGvXTgkc/chPSKFq4tnVsQm2Ba025il7dkw41gmZ31MV+6E7P1dS1W8H/E5nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744997403; c=relaxed/simple;
	bh=7Zm1ra4Kkx6UNSYjT29unnZNFRlLSicJjp5B6B/BV+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YHLQazxJ4s6reFBkH8/yMM6TASxWBoSEl+ZcTv3Ho5KADLuWiY8LU8HeKAiIprjwli67/Byrr5DbiapMUKMJt8Fra0aQhWgyxnkDZISpqTvtethyydzONMJtSGkX652K1TZxcoZ+xPBB2564k3Mt1JmUQPAGpVK4lfz350uO57s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8YqGgud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85F5C4CEED;
	Fri, 18 Apr 2025 17:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744997403;
	bh=7Zm1ra4Kkx6UNSYjT29unnZNFRlLSicJjp5B6B/BV+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j8YqGgud6bXMOt9tmL0kDrUaneJ8QaMHsZTX9zjJjwPuuHm5pePhhmSigkrhG88c/
	 F3GTMHYkkUl13oBlIQUmzivaihkiGa3NgH2smndPQ3a3r1RDIZE+aN/8hN5vhVOtPI
	 YNfe1+5oB7VNFzMU9EqWFBTPeAKPYgJcz0tJLqBLPnSCR80o1cUKNdqXK4uvO/b+QE
	 wDao5+krXX01UI5+6JxNFePw1OYo6/9V3vxcd3strcN8gf02g1c2s1rwoVozepwjns
	 /im55CP522eBu75TN77r8v5279yuXrZQP/tJW0wxojopxpNj8Zeow29BnIByfNJiZY
	 B/nkS1TH+ruaw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 82830CE0F4D; Fri, 18 Apr 2025 10:30:02 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
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
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 4/4] tools/memory-model: docs/references: Remove broken link to imgtec.com
Date: Fri, 18 Apr 2025 10:30:00 -0700
Message-Id: <20250418173000.1188561-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cd7fb2c4-1895-455c-84f8-8ed7252b93ff@paulmck-laptop>
References: <cd7fb2c4-1895-455c-84f8-8ed7252b93ff@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Akira Yokosawa <akiyks@gmail.com>

MIPS documents are not provided at imgtec.com any more.
Get rid of useless link.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/references.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/memory-model/Documentation/references.txt b/tools/memory-model/Documentation/references.txt
index c5fdfd19df240..d691390620b3b 100644
--- a/tools/memory-model/Documentation/references.txt
+++ b/tools/memory-model/Documentation/references.txt
@@ -46,8 +46,7 @@ o	ARM Ltd. (Ed.). 2014. "ARM Architecture Reference Manual (ARMv8,
 
 o	Imagination Technologies, LTD. 2015. "MIPS(R) Architecture
 	For Programmers, Volume II-A: The MIPS64(R) Instruction,
-	Set Reference Manual". Imagination Technologies,
-	LTD. https://imgtec.com/?do-download=4302.
+	Set Reference Manual". Imagination Technologies, LTD.
 
 o	Shaked Flur, Kathryn E. Gray, Christopher Pulte, Susmit
 	Sarkar, Ali Sezgin, Luc Maranget, Will Deacon, and Peter
-- 
2.40.1


