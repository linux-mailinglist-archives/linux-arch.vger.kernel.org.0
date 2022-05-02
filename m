Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97348516BFF
	for <lists+linux-arch@lfdr.de>; Mon,  2 May 2022 10:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383736AbiEBIaG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 May 2022 04:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379079AbiEBIaF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 May 2022 04:30:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E0B522EB;
        Mon,  2 May 2022 01:26:36 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2426eC2D030335;
        Mon, 2 May 2022 08:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=c4F418i+uSY5SQ6IJyvNoDoM0QEZy3napvtaDUHfy0I=;
 b=HzUzLL/HjPhwv8gvMuxpqbDgvJ3kgKRkJVUs5qqeU0YC/hUxnRQ1NRGDmmrlOirZdTMv
 8F27mbJ/+KUz6r5LwheWjj620v6GooMCTw/HMrOlJBlDyS3FsrDhKq+dkQlpFX+MF9Vp
 hJMeDxWGP7W+yPrmbWOF94hhv+SRNhBc8uXPA5Hve4F+LIPFcDDF49C426/9uKu6SKiU
 7InuTYLgr+13JbjB6PehCYTu6qvfho2a+NZr7wZr9rzV1X7tDvALmwq8G4Wocn7iinsi
 H1whJoo7wYmxQlBuIZPeabnJV+zgxd0hoFEl+9ew2JFcjdCDO8uB85DNiBs8LedjniCf KQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ft7tmbs5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 08:26:28 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2428D9Km021486;
        Mon, 2 May 2022 08:26:26 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3frvr8tcct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 08:26:25 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2428QNvX52756784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 May 2022 08:26:23 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3C2111C04C;
        Mon,  2 May 2022 08:26:23 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 562FD11C04A;
        Mon,  2 May 2022 08:26:23 +0000 (GMT)
Received: from sig-9-145-11-74.uk.ibm.com (unknown [9.145.11.74])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 May 2022 08:26:23 +0000 (GMT)
Message-ID: <bc46562ab57cfc1e0805280b7fb153b02885c72c.camel@linux.ibm.com>
Subject: Re: [RFC v2 35/39] usb: handle HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>
Date:   Mon, 02 May 2022 10:26:23 +0200
In-Reply-To: <Ym0yBti0J5w2S59W@rowland.harvard.edu>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
         <20220429135108.2781579-65-schnelle@linux.ibm.com>
         <Ym0yBti0J5w2S59W@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ewUH-9lsWOSWBJybGhHLJUarXPcD4BQx
X-Proofpoint-ORIG-GUID: ewUH-9lsWOSWBJybGhHLJUarXPcD4BQx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_02,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=781 phishscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205020062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 2022-04-30 at 08:56 -0400, Alan Stern wrote:
> On Fri, Apr 29, 2022 at 03:51:02PM +0200, Niklas Schnelle wrote:
> > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > not being declared. We thus need to guard sections of code calling them
> > as alternative access methods with CONFIG_HAS_IOPORT checks. Similarly
> > drivers requiring these functions need to depend on HAS_IOPORT.
> > 
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> 
> ...
> 
> > diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> > index ef08d68b9714..4fd06b48149d 100644
> > --- a/drivers/usb/host/pci-quirks.c
> > +++ b/drivers/usb/host/pci-quirks.c
> > @@ -632,7 +590,53 @@ bool usb_amd_pt_check_port(struct device *device, int port)
> >  	return !(value & BIT(port_shift));
> >  }
> >  EXPORT_SYMBOL_GPL(usb_amd_pt_check_port);
> > +#endif
> > @@ -1273,7 +1280,8 @@ static void quirk_usb_early_handoff(struct pci_dev *pdev)
> >  			 "Can't enable PCI device, BIOS handoff failed.\n");
> >  		return;
> >  	}
> > -	if (pdev->class == PCI_CLASS_SERIAL_USB_UHCI)
> > +	if (IS_ENABLED(CONFIG_USB_UHCI_HCD) &&
> > +	    pdev->class == PCI_CLASS_SERIAL_USB_UHCI)
> >  		quirk_usb_handoff_uhci(pdev);
> 
> We discussed this already.  quirk_usb_handoff_uhci() is supposed to be 
> called even when CONFIG_USB_UHCI_HCD isn't enabled.

Sorry I missed this part. Done.

> 
> ...
> 
> > diff --git a/drivers/usb/host/uhci-hcd.h b/drivers/usb/host/uhci-hcd.h
> > index 8ae5ccd26753..be4aee1f0ca5 100644
> > --- a/drivers/usb/host/uhci-hcd.h
> > +++ b/drivers/usb/host/uhci-hcd.h
> > @@ -505,36 +505,43 @@ static inline bool uhci_is_aspeed(const struct uhci_hcd *uhci)
> >   * we use memory mapped registers.
> >   */
> >  
> > +#ifdef CONFIG_HAS_IOPORT
> > +#define UHCI_IN(x)	x
> > +#define UHCI_OUT(x)	x
> > +#else
> > +#define UHCI_IN(x)	0
> > +#define UHCI_OUT(x)
> > +#endif
> 
> Should have a blank line here.

Done

> 
> >  #ifndef CONFIG_USB_UHCI_SUPPORT_NON_PCI_HC
> >  /* Support PCI only */
> >  static inline u32 uhci_readl(const struct uhci_hcd *uhci, int reg)
> >  {
> > -	return inl(uhci->io_addr + reg);
> > +	return UHCI_IN(inl(uhci->io_addr + reg));
> >  }
> >  
> >  static inline void uhci_writel(const struct uhci_hcd *uhci, u32 val, int reg)
> >  {
> > -	outl(val, uhci->io_addr + reg);
> > +	UHCI_OUT(outl(val, uhci->io_addr + reg));
> >  }
> >  
> >  static inline u16 uhci_readw(const struct uhci_hcd *uhci, int reg)
> >  {
> > -	return inw(uhci->io_addr + reg);
> > +	return UHCI_IN(inw(uhci->io_addr + reg));
> >  }
> >  
> >  static inline void uhci_writew(const struct uhci_hcd *uhci, u16 val, int reg)
> >  {
> > -	outw(val, uhci->io_addr + reg);
> > +	UHCI_OUT(outw(val, uhci->io_addr + reg));
> >  }
> >  
> >  static inline u8 uhci_readb(const struct uhci_hcd *uhci, int reg)
> >  {
> > -	return inb(uhci->io_addr + reg);
> > +	return UHCI_IN(inb(uhci->io_addr + reg));
> >  }
> >  
> >  static inline void uhci_writeb(const struct uhci_hcd *uhci, u8 val, int reg)
> >  {
> > -	outb(val, uhci->io_addr + reg);
> > +	UHCI_OUT(outb(val, uhci->io_addr + reg));
> >  }
> >  
> >  #else
> 
> I thought you were going to update the definition of 
> uhci_has_pci_registers().  It shouldn't do a test at runtime if 
> CONFIG_HAS_IOPORT is disabled.
> 
> Alan Stern

Good point. Done.


