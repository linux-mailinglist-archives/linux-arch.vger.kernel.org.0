Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2286B9AD7
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 17:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjCNQP1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 12:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjCNQPY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 12:15:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6B564A85;
        Tue, 14 Mar 2023 09:15:06 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EFH2tq021797;
        Tue, 14 Mar 2023 16:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=sdRNyLH4kLdrI+qcohJKVn4GGHSV4urB8tfYdgoZ3qU=;
 b=dhsmZ+K8oq00bXlqRF9CXipZdfYC5yhyxbdkM0VeUNla5BiVxkTGNHG4nTOgUzGnpyc1
 rToniBKIMdWWOF9xs7bLCEeDr+D7GNEGxRZ2tbHIrR2IuyBHcV6VyNhUwJjgaKp13mnL
 nWa6dGChpS0J+QYz6TXPC7kigkptl1FOZvGVKEvaN8hKamljIDLwp1wpRhe6rSfRCl5z
 w6hyyYC9nB0JPlXMdWN+A7Li/dILjHRTP24mDPZIVpcYK5myCvyvJ+EP6T8t7CgP7fzV
 5dQ4Fd5nnPXuTmZlr4Eadudr0uHb+5/XxwG+Zbj9fmGenzt/qMN6G3Dau3BcvxB4ZI+T wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3papbaksaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 16:11:53 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32EFH2KZ021927;
        Tue, 14 Mar 2023 16:11:52 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3papbaks8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 16:11:51 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32E5qEc2020629;
        Tue, 14 Mar 2023 16:11:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3p8h96m043-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 16:11:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32EGBj6Y30671604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 16:11:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECE4520040;
        Tue, 14 Mar 2023 16:11:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 007CF20043;
        Tue, 14 Mar 2023 16:11:40 +0000 (GMT)
Received: from [9.171.50.237] (unknown [9.171.50.237])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Mar 2023 16:11:40 +0000 (GMT)
Message-ID: <c524798dd2039e5b2b0f0f964b927ced65070377.camel@linux.ibm.com>
Subject: Re: [PATCH v3 01/38] Kconfig: introduce HAS_IOPORT option and
 select it as necessary
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org
Date:   Tue, 14 Mar 2023 17:11:40 +0100
In-Reply-To: <f8bdc245-38b0-4973-bd01-34f594a0ede4@app.fastmail.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
         <20230314121216.413434-2-schnelle@linux.ibm.com>
         <f8bdc245-38b0-4973-bd01-34f594a0ede4@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0eGKEFAcBwfQg_NBnhwZRPWInLzlQ7lk
X-Proofpoint-ORIG-GUID: TX80XVSaVIOsqiKspa3un8GJOHFTh7li
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_09,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0
 clxscore=1015 mlxlogscore=265 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140134
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2023-03-14 at 14:29 +0100, Arnd Bergmann wrote:
> On Tue, Mar 14, 2023, at 13:11, Niklas Schnelle wrote:
> > We introduce a new HAS_IOPORT Kconfig option to indicate support for I/=
O
> > Port access. In a future patch HAS_IOPORT=3Dn will disable compilation =
of
> > the I/O accessor functions inb()/outb() and friends on architectures
> > which can not meaningfully support legacy I/O spaces such as s390. Also
> > add dependencies on HAS_IOPORT for the ISA and HAVE_EISA config options
> > as these busses always go along with HAS_IOPORT.
> >=20
> > The "depends on" relations on HAS_IOPORT in drivers as well as ifdefs
> > for HAS_IOPORT specific sections will be added in subsequent patches on
> > a per subsystem basis.
>=20
> I think it would be helpful to enumerate which architectures
> do not get HAS_IOPORT added, as they will be affected more.
>=20
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>=20
> If there are no objections, I could send this first patch for the
> asm-generic tree as a preparation for 6.3, so we are able to merge
> the other patches through subsystem maintainer tree for 6.4.
>=20
> arch/loongarch/ will now also need to select HAS_IOPORT
> uncontitionally, this architecture was added after you
> sent v2.

Ah right. Added "select HAS_IOPORT" for LoongArch.

>=20
> > diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> > index a98940e64243..5eeacc72e4da 100644
> > --- a/arch/parisc/Kconfig
> > +++ b/arch/parisc/Kconfig
> > @@ -47,6 +47,7 @@ config PARISC
> >  	select MODULES_USE_ELF_RELA
> >  	select CLONE_BACKWARDS
> >  	select TTY # Needed for pdc_cons.c
> > +	select HAS_IOPORT if PCI
>=20
> It's also needed for EISA and I think you should select it
> from CONFIG_GSC in drivers/parisc/Kconfig for this purpose.
>=20
> This could also be 'select HAS_IOPORT if PCI || EISA', but
> that would require removing the 'depends on HAS_IOPORT'
> under drivers/eisa/.

I did use "select HAS_IOPORT if PCI || ISA || ATARI_ROM_ISA" in m68k so
I think ideally we would handle both in the same way. I don't have a
strong preference but I think the "select HAS_IOPORT if ..." puts it
all in a single place which is nice. Also I think this would make it
more similar architectures with unconditional HAS_IOPORT that thus
don't need "depends on HAS_IOPORT" in their "config ISA" either. As
also pointed by your comment below for x86. So will try to go this
route.

>=20
> >  	select HAVE_DEBUG_STACKOVERFLOW
> >  	select HAVE_ARCH_AUDITSYSCALL
> >  	select HAVE_ARCH_HASH
> > @@ -131,6 +132,7 @@ config STACKTRACE_SUPPORT
> >=20
> >  config ISA_DMA_API
> >  	bool
> > +	depends on HAS_IOPORT
> >=20
>=20
> This line is not really needed since there is no way to
> enable ISA_DMA_API.

Removed

>=20
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index a6c4407d3ec8..f7de646c074a 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -188,6 +188,7 @@ config PPC
> >  	select GENERIC_SMP_IDLE_THREAD
> >  	select GENERIC_TIME_VSYSCALL
> >  	select GENERIC_VDSO_TIME_NS
> > +	select HAS_IOPORT			if PCI
> >  	select HAVE_ARCH_AUDITSYSCALL
> >  	select HAVE_ARCH_HUGE_VMALLOC		if HAVE_ARCH_HUGE_VMAP
> >  	select HAVE_ARCH_HUGE_VMAP		if PPC_RADIX_MMU || PPC_8xx
> > @@ -1070,7 +1071,6 @@ menu "Bus options"
> >=20
> >  config ISA
> >  	bool "Support for ISA-bus hardware"
> > -	depends on PPC_CHRP
> >  	select PPC_I8259
> >  	help
> >  	  Find out whether you have ISA slots on your motherboard.  ISA is th=
e
>=20
> This line looks wrong, I think we should keep that dependency.
> Did you get a circular dependency if you leave it in?

I don't recall why this was removed. I guess it happened when I was
experimenting with adding "depends on HAS_IOPORT" for the ISA config
options but that ultimately lead to circular dependencies, must have
messed up when removing this here.

>=20
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index a825bf031f49..634dd42532f3 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -162,6 +162,7 @@ config X86
> >  	select GUP_GET_PXX_LOW_HIGH		if X86_PAE
> >  	select HARDIRQS_SW_RESEND
> >  	select HARDLOCKUP_CHECK_TIMESTAMP	if X86_64
> > +	select HAS_IOPORT
> >  	select HAVE_ACPI_APEI			if ACPI
> >  	select HAVE_ACPI_APEI_NMI		if ACPI
> >  	select HAVE_ALIGNED_STRUCT_PAGE		if SLUB
> > @@ -2893,6 +2894,7 @@ if X86_32
> >=20
> >  config ISA
> >  	bool "ISA support"
> > +	depends on HAS_IOPORT
> >  	help
>=20
> HAS_IOPORT is selected unconditionally already, so this doesn't
> really do anything.

Removed.

>=20
> > diff --git a/lib/Kconfig.kgdb b/lib/Kconfig.kgdb
> > index 3b9a44008433..c68e4d9dcecb 100644
> > --- a/lib/Kconfig.kgdb
> > +++ b/lib/Kconfig.kgdb
> > @@ -121,7 +121,8 @@ config KDB_DEFAULT_ENABLE
> >=20
> >  config KDB_KEYBOARD
> >  	bool "KGDB_KDB: keyboard as input device"
> > -	depends on VT && KGDB_KDB && !PARISC
> > +	depends on HAS_IOPORT
> > +	depends on VT && KGDB_KDB
> >  	default n
>=20
> This loses the !PARISC dependency, which I don't think is
> intentional. The added HAS_IOPORT dependency makes sense
> here, but I think this should be in a different patch
> and not in the preparation.
>=20
>     Arnd

Agree will put into its own patch and re-add the !PARISC

