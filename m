Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC323539CE3
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 08:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349793AbiFAGDT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 02:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243177AbiFAGDT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 02:03:19 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C4864D0D;
        Tue, 31 May 2022 23:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1654062778; bh=+SQ/0eJGKRfUjrv0y7MBl6u9+aie9yNgtn9zXiJXatQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MPrVk57osmnSJSH8usd6C0hOYOQnqvMfimKla8SPTKb1b3p7S7z4TV3QbmJvgi8wz
         QvqDrG+EPygWMfJumqmcMARAyrD4yUYS9QesvYMzOhDspws14XkxFR1mG0+D9SYk4H
         PbOG71wY9849hZUFfXVpJ1HsxE8Qs6miB8t2TYJA=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 9FFC260104;
        Wed,  1 Jun 2022 13:52:57 +0800 (CST)
Message-ID: <832c3ae8-6c68-db2c-2c7f-0a5cd3071543@xen0n.name>
Date:   Wed, 1 Jun 2022 13:52:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:103.0) Gecko/20100101
 Thunderbird/103.0a1
Subject: Re: [musl] Re: [GIT PULL] asm-generic changes for 5.19
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     musl@lists.openwall.com, WANG Xuerui <kernel@xen0n.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        linux-pci <linux-pci@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <CAK8P3a2_52JPnBWNvTTkFVwLxPAa7=NaQ4whwC1UeH_NYHeUKQ@mail.gmail.com>
 <CAK8P3a0SpU1n+29KQxzKnPRvzmDE=L0V9RUpKxhemv=74kevcQ@mail.gmail.com>
 <df5c406c-eec6-c340-2847-49670b7fe8bf@xen0n.name>
 <CAK8P3a3awFdB1-G65DC38NBuSTvo6SvFTaS0m9YBxunHjHjQvQ@mail.gmail.com>
 <CAAhV-H6sNr-yo8brBFtzziH6k9Tby0dFp7yehK55SfH5HjZ8hQ@mail.gmail.com>
 <358025d1-28e6-708b-d23d-3f22ae12a800@xen0n.name>
 <CAK8P3a1ge2bZS13ahm_LdO3jEcbtR4w3do-gLjggKvppqnBDkw@mail.gmail.com>
 <CAAhV-H5NCUpR6aBtR9d7c9vW2KiHpk3iFQxj7BeTSS0boMz8PQ@mail.gmail.com>
 <CAK8P3a2JgrW5a7_udCUWen-gOnJgVeRV2oAd-uq4VSuYkFUqNQ@mail.gmail.com>
 <CAAhV-H6wfmdcV=a4L43dcabsvO+JbOebCX3_6PV+p85NjA9qhQ@mail.gmail.com>
 <CAK8P3a0c_tbHov_b6cz-_Tj6VD3OWLwpGJf_2rj-nitipSKdYQ@mail.gmail.com>
 <CAAhV-H4_qqQtTp2=mJF=OV+qcKzA0j8SPWKRMR-LJgC0zNfatQ@mail.gmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H4_qqQtTp2=mJF=OV+qcKzA0j8SPWKRMR-LJgC0zNfatQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/1/22 00:01, Huacai Chen wrote:
> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-next
> has been updated. Now this branch droped irqchip drivers and pci
> drivers. But the existing irqchip drivers need some small adjustment
> to avoid build errors [1], and I hope Marc can give an Acked-by.
> Thanks.
>
> This branch can be built with defconfig and allmodconfig (except
> drivers/platform/surface/aggregator/controller.c, because it requires
> 8bit/16bit cmpxchg, which I was told to remove their support).
>
> [1] https://lore.kernel.org/lkml/e7cf33a170d0b4e98e53744f60dbf922@kernel.org/T/#t

I see the loongarch-next HEAD has been updated and it's now purely arch 
changes aside from the two trivial irqchip cleanups. Some other changes 
to the v11 patchset [1] are included, but arguably minor enough to not 
invalidate previous Reviewed-by tags.

After some small tweaks:

- adding "#include <asm/irqflags.h>" to arch/loongarch/include/asm/ptrace.h,
- adding an arch/loongarch/include/uapi/asm/bpf_perf_event.h with the 
same content as arch/arm64's, and
- adding "depends on ARM64 || X86" to 
drivers/platform/surface/aggregator/Kconfig,

the current loongarch-next HEAD (commit 
36552a24f70d21b7d63d9ef490561dbdc13798d7) now passes allmodconfig build 
(with CONFIG_WERROR disabled; my Gentoo-flavored gcc-12 seems to emit 
warnings on a few drivers).

The majority of userspace ABI has been stable for a few months already, 
after the addition of orig_a0 and removal of newfstatat; the necessary 
changes to switch to statx are already reviewed [2] / merged [3], and 
have been integrated into the LoongArch port of Gentoo for a while. Eric 
looked at the v11 and gave comments, and changes were made according to 
the suggestions, but it'd probably better to get a proper Reviewed-by.

Among the rest of patches, I think maybe the EFI/boot protocol part 
still need approval/ack from the EFI maintainer. However because the 
current port isn't going to be able to run on any real hardware, maybe 
that part could be done later; I'm not sure if the unacknowledged EFI 
bits should be removed as well.

Arnd, what do you think about the current branch's status? Do Huacai 
need to send a quick final v12 to gather tags?


[1]: 
https://lore.kernel.org/all/20220518092619.1269111-1-chenhuacai@loongson.cn/
[2]: https://sourceware.org/pipermail/libc-alpha/2022-May/139127.html
[3]: https://go-review.googlesource.com/c/go/+/407694

