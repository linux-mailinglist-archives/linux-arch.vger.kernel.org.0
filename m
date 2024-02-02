Return-Path: <linux-arch+bounces-1992-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA3484705B
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 13:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2D91C23DA8
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 12:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21953145B13;
	Fri,  2 Feb 2024 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="fEI1zv/+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GM6TVMHq"
X-Original-To: linux-arch@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B657414532C;
	Fri,  2 Feb 2024 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877044; cv=none; b=LDBidOcqXhwFocE7HosHPNWveLNzX2VGkS48U0HphDDgwTau7znFEbpjTmpgV1JQCUYqiNorVxlS6kpJABpwJeJEPvxp+DtW8DnfIGKSDI7dCQ7BgZpYZeQkR1SrBKprGePUUcYreQZrj+/C168rgmxzkIFOJ0aBonLx598OUHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877044; c=relaxed/simple;
	bh=jqYI8HbcM9CNa56K9MGaAYkP5szfqvwINyuXO+HntBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bep3NYGnGTkljyORjsGCDC5Y2vdpfJKhJRj7uEXwAgIZMIgWIzEYPFXSznwb5E7lhRQm+Yq0j6Nvef+Sj3K+G6N7DJA9o886z/giusQ/ioJsVZBJR3O9zjkSV/sRr/nEVGsFwzn7D+ZOghHZshtJxhzgvN0fzPUuTHnavD4VqB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=fEI1zv/+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GM6TVMHq; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 8CDF65C0160;
	Fri,  2 Feb 2024 07:30:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 02 Feb 2024 07:30:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1706877036;
	 x=1706963436; bh=3C5bFwJv9LWEX7uXH9OhbPn6aVzr7qyWAUolJmL7emQ=; b=
	fEI1zv/+ZvFpkfpFRiLTSbFcBisWuJ2q1jjScOxUaTFUrgkBaxR7Dx3eZf25cfK3
	CCgcfDN0Mp+DmtIBGMvaBhPgFah6cUtlcaagGHlj97CLyV1V3p/5jw7OtwdFh64a
	HMQa5y/m/fAdJjMEvV/Q0eZ89mcIVI1Riga2COWISSsrwMoXl1biAun7d9Iem3JM
	EJsIIbsWbJqGq5yN4S1pDLjjeDsbBOGGag/1fMXqkCs/ScLMbRqeJdXOG6T/rZGC
	s00KA5riqpXZZ/sqaaNNV9dRJ0lagWb/DXUyBPlGEwCHFFKUDNZtGujoWsr2NybD
	eYv4M7t3bTg1agwJRceaIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706877036; x=
	1706963436; bh=3C5bFwJv9LWEX7uXH9OhbPn6aVzr7qyWAUolJmL7emQ=; b=G
	M6TVMHqdzw6Ad4JtN7ng9dTBDFr/eJ0ih2VN0pFcxFRMqVse9IA4ZgGzwjEuvCz8
	ZYuIoiL2km7nIa+V2fNKiCBS3hXbwKYKgfKJABkZ3O58hAPcwy3AmQvvJx5xoy6/
	w6Yew322XWxbcGUF9VqlbmHmtI/kQqZFxP/WHKzEIwgIg1+Luc8NEAHeVxPuGU+E
	ztCrKwLNLAlHT2j+alLLJ/jtu4feGjNtgYQTtunDXjuJxRD/O1ZNDNPRq2r4o1Jh
	AZ1h8rdIffPFFY6kjHi7iGxfFTjq2U4DpsBRuyMgjprKJ6be/BB/h/kEbM00rSgp
	jgGUDqGGjalnzB+Cei1Nw==
X-ME-Sender: <xms:bOC8Zf7gvJ1zZerDDFjDAdukW7abAaeyZE0VvcvxglB51WbTjgoSdQ>
    <xme:bOC8ZU4crtGOkNslH5cNYIjWYRM6qSCnlcZdbPe6dUOMLcQ-Rv06_wo9X-eL1xGJl
    2zHAW_qWYIoU3-eE5c>
X-ME-Received: <xmr:bOC8ZWd52GekhM7nlHvcqbNa0YowaXRUTTfA9Oi4BgvPZ_Fh2_yCffFwscfQVpKxPd5dKZoLDv7ECCzl4shmN_qjIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedugedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvedujefhfffhveekhfffkeetvefgteejkeeutdduieehieeg
    feejtdelveejtedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:bOC8ZQKnFTbYHhwPBE3OwTXV6OYZ2ZTJZWPXJagNndElpdct2ITGsg>
    <xmx:bOC8ZTKsX2kBC5OusDQMhfD3PlO4wTy93qo9QJ6-i4rm2L8Bl2feMg>
    <xmx:bOC8ZZzZb22lNXgg9qApzY6i3Af3-uJ5O9wFTnDoDMZC3VfBW58dvg>
    <xmx:bOC8ZQpWL5-RKpxUUmBF7763XuSCCExTi1onNIJzbh3DNDfY1OgmYQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 07:30:34 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 02 Feb 2024 12:30:26 +0000
Subject: [PATCH v2 1/3] ptrace: Introduce exception_ip arch hook
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-exception_ip-v2-1-e6894d5ce705@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2422;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=jqYI8HbcM9CNa56K9MGaAYkP5szfqvwINyuXO+HntBI=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhtQ9D9L/qG88d2+OlHtP+o78T0s3chUbPZ8Uvzbu8jpWN
 g75zrbzHaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCRVzMYGR6pPn00Z3LOVYMf
 +pd5H13RYA/4m6B+6ezjTK8Z5rkHPioy/FMONNv9ubG3cWFPxtH1qnK6706VPv38t/CF1H4RHyU
 PKx4A
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

On architectures with delay slot, architecture level instruction
pointer (or program counter) in pt_regs may differ from where
exception was triggered.

Introduce exception_ip hook to invoke architecture code and determine
actual instruction pointer to the exception.

Link: https://lore.kernel.org/lkml/00d1b813-c55f-4365-8d81-d70258e10b16@app.fastmail.com/
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/ptrace.h | 2 ++
 arch/mips/kernel/ptrace.c      | 7 +++++++
 include/linux/ptrace.h         | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index daf3cf244ea9..701a233583c2 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -154,6 +154,8 @@ static inline long regs_return_value(struct pt_regs *regs)
 }
 
 #define instruction_pointer(regs) ((regs)->cp0_epc)
+extern unsigned long exception_ip(struct pt_regs *regs);
+#define exception_ip(regs) exception_ip(regs)
 #define profile_pc(regs) instruction_pointer(regs)
 
 extern asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall);
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index d9df543f7e2c..59288c13b581 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -31,6 +31,7 @@
 #include <linux/seccomp.h>
 #include <linux/ftrace.h>
 
+#include <asm/branch.h>
 #include <asm/byteorder.h>
 #include <asm/cpu.h>
 #include <asm/cpu-info.h>
@@ -48,6 +49,12 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
+unsigned long exception_ip(struct pt_regs *regs)
+{
+	return exception_epc(regs);
+}
+EXPORT_SYMBOL(exception_ip);
+
 /*
  * Called by kernel/ptrace.c when detaching..
  *
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index eaaef3ffec22..90507d4afcd6 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -393,6 +393,10 @@ static inline void user_single_step_report(struct pt_regs *regs)
 #define current_user_stack_pointer() user_stack_pointer(current_pt_regs())
 #endif
 
+#ifndef exception_ip
+#define exception_ip(x) instruction_pointer(x)
+#endif
+
 extern int task_current_syscall(struct task_struct *target, struct syscall_info *info);
 
 extern void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oact);

-- 
2.43.0


