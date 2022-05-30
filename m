Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4661A538539
	for <lists+linux-arch@lfdr.de>; Mon, 30 May 2022 17:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241673AbiE3Pr3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 May 2022 11:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242366AbiE3PrL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 May 2022 11:47:11 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C72222A18;
        Mon, 30 May 2022 08:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1653922822; bh=s1QiOz9wspSFr3MKcctc4iYPmhaFi0B1Ir77QXPhGkQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XfTYcoObJmrg/JDjGJc1MTn8iRm6p9KRmLhJGb19BxuVDXKKtNE0cQ2gWHsF9L+p0
         dIpeX7wWK2a9S4ui6qfeVUc2FQZiqJyJIw5ZbLpSGeapzW6+8zzFTniivYOrQZqCSp
         2f7dkspWYhoyPbx9PLNCS+9mqHuvG4xR3MX9aq/M=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id EB8A86011F;
        Mon, 30 May 2022 23:00:21 +0800 (CST)
Message-ID: <358025d1-28e6-708b-d23d-3f22ae12a800@xen0n.name>
Date:   Mon, 30 May 2022 23:00:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0a1
Subject: Re: [GIT PULL] asm-generic changes for 5.19
To:     Huacai Chen <chenhuacai@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        libc-alpha@sourceware.org,
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
        Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <CAK8P3a2_52JPnBWNvTTkFVwLxPAa7=NaQ4whwC1UeH_NYHeUKQ@mail.gmail.com>
 <CAK8P3a0SpU1n+29KQxzKnPRvzmDE=L0V9RUpKxhemv=74kevcQ@mail.gmail.com>
 <df5c406c-eec6-c340-2847-49670b7fe8bf@xen0n.name>
 <CAK8P3a3awFdB1-G65DC38NBuSTvo6SvFTaS0m9YBxunHjHjQvQ@mail.gmail.com>
 <CAAhV-H6sNr-yo8brBFtzziH6k9Tby0dFp7yehK55SfH5HjZ8hQ@mail.gmail.com>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H6sNr-yo8brBFtzziH6k9Tby0dFp7yehK55SfH5HjZ8hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/30/22 21:01, Huacai Chen wrote:
> Hi, Arnd,
>
> On Mon, May 30, 2022 at 4:21 PM Arnd Bergmann <arnd@kernel.org> wrote:
>> On Sun, May 29, 2022 at 3:10 PM WANG Xuerui <kernel@xen0n.name> wrote:
>>> But what for the users and downstream projects? Do the users owning
>>> LoongArch hardware (me included) and projects/companies porting their
>>> offerings have to pay for Loongson's mistakes and wait another [2mo,
>>> 1yr], "ideally" also missing the glibc 2.36 release too?
>> ...
>>> Lastly, I'd like to clarify, that this is by no means a
>>> passive-aggressive statement to make the community look like "the bad
>>> guy", or to make Loongson "look bad"; I just intend to provide a
>>> hopefully fresh perspective from a/an {end user, hobbyist kernel
>>> developer, distro developer, native Chinese speaker with a hopefully
>>> decent grasp of English}'s view.
>> Your feedback has been extremely valuable, as always. I definitely
>> don't want to hold up merging the port for the glibc-2.36 release. If
>> that is a risk, and if merging the architecture port without the drivers
>> helps with that, I agree we should just do that. This will also help
>> with build testing and any treewide changes that are going to be
>> done on top of v5.19-rc1.
>>
>> For the continuous maintenance, would you be available as an
>> additional Reviewer or co-maintainer to be listed in the maintainers
>> file? I think in general it is a good idea to have at least one maintainer
>> that is not directly part of the organization that owns the product,
>> and you are clearly the best person outside of loongson technology
>> for this.
> Yes, Xuerui is very suitable as a Reviewer.

Thanks for the recognition from both of you; it is my honor and pleasure 
to contribute to the LoongArch port and to Linux in general.

As I'm still not entirely satisfied with my kernel development skills, 
plus my day job is not kernel-related nor Loongson/LoongArch-related at 
all, listing me as reviewer should be enough for now. I will take care 
of the arch as long as I have the hardware.

BTW, there were already several breakages when rebasing the previous 
revision (I believe it's commit 215da6d2dac0 ("MAINTAINERS: Add 
maintainer information for LoongArch")) on top of linus' tree. Now I see 
the loongarch-next HEAD is already rebased on top of what I believe to 
be the current main branch, however I vaguely remember that it's not 
good to base one's patches on top of "some random commit", so I wonder 
whether the current branch state is appropriate for a PR?

