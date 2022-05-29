Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E01753710D
	for <lists+linux-arch@lfdr.de>; Sun, 29 May 2022 15:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiE2NKZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 29 May 2022 09:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiE2NKY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 29 May 2022 09:10:24 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2984473AD;
        Sun, 29 May 2022 06:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1653829817; bh=Vln6eNWYIfvW2Az5WqaEcClnua9NiMj8Cj2U84HgAQ8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MGN1TmmG44Q8vaIJdKyrOr4MeU3HYHUWQc+FUSKfMYU9JPwIBuLT3ku3DWAnZ056X
         jkyMK0rt/JA5MXVBGq5TVrZJYp40BsPWDSkWADjqbtAlanZ66fAUPS6WQtIO98Rzku
         g5U6JAB/fSeO4JF/J6kygWJdkED/hwtSKJnLxpec=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 39C0A60074;
        Sun, 29 May 2022 21:10:17 +0800 (CST)
Message-ID: <df5c406c-eec6-c340-2847-49670b7fe8bf@xen0n.name>
Date:   Sun, 29 May 2022 21:10:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0a1
Subject: Re: [GIT PULL] asm-generic changes for 5.19
To:     Arnd Bergmann <arnd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, Marc Zyngier <maz@kernel.org>,
        libc-alpha@sourceware.org, musl@lists.openwall.com,
        ardb@kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <CAK8P3a2_52JPnBWNvTTkFVwLxPAa7=NaQ4whwC1UeH_NYHeUKQ@mail.gmail.com>
 <CAK8P3a0SpU1n+29KQxzKnPRvzmDE=L0V9RUpKxhemv=74kevcQ@mail.gmail.com>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAK8P3a0SpU1n+29KQxzKnPRvzmDE=L0V9RUpKxhemv=74kevcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/29/22 19:24, Arnd Bergmann wrote:
> On Thu, May 26, 2022 at 5:00 PM Arnd Bergmann <arnd@kernel.org> wrote:
>> - A series to add a generic ticket spinlock that can be shared by most
>>    architectures with a working cmpxchg or ll/sc type atomic, including
>>    the conversion of riscv, csky and openrisc. This series is also a
>>    prerequisite for the loongarch64 architecture port that will come as
>>    a separate pull request.
> An update on Loongarch: I was originally planning to  send Linus a
> pull request with
> the branch with the contents from
>
> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-next
>
> but I saw that this includes both the architecture code and some
> device drivers (irqchip,
> pci, acpi) that are essential for the kernel to actually boot. At
> least the irqchip driver
> has not passed review because it uses a nonstandard way to integrate into ACPI,
> and the PCI stuff may or may not be ready but has no Reviewed-by or
> Acked-by tags
> from the maintainers. I clearly don't want to bypass the subsystem
> maintainers on
> those drivers by sending a pull request for the current branch.
>
> My feeling is that there is also no point in merging a port without
> the drivers as it cannot
> work on any hardware. On the other hand, the libc submissions (glibc
> and musl) are
> currently blocked while they are waiting for the kernel port to get merged.

(CC-ing Jianmin Lv as he is apparently the person responsible for the 
majority of irqchip changes, which are arguably the center of the whole 
controversy; and Jiaxun Yang, author of the original Loongson MIPS IRQ 
scheme, carried over to the LoongArch era.)

Just my two cents, sorry for the wall of text following:

It's unfortunate the irqchip situation evolved to eventually block 
merging of the whole port altogether, especially the kernel ABI; but I'd 
like to point out that *the ship has already sailed*, regarding the move 
to fully dynamic IRQ topology probing.

IIUC, the necessary ACPI spec changes were already accepted even before 
the first revision of the port, back in late 2021; while I don't know if 
there's time for the responsible Loongson team to listen and amend the 
spec draft before the freeze, the end result is no change, and I was 
told that the ACPI 6.5 release is imminent (around early June). As 
everyone can see from the code, it's simply not possible to express 
fully dynamic associations between the interrupt controllers, the 
necessary reference fields for describing arbitrary graph edges are 
simply not there.

The responsible Loongson team could be hard-pressed to revise their 
tables and make it more IORT-like so as to satisfy the subsystem 
maintainer's requirement, but it'll be at least 1 year before the fixed 
ACPI 6.6 is out, and there will already be loads of boards featuring the 
fixed-topology ACPI 6.5 tables, which we have to support for a while anyway.

Yes, the Loongson teams could be (or most probably, are already) 
punished for their uncooperative attitude towards upstream reviews, by 
letting them miss the 5.19 window; the open-source community in general 
is *not* going to bend rules only for some random people's KPI and the 
kernel community is famously no exception. Reviewers always give 
suggestions out of their goodwill and previous experience, and I believe 
in this case it must be the case too; it's Loongson's fault to 
repeatedly ignore the comments after all, no matter due to ignorance, or 
language barrier (looking at the conversations, it's painfully clear to 
a native Chinese speaker that many chances to resolve 
confusion/misunderstanding have been wasted), and missing 5.19 is 
precisely that hard lesson for them.

But what for the users and downstream projects? Do the users owning 
LoongArch hardware (me included) and projects/companies porting their 
offerings have to pay for Loongson's mistakes and wait another [2mo, 
1yr], "ideally" also missing the glibc 2.36 release too?

So, being an affected end user and a distro developer, I suggest that we 
be pragmatic, and try to review the irqchip code in its current form, in 
hopes of making it into this merge window. The more elegant alternative 
is already impossible in the context of ACPI 6.5, and the current code 
is going to get in eventually anyway, unless we're ready to declare the 
ACPI 6.5 LoongArch systems deprecated and unsupported from day one, due 
to some Loongson dev being unreasonably stubborn and rejecting upstream 
reviews. In return, the Loongson devs should really lower their ego and 
consider the maintainer's advice, and ensure things are sorted out in 
ACPI 6.6; the experience behind the comment simply cannot be ignored for 
any reason.

At the very least, we should give out a clear signal for downstream 
projects, that the userspace ABI of the port can already be considered 
stable, so they could somehow move forward even if the port is not going 
to appear in 5.19. (Semi-selfishly speaking, it's arguably preferable to 
work especially hard for inclusion in 5.19, because otherwise we would 
likely miss the glibc 2.36 release, which means another 6mo of carrying 
patches downstream, and widespream patching of glibc symbol versions 
once the glibc port is changed to target 2.37 instead. It's really hard 
to teach end users to migrate such low-level thing.)

Lastly, I'd like to clarify, that this is by no means a 
passive-aggressive statement to make the community look like "the bad 
guy", or to make Loongson "look bad"; I just intend to provide a 
hopefully fresh perspective from a/an {end user, hobbyist kernel 
developer, distro developer, native Chinese speaker with a hopefully 
decent grasp of English}'s view.


And thanks for your patience,

WANG Xuerui

