Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A995A54E0B2
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jun 2022 14:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376592AbiFPMVJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jun 2022 08:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiFPMVJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jun 2022 08:21:09 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AE34AE2C
        for <linux-arch@vger.kernel.org>; Thu, 16 Jun 2022 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1655382063; bh=dMkXkbRo80VKUtNbZXQUgDEsYjkDN9QPvX0sgb47bHY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C9+E90tCTyhOQKxDJUbdlmBcr5sr9FydxAFLnVK2oBrcV2wApCHIJbYZTc1GkwquJ
         7Yoor+Lk0PYne5E+irgfYvFGhTQdRCLxu8pvHTXad8CU1ca2r+wJRl6t+vbSTPtzdB
         ky59ZdGC3pfjxu4gRotEvJFL1PZQ5jKRw7K+sw7g=
Received: from [100.100.57.190] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id D827D60691;
        Thu, 16 Jun 2022 20:21:02 +0800 (CST)
Message-ID: <ab6e2213-0795-68d1-c596-3dae1e174421@xen0n.name>
Date:   Thu, 16 Jun 2022 20:21:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:103.0)
 Gecko/20100101 Thunderbird/103.0a1
Subject: Re: [PATCH] MAINTAINERS: Add maillist information for LoongArch
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220616121456.3613470-1-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220616121456.3613470-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2022/6/16 20:14, Huacai Chen wrote:
> Now there is a dedicated maillist (loongarch@lists.linux.dev) for
> LoongArch, add it for better development.

Obligatory English fixes:

 > Now that there is a dedicated mailing list for LoongArch, add it for 
better collaboration.

Is this version better? We have the list address below so I feel no need 
for duplicating it in the commit message.

>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1fc9ead83d2a..dba5e89527a2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11590,6 +11590,7 @@ F:	drivers/gpu/drm/bridge/lontium-lt8912b.c
>   LOONGARCH
>   M:	Huacai Chen <chenhuacai@kernel.org>
>   R:	WANG Xuerui <kernel@xen0n.name>
> +L:	loongarch@lists.linux.dev
>   S:	Maintained
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git
>   F:	arch/loongarch/

Otherwise LGTM. I should become the 4th subscriber shortly ;-)

Reviewed-by: WANG Xuerui <git@xen0n.name>

