Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD360221A64
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 04:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgGPC7b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jul 2020 22:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgGPC7a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jul 2020 22:59:30 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9888C061755;
        Wed, 15 Jul 2020 19:59:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B6f9W42bZz9sRK;
        Thu, 16 Jul 2020 12:59:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1594868368;
        bh=jzbuvvlMTLS4EHeC88n/VPIkgVW18hN1jUzcnLgJ8d8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KMMinymWhupPskkr7ijdgeKRQBfmcQ4UD12mWc7vxc+iRvR808D5wY8Mj/qG7RzH1
         OHI/TsSDwoR7pyjvHq/2M9xVkWbTVyIx7qfuWkbqTBZq8UU8nXRDct3ncuimUMoMmi
         KCZyddshC1iZkGKtl12ydu6Z03cBSK3qenn+FwbYwRwNypcN9XciDtMxTYBXwn0QUB
         0/rY8qC6joGsomWAVYkgt7g268mAUpFLF4Q6e1Z/MgSQrrOl3BVPOjUd4iBr9ABxKd
         b76to3OCrSbin7CCh/LrEhpoqSSCIxaCAC9VJZiS1TVle+0mUSbEVuqxX+UIW1QuN1
         DhJ20PPAVjEhw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, nathanl@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com,
        luto@kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v8 2/8] powerpc/vdso: Remove __kernel_datapage_offset and simplify __get_datapage()
In-Reply-To: <0d2201efe3c7727f2acc718aefd7c5bb22c66c57.1588079622.git.christophe.leroy@c-s.fr>
References: <cover.1588079622.git.christophe.leroy@c-s.fr> <0d2201efe3c7727f2acc718aefd7c5bb22c66c57.1588079622.git.christophe.leroy@c-s.fr>
Date:   Thu, 16 Jul 2020 12:59:23 +1000
Message-ID: <87wo34tbas.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> The VDSO datapage and the text pages are always located immediately
> next to each other, so it can be hardcoded without an indirection
> through __kernel_datapage_offset
>
> In order to ease things, move the data page in front like other
> arches, that way there is no need to know the size of the library
> to locate the data page.
>
> Before:
> clock-getres-realtime-coarse:    vdso: 714 nsec/call
> clock-gettime-realtime-coarse:    vdso: 792 nsec/call
> clock-gettime-realtime:    vdso: 1243 nsec/call
>
> After:
> clock-getres-realtime-coarse:    vdso: 699 nsec/call
> clock-gettime-realtime-coarse:    vdso: 784 nsec/call
> clock-gettime-realtime:    vdso: 1231 nsec/call
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> v7:
> - Moved the removal of the tmp param of __get_datapage()
> in a subsequent patch
> - Included the addition of the offset param to __get_datapage()
> in the further preparatory patch
> ---
>  arch/powerpc/include/asm/vdso_datapage.h |  8 ++--
>  arch/powerpc/kernel/vdso.c               | 53 ++++--------------------
>  arch/powerpc/kernel/vdso32/datapage.S    |  3 --
>  arch/powerpc/kernel/vdso32/vdso32.lds.S  |  7 +---
>  arch/powerpc/kernel/vdso64/datapage.S    |  3 --
>  arch/powerpc/kernel/vdso64/vdso64.lds.S  |  7 +---
>  6 files changed, 16 insertions(+), 65 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/asm/vdso_datapage.h
> index b9ef6cf50ea5..11886467dfdf 100644
> --- a/arch/powerpc/include/asm/vdso_datapage.h
> +++ b/arch/powerpc/include/asm/vdso_datapage.h
> @@ -118,10 +118,12 @@ extern struct vdso_data *vdso_data;
>  
>  .macro get_datapage ptr, tmp
>  	bcl	20, 31, .+4
> +999:
>  	mflr	\ptr
> -	addi	\ptr, \ptr, (__kernel_datapage_offset - (.-4))@l
> -	lwz	\tmp, 0(\ptr)
> -	add	\ptr, \tmp, \ptr
> +#if CONFIG_PPC_PAGE_SHIFT > 14
> +	addis	\ptr, \ptr, (_vdso_datapage - 999b)@ha
> +#endif
> +	addi	\ptr, \ptr, (_vdso_datapage - 999b)@l
>  .endm
>  
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
> index f38f26e844b6..d33fa22ddbed 100644
> --- a/arch/powerpc/kernel/vdso.c
> +++ b/arch/powerpc/kernel/vdso.c
> @@ -190,7 +190,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>  	 * install_special_mapping or the perf counter mmap tracking code
>  	 * will fail to recognise it as a vDSO (since arch_vma_name fails).
>  	 */
> -	current->mm->context.vdso_base = vdso_base;
> +	current->mm->context.vdso_base = vdso_base + PAGE_SIZE;

I merged this but then realised it breaks the display of the vdso in /proc/self/maps.

ie. the vdso vma gets no name:

  # cat /proc/self/maps
  110f90000-110fa0000 r-xp 00000000 08:03 17021844                         /usr/bin/cat
  110fa0000-110fb0000 r--p 00000000 08:03 17021844                         /usr/bin/cat
  110fb0000-110fc0000 rw-p 00010000 08:03 17021844                         /usr/bin/cat
  126000000-126030000 rw-p 00000000 00:00 0                                [heap]
  7fffa8790000-7fffa87d0000 rw-p 00000000 00:00 0 
  7fffa87d0000-7fffa8830000 r--p 00000000 08:03 17521786                   /usr/lib/locale/en_AU.utf8/LC_CTYPE
  7fffa8830000-7fffa8840000 r--p 00000000 08:03 16958337                   /usr/lib/locale/en_AU.utf8/LC_NUMERIC
  7fffa8840000-7fffa8850000 r--p 00000000 08:03 8501358                    /usr/lib/locale/en_AU.utf8/LC_TIME
  7fffa8850000-7fffa8ad0000 r--p 00000000 08:03 16870886                   /usr/lib/locale/en_AU.utf8/LC_COLLATE
  7fffa8ad0000-7fffa8ae0000 r--p 00000000 08:03 8509433                    /usr/lib/locale/en_AU.utf8/LC_MONETARY
  7fffa8ae0000-7fffa8af0000 r--p 00000000 08:03 25383753                   /usr/lib/locale/en_AU.utf8/LC_MESSAGES/SYS_LC_MESSAGES
  7fffa8af0000-7fffa8b00000 r--p 00000000 08:03 17521790                   /usr/lib/locale/en_AU.utf8/LC_PAPER
  7fffa8b00000-7fffa8b10000 r--p 00000000 08:03 8501354                    /usr/lib/locale/en_AU.utf8/LC_NAME
  7fffa8b10000-7fffa8b20000 r--p 00000000 08:03 8509431                    /usr/lib/locale/en_AU.utf8/LC_ADDRESS
  7fffa8b20000-7fffa8b30000 r--p 00000000 08:03 8509434                    /usr/lib/locale/en_AU.utf8/LC_TELEPHONE
  7fffa8b30000-7fffa8b40000 r--p 00000000 08:03 17521787                   /usr/lib/locale/en_AU.utf8/LC_MEASUREMENT
  7fffa8b40000-7fffa8b50000 r--s 00000000 08:03 25623315                   /usr/lib64/gconv/gconv-modules.cache
  7fffa8b50000-7fffa8d40000 r-xp 00000000 08:03 25383789                   /usr/lib64/libc-2.30.so
  7fffa8d40000-7fffa8d50000 r--p 001e0000 08:03 25383789                   /usr/lib64/libc-2.30.so
  7fffa8d50000-7fffa8d60000 rw-p 001f0000 08:03 25383789                   /usr/lib64/libc-2.30.so
  7fffa8d60000-7fffa8d70000 r--p 00000000 08:03 8509432                    /usr/lib/locale/en_AU.utf8/LC_IDENTIFICATION
  7fffa8d70000-7fffa8d90000 r-xp 00000000 00:00 0						<--- missing
  7fffa8d90000-7fffa8dc0000 r-xp 00000000 08:03 25383781                   /usr/lib64/ld-2.30.so
  7fffa8dc0000-7fffa8dd0000 r--p 00020000 08:03 25383781                   /usr/lib64/ld-2.30.so
  7fffa8dd0000-7fffa8de0000 rw-p 00030000 08:03 25383781                   /usr/lib64/ld-2.30.so
  7fffc31c0000-7fffc31f0000 rw-p 00000000 00:00 0                          [stack]


And it's also going to break the logic in arch_unmap() to detect if
we're unmapping (part of) the VDSO. And it will break arch_remap() too.

And the logic to recognise the signal trampoline in
arch/powerpc/perf/callchain_*.c as well.

So I'm going to rebase and drop this for now.

Basically we have a bunch of places that assume that vdso_base is == the
start of the VDSO vma, and also that the code starts there. So that will
need some work to tease out all those assumptions and make them work
with this change.

cheers
