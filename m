Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CE93726AD
	for <lists+linux-arch@lfdr.de>; Tue,  4 May 2021 09:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhEDHlj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 May 2021 03:41:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4764 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229922AbhEDHl3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 May 2021 03:41:29 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1447Y8TK073727;
        Tue, 4 May 2021 03:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=SNzRA80G7BEoftP4TQQcROGHJxxlHWljovtZ2dqle6M=;
 b=VrfZxHOxJy0a7qA1nJsTVskQWqLvq0kcXTsg0caPlHMlfWsUMMXrxBvmsfeIaevXaUa6
 oT8Wk9PKn4dwM5pNRt0jCewGcrC/ut0yk2M2ALJiQL3dGoa4D7V/nu+7weMFhsRipRqB
 GzhiFDOW51PbmbWyWkPC0Q8g/UQBQ5fuhPn217d6oexoCtgA3dfmugMyI5SOwORC/ebW
 itzLKdpLo/3IFtZ6INwLE7Y3bu+QKnDJlI7IZIqYo8lw80swysip031S2PlCNfxxAhXk
 b0zmOlIzEOuJhVN3vE9IYY3gGyRJuqGWLRK232po6k5yy9SHXAAATGAXogvTI9e0+YKQ kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38b1wb09kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 03:39:46 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1447Yca9075458;
        Tue, 4 May 2021 03:39:46 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38b1wb09k2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 03:39:46 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1447WEC0016838;
        Tue, 4 May 2021 07:39:44 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 388xm8h27c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 07:39:44 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1447dGux30474742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 May 2021 07:39:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A213FAE055;
        Tue,  4 May 2021 07:39:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19DA5AE045;
        Tue,  4 May 2021 07:39:41 +0000 (GMT)
Received: from sig-9-145-90-245.uk.ibm.com (unknown [9.145.90.245])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 May 2021 07:39:41 +0000 (GMT)
Message-ID: <9e52895227515143bf3cd9197876ff1ed596682b.camel@linux.ibm.com>
Subject: Re: [PATCH v4 0/3] asm-generic/io.h: Silence
 -Wnull-pointer-arithmetic warning on PCI_IOBASE
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        sparclinux <sparclinux@vger.kernel.org>
Date:   Tue, 04 May 2021 09:39:40 +0200
In-Reply-To: <CAK8P3a3mCujxC0=_cL6Z88Xh2cb=OY_Ct7DVpJNvRn1v9=FhkQ@mail.gmail.com>
References: <20210430111641.1911207-1-schnelle@linux.ibm.com>
         <CAK8P3a3mCujxC0=_cL6Z88Xh2cb=OY_Ct7DVpJNvRn1v9=FhkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1Pftu_AEJr1ccZfm4uSBQRSXbzHt5fUN
X-Proofpoint-GUID: NnNsF52RJSWhrfL8DmTT5s-OsatqEN8Z
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-04_02:2021-05-04,2021-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=880 bulkscore=0 phishscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2105040057
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2021-05-03 at 18:07 +0200, Arnd Bergmann wrote:
> On Fri, Apr 30, 2021 at 1:16 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > From: Niklas Schnelle <niklas@komani.de>
> > 
> > This is version 4 of my attempt to get rid of a clang
> > -Wnull-pointer-arithmetic warning for the use of PCI_IOBASE in
> > asm-generic/io.h. This was originally found on s390 but should apply to
> > all platforms leaving PCI_IOBASE undefined while making use of the inb()
> > and friends helpers from asm-generic/io.h.
> > 
> > This applies cleanly and was compile tested on top of v5.12 for the
> > previously broken ARC, nds32, h8300 and risc-v architecture
> > 
> > I did boot test this only on x86_64 and s390x the former implements
> > inb() itself while the latter would emit a WARN_ONCE() but no drivers
> > use inb().
> 
> This looks all fine to me, but with the merge window open right now, I
> can't add it into linux-next yet, and it wouldn't qualify as a bugfix for 5.13.
> 
> Please resend them to me after -rc1 is out so I can merge it for
> 5.14 through the asm-generic tree.

Thanks for the great feedback I appreciate it. Will do the resend of
course.

> 
> Please add two small changes to the changelog texts:
> 
> - for patch 3, please include a 'Link: tag' to the lore archive of the
>   previous discussion, that should cover any questions that people
>   may have

Done

> 
> - for the risc-v patch, I would suggest explaining that this fixes
>   an existing runtime bug, not just a compiler error:
>   | This is already broken, as accessing a fixed I/O port number of
>   | an ISA device on NOMMU RISC-V would turn into a NULL pointer
>   | dereference.
>   Feel free to either copy this, or use your own explanation.

I mixed the above in with the current commit message:

    Without MMU support PCI_IOBASE is left undefined because PCI_IO_END is
    VMEMMAP_START. Nevertheless the in*()/out*() helper macros are left
    defined with uses of PCI_IOBASE. At the moment this only compiles
    because asm-generic/io.h defines PCI_IOBASE as 0 if it is undefined and
    so at macro expansion PCI_IOBASE is defined. This leads to compilation
    errors when asm-generic/io.h is changed to leave PCI_IOBASE undefined.
    More importantly it is currently broken at runtime, as accessing a fixed
    I/O port number of an ISA device on NOMMU RISC-V would turn into a NULL
    pointer dereference. Instead only define the in*()/out*() helper macros
    with MMU support and fall back to the asm-generic/io.h helper stubs
    otherwise.



> 
>        Arnd

