Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D353734F3
	for <lists+linux-arch@lfdr.de>; Wed,  5 May 2021 08:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhEEG2e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 May 2021 02:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbhEEG2b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 May 2021 02:28:31 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25DAC061574;
        Tue,  4 May 2021 23:27:34 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id d10so1053676pgf.12;
        Tue, 04 May 2021 23:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1HKBlpaCyJzd9arklB7EU/tOaG5LupW4wg4un2llmUs=;
        b=mcr1f1QLoVbjojRQsaDAal09mAV3oCfe3iVNmQC9+y+ZD4YM7+Da1q3GubyPQi+YTB
         lIzJ/eQm26rFXKUFZUvEbcBB0lvglkSYiaPh0FReYd/Ji0q9FjCzUy3XgrJ5dU43Dh1v
         p9wb7psQEjueQgdIPIzHN3TM2LXblLcQ+jJq3mrsAENDUrTiL8dHRkycvlXfkQ/ksC0O
         KvFEAMnC5CkxPp+vjMRxBIfpLXW4ByDtfqd3yGKHCpbQTrKwuprrqZHgPeTOgmsm8e7u
         6cn7gZ85b/1oJfZEQuUdYACTGz6UtN1/wxLFvEqqOSbac/PJDeKv/td6xmODQlkFtXTa
         1DFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1HKBlpaCyJzd9arklB7EU/tOaG5LupW4wg4un2llmUs=;
        b=FVBQ00KJMHkw7HIlXnOyj+yGALStUzF170uqnm2nzhh4e3DZRNGqXJGkox1zln2QTj
         +KsEBBQdVmx/7+VNtsx5NDEOhvN1/hiwwXPUjxlTlVDLLqG1c7StQjeNZoVFJztJ8oT6
         UY0+qnc+1cwedMR0QdlETx/e/BLMtVW6N3HiFlRl7Exhhe9GanvpN8nhix5grFTWUAqZ
         TBS/W3sPI5aCI4iqWdN7Mti5akkVSiJ3oX+fhsMyAepNlB9v3X02fkyf8x/dNROPrCFo
         Ko/exI++IOh+D62T6BMcfLLLs6DpzLIrHVv1+XZTWIz1ORieIsTfWagrZkZGlmB76dYf
         Rhcg==
X-Gm-Message-State: AOAM531TQqVufOxtpGytylau8jaWxDRvlyU6HojoiATK+qIOt9+wX4L4
        c33yVaBtUJal1E6U+YxW/Es=
X-Google-Smtp-Source: ABdhPJyIBesPesIQfRjyOxzNqGnAz825pqG4hSplMnk9nO/R13QMazp98PNnKEvyZ0RLCNMl8FNxKQ==
X-Received: by 2002:aa7:814c:0:b029:250:13db:3c6e with SMTP id d12-20020aa7814c0000b029025013db3c6emr27493810pfn.65.1620196054408;
        Tue, 04 May 2021 23:27:34 -0700 (PDT)
Received: from localhost (g17.222-224-135.ppp.wakwak.ne.jp. [222.224.135.17])
        by smtp.gmail.com with ESMTPSA id c134sm9652932pfb.135.2021.05.04.23.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 23:27:33 -0700 (PDT)
Date:   Wed, 5 May 2021 15:27:31 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Richard Henderson <rth@twiddle.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Dike <jdike@addtoit.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chris Zankel <chris@zankel.net>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm: Define default value for FIRST_USER_ADDRESS
Message-ID: <20210505062731.GS3288043@lianli.shorne-pla.net>
References: <1618550254-14511-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618550254-14511-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 16, 2021 at 10:47:34AM +0530, Anshuman Khandual wrote:
> Currently most platforms define FIRST_USER_ADDRESS as 0UL duplication the
> same code all over. Instead just define a generic default value (i.e 0UL)
> for FIRST_USER_ADDRESS and let the platforms override when required. This
> makes it much cleaner with reduced code.
> 
> The default FIRST_USER_ADDRESS here would be skipped in <linux/pgtable.h>
> when the given platform overrides its value via <asm/pgtable.h>.
> 
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Brian Cain <bcain@codeaurora.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Ley Foon Tan <ley.foon.tan@intel.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v5.12-rc7 and has been boot tested on arm64 platform.
> But has been cross compiled on multiple other platforms.
> 
> Changes in V2:
> 
> - Dropped ARCH_HAS_FIRST_USER_ADDRESS construct
> 
> Changes in V1:
> 
> https://patchwork.kernel.org/project/linux-mm/patch/1618368899-20311-1-git-send-email-anshuman.khandual@arm.com/
> 
>  arch/alpha/include/asm/pgtable.h             | 1 -
>  arch/arc/include/asm/pgtable.h               | 6 ------
>  arch/arm64/include/asm/pgtable.h             | 2 --
>  arch/csky/include/asm/pgtable.h              | 1 -
>  arch/hexagon/include/asm/pgtable.h           | 3 ---
>  arch/ia64/include/asm/pgtable.h              | 1 -
>  arch/m68k/include/asm/pgtable_mm.h           | 1 -
>  arch/microblaze/include/asm/pgtable.h        | 2 --
>  arch/mips/include/asm/pgtable-32.h           | 1 -
>  arch/mips/include/asm/pgtable-64.h           | 1 -
>  arch/nios2/include/asm/pgtable.h             | 2 --
>  arch/openrisc/include/asm/pgtable.h          | 1 -

Acked-by: Stafford Horne <shorne@gmail.com>

>  arch/parisc/include/asm/pgtable.h            | 2 --
>  arch/powerpc/include/asm/book3s/pgtable.h    | 1 -
>  arch/powerpc/include/asm/nohash/32/pgtable.h | 1 -
>  arch/powerpc/include/asm/nohash/64/pgtable.h | 2 --
>  arch/riscv/include/asm/pgtable.h             | 2 --
>  arch/s390/include/asm/pgtable.h              | 2 --
>  arch/sh/include/asm/pgtable.h                | 2 --
>  arch/sparc/include/asm/pgtable_32.h          | 1 -
>  arch/sparc/include/asm/pgtable_64.h          | 3 ---
>  arch/um/include/asm/pgtable-2level.h         | 1 -
>  arch/um/include/asm/pgtable-3level.h         | 1 -
>  arch/x86/include/asm/pgtable_types.h         | 2 --
>  arch/xtensa/include/asm/pgtable.h            | 1 -
>  include/linux/pgtable.h                      | 9 +++++++++
>  26 files changed, 9 insertions(+), 43 deletions(-)

This all looks fine to me, will this be merged via the arm tree?  I guess you
have a means for that.

-Stafford
