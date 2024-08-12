Return-Path: <linux-arch+bounces-6152-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CDB94E66A
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 08:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14ABD1F2237C
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2024 06:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B931A14F9C9;
	Mon, 12 Aug 2024 06:13:51 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE01614E2EF;
	Mon, 12 Aug 2024 06:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723443231; cv=none; b=V692/Y+gynSNqo8dgs2PSFlrYG1AAlcGigmBBgbLhT0v+NawNfKkOjrN7g8cuE7LczEW0pdAA1irx+/REmc4u5jCz5wrT568G1pcepaszawKodzb7NglTGlHXuzAv62NW2637C7yy0fbTWoZeiIZhPT+7qJUqg+Oci12JFZVtjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723443231; c=relaxed/simple;
	bh=JxHQkpLX42zbYR/K/LXcoZTUYa6MhYcukw+z5FRgmUk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DiObCjNmG1fqqNYU5J9Khu7iH7I2haG4kXTNwh9PJSd1A3cQYYxGWw6LdWPewvRcJrREElWw52zVOLh278DtoVxl+UzBVF/foZWlz+tXd2Kcy7LD9CMghCe6JKK3SJoANhvL65Gp2swjqdU+luH2eUjklnRT8F/CTwdRmJFonMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wj3xb4K1vzQpcx;
	Mon, 12 Aug 2024 14:09:07 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 9213E1402E2;
	Mon, 12 Aug 2024 14:13:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 12 Aug
 2024 14:13:38 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-arch@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2] crash: Fix riscv64 crash memory reserve dead loop
Date: Mon, 12 Aug 2024 14:20:17 +0800
Message-ID: <20240812062017.2674441-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi100008.china.huawei.com (7.221.188.57)

On RISCV64 Qemu machine with 512MB memory, cmdline "crashkernel=500M,high"
will cause system stall as below:

	 Zone ranges:
	   DMA32    [mem 0x0000000080000000-0x000000009fffffff]
	   Normal   empty
	 Movable zone start for each node
	 Early memory node ranges
	   node   0: [mem 0x0000000080000000-0x000000008005ffff]
	   node   0: [mem 0x0000000080060000-0x000000009fffffff]
	 Initmem setup node 0 [mem 0x0000000080000000-0x000000009fffffff]
	(stall here)

commit 5d99cadf1568 ("crash: fix x86_32 crash memory reserve dead loop
bug") fix this on 32-bit architecture. However, the problem is not
completely solved. If `CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX` on 64-bit
architecture, for example, when system memory is equal to
CRASH_ADDR_LOW_MAX on RISCV64, the following infinite loop will also occur:

	-> reserve_crashkernel_generic() and high is true
	   -> alloc at [CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX] fail
	      -> alloc at [0, CRASH_ADDR_LOW_MAX] fail and repeatedly
	         (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).

As Catalin suggested, do not remove the ",high" reservation fallback to
",low" logic which will change arm64's kdump behavior, but fix it by
skipping the above situation similar to commit d2f32f23190b ("crash: fix
x86_32 crash memory reserve dead loop").

After this patch, it print:
	cannot allocate crashkernel (size:0x1f400000)

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
---
v2:
- Fix it in another way suggested by Catalin.
- Add Suggested-by.
---
 kernel/crash_reserve.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5387269114f6..aae4a9e998d1 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -427,7 +427,8 @@ void __init reserve_crashkernel_generic(char *cmdline,
 		if (high && search_end == CRASH_ADDR_HIGH_MAX) {
 			search_end = CRASH_ADDR_LOW_MAX;
 			search_base = 0;
-			goto retry;
+			if (search_end != CRASH_ADDR_HIGH_MAX)
+				goto retry;
 		}
 		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
 			crash_size);
-- 
2.34.1


