Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2E3539AAD
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 03:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344508AbiFABOG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 May 2022 21:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240650AbiFABOG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 May 2022 21:14:06 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4669795A18;
        Tue, 31 May 2022 18:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1654046039; bh=pMq9NS9OSPMIUB60xzKZhXnr5K83nxwQ8BT9E2zyna8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IUcZH4S0FgPYhAx2CZ5cPrcna6qZkVxpbP32f4XEImxLpPADWip7X9LJ8dDjXwi9Y
         gkPH7D3zlvQuVPlKaicnTInLT3w4VG2NHPEtkQFFKfxq5U+JP0FEx4/5V+icuOjiWM
         ekOBReg5J/qWSZPuVDlqu9VGeGrroQXf3lf9VR+M=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 90345600FF;
        Wed,  1 Jun 2022 09:13:58 +0800 (CST)
Message-ID: <cbe2d050-5b28-f913-9f3b-8ddabe861eae@xen0n.name>
Date:   Wed, 1 Jun 2022 09:13:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:103.0) Gecko/20100101
 Thunderbird/103.0a1
Subject: Re: [musl] Re: [GIT PULL] asm-generic changes for 5.19
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>
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
 <CAK8P3a3UfDJkoAkA6an2kXyAYSzz2vt__19JoQmum8LZehXrgg@mail.gmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAK8P3a3UfDJkoAkA6an2kXyAYSzz2vt__19JoQmum8LZehXrgg@mail.gmail.com>
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

On 6/1/22 04:07, Arnd Bergmann wrote:
> On Tue, May 31, 2022 at 6:01 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>> On Tue, May 31, 2022 at 7:15 PM Arnd Bergmann <arnd@kernel.org> wrote:
>>> On Tue, May 31, 2022 at 10:17 AM Huacai Chen <chenhuacai@kernel.org> wrote:
>> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-next
>> has been updated. Now this branch droped irqchip drivers and pci
>> drivers. But the existing irqchip drivers need some small adjustment
>> to avoid build errors [1], and I hope Marc can give an Acked-by.
> Ok, glad you got that working.
>
>   What about the ACPI changes? I see that these are needed to get a clean build,
> and as I understood it, they are supposed to get merged through the
> acpica tree.

I think the acpica bits could be dropped with some effort too; the main 
dependency on the various ACPI 6.5 tables are the SMP bits, which relies 
on the new MADT CPUINTC tables. While the others also provide 
information, they're not as fundamental as this, and even this CPUINTC 
piece can be taken out given we can't run this branch on any real 
LoongArch hardware after all (due to the irqchip changes being backed 
out), I think we can just leave the remaining bits dummy-initialized 
with some simple comment. We can review once the new branch with only 
arch/loongarch changes is out.

>> This branch can be built with defconfig and allmodconfig (except
>> drivers/platform/surface/aggregator/controller.c, because it requires
>> 8bit/16bit cmpxchg, which I was told to remove their support).
> Right, that is ok to keep in there, we should fix that by adding a Kconfig
> dependency for the driver. It looks like it has a CONFIG_ACPI dependency,
> so it is currently limited to x86/arm64/ia64, which all have the short
> cmpxchg(),
> but in reality this driver can only work on x86 and arm64.

In case this isn't obvious to any non-native English speaker: the driver 
is written for the Microsoft Surface, which only has x86 and arm64 
variants to this date and the list is probably not going to expand in 
the foreseeable future, so the word "work" here takes a quite literal 
sense. ;-)

I agree a tiny fix for that driver could be added later that limits the 
driver to X86 || ARM64. As a popular product line, adding support for 
yet another architecture would be a news visible enough for the crowd 
that they'll come and tweak the Kconfig themselves.

