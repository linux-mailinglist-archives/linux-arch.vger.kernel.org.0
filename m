Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337F96AB495
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 03:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCFCSm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Mar 2023 21:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjCFCSm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 21:18:42 -0500
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD66CA02;
        Sun,  5 Mar 2023 18:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1678069116; bh=ZHnW+A+s3D7t9NyDHWLNv5AKl7GYJwEEJGQPmuQN+TM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LCrc16B+oLgMfDF07fT2jeraC0azAnESHc2hlMFFHEFEBjuJ3LWGtcqzNhYS29XuE
         dOXw4fW3iiPqwcjbzFy2XLUKALVmq6M4My1dDLgj/wd2xu8gjqS9/c/gzBGnqg0ncb
         SvkDNVr91Jkcky1gUgKef5CSaAq334D8RAbXJ3jQ=
Received: from [100.100.57.122] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 00029600BD;
        Mon,  6 Mar 2023 10:18:35 +0800 (CST)
Message-ID: <65d890c8-9c37-070c-f5c6-db26ab8cfe54@xen0n.name>
Date:   Mon, 6 Mar 2023 10:18:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] LoongArch: Provide kernel fpu functions
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>, Xi Ruoyao <xry111@xry111.site>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
References: <20230305052818.4030447-1-chenhuacai@loongson.cn>
 <48f508aa-ab40-7032-a68d-90d8986afb2f@xen0n.name>
 <CAAhV-H55QUrkYYR1Lbj=zbquiz3frX2dNAH23fAuN6eCOUddNA@mail.gmail.com>
 <58cc7e6d19628757d6d8dc192d07876288f6077e.camel@xry111.site>
 <CAAhV-H7vv+AE-7kDf7YpU6_f_dTNxKKoRSHC6vA4aBHOVyMRAQ@mail.gmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H7vv+AE-7kDf7YpU6_f_dTNxKKoRSHC6vA4aBHOVyMRAQ@mail.gmail.com>
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

On 2023/3/6 09:55, Huacai Chen wrote:
> On Sun, Mar 5, 2023 at 9:28 PM Xi Ruoyao <xry111@xry111.site> wrote:
>>
>> On Sun, 2023-03-05 at 20:18 +0800, Huacai Chen wrote:
>>>> Might be good to provide some explanation in the commit message as to
>>>> why the pair of helpers should be GPL-only. Do they touch state buried
>>>> deep enough to make any downstream user a "derivative work"? Or are the
>>>> annotation inspired by arch/x86?
>>> Yes, just inspired by arch/x86, and I don't think these symbols should
>>> be used by non-GPL modules.
>>
>> Hmm, what if one of your partners wish to provide a proprietary GPU
>> driver using the FPU like this way?  As a FLOSS developer I'd say "don't
>> do that, make your driver GPL".  But for Loongson there may be a
>> commercial issue.
> So use EXPORT_SYMBOL can make life easier?

As I've detailed in my first reply, every arch other than x86 exposes 
this functionality without the GPL-only restriction. Although IMO 
non-GPL driver developers wouldn't grieve over this particular feature 
simply because pretty much everyone would have to build on x86 and that 
arch wouldn't have it exposed, I do think it will be more demanded on 
loongarch, where HW performance is in general lower than x86/arm64 
offerings at similar cost levels, so perhaps people would have to resort 
to FP/SIMD tricks to reach performance on par with others.

Also, if the old world is taken into consideration (which we normally 
have the luxury of not having to do so), consider Ruoyao's case where a 
commercial partner of Loongson wants to do this with the vendor kernel, 
but the symbols are exported GPL -- in this case I doubt the GPL marking 
will remain, thus creating inconsistency between upstream and vendor 
kernels, and community distros are going to complain loudly about the 
need to patch things. It's probably best to avoid all of this upfront.

Note that this is all suggestion though, it's down to you and your team 
to decide after all. And I've not done the archaeology about the other 
arches' choice yet, which may or may not reveal more reasoning behind 
their status quo.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

