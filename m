Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C68E5820A6
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jul 2022 09:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiG0HFK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jul 2022 03:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiG0HFJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jul 2022 03:05:09 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD5521A
        for <linux-arch@vger.kernel.org>; Wed, 27 Jul 2022 00:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1658905504; bh=UT8bWIMZYd2/hRcgWb7BU9Sbsu2ImVUasxeDJLxN/TM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EvDSrylctg96lCOmdGJhQdcc1hL5XVmb3I+uI6zSm4ISPph+oNGYQ6KWAqDAJ6kHy
         uZRY8ZKyPPTZ0NtHdiRZoaEyUDmyc0jofnLkHq7gs7Em4Iup0Rqnzsfb+ytWn9ZReK
         r6v9bg3Q5j0SK8HsrO7r/ZgBlZZ7wZSnVfkZBBMU=
Received: from [100.100.57.219] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 4E6926061B;
        Wed, 27 Jul 2022 15:05:04 +0800 (CST)
Message-ID: <4457577a-64b8-4f17-c071-b23af1fe2aa5@xen0n.name>
Date:   Wed, 27 Jul 2022 15:05:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:105.0)
 Gecko/20100101 Thunderbird/105.0a1
Subject: Re: [PATCH] LoongArch: Disable executable stack by default
Content-Language: en-US
To:     Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220726130224.3987623-1-chenhuacai@loongson.cn>
 <c873f358-628a-72d9-42e3-5f40354745b1@xen0n.name>
 <221507a09870312d86193b96f680cdf4fa5742fc.camel@xry111.site>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <221507a09870312d86193b96f680cdf4fa5742fc.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2022/7/27 14:59, Xi Ruoyao wrote:
> On Tue, 2022-07-26 at 21:10 +0800, WANG Xuerui wrote:
>> On 2022/7/26 21:02, Huacai Chen wrote:
>>> Disable executable stack for LoongArch by default, as all modern
>>> architectures do.
>>
>> I don't know why this slipped in under everyone's eyes... Struggling
>> to
>> recall some of my mental activities during the initial review, I may
>> be
>> not too familiar with the code at that time (maybe still the case
>> now),
>> and didn't check what exactly "read_implies_exec" means in this
>> particular context. That could be just the reason for my part.
>>
>> But better mention the discussion leading to the discovery of this
>> bug:
>> "The problematic behavior was initially discovered by Andreas Schwab
>> in
>> a binutils discussion [1], fix suggested by WANG Xuerui" or something
>> along the line.
>>
>> [1]: https://sourceware.org/pipermail/binutils/2022-July/121992.html
> 
> I think we already have a "standard" format for this:
> 
> "Reported-by: Andreas Schwab <...>"
> "Suggested-by: Wang Xuerui <...>"
> "Url: https://sourceware.org/pipermail/binutils/2022-July/121992.html"

Hmm, I didn't find any occurrence of "Url:" but plenty of "Link:" in the 
kernel's commit history, so I agree the tag trio should sound even better...

> 
> Tested on my A2101 board and nothing is broken so far.
> 
> Tested-by: Xi Ruoyao <xry111@xry111.site>
> 
> 

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

