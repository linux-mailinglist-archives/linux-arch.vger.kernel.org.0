Return-Path: <linux-arch+bounces-4434-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF40E8C6BE8
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 20:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A93284A13
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 18:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FC4158DB1;
	Wed, 15 May 2024 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUGicGn9"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849681F60A;
	Wed, 15 May 2024 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715796761; cv=none; b=cyrl+gCpYyqF6R+BVUGmerjYuKFNxBRGeUUqqfTXSL6nRFn7Gg4RjYwGyuj/iNSb5MWoeh4L78a/c/byZy2bZaoZLS6XRmlk+CDBUgTYYQAGkYuGpEhUNpke3HdfTfmFeVOpI3ikha52Ze25zr6ejx0eWvDDiEW31C7fGBK56Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715796761; c=relaxed/simple;
	bh=LOrt+7GsCdn7DVj/gMbh6Xgf4i7fcQTqSrnZGxnrKlo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=i9194/XMqrzZIfA/GJj31yEvng4TKeYCQAufbYWjPsjdwxLTHEhvMft5eZ0AGH8RkkAwbMvgKChizRn12I2U+qlJEjVqkdDLBLC4LZvWgQoyErTTFLM0svvzKFxEY1bIBclmjXqlceTCx0CEwGAKxq1w79GwZfN6FESe7DnSQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUGicGn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5BFC116B1;
	Wed, 15 May 2024 18:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715796761;
	bh=LOrt+7GsCdn7DVj/gMbh6Xgf4i7fcQTqSrnZGxnrKlo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fUGicGn9UQgOA6mw01bZqzwkiP556cGeMZciwhppd1eEX9Q0UyRqHaH8a4Pix3k4b
	 pMz23Ce3cls1u/0/VAklE+zSfxBIc4q/Uh5HvttBB97ty+zfdR7aOGF/Nm8Fl63jWh
	 8i/bfP5MmhIMJBpGlOlyFiqqNulqAA0FX0FBTo9laWKQKZ+YcI2JfkT2N5K2d06Gbp
	 WBxbqYwCJ5g3Y8isM7PyYMPTixIec/VbFzK6ez58k2QvWcWE0Jls5XZyrRsy0ovJc9
	 V327PgagjEknSV7Nzxh+JZX4mJGlP6Cksf6OBV6yYGWAx9kmRq3lFcEsKsSo40a8CI
	 +YRlQR7DjwxjA==
Date: Wed, 15 May 2024 13:12:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: Saurabh Singh Sengar <ssengar@linux.microsoft.com>, arnd@arndb.de,
	bhelgaas@google.com, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	haiyangz@microsoft.com, hpa@zytor.com, kw@linux.com,
	kys@microsoft.com, lenb@kernel.org, lpieralisi@kernel.org,
	mingo@redhat.com, mhklinux@outlook.com, rafael@kernel.org,
	robh@kernel.org, tglx@linutronix.de, wei.liu@kernel.org,
	will@kernel.org, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, x86@kernel.org, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v2 6/6] drivers/pci/hyperv/arm64: vPCI MSI IRQ domain
 from DT
Message-ID: <20240515181238.GA2129352@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea91140a-d0df-4efd-aef8-34f00b82cf74@linux.microsoft.com>

On Wed, May 15, 2024 at 09:34:09AM -0700, Roman Kisel wrote:
> 
> 
> On 5/15/2024 2:48 AM, Saurabh Singh Sengar wrote:
> > On Tue, May 14, 2024 at 03:43:53PM -0700, Roman Kisel wrote:
> > > The hyperv-pci driver uses ACPI for MSI IRQ domain configuration
> > > on arm64 thereby it won't be able to do that in the VTL mode where
> > > only DeviceTree can be used.
> > > 
> > > Update the hyperv-pci driver to discover interrupt configuration
> > > via DeviceTree.
> > 
> > Subject prefix should be "PCI: hv:"
> > 
> Thanks!

"git log --oneline <file>" is a good guide in general and could be
used for other patches in this series as well.

> > > +		hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
> > > +			fn, &hv_pci_domain_ops,
> > > +			chip_data);
> > 
> > Upto 100 characters per line are supported now, we can have less
> > line breaks.
> > 
> Fewer line breaks would make this look nicer, let me know if you had any
> particular style in mind.

Let's not use the checkpatch "$max_line_length = 100" as a guide.

The pci-hyperv.c file as a whole is obviously formatted to fit in 80
columns with few exceptions.

IMO it would not be an improvement to scatter random 100-column lines
throughout.  That would just mean the file would look bad in an
80-column terminal and there would be a lot of wasted space in a
100-column terminal.

Bjorn

