Return-Path: <linux-arch+bounces-7656-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F3E98F29A
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 17:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8103928197D
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 15:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8431C1A2569;
	Thu,  3 Oct 2024 15:29:26 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BD71A3042;
	Thu,  3 Oct 2024 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727969366; cv=none; b=CGgDmJn5hqnzC8r/+hxvkdYWbDYUKIefr9IApQnTEujKnZT6Z0Gxa55+ZbWdDXGh9KBIthroJO0DkssHDUr6GSbV9cUdR8e15+V4ogUPqxUwsMRMI9frp1gVKtyi3e2iJl/MIRIpZEUquBlD8h+IZskse15vzVSzJVan4UZy64U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727969366; c=relaxed/simple;
	bh=GKgg1zsyKJ9sd8dZXgkcJMYDWmzgqiGUKV82pTnGx5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQiQPelITUWp+ttCVgVJkER6/dwXa2LzGgLekk3M/+KlqSbGYC5utz7cckgZS3XucRZQ7yjhLyITuxcjUZxXm/3Jjd3e6C+ZLMDd1lqVGpc4OiWIfGwKIVevFuCWqFrxPJCW6qzF+XNGK2RGIFmszipvbsxjRE8bKjBY3rj9zTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 245E014BF;
	Thu,  3 Oct 2024 08:29:53 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF29F3F640;
	Thu,  3 Oct 2024 08:29:20 -0700 (PDT)
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
Subject: [PATCH v3 1/2] drm: Fix fault format
Date: Thu,  3 Oct 2024 16:29:09 +0100
Message-Id: <20241003152910.3287259-2-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003152910.3287259-1-vincenzo.frascino@arm.com>
References: <20241003152910.3287259-1-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fault is of type u32 and PAGE_MASK is type agnostic, hence the correct
format for address should be %x not %lx otherwise:

drivers/gpu/drm/i915/gt/intel_gt_print.h:29:36: error: format ‘%lx’ expects
argument of type ‘long unsigned int’, but argument 6 has type ‘u32’ {aka
‘unsigned int’} [-Werror=format=]
   29 |         drm_dbg(&(_gt)->i915->drm, "GT%u: " _fmt, (_gt)->info.id,
      |                                    ^~~~~~~~
include/drm/drm_print.h:424:39: note: in definition of macro ‘drm_dev_dbg’
  424 |         __drm_dev_dbg(NULL, dev, cat, fmt, ##__VA_ARGS__)
      |                                       ^~~
include/drm/drm_print.h:524:33: note: in expansion of macro ‘drm_dbg_driver’
  524 | #define drm_dbg(drm, fmt, ...)  drm_dbg_driver(drm, fmt, ##__VA_ARGS__)
      |                                 ^~~~~~~~~~~~~~
linux/drivers/gpu/drm/i915/gt/intel_gt_print.h:29:9: note: in expansion of macro
‘drm_dbg’
   29 |         drm_dbg(&(_gt)->i915->drm, "GT%u: " _fmt, (_gt)->info.id,
      |         ^~~~~~~
drivers/gpu/drm/i915/gt/intel_gt.c:310:25: note: in expansion of macro ‘gt_dbg’
  310 |                         gt_dbg(gt, "Unexpected fault\n"
      |                         ^~~~~~

Fix address format.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 drivers/gpu/drm/i915/gt/intel_gt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt.c b/drivers/gpu/drm/i915/gt/intel_gt.c
index a6c69a706fd7..352ef5e1c615 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt.c
@@ -308,7 +308,7 @@ static void gen6_check_faults(struct intel_gt *gt)
 		fault = GEN6_RING_FAULT_REG_READ(engine);
 		if (fault & RING_FAULT_VALID) {
 			gt_dbg(gt, "Unexpected fault\n"
-			       "\tAddr: 0x%08lx\n"
+			       "\tAddr: 0x%08x\n"
 			       "\tAddress space: %s\n"
 			       "\tSource ID: %d\n"
 			       "\tType: %d\n",
-- 
2.34.1


