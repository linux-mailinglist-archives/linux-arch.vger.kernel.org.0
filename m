Return-Path: <linux-arch+bounces-1240-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88DB822E08
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jan 2024 14:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984752853DA
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jan 2024 13:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2861946F;
	Wed,  3 Jan 2024 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjiXUhhX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B901F1945C;
	Wed,  3 Jan 2024 13:11:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A78C433C7;
	Wed,  3 Jan 2024 13:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704287514;
	bh=qIhmbs4q19ce2u3+/p/L4uydu2guvXDqASx18xBCCcw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YjiXUhhXpqumwXKQPMqpkdB4wPrRMy0bOzR1kahYVY1+qE5n7Z4haXZSfzT55IAI1
	 ynnt4aDFeWwdn3Bmo5Bfg3xsBbD4VmuDjTgmQqqSG0Dix3Qw+sRw31WGG1TTPzsztY
	 xEBVl2pFbuK9dXt2+f5UHWoEFd+owy0H5XKrkZJgan6ykecKAc0NlQ3PixVapEOMsh
	 WZaVatHDS9M7AbWzldR9FtJbZ8YV4Nj0WtHrYRV+9O+mPx3NBqug+uWnuoXIFfBHdv
	 wIXZQatu7fvlr03zk4kPyj4OlIeIKc3RW7eL39FEqzhdIH8rP99VcvF/HkLUMW9Uyc
	 e/qinOLQAN2uw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e766937ddso8433219e87.3;
        Wed, 03 Jan 2024 05:11:54 -0800 (PST)
X-Gm-Message-State: AOJu0Yw7x6HLmhqYQWyCD4Ng8AH0hEZWtJfvJPFXxVvQYICwYEqdc8pj
	k1ASIwzd6P/jUQdMzKHIwexv7bnN81u+UYHAWIU=
X-Google-Smtp-Source: AGHT+IH2AecowZ+aHnkLeMgGIy725oLMF333U21alEK2Fc5uT7O22wyPK+unkG3ON5Ldu0WACaHrxvakM17+AqJ7PHk=
X-Received: by 2002:ac2:5190:0:b0:50e:aa04:b2e9 with SMTP id
 u16-20020ac25190000000b0050eaa04b2e9mr24496lfi.39.1704287512452; Wed, 03 Jan
 2024 05:11:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215122614.5481-1-tzimmermann@suse.de> <20231215122614.5481-3-tzimmermann@suse.de>
 <CAMj1kXHrn-PxpMGnR4VoHv7kHvQYyf8SS9i1irm9Gi_uBseciw@mail.gmail.com> <97f118fc-b38f-4bcc-83d3-4d3c13edf7a0@suse.de>
In-Reply-To: <97f118fc-b38f-4bcc-83d3-4d3c13edf7a0@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 3 Jan 2024 14:11:40 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF-1TXYzheS-e_rGKnV+6FrkZe+e2sfCixyUzxSQE7X6w@mail.gmail.com>
Message-ID: <CAMj1kXF-1TXYzheS-e_rGKnV+6FrkZe+e2sfCixyUzxSQE7X6w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arch/x86: Add <asm/ima-efi.h> for arch_ima_efi_boot_mode
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

On Tue, 2 Jan 2024 at 15:07, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hii Ard
>
> Am 19.12.23 um 12:38 schrieb Ard Biesheuvel:
> > Hi Thomas,
> >
> > On Fri, 15 Dec 2023 at 13:26, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >>
> >> The header file <asm/efi.h> contains the macro arch_ima_efi_boot_mode,
> >> which expands to use struct boot_params from <asm/bootparams.h>. Many
> >> drivers include <linux/efi.h>, but do not use boot parameters. Changes
> >> to bootparam.h or its included headers can easily trigger large,
> >> unnessary rebuilds of the kernel.
> >>
> >> Moving x86's arch_ima_efi_boot_mode to <asm/ima-efi.h> and including
> >> <asm/setup.h> separates that dependency from the rest of the EFI
> >> interfaces. The only user is in ima_efi.c. As the file already declares
> >> a default value for arch_ima_efi_boot_mode, move this define into
> >> asm-generic for all other architectures.
> >>
> >> With arch_ima_efi_boot_mode removed from efi.h, <asm/bootparam.h> can
> >> later be removed from further x86 header files.
> >>
> >
> > Apologies if I missed this in v1 but is the new asm-generic header
> > really necessary? Could we instead turn arch_ima_efi_boot_mode into a
> > function that is a static inline { return unset; } by default, but can
> > be emitted out of line in one of the x86/platform/efi.c source files,
> > where referring to boot_params is fine?
>
> I cannot figure out how to do this without *something* in asm-generic or
> adding if-CONFIG_X86 guards in ima-efi.c.
>
> But I noticed that linux/efi.h already contains 2 or 3 ifdef branches
> for x86. Would it be an option to move this code into asm/efi.h
> (including a header file in asm-generic for the non-x86 variants) and
> add the arch_ima_efi_boot_mode() helper there as well?  At least that
> wouldn't be a header for only a single define.
>

Could we just move the x86 implementation out of line?

So something like this in arch/x86/include/asm/efi.h

enum efi_secureboot_mode x86_ima_efi_boot_mode(void);
#define arch_ima_efi_boot_mode x86_ima_efi_boot_mode()

and an implementation in one of the related .c files:

enum efi_secureboot_mode x86_ima_efi_boot_mode(void)
{
    return boot_params.secure_boot;
}

?

