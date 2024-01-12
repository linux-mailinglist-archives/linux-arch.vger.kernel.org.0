Return-Path: <linux-arch+bounces-1367-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610F082C4B1
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jan 2024 18:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877BA1C22142
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jan 2024 17:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCD52262C;
	Fri, 12 Jan 2024 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/6K2Dib"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743BF22626;
	Fri, 12 Jan 2024 17:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D4DC43330;
	Fri, 12 Jan 2024 17:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705080547;
	bh=jssAwbuPxvN7TZtNLg2pY60C9/BU5tslVku5TmAKZdw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c/6K2Dib9ffLTtP8V3/i61Poz6aqFNtuEEiSH0No09eQkAnvZjXt3iRP+NM8lpPGf
	 rfNOdrI5hPYSrKpRznCK4RiWlk1LTqHjExhvF6deHyxnrKjrTthONGs8tQN09BJyf+
	 ZNGF3PNfHa6Te4/El8O2JyvHYWpOjCcA40X44RODeJz3hvWAishkave2Lcm354ZJc2
	 mys6CNHCSLP8C9gXnK28wYuqNQA0WLGIbfTwVqJZuQnYdLrK4TWSLuE/PlqXv1o0oU
	 8tdoLtWgTzcqN2SvAVAkkn1JH7Uv1B7TActqvkq91t/8/IVXMpok59UqhgkZGnQnRI
	 waDPJr64KryrA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e7dd8bce8so7970180e87.1;
        Fri, 12 Jan 2024 09:29:07 -0800 (PST)
X-Gm-Message-State: AOJu0YxRpTl3mvhOMIuewhyMF3yah9db0Z7hRUc/woI05YEWclUkEUzL
	kmQQFgj+KrydHIDBxj8sIN133EXjWUnpIhRSdtY=
X-Google-Smtp-Source: AGHT+IHv4U6Bv1CLMGqgczNTVhhcMsKubjnAMrFM7bbub8DgPF2lBHnCeeFTbjYR9e4eTnYIRgHyWdZc6b2WsJsdG64=
X-Received: by 2002:a05:6512:39d2:b0:50e:7b01:70df with SMTP id
 k18-20020a05651239d200b0050e7b0170dfmr1134504lfu.72.1705080545496; Fri, 12
 Jan 2024 09:29:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112095000.8952-1-tzimmermann@suse.de>
In-Reply-To: <20240112095000.8952-1-tzimmermann@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 12 Jan 2024 18:28:53 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGxNTvCca+9TfUfvp06ppyD9XiyO59khYXg88VkyFm1rw@mail.gmail.com>
Message-ID: <CAMj1kXGxNTvCca+9TfUfvp06ppyD9XiyO59khYXg88VkyFm1rw@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] arch/x86: Remove unnecessary dependencies on bootparam.h
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: nathan@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	bhelgaas@google.com, arnd@arndb.de, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, javierm@redhat.com, linux-arch@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jan 2024 at 10:50, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Reduce build time in some cases by removing unnecessary include statements
> for <asm/bootparam.h>. Reorganize some header files accordingly.
>
> While working on the kernel's boot-up graphics, I noticed that touching
> include/linux/screen_info.h triggers a complete rebuild of the kernel
> on x86. It turns out that the architecture's PCI and EFI headers include
> <asm/bootparam.h>, which depends on <linux/screen_info.h>. But none of
> the drivers have any business with boot parameters or the screen_info
> state.
>
> The patchset moves code from bootparam.h and efi.h into separate header
> files and removes obsolete include statements on x86. I did
>
>   make allmodconfig
>   make -j28
>   touch include/linux/screen_info.h
>   time make -j28
>
> to measure the time it takes to rebuild. Results without the patchset
> are around 20 minutes.
>
>   real    20m46,705s
>   user    354m29,166s
>   sys     28m27,359s
>
> And with the patchset applied it goes down to less than one minute.
>
>   real    0m56,643s
>   user    4m0,661s
>   sys     0m32,956s
>
> The test system is an Intel i5-13500.
>
> v5:
>         * silence clang warnings for real-mode code (Nathan)
>         * revert boot/compressed/misc.h (kernel test robot)
> v4:
>         * fix fwd declaration in compressed/misc.h (Ard)
> v3:
>         * keep setup_header in bootparam.h (Ard)
>         * implement arch_ima_efi_boot_mode() in source file (Ard)
> v2:
>         * only keep struct boot_params in bootparam.h (Ard)
>         * simplify arch_ima_efi_boot_mode define (Ard)
>         * updated cover letter
>
> Thomas Zimmermann (4):
>   arch/x86: Move UAPI setup structures into setup_data.h
>   arch/x86: Move internal setup_data structures into setup_data.h
>   arch/x86: Implement arch_ima_efi_boot_mode() in source file
>   arch/x86: Do not include <asm/bootparam.h> in several files
>

This looks ok to me, thanks for sticking with it.

For the series,

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

