Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E4951D6A3
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 13:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391324AbiEFLaP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 07:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389782AbiEFLaO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 07:30:14 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB4B13F7F;
        Fri,  6 May 2022 04:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1651836387; bh=azHha70+GWhmg49YkWnFtTT3iKIMGLPZ6Q/jJlWPQuI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PE/TUtgED1vC70nqwhf+4/pi1bKNCjFm19JASheRMc2lYYis/Gq7FbfKbCJCAKqk2
         jioMj/Q1zY4ITwJA2XqesgXVGpx5IEoEUYoZ19GNjXDbysOcyx8+MBFC+N8MSQY+nb
         LP7ylM4j2W5XZCd3j5A0I33AP35IP89CdrWvRKT4=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 734406068D;
        Fri,  6 May 2022 19:26:27 +0800 (CST)
Message-ID: <a6afaa3f-cb9f-2086-0e02-5ec21ba535d4@xen0n.name>
Date:   Fri, 6 May 2022 19:26:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0a1
Subject: Re: [PATCH V9 20/24] LoongArch: Add efistub booting support
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-21-chenhuacai@loongson.cn>
 <CAK8P3a2SPTLLrZtSz0LT0LqMpq4SKCScD4vLvr+DJn+u5W_CdA@mail.gmail.com>
 <CAMj1kXEDpJwLDD4ZGLwzdo1KcJG_90iD9MnBVamCK06YKF7BdA@mail.gmail.com>
 <CAAhV-H4eR5YvhABp9L4FBmofWwH+XM3V_nOjatQTV_M7Gihs7g@mail.gmail.com>
 <CAMj1kXFD8_CuijJFgQbrxvY4MVBLmKQKFKmYhD1NBFLn3v=+FQ@mail.gmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAMj1kXFD8_CuijJFgQbrxvY4MVBLmKQKFKmYhD1NBFLn3v=+FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 5/6/22 16:14, Ard Biesheuvel wrote:
> [snip]
>>>>> +
>>>>> +static efi_status_t mk_mmap(struct efi_boot_memmap *map, struct boot_params *p)
>>>>> +{
>>> Are you passing a different representation of the memory map to the
>>> core kernel? I think it would be easier just to pass the EFI memory
>>> map like other EFI arches do, and reuse all of the code that we
>>> already have.
>> Yes, this different representation is used by our "boot_params", the
>> interface between bootloader (including efistub) and the core kernel.
> So how does the core kernel consume the EFI memory map? Only through
> this mechanism?
>
>>>>> +       char checksum;
>>>>> +       unsigned int i;
>>>>> +       unsigned int nr_desc;
>>>>> +       unsigned int mem_type;
>>>>> +       unsigned long count;
>>>>> +       efi_memory_desc_t *mem_desc;
>>>>> +       struct loongsonlist_mem_map *mhp = NULL;
>>>>> +
>>>>> +       memset(map_entry, 0, sizeof(map_entry));
>>>>> +       memset(mmap_array, 0, sizeof(mmap_array));
>>>>> +
>>>>> +       if (!strncmp((char *)p, "BPI", 3)) {
>>>>> +               p->flags |= BPI_FLAGS_UEFI_SUPPORTED;
>>>>> +               p->systemtable = (efi_system_table_t *)efi_system_table;
>>>>> +               p->extlist_offset = sizeof(*p) + sizeof(unsigned long);
>>>>> +               mhp = (struct loongsonlist_mem_map *)((char *)p + p->extlist_offset);
>>>>> +
>>>>> +               memcpy(&mhp->header.signature, "MEM", sizeof(unsigned long));
>>>>> +               mhp->header.length = sizeof(*mhp);
>>>>> +               mhp->desc_version = *map->desc_ver;
>>>>> +               mhp->map_count = 0;
>>>>> +       }
>>>>> +       if (!(*(map->map_size)) || !(*(map->desc_size)) || !mhp) {
>>>>> +               efi_err("get memory info error\n");
>>>>> +               return EFI_INVALID_PARAMETER;
>>>>> +       }
>>>>> +       nr_desc = *(map->map_size) / *(map->desc_size);
>>>>> +
>>>>> +       /*
>>>>> +        * According to UEFI SPEC, mmap_buf is the accurate Memory Map
>>>>> +        * mmap_array now we can fill platform specific memory structure.
>>>>> +        */
>>>>> +       for (i = 0; i < nr_desc; i++) {
>>>>> +               mem_desc = (efi_memory_desc_t *)((void *)(*map->map) + (i * (*(map->desc_size))));
>>>>> +               switch (mem_desc->type) {
>>>>> +               case EFI_RESERVED_TYPE:
>>>>> +               case EFI_RUNTIME_SERVICES_CODE:
>>>>> +               case EFI_RUNTIME_SERVICES_DATA:
>>>>> +               case EFI_MEMORY_MAPPED_IO:
>>>>> +               case EFI_MEMORY_MAPPED_IO_PORT_SPACE:
>>>>> +               case EFI_UNUSABLE_MEMORY:
>>>>> +               case EFI_PAL_CODE:
>>>>> +                       mem_type = ADDRESS_TYPE_RESERVED;
>>>>> +                       break;
>>>>> +
>>>>> +               case EFI_ACPI_MEMORY_NVS:
>>>>> +                       mem_type = ADDRESS_TYPE_NVS;
>>>>> +                       break;
>>>>> +
>>>>> +               case EFI_ACPI_RECLAIM_MEMORY:
>>>>> +                       mem_type = ADDRESS_TYPE_ACPI;
>>>>> +                       break;
>>>>> +
>>>>> +               case EFI_LOADER_CODE:
>>>>> +               case EFI_LOADER_DATA:
>>>>> +               case EFI_PERSISTENT_MEMORY:
>>>>> +               case EFI_BOOT_SERVICES_CODE:
>>>>> +               case EFI_BOOT_SERVICES_DATA:
>>>>> +               case EFI_CONVENTIONAL_MEMORY:
>>>>> +                       mem_type = ADDRESS_TYPE_SYSRAM;
>>>>> +                       break;
>>>>> +
>>>>> +               default:
>>>>> +                       continue;
>>>>> +               }
>>>>> +
>>>>> +               mmap_array[mem_type][map_entry[mem_type]].mem_type = mem_type;
>>>>> +               mmap_array[mem_type][map_entry[mem_type]].mem_start =
>>>>> +                                               mem_desc->phys_addr & TO_PHYS_MASK;
>>>>> +               mmap_array[mem_type][map_entry[mem_type]].mem_size =
>>>>> +                                               mem_desc->num_pages << EFI_PAGE_SHIFT;
>>>>> +               mmap_array[mem_type][map_entry[mem_type]].attribute =
>>>>> +                                               mem_desc->attribute;
>>>>> +               map_entry[mem_type]++;
>>>>> +       }
>>>>> +
>>>>> +       count = mhp->map_count;
>>>>> +       /* Sort EFI memmap and add to BPI for kernel */
>>>>> +       for (i = 0; i < LOONGSON3_BOOT_MEM_MAP_MAX; i++) {
>>>>> +               if (!map_entry[i])
>>>>> +                       continue;
>>>>> +               count = efi_memmap_sort(mhp, count, i);
>>>>> +       }
>>>>> +
>>>>> +       mhp->map_count = count;
>>>>> +       mhp->header.checksum = 0;
>>>>> +
>>>>> +       checksum = efi_crc8((char *)mhp, mhp->header.length);
>>>>> +       mhp->header.checksum = checksum;
>>>>> +
>>>>> +       return EFI_SUCCESS;
>>>>> +}
>>>>> +
>>>>> +static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
>>>>> +{
>>>>> +       efi_status_t status;
>>>>> +       struct exit_boot_struct *p = priv;
>>>>> +
>>>>> +       status = mk_mmap(map, p->bp);
>>>>> +       if (status != EFI_SUCCESS) {
>>>>> +               efi_err("Make kernel memory map failed!\n");
>>>>> +               return status;
>>>>> +       }
>>>>> +
>>>>> +       return EFI_SUCCESS;
>>>>> +}
>>>>> +
>>>>> +static efi_status_t exit_boot_services(struct boot_params *boot_params, void *handle)
>>>>> +{
>>>>> +       unsigned int desc_version;
>>>>> +       unsigned int runtime_entry_count = 0;
>>>>> +       unsigned long map_size, key, desc_size, buff_size;
>>>>> +       efi_status_t status;
>>>>> +       efi_memory_desc_t *mem_map;
>>>>> +       struct efi_boot_memmap map;
>>>>> +       struct exit_boot_struct priv;
>>>>> +
>>>>> +       map.map                 = &mem_map;
>>>>> +       map.map_size            = &map_size;
>>>>> +       map.desc_size           = &desc_size;
>>>>> +       map.desc_ver            = &desc_version;
>>>>> +       map.key_ptr             = &key;
>>>>> +       map.buff_size           = &buff_size;
>>>>> +       status = efi_get_memory_map(&map);
>>>>> +       if (status != EFI_SUCCESS) {
>>>>> +               efi_err("Unable to retrieve UEFI memory map.\n");
>>>>> +               return status;
>>>>> +       }
>>>>> +
>>>>> +       priv.bp = boot_params;
>>>>> +       priv.runtime_entry_count = &runtime_entry_count;
>>>>> +
>>>>> +       /* Might as well exit boot services now */
>>>>> +       status = efi_exit_boot_services(handle, &map, &priv, exit_boot_func);
>>>>> +       if (status != EFI_SUCCESS)
>>>>> +               return status;
>>>>> +
>>>>> +       return EFI_SUCCESS;
>>>>> +}
>>>>> +
>>>>> +/*
>>>>> + * EFI entry point for the LoongArch EFI stub.
>>>>> + */
>>>>> +efi_status_t __efiapi efi_pe_entry(efi_handle_t handle, efi_system_table_t *sys_table)
>>> Why are you not using the generic EFI stub boot flow?
>> Hmmm, as I know, we define our own "boot_params", a interface between
>> bootloader (including efistub) and the core kernel to pass memmap,
>> cmdline and initrd information, three years ago. This method looks
>> like the X86 way, while different from the generic stub (which is
>> called arm stub before 5.8). In these years, many products have
>> already use the "boot_params" interface (including UEFI, PMON, Grub,
>> Kernel, etc., but most of them haven't be upstream). Replace
>> boot_params with FDT (i.e., the generic stub way) is difficult for us,
>> because it means a big broken of compatibility.
>>
> OK, I understand. So using the generic stub is not possible for you.
>
> So as long as you don't enable deprecated features such as initrd=, or
> rely on special hacks like putting magic numbers at fixed offsets in
> the image, I'm fine with this approach.

I'd like to add some relevant background: this "struct boot_params" 
thingy is actually a Loongson corporate standard. It is available at 
[1]; only in Chinese but should be minimally recognizable given much of 
it is C code, and you can see this struct and its friends barely changed 
since 2019.

The standard is in place long before inception of LoongArch (the 
earliest spec is dated back to 2014). Back when Loongson was still doing 
MIPS this is somewhat acceptable, due to fragmentation of the MIPS 
world, but they didn't take the chance to re-think most of this for 
LoongArch, instead simply porting everything over as-is. Hence the ship 
has more-or-less already sailed, and we indeed have to support this flow 
for keeping compatibility...

Or is there compatibility at all?

It turns out that this port is already incompatible with shipped 
systems, in other ways, at least since the March revision or so.

For one thing, the exact definition of this "struct boot_params" is 
already incompatibly revised; this version [2] is the one actually 
compatible with existing firmware, so people already have to write shims 
(not started yet) or flash their firmware (not open-sourced or provided 
by Loongson yet) to actually compile and run this port. (You haven't 
read that wrong; indeed no one outside Loongson is able to run this 
kernel so far.)

For another thing, the kernel ABI and the userland (mainly glibc) are 
also incompatible with the shipped systems with their pre-installed 
vendor systems. Things like different NSIG, sigcontext, and glibc symbol 
versions already ensured no binary can run in "the other world".

So, in effect, this port is starting from scratch, and taking the chance 
to fix early mistakes and oversights all over; hence my opinion is, 
better do the Right Thing (tm) and give the generic codepath a chance.

For the Loongson devs: at least, declare the struct boot_params flow 
deprecated from day one, then work to eliminate it from future products, 
if you really don't want to delay merging even further (it's already 
unlikely to land in 5.19, given the discussion happening in LKML [3]). 
It's not embarrassing to admit mistakes; we all make mistakes, and 
what's important is to learn from them so we don't collectively repeat 
ourselves.


[1]: 
https://web.archive.org/web/20190713081851/http://www.loongson.cn/uploadfile/devsysmanual/loongson_devsys_firmware_kernel_interface_specification.pdf
[2]: 
https://github.com/xen0n/linux/commit/a55739f8e748dc9164c12da504696161bb8b9911
[3]: https://lwn.net/ml/linux-kernel/87v8uk6kfa.wl-maz@kernel.org/

