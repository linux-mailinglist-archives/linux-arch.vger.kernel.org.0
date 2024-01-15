Return-Path: <linux-arch+bounces-1370-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CA982D7DF
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jan 2024 11:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FD31F220D3
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jan 2024 10:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974C41E4B9;
	Mon, 15 Jan 2024 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4IVxdbM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BBB18E00;
	Mon, 15 Jan 2024 10:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC42C43142;
	Mon, 15 Jan 2024 10:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705316150;
	bh=rfREZzmiD9nPW8TbesDDnUUTWye4kt++Bv0KP8PLvFk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A4IVxdbM5n6+Wri6LKPCFt4boNRWCZk+x+FvjGA0rMzBKnTq0PG2P4HgdoibE34JU
	 7I+sl3ic4kVgy6alkJ1V+WOxCGZ2ZCdHvSZazXxPfmb5arAkTMCAyiEierrpoLCjzM
	 Ygj8ldj/YeV7xxWj3T+cJucDy6g0wviAclEb83PQYKh4IA3J10TosGkmbLnZg7vRG5
	 klaKs9ycUq3mSQ8r8jOJecX0Mq/uJGiy1/elHSc22WoW1AxZktex9NE9JrxYS5mS2+
	 cE8gPHQUwUZeynpCd6W3njl/YBfE5cxvvdBerqY16hvAfFGT43Lf9OM8ZBsaDE8gEI
	 oLYOyEDKggW0A==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50eaaf2c7deso9635020e87.2;
        Mon, 15 Jan 2024 02:55:49 -0800 (PST)
X-Gm-Message-State: AOJu0YxdnEmOWayncYpTcwpapO5T9U7QvQyR1lgCXFPUaZhDDk0Xgoa4
	sLHZZC3R7KyEeShjc05qn4OEMu7gpa2F7aSXYxA=
X-Google-Smtp-Source: AGHT+IHjiob4d9Y9lHe/Mg25bV/9NI9KuHdlICb0KG40svce27wXXneGwYvZf40noCzmA0/mYLev+nDZBuyx7BNLBuM=
X-Received: by 2002:a05:6512:130c:b0:50e:df4f:44d7 with SMTP id
 x12-20020a056512130c00b0050edf4f44d7mr2867593lfu.90.1705316148087; Mon, 15
 Jan 2024 02:55:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112095000.8952-1-tzimmermann@suse.de> <CAMj1kXGxNTvCca+9TfUfvp06ppyD9XiyO59khYXg88VkyFm1rw@mail.gmail.com>
 <3e2f70ab-c4de-4fae-9365-4f6f77c847c5@suse.de>
In-Reply-To: <3e2f70ab-c4de-4fae-9365-4f6f77c847c5@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 15 Jan 2024 11:55:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGECo1E1U8jjrzvA=ZJe80DVOi3v5CvxkhXbnBQKVMT8Q@mail.gmail.com>
Message-ID: <CAMj1kXGECo1E1U8jjrzvA=ZJe80DVOi3v5CvxkhXbnBQKVMT8Q@mail.gmail.com>
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

On Mon, 15 Jan 2024 at 08:58, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 12.01.24 um 18:28 schrieb Ard Biesheuvel:
> > On Fri, 12 Jan 2024 at 10:50, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >>
> >> Reduce build time in some cases by removing unnecessary include statements
> >> for <asm/bootparam.h>. Reorganize some header files accordingly.
> >>
> >> While working on the kernel's boot-up graphics, I noticed that touching
> >> include/linux/screen_info.h triggers a complete rebuild of the kernel
> >> on x86. It turns out that the architecture's PCI and EFI headers include
> >> <asm/bootparam.h>, which depends on <linux/screen_info.h>. But none of
> >> the drivers have any business with boot parameters or the screen_info
> >> state.
> >>
> >> The patchset moves code from bootparam.h and efi.h into separate header
> >> files and removes obsolete include statements on x86. I did
> >>
> >>    make allmodconfig
> >>    make -j28
> >>    touch include/linux/screen_info.h
> >>    time make -j28
> >>
> >> to measure the time it takes to rebuild. Results without the patchset
> >> are around 20 minutes.
> >>
> >>    real    20m46,705s
> >>    user    354m29,166s
> >>    sys     28m27,359s
> >>
> >> And with the patchset applied it goes down to less than one minute.
> >>
> >>    real    0m56,643s
> >>    user    4m0,661s
> >>    sys     0m32,956s
> >>
> >> The test system is an Intel i5-13500.
> >>
> >> v5:
> >>          * silence clang warnings for real-mode code (Nathan)
> >>          * revert boot/compressed/misc.h (kernel test robot)
> >> v4:
> >>          * fix fwd declaration in compressed/misc.h (Ard)
> >> v3:
> >>          * keep setup_header in bootparam.h (Ard)
> >>          * implement arch_ima_efi_boot_mode() in source file (Ard)
> >> v2:
> >>          * only keep struct boot_params in bootparam.h (Ard)
> >>          * simplify arch_ima_efi_boot_mode define (Ard)
> >>          * updated cover letter
> >>
> >> Thomas Zimmermann (4):
> >>    arch/x86: Move UAPI setup structures into setup_data.h
> >>    arch/x86: Move internal setup_data structures into setup_data.h
> >>    arch/x86: Implement arch_ima_efi_boot_mode() in source file
> >>    arch/x86: Do not include <asm/bootparam.h> in several files
> >>
> >
> > This looks ok to me, thanks for sticking with it.
> >
> > For the series,
> >
> > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
>
> Thank you so much. Can this series go through the x86 tree?
>

Yes, this should be taken through the -tip tree. But I am not a -tip maintainer.

But please be aware that we are in the middle of the merge window
right now, and I suspect that the -tip maintainers may have some
feedback of their own. So give it at least a week or so, and ping this
thread again to ask how to proceed.

Also, please trim the cc list a bit when you do - this is mostly a x86
specific reshuffle of headers so no need to keep all the other
subsystem maintainers on cc while we finish up the discussion.

