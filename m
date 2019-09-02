Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC2C3A590C
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2019 16:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbfIBORO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Sep 2019 10:17:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45595 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfIBORM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Sep 2019 10:17:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id q12so14162784wrj.12
        for <linux-arch@vger.kernel.org>; Mon, 02 Sep 2019 07:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=wHLGtYkZTmnf/Q+NJRht7CodjM3w+dg+9ES/vSM0RcI=;
        b=afYPXPQLzvFAj1lVnwBQn3TA5rDlPS9rxLsQKmLyUEVYYqLvv2di5vklel8nyDuIlj
         IagBthy5dYLukTgWxTT/3ztKBRs9PTOZ66iuza579Dfj5UnylogGKx0AMzEUMimvbUWZ
         v0Jple7LvgR/plVjamH/3QMW3Vb3p+g8yC6PXiSurp6qQqqA/N9J6twCJEbcgPkvIwyL
         WsQO4HxJE3vbkuodjs3S68y25OtneQYX4b8YKVWUaflWKRlIMn5V5CKAAS7VvPy3RMkl
         oDTh3MMO0lQA3AxaolW6Uh96p9mpUIjQPq9teH1xMncYapsZ1Q7Az7UhWut9STf4/cGK
         RxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=wHLGtYkZTmnf/Q+NJRht7CodjM3w+dg+9ES/vSM0RcI=;
        b=Gg1avLH8ZiSy/tjFwXJp7aB343K2AZjF778wpVCn85RnL9JviCyAFYRU0tQeAybEfO
         r58+ef31mTgehng5lndUAbcxo8Mt/t/XBBTuCmd8v9sXPyMENvvmnYhFjV4tv5pyRtX1
         REXVu9YS/7N3Vc1QaW4wyAVeK+yH/MS0Y3gYpU0EqTM2iSYxAinjeqGY4KbmvV2vXxCw
         yJzPAvvHobobXB4uNdg7h6TCcCDG7dclcMohe0xjO3HIJlWNaEAME0vZcz4BC7awvqTM
         qrJ/tei/lqnVKdvrov0jbu91jEFG4TyQ6EBf/Uvjs3nPQM4iufORFYwPCedQOGPgj1xD
         NyOw==
X-Gm-Message-State: APjAAAW6ascaYFmQT6A5P89c9GWFKgzsS7EJnAe3xhDCoffQAyXlpHTU
        +EgvIXQ9mu88JHBzqnhBXZTh2w==
X-Google-Smtp-Source: APXvYqyShqgEJwFOtJFr9Fq0w6BS1apJDW9A6yIMdA+d8V9PFj9RZCN2SBDb4+Bki1KAn/644PK6KQ==
X-Received: by 2002:adf:dd04:: with SMTP id a4mr5388204wrm.340.1567433828197;
        Mon, 02 Sep 2019 07:17:08 -0700 (PDT)
Received: from [74.125.133.108] ([149.199.62.131])
        by smtp.gmail.com with ESMTPSA id r17sm13933233wrt.68.2019.09.02.07.16.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 07:17:07 -0700 (PDT)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH 03/26] m68k, microblaze: remove ioremap_fullcache
To:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Guo Ren <guoren@kernel.org>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org
Cc:     linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mtd@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190817073253.27819-1-hch@lst.de>
 <20190817073253.27819-4-hch@lst.de>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9a11ddb0-0799-c64a-f5aa-0504c564998f@monstr.eu>
Date:   Mon, 2 Sep 2019 16:16:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190817073253.27819-4-hch@lst.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="sxrD5DzuLHXmSTexCf4xoEovzaJstmsXm"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sxrD5DzuLHXmSTexCf4xoEovzaJstmsXm
Content-Type: multipart/mixed; boundary="Gv98DqTDPDXpgdAS8uye8pnF1A8XQfxBm";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
 Guo Ren <guoren@kernel.org>, Greentime Hu <green.hu@gmail.com>,
 Vincent Chen <deanbo422@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 x86@kernel.org
Cc: linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org,
 openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, linux-mtd@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <9a11ddb0-0799-c64a-f5aa-0504c564998f@monstr.eu>
Subject: Re: [PATCH 03/26] m68k, microblaze: remove ioremap_fullcache
References: <20190817073253.27819-1-hch@lst.de>
 <20190817073253.27819-4-hch@lst.de>
In-Reply-To: <20190817073253.27819-4-hch@lst.de>

--Gv98DqTDPDXpgdAS8uye8pnF1A8XQfxBm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17. 08. 19 9:32, Christoph Hellwig wrote:
> No callers of this function.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/m68k/include/asm/kmap.h     | 7 -------
>  arch/microblaze/include/asm/io.h | 1 -
>  2 files changed, 8 deletions(-)
>=20
> diff --git a/arch/m68k/include/asm/kmap.h b/arch/m68k/include/asm/kmap.=
h
> index aac7f045f7f0..03d904fe6087 100644
> --- a/arch/m68k/include/asm/kmap.h
> +++ b/arch/m68k/include/asm/kmap.h
> @@ -43,13 +43,6 @@ static inline void __iomem *ioremap_wt(unsigned long=
 physaddr,
>  	return __ioremap(physaddr, size, IOMAP_WRITETHROUGH);
>  }
> =20
> -#define ioremap_fullcache ioremap_fullcache
> -static inline void __iomem *ioremap_fullcache(unsigned long physaddr,
> -					      unsigned long size)
> -{
> -	return __ioremap(physaddr, size, IOMAP_FULL_CACHING);
> -}
> -
>  #define memset_io memset_io
>  static inline void memset_io(volatile void __iomem *addr, unsigned cha=
r val,
>  			     int count)
> diff --git a/arch/microblaze/include/asm/io.h b/arch/microblaze/include=
/asm/io.h
> index c7968139486f..86c95b2a1ce1 100644
> --- a/arch/microblaze/include/asm/io.h
> +++ b/arch/microblaze/include/asm/io.h
> @@ -40,7 +40,6 @@ extern void iounmap(volatile void __iomem *addr);
> =20
>  extern void __iomem *ioremap(phys_addr_t address, unsigned long size);=

>  #define ioremap_nocache(addr, size)		ioremap((addr), (size))
> -#define ioremap_fullcache(addr, size)		ioremap((addr), (size))
>  #define ioremap_wc(addr, size)			ioremap((addr), (size))
>  #define ioremap_wt(addr, size)			ioremap((addr), (size))
> =20
>=20

Acked-by: Michal Simek <monstr@monstr.eu> (for Microblaze)

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--Gv98DqTDPDXpgdAS8uye8pnF1A8XQfxBm--

--sxrD5DzuLHXmSTexCf4xoEovzaJstmsXm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQbPNTMvXmYlBPRwx7KSWXLKUoMIQUCXW0kVQAKCRDKSWXLKUoM
IUCIAJ0dq35U3Gq44M2ocYgcj4SW3Em/1wCfajAs22UIYAGzwTZZyZTvB5OFi1I=
=essT
-----END PGP SIGNATURE-----

--sxrD5DzuLHXmSTexCf4xoEovzaJstmsXm--
