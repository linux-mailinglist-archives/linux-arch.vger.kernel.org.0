Return-Path: <linux-arch+bounces-15488-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C11ACC9654
	for <lists+linux-arch@lfdr.de>; Wed, 17 Dec 2025 20:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA0233004F6C
	for <lists+linux-arch@lfdr.de>; Wed, 17 Dec 2025 19:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71C421257A;
	Wed, 17 Dec 2025 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1DtHMhbp"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4347A7262B;
	Wed, 17 Dec 2025 19:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765999086; cv=none; b=OvDnvqfH+bdhqx6lLzXVCS2SVoHgaWbZe0l6VaZ9ySVPyDc3sHhMdj8FB1VGQoAVKbBv8RJh+pr7i3tee6bTfMdTMZ2bm3BqhZBL84t5FhU65yj+1ck68gZOyXy7YcHt8LE3Eu4ItqmoR83MAOE9UeWQr3YW9GkD4ceFADjq3yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765999086; c=relaxed/simple;
	bh=DsG0BI4mUD2DwSSKg7W0p0QGoLuP5vCs2zTIGHvZN4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwv7mIHTFzH6vV/zNl1zCs+in5jbOZPn6L3RVpIxHlelTw6roLB6egRGOpgwL4c0N5h+cv2PGZrqlY7X91nN2CKOYu4r2qngMD+9nJNiIxkGFRQhbsTzJ4fHWclJwmO04Xckv58LgpbZ6bP0WjWFPbBkc4JyEwUSbEEgjCZQn0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1DtHMhbp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=QtH1btA5f/fUGBE+reiIDzXtrb4CiULa1zc5KJOMbHM=; b=1DtHMhbpzm8yshwB0tj0/wckd6
	NNyTVGDL1rwRMVFcj1vgKfKhC3WTGI8xZVF50IJNmyH7cPXobnwXrIXByJwsWbzqIKs9ksuSlEz+v
	TJ07ESHMmDnTrZHXzPcMcj1+3UwRc5oR5/bBsxh85Zo7caj7iAS79qpz3F8xpn46+7/H31Y70/ZLM
	O1LHRykZok7pnoZiWhU0VwVdi7AVL7sBjuoeyLmFtnBAUlXrkIBeJuz3YmAtb5I/1IbtLq35VYi+C
	cPz5i1zH52Emhe9Opx4Mh/7fuf1P1TNE5/Oiw55FqnKEZ/14tmKSUh3Jbh6gqvRouAX9MtPUe7eAL
	TDFAteug==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVx26-00000007JeQ-3poI;
	Wed, 17 Dec 2025 19:17:58 +0000
Message-ID: <15fdb116-fbb1-47d0-8bb4-c1d97a99fee7@infradead.org>
Date: Wed, 17 Dec 2025 11:17:58 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-v3 1/3] genirq: Fixed Global Software Interrupt Moderation
 (GSIM)
To: Luigi Rizzo <lrizzo@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Sean Christopherson <seanjc@google.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>
References: <20251217112128.1401896-1-lrizzo@google.com>
 <20251217112128.1401896-2-lrizzo@google.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251217112128.1401896-2-lrizzo@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/17/25 3:21 AM, Luigi Rizzo wrote:
> diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
> index 1b4254d19a73e..c258973b63459 100644
> --- a/kernel/irq/Kconfig
> +++ b/kernel/irq/Kconfig
> @@ -155,6 +155,18 @@ config IRQ_KUNIT_TEST
>  
>  endmenu
>  
> +# Support platform wide software interrupt moderation
> +config IRQ_SOFT_MODERATION
> +	bool "Enable platform wide software interrupt moderation"
> +	depends on PROC_FS=y
> +	help
> +	  Enable platform wide software interrupt moderation.
> +	  Uses a local timer to delay interrupts in configurable ways
> +	  and depending on various global system load indicators
> +	  and targets.
> +
> +	  If you don't know what to do here, say N.

s/platform wide/platform-wide/g
(3 places)

-- 
~Randy


