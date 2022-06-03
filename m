Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1F153C7E0
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 11:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243200AbiFCJsN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jun 2022 05:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243182AbiFCJsM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2022 05:48:12 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B191613D1F;
        Fri,  3 Jun 2022 02:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1654249686; bh=yrg9on8zb+NApRYtS5qBL8mX8F/7jBwdIdZxHyDYbOg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jRWyTZmCNV/pqzL9Eg+ZxwLUSRI9QggIjDRMCfMrbky0lqSLxFkJtfEZUGVyyUYRg
         89X1nwC1YAmllYkpH0RvCQ201k1hKMjSdHc0Op5LLuhNnls78FnzObQU7HsVRJeXBr
         tQ2czc6m7bTnTxGA7okwYgtWi3dI1Urc/giRlB1M=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id EB0F560104;
        Fri,  3 Jun 2022 17:48:05 +0800 (CST)
Message-ID: <f7b53d2b-759c-bc5b-e2ed-a251b879f450@xen0n.name>
Date:   Fri, 3 Jun 2022 17:48:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:103.0) Gecko/20100101
 Thunderbird/103.0a1
Subject: Re: Steps forward for the LoongArch UEFI bringup patch? (was: Re:
 [PATCH V14 11/24] LoongArch: Add boot and setup routines)
Content-Language: en-US
To:     Xi Ruoyao <xry111@xry111.site>, WANG Xuerui <kernel@xen0n.name>,
        Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>,
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
 <d88ede74-b7a5-e568-1863-107c6c7f5fe0@xen0n.name>
 <dab96b787bef91240c719ea1a100396350135f99.camel@xry111.site>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <dab96b787bef91240c719ea1a100396350135f99.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/3/22 17:32, Xi Ruoyao wrote:
> On Thu, 2022-06-02 at 22:09 +0800, WANG Xuerui wrote:
>
>> For this, I don't know if Huacai should really just leave those
>> modification in the downstream fork to keep the upstream Linux clean of
>> such hacks, because to some degree dealing with such notoriety is life,
>> it seems to me. I think at this point Huacai would cooperate and tweak
>> the patch to get rid of the SVAM and other nonstandard bits as much as
>> possible, and I'll help him where necessary too.
> To me any new firmware for PC-like platforms should implement UEFI.  For
> embedded platforms device tree support will be added later.
>
> For those guys impossible or unwilling to upgrade the firmware, it may
> be possible to implement a compatibility layer and the booting procedure
> will be like:
>
> old firmware -> bootloongarch.efi -> customized u-boot -> bootloongarch64.efi (grub) -> efi stub (kernel)
>                  --------- compatibility layer --------    ^^^^^^^^ normal UEFI compatible stuff ^^^^^^^^^
>
> new firmware -> bootloongarch64.efi (grub) -> efi stub (kernel)
>
> The old firmware route would be similar to the booting procedure of
> Asahi Linux.  I think this can be implemented because it's already
> implemented on M1 even while Apple is almost completely uncooperative.

This is a bit off-topic (we're basically hurrying up to get the port 
into v5.19-rc1 and discussing ways to achieve that), but yeah 
definitely. I've had the same idea right after knowing the LoongArch 
firmware would also have "new-world" variant, then I contacted some 
firmware engineers working on LoongArch boards, I think they agreed on 
the approach overall.

However, making the kernel itself capable of booting on both BPI and 
new-world UEFI firmware flavors may have its merits after all; one 
scenario I could come up with is that user reboots and upgrades their 
firmware, *before* updating their old-world kernel, and bang! system 
soft-bricked. All such cases involve old-world distros that already 
deviate a little bit from vanilla upstream code, so such BPI support 
needn't be mainlined for avoiding this scenario.

>
> Just my 2 cents. I know almost nothing about booting.
That's fine, we all know nothing in the beginning ;-)
