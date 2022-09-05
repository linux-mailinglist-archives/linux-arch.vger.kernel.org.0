Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57605ACA94
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 08:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbiIEG3Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 02:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbiIEG3P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 02:29:15 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 776FF2AE2C;
        Sun,  4 Sep 2022 23:29:12 -0700 (PDT)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxvmsrlxVjfIkRAA--.61063S3;
        Mon, 05 Sep 2022 14:29:00 +0800 (CST)
Subject: Re: [PATCH V3] LoongArch: Add efistub booting support
To:     Huacai Chen <chenhuacai@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20220819102037.2697798-1-chenhuacai@loongson.cn>
 <9b6f0aeaebbd36882b5b40d655f9ccd20c7be496.camel@xry111.site>
 <CAMj1kXFOd+gMHbi6MH0KHWkBEKN9V0LeZbyGRw8h630OxtMrdA@mail.gmail.com>
 <CAAhV-H6MR=rWhecY_uuiXAysED-BBJhKhGHj2cCkefJiPOo-ZQ@mail.gmail.com>
 <CAAhV-H4KXVUBgNoQxOFiEj2AH-ojhnrEJ8QLvNrALY69MhXF3w@mail.gmail.com>
 <CAMj1kXHJv_6mLhMikg+ic7=EUABLdrX3f__eBbHntrpGHjRfXg@mail.gmail.com>
 <CAAhV-H4WTCRU9qShDp57AZ2DG1uz+=GTz14zyAUaqVDjXrNABA@mail.gmail.com>
 <8319b9d4-960c-e706-468a-cb58bef6df8c@loongson.cn>
Cc:     Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <2772310e-a537-a733-c7c1-be3ff243d2fe@loongson.cn>
Date:   Mon, 5 Sep 2022 14:28:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <8319b9d4-960c-e706-468a-cb58bef6df8c@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxvmsrlxVjfIkRAA--.61063S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyfZw1kJr47JFW7WFWxZwb_yoW7JrWkp3
        y8GF48KF4kJr1xJwn2q3Wj9a42q34fAr12qr1Dt348Ar90vrnIqr1Iqr45WFyDZw40kr42
        vF4Ut34I9F1UA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI4
        8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
        wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
        v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
        Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
        AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUEAp5UUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Ard & Huacai

While applying this patch [1] we need to add vmlinuz* (vmlinuz and
vmlinuz.efi) to arch/loongarch/boot/.gitignore to ignore the generated
binary (also required for arm64 and riscv).

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=efi-decompressor-v4&id=efcc03a013f2ddbed0ee782e5049b39432dc9db2

Thanks,
Youling.

On 09/05/2022 12:34 PM, Youling Tang wrote:
> Hi, Ard & Huacai
>
> On 09/05/2022 11:50 AM, Huacai Chen wrote:
>> Hi, Ard,
>>
>> On Mon, Sep 5, 2022 at 5:59 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>>>
>>> On Sun, 4 Sept 2022 at 15:24, Huacai Chen <chenhuacai@kernel.org> wrote:
>>>>
>>>> Hi, Ard,
>>>>
>>>> On Thu, Sep 1, 2022 at 6:40 PM Huacai Chen <chenhuacai@kernel.org>
>>>> wrote:
>>>>>
>>>>> Hi, Ard,
>>>>>
>>>>> On Sat, Aug 27, 2022 at 3:14 PM Ard Biesheuvel <ardb@kernel.org>
>>>>> wrote:
>>>>>>
>>>>>> On Sat, 27 Aug 2022 at 06:41, Xi Ruoyao <xry111@xry111.site> wrote:
>>>>>>>
>>>>>>> Tested V3 with the magic number check manually removed in my GRUB
>>>>>>> build.
>>>>>>> The system boots successfully.  I've not tested Arnd's zBoot
>>>>>>> patch yet.
>>>>>>
>>>>>> I am Ard not Arnd :-)
>>>>>>
>>>>>> Please use this branch when testing the EFI decompressor:
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-decompressor-v4
>>>>>>
>>>>> The root cause of LoongArch zboot boot failure has been found, it is a
>>>>> binutils bug, latest toolchain with the below patch can solve the
>>>>> problem.
>>>>>
>>>>> diff --git a/bfd/elfnn-loongarch.c b/bfd/elfnn-loongarch.c
>>>>> index 5b44901b9e0..fafdc7c7458 100644
>>>>> --- a/bfd/elfnn-loongarch.c
>>>>> +++ b/bfd/elfnn-loongarch.c
>>>>> @@ -2341,9 +2341,10 @@ loongarch_elf_relocate_section (bfd
>>>>> *output_bfd, struct bfd_link_info *info,
>>>>>      case R_LARCH_SOP_PUSH_PLT_PCREL:
>>>>>        unresolved_reloc = false;
>>>>>
>>>>> -      if (resolved_to_const)
>>>>> +      if (!is_undefweak && resolved_to_const)
>>>>>          {
>>>>>            relocation += rel->r_addend;
>>>>> +          relocation -= pc;
>>>>>            break;
>>>>>          }
>>>>>        else if (is_undefweak)
>>>>>
>>>>>
>>>>> Huacai
>>>> Now the patch is submitted here:
>>>> https://sourceware.org/pipermail/binutils/2022-September/122713.html
>>>>
>>>
>>> Great. Given the severity of this bug, I imagine that building the
>>> LoongArch kernel will require a version of binutils that carries this
>>> fix.
>>>
>>> Therefore, i will revert back to the original approach for accessing
>>> uncompressed_size, using an extern declaration with an __aligned(1)
>>> attribute.
>>>
>>>> And I have some other questions about kexec: kexec should jump to the
>>>> elf entry or the pe entry? I think is the elf entry, because if we
>>>> jump to the pe entry, then SVAM will be executed twice (but it should
>>>> be executed only once). However, how can we jump to the elf entry if
>>>> we use zboot? Maybe it is kexec-tool's responsibility to decompress
>>>> the zboot kernel image?
>>>>
>>>
>>> Yes, very good point. Kexec kernels cannot boot via the EFI entry
>>> point, as the boot services will already be shutdown. So the kexec
>>> kernel needs to boot via the same entrypoint in the core kernel that
>>> the EFI stub calls when it hands over.
>>>
>>> For the EFI zboot image in particular, we will need to teach kexec how
>>> to decompress them. The zboot image has a header that
>>> a) describes it as a EFI linux zimg
>>> b) describes the start and end offset of the compressed payload
>>> c) describes which compression algorithm was used.
>>>
>>> This means that any non-EFI loader (including kexec) should be able to
>>> extract the inner PE/COFF image and decompress it. For arm64 and
>>> RISC-V, this is sufficient as the EFI and raw images are the same. For
>>> LoongArch, I suppose it means we need a way to enter the core kernel
>>> directly via the entrypoint that the EFI stub uses when handing over
>>> (and pass the original DT argument so the kexec kernel has access to
>>> the EFI and ACPI firmware tables)
>> OK, then is this implementation [1] acceptable? I remember that you
>> said the MS-DOS header shouldn't contain other information, so I guess
>> this is unacceptable?
>>
>> [1]
>> https://lore.kernel.org/loongarch/c4dbb14a-5580-1e47-3d15-5d2079e88404@loongson.cn/T/#mb8c1dc44f7fa2d3ef638877f0cd3f958f0be96ad
>>
>
> Modifications to the MS-DOS header refer to the arm64 and riscv
> implementations [1], and to provide the necessary information to
> kexec-tools[2] when loading uncompressed efi images.
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0f327f2aaad6a87356cbccfa390d4d3b64d0d3b6
>
> [2]
> https://github.com/horms/kexec-tools/blob/main/kexec/arch/arm64/image-header.h
>
>
> Thanks,
> Youling
>
>>
>> Huacai
>>
>

