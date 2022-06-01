Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AE053A413
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 13:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352693AbiFALaP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 07:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351526AbiFALaO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 07:30:14 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBD16FA02;
        Wed,  1 Jun 2022 04:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1654083010; bh=c3qS0n8n88+tT/EbA//3xsAM4TxufqzUUQRbFEJfV+w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EywJLnYe7A8R/LTmgK3yGO7e6PNUeSyCjGLs1zzawBDPsZMKW/8UH5ABYC91HPm6h
         IpcFYqkr/Qr2DnAv99qf6UVCE3CBdZuKWPtweb5POzDav/njGFp0wWL0czl7CQ9RLo
         qDSDMdommChrpsrNhpJL4PZGLt1I2wjki+xbPPME=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 69B7B60104;
        Wed,  1 Jun 2022 19:30:10 +0800 (CST)
Message-ID: <fe537ea1-01a0-d963-ec8b-f73788e049b3@xen0n.name>
Date:   Wed, 1 Jun 2022 19:30:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:103.0) Gecko/20100101
 Thunderbird/103.0a1
Subject: Re: [PATCH V12 00/24] arch: Add basic LoongArch support
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Eric Biederman <ebiederm@xmission.com>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20220601100005.2989022-1-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220601100005.2989022-1-chenhuacai@loongson.cn>
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

On 6/1/22 17:59, Huacai Chen wrote:
> <snip>
>
> Huacai Chen(24):
>   irqchip: Adjust Kconfig for Loongson.
>   irqchip/loongson-liointc: Fix build error for LoongArch.
>   Documentation: LoongArch: Add basic documentations.
>   Documentation/zh_CN: Add basic LoongArch documentations.
>   LoongArch: Add elf-related definitions.
>   LoongArch: Add writecombine support for drm.
>   LoongArch: Add build infrastructure.
>   LoongArch: Add CPU definition headers.
>   LoongArch: Add atomic/locking headers.
>   LoongArch: Add other common headers.
>   LoongArch: Add boot and setup routines.
>   LoongArch: Add exception/interrupt handling.
>   LoongArch: Add process management.
>   LoongArch: Add memory management.
>   LoongArch: Add system call support.
>   LoongArch: Add signal handling support.
>   LoongArch: Add elf and module support.
>   LoongArch: Add misc common routines.
>   LoongArch: Add some library functions.
>   LoongArch: Add PCI controller support.
>   LoongArch: Add VDSO and VSYSCALL support.
>   LoongArch: Add multi-processor (SMP) support.
>   LoongArch: Add Non-Uniform Memory Access (NUMA) support.
>   LoongArch: Add Loongson-3 default config file.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

I have gone through every of these patches, and they now all look good 
to me. Thanks for all the revisions and cooperation!

I remember several more people have left comments on the v11 code; Eric 
commented on the signal handling bits and Ard may have something to say 
on the UEFI part. The first two cleanup patches to irqchip are 
previously sent in a separate series, and they are already trivial 
enough, but Marc may want to give the ack here too, for the patches to 
go in via the asm-generic tree.

At this time, although the port currently cannot work on any real 
hardware, the value is mostly for unblocking downstream development 
starting from the libc's, as the userspace ABI has been stable for 
several months already and there's probably no point in delaying even 
further. I've been working on the Gentoo/LoongArch port since August 
2021 and experienced every ABI break since then, so I probably know 
enough to make this statement.

I think, with the userspace ABI effectively stable already, and other 
implementation details available for continued improvement, we could 
make it into this merge window after all. People, please take a final 
quick look at this; your opinions and/or review and acks are appreciated.

