Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFE735F3DB
	for <lists+linux-arch@lfdr.de>; Wed, 14 Apr 2021 14:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbhDNMfM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Apr 2021 08:35:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28006 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229765AbhDNMfL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Apr 2021 08:35:11 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13ECXLjs082105;
        Wed, 14 Apr 2021 08:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=t08pgRARfONYID5oKmw0vTX25J07bAbAivjLULLeJlI=;
 b=OBv9mqk8OQSiONC9E+wYDo1FXHt4dM3rdsn/IuJ84PSLffEAlbm5N7JCOofjkvPeaadQ
 Uf9X0yQBTF6FTpHYq1QLbyJYsASUSxhAk8kV/0OCopur3k3UbKAdK8cP2vZlPeiuTgni
 nsOBxNUL16Gm6n4mH8X43/fRQkqPURvE8EGQoM4YQdWknGNA9YNBKYlsg8idwDDa3Ep8
 3w0HMqtd7ZhsMkV+65U5aX6FXjnmHTJh0AImneJrzWPzRLESbZL30E8mArZlXUik6gNk
 eSMY/BKHk41R2TOVihjo0uG2MovJkxDuRn3VPQczFrZORFxw/hphjKLLxpFpZkjpSpWW ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37vjtv8vx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 08:34:42 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13ECYJmi088812;
        Wed, 14 Apr 2021 08:34:41 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37vjtv8vwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 08:34:41 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13ECRL8P008697;
        Wed, 14 Apr 2021 12:34:39 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 37u3n89rcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 12:34:39 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13ECYFmI13107558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 12:34:15 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C380A4051;
        Wed, 14 Apr 2021 12:34:37 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFFA6A4055;
        Wed, 14 Apr 2021 12:34:36 +0000 (GMT)
Received: from sig-9-145-163-27.de.ibm.com (unknown [9.145.163.27])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Apr 2021 12:34:36 +0000 (GMT)
Message-ID: <c6f3c9a70e054e9087f657bf4f142732fd43784c.camel@linux.ibm.com>
Subject: Re: [PATCH] asm-generic/io.h: Silence -Wnull-pointer-arithmetic
 warning on PCI_IOBASE
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Arnd Bergmann'" <arnd@arndb.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Guo Ren <guoren@kernel.org>
Date:   Wed, 14 Apr 2021 14:34:36 +0200
In-Reply-To: <40d4114fa34043d0841b81d09457c415@AcuMS.aculab.com>
References: <20210413115439.1011560-1-schnelle@linux.ibm.com>
         <CAK8P3a1WTZOYpJ2TSjnbytQJWgtfwkQ8bXXdnqCnOn6ugJqN_w@mail.gmail.com>
         <84ab737edbe13d390373850bf317920b3a486b87.camel@linux.ibm.com>
         <CAK8P3a2NR2nhEffFQJdMq2Do_g2ji-7p3+iWyzw+aXD6gov05w@mail.gmail.com>
         <11ead5c2c73c42cbbeef32966bc7e5c2@AcuMS.aculab.com>
         <CAK8P3a3PK9zyeP4ymELtc2ZYnymECoACiigw9Za+pvSJpCk5=g@mail.gmail.com>
         <40d4114fa34043d0841b81d09457c415@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cXeDngAzJk4G47j_fUM_9aNOG6XcQ9XV
X-Proofpoint-ORIG-GUID: XfhqNwJhoXUPrB125TwaEW8uHjp9E7Ad
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-14_06:2021-04-14,2021-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1011 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140086
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2021-04-13 at 14:12 +0000, David Laight wrote:
> From: Arnd Bergmann
> > Sent: 13 April 2021 14:40
> > 
> > On Tue, Apr 13, 2021 at 3:06 PM David Laight <David.Laight@aculab.com> wrote:
> > > From: Arnd Bergmann
> > > > Sent: 13 April 2021 13:58
> > > ...
> > > > The remaining ones (csky, m68k, sparc32) need to be inspected
> > > > manually to see if they currently support PCI I/O space but in
> > > > fact use address zero as the base (with large resources) or they
> > > > should also turn the operations into a NOP.
> > > 
> > > I'd expect sparc32 to use an ASI to access PCI IO space.
> > > I can't quite remember whether IO space was supported at all.
> > 
> > I see this bit in arch/sparc/kernel/leon_pci.c
> > 
> >  * PCI Memory and Prefetchable Memory is direct-mapped. However I/O Space is
> >  * accessed through a Window which is translated to low 64KB in PCI space, the
> >  * first 4KB is not used so 60KB is available.
> > ...
> >         pci_add_resource_offset(&resources, &info->io_space,
> >                                 info->io_space.start - 0x1000);
> > 
> > which means that there is I/O space, which gets accessed through whichever
> > method readb() uses. Having the offset equal to the resource means that
> > the '(void *)0' start is correct.
> 
> It must have been the VMEbus (and maybe sBus) sparc that used an ASI.
> 
> I do remember issues with Solaris of some PCI cards not liking
> being assigned a BAR address of zero.
> That may be why the low 4k IO space isn't assigned here.
> (I've never run Linux on sparc, just SVR4 and Solaris.)
> 
> I guess setting PCI_IOBASE to zero is safer when you can't trust
> drivers not to use inb() instead of readb().
> Or whatever io_read() ends up being.
> 
> 	David

So "I guess setting PCI_IOBASE to zero is safer when you can't trust
drivers not to use inb()…" in principle is true on other architectures
than sparc too, right? So do you think this means we shouldn't go with
Arnd's idea of making inb() just WARN_ONCE() if PCI_IOBASE is not
defined or just that for sparc defining it as 0 would be preferred?

As for s390 since we only support a limited number of drivers I think
for us such a WARN_ONCE() for inb() would be preferable.

I guess one option would be to let each architecture opt in to leaving
PCI_IOBASE undefined but in the first patch push PCI_IOBASE 0 into all
drivers that currently don't define it at all _and_ do not define their
own inb() etc.

> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

