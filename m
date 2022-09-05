Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173795ACCDF
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 09:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbiIEHfb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 03:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236903AbiIEHfY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 03:35:24 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5F831A3B3;
        Mon,  5 Sep 2022 00:35:02 -0700 (PDT)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxX+CWphVjdJgRAA--.7347S3;
        Mon, 05 Sep 2022 15:34:47 +0800 (CST)
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
 <CAMj1kXFRsEJOS2Kim8T64rYF85_bmmZ5gW7kjb8eDXry5SA+cg@mail.gmail.com>
 <CAAhV-H4xDB6JPCEZqQ6+VadOPnzA3beguiuTRS-Ub=Ci5FgpPw@mail.gmail.com>
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
Message-ID: <aecbb170-d351-f6a1-57f5-f17415017dbb@loongson.cn>
Date:   Mon, 5 Sep 2022 15:34:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4xDB6JPCEZqQ6+VadOPnzA3beguiuTRS-Ub=Ci5FgpPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxX+CWphVjdJgRAA--.7347S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Wry5uryxGrW7tw4rtr4Dtwb_yoW7Xryxp3
        4xGFW8tF4DJr1rGwn2q3WUua42vw13Ar17Xrn8try8Awn0vrnIqr1Iqr45uFyUZw1Ikw12
        vF4jq347uF15ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr4
        1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
        67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
        8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUeeOJUUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Huacai

On 09/05/2022 03:24 PM, Huacai Chen wrote:
> Hi, Ard and Youling,
>
> On Mon, Sep 5, 2022 at 3:02 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> On Mon, 5 Sept 2022 at 05:51, Huacai Chen <chenhuacai@kernel.org> wrote:
>>>
>>> Hi, Ard,
>>>
>>> On Mon, Sep 5, 2022 at 5:59 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>>>>
>>>> On Sun, 4 Sept 2022 at 15:24, Huacai Chen <chenhuacai@kernel.org> wrote:
>>>>>
>>>>> Hi, Ard,
>>>>>
>>>>> On Thu, Sep 1, 2022 at 6:40 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>>>>>>
>>>>>> Hi, Ard,
>>>>>>
>>>>>> On Sat, Aug 27, 2022 at 3:14 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>>>>>>>
>>>>>>> On Sat, 27 Aug 2022 at 06:41, Xi Ruoyao <xry111@xry111.site> wrote:
>>>>>>>>
>>>>>>>> Tested V3 with the magic number check manually removed in my GRUB build.
>>>>>>>> The system boots successfully.  I've not tested Arnd's zBoot patch yet.
>>>>>>>
>>>>>>> I am Ard not Arnd :-)
>>>>>>>
>>>>>>> Please use this branch when testing the EFI decompressor:
>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-decompressor-v4
>>>>>> The root cause of LoongArch zboot boot failure has been found, it is a
>>>>>> binutils bug, latest toolchain with the below patch can solve the
>>>>>> problem.
>>>>>>
>>>>>> diff --git a/bfd/elfnn-loongarch.c b/bfd/elfnn-loongarch.c
>>>>>> index 5b44901b9e0..fafdc7c7458 100644
>>>>>> --- a/bfd/elfnn-loongarch.c
>>>>>> +++ b/bfd/elfnn-loongarch.c
>>>>>> @@ -2341,9 +2341,10 @@ loongarch_elf_relocate_section (bfd
>>>>>> *output_bfd, struct bfd_link_info *info,
>>>>>>      case R_LARCH_SOP_PUSH_PLT_PCREL:
>>>>>>        unresolved_reloc = false;
>>>>>>
>>>>>> -      if (resolved_to_const)
>>>>>> +      if (!is_undefweak && resolved_to_const)
>>>>>>          {
>>>>>>            relocation += rel->r_addend;
>>>>>> +          relocation -= pc;
>>>>>>            break;
>>>>>>          }
>>>>>>        else if (is_undefweak)
>>>>>>
>>>>>>
>>>>>> Huacai
>>>>> Now the patch is submitted here:
>>>>> https://sourceware.org/pipermail/binutils/2022-September/122713.html
>>>>>
>>>>
>>>> Great. Given the severity of this bug, I imagine that building the
>>>> LoongArch kernel will require a version of binutils that carries this
>>>> fix.
>>>>
>>>> Therefore, i will revert back to the original approach for accessing
>>>> uncompressed_size, using an extern declaration with an __aligned(1)
>>>> attribute.
>>>>
>>>>> And I have some other questions about kexec: kexec should jump to the
>>>>> elf entry or the pe entry? I think is the elf entry, because if we
>>>>> jump to the pe entry, then SVAM will be executed twice (but it should
>>>>> be executed only once). However, how can we jump to the elf entry if
>>>>> we use zboot? Maybe it is kexec-tool's responsibility to decompress
>>>>> the zboot kernel image?
>>>>>
>>>>
>>>> Yes, very good point. Kexec kernels cannot boot via the EFI entry
>>>> point, as the boot services will already be shutdown. So the kexec
>>>> kernel needs to boot via the same entrypoint in the core kernel that
>>>> the EFI stub calls when it hands over.
>>>>
>>>> For the EFI zboot image in particular, we will need to teach kexec how
>>>> to decompress them. The zboot image has a header that
>>>> a) describes it as a EFI linux zimg
>>>> b) describes the start and end offset of the compressed payload
>>>> c) describes which compression algorithm was used.
>>>>
>>>> This means that any non-EFI loader (including kexec) should be able to
>>>> extract the inner PE/COFF image and decompress it. For arm64 and
>>>> RISC-V, this is sufficient as the EFI and raw images are the same. For
>>>> LoongArch, I suppose it means we need a way to enter the core kernel
>>>> directly via the entrypoint that the EFI stub uses when handing over
>>>> (and pass the original DT argument so the kexec kernel has access to
>>>> the EFI and ACPI firmware tables)
>>> OK, then is this implementation [1] acceptable? I remember that you
>>> said the MS-DOS header shouldn't contain other information, so I guess
>>> this is unacceptable?
>>>
>>
>> No, this looks reasonable to me. I objected to using magic numbers in
>> the 'pure PE' view of the image, as it does not make sense for a pure
>> PE loader such as GRUB to rely on such metadata.
>>
>> In this case (like on arm64), we are dealing with something else: we
>> need to identify the image to the kernel itself, and here, using the
>> unused space in the MS-DOS header is fine.
>>
>>> [1] https://lore.kernel.org/loongarch/c4dbb14a-5580-1e47-3d15-5d2079e88404@loongson.cn/T/#mb8c1dc44f7fa2d3ef638877f0cd3f958f0be96ad
> OK, then there is no big problem here. And I found that arm64/riscv
> don't need the kernel entry point in the header. I don't know why, but
> I think it implies that a unified layout across architectures is
> unnecessary, and I prefer to put the kernel entry point before
> effective kernel size. :)

The kernel entry point is added because LoongArch has not implemented
purgatory in kexec-tools, so I want to get it from the head through a
simpler method, similar to the elf image operation.

Youling.

>
> Huacai
>
>>>
>>> Huacai

