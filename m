Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B59734B70
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jun 2023 07:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjFSFsq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Jun 2023 01:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjFSFsq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Jun 2023 01:48:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DA61A8;
        Sun, 18 Jun 2023 22:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687153678; x=1687758478; i=deller@gmx.de;
 bh=3bpv0Sq84qpeiKzwxZGQAnzIVxWHnuEFv0IZNw09BQY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=erSM4FKBEmuXAlZ59doRaUwk8EwhueZdegMbzKP+QhYfRbKi2Lhx6IofVmpVONNpLiug8S9
 p9r/TQNwzg7ALvwtjSEt2eAVTxoxtjpWbGuGVq+kfsr1FEcVW+VeiAdDHm6b7PHYLJcg4oz+8
 9/bEgLbRWcQY5XecBZ3JfLlA9SQvZ7N+vT8/gC9Cnk1GspNb5VoEWWGJ3uJfQ8eRrBZ6wgzVF
 U3aA8LhWNS6bl1L3ql9uXRIfiyeF0DBr6U3H3zlvszQH2R9m5m0NyHlSsZX7l0ZfFx8D6YVaj
 bKq0mb9A4vX9/hTOvFX0Ub0iwCmKhvxq3LYymljnrcRVvVbyvTdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.204]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtfJX-1ppBXV0PpH-00v9sa; Mon, 19
 Jun 2023 07:47:58 +0200
Message-ID: <75a0786d-d3ec-05e2-6505-188c3d181b83@gmx.de>
Date:   Mon, 19 Jun 2023 07:47:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 14/19] parisc: mm: Convert to GENERIC_IOREMAP
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        christophe.leroy@csgroup.eu, hch@lst.de, rppt@kernel.org,
        willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org
References: <20230609075528.9390-1-bhe@redhat.com>
 <20230609075528.9390-15-bhe@redhat.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230609075528.9390-15-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4xBnCYot+P9hRdTSapi4CiX5gBlJsUOVbaNVW1eypzPZ2gwUQ1i
 BEO8XT+RYH8BNM/68eCkJfLORi3jHcTAU4Hme7siRfX6+VG12ljyon+Tz4qCuW1a2QgFrXk
 uSq6Cq3S4uEQxotyGWHAkKGN/etzWeES+801teEI00aZ0oVpYpucJxVgpHwCIyXu0ZHkOIP
 6yXBZFVFsD6XwSxRed+4A==
UI-OutboundReport: notjunk:1;M01:P0:br2Bb9rJ1aI=;vxRiu6N5Lpq4NJtTWUikbA7SH2c
 4634vVbd2iDsJjV4erZSRwYVHH/DNTf8WnEwDhLJPlifzIGU/pJlxJremwNCQnpQOrVYouym7
 l55UvXiLNYb4ZNWek9Fmi0lQYQK9Zy8DWf5tsCxKDzPbYxSZ13HpVsJ4B1QvHwEFkB6bK/8iH
 g+dk9NU5GhB97NVa8Uj3DahDQrVfjEd0EzEMh6gogmwlFwRV3iZYyFSZ8264aAZ8bfXlLJEoY
 8v2eKCqw1WoUWanNovFK3iytd19Ej5h5a5mLhHw2CmeQcfauoRq9liajYm4ooGaGvHDt1AunP
 jcl1aMC3zBepd2AllaptPyDCliZFBr3I6zJ7M+0tIf7nQKtfjkNdM0L3DpZP8Gsdl2ZjiXdU5
 iKu8w6qLvePxRQoomI1GzPSMlsGV8/806ZuhpzMvB1eISBocjSv86kWluMLAiQFgddxNdLLbT
 QUbnUPn4o8kYagcnh5pARO0SF6AyMSjAmLyzmxmzl8My0iCcaSpz6c1VJGTln2wD2BHNcGOAQ
 x2cLa+eKo+pf6vd9jq2Ns6bQmztJk8iurCA6Maoxexu13uSu7Nfb9tUZ1QXTVug6YiLnrqvtk
 frQZsL7D6FHB/I0DADoCed1uGagiJUEQ13Wj7APly8/ut3N8nL6g9IbqxI6FYoaT0R3RV7doD
 6ecjieXYxMCFHEpYD/5gWWw+7rL75Yy7zBU+2/qc/MoevH9txTTF27KHjDktFP00n6X7oK+CA
 29EX8pZ1wE6iuEZdTeKFC1JfLjPzhYSfCE0ywjrCLi8QAYfcfqAgNTAsdzqO+oKM96MYc3egL
 jcVRqv98AIIDmSKMF3/rqfnL1/sZvI7ILYC4uj9kTju5YtfvmQA6O7CdnrxxaQl6LKAwpTBhB
 V8DB6wQa4F2/SkpW00PuMxBm1Syip8kAfeMatbOJj1PqfOmKT9tCCWPfG0/oDMOhQmKFoZUal
 Z+smTtB2T6GEy5dIVC2iI+XXth4=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/9/23 09:55, Baoquan He wrote:
> By taking GENERIC_IOREMAP method, the generic generic_ioremap_prot(),
> generic_iounmap(), and their generic wrapper ioremap_prot(), ioremap()
> and iounmap() are all visible and available to arch. Arch needs to
> provide wrapper functions to override the generic versions if there's
> arch specific handling in its ioremap_prot(), ioremap() or iounmap().
> This change will simplify implementation by removing duplicated codes
> with generic_ioremap_prot() and generic_iounmap(), and has the equivalen=
t
> functioality as before.
>
> Here, add wrapper function ioremap_prot() for parisc's special operation
> when iounmap().
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org

Acked-by: Helge Deller <deller@gmx.de> # parisc

Thanks!
Helge

> ---
> v5->v6:
>    Remove the stale paragraph related to ARCH_HAS_IOREMAP_WC adding in
>    log - Mike
>
>   arch/parisc/Kconfig          |  1 +
>   arch/parisc/include/asm/io.h | 15 ++++++---
>   arch/parisc/mm/ioremap.c     | 62 +++---------------------------------
>   3 files changed, 15 insertions(+), 63 deletions(-)
>
> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index 967bde65dd0e..315cc42b1a2c 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -36,6 +36,7 @@ config PARISC
>   	select GENERIC_ATOMIC64 if !64BIT
>   	select GENERIC_IRQ_PROBE
>   	select GENERIC_PCI_IOMAP
> +	select GENERIC_IOREMAP
>   	select ARCH_HAVE_NMI_SAFE_CMPXCHG
>   	select GENERIC_SMP_IDLE_THREAD
>   	select GENERIC_ARCH_TOPOLOGY if SMP
> diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
> index c05e781be2f5..366537042465 100644
> --- a/arch/parisc/include/asm/io.h
> +++ b/arch/parisc/include/asm/io.h
> @@ -125,12 +125,17 @@ static inline void gsc_writeq(unsigned long long v=
al, unsigned long addr)
>   /*
>    * The standard PCI ioremap interfaces
>    */
> -void __iomem *ioremap(unsigned long offset, unsigned long size);
> -#define ioremap_wc			ioremap
> -#define ioremap_uc			ioremap
> -#define pci_iounmap			pci_iounmap
> +#define ioremap_prot ioremap_prot
> +
> +#define _PAGE_IOREMAP (_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | \
> +		       _PAGE_ACCESSED | _PAGE_NO_CACHE)
>
> -extern void iounmap(const volatile void __iomem *addr);
> +#define ioremap_wc(addr, size)  \
> +	ioremap_prot((addr), (size), _PAGE_IOREMAP)
> +#define ioremap_uc(addr, size)  \
> +	ioremap_prot((addr), (size), _PAGE_IOREMAP)
> +
> +#define pci_iounmap			pci_iounmap
>
>   void memset_io(volatile void __iomem *addr, unsigned char val, int cou=
nt);
>   void memcpy_fromio(void *dst, const volatile void __iomem *src, int co=
unt);
> diff --git a/arch/parisc/mm/ioremap.c b/arch/parisc/mm/ioremap.c
> index 345ff0b66499..fd996472dfe7 100644
> --- a/arch/parisc/mm/ioremap.c
> +++ b/arch/parisc/mm/ioremap.c
> @@ -13,25 +13,9 @@
>   #include <linux/io.h>
>   #include <linux/mm.h>
>
> -/*
> - * Generic mapping function (not visible outside):
> - */
> -
> -/*
> - * Remap an arbitrary physical address space into the kernel virtual
> - * address space.
> - *
> - * NOTE! We need to allow non-page-aligned mappings too: we will obviou=
sly
> - * have to convert them into an offset in a page-aligned mapping, but t=
he
> - * caller shouldn't need to know that small detail.
> - */
> -void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
> +void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> +			   unsigned long prot)
>   {
> -	void __iomem *addr;
> -	struct vm_struct *area;
> -	unsigned long offset, last_addr;
> -	pgprot_t pgprot;
> -
>   #ifdef CONFIG_EISA
>   	unsigned long end =3D phys_addr + size - 1;
>   	/* Support EISA addresses */
> @@ -40,11 +24,6 @@ void __iomem *ioremap(unsigned long phys_addr, unsign=
ed long size)
>   		phys_addr |=3D F_EXTEND(0xfc000000);
>   #endif
>
> -	/* Don't allow wraparound or zero size */
> -	last_addr =3D phys_addr + size - 1;
> -	if (!size || last_addr < phys_addr)
> -		return NULL;
> -
>   	/*
>   	 * Don't allow anybody to remap normal RAM that we're using..
>   	 */
> @@ -62,39 +41,6 @@ void __iomem *ioremap(unsigned long phys_addr, unsign=
ed long size)
>   		}
>   	}
>
> -	pgprot =3D __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY |
> -			  _PAGE_ACCESSED | _PAGE_NO_CACHE);
> -
> -	/*
> -	 * Mappings have to be page-aligned
> -	 */
> -	offset =3D phys_addr & ~PAGE_MASK;
> -	phys_addr &=3D PAGE_MASK;
> -	size =3D PAGE_ALIGN(last_addr + 1) - phys_addr;
> -
> -	/*
> -	 * Ok, go for it..
> -	 */
> -	area =3D get_vm_area(size, VM_IOREMAP);
> -	if (!area)
> -		return NULL;
> -
> -	addr =3D (void __iomem *) area->addr;
> -	if (ioremap_page_range((unsigned long)addr, (unsigned long)addr + size=
,
> -			       phys_addr, pgprot)) {
> -		vunmap(addr);
> -		return NULL;
> -	}
> -
> -	return (void __iomem *) (offset + (char __iomem *)addr);
> -}
> -EXPORT_SYMBOL(ioremap);
> -
> -void iounmap(const volatile void __iomem *io_addr)
> -{
> -	unsigned long addr =3D (unsigned long)io_addr & PAGE_MASK;
> -
> -	if (is_vmalloc_addr((void *)addr))
> -		vunmap((void *)addr);
> +	return generic_ioremap_prot(phys_addr, size, __pgprot(prot));
>   }
> -EXPORT_SYMBOL(iounmap);
> +EXPORT_SYMBOL(ioremap_prot);

