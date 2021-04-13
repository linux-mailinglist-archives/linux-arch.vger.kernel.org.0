Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257FF35DF08
	for <lists+linux-arch@lfdr.de>; Tue, 13 Apr 2021 14:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbhDMMi5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Apr 2021 08:38:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35230 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231489AbhDMMiv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Apr 2021 08:38:51 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DCXw5h105879;
        Tue, 13 Apr 2021 08:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Pw9M3G9Sv8NSb3H3DbqXrJ2HXCzyntpYRr6tMbE39FM=;
 b=PiCAvy7v6K+BsoFEINcL53kfnC+XS5CRJSPH83A+3aFnDiEuCFp28xsgA/H6ZsTdXJSF
 B54FboM0GBTWTxfVfE7n/cxB8eD05F/cl68cegKeLibAhAykgFdfDwZgJzuEYokYe7yr
 j55iNcQyNISPR3BSYieisWEFR1nNjjtJQzpCkrC14HrjqGHmZ5vmjijR+904R4A/TBMQ
 v64Pe9BbgZsULth7IBwY4xGQX0aOX3ifx6DJA3/MJyqUwU4zaqF0kHcAI35TJiq28f8t
 lUBW+9NZuujfq2c5evQHhFKkLvq08HM+kBBNTWrF9epU2w5wf88GbvEId9cu74Xmixfm xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37wb4f8pcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 08:38:28 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13DCY4BH106532;
        Tue, 13 Apr 2021 08:38:27 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37wb4f8pbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 08:38:27 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13DCX7wF004270;
        Tue, 13 Apr 2021 12:38:26 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 37u3n8ap0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 12:38:25 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13DCc10827459898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 12:38:01 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF038AE04D;
        Tue, 13 Apr 2021 12:38:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EE22AE045;
        Tue, 13 Apr 2021 12:38:23 +0000 (GMT)
Received: from sig-9-145-159-22.de.ibm.com (unknown [9.145.159.22])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 13 Apr 2021 12:38:23 +0000 (GMT)
Message-ID: <84ab737edbe13d390373850bf317920b3a486b87.camel@linux.ibm.com>
Subject: Re: [PATCH] asm-generic/io.h: Silence -Wnull-pointer-arithmetic
 warning on PCI_IOBASE
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Date:   Tue, 13 Apr 2021 14:38:22 +0200
In-Reply-To: <CAK8P3a1WTZOYpJ2TSjnbytQJWgtfwkQ8bXXdnqCnOn6ugJqN_w@mail.gmail.com>
References: <20210413115439.1011560-1-schnelle@linux.ibm.com>
         <CAK8P3a1WTZOYpJ2TSjnbytQJWgtfwkQ8bXXdnqCnOn6ugJqN_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EE0ZgieKHyKBFyYO1857tiAUAblL3cm0
X-Proofpoint-GUID: c3jl4UEZNnDTMwPWeaTHrOxhamOfk3ta
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_07:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxscore=0 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130088
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2021-04-13 at 14:26 +0200, Arnd Bergmann wrote:
> On Tue, Apr 13, 2021 at 1:54 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > When PCI_IOBASE is not defined, it is set to 0 such that it is ignored
> > in calls to the readX/writeX primitives. While mathematically obvious
> > this triggers clang's -Wnull-pointer-arithmetic warning.
> 
> Indeed, this is an annoying warning.
> 
> > An additional complication is that PCI_IOBASE is explicitly typed as
> > "void __iomem *" which causes the type conversion that converts the
> > "unsigned long" port/addr parameters to the appropriate pointer type.
> > As non pointer types are used by drivers at the callsite since these are
> > dealing with I/O port numbers, changing the parameter type would cause
> > further warnings in drivers. Instead use "uintptr_t" for PCI_IOBASE
> > 0 and explicitly cast to "void __iomem *" when calling readX/writeX.
> > 
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >  include/asm-generic/io.h | 26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> > 
> > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > index c6af40ce03be..8eb00bdef7ad 100644
> > --- a/include/asm-generic/io.h
> > +++ b/include/asm-generic/io.h
> > @@ -441,7 +441,7 @@ static inline void writesq(volatile void __iomem *addr, const void *buffer,
> >  #endif /* CONFIG_64BIT */
> > 
> >  #ifndef PCI_IOBASE
> > -#define PCI_IOBASE ((void __iomem *)0)
> > +#define PCI_IOBASE ((uintptr_t)0)
> >  #endif
> > 
> >  #ifndef IO_SPACE_LIMIT
> 
> Your patch looks wrong in the way it changes the type of one of the definitions,
> but not the type of any of the architecture specific ones. It's also
> awkward since
> 'void __iomem *' is really the correct type, while 'uintptr_t' is not!

Yeah I see your point. The way I justified it for myself is that the
above define really only serves to ignore the PCI_IOBASE and the
explicit cast in the function makes the actual type more clear since
the parameters have the "wrong" type too. I do agree that this still
leaves things somewhat awkward.

> 
> I think the real underlying problem is that '0' is a particularly bad
> default value,
> we should not have used this one in asm-generic, or maybe have left it as
> mandatory to be defined by an architecture to a sane value. Note that
> architectures that don't actually support I/O ports will cause a NULL
> pointer dereference when loading a legacy driver, which is exactly what clang
> is warning about here. Architectures that to support I/O ports in PCI typically
> map them at a fixed location in the virtual address space and should put that
> location here, rather than adding the pointer value to the port resources.
> 
> What we might do instead here would be move the definition into those
> architectures that actually define the base to be at address zero, with a
> comment explaining why this is a bad location, and then changing the
> inb/outb style helpers to either an empty function or a WARN_ONCE().
> 
> On which architectures do you see the problem? How is the I/O port
> actually mapped there?
> 
>       Arnd

I'm seeing this on s390 which indeed has no I/O port support at all.
I'm not sure how many others there are but I feel like us having to
define these functions as empty is also kind of awkward. Maybe we could
put them into the asm-generic/io.h for the case that PCI_IOBASE is not
defined? Then at least every platform not supporting I/O ports would
share them.


