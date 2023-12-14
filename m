Return-Path: <linux-arch+bounces-1047-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B910813926
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 18:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6E52824E4
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 17:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80DF67B4D;
	Thu, 14 Dec 2023 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YZln1QZx"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EDDA6;
	Thu, 14 Dec 2023 09:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yZZfFiLwNQEGOTfqPZeYqFsQFPoC9cJyPHRCME7+qng=; b=YZln1QZxhDK9MAc+S2Xd9heAgy
	ie5lPli0BDZIk0s28NjnJCpwz3RwdjpjdXrpc+br3qEiudcMak40U5Z+KZNubTpGCA7kHnccAeNlr
	Pyd4TFtyk/YlD6xLA3UBo+0SS95CobxPx1j5yl7dW43hlqLWjkB2Gt5g/Q9fQiM4IljnmObep5pma
	mIgrXVGCHv0cZkuAsz3SmcPEpKVgoVbP/e96BvWTC3xUkbjCiKWCZs/aOpnDnusCNUH4kdYbxSCdM
	U+6zvJBCblim05E+MMAqmh4KZVohjAhWk/AvdEovz1W7UBINZht7JDprgbbiomQQV/JJWQXrhLWtO
	JcUuFF2w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45686)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rDpvX-0001ns-17;
	Thu, 14 Dec 2023 17:55:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rDpvW-0002kf-Sv; Thu, 14 Dec 2023 17:55:14 +0000
Date: Thu, 14 Dec 2023 17:55:14 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
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
Subject: Re: [PATCH RFC v3 01/21] ACPI: Only enumerate enabled (or
 functional) devices
Message-ID: <ZXtBgtB8FXs8ge0h@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <E1rDOfs-00DvjY-HQ@rmk-PC.armlinux.org.uk>
 <20231214173241.0000260f@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214173241.0000260f@Huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 14, 2023 at 05:32:41PM +0000, Jonathan Cameron wrote:
> On Wed, 13 Dec 2023 12:49:16 +0000
> Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:
> 
> > From: James Morse <james.morse@arm.com>
> > 
> > Today the ACPI enumeration code 'visits' all devices that are present.
> > 
> > This is a problem for arm64, where CPUs are always present, but not
> > always enabled. When a device-check occurs because the firmware-policy
> > has changed and a CPU is now enabled, the following error occurs:
> > | acpi ACPI0007:48: Enumeration failure
> > 
> > This is ultimately because acpi_dev_ready_for_enumeration() returns
> > true for a device that is not enabled. The ACPI Processor driver
> > will not register such CPUs as they are not 'decoding their resources'.
> > 
> > Change acpi_dev_ready_for_enumeration() to also check the enabled bit.
> > ACPI allows a device to be functional instead of maintaining the
> > present and enabled bit. Make this behaviour an explicit check with
> > a reference to the spec, and then check the present and enabled bits.
> > This is needed to avoid enumerating present && functional devices that
> > are not enabled.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> > If this change causes problems on deployed hardware, I suggest an
> > arch opt-in: ACPI_IGNORE_STA_ENABLED, that causes
> > acpi_dev_ready_for_enumeration() to only check the present bit.
> 
> My gut feeling (having made ACPI 'fixes' in the past that ran into
> horribly broken firmware and had to be reverted) is reduce the blast
> radius preemptively from the start. I'd love to live in a world were
> that wasn't necessary but I don't trust all the generators of ACPI tables.
> I'll leave it to Rafael and other ACPI experts suggest how narrow we should
> make it though - arch opt in might be narrow enough.

Yes, I think an arch opt-in would be the most sensible way forward, if
Rafael concurs with that idea. I notice that what I wrote there was
actually an opt-out. I'll fix that.

> > +	/*
> > +	 * ACPI 6.5's 6.3.7 "_STA (Device Status)" allows firmware to return
> > +	 * (!present && functional) for certain types of devices that should be
> > +	 * enumerated. Note that the enabled bit can't be sert until the present
> 
> set until

Thanks for spotting that, fixed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

