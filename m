Return-Path: <linux-arch+bounces-11251-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943D6A7B064
	for <lists+linux-arch@lfdr.de>; Thu,  3 Apr 2025 23:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93350179156
	for <lists+linux-arch@lfdr.de>; Thu,  3 Apr 2025 21:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCC61FE45F;
	Thu,  3 Apr 2025 20:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="fipwsY+d"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8151FE46C
	for <linux-arch@vger.kernel.org>; Thu,  3 Apr 2025 20:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743712494; cv=none; b=P9bXIA6IQR3eTYnbzGtW0DXSSpbToq3Mut04hxK5jLepg0OXjokzi+WucB/A4yDPjcUJ6qEFHqM5kjtqQDRg8XtNCfAHksbxGyKYPZVHxKq7yIbepfQQB4vaDRmnsEhGcmTGPfGXStS8Bn5r792eEegbGQaBzFM8IqfipHQMcNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743712494; c=relaxed/simple;
	bh=xB2C04uovpv4skICAYGaB52QAvjvmMm90YpbPc+QSWE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F/Y8JRtH2KK6VAXb2OQkuq92emUMoGNhbO74UPDM6SkPJH8qRU4P03TbmgwaFGiKH1hcz4hjfmEMsZTnLrHIK39RvChm/J5E/1d4x+uKSSh1zTl8c7J8HFp7SaDHVl/tWVbqIPRz8j6aUDqe5PW3BQdoo9dGyZ6EiH0NEJMaEDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=fipwsY+d; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1743712480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UDfYL4ErdunlNmstrEsdYuv+0FhmfCu6RIMjgekzhfE=;
	b=fipwsY+d+b6rrvO4vtfMK74We5DLTRxmJZCjFxcOm517hPj64VLEIduGp6NAUPREU89bjd
	xZyKMR6nFCAMifx9XV1LmHzDsR58ZHEpgkfL4NkP+YcXqsECMzDYu5cQOnOEs/sUaH9WCw
	ukcacLOEs519U2x8Xudi91EKa/cOBqF6WZ3YK8xvOjpS0qw7m1lnGoaB9bFBtJj7rfyaiJ
	jdKLSDWnzKX12KL7x71yizY4dCcT3195iwvxltXgU7Q31Xyvw/0YkVQLNEmuAXzopXQl9u
	hkfS8CjuyPo/Xascx/5iTJ2qdB8qF+NiTZrWIn+LWV/Zk2l8svIVyF5ej0JqTA==
From: Ignacio Encinas <ignacio@iencinas.com>
Subject: [PATCH v3 0/2] Implement endianess swap macros for RISC-V
Date: Thu, 03 Apr 2025 22:34:16 +0200
Message-Id: <20250403-riscv-swab-v3-0-3bf705d80e33@iencinas.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMjw7mcC/13MQQ7CIBCF4asY1mIYKCiuvIdxAXRqZyE1YFDT9
 O7SxkV1+V7yfyPLmAgzO25GlrBQpiHWobYbFnoXr8iprZtJIbVQYs8T5VB4fjrP/QG8bZx1ATy
 rwT1hR68FO1/q7ik/hvRe7ALz+2VArJkCHLhqjJbYAaI1J8IYKLq8C8ONzVKR69r+1JIL3mrlT
 Wuct6D/6mmaPuSS1UflAAAA
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
Changes in v3:

PATCH 2:
  Use if(riscv_has_extension_likely) instead of asm goto (Eric). It 
  looks like both versions generate the same assembly. Perhaps we should 
  do the same change in other places such as arch/riscv/include/asm/bitops.h

- Link to v2: https://lore.kernel.org/r/20250319-riscv-swab-v2-0-d53b6d6ab915@iencinas.com

Arnd, I tried your suggestion but couldn't make it work. Let me know if
I missed something in my response.

Changes in v2:
- Introduce first patch factoring out the default implementation into
  asm-generic
- Remove blank line to make checkpatch happy
- Link to v1: https://lore.kernel.org/r/20250310-riscv-swab-v1-1-34652ef1ee96@iencinas.com

---
Ignacio Encinas (2):
      include/uapi/linux/swab.h: move default implementation for swab macros into asm-generic
      riscv: introduce asm/swab.h

 arch/riscv/include/asm/swab.h   | 43 +++++++++++++++++++++++++++++++++++++++++
 include/uapi/asm-generic/swab.h | 32 ++++++++++++++++++++++++++++++
 include/uapi/linux/swab.h       | 33 +------------------------------
 3 files changed, 76 insertions(+), 32 deletions(-)
---
base-commit: a7f2e10ecd8f18b83951b0bab47ddaf48f93bf47
change-id: 20250307-riscv-swab-b81b94a9ac1b

Best regards,
-- 
Ignacio Encinas <ignacio@iencinas.com>


