Return-Path: <linux-arch+bounces-15501-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B976BCCDBD4
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 22:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9DE8A304F25B
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 21:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10A826B0B3;
	Thu, 18 Dec 2025 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nHCr+DaY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4z4yiqD0"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD0E1E7C34;
	Thu, 18 Dec 2025 21:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766095016; cv=none; b=EGRvyzHWKSqy5JvEXFUCigBy8M0TB7VZ2hwnacfRpQyrnYm6nNqZ6ebMYfJxcLzho0nwsRBDfOdyJgAdZX1zIXWhFAaGc0UQxkpDjizfd6ziCJd3r82P861UcLuCf8butO8Rb9z+jla7UASy+zbOAeOtaVX8tGm9f/zpSPq1NLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766095016; c=relaxed/simple;
	bh=Hf4qLLtrnn2ezwleG+RyxyYWHwxJq3j1HwQ3mLIN/K0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uhgvLNeKEj4M6R76cwJx9jb0+13jMXTDk4BtDHnc+18MtzK4giEljZFkx0JnkOaflmNCDLJkzjp9da3FEJpqLfFS8AizG8O4PiWP2HJVpzIxPEruSxREcnkoHdNk+3jDXPhx35I+4coGLvOovXX+9vNZb+S1+XtXJgibKn5A41s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nHCr+DaY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4z4yiqD0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766095012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qVHw+VLvdAw5Ok2H1a/xNOAmVG278ORkieUamICyunk=;
	b=nHCr+DaYwq6lywF2pMuGlgNEJcPuUU2+l9O1cY5tWaoajeyjOLqbAIOvUfndDwoNOrcugn
	7F9kLZdfoiEVpUJYeyTfPeruHjoqEo+S4neQr9yOi7BDoYKdY8M2bJEHIPoajp53CG86mf
	Yf0sJp+nIRjIPgOCrX8ZLiBMGvY+gItDSNOGwZODIK5AHw+K7TvtB5rT6n8fSSIQRgGmoL
	97mgvcrWkdKzTg6pCtNtGVzRDj55a56e+mW09FxX9hyBfWdGntXjxLSX1lB0Gp/lFEvv4Q
	s3RTZipGgL6gkiPVnyVp5YUbskCtCEZEJ0WZs5jD46DR9gzB3DSVXvfJ4D2IMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766095012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qVHw+VLvdAw5Ok2H1a/xNOAmVG278ORkieUamICyunk=;
	b=4z4yiqD0cEhHRgV12s5v+fVAPnGxbhZCEdTdWr1LwAUeET2ZJxmW+hce4h2LpU23w0XosC
	77PESOf2QUGipRAA==
To: Luigi Rizzo <lrizzo@google.com>, Marc Zyngier <maz@kernel.org>, Luigi
 Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, Sean Christopherson
 <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH-v3 3/3] genirq: Configurable default mode for GSIM
In-Reply-To: <20251217112128.1401896-4-lrizzo@google.com>
References: <20251217112128.1401896-1-lrizzo@google.com>
 <20251217112128.1401896-4-lrizzo@google.com>
Date: Thu, 18 Dec 2025 22:56:51 +0100
Message-ID: <87pl8bbgik.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Dec 17 2025 at 11:21, Luigi Rizzo wrote:
> GSIM (Global Software Interrupt Moderation) can be enabled only after the
> interrupt is created by writing to /proc/irq/NN/soft_moderation. This is
> impractical when devices that are dynamically created or reconfigured.
>
> Add a module parameter irq_moderation.enable_list to specify whether
> moderation should be enabled at interrupt creation time. This is done
> with a comma-separated list of patterns (enable_list) matched against
> interrupt or handler names when the interrupt is created.
>
> This allows very flexible control without having to modify every single
> driver. As an example, one can limit to specific drivers by specifying
> the handler functions (using parentheses) as below
>
>      irq_moderation.enable_list="nvme_irq(),vfio_msihandler()"
>
> ora apply it to certain interrupt names
>
>      irq_moderation.enable_list="eth*,vfio*"

TBH, that's an admittely creative but horrible hack.

That's what uevents are for. Something like the below provides the
information you need to keep track of interrupt requests:

KERNEL[57.529152] change   /kernel/irq/256 (irq)

With that it is very practical to do all this magic in user space, no?

Thanks,

        tglx
---
 kernel/irq/internals.h |    6 ++++++
 kernel/irq/irqdesc.c   |   25 ++++++++++++++++++++-----
 kernel/irq/manage.c    |    1 +
 3 files changed, 27 insertions(+), 5 deletions(-)

--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -521,3 +521,9 @@ static inline void irq_debugfs_copy_devn
 {
 }
 #endif /* CONFIG_GENERIC_IRQ_DEBUGFS */
+
+#if defined(CONFIG_SPARSE_IRQ) && defined(CONFIG_SYSFS)
+void irqdesc_action_uevent(struct irq_desc *desc);
+#else
+static inline void irqdesc_action_uevent(struct irq_desc *desc) { }
+#endif
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -241,7 +241,7 @@ static int init_desc(struct irq_desc *de
 static void irq_kobj_release(struct kobject *kobj);
 
 #ifdef CONFIG_SYSFS
-static struct kobject *irq_kobj_base;
+static struct kset *irq_kobj_base;
 
 #define IRQ_ATTR_RO(_name) \
 static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
@@ -363,10 +363,12 @@ static void irq_sysfs_add(int irq, struc
 		 * crucial and failures in the late irq_sysfs_init()
 		 * cannot be rolled back.
 		 */
-		if (kobject_add(&desc->kobj, irq_kobj_base, "%d", irq))
+		if (kobject_add(&desc->kobj, &irq_kobj_base->kobj, "%d", irq)) {
 			pr_warn("Failed to add kobject for irq %d\n", irq);
-		else
+		} else {
 			desc->istate |= IRQS_SYSFS;
+			desc->kobj.kset = irq_kobj_base;
+		}
 	}
 }
 
@@ -382,6 +384,16 @@ static void irq_sysfs_del(struct irq_des
 		kobject_del(&desc->kobj);
 }
 
+void irqdesc_action_uevent(struct irq_desc *desc)
+{
+	if (!(desc->istate & IRQS_SYSFS))
+		return;
+
+	guard(mutex)(&sparse_irq_lock);
+	if (irq_kobj_base)
+		kobject_uevent(&desc->kobj, KOBJ_CHANGE);
+}
+
 static int __init irq_sysfs_init(void)
 {
 	struct irq_desc *desc;
@@ -389,13 +401,16 @@ static int __init irq_sysfs_init(void)
 
 	/* Prevent concurrent irq alloc/free */
 	guard(mutex)(&sparse_irq_lock);
-	irq_kobj_base = kobject_create_and_add("irq", kernel_kobj);
+	irq_kobj_base = kset_create_and_add("irq", NULL, kernel_kobj);
 	if (!irq_kobj_base)
 		return -ENOMEM;
 
 	/* Add the already allocated interrupts */
-	for_each_irq_desc(irq, desc)
+	for_each_irq_desc(irq, desc) {
 		irq_sysfs_add(irq, desc);
+		if (data_race(desc->action))
+			kobject_uevent(&desc->kobj, KOBJ_CHANGE);
+	}
 	return 0;
 }
 postcore_initcall(irq_sysfs_init);
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1762,6 +1762,7 @@ static int
 	register_irq_proc(irq, desc);
 	new->dir = NULL;
 	register_handler_proc(irq, new);
+	irqdesc_action_uevent(desc);
 	return 0;
 
 mismatch:

