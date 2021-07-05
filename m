Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09B13BBCED
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jul 2021 14:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhGEMnT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Jul 2021 08:43:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57214 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230188AbhGEMnT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Jul 2021 08:43:19 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 165CXBp8111265;
        Mon, 5 Jul 2021 08:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+wzwx/rOWMtl2r9GcTZe+zXqgVhpNq7S2WQ1D1BJGrc=;
 b=aROnRBytRIk1ez38XeC4cePF2pOS/eq9A6h5a5W7AeUVML7CyuEvp1uirwyhCw3TTync
 ha0H4DnLXHvFzOVqbaTmlHv/Hg6N/2BXisMNj9ytgporkybdDbMg0xDz75Z0hSZImBp8
 xwHZNXaEKj18it7Lg/SS8+gcJnpeQPNkw2k+CwlGcUaCEhXRMNN9qOJ4GXjALRHxbQnp
 hv00ydqtqpvKVhzw0RoDY8PACZMST+3T50amaul96cmdcXHgKLS14LQl+77lSW2tjBb8
 PQrBnE91LOmFi81326CKPaJTyj7dBjeqvhsuGPU7TAVpfHyk2KNM81zlP4qvrazO2QlM CQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39kyj0cs3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jul 2021 08:40:40 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 165CYsvU016959;
        Mon, 5 Jul 2021 12:40:38 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 39jf5h8suh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jul 2021 12:40:38 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 165Cea6W31326696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Jul 2021 12:40:36 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DCB411C064;
        Mon,  5 Jul 2021 12:40:36 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C546711C050;
        Mon,  5 Jul 2021 12:40:35 +0000 (GMT)
Received: from sig-9-145-159-22.de.ibm.com (unknown [9.145.159.22])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Jul 2021 12:40:35 +0000 (GMT)
Message-ID: <d1d41b7ca4bf2b25e234e5cda0ad624e714f7a64.camel@linux.ibm.com>
Subject: Re: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 05 Jul 2021 14:40:35 +0200
In-Reply-To: <CAK8P3a1D5DzmNGsEPQomkyMCmMrtD6pQ11JRMh78vbY53edp-Q@mail.gmail.com>
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
         <CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com>
         <CAK8P3a1D5DzmNGsEPQomkyMCmMrtD6pQ11JRMh78vbY53edp-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8qRyU10tlyXzjrA-NE2p44wRQ1ld1zne
X-Proofpoint-ORIG-GUID: 8qRyU10tlyXzjrA-NE2p44wRQ1ld1zne
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-05_07:2021-07-02,2021-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 spamscore=0 clxscore=1011 bulkscore=0 adultscore=0
 mlxlogscore=984 lowpriorityscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107050067
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 2021-07-03 at 14:12 +0200, Arnd Bergmann wrote:
> On Fri, Jul 2, 2021 at 9:42 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Fri, Jul 2, 2021 at 6:48 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > > A rework for PCI I/O space access from Niklas Schnelle:
> > 
> > I pulled this, but then I ended up unpulling.
> > 
> > I don't absolutely _hate_ the concept, but I really find this to be
> > very unpalatable:
> > 
> >   #if !defined(inb) && !defined(_inb)
> >   #define _inb _inb
> >   static inline u8 _inb(unsigned long addr)
> >   {
> >   #ifdef PCI_IOBASE
> >         u8 val;
> > 
> >         __io_pbr();
> >         val = __raw_readb(PCI_IOBASE + addr);
> >         __io_par(val);
> >         return val;
> >   #else
> >         WARN_ONCE(1, "No I/O port support\n");
> >         return ~0;
> >   #endif
> >   }
> >   #endif
> > 
> > because honestly, the notion of a run-time warning for a compile-time
> > "this cannot work" is just wrong.
> 
> Ok, fair enough, back to the drawing board then.

Yes, hard to argue with the reasoning. I'll be here to assist with
testing etc.

> 
> > If the platform doesn't have inb/outb, and you compile some driver
> > that uses them, you don't want a run-time warning. Particularly since
> > in many cases nobody will ever run it, and the main use case was to do
> > compile-testing across a wide number of platforms.
> > 
> > So if the platform doesn't have inb/outb, they simply should not be
> > declared, and there should be a *compile-time* error. That is
> > literally a lot more useful, and it avoids this extra code.
> 
> I tried adding a Kconfig option over a decade ago, but at the time
> gave up when I couldn't still get drivers/ide and the 8250 uart driver
> to build in a sensible way that would still allow the MMIO based
> variants to work, but leave out the PIO accessors. With drivers/ide
> gone, and the drivers/tty/serial/ having gone through many changes,
> it's probably easier now.
> 
> I could imagine adding a CONFIG_LEGACY_PCI that controls
> whether we have any pre-PCIe devices or those PCIe drivers
> that need PIO accessors other than ioport_map()/pci_iomap().
> 
> This can then select a CONFIG_IOPORT, which controls whether
> inb/outb etc are provided. x86 and anything that uses inb/outb for
> non-PCI devices would select it as well.

I saw your patch in the other mail and will give it a try on our
systems as well.

> 
> > Extra code that not only doesn't add value, but that actually
> > *subtracts* value is not code I really want to pull.
> 
> What happened here specifically is that the asm-generic version
> is definitely broken and can cause a NULL pointer dereference
> on platforms that used to fall back to NULL PCI_IOBASE.
> 
> The latest clang does complain about those drivers with a
> correct warning (not an error) that shows up in s390 allmodconfig
> builds. Niklas' original version of the patch tried to shut up the
> warning but did not address the dangerous behavior, which I
> did not find sufficient either.
> 
> The version we got here makes it no longer crash the kernel, but
> I see your point that the runtime warning is still wrong. I'll have
> a look at what it would take to guard all inb/outb callers with a
> Kconfig conditional, and will report back after that.
> 
>       Arnd

Thanks for your explanation I had already forgotten some of the details
and have nothing to add.

Except, thanks, I guess I can now strike "Got code criticiced by Linus
Torvalds" from my bucket list.

