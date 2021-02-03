Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1CF30E3A6
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 20:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhBCT4U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 14:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhBCT4R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2021 14:56:17 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906A7C061573;
        Wed,  3 Feb 2021 11:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=lZIM2DPH255woCpuEYzpAbqOgqBRxAkE8W2SBU4ewJE=; b=ceCUCEaJD39WM5gPnzKJ8wCMMB
        luJoynXfntKH0PrBYD0kV1boOM9EYOyikVf1bjeNLMp+UGrLsgPi/id7egUyvAw1XP2smeHy1aHvB
        THbPIkej5ErUCXA1NJhHsy9Sy58pIDNM5U1INSPEEMp3hay4Mzyul/jY5dhFLyIux8lRst/i7Xhff
        eN0djcpHrWSFX4bf2MlxDBJEtxfjmeXnDyZkydj3I+GPHP5y5kGCdEbAbjI/wEBSZpwvhfi7qh6LY
        ZRkz88wlLjuctiw2HWUek5QMoiFZmg4e630jPWnPaXnaL+b9dY3em0hinWaB7lFlsH9QUOY5EWGWB
        6Hg+KPqQ==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7OFM-0003dU-EK; Wed, 03 Feb 2021 19:55:28 +0000
Subject: Re: memory_model.h:64:14: error: implicit declaration of function
 'page_to_section'
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-mips@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>
References: <CA+G9fYv-=GdpLK3-6M9P4J1N-4ypS=GO8T2N15JFWXSmsG1adQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <201a2712-d708-7f83-9272-730b32e7a842@infradead.org>
Date:   Wed, 3 Feb 2021 11:55:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CA+G9fYv-=GdpLK3-6M9P4J1N-4ypS=GO8T2N15JFWXSmsG1adQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/3/21 7:51 AM, Naresh Kamboju wrote:
> Linux next tag 20210203 the mips and sh builds failed due to below errors.
> Following builds failed with gcc-8, gcc-9 and gcc-10,
>   - mips (cavium_octeon_defconfig)
>   - sh (defconfig)
>   - sh (shx3_defconfig)
> 
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=mips
> CROSS_COMPILE=mips-linux-gnu- 'CC=sccache mips-linux-gnu-gcc'
> 'HOSTCC=sccache gcc' uImage.gz
> In file included from arch/mips/include/asm/page.h:258,
>                  from arch/mips/include/asm/io.h:29,
>                  from include/linux/io.h:13,
>                  from arch/mips/include/asm/mips-cps.h:10,
>                  from arch/mips/include/asm/smp-ops.h:16,
>                  from arch/mips/include/asm/smp.h:21,
>                  from include/linux/smp.h:84,
>                  from arch/mips/include/asm/cpu-type.h:12,
>                  from arch/mips/include/asm/timex.h:19,
>                  from include/linux/timex.h:65,
>                  from include/linux/time32.h:13,
>                  from include/linux/time.h:60,
>                  from include/linux/compat.h:10,
>                  from arch/mips/kernel/asm-offsets.c:12:
> include/linux/mm.h: In function 'is_pinnable_page':
> include/asm-generic/memory_model.h:64:14: error: implicit declaration
> of function 'page_to_section'; did you mean 'present_section'?
> [-Werror=implicit-function-declaration]
>   int __sec = page_to_section(__pg);   \
>               ^~~~~~~~~~~~~~~
> include/asm-generic/memory_model.h:81:21: note: in expansion of macro
> '__page_to_pfn'
>  #define page_to_pfn __page_to_pfn
>                      ^~~~~~~~~~~~~
> include/linux/mm.h:1135:15: note: in expansion of macro 'page_to_pfn'
>    is_zero_pfn(page_to_pfn(page));
>                ^~~~~~~~~~~
> In file included from arch/mips/kernel/asm-offsets.c:15:
> include/linux/mm.h: At top level:
> include/linux/mm.h:1512:29: error: conflicting types for 'page_to_section'
>  static inline unsigned long page_to_section(const struct page *page)
>                              ^~~~~~~~~~~~~~~
> Steps to reproduce:
> --------------------------
> # TuxMake is a command line tool and Python library that provides
> # portable and repeatable Linux kernel builds across a variety of
> # architectures, toolchains, kernel configurations, and make targets.
> #
> # TuxMake supports the concept of runtimes.
> # See https://docs.tuxmake.org/runtimes/, for that to work it requires
> # that you install podman or docker on your system.
> #
> # To install tuxmake on your system globally:
> # sudo pip3 install -U tuxmake
> #
> # See https://docs.tuxmake.org/ for complete documentation.
> 
> 
> tuxmake --runtime podman --target-arch mips --toolchain gcc-10
> --kconfig cavium_octeon_defconfig

Looks to me like this is due to <linux/mm.h>:

#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
#define SECTION_IN_PAGE_FLAGS
#endif


with
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
# CONFIG_SPARSEMEM_VMEMMAP is not set


I'm still digging.

-- 
~Randy

