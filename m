Return-Path: <linux-arch+bounces-3260-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC1088F88F
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 08:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC07C295FA9
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 07:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2526250A80;
	Thu, 28 Mar 2024 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="ZE4ko+rx";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="F5ZG3jPw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mailrelay6-1.pub.mailoutpod3-cph3.one.com (mailrelay6-1.pub.mailoutpod3-cph3.one.com [46.30.211.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A53052F6C
	for <linux-arch@vger.kernel.org>; Thu, 28 Mar 2024 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711610652; cv=none; b=Jp+29b/6whsVD/7wmIuCuUwpR2Jxa0JRdg4CmaqSpOf5WS0axtzVp33ome2XS46nPa1aQH5rnddaxcKlERW18EtgHPqtsVzOf1JivsdbQap55f6UyS58xHY0tFLCLGc8u0IRgIt66EVOSoa1jxk6u+EWpAeyp7r1MoiPpagopG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711610652; c=relaxed/simple;
	bh=lC/MAxDKVedxYYDbpstaB8/CiL11IsiPeCS0mpthbj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBqlGSI43uiOXAJ2rmVN3u9j8kL/02q9vdBguMaSkGAukW4psO2sp+O8gYyuCpaLb74ysS01D3ikJkcFIFt7uZYJcpDlM5sPtWmxUVE1iMB/xB+4l/UzMnzKsC5b2P7OiliMk2nS6QYmI2kj24nmNfXBC34hL/Cep233rXRdjAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=ZE4ko+rx; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=F5ZG3jPw; arc=none smtp.client-ip=46.30.211.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=gya7IPEuSu6MJQjEiIDquH7exohl6PUqhigJxnlATAE=;
	b=ZE4ko+rxCKWftwAo8NczSWsuqHjEGGfU6uUbSIvP9K7fRjmUyo4Xr6m3BNAQARjmG/LX8288MYqxa
	 qrdk8dPJqF9CYmvYKIuCC2KeC1KUOqccJBBkzOKfv28rtFurrRJni2BtWG1TH9wXZ4K99dnFf8V5MD
	 HZ1gA7bs8n86UELzO/3mtmm9tYEeJ1jNRSMFTH1fTc77A4UCALepeO491AxJF+4LLzM+MLxKLdACw9
	 4pMSRnDxAVYcWBUnWQrf3ZIk6pJCXrGR5H7uq2oOnDFOYI+oh/4/BJhyLEjVShZXd+FvQVzGTZFYI4
	 XSSV3BEarvEACwRvDNnbMC1B5JbFC8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=gya7IPEuSu6MJQjEiIDquH7exohl6PUqhigJxnlATAE=;
	b=F5ZG3jPwCujGHPqRnIkMdiF/ub3mtz9R1CndiSD3xivl8FAjmngZD0HN2Qu0BtwII0e2ZNTa1qmYb
	 0bYRExmAw==
X-HalOne-ID: 25d22949-ecd4-11ee-9cc7-bd80189f112a
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay6.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 25d22949-ecd4-11ee-9cc7-bd80189f112a;
	Thu, 28 Mar 2024 07:24:03 +0000 (UTC)
Date: Thu, 28 Mar 2024 08:24:01 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: arnd@arndb.de, javierm@redhat.com, deller@gmx.de,
	sui.jingfeng@linux.dev, linux-arch@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-sh@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 1/3] arch: Select fbdev helpers with CONFIG_VIDEO
Message-ID: <20240328072401.GB1573630@ravnborg.org>
References: <20240327204450.14914-1-tzimmermann@suse.de>
 <20240327204450.14914-2-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327204450.14914-2-tzimmermann@suse.de>

On Wed, Mar 27, 2024 at 09:41:29PM +0100, Thomas Zimmermann wrote:
> Various Kconfig options selected the per-architecture helpers for
> fbdev. But none of the contained code depends on fbdev. Standardize
> on CONFIG_VIDEO, which will allow to add more general helpers for
> video functionality.
> 
> CONFIG_VIDEO protects each architecture's video/ directory. This
> allows for the use of more fine-grained control for each directory's
> files, such as the use of CONFIG_STI_CORE on parisc.
> 
> v2:
> - sparc: rebased onto Makefile changes
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

