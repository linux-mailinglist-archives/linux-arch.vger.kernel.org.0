Return-Path: <linux-arch+bounces-15006-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D055C78796
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 11:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 1E63B3553E
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 10:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9942434D4CD;
	Fri, 21 Nov 2025 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebk9NsO6"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517E134D392
	for <linux-arch@vger.kernel.org>; Fri, 21 Nov 2025 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719300; cv=none; b=Ev/u+S9Dy/i1MuoOTiWghxTB32J0VhlQ1f47Q0EPiu4kYyqCfKYpiyS3h9y4cXrAuFZd4vQ3yLxKl+KNe0/ULq+Fz1vhgGcf9FVXFC8/azXXP5yTlmGeoCqr4QkexO605tOziTntD1f/KfsnDjnhmmJSDL7dRDbGWuGrEagfzb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719300; c=relaxed/simple;
	bh=9/Ql+dAsUXEs4tc/9oTf/8u6Gf7/hz+bXrR8WKKb1cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMEhVkP28wkRqEexMz1bzK6g+fvtNLzi7JyMAZVvYKv1KhDRD0yoYd+73Xr9a9/b0DIpDZ3G3mMVO65iPUE+4r8u0VuJchx6W8uANxgSUDMAmQeVzr9x/a9Ou/t7Priz0MH955TZXoMKsBp/ahoh84ATSlBVSkwL8NEMhNlHT3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ebk9NsO6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763719296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HzjekNmgRaAQ18lyWUzsEgEEJcD+Pamj+FUs+1j6mw8=;
	b=ebk9NsO6KsMHZdTPCBlbDOS4GilXwLDzrgqFtdtkf8usI/xq2jAl0k77mtnDzWbEl2BItl
	Vl9Bq9Lu+oP5vVv6LrsQIPruXR1ykW3eSEYFiI3fDAf+umQYhxfMoUSyPbY+kKTPpx1rBS
	DzEA7Ce7SgPl1wCiI+AE5akAEhjQkS8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-KhGOA54LO2idn1_FQ3SIiw-1; Fri,
 21 Nov 2025 05:01:27 -0500
X-MC-Unique: KhGOA54LO2idn1_FQ3SIiw-1
X-Mimecast-MFC-AGG-ID: KhGOA54LO2idn1_FQ3SIiw_1763719284
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A83221954B1B;
	Fri, 21 Nov 2025 10:01:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.78])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9142E1955F66;
	Fri, 21 Nov 2025 10:01:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kbuild@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 8/9] x86/headers: Replace __ASSEMBLY__ stragglers with __ASSEMBLER__
Date: Fri, 21 Nov 2025 11:00:43 +0100
Message-ID: <20251121100044.282684-9-thuth@redhat.com>
In-Reply-To: <20251121100044.282684-1-thuth@redhat.com>
References: <20251121100044.282684-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Thomas Huth <thuth@redhat.com>

After converting the __ASSEMBLY__ statements to __ASSEMBLER__ in
commit 24a295e4ef1ca ("x86/headers: Replace __ASSEMBLY__ with
__ASSEMBLER__ in non-UAPI headers"), some new code has been
added that uses __ASSEMBLY__ again. Convert these stragglers, too.

This is a mechanical patch, done with a simple "sed -i" command.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/x86/include/asm/irqflags.h      | 4 ++--
 arch/x86/include/asm/percpu.h        | 2 +-
 arch/x86/include/asm/runtime-const.h | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index b30e5474c18e1..5feaac1d235f0 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -77,7 +77,7 @@ static __always_inline void native_local_irq_restore(unsigned long flags)
 #endif
 
 #ifndef CONFIG_PARAVIRT
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * Used in the idle loop; sti takes one instruction cycle
  * to complete:
@@ -95,7 +95,7 @@ static __always_inline void halt(void)
 {
 	native_halt();
 }
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* CONFIG_PARAVIRT */
 
 #ifdef CONFIG_PARAVIRT_XXL
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 725d0eff7acdf..50f73a8df7f6c 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -20,7 +20,7 @@
 
 #define PER_CPU_VAR(var)	__percpu(var)__percpu_rel
 
-#else /* !__ASSEMBLY__: */
+#else /* !__ASSEMBLER__: */
 
 #include <linux/args.h>
 #include <linux/bits.h>
diff --git a/arch/x86/include/asm/runtime-const.h b/arch/x86/include/asm/runtime-const.h
index e5a13dc8816e2..4cd94fdcb45e2 100644
--- a/arch/x86/include/asm/runtime-const.h
+++ b/arch/x86/include/asm/runtime-const.h
@@ -6,7 +6,7 @@
   #error "Cannot use runtime-const infrastructure from modules"
 #endif
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 .macro RUNTIME_CONST_PTR sym reg
 	movq	$0x0123456789abcdef, %\reg
@@ -16,7 +16,7 @@
 	.popsection
 .endm
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 #define runtime_const_ptr(sym) ({				\
 	typeof(sym) __ret;					\
@@ -74,5 +74,5 @@ static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
 	}
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif
-- 
2.51.1


