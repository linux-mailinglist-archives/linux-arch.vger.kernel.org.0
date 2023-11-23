Return-Path: <linux-arch+bounces-431-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2147F66E4
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 20:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5D61C21069
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 19:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75E84B5DA;
	Thu, 23 Nov 2023 19:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEbQgGVx"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6DF4B5A9;
	Thu, 23 Nov 2023 19:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E835BC433CA;
	Thu, 23 Nov 2023 19:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700766283;
	bh=xUztf5c6+cDrQVGWca5DAIqwQ3w/w7JoXRRhID515MY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iEbQgGVxuo5B+LkFE9lNJQsMr3+HPoAKvZldiQRRSTjhFRsd6PUuS8DZjFh/1U7fg
	 BraPFqCBY6Kutl8+97B/ZKk/rZP89+vzbsMufoKDQgWyqVoVhLQTyp7BM0fmRpCB9W
	 hwdVPYiHevRo6ysqAED9NuVMaxd5e6dPy6nGCNp3phvKuX0lJ7RIkN59ULD+Fz7hHb
	 lAwLRhrKM4v5C8lZJdZmKtNoRn2j29FwQDY8iQTqqfOTjWC3v/ZqP9si/HUV/g0c5d
	 Pfg9ff29ZANEch0NMG6DabapUS49GnGHEj9UYYhDCety0Qp7LVXfxMK0mjcCc8EOYB
	 xmU8SMS9YQYKQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org,
	llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH rdma-next 2/2] IB/mlx5: Use memcpy_toio_64() for write combining stores
Date: Thu, 23 Nov 2023 21:04:32 +0200
Message-ID: <744fdfcd61fa8efa6da8ed432883b5f016c3a86f.1700766072.git.leon@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1700766072.git.leon@kernel.org>
References: <cover.1700766072.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

mlx5 has a built in self-test at driver startup to evaluate if the
platform supports write combining to generate a 64 byte PCIe TLP or
not. This has proven necessary because a lot of common scenarios end up
with broken write combining (especially inside virtual machines) and there
is other way to learn this information.

This self test has been consistently failing on new ARM64 CPU
designs (specifically with NVIDIA Grace's implementation of Neoverse
V2). The C loop around writel() generates some pretty terrible ARM64
assembly, but historically this has worked on a lot of existing ARM64 CPUs
till now.

We see it succeed about 1 time in 10,000 on the worst effected
systems. The CPU architects speculate that the load instructions
interspersed with the stores make it very unreliable.

Change this to use memcpy_toio_64() which provides a block of 4 STP
instructions on ARM64, and the same writel loop on everything else.

Fixes: 11f552e21755 ("IB/mlx5: Test write combining support")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mem.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index 96ffbbaf0a73..26b5590d2164 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -108,7 +108,6 @@ static int post_send_nop(struct mlx5_ib_dev *dev, struct ib_qp *ibqp, u64 wr_id,
 	__be32 mmio_wqe[16] = {};
 	unsigned long flags;
 	unsigned int idx;
-	int i;
 
 	if (unlikely(dev->mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR))
 		return -EIO;
@@ -148,9 +147,7 @@ static int post_send_nop(struct mlx5_ib_dev *dev, struct ib_qp *ibqp, u64 wr_id,
 	 * we hit doorbell
 	 */
 	wmb();
-	for (i = 0; i < 8; i++)
-		mlx5_write64(&mmio_wqe[i * 2],
-			     bf->bfreg->map + bf->offset + i * 8);
+	memcpy_toio_64(bf->bfreg->map + bf->offset, mmio_wqe);
 	io_stop_wc();
 
 	bf->offset ^= bf->buf_size;
-- 
2.42.0


