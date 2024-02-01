Return-Path: <linux-arch+bounces-1971-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D047845C0C
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 16:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96782B23CD3
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 15:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718E3779EE;
	Thu,  1 Feb 2024 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="OcTC9QfL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uNT7zrOD"
X-Original-To: linux-arch@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DE3626AD;
	Thu,  1 Feb 2024 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802397; cv=none; b=qkaaKeF4AWai1LLUrejF2qnQezjg11WqhQqxmqWLwhUnFOD7NnIIQAcfGKhnKx9Fv+BWb+6KvNGgDlRAkhCV8KEU7SOo7fDTyiBPbQ7EvwnBZWF18UVUOK2OgBmgnaSa0jM6dLq80wsAsAtoCWK5ItJZ51HvKzYF7HgGrxSdb2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802397; c=relaxed/simple;
	bh=NiHFyPPrD5sK3tKmsstYY6GfrHgdKmJEsdk12grutnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H3HHm1D9Gi4OiG64Nw9YtHpa2/Nz3c5IyJk12L5D5R4qvdQBKZxehQc9rliphiH9yi3vP2nZ6xwfmj12oisQJXnvMRUAhUNDDe4onrz/uucydraRO5Dzh4Hn3NYr3OmcW0A2svjLO0AhxzQkhEGJf3qk+Crb1MyEqA0e3hyywcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=OcTC9QfL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uNT7zrOD; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id C35AC5C0080;
	Thu,  1 Feb 2024 10:46:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 01 Feb 2024 10:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1706802394;
	 x=1706888794; bh=i1v7gjbWYtUmewWLy9Kvlb4tyH5uqfyNj8gU9rtRY70=; b=
	OcTC9QfL162gZptSWEDjPWdZnEazNy9ME14ocM4u4Hqg32ZxHXv86zGSpg1ANxrp
	y85+SHbIXplcptG1iu9QbpHDlIeWxrmmNxDtRWQRjB+GrMNAXbg0gjdoyiRkzveT
	RbPTIm1lL940KAuRgcszRYHYUjqyGaeWna6/r4ikauCbuoxp9SZueRiDIsUfUTbQ
	lLFeaRdYgU+Iful3+CVSJnsV+NbWTarlf/iXjvb66r48+k+fLozytYBianvvo6wf
	WS/vAa3CAsR+79V2NZvjF/LS1Gzt7DlyZZxQzBe+e+yuZKWGY1CKyNnRRwLbi3u5
	QQB9Iw/7y92B4ZcU+gLr1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706802394; x=
	1706888794; bh=i1v7gjbWYtUmewWLy9Kvlb4tyH5uqfyNj8gU9rtRY70=; b=u
	NT7zrODxo1yyqBsfvZZE8jEgzkBEg4zm7mB0qJkNoo+cH7BOocaIMy8zJZoRIOhH
	46YaWAexAN5A0SHU+Rfm3Ga+RIGesj+AvHsz0inE1ZD5zknUM5MiLnoiUKSo8hYW
	TSlSu33ESAm+VxKElQ7IBNKmzEtc526+wJgLUTACSRkGAgBoHG6zOgl0ejytcCzH
	XliM963BvsNuxXClnE1HOhNEuI7kq+NkGrTIcqD4pUBTuoKnr/481Z8m2mTTRrYD
	sbr9mvEU3osslGFafQqC+ckc6J64sgiPUeGYa6SkOzJAs13dXdKKbe3cxijujbUC
	dvaqenrCgk/Gub5tGP4wA==
X-ME-Sender: <xms:2ry7ZdKtlIXRZot7X9ZGKlU7-_DL8uXKubDgvFpJ-Pu0f22wMUavqQ>
    <xme:2ry7ZZLKBhY6WIJKOoqCBTJZloXJsxMHwQUFSr8XRCFBev7HCNFlPmUPCG__2jGSq
    u84l5IErGNiZFq32KI>
X-ME-Received: <xmr:2ry7ZVvE28zjLYlQq6Pcy1yhIAtOcGs5B77wdKk3QEVcGYUPpYdLE1Xf9Dmy1GOQ_gNxCM6e1aMH280ockOaBbpJlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
    veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:2ry7ZebIw97Epslg-glR01lUqnm72dyQBJMZ2WJ1TFAs1F6ek9IlHA>
    <xmx:2ry7ZUbyJqT6ArZ0btBJU0Kn7dRk2LvXxwIL9agOUwn0mh1GCk_T6A>
    <xmx:2ry7ZSCorm_Td3Zb0eNP9f2JCRaoyHVSlPB2bJk8cCtnNpnSNDdrlw>
    <xmx:2ry7ZU4d4CHS427h5V71ZJh0OFTZIEpCUompl9ISTPB4tspuqOJ_LQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 10:46:33 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 01 Feb 2024 15:46:28 +0000
Subject: [PATCH 2/3] MIPS: Clear Cause.BD in instruction_pointer_set
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-exception_ip-v1-2-aa26ab3ee0b5@flygoat.com>
References: <20240201-exception_ip-v1-0-aa26ab3ee0b5@flygoat.com>
In-Reply-To: <20240201-exception_ip-v1-0-aa26ab3ee0b5@flygoat.com>
To: Oleg Nesterov <oleg@redhat.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Ben Hutchings <ben@decadent.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=860;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=NiHFyPPrD5sK3tKmsstYY6GfrHgdKmJEsdk12grutnA=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhtTde64yuL1SSV4UOF9DePOkzgsnGSd6LJDLjxSMtNtSb
 F0aeTKso5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDaEi1MAJmIdxMjwTTn6ttlZ/av+3xp3
 Pe7ZFsP1s/eGc6bPToN79bsYuU7OY2Q45vFTKG7j7El89pddzOYxbdN/9LVUT2PVZknNzeInBAo
 4AA==
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Clear Cause.BD after we use instruction_pointer_set to override
EPC.

This can prevent exception_epc check against instruction code at
new return address.
It won't be considered as "in delay slot" after epc being overridden
anyway.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/ptrace.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index 97589731fd40..845508008e90 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -60,6 +60,7 @@ static inline void instruction_pointer_set(struct pt_regs *regs,
                                            unsigned long val)
 {
 	regs->cp0_epc = val;
+	regs->cp0_cause &= ~CAUSEF_BD;
 }
 
 /* Query offset/name of register from its name/offset */

-- 
2.43.0


