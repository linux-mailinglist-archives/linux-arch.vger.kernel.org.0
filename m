Return-Path: <linux-arch+bounces-5765-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C48942BC4
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 12:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960B31F2307C
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 10:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D48E1AAE24;
	Wed, 31 Jul 2024 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fjZt/u+B"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BF053370;
	Wed, 31 Jul 2024 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420931; cv=none; b=sO5bTrQ+RAcnVqFHiDW4v3uO3xdK3YZSiCxTZmCKyAMod8AvCTIdy/pWdcM+Aw79h8wDD3i3/Hwyu+QhOmVvNXBkMw9uCZsLzUnkHswILJblcohDA/qN5NsmWHKOvgdOo+E9Plp/RyEo2gZ+N99f6BCd1uE2zGA7a0XZF6QZowc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420931; c=relaxed/simple;
	bh=z+VQEntqBxo5Gd2LvLOmLC4MpGmQveBzWyM3KmPsLAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqfkTJcZ2j+ghZC5nak4DTKU1r5Jvss66xaFX6/3ki+6rXPgvCVph0Klw4EJxTDu20XQkXAOZq0C4n/ENmEglfqr5EXnLbdG81R90M59sks97f999JRbc/aWW/zdTnGsjdYA+Dh3BgEaSNF8/k7aoT3pYqCD1CFjTYFkIp6GGmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fjZt/u+B; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qMBM7pjQFwnbFVqnUX8SB3vfklTZ2ocTvkMoeIJbxQ4=; b=fjZt/u+BQ9Vz/yMivaqlHmM58H
	OgLS6W+bfy2IQA0xkn3anddDj+f5ij2o3A9jTJHE96XREjU3SE0wSBJhRhZScfR9ZtdrT5Q5ni8cr
	7pu7f7uEwLsruVT2u60fxv9OUHIJt1ZQsIvCrKPpx5gwjWcTx4WxDewRAEKyXWl/tm3WcGLvK7GDu
	ikow8z5kDrgmUGvoLWpdNsZHBamXkCPMVVumCAVXgRfKS20GQdJCVKMY9S8CVvDDXOFdUs1rTmzJ6
	xbvjYTgPJTt7Qp2zA0PNedoTQBkcVPyEaHr7SalzMkgtBUyGbOzSZgRPFK0Xjmh2mWCBUDaUcmrsh
	zm7ia9JQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47592)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sZ6ME-00005e-0w;
	Wed, 31 Jul 2024 11:14:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sZ6MD-00067m-VX; Wed, 31 Jul 2024 11:14:58 +0100
Date: Wed, 31 Jul 2024 11:14:57 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: arnd@arndb.de, afd@ti.com, akpm@linux-foundation.org,
	linus.walleij@linaro.org, eric.devolder@oracle.com, robh@kernel.org,
	vincent.whitchurch@axis.com, bhe@redhat.com, nico@fluxnic.net,
	ardb@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] ARM: support PREEMPT_DYNAMIC
Message-ID: <ZqoOoUPDIeJX5M0e@shell.armlinux.org.uk>
References: <20240620090028.729373-1-ruanjinjie@huawei.com>
 <79a3de7c-21da-12ce-8372-9c9029c237ac@huawei.com>
 <Zqn0wL5iScf455O5@shell.armlinux.org.uk>
 <034499ea-2cd6-8775-ee94-771cbecd4cdb@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <034499ea-2cd6-8775-ee94-771cbecd4cdb@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jul 31, 2024 at 06:03:11PM +0800, Jinjie Ruan wrote:
> On 2024/7/31 16:24, Russell King (Oracle) wrote:
> > On Wed, Jul 31, 2024 at 10:07:53AM +0800, Jinjie Ruan wrote:
> >>>  #ifdef CONFIG_PREEMPTION
> >>> +#ifdef CONFIG_PREEMPT_DYNAMIC
> >>> +	bl	need_irq_preemption
> >>> +	cmp	r0, #0
> >>> +	beq	2f
> >>> +#endif
> > 
> > Depending on the interrupt rate, this can be regarded as a fast path,
> > it would be nice if we could find a way to use static branches in
> > assembly code.
> It seems to be hard to use static keys in assembly code.
> 
> By the way, currently, most architectures have simplified assembly code
> and implemented its most functions in C functions. Does arm32 have this
> plan?

arm32 is effectively in maintenance mode; very little active development
is occuring. So, there are no plans to change the code without good
reason (as code changes without reason will needlessly affect its
stability.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

