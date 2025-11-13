Return-Path: <linux-arch+bounces-14722-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B22CCC56AB5
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 10:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65983350604
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 09:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D9E2D5C6C;
	Thu, 13 Nov 2025 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cXls27nn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QmLGy+S5"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F181F5EA;
	Thu, 13 Nov 2025 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763027091; cv=none; b=icZd3IiB60ATFlM4KCqSy0n6ff9BHC/sAXmNTVVft/DFqeVxIpIqftU8u5BdLXirW4AoVZAITMJVMqscY0/Kj1oV6AT+9UlN5/EnlmPmnhnDjfMV+pd1jb3u5T4JJRyMfDpXmB6krlTe7nkIgak3HgotLLxp64Pa6lcPjO/vuAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763027091; c=relaxed/simple;
	bh=isJRoUWxxLJpFKzvjpSpHQE5Dp+Bzdjh9JrmSx8aVSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z6zV41AOEu4sRad8VJG7HTOYNcH2tCNZRTKB2dN1j0LjL9Xmc9TQTO5spq1bHrT0ZVajwOYyRUxCuW+JTbf8zlbW8Svh2z8D991Gau3bRQgy3GT7aS3TyhVFumeWt51mmJ9jGekhjWJoQT6Y+bCDwb3y/kldro/Y+hHlF3X7J3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cXls27nn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QmLGy+S5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763027087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HAViy+O6ujFPIGv4atGIGSm6pw/WKs36Nmn/Lo0d928=;
	b=cXls27nn3dp8sF/4bGcZUaDPU2K+GF7oMaepZ7WYCx0mENG/DdbK3WK9+36NqZmt1/fj5B
	+gPVBMdraYJ5e43cIqlZWknPa0V3optuw89PcFk4p89VlvxDJ55Fu5/EFqQT7bnvlTQYze
	XXFDwzUxlyEMCsSmhxr5V5LozXMdnmF25EuTs5WE8mdxrZd2NZpKbJIdFsbCVWDoq6NRvx
	BAFb8J+cjjS0QftsTO2BBETvtKUPOA/pIX1LPVZOxDh7Qb8uxSylfgeJ30UjHvfHlGj0js
	teKQiccIqOjIkbXjCk0e989anAjy38i5bjw1QD8PFE/eCvi7eUDBkiMKI6+LPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763027087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HAViy+O6ujFPIGv4atGIGSm6pw/WKs36Nmn/Lo0d928=;
	b=QmLGy+S5kxnQbEl0+zytVFgmWe11jBMBeW+QrJ7xZ3fkOkFbIfm9QGefRuFy4t1dzB2B4G
	wF3gLPI+6t0gkPCQ==
To: Luigi Rizzo <lrizzo@google.com>, Marc Zyngier <maz@kernel.org>, Luigi
 Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, Sean Christopherson
 <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, Luigi Rizzo
 <lrizzo@google.com>
Subject: Re: [PATCH 1/6] genirq: platform wide interrupt moderation:
 Documentation, Kconfig, irq_desc
In-Reply-To: <20251112192408.3646835-2-lrizzo@google.com>
References: <20251112192408.3646835-1-lrizzo@google.com>
 <20251112192408.3646835-2-lrizzo@google.com>
Date: Thu, 13 Nov 2025 10:44:45 +0100
Message-ID: <87v7jeclma.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 12 2025 at 19:24, Luigi Rizzo wrote:
> +# Support platform wide software interrupt moderation
> +config IRQ_SOFT_MODERATION
> +	bool "Enable platform wide software interrupt moderation"

Lacks 'depends on PROCFS' 

