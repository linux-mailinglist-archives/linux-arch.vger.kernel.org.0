Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571023D7E58
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 21:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhG0TRP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 15:17:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229945AbhG0TRO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Jul 2021 15:17:14 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16RJCSEB017230;
        Tue, 27 Jul 2021 15:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=S9WrCfkjSuekFZGHC4uhqiuih4pXzbHlc84xouUPS30=;
 b=XtVP3aKZR9Z1pNXNGsp2zrrSA1oIVqlmYRUJPfycxAbVOkY5aZf+STUn9HLRwdindj3l
 KayU7gSPFJF6TUFinKMIcypSlccNbLBBnSnc5ruZiyqnwmDoIislOsDVW4Te5vaOGJgZ
 b7kywMaOLrCGDMZRY+uKUt0OzvUQ34KEsan0jAdmN9/yBt+/+HMJBKo75rsn7qBS8mun
 gUQarU41NbCVnlybtddgQtb3CoZX8pZTDN0LmYM7pXhSRrMOgI/YBhMS1NwBf8j2iz9x
 emQXUe5DEH1yYeh2sRn1AWomHCowoydRrg2Gdsd2bZqQNw5BzKMv2r6i+GFg1iZ0otVG Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a2qtvg9j2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 15:16:01 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16RJFBjg028792;
        Tue, 27 Jul 2021 15:16:00 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a2qtvg9h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 15:16:00 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16RIumuQ029158;
        Tue, 27 Jul 2021 19:15:58 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3a235kgdeu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 19:15:58 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16RJFthW28377476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 19:15:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF014A405F;
        Tue, 27 Jul 2021 19:15:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD9DBA4057;
        Tue, 27 Jul 2021 19:15:53 +0000 (GMT)
Received: from osiris (unknown [9.145.19.157])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 27 Jul 2021 19:15:53 +0000 (GMT)
Date:   Tue, 27 Jul 2021 21:15:52 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christoph Hellwig <hch@infradead.org>,
        Feng Tang <feng.tang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 4/6] mm: simplify compat numa syscalls
Message-ID: <YQBbaNqfBzX+pf1t@osiris>
References: <20210727144859.4150043-1-arnd@kernel.org>
 <20210727144859.4150043-5-arnd@kernel.org>
 <YQBB9yteAwtG2xyp@osiris>
 <CAK8P3a3itgCyc4jDBodTOcwG+XXsDYspZqQVBmy88cGXevY5Yw@mail.gmail.com>
 <YQBSpxZR4P/Phpf1@osiris>
 <CAK8P3a0WT36Lg4nRBWx_kqb9yKj0mHx8gTdzCsDfrx1tQSEqbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0WT36Lg4nRBWx_kqb9yKj0mHx8gTdzCsDfrx1tQSEqbA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -XM2aaOHmahf3GNtvPV0YNUK2TjKX7f3
X-Proofpoint-ORIG-GUID: TkiykJPEd5k1niuESQpMFCol9mhqnTsf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-27_13:2021-07-27,2021-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=984 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270113
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 27, 2021 at 08:49:40PM +0200, Arnd Bergmann wrote:
> On Tue, Jul 27, 2021 at 8:38 PM Heiko Carstens <hca@linux.ibm.com> wrote:
> >
> > -268  common    mbind                   sys_mbind                       compat_sys_mbind
> > -269  common    get_mempolicy           sys_get_mempolicy               compat_sys_get_mempolicy
> > -270  common    set_mempolicy           sys_set_mempolicy               compat_sys_set_mempolicy
> > +268  common    mbind                   sys_mbind                       sys_mbind
> > +269  common    get_mempolicy           sys_get_mempolicy               sys_get_mempolicy
> > +270  common    set_mempolicy           sys_set_mempolicy               sys_set_mempolicy
> >
> > would remove compat_ptr() conversion from nmask above if I'm not mistaken.
> 
> Maybe I'm misremembering how compat syscalls work on s390. Doesn't
> SYSCALL_DEFINEx(sys_mbind) still create two entry points __s390x_sys_mbind()
> and __s390_sys_mbind() with different argument conversion (__SC_CAST vs
> __SC_COMPAT_CAST)? I thought that was the whole point of the macros.

You are remembering correctly, probably because you implemented it ;)
I totally forgot - sorry for the noise!
