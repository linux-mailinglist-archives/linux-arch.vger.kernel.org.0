Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70556B36AB
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 07:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCJGd0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Mar 2023 01:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCJGdZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Mar 2023 01:33:25 -0500
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB9362329;
        Thu,  9 Mar 2023 22:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1678429997; bh=4C6HnN21M1Yd/D9KjrquiNHGH1hSuW4N+37mX25H2Fc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=entKqqchb8a09D3jBKHUDRbIEQgT8b5aA/UrInuRxuX+dAhWtlOu+HDag85LjJBCA
         hBG+7PggoBfFjyCTpBRWhF973rmEkprmt3MQ0r7HPx2GUmAo+uXEq73lktCzajVIZF
         u5EnaJd0WhME6nSM9CdhNvPefd9osUIdMHE2JaxI=
Received: from [100.100.57.122] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id D529D600A6;
        Fri, 10 Mar 2023 14:33:16 +0800 (CST)
Message-ID: <7e743095-3dbc-3f28-a347-d2a1659e650d@xen0n.name>
Date:   Fri, 10 Mar 2023 14:33:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH V4] LoongArch: Provide kernel fpu functions
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
References: <20230310025136.964745-1-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230310025136.964745-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2023/3/10 10:51, Huacai Chen wrote:
> Provide kernel_fpu_begin()/kernel_fpu_end() to allow the kernel itself
> to use fpu. They can be used by some other kernel components, e.g., the
> AMDGPU graphic driver for DCN.

Actually, as Christoph suggested earlier, you should probably send this 
together with the amdgpu modifications so that "actual usage" of the 
interface is established.

> 
> Reported-by: WANG Xuerui <kernel@xen0n.name>
> Tested-by: WANG Xuerui <kernel@xen0n.name>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V2: Use non-GPL exports and update commit messages.
> V3: Add spaces for coding style.
> V4: WARN_ON unexpected requests and use GPL exports again.

We should probably provide more archaeology or legal evidence as to why 
the in-kernel FPU ops must be GPL-only. After all the status quo is that 
among all arches that provide such ops, only the x86 ones are exported 
GPL, so if loongarch should go GPL for this interface then probably 
everyone else should too. It's not only affecting loongarch IMO.

> 
>   arch/loongarch/include/asm/fpu.h |  3 +++
>   arch/loongarch/kernel/Makefile   |  2 +-
>   arch/loongarch/kernel/kfpu.c     | 43 ++++++++++++++++++++++++++++++++
>   3 files changed, 47 insertions(+), 1 deletion(-)
>   create mode 100644 arch/loongarch/kernel/kfpu.c
> 

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

