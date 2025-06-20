Return-Path: <linux-arch+bounces-12413-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C8DAE19BE
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jun 2025 13:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88BE3A46D4
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jun 2025 11:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385C3289E1C;
	Fri, 20 Jun 2025 11:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FFHfJz+Q"
X-Original-To: linux-arch@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D188229B27;
	Fri, 20 Jun 2025 11:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417993; cv=none; b=gHgnj6/M9Ugx28/HV4yrPCmhmzJIfiaE9u8o9cFNVVCq8M2aIagETUjQ3b7k5U+AbYdCJtFD1Mrt7mUwWWYB37C8ycaRXQHiyq2ilHhipB9iyIAKIRRlmcArPLHUPU1UJmEiboQJh2I0l16hZ1PAPKxYT33yZN3/5IJ7tOJV9k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417993; c=relaxed/simple;
	bh=7FV8atmM6ULayl5/hDZbPvE1HWgIwwZOidLt2BkSKbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QmvZLtLmSrcZwgCD3K64qwG6ycc/110nsKR2+/DTd+CSxfxaeXymEfoi6J+0Lvto+LoKA+vQzQ91lKirj+RNkeKiCGQF3UQ3xum9sdNbTQQsjueY+A0CIMCptCTodlQwwoiWfkvaETvvzXDDHPodArqgzxtoq/pzAPmDkbkVLK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FFHfJz+Q; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750417982; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7+9nhCOVGIzCFiDtp94CVoN8wnMB/5TEpBypcppi+RM=;
	b=FFHfJz+QMFZe7kabqRSWET0QBvOSh15RWObRGaz8SeqrAO3xeEEP18tSlKXu4/aDy2EJHr/XgIE2QWXPMdgQfSM4i7kR+go8ACbD8WmtY1PqwLQ79v6QX/llBlTvr5Zv3fscp8Yf0QRmT9SbRaT1O7VEl3Z4JbdV9TwkyfGwbsk=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0WeKdP2w_1750417960 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Jun 2025 19:13:01 +0800
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
Date: Fri, 20 Jun 2025 19:12:17 +0800
Message-ID: <20250620111219.52182-1-cp0613@linux.alibaba.com>
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


