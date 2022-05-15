Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC179527818
	for <lists+linux-arch@lfdr.de>; Sun, 15 May 2022 16:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbiEOOa3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 May 2022 10:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbiEOOa2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 May 2022 10:30:28 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C472B2AC5B;
        Sun, 15 May 2022 07:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1652625026; bh=3e16+hFlcGDsfg0rNSyxTRRT1xm0ipxvrTmKSPS6a7s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KA+rp3O+vgwoZwoM8/k+URBatu8cBv6t0tj1EdIXFRjcJM2WdrNkON3EVJXuzDqx2
         LFWZkD7F0adHlJAiykdppXt1vqCsCyaGG/2OWfaSMWSYcP8gAMROE/whOha4Irht9F
         CiR+Jhulx3ohrHCyXyaVIoveOK3qEVyFElFwrXOo=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id D04A260691;
        Sun, 15 May 2022 22:30:25 +0800 (CST)
Message-ID: <9c2b347a-8b73-2c94-d321-68a339152642@xen0n.name>
Date:   Sun, 15 May 2022 22:30:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0a1
Subject: Re: [PATCH V10 22/22] LoongArch: Add Loongson-3 default config file
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
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-23-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220514080402.2650181-23-chenhuacai@loongson.cn>
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

On 5/14/22 16:04, Huacai Chen wrote:
> Add a default config file for LoongArch-based Loongson-3 platform.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/Makefile                    |   2 +
>   arch/loongarch/configs/loongson3_defconfig | 772 +++++++++++++++++++++
>   2 files changed, 774 insertions(+)
>   create mode 100644 arch/loongarch/configs/loongson3_defconfig
>
These are all reasonable enough, although I've never run a defconfig 
kernel myself because I always carry my old configs over to new boxes, 
LoongArch ones included. :-D

Reviewed-by: WANG Xuerui <git@xen0n.name>

