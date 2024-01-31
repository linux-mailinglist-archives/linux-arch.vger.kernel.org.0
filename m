Return-Path: <linux-arch+bounces-1884-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7268A8436C2
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 07:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E876282B8D
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 06:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD253E499;
	Wed, 31 Jan 2024 06:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUUJh4ZU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E8D3D56E;
	Wed, 31 Jan 2024 06:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706682593; cv=none; b=gZq7X9M31FLI/66EX0AP83nGavrq4m0Y9yWL86fDPgg5mPRMGffJ5yTM9A0cdHzLsTDQa/4ACFzDV+Vft3D3zkemzsY8USKrxwmqTEqcM4lqHt1zxYEByuqg1320s7ArHefPcNY0kvEzwIu9qWrO7FWQ40QlgYsWvqJbCBSAf9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706682593; c=relaxed/simple;
	bh=2FW/d4u/muEUqMbOvxlTPNXE5CaRll4su+xJMlD1d+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JjRoAzAhv2xdkwmiRa5tlvyF+9pjXrVYKOER8oKao6oWGwwGTk5hJTylFJ+bzPjROh8CwLCpDUJT1kx8dF8D3dcVEPlHyEaR2D4oxYJY1HV3BpWsHRyS/VyFhupHuP3kDXzMWXVSNLZ4vf3owsDK1Shk9PNylHzSBk3UAPdCF0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUUJh4ZU; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706682592; x=1738218592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=2FW/d4u/muEUqMbOvxlTPNXE5CaRll4su+xJMlD1d+8=;
  b=RUUJh4ZU/6OkQmQ7HDqomPWqUT2m/bgt2kNtWCqxFj2GTdFqZxAr8LW2
   /fdCmj2nSrTW9llp+C2XBvfrg1GxVTiHSbPMf1e8A607xI44Io5JGBVVb
   z3EPGSf0aHAdvDhZVzUoW5vU2iIY6fTpAmTtwKYh62UZsKC2/6pfh0lrk
   EvHjexpGPnHgjHfQCy2YJ05dLQGZeIyYiOjOmVG8UBa11hHsZdWeOH7eh
   WVls0JYLhPuFRN11ibpOBCbES7IjVv5lducSp0nh5L4j2pVs+Dv6h/RZ9
   RXq8WbNLmBl8vaQtwA/esepZ9ijolpZsDFebher0miwy4/qLv5fMQ4L/2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="434679669"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="434679669"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 22:29:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822458493"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="822458493"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 22:29:47 -0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: arnd@arndb.de,
	linus.walleij@linaro.org,
	guoren@kernel.org,
	bcain@quicinc.com,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: [PATCH 3/4] Hexagon: apply page shift to PFN instead of VA in pfn_to_virt
Date: Wed, 31 Jan 2024 14:00:21 +0800
Message-Id: <20240131060021.2749-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240131055159.2506-1-yan.y.zhao@intel.com>
References: <20240131055159.2506-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Apply the page shift to PFN to get physical address for final VA.
The macro __va should take physical address instead of PFN as input.

Fixes: d6e81532b10d ("Hexagon: Make pfn accessors statics inlines")
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/hexagon/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/include/asm/page.h b/arch/hexagon/include/asm/page.h
index 10f1bc07423c..1d341590791a 100644
--- a/arch/hexagon/include/asm/page.h
+++ b/arch/hexagon/include/asm/page.h
@@ -135,7 +135,7 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
 
 static inline void *pfn_to_virt(unsigned long pfn)
 {
-	return (void *)((unsigned long)__va(pfn) << PAGE_SHIFT);
+	return __va(pfn << PAGE_SHIFT);
 }
 
 
-- 
2.17.1


