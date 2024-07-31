Return-Path: <linux-arch+bounces-5757-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FEC942916
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 10:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D35A2823AD
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 08:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC581A71F7;
	Wed, 31 Jul 2024 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qPifwyiA"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1215D18A6A3;
	Wed, 31 Jul 2024 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722414304; cv=none; b=DAx+ugOPOImPXsInzeZqBi6uZkioWYoY+qOzZ4C+3zUlOGTDYD8lpp+STzfNsFHJ1pT6YweI9ywRL66ybMUkdcHh10qj4TdoqQTMHPqywqoQB2f1PAJ/jW4gDUvS4qEL4TXVNpF9uwicXmM+QytqNdapwIe2OZ07rGUzsgKgHOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722414304; c=relaxed/simple;
	bh=V/qMid1eZAZ9KqR4unGjgGs1o2BzZRAEjRLlRpm8Vdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQZysK/hiTWK/v4qyLBgmxpR7UTuycJ36DNuHoRxem6cpijJ3fkOqiQVF3iCHmyza7+l07CGdLLk6PFNWJLFbqzyDczNq9uRbCSrvRJTzUhUlb4F8iM1gGgYRykHbYbQP2uK8YSRMnUFudGtLzHzXdWSkAJLh5EOBKVgBRrUqDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qPifwyiA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9Ohyf01z+RQdbQQcz4+PP/EvJqHgnb9g8adgwYo0As8=; b=qPifwyiAX5xb8gnHPkVc5vS3zC
	RT5FqN29h0hS/WprOebZI85qTmsYpZaejB9WhdNcrwsxSdYSJI0QSgn2INPKdKdll53n/D1YAhdp8
	gwB2L4KmKY1xgxqUw+DJ2n5FVvb+qSSkZFLMGPWkQFvae7FOhuJ0HUyIkjxge3H449D1fgYrLkdO4
	XleptULGrZfO7P0MubCgGChxybTVRcZosZ38IqC1HpZvA4NJ/mZ22b0cWuwO02B1KRbG8Rojx/M61
	rXNVMvDS9pXywgSmJRZoVVoyGQuVvbtasj9zj2WHEi8PNcwwiyrVkT/9QLe5vv86DSBxfEcuziJz0
	ZDG1+22g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60238)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sZ4dO-0008GX-0p;
	Wed, 31 Jul 2024 09:24:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sZ4dM-00063s-9V; Wed, 31 Jul 2024 09:24:32 +0100
Date: Wed, 31 Jul 2024 09:24:32 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: arnd@arndb.de, afd@ti.com, akpm@linux-foundation.org,
	linus.walleij@linaro.org, eric.devolder@oracle.com, robh@kernel.org,
	vincent.whitchurch@axis.com, bhe@redhat.com, nico@fluxnic.net,
	ardb@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] ARM: support PREEMPT_DYNAMIC
Message-ID: <Zqn0wL5iScf455O5@shell.armlinux.org.uk>
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
> >  #ifdef CONFIG_PREEMPTION
> > +#ifdef CONFIG_PREEMPT_DYNAMIC
> > +	bl	need_irq_preemption
> > +	cmp	r0, #0
> > +	beq	2f
> > +#endif

Depending on the interrupt rate, this can be regarded as a fast path,
it would be nice if we could find a way to use static branches in
assembly code.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

