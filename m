Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A386B596A
	for <lists+linux-arch@lfdr.de>; Sat, 11 Mar 2023 09:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCKIK4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Mar 2023 03:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCKIKz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Mar 2023 03:10:55 -0500
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1BC13EB8A;
        Sat, 11 Mar 2023 00:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1678522246; bh=+dkM0nzzv60Hr+kG9MKvNn/VBv9os22kziC0//E149g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lGATb0eS1zajslAEO/M8EmJIcDtNBAH4qxOMV7DLmk/LOoywobDWduyih4Hs/Mtkh
         aMOyQPb7e7d0uVGcGJJlQan1KdBdMzax/OMSSo64HkO8bp81zOl7/WWq7yNerkgf2a
         FF2s5PbG50l3MikKSRjAfvwExn4YZ39XdqA+rjig=
Received: from [192.168.9.172] (unknown [101.228.138.55])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 3458F6011B;
        Sat, 11 Mar 2023 16:10:46 +0800 (CST)
Message-ID: <428e2df8-d5b7-a200-62c2-59497f3facea@xen0n.name>
Date:   Sat, 11 Mar 2023 16:10:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2] LoongArch: Provide kernel fpu functions
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
References: <20230306031258.99230-1-chenhuacai@loongson.cn>
 <ZAoNPuyHQTqucYxn@infradead.org>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <ZAoNPuyHQTqucYxn@infradead.org>
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

On 3/10/23 00:45, Christoph Hellwig wrote:
> NAK, this needs to be an EXPORT_SYMBOL_GPL.
>
> Also no way we're going to merge this without an actual user.

Okay so I sat down for some Saturday afternoon archaeology, and this is 
indeed much hairier than I originally thought...

Basically the same conversation has happened back in 2019 [1][2][3], 
mainly over the breakage it caused for zfs (obviously non-GPL and 
out-of-tree, that apparently made people automatically ignore it), while 
the introducing commit d63e79b114c02 ("x86/fpu: Uninline 
kernel_fpu_begin()/end()") went in unnoticed at that time [4]. It's 
clear that my opinion fell under the same camp as Andy and Paolo 
("exporting as GPL" means "any usage of this symbol implies the module 
is in fact derived work"), but the others disagreed ("in practice we 
don't care if it has no in-kernel users, and even if it does it would 
have to be GPL anyway", IIUC).

For now I've only been tinkering with Navi GPUs on loongarch, and 
haven't got to try openzfs yet, but I surely don't want to start the 
debate all over again, and making the loongarch FPU helpers GPL-only 
works for me. However there's probably another question that Ruoyao 
pointed out: do we want to mark the neon/altivec/s390x helpers GPL-only 
right away? IMO this particular feature is not inherently arch-specific 
(the same would have to happen for every arch with optionally enabled 
extra state and instructions, not limited to FPU actually) so 
availability of such feature should preferably be made symmetric over 
arches.

Given the topic's sensitive nature I'd want to hear from more people 
before deciding to (not) write the patches; thanks in advance.

[1]: 
https://lore.kernel.org/all/761345df6285930339aced868ebf8ec459091383.1556807897.git.luto@kernel.org/
[2]: https://lore.kernel.org/all/20190522044204.24207-1-cyphar@cyphar.com/
[3]: 
https://lore.kernel.org/all/CAB9dFdsZb-sZixeOzrt8F50h1pnUK2W2Cxx8+xjhgd0=6xs7iw@mail.gmail.com/T/#u
[4]: 
https://lore.kernel.org/all/1430848300-27877-51-git-send-email-mingo@kernel.org/

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

