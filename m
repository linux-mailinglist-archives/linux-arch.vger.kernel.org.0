Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB45B4811A8
	for <lists+linux-arch@lfdr.de>; Wed, 29 Dec 2021 11:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbhL2K0B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Dec 2021 05:26:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231732AbhL2K0B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Dec 2021 05:26:01 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BT76LOq030283;
        Wed, 29 Dec 2021 10:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=LfGyH4GDskxin+coKtlA3vbQM36+89KqWNVcmXSF8W0=;
 b=mflE2cyytkG9Q/WUZtx7ovtq9ccBoAHBANBEfJuG8PdjftSebyQ2jDJaBDmjubI82hGW
 93ZBO6vWATGyfAt1cY3U9ArcEunwGBZy+/PUejCOuxoSqab5gQAbp45C2KWwUihixite
 KL79xyeFwX2GrUrWkdKepIcYSAWzueb3DmBcywreiE0IpjIqkNK7UjpAsp7Lf/4mhsQt
 FLnhSXuKjIEMf8rr9bVODJfEPduZOaBqwX/utRni/IvrZOaQUegP2nxh+a4Dtc6qKacy
 gcifblxR0oUm4IgeCTO6k8LbWUUpWcfgA4WShX1NA3Jmd6RZbYnbS2v41u0c/zIdHRMn tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d7xdut6kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Dec 2021 10:25:20 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BTA9QKZ031427;
        Wed, 29 Dec 2021 10:25:19 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d7xdut6js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Dec 2021 10:25:19 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BTA7Dhe022628;
        Wed, 29 Dec 2021 10:25:16 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3d5tx9mjsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Dec 2021 10:25:16 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BTAPD0x39584226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Dec 2021 10:25:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4CECAE064;
        Wed, 29 Dec 2021 10:25:13 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8271AE05A;
        Wed, 29 Dec 2021 10:25:12 +0000 (GMT)
Received: from sig-9-145-13-177.uk.ibm.com (unknown [9.145.13.177])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 29 Dec 2021 10:25:12 +0000 (GMT)
Message-ID: <b9d0c0b88ef66f9beb51a880e765177670a76394.camel@linux.ibm.com>
Subject: Re: [RFC 30/32] /dev/port: don't compile file operations without
 CONFIG_DEVPORT
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org
Date:   Wed, 29 Dec 2021 11:25:12 +0100
In-Reply-To: <YcrIHxTDipVNUuCA@kroah.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
         <20211227164317.4146918-31-schnelle@linux.ibm.com>
         <YcrIHxTDipVNUuCA@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CONH9YRiE6zUaNV_ldL6uBzMkmByWy47
X-Proofpoint-ORIG-GUID: 8hmI9OQZCwEaLbSCMb7YKm3rBHuILRIK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-29_03,2021-12-29_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112290054
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2021-12-28 at 09:17 +0100, Greg Kroah-Hartman wrote:
> On Mon, Dec 27, 2021 at 05:43:15PM +0100, Niklas Schnelle wrote:
> > In the future inb() and friends will not be available when compiling
> > with CONFIG_HAS_IOPORT=n so we must only try to access them here if
> > CONFIG_DEVPORT is set which depends on HAS_IOPORT.
> > 
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >  drivers/char/mem.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> > index cc296f0823bd..c1373617153f 100644
> > --- a/drivers/char/mem.c
> > +++ b/drivers/char/mem.c
> > @@ -402,6 +402,7 @@ static int mmap_mem(struct file *file, struct vm_area_struct *vma)
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_DEVPORT
> >  static ssize_t read_port(struct file *file, char __user *buf,
> >  			 size_t count, loff_t *ppos)
> >  {
> > @@ -443,6 +444,7 @@ static ssize_t write_port(struct file *file, const char __user *buf,
> >  	*ppos = i;
> >  	return tmp-buf;
> >  }
> > +#endif
> >  
> >  static ssize_t read_null(struct file *file, char __user *buf,
> >  			 size_t count, loff_t *ppos)
> > @@ -665,12 +667,14 @@ static const struct file_operations null_fops = {
> >  	.splice_write	= splice_write_null,
> >  };
> >  
> > -static const struct file_operations __maybe_unused port_fops = {
> > +#ifdef CONFIG_DEVPORT
> > +static const struct file_operations port_fops = {
> >  	.llseek		= memory_lseek,
> >  	.read		= read_port,
> >  	.write		= write_port,
> >  	.open		= open_port,
> >  };
> > +#endif
> 
> Why is this #ifdef needed if it is already __maybe_unused?

Because read_port() calls inb() and write_port() calls outb() they
wouldn't compile once these are no longer defined. Then however the
read_port/write_port symbols in the struct initialization above
couldn't be resolved.

> 
> In looking closer, this change could be taken now as the use of this
> variable already is behind this same #ifdef statement, right?

Yes

> 
> thanks,
> 
> greg k-h

