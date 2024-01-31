Return-Path: <linux-arch+bounces-1883-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D46B8436BA
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 07:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0BB28AC1E
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 06:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB40B3E49C;
	Wed, 31 Jan 2024 06:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="We2OMRKG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE7D3E48F;
	Wed, 31 Jan 2024 06:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706682522; cv=none; b=ffmwqJEKl1frr+EeHoACz110SUraPpL24CWnywJf3B2yMedHzJu2rINl6ypfHxEKQ8Fdu5UhgdNWvplhVY2uHA8jO5dXXD2ij5OcROhJRRt4IUKREL+M1APsnVvMxp7AduYJy1mm3bfTTolw0c0ZQsNkHWJqToGVevt8K1725IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706682522; c=relaxed/simple;
	bh=hfVSVgT0v5YPemJxSQBciKx1IHu0qbunahQtFTlHaHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YAToFqPgFtDwGNtCeXm68QvnKgQyunv2QqI6l/5oG+qt8innpCVoZ5KFs47mzX1oyH+ob9OEuauApKPKOKr5Sj7UxFDl/goYNWE1ZsKCp7VJkgBGGr6MbdHfcExzvNGuTMXLMjgiA+dkcWdggLF2HA6GVye8IRl7vGp1O8w4y9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=We2OMRKG; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706682521; x=1738218521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=hfVSVgT0v5YPemJxSQBciKx1IHu0qbunahQtFTlHaHI=;
  b=We2OMRKGOsLHH3l/j9Vk4F4SVlti1xrIpm1no5lhY+jr9EpUbTf63X1Q
   11T0CB6esi+fS/f+OY5jQa662l4EJGiebMm0yEV0IPDl7owu3xgIEXfUY
   HtVIEMqVe9R+O2E800MZzIagIu+i6rsB7kWaeIWEDLhAp5eesslOQL5ax
   WQh+/dj+0zeu0vIEe0rtdJ/P4H0WPzWOFC+HDwL3Q+p0ge/cCd38E4OWM
   Zj3it3Ckia26YDswK4dLPIwukGgsGuQC+HqHwe2TAjpPjmnZhNp+Jm7m9
   eGDqP5crjDiZLND6Xznh/tbu9xvVtDtzP3l/cQc9tDhTsLcE+Db7CpQ0X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="467751655"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="467751655"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 22:28:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="30385588"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 22:28:30 -0800
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
Subject: [PATCH 2/4] csky: apply page shift to PFN instead of VA in pfn_to_virt
Date: Wed, 31 Jan 2024 13:59:04 +0800
Message-Id: <20240131055904.2652-1-yan.y.zhao@intel.com>
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

Fixes: c1884e1e1164 ("csky: Make pfn accessors static inlines")
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/csky/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/page.h
index 4a0502e324a6..2c4cc7825a7b 100644
--- a/arch/csky/include/asm/page.h
+++ b/arch/csky/include/asm/page.h
@@ -84,7 +84,7 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
 
 static inline void * pfn_to_virt(unsigned long pfn)
 {
-	return (void *)((unsigned long)__va(pfn) << PAGE_SHIFT);
+	return __va(pfn << PAGE_SHIFT);
 }
 
 #define MAP_NR(x)	PFN_DOWN((unsigned long)(x) - PAGE_OFFSET - \
-- 
2.17.1


