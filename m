Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C40F5277D5
	for <lists+linux-arch@lfdr.de>; Sun, 15 May 2022 15:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbiEONfx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 May 2022 09:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiEONfx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 May 2022 09:35:53 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DCF2726;
        Sun, 15 May 2022 06:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1652621746; bh=Hev/2LN/s86tH2jvoSI5c8Y1OZeqme4qP1VdhTqd2/Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=xKnEcxewoRBdKZc2HJt8887GvdDDvi+ddtwVnfIPSp3sx3FL9+wfbSwhhRnDWyXi5
         CKl0RnT93rk7CK+mOmKl8Zl8OLbYDL8N2y84YWhblmPt8AftlCPqx56mePym5sF1Ew
         uerh7Jb4hfWoVa+qnBiTe8/oZvCFez1ZL9oDraZc=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id A81D7600B5;
        Sun, 15 May 2022 21:35:45 +0800 (CST)
Message-ID: <8bf80bfd-7d49-a82e-22af-6b67ac80d0fd@xen0n.name>
Date:   Sun, 15 May 2022 21:35:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0a1
Subject: Re: [PATCH V10 18/22] LoongArch: Add PCI controller support
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
        Jianmin Lv <lvjianmin@loongson.cn>
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-19-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220514080402.2650181-19-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 5/14/22 16:03, Huacai Chen wrote:
> Loongson64 based systems are PC-like systems which use PCI/PCIe as its
> I/O bus, This patch adds the PCI host controller support for LoongArch.
>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/include/asm/dma.h |  13 +++
>   arch/loongarch/include/asm/pci.h |  40 +++++++
>   arch/loongarch/pci/acpi.c        | 172 +++++++++++++++++++++++++++++++
>   arch/loongarch/pci/pci.c         |  98 ++++++++++++++++++
>   4 files changed, 323 insertions(+)
>   create mode 100644 arch/loongarch/include/asm/dma.h
>   create mode 100644 arch/loongarch/include/asm/pci.h
>   create mode 100644 arch/loongarch/pci/acpi.c
>   create mode 100644 arch/loongarch/pci/pci.c

Admittedly I'm also not familiar with the PCI code in general, but from 
what little my knowledge currently is, the changes look okay. (At least 
the code style and naming of things are reasonable.)

So, albeit a rather weak one:

Reviewed-by: WANG Xuerui <git@xen0n.name>

