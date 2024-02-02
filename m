Return-Path: <linux-arch+bounces-1990-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4575B847057
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 13:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C7A29506F
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 12:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B288E144631;
	Fri,  2 Feb 2024 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="KPCaY3+u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yPVF2ep6"
X-Original-To: linux-arch@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0876E144624;
	Fri,  2 Feb 2024 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877042; cv=none; b=QrR/p5Ii9vUhOem+mKTaAVGUWV7TcThpN/L3WQqkSPDC6xyVOKwb1w12e+J3ge+hOLB2asR0DS4IVyD7YjxwUO6HTd5gQcgfLPKla4TGu9Rq4PO2D2TC+mXY0c2dM7Xt24ceUKHuteCiWYQ4Go8uccoHVLBbNPtE1SYqZluKFfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877042; c=relaxed/simple;
	bh=eEckd5oJQ3BVb3TI50bExWCbMqs/5XPSjzMz9OXoNmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uKRvbo9xfnaECIYJ0xjdS3yZMpX/Efrgw5sXqpTTrvvQOMveQylOfSbgW/p5GNIU6PzO/6ka9lh9d2pSVmk9QrpPG33l/R5blPEqMFvce1WxwBZLzs+GCIw6cOxeuRYmvjqmTfhDh3j8PCgVqIwG7M9rbTEHdlWo9uCpTPAvOUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=KPCaY3+u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yPVF2ep6; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 00D0A5C00C0;
	Fri,  2 Feb 2024 07:30:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 02 Feb 2024 07:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1706877037;
	 x=1706963437; bh=w2r17fGseyKoUkYg1Q+CG1Kwf5xRgoFxjWp3QiPCMOY=; b=
	KPCaY3+uIJ73xN9kmYWwqgB93DBfywxqEdTVF6jc120MMGM0qem41ii6ITXekWMz
	VBrSyQbOQFobNNMOYtJbqvUhxmtWSVWUogeU9JxxLmq05JvxZetbuaVM8hFwtZc7
	B+dlZAVTfVuWDfXAy6QGqW6YSij16X4jDd73BiueETOXlSy2csX5Su4y+mBe6Zue
	FDZIj8Mk8xs4vvI5W7S86b8zCJauqXvPqpGTya19/yJvq6dKYZb1UvcYAbflthp9
	2Su/6ZEeuTXPGiTorKVckNAGL24Jk3/kE/y84EUkHooM9TkQQjIHzagTBvRaad5M
	m2bsiZJgHM3sTlhiUx3AYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706877037; x=
	1706963437; bh=w2r17fGseyKoUkYg1Q+CG1Kwf5xRgoFxjWp3QiPCMOY=; b=y
	PVF2ep61M5MoWsoGtC6vryilWqWoSPCuYHTkRIUxkp2m+XgU2WglQGeTgqMRkWen
	z3n/xeXDSYWxohz/3+6PfCnngrXxukbjVlgRq/M3TbTRhIytfk3C52Q8reQIwY8Y
	LhlxM1J1GBRMp/5yY34id+Y/jJyXHDFlIlQBTxxvsK3b/y3sZ1oWp3d4a0ZCGQBd
	mhawXZ3huHsn/FEiDGAcrMNf/6j2mYVmMK5GbdhWDvMmIja2QU72CFCs32FpS54m
	c4y9+s/rCgzw3TAy1OwJ8QsuYM1UPwOcZ8zjmbL3cQNTtwI77TfFYR1dyB59Btly
	nIU18gB2KMbJuwqTFfCsg==
X-ME-Sender: <xms:beC8ZSS9vgNrVs-Hvq82_CG87KfVGjMgjClvvg-9JnosgFFm_cn8zg>
    <xme:beC8ZXz8StOt_t-l7V58i0P4ZiCOSH6iMH-iLoTNJNuhb_fLuPzK8LZR0DyK-sWad
    qOY8VRFfoxoaoLzilI>
X-ME-Received: <xmr:beC8Zf1AdZciTpZB7LvtHMPQI6YTzogHyxj0T-mff9W2B776ZmnBA5SINvzxo325x8UfKsq3cHUJdXFiBowYJ-n0Zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedugedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
    veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:beC8ZeBlb2n27dINsto1uwELIsIlvuV_sUhwwj9pqak7va1ogJIdIQ>
    <xmx:beC8ZbhkuWBdmrfyG_WPT4eWPuNjqTVOd3uP6cW9ewFPiEuBZXdcBg>
    <xmx:beC8ZarO86mYBvc-swgrf3yZyy5wysSV31Kzb3dP_IMZ1tDBhZzYtQ>
    <xmx:beC8ZbidnBaNgShomJ5CCVAgU2mnr9vmDVx5ibPZlThb2a9ReQoM2Q>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 07:30:36 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 02 Feb 2024 12:30:27 +0000
Subject: [PATCH v2 2/3] MIPS: Clear Cause.BD in instruction_pointer_set
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-exception_ip-v2-2-e6894d5ce705@flygoat.com>
References: <20240202-exception_ip-v2-0-e6894d5ce705@flygoat.com>
In-Reply-To: <20240202-exception_ip-v2-0-e6894d5ce705@flygoat.com>
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
 bh=eEckd5oJQ3BVb3TI50bExWCbMqs/5XPSjzMz9OXoNmg=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhtQ9D9KbxBb5s2avMMxZk/Fa1OTF/ICgHV78MjaFTJtvf
 f35OXBNRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEzE9Dsjwz6v/vdH3Fze1/99
 FOW6+OMuxxvHUq8msNTf6zrBPE9PsIThr3h4jgr7uXVaRkt3sXl2P3nPWfRUcFd+muzkppu3Vhz
 /zQAA
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
index 701a233583c2..d14d0e37ad02 100644
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


