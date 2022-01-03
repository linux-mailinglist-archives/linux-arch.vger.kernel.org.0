Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3045C48309E
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 12:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiACLgh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 06:36:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47602 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230417AbiACLgg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 06:36:36 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 203A0o71029810;
        Mon, 3 Jan 2022 11:35:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ufpavbPzye5iN5lSyr7+fUSKFKCjhh0g0AU+dxcxb3c=;
 b=A2xXU2hyLLk1AgKWY6pxZ630TcoWds27eIt1Rin7V5OjbLAqsYFiloY4Usja1nvhkh2F
 UUeuoBoZ8LpiWfH5MA/pagi8s9AkrESyRrw0oL4v+6Yd7rqucz/1Fji1t3z2ZyVbr2f0
 acybJBJmungBlwHyoMI5FHGYr3iKc7/zOm8RJjPv+fp931iPs3ZcMaWr9tkpWh9q2qQI
 Fmh0LNqxUzfyDswy708AfuLz/ZqibLDmSMbhqJgZs6PDHC3Rt6Hym8SFGUdeIwYGaMhV
 KhYxT7+JEMhozui5xbw8jHd8uwzPBnuvLoEBWYK5nRIOU7hFFmexbKUjEMJswupxE3po yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dburw575m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jan 2022 11:35:53 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 203BPuqO021269;
        Mon, 3 Jan 2022 11:35:52 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dburw5754-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jan 2022 11:35:52 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 203BRxcF011535;
        Mon, 3 Jan 2022 11:35:50 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3dae7jj7u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jan 2022 11:35:50 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 203BR5vh35848610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Jan 2022 11:27:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 834CEA405B;
        Mon,  3 Jan 2022 11:35:47 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41503A4060;
        Mon,  3 Jan 2022 11:35:46 +0000 (GMT)
Received: from sig-9-145-76-151.uk.ibm.com (unknown [9.145.76.151])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 Jan 2022 11:35:46 +0000 (GMT)
Message-ID: <5a271c9e80ee394ecb41297e66d687e035a823ce.camel@linux.ibm.com>
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
Date:   Mon, 03 Jan 2022 12:35:45 +0100
In-Reply-To: <Yc86mvCUe2mHCa57@rowland.harvard.edu>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
         <20211227164317.4146918-32-schnelle@linux.ibm.com>
         <YcojyRhALdm40gfk@rowland.harvard.edu>
         <8bda347ea30b60f1edb55693ff7509e7f7b1f979.camel@linux.ibm.com>
         <Yc86mvCUe2mHCa57@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N2-PFTq6n9ARg6TLDEy1ybSsJR7I5_iF
X-Proofpoint-GUID: 3vxwt5eQUgZM-hiixHGby9Mzv2OlZGvJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-03_04,2022-01-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=574 priorityscore=1501 impostorscore=0 phishscore=0
 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201030078
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2021-12-31 at 12:15 -0500, Alan Stern wrote:
> On Fri, Dec 31, 2021 at 12:06:24PM +0100, Niklas Schnelle wrote:
> > On Mon, 2021-12-27 at 15:36 -0500, Alan Stern wrote:
> > > On Mon, Dec 27, 2021 at 05:43:16PM +0100, Niklas Schnelle wrote:
> > > > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > > > not being declared. We thus need to guard sections of code calling them
> > > > as alternative access methods with CONFIG_HAS_IOPORT checks. Similarly
> > > > drivers requiring these functions need to depend on HAS_IOPORT.
> > > 
> > > A few things in here can be improved.
> > > 
> > > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > > ---
> > > > diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> > > > index ef08d68b9714..bba320194027 100644
> > > > --- a/drivers/usb/host/pci-quirks.c
> > > > +++ b/drivers/usb/host/pci-quirks.c
> > > > +#ifdef CONFIG_USB_PCI_AMD
> > > > +#if IS_ENABLED(CONFIG_USB_UHCI_HCD) && defined(CONFIG_HAS_IOPORT)
> > > 
> > > In the original, the following code will be compiled even if
> > > CONFIG_USB_UHCI_HCD is not enabled.  You shouldn't change that.
> > 
> > If this was only '#ifdef CONFIG_HAS_IOPORT' we would leave
> > uhci_reset_hc() undeclared in the case where CONFIG_HAS_IOPORT is
> > unset. This function however is also called from uhci-pci.c. That on
> > the other hand is built only if CONFIG_USB_UHCI_HCD is set so if we
> > depend on both config options we can get rid of all calls and have the
> > functions undeclared.
> 
> But you changed the guard around the '#include "uhci-pci.c"' line in 
> uhci-hcd.c, so uhci-pci.c won't be built if CONFIG_HAS_IOPORT is unset.  
> Thus there won't be an undefined function call regardless.

Ah thanks yes that makes sense. I seem to have gotten confused by the
uhci-hcd.c vs uhci-pci.c dependency.

> 
> You see, even if the kernel isn't configured to include a UHCI driver, 
> it's still important to hand off and disable any PCI UHCI hardware when 
> the system starts up.  Otherwise you can get all sorts of crazy 
> interrupts and DMA from the BIOS.

Thanks for the explanation, this is very helpful to understand the
context.

> 
> > > >  /*
> > > >   * Make sure the controller is completely inactive, unable to
> > > >   * generate interrupts or do DMA.
> > > > @@ -1273,7 +1277,8 @@ static void quirk_usb_early_handoff(struct pci_dev *pdev)
> > > >  			 "Can't enable PCI device, BIOS handoff failed.\n");
> > > >  		return;
> > > >  	}
> > > > -	if (pdev->class == PCI_CLASS_SERIAL_USB_UHCI)
> > > > +	if (IS_ENABLED(CONFIG_USB_UHCI_HCD) &&
> > > > +	    pdev->class == PCI_CLASS_SERIAL_USB_UHCI)
> > > >  		quirk_usb_handoff_uhci(pdev);
> > > 
> > > Same idea here.
> > 
> > Hmm, I'm not 100% sure if the IS_ENABLED(CONFIG_USB_UHCI_HCD) depends
> > on some compiler optimizations for it to be ok that
> > uhci_check_and_reset_hc() is not declared in the case where both
> > CONFIG_HAS_IOPORT and CONFIG_USB_UHCI_HCD are unset. Maybe that should
> > be a plain ifdef.
> 
> The reasoning should be exactly the same as in the previous case.

Yeah with your above explanation it makes sense that we need to keep
the calls even if CONFIG_USB_UHCI_HCD is not enabled. We're also
handling the CONFIG_HAS_IOPORT=n case in quirk_usb_handoff_uhci()
anyway.

> 
> > > > diff --git a/drivers/usb/host/uhci-hcd.h b/drivers/usb/host/uhci-hcd.h
> > > > index 8ae5ccd26753..8e30116b6fd2 100644
> > > > --- a/drivers/usb/host/uhci-hcd.h
> > > > +++ b/drivers/usb/host/uhci-hcd.h
> > > > @@ -586,12 +586,14 @@ static inline int uhci_aspeed_reg(unsigned int reg)
> > > >  
> > > >  static inline u32 uhci_readl(const struct uhci_hcd *uhci, int reg)
> > > >  {
> > > > +#ifdef CONFIG_HAS_IOPORT
> > > >  	if (uhci_has_pci_registers(uhci))
> > > >  		return inl(uhci->io_addr + reg);
> > > > -	else if (uhci_is_aspeed(uhci))
> > > > +#endif
> > > 
> > > Instead of making all these changes (here and in the hunks below), you
> > > can simply modify the definition of uhci_has_pci_registers() so that it
> > > always gives 0 when CONFIG_HAS_IOPORT is N.
> > > 
> > > Alan Stern
> > 
> > I don't think that works, for example in the hunk you quoted returning
> > 0 from uhci_has_pci_registers() only skips over the inl() at run-time.
> > We're aiming to have inl() undeclared if HAS_IOPORT is unset though.
> 
> I see.  Do you think the following would be acceptable?  Add:
> 
> #ifdef CONFIG_HAS_IOPORT
> #define UHCI_IN(x)	x
> #define UHCI_OUT(x)	x
> #else
> #define UHCI_IN(x)	0
> #define UHCI_OUT(x)
> #endif
> 
> and then replace for example inl(uhci->io_addr + reg) with 
> UHCI_IN(inl(uhci->io_addr + reg)).

In principle that looks like a valid approach. Not sure this is better
than explicit ifdefs though. With this approach one could add
UHCI_IN()/UHCI_OUT() calls which end up as nops without realizing it as
it would disable any compile time warning for using them without
guarding against CONFIG_HAS_IOPORT being undefined.

> 
> The definition of uhci_has_pci_registers() should be updated in any 
> case; there's no reason for it to do a runtime check of uhci->io_addr 
> when HAS_IOPORT is disabled.

Agree. Interestingly same as with the "if
(IS_ENABLED(CONFIG_HAS_IOPORT))" it seems having
uhci_has_pci_registers() compile-time defined to 0 (I added a
defined(CONFIG_HAS_IOPORT) to it) makes the compiler ignore the missing
inl() decleration already. But I'm not sure if we should rely on that.



