Return-Path: <linux-arch+bounces-1505-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA3183A46F
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 09:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48397282818
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 08:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3751717997;
	Wed, 24 Jan 2024 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Nzo1kG4/"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103C917BA5;
	Wed, 24 Jan 2024 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085923; cv=none; b=WJDxy4ZvnW5GtVDzzynv9+rxNjk1QpMQLypqIVztW1fuITt5eILyWtzPRd4Bc7ul5ToR8MUGnSs/NeYPQuW/IDbV2ICrS8fW0iCHR0fN08AMGAA3AY4y4T8viXQfbqFzJcNNTm0WJp62hoMTxQSXrFv/se3S6Af36mIrwdaYhMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085923; c=relaxed/simple;
	bh=/nsD3d+E0lLEEpr6zHa2aA4SWpngDZwV5I8Z0fUog+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHuEkWpfAwS4xcK45M9uFOFRtZsJ5tN1gpxHFoRdHDnuWJyebVUYI8lbb5cHX/Rz2cmMN1tBFllXTzxzOUh5zIQVyw4Qw2hYVmEDOLB34opdhCESZyFcnyUOEPGAghJIn8gpUa/U94rXShaceDDkttze2jg0JFo37lz8QIAWs/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Nzo1kG4/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5lEen0G4yFCsLlAF+wT6cjA+TZeTYFwLA6f1OlJb35c=; b=Nzo1kG4/6uJi4JkVCN2GnsVPSP
	MSCm4FbOrhPHehb1KUJVrH1BJ3z9cxxbnwCC0zxjG3bD8+skV/uIfdTD6Xjbum3MAfAlH46N/Wp+6
	L7YV4CDoxK1vWQMcHAQgVJyJHoNDrjkuxOIry+Y5WoNfp7WvmbHn0uuneIMiaw3MbPLQllmBXaukX
	TYMxIFTn6SoI9/QX7eY4T0qhBicf+VgU4zXx/IN3Fy2G80u7atBOa9GDJ5r57T/AsDstwl/th3j5P
	hRfBkIRpb/e4q3+Na04s1TcgWKeqoYLVLCnejFkjHgtXQ41c1OGcmGHfEku7EHHcuxCj7+We0ZUXO
	+zL7lf9w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41124)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rSYsi-0003f3-2f;
	Wed, 24 Jan 2024 08:45:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rSYse-0002ld-Qu; Wed, 24 Jan 2024 08:45:08 +0000
Date: Wed, 24 Jan 2024 08:45:08 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, acpica-devel@lists.linuxfoundation.org,
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
	Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com,
	James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 05/21] ACPI: Rename ACPI_HOTPLUG_CPU to include
 'present'
Message-ID: <ZbDOFJeRjdaXtVJu@shell.armlinux.org.uk>
References: <CAJZ5v0gwe02uzAQoX0QDHo35OTEozpbnqC6vukjM3aE6HMq9WQ@mail.gmail.com>
 <ZbADTBLDEFtdglho@shell.armlinux.org.uk>
 <CAJZ5v0jh-EdrnjkJep++UDo+Uv4hmR7VV4KYVdF4CK2K+5XLtg@mail.gmail.com>
 <ZbAMjZoybVfiAGcT@shell.armlinux.org.uk>
 <CAJZ5v0gt=MR1JGsPZnZG_AqudA-KMmb4BOa_A6H9B6+Rhe_+JQ@mail.gmail.com>
 <ZbAdAdqqfXRuY3Xj@shell.armlinux.org.uk>
 <CAJZ5v0gsqbeJc4qX-AefOqu53=rDme2XzFXacWz_0zbVBoaXjw@mail.gmail.com>
 <ZbAoJO8f66Dg0lGF@shell.armlinux.org.uk>
 <ZbArzbC19L1YxLHi@shell.armlinux.org.uk>
 <CAJZ5v0jvek=W-FNhiY_0DQha2wDCUv7YW_4jaHUeX0DbYJOX6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jvek=W-FNhiY_0DQha2wDCUv7YW_4jaHUeX0DbYJOX6Q@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 23, 2024 at 11:05:43PM +0100, Rafael J. Wysocki wrote:
> > So why not state that you personally don't want it in the first
> > place? Why this game of cat and mouse and the constantly changing
> > arguments. I guess it's to waste developers time.
> >
> > Well, I'm calling you out for this, because I'm that pissed off
> > at the amount of time you're causing to be wasted.
> 
> And I don't have to suffer this kind of abuse.  Sorry.

And I've had enough of this crap, so I'm not walking away. Good
riddance.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

