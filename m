Return-Path: <linux-arch+bounces-7224-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AA997604C
	for <lists+linux-arch@lfdr.de>; Thu, 12 Sep 2024 07:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4F11F23C3A
	for <lists+linux-arch@lfdr.de>; Thu, 12 Sep 2024 05:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4AF1891AE;
	Thu, 12 Sep 2024 05:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X7KNatHA"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFA5188936;
	Thu, 12 Sep 2024 05:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726118519; cv=none; b=gE1xNhFOUTFHs/31Q6ovM5uj8Ws9ooEoonWoecInBN9qexxnrybuTEsR+08285D6msU/yVbydTa0Pc3ZoAMMuSuO5F5cv4QXNsvJTGFlJjxrgR+z80c3O+8QEg0PcxtFjT+Lo4+5a9H6RZ/mR+pvHFeVZptKmUmJTMFlG7p/Byg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726118519; c=relaxed/simple;
	bh=2VP9K8A4lQ+kKZ4u3aFFAQdAmskII642zMj1HvDJd+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPR/mzVNtGFVmPpNS4BqyENdR9FlGv38vmaqLQvuhfS2dYOcDqhjmKUyjQ0VSBcocFy1HLXpNA+ZmKQ86/trtuapfZHyQebEOZzXWi0TMy27ATgqZ7YStj2aMkRsvSU6nOuS7vuRLRtu/tqeSd7khofSKEwLTmIOHdSFqN3KCgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X7KNatHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E51C4CEC3;
	Thu, 12 Sep 2024 05:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726118518;
	bh=2VP9K8A4lQ+kKZ4u3aFFAQdAmskII642zMj1HvDJd+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X7KNatHA46rb30Quk/me3P7g7WSPNaN3Zj/jCzS4xdfPvJ6PzZocT3PfkvFYh9JXC
	 7dFTJeAzkNw+q5QOTD1t1RdIStAZmk0ohtt1kkT527YBHzywtn1+yTbOIozV1kELsx
	 qO/D8Yu7XQn8ynAx4X2MfyRQ43YG27TG72Ax8gR8=
Date: Thu, 12 Sep 2024 07:21:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Niels Dettenbach <nd@syndicat.com>
Cc: linux-arch@vger.kernel.org, stable@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 1/1] x86: SMT broken on Xen PV DomU since 6.9 (updated)
Message-ID: <2024091258-quickness-clapping-7418@gregkh>
References: <4242435.1IzOArtZ34@gongov>
 <3301863.oiGErgHkdL@gongov>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3301863.oiGErgHkdL@gongov>

On Wed, Sep 11, 2024 at 05:49:46PM +0200, Niels Dettenbach wrote:
> Am Mittwoch, 11. September 2024, 10:53:30  schrieb Niels Dettenbach:
> > virtual machines under Xen Hypervisor (DomU) running in Xen PV mode use a
> > special, nonstandard synthetized CPU topology which "just works" under
> > kernels 6.9.x while newer kernels assuming a "crash kernel" and disable
> > SMT (reducing to one CPU core) because the newer topology implementation
> > produces a wrong error "[Firmware Bug]: APIC enumeration order not
> > specification compliant" after new topology checks which are improper for
> > Xen PV platform. As a result, the kernel disables SMT and activates just
> > one CPU core within the VM (DomU).
> > 
> > The patch disables the regarding checks if it is running in Xen PV
> > mode (only) and bring back SMT / all CPUs as in the past to such DomU
> > VMs.
> > 
> > Signed-off-by: Niels Dettenbach <nd@syndicat.com>
> > 
> 
> Signed-off-by: Niels Dettenbach <nd@syndicat.com>
> ---
> 
> A reworked proposal patch which substitutes my initial proposed patch:
> 
> 
> --- linux/arch/x86/kernel/cpu/topology.c        2024-09-11 17:42:42.699278317 +0200
> +++ linux/arch/x86/kernel/cpu/topology.c.orig   2024-09-11 09:53:16.194095250 +0200

<snip>

Please submit this to the proper developers and maintainers for this
code, as the get_maintainers script will tell you as the documentation
states.  As it is, this isn't going anywhere as you did not include them
properly.

good luck!

greg k-h

