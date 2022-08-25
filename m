Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD67A5A0FED
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 14:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbiHYMFS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 08:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237360AbiHYMFQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 08:05:16 -0400
X-Greylist: delayed 117 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 Aug 2022 05:05:07 PDT
Received: from mxout.security-mail.net (mxout.security-mail.net [85.31.212.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52AB67C81
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 05:05:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx302.security-mail.net (Postfix) with ESMTP id B8B873D3B1D0
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 14:03:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661428987;
        bh=c3uYyBl6qvCHN1q+Vp2nMomyuSSZyQtk8GD6AReFogg=;
        h=Date:Subject:References:To:From:In-Reply-To;
        b=RfXgYwb6FvMA0qtaFaa5Jo1rFeAAG4RBKlnmA1/wwFmp1zc1hqTdORetVdToCdR5x
         rFNi/SEGRAa3cVHZveNuUx9ORQ9FGqA+kuQ6WVwhDmR1pIvJxiI3ruLG4XwnsHJuYI
         DxtDQ1I5EzBc2dMAgv1oExFmf/slS7ZHOArnpIAQ=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id 632903D3B1D8; Thu, 25 Aug 2022 14:03:07 +0200 (CEST)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx302.security-mail.net (Postfix) with ESMTPS id C2D4E3D3B01D; Thu, 25 Aug
 2022 14:03:06 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 3E85227E038A; Thu, 25 Aug 2022
 14:03:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 27E3327E0394; Thu, 25 Aug 2022 14:03:03 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 f2JAeIGqXzVT; Thu, 25 Aug 2022 14:03:03 +0200 (CEST)
Received: from [127.0.0.1] (unknown [192.168.37.161]) by zimbra2.kalray.eu
 (Postfix) with ESMTPSA id E9D5827E038A; Thu, 25 Aug 2022 14:03:02 +0200
 (CEST)
X-Virus-Scanned: E-securemail, by Secumail
Secumail-id: <a93b.630764fa.c2622.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 27E3327E0394
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661428983;
 bh=HGxFO3zfun4rb0tLinDLjetXRC3Xrh4uCBUGEF7M5U8=;
 h=Message-ID:Date:MIME-Version:To:From;
 b=N2I0P2FxIYtse7t5r8XIS6fmoMI4vO129nEEu9OJEjqMOlAmd4NLuB+1pmvkcwZIf
 1cYx+DX9vMGZxeFIMe8qUPN3MqEKgR7jNXfbxQa0VDCBqRtrBn76XlIJZmIAF4eQ7F
 a/6Co6kUnvj1ri9xLw0pH9ML6rtlnadvdIgRNp94=
Message-ID: <ccc8a0ba-31f4-f9a7-7955-a0511cf793b6@kalray.eu>
Date:   Thu, 25 Aug 2022 14:03:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Fwd: [RFC PATCH 0/1] Fix __kcrctab+* sections alignment
References: <20220817161438.32039-1-ysionneau@kalray.eu>
Content-Language: en-us
To:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
From:   Yann Sionneau <ysionneau@kalray.eu>
In-Reply-To: <20220817161438.32039-1-ysionneau@kalray.eu>
X-Forwarded-Message-Id: <20220817161438.32039-1-ysionneau@kalray.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Forwarding to linux-kbuild and linux-arch


-------- Forwarded Message --------
Subject: 	[RFC PATCH 0/1] Fix __kcrctab+* sections alignment
Date: 	Wed, 17 Aug 2022 18:14:37 +0200
From: 	Yann Sionneau <ysionneau@kalray.eu>
To: 	linux-kernel@vger.kernel.org
CC: 	Nicolas Schier <nicolas@fjasle.eu>, Masahiro Yamada 
<masahiroy@kernel.org>, Jules Maselbas <jmaselbas@kalray.eu>, Julian 
Vetter <jvetter@kalray.eu>, Yann Sionneau <ysionneau@kalray.eu>



Hello, At Kalray we have our (non-upstreamed-yet) kvx Linux port 
(https://github.com/kalray/linux_coolidge).

When I did the rebase on 5.19 I noticed the kernel module would not load 
anymore and would say

[ 10.071771] Found checksum 0 vs module B4E7D8E
[ 10.071824] libphy: disagrees about version of symbol module_layout

The CRC of module_layout in libphy.ko seems fine, but surprisingly, the 
CRC of module_layout in vmlinux is 0.

I dig a little bit to try and understand why.

.vmlinux.export.c contains:
SYMBOL_CRC(module_layout, 0x0b4e7d8e, "");

Dumping the section '___kcrctab+module_layout' of .vmlinux.export.o I get:
Hex dump of section '___kcrctab+module_layout':
0x00000000 8e7d4e0b .}N.

Dumping __kcrctab section of vmlinux:
Hex dump of section '__kcrctab':
0xffffff80055b7090 572828d0 00000000 b96e414c 00000000 W((......nAL....
0xffffff80055b70a0 b0179638 00000000 e3eb8db7 00000000 ...8............
0xffffff80055b70b0 7a10c1c7 00000000 3d04478a 00000000 z.......=.G.....
0xffffff80055b70c0 a5d7be15 00000000 d188008b 00000000 ................
0xffffff80055b70d0 6214323b 00000000 bba48601 00000000 b.2;............
0xffffff80055b70e0 6bfbba55 00000000 251fa090 00000000 k..U....%.......
0xffffff80055b70f0 2861bde8 00000000 81c8241d 00000000 (a........$.....
etc

You can see that in fact there is some kind of 4-bytes padding 
in-between each CRC32.

And indeed by looking at ___kcrctab+module_layout section alignment in 
.vmlinux.export.o I can see:
Section Headers:
[Nr] Name Type Address Off Size ES Flg Lk Inf Al
[...snip snip...]
[6189] ___kcrctab+module_layout PROGBITS 0000000000000000 00c188 000004 
00 WA 0 0 8

So somehow, the section really contains 4 bytes of the CRC32 but even 
though the section contains a u32, the toolchain creates an 8-bytes 
aligned section.
This ends up creating 4-bytes padding with 0s once the linker collects 
all those ___kcrctab+* into __kcrctab for vmlinux ELF.

Do you think this is an issue in Linux kernel generic code? (See 
attached patch that makes our module probe again)
Or is this an issue with our toolchain?

On 5.16.20 our modules were loading fine and the __kcrctab did not 
contain any 4-bytes 00000000 gaps.
I think it is related to this change: 
https://lore.kernel.org/linux-kbuild/20220528224745.GA2501857@roeck-us.net/T/
In the change, we can see that the previous version was using assembly 
to create the sections and there was the presence of a ".balign 
KCRC_ALIGN" which was defined to whatever is the arch-specific way to 
encode a "4 bytes" alignement (be it 2 for "2^2" for m68k or directly 4 
for others) for the assembler.

How to reproduce:
1/ generate the toolchain
$ git clone https://github.com/kalray/build-scripts
$ cd build-scripts
$ source last.refs
$ ./build-kvx-xgcc.sh output

2/ fetch and build our v5.19 kernel
$ git clone -b kalray-linux-v5.19 https://github.com/kalray/linux_coolidge
$ cd linux_coolidge
$ make ARCH=kvx O=build_kvx CROSS_COMPILE=kvx-elf- default_defconfig
$ make ARCH=kvx O=build_kvx CROSS_COMPILE=kvx-elf- -j$(($(nproc) + 1))

You won't have a rootfs but you will be able to observe the content of 
__kcrctab section of vmlinux
PS: the kalray-linux-v5.19 branch already contains the attached-patch to 
add __aligned(4) requirement.
PPS: Please CC me, I am not subscribed to the mailing list

Yann Sionneau (1):
Fix __kcrctab+* sections alignment

include/linux/export-internal.h | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.37.2





