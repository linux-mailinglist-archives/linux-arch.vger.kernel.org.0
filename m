Return-Path: <linux-arch+bounces-4711-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909258FD0AC
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 16:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F503287623
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 14:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0347910A36;
	Wed,  5 Jun 2024 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2inVvOWu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1hc7ph2l"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504EC17BCD;
	Wed,  5 Jun 2024 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717597178; cv=none; b=Bdex5Ceng0E8YD5ZsrKGEAiPSkB6MQi6nXKCHisVgdTQhx2O24FVptlPM7vGy1qD6iah3BnpTr411okE/lXQUnyc05Xye/mna8ECruF8G42+7pvvIbJZiQ7I9hXggpgB1CWs41s1+cP7cmchrHBhoGV75QIQLMqxBqHgkB11td0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717597178; c=relaxed/simple;
	bh=6URTEerfkdzLvqFcLf0HfIhwY4ccOG/H9zSR0R5rh18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dPEy1dPagDxBJFAHkpfS7Q0Go1WecIkwpL5Xxi7ULTto2SXNJEyTd0EJ5expvW1KtBR2/eACgkMcVQT07q0b6PPhzUfjhYqB470j09PXjmxJu9GyhN71e8kZFKc5/lnJbiS7MPE1lqV5ZLvG3wBtgE2dhPH9BLmr/SncEpzmOXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2inVvOWu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1hc7ph2l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717597173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t0o5pyoMUAS+Hj4ypHyiKCTLmAk7b8HOBNFgUfxaG+0=;
	b=2inVvOWu3HafMPDKsb+qpF7AzcwPeqf+JH+8bF9kRSdqDzzaaku3ordzvLSUIWDvdfcEoj
	SPaeek8iNZF8xz/3ZfaME/ZUVxpuqcaypIs1CzrRizlEU/i02qTJYH0S8XcDTLiu+JbCHq
	ZrrPyEn1xY3N0QsZJxMPeIPTySHdC1M/7eiTpZIBCNM92mz3kqIs6ZcPqQP4ep6XPDEG/9
	RykbrOlFQtdrI+tl3ju5PWpdJW8JQ8psPivXVdTF6lsxdYKKTTTt6FUk0Ahr4oxW1ySkSI
	ocetbrzCRqfAO0gHv1rWrvd4iwKcyiFCMTZn6ZjbXbcDz5BvnGT6IE77Ej4S/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717597173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t0o5pyoMUAS+Hj4ypHyiKCTLmAk7b8HOBNFgUfxaG+0=;
	b=1hc7ph2lzRvvkR/40ZQ5c0U6Xp36HKvb3qaHbKRSkMdKXAKUOWynQr6Xh4YfQxYICLEVyg
	nsrwj93w2GG5ZmCQ==
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
In-Reply-To: <SN6PR02MB415706390CB0E8FD599B6494D4F92@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240604050940.859909-1-mhklinux@outlook.com>
 <20240604050940.859909-7-mhklinux@outlook.com> <87h6e860f8.ffs@tglx>
 <SN6PR02MB415737FF6F7B40A1CD20C4A9D4F82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87zfrz4jce.ffs@tglx>
 <SN6PR02MB415706390CB0E8FD599B6494D4F92@SN6PR02MB4157.namprd02.prod.outlook.com>
Date: Wed, 05 Jun 2024 16:19:33 +0200
Message-ID: <87cyov4glm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jun 05 2024 at 13:45, Michael Kelley wrote:
> From: Thomas Gleixner <tglx@linutronix.de> Sent: Wednesday, June 5, 2024 6:20 AM
>
> In /proc/interrupts, the double-counting isn't a problem, and is
> potentially helpful as you say. But /proc/stat, for example, shows a total
> interrupt count, which will be roughly double what it was before. That
> /proc/stat value then shows up in user space in vmstat, for example.
> That's what I was concerned about, though it's not a huge problem in
> the grand scheme of things.

That's trivial to solve. We can mark interrupts to be excluded from
/proc/stat accounting.

Thanks,

        tglx

