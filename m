Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7DC83F879E
	for <lists+linux-arch@lfdr.de>; Thu, 26 Aug 2021 14:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241914AbhHZMho (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Aug 2021 08:37:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241878AbhHZMhn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Aug 2021 08:37:43 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17QCXI0x162215;
        Thu, 26 Aug 2021 08:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ujUmPrruaZ9z+WNsaGZbPQEnhEfXbSITcXDL6b+XNgI=;
 b=Ig1CLBiiYQpJj65nUtw1TOMcnFIfiw787w+UU01aLjja8RHKtqI3a5VE5X7i6hYWZq71
 ZuyJ+unZCMwLpMifrm571fCRq14kzMVTFteroo8MvFIdwwhYd3SshMlxKp6SeZQKCaO0
 zV02fBXzOGzELI1iKdLhXIhdx5b4iR8oOmvKY7d8dxTqeCJC/krZEF2OIcRvdn4mRdiv
 5AzPMk437jCrJaF+xyyZEqtONMAp8QZ1uqdPU9/rRZX9T+SaaUcC3NJ5Aj4DnaRQ/jwa
 TLOsfDawfpslzMiXte/JaoKSyy9juT4Vq2KaiD58KY+KhzNabKqTLmx8xxG7k2dYtAKj Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3apabchcxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Aug 2021 08:36:33 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17QCXbRw163122;
        Thu, 26 Aug 2021 08:36:33 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3apabchcvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Aug 2021 08:36:33 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17QCWnSQ004857;
        Thu, 26 Aug 2021 12:36:31 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3ajs48hd0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Aug 2021 12:36:30 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17QCaSMK54329644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 12:36:28 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D6D152052;
        Thu, 26 Aug 2021 12:36:28 +0000 (GMT)
Received: from sig-9-145-41-53.uk.ibm.com (unknown [9.145.41.53])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EA1DE52054;
        Thu, 26 Aug 2021 12:36:27 +0000 (GMT)
Message-ID: <87d15d5eead35c9eaa667958d057cf4a81a8bf13.camel@linux.ibm.com>
Subject: Re: [PATCH v3] PCI: Move pci_dev_is/assign_added() to pci.h
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 26 Aug 2021 14:36:27 +0200
In-Reply-To: <20210825190444.GA3593752@bjorn-Precision-5520>
References: <20210825190444.GA3593752@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xl4UtiseWzXXSIZAvLjOt7vbm6dFF_Ui
X-Proofpoint-GUID: J3eT8UvJPBvZRDUgGthuNmjzyEOXPS-X
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-26_03:2021-08-26,2021-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108260077
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2021-08-25 at 14:04 -0500, Bjorn Helgaas wrote:
> On Mon, Aug 23, 2021 at 12:53:39PM +0200, Niklas Schnelle wrote:
> > On Fri, 2021-08-20 at 17:37 -0500, Bjorn Helgaas wrote:
> > > On Tue, Jul 20, 2021 at 05:01:45PM +0200, Niklas Schnelle wrote:
> > > > The helper function pci_dev_is_added() from drivers/pci/pci.h is used in
> > > > PCI arch code of both s390 and powerpc leading to awkward relative
> > > > includes. Move it to the global include/linux/pci.h and get rid of these
> > > > includes just for that one function.
> > > 
> > > I agree the includes are awkward.
> > > 
> > > But the arch code *using* pci_dev_is_added() seems awkward, too.
> > 
> > See below for my interpretation why s390 has some driver like
> > functionality in its arch code which isn't necessarily awkward.
> > 
> > Independent from that I have found pci_dev_is_added() as the only way
> > deal with the case that one might be looking at a struct pci_dev
> > reference that has been removed via pci_stop_and_remove_bus_device() or
> > has never been fully scanned. This is quite useful when handling error
> > events which on s390 are part of the adapter event mechanism shared
> > with channel I/O devices.
> > 
> > > AFAICS, in powerpc, pci_dev_is_added() is only used by
> > > pnv_pci_ioda_fixup_iov() and pseries_pci_fixup_iov_resources().  Those
> > > are only called from pcibios_add_device(), which is only called from
> > > pci_device_add().
> > > 
> > > Is it even possible for pci_dev_is_added() to be true in that path?
> 
> If the pci_dev_is_added() in powerpc is unreachable, we can remove it
> and at least reduce this to an s390-only problem.

Ok. I might be missing something but I agree it does look these are
called from within pcibios_add_device() only so pci_dev_is_added() can
never be true. This looks pretty clear as pci_dev_assign_added() is
called after pcibios_add_device() in pci_bus_add_device().

> 
> > > s390 uses pci_dev_is_added() in recover_store()
> > 
> > I'm actually looking into this as I'm working on an s390 implementation
> > of the PCI recovery flow described in Documentation/PCI/pci-error-
> > recovery.rst that would also call pci_dev_is_added() because when we
> > get a platform notification of a PCI reset done by firmware it may be
> > that the struct pci_dev is going away i.e. we still have a ref count
> > but it is not added to the PCI bus anymore. And pci_dev_is_added() is
> > the only way I've found to check for this state.
> > 
> > > , but I don't know what
> > > that is (looks like a sysfs file, but it's not documented) or why s390
> > > is the only arch that does this.
> > 
> > Good point about this not being documented, I'll look into adding docs.
> > 
> > This is a sysfs attribute that basically removes the pci_dev and re-
> > adds it. This has the complication that since the attribute sits at
> > /sys/bus/pci/devices/<dev>/recover it deletes its own parent directory
> > which requires extra caution and means concurrent accesses block on
> > pci_lock_rescan_remove() instead of a kernfs lock.
> > Long story short when concurrently triggering the attribute one thread
> > proceeds into the pci_lock_rescan_remove() section and does the
> > removal, while others would block on pci_lock_rescan_remove(). Now when
> > the threads unblock the removal is done. In this case there is a new
> > struct pci_dev found in the rescan but the previously blocked threads
> > still have references to the old struct pci_dev which was removed and
> > as far as I could tell can only be distinguished by checking
> > pci_dev_is_added().
> 
> Is this locking issue different from concurrently writing to
> /sys/.../remove on other architectures?

In principle it is very similar except that we re-scan and thus the
removed pdev may co-exist with a new pdev for the same actual device if
there are other references to the pdev.

There is however also a significant difference in locking that fixes a
possible deadlock that I just confirmed also affects /sys/../remove
where it is hidden by a lockdep ignore, see lockdep splash below. 

For /sys/../recover this was fixed by my commit dd712f0a53ca
("s390/pci: Fix possible deadlock in  recover_store()") which also
introduced the need for pci_dev_is_added().

The change in the above commit is very similar to what is done in
drivers/scsi/scsi_sysfs.c:sdev_store_delete() which also has a self
deletion and in commit 0ee223b2e1f6 ("scsi: core: Avoid that SCSI
device removal through sysfs triggers a deadlock") fixed a very very
similar lock order problem.

Like the SCSI code I use sysfs_break_active_protection() which allows a
concurrent access to /sys/../recover to advance into recover_store().
It may then block on pci_lock_rescan_remove() instead of the kernfs
lock it would block on with just delete_remove_file_self(). Thus we
have to handle unblocking from pci_lock_rescan_remove() while holding
the stale struct pci_dev of the removed device. Together with the re-
scan this means I have to be able to determine after unblocking if I'm
looking at the old pdev.

I just tested that when removing the lockdep ignore from remove_store()
and do /sys/../power and /sys/../remove I do hit the same lock order
inversion issue there for remove. Note that unlike in the commit
introducing the ignore this is a completely flat hiearchy:

[  234.196509] ======================================================
[  234.196511] WARNING: possible circular locking dependency detected
[  234.196512] 5.14.0-rc7-08025-gf6d7568b37df-dirty #18 Not tainted
[  234.196514] ------------------------------------------------------
[  234.196516] zsh/1214 is trying to acquire lock:
[  234.196518] 000000013f296e30 (pci_rescan_remove_lock){+.+.}-{3:3}, at: pci_stop_and_remove_bus_device_locked+0x26/0x48
[  234.196529]
               but task is already holding lock:
[  234.196530] 000000009b6c3a10 (kn->active#363){++++}-{0:0}, at: sysfs_remove_file_self+0x42/0x78
[  234.196538]
               which lock already depends on the new lock.

[  234.196539]
               the existing dependency chain (in reverse order) is:
[  234.196541]
               -> #1 (kn->active#363){++++}-{0:0}:
[  234.196545]        validate_chain+0x9ca/0xde8
[  234.196548]        __lock_acquire+0x64c/0xc40
[  234.196550]        lock_acquire.part.0+0xec/0x258
[  234.196552]        lock_acquire+0xb0/0x200
[  234.196554]        kernfs_drain+0x17a/0x1c8
[  234.196556]        __kernfs_remove+0x1f4/0x230
[  234.196558]        kernfs_remove_by_name_ns+0x5c/0xa8
[  234.196560]        remove_files+0x46/0x90
[  234.196563]        sysfs_remove_group+0x5a/0xb8
[  234.196565]        sysfs_remove_groups+0x46/0x68
[  234.196567]        device_remove_attrs+0x90/0xb8
[  234.196598]        device_del+0x192/0x3f8
[  234.196600]        pci_remove_bus_device+0x8a/0x128
[  234.196602]        pci_stop_and_remove_bus_device_locked+0x3a/0x48
[  234.196604]        zpci_bus_remove_device+0x68/0xa8
[  234.196607]        zpci_deconfigure_device+0x3a/0xe0
[  234.196610]        power_write_file+0x7c/0x130
[  234.196615]        kernfs_fop_write_iter+0x13e/0x1e0
[  234.196617]        new_sync_write+0x100/0x190
[  234.196620]        vfs_write+0x21e/0x2d0
[  234.196622]        ksys_write+0x6c/0xf8
[  234.196624]        __do_syscall+0x1c2/0x1f0
[  234.196628]        system_call+0x78/0xa0
[  234.196632]
               -> #0 (pci_rescan_remove_lock){+.+.}-{3:3}:
[  234.196636]        check_noncircular+0x168/0x188
[  234.196637]        check_prev_add+0xe0/0xed8
[  234.196639]        validate_chain+0x9ca/0xde8
[  234.196641]        __lock_acquire+0x64c/0xc40
[  234.196642]        lock_acquire.part.0+0xec/0x258
[  234.196644]        lock_acquire+0xb0/0x200
[  234.196646]        __mutex_lock+0xa2/0x8d8
[  234.196648]        mutex_lock_nested+0x32/0x40
[  234.196649]        pci_stop_and_remove_bus_device_locked+0x26/0x48
[  234.196652]        remove_store+0x7a/0x88
[  234.196654]        kernfs_fop_write_iter+0x13e/0x1e0
[  234.196656]        new_sync_write+0x100/0x190
[  234.196657]        vfs_write+0x21e/0x2d0
[  234.196659]        ksys_write+0x6c/0xf8
[  234.196661]        __do_syscall+0x1c2/0x1f0
[  234.196663]        system_call+0x78/0xa0
[  234.196665]
               other info that might help us debug this:

[  234.196666]  Possible unsafe locking scenario:

[  234.196668]        CPU0                    CPU1
[  234.196669]        ----                    ----
[  234.196670]   lock(kn->active#363);
[  234.196672]                                lock(pci_rescan_remove_lock);
[  234.196674]                                lock(kn->active#363);
[  234.196677]   lock(pci_rescan_remove_lock);
[  234.196679]
                *** DEADLOCK ***

[  234.196680] 3 locks held by zsh/1214:
[  234.196682]  #0: 0000000099d44498 (sb_writers#3){.+.+}-{0:0}, at: ksys_write+0x6c/0xf8
[  234.196688]  #1: 00000000b214ee90 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x102/0x1e0
[  234.196693]  #2: 000000009b6c3a10 (kn->active#363){++++}-{0:0}, at: sysfs_remove_file_self+0x42/0x78
[  234.196699]
               stack backtrace:
[  234.196701] CPU: 6 PID: 1214 Comm: zsh Not tainted 5.14.0-rc7-08025-gf6d7568b37df-dirty #18
[  234.196703] Hardware name: IBM 8561 T01 703 (LPAR)
[  234.196705] Call Trace:
[  234.196706]  [<000000013ebba5d0>] show_stack+0x90/0xf8
[  234.196711]  [<000000013ebcc28e>] dump_stack_lvl+0x8e/0xc8
[  234.196714]  [<000000013dfbe908>] check_noncircular+0x168/0x188
[  234.196716]  [<000000013dfbf9c8>] check_prev_add+0xe0/0xed8
[  234.196718]  [<000000013dfc118a>] validate_chain+0x9ca/0xde8
[  234.196720]  [<000000013dfc4184>] __lock_acquire+0x64c/0xc40
[  234.196721]  [<000000013dfc2d8c>] lock_acquire.part.0+0xec/0x258
[  234.196724]  [<000000013dfc2fa8>] lock_acquire+0xb0/0x200
[  234.196725]  [<000000013ebdac7a>] __mutex_lock+0xa2/0x8d8
[  234.196727]  [<000000013ebdb4e2>] mutex_lock_nested+0x32/0x40
[  234.196729]  [<000000013e7daaf6>] pci_stop_and_remove_bus_device_locked+0x26/0x48
[  234.196732]  [<000000013e7e753a>] remove_store+0x7a/0x88
[  234.196734]  [<000000013e35b4be>] kernfs_fop_write_iter+0x13e/0x1e0
[  234.196736]  [<000000013e264098>] new_sync_write+0x100/0x190
[  234.196738]  [<000000013e266f06>] vfs_write+0x21e/0x2d0
[  234.196740]  [<000000013e267224>] ksys_write+0x6c/0xf8
[  234.196742]  [<000000013ebcf9da>] __do_syscall+0x1c2/0x1f0
[  234.196744]  [<000000013ebe2238>] system_call+0x78/0xa0


> 
> > > Maybe we should make powerpc and s390 less special?
> > 
> > On s390, as I see it, the reason for this is that all of the PCI
> > functionality is directly defined in the Architecture as special CPU
> > instructions which are kind of hypercalls but also an ISA extension.
> > 
> > These instructions range from the basic PCI memory accesses (no real
> > MMIO) to enumeration of the devices and on to reporting of hot-plug and
> > and resets/recovery events. Importantly we do not have any kind of
> > direct access to a real or virtual PCI controller and the architecture
> > has no concept of a comparable entity.
> > 
> > So in my opinion while there is some of the functionality of a PCI
> > controller in arch/s390/pci the cut off between controller
> > functionality and arch support isn't clear at all and exposing PCI
> > support as CPU instructions doesn't map well to the controller concept.
> > 
> > That said, in principle I'm open to moving some of that into
> > drivers/pci/controller/ if you think that would improve things and we
> > can find a good argument what should go where. One possible cut off
> > would be to have arch/s390/pci/ provide wrappers to the PCI
> > instructions but move all their uses to  e.g.
> > drivers/pci/controller/s390/. This would of course be a major
> > refactoring and none of that code would be useful on any other
> > architecture but it would move a lot the accesses to PCI common code
> > functionality out of the arch code.
> 
> Looks like hotplug is already in drivers/pci/hotplug/s390_pci_hpc.c.
> 
> Might be worth considering putting the other PCI core-ish code in
> drivers/pci as well, though it doesn't feel urgent to me.  Maybe a
> good internship or mentoring project.

I agree

> 
> I'm not sure this juggling around is worth it basically to just clean
> up the include path.  The downside to me is exposing
> pci_dev_is_added() to outside the PCI core, because I don't want
> to encourage any other users.

Hmm, for me the big question how to then handle the need for
pci_dev_is_added() in my upcoming recovery code, that would be a new
user outside the PCI core unless I move arch/s390/pci/pci_event.c to
drivers/pci.

That said I'm not sure I understand yet what makes pci_dev_is_added()
unsuitable for outside the PCI core. I do understand that struct
pci_dev::priv_flags is supposed to be private to PCI drivers but on the
other hand the functionality of checking whether a PCI device has been
added to a PCI bus seems rather basic and useful whenever working with
a PCI device.

> 
> > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > > ---
> > > > Since v1 (and bad v2):
> > > > - Fixed accidental removal of PCI_DPC_RECOVERED, PCI_DPC_RECOVERING
> > > >   defines and also move these to include/linux/pci.h
> > > > 
> > > >  arch/powerpc/platforms/powernv/pci-sriov.c |  3 ---
> > > >  arch/powerpc/platforms/pseries/setup.c     |  1 -
> > > >  arch/s390/pci/pci_sysfs.c                  |  2 --
> > > >  drivers/pci/hotplug/acpiphp_glue.c         |  1 -
> > > >  drivers/pci/pci.h                          | 15 ---------------
> > > >  include/linux/pci.h                        | 15 +++++++++++++++
> > > >  6 files changed, 15 insertions(+), 22 deletions(-)
> > > > 
> > > > diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/platforms/powernv/pci-sriov.c
> > > > index 28aac933a439..2e0ca5451e85 100644
> > > > --- a/arch/powerpc/platforms/powernv/pci-sriov.c
> > > > +++ b/arch/powerpc/platforms/powernv/pci-sriov.c
> > > > @@ -9,9 +9,6 @@
> > > >  
> > > >  #include "pci.h"
> > > >  
> > > > -/* for pci_dev_is_added() */
> > > > -#include "../../../../drivers/pci/pci.h"
> > > > 
> > .. snip ..
> > 

