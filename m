Return-Path: <linux-arch+bounces-7371-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 712A797ED11
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2024 16:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FCB91C218B8
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2024 14:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4031819F137;
	Mon, 23 Sep 2024 14:20:08 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A522419F432;
	Mon, 23 Sep 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101208; cv=none; b=tSU5btww0Z/qRWfmthnXs3CFX3wyVZyIVhGyaZ1j9XHHlXyam1IfuS2bnuXEVlUmI953C1IRKLChdddix3pUX0SF69/VTUT3vnYDCjPDxU52nDvDxdseCiRJOEZ3RQSpearDIBcGKMPQ6xwLItQ7W6Rns2E3C/9nuzkQOyRogTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101208; c=relaxed/simple;
	bh=AQxwLnCeXR4Tt2nNEssfZPp+mkppPyi+qa+VwXA7ggc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T8t9vIg/TlYsKkoBxTlFbkPWtA5ZT/+RnytYyWIcrv4/kOQZF58/U4/LIUmheFURX3jjKJE+/KKo51Hvw4KHXsuwmTyo2yJEoM4+EnIjOMszE2zZ+kqaq/A6noPxzKX5tETskIgzGcGSlyEP2OFtB1Wm+YKBrQBI0rQkhcUIK8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6FACFEC;
	Mon, 23 Sep 2024 07:20:35 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDBCE3F64C;
	Mon, 23 Sep 2024 07:20:03 -0700 (PDT)
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
Subject: [PATCH v2 6/8] vdso: Modify vdso/getrandom.h to include the asm header
Date: Mon, 23 Sep 2024 15:19:41 +0100
Message-Id: <20240923141943.133551-7-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240923141943.133551-1-vincenzo.frascino@arm.com>
References: <20240923141943.133551-1-vincenzo.frascino@arm.com>
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


