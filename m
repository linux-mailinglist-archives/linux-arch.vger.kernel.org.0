Return-Path: <linux-arch+bounces-1885-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EE38436D5
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 07:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2FB31F2984B
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 06:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C051232186;
	Wed, 31 Jan 2024 06:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mmQFZQ15"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00817125CA;
	Wed, 31 Jan 2024 06:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706682673; cv=none; b=V5A9XemPKHnblvKiTT5NRg04pZzadydrR+eS1ZrgV/g1k2nSb9HgqusiQ4aCfpdZz5rJq08LfUCwm6ie35ggmqRzhLD+Kkr/T/F8UIejbk3vVPKdP8zyHwM8Es+7Cf+3en2HfhLw7WUnaz3Y379bN6oBX37RQ4ApLfHySTUzCmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706682673; c=relaxed/simple;
	bh=rWpNYhvi5Y7XEDqsmQ7YOXj2NszqHIpA2qBYV+5aizE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bKrVVEJyzBzJv0e43ll4wN6rRozrJ3EgFMgZKX3odYvE/SR/lOlHEElX0OjKCpDAjFKjB9Ml7RwJ7vpxXQrINfmsyAFZbWqyNoBZmAWsGxY7O3SBZnmdSFybPTXBREofAVBZSKsej1fdyvQefYB0TdOKEI2rpj4TySGSXAy0CoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mmQFZQ15; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706682673; x=1738218673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=rWpNYhvi5Y7XEDqsmQ7YOXj2NszqHIpA2qBYV+5aizE=;
  b=mmQFZQ15dYt8NhEMlVcdhRYa0u3xnfkQLqMib7qbOgJtDIz2y/RIPt4+
   2WA5JJfD2219ZbFDdU5ORcag9Gfva0fQwvivmjqn6hFvBrBCDXAFf6AmV
   2jsNQvP5dHNdlT7ZZauPcuoZaeb+k/meHXAaD6Gs7ACSpSFDNY3Dt0yBQ
   h7mC+/202asF2pdIQNypTg7L0gro0TeX+dvXvNNDPu48JsrEus7ww1+u1
   nluYSQDSjSnl8HwCaGE3E5O6KxSCcYP6ZLuzycMQ73TWwwHJeDBuRzq+L
   rFX1fvXX/9Ooxji1GxQmKOy0myy1ycKTkYaNmDCMrRCc7gxJcJG+5mMiO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10145767"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10145767"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 22:31:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="907779612"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="907779612"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 22:31:07 -0800
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
Subject: [PATCH 4/4] openrisc: apply page shift to PFN instead of VA in pfn_to_virt
Date: Wed, 31 Jan 2024 14:01:42 +0800
Message-Id: <20240131060142.2823-1-yan.y.zhao@intel.com>
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

Fixes: 232ba1630c66 ("openrisc: Make pfn accessors statics inlines")
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/openrisc/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/page.h
index 44fc1fd56717..55c66f6cb1bd 100644
--- a/arch/openrisc/include/asm/page.h
+++ b/arch/openrisc/include/asm/page.h
@@ -79,7 +79,7 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
 
 static inline void * pfn_to_virt(unsigned long pfn)
 {
-	return (void *)((unsigned long)__va(pfn) << PAGE_SHIFT);
+	return __va(pfn << PAGE_SHIFT);
 }
 
 #define virt_to_page(addr) \
-- 
2.17.1


