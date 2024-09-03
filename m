Return-Path: <linux-arch+bounces-6958-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD5F96A1E2
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 17:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1C73B26F6B
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 15:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0152218859E;
	Tue,  3 Sep 2024 15:15:22 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901A2187571;
	Tue,  3 Sep 2024 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376521; cv=none; b=gl5DdQkDmZJ7Si9hutTwk5xR8JcuJ8xPR9jv8+BMu89ED+8CecERNF0Vn/KQHuox8qT6Q+onU21dJyupVm2wn0WNOGbRCMlvCkLFI8BxZ3UBwoB88BTFB3zbLgU6HdhcYN+a1AxLNGRuBCpdBl5w8SveLuszqOWWwzIoXsdos5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376521; c=relaxed/simple;
	bh=AQxwLnCeXR4Tt2nNEssfZPp+mkppPyi+qa+VwXA7ggc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=myz9wIg6UiIBBeXY1eNYfWUI5u0l/Ggs2Cr8WY6Mjxvu/xf7ZVA2U57bdBJGo/x6UIppp515YmopA5hBrOrC3wM9BfG8aF1tujlZURMqgVg1dz588yDWPiiGkXzwTQqK8grKMOfUnzm5iUTKf6WHuUcNXwNxmxENwohsecthgZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AF7E1063;
	Tue,  3 Sep 2024 08:15:46 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 150153F66E;
	Tue,  3 Sep 2024 08:15:16 -0700 (PDT)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 8/9] vdso: Modify vdso/getrandom.h to include the asm header
Date: Tue,  3 Sep 2024 16:14:36 +0100
Message-Id: <20240903151437.1002990-9-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903151437.1002990-1-vincenzo.frascino@arm.com>
References: <20240903151437.1002990-1-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VDSO implementation includes headers from outside of the
vdso/ namespace.

Modify vdso/getrandom.h to include the getrandom asm header.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/vdso/getrandom.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/vdso/getrandom.h b/include/vdso/getrandom.h
index 6ca4d6de9e46..5cf3f75d6fb6 100644
--- a/include/vdso/getrandom.h
+++ b/include/vdso/getrandom.h
@@ -7,6 +7,7 @@
 #define _VDSO_GETRANDOM_H
 
 #include <linux/types.h>
+#include <asm/vdso/getrandom.h>
 
 #define CHACHA_KEY_SIZE         32
 #define CHACHA_BLOCK_SIZE       64
-- 
2.34.1


