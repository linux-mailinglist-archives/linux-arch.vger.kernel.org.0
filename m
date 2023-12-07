Return-Path: <linux-arch+bounces-750-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C08A808BF5
	for <lists+linux-arch@lfdr.de>; Thu,  7 Dec 2023 16:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A37AB20BB8
	for <lists+linux-arch@lfdr.de>; Thu,  7 Dec 2023 15:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABFF44C93;
	Thu,  7 Dec 2023 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mz/wOiEC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094A54594E;
	Thu,  7 Dec 2023 15:35:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8582DC433AD;
	Thu,  7 Dec 2023 15:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701963316;
	bh=GX1JJEdl3nBIPUgvKvrvyG3QPg50ra5uqsG8fD9kqBk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mz/wOiECHCVR1Lz74BNfGrVpl75pi4T1SmdNhY7T5tllzwvHekJAKY+DnlhOdAJ3H
	 Y5ET2/EfKwazOw1UTaJeeVu74l04i5jYhNIEy1L2Z2z6ZHuM0TDun+Tdj+cig5PmlS
	 yDK+FLExVUpT0R5XuaZ9WbDFDV/WKCUuMsBVjWNUSxth1pqW62e88T58K444wwlrZn
	 Z6sEM2E99OWA1wwwE7tbnvv935G2s6uoEpKMjI7mHkiHNAdAE1YTcgQZ1GS3U88oiP
	 gTd7Zjm9pdWTskE52YIYsPXPKUoaVgu+iSzbE6ZSSy0H8O7+/l6TKFn0yOnU+gv8Xe
	 da57Lx0/Ymf8g==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2c9eca5bbaeso11055361fa.3;
        Thu, 07 Dec 2023 07:35:16 -0800 (PST)
X-Gm-Message-State: AOJu0Ywc97LuL7Z11n9vC6iKMixZRw+byohIi3XdAxR0zef+lA4tk76P
	PfFfTyDPDarXw14Lfi9RdNBr1V8rGuOiphPCrew=
X-Google-Smtp-Source: AGHT+IF/q/lLjgFbSPGy960Lqp10I7G5W6vbxblvpjxeewdLqSpG5SEUTfucABSTKcFVGKtdRrUOTAdXb/YyFHWnbEc=
X-Received: by 2002:a2e:7c15:0:b0:2c9:f2a5:7145 with SMTP id
 x21-20020a2e7c15000000b002c9f2a57145mr888908ljc.142.1701963314593; Thu, 07
 Dec 2023 07:35:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206125433.18420-1-tzimmermann@suse.de> <20231206125433.18420-2-tzimmermann@suse.de>
In-Reply-To: <20231206125433.18420-2-tzimmermann@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 7 Dec 2023 16:35:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEOXh10v7dz-Y4hVM0y1VxR3YFxSxuE9a3wE0LbMsy2UA@mail.gmail.com>
Message-ID: <CAMj1kXEOXh10v7dz-Y4hVM0y1VxR3YFxSxuE9a3wE0LbMsy2UA@mail.gmail.com>
Subject: Re: [PATCH 1/3] arch/x86: Move struct pci_setup_rom into pci_setup.h
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

Hello Thomas,

On Wed, 6 Dec 2023 at 13:54, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> The type definition of struct pci_setup_rom in <asm/pci.h> requires
> struct setup_data from <asm/bootparam.h>. Many drivers include
> <linux/pci.h>, but do not use boot parameters. Changes to bootparam.h
> or its included header files could easily trigger a large, unnecessary
> rebuild of the kernel.
>
> Moving struct pci_setup_rom into its own header file avoid including
> <asm/bootparam.h> in <asm/pci.h>. Update the only two users of the
> struct in the x86 PCI code and in the EFI code. Also remove the include
> statement for x86_init.h, which is unnecessary but pulls in bootparams.h.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  arch/x86/include/asm/pci.h              | 13 -------------
>  arch/x86/include/asm/pci_setup.h        | 19 +++++++++++++++++++
>  arch/x86/pci/common.c                   |  1 +
>  drivers/firmware/efi/libstub/x86-stub.c |  1 +
>  4 files changed, 21 insertions(+), 13 deletions(-)
>  create mode 100644 arch/x86/include/asm/pci_setup.h
>

Thanks for cleaning this up.

Would it be more appropriate to move all setup_data related
definitions into a separate header entirely?

- the SETUP_ defines
- struct setup_data
- struct pci_setup_rom
- struct   jailhouse_setup_data
etc etc

struct setup_header has a setup_data field which is the root of the
setup_data linked list, but it is typed as __u64 so it doesn't
actually need to know the real type of the associated structs.

That way, you can avoid creating a special asm/pci_setup.h that only
covers this one particular definition.



> diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> index b40c462b4af3..b3ab80a03365 100644
> --- a/arch/x86/include/asm/pci.h
> +++ b/arch/x86/include/asm/pci.h
> @@ -10,7 +10,6 @@
>  #include <linux/numa.h>
>  #include <asm/io.h>
>  #include <asm/memtype.h>
> -#include <asm/x86_init.h>
>
>  struct pci_sysdata {
>         int             domain;         /* PCI domain */
> @@ -124,16 +123,4 @@ cpumask_of_pcibus(const struct pci_bus *bus)
>  }
>  #endif
>
> -struct pci_setup_rom {
> -       struct setup_data data;
> -       uint16_t vendor;
> -       uint16_t devid;
> -       uint64_t pcilen;
> -       unsigned long segment;
> -       unsigned long bus;
> -       unsigned long device;
> -       unsigned long function;
> -       uint8_t romdata[];
> -};
> -
>  #endif /* _ASM_X86_PCI_H */
> diff --git a/arch/x86/include/asm/pci_setup.h b/arch/x86/include/asm/pci_setup.h
> new file mode 100644
> index 000000000000..b4b246ef6f2b
> --- /dev/null
> +++ b/arch/x86/include/asm/pci_setup.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_PCI_SETUP_H
> +#define _ASM_X86_PCI_SETUP_H
> +
> +#include <asm/bootparam.h>
> +
> +struct pci_setup_rom {
> +       struct setup_data data;
> +       uint16_t vendor;
> +       uint16_t devid;
> +       uint64_t pcilen;
> +       unsigned long segment;
> +       unsigned long bus;
> +       unsigned long device;
> +       unsigned long function;
> +       uint8_t romdata[];
> +};
> +
> +#endif /* _ASM_X86_PCI_SETUP_H */
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index ddb798603201..c6cbb9182160 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -17,6 +17,7 @@
>  #include <asm/segment.h>
>  #include <asm/io.h>
>  #include <asm/smp.h>
> +#include <asm/pci_setup.h>
>  #include <asm/pci_x86.h>
>  #include <asm/setup.h>
>  #include <asm/irqdomain.h>
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 1bfdae34df39..0c878ebe5257 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -17,6 +17,7 @@
>  #include <asm/boot.h>
>  #include <asm/kaslr.h>
>  #include <asm/sev.h>
> +#include <asm/pci_setup.h>
>
>  #include "efistub.h"
>  #include "x86-stub.h"
> --
> 2.43.0
>

