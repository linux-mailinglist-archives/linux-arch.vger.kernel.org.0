Return-Path: <linux-arch+bounces-14809-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F78C61AC0
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 19:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFD2E4E4215
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 18:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D688D3126B0;
	Sun, 16 Nov 2025 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmJy+thO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18275311C10
	for <linux-arch@vger.kernel.org>; Sun, 16 Nov 2025 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763317753; cv=none; b=CYNqOkeUCE4XGRgD3foQZMuxgVL16YXGnmG4Zze+Z3MGVDbQ3LrITLhQywyEWzdimBMHrmThOj8x6JO80UjtIncHW0dJ9hUD7RtF2l0c5cMgSikbzTVIg5AP9rMg/CsSYqE/lScpqNOYuY++D6eolbYKHfPEkY9t2e/8+tGypJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763317753; c=relaxed/simple;
	bh=l21shQ3umzPxZYivRnhQSjFruuiqT/04axRk7SI7moI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZMYG/330XNCMrAECp8q/YlhAS8em+0bpB4JVYu3TvSpy+WprcuNrsNFLZSe/wyWC/Ky7Scy/Rp5Kn2auayobYHYUDLFaFTsM82WzYmf1VyeSbn051BEWKoVInrhBPawQaTQS3cGedTTT8I6rqCTWjO/j23W0x2IBjU6JE01J8u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RmJy+thO; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-64091bef2ecso4519428a12.3
        for <linux-arch@vger.kernel.org>; Sun, 16 Nov 2025 10:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763317750; x=1763922550; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dkV+qdZ4WHfIeKYmRBA0sopwDh/gSz07Cpm1RhYXmDY=;
        b=RmJy+thOXdkodMeLXqhyPwbqf8ClwusaXEPwe4sKUg3Mz8uAeyhOPY5DPlt95/CmuP
         xK1YBY+b5xSVjqkPEgkgC+oNaLy9j059uwya5ocGAtF0J+n9tNwQhf1nmzOmw9B/jJVw
         PJ/VJXlkgbLVnvlD0tqpBnW43BceMBD73l1rlIfbCds8ne9FCZ9mbNUJuTbvNNoftOQI
         OENVWMBhuShQ8GBIoD1sbMrRYMukk7yhqa/FjJzjZMmnL8RAfzgDQ1YjnaEKDotWaxkO
         6dc9Qj5oPjSjRbxkIa9uXA8Wjr7WiqOB8Yj9TyhXGHm6mjn6khuLe64NQUDtTSbicXLr
         PxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763317750; x=1763922550;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkV+qdZ4WHfIeKYmRBA0sopwDh/gSz07Cpm1RhYXmDY=;
        b=OJzg84gy9Rc7hgtdAUYe2+JFQEdHFVa34kqh42sha7Shw9rxuYRzACjvmL/TZLvad+
         rPNpjHu1A0KQDbMC+IEfkM5aylJfZyToV+8wF58vwNklBLEeAyNGX9fJqXFknI+G87+y
         RJGCTOIxowVGOlWYfEH9l4RbqM+m8FYcNxc38ocGSlc7ytP2smLsz6CRU+4U1P6EqOyI
         B/IOrhjryJ9i3FNMxr4rnowwNMVzZvaMSA7ToebPTmBo8BHDLOxFuv8uEeuJCGs8HCi9
         kDjcqf4hChCuBbsLp0JUlpNTO90EgeimR9e2+pkm02lX9uHe1pw9zglQc0V2rdD2/Rb1
         fbBg==
X-Forwarded-Encrypted: i=1; AJvYcCUrk9GnpOO+9TvoCprdibJL7K2uKlKo+RpOj04c8WqJGy4CPzz6xiC8Coqi3WYJTgWZT4B5zj8ZjmC2@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr64XtdP8WLTZnmDdBaZn+HaTAMbb8o2RzaW/9L+yPF3wQL0TZ
	IRb+rDTtRnkNxce0VLpTpjpt0WxEfFFry+e2ai6CJk2QJCLwL5e0pZ3VQ0EKZuB54JY+U8LOuHU
	30h9bXg==
X-Google-Smtp-Source: AGHT+IFQGuWjEwyHai6f+XdAfMVlRX0Fy1Rt0s0FIan/KaxUMqOjNSYD2JZCGeyVwPK+/3U0bkWGxw0toXs=
X-Received: from edh8.prod.google.com ([2002:a05:6402:5048:b0:640:e9f8:c947])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:90e:b0:640:bbd1:7d99
 with SMTP id 4fb4d7f45d1cf-64350e204f7mr9510319a12.16.1763317750612; Sun, 16
 Nov 2025 10:29:10 -0800 (PST)
Date: Sun, 16 Nov 2025 18:28:37 +0000
In-Reply-To: <20251116182839.939139-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251116182839.939139-1-lrizzo@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251116182839.939139-7-lrizzo@google.com>
Subject: [PATCH v2 6/8] genirq: soft_moderation: helpers for per-driver defaults
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce helpers to implement per-driver module parameters to enable
moderation at boot/probe time.

No functional change.

Change-Id: I305aa42fa348055004cc2221ef6b055a0ab4b9d5
Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 include/linux/interrupt.h   | 19 +++++++++++++++++++
 kernel/irq/irq_moderation.c | 14 ++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 51b6484c04934..17ce0aac181de 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -872,6 +872,25 @@ extern int early_irq_init(void);
 extern int arch_probe_nr_irqs(void);
 extern int arch_early_irq_init(void);
 
+#ifdef CONFIG_IRQ_SOFT_MODERATION
+
+/* helpers for per-driver moderation mode settings */
+#define DEFINE_IRQ_MODERATION_MODE_PARAMETER		\
+	static bool soft_moderation;			\
+	module_param(soft_moderation, bool, 0644);	\
+	MODULE_PARM_DESC(soft_moderation, "0: off, 1: on")
+
+void irq_moderation_set_mode(int irq, bool enable);
+#define IRQ_MODERATION_SET_DEFAULT_MODE(_irq)		\
+	irq_moderation_set_mode(_irq, READ_ONCE(soft_moderation))
+
+#else   /* empty stubs to avoid conditional compilation */
+
+#define DEFINE_IRQ_MODERATION_MODE_PARAMETER
+#define IRQ_MODERATION_SET_DEFAULT_MODE(_irq)
+
+#endif
+
 /*
  * We want to know which function is an entrypoint of a hardirq or a softirq.
  */
diff --git a/kernel/irq/irq_moderation.c b/kernel/irq/irq_moderation.c
index 2d01e4cd4638b..c2542c92fbbd5 100644
--- a/kernel/irq/irq_moderation.c
+++ b/kernel/irq/irq_moderation.c
@@ -84,6 +84,10 @@ static inline bool posted_msi_supported(void) { return false; }
  *
  *    echo "on" > /proc/irq/NN/soft_moderation # use "off" to disable
  *
+ * For selected drivers, the default can also be supplied via module parameters
+ *
+ *	${DRIVER}.soft_moderation=1
+ *
  * === MONITORING ===
  *
  * cat /proc/irq/soft_moderation shows per-CPU and global statistics.
@@ -307,6 +311,16 @@ static inline int set_moderation_mode(struct irq_desc *desc, bool enable)
 	return 0;
 }
 
+/* irq_to_desc() is not exported. Wrap it for use in drivers. */
+void irq_moderation_set_mode(int irq, bool enable)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+
+	if (desc)
+		set_moderation_mode(desc, enable);
+}
+EXPORT_SYMBOL(irq_moderation_set_mode);
+
 #pragma clang diagnostic error "-Wformat"
 /* Print statistics */
 static int moderation_show(struct seq_file *p, void *v)
-- 
2.52.0.rc1.455.g30608eb744-goog


