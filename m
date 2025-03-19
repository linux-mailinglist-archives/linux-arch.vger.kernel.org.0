Return-Path: <linux-arch+bounces-10973-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C83A69A9D
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 22:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31509423CC1
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 21:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7097215F46;
	Wed, 19 Mar 2025 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="AM+sIw7u"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E381F099A
	for <linux-arch@vger.kernel.org>; Wed, 19 Mar 2025 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418610; cv=none; b=lkfzaIfr1J8m06MiSsUTptEanIJepbN3H0r45V8tykHZSatITv3XZ4E3QBsM/Gz/nQt10beMwEblO3Q+j6YHNaykN6nvO2RI/lm+ApRCsZjL/dP0tEWxJFvApLiCn2YnAMzVymhxA7R9M2HICxw4H9nD8XvxvgJqM0AGPdMJ/Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418610; c=relaxed/simple;
	bh=9ZBMFt6MAgYWSIoBhxeQmqzoPJ5LtjoGnali5k28gEo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j2Ueg4ffSc0VrLpemIqRutUVCrHqXZ0Pz74dX4wm0nvvu+997sA7iDY+fOtBpZvxG3GyCT/zY8e7upsiV+4UDjcIndowOYr/fUYnN7d5gBnwY5CNkQ8+RjSTlV+GIUNBOaFyGLLDrZs6KjotC4Iztms1ayas+QbXFGF3WX8NNDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=AM+sIw7u; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1742418606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6qfnQE3B76r0ibOdpJTcF98zCUlANBRyP53o9I/sYaY=;
	b=AM+sIw7u+x9pDDK/T/jqmq19frHqxhqQVlgS9Yy8IHFm60uP/c50tC0EeOBLs7uhIXb22o
	C1fMvKQxt493RfVN4WKu/q4/gRTkCVtYoEiNDcB43xuT2VfL6+c8yuHdsnjC2pOb0G/rMR
	RtDOGOwtC1NGBJSVHqVoQYqxYuxi2IkN7chcr/7B7LQTUCBe7/aABznwOoeflT79h/aRT/
	XOIJbtoriN5sn0RyaO4crG3Wp7RCtAElipSXjZpvkVzzSEfC2u/LeckBkzVpT2LP3+kndf
	aAAOqYLKhgwUBA+OD7ZDlQHgGdLKz/ml35GqC/uiSsX3xYZTs4HvYZTwWVqFyQ==
From: Ignacio Encinas <ignacio@iencinas.com>
Subject: [PATCH v2 0/2] Implement endianness swap macros for RISC-V
Date: Wed, 19 Mar 2025 22:09:44 +0100
Message-Id: <20250319-riscv-swab-v2-0-d53b6d6ab915@iencinas.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJgy22cC/03MOw7CMBBF0a1EU2PkcT4QKvaBUthmQqbAiTzIg
 CLvHRNRUN4nvbOCUGQSOFUrREosPIcSZleBn2y4keJraTDatLrWBxVZfFLytE65I7q+sb316KA
 clkgjvzbsMpSeWB5zfG92wu/6Y1D/MwkVqrrpWkMjEvXdmSl4Dlb2fr7DkHP+AEC2x9inAAAA
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

RISC-V needs a default implementation to fall back on. Such
implementation is available in include/uapi/linux/swab.h in the form of 
___constant_swabXX macros. As include/uapi/linux/swab.h can't be 
included from arch/riscv/include/asm/swab.h, the default implementation 
has been moved into asm-generic in the first patch of the series.

Tested with crc_kunit as pointed out in [2]. I can't provide performance 
numbers as I don't have RISC-V hardware yet.

[1] https://lore.kernel.org/all/20250302220426.GC2079@quark.localdomain/
[2] https://lore.kernel.org/all/20250216225530.306980-1-ebiggers@kernel.org/

Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
---
Changes in v2:
- Introduce first patch factoring out the default implementation into
  asm-generic

Patch 2:
- Remove blank line to make checkpatch happy 
- Instead of duplicating the default implementation for swap macros,
  leverage patch 1 and add an include to asm-generic/swab.h

- Link to v1: https://lore.kernel.org/r/20250310-riscv-swab-v1-1-34652ef1ee96@iencinas.com

---
Ignacio Encinas (2):
      include/uapi/linux/swab.h: move default implementation for swab macros into asm-generic
      riscv: introduce asm/swab.h

 arch/riscv/include/asm/swab.h   | 48 +++++++++++++++++++++++++++++++++++++++++
 include/uapi/asm-generic/swab.h | 32 +++++++++++++++++++++++++++
 include/uapi/linux/swab.h       | 33 +---------------------------
 3 files changed, 81 insertions(+), 32 deletions(-)
---
base-commit: a7f2e10ecd8f18b83951b0bab47ddaf48f93bf47
change-id: 20250307-riscv-swab-b81b94a9ac1b

Best regards,
-- 
Ignacio Encinas <ignacio@iencinas.com>


