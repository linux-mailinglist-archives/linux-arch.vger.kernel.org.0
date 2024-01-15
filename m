Return-Path: <linux-arch+bounces-1376-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1910882E366
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jan 2024 00:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B69283C9B
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jan 2024 23:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271011B7EB;
	Mon, 15 Jan 2024 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUVKrpAh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F831B7E8;
	Mon, 15 Jan 2024 23:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022DCC433C7;
	Mon, 15 Jan 2024 23:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361103;
	bh=EYKfpeOjQcNy5olvIYknZHSp3uT9jDCqmH7907PblMA=;
	h=From:To:Cc:Subject:Date:From;
	b=IUVKrpAh/NAHsR0ez4LZmLPxHINjwgwtamCx9OgGSxF4HGRNlXWIJJkxx6+8+NDQJ
	 VxyY+i9Pgp4q299kmSVyCvR6ARnSSxRzx4cY5oA6rtKtl6umAii1S37URpCr+7kotN
	 mgp/+tJYQZh2AKSTvLxV0c0fRFr/2O9EyRjfBfzZPi+LesV5Q7hj/2Q9SsHvnF40Qo
	 uOz9Yq4hOzbyj0SB6BI/ZEWnvn3xwURxLkWnzYFAsQfsUi7Jzm67H0GoM1GoZp8TIT
	 OL4sPxRZRddXCca2lcaVlHo8ZMDmbBcjQ14CpP7dcxRZM+fQb4nHvXRH40qqwrA8mh
	 lWZ78C5j+r4jw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-arch@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/14] asm-generic: make sparse happy with odd-sized put_unaligned_*()
Date: Mon, 15 Jan 2024 18:24:24 -0500
Message-ID: <20240115232501.208889-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 1ab33c03145d0f6c345823fc2da935d9a1a9e9fc ]

__put_unaligned_be24() and friends use implicit casts to convert
larger-sized data to bytes, which trips sparse truncation warnings when
the argument is a constant:

    CC [M]  drivers/input/touchscreen/hynitron_cstxxx.o
    CHECK   drivers/input/touchscreen/hynitron_cstxxx.c
  drivers/input/touchscreen/hynitron_cstxxx.c: note: in included file (through arch/x86/include/generated/asm/unaligned.h):
  include/asm-generic/unaligned.h:119:16: warning: cast truncates bits from constant value (aa01a0 becomes a0)
  include/asm-generic/unaligned.h:120:20: warning: cast truncates bits from constant value (aa01 becomes 1)
  include/asm-generic/unaligned.h:119:16: warning: cast truncates bits from constant value (ab00d0 becomes d0)
  include/asm-generic/unaligned.h:120:20: warning: cast truncates bits from constant value (ab00 becomes 0)

To avoid this let's mask off upper bits explicitly, the resulting code
should be exactly the same, but it will keep sparse happy.

Reported-by: kernel test robot <lkp@intel.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/oe-kbuild-all/202401070147.gqwVulOn-lkp@intel.com/
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/asm-generic/unaligned.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 699650f81970..a84c64e5f11e 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -104,9 +104,9 @@ static inline u32 get_unaligned_le24(const void *p)
 
 static inline void __put_unaligned_be24(const u32 val, u8 *p)
 {
-	*p++ = val >> 16;
-	*p++ = val >> 8;
-	*p++ = val;
+	*p++ = (val >> 16) & 0xff;
+	*p++ = (val >> 8) & 0xff;
+	*p++ = val & 0xff;
 }
 
 static inline void put_unaligned_be24(const u32 val, void *p)
@@ -116,9 +116,9 @@ static inline void put_unaligned_be24(const u32 val, void *p)
 
 static inline void __put_unaligned_le24(const u32 val, u8 *p)
 {
-	*p++ = val;
-	*p++ = val >> 8;
-	*p++ = val >> 16;
+	*p++ = val & 0xff;
+	*p++ = (val >> 8) & 0xff;
+	*p++ = (val >> 16) & 0xff;
 }
 
 static inline void put_unaligned_le24(const u32 val, void *p)
@@ -128,12 +128,12 @@ static inline void put_unaligned_le24(const u32 val, void *p)
 
 static inline void __put_unaligned_be48(const u64 val, u8 *p)
 {
-	*p++ = val >> 40;
-	*p++ = val >> 32;
-	*p++ = val >> 24;
-	*p++ = val >> 16;
-	*p++ = val >> 8;
-	*p++ = val;
+	*p++ = (val >> 40) & 0xff;
+	*p++ = (val >> 32) & 0xff;
+	*p++ = (val >> 24) & 0xff;
+	*p++ = (val >> 16) & 0xff;
+	*p++ = (val >> 8) & 0xff;
+	*p++ = val & 0xff;
 }
 
 static inline void put_unaligned_be48(const u64 val, void *p)
-- 
2.43.0


