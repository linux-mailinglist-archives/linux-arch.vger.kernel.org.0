Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F53A53BA7A
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jun 2022 16:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbiFBOJm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jun 2022 10:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234646AbiFBOJl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jun 2022 10:09:41 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A0C2A5500;
        Thu,  2 Jun 2022 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1654178973; bh=rULKadNuRUmxsRHBTvF37ibbVCBVzs4lGOC6A+8n0R8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LjPfY4RmCaGNed0hYjvZdi9282Fy30mTAzDUxPpJVMoSCO31bTsp7+8miCdPNDiJB
         0bUpEVgnYT0mxb0I5CVVf3fr++T/jXf9g2VcDw9qH5Mas7gVidwFK1+R8OOUJI2wGv
         Mai2UTqjMFJg9+s7B/tZWxGpr9i00eSD6sB00zKw=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 4D683600FF;
        Thu,  2 Jun 2022 22:09:33 +0800 (CST)
Message-ID: <d88ede74-b7a5-e568-1863-107c6c7f5fe0@xen0n.name>
Date:   Thu, 2 Jun 2022 22:09:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:103.0) Gecko/20100101
 Thunderbird/103.0a1
Subject: Steps forward for the LoongArch UEFI bringup patch? (was: Re: [PATCH
 V14 11/24] LoongArch: Add boot and setup routines)
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-efi@vger.kernel.org, WANG Xuerui <git@xen0n.name>,
        Yun Liu <liuyun@loongson.cn>, Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220602115141.3962749-1-chenhuacai@loongson.cn>
 <20220602115141.3962749-12-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220602115141.3962749-12-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Ard,

Sorry for sounding particularly rushed and I really don't like rushing 
things either, but as explained in the previous reply [1], what we want 
to do is mainly to get the arch/loongarch into mainline first, 
stabilizing an ABI surface already under heavy testing for many months; 
plus Huacai has removed the questioned kernel version string, and the 
Loongson-specific "boardinfo" sysfs file that doesn't really belong to 
/sys/firmware/efi.

So, would you please clarify and explain how Huacai and I could best 
proceed to hopefully get the *rest* of the port readied for a (late) 
merge window PR? Otherwise much of userspace development would have to 
shift target once more, and many Linux distros would have to carry and 
rebase this big patchset for another 2 months which is real churn.

If some more background is necessary, let me explain a bit more about 
the LoongArch boot protocol peculiarities...

For one thing, the standard EFI stub boot flow is a recent development, 
and has not shipped yet; all currently existing LoongArch systems 
actually implement the previous Loongson-specific boot protocol based on 
"struct bootparamsinterface", or BPI for short, that was carried over 
from the MIPS era. Systems with BPI firmware provide full EFI services 
too, but all pointers in BPI structs are virtual addresses, and the 
memory maps are not provided in the same way as their new firmware. In 
addition to that, all BPI systems launch Linux via a special GRUB2 that 
can only boot ELF files (so cannot chainload an EFI stub), and it's 
unclear whether directly booting an EFI stub would work, so the EFI stub 
logic is not invoked at all but SVAM still have to be executed somehow 
to ensure sanity. All of this means the SVAM oddity will eventually get 
in, regardless of whether we take it out now or not, if the BPI support 
is to be mainlined in the future.

For another thing, it seems Loongson really wanted to support the "PMON" 
use case that wouldn't provide full EFI services but sharing some logic 
with UEFI boot. PMON is one of the MIPS firmware varieties that Loongson 
has supported back in the days, and they seem to have ported it to 
LoongArch as well.

For this, I don't know if Huacai should really just leave those 
modification in the downstream fork to keep the upstream Linux clean of 
such hacks, because to some degree dealing with such notoriety is life, 
it seems to me. I think at this point Huacai would cooperate and tweak 
the patch to get rid of the SVAM and other nonstandard bits as much as 
possible, and I'll help him where necessary too.


[1]: 
https://lore.kernel.org/all/47b559c0-b1e8-e800-0491-2431e2083dad@xen0n.name/

