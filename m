Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06496A89CE
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 20:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCBTyw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 14:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCBTyw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 14:54:52 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D9139B93;
        Thu,  2 Mar 2023 11:54:51 -0800 (PST)
Received: from [127.0.0.1] ([73.223.221.228])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 322JolfB1654568
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 2 Mar 2023 11:50:48 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 322JolfB1654568
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023020601; t=1677786658;
        bh=n/GRsm1pImWCPNm4dPoe5zec7Kp4K3JReb8gPrI8/mc=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=EoMqj2NrvtdnnKP1K3ZY31x6mzZLyhmRVv+AfJ7wKdoAJbCxWwA+q2O/5sMmJVAVH
         CBl1NaM0Y8H4KZuzvQjbNwKYV6dXCiIfmDalzvbDgGVmn+bMayegSv6UvQXFNOV7kH
         d/WVC69GzUYAENKo48YQjfv0/LuQNbAN20Le/uIDHGiGr9P8B8oHP2fS95eG5xB58F
         uasUM1VqxwzDuwffGGAapL9uswmgoHxhnTzGnsDohaOFjOu2pxA/e5nnYVugsNl2zn
         98XlC/4jazJIi0XM8kFrS6seI0EpKbWqSgJdlLGlfl4yBTPVtfQW74gM369HHmiIcn
         4YRgUzYFXGcXg==
Date:   Thu, 02 Mar 2023 11:50:45 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>, hca@linux.ibm.com
CC:     geert@linux-m68k.org, alexghiti@rivosinc.com, corbet@lwn.net,
        Richard Henderson <richard.henderson@linaro.org>,
        ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org,
        linux@armlinux.org.uk, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, chenhuacai@kernel.org,
        kernel@xen0n.name, monstr@monstr.eu, tsbogend@alpha.franken.de,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        ysato@users.osdn.me, dalias@libc.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, chris@zankel.net,
        jcmvbkbc@gmail.com, Arnd Bergmann <arnd@arndb.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 00/24] Remove COMMAND_LINE_SIZE from uapi
User-Agent: K-9 Mail for Android
In-Reply-To: <mhng-e8b09772-24e5-4729-a0bf-01a9e4c76636@palmer-ri-x1c9a>
References: <mhng-e8b09772-24e5-4729-a0bf-01a9e4c76636@palmer-ri-x1c9a>
Message-ID: <21F95EC4-71EA-4154-A7DC-8A5BA54F174B@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On March 1, 2023 7:17:18 PM PST, Palmer Dabbelt <palmer@dabbelt=2Ecom> wrot=
e:
>On Tue, 14 Feb 2023 01:19:02 PST (-0800), hca@linux=2Eibm=2Ecom wrote:
>> On Tue, Feb 14, 2023 at 09:58:17AM +0100, Geert Uytterhoeven wrote:
>>> Hi Heiko,
>>>=20
>>> On Tue, Feb 14, 2023 at 9:39 AM Heiko Carstens <hca@linux=2Eibm=2Ecom>=
 wrote:
>>> > On Tue, Feb 14, 2023 at 08:49:01AM +0100, Alexandre Ghiti wrote:
>>> > > This all came up in the context of increasing COMMAND_LINE_SIZE in=
 the
>>> > > RISC-V port=2E  In theory that's a UABI break, as COMMAND_LINE_SIZ=
E is the
>>> > > maximum length of /proc/cmdline and userspace could staticly rely =
on
>>> > > that to be correct=2E
>>> > >
>>> > > Usually I wouldn't mess around with changing this sort of thing, b=
ut
>>> > > PowerPC increased it with a5980d064fe2 ("powerpc: Bump COMMAND_LIN=
E_SIZE
>>> > > to 2048")=2E  There are also a handful of examples of COMMAND_LINE=
_SIZE
>>> > > increasing, but they're from before the UAPI split so I'm not quit=
e sure
>>> > > what that means: e5a6a1c90948 ("powerpc: derive COMMAND_LINE_SIZE =
from
>>> > > asm-generic"), 684d2fd48e71 ("[S390] kernel: Append scpdata to ker=
nel
>>> > > boot command line"), 22242681cff5 ("MIPS: Extend COMMAND_LINE_SIZE=
"),
>>> > > and 2b74b85693c7 ("sh: Derive COMMAND_LINE_SIZE from
>>> > > asm-generic/setup=2Eh=2E")=2E
>>> > >
>>> > > It seems to me like COMMAND_LINE_SIZE really just shouldn't have b=
een
>>> > > part of the uapi to begin with, and userspace should be able to ha=
ndle
>>> > > /proc/cmdline of whatever length it turns out to be=2E  I don't se=
e any
>>> > > references to COMMAND_LINE_SIZE anywhere but Linux via a quick Goo=
gle
>>> > > search, but that's not really enough to consider it unused on my e=
nd=2E
>>> > >
>>> > > The feedback on the v1 seemed to indicate that COMMAND_LINE_SIZE r=
eally
>>> > > shouldn't be part of uapi, so this now touches all the ports=2E  I=
've
>>> > > tried to split this all out and leave it bisectable, but I haven't
>>> > > tested it all that aggressively=2E
>>> >
>>> > Just to confirm this assumption a bit more: that's actually the same
>>> > conclusion that we ended up with when commit 3da0243f906a ("s390: ma=
ke
>>> > command line configurable") went upstream=2E
>
>Thanks, I guess I'd missed that one=2E  At some point I think there was s=
ome discussion of making this a Kconfig for everyone, which seems reasonabl=
e to me -- our use case for this being extended is syzkaller, but we're sor=
t of just picking a value that's big enough for now and running with it=2E
>
>Probably best to get it out of uapi first, though, as that way at least i=
t's clear that it's not uABI=2E
>
>>> Commit 622021cd6c560ce7 ("s390: make command line configurable"),
>>> I assume?
>>=20
>> Yes, sorry for that=2E I got distracted while writing and used the wron=
g
>> branch to look this up=2E
>
>Alex: Probably worth adding that to the list in the cover letter as it lo=
oks like you were planning on a v4 anyway (which I guess you now have to do=
, given that I just added the issue to RISC-V)=2E

The only use that is uapi is the *default* length of the command line if t=
he kernel header doesn't include it (in the case of x86, it is in the bzIma=
ge header, but that is atchitecture- or even boot format-specific=2E)
