Return-Path: <linux-arch+bounces-14725-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26323C56CF4
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 11:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 211FD4E3D4D
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 10:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F4922578D;
	Thu, 13 Nov 2025 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M7Lj1st/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dOY1ZsMr"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6961035CBAF;
	Thu, 13 Nov 2025 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763029127; cv=none; b=YttgSu9eyNmsBfermkCyvLoy2BSNwgPAXCS3k7BPpGwu9Mb+5LJnN0oAGVIykYYWZyH2BoccN0eUYlxDAvQl7ILd3WjaLrhOqv832Dm348OSeRZsJZbDdwRDZ2mqGeobKYKws/TlpUVreRlPIJLQJcVVW77yk+JhNK1/UnwnYQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763029127; c=relaxed/simple;
	bh=LJGBzkpvbORrmNtfquLx7qWbEnyjNYbu81Pl10pBGxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YOl1ENBq1j6kh6g3TAWTBVa6BQLwcNXwYoF7subr3fylawNppGqDFD9aqhebdJ/Fa5rR5yQ4btrdrrV4vXE6Uunw/e8vcGDOm4Xm0suH/67uTcWEfXnOGOtPc46Z1ENWuLaiOF2jAb8ctlm8zuFB+ZFSqlWR6D6nxGQIWsUoaCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M7Lj1st/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dOY1ZsMr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763029124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NcsDVZsBhQkgJbWn/k4TOWkjECO/uEWNKITsrhWHd00=;
	b=M7Lj1st/qtCIasRa2Z048ekBYT/+/8EUym0tNiCC+BWUeDu1WofBDdb3gs8WOhEn4SAg/V
	ZPgK8pGdAe/PPW37mL4NwoZ5HNP8d/ckeGcOnAu8WQaKW15vuSXLvQmXlXcNMIEq6OpmLE
	kGOAHsEXCauFmTq4/UfSMH4c3zN/UkBkFDigUbFKisKI+kBebIZP2/3ghijD7ZIx6qIsK1
	WhJQpagijXQaitTQRK5G96UQ2k8Bq9EMAbjuP5FbxAD0rEG8zbtJc15R2fTYzh6r5Gf08r
	5SO/UzAQSvi86/Zy8JLEMVtYwfy7VPFbT3IbE7Nyq4KCtesTlMxCod3TF8WhRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763029124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NcsDVZsBhQkgJbWn/k4TOWkjECO/uEWNKITsrhWHd00=;
	b=dOY1ZsMrBwgrsqXxiISAs7CWXPiA+gcp2s1cnXvBaID+J+jeTzX5ZugguFql0UeLWDR3m+
	VWWuAFzyXvRU+8CA==
To: Luigi Rizzo <lrizzo@google.com>, Marc Zyngier <maz@kernel.org>, Luigi
 Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, Sean Christopherson
 <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, Luigi Rizzo
 <lrizzo@google.com>
Subject: Re: [PATCH 6/6] genirq: soft_moderation: implement per-driver
 defaults (nvme and vfio)
In-Reply-To: <20251112192408.3646835-7-lrizzo@google.com>
References: <20251112192408.3646835-1-lrizzo@google.com>
 <20251112192408.3646835-7-lrizzo@google.com>
Date: Thu, 13 Nov 2025 11:18:43 +0100
Message-ID: <87ldkack1o.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 12 2025 at 19:24, Luigi Rizzo wrote:
> Introduce helpers to implement per-driver module parameters to enable
> moderation at boot/probe time.
>
> As an example, use the helpers in nvme and vfio drivers.
>
> To test, boot a kernel with
>
> ${driver}.soft_moderation=1 # enables moderation.
>
> and verify with "cat /proc/irq/soft_moderation" that
> the counters increase.
>
> Change-Id: Iaad4110977deb96df845501895e0043bd93fc350
> ---
>  drivers/nvme/host/pci.c           |  3 +++
>  drivers/vfio/pci/vfio_pci_intrs.c |  3 +++
>  include/linux/interrupt.h         | 13 +++++++++++++
>  kernel/irq/irq_moderation.c       | 11 +++++++++++

Again a pile of randomly picked files. The proper way is documented:

   1) Add infrastructure first

   2) Use infrastructure in drivers, one patch per subsystem

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 72fb675a696f4..b9d7bce30061f 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -72,6 +72,8 @@
>  static_assert(MAX_PRP_RANGE / NVME_CTRL_PAGE_SIZE <=
>  	(1 /* prp1 */ + NVME_MAX_NR_DESCRIPTORS * PRPS_PER_PAGE));
>  
> +DEFINE_IRQ_MODERATION_MODE_PARAMETER;
> +
>  static int use_threaded_interrupts;
>  module_param(use_threaded_interrupts, int, 0444);
>  
> @@ -1989,6 +1991,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
>  		result = queue_request_irq(nvmeq);
>  		if (result < 0)
>  			goto release_sq;
> +		IRQ_MODERATION_SET_DEFAULT_MODE(pci_irq_vector(to_pci_dev(dev->dev), vector));

What's the point of this IRQ_MODERATION_SET_DEFAULT_MODE() wrapper?

Thanks,

        tglx

