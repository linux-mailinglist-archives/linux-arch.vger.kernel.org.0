Return-Path: <linux-arch+bounces-1314-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F2F828955
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 16:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2121283183
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7C639FE8;
	Tue,  9 Jan 2024 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nN/okoV4"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D84A3A8E1;
	Tue,  9 Jan 2024 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tZu+pKrUWqvj1u7XXOZ361qKXLT14yOTmWAUg/xb9K8=; b=nN/okoV4vFIiLWpy1C8jbd7tdw
	Qv36Z2Gb+2ode/mlOC9FGuq844QXK7cH1QtvswvkKjPFNn3crE3ejxFH+peDwTmHOW4G/GWbH6Jpn
	0qzKOvO75N3PC9BVsubbFulOPfcPT9peor+qGDaJvLE1hDNNoKtb0pRiolyX60ZvDTRC5WW3imUyZ
	1xyVORTa/XshnAfR1BtvDgMDdHcKzUMxaBI9H8XnwA0OUVxFBs03HPJwS8ZWzD+a9pTAz9kjYXkvu
	D81k2SVTALrUMdf78FrSRpsd/686oC+ZFg2iPb8F+4cDR8NoTEmsESKvjPSBSJuSGwKrJgRpTa/j3
	34Jq5IPg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53760)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rNELt-0004Hq-18;
	Tue, 09 Jan 2024 15:49:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rNELr-0004Of-RO; Tue, 09 Jan 2024 15:49:15 +0000
Date: Tue, 9 Jan 2024 15:49:15 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Rafael J. Wysocki" <rafael@kernel.org>
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
Subject: Re: [PATCH RFC v3 02/21] ACPI: processor: Add support for processors
 described as container packages
Message-ID: <ZZ1q+7GXqnMMwKNR@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <E1rDOfx-00Dvje-MS@rmk-PC.armlinux.org.uk>
 <CAJZ5v0iB0bS6nmjQ++pV1zp5YSGuigbffK5VD3wsX+8bY9MA5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iB0bS6nmjQ++pV1zp5YSGuigbffK5VD3wsX+8bY9MA5w@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 18, 2023 at 09:17:34PM +0100, Rafael J. Wysocki wrote:
> On Wed, Dec 13, 2023 at 1:49 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:
> >
> > From: James Morse <james.morse@arm.com>
> >
> > ACPI has two ways of describing processors in the DSDT. From ACPI v6.5,
> > 5.2.12:
> >
> > "Starting with ACPI Specification 6.3, the use of the Processor() object
> > was deprecated. Only legacy systems should continue with this usage. On
> > the Itanium architecture only, a _UID is provided for the Processor()
> > that is a string object. This usage of _UID is also deprecated since it
> > can preclude an OSPM from being able to match a processor to a
> > non-enumerable device, such as those defined in the MADT. From ACPI
> > Specification 6.3 onward, all processor objects for all architectures
> > except Itanium must now use Device() objects with an _HID of ACPI0007,
> > and use only integer _UID values."
> >
> > Also see https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html#declaring-processors
> >
> > Duplicate descriptions are not allowed, the ACPI processor driver already
> > parses the UID from both devices and containers. acpi_processor_get_info()
> > returns an error if the UID exists twice in the DSDT.
> 
> I'm not really sure how the above is related to the actual patch.
> 
> > The missing probe for CPUs described as packages
> 
> It is unclear what exactly is meant by "CPUs described as packages".
> 
> From the patch, it looks like those would be Processor() objects
> defined under a processor container device.
> 
> > creates a problem for
> > moving the cpu_register() calls into the acpi_processor driver, as CPUs
> > described like this don't get registered, leading to errors from other
> > subsystems when they try to add new sysfs entries to the CPU node.
> > (e.g. topology_sysfs_init()'s use of topology_add_dev() via cpuhp)
> >
> > To fix this, parse the processor container and call acpi_processor_add()
> > for each processor that is discovered like this.
> 
> Discovered like what?
> 
> > The processor container
> > handler is added with acpi_scan_add_handler(), so no detach call will
> > arrive.
> 
> The above requires clarification too.

The above comments... yea. As I didn't write the commit description, but
James did, and James has basically vanished, I don't think these can be
answered, short of rewriting the entire commit message, with me spending
a lot of time with the ACPI specification trying to get the terminology
right - because at lot of the above on the face of it seems to be things
to do with wrong terminology being used.

I wasn't expecting this level of issues with this patch set, and I now
feel completely out of my depth with this series. I'm wondering whether
I should even continue with it, since I don't have the ACPI knowledge
to address a lot of these comments.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

