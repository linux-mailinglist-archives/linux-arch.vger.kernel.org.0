Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E0C52BE55
	for <lists+linux-arch@lfdr.de>; Wed, 18 May 2022 17:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbiERPWh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 May 2022 11:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiERPWf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 May 2022 11:22:35 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6879535AA7;
        Wed, 18 May 2022 08:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1652887346; bh=Q9LeUXw8EHw4L9SRCRb8ePYUktfr7J4tsLyCA73Vf3Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YxbGDmVoCnOXfWRDnmXRjdPhcQGbdfEfvySLwQah35S51Wrb4EJ4jd9BW0zUl9yN8
         jadXiOflC3tSJ62OqfHqC0pFPVM/NFxZDADSwaVzIEOHtFA1QoL2HmzNnAqWaDcavZ
         FUd3tfyYVzOAYwxiSVg3/UU3HHMRORj6ERNu2kRQ=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id BBD9660691;
        Wed, 18 May 2022 23:22:25 +0800 (CST)
Message-ID: <3d2c210f-03f3-f7e6-9c42-8189c240cd3a@xen0n.name>
Date:   Wed, 18 May 2022 23:22:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0a1
Subject: Re: [PATCH V11 05/22] LoongArch: Add build infrastructure
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
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
 <20220518092619.1269111-6-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220518092619.1269111-6-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/18/22 17:26, Huacai Chen wrote:
> Add Kbuild, Makefile, Kconfig and link script for LoongArch build
> infrastructure.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/Kbuild                  |   6 +
>   arch/loongarch/Kconfig                 | 395 +++++++++++++++++++++++++
>   arch/loongarch/Kconfig.debug           |   0
>   arch/loongarch/Makefile                | 105 +++++++
>   arch/loongarch/boot/.gitignore         |   2 +
>   arch/loongarch/boot/Makefile           |  20 ++
>   arch/loongarch/boot/dts/Makefile       |   4 +
>   arch/loongarch/include/asm/Kbuild      |  30 ++
>   arch/loongarch/include/uapi/asm/Kbuild |   2 +
>   arch/loongarch/kernel/.gitignore       |   2 +
>   arch/loongarch/kernel/Makefile         |  21 ++
>   arch/loongarch/kernel/vmlinux.lds.S    | 117 ++++++++
>   arch/loongarch/lib/Makefile            |   6 +
>   arch/loongarch/mm/Makefile             |   9 +
>   arch/loongarch/pci/Makefile            |   7 +
>   arch/loongarch/vdso/.gitignore         |   2 +
>   scripts/subarch.include                |   2 +-
>   17 files changed, 729 insertions(+), 1 deletion(-)
>   create mode 100644 arch/loongarch/Kbuild
>   create mode 100644 arch/loongarch/Kconfig
>   create mode 100644 arch/loongarch/Kconfig.debug
>   create mode 100644 arch/loongarch/Makefile
>   create mode 100644 arch/loongarch/boot/.gitignore
>   create mode 100644 arch/loongarch/boot/Makefile
>   create mode 100644 arch/loongarch/boot/dts/Makefile
>   create mode 100644 arch/loongarch/include/asm/Kbuild
>   create mode 100644 arch/loongarch/include/uapi/asm/Kbuild
>   create mode 100644 arch/loongarch/kernel/.gitignore
>   create mode 100644 arch/loongarch/kernel/Makefile
>   create mode 100644 arch/loongarch/kernel/vmlinux.lds.S
>   create mode 100644 arch/loongarch/lib/Makefile
>   create mode 100644 arch/loongarch/mm/Makefile
>   create mode 100644 arch/loongarch/pci/Makefile
>   create mode 100644 arch/loongarch/vdso/.gitignore

Seems most (if not all) my comments from v10 are addressed; and there 
seems to have no obvious mistake.

Reviewed-by: WANG Xuerui <git@xen0n.name>

