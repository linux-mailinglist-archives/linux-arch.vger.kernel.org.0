Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD324204C0
	for <lists+linux-arch@lfdr.de>; Mon,  4 Oct 2021 03:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhJDBgD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Oct 2021 21:36:03 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:40541 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229597AbhJDBgD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Oct 2021 21:36:03 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 2F73A2B012EA;
        Sun,  3 Oct 2021 21:34:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 03 Oct 2021 21:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:references:cc:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=j
        08sh6m6YgSaQWXZPVhA3JZmyLlucPN/yEkWrIr4Uc0=; b=EjcmciBXjpLqcxflb
        q67yJ8hPxQ7VhDsjMltDPGQ6TKPw3oXAka4cymfenw2sFcV9+2PTBeher17PCAD2
        M6kswA7faR1slq6kLy2stdcmNk43Ug5Y/blYZYKVehffZqdi97PQLbDn+i08lhu0
        R1Nw3jJV+fHekXVYRNjfLsXHARse30X4sfAhXuboH83q7h8DENnKPSyQ3ZquWrGF
        5DC67sDh2lR1epjdB+SZQdnwQZeNv6yuUKyisZqodz2BaCLXbYXJmLYm5onSbfhx
        9lJe4gEJ81Ss/4NKGdLUt/Ac87r9I7vEUA4I7zUodSoSLIIyTskdzmCpsycMsdA1
        WnqcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=j08sh6m6YgSaQWXZPVhA3JZmyLlucPN/yEkWrIr4U
        c0=; b=YC6izWu0Kjo1Qb7rA1jiEuQZsbWP7DEtCGykjlcvbxyEmTy4uAgmF5TLz
        B89QY7KF5+IKB9q/Zbca/ipkMjn0sRE5vXT3outSaz83cwUcq0HR3iERRstMCD3w
        agf+naermuxGMRvEqS2+2REWjPbdOSUqAg6UtQ+cSYAznbVZtMbmltU+dRM8bBvx
        FwbZjY0dWnFzr+vjBUuLWvqzCH6mcMG1nO5mNCGT+OZpTdOMn39MhLdSQX9vW7rC
        HE7ul4pQxxnzjZK5RYwgGepJBZkmWB0H6kk4DdMKC1vTY+eIWAw6UQHF0Se4T7jh
        dpNa63nAbcPFEZdPaNrjsxgDOPZqg==
X-ME-Sender: <xms:E1paYc1__yfUYN85tBFlf72T7I1jqtG8d0yBiLWQrQMdN5ebn0lL3w>
    <xme:E1paYXG0jXORCRdVxXIEoUldnVdUZ9-NV51DGwmp2RrYQVPV-S9EsUpoF9cL3SLMn
    gt6mI6pVunQPNUD8A>
X-ME-Received: <xmr:E1paYU6y_9AKaPRO0DydJIqpi-eNzSWzNyW2C_hfAiQvd2upjRqNZFzsJVVOgS314Xr9ZcJDQ7PIZSb0EGAsL0X8wTYe6yY_Kx6a2kunrTpjL-l3aqWRS2V8MA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeluddggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:E1paYV1r3P_dvbSWePjc29cvvEWXFXN_ST5zIbpEPxJBZKODWiJg5g>
    <xmx:E1paYfEIT9WVE1jLcCr3siueJ7uhD9Jjw7DJRQzmJNQs8z1hFiummw>
    <xmx:E1paYe_wwZGRhioAsm199qxDzvYAafosWWiaQjXxjiQ7BlJUzHNBfQ>
    <xmx:FFpaYemw4ofYc9WS4pEaHrrRkD84RolIzYf9F3aJI6S2r_8jmQPaT8zgwwo>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Oct 2021 21:34:10 -0400 (EDT)
Subject: Re: [PATCH v2 04/10] riscv: Implement sv48 support
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
References: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
 <20210929145113.1935778-5-alexandre.ghiti@canonical.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <748a2c58-4d69-6457-0aa5-89797cb45a5c@sholland.org>
Date:   Sun, 3 Oct 2021 20:34:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210929145113.1935778-5-alexandre.ghiti@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/29/21 9:51 AM, Alexandre Ghiti wrote:
> By adding a new 4th level of page table, give the possibility to 64bit
> kernel to address 2^48 bytes of virtual address: in practice, that offers
> 128TB of virtual address space to userspace and allows up to 64TB of
> physical memory.
> 
> If the underlying hardware does not support sv48, we will automatically
> fallback to a standard 3-level page table by folding the new PUD level into
> PGDIR level. In order to detect HW capabilities at runtime, we
> use SATP feature that ignores writes with an unsupported mode.
> 
> Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> ---
>  arch/riscv/Kconfig                      |   4 +-
>  arch/riscv/include/asm/csr.h            |   3 +-
>  arch/riscv/include/asm/fixmap.h         |   1 +
>  arch/riscv/include/asm/kasan.h          |   2 +-
>  arch/riscv/include/asm/page.h           |  10 +
>  arch/riscv/include/asm/pgalloc.h        |  40 ++++
>  arch/riscv/include/asm/pgtable-64.h     | 108 ++++++++++-
>  arch/riscv/include/asm/pgtable.h        |  13 +-
>  arch/riscv/kernel/head.S                |   3 +-
>  arch/riscv/mm/context.c                 |   4 +-
>  arch/riscv/mm/init.c                    | 237 ++++++++++++++++++++----
>  arch/riscv/mm/kasan_init.c              |  91 +++++++--
>  drivers/firmware/efi/libstub/efi-stub.c |   2 +
>  13 files changed, 453 insertions(+), 65 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 13e9c4298fbc..69c5533955ed 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -149,7 +149,7 @@ config PAGE_OFFSET
>  	hex
>  	default 0xC0000000 if 32BIT
>  	default 0x80000000 if 64BIT && !MMU
> -	default 0xffffffe000000000 if 64BIT
> +	default 0xffffc00000000000 if 64BIT
>  
>  config ARCH_FLATMEM_ENABLE
>  	def_bool !NUMA
> @@ -197,7 +197,7 @@ config FIX_EARLYCON_MEM
>  
>  config PGTABLE_LEVELS
>  	int
> -	default 3 if 64BIT
> +	default 4 if 64BIT
>  	default 2
>  
>  config LOCKDEP_SUPPORT
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 87ac65696871..3fdb971c7896 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -40,14 +40,13 @@
>  #ifndef CONFIG_64BIT
>  #define SATP_PPN	_AC(0x003FFFFF, UL)
>  #define SATP_MODE_32	_AC(0x80000000, UL)
> -#define SATP_MODE	SATP_MODE_32
>  #define SATP_ASID_BITS	9
>  #define SATP_ASID_SHIFT	22
>  #define SATP_ASID_MASK	_AC(0x1FF, UL)
>  #else
>  #define SATP_PPN	_AC(0x00000FFFFFFFFFFF, UL)
>  #define SATP_MODE_39	_AC(0x8000000000000000, UL)
> -#define SATP_MODE	SATP_MODE_39
> +#define SATP_MODE_48	_AC(0x9000000000000000, UL)
>  #define SATP_ASID_BITS	16
>  #define SATP_ASID_SHIFT	44
>  #define SATP_ASID_MASK	_AC(0xFFFF, UL)
> diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> index 54cbf07fb4e9..58a718573ad6 100644
> --- a/arch/riscv/include/asm/fixmap.h
> +++ b/arch/riscv/include/asm/fixmap.h
> @@ -24,6 +24,7 @@ enum fixed_addresses {
>  	FIX_HOLE,
>  	FIX_PTE,
>  	FIX_PMD,
> +	FIX_PUD,
>  	FIX_TEXT_POKE1,
>  	FIX_TEXT_POKE0,
>  	FIX_EARLYCON_MEM_BASE,
> diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasan.h
> index a2b3d9cdbc86..1dcf5fa93aa0 100644
> --- a/arch/riscv/include/asm/kasan.h
> +++ b/arch/riscv/include/asm/kasan.h
> @@ -27,7 +27,7 @@
>   */
>  #define KASAN_SHADOW_SCALE_SHIFT	3
>  
> -#define KASAN_SHADOW_SIZE	(UL(1) << ((CONFIG_VA_BITS - 1) - KASAN_SHADOW_SCALE_SHIFT))
> +#define KASAN_SHADOW_SIZE	(UL(1) << ((VA_BITS - 1) - KASAN_SHADOW_SCALE_SHIFT))

Does this change belong in patch 1, where you remove CONFIG_VA_BITS?

Regards,
Samuel
