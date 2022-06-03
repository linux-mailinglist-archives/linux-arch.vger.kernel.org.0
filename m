Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD87153C748
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 11:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242959AbiFCJOP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jun 2022 05:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241874AbiFCJOO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2022 05:14:14 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A30820BF7;
        Fri,  3 Jun 2022 02:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1654247646; bh=m1vnCsg0kMjXGWID0KuuTcJ4qjSL9FogZi8jOVhcybo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jQIYMDszzAqjFNSsOu9jYkVh+3QNGGnyjHPOYwAedAeIJV2baKTsZArIEw1xqOvIY
         557sJRLYIFdJ/PkYzr0icbnOpWV+d2oTOLTmcQLVuI5i3dwsjrm2DIqAak8E17/Msu
         QDdGtmG5Q/gU3+Lkpz8ZwwUSDCVFYMSF/Yi/WW6U=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 37EBF60104;
        Fri,  3 Jun 2022 17:14:06 +0800 (CST)
Message-ID: <e3af6993-bbd5-9ce6-07e8-3c180833db75@xen0n.name>
Date:   Fri, 3 Jun 2022 17:14:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:103.0) Gecko/20100101
 Thunderbird/103.0a1
Subject: Re: [PATCH V15 00/24] arch: Add basic LoongArch support
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
References: <20220603072053.35005-1-chenhuacai@loongson.cn>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220603072053.35005-1-chenhuacai@loongson.cn>
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

On 6/3/22 15:20, Huacai Chen wrote:
> V13 -> V14:
> 1, Add some missing Cc;
> 2, Add a comment for EFI_RT_VIRTUAL_LIMIT definition.
>
> V14 -> V15:
> 1, Remove EFISTUB for now, since the design detail need further discussion.

Thanks for the quick followup revision!

So I've pulled the latest loongarch-next HEAD (commit 
fb575e32bdd27d57b1587227abea8d4ea2eccb71), and did allmodconfig builds 
of ARCH={x86,mips,loongarch}. I used the LoongArch cross-toolchain 
compiled by Arnd and my own Gentoo toolchains (native & crossdev) for 
x86 and mips; no new problem is found.

Diff between this revision and the previous revision I tested (I think 
it's v13) is just removal of the non-reviewed architecture-independent 
EFI changes, which is good, and I believe we now have every commit here 
ready for PR. (In theory, Eric didn't respond to my previous mail to 
approve the signal.h UAPI, but I can confirm that his concerns are fully 
addressed, which involved spelling suggestion and prefixes to the type 
names.)

On the v14 thread, Bagas suggested that the ASCII art in the 
documentation in single-cell table form be replaced with ordinary code 
blocks, which I think is reasonable due to consistency; but we already 
got 2 revisions of this patchset today, and each revision adds 25 mails 
to everyone's inbox, so I think Huacai could just apply the changes, 
collect the Tested-by, and just push to the loongarch-next branch 
instead (and replying here of course).

So, Arnd, do you think we can go ahead and send the PR today or 
tomorrow? I know this batch of modification didn't get included in 
today's linux-next, but there's little substantive change, and Stephen 
didn't mention that there will be no linux-next tomorrow, so the timing 
might still work out. We may want to get the final Acked-by from Ard for 
the now stripped-down Patch 11, though, I'm not entirely sure.

