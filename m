Return-Path: <linux-arch+bounces-14726-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79730C56D1B
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 11:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 270C235158F
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 10:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A602E11D7;
	Thu, 13 Nov 2025 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BNEqMJ1g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1tLFunv9"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECAC325708;
	Thu, 13 Nov 2025 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763029502; cv=none; b=TyUHBhLyBeoyKboshTIwiJsYMonCcfI6rL6UuOH5fMtUM6BYuGk8Mo62lY4rRSQJb7Z6YICZbDUlyRn8VlRk/g7kQ19cWD4IBaQieKLL2rl0xl0PAt/wkxQdNrCA0fq19wzdDu6fmSTaoh8VUOkw4e2XUlciSO8fv6n8HBfYzUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763029502; c=relaxed/simple;
	bh=AoscNRGqPawBDwd80+Ax6z5GQoU8xk6n8gXX2rQnuSA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ryK2rHIyM1SHHpMlu5Ll9oxryISGPGWD/6iGlADEFB7tg20wTfAaDp38+yFBjF+t3a/q0EVSAU/vN2ry7efeebx3Gy/lhFwoXkpBVQpTShajwEMFjoUVhshKv+2kuKRGrVyRGtIZ2MNApOVZK4BgOB1BLivyKAioi5Ehk1JOctc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BNEqMJ1g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1tLFunv9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763029499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pRe9bYq0l01ci/6XvkwCqudL7VObeTq34jJDo4iJaMw=;
	b=BNEqMJ1gvMgHw9Y18A35VQEU45ihD9S5vWuXlyrDxE5bQyDydr1TlGtYC8Nbpswx3+BUpg
	cYcfHOl6c4uKXx/Z0Pa9Zy0uSrSj1YWjh52TkUhC8IK1IeMiBgJqI2CLjulBm5JF5A2kA0
	pR3XWhv/fuc9FxZTxywz8WBcsCqt80pFDjU57Z9RCRMF1+z7Ra6cQF7HD67so5f7+dPPi9
	I9gmpdfdP4V2XxL+QzcG6miuzwf0G6ynfkbXqmCLJqhqsBVoMLkRB3V999cX4YquwHmnfx
	JKuVgalgOgUGvj/IIsy6kRPdtX1LTYMTEz/lfWec73NruLKQIVii1WtJMUK0Tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763029499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pRe9bYq0l01ci/6XvkwCqudL7VObeTq34jJDo4iJaMw=;
	b=1tLFunv9jHl1Ku5pLEyk3B69oLv6jx+Oggh6gvbMV9WcAayvc8F/eCLmiix8EeQzATHLQC
	yEx6E5c6giVtqcDg==
To: Luigi Rizzo <lrizzo@google.com>, Marc Zyngier <maz@kernel.org>, Luigi
 Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, Sean Christopherson
 <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, Luigi Rizzo
 <lrizzo@google.com>
Subject: Re: [PATCH 2/6] genirq: soft_moderation: add base files, procfs hooks
In-Reply-To: <87346ie0vs.ffs@tglx>
References: <20251112192408.3646835-1-lrizzo@google.com>
 <20251112192408.3646835-3-lrizzo@google.com> <87346ie0vs.ffs@tglx>
Date: Thu, 13 Nov 2025 11:24:58 +0100
Message-ID: <87h5uycjr9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 13 2025 at 10:29, Thomas Gleixner wrote:
> On Wed, Nov 12 2025 at 19:24, Luigi Rizzo wrote:
>> +static void set_moderation_mode(struct irq_desc *desc, bool mode)
>> +{
>> +	if (desc) {
>
> Why would desc be NULL?
>
>> +		struct irq_chip *chip = desc->irq_data.chip;
>> +
>> +		/* Make sure this is msi and we can run enable_irq from irq context */
>> +		mode &= desc->handle_irq == handle_edge_irq && chip && chip->irq_bus_lock == NULL &&
>> +				chip->irq_bus_sync_unlock == NULL;

Q: How does this make sure that it is MSI?
A: Not at all

Q: How is this protected against concurrent modification?
A: Not at all

>> +		if (mode != desc->moderation_mode)
>> +			desc->moderation_mode = mode;

This conditional is truly making a difference.

Thanks

        tglx

