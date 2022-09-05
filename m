Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2128E5AD8D2
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 20:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiIESIC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 14:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiIESH7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 14:07:59 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5705061717;
        Mon,  5 Sep 2022 11:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1662401271; bh=5+fBIDj/plLFKdhPodt2PuIY5OBgWlvoqpWtbGLNoXM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=puIOOBlNKkdEH2NfqMZ6Dv+IlrIPGhmqaDgp7h/qM2meKfWQ7SIwqeYUkn6dYgczL
         Q/Iv3vTQglESUW6b+rP5yhnh5leHyveimiFrvxIFlRbpSEDFd6iih6c11OjY3WYVu3
         iILqoc9d48XIgD/SbgOagG4+sAU36CsE9BVH2uJ8=
Received: from [192.168.9.172] (unknown [101.88.26.24])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id C40CA6006F;
        Tue,  6 Sep 2022 02:07:50 +0800 (CST)
Message-ID: <3591e532-a6ed-01f1-88fc-77b8637abced@xen0n.name>
Date:   Tue, 6 Sep 2022 02:07:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:106.0) Gecko/20100101
 Thunderbird/106.0a1
Subject: Re: [PATCH V3] LoongArch: Add efistub booting support
To:     Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220819102037.2697798-1-chenhuacai@loongson.cn>
 <9b6f0aeaebbd36882b5b40d655f9ccd20c7be496.camel@xry111.site>
 <CAMj1kXFOd+gMHbi6MH0KHWkBEKN9V0LeZbyGRw8h630OxtMrdA@mail.gmail.com>
 <CAAhV-H6MR=rWhecY_uuiXAysED-BBJhKhGHj2cCkefJiPOo-ZQ@mail.gmail.com>
 <CAAhV-H4KXVUBgNoQxOFiEj2AH-ojhnrEJ8QLvNrALY69MhXF3w@mail.gmail.com>
 <CAMj1kXHJv_6mLhMikg+ic7=EUABLdrX3f__eBbHntrpGHjRfXg@mail.gmail.com>
 <CAAhV-H4WTCRU9qShDp57AZ2DG1uz+=GTz14zyAUaqVDjXrNABA@mail.gmail.com>
 <CAMj1kXFRsEJOS2Kim8T64rYF85_bmmZ5gW7kjb8eDXry5SA+cg@mail.gmail.com>
 <CAAhV-H4xDB6JPCEZqQ6+VadOPnzA3beguiuTRS-Ub=Ci5FgpPw@mail.gmail.com>
 <CAMj1kXEPpCPHe8ghOKcaGvuLjetP9WJbrMkLcqv_V+oRWeyLmw@mail.gmail.com>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAMj1kXEPpCPHe8ghOKcaGvuLjetP9WJbrMkLcqv_V+oRWeyLmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/5/22 15:28, Ard Biesheuvel wrote:
> [snip]
>>>>>> And I have some other questions about kexec: kexec should jump to the
>>>>>> elf entry or the pe entry? I think is the elf entry, because if we
>>>>>> jump to the pe entry, then SVAM will be executed twice (but it should
>>>>>> be executed only once). However, how can we jump to the elf entry if
>>>>>> we use zboot? Maybe it is kexec-tool's responsibility to decompress
>>>>>> the zboot kernel image?
>>>>>>
>>>>> Yes, very good point. Kexec kernels cannot boot via the EFI entry
>>>>> point, as the boot services will already be shutdown. So the kexec
>>>>> kernel needs to boot via the same entrypoint in the core kernel that
>>>>> the EFI stub calls when it hands over.
>>>>>
>>>>> For the EFI zboot image in particular, we will need to teach kexec how
>>>>> to decompress them. The zboot image has a header that
>>>>> a) describes it as a EFI linux zimg
>>>>> b) describes the start and end offset of the compressed payload
>>>>> c) describes which compression algorithm was used.
>>>>>
>>>>> This means that any non-EFI loader (including kexec) should be able to
>>>>> extract the inner PE/COFF image and decompress it. For arm64 and
>>>>> RISC-V, this is sufficient as the EFI and raw images are the same. For
>>>>> LoongArch, I suppose it means we need a way to enter the core kernel
>>>>> directly via the entrypoint that the EFI stub uses when handing over
>>>>> (and pass the original DT argument so the kexec kernel has access to
>>>>> the EFI and ACPI firmware tables)
>>>> OK, then is this implementation [1] acceptable? I remember that you
>>>> said the MS-DOS header shouldn't contain other information, so I guess
>>>> this is unacceptable?
>>>>
>>> No, this looks reasonable to me. I objected to using magic numbers in
>>> the 'pure PE' view of the image, as it does not make sense for a pure
>>> PE loader such as GRUB to rely on such metadata.
>>>
>>> In this case (like on arm64), we are dealing with something else: we
>>> need to identify the image to the kernel itself, and here, using the
>>> unused space in the MS-DOS header is fine.
>>>
>>>> [1] https://lore.kernel.org/loongarch/c4dbb14a-5580-1e47-3d15-5d2079e88404@loongson.cn/T/#mb8c1dc44f7fa2d3ef638877f0cd3f958f0be96ad
>> OK, then there is no big problem here. And I found that arm64/riscv
>> don't need the kernel entry point in the header. I don't know why, but
>> I think it implies that a unified layout across architectures is
>> unnecessary, and I prefer to put the kernel entry point before
>> effective kernel size. :)
>>
> It is fine to put the entry point offset in the header. arm64 and
> RISC-V don't need this because the first instructions are a pseudo-NOP
> (an instruction that does nothing but its binary encoding looks like
> 'MZ..') and a jump to the actual entry point.

FYI the same trick also works for LoongArch: the code "MZ\x00\x00" i.e. 
00005a4d is in fact "ext.w.h $t1, $t6", which is going to simply trash 
one temporary register without any other effect, so a similar jump to 
the actual entrypoint could follow.

This instruction is available for both LA32 and LA64. The only subset 
without it is the LA32 Primary, which is meant for university courses 
and probably would never run UEFI, so the instruction is safe to use.

P.S. If we'd go the extra mile just for ensuring the instruction works 
on every possible LoongArch core, due to the prefix construction of 
LoongArch encoding, we could just change the bytes toward the MSB (so we 
keep the "MZ" with ease) and still only trash $t1. For example 
"MZ\x10\x00" or 00105a4d is "add.w $t1, $t6, $fp", which is similarly 
harmless, but this time it works on even coursework cores!

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

