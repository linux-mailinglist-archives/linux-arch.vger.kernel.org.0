Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F41B42737E
	for <lists+linux-arch@lfdr.de>; Sat,  9 Oct 2021 00:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243555AbhJHWPG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Oct 2021 18:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243539AbhJHWPF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Oct 2021 18:15:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8320760FC1;
        Fri,  8 Oct 2021 22:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633731189;
        bh=wNgDKDIIK358RGjNmCHeTM6eGu9i1NUq2a4Cx1Zn5ec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NfOQ1BydTGGErjNKi2rvvo23VwEfRECB5hinU3fTD/YWGT9/wIoxtnDy0UMOb9F4Z
         Tzo85ZiIClqd9Br3sFdFgZc04avS7YFvKqBTXL1DiIl4OuLjBm9qY2WvQp8l+8T0B5
         AthcCY3b9E2A3C/eMVa0xojj/6onvABaY40UGivKWe/p1obD6p8Y4Bun00Fgp1s8zp
         RGlUjv6rmc5Hni8/2Ju6cxQJcUjT0b7O9dwy0Z94iGg1CuBBYqPTMaPsBt0GNoUzlI
         HXbK/hR3Bd6/t9zuyP1NSYD6n8jVOsNG5w7uN4sQ0R/gVLZtxJfARJL0iO21pHUVd9
         vv+eJeOuhHiyg==
Date:   Fri, 8 Oct 2021 17:13:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] PCI: Move pci_dev_is/assign_added() to pci.h
Message-ID: <20211008221308.GA1383868@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720150145.640727-1-schnelle@linux.ibm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 20, 2021 at 05:01:45PM +0200, Niklas Schnelle wrote:
> The helper function pci_dev_is_added() from drivers/pci/pci.h is used in
> PCI arch code of both s390 and powerpc leading to awkward relative
> includes. Move it to the global include/linux/pci.h and get rid of these
> includes just for that one function.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Since v1 (and bad v2):
> - Fixed accidental removal of PCI_DPC_RECOVERED, PCI_DPC_RECOVERING
>   defines and also move these to include/linux/pci.h
> 
>  arch/powerpc/platforms/powernv/pci-sriov.c |  3 ---
>  arch/powerpc/platforms/pseries/setup.c     |  1 -
>  arch/s390/pci/pci_sysfs.c                  |  2 --
>  drivers/pci/hotplug/acpiphp_glue.c         |  1 -
>  drivers/pci/pci.h                          | 15 ---------------
>  include/linux/pci.h                        | 15 +++++++++++++++
>  6 files changed, 15 insertions(+), 22 deletions(-)

I dropped this one because I think a subsequent patch removed the use
in arch/powerpc, so if you still need this, it probably needs to be
updated to at least drop those hunks.
