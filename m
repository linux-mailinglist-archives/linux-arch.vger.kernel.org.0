Return-Path: <linux-arch+bounces-4727-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590C98FE2F1
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2024 11:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2932838C1
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2024 09:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273211514E7;
	Thu,  6 Jun 2024 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MATPO10Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YGCAIQIF"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D1713C676;
	Thu,  6 Jun 2024 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666447; cv=none; b=tfca36MbpJusgtPj1q2UWuGBEvbB3BGcy2JnOUZ7oJ5s9/BrOEbb8wuYRj6jJ4qaXxmgdCYrczgCUQeyt/KKlV9CLdRboY6KHXTxeWMmxD4JIBPsWmF4RIPIPOYG1+9VwE4FtXYA7OzyoloiCRE9HDYyoFAbdEjWAgQ16O0b9MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666447; c=relaxed/simple;
	bh=7CsufZK2miEU5UnmC5oGSmYNS+ai0Uwb0uhJhcKAtRo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ywfjb1WfPRLuVCJ2YD6JL3W/P6Klq9n7Z5PfqRmHf0Tb3G8ejpyRfVBjaaTj8OJ95atp8h6j2xxWhlEQJ9j2oayYkcT/RALcvZ35dVN1atHRUH1M6OikLlrHGDLGQZX+CZChzkhaoFXG4MDFd6Gc+3irt7YgXb0eniT7KI1SKVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MATPO10Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YGCAIQIF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717666443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GI0Ast9VZDly/xi6jCxjuQpHUZTGPm46ngg6M3zfBXs=;
	b=MATPO10QOHKv4k4VQnrpfoCLSbqRmbY7gqT/F7T0Lc/2E7Du63oB8161P4q5JWozu3fZnB
	V9RDyzJh7XWLYDycTqRoUWo2plgch3aRjBVw4XZSkNQNjZvqWHAT9K73qLd8nN0rKfCezR
	Bp18ybroip0aRG4RB4z2CLeZ5dBwCqJ129sBCgauC9Ok0NyqMbHNvXlLWaGPfMJDdgC1aW
	1SCPm4PXh9MoYg0TniyHUitOsT2qoJgTjF2aFxkh2/JlM+j4ONJmcdKHivsjP+Q4SU/D6g
	cfGOJyLnD7ell8quwLO5W77UB0wdhQtYpvI8JHvTB8xeEEA7ZtyGSV72RTe36Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717666443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GI0Ast9VZDly/xi6jCxjuQpHUZTGPm46ngg6M3zfBXs=;
	b=YGCAIQIFH0BDyKRWYSb4HAgVmuTgJ2BKHKaHx9TT01zEtsSvWNKJWbqK6SEyypSe+CHCDb
	ASnT1HJAMDuvaFBA==
To: Michael Kelley <mhklinux@outlook.com>, "kys@microsoft.com"
 <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
 <decui@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
 "hpa@zytor.com" <hpa@zytor.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
 <robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: "maz@kernel.org" <maz@kernel.org>, "den@valinux.co.jp"
 <den@valinux.co.jp>, "jgowans@amazon.com" <jgowans@amazon.com>,
 "dawei.li@shingroup.cn" <dawei.li@shingroup.cn>
Subject: RE: [RFC 06/12] genirq: Add per-cpu flow handler with conditional
 IRQ stats
In-Reply-To: <SN6PR02MB4157AD9DE6D3F45EC5F5595DD4FA2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240604050940.859909-1-mhklinux@outlook.com>
 <20240604050940.859909-7-mhklinux@outlook.com> <87h6e860f8.ffs@tglx>
 <SN6PR02MB415737FF6F7B40A1CD20C4A9D4F82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87zfrz4jce.ffs@tglx>
 <SN6PR02MB415706390CB0E8FD599B6494D4F92@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87cyov4glm.ffs@tglx>
 <SN6PR02MB4157AD9DE6D3F45EC5F5595DD4FA2@SN6PR02MB4157.namprd02.prod.outlook.com>
Date: Thu, 06 Jun 2024 11:34:03 +0200
Message-ID: <87le3i2z5g.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jun 06 2024 at 03:14, Michael Kelley wrote:
> From: Thomas Gleixner <tglx@linutronix.de> Sent: Wednesday, June 5, 2024 7:20 AM
>> 
>> On Wed, Jun 05 2024 at 13:45, Michael Kelley wrote:
>> > From: Thomas Gleixner <tglx@linutronix.de> Sent: Wednesday, June 5, 2024 6:20 AM
>> >
>> > In /proc/interrupts, the double-counting isn't a problem, and is
>> > potentially helpful as you say. But /proc/stat, for example, shows a total
>> > interrupt count, which will be roughly double what it was before. That
>> > /proc/stat value then shows up in user space in vmstat, for example.
>> > That's what I was concerned about, though it's not a huge problem in
>> > the grand scheme of things.
>> 
>> That's trivial to solve. We can mark interrupts to be excluded from
>> /proc/stat accounting.
>> 
>
> OK.  On x86, some simple #ifdef'ery in arch_irq_stat_cpu() can filter
> out the HYP interrupts. But what do you envision on arm64, where
> there is no arch_irq_stat_cpu()?  On arm64, the top-level interrupt is a
> normal Linux IRQ, and its count is included in the "kstat.irqs_sum" field
> with no breakout by IRQ. Identifying the right IRQ and subtracting it
> out later looks a lot uglier than the conditional stats accounting.

Sure. There are two ways to solve that:

1) Introduce a IRQ_NO_PER_CPU_STATS flag, mark the interrupt
   accordingly and make the stats increment conditional on it.
   The downside is that the conditional affects every interrupt.

2) Do something like this:

static inline
void __handle_percpu_irq(struct irq_desc *desc, irqreturn_t (*handle)(struct irq_desc *))
{
	struct irq_chip *chip = irq_desc_get_chip(desc);

	if (chip->irq_ack)
		chip->irq_ack(&desc->irq_data);

	handle(desc);

	if (chip->irq_eoi)
		chip->irq_eoi(&desc->irq_data);
}

void handle_percpu_irq(struct irq_desc *desc)
{
	/*
	 * PER CPU interrupts are not serialized. Do not touch
	 * desc->tot_count.
	 */
	__kstat_incr_irqs_this_cpu(desc);
	__handle_percpu_irq(desc, handle_irq_event_percpu);
}

void handle_percpu_irq_nostat(struct irq_desc *desc)
{
	__this_cpu_inc(desc->kstat_irqs->cnt);
	__handle_percpu_irq(desc, __handle_irq_event_percpu);
}
 
So that keeps the interrupt accounted for in /proc/interrupts. If you
don't want that remove the __this_cpu_inc() and mark the interrupt with
irq_set_status_flags(irq, IRQ_HIDDEN). That will exclude it from
/proc/interrupts too.

Thanks,

        tglx

