Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95A4366A26
	for <lists+linux-arch@lfdr.de>; Wed, 21 Apr 2021 13:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbhDULvS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Apr 2021 07:51:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48776 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238216AbhDULvS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Apr 2021 07:51:18 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LBiPCm166756;
        Wed, 21 Apr 2021 07:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=umFa+41AGn1p0ze7VTHK1gWh/RUXya1ijTfV9QCSiUU=;
 b=Fg+gjzmIsdkWN2gD6MQFOMUskRgAI7wvOomoXc8tUZ232jGOusYCK0QAesykWFWy9Px6
 ja+v1kP9wThdS6Y7FD47R54K2iePD5jO3sQGfqnGYdqKdw6ALR2mI2lFNFDBi3D/T0pO
 RCJCZ5CPx8nNJfArsvLON/EX3Cy8DJ0r2xys6WbOMY3h8RYC86A14oiYCGNU6/nRJuTg
 Cm73iFvSvU9QmRqcGTiAUOCNCIw58NCMa5ReNI30kzL8Rn78gDZSpMszjGoQ03og70Yv
 VuuqUuFe196UkXTFFvapgJpOKypKFeBrtGoqk4eGKyPVrXPv9wH4iKJrM7lDqd67ZDF/ ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 382keg84vr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 07:50:31 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13LBjTo5173888;
        Wed, 21 Apr 2021 07:50:31 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 382keg84v4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 07:50:30 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13LBmOZW023128;
        Wed, 21 Apr 2021 11:50:29 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 37yqa8j915-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 11:50:28 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13LBo3t334406874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 11:50:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D0CC4C044;
        Wed, 21 Apr 2021 11:50:26 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D968D4C04A;
        Wed, 21 Apr 2021 11:50:25 +0000 (GMT)
Received: from sig-9-145-20-41.uk.ibm.com (unknown [9.145.20.41])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Apr 2021 11:50:25 +0000 (GMT)
Message-ID: <aac9ac52de09ff7162fc7caa6e817258d9dd313d.camel@linux.ibm.com>
Subject: Re: [PATCH v3 3/3] asm-generic/io.h: Silence
 -Wnull-pointer-arithmetic warning on PCI_IOBASE
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Arnd Bergmann <arnd@arndb.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Date:   Wed, 21 Apr 2021 13:50:25 +0200
In-Reply-To: <bb21141706d7477794453f7f52f6bc98@AcuMS.aculab.com>
References: <20210421111759.2059976-1-schnelle@linux.ibm.com>
         <20210421111759.2059976-4-schnelle@linux.ibm.com>
         <bb21141706d7477794453f7f52f6bc98@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GljSLrlc0NXVaepFAyeRF6XnrO1FeM8W
X-Proofpoint-ORIG-GUID: 50MlIDyyzltO3bQ54AWDJNeVxVPQ8cF6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_04:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104210090
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2021-04-21 at 11:24 +0000, David Laight wrote:
> From: Niklas Schnelle
> > Sent: 21 April 2021 12:18
> > 
> > When PCI_IOBASE is not defined, it is set to 0 such that it is ignored
> > in calls to the readX/writeX primitives. This triggers clang's
> > -Wnull-pointer-arithmetic warning and will result in illegal accesses on
> > platforms that do not support I/O ports if drivers do still attempt to
> > access them.
> > 
> > Make things explicit and silence the warning by letting inb() and
> > friends fail with WARN_ONCE() and a 0xff... return in case PCI_IOBASE is
> > not defined.
> ...
> > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > index c6af40ce03be..aabb0a8186ee 100644
> > --- a/include/asm-generic/io.h
> > +++ b/include/asm-generic/io.h
> ...
> > @@ -458,12 +454,17 @@ static inline void writesq(volatile void __iomem *addr, const void *buffer,
> >  #define _inb _inb
> >  static inline u8 _inb(unsigned long addr)
> >  {
> > +#ifdef PCI_IOBASE
> >  	u8 val;
> > 
> >  	__io_pbr();
> >  	val = __raw_readb(PCI_IOBASE + addr);
> >  	__io_par(val);
> >  	return val;
> > +#else
> > +	WARN_ONCE(1, "No I/O port support\n");
> > +	return ~0;
> > +#endif
> >  }
> >  #endif
> 
> I suspect that this might be better not inlined
> when PCI_IOBASE is undefined.
> 
> Otherwise you get quite a lot of bloat from all the
> WARN_ONCE() calls.
> 
> 	David

Hmm, I was wondering if we should rather have a large ifdef block of
all these functions stubbed to WARN_ONCE rather than in each function.
As I understand it this would be necessary if we want the inline gone.
They would still be static though so we still get a copy per
compilation unit that uses it or am I misunderstanding?

> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

