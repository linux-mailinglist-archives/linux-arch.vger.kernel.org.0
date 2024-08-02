Return-Path: <linux-arch+bounces-5930-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2580945D5E
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 13:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734AA281941
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 11:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2981E287E;
	Fri,  2 Aug 2024 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mmaz96gQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1056E1BF306;
	Fri,  2 Aug 2024 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722599110; cv=none; b=DM+Rc5ffvKF5ym13sYBpQLMxAwjzlCYkOW+LPfoWX9U3Kkx6odWDH2NopoljiLf//Wr6y7c9dR9SpD2E4uLdGSB19RR2ZC9VYlvwCMh3a0jTqciV72Ly0H69c/gXAKo/fvs6vmkBcQYTfFmr9bWxlnQYTYv9v0ZTbmkClN3bMAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722599110; c=relaxed/simple;
	bh=amtPYPnzRa1aroksNv8S0Qo41srI99FBLIdJa5UeVB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uD8PBT3usAY48bt/yk+XJOn4WoYCVa7wLuOllmUkIhzUM32Wm9aTtgtnErcwlZQg0J8Pk5QZsw1qvdiUcr5RB/akp7z1HWY3D1GgjCbbpWAHCY9fvZ3o7ZaeS2XiU67D4IEye6kJ/3BNoaBP3gFG7LL5fQrVY6bhJuGnJum3xjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mmaz96gQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6mhOjOjaHVces5fHVVmQVHl9XJCI2jfaqtHAFlR8yIc=; b=mmaz96gQjgt4RR9Gs5n26LcEdk
	m19xphe1TyPnefPjsyKwS0f6bfdpEPs6jqp7sOAvCtqHqSV/bQoLcSsEyZL29qh4DM+hTqOd7Yvuy
	pe0CpGLAN/YCsYuz70vNDDGDiHodmG+UJumpa/cWMa7J7yvkV41MkiEkeGfOJyCrUhpWRgnHpxxdS
	yFgQfWPS4X5+fV7UFE/7jWJ1vKfu3iRib8yqewIk1R00U2PuoSCTltH4eXrPltv2u7wQ3NW4tyTEs
	8wHbDYKfmgxw4JqCt/HPzaojgVHu/rN2S3cBdKnqDFADQd6m83JnmMS4kObPerDlyqUjGuopWMUwq
	sGxJdAtg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53900)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sZqiB-0006c6-0V;
	Fri, 02 Aug 2024 12:44:43 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sZqi7-00080g-Qb; Fri, 02 Aug 2024 12:44:39 +0100
Date: Fri, 2 Aug 2024 12:44:39 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: arnd@arndb.de, afd@ti.com, akpm@linux-foundation.org,
	linus.walleij@linaro.org, eric.devolder@oracle.com, robh@kernel.org,
	vincent.whitchurch@axis.com, bhe@redhat.com, nico@fluxnic.net,
	ardb@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] ARM: support PREEMPT_DYNAMIC
Message-ID: <ZqzGp14u/XTST8v1@shell.armlinux.org.uk>
References: <20240620090028.729373-1-ruanjinjie@huawei.com>
 <79a3de7c-21da-12ce-8372-9c9029c237ac@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79a3de7c-21da-12ce-8372-9c9029c237ac@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jul 31, 2024 at 10:07:53AM +0800, Jinjie Ruan wrote:
> On 2024/6/20 17:00, Jinjie Ruan wrote:
> > Enable support for PREEMPT_DYNAMIC on arm32, allowing the preemption model
> > to be chosen at boot time.
> > 
> > Similar to arm64, arm32 does not yet use the generic entry code, we must
> > define our own `sk_dynamic_irqentry_exit_cond_resched`, which will be
> > enabled/disabled by the common code in kernel/sched/core.c.
> > 
> > And arm32 use generic preempt.h, so declare
> > `sk_dynamic_irqentry_exit_cond_resched` if the arch do not use generic
> > entry. Other architectures which use generic preempt.h but not use generic
> > entry can benefit from it.
> > 
> > Test ok with the below cmdline parameters on Qemu versatilepb board:
> > 	`preempt=none`
> > 	`preempt=voluntary`
> > 	`preempt=full`
> > 
> > Update preempt mode with debugfs interface on above Qemu board is also
> > tested ok:
> > 	# cd /sys/kernel/debug/sched
> > 	# echo none > preempt
> > 	# echo voluntary > preempt
> > 	# echo full > preempt

Do you have a use case for this feature?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

