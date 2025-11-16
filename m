Return-Path: <linux-arch+bounces-14810-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 486C7C61AC6
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 19:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E19324E4D68
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 18:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA91F312826;
	Sun, 16 Nov 2025 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mjiDoCoy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B2E3126B2
	for <linux-arch@vger.kernel.org>; Sun, 16 Nov 2025 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763317755; cv=none; b=b0rkdLTunfN8B8HO7Z8B4IfdNcvcFT0Ql297dg2IDDcq4lfaHcAjO2DLMDb9GJ2E61Zp1AALPc46aMFY6eaBMLoOqOek2147wOQgnFBPBviHTiyUHkVBXfi6cOfGtogk1acAbvElld2ojK5Asw8caor/JJoN7fShCU6NK1Q5COA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763317755; c=relaxed/simple;
	bh=00mALChpOM7DFQuKJAqLgOxwnjchBiE+L7n4Z+W75eA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PE+JN2VnOsuhxUT3o0dG4/rbmOQZJno6IqnCztqXAfZ55w9lr+XKEIZpy+kX7Yrp5L8Ue/8ZVwS5AZn4OQ5cSkHfepKJjCubeehnAasIROfv+f1TNrY2cK1unJRH1bM7pDCCkQMiFYXh0WarqFYJ+dDdR5KMTc5/DzzEwjAcR4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mjiDoCoy; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b72a95dc6d9so512093066b.0
        for <linux-arch@vger.kernel.org>; Sun, 16 Nov 2025 10:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763317752; x=1763922552; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IUxkiGynZiAFv0MAfGMeT3PXXPBCq7AugJzue/oa1+A=;
        b=mjiDoCoylCiy3mHJEQ0TscQurnR+E1QJmgsmWRCg4d81+bWugt3UZe+PChCCAXGBUt
         DZWWJDT6T6sSCE3KnncXdXcv4ikw/MuIQgs1Qb7PFcKHSRkRDnsJN+VN+/g7peYSqMcU
         L1jLPteMPOL0GNkwPuBnMDhJXvwyjVYbtWt9a1qQgb6JO5KG8CtinbZH0PUFvb1WVvjv
         Hv7+y8g86wfQ9rr9lEMMsJXWOweEtc5RwiFrHHFjiMONC6RUmU4+7KPRq5IB8KDcx8Nq
         lP0VAbr/WLOwrpvMpiOS7LgcVB9CwnqsclDe3uApkvVjd5X1+yvqH55vvXqDsikgnvU1
         y1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763317752; x=1763922552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUxkiGynZiAFv0MAfGMeT3PXXPBCq7AugJzue/oa1+A=;
        b=S1fOPOrEzIUfUXywl+P3qpztMSkHj7HxJRcU/jslLHOfy6X1lEqmjHBB/g4M4lhf9T
         AYxSyMYpO7DemhXd0YmaHBxoUYMjaQsWvYCwzQikou+uwkTQLc70VWhHNH0UvfbJbmuX
         pET+pjhgdatX240etIyVuLZQLURw7UTZSJDk1bH/A1QdWo6LGUyW6Sa0r4gkxZ16WZ+U
         u5gK9LBzi6rmBglFkD1Qt4bszD3UiUougRoe8lb66yjceCd6vSrpM4KyN5ZDSJXp9LtB
         4dcwhz6U+jlb6filN/iX8hRMbF4EBWGyLT3DuYBZnTG+nVk13OJMGUIQrwSc/tsWz+TG
         XUfA==
X-Forwarded-Encrypted: i=1; AJvYcCXWGtM91favFN/bG288WS4dCx1B2SkNa2VIv1E0LfKgPwHo5DA5zajwM9MbC6/f64BC0gfpsrV2flbK@vger.kernel.org
X-Gm-Message-State: AOJu0YxO81YkfsySLVZ/8yG74jaTOud/EtsPItQtDA57hUx3rgkmKKMy
	/xtFo1fUCGNyFo73dNeMV8mmDM63In3ka15wA+Ztc8S4KXlnk3ZoZzYXE2H84ut+Yi7WzCbVll2
	qCvwoKA==
X-Google-Smtp-Source: AGHT+IHUtJtAYO5VoPHTP3KkG3xrvaO2UdEkY1YzXHK5nlOWuzoFlFfldRJ8XmBWUxdDPYUHNvaUcMhIGtA=
X-Received: from ejcvc14.prod.google.com ([2002:a17:907:d08e:b0:b73:592e:4be0])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:97c3:b0:b72:a899:169f
 with SMTP id a640c23a62f3a-b7367828ab8mr1177209666b.4.1763317752491; Sun, 16
 Nov 2025 10:29:12 -0800 (PST)
Date: Sun, 16 Nov 2025 18:28:38 +0000
In-Reply-To: <20251116182839.939139-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251116182839.939139-1-lrizzo@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251116182839.939139-8-lrizzo@google.com>
Subject: [PATCH v2 7/8] nvme-pci: add module parameter for default moderation mode
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

The following module parameter enables moderation at boot time for nvme devices.

  nvme.soft_moderation=1

It can be overridden at runtime via /proc/irq/*/*nvme*/soft_moderation.
See Documentation/core-api/irq/irq-moderation.rst for configuration.

Change-Id: Ib061737415c26b868e889d4d9953e1d25ca8fc4b
Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 72fb675a696f4..b9d7bce30061f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -72,6 +72,8 @@
 static_assert(MAX_PRP_RANGE / NVME_CTRL_PAGE_SIZE <=
 	(1 /* prp1 */ + NVME_MAX_NR_DESCRIPTORS * PRPS_PER_PAGE));
 
+DEFINE_IRQ_MODERATION_MODE_PARAMETER;
+
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0444);
 
@@ -1989,6 +1991,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 		result = queue_request_irq(nvmeq);
 		if (result < 0)
 			goto release_sq;
+		IRQ_MODERATION_SET_DEFAULT_MODE(pci_irq_vector(to_pci_dev(dev->dev), vector));
 	}
 
 	set_bit(NVMEQ_ENABLED, &nvmeq->flags);
-- 
2.52.0.rc1.455.g30608eb744-goog


