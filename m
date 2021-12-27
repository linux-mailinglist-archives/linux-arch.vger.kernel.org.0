Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5144802E9
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 18:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhL0Rnu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 12:43:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23148 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230351AbhL0Rnu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Dec 2021 12:43:50 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BRGfnE8012032;
        Mon, 27 Dec 2021 17:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=LJPZ92dTRudeh24NKiz2/JbNNsiAVDg8RXKrt1Poe4c=;
 b=Cr/0cattw/JUbNhN2BtjHLJolBLUQcBfh9ORCm+egtDcMF10J9erNlBOMgbiOGdkv8S+
 cxql1HSMRVxTS7yXgfepJ5nEF87XOxVCKIc3qwgS0Z+FrS3I5yhC7GTh6GHemfG5JSrw
 Zpsy9CvmmJHVZkhhW6UjS1Pl5Pzi++IiTSxG5xJatdaB/9vr6U5vXsrRhIFF1eCYqZgk
 ixWxI8H42maozvLPrML38SyynKljUqnxIOI6kll0w8qAAQQkO3wVJZ/cuH/MJN8D5XDn
 R1WxwH9aOXScJFAcktqZ3RnsSBjvSG8KoeUN3XpYZ+FthrbG3YL03xws49GYtGai0xF5 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d7h7uh119-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 17:43:14 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BRHPbrs026485;
        Mon, 27 Dec 2021 17:43:13 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d7h7uh110-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 17:43:13 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BRHgO0c027632;
        Mon, 27 Dec 2021 17:43:11 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3d5tjjb2qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 17:43:11 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BRHh9RB47644996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Dec 2021 17:43:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F047A42041;
        Mon, 27 Dec 2021 17:43:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8D6542042;
        Mon, 27 Dec 2021 17:43:07 +0000 (GMT)
Received: from sig-9-145-11-194.uk.ibm.com (unknown [9.145.11.194])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Dec 2021 17:43:07 +0000 (GMT)
Message-ID: <d1daba9437783ffca746ab7329fe4fbdd04d247f.camel@linux.ibm.com>
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
Date:   Mon, 27 Dec 2021 18:43:07 +0100
In-Reply-To: <CAJZ5v0htSMwM5SgSAaS-UB3G=99DC8ytQ5P4BfjDhdAoQ7pFdg@mail.gmail.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
         <20211227164317.4146918-4-schnelle@linux.ibm.com>
         <CAJZ5v0iBJ8NtQautnWnp_pXMfLy_rxys8j4+ugSTbNBb=wzy6A@mail.gmail.com>
         <f9f698b44173c6906e49e17aa33a98e12da7f60b.camel@linux.ibm.com>
         <CAJZ5v0iG=wqVtJULiTFsffMWqihA0Rk+abMzmfTcH+J9d5G+YA@mail.gmail.com>
         <CAJZ5v0htSMwM5SgSAaS-UB3G=99DC8ytQ5P4BfjDhdAoQ7pFdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3eye2BZ5UPUn-S0QwdpBT27xFHxw80tM
X-Proofpoint-ORIG-GUID: e__HM_n4SzUYF7nYZDFSUIgoIQiH_jGZ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-27_09,2021-12-24_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112270085
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2021-12-27 at 18:15 +0100, Rafael J. Wysocki wrote:
> On Mon, Dec 27, 2021 at 6:12 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Mon, Dec 27, 2021 at 6:02 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > > On Mon, 2021-12-27 at 17:47 +0100, Rafael J. Wysocki wrote:
> > > > On Mon, Dec 27, 2021 at 5:44 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > > > > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > > > > not being declared. As ACPI always uses I/O port access
> > > > 
> > > > The ARM64 people may not agree with this.
> > > 
> > > Maybe my wording is bad. This is my rewording of what Arnd had in his
> > > original mail: "The ACPI subsystem needs access to I/O ports, so that
> > > also gets a dependency."(
> > > https://lore.kernel.org/lkml/CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com/
> > > ).
> > 
> > And my point is that on ARM64 the ACPI subsystem does not need to
> > access IO ports.
> > 
> > It may not even need to access them on x86, but that depends on the
> > platform firmware in use.

Well at least it does compile code calling outb() in
drivers/acpi/ec.c:acpi_ec_write_cmd(). Not sure if there is an
alternative path at runtime if there is then we might want to instead
use ifdefs to always use the non I/O port path if HAS_IOPORT is
undefined.

> > 
> > If arm64 is going to set HAS_IOPORT, then fine, but is it (and this
> > applies to ia64 too)?

Yes x86, arm64 and ia64 that is all arches that set ACH_SUPPORTS_ACPI
all select HAS_IOPORT too. See patch 02 or the summary in the cover
letter which notes that only s390, nds32, um, h8300, nios2, openrisc,
hexagon, csky, and xtensa do not select it.

> > 
> > > > > we depend on HAS_IOPORT unconditionally.
> > > > > 
> > > > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > > > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > > > ---
> > > > >  drivers/acpi/Kconfig | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > > > > index cdbdf68bd98f..b57f15817ede 100644
> > > > > --- a/drivers/acpi/Kconfig
> > > > > +++ b/drivers/acpi/Kconfig
> > > > > @@ -9,6 +9,7 @@ config ARCH_SUPPORTS_ACPI
> > > > >  menuconfig ACPI
> > > > >         bool "ACPI (Advanced Configuration and Power Interface) Support"
> > > > >         depends on ARCH_SUPPORTS_ACPI
> 
> Besides, I'm not sure why ARCH_SUPPORTS_ACPI cannot cover this new dependency.

If you prefer to have the dependency there that should work too yes.

> 
> > > > > +       depends on HAS_IOPORT
> > > > >         select PNP
> > > > >         select NLS
> > > > >         default y if X86
> > > > > --
> > > > > 2.32.0
> > > > > 

