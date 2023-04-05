Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF5F6D8167
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 17:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbjDEPRE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 11:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238148AbjDEPQv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 11:16:51 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BAE768F;
        Wed,  5 Apr 2023 08:15:23 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335Ex0qK002073;
        Wed, 5 Apr 2023 15:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=EP7H/BG3XCUIVobBKkorHkQj2TA2B5DpLLQdBFgYKS4=;
 b=XbWxDBkfY2fo/oPyI6TrXqcU1euUz4IzeWoGlM8pMsRk498yO8yVE/7T1S6eJTb2S1UY
 Ce4n6uRJXGbJACtJS5PEQm7yDaXiLZ77NckRKQQQ5DNapH75rb5fd/ItpAm5JdaIGkJB
 EjYbhhlQ0ryc2KE5ooaYTcsk8RJlUZZfLediFtvaH7EkQ1SjyGt/Xzy43DdKyba2DK/C
 mj3z1Ouz77q3PQdLEc8JzeNlXRNO2YNOk1g5JnRZp+nfYv7EYFBF1bpKeDuLr8vDL+6n
 b4UH/HRs8HkTZNjSxDyvmPDruJP3v3TVMAV46NXQWSanaU69dM9Hykbwz50y1ICQraWy Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ps9mdkkrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 15:12:47 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 335Ena21018706;
        Wed, 5 Apr 2023 15:12:46 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ps9mdkkpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 15:12:45 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 335DwTrM010607;
        Wed, 5 Apr 2023 15:12:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3ppc86tktp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 15:12:43 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 335FCejC27853382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Apr 2023 15:12:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7493520040;
        Wed,  5 Apr 2023 15:12:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE7A920043;
        Wed,  5 Apr 2023 15:12:38 +0000 (GMT)
Received: from [9.155.211.163] (unknown [9.155.211.163])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  5 Apr 2023 15:12:38 +0000 (GMT)
Message-ID: <248a41a536d5a3c9e81e8e865b34c5bf74cd36d4.camel@linux.ibm.com>
Subject: Re: [PATCH v4] Kconfig: introduce HAS_IOPORT option and select it
 as necessary
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
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
        Johannes Berg <johannes@sipsolutions.net>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Date:   Wed, 05 Apr 2023 17:12:38 +0200
In-Reply-To: <20230323163354.1454196-1-schnelle@linux.ibm.com>
References: <20230323163354.1454196-1-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Chh8ozZVKyRilF6r1sDguQSl3KT7MF3_
X-Proofpoint-GUID: RSLPMutPzrPKT5ywknWUr1qrnGdzz6Rn
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_09,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 bulkscore=0 spamscore=0
 malwarescore=0 mlxlogscore=438 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304050136
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2023-03-23 at 17:33 +0100, Niklas Schnelle wrote:
> We introduce a new HAS_IOPORT Kconfig option to indicate support for I/O
> Port access. In a future patch HAS_IOPORT=3Dn will disable compilation of
> the I/O accessor functions inb()/outb() and friends on architectures
> which can not meaningfully support legacy I/O spaces such as s390.
>=20
> The following architectures do not select HAS_IOPORT:
>=20
> * ARC
> * C-SKY
> * Hexagon
> * Nios II
> * OpenRISC
> * s390
> * User-Mode Linux
> * Xtensa
>=20
> All other architectures select HAS_IOPORT at least conditionally.
>=20
> The "depends on" relations on HAS_IOPORT in drivers as well as ifdefs
> for HAS_IOPORT specific sections will be added in subsequent patches on
> a per subsystem basis.
>=20
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Acked-by: Johannes Berg <johannes@sipsolutions.net> # for ARCH=3Dum
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Note: This patch is the initial patch of a larger series[0]. This patch
> introduces the HAS_IOPORT config option while the rest of the series adds
> driver dependencies and the final patch removes inb() / outb() and friend=
s on
> platforms that don't support them.=20
>=20
> Thus each of the per-subsystem patches is independent from each other but
> depends on this patch while the final patch depends on the whole series. =
Thus
> splitting this initial patch off allows the per-subsytem HAS_IOPORT depen=
dency
> addition be merged separately via different trees without breaking the bu=
ild.
>=20
> [0] https://lore.kernel.org/lkml/20230314121216.413434-1-schnelle@linux.i=
bm.com/
>=20
> Changes since v3:
> - List archs without HAS_IOPORT in commit message (Arnd)
> - Select HAS_IOPORT for LoongArch (Arnd)
> - Use "select HAS_IOPORT if (E)ISA || .." instead of a "depends on" for (=
E)ISA
>   for m68k and parisc
> - Select HAS_IOPORT with config GSC on parisc (Arnd)
> - Drop "depends on HAS_IOPORT" for um's config ISA (Johannes)
> - Drop "depends on HAS_IOPORT" for config ISA on x86 and parisc where it =
is
>   always selected (Arnd)
>=20

Gentle ping. As far as I can tell this hasn't been picked to any tree
sp far but also hasn't seen complains so I'm wondering if I should send
a new version of the combined series of this patch plus the added
HAS_IOPORT dependencies per subsystem or wait until this is picked up.

Thanks,
Niklas

