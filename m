Return-Path: <linux-arch+bounces-14255-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7E6BFBAA1
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 13:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C382C35356F
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 11:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502C933DECE;
	Wed, 22 Oct 2025 11:36:33 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F941309DDF;
	Wed, 22 Oct 2025 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132993; cv=none; b=Lr+rNKGXCxkQaUhggHBDeZAow+2SV9gBZwC80lFiAP3UidrGG3SmMsY+XCNMGGx+S0wLLgTTLk7CE+MKKo6spcE1hlqYK22iLljqg4O0ZAgTmRIG9s06VA5NicyT8LJw+eWZjEvm4Nn7ML+3/GO2Y66hhduBTsIev5kIX+RQlqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132993; c=relaxed/simple;
	bh=2D6rOWQd2+2ovB0Vww4AzRzGp2Lih06qNstkcCiwyMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcjiLsEUtIpmhVOcv4yI+MJWai6O/IeM3ORA78ToJ8XhDLGR880bH5k3MdK335ead70buFkclhL7xp3gvHAnRe+5O7OFDoZ6Z+dYupheCm+OWIGN4SKlhc56Ef3XyNqxN0QyQZoQI1V4VEy1QppFsfNHiv6KTm6c6Nx/IwTgai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cs6XS5yH3z6K5kg;
	Wed, 22 Oct 2025 19:35:04 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 100031402FC;
	Wed, 22 Oct 2025 19:36:29 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml100005.china.huawei.com (7.214.146.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Oct 2025 12:36:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Conor Dooley <conor@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, <linux-cxl@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, Dan Williams <dan.j.williams@intel.com>, "H . Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <james.morse@arm.com>, Will Deacon <will@kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, <linuxarm@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, Andy Lutomirski
	<luto@kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v4 5/6] MAINTAINERS: Add Jonathan Cameron to drivers/cache and add lib/cache_maint.c + header
Date: Wed, 22 Oct 2025 12:33:48 +0100
Message-ID: <20251022113349.1711388-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251022113349.1711388-1-Jonathan.Cameron@huawei.com>
References: <20251022113349.1711388-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

Seems unfair to inflict the cache-coherency drivers on Conor with out also
stepping up as a second maintainer for drivers/cache.

Include the library support for cache-coherency maintenance drivers to the
existing entry.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
v4: Tag from Conor (thanks!)  Updated commit message to make it
    reflect the added files.
v3: Add lib/cache_maint.c and include/cache_coherency.h
    Conor, do you mind those two being in this entry? Seems silly to spin
    another MAINTAINERS entry for a few 10s of lines of simple code.
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968..b517f2703615 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24417,10 +24417,13 @@ F:	drivers/staging/
 
 STANDALONE CACHE CONTROLLER DRIVERS
 M:	Conor Dooley <conor@kernel.org>
+M:	Jonathan Cameron <jonathan.cameron@huawei.com>
 S:	Maintained
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
 F:	Documentation/devicetree/bindings/cache/
 F:	drivers/cache
+F:	include/cache_coherency.h
+F:	lib/cache_maint.c
 
 STARFIRE/DURALAN NETWORK DRIVER
 M:	Ion Badulescu <ionut@badula.org>
-- 
2.48.1


