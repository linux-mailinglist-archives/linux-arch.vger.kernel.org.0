Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C07B16BFB2
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2020 12:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgBYLfQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Feb 2020 06:35:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45592 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbgBYLfQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 06:35:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id g3so14261919wrs.12
        for <linux-arch@vger.kernel.org>; Tue, 25 Feb 2020 03:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=LY6biZcm8R/QrClAZ/HsTb1RNT08TvHG0vUt4da2h60=;
        b=kh93uXgTimo3chBQN5mtRomSyg65ssTDVJ1sQ8/Lkcw1psBzp9A1ia9oUVj/ZcIbL0
         01HoGIK3tt/WCz2XZK/vKieqGLblqAXbj8P96i0d4oXKQyAD9lj1GaPuomqGKPUUXc+s
         4kLY3kpP04gTZq8zgkdsj27rFR1NfPSWs8nklbRSbTvhsYWx+gYpgIHxwFzoiOngg5zd
         PHoFbtRWGSOz+4O4EoDbbZ5bezMFqBR49BZ5h4YlHqlUu98VSnhys+ixmMB+u55gMsFx
         cuge2g3UjN8t993G5c6AF+aTz+K+4AdIQlYY9AJs8r+Cjvx8JBECfVg2x5LBNOXfbBH8
         2dHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=LY6biZcm8R/QrClAZ/HsTb1RNT08TvHG0vUt4da2h60=;
        b=X7XjpAxcPMOF6T8g3nq2YMGm1RHnhM98l0J7QofvqStE+70XQboc3ZWWMQXKt3PfxC
         RhGJvdhrrM4LFdU80MLdfH3b17q7cYNqKeS+2qMfU3uJIB0LZXYTR9i9981tt2kZx6oU
         jPsk7dPDTurRfQY4oVkNgApQ+hbiCGKehxAZaf06kSijPuzSiNNzxSBuEHswSbJzwkgc
         JScEA5Gq9lXq2w3TmN1/JYBytFaZWwVmUJM0NecDolVWyCQftMl+XgpvCd1H3IuHlV2n
         eCrsWl7h+mSfDeJ2FoFJq/4kP30oYFRhqrC3bgdVstHH1aq0SJlRlgMW+PamFYg8HT1h
         mEDg==
X-Gm-Message-State: APjAAAXITRjfIKXjRt9wI+u8cgLdxWPRSdB2yxYbKDLtpCqn6L4XHEEy
        N1UQMgwzoRXSRsFoBAeyMqm6Ig==
X-Google-Smtp-Source: APXvYqwrEqKO6Tw3Nnk5DX0NtnB3x9gBegcco4xab3I71PkNSN9xePRcLcP2cFfPKsA5zuVHOOmVXA==
X-Received: by 2002:adf:e543:: with SMTP id z3mr70859994wrm.369.1582630512651;
        Tue, 25 Feb 2020 03:35:12 -0800 (PST)
Received: from [74.125.206.108] ([149.199.62.130])
        by smtp.gmail.com with ESMTPSA id v14sm19271415wrm.30.2020.02.25.03.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 03:35:11 -0800 (PST)
Subject: Re: [PATCH 00/10] Hi,
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, git@xilinx.com, arnd@arndb.de
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Cornelia Huck <cohuck@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mubin Sayyed <mubinusm@xilinx.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
References: <cover.1581497860.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Autocrypt: addr=monstr@monstr.eu; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <bb01ba1d-49a4-6827-b2ef-18475cea18f7@monstr.eu>
Date:   Tue, 25 Feb 2020 12:34:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cover.1581497860.git.michal.simek@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="LZHPN2jpshxJTPpehPN2oomZ5ViUkpu3G"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LZHPN2jpshxJTPpehPN2oomZ5ViUkpu3G
Content-Type: multipart/mixed; boundary="c2rUlmsk1qexDFpBjgpaV7Nn62sVlDOPV";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org,
 git@xilinx.com, arnd@arndb.de
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Arvind Sankar <nivedita@alum.mit.edu>, Borislav Petkov <bp@suse.de>,
 Cornelia Huck <cohuck@redhat.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Greg Ungerer <gerg@linux-m68k.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook
 <keescook@chromium.org>, Masahiro Yamada <yamada.masahiro@socionext.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Mubin Sayyed <mubinusm@xilinx.com>,
 Nicholas Piggin <npiggin@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>,
 Rob Herring <robh@kernel.org>,
 Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
 Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com>,
 Stefan Asserhall <stefan.asserhall@xilinx.com>,
 Vladimir Murzin <vladimir.murzin@arm.com>, Will Deacon <will@kernel.org>,
 linux-arch@vger.kernel.org, linux-mm@kvack.org
Message-ID: <bb01ba1d-49a4-6827-b2ef-18475cea18f7@monstr.eu>
Subject: Re: [PATCH 00/10] Hi,
References: <cover.1581497860.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1581497860.git.michal.simek@xilinx.com>

--c2rUlmsk1qexDFpBjgpaV7Nn62sVlDOPV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12. 02. 20 9:57, Michal Simek wrote:
>=20
> I am sending this series as before SMP support.
> Most of these patches are clean ups and should be easy to review them. =
I
> expect there will be more discussions about SMP support.
>=20
> There could be some optimization added based on
> https://lkml.org/lkml/2020/2/10/1528
>=20
> Thanks,
> Michal
>=20
>=20
> Michal Simek (6):
>   microblaze: Convert headers to SPDX license
>   microblaze: Remove architecture tlb.h and use generic one
>   microblaze: Remove early printk setup
>   microblaze: Remove empty headers
>   microblaze: Remove unused boot_cpuid variable
>   microblaze: Use asm generic cmpxchg.h for !SMP case
>=20
> Stefan Asserhall (4):
>   microblaze: Define microblaze barrier
>   microblaze: Add sync to tlb operations
>   microblaze: Add missing irqflags.h header
>   microblaze: Define percpu sestion in linker file
>=20
>  arch/microblaze/include/asm/Kbuild            |  4 +-
>  arch/microblaze/include/asm/barrier.h         | 13 ++++++
>  arch/microblaze/include/asm/cache.h           |  5 +--
>  arch/microblaze/include/asm/cacheflush.h      |  6 +--
>  arch/microblaze/include/asm/checksum.h        |  5 +--
>  arch/microblaze/include/asm/cmpxchg.h         | 40 ++-----------------=

>  arch/microblaze/include/asm/cpuinfo.h         |  5 +--
>  arch/microblaze/include/asm/cputable.h        |  1 -
>  arch/microblaze/include/asm/current.h         |  5 +--
>  arch/microblaze/include/asm/delay.h           |  7 +---
>  arch/microblaze/include/asm/dma.h             |  5 +--
>  arch/microblaze/include/asm/elf.h             |  5 +--
>  arch/microblaze/include/asm/entry.h           |  5 +--
>  arch/microblaze/include/asm/exceptions.h      |  5 +--
>  arch/microblaze/include/asm/fixmap.h          |  5 +--
>  arch/microblaze/include/asm/flat.h            |  5 +--
>  arch/microblaze/include/asm/hw_irq.h          |  1 -
>  arch/microblaze/include/asm/io.h              |  5 +--
>  arch/microblaze/include/asm/irq.h             |  5 +--
>  arch/microblaze/include/asm/irqflags.h        |  5 +--
>  arch/microblaze/include/asm/mmu.h             |  5 +--
>  arch/microblaze/include/asm/mmu_context_mm.h  |  5 +--
>  arch/microblaze/include/asm/module.h          |  5 +--
>  arch/microblaze/include/asm/page.h            |  5 +--
>  arch/microblaze/include/asm/pgalloc.h         |  5 +--
>  arch/microblaze/include/asm/pgtable.h         |  5 +--
>  arch/microblaze/include/asm/processor.h       |  5 +--
>  arch/microblaze/include/asm/ptrace.h          |  5 +--
>  arch/microblaze/include/asm/pvr.h             |  5 +--
>  arch/microblaze/include/asm/registers.h       |  5 +--
>  arch/microblaze/include/asm/sections.h        |  5 +--
>  arch/microblaze/include/asm/setup.h           |  7 +---
>  arch/microblaze/include/asm/string.h          |  5 +--
>  arch/microblaze/include/asm/switch_to.h       |  5 +--
>  arch/microblaze/include/asm/thread_info.h     |  5 +--
>  arch/microblaze/include/asm/timex.h           |  5 +--
>  arch/microblaze/include/asm/tlb.h             | 17 --------
>  arch/microblaze/include/asm/tlbflush.h        |  5 +--
>  arch/microblaze/include/asm/uaccess.h         |  5 +--
>  arch/microblaze/include/asm/unaligned.h       |  5 +--
>  arch/microblaze/include/asm/unistd.h          |  5 +--
>  arch/microblaze/include/asm/unwind.h          |  5 +--
>  arch/microblaze/include/asm/user.h            |  1 -
>  arch/microblaze/kernel/cpu/cpuinfo-pvr-full.c |  7 +---
>  arch/microblaze/kernel/cpu/pvr.c              |  1 +
>  arch/microblaze/kernel/misc.S                 |  3 +-
>  arch/microblaze/kernel/setup.c                |  1 -
>  arch/microblaze/kernel/vmlinux.lds.S          |  3 ++
>  48 files changed, 62 insertions(+), 215 deletions(-)
>  create mode 100644 arch/microblaze/include/asm/barrier.h
>  delete mode 100644 arch/microblaze/include/asm/cputable.h
>  delete mode 100644 arch/microblaze/include/asm/hw_irq.h
>  delete mode 100644 arch/microblaze/include/asm/tlb.h
>  delete mode 100644 arch/microblaze/include/asm/user.h
>=20

applied all.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--c2rUlmsk1qexDFpBjgpaV7Nn62sVlDOPV--

--LZHPN2jpshxJTPpehPN2oomZ5ViUkpu3G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQbPNTMvXmYlBPRwx7KSWXLKUoMIQUCXlUGXwAKCRDKSWXLKUoM
IWakAKCB1Nf50wQlkY3QmenLnoFwU1bVRQCfXM644R24pTsD+kEK+7AWWzPDUeE=
=6NRI
-----END PGP SIGNATURE-----

--LZHPN2jpshxJTPpehPN2oomZ5ViUkpu3G--
