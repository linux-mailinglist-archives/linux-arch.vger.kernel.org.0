Return-Path: <linux-arch+bounces-14811-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 623B2C61AC9
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 19:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1DC7735A644
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 18:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA4B3126C8;
	Sun, 16 Nov 2025 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qdC2DgbI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423393126B2
	for <linux-arch@vger.kernel.org>; Sun, 16 Nov 2025 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763317759; cv=none; b=ghoJA9iR+zuyk4vfKKA9pVZXl1AkubgPEgLtJpD7RnKWYj44hgsJ43lTz+Fx/Lo9NRWXj/+DsVNPblSqeNKNZ0IFC46wnX6DGHQ7Sh/4tWC1WTLP8ilTz45TDgcDX27ECvsh6g/Hl2aAFCZZCxcuGVGHuybfenS4myrhOhPDU58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763317759; c=relaxed/simple;
	bh=1ZFyFxA+oQ+ok8wSm6aDLsEi46Nbc2ug/MQz5FqVjRI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mbmUvz9M1br3uoCwvp7QOJfe+4U01GE8EYXzIW4ovxhj8HKgRQIeMhhXSZRiCrfWgcMmZsEe8+N7UphFBR8Zif0mLjDftVX7ePDZD0HAysSEjmmfEnpgaKc72z1Suh8M+j/hS5iC6MXyxvKw/U8MAyHHdcfPAIjRQLSB5r52gBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qdC2DgbI; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-640b8087663so5370753a12.3
        for <linux-arch@vger.kernel.org>; Sun, 16 Nov 2025 10:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763317754; x=1763922554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ssIrRFSIZLhL847+Mj1S01mAVv1HMT3ge2VjAzv+kxg=;
        b=qdC2DgbImsKU3TGx+iuSyxAo/ToZBzAw6bZbJRCo9xptEHhtBvzJMc1NCDQ3CpqRMi
         sIeV8wwfCR0c7k5IS4myZuIbyZeNM8Shd2xgnpVz18Ua9aopCqfCZhYcgQLBMx0TnYj2
         unS815JWdyL5EsNCo0Alz2DzKCHoRqBACq6PJY7GnCaKSdDE77jTsqGagg6WeVHVmoJr
         bLboCGFEqYuFBhhcGndKYc+sm+SEN6fLFd0EAPqNhENoKWfEGwBOERJKB3tNpnWso5RK
         lhIZGhV921VINHsdQuOmqrTSloyMZB0pbGQDvVvITHZlNjLhQZed98MSwwzuS0lGsGfr
         ehYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763317754; x=1763922554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ssIrRFSIZLhL847+Mj1S01mAVv1HMT3ge2VjAzv+kxg=;
        b=w9c4HBLXwqyjvizSV6VubWZlvCHqAJMJfpZnR58FobPZnMwGKSXXU43bkoqU0P0BTn
         lJc9pCYe7MJJPGDXUAEuwxJ4equ5tmie93+W/Whf/kFvBAtDeboPq2/5SLvKMF1NSRJw
         WYCcEkp4du4/FB53b6Aa60wzMEiDWnF41pFDUSGpQg5/pcc4l0E6qEeg3oisi0IGfHRd
         CrdvXi6h4YZIPx3lcHyXM6vocW5Uygi9HKYmGy4ixOzAw+mZXJCMION3KsIVNOLKWdOn
         XBWGVb0bm7x+vwqvMJEOnUdk8Q9YMQGSCh40TYTBVGXkkdynAi9dubXpZL4XqrTlxqi5
         fWdA==
X-Forwarded-Encrypted: i=1; AJvYcCU+piHReME2S6ZUH72A1NR0j5OEI1zZFbnqncLGQWVB1p4YbmilUwhU1fdMwwp8jhpYeBB+/WuPNZyF@vger.kernel.org
X-Gm-Message-State: AOJu0YyB4m8+cHgNN6k435wD6qzE57ShK4kUBHsaBXIKBxeTw2wUvLyd
	KDj92cWN0IdHgrok/Zf6bIxhuI+iOOPRpLQbQQNtEyX6tU6ESREDQvCBof1qFcVzyR+r8bwCdQo
	mWwdFbw==
X-Google-Smtp-Source: AGHT+IGHAbppNHiwJnClKOePjqFi/tDUwKC7ezqVNbe2nbWY/8nzQo9Lx1mTLxNflma40Wb/tllUcL0zHFY=
X-Received: from edo12.prod.google.com ([2002:a05:6402:52cc:b0:641:7661:2a7c])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:35d2:b0:640:be87:a858
 with SMTP id 4fb4d7f45d1cf-64350e9eb3cmr9605284a12.27.1763317754455; Sun, 16
 Nov 2025 10:29:14 -0800 (PST)
Date: Sun, 16 Nov 2025 18:28:39 +0000
In-Reply-To: <20251116182839.939139-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251116182839.939139-1-lrizzo@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251116182839.939139-9-lrizzo@google.com>
Subject: [PATCH v2 8/8] vfio-pci: add module parameter for default moderation mode
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

The following module parameter enables moderation at boot time for vfio devices.

vfio_pci_core.soft_moderation=1

It can be overridden at runtime via /proc/irq/*/*vfio*/soft_moderation.
See Documentation/core-api/irq/irq-moderation.rst for configuration.

Change-Id: I69ece365fa8eb796c22e088dbe849eddb684e02a
Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/vfio/pci/vfio_pci_intrs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 30d3e921cb0de..e54d88cfe601d 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -22,6 +22,8 @@
 
 #include "vfio_pci_priv.h"
 
+DEFINE_IRQ_MODERATION_MODE_PARAMETER;
+
 struct vfio_pci_irq_ctx {
 	struct vfio_pci_core_device	*vdev;
 	struct eventfd_ctx		*trigger;
@@ -317,6 +319,7 @@ static int vfio_intx_enable(struct vfio_pci_core_device *vdev,
 		vfio_irq_ctx_free(vdev, ctx, 0);
 		return ret;
 	}
+	IRQ_MODERATION_SET_DEFAULT_MODE(pdev->irq);
 
 	return 0;
 }
-- 
2.52.0.rc1.455.g30608eb744-goog


