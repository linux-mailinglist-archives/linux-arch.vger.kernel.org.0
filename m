Return-Path: <linux-arch+bounces-3497-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1189D89CB0C
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 19:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23F0288C24
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 17:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8347B144D03;
	Mon,  8 Apr 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaTuN8fN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452C114431C;
	Mon,  8 Apr 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598587; cv=none; b=dZrCj2HLWzXf89B0uOHmaSn+WKwJEVDJy90GeB226ePmjeENnT3xQJfOeO6BIvwEzMS0JmAAmD8UGRNU0MZR677mKCrJL8h+Y6Rfj/iIEo002fFvJpYI/+wCLKIXyOOg59q1yipP3R22W5ruUTX40q1zTg8ADH/XY3fbxrTna/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598587; c=relaxed/simple;
	bh=JQmLzMtBpKC/TtfERldphRZSepAv95vPmjK1jOVEaZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gr+TQClgVwNxIJewvrQ0o8i24svb5fhwoXOjkwfyonahoVrsF00drVxssSGyFfhaUinKNu9kPvVn1aDNtx7hlrN8PkAKnIi245oBtZ0rcA83LCYoi4uWLi5ibZpF/pddIf3Ur8sxbHrFFTDTokNKAhuCa9oBpyMQU5Dpx6EOXVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaTuN8fN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE318C43601;
	Mon,  8 Apr 2024 17:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712598587;
	bh=JQmLzMtBpKC/TtfERldphRZSepAv95vPmjK1jOVEaZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EaTuN8fNI0+WZ62ylMY5dtBA33Pfm7uJAF3/3+yfk5Zo16QAlWA8dH8RV94LQTAcB
	 /TCbzXBUNABV7sW6dZ4fh1hiI08jTyXC0FqnoonimRb9h8uRLZEVvJGtfCdXDyJ9Mg
	 FOxpgXWzr43xO1S4Xgo5fKP+fhqrZWy9YfU8jRmqINHdw4J/AJ3QTAFgOwPJUFVz8V
	 Xm9zngLOHXi0nSHh71nhcRmYJh28WgQz29EYvoSljw700jTBJma1QDjcjSmy9DQRip
	 QtArN/yxzD8mP1hkGIf2ofhq9GxDfEJNfcTiotgQNBwuZ9W2OSQHandTmih2gLhWNJ
	 F9bO+7hcgEFWQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4CA58CE2CCC; Mon,  8 Apr 2024 10:49:46 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: elver@google.com,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	peterz@infradead.org,
	dianders@chromium.org,
	pmladek@suse.com,
	torvalds@linux-foundation.org,
	Arnd Bergmann <arnd@arndb.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH cmpxchg 07/14] parisc: add missing export of __cmpxchg_u8()
Date: Mon,  8 Apr 2024 10:49:37 -0700
Message-Id: <20240408174944.907695-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>
References: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

__cmpxchg_u8() had been added (initially) for the sake of
drivers/phy/ti/phy-tusb1210.c; the thing is, that drivers is
modular, so we need an export

Fixes: b344d6a83d01 "parisc: add support for cmpxchg on u8 pointers"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/parisc/kernel/parisc_ksyms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/parisc/kernel/parisc_ksyms.c b/arch/parisc/kernel/parisc_ksyms.c
index 6f0c92e8149d8..dcf61cbd31470 100644
--- a/arch/parisc/kernel/parisc_ksyms.c
+++ b/arch/parisc/kernel/parisc_ksyms.c
@@ -22,6 +22,7 @@ EXPORT_SYMBOL(memset);
 #include <linux/atomic.h>
 EXPORT_SYMBOL(__xchg8);
 EXPORT_SYMBOL(__xchg32);
+EXPORT_SYMBOL(__cmpxchg_u8);
 EXPORT_SYMBOL(__cmpxchg_u32);
 EXPORT_SYMBOL(__cmpxchg_u64);
 #ifdef CONFIG_SMP
-- 
2.40.1


