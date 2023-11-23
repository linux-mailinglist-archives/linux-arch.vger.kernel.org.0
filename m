Return-Path: <linux-arch+bounces-430-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA477F66E2
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 20:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E293E281DF0
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 19:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54A84B5DF;
	Thu, 23 Nov 2023 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqNiMT7r"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC884B5DA;
	Thu, 23 Nov 2023 19:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A76DC433CB;
	Thu, 23 Nov 2023 19:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700766279;
	bh=9vQGT/qLYbQVJ6jyB7uTbXrGWb2NZ5AwZAZqn9UW3bc=;
	h=From:To:Cc:Subject:Date:From;
	b=nqNiMT7rxoJOGnXcFeFm2ZrNwK4PR5dxH6p5Wml1P94yifzNfv1Yz8OkfJtlJow8l
	 g9F29qkuH+gMH7cguIGbaMm1Qp/MlUaFpqEPc/PVZjOF5By4ve/6D58RaaDQ9rnvU8
	 EGrq7cV4mHUhJYJ62vtMDUAj+l5jmkiaavISWE5kEGPNb+lc9Yv5hLvS7BP7B2GWjZ
	 vJTnow89BCIkB+Kdx7EdLnPpdK6kMimXHikKiEB01ac1q0E0EA8QzOqG6OGSLaN7o6
	 UZYsyQCkn+koMo4vdoviYWdbMy9Ysrblb7U5p3gzjeGS8G5ILZ+z1YkWPLsBjAcFSw
	 7MQvBTy9uUv+g==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH rdma-next 0/2] Add and use memcpy_toio_64()
Date: Thu, 23 Nov 2023 21:04:30 +0200
Message-ID: <cover.1700766072.git.leon@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

This short series adds and utilizes memcpy_toio_64().

Jason Gunthorpe (2):
  arm64/io: add memcpy_toio_64
  IB/mlx5: Use memcpy_toio_64() for write combining stores

 arch/arm64/include/asm/io.h      | 20 ++++++++++++++++++++
 drivers/infiniband/hw/mlx5/mem.c |  5 +----
 include/asm-generic/io.h         | 30 ++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 4 deletions(-)

-- 
2.42.0


