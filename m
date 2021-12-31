Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F96448238F
	for <lists+linux-arch@lfdr.de>; Fri, 31 Dec 2021 12:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhLaLHS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Dec 2021 06:07:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229482AbhLaLHS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 Dec 2021 06:07:18 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BV6av2N020393;
        Fri, 31 Dec 2021 11:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=xJH5WwsfQJ8Mxc8BdV7taHeXPW9ViIdvk7MTMP7T6Ig=;
 b=nAAboAJ/QiK68ZivpqdzxMwieFswvdaOl8ZHsT5ChKZT+yiNjvz9gnZ8tkkLRVeNXxV9
 dhKdhMdAw/pme0PmK98yWu5byhSym6PKMQorkrMxuht0N8HRk4h7AgfSRD+yIYetALZO
 lfgts+/wV2RJ7A9/tvc2sCiP4xW6LRRDXZQ/6gkDRUB7OFDdSIkrfxV3IGzrfh6fJXor
 5yTEET3BP+TaaKsGyZ17k0oBLqSW25CJNtp7ZnRxbnYQKNdTxP7+kSfF0PLeRCwGU7ip
 IQa/+M/UzW01BZE0aMbzve2OJ5f425hqieQNj8iP1W+CWxRBBWyNM2/C7Jl0F0Nu0AQ0 VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d9q3ug5j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Dec 2021 11:06:30 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BVB6Uqf027150;
        Fri, 31 Dec 2021 11:06:30 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d9q3ug5hj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Dec 2021 11:06:30 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BVB1R2m016825;
        Fri, 31 Dec 2021 11:06:28 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3d5tjjyv0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Dec 2021 11:06:28 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BVB6PT224248770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Dec 2021 11:06:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B615EAE05F;
        Fri, 31 Dec 2021 11:06:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4108AE056;
        Fri, 31 Dec 2021 11:06:24 +0000 (GMT)
Received: from sig-9-145-181-202.de.ibm.com (unknown [9.145.181.202])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 31 Dec 2021 11:06:24 +0000 (GMT)
Message-ID: <8bda347ea30b60f1edb55693ff7509e7f7b1f979.camel@linux.ibm.com>
Subject: Re: [RFC 31/32] usb: handle HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Fri, 31 Dec 2021 12:06:24 +0100
In-Reply-To: <YcojyRhALdm40gfk@rowland.harvard.edu>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
         <20211227164317.4146918-32-schnelle@linux.ibm.com>
         <YcojyRhALdm40gfk@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NhNtF-1m6icXYNFDo79yGrG_eNf3x7BD
X-Proofpoint-ORIG-GUID: Vv488cpfeOJo0QVO7xxEqjUCmkZs45vg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-31_04,2021-12-30_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=404
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112310050
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2021-12-27 at 15:36 -0500, Alan Stern wrote:
> On Mon, Dec 27, 2021 at 05:43:16PM +0100, Niklas Schnelle wrote:
> > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > not being declared. We thus need to guard sections of code calling them
> > as alternative access methods with CONFIG_HAS_IOPORT checks. Similarly
> > drivers requiring these functions need to depend on HAS_IOPORT.
> 
> A few things in here can be improved.
> 
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >  drivers/usb/core/hcd-pci.c    |   3 +-
> >  drivers/usb/host/Kconfig      |   4 +-
> >  drivers/usb/host/pci-quirks.c | 127 ++++++++++++++++++----------------
> >  drivers/usb/host/pci-quirks.h |  33 ++++++---
> >  drivers/usb/host/uhci-hcd.c   |   2 +-
> >  drivers/usb/host/uhci-hcd.h   |  77 ++++++++++++++-------
> >  6 files changed, 148 insertions(+), 98 deletions(-)
> > diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> > index ef08d68b9714..bba320194027 100644
> > --- a/drivers/usb/host/pci-quirks.c
> > +++ b/drivers/usb/host/pci-quirks.c
> > +#ifdef CONFIG_USB_PCI_AMD
> > +#if IS_ENABLED(CONFIG_USB_UHCI_HCD) && defined(CONFIG_HAS_IOPORT)
> 
> In the original, the following code will be compiled even if
> CONFIG_USB_UHCI_HCD is not enabled.  You shouldn't change that.

If this was only '#ifdef CONFIG_HAS_IOPORT' we would leave
uhci_reset_hc() undeclared in the case where CONFIG_HAS_IOPORT is
unset. This function however is also called from uhci-pci.c. That on
the other hand is built only if CONFIG_USB_UHCI_HCD is set so if we
depend on both config options we can get rid of all calls and have the
functions undeclared.

> 
> >  /*
> >   * Make sure the controller is completely inactive, unable to
> >   * generate interrupts or do DMA.
> > @@ -1273,7 +1277,8 @@ static void quirk_usb_early_handoff(struct pci_dev *pdev)
> >  			 "Can't enable PCI device, BIOS handoff failed.\n");
> >  		return;
> >  	}
> > -	if (pdev->class == PCI_CLASS_SERIAL_USB_UHCI)
> > +	if (IS_ENABLED(CONFIG_USB_UHCI_HCD) &&
> > +	    pdev->class == PCI_CLASS_SERIAL_USB_UHCI)
> >  		quirk_usb_handoff_uhci(pdev);
> 
> Same idea here.

Hmm, I'm not 100% sure if the IS_ENABLED(CONFIG_USB_UHCI_HCD) depends
on some compiler optimizations for it to be ok that
uhci_check_and_reset_hc() is not declared in the case where both
CONFIG_HAS_IOPORT and CONFIG_USB_UHCI_HCD are unset. Maybe that should
be a plain ifdef.

> 
> >  	else if (pdev->class == PCI_CLASS_SERIAL_USB_OHCI)
> >  		quirk_usb_handoff_ohci(pdev);
> > diff --git a/drivers/usb/host/pci-quirks.h b/drivers/usb/host/pci-quirks.h
> > index e729de21fad7..42eb18be37af 100644
> > --- a/drivers/usb/host/pci-quirks.h
> > +++ b/drivers/usb/host/pci-quirks.h
> > @@ -2,33 +2,50 @@
> >  #ifndef __LINUX_USB_PCI_QUIRKS_H
> >  #define __LINUX_USB_PCI_QUIRKS_H
> >  
> > -#ifdef CONFIG_USB_PCI
> >  void uhci_reset_hc(struct pci_dev *pdev, unsigned long base);
> >  int uhci_check_and_reset_hc(struct pci_dev *pdev, unsigned long base);
> > -int usb_hcd_amd_remote_wakeup_quirk(struct pci_dev *pdev);
> > +
> > +struct pci_dev;
> 
> This can't be right; struct pci_dev is referred to three lines earlier.
> You could move this up, but it may not be needed at all.

I agree.

> 
> > diff --git a/drivers/usb/host/uhci-hcd.h b/drivers/usb/host/uhci-hcd.h
> > index 8ae5ccd26753..8e30116b6fd2 100644
> > --- a/drivers/usb/host/uhci-hcd.h
> > +++ b/drivers/usb/host/uhci-hcd.h
> > @@ -586,12 +586,14 @@ static inline int uhci_aspeed_reg(unsigned int reg)
> >  
> >  static inline u32 uhci_readl(const struct uhci_hcd *uhci, int reg)
> >  {
> > +#ifdef CONFIG_HAS_IOPORT
> >  	if (uhci_has_pci_registers(uhci))
> >  		return inl(uhci->io_addr + reg);
> > -	else if (uhci_is_aspeed(uhci))
> > +#endif
> 
> Instead of making all these changes (here and in the hunks below), you
> can simply modify the definition of uhci_has_pci_registers() so that it
> always gives 0 when CONFIG_HAS_IOPORT is N.
> 
> Alan Stern

I don't think that works, for example in the hunk you quoted returning
0 from uhci_has_pci_registers() only skips over the inl() at run-time.
We're aiming to have inl() undeclared if HAS_IOPORT is unset though.

