Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42710480B49
	for <lists+linux-arch@lfdr.de>; Tue, 28 Dec 2021 17:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbhL1QcH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Dec 2021 11:32:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13866 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233260AbhL1QcH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Dec 2021 11:32:07 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BSFgBtE031500;
        Tue, 28 Dec 2021 16:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=zKO8gN/AaO+13AvkZHtNTkiwvUjnuScjRHnHOBSxakg=;
 b=kajm3cg02D+QrYkTd1rFQeszrS70//WnelcdH8mx9bN7eAI+LQoPfPH4TChL3OTieJKC
 jQha43PoSE/H6Jvogk6VhBYKX5ZxT6193UjtJ0wRteHe8gapBh9FmswOEg0O5D07TDyx
 5vulaotDseivrekycCEibTZjta+QGTdkP+sC5cTP4AZcHBFQQt7grdleP6PiDVyZU627
 oy/FG4WPgg0SIjkmK6G9+qf2Qq2a/fv6GE0K8loGOb1bBmZXx0528FWxIbpKfmwoHHj0
 stHsV4LzQVNgrsma+5GmFUSkYINVy+Gj+HvvtuViTL179bFpYdBXvMyaQFmgPyFAyKTl cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d85ew8w7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 16:31:32 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BSGR9gu014759;
        Tue, 28 Dec 2021 16:31:32 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d85ew8w6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 16:31:31 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BSGSU8I007577;
        Tue, 28 Dec 2021 16:31:30 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3d5tx9gq21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 16:31:29 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BSGVRLA46793182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Dec 2021 16:31:27 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58513A405D;
        Tue, 28 Dec 2021 16:31:27 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04861A4040;
        Tue, 28 Dec 2021 16:31:26 +0000 (GMT)
Received: from sig-9-145-12-118.uk.ibm.com (unknown [9.145.12.118])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Dec 2021 16:31:25 +0000 (GMT)
Message-ID: <e6405f7f91fffdefe504b238bb0aebf653561fbb.camel@linux.ibm.com>
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
Date:   Tue, 28 Dec 2021 17:31:25 +0100
In-Reply-To: <CAJZ5v0idJXf0dBctmCVxyp4rWsMp_MvnryibZa8hqvmjtKV5TQ@mail.gmail.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
         <20211227164317.4146918-4-schnelle@linux.ibm.com>
         <CAJZ5v0iBJ8NtQautnWnp_pXMfLy_rxys8j4+ugSTbNBb=wzy6A@mail.gmail.com>
         <f9f698b44173c6906e49e17aa33a98e12da7f60b.camel@linux.ibm.com>
         <CAJZ5v0iG=wqVtJULiTFsffMWqihA0Rk+abMzmfTcH+J9d5G+YA@mail.gmail.com>
         <CAJZ5v0htSMwM5SgSAaS-UB3G=99DC8ytQ5P4BfjDhdAoQ7pFdg@mail.gmail.com>
         <d1daba9437783ffca746ab7329fe4fbdd04d247f.camel@linux.ibm.com>
         <CAJZ5v0idJXf0dBctmCVxyp4rWsMp_MvnryibZa8hqvmjtKV5TQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dIaz2ojdubVtE2rkHIDRqNNbdpc-XHHC
X-Proofpoint-ORIG-GUID: Z2uY6ABdqmuHrBTq9VCwjgsec3OZVpaL
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-28_08,2021-12-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112280075
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2021-12-28 at 16:20 +0100, Rafael J. Wysocki wrote:
> On Mon, Dec 27, 2021 at 6:43 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > On Mon, 2021-12-27 at 18:15 +0100, Rafael J. Wysocki wrote:
> > > On Mon, Dec 27, 2021 at 6:12 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > On Mon, Dec 27, 2021 at 6:02 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > > > > On Mon, 2021-12-27 at 17:47 +0100, Rafael J. Wysocki wrote:
> > > > > > On Mon, Dec 27, 2021 at 5:44 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > > > > > > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > > > > > > not being declared. As ACPI always uses I/O port access
> > > > > > 
> > > > > > The ARM64 people may not agree with this.
> > > > > 
> > > > > Maybe my wording is bad. This is my rewording of what Arnd had in his
> > > > > original mail: "The ACPI subsystem needs access to I/O ports, so that
> > > > > also gets a dependency."(
> > > > > https://lore.kernel.org/lkml/CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com/
> > > > > ).
> > > > 
> > > > And my point is that on ARM64 the ACPI subsystem does not need to
> > > > access IO ports.
> > > > 
> > > > It may not even need to access them on x86, but that depends on the
> > > > platform firmware in use.
> > 
> > Well at least it does compile code calling outb() in
> > drivers/acpi/ec.c:acpi_ec_write_cmd().
> 
> That's the EC driver which is not used on arm64 AFAICS and that driver
> itself can be made depend on HAS_IOPORT.

Ah ok good to know.

Looking further there is also an inb_p() in
drivers/acpi/processor_idle.c:acpi_idle_bm_check(). That does look x86
specific though. There are a few more in the same file in
acpi_idle_do_entry() and acpi_idle_play_dead() they both look like
alternative mechanisms though interestingly one of the sites checks for
ACPI_CSTATE_SYSTEMIO while the other doesn't. Also it seems to me that
processor_idle.c is compiled when ACPI_PROCESSOR_IDLE is set which is
selected by ACPI_PROCESSOR which gets set for ARM64 as well.

Then there is a few more calls in drivers/acpi/osl.c which currently
gets compiled on all architectures as well.

I think we could ifdef all of these as it seems there are always
alternative paths. But I'm not sure if that makes sense if ACPI only
works on platforms with HAS_IOPORT anyway. From a cursory look it seems
even the not yet merged LoongArch would set HAS_IOPORT.

What do you think?

> 
> > Not sure if there is an
> > alternative path at runtime if there is then we might want to instead
> > use ifdefs to always use the non I/O port path if HAS_IOPORT is
> > undefined.
> > 
> > > > If arm64 is going to set HAS_IOPORT, then fine, but is it (and this
> > > > applies to ia64 too)?
> > 
> > Yes x86, arm64 and ia64 that is all arches that set ACH_SUPPORTS_ACPI
> > all select HAS_IOPORT too. See patch 02 or the summary in the cover
> > letter which notes that only s390, nds32, um, h8300, nios2, openrisc,
> > hexagon, csky, and xtensa do not select it.
> 
> If that is the case, there should be no need to add the extra
> dependency to CONFIG_ACPI.
> 
> > > > > > > we depend on HAS_IOPORT unconditionally.
> > > > > > > 
> > > > > > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > > > > > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > > > > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > > > > > ---
> > > > > > >  drivers/acpi/Kconfig | 1 +
> > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > > > > > > index cdbdf68bd98f..b57f15817ede 100644
> > > > > > > --- a/drivers/acpi/Kconfig
> > > > > > > +++ b/drivers/acpi/Kconfig
> > > > > > > @@ -9,6 +9,7 @@ config ARCH_SUPPORTS_ACPI
> > > > > > >  menuconfig ACPI
> > > > > > >         bool "ACPI (Advanced Configuration and Power Interface) Support"
> > > > > > >         depends on ARCH_SUPPORTS_ACPI
> > > 
> > > Besides, I'm not sure why ARCH_SUPPORTS_ACPI cannot cover this new dependency.
> > 
> > If you prefer to have the dependency there that should work too yes.
> 
> I would prefer that.
> 
> IMO, if ARCH_SUPPORTS_ACPI is set, all of the requisite dependencies
> should be met.

I personally think it makes sense to have an explicit HAS_IOPORT
dependency even if it's already selected by all architectures setting
ARCH_SUPPORTS_ACPI adding it there as a dependency at the very least
documents its, currently unconditional, compile-time dependency.

