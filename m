Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7A091518D0
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2020 11:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgBDKbX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Feb 2020 05:31:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46767 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgBDKbX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Feb 2020 05:31:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so22207900wrl.13
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2020 02:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=yrtra2ee+KLVOttd4bXZYdK9YXYtwBJf0l2O9Xpk63w=;
        b=T3LmiWCzexeHLHNbYatPJHQ1Jzu/Dfe6b91IWZnWDttMbj7NlluOZ4VbcqwqVz7//x
         LG9uDNGgWBZWg6kdJcgRrp/tWhBSC7AtLVjAG38MV1e2YuhzfYkHbTb8bESg5pYUn2g6
         mTBy8LOv0U8zO988akhwj5miebzX2id3YKATYKcicNb+fmzgXCtiFtRUBsbnZ+4qqtyq
         NphLTD94p3e2yfpafymvvbenC5CBwsTGmjNOQovWOOBASmREc66RhowyuOpGicGWWVAa
         iXSNU7q8H8k/8FTuBEfHRg+VPRJWUTbCZa1jwb6Cepv2+g5QlBqWa2XjyOicuaFnEHHV
         Lo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=yrtra2ee+KLVOttd4bXZYdK9YXYtwBJf0l2O9Xpk63w=;
        b=DFtiADS7hGP/X9lHLsCpCYFkaZm1y1zfJ8rNrC5bWs8FsgrNwtui1qdqpF+Fr+78jo
         l4Bl0SH9R2Njx+RiEf3iCua81fXhUZUdaewHyANDXI3Ns1g2BrtqkvQ3vz7kGAgsFmhN
         S3fU1VwTVQwo3/+7/8gakBxC5uHcbswxISG30aay1jo01oJP/hCRH1dpTRdO5N6y61ZP
         EvwG5clfY9MNAFOHXtSQsoxTpYMq6euXI1j4MpAnpdE80ugogMeJrA5NEzJICKNypZrb
         Qu2U8yU8QfsQkilL34v5ElwlcYj5F/kLOUOhEOSUNC7dKzFDkpDGm/3FjZ3166ChRiiM
         Hsgg==
X-Gm-Message-State: APjAAAWTYDy9Xue6NKS0IW2+yBa2R64oMFNKrsAg7Kh+Zao+PNjtOFWx
        KTBLk9sOw5cySI9+xaCVULZBBw==
X-Google-Smtp-Source: APXvYqzbzEy2S2mIksTlB/Be+HGMhTUe5EtNkl2cNi6/3J3nu2RvrRvZ8lWYtbHpC136cTDN5i5+Ig==
X-Received: by 2002:adf:ea8a:: with SMTP id s10mr20395994wrm.278.1580812278888;
        Tue, 04 Feb 2020 02:31:18 -0800 (PST)
Received: from [173.194.76.109] ([149.199.62.130])
        by smtp.gmail.com with ESMTPSA id r5sm29620132wrt.43.2020.02.04.02.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 02:31:17 -0800 (PST)
Subject: Re: [PATCH v2 0/2] microblaze: Enable CMA
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Christoph Hellwig <hch@lst.de>
Cc:     Paul Burton <paulburton@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Manjukumar Matha <manjukumar.harthikote-matha@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mips@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        x86@kernel.org, Guo Ren <guoren@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Wesley Terpstra <wesley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Manish Narani <manish.narani@xilinx.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Vasily Gorbik <gor@linux.ibm.com>,
        James Hogan <jhogan@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Guo Ren <ren_guo@c-sky.com>
References: <cover.1579248206.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Autocrypt: addr=monstr@monstr.eu; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <5706978d-4c9a-1123-c34b-e19e2b8aa37f@monstr.eu>
Date:   Tue, 4 Feb 2020 11:30:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cover.1579248206.git.michal.simek@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pBOm8rNjCoJTkwKyfl4Ed8HeJH77Ps32T"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pBOm8rNjCoJTkwKyfl4Ed8HeJH77Ps32T
Content-Type: multipart/mixed; boundary="BbuWsr0XsV2TagfAoYrRnS0Lcvh9jdEaZ";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org,
 monstr@monstr.eu, git@xilinx.com, Christoph Hellwig <hch@lst.de>
Cc: Paul Burton <paulburton@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Mike Rapoport <rppt@linux.ibm.com>,
 Manjukumar Matha <manjukumar.harthikote-matha@xilinx.com>,
 Borislav Petkov <bp@alien8.de>, Linus Walleij <linus.walleij@linaro.org>,
 linux-mips@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, x86@kernel.org,
 Guo Ren <guoren@kernel.org>, Kate Stewart <kstewart@linuxfoundation.org>,
 Wesley Terpstra <wesley@sifive.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Andrew Morton <akpm@linux-foundation.org>,
 Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Will Deacon <will@kernel.org>, Christian Borntraeger
 <borntraeger@de.ibm.com>, Deepa Dinamani <deepa.kernel@gmail.com>,
 Chris Zankel <chris@zankel.net>, Manish Narani <manish.narani@xilinx.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
 Vasily Gorbik <gor@linux.ibm.com>, James Hogan <jhogan@kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Guo Ren <ren_guo@c-sky.com>
Message-ID: <5706978d-4c9a-1123-c34b-e19e2b8aa37f@monstr.eu>
Subject: Re: [PATCH v2 0/2] microblaze: Enable CMA
References: <cover.1579248206.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1579248206.git.michal.simek@xilinx.com>

--BbuWsr0XsV2TagfAoYrRnS0Lcvh9jdEaZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17. 01. 20 9:03, Michal Simek wrote:
> Hi,
>=20
> the patchset enable CMA on Microblaze. Based on Christoph request I hav=
e
> created the first patch which makes dma-continugous.h mandatory for all=

> archs before Microblaze wiring.
>=20
> Thanks,
> Michal
>=20
> Changes in v2:
> - New patch suggested by Christoph
> - Align commit message
> - Remove adding dma-contigous.h via Kbuild because it is done by previo=
us
>   patch
>=20
> Michal Simek (2):
>   asm-generic: Make dma-contiguous.h a mandatory include/asm header
>   microblaze: Wire CMA allocator
>=20
>  arch/arm64/include/asm/Kbuild         | 1 -
>  arch/csky/include/asm/Kbuild          | 1 -
>  arch/microblaze/Kconfig               | 1 +
>  arch/microblaze/configs/mmu_defconfig | 2 ++
>  arch/microblaze/mm/init.c             | 4 ++++
>  arch/mips/include/asm/Kbuild          | 1 -
>  arch/riscv/include/asm/Kbuild         | 1 -
>  arch/s390/include/asm/Kbuild          | 1 -
>  arch/x86/include/asm/Kbuild           | 1 -
>  arch/xtensa/include/asm/Kbuild        | 1 -
>  include/asm-generic/Kbuild            | 1 +
>  11 files changed, 8 insertions(+), 7 deletions(-)
>=20

Applied.

Thanks,
Michal
--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--BbuWsr0XsV2TagfAoYrRnS0Lcvh9jdEaZ--

--pBOm8rNjCoJTkwKyfl4Ed8HeJH77Ps32T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQbPNTMvXmYlBPRwx7KSWXLKUoMIQUCXjlH4AAKCRDKSWXLKUoM
IXg5AJ9J98El4wJeR5l37eVkp19mJ5smqwCdGPO/rvmeDwYSeGZMMaNPcnZNHRA=
=bdA8
-----END PGP SIGNATURE-----

--pBOm8rNjCoJTkwKyfl4Ed8HeJH77Ps32T--
