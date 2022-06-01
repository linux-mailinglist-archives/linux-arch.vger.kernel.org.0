Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8D253AB33
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 18:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356181AbiFAQoj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 12:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356180AbiFAQog (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 12:44:36 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17D89E9DA;
        Wed,  1 Jun 2022 09:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1654101870; bh=D86uvLtUnid4ac7RPV6LXcQ6KwoBx2mBLbHHxLqwrus=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rCSys+WSoaWiFQDm31CP75+HYXB6/F1uJSD8F2HZfW31dKUPSaK3hTAq2ub1Skgxq
         4F+g0b2xTlO92waMrhrZ/d/Zv2R5bQVlDwHuk33MfL+SrYXR0/2yCTLOVQJhNTjTcE
         UB+cQ/tIApWLxneHte7BXvPhqhkz3K4LQXZagY88=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 5D2C460104;
        Thu,  2 Jun 2022 00:44:30 +0800 (CST)
Message-ID: <47b559c0-b1e8-e800-0491-2431e2083dad@xen0n.name>
Date:   Thu, 2 Jun 2022 00:44:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:103.0) Gecko/20100101
 Thunderbird/103.0a1
Subject: Re: [musl] Re: [GIT PULL] asm-generic changes for 5.19
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        musl@lists.openwall.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
 <832c3ae8-6c68-db2c-2c7f-0a5cd3071543@xen0n.name>
 <CAK8P3a1Mg=Mr6aig25Kk9+Qf_E6DPMs0Yd-ozcvmY11kvCU74Q@mail.gmail.com>
 <CAMj1kXFijHBnQVPR=O85u78n6A1Ev_24k=vns4yPQ=d-aiAC8Q@mail.gmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAMj1kXFijHBnQVPR=O85u78n6A1Ev_24k=vns4yPQ=d-aiAC8Q@mail.gmail.com>
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

Hi Ard,

On 6/2/22 00:01, Ard Biesheuvel wrote:
> On Wed, 1 Jun 2022 at 09:41, Arnd Bergmann <arnd@kernel.org> wrote:
>> On Wed, Jun 1, 2022 at 7:52 AM WANG Xuerui <kernel@xen0n.name> wrote:
>>> On 6/1/22 00:01, Huacai Chen wrote:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-next
>>>> has been updated. Now this branch droped irqchip drivers and pci
>>>> drivers. But the existing irqchip drivers need some small adjustment
>>>> to avoid build errors [1], and I hope Marc can give an Acked-by.
>>>> Thanks.
>>>>
>>>> This branch can be built with defconfig and allmodconfig (except
>>>> drivers/platform/surface/aggregator/controller.c, because it requires
>>>> 8bit/16bit cmpxchg, which I was told to remove their support).
>>>>
>>>> [1] https://lore.kernel.org/lkml/e7cf33a170d0b4e98e53744f60dbf922@kernel.org/T/#t
>>> I see the loongarch-next HEAD has been updated and it's now purely arch
>>> changes aside from the two trivial irqchip cleanups. Some other changes
>>> to the v11 patchset [1] are included, but arguably minor enough to not
>>> invalidate previous Reviewed-by tags.
>> Very nice! I don't see exactly how the previous build bugs were addressed,
>> but I can confirm that this version builds. Regarding the two irqchip patches,
>> 621e7015b529 ("irqchip/loongson-liointc: Fix build error for LoongArch") is
>> a good way to work around the mips oddity, and I have no problem taking
>> that through the asm-generic tree. The other one, f54b4a166023 ("irqchip:
>>   Adjust Kconfig for Loongson"), looks mostly unnecessary, and I think only
>> the LOONGSON_HTPIC change should be included here, while I would
>> leave out the COMPILE_TEST changes and instead have the driver
>> changes take care of making it possible to keep building it on x86, possibly
>> doing
>>
>>          depends on MACH_LOONGSON64 || (COMPILE_TEST && ACPI)
>>
>> in the future, after the loongarch64 ACPI support is merged.
>>
>>> After some small tweaks:
>>>
>>> - adding "#include <asm/irqflags.h>" to arch/loongarch/include/asm/ptrace.h,
>>> - adding an arch/loongarch/include/uapi/asm/bpf_perf_event.h with the
>>> same content as arch/arm64's, and
>>> - adding "depends on ARM64 || X86" to
>>> drivers/platform/surface/aggregator/Kconfig,
>>>
>>> the current loongarch-next HEAD (commit
>>> 36552a24f70d21b7d63d9ef490561dbdc13798d7) now passes allmodconfig build
>>> (with CONFIG_WERROR disabled; my Gentoo-flavored gcc-12 seems to emit
>>> warnings on a few drivers).
>> The only one of these issues that I see is the surface aggregator one.
>> I think we can address all three as follow-up fixes after -rc1 if the port
>> gets merged and these are still required.
>>
>>> The majority of userspace ABI has been stable for a few months already,
>>> after the addition of orig_a0 and removal of newfstatat; the necessary
>>> changes to switch to statx are already reviewed [2] / merged [3], and
>>> have been integrated into the LoongArch port of Gentoo for a while. Eric
>>> looked at the v11 and gave comments, and changes were made according to
>>> the suggestions, but it'd probably better to get a proper Reviewed-by.
>> Right.
>>
>>> Among the rest of patches, I think maybe the EFI/boot protocol part
>>> still need approval/ack from the EFI maintainer. However because the
>>> current port isn't going to be able to run on any real hardware, maybe
>>> that part could be done later; I'm not sure if the unacknowledged EFI
>>> bits should be removed as well.
>> Ard, do you have any last comments on this?
>>
> It would be nice if the questions I raised against the previous
> revision (v11) were addressed (or at least answered) first. In
> general, I think this is feeling a bit rushed and IMHO we should
> probably defer this to the next cycle.

Actually I think Huacai did reply to your review on v11: 
https://lore.kernel.org/all/CAAhV-H7KAg8RxN7M=WiOOh0fDhEKTyqrwp6V-SC0cyR0iMrdeg@mail.gmail.com/. 
It's a bit unfortunate that he probably didn't justify some of the 
approaches enough, and it's especially unfortunate that some of the 
points (like maybe the kernel version string in the EFI stub header) are 
result of their internal discussion, which I presume to be especially 
hard to change due to their particularly worrying corporate dynamics...

But again, my point is that the userspace ABI in particular is *not* 
rushed -- it has been brewing since v1 of the port which is already 
several months ago, and multiple distro-building efforts are already 
underway. We (LoongArch distro packagers) want to freeze the userspace 
ABI so that many downstream efforts wouldn't be blocked by the merging 
of kernel port.

As the boot protocol is technically not part of the userspace ABI that 
toolchains care about, and we already know it'll be a rather 
standards-compliant UEFI implementation even if this part gets dropped 
for brewing one more cycle, would taking this part out work for you?

