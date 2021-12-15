Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77F1475D99
	for <lists+linux-arch@lfdr.de>; Wed, 15 Dec 2021 17:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbhLOQfI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Dec 2021 11:35:08 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50462 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbhLOQfG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Dec 2021 11:35:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F147F619C9;
        Wed, 15 Dec 2021 16:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F169C36AE2;
        Wed, 15 Dec 2021 16:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639586105;
        bh=+ZgCupjax4AhWP60VaWy3uMq6uc07rZ6Bxyiq5RqgUA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gPdDrSUcrBSvD8DLkN55ecG3pz7nToYJpdJg7SkDkQ5MKPp+SlsPYBEfrsM1dXJ8A
         xil6sOsGMmM3687zy+O+7lRT4n9EpERJZwKKjo26KS40LHSgzxh6mDI8CafQwsOpiL
         dKDww9swrZim8z9JJ9x6SjznjtbHyfOj7PiBoI2IsTZgpzbD4HRAqvVPXKd43AHHiH
         ssUr+dpyIwMyLRqvGutprX8nBd77dhlCoxw72Oeux6lf4fEpEJhMxK7udCM76aDWux
         Hx3ENHfmh2pQyne/F4mPwQAE9jU7VrYkl9jJWSiIIH3s23EK/fkSKw0BikwdcKYwgn
         0+Zq8Ygvqq4YA==
Date:   Wed, 15 Dec 2021 10:35:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sunil Muthuswamy <sunilmut@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, maz@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, arnd@arndb.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: Re: [PATCH v6 0/2] PCI: hv: Hyper-V vPCI for arm64
Message-ID: <20211215163503.GA698547@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637225490-2213-1-git-send-email-sunilmut@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 18, 2021 at 12:51:28AM -0800, Sunil Muthuswamy wrote:

> Sunil Muthuswamy (2):
>   PCI: hv: Make the code arch neutral by adding arch specific interfaces
>   arm64: PCI: hv: Add support for Hyper-V vPCI

Both patches are primarily to drivers/pci/controller/pci-hyperv.c, so
why do the subject lines look so different?

Instead of making up a new format from scratch, look at the previous
history and copy it:

  $ git log --oneline drivers/pci/controller/pci-hyperv.c
  f18312084300 ("PCI: hv: Remove unnecessary use of %hx")
  41608b64b10b ("PCI: hv: Fix sleep while in non-sleep context when removing child devices from the bus")
  88f94c7f8f40 ("PCI: hv: Turn on the host bridge probing on ARM64")
  9e7f9178ab49 ("PCI: hv: Set up MSI domain at bridge probing time")
  38c0d266dc80 ("PCI: hv: Set ->domain_nr of pci_host_bridge at probing time")
  418cb6c8e051 ("PCI: hv: Generify PCI probing")
  8f6a6b3c50ce ("PCI: hv: Support for create interrupt v3")
  7d815f4afa87 ("PCI: hv: Add check for hyperv_initialized in init_hv_pci_drv()")
  326dc2e1e59a ("PCI: hv: Remove bus device removal unused refcount/functions")
  ...

The second patch adds arm64 support, so it *should* mention arm64, but
it can be something like this:

  PCI: hv: Add arm64 Hyper-V vPCI support

>  arch/arm64/include/asm/hyperv-tlfs.h |   9 +
>  arch/x86/include/asm/hyperv-tlfs.h   |  33 ++++
>  arch/x86/include/asm/mshyperv.h      |   7 -
>  drivers/pci/Kconfig                  |   2 +-
>  drivers/pci/controller/Kconfig       |   2 +-
>  drivers/pci/controller/pci-hyperv.c  | 281 ++++++++++++++++++++++++---
>  include/asm-generic/hyperv-tlfs.h    |  33 ----
>  7 files changed, 300 insertions(+), 67 deletions(-)
