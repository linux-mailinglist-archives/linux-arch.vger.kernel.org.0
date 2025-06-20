Return-Path: <linux-arch+bounces-12414-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3554DAE19D1
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jun 2025 13:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68CFE7AB72D
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jun 2025 11:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDF4257AF2;
	Fri, 20 Jun 2025 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i5qQt3Oa"
X-Original-To: linux-arch@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC7A221260;
	Fri, 20 Jun 2025 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750418213; cv=none; b=pVqbrdCEVCortInJrz4j1mE+WaMB2j/9HwXgMfnXB2w3kwek1JOMEs+O/8kCQsMKB9fcNtUpmWnOdwYPyBP6SaEvmBEfZ8uHTpvGLq9mrL1u8tOHc3YbTVT5UE17gYLpmGTpG8wh5G1DEUqn7wSQj1x7JASHO+cbXct7je3Hbho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750418213; c=relaxed/simple;
	bh=7FV8atmM6ULayl5/hDZbPvE1HWgIwwZOidLt2BkSKbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cbMnB/HgClhsIAjgVYQd2ATyn+kzaTBSXe1WyugJ2Tb3VS47lFXtgJ8Oaw5Bravk9LDIXek85zaV/3weMWRhhEgpbpbTidgsCAx4Ml7K/QPIhIEo9ksdBXBZ4LBC+dUl3T8hRvWxXzkCDyQH8cVtSQnsDvGNwQWM60NFqPY02wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i5qQt3Oa; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750418202; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7+9nhCOVGIzCFiDtp94CVoN8wnMB/5TEpBypcppi+RM=;
	b=i5qQt3OaXCB51bhe5MQbHz4GRPt2XmguQVrF2eG0mPYlI6arc/2rA+PaBLy8MC3rWgilSwP3g63QpgtajERmKnQcnyEj9WZ7kltXZ+vl1R/xKufZO7V8SIHHZ9vrp2zLm+ED4Mbwmm3m4NyIce17kkTTylZ9jpxQSG/sbOa2aBg=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0WeKdQHt_1750418195 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Jun 2025 19:16:41 +0800
From: cp0613@linux.alibaba.com
To: yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	arnd@arndb.de,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [PATCH 0/2] Implementing bitops rotate using riscv Zbb extension
Date: Fri, 20 Jun 2025 19:16:08 +0800
Message-ID: <20250620111610.52750-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Pei <cp0613@linux.alibaba.com>

This patch series moves the ror*/rol* functions from include/linux/bitops.h
to include/asm-generic/bitops/rotate.h as a generic implementation.

At the same time, an optimized implementation is made based on the bitwise
rotation instructions provided by the RISC-V Zbb extension[1].

Based on the RISC-V processor XUANTIE C908, I tested the performance of
sha3_generic. Compared with the generic implementation, the RISC-V Zbb
instruction implementation performance increased by an average of 6.87%.

Test method:
1. CONFIG_CRYPTO_TEST=m
2. modprobe tcrypt mode=322 sec=3
Different parameters will be selected to test the performance of sha3-224.

[1] https://github.com/riscv/riscv-bitmanip/

Chen Pei (2):
  bitops: generic rotate
  bitops: rotate: Add riscv implementation using Zbb extension

 arch/riscv/include/asm/bitops.h     | 127 ++++++++++++++++++++++++++++
 include/asm-generic/bitops.h        |   2 +-
 include/asm-generic/bitops/rotate.h |  97 +++++++++++++++++++++
 include/linux/bitops.h              |  80 ------------------
 tools/include/asm-generic/bitops.h  |   2 +-
 5 files changed, 226 insertions(+), 82 deletions(-)
 create mode 100644 include/asm-generic/bitops/rotate.h

-- 
2.49.0


