Return-Path: <linux-arch+bounces-1972-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C10A845C08
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 16:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0ED1F2441F
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 15:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF5E77A10;
	Thu,  1 Feb 2024 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="ogNS4GpH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zv7vFK8h"
X-Original-To: linux-arch@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7509B779F0;
	Thu,  1 Feb 2024 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802399; cv=none; b=fJuAwlEkqOBb6YIzF51rrkpYw7r9xTxbO5iDAyXk6JL2gxVhsLN8VUoNPlEgMYdnZ72jQHRUBZ6tF5vA7i6+otdzZkGRZLTZRW5R0ucbVdfVHkGBfG9VjxpIt25dPH10jMcy5Aub//gf+ZGWqPJrHOZPOGDwlwEQ8a9mraCaHXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802399; c=relaxed/simple;
	bh=uKuLCoMYm7TN/5FDEmNqhpyC6JKJvRlQkX2qQKN8ZTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MIhRhE0FoY2P+q9zLoHm2mLv2bgHHhQffd2ZYNp+9ENU4LIYdc8IBaCvB9hDXXtmOfqL9BtBx1YubaeEuWfsMEwEeCxQ9fAtiYT/d+N+VPltNDdP8tHKo9th1SDjcCivFksJ30to78rKq4Q09vXNlzYMMQQ9fXK42dcXLUbLee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=ogNS4GpH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zv7vFK8h; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 751975C0143;
	Thu,  1 Feb 2024 10:46:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 01 Feb 2024 10:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1706802396;
	 x=1706888796; bh=PkffIQ/TwdfU+2w1YXK1H3DJt1XQppKKQHpkyIAY8Jw=; b=
	ogNS4GpHLOaAi26YwvNGDn2O/lkVyJMCKH4ZLzdYBxvNF4Ghg+1pAS7N+7fe3PEQ
	F7U03j5yLZfBYr9bPyahFksuvY7GaYExKi0iBKAc8Hk6GqnizcaCLXyAFLCCEpXC
	AAX9DKxr/ZwxJ/FdNGr01oFM0sW6gRIyxhTkq99EulTm4pDloXDVGC1l89ZwZMfa
	F0CbBoftKcYqOXwCkLZwhPJ644yqZJelFRqgAxGz/uHR3IC9AFTai5ARHwqX/O6I
	u8HtBisIX2VLfLBtkDclhJkOx4RmpCqYQdmcoDHGINyWL/BIRP/bp98GL9AcfQmL
	IZvC9hNk77GCvSkpwET2KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706802396; x=
	1706888796; bh=PkffIQ/TwdfU+2w1YXK1H3DJt1XQppKKQHpkyIAY8Jw=; b=Z
	v7vFK8h6WyGCZO+fTEtv3JQhFyhoWTvILxwV2NRWBdSK1vdjFMCVXW2GwTXx/GZZ
	XBQSt1aqtTonHlvkFoOhTh6d+by+aReRfLMNARK8312ZdUbnzZyEGAOBjRIBuxU4
	85NXS0HATkVvRpxYb1G0zp3NZ3ADGDRYaccdGeb+vffRs93pvjIqx6nUiTt1D8ny
	mGqzioXUePtDNS6HeWHnuUFkgFl6gJVgZVx4Xm2hSgDAQ73Bo/964MVd2/gTVo4Y
	FZD/yYJhMTAISTPGoUIid5krD4B4xst1ENOGPHMZ4I/j+rCYGPriAtVs9JD3RGG5
	/I4/Hl8vvbpBKYCMxpSRA==
X-ME-Sender: <xms:3Ly7ZegrwF-HGZ-4D3_2DchrRtSBqLg8IdG3M4oYhlU6jNcAHxPHpA>
    <xme:3Ly7ZfA9G16qXg6zutH4IVp_3COSyhS4eGQpcU2dqVDLL185fjRdyZYkwwx6fz9q9
    bEPsj8Q49i6aTFshCI>
X-ME-Received: <xmr:3Ly7ZWFX37urArgNuBeig6_wHReDpa64NJX_UOR1Ow2_m7knqA2Fez1MU7FwlpJ2GOKy_cOmghz8Tr8XCRF5QFiYkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvedujefhfffhveekhfffkeetvefgteejkeeutdduieehieeg
    feejtdelveejtedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:3Ly7ZXTG6JY7EqV_vQHpNTdn8JAWolp4FpWaS0BwBoYuALnLhDL1IA>
    <xmx:3Ly7Zbx7nCr0e0h_WMXgSs__cM2lDlHnHbfWedr3XO33Pwhh71QAhw>
    <xmx:3Ly7ZV4zAlY1TuSm84sx_hlSG-A2k-VHIfJbdE3Ukkk3Oj4pMSOFUA>
    <xmx:3Ly7ZTdsTKza5t_N_SYFom1zppPyDQto2lhv-P1gCKTa4jBo1b9-bg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 10:46:34 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 01 Feb 2024 15:46:29 +0000
Subject: [PATCH 3/3] mm/memory: Use exception ip to search exception tables
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-exception_ip-v1-3-aa26ab3ee0b5@flygoat.com>
References: <20240201-exception_ip-v1-0-aa26ab3ee0b5@flygoat.com>
In-Reply-To: <20240201-exception_ip-v1-0-aa26ab3ee0b5@flygoat.com>
To: Oleg Nesterov <oleg@redhat.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Ben Hutchings <ben@decadent.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Xi Ruoyao <xry111@xry111.site>, 
 Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1379;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=uKuLCoMYm7TN/5FDEmNqhpyC6JKJvRlQkX2qQKN8ZTg=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhtTde672x4SsrfVewuR6t1Nnmlr5QtH+q/m1zqculPqee
 +n7amJERykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEyk2oHhn8q3ba8O6dkcYv32
 cfqJCbVLm8pE31xT/LY88sIrTq7Li2cw/Pdfnj5VT79IOtfx81mrjQXq64WdoqsvPp4d/UHlQPI
 XQx4A
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

On architectures with delay slot, instruction_pointer() may differ
from where exception was triggered.

Use exception_ip we just introduced to search exception tables to
get rid of the problem.

Fixes: 4bce37a68ff8 ("mips/mm: Convert to using lock_mm_and_find_vma()")
Reported-by: Xi Ruoyao <xry111@xry111.site>
Link: https://lore.kernel.org/r/75e9fd7b08562ad9b456a5bdaacb7cc220311cc9.camel@xry111.site/
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 mm/memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 8d14ba440929..49433612444a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5481,7 +5481,7 @@ static inline bool get_mmap_lock_carefully(struct mm_struct *mm, struct pt_regs
 		return true;
 
 	if (regs && !user_mode(regs)) {
-		unsigned long ip = instruction_pointer(regs);
+		unsigned long ip = exception_ip(regs);
 		if (!search_exception_tables(ip))
 			return false;
 	}
@@ -5506,7 +5506,7 @@ static inline bool upgrade_mmap_lock_carefully(struct mm_struct *mm, struct pt_r
 {
 	mmap_read_unlock(mm);
 	if (regs && !user_mode(regs)) {
-		unsigned long ip = instruction_pointer(regs);
+		unsigned long ip = exception_ip(regs);
 		if (!search_exception_tables(ip))
 			return false;
 	}

-- 
2.43.0


