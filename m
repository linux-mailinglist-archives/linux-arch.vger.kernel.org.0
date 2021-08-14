Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5446C3EBF2E
	for <lists+linux-arch@lfdr.de>; Sat, 14 Aug 2021 03:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbhHNBFA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Aug 2021 21:05:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235870AbhHNBFA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Aug 2021 21:05:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EEBF61042;
        Sat, 14 Aug 2021 01:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628903072;
        bh=DFe7UDoGnT6+u9OBWO0ZI9GbCic4YsZIgmx3Avqy5h0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qdpJK4WjJaQf1C0jjNsURq189sWEPYwVEXf63nkPTHGo5GuEaWMbh4tazJvxpM4wr
         N1LTQk4snhQeGf3Us8ww/eldAa7mGSGvez7Z7Tg0KsFaOCCz7SxepAocx0IAv5no1M
         tf7jVd0ZbiKZDDAs64w9Vdwba09qv4K2uJ+sKt8o8hd+4bfY6MuZajZ/EyxwLsvhWt
         NqbbGp6bCtWe5QEn9goO0GkyOHRGnkQX78kg0YcqGABXZlPsfOSSwkPPeUClNRRHgF
         BZlIcwOJVRO3f6S/9B3mAt86poApD6jz/7qsP7DvFLSV6Y/VVl+/1KjCxWPpal1kAN
         X2FPeoxyoIGyw==
Subject: Re: [PATCH v3 0/6] asm-generic: strncpy_from_user/strnlen_user
 cleanup
To:     Arnd Bergmann <arnd@kernel.org>, linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Brian Cain <bcain@codeaurora.org>,
        Chris Zankel <chris@zankel.net>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Richard Weinberger <richard@nod.at>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.j>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20210722124814.778059-1-arnd@kernel.org>
From:   Vineet Gupta <vgupta@kernel.org>
Message-ID: <110b8a69-db5e-e5bc-4391-856a2ed45495@kernel.org>
Date:   Fri, 13 Aug 2021 18:04:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210722124814.778059-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On 7/22/21 5:48 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> I had run into some regressions for the previous version of this
> series, the new version is based on v5.14-rc2 instead.
> 
> These two functions appear to be unnecessarily different between
> architectures, and the asm-generic version is a bit questionable,
> even for NOMMU architectures.
> 
> Clean this up to just use the generic library version for anything
> that uses the generic version today. I've expanded on the patch
> descriptions a little, as suggested by Christoph Hellwig, but I
> suspect a more detailed review would uncover additional problems
> with the custom versions that are getting removed.
> 
> I ended up adding patches for csky and microblaze as they had the
> same implementation that I removed elsewhere, these are now gone
> as well.
> 
> If I hear no objections from architecture maintainers or new
> build regressions, I'll queue these up in the asm-generic tree
> for 5.15.
> 
>         Arnd
> 
> Link: https://lore.kernel.org/linux-arch/20210515101803.924427-1-arnd@kernel.org/

Are you planning to add this to asm-generic tree for 5.15 anytime soon.
Also while there, any chance you could pick up [1] too which was Acked 
by Will.

Thx,
-Vineet

[1] 
https://lore.kernel.org/linux-arch/20210805191408.2003237-1-vgupta@synopsys.com/


> 
> Arnd Bergmann (9):
>    asm-generic/uaccess.h: remove __strncpy_from_user/__strnlen_user
>    h8300: remove stale strncpy_from_user
>    hexagon: use generic strncpy/strnlen from_user
>    arc: use generic strncpy/strnlen from_user
>    csky: use generic strncpy/strnlen from_user
>    microblaze: use generic strncpy/strnlen from_user
>    asm-generic: uaccess: remove inline strncpy_from_user/strnlen_user
>    asm-generic: remove extra strn{cpy_from,len}_user declarations
>    asm-generic: reverse GENERIC_{STRNCPY_FROM,STRNLEN}_USER symbols
> 
>   arch/alpha/Kconfig                        |   2 -
>   arch/arc/include/asm/uaccess.h            |  72 -------------
>   arch/arc/mm/extable.c                     |  12 ---
>   arch/arm/Kconfig                          |   2 -
>   arch/arm64/Kconfig                        |   2 -
>   arch/csky/include/asm/uaccess.h           |   6 --
>   arch/csky/lib/usercopy.c                  | 102 ------------------
>   arch/h8300/kernel/h8300_ksyms.c           |   2 -
>   arch/h8300/lib/Makefile                   |   2 +-
>   arch/h8300/lib/strncpy.S                  |  35 ------
>   arch/hexagon/include/asm/uaccess.h        |  31 ------
>   arch/hexagon/kernel/hexagon_ksyms.c       |   1 -
>   arch/hexagon/mm/Makefile                  |   2 +-
>   arch/hexagon/mm/strnlen_user.S            | 126 ----------------------
>   arch/ia64/Kconfig                         |   2 +
>   arch/m68k/Kconfig                         |   2 -
>   arch/microblaze/include/asm/uaccess.h     |  19 +---
>   arch/microblaze/kernel/microblaze_ksyms.c |   3 -
>   arch/microblaze/lib/uaccess_old.S         |  90 ----------------
>   arch/mips/Kconfig                         |   2 +
>   arch/nds32/Kconfig                        |   2 -
>   arch/nios2/Kconfig                        |   2 -
>   arch/openrisc/Kconfig                     |   2 -
>   arch/parisc/Kconfig                       |   2 +-
>   arch/powerpc/Kconfig                      |   2 -
>   arch/riscv/Kconfig                        |   2 -
>   arch/s390/Kconfig                         |   2 +
>   arch/sh/Kconfig                           |   2 -
>   arch/sparc/Kconfig                        |   2 -
>   arch/um/Kconfig                           |   2 +
>   arch/um/include/asm/uaccess.h             |   5 +-
>   arch/um/kernel/skas/uaccess.c             |  14 ++-
>   arch/x86/Kconfig                          |   2 -
>   arch/xtensa/Kconfig                       |   3 +-
>   arch/xtensa/include/asm/uaccess.h         |   3 +-
>   include/asm-generic/uaccess.h             |  52 ++-------
>   lib/Kconfig                               |  10 +-
>   37 files changed, 43 insertions(+), 581 deletions(-)
>   delete mode 100644 arch/h8300/lib/strncpy.S
>   delete mode 100644 arch/hexagon/mm/strnlen_user.S
> 

