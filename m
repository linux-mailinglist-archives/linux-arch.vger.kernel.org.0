Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A482B3F7C87
	for <lists+linux-arch@lfdr.de>; Wed, 25 Aug 2021 21:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbhHYTFd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Aug 2021 15:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235172AbhHYTFc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 25 Aug 2021 15:05:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A0F0610A3;
        Wed, 25 Aug 2021 19:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629918286;
        bh=WE8rqI012Bzl/S5TbfbNOjLun8qlZXOdpo6l9ED62V4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aFZjR+1honOKjKC+pRz6jj7Was9KpFFUMPJh/UkYpvNBL2xVPn87lwG5cA5CFX1Ob
         4d5l/IrV8H+baIQvliFhmTXOTRgi8dfJxK/W0qgzFpt3XGIlPRifkxOuV1CZQA/JcY
         NPNiDNbZCV41w9FxGUuENiifVKyythlsS+XYAh30GUvC2RXkn4ugxxAx0b8ImPsHNx
         BcRYaLUiJv5rVJkjPymrj/3G8FzteXPNpSZIRpwMVKF96tN5/D4+woPrIBdUCTiM4e
         JZTW4SJvS9/JzOU23fBU2hlAFlMWE7iUynCjK7I6g3wJA3jhw4zgjCkGqLde/haUzp
         ydK1CXk21JDZQ==
Date:   Wed, 25 Aug 2021 14:04:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] PCI: Move pci_dev_is/assign_added() to pci.h
Message-ID: <20210825190444.GA3593752@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7595397d6c32ae8745201085956696866cc400b6.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 23, 2021 at 12:53:39PM +0200, Niklas Schnelle wrote:
> On Fri, 2021-08-20 at 17:37 -0500, Bjorn Helgaas wrote:
> > On Tue, Jul 20, 2021 at 05:01:45PM +0200, Niklas Schnelle wrote:
> > > The helper function pci_dev_is_added() from drivers/pci/pci.h is used in
> > > PCI arch code of both s390 and powerpc leading to awkward relative
> > > includes. Move it to the global include/linux/pci.h and get rid of these
> > > includes just for that one function.
> > 
> > I agree the includes are awkward.
> > 
> > But the arch code *using* pci_dev_is_added() seems awkward, too.
> 
> See below for my interpretation why s390 has some driver like
> functionality in its arch code which isn't necessarily awkward.
> 
> Independent from that I have found pci_dev_is_added() as the only way
> deal with the case that one might be looking at a struct pci_dev
> reference that has been removed via pci_stop_and_remove_bus_device() or
> has never been fully scanned. This is quite useful when handling error
> events which on s390 are part of the adapter event mechanism shared
> with channel I/O devices.
> 
> > AFAICS, in powerpc, pci_dev_is_added() is only used by
> > pnv_pci_ioda_fixup_iov() and pseries_pci_fixup_iov_resources().  Those
> > are only called from pcibios_add_device(), which is only called from
> > pci_device_add().
> > 
> > Is it even possible for pci_dev_is_added() to be true in that path?

If the pci_dev_is_added() in powerpc is unreachable, we can remove it
and at least reduce this to an s390-only problem.

> > s390 uses pci_dev_is_added() in recover_store()
> 
> I'm actually looking into this as I'm working on an s390 implementation
> of the PCI recovery flow described in Documentation/PCI/pci-error-
> recovery.rst that would also call pci_dev_is_added() because when we
> get a platform notification of a PCI reset done by firmware it may be
> that the struct pci_dev is going away i.e. we still have a ref count
> but it is not added to the PCI bus anymore. And pci_dev_is_added() is
> the only way I've found to check for this state.
> 
> > , but I don't know what
> > that is (looks like a sysfs file, but it's not documented) or why s390
> > is the only arch that does this.
> 
> Good point about this not being documented, I'll look into adding docs.
> 
> This is a sysfs attribute that basically removes the pci_dev and re-
> adds it. This has the complication that since the attribute sits at
> /sys/bus/pci/devices/<dev>/recover it deletes its own parent directory
> which requires extra caution and means concurrent accesses block on
> pci_lock_rescan_remove() instead of a kernfs lock.
> Long story short when concurrently triggering the attribute one thread
> proceeds into the pci_lock_rescan_remove() section and does the
> removal, while others would block on pci_lock_rescan_remove(). Now when
> the threads unblock the removal is done. In this case there is a new
> struct pci_dev found in the rescan but the previously blocked threads
> still have references to the old struct pci_dev which was removed and
> as far as I could tell can only be distinguished by checking
> pci_dev_is_added().

Is this locking issue different from concurrently writing to
/sys/.../remove on other architectures?

> > Maybe we should make powerpc and s390 less special?
> 
> On s390, as I see it, the reason for this is that all of the PCI
> functionality is directly defined in the Architecture as special CPU
> instructions which are kind of hypercalls but also an ISA extension.
> 
> These instructions range from the basic PCI memory accesses (no real
> MMIO) to enumeration of the devices and on to reporting of hot-plug and
> and resets/recovery events. Importantly we do not have any kind of
> direct access to a real or virtual PCI controller and the architecture
> has no concept of a comparable entity.
> 
> So in my opinion while there is some of the functionality of a PCI
> controller in arch/s390/pci the cut off between controller
> functionality and arch support isn't clear at all and exposing PCI
> support as CPU instructions doesn't map well to the controller concept.
> 
> That said, in principle I'm open to moving some of that into
> drivers/pci/controller/ if you think that would improve things and we
> can find a good argument what should go where. One possible cut off
> would be to have arch/s390/pci/ provide wrappers to the PCI
> instructions but move all their uses to  e.g.
> drivers/pci/controller/s390/. This would of course be a major
> refactoring and none of that code would be useful on any other
> architecture but it would move a lot the accesses to PCI common code
> functionality out of the arch code.

Looks like hotplug is already in drivers/pci/hotplug/s390_pci_hpc.c.

Might be worth considering putting the other PCI core-ish code in
drivers/pci as well, though it doesn't feel urgent to me.  Maybe a
good internship or mentoring project.

I'm not sure this juggling around is worth it basically to just clean
up the include path.  The downside to me is exposing
pci_dev_is_added() to outside the PCI core, because I don't want
to encourage any other users.

> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ---
> > > Since v1 (and bad v2):
> > > - Fixed accidental removal of PCI_DPC_RECOVERED, PCI_DPC_RECOVERING
> > >   defines and also move these to include/linux/pci.h
> > > 
> > >  arch/powerpc/platforms/powernv/pci-sriov.c |  3 ---
> > >  arch/powerpc/platforms/pseries/setup.c     |  1 -
> > >  arch/s390/pci/pci_sysfs.c                  |  2 --
> > >  drivers/pci/hotplug/acpiphp_glue.c         |  1 -
> > >  drivers/pci/pci.h                          | 15 ---------------
> > >  include/linux/pci.h                        | 15 +++++++++++++++
> > >  6 files changed, 15 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/platforms/powernv/pci-sriov.c
> > > index 28aac933a439..2e0ca5451e85 100644
> > > --- a/arch/powerpc/platforms/powernv/pci-sriov.c
> > > +++ b/arch/powerpc/platforms/powernv/pci-sriov.c
> > > @@ -9,9 +9,6 @@
> > >  
> > >  #include "pci.h"
> > >  
> > > -/* for pci_dev_is_added() */
> > > -#include "../../../../drivers/pci/pci.h"
> > > 
> .. snip ..
> 
