Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9FA4C3D3A
	for <lists+linux-arch@lfdr.de>; Fri, 25 Feb 2022 05:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbiBYEcH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Feb 2022 23:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237392AbiBYEcG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Feb 2022 23:32:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB0F9FD8;
        Thu, 24 Feb 2022 20:31:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 392A2B82AB8;
        Fri, 25 Feb 2022 04:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF54C340E7;
        Fri, 25 Feb 2022 04:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645763491;
        bh=GLLjJ1DIY+pcaD5Wxr3GGBnMqVEARs5wDghfvFD40O8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hIVBklbMz20Too2yeCCQf4FR/ynGbzZ2XY3Q4fmoq3AjGgtKL335uxFhoNA+O7GwZ
         1xI9NTIagmUc/WGvwJaXmKN3m6iRlWo7xNSh2VqLx5iFbuZhtPqHWNdyPZFCcQmvJg
         B/wRcBuuSGk7QMYD4O/BWhUPyLQM2U2ZADwP6zy8YV9xa2LwvKMXbfS9owW1MUfUTw
         6fHO3FMrRRy8SAogw4atZuZJaPKXrV3/3aWAhAbetYfwpuO/cHRAnjSsimimMy3Xa2
         RW5lD3MIKq24lj+jc1tNunbJNi08raKakbPeJIfU1woaZaqtvTkkP3acIOYmeu0z/S
         VxtoRQs+6FTNQ==
Message-ID: <d12e6bcc-089d-568b-62cf-036c68c08ca0@kernel.org>
Date:   Thu, 24 Feb 2022 22:31:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 13/18] uaccess: generalize access_ok()
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
 <20220216131332.1489939-14-arnd@kernel.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220216131332.1489939-14-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2/16/22 07:13, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are many different ways that access_ok() is defined across
> architectures, but in the end, they all just compare against the
> user_addr_max() value or they accept anything.
> 
> Provide one definition that works for most architectures, checking
> against TASK_SIZE_MAX for user processes or skipping the check inside
> of uaccess_kernel() sections.
> 
> For architectures without CONFIG_SET_FS(), this should be the fastest
> check, as it comes down to a single comparison of a pointer against a
> compile-time constant, while the architecture specific versions tend to
> do something more complex for historic reasons or get something wrong.
> 
> Type checking for __user annotations is handled inconsistently across
> architectures, but this is easily simplified as well by using an inline
> function that takes a 'const void __user *' argument. A handful of
> callers need an extra __user annotation for this.
> 
> Some architectures had trick to use 33-bit or 65-bit arithmetic on the
> addresses to calculate the overflow, however this simpler version uses
> fewer registers, which means it can produce better object code in the
> end despite needing a second (statically predicted) branch.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Mark Rutland <mark.rutland@arm.com> [arm64, asm-generic]
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/Kconfig                          |  7 ++++
>   arch/alpha/include/asm/uaccess.h      | 34 +++------------
>   arch/arc/include/asm/uaccess.h        | 29 -------------
>   arch/arm/include/asm/uaccess.h        | 20 +--------
>   arch/arm64/include/asm/uaccess.h      | 11 ++---
>   arch/csky/include/asm/uaccess.h       |  8 ----
>   arch/hexagon/include/asm/uaccess.h    | 25 ------------
>   arch/ia64/include/asm/uaccess.h       |  5 +--
>   arch/m68k/Kconfig.cpu                 |  1 +
>   arch/m68k/include/asm/uaccess.h       | 19 +--------
>   arch/microblaze/include/asm/uaccess.h |  8 +---
>   arch/mips/include/asm/uaccess.h       | 29 +------------
>   arch/nds32/include/asm/uaccess.h      |  7 +---
>   arch/nios2/include/asm/uaccess.h      | 11 +----

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
