Return-Path: <linux-arch+bounces-15803-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A7893D25916
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 17:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE659301D128
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 15:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF2F3B8BC4;
	Thu, 15 Jan 2026 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m8Pm6clF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903A43B8BD8
	for <linux-arch@vger.kernel.org>; Thu, 15 Jan 2026 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492792; cv=none; b=HOT3Is+Y9qKA7YzGF6mlWvwgUS3iwTMP7vaPiiIS6yDYlAMdyRXbeD4Zecfsld0PdGt5uVXhgPHe8rNrmIvBcP7jvuJqw/WJ90cKNbo+iJNr2MZGuCai3oMIQkG6m4KDtIFU+AjRepxnX3jI6dfGSuktKp0JrMOuUdnWxxVkuQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492792; c=relaxed/simple;
	bh=opub2fbgRWS1Kq2hoaD2U8sWGb/uPCW68VZXw0xO7sk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QgljG31Gshu9ESf9UIo1bfM2rZR+JrewcPXt82d+7mZy5EjP0PdJ723AomJqQaxu5MFcjcCzKc204zW5SyOzjF3ARyho+PcA+RdTStq3HI4NM7o8V8PA/W4/wFCOSzQwbia79zSMgLQhZkYQciV2CskMg1PMsDHNYIAah/Mex1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m8Pm6clF; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b8773bf3ddbso113636166b.1
        for <linux-arch@vger.kernel.org>; Thu, 15 Jan 2026 07:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768492789; x=1769097589; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K3MNKafNCuEMF2IMwQI0I3Gp+X1QzwdfJu03oHxNqEQ=;
        b=m8Pm6clF1xp5xqEeYwswu9GMtcAJxC075mXTiEc5UNrV/PxR5wtNSLS/DL6jHiyEGo
         UC82o1FXsX9G+9SlmjuZTxQXAIiuiUfp0kVPG4eVezeW66U3UsWutFvM5fT3M9+YC+D9
         sqMl2oncDu7N1IJszZkz1zAa4q8+upR73YSMS8ASTb/i4c/068eHFxwp56iDvBQvJBor
         MKygt9Nf8537p2yjCF0T77f+LMi7yhDb4CnbNqvvfOPD9fHzzv56MNi4T+66e4WF9ehB
         5DbdGn3OhgUx/8n4hAsrr4GXTw3Rh2mq4e6AxXOLbZupuKPxxR2PBJHU7JixJeJWCHFq
         lCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768492789; x=1769097589;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3MNKafNCuEMF2IMwQI0I3Gp+X1QzwdfJu03oHxNqEQ=;
        b=Xj/l0SRZfUpBUit24b4EDu4W39vK0NWSEaHq20W5/ljf/cBh+xYFpAJyg3hzc62GzL
         m7vgsCFU8TC3ndHkRqRKlxR4uFVNNfou+cs6W8n0MDzyWZWQggXxI1AS+9D7TGJ41tXp
         lz0+l04RS9QVbl3KfNIexq9i8Imil45SNIed4mxAkCQKsjBj/nrKXi03xN6u2sFThCkx
         ZtsIZKIPizgwWukr1YHT+mOV2GFDmFU5KPn3vuW13DEerGsBYK2iYgPtU209SQIQVis1
         /WH785Z74L68NZzoYe8bSuog2n2zkrtvv/qr0ULNu6vJbPkwvlU2aDjotC25cWdz5hML
         Am8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4mIJcEBhDG1aOIeLn0g+puh8/NOulAP074S6KZe1wk9QnLyfYQMiduvfBF81EpgRKdDdO8orozNYz@vger.kernel.org
X-Gm-Message-State: AOJu0YzNeIEkBnVfm1BL8BVpfrNjfe52iJb2MKB39h9OGhVK1NVDIPdl
	ABaSgOO4/cH+Ik/b4+9YRbj5EoKrg3+q+3v/1WYRod+6eL9xL32jegL/yHKVWR+F0pVB+gazOvr
	csQjcjA==
X-Received: from ejux23.prod.google.com ([2002:a17:906:4a97:b0:b84:5221:bb89])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:9608:b0:b87:4c74:b316
 with SMTP id a640c23a62f3a-b8792feb24dmr6764966b.50.1768492788925; Thu, 15
 Jan 2026 07:59:48 -0800 (PST)
Date: Thu, 15 Jan 2026 15:59:40 +0000
In-Reply-To: <20260115155942.482137-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115155942.482137-1-lrizzo@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115155942.482137-2-lrizzo@google.com>
Subject: [PATCH v4 1/3] genirq: Add flags for software interrupt moderation.
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Add two flags to support software interrupt moderation:

- IRQ_SW_MODERATION is an irqdesc flag indicating that an interrupt supports
  moderation. This is a feature that can be set by the system
  administrator.
- IRQD_IRQ_MODERATED is an internal irqdata flag indicating that the
  interrupt is currently being moderated. This is a state flag.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 include/linux/irq.h   | 6 +++++-
 kernel/irq/settings.h | 7 +++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 4a9f1d7b08c39..df653e10a83bf 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -72,6 +72,7 @@ enum irqchip_irq_state;
  * IRQ_DISABLE_UNLAZY		- Disable lazy irq disable
  * IRQ_HIDDEN			- Don't show up in /proc/interrupts
  * IRQ_NO_DEBUG			- Exclude from note_interrupt() debugging
+ * IRQ_SW_MODERATION		- Can do software interrupt moderation
  */
 enum {
 	IRQ_TYPE_NONE		= 0x00000000,
@@ -99,13 +100,14 @@ enum {
 	IRQ_DISABLE_UNLAZY	= (1 << 19),
 	IRQ_HIDDEN		= (1 << 20),
 	IRQ_NO_DEBUG		= (1 << 21),
+	IRQ_SW_MODERATION	= (1 << 22),
 };
 
 #define IRQF_MODIFY_MASK	\
 	(IRQ_TYPE_SENSE_MASK | IRQ_NOPROBE | IRQ_NOREQUEST | \
 	 IRQ_NOAUTOEN | IRQ_LEVEL | IRQ_NO_BALANCING | \
 	 IRQ_PER_CPU | IRQ_NESTED_THREAD | IRQ_NOTHREAD | IRQ_PER_CPU_DEVID | \
-	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY | IRQ_HIDDEN)
+	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY | IRQ_HIDDEN | IRQ_SW_MODERATION)
 
 #define IRQ_NO_BALANCING_MASK	(IRQ_PER_CPU | IRQ_NO_BALANCING)
 
@@ -219,6 +221,7 @@ struct irq_data {
  *				  irqchip have flag IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND set.
  * IRQD_RESEND_WHEN_IN_PROGRESS	- Interrupt may fire when already in progress in which
  *				  case it must be resent at the next available opportunity.
+ * IRQD_IRQ_MODERATED		- Interrupt is currently moderated.
  */
 enum {
 	IRQD_TRIGGER_MASK		= 0xf,
@@ -244,6 +247,7 @@ enum {
 	IRQD_AFFINITY_ON_ACTIVATE	= BIT(28),
 	IRQD_IRQ_ENABLED_ON_SUSPEND	= BIT(29),
 	IRQD_RESEND_WHEN_IN_PROGRESS    = BIT(30),
+	IRQD_IRQ_MODERATED		= BIT(31),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
diff --git a/kernel/irq/settings.h b/kernel/irq/settings.h
index 00b3bd127692c..bc8ade4726322 100644
--- a/kernel/irq/settings.h
+++ b/kernel/irq/settings.h
@@ -18,6 +18,7 @@ enum {
 	_IRQ_DISABLE_UNLAZY	= IRQ_DISABLE_UNLAZY,
 	_IRQ_HIDDEN		= IRQ_HIDDEN,
 	_IRQ_NO_DEBUG		= IRQ_NO_DEBUG,
+	_IRQ_SW_MODERATION	= IRQ_SW_MODERATION,
 	_IRQF_MODIFY_MASK	= IRQF_MODIFY_MASK,
 };
 
@@ -34,6 +35,7 @@ enum {
 #define IRQ_DISABLE_UNLAZY	GOT_YOU_MORON
 #define IRQ_HIDDEN		GOT_YOU_MORON
 #define IRQ_NO_DEBUG		GOT_YOU_MORON
+#define IRQ_SW_MODERATION	GOT_YOU_MORON
 #undef IRQF_MODIFY_MASK
 #define IRQF_MODIFY_MASK	GOT_YOU_MORON
 
@@ -180,3 +182,8 @@ static inline bool irq_settings_no_debug(struct irq_desc *desc)
 {
 	return desc->status_use_accessors & _IRQ_NO_DEBUG;
 }
+
+static inline bool irq_settings_moderation_allowed(struct irq_desc *desc)
+{
+	return desc->status_use_accessors & _IRQ_SW_MODERATION;
+}
-- 
2.52.0.457.g6b5491de43-goog


