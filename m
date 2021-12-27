Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982A148028D
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 18:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhL0RCh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 12:02:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229563AbhL0RCg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Dec 2021 12:02:36 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BRDkCmV013610;
        Mon, 27 Dec 2021 17:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=gnFH4a78JuCPO99u0gbsqygVxKsV0Rfm/xKnd2A7AAM=;
 b=WU2nN411vgkD8yrhODS180VCF0tdlnHAmV5kjuO26KMUS2WcUemvCshhid9xOfSJyV4L
 cyye6Y8w7LDHlip73buwzfFJZqE6DM/PYd5bZ9K+KLzAaWTiF+wHbFD+hLfYLbRG9TRA
 1PP6jtNRJ/zr9EIExFC7v6IpAzS/BhQ/gUx2RCUXA+yoOsz2RLNLR/esfIB5CodtsKsC
 hnSTthyrfhJqd6SJSxItBwMVEuLo4T/buD7frGmy+wc9kJAxleyuUx34hr3VuqSeXiCA
 emj2Hwt6lIXYgtb1rLLI3RgENjuwDO3X1iLMpyEdmfSK9cE54zEcK/23bYgnL5upV6dw tA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d7cd8nqth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 17:02:09 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BRH22B6022486;
        Mon, 27 Dec 2021 17:02:08 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d7cd8nqsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 17:02:08 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BRGx5Sb008338;
        Mon, 27 Dec 2021 17:02:06 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3d5tx92vj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 17:02:05 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BRH23gk42336736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Dec 2021 17:02:03 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DA1A11C052;
        Mon, 27 Dec 2021 17:02:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54D4611C04C;
        Mon, 27 Dec 2021 17:02:02 +0000 (GMT)
Received: from sig-9-145-11-194.uk.ibm.com (unknown [9.145.11.194])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Dec 2021 17:02:02 +0000 (GMT)
Message-ID: <f9f698b44173c6906e49e17aa33a98e12da7f60b.camel@linux.ibm.com>
Subject: Re: [RFC 03/32] ACPI: Kconfig: add HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Date:   Mon, 27 Dec 2021 18:02:01 +0100
In-Reply-To: <CAJZ5v0iBJ8NtQautnWnp_pXMfLy_rxys8j4+ugSTbNBb=wzy6A@mail.gmail.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
         <20211227164317.4146918-4-schnelle@linux.ibm.com>
         <CAJZ5v0iBJ8NtQautnWnp_pXMfLy_rxys8j4+ugSTbNBb=wzy6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FJpMJrV3UNNOX-5p57exbTrV9Nk_Fiz7
X-Proofpoint-ORIG-GUID: g8rSFgsEfCHWMq45Bd3ScoCUunJ-yQoD
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-27_09,2021-12-24_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112270083
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2021-12-27 at 17:47 +0100, Rafael J. Wysocki wrote:
> On Mon, Dec 27, 2021 at 5:44 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > not being declared. As ACPI always uses I/O port access
> 
> The ARM64 people may not agree with this.

Maybe my wording is bad. This is my rewording of what Arnd had in his
original mail: "The ACPI subsystem needs access to I/O ports, so that
also gets a dependency."(
https://lore.kernel.org/lkml/CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com/
).

> 
> > we depend on HAS_IOPORT unconditionally.
> > 
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >  drivers/acpi/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > index cdbdf68bd98f..b57f15817ede 100644
> > --- a/drivers/acpi/Kconfig
> > +++ b/drivers/acpi/Kconfig
> > @@ -9,6 +9,7 @@ config ARCH_SUPPORTS_ACPI
> >  menuconfig ACPI
> >         bool "ACPI (Advanced Configuration and Power Interface) Support"
> >         depends on ARCH_SUPPORTS_ACPI
> > +       depends on HAS_IOPORT
> >         select PNP
> >         select NLS
> >         default y if X86
> > --
> > 2.32.0
> > 

