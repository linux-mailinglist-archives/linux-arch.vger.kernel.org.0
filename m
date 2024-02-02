Return-Path: <linux-arch+bounces-1991-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 254DE847059
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 13:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895A61F22B09
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 12:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8433145B0A;
	Fri,  2 Feb 2024 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="mNL2+pa4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cq4Hswe3"
X-Original-To: linux-arch@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3076145345;
	Fri,  2 Feb 2024 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877043; cv=none; b=MLSatz3zxBFOOTT8UkAeOakQakHpX1MeeKEJhS4ZTmmnYX+maD/1zwy2eaJRHm3TdApWOYURcj1HYBY4tVpByiWKVeFLaklKBekesNbIm4MZ8IQ1ohhuc7/9fIeH06UzywqO7Al8Tcfehv1KsZ0q0hObt8o1QNdecb+nFrRJZ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877043; c=relaxed/simple;
	bh=uKuLCoMYm7TN/5FDEmNqhpyC6JKJvRlQkX2qQKN8ZTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kL6WVmxf6wG6+IjQNhPZr1Gq1Cuc7CKUVcV9Kzl38G83DHlQL6kO6ni37pDmfn8w5jORzLewFiCJF8vvlOonhYy60wO7kHUC0BQiY18SLp1FAsihFC594aFGnSWn7IUzeeU2uU7IZhiwGIfDstx0USyiN5Pm/+hc/ShLw2Yf9sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=mNL2+pa4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cq4Hswe3; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id E94335C0180;
	Fri,  2 Feb 2024 07:30:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 02 Feb 2024 07:30:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1706877039;
	 x=1706963439; bh=PkffIQ/TwdfU+2w1YXK1H3DJt1XQppKKQHpkyIAY8Jw=; b=
	mNL2+pa4mBLckcf1YJNeLqeEfEkNIjSaMXoe0/FrLp02SzGJ1t3KLW7TQO9OrUXc
	gptTiPkf6xEJzcFsrJmmaP3fCsUyMqC7xRA+KTwybjnLjZRd0HzgwV0Hpw2bMevY
	DQ+bVp6Wcbe2sKmiK7UhkyRCrq1BPPCVpVdSbfPG+667OCbV20W7ydPsxLBgVJMH
	PVwxt+msm8xw2LScDcgmsw9zYJAtlnk2NZIT8KBu45qMK6XCj9Zu+luAq6INNCTz
	MKRctK4ygm6lXXS8eruWRjzvu8IRq6ynqU9WCHZjFBVUj/OjDLAgRPoGsOVl8MQv
	ymUfDDIqKWIrUCROGYDowQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706877039; x=
	1706963439; bh=PkffIQ/TwdfU+2w1YXK1H3DJt1XQppKKQHpkyIAY8Jw=; b=C
	q4Hswe3VCvFGloX8BaUea0BX+Tdp6jIWtdo/NcLMOZ56e2czWHNGBPkiuQbNdzBb
	HBcnE/O0bfvlN2FqY6HlgqPif8XK2+JNKeADBQsfNLfGp3S7Sp88DXOuv7KROL1M
	qxYc/MyR+MFHX78qRaPRY1BTHlQgtAwnrxD4cVxCo6jpNlPMqWNmYWKx0HxbUh3V
	wtwSxtMqXbBHWYzIW6RDV58pXcBTsqQEVKXe3gt3wkwFWhOl69ipCtLw8ErunLPu
	rjLwCcAM/gYCPYwRX1+qpa/wHGqP1JVs4qH6fUfdd60GVpbNtxrx+5sCKB6OCqeW
	pPmUmusVQfxGge/Nohhaw==
X-ME-Sender: <xms:b-C8Zbq6OSX2fhwIS1gNipPpCFQw8hyVrN5ITQDqYniPwCTbZqRaog>
    <xme:b-C8ZVq5xW5XfaWS5VlRW0rzPTppkfRzGxdaRkTi_L0xtprUwFFaDRcQHkpoWYden
    JoxQ1vmQRFUgh6_u0U>
X-ME-Received: <xmr:b-C8ZYMfD7GzqxdWKV-zChEdqmHnHBsFUXK16ESvB8di7H3CGXW-ilYDA7HXyy3wcAieMxUf-Xqaz3ukjgR2bMzPAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedugedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvedujefhfffhveekhfffkeetvefgteejkeeutdduieehieeg
    feejtdelveejtedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:b-C8Ze6IZ-USR6eKEGNOWcDXyDjbN4ICUvO_1T5p5H7CybjQ_wiFqA>
    <xmx:b-C8Za7lxo1PRGt1vildzpsMrmTHm2Xdqq3PGci2KeaV0jA7jVanJg>
    <xmx:b-C8ZWi7WDHjVX3u4I0qExPssNNTyJlBuuglLV-5E9Jmxg0QsBNwwA>
    <xmx:b-C8ZTHBSHd_lgqRI6KaVaN4mspPG2RVmhCfI79ib0V6fvhjIV_ATw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 07:30:38 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 02 Feb 2024 12:30:28 +0000
Subject: [PATCH v2 3/3] mm/memory: Use exception ip to search exception
 tables
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-exception_ip-v2-3-e6894d5ce705@flygoat.com>
References: <20240202-exception_ip-v2-0-e6894d5ce705@flygoat.com>
In-Reply-To: <20240202-exception_ip-v2-0-e6894d5ce705@flygoat.com>
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
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhtQ9D9I5oxxuhtd5FaqYPUoS1m9SED32vzE+yratNz1t6
 f17PZwdpSwMYlwMsmKKLCECSn0bGi8uuP4g6w/MHFYmkCEMXJwCMJGpQQx/xT/dPrVBSu154PLX
 /HJvTZJnd/7847ilbPm6i5kqQk9unmX4yVh5i+20gXjQviW/jx/ZZs6cUhVptrg1LabUvf/G1MP
 JLAA=
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


