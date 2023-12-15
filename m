Return-Path: <linux-arch+bounces-1082-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F355814BE1
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 16:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29EBD1F2152E
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 15:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EB636B17;
	Fri, 15 Dec 2023 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RR12zPsU"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6798136AF3;
	Fri, 15 Dec 2023 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nvVr24yJlTcKSpTw1UQi3U4632hdafX2X9T8yNVWb/s=; b=RR12zPsUj34Qy44F0kIaQPaAZB
	nPc+zWXztM2JH+6eKjddRnEJOcP4lHMaZs0Ok+6Eho9xjDst2RRvXpsCCyoi7ja6CGEcydbSwFAla
	53X4gkcQ8TpZWIlIRo/ThKhe3wdKOcfl7yUOyXTd80QhoYvEG1X1gzin5cMl7VuHRsiaoHUkm/vCF
	PYV3ouDdMG+9zRwjqRNnemtSmGGjTl1pO8Bz5P4ZH+wXgC0S9oDcdiSR5YyOfn5ipO2ghRZtIMuIZ
	6tcgCPy1Ngdj7NUdlCPMO+WdfmNzTDSJrQZBHAb7IAFs/jxP1GIaaGn85jf5fzZNPpucwpWFKdF2Q
	MkpmY3mA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48236)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rEAAQ-0002qa-0q;
	Fri, 15 Dec 2023 15:31:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rEAAN-0003iY-2B; Fri, 15 Dec 2023 15:31:55 +0000
Date: Fri, 15 Dec 2023 15:31:55 +0000
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
Subject: Re: [PATCH RFC v3 01/21] ACPI: Only enumerate enabled (or
 functional) devices
Message-ID: <ZXxxa+XZjPZtNfJ+@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <E1rDOfs-00DvjY-HQ@rmk-PC.armlinux.org.uk>
 <20231214173241.0000260f@Huawei.com>
 <CAJZ5v0jymOtZ0y65K9wE8FJk+ZKwP+FoGm4AKHXcYVfQJL9MVw@mail.gmail.com>
 <ZXtFBYJEX2RrFrwj@shell.armlinux.org.uk>
 <CAJZ5v0h2Keyb-gFWFuPsKtwqjXvM2snyGpo6MMfFzaXKbfEpgw@mail.gmail.com>
 <CAJZ5v0h3WWtvrbxRpaGfq6c756k+L1SzZ1Gv3A14JxXHNcUMKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h3WWtvrbxRpaGfq6c756k+L1SzZ1Gv3A14JxXHNcUMKA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 14, 2023 at 07:37:10PM +0100, Rafael J. Wysocki wrote:
> On Thu, Dec 14, 2023 at 7:16 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Dec 14, 2023 at 7:10 PM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > > I guess we need something like:
> > >
> > >         if (device->status.present)
> > >                 return device->device_type != ACPI_BUS_TYPE_PROCESSOR ||
> > >                        device->status.enabled;
> > >         else
> > >                 return device->status.functional;
> > >
> > > so we only check device->status.enabled for processor-type devices?
> >
> > Yes, something like this.
> 
> However, that is not sufficient, because there are
> ACPI_BUS_TYPE_DEVICE devices representing processors.
> 
> I'm not sure about a clean way to do it ATM.

Ok, how about:

static bool acpi_dev_is_processor(const struct acpi_device *device)
{
	struct acpi_hardware_id *hwid;

	if (device->device_type == ACPI_BUS_TYPE_PROCESSOR)
		return true;

	if (device->device_type != ACPI_BUS_TYPE_DEVICE)
		return false;

	list_for_each_entry(hwid, &device->pnp.ids, list)
		if (!strcmp(ACPI_PROCESSOR_OBJECT_HID, hwid->id) ||
		    !strcmp(ACPI_PROCESSOR_DEVICE_HID, hwid->id))
			return true;

	return false;
}

and then:

	if (device->status.present)
		return !acpi_dev_is_processor(device) || device->status.enabled;
	else
		return device->status.functional;

?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

