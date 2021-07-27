Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002773D7DD8
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 20:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhG0SkB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 14:40:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55300 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229716AbhG0SkA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Jul 2021 14:40:00 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16RIZYit159213;
        Tue, 27 Jul 2021 14:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=d/4BumVgvtK9RROG6z6FdhebdQ556A1xMyoo6DS29A4=;
 b=qqRRky/Cn5ZAYNzCDbLY75T2dY8OMMmza3EjtMUJDrhtbK99HbLpEyNO85p/tMReOjiA
 JvjAJ0171Pn6gJu5IKQsdbMEK48JbBAiBV4V5J4m9KQ9v091n8FS+AQ8OM4IkxWllFCe
 eROK+fPGXUREt2/TfA4ni0Om93DJqlJE0GQQZk3S1zQRtCU+lt/4K3Qu+6w4/B54JmrW
 +DUqDS8eP/83foES8MsF69TR5Yhr/KYSoYSItPHV6iBN8aWERKV3fsDf8rgZlxRQoQz6
 aqU6se/OCi3jmtZ7ThHrsoc7ujZ9cX/DFwdaK0xWaqwipzZvcWEPgVlBLwgVm2D89WZb 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a2qgfg98w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 14:38:41 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16RIZc3Y159614;
        Tue, 27 Jul 2021 14:38:40 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a2qgfg95h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 14:38:39 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16RIcbXt000976;
        Tue, 27 Jul 2021 18:38:37 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3a235m0ke5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 18:38:37 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16RIcX3P22282602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 18:38:34 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D88A54C044;
        Tue, 27 Jul 2021 18:38:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A84184C040;
        Tue, 27 Jul 2021 18:38:32 +0000 (GMT)
Received: from osiris (unknown [9.145.19.157])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 27 Jul 2021 18:38:32 +0000 (GMT)
Date:   Tue, 27 Jul 2021 20:38:31 +0200
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
Message-ID: <YQBSpxZR4P/Phpf1@osiris>
References: <20210727144859.4150043-1-arnd@kernel.org>
 <20210727144859.4150043-5-arnd@kernel.org>
 <YQBB9yteAwtG2xyp@osiris>
 <CAK8P3a3itgCyc4jDBodTOcwG+XXsDYspZqQVBmy88cGXevY5Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3itgCyc4jDBodTOcwG+XXsDYspZqQVBmy88cGXevY5Yw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Kwccqqwc5VX735JqhRPAybSOZZQrYCVP
X-Proofpoint-ORIG-GUID: YtLX8HDtFqe7pp2VkhD_wrYR0Q9OXJxP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-27_13:2021-07-27,2021-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0
 clxscore=1015 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=955 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2107270109
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 27, 2021 at 07:40:05PM +0200, Arnd Bergmann wrote:
> On Tue, Jul 27, 2021 at 7:27 PM Heiko Carstens <hca@linux.ibm.com> wrote:
> > > +static int get_bitmap(unsigned long *mask, const unsigned long __user *nmask,
> > > +                   unsigned long maxnode)
> > > +{
> > > +     unsigned long nlongs = BITS_TO_LONGS(maxnode);
> > > +     int ret;
> > > +
> > > +     if (in_compat_syscall())
> > > +             ret = compat_get_bitmap(mask,
> > > +                                     (const compat_ulong_t __user *)nmask,
> > > +                                     maxnode);
> >
> > compat_ptr() conversion for e.g. nmask is missing with the next patch
> > which removes the compat system calls.
> > Is that intended or am I missing something?
> 
> I don't think it's needed here, since the pointer comes from the system
> call argument, which has the compat_ptr() conversion applied in
> arch/s390/include/asm/syscall_wrapper.h, not from a compat_uptr_t
> that gets passed indirectly. The compat_get_bitmap() conversion
> is only needed for byte order adjustment, not for converting pointers.
> 
> It's also possible that I'm the one who's missing something.

What I was trying to say: this patch on its own is ok. However with
the next patch you remove the compat system calls and map the regular
system calls instead.

That is:

-COMPAT_SYSCALL_DEFINE6(mbind, compat_ulong_t, start, compat_ulong_t, len,
-		       compat_ulong_t, mode, compat_ulong_t __user *, nmask,
-		       compat_ulong_t, maxnode, compat_ulong_t, flags)
-{
-	return kernel_mbind(start, len, mode, (unsigned long __user *)nmask,
-			    maxnode, flags);
-}

and this:

-268  common	mbind			sys_mbind			compat_sys_mbind
-269  common	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
-270  common	set_mempolicy		sys_set_mempolicy		compat_sys_set_mempolicy
+268  common	mbind			sys_mbind			sys_mbind
+269  common	get_mempolicy		sys_get_mempolicy		sys_get_mempolicy
+270  common	set_mempolicy		sys_set_mempolicy		sys_set_mempolicy

would remove compat_ptr() conversion from nmask above if I'm not mistaken.
