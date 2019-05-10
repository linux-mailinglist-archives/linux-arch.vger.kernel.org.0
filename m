Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 655901A1C4
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2019 18:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfEJQqA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 May 2019 12:46:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727496AbfEJQqA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 May 2019 12:46:00 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4AGb041048360
        for <linux-arch@vger.kernel.org>; Fri, 10 May 2019 12:45:59 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sdbtgu6su-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 10 May 2019 12:45:58 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Fri, 10 May 2019 17:45:57 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 10 May 2019 17:45:51 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4AGjoHK51576876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 16:45:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84A005204F;
        Fri, 10 May 2019 16:45:50 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.32.174])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E268752050;
        Fri, 10 May 2019 16:45:49 +0000 (GMT)
Date:   Fri, 10 May 2019 18:45:48 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Stephen Rothwell <sfr@ozlabs.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing
 addresses
In-Reply-To: <20190510124058.0d44b441@gandalf.local.home>
References: <20190510081635.GA4533@jagdpanzerIV>
        <20190510084213.22149-1-pmladek@suse.com>
        <20190510122401.21a598f6@gandalf.local.home>
        <20190510183258.1f6c4153@mschwideX1>
        <20190510124058.0d44b441@gandalf.local.home>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051016-0020-0000-0000-0000033B63F6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051016-0021-0000-0000-0000218E116C
Message-Id: <20190510184548.1eda01a9@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=829 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905100112
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 10 May 2019 12:40:58 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 10 May 2019 18:32:58 +0200
> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> 
> > On Fri, 10 May 2019 12:24:01 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> > > On Fri, 10 May 2019 10:42:13 +0200
> > > Petr Mladek <pmladek@suse.com> wrote:
> > >     
> > > >  static const char *check_pointer_msg(const void *ptr)
> > > >  {
> > > > -	char byte;
> > > > -
> > > >  	if (!ptr)
> > > >  		return "(null)";
> > > >  
> > > > -	if (probe_kernel_address(ptr, byte))
> > > > +	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
> > > >  		return "(efault)";
> > > >        
> > > 
> > > 
> > > 	< PAGE_SIZE ?
> > > 
> > > do you mean: < TASK_SIZE ?    
> > 
> > The check with < TASK_SIZE would break on s390. The 'ptr' is
> > in the kernel address space, *not* in the user address space.
> > Remember s390 has two separate address spaces for kernel/user
> > the check < TASK_SIZE only makes sense with a __user pointer.
> >   
> 
> So we allow this to read user addresses? Can't that cause a fault?
> 
> If the condition is true, we return "(efault)".

On x86 this would allow a user space access as kernel and user live
in the same address space, on s390 it would not.
h
-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

