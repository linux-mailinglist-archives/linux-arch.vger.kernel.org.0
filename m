Return-Path: <linux-arch+bounces-1881-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3308C8436A5
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 07:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6625C1C21CA2
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 06:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDAF3EA90;
	Wed, 31 Jan 2024 06:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eAHplHh2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B390C3EA7A;
	Wed, 31 Jan 2024 06:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706682355; cv=none; b=fg+R+MdYbyl/E6UpHrGvPrH92kBU3oXuxWns8pV5kjr9xOkSND+T7B4Nt0JoRfwYA5mKAnf5uBVBHZp+IU7uZBOjq8FWvld8HVHF3WSwZIaAuz0o0h3r8W1SLm7HbHMB534vaaEnim58T82zLk8CQ5LeLGsMGSPtwW+pWjOE1Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706682355; c=relaxed/simple;
	bh=Dz+rEBJ1wZtGL4hQOfZUqa80XN/mQMePbBMimQSo/DE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=I0cFyrxwB6CUjqhI5SpUDhovsFHQIqC5p+/pJU4IEqrPpVxsEzqW8DZe7ful/FQgKuPfcqY0guf8oFyyIOLM/i+dWAfcZQftqtWwmwQgDhs4WSvgXMxkfM3Ub88IyoFs6JNjvTG/OoZdaQ9yOBX9pHllMc/b6gEqgpKNbVlTRRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eAHplHh2; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706682353; x=1738218353;
  h=from:to:cc:subject:date:message-id;
  bh=Dz+rEBJ1wZtGL4hQOfZUqa80XN/mQMePbBMimQSo/DE=;
  b=eAHplHh2S9pdRDzjgvzFHshNkiSArFrKroXo7QoWq/B812hZ6r8Z/UwD
   sabFCxTq56v5R+WcUv2ELz6qFPZf7sxg0eB+f066YRfU0IdP7mHIu57yy
   Mc1U3emt7Mo/Rk/kbsq9hBaM7ZcMRVcr6JVLNL8zaKW3+6KI6sCF6JimX
   7fy5sWQwrIHjcSvWf3gIsHEi1pT9Mc7Izmj3Usuoh33qoWYC2+zxNHoG+
   vLu8yFUWT8a05EKxed4Aq4Zislw0nUV2WtNDJkc5+W11qifFIaCHgrkVu
   xk6sCzv6YdEKUzaPWVId1Vxj70GBMsQcPrznm3JoRUiacWEHobr+jEQM0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="16888137"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="16888137"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 22:25:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3939842"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 22:25:50 -0800
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
Subject: [PATCH 0/4] apply page shift to PFN instead of VA in pfn_to_virt
Date: Wed, 31 Jan 2024 13:51:59 +0800
Message-Id: <20240131055159.2506-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

This is a tiny fix to pfn_to_virt() for some platforms.

The original implementaion of pfn_to_virt() takes PFN instead of PA as the
input to macro __va, with PAGE_SHIFT applying to the converted VA, which
is not right under most conditions, especially when there's an offset in
__va.


Yan Zhao (4):
  asm-generic/page.h: apply page shift to PFN instead of VA in
    pfn_to_virt
  csky: apply page shift to PFN instead of VA in pfn_to_virt
  Hexagon: apply page shift to PFN instead of VA in pfn_to_virt
  openrisc: apply page shift to PFN instead of VA in pfn_to_virt

 arch/csky/include/asm/page.h     | 2 +-
 arch/hexagon/include/asm/page.h  | 2 +-
 arch/openrisc/include/asm/page.h | 2 +-
 include/asm-generic/page.h       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)


base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
-- 
2.17.1


