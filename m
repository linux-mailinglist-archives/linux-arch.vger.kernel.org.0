Return-Path: <linux-arch+bounces-7972-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7578599885B
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 15:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9CC5B28B12
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 13:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA501C9EDA;
	Thu, 10 Oct 2024 13:51:55 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9DA1C8FD7;
	Thu, 10 Oct 2024 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568315; cv=none; b=ErhhqDXOo16t2BySqCK/lYtDvah08s0O5xxdNBGBVYkUh7ju9FPE7QG++PtDaIZ6MyFbAW9Mx1zbfkhkiKB6geohayNk8vjusSCsqfGvv7O5O/3CRmgHpi2wv8CUV51f7/xJ1HUKeoHd8qcv6NOmT6lIzGNUhQ8CWrfNa1USlPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568315; c=relaxed/simple;
	bh=6KG25XLjDXIuDc4PxrAhsp1s6fsl9H8fRrY2vjyd17g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgg6vgh38vgNVNceG+YV6DNQ8EQzNnt//8OgDWV/HcUxSNKT9PjJxu1PjIy5eThTZBeylMwD8Mu+9+AeqmH7GvwH08AZ2jYNOSaVksH808H+RNRt7PBo/9BaIjEcFsYqrJEEfwAb6AJcrbiOgt/xhcq0v01zL+uC24LYcKasyzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27408DA7;
	Thu, 10 Oct 2024 06:52:22 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FC053F64C;
	Thu, 10 Oct 2024 06:51:51 -0700 (PDT)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v4 1/2] drm: i915: Change fault type to unsigned long
Date: Thu, 10 Oct 2024 14:51:45 +0100
Message-Id: <20241010135146.181175-2-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010135146.181175-1-vincenzo.frascino@arm.com>
References: <20241010135146.181175-1-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fault is currently of type u32 and with the introduction of the
generalized vdso/page.h we trigger the error below:

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

This happens because the type of PAGE_MASK depends on the architecture.

Prevent the compilation error changing the 'fault' type to unsigned
long.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 drivers/gpu/drm/i915/gt/intel_gt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt.c b/drivers/gpu/drm/i915/gt/intel_gt.c
index a6c69a706fd7..bb29f361110e 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt.c
@@ -302,7 +302,7 @@ static void gen6_check_faults(struct intel_gt *gt)
 {
 	struct intel_engine_cs *engine;
 	enum intel_engine_id id;
-	u32 fault;
+	unsigned long fault;
 
 	for_each_engine(engine, gt, id) {
 		fault = GEN6_RING_FAULT_REG_READ(engine);
@@ -310,8 +310,8 @@ static void gen6_check_faults(struct intel_gt *gt)
 			gt_dbg(gt, "Unexpected fault\n"
 			       "\tAddr: 0x%08lx\n"
 			       "\tAddress space: %s\n"
-			       "\tSource ID: %d\n"
-			       "\tType: %d\n",
+			       "\tSource ID: %ld\n"
+			       "\tType: %ld\n",
 			       fault & PAGE_MASK,
 			       fault & RING_FAULT_GTTSEL_MASK ?
 			       "GGTT" : "PPGTT",
-- 
2.34.1


