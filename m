Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961493F490A
	for <lists+linux-arch@lfdr.de>; Mon, 23 Aug 2021 12:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbhHWKy4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Aug 2021 06:54:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234701AbhHWKy4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Aug 2021 06:54:56 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17NAYN3b039643;
        Mon, 23 Aug 2021 06:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=VK03W+30BqBYeXpGwPZrGnWV+vbZaZ/TMMug5lrNGn8=;
 b=JgYC0gODFl8HmCalHaHw745zt3POR0EpG3aUrewK2WN3A769e5hI0hS3/2YOTQH06x3G
 Q1pjiH/hapDcLXmUAwOk2qFU13UZnthyIjxBz/ne+KttOywWrOaYOGuVmVaAZfh/iYZQ
 gbFFyn9vcCFfjAGpjpIC8iJG1tRTFgqolcqZAn2Tb4r8iFmYJNE6ZNbtS1xpNt7BJ9RA
 LrzVk4WnbOsKIFz6Hf0gZDIcsybzmNJkh7JOXGvvCOa/NUCS1xxeVFurkJ/1j5hNTJzA
 +PIdzBFyv8+hzUonJGSBTokfD8jrltSd2N1EpZiB44fbpfeBiTl6bt8dm1o0C8RqjFoG Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3am358artv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 06:53:46 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17NAYciQ040734;
        Mon, 23 Aug 2021 06:53:46 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3am358artg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 06:53:46 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17NArNtJ006021;
        Mon, 23 Aug 2021 10:53:44 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3ajs48jpv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 10:53:44 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17NArets26280222
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 10:53:40 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B5E2A4096;
        Mon, 23 Aug 2021 10:53:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC76FA4098;
        Mon, 23 Aug 2021 10:53:39 +0000 (GMT)
Received: from sig-9-145-159-82.de.ibm.com (unknown [9.145.159.82])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Aug 2021 10:53:39 +0000 (GMT)
Message-ID: <7595397d6c32ae8745201085956696866cc400b6.camel@linux.ibm.com>
Subject: Re: [PATCH v3] PCI: Move pci_dev_is/assign_added() to pci.h
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 23 Aug 2021 12:53:39 +0200
In-Reply-To: <20210820223734.GA3366782@bjorn-Precision-5520>
References: <20210820223734.GA3366782@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sPEaVfThlIByYT9mCQ6fz2K2kUsFA1OW
X-Proofpoint-GUID: Srhjx2oMjFIXmjyTPWQ2Mu1yV3gTT4k-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-23_02:2021-08-23,2021-08-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108230070
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2021-08-20 at 17:37 -0500, Bjorn Helgaas wrote:
> On Tue, Jul 20, 2021 at 05:01:45PM +0200, Niklas Schnelle wrote:
> > The helper function pci_dev_is_added() from drivers/pci/pci.h is used in
> > PCI arch code of both s390 and powerpc leading to awkward relative
> > includes. Move it to the global include/linux/pci.h and get rid of these
> > includes just for that one function.
> 
> I agree the includes are awkward.
> 
> But the arch code *using* pci_dev_is_added() seems awkward, too.

See below for my interpretation why s390 has some driver like
functionality in its arch code which isn't necessarily awkward.

Independent from that I have found pci_dev_is_added() as the only way
deal with the case that one might be looking at a struct pci_dev
reference that has been removed via pci_stop_and_remove_bus_device() or
has never been fully scanned. This is quite useful when handling error
events which on s390 are part of the adapter event mechanism shared
with channel I/O devices.

> 
> AFAICS, in powerpc, pci_dev_is_added() is only used by
> pnv_pci_ioda_fixup_iov() and pseries_pci_fixup_iov_resources().  Those
> are only called from pcibios_add_device(), which is only called from
> pci_device_add().
> 
> Is it even possible for pci_dev_is_added() to be true in that path?
> 
> s390 uses pci_dev_is_added() in recover_store()

I'm actually looking into this as I'm working on an s390 implementation
of the PCI recovery flow described in Documentation/PCI/pci-error-
recovery.rst that would also call pci_dev_is_added() because when we
get a platform notification of a PCI reset done by firmware it may be
that the sturct pci_dev is going away i.e. we still have a ref count
but it is not added to the PCI bus anymore. And pci_dev_is_added() is
the only way I've found to check for this state.

> , but I don't know what
> that is (looks like a sysfs file, but it's not documented) or why s390
> is the only arch that does this.

Good point about this not being documented, I'll look into adding docs.

This is a sysfs attribute that basically removes the pci_dev and re-
adds it. This has the complication that since the attribute sits at
/sys/bus/pci/devices/<dev>/recover it deletes its own parent directory
which requires extra caution and means concurrent accesses block on
pci_lock_rescan_remove() instead of a kernfs lock.
Long story short when concurrently triggering the attribute one thread
proceeds into the pci_lock_rescan_remove() section and does the
removal, while others would block on pci_lock_rescan_remove(). Now when
the threads unblock the removal is done. In this case there is a new
struct pci_dev found in the rescan but the previously blocked threads
still have references to the old struct pci_dev which was removed and
as far as I could tell can only be distinguihsed by checking
pci_dev_is_added().

> 
> Maybe we should make powerpc and s390 less special?

On s390, as I see it, the reason for this is that all of the PCI
functionality is directly defined in the Architecture as special CPU
instructions which are kind of hypercalls but also an ISA extension.

These instructions range from the basic PCI memory accesses (no real
MMIO) to enumeration of the devices and on to reporting of hot-plug and
and resets/recovery events. Importantly we do not have any kind of
direct access to a real or virtual PCI controller and the architecture
has no concept of a comparable entity.

So in my opinion while there is some of the functionality of a PCI
controller in arch/s390/pci the cut off between controller
functionality and arch support isn't clear at all and exposing PCI
support as CPU instructions doesn't map well to the controller concept.

That said, in principle I'm open to moving some of that into
drivers/pci/controller/ if you think that would improve things and we
can find a good argument what should go where. One possible cut off
would be to have arch/s390/pci/ provide wrappers to the PCI
instructions but move all their uses to  e.g.
drivers/pci/controller/s390/. This would of course be a major
refactoring and none of that code would be useful on any other
architecture but it would move a lot the accesses to PCI common code
functionality out of the arch code.

> 
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> > Since v1 (and bad v2):
> > - Fixed accidental removal of PCI_DPC_RECOVERED, PCI_DPC_RECOVERING
> >   defines and also move these to include/linux/pci.h
> > 
> >  arch/powerpc/platforms/powernv/pci-sriov.c |  3 ---
> >  arch/powerpc/platforms/pseries/setup.c     |  1 -
> >  arch/s390/pci/pci_sysfs.c                  |  2 --
> >  drivers/pci/hotplug/acpiphp_glue.c         |  1 -
> >  drivers/pci/pci.h                          | 15 ---------------
> >  include/linux/pci.h                        | 15 +++++++++++++++
> >  6 files changed, 15 insertions(+), 22 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/platforms/powernv/pci-sriov.c
> > index 28aac933a439..2e0ca5451e85 100644
> > --- a/arch/powerpc/platforms/powernv/pci-sriov.c
> > +++ b/arch/powerpc/platforms/powernv/pci-sriov.c
> > @@ -9,9 +9,6 @@
> >  
> >  #include "pci.h"
> >  
> > -/* for pci_dev_is_added() */
> > -#include "../../../../drivers/pci/pci.h"
> > 
.. snip ..

