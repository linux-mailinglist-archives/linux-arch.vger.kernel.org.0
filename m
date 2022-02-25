Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA464C3D4A
	for <lists+linux-arch@lfdr.de>; Fri, 25 Feb 2022 05:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbiBYEe1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Feb 2022 23:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbiBYEe1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Feb 2022 23:34:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08511AAA51;
        Thu, 24 Feb 2022 20:33:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D34F61893;
        Fri, 25 Feb 2022 04:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2F6C340E7;
        Fri, 25 Feb 2022 04:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645763634;
        bh=uh4UnFdDR53Ujc6m18f6ctjt+AIyhJXv2xufWpNaVhA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Uvtrsu50Hf9ISgTqjw2cZIY/fdalMvrStTdfqoQM3mdhWwRTlcM+di3Mlxj2LfRYC
         sL2lOFI5CCKzGB0MNHSMJUWPqE4dtIOpz2JXIrS4+Xkvjw7ulJEnCWAELTi2BsI79T
         +YcmqfASppeT6+G8sHwqPvTdqA+0hk873k0laznUkKMLOPw4ZEEscH10+2t1L5fKp+
         8BfsQshsS4Im5IcgpwMXaxmFYPmHS4QO6tZE5Cu6VT+1C4lCHB7iNpJZvNEdHwtoNJ
         zTpbMfhiIoucAZFTRmPZuLhWqy/lBlhaelfx8iUJ+lK7d4LQiirbG9AaOIPIgpnmXG
         aNgH1u0nAoM1w==
Message-ID: <3927b6f5-c8d0-1421-407d-850ede02dd0f@kernel.org>
Date:   Thu, 24 Feb 2022 22:33:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 18/18] uaccess: drop maining CONFIG_SET_FS users
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org,
        bcain@codeaurora.org, geert@linux-m68k.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        green.hu@gmail.com, shorne@gmail.com, deller@gmx.de,
        mpe@ellerman.id.au, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, hca@linux.ibm.com, dalias@libc.org,
        davem@davemloft.net, richard@nod.at, x86@kernel.org,
        jcmvbkbc@gmail.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, ardb@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-19-arnd@kernel.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220216131332.1489939-19-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2/16/22 07:13, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are no remaining callers of set_fs(), so CONFIG_SET_FS
> can be removed globally, along with the thread_info field and
> any references to it.
> 
> This turns access_ok() into a cheaper check against TASK_SIZE_MAX.
> 
> With CONFIG_SET_FS gone, so drop all remaining references to
> set_fs()/get_fs(), mm_segment_t and uaccess_kernel().
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/Kconfig                              |  3 -
>   arch/alpha/Kconfig                        |  1 -
>   arch/alpha/include/asm/processor.h        |  4 --
>   arch/alpha/include/asm/thread_info.h      |  2 -
>   arch/alpha/include/asm/uaccess.h          | 19 ------
>   arch/arc/Kconfig                          |  1 -
>   arch/arc/include/asm/segment.h            | 20 -------
>   arch/arc/include/asm/thread_info.h        |  3 -
>   arch/arc/include/asm/uaccess.h            |  1 -
>   arch/arm/lib/uaccess_with_memcpy.c        | 10 ----
>   arch/csky/Kconfig                         |  1 -
>   arch/csky/include/asm/processor.h         |  2 -
>   arch/csky/include/asm/segment.h           | 10 ----
>   arch/csky/include/asm/thread_info.h       |  2 -
>   arch/csky/include/asm/uaccess.h           |  3 -
>   arch/csky/kernel/asm-offsets.c            |  1 -
>   arch/h8300/Kconfig                        |  1 -
>   arch/h8300/include/asm/processor.h        |  1 -
>   arch/h8300/include/asm/segment.h          | 40 -------------
>   arch/h8300/include/asm/thread_info.h      |  3 -
>   arch/h8300/kernel/entry.S                 |  1 -
>   arch/h8300/kernel/head_ram.S              |  1 -
>   arch/h8300/mm/init.c                      |  6 --
>   arch/h8300/mm/memory.c                    |  1 -
>   arch/hexagon/Kconfig                      |  1 -
>   arch/hexagon/include/asm/thread_info.h    |  6 --
>   arch/hexagon/kernel/process.c             |  1 -
>   arch/microblaze/Kconfig                   |  1 -
>   arch/microblaze/include/asm/thread_info.h |  6 --
>   arch/microblaze/include/asm/uaccess.h     | 24 --------
>   arch/microblaze/kernel/asm-offsets.c      |  1 -
>   arch/microblaze/kernel/process.c          |  1 -
>   arch/nds32/Kconfig                        |  1 -
>   arch/nds32/include/asm/thread_info.h      |  4 --
>   arch/nds32/include/asm/uaccess.h          | 15 +----
>   arch/nds32/kernel/process.c               |  5 +-
>   arch/nds32/mm/alignment.c                 |  3 -
>   arch/nios2/Kconfig                        |  1 -
>   arch/nios2/include/asm/thread_info.h      |  9 ---
>   arch/nios2/include/asm/uaccess.h          | 12 ----

For NIOS2:

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
