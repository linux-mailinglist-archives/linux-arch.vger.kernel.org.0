Return-Path: <linux-arch+bounces-7337-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 377E597A719
	for <lists+linux-arch@lfdr.de>; Mon, 16 Sep 2024 20:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51631F28C7E
	for <lists+linux-arch@lfdr.de>; Mon, 16 Sep 2024 18:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430B015B15D;
	Mon, 16 Sep 2024 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="ULYHcJXo"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E6415A865;
	Mon, 16 Sep 2024 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726509640; cv=none; b=EHpnE1qwrIarTflO5JJihQsUbM8cvy1vnwuIjDhxQEprE3YF31hHerHpLY0QK0ISp5jpBWefn1CzugxYy1XV97sMExw/ZiexmvTLZ8UgBaypWS+RBQycGVGv51fuJD9GAxzRDMK6D8+e8GQcTmHE/w/AZpyw6OPBSGeX2JVtnuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726509640; c=relaxed/simple;
	bh=VEcCojKlwFA8hJfGgqCw4mLqtRV4UKECSLbvXOFqrkw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oHTpK+EXRUA+AfApiM06ZBPCxsLbAsBm0+ZieUd3rWDuHElZm1DTMlIlagzaaEZJEUFenTVZ8L2tqt8ZxlmvaaiR1clZ2uquXuu4khoB196igUPG4XjDyUB8GLlJzMApEk1f2m1FWn1uJ9H8MjmfU4eBIUWPwkIpJzIUqfmD/Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=ULYHcJXo; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1726509138;
	bh=VEcCojKlwFA8hJfGgqCw4mLqtRV4UKECSLbvXOFqrkw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ULYHcJXoqq8BkGdPNajFNKW/OwrOUFqLYj+U6PY1T8TdhuKxdte6DhL1LojaBalUj
	 XsbfRBPi8Q+3/awB4s+ov5uwKp7sqpCFgd+nvO+P8G+iHMOhW0f48E07HY98L9g1mz
	 HJxOURoQdTdjp/WegHbVSYsLLyHn1p3sfvrl7Bow=
Received: by gentwo.org (Postfix, from userid 1003)
	id 8CC8440262; Mon, 16 Sep 2024 10:52:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 890F5401D1;
	Mon, 16 Sep 2024 10:52:18 -0700 (PDT)
Date: Mon, 16 Sep 2024 10:52:18 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: kernel test robot <lkp@intel.com>
cc: Christoph Lameter via B4 Relay <devnull+cl.gentwo.org@kernel.org>, 
    Thomas Gleixner <tglx@linutronix.de>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
    oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-arch@vger.kernel.org
Subject: Re: [PATCH v3] Avoid memory barrier in read_seqcount() through load
 acquire
In-Reply-To: <202409132135.ki3Mp5EA-lkp@intel.com>
Message-ID: <766fe92a-13da-f299-0ecf-f8a477d58a79@gentwo.org>
References: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org> <202409132135.ki3Mp5EA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 13 Sep 2024, kernel test robot wrote:

> >> drivers/gpu/drm/i915/gt/intel_tlb.h:21:47: error: macro "seqprop_sequence" requires 2 arguments, but only 1 given

From 15d86bc9589f16947c5fb0f34d2947eacd48f853 Mon Sep 17 00:00:00 2001
From: Christoph Lameter <cl@gentwo.org>
Date: Mon, 16 Sep 2024 10:44:16 -0700
Subject: [PATCH] Update Intel DRM use of seqprop_sequence

One of Intels drivers uses seqprop_sequence() for its tlb sequencing.
We added a parameter so that we can use acquire. Its pretty safe to
assume that this will work without acquire.

Signed-off-by: Christoph Lameter <cl@linux.com>
---
 drivers/gpu/drm/i915/gt/intel_tlb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_tlb.h b/drivers/gpu/drm/i915/gt/intel_tlb.h
index 337327af92ac..81998c4cd4fb 100644
--- a/drivers/gpu/drm/i915/gt/intel_tlb.h
+++ b/drivers/gpu/drm/i915/gt/intel_tlb.h
@@ -18,7 +18,7 @@ void intel_gt_fini_tlb(struct intel_gt *gt);

 static inline u32 intel_gt_tlb_seqno(const struct intel_gt *gt)
 {
-	return seqprop_sequence(&gt->tlb.seqno);
+	return seqprop_sequence(&gt->tlb.seqno, false);
 }

 static inline u32 intel_gt_next_invalidate_tlb_full(const struct intel_gt *gt)
-- 
2.39.5


