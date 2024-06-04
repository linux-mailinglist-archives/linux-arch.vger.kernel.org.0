Return-Path: <linux-arch+bounces-4686-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DAA8FBB56
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 20:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 093761C21AA1
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 18:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFA684A33;
	Tue,  4 Jun 2024 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yWklZzVM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i5UbluQk"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2391474A5;
	Tue,  4 Jun 2024 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524847; cv=none; b=lwYbRqa+f2k9epQc0hVvR9XveBpCwaPKj/xAAFxu8LjgBmRdLtcA5iZ0hu2kZLInp314KKDjzGUcQh+E2TcXyaY6KrE8XurDz6M22aAUiWCWzwGvKdskStRUNSYiVoKNDhBwONXo997cg5JBTpfDdW64QB/K89zO/2hV6bMxUsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524847; c=relaxed/simple;
	bh=IQorAkEYVe7up2fEOE5YbCTLI6WLK8ATjBO+3so6jGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yc5VsutnOE8VkhiSnqbySgodd4+uZVhuYYZdEotTCxIGUnJXv5NcEhcEOiK+nu6umw9RHbOaBBIYT3CMB6n3qlxKw8n39jtni05EwiYLBTtalhQ592uzCHOaAHvIXJ6okgY68wn7Gu9DWozoUyaHt+ITmhSJpUYzB5het8Nc+Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yWklZzVM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i5UbluQk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717524843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=prqacbQcjn+n2e778DNwJeCBy7KaYouq/VzGoavNVk0=;
	b=yWklZzVMpbVPvo1jsg92p8nTHAt1+QsyoNE2Jqvzm/GJhF53kUgNnWEK0/VSjE0lInxBJk
	6QlzenLDS2bav5DZMTXwghTPabby9O+Wcn35RIM7N6SXchmN56eQo8ZWJwhBjlIZDjuFH9
	C1eQu+zyGFJMIMi31hmA/cNS7thPysEDB59EtjIeQzMz4zvgZtezwUHwX8/SLdOwSXVUHn
	OtUjg4nSWaY3qhLzt0nT+GEKGWP6cst3YplGGVzD31cO2/vRebBzO6atGsGw6RjAGFdRm0
	cDlWXOc+XUPHbzxbl16+md+qkDOExEqrlMk4CaWP/sy+tPRW4/uWvKUdypWiZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717524843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=prqacbQcjn+n2e778DNwJeCBy7KaYouq/VzGoavNVk0=;
	b=i5UbluQk14qgiFhIoUjI4lmomrHRuLLynuD8lVZmZelI6F0yTli9Pi7qVDz6qBXyjFmMV7
	DzFuKq0VCpesHjCg==
To: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 arnd@arndb.de, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-arch@vger.kernel.org
Cc: maz@kernel.org, den@valinux.co.jp, jgowans@amazon.com,
 dawei.li@shingroup.cn
Subject: Re: [RFC 06/12] genirq: Add per-cpu flow handler with conditional
 IRQ stats
In-Reply-To: <20240604050940.859909-7-mhklinux@outlook.com>
References: <20240604050940.859909-1-mhklinux@outlook.com>
 <20240604050940.859909-7-mhklinux@outlook.com>
Date: Tue, 04 Jun 2024 20:13:47 +0200
Message-ID: <87h6e860f8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael!

On Mon, Jun 03 2024 at 22:09, mhkelley58@gmail.com wrote:
> Hyper-V VMBus devices generate interrupts that are multiplexed
> onto a single per-CPU architectural interrupt. The top-level VMBus
> driver ISR demultiplexes these interrupts and invokes per-device
> handlers. Currently, these per-device handlers are not modeled as
> Linux IRQs, so /proc/interrupts shows all VMBus interrupts as accounted
> to the top level architectural interrupt. Visibility into per-device
> interrupt stats requires accessing VMBus-specific entries in sysfs.
> The top-level VMBus driver ISR also handles management-related
> interrupts that are not attributable to a particular VMBus device.
>
> As part of changing VMBus to model VMBus per-device handlers as
> normal Linux IRQs, the top-level VMBus driver needs to conditionally
> account for interrupts. If it passes the interrupt off to a
> device-specific IRQ, the interrupt stats are done by that IRQ
> handler, and accounting for the interrupt at the top level
> is duplicative. But if it handles a management-related interrupt
> itself, then it should account for the interrupt itself.
>
> Introduce a new flow handler that provides this functionality.
> The new handler parallels handle_percpu_irq(), but does stats
> only if the ISR returns other than IRQ_NONE. The existing
> handle_untracked_irq() can't be used because it doesn't work for
> per-cpu IRQs, and it doesn't provide conditional stats.

There is a two other options to solve this:

   1) Move the inner workings of handle_percpu_irq() out into
      a static function which returns the 'handled' value and
      share it between the two handler functions.

   2) Allocate a proper interrupt for the management mode and invoke it
      via generic_handle_irq() just as any other demultiplex interrupt.
      That spares all the special casing in the core code and just
      works.

Thanks,

        tglx

