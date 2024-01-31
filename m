Return-Path: <linux-arch+bounces-1882-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D278B8436B1
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 07:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE0B28A13B
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 06:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FFE3E478;
	Wed, 31 Jan 2024 06:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z2czEHs1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6923540BE9;
	Wed, 31 Jan 2024 06:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706682438; cv=none; b=WHYLtg/4tiVvR7s712AeapNosYIA7iK4OzsqiyT1oXw0h9z544OdlqxhygrM2zBE/ySr2THLnwbekR8yexx8ElVIj2Sj+Gc+1LC003igBgxsiH6eG6e9BlvI3vw1jiO50+MFWQhb6MGXUiB71AjjQ99CkQb8twFo5h9y8Kj+Q1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706682438; c=relaxed/simple;
	bh=Xo8Jvj5oQfz6M2xvN89WBs3fC3gskTN27sgAVfq3fjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=is4erkwnkhjsVO68fYZo6ZZwZ9leBSlpOiH1fnSLU1Wzz4PsZDMwk8k0TTAbKtXcAklr4nq9Dhue/fxkp6cbFNynIH6zNkrF4IBYmw7xe7Byh34EnFvkbxCyj63xD9LbyWcno2glpocTYxTE98WJRTm4bZpgnJ9gbh0Q0boetCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z2czEHs1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706682437; x=1738218437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Xo8Jvj5oQfz6M2xvN89WBs3fC3gskTN27sgAVfq3fjI=;
  b=Z2czEHs12ncbG+D4JgStwFJcGuQylSGpN2rThGtbYZFR6rOSlV8aKJsA
   FNzbYAHaor7nIY8LvTktsB8a8PPjEPJTLfVMv/vgXDBYDLt4VfLTS1g9E
   B4HC0tGZNIQ/xB6MzyzApi+GDdpEVKLkGgKoJ5iRtRlz7M4GTf8i7Hoir
   FVSOB4J4cWivCDLtT2tS3hxE8NjGIrmFR8oMtjdB/mk0Osi3+j4CjACz6
   3zHCXCjKfTM33LqbT3gv8HhZUJdeWrtRNOreDKpw0I1j+UfeuwKVksnwa
   FxrGNDH438lknycSPiO6jBnZxG+sYDyjUXGfQ5qDgdKL4VHY1qYxYqLZj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10144950"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10144950"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 22:27:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="931737324"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="931737324"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 22:27:10 -0800
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
Subject: [PATCH 1/4] asm-generic/page.h: apply page shift to PFN instead of VA in pfn_to_virt
Date: Wed, 31 Jan 2024 13:57:40 +0800
Message-Id: <20240131055740.2579-1-yan.y.zhao@intel.com>
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

Fixes: 2d78057f0dd4 ("asm-generic/page.h: Make pfn accessors static inlines")
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 include/asm-generic/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
index 9773582fd96e..4f1265207b9a 100644
--- a/include/asm-generic/page.h
+++ b/include/asm-generic/page.h
@@ -81,7 +81,7 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
 #define virt_to_pfn virt_to_pfn
 static inline void *pfn_to_virt(unsigned long pfn)
 {
-	return __va(pfn) << PAGE_SHIFT;
+	return __va(pfn << PAGE_SHIFT);
 }
 #define pfn_to_virt pfn_to_virt
 
-- 
2.17.1


