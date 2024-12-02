Return-Path: <linux-arch+bounces-9212-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6F09DF827
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 02:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7176E28125B
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 01:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C367A1B21A4;
	Mon,  2 Dec 2024 01:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKU68uRv"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9EC10A3E;
	Mon,  2 Dec 2024 01:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733101777; cv=none; b=daqUT0oyfQLAGQvPPJRpQqjd+TGJ6JJs7DcVra858Nm+GouYf37N9cTnNEowRiPkWP1e821qtLvxKAL8/UWaH60yHWX75kRXqWRAp/uXHv9TptPkJ9evFi+/TsRu111SUtE46Jl9Ik52/8miIG4DpmwGqhgDp244g60aPjFYtlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733101777; c=relaxed/simple;
	bh=sAzD90I338AaM/8blk/uCSyjht7bgmdBUwOqBKuzNIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pB1I3PQKJufKYOgib8xwMxyrwE7PRi6RId0Sz2rbgy2i1avCSnPp5jdSdAscmEUwb2NxH9qstVWsYbqaTMWA+ZKyA2g70nHLkKsIV5UznkECz38Z+bfH1IEh19oGp0JWYdyA42a/opHFdutcEB9claP66XLpJBdz9LJHUXPToNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKU68uRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA70C4CEDB;
	Mon,  2 Dec 2024 01:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733101777;
	bh=sAzD90I338AaM/8blk/uCSyjht7bgmdBUwOqBKuzNIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VKU68uRvYLBaRovzroTHtIutPCgKC6QkWzoPlcXn8VLM2AALjN1tsYCrjDYauffPh
	 vV6r/DOWuGw63oGNuEpGfQeGp7R9lS7LFFszoCHGml3UntRKROIAqiRLuW7StNARAh
	 0Ci9DWmxpBAX6yOIkEhsEz/hYmPWznYUul/CrbWG5pymjMcUeQP7p/YkmMyjb5GzJK
	 39oZsqc7xqfpiGZ3M6uxZoPUSFSrArat5L/oUnvlg0O/o//5/6kQMa9L/3ikiS0It+
	 vQmd5gbRiBDmGq+W6WGs4X/oXNr4Sn9tEdFlgPqNpLYdtbNGTsCzwXVjggoYAnUbKy
	 F6ON4jIkYHO3Q==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v4 14/19] bcachefs: Explicitly select CRYPTO from BCACHEFS_FS
Date: Sun,  1 Dec 2024 17:08:39 -0800
Message-ID: <20241202010844.144356-15-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241202010844.144356-1-ebiggers@kernel.org>
References: <20241202010844.144356-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Explicitly select CRYPTO from BCACHEFS_FS, so that this dependency of
CRYPTO_SHA256, CRYPTO_CHACHA20, and CRYPTO_POLY1305 (which are also
selected) is satisfied.  Currently this dependency is satisfied
indirectly via LIBCRC32C, but this is fragile and is planned to change
(https://lore.kernel.org/r/20241021002935.325878-13-ebiggers@kernel.org).

Acked-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/bcachefs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/bcachefs/Kconfig b/fs/bcachefs/Kconfig
index ab6c95b895b3..971ea505e7b0 100644
--- a/fs/bcachefs/Kconfig
+++ b/fs/bcachefs/Kconfig
@@ -13,10 +13,11 @@ config BCACHEFS_FS
 	select LZ4HC_DECOMPRESS
 	select ZLIB_DEFLATE
 	select ZLIB_INFLATE
 	select ZSTD_COMPRESS
 	select ZSTD_DECOMPRESS
+	select CRYPTO
 	select CRYPTO_SHA256
 	select CRYPTO_CHACHA20
 	select CRYPTO_POLY1305
 	select KEYS
 	select RAID6_PQ
-- 
2.47.1


