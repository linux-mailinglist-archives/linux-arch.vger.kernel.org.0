Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C08D6C696A
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 14:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjCWNZp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 09:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCWNZo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 09:25:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9049A421B;
        Thu, 23 Mar 2023 06:25:43 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NBwu6E027980;
        Thu, 23 Mar 2023 13:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=VwL2eHgiXbSpbcyOMi1Fm6CGpKEbs60ss+WPZnJK5Ik=;
 b=XUOZb+O02s7yDbfd9owIe2KU+IxtepAYblP5hOfMaou9r1s62w4XYcd21Ay890Ch0UtZ
 b3P6V74UYISN/vgI9gfJX4goA81aaSJ6+BrnqTltbxt9dViPahHFqwYh2ph/oHgOCuUs
 cBuk/dBdRXe6yir7UjhPfJohLY53yu99IuZ0u/VvorW219jlSZERTnQz24NuopyuaJRv
 f/R4+LqrQSLYvZjgJitqK439IVBWg+2l8kKrls150yN5+2GDZLbAW/9AVV53S7LOSmnA
 XiauVMwmdc0qgxFAu2fBNR8kde+goodonXLhqI7dsBaHwnZoURHUBVQ40SKG6ndeV6av Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pghqssfc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 13:24:08 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32NBrkW0000445;
        Thu, 23 Mar 2023 13:24:07 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pghqssfab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 13:24:07 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32NCFRdl006837;
        Thu, 23 Mar 2023 13:24:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3pd4x667jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 13:24:03 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32NDO0Y524772868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 13:24:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBC2C20040;
        Thu, 23 Mar 2023 13:24:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD7DC2004D;
        Thu, 23 Mar 2023 13:23:57 +0000 (GMT)
Received: from [9.171.87.16] (unknown [9.171.87.16])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 23 Mar 2023 13:23:57 +0000 (GMT)
Message-ID: <95d5d0c434ef6c4cadc3fca34c4c0d3104becea8.camel@linux.ibm.com>
Subject: Re: [PATCH v3 01/38] Kconfig: introduce HAS_IOPORT option and
 select it as necessary
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
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
        "David S. Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
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
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org
Date:   Thu, 23 Mar 2023 14:23:57 +0100
In-Reply-To: <21a828bae06b97b8ca806a6b76d867902b1e0e1f.camel@sipsolutions.net>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
         <20230314121216.413434-2-schnelle@linux.ibm.com>
         <21a828bae06b97b8ca806a6b76d867902b1e0e1f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ILhJ9KxUcdZTNzZ4sWuhaur67a0wm06C
X-Proofpoint-ORIG-GUID: mOBSc53Xq2jpq67qceMo9W2p8ZoZQ_8a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 spamscore=0 bulkscore=0 mlxlogscore=449
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230098
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2023-03-14 at 13:37 +0100, Johannes Berg wrote:
> On Tue, 2023-03-14 at 13:11 +0100, Niklas Schnelle wrote:
> > --- a/arch/um/Kconfig
> > +++ b/arch/um/Kconfig
> > @@ -56,6 +56,7 @@ config NO_IOPORT_MAP
> > =20
> >  config ISA
> >  	bool
> > +	depends on HAS_IOPORT
> >=20
>=20
> config ISA here is already unselectable, and nothing ever does "select
> ISA" (only in some other architectures), so is there much point in this?
>=20
> I'm not even sure why this exists at all.

You're right there's not much point and I dropped this for v4. I agree
that probably the whole "config ISA" could be removed if it's always
false anyway but that seems out of scope for this patch.

>=20
> But anyway, adding a dependency to a always-false symbol doesn't make it
> less always-false :-)
>=20
> Acked-by: Johannes Berg <johannes@sipsolutions.net> # for ARCH=3Dum

Thanks

>=20
>=20
> Certainly will be nice to get rid of this cruft for architectures that
> don't have it.
>=20
> johannes

Yes, also, for s390 the broken NULL + port number access in the generic
inb()/outb() currently causes the only remaining clang warning on
defconfig builds.
