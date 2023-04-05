Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811626D87AC
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 22:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjDEUGw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 16:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjDEUGv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 16:06:51 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D6F268B;
        Wed,  5 Apr 2023 13:06:50 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.221.228])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 335K0Sot3654908
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 5 Apr 2023 13:00:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 335K0Sot3654908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023030901; t=1680724836;
        bh=e+7idCFcOldUdf6Kn1N4qPSHOAd8AGbMfDqGpl68/MY=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=EcXIoUqgD3GVk8dx9ASffLO9ApOOB/n4lbb3fej1ORvYHN0/iMb/OoqoAXejO+Zl0
         Rw/g8eHLmO+3g1cgp+fB4K8y/Tv66bULY41CG0VNoNe1xXssQzoSffnMPSdWphcYwf
         ZzGlpNJKo4CsJ2a2nk0pmTpZD0wBYq7o8dQL4gvncAtMrlBPm5aJCuPjVQ630EH6kU
         RTKT9BP7sk08N3WlXh3R+KcPbOQKrbUAmaN/sN+VsgfhU1MyFvVfA0l5ideAWavhGi
         1hSCNrnhuIGoxexs5BAE4C0+dBVdtOYUI9AG6FgCpZuqROhanSelavXMtP8wX3ELEQ
         7+LEVmStcCTzw==
Date:   Wed, 05 Apr 2023 13:00:27 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
        Yoshinori Sato <ysato@users.osdn.me>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4=5D_Kconfig=3A_introduce_HAS=5FI?= =?US-ASCII?Q?OPORT_option_and_select_it_as_necessary?=
User-Agent: K-9 Mail for Android
In-Reply-To: <248a41a536d5a3c9e81e8e865b34c5bf74cd36d4.camel@linux.ibm.com>
References: <20230323163354.1454196-1-schnelle@linux.ibm.com> <248a41a536d5a3c9e81e8e865b34c5bf74cd36d4.camel@linux.ibm.com>
Message-ID: <B1EC1AC7-6BB5-4B66-B171-24687C3CBFB3@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On April 5, 2023 8:12:38 AM PDT, Niklas Schnelle <schnelle@linux=2Eibm=2Eco=
m> wrote:
>On Thu, 2023-03-23 at 17:33 +0100, Niklas Schnelle wrote:
>> We introduce a new HAS_IOPORT Kconfig option to indicate support for I/=
O
>> Port access=2E In a future patch HAS_IOPORT=3Dn will disable compilatio=
n of
>> the I/O accessor functions inb()/outb() and friends on architectures
>> which can not meaningfully support legacy I/O spaces such as s390=2E
>>=20
>> The following architectures do not select HAS_IOPORT:
>>=20
>> * ARC
>> * C-SKY
>> * Hexagon
>> * Nios II
>> * OpenRISC
>> * s390
>> * User-Mode Linux
>> * Xtensa
>>=20
>> All other architectures select HAS_IOPORT at least conditionally=2E
>>=20
>> The "depends on" relations on HAS_IOPORT in drivers as well as ifdefs
>> for HAS_IOPORT specific sections will be added in subsequent patches on
>> a per subsystem basis=2E
>>=20
>> Co-developed-by: Arnd Bergmann <arnd@kernel=2Eorg>
>> Signed-off-by: Arnd Bergmann <arnd@kernel=2Eorg>
>> Acked-by: Johannes Berg <johannes@sipsolutions=2Enet> # for ARCH=3Dum
>> Acked-by: Geert Uytterhoeven <geert@linux-m68k=2Eorg>
>> Signed-off-by: Niklas Schnelle <schnelle@linux=2Eibm=2Ecom>
>> ---
>> Note: This patch is the initial patch of a larger series[0]=2E This pat=
ch
>> introduces the HAS_IOPORT config option while the rest of the series ad=
ds
>> driver dependencies and the final patch removes inb() / outb() and frie=
nds on
>> platforms that don't support them=2E=20
>>=20
>> Thus each of the per-subsystem patches is independent from each other b=
ut
>> depends on this patch while the final patch depends on the whole series=
=2E Thus
>> splitting this initial patch off allows the per-subsytem HAS_IOPORT dep=
endency
>> addition be merged separately via different trees without breaking the =
build=2E
>>=20
>> [0] https://lore=2Ekernel=2Eorg/lkml/20230314121216=2E413434-1-schnelle=
@linux=2Eibm=2Ecom/
>>=20
>> Changes since v3:
>> - List archs without HAS_IOPORT in commit message (Arnd)
>> - Select HAS_IOPORT for LoongArch (Arnd)
>> - Use "select HAS_IOPORT if (E)ISA || =2E=2E" instead of a "depends on"=
 for (E)ISA
>>   for m68k and parisc
>> - Select HAS_IOPORT with config GSC on parisc (Arnd)
>> - Drop "depends on HAS_IOPORT" for um's config ISA (Johannes)
>> - Drop "depends on HAS_IOPORT" for config ISA on x86 and parisc where i=
t is
>>   always selected (Arnd)
>>=20
>
>Gentle ping=2E As far as I can tell this hasn't been picked to any tree
>sp far but also hasn't seen complains so I'm wondering if I should send
>a new version of the combined series of this patch plus the added
>HAS_IOPORT dependencies per subsystem or wait until this is picked up=2E
>
>Thanks,
>Niklas
>
>

You need this on a system supporting not just ISA but also PCI=2E

Typically on non-x86 architectures this is simply mapped into a memory win=
dow=2E
