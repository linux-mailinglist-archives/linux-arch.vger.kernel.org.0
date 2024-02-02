Return-Path: <linux-arch+bounces-1993-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C7884705F
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 13:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D192B293C4
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 12:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12A4145B14;
	Fri,  2 Feb 2024 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="MZV4wMb8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PFwE9yHU"
X-Original-To: linux-arch@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44E9433B9;
	Fri,  2 Feb 2024 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877044; cv=none; b=pM0zzrUiSv6DEMTaAlZrvAcnaZXVb2+QumKvhky1vTgDqDEt4ADaYounMr+CTv86MuanI6Fo4fYxzWRf90Q5wCmvpsEoPoAWLSpDldRFrYwjM2rNKk4lmYJUJRAnRPdkyzipdYGs+N4NPrASFuBEC4ZuxkkPW3kJeos0QLEjvOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877044; c=relaxed/simple;
	bh=pGqKeHOWkrrdSTGrMykY9rjwN9Hvy+fpNB0uLbEruW0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nUBMGfnh5j1n2KsKF6NYmzS17fafNxRuZ/IOQ+EnkGkZ4QesAnsoLHxngqlBs0luhmH2eFbC90ZFV50E4y7KkpQhArTrTNu5cJkqxWOGUCt4Q3WUNkmjC2+qLYT3ktOPmfwBRZSZ6gKK/Ymolm/3C+SXkx0kXdaCQKK2437VhE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=MZV4wMb8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PFwE9yHU; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id B35FB5C0172;
	Fri,  2 Feb 2024 07:30:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 02 Feb 2024 07:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1706877034; x=1706963434; bh=yR
	uTU6WwnK4ASnLLJJkZtTcbcg4dpQfErooMSebUGYI=; b=MZV4wMb8fDxCIy14Hg
	XrOXP9hayqNVHIn6LVzBCsDTLZQ4/6P5YWFrjNLcrcDioLZHFItwYbDwS4zY3bKN
	md4GJ0OYkgqQfiVpL7cnqKCnJY2dj4P4zyg5gje3R3hljYr/+rtFR0eh40ixiDqQ
	gbQdRVgcANZTa5BLzu0zFvRjLyH9oTl/pi3LtWKmtVyV5laYtETmc1VzQe6JWFFB
	uCtXjswYTCCS1A+uUOvia0ukE9Oh9lZzW0WlTSpK1IyG5g/8UlyNaSfTBttY3mn1
	l8CgIf0XxuPmtUNGCnY7dlpNJYnuRnpHlFFPooWX9CdyrsLVdiml81HUqasLJjNr
	jx9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1706877034; x=1706963434; bh=yRuTU6WwnK4AS
	nLLJJkZtTcbcg4dpQfErooMSebUGYI=; b=PFwE9yHUFdVOGhRcB+PN/twkCb8qa
	CT2vTPaqjAqbwxzFY1BRJYUKqk1rQq71oAmHvZzcjRnfoBzbx4jyPrBOkr8c2eSK
	JEpO5uYcM7w5zI5h7Yg1LpdRIN2F2vKo6dcpKE+jUl2TbvONuRPQlr5Y1axA/oKv
	/t2m8v7TA4dALlwpja3C8oXyMDImJcFuuyystXr5qEUuk9uXIUN6cYri28GYE9wd
	fp+k15mOWcqBH11MCgALjCsmC+fnd5CVKwm4V/UiFTovT0mPK4L2OENRp2GEMI0T
	ZWahw1f+PlH0AQKvlrw0QjGgqBqFQijjynVYEo+K8YX2r/mNKMI3X2iHg==
X-ME-Sender: <xms:aOC8ZR2THUBA0oAJdPJCYig1GxLTLHdymPi8026KD9piA8dte4Z30g>
    <xme:aOC8ZYHNdeuSqIwaJtZDhvwJbDQeRNotrbtcT8BxbMAUPsvv6BzTJBjng3b4B9tde
    l1WSe009lw4mIwicSE>
X-ME-Received: <xmr:aOC8ZR6-FmBcYPJmYf7-Qu-DnAlQ8wp3MSGJatIhKRgYgAOA4Kmemh1bVcOGnZOCwpaAHVJ1in6G0x0n_53h9DPS0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedugedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepgfevffejteegjeeflefgkeetleekhfeugfegvdeuueejkeejteek
    kedvfffffedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
    lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:aOC8Ze1SCeXfzkiTMkk1GdIrrtNLURJG2McgcnoNHiPZ1mPTrm3oZw>
    <xmx:aOC8ZUEBORqqQJ5qH4tGuVN0NbAfAHqdPDRSMaM_fCMeg04wGqsHTw>
    <xmx:aOC8Zf-KOGgTJjmVPVHlquKgKgDo-z6DOf8OM2rHQfXfLYHL3Y6eCQ>
    <xmx:auC8ZfAIfcoj686uYaS8vQdkIPFDbGn9FtPWovQLe1aSbHoUkA9Xqw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 07:30:31 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 0/3] Handle delay slot for extable lookup
Date: Fri, 02 Feb 2024 12:30:25 +0000
Message-Id: <20240202-exception_ip-v2-0-e6894d5ce705@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGHgvGUC/13MQQqDMBCF4avIrJuSxFRoV71HkTLGUQdaE5Igi
 uTuTe2uy3+Y9+0QKTBFuFU7BFo4sptL6FMFdsJ5JMF9adBSG6lqJWi15FP5erIX6mrIYC+psQh
 l4gMNvB7coy09cUwubIe+qO/1B2n5By1KSIGoG+xqItld7sNrGx2ms3VvaHPOH0aPv4mqAAAA
To: Oleg Nesterov <oleg@redhat.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Ben Hutchings <ben@decadent.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Xi Ruoyao <xry111@xry111.site>, 
 Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1507;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=pGqKeHOWkrrdSTGrMykY9rjwN9Hvy+fpNB0uLbEruW0=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhtQ9D9JY1ZN+2RmLFb5hZLfOsy+9bCvKkvriW2thfXnT7
 /uJfxw7SlkYxLgYZMUUWUIElPo2NF5ccP1B1h+YOaxMIEMYuDgFYCJfqhn+cC75k3JAd+3LKVvn
 usV8ZJSyFj+8/pj27Yc2Zsps75JyUxkZmu2L7j6x/vtZ/aOn9yvl/du1WNX/Fa54pckROm/mR7b
 rnAA=
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
Changes in v2:
- Reduce diffstat by implemente fallback macro in linux/ptrace.h (linus)
- Link to v1: https://lore.kernel.org/r/20240201-exception_ip-v1-0-aa26ab3ee0b5@flygoat.com

---
Jiaxun Yang (3):
      ptrace: Introduce exception_ip arch hook
      MIPS: Clear Cause.BD in instruction_pointer_set
      mm/memory: Use exception ip to search exception tables

 arch/mips/include/asm/ptrace.h | 3 +++
 arch/mips/kernel/ptrace.c      | 7 +++++++
 include/linux/ptrace.h         | 4 ++++
 mm/memory.c                    | 4 ++--
 4 files changed, 16 insertions(+), 2 deletions(-)
---
base-commit: 06f658aadff0e483ee4f807b0b46c9e5cba62bfa
change-id: 20240131-exception_ip-194e4ad0e6ca

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


