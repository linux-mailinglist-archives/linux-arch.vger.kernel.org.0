Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24EE7EFFBB
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2019 15:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfKEO3a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Nov 2019 09:29:30 -0500
Received: from mout.gmx.net ([212.227.17.22]:55725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727858AbfKEO33 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 Nov 2019 09:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572964151;
        bh=1ccRhMfOjQfCWgxZtJzM4hP1zgDfrNPilzzEdo9nVpk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Y0fiQZVlL53W17TOlZbi6XyMv5zjwVPRrWuOHJMTc50mzth8UTL/m2E1lYcbSheEF
         8jorhA7eYWbpK5PWaPEPGi/wJtl+L33sVAQqL300Yc0SHDjTKJjeHWLOB6GN35q3YS
         +a7NPrubb/JJYnsmHtwYU8sEHifg8Yl87BpLmw98=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.150.99]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpUYu-1i9DSt0bLI-00pqwr; Tue, 05
 Nov 2019 15:29:11 +0100
Subject: Re: [PATCH 07/21] parisc: remove __ioremap
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191029064834.23438-1-hch@lst.de>
 <20191029064834.23438-8-hch@lst.de>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 oiAieEtb6a/7+jPKZnRFTw==
Message-ID: <23dd12c1-8af2-dd97-18f2-da3203d49a48@gmx.de>
Date:   Tue, 5 Nov 2019 15:29:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191029064834.23438-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K84d31/CVvwIJRKgEkYeLn7nG07Ceq3NW0dsqaiRS5IsUys1PNO
 B3wZA6JSQUR3ASpFYkzv5n9DIUepkHMiZULCTf1KC+BWlAXPXnF8HuJwokTu9RHIoaGeecm
 Ci3RRzeiRWquDPKN9RN+JUnecDqMAenupRgKRqv99/LWiBv0xQpgWSKokC8ejSoOAF87fIb
 GlxUK3lSPzPHSDlD+KOEg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qywLIYXxQ6w=:uquN0cefM1Gv+iPhjMDm4y
 WzeGInW3/ErqTG1UoKT/xRidojOzqlKb5yOcKxyKZooWk6bL0fIl5AhbM6blTwH8c66Kn8H1J
 WGQc1ZJSoco0WhSHDXQ7118RQcJ0xrZYuyKBlHofDr66VPHNcDWKy5kH8jKybSP7WJTfqINRw
 XxrfJB4efx2ltV+lzx058SbsYx4C2h/rBJPKR7Kqu12s97bSiY+nyblh2s/yxfeKFuFc/wjCs
 lFYevasBI4YCaAngtQ6appEtRUuMVex0GquZfTkuN9kQa+RTc+z5tNk/7jbcLhxfdgxDb2A4Y
 A/K7Bt5gq41M7Jn+KWZX/6P2XqsNOt+6inw4TwVnCWKxgaw4xs9j+1+zOqMQZiYL/+b0EeS0h
 brYf9g9CAaFNjtMq6+/VAW2IOZ5Nv94fAwRDijmOwyrTdd18Y6DPZNsURYzGl5eEPOeFfkL/F
 JQUcovMUYYj9ZyJXaUrtQ2Lv1lLkNS2AbR8d6Z/6jfAFZlQsxf8UPI82eUYeX00lWlgIp/SYH
 cMXDYNrAgF3fA02cefaga+ToL9W+PJkdoWMNamBPYbInO41HfM4bO0JLXBJxLu8NxsIHwyYbL
 jISx7DcFcwYuhtufHVwYQb2iUXssyinN3j5YlEUD5kcq0apbnaksTH/qQGR+n+GfJqmwZUeTP
 LwRpD/4coGlhAyp/lmnCABsVRB5lwbpRNVUVoJzONql8z4AriXnPaX9nbHtB3uJ8FT1k1bImz
 E56ha19Q0Hnmpw/rCFgb7UT4+4PlAIXgifeujs/4EfgAtwZeLMDSJkAL3PBHGUAs62iq2qh1m
 vpSXwvx1tptIrnrGAtzQHlpMTiy3aP3TJHvhozmVGgOaIR3xRyA9CXUTBI+Hk0XuwymklVM5A
 BvFZUGwg1Wb55/+OdgYFXa6p9XFxMk+XBpGa8NYWQXBZxnCXVRMf3ucDkauRT/6fdyMaVUBvx
 qywVTNg1ILLrPVRP63jplKrFoDllanZJZNwQQgR0kyBWBaUMEBKRGhOn8wdgaWGOB5aC65RGx
 AkhXGJIgOkrsNq3xEuYujqPxATUS2ohV5/RQJjOfpLXgeBUx7ZOhe063AQZ72pgAsRhU5l5bP
 p/KTjTIG/oyqLgCyNVW9DucS2YjDRVYuPoK5r+qOQfF1oFXgONBCwUTL7hhhu/VtZ6J52BURA
 uUYYBM/GzpGVcgiHzTrdtFtF4RDNhEibY8tLl2/IpBAL3fwmJg8W+IziWuaj77zX1IdQfs5WW
 sY7znfNyevOrgCAOqWYYuW4MFkdA7qd6WtFYbUg==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 29.10.19 07:48, Christoph Hellwig wrote:
> __ioremap is always called with the _PAGE_NO_CACHE, so fold the whole
> thing and rename it to ioremap.  This also allows to remove the special
> EISA quirk to force _PAGE_NO_CACHE.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Helge Deller <deller@gmx.de>

Helge

> ---
>  arch/parisc/include/asm/io.h | 11 +----------
>  arch/parisc/mm/ioremap.c     | 10 ++++------
>  2 files changed, 5 insertions(+), 16 deletions(-)
>
> diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
> index 93d37010b375..46212b52c23e 100644
> --- a/arch/parisc/include/asm/io.h
> +++ b/arch/parisc/include/asm/io.h
> @@ -127,16 +127,7 @@ static inline void gsc_writeq(unsigned long long va=
l, unsigned long addr)
>  /*
>   * The standard PCI ioremap interfaces
>   */
> -
> -extern void __iomem * __ioremap(unsigned long offset, unsigned long siz=
e, unsigned long flags);
> -
> -/* Most machines react poorly to I/O-space being cacheable... Instead l=
et's
> - * define ioremap() in terms of ioremap_nocache().
> - */
> -static inline void __iomem * ioremap(unsigned long offset, unsigned lon=
g size)
> -{
> -	return __ioremap(offset, size, _PAGE_NO_CACHE);
> -}
> +void __iomem *ioremap(unsigned long offset, unsigned long size);
>  #define ioremap_nocache(off, sz)	ioremap((off), (sz))
>  #define ioremap_wc			ioremap_nocache
>  #define ioremap_uc			ioremap_nocache
> diff --git a/arch/parisc/mm/ioremap.c b/arch/parisc/mm/ioremap.c
> index f29f682352f0..6e7c005aa09b 100644
> --- a/arch/parisc/mm/ioremap.c
> +++ b/arch/parisc/mm/ioremap.c
> @@ -25,7 +25,7 @@
>   * have to convert them into an offset in a page-aligned mapping, but t=
he
>   * caller shouldn't need to know that small detail.
>   */
> -void __iomem * __ioremap(unsigned long phys_addr, unsigned long size, u=
nsigned long flags)
> +void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
>  {
>  	void __iomem *addr;
>  	struct vm_struct *area;
> @@ -36,10 +36,8 @@ void __iomem * __ioremap(unsigned long phys_addr, uns=
igned long size, unsigned l
>  	unsigned long end =3D phys_addr + size - 1;
>  	/* Support EISA addresses */
>  	if ((phys_addr >=3D 0x00080000 && end < 0x000fffff) ||
> -	    (phys_addr >=3D 0x00500000 && end < 0x03bfffff)) {
> +	    (phys_addr >=3D 0x00500000 && end < 0x03bfffff))
>  		phys_addr |=3D F_EXTEND(0xfc000000);
> -		flags |=3D _PAGE_NO_CACHE;
> -	}
>  #endif
>
>  	/* Don't allow wraparound or zero size */
> @@ -65,7 +63,7 @@ void __iomem * __ioremap(unsigned long phys_addr, unsi=
gned long size, unsigned l
>  	}
>
>  	pgprot =3D __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY |
> -			  _PAGE_ACCESSED | flags);
> +			  _PAGE_ACCESSED | _PAGE_NO_CACHE);
>
>  	/*
>  	 * Mappings have to be page-aligned
> @@ -90,7 +88,7 @@ void __iomem * __ioremap(unsigned long phys_addr, unsi=
gned long size, unsigned l
>
>  	return (void __iomem *) (offset + (char __iomem *)addr);
>  }
> -EXPORT_SYMBOL(__ioremap);
> +EXPORT_SYMBOL(ioremap);
>
>  void iounmap(const volatile void __iomem *io_addr)
>  {
>

