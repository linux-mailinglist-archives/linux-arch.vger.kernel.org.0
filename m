Return-Path: <linux-arch+bounces-11602-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 894A6A9DB99
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 16:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D599A189EA45
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 14:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B06E25CC5A;
	Sat, 26 Apr 2025 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="V97VpETT"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C338D13E41A
	for <linux-arch@vger.kernel.org>; Sat, 26 Apr 2025 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745679402; cv=none; b=P6ceJBBBMhYd0GFI3zu4e9uUhZWj2GRE2GfPyvxlEQsyTXyjQzq/31GoiogjCyXzbr9RM8+LP5n/VphJG0yktoryX3ZEgYNsjYnzz1wYUZIQOtTSFxk1ZxIG4x/SgCbzXzLix8SY+5LjSMF++eTjurxKwVr4QmYPohOR++uaJrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745679402; c=relaxed/simple;
	bh=bHBQBm0qlrFLSPTQ5kZMOgmZuQIX6guRz1psjWrgWzQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PVRy3lP+/ScCXsGCC1T8fV9SU6Ydal/Fz9PluMkybjN4Siw88V24MqvHuSBWRCBHd0kL/TP3+IelUZjqxvirVXLTFtMKqtoJpZzqKDW4LXEZZScBNI88hsVHylPXzmJudOSxm6S3jFbHCeTPX3F3l7g3XoL/qSgSq8p5u2rBago=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=V97VpETT; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1745679397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GICB4BFYHCXkZcWANyav9UTGwPzsmDF0x+dfscxZ+3E=;
	b=V97VpETThcQMI2V6pF8NhEa6hJbzknZuXEklIlmiA3b0ryvgW4Ki8dI3NbrTDsRvdx+oJH
	SCOxyM6iqtdWcFQQ+wUd9mHMuIhgZxbJaBUsH9kieekgvikhAWiJGEKFXi9UD4d8pRduE4
	ZXq983R6AJ+HS2XHOUoPOF8jIkkcZKnnjfh8HmydHdhLeQoHra/VtZqX6NiPrlbcb08RC+
	8taQ3XUXyhgwNVsbmd3GiaHCdteW8BXeIB7pbU6rY9I1KQAEgBUZp5jXnrBD7AZOYQqFkQ
	N37TMYVibwe0Q/scWSR/urLfgOuB/Kdq0EORg9SPenxHXvjFtKdZjpJGbZYabA==
From: Ignacio Encinas <ignacio@iencinas.com>
Subject: [PATCH v4 0/2] Implement endianess swap macros for RISC-V
Date: Sat, 26 Apr 2025 16:56:17 +0200
Message-Id: <20250426-riscv-swab-v4-0-64201404a68c@iencinas.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABH0DGgC/23MQQ7CIBCF4as0rMUAU2px5T2MC6BTnYWtAYOap
 neXNia2xuV7yfcPLGIgjGxfDCxgokh9l0e5KZi/2O6MnJq8mRJKCxA7Hij6xOPDOu5q6UxpjfX
 SsQxuAVt6zrHjKe8LxXsfXnM7yen9ZKRYZpLkkkNZaYWtRDTVgbDz1Nm49f2VTaWkltqstOKCN
 xpc1VTWGan/aPjqUsBKQ9bg2p3QTS0Q4EeP4/gG6i983iMBAAA=
X-Change-ID: 20250307-riscv-swab-b81b94a9ac1b
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
 skhan@linuxfoundation.org, Zhihang Shao <zhihang.shao.iscas@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 linux-arch@vger.kernel.org, Ignacio Encinas <ignacio@iencinas.com>
X-Migadu-Flow: FLOW_OUT

Motivated by [1]. A couple of things to note:

RISC-V needs a default implementation to fall back on. There is one
available in include/uapi/linux/swab.h but that header can't be included
from arch/riscv/include/asm/swab.h. Therefore, the first patch in this
series moves the default implementation into asm-generic.

Tested with crc_kunit as pointed out here [2]. I can't provide
performance numbers as I don't have RISC-V hardware yet.

[1] https://lore.kernel.org/all/20250302220426.GC2079@quark.localdomain/
[2] https://lore.kernel.org/all/20250216225530.306980-1-ebiggers@kernel.org/

Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
---
Changes in v4:

- Add missing include in the 1st patch, reported by 
  https://lore.kernel.org/all/202504042300.it9RcOSt-lkp@intel.com/
- Rewrite the ARCH_SWAB macro as suggested by Arnd
- Define __arch_swab64 for CONFIG_32BIT (Ben)
- Link to v3: https://lore.kernel.org/r/20250403-riscv-swab-v3-0-3bf705d80e33@iencinas.com

Arnd, I know you don't like Patch 1 but I tried your suggestions and
couldn't make them work. Please let me know if I missed anything [3] [4]

[3] https://lore.kernel.org/linux-riscv/f5464e26-faa0-48f1-8585-9ce52c8c9f5f@iencinas.com/
[4] https://lore.kernel.org/linux-riscv/b3b59747-0484-4042-bdc4-c067688e3bfe@iencinas.com/

Changes in v3:

PATCH 2:
  Use if(riscv_has_extension_likely) instead of asm goto (Eric). It 
  looks like both versions generate the same assembly. Perhaps we should 
  do the same change in other places such as arch/riscv/include/asm/bitops.h
- Link to v2: https://lore.kernel.org/r/20250319-riscv-swab-v2-0-d53b6d6ab915@iencinas.com

Changes in v2:
- Introduce first patch factoring out the default implementation into
  asm-generic
- Remove blank line to make checkpatch happy
- Link to v1: https://lore.kernel.org/r/20250310-riscv-swab-v1-1-34652ef1ee96@iencinas.com

---
Ignacio Encinas (2):
      include/uapi/linux/swab.h: move default implementation for swab macros into asm-generic
      riscv: introduce asm/swab.h

 arch/riscv/include/asm/swab.h   | 62 +++++++++++++++++++++++++++++++++++++++++
 include/uapi/asm-generic/swab.h | 33 ++++++++++++++++++++++
 include/uapi/linux/swab.h       | 33 +---------------------
 3 files changed, 96 insertions(+), 32 deletions(-)
---
base-commit: a7f2e10ecd8f18b83951b0bab47ddaf48f93bf47
change-id: 20250307-riscv-swab-b81b94a9ac1b

Best regards,
-- 
Ignacio Encinas <ignacio@iencinas.com>


