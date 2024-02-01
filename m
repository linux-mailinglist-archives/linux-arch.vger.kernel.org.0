Return-Path: <linux-arch+bounces-1969-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4777B845BFE
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 16:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692901C235F5
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 15:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEEF62178;
	Thu,  1 Feb 2024 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="QJcbaxYI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vRaxLOy6"
X-Original-To: linux-arch@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A85626DF;
	Thu,  1 Feb 2024 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802394; cv=none; b=qBUxSVVoaieF+7YAYgPJFIFptRRITMQFjWhHJLa2uWtXore6ULBZTO+0trZTYXPH3DOPYe2pW1MDvcd6N0DJYUL1jqIb3fP947cyFisHbX5QI/v/4U7EcQaUcuoha41FycK9CLPRCCvtiuPQcJc5h1Ca8Wt6uIGxlsI3FdA9wSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802394; c=relaxed/simple;
	bh=8B90B4rDuiui0E6UinfX3ZgtenzPM9teCiqi4K4psi4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=omH9SD3CRslPir4Wifprc8cPA1WXOqAiqN18BYJoYHhfudYaGvGoWAVUlXDxRi0EmLFB3wrKFLkTV+WqKMAS6qPenuF80eYhzXMguooQrOWDBm6kvRc8QhR1KpXjTiaTjueBJpK9gv7KzGryUPicfmnbhmGGxiihrpc2gcDPsC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=QJcbaxYI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vRaxLOy6; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id BA7165C0195;
	Thu,  1 Feb 2024 10:46:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 01 Feb 2024 10:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1706802391; x=1706888791; bh=hJ
	rBUU7pkBW3DKm9qlUbvAWbauW3jW5E3faoXg0oEwU=; b=QJcbaxYI3QPsZ2CVnt
	cbB0rhi5RyG8LrtaN1th9lJ3zUkk34jrHZXWEl7PBa2RSSeswnJ+darRjq5+W0xZ
	kzsEuHIZsInDWaxWZAPLtiUP4dT6EnvMJp68qzJc5hVRpMnhOG3gp/oe0Vc5QwEK
	gsqZmrdmqvmRVXWL7wK0mdZnEr5XbFvNyuHRcumVAZoS+FoYwhtH092YJsZQXt2c
	hfejBHa7CT2l5ozL391ztsR0C3Vp6aAxMxY9denmh4lX56M2YdQAm6BgtOBRNbY3
	DccLcuFi4vJ33rQp8jDf/kam+9Nhvmnw27X4VnekvYZohyyPNcx6taxZdgni658h
	WbgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1706802391; x=1706888791; bh=hJrBUU7pkBW3D
	Km9qlUbvAWbauW3jW5E3faoXg0oEwU=; b=vRaxLOy6RLcHIj5Wn080Pi8nMo5Av
	y6iFYu7UmppjBd+K9yrYWZsC3g/sq5e2CntgvP/FWmnRV/W3zosZ628ZUCUFJju4
	Fpam2jzbzvuWr4qDJeHoSImvzA4FLq4xDKK/pRkpWSn99xzWmBOTVDSDO+dit8Wh
	N2afrHCEunwUtUMdzgWmaBfpzF8aulfcDv8SrmvF49WT1Hf4GSGdpTLTRhCvV/Tv
	hSFtjlKNO2k1x0yn7EiV5WAyXxdPDH8XynH2HcR6pBxBW9RY6SyGInku9ml6gxAg
	VovmnUu4iflNtrbUTV6ORqohZbyM7PnOdhYTTTYJJADjaRzFH1Lvrn2IA==
X-ME-Sender: <xms:17y7ZcHZfCX1KAiKGB-ctsMVRfuzSdqwstRs68x-Pfh81f3QoNvGCg>
    <xme:17y7ZVU5roU_X-4wMZuaMQ5HcTokgnr5ilyb9oIO0h6y6RHeQuUIVEvONYS833_UJ
    3yi2mBqhd2Cqa_in70>
X-ME-Received: <xmr:17y7ZWIfbfoEgBtvDw2KEGpzqM_c9WpsDSoQM2PTbOt_tWN9bnggDYlQWvu2DnTxMUFSqRFBQUYFHKyof6kTifqQew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepgfevffejteegjeeflefgkeetleekhfeugfegvdeuueejkeejteek
    kedvfffffedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
    lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:17y7ZeHU49ll_6kkFQUAk9_h62oTDCxPt5AqqijfkNXSFjz4ZupCYQ>
    <xmx:17y7ZSWO8xAWfy0tEtGINB-co002jLBR4s2BoLWmeW4-mRz_nbZ3rg>
    <xmx:17y7ZRNga6qerSc4WElUyKjSfXWyMsvXOPPPFfJCwjC83HFyw44jiA>
    <xmx:17y7ZeTviw0gA5wkUZCCYnv34A2ZwmT_fb-UwirlQEJfP2ZBY-eCqg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 10:46:29 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/3] Handle delay slot for extable lookup
Date: Thu, 01 Feb 2024 15:46:26 +0000
Message-Id: <20240201-exception_ip-v1-0-aa26ab3ee0b5@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANK8u2UC/x2MUQqAIBAFrxL7naAlQV0lIkRftT8lGhGId2/pc
 2BmCmUkRqapKZTwcObrFDBtQ/5w5w7FQZg63VlteqPwesRbrJWjMqOFdUFj8I4kiQkbv/9uXmr
 9AHlP29teAAAA
To: Oleg Nesterov <oleg@redhat.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Ben Hutchings <ben@decadent.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Xi Ruoyao <xry111@xry111.site>, 
 Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1962;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=8B90B4rDuiui0E6UinfX3ZgtenzPM9teCiqi4K4psi4=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhtTde66eLuV5d7XK5sbbAinu/1bGLReadl7iOl618vwGk
 W2Fc5bqdZSyMIhxMciKKbKECCj1bWi8uOD6g6w/MHNYmUCGMHBxCsBEgjcy/FPN5rJkzftgsers
 0eo1VjJHLjsu/lRkuiX0gML8inM8jjKMDFtEZ97qiz4n1bXolZXwmUtsVguOqK33VjhZvyEmvOP
 PLGYA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Hi all,

This series fixed extable handling for architecture delay slot (MIPS).

Please see previous discussions at [1].

There are some other places in kernel not handling delay slots properly,
such as uprobe and kgdb, I'll sort them later.

Thanks!

[1]: https://lore.kernel.org/lkml/75e9fd7b08562ad9b456a5bdaacb7cc220311cc9.camel@xry111.site

To: Oleg Nesterov <oleg@redhat.com>

To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

To: Andrew Morton <akpm@linux-foundation.org>
To: Ben Hutchings <ben@decadent.org.uk>

Cc:  <linux-arch@vger.kernel.org>
Cc:  <linux-kernel@vger.kernel.org>

Cc:  <linux-mips@vger.kernel.org>

Cc:  <linux-mm@kvack.org>

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (3):
      ptrace: Introduce exception_ip arch hook
      MIPS: Clear Cause.BD in instruction_pointer_set
      mm/memory: Use exception ip to search exception tables

 arch/alpha/include/asm/ptrace.h        | 1 +
 arch/arc/include/asm/ptrace.h          | 1 +
 arch/arm/include/asm/ptrace.h          | 1 +
 arch/csky/include/asm/ptrace.h         | 1 +
 arch/hexagon/include/uapi/asm/ptrace.h | 1 +
 arch/loongarch/include/asm/ptrace.h    | 1 +
 arch/m68k/include/asm/ptrace.h         | 1 +
 arch/microblaze/include/asm/ptrace.h   | 3 ++-
 arch/mips/include/asm/ptrace.h         | 2 ++
 arch/mips/kernel/ptrace.c              | 7 +++++++
 arch/nios2/include/asm/ptrace.h        | 3 ++-
 arch/openrisc/include/asm/ptrace.h     | 1 +
 arch/parisc/include/asm/ptrace.h       | 1 +
 arch/s390/include/asm/ptrace.h         | 1 +
 arch/sparc/include/asm/ptrace.h        | 2 ++
 arch/um/include/asm/ptrace-generic.h   | 1 +
 mm/memory.c                            | 4 ++--
 17 files changed, 28 insertions(+), 4 deletions(-)
---
base-commit: 06f658aadff0e483ee4f807b0b46c9e5cba62bfa
change-id: 20240131-exception_ip-194e4ad0e6ca

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


