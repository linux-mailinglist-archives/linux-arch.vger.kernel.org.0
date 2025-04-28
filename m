Return-Path: <linux-arch+bounces-11655-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2ABA9F67B
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 19:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE33517F835
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 17:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B95828D85A;
	Mon, 28 Apr 2025 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4lo9OBt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F0F28CF71;
	Mon, 28 Apr 2025 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745859721; cv=none; b=Cx3NqZ6y6dlnyR6MsL1nLxRbdIVj5HnMZLu/nNi5GrQE1BM/i324ruI46knF/xn0tyNEAKf0QgL2WNDh/tdpPMARHGpiddUm8OajAbcE0YQJYtC94KcqyhEUF2Cyh1A3UiOsE7m7iG8sPGoKWZ86gGGq/WP99HyfFACEhmw92n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745859721; c=relaxed/simple;
	bh=WGUG3mTzhoDhli2YpBvT7Wh87yi92KthyKex4Ih+eYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCGIhIJhngocIufTqzv/60eheAordjeVXtNpMjeTnGZIYNriGrZLJjQZfyx8DwpUip8nMA2U4tus1W5R8imwyHXSTXUsAC14zudczXCMs5xFOU7uWHaxaAFlZU9Mt6FLGM8xvUre8nSIPqe5ADL+pTZ52iWSOSiuB/EdTb39L38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4lo9OBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737D5C4CEF2;
	Mon, 28 Apr 2025 17:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745859720;
	bh=WGUG3mTzhoDhli2YpBvT7Wh87yi92KthyKex4Ih+eYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R4lo9OBtV1cajdxreoVKsMWdUvS6ZbyO08N/F8VPM7gCjd4vR29sCJ6hr+gsAz5sV
	 /PsXwkP+M3rZJ1TDwQNaE0aEMelACb4s9S+KbbNmpiYX8UiyOjoozEWfhD09JDOZu+
	 x/SJkloWktFlYpZjkRJX9AIJbC1zJzJj+z2oCK+M9nZLvkVSf48G9lnXlrGrV0uQug
	 1k03Xh4jH0fkYF41PZm+nkzeR8JhPi/OIZVa5O0ePLaxiWaCo8FJrhxJm5FvTZ2LBl
	 rhTM8PIU0kCLWQEmTvEPDD6lPp5XrwrJn6ldRIfBEJVhhwso8J2oM3uHywynAvoKeb
	 QkQs8cjXuMjsw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	sparclinux@vger.kernel.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v4 03/13] crypto: arm64/sha256 - remove obsolete chunking logic
Date: Mon, 28 Apr 2025 10:00:28 -0700
Message-ID: <20250428170040.423825-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428170040.423825-1-ebiggers@kernel.org>
References: <20250428170040.423825-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Since kernel-mode NEON sections are now preemptible on arm64, there is
no longer any need to limit the length of them.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm64/crypto/sha256-glue.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/crypto/sha256-glue.c b/arch/arm64/crypto/sha256-glue.c
index 26f9fdfae87bf..d63ea82e1374e 100644
--- a/arch/arm64/crypto/sha256-glue.c
+++ b/arch/arm64/crypto/sha256-glue.c
@@ -84,27 +84,12 @@ static struct shash_alg algs[] = { {
 } };
 
 static int sha256_update_neon(struct shash_desc *desc, const u8 *data,
 			      unsigned int len)
 {
-	do {
-		unsigned int chunk = len;
-
-		/*
-		 * Don't hog the CPU for the entire time it takes to process all
-		 * input when running on a preemptible kernel, but process the
-		 * data block by block instead.
-		 */
-		if (IS_ENABLED(CONFIG_PREEMPTION))
-			chunk = SHA256_BLOCK_SIZE;
-
-		chunk -= sha256_base_do_update_blocks(desc, data, chunk,
-						      sha256_neon_transform);
-		data += chunk;
-		len -= chunk;
-	} while (len >= SHA256_BLOCK_SIZE);
-	return len;
+	return sha256_base_do_update_blocks(desc, data, len,
+					    sha256_neon_transform);
 }
 
 static int sha256_finup_neon(struct shash_desc *desc, const u8 *data,
 			     unsigned int len, u8 *out)
 {
-- 
2.49.0


