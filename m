Return-Path: <linux-arch+bounces-14721-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 499F3C56A6D
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 10:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F4F13499B7
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 09:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5040B2D6E78;
	Thu, 13 Nov 2025 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i2OcYL/0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HLCfmX9D"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43B32C327A;
	Thu, 13 Nov 2025 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026841; cv=none; b=K4aJ+aj/ZD7h3HiCFWP+l4USACgQmJzlXFrUscDtorLPpKW3Kin1ZEP9AvwCnM6LqA/FDkkhVUYPJH9rUsuo0kN50fnPcV4aI91Z4ojmJdfX+wMXxfEHbm4ZftVtG2o4vIE6jNWeKmFEqio/L+Xnkt+See52TqFHeVJHvFC4h0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026841; c=relaxed/simple;
	bh=IkgqqnXk5PmNq5RMYlC3L++CSmxPv0rYo3MTnQtThVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mLitsu6Es3TmQUW56n/QhSpCjFMnmJhlSW3tryt651pZljxEbMJm/JJYkWiHu3B2FA2NmkpibC2UOVhubZhlQasNzTgZu5u5RPQNQBdHqcAxoErMWDnzIO97yhsIh6pK15B5RD+ip6RTlKaJgt0yHGHZfZbQfqDJm1m9lQCm6fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i2OcYL/0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HLCfmX9D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763026837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VU8hU3Pos79bAWucqZLoNJdgDrQIvlXKx3SEWOXiE9E=;
	b=i2OcYL/0yU//MaEu9ci362cLND+GZp0hxZZkT/1hFy5kMs2GsR+TyuYXcxJlyrB3Wsf/GL
	jt2AF8YVLHtxAObzbF8w/N9qohaZALehuA8TEZZDhGKE9f0i7L3RNkdP3pWjrw3qjprAZS
	ZBlz83nQrWI60HqnWNm0kG/6hXdf2GAJjLckOToBvdsVOrwSAqE/sh1zmGxpt6uKMTqe1X
	nRwLETncKNTwjbqnlQC6jkdJ9qYU0QNdM6XNEpPZALSSq7SMQ0g/WUmMXgUZBp48wyE576
	y151T81y9Q/L/h+oXZpO5KIaiW3BeOZoGywE15niiPqHU4LuEsaKP9TCRDd+9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763026837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VU8hU3Pos79bAWucqZLoNJdgDrQIvlXKx3SEWOXiE9E=;
	b=HLCfmX9D/NWjAMgLMB5otMjf3HFks2Lc2WtzEZlRWok1atftT5Rvto/g6WAK7VkQvdEfp1
	s5RYlZdF2wrrkXAA==
To: Luigi Rizzo <lrizzo@google.com>, Marc Zyngier <maz@kernel.org>, Luigi
 Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, Sean Christopherson
 <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, Luigi Rizzo
 <lrizzo@google.com>
Subject: Re: [PATCH 2/6] genirq: soft_moderation: add base files, procfs hooks
In-Reply-To: <20251112192408.3646835-3-lrizzo@google.com>
References: <20251112192408.3646835-1-lrizzo@google.com>
 <20251112192408.3646835-3-lrizzo@google.com>
Date: Thu, 13 Nov 2025 10:40:36 +0100
Message-ID: <87y0oaclt7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 12 2025 at 19:24, Luigi Rizzo wrote:
> Add the main core files that implement soft_moderation, limited to static
> moderation, plus related small changes to include/linux/interrupt.h,
> kernel/irq/Makefile, and kernel/irq/proc.c
>
> - include/linux/irq_moderation.h has the two main struct, prototypes
>   and inline hooks

And none of this should be in a global visible header. All of that is
only relevant to the core interrupt code, so that want's to be a core
local header file.

Thanks,

        tglx

