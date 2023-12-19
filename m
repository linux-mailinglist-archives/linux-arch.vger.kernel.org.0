Return-Path: <linux-arch+bounces-1130-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1368185A9
	for <lists+linux-arch@lfdr.de>; Tue, 19 Dec 2023 11:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F561F24145
	for <lists+linux-arch@lfdr.de>; Tue, 19 Dec 2023 10:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0728F14F68;
	Tue, 19 Dec 2023 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSlZHRW4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B0414AB0;
	Tue, 19 Dec 2023 10:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AD2C433CC;
	Tue, 19 Dec 2023 10:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702983050;
	bh=boVSalnCGlkz1ODJ8LdCVIJrPZvD+WMXnOuvULILNQE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rSlZHRW456R4j32VftJoUKWPnAHhgrIuErQlGx8+Pb2j2R6gm/6sZYXraynlQwSJs
	 TODZF223NDWyXxssJTgkxKy6rklDM0pB2D9VpH/Suk5+j1EAaU+BGRLgN9kA8KVo9U
	 r2oPJL08RVeXSdw5uCE+cwpHHgzhqG8mT7oE56WZwuqIgFi51SFwm2wJvMUzKaiZh1
	 1VYQErzPuiks0CXWstQxrxt1yz+aISWsGTSWOkgseRb4fUCwJptc78m1r6bDvlSRTW
	 IpYx/fSeDFqCkyZ561JICe2si5ZZLwXTD5H7RVULd+Br553Z19KVlyYriX5GClXcTk
	 LKxuzNuAjwoCA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50bce78f145so5041386e87.0;
        Tue, 19 Dec 2023 02:50:50 -0800 (PST)
X-Gm-Message-State: AOJu0YwEIYk0WsLI7svZXpuDZJSFfpGUfFe6U4cOyCD8TLk86vwdSXkO
	N7n/2vPPbNz8cyBjMfdXZJAqxLJIIv1PM7v1lBQ=
X-Google-Smtp-Source: AGHT+IHT4YrAB66G8KurFpT6fXhEv3LbPDu6EWrXwHUtM/XsyvcXI8i1oDj5YA/PvBYxWJPLDHFcZBjQli9onMeLIQ4=
X-Received: by 2002:a19:c21a:0:b0:50e:2b00:1f99 with SMTP id
 l26-20020a19c21a000000b0050e2b001f99mr864576lfc.100.1702983048284; Tue, 19
 Dec 2023 02:50:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215122614.5481-1-tzimmermann@suse.de> <20231215122614.5481-2-tzimmermann@suse.de>
In-Reply-To: <20231215122614.5481-2-tzimmermann@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 19 Dec 2023 11:50:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG3rHSM=vkDYibe7ZCbk65vwa=vJaDDO1aW1VStzN+sug@mail.gmail.com>
Message-ID: <CAMj1kXG3rHSM=vkDYibe7ZCbk65vwa=vJaDDO1aW1VStzN+sug@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arch/x86: Move UAPI setup structures into setup_data.h
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	bhelgaas@google.com, arnd@arndb.de, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, javierm@redhat.com, linux-arch@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

On Fri, 15 Dec 2023 at 13:26, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> The type definition of struct pci_setup_rom in <asm/pci.h> requires
> struct setup_data from <asm/bootparam.h>. Many drivers include
> <linux/pci.h>, but do not use boot parameters. Changes to bootparam.h
> or its included header files could easily trigger a large, unnecessary
> rebuild of the kernel.
>
> Moving struct setup_data and related code into its own own header file
> avoids including <asm/bootparam.h> in <asm/pci.h>. Instead include the
> new header <asm/screen_data.h> and remove the include statement for
> x86_init.h, which is unnecessary but pulls in bootparams.h.
>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  arch/x86/include/asm/pci.h             |   2 +-
>  arch/x86/include/uapi/asm/bootparam.h  | 218 +----------------------
>  arch/x86/include/uapi/asm/setup_data.h | 229 +++++++++++++++++++++++++
>  3 files changed, 231 insertions(+), 218 deletions(-)
>  create mode 100644 arch/x86/include/uapi/asm/setup_data.h
>

This is an improvement but not quite what I had in mind: setup_data is
a x86 specific linked list that is only referred to via a u64 in
setup_header.

So setup_data and all the specializations belong in setup_data.h.
OTOH, setup_header, the XLF load flags, efi_info, the e820 related
definitions etc are not related to setup_data at all but to
setup_header. Whether or not setup_header could live in its own header
too (along with those related definitions) is a separate question imo,
but I don't think they belong in setup_data.h



> diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> index b40c462b4af3..f6100df3652e 100644
> --- a/arch/x86/include/asm/pci.h
> +++ b/arch/x86/include/asm/pci.h
> @@ -10,7 +10,7 @@
>  #include <linux/numa.h>
>  #include <asm/io.h>
>  #include <asm/memtype.h>
> -#include <asm/x86_init.h>
> +#include <asm/setup_data.h>
>
>  struct pci_sysdata {
>         int             domain;         /* PCI domain */
> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> index 01d19fc22346..f6361eb792fd 100644
> --- a/arch/x86/include/uapi/asm/bootparam.h
> +++ b/arch/x86/include/uapi/asm/bootparam.h
> @@ -2,42 +2,7 @@
>  #ifndef _ASM_X86_BOOTPARAM_H
>  #define _ASM_X86_BOOTPARAM_H
>
> -/* setup_data/setup_indirect types */
> -#define SETUP_NONE                     0
> -#define SETUP_E820_EXT                 1
> -#define SETUP_DTB                      2
> -#define SETUP_PCI                      3
> -#define SETUP_EFI                      4
> -#define SETUP_APPLE_PROPERTIES         5
> -#define SETUP_JAILHOUSE                        6
> -#define SETUP_CC_BLOB                  7
> -#define SETUP_IMA                      8
> -#define SETUP_RNG_SEED                 9
> -#define SETUP_ENUM_MAX                 SETUP_RNG_SEED
> -
> -#define SETUP_INDIRECT                 (1<<31)
> -#define SETUP_TYPE_MAX                 (SETUP_ENUM_MAX | SETUP_INDIRECT)
> -
> -/* ram_size flags */
> -#define RAMDISK_IMAGE_START_MASK       0x07FF
> -#define RAMDISK_PROMPT_FLAG            0x8000
> -#define RAMDISK_LOAD_FLAG              0x4000
> -
> -/* loadflags */
> -#define LOADED_HIGH    (1<<0)
> -#define KASLR_FLAG     (1<<1)
> -#define QUIET_FLAG     (1<<5)
> -#define KEEP_SEGMENTS  (1<<6)
> -#define CAN_USE_HEAP   (1<<7)
> -
> -/* xloadflags */
> -#define XLF_KERNEL_64                  (1<<0)
> -#define XLF_CAN_BE_LOADED_ABOVE_4G     (1<<1)
> -#define XLF_EFI_HANDOVER_32            (1<<2)
> -#define XLF_EFI_HANDOVER_64            (1<<3)
> -#define XLF_EFI_KEXEC                  (1<<4)
> -#define XLF_5LEVEL                     (1<<5)
> -#define XLF_5LEVEL_ENABLED             (1<<6)
> +#include <asm/setup_data.h>
>
>  #ifndef __ASSEMBLY__
>
> @@ -48,139 +13,6 @@
>  #include <asm/ist.h>
>  #include <video/edid.h>
>
> -/* extensible setup data list node */
> -struct setup_data {
> -       __u64 next;
> -       __u32 type;
> -       __u32 len;
> -       __u8 data[];
> -};
> -
> -/* extensible setup indirect data node */
> -struct setup_indirect {
> -       __u32 type;
> -       __u32 reserved;  /* Reserved, must be set to zero. */
> -       __u64 len;
> -       __u64 addr;
> -};
> -
> -struct setup_header {
> -       __u8    setup_sects;
> -       __u16   root_flags;
> -       __u32   syssize;
> -       __u16   ram_size;
> -       __u16   vid_mode;
> -       __u16   root_dev;
> -       __u16   boot_flag;
> -       __u16   jump;
> -       __u32   header;
> -       __u16   version;
> -       __u32   realmode_swtch;
> -       __u16   start_sys_seg;
> -       __u16   kernel_version;
> -       __u8    type_of_loader;
> -       __u8    loadflags;
> -       __u16   setup_move_size;
> -       __u32   code32_start;
> -       __u32   ramdisk_image;
> -       __u32   ramdisk_size;
> -       __u32   bootsect_kludge;
> -       __u16   heap_end_ptr;
> -       __u8    ext_loader_ver;
> -       __u8    ext_loader_type;
> -       __u32   cmd_line_ptr;
> -       __u32   initrd_addr_max;
> -       __u32   kernel_alignment;
> -       __u8    relocatable_kernel;
> -       __u8    min_alignment;
> -       __u16   xloadflags;
> -       __u32   cmdline_size;
> -       __u32   hardware_subarch;
> -       __u64   hardware_subarch_data;
> -       __u32   payload_offset;
> -       __u32   payload_length;
> -       __u64   setup_data;
> -       __u64   pref_address;
> -       __u32   init_size;
> -       __u32   handover_offset;
> -       __u32   kernel_info_offset;
> -} __attribute__((packed));
> -
> -struct sys_desc_table {
> -       __u16 length;
> -       __u8  table[14];
> -};
> -
> -/* Gleaned from OFW's set-parameters in cpu/x86/pc/linux.fth */
> -struct olpc_ofw_header {
> -       __u32 ofw_magic;        /* OFW signature */
> -       __u32 ofw_version;
> -       __u32 cif_handler;      /* callback into OFW */
> -       __u32 irq_desc_table;
> -} __attribute__((packed));
> -
> -struct efi_info {
> -       __u32 efi_loader_signature;
> -       __u32 efi_systab;
> -       __u32 efi_memdesc_size;
> -       __u32 efi_memdesc_version;
> -       __u32 efi_memmap;
> -       __u32 efi_memmap_size;
> -       __u32 efi_systab_hi;
> -       __u32 efi_memmap_hi;
> -};
> -
> -/*
> - * This is the maximum number of entries in struct boot_params::e820_table
> - * (the zeropage), which is part of the x86 boot protocol ABI:
> - */
> -#define E820_MAX_ENTRIES_ZEROPAGE 128
> -
> -/*
> - * The E820 memory region entry of the boot protocol ABI:
> - */
> -struct boot_e820_entry {
> -       __u64 addr;
> -       __u64 size;
> -       __u32 type;
> -} __attribute__((packed));
> -
> -/*
> - * Smallest compatible version of jailhouse_setup_data required by this kernel.
> - */
> -#define JAILHOUSE_SETUP_REQUIRED_VERSION       1
> -
> -/*
> - * The boot loader is passing platform information via this Jailhouse-specific
> - * setup data structure.
> - */
> -struct jailhouse_setup_data {
> -       struct {
> -               __u16   version;
> -               __u16   compatible_version;
> -       } __attribute__((packed)) hdr;
> -       struct {
> -               __u16   pm_timer_address;
> -               __u16   num_cpus;
> -               __u64   pci_mmconfig_base;
> -               __u32   tsc_khz;
> -               __u32   apic_khz;
> -               __u8    standard_ioapic;
> -               __u8    cpu_ids[255];
> -       } __attribute__((packed)) v1;
> -       struct {
> -               __u32   flags;
> -       } __attribute__((packed)) v2;
> -} __attribute__((packed));
> -
> -/*
> - * IMA buffer setup data information from the previous kernel during kexec
> - */
> -struct ima_setup_data {
> -       __u64 addr;
> -       __u64 size;
> -} __attribute__((packed));
> -
>  /* The so-called "zeropage" */
>  struct boot_params {
>         struct screen_info screen_info;                 /* 0x000 */
> @@ -231,54 +63,6 @@ struct boot_params {
>         __u8  _pad9[276];                               /* 0xeec */
>  } __attribute__((packed));
>
> -/**
> - * enum x86_hardware_subarch - x86 hardware subarchitecture
> - *
> - * The x86 hardware_subarch and hardware_subarch_data were added as of the x86
> - * boot protocol 2.07 to help distinguish and support custom x86 boot
> - * sequences. This enum represents accepted values for the x86
> - * hardware_subarch.  Custom x86 boot sequences (not X86_SUBARCH_PC) do not
> - * have or simply *cannot* make use of natural stubs like BIOS or EFI, the
> - * hardware_subarch can be used on the Linux entry path to revector to a
> - * subarchitecture stub when needed. This subarchitecture stub can be used to
> - * set up Linux boot parameters or for special care to account for nonstandard
> - * handling of page tables.
> - *
> - * These enums should only ever be used by x86 code, and the code that uses
> - * it should be well contained and compartmentalized.
> - *
> - * KVM and Xen HVM do not have a subarch as these are expected to follow
> - * standard x86 boot entries. If there is a genuine need for "hypervisor" type
> - * that should be considered separately in the future. Future guest types
> - * should seriously consider working with standard x86 boot stubs such as
> - * the BIOS or EFI boot stubs.
> - *
> - * WARNING: this enum is only used for legacy hacks, for platform features that
> - *         are not easily enumerated or discoverable. You should not ever use
> - *         this for new features.
> - *
> - * @X86_SUBARCH_PC: Should be used if the hardware is enumerable using standard
> - *     PC mechanisms (PCI, ACPI) and doesn't need a special boot flow.
> - * @X86_SUBARCH_LGUEST: Used for x86 hypervisor demo, lguest, deprecated
> - * @X86_SUBARCH_XEN: Used for Xen guest types which follow the PV boot path,
> - *     which start at asm startup_xen() entry point and later jump to the C
> - *     xen_start_kernel() entry point. Both domU and dom0 type of guests are
> - *     currently supported through this PV boot path.
> - * @X86_SUBARCH_INTEL_MID: Used for Intel MID (Mobile Internet Device) platform
> - *     systems which do not have the PCI legacy interfaces.
> - * @X86_SUBARCH_CE4100: Used for Intel CE media processor (CE4100) SoC
> - *     for settop boxes and media devices, the use of a subarch for CE4100
> - *     is more of a hack...
> - */
> -enum x86_hardware_subarch {
> -       X86_SUBARCH_PC = 0,
> -       X86_SUBARCH_LGUEST,
> -       X86_SUBARCH_XEN,
> -       X86_SUBARCH_INTEL_MID,
> -       X86_SUBARCH_CE4100,
> -       X86_NR_SUBARCHS,
> -};
> -
>  #endif /* __ASSEMBLY__ */
>
>  #endif /* _ASM_X86_BOOTPARAM_H */
> diff --git a/arch/x86/include/uapi/asm/setup_data.h b/arch/x86/include/uapi/asm/setup_data.h
> new file mode 100644
> index 000000000000..e1396e1bf048
> --- /dev/null
> +++ b/arch/x86/include/uapi/asm/setup_data.h
> @@ -0,0 +1,229 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_ASM_X86_SETUP_DATA_H
> +#define _UAPI_ASM_X86_SETUP_DATA_H
> +
> +/* setup_data/setup_indirect types */
> +#define SETUP_NONE                     0
> +#define SETUP_E820_EXT                 1
> +#define SETUP_DTB                      2
> +#define SETUP_PCI                      3
> +#define SETUP_EFI                      4
> +#define SETUP_APPLE_PROPERTIES         5
> +#define SETUP_JAILHOUSE                        6
> +#define SETUP_CC_BLOB                  7
> +#define SETUP_IMA                      8
> +#define SETUP_RNG_SEED                 9
> +#define SETUP_ENUM_MAX                 SETUP_RNG_SEED
> +
> +#define SETUP_INDIRECT                 (1<<31)
> +#define SETUP_TYPE_MAX                 (SETUP_ENUM_MAX | SETUP_INDIRECT)
> +
> +/* ram_size flags */
> +#define RAMDISK_IMAGE_START_MASK       0x07FF
> +#define RAMDISK_PROMPT_FLAG            0x8000
> +#define RAMDISK_LOAD_FLAG              0x4000
> +
> +/* loadflags */
> +#define LOADED_HIGH    (1<<0)
> +#define KASLR_FLAG     (1<<1)
> +#define QUIET_FLAG     (1<<5)
> +#define KEEP_SEGMENTS  (1<<6)
> +#define CAN_USE_HEAP   (1<<7)
> +
> +/* xloadflags */
> +#define XLF_KERNEL_64                  (1<<0)
> +#define XLF_CAN_BE_LOADED_ABOVE_4G     (1<<1)
> +#define XLF_EFI_HANDOVER_32            (1<<2)
> +#define XLF_EFI_HANDOVER_64            (1<<3)
> +#define XLF_EFI_KEXEC                  (1<<4)
> +#define XLF_5LEVEL                     (1<<5)
> +#define XLF_5LEVEL_ENABLED             (1<<6)
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/types.h>
> +
> +/* extensible setup data list node */
> +struct setup_data {
> +       __u64 next;
> +       __u32 type;
> +       __u32 len;
> +       __u8 data[];
> +};
> +
> +/* extensible setup indirect data node */
> +struct setup_indirect {
> +       __u32 type;
> +       __u32 reserved;  /* Reserved, must be set to zero. */
> +       __u64 len;
> +       __u64 addr;
> +};
> +
> +struct setup_header {
> +       __u8    setup_sects;
> +       __u16   root_flags;
> +       __u32   syssize;
> +       __u16   ram_size;
> +       __u16   vid_mode;
> +       __u16   root_dev;
> +       __u16   boot_flag;
> +       __u16   jump;
> +       __u32   header;
> +       __u16   version;
> +       __u32   realmode_swtch;
> +       __u16   start_sys_seg;
> +       __u16   kernel_version;
> +       __u8    type_of_loader;
> +       __u8    loadflags;
> +       __u16   setup_move_size;
> +       __u32   code32_start;
> +       __u32   ramdisk_image;
> +       __u32   ramdisk_size;
> +       __u32   bootsect_kludge;
> +       __u16   heap_end_ptr;
> +       __u8    ext_loader_ver;
> +       __u8    ext_loader_type;
> +       __u32   cmd_line_ptr;
> +       __u32   initrd_addr_max;
> +       __u32   kernel_alignment;
> +       __u8    relocatable_kernel;
> +       __u8    min_alignment;
> +       __u16   xloadflags;
> +       __u32   cmdline_size;
> +       __u32   hardware_subarch;
> +       __u64   hardware_subarch_data;
> +       __u32   payload_offset;
> +       __u32   payload_length;
> +       __u64   setup_data;
> +       __u64   pref_address;
> +       __u32   init_size;
> +       __u32   handover_offset;
> +       __u32   kernel_info_offset;
> +} __attribute__((packed));
> +
> +struct sys_desc_table {
> +       __u16 length;
> +       __u8  table[14];
> +};
> +
> +/* Gleaned from OFW's set-parameters in cpu/x86/pc/linux.fth */
> +struct olpc_ofw_header {
> +       __u32 ofw_magic;        /* OFW signature */
> +       __u32 ofw_version;
> +       __u32 cif_handler;      /* callback into OFW */
> +       __u32 irq_desc_table;
> +} __attribute__((packed));
> +
> +struct efi_info {
> +       __u32 efi_loader_signature;
> +       __u32 efi_systab;
> +       __u32 efi_memdesc_size;
> +       __u32 efi_memdesc_version;
> +       __u32 efi_memmap;
> +       __u32 efi_memmap_size;
> +       __u32 efi_systab_hi;
> +       __u32 efi_memmap_hi;
> +};
> +
> +/*
> + * This is the maximum number of entries in struct boot_params::e820_table
> + * (the zeropage), which is part of the x86 boot protocol ABI:
> + */
> +#define E820_MAX_ENTRIES_ZEROPAGE 128
> +
> +/*
> + * The E820 memory region entry of the boot protocol ABI:
> + */
> +struct boot_e820_entry {
> +       __u64 addr;
> +       __u64 size;
> +       __u32 type;
> +} __attribute__((packed));
> +
> +/*
> + * Smallest compatible version of jailhouse_setup_data required by this kernel.
> + */
> +#define JAILHOUSE_SETUP_REQUIRED_VERSION       1
> +
> +/*
> + * The boot loader is passing platform information via this Jailhouse-specific
> + * setup data structure.
> + */
> +struct jailhouse_setup_data {
> +       struct {
> +               __u16   version;
> +               __u16   compatible_version;
> +       } __attribute__((packed)) hdr;
> +       struct {
> +               __u16   pm_timer_address;
> +               __u16   num_cpus;
> +               __u64   pci_mmconfig_base;
> +               __u32   tsc_khz;
> +               __u32   apic_khz;
> +               __u8    standard_ioapic;
> +               __u8    cpu_ids[255];
> +       } __attribute__((packed)) v1;
> +       struct {
> +               __u32   flags;
> +       } __attribute__((packed)) v2;
> +} __attribute__((packed));
> +
> +/*
> + * IMA buffer setup data information from the previous kernel during kexec
> + */
> +struct ima_setup_data {
> +       __u64 addr;
> +       __u64 size;
> +} __attribute__((packed));
> +
> +/**
> + * enum x86_hardware_subarch - x86 hardware subarchitecture
> + *
> + * The x86 hardware_subarch and hardware_subarch_data were added as of the x86
> + * boot protocol 2.07 to help distinguish and support custom x86 boot
> + * sequences. This enum represents accepted values for the x86
> + * hardware_subarch.  Custom x86 boot sequences (not X86_SUBARCH_PC) do not
> + * have or simply *cannot* make use of natural stubs like BIOS or EFI, the
> + * hardware_subarch can be used on the Linux entry path to revector to a
> + * subarchitecture stub when needed. This subarchitecture stub can be used to
> + * set up Linux boot parameters or for special care to account for nonstandard
> + * handling of page tables.
> + *
> + * These enums should only ever be used by x86 code, and the code that uses
> + * it should be well contained and compartmentalized.
> + *
> + * KVM and Xen HVM do not have a subarch as these are expected to follow
> + * standard x86 boot entries. If there is a genuine need for "hypervisor" type
> + * that should be considered separately in the future. Future guest types
> + * should seriously consider working with standard x86 boot stubs such as
> + * the BIOS or EFI boot stubs.
> + *
> + * WARNING: this enum is only used for legacy hacks, for platform features that
> + *         are not easily enumerated or discoverable. You should not ever use
> + *         this for new features.
> + *
> + * @X86_SUBARCH_PC: Should be used if the hardware is enumerable using standard
> + *     PC mechanisms (PCI, ACPI) and doesn't need a special boot flow.
> + * @X86_SUBARCH_LGUEST: Used for x86 hypervisor demo, lguest, deprecated
> + * @X86_SUBARCH_XEN: Used for Xen guest types which follow the PV boot path,
> + *     which start at asm startup_xen() entry point and later jump to the C
> + *     xen_start_kernel() entry point. Both domU and dom0 type of guests are
> + *     currently supported through this PV boot path.
> + * @X86_SUBARCH_INTEL_MID: Used for Intel MID (Mobile Internet Device) platform
> + *     systems which do not have the PCI legacy interfaces.
> + * @X86_SUBARCH_CE4100: Used for Intel CE media processor (CE4100) SoC
> + *     for settop boxes and media devices, the use of a subarch for CE4100
> + *     is more of a hack...
> + */
> +enum x86_hardware_subarch {
> +       X86_SUBARCH_PC = 0,
> +       X86_SUBARCH_LGUEST,
> +       X86_SUBARCH_XEN,
> +       X86_SUBARCH_INTEL_MID,
> +       X86_SUBARCH_CE4100,
> +       X86_NR_SUBARCHS,
> +};
> +
> +#endif /* __ASSEMBLY__ */
> +
> +#endif /* _UAPI_ASM_X86_SETUP_DATA_H */
> --
> 2.43.0
>
>

