Return-Path: <linux-arch+bounces-11587-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E32DA9D896
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 08:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55689211EA
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 06:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98A11E834D;
	Sat, 26 Apr 2025 06:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lcsr7CT6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEED81E7640;
	Sat, 26 Apr 2025 06:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745650301; cv=none; b=Cdf89e8gFxXAt3NsuMqnyMhyUVNasVk1ipRGmMxPB5T8yfLpcAQTpUkUW+f6m5rpHsZGcTGEcUne1AEf0i9IgRRLQhTbxXJHNzTQaoiHhkf385LgMZuJljSnd8/KKAElN6A9HMYM28KqXafV+RoYQGbzc7E0/2l5ejyN1iTNNqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745650301; c=relaxed/simple;
	bh=tT7xHizMSeBb7KvPb+oh3/Ig96zej6yrrgzCapsgU4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYvZW1cIJ8DkXGw1Q7ywVb38mB2TR55K7KmxetIJ4nZhD8pcn9zEQf5puuc8x6mgaazmBH04mxZjQWK+dzr/ooxnhHzCxDG4GTfk+lfnQQmpq21beQ4sSc9LCHwqHk1ut30iT4ESZ6ITXDGIx/25qraLp2UPCjO1mlpVUXGvJuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lcsr7CT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB467C4CEEB;
	Sat, 26 Apr 2025 06:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745650301;
	bh=tT7xHizMSeBb7KvPb+oh3/Ig96zej6yrrgzCapsgU4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lcsr7CT6H9XpOvDDW/C83SMoazZN1PRVMrqjz50cIA8jvmCUTp4hbSP/O3xWDYddd
	 YZ0Ca/KBHzX6l/dLL8hxBuVetdDeZw6hpcDAZ35cOMN09OfSLYS0ycv+SBXsap2x9T
	 nYa388Rpg9JgkkRno5+iBFIWegN8KKu5pmrB5RAANFCP2wNWIJ8cg4uo4UGSC1YmXX
	 3PyA35KurVu6MUW3T2QiEAViSJb9VVp4oVLGMgGOqouczpABo7xEpnV5PbcofFOcyJ
	 SrKpi4wF6nF6wj1xAmeQyg10nxHDcqBjKLSEqqQyHj2PlfzO/+3AwSUvpeth2rtySI
	 75WbMMZSzlWhA==
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
	"Jason A . Donenfeld " <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 03/13] crypto: arm64/sha256 - remove obsolete chunking logic
Date: Fri, 25 Apr 2025 23:50:29 -0700
Message-ID: <20250426065041.1551914-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250426065041.1551914-1-ebiggers@kernel.org>
References: <20250426065041.1551914-1-ebiggers@kernel.org>
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


