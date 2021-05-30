Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1853394EA7
	for <lists+linux-arch@lfdr.de>; Sun, 30 May 2021 02:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhE3Acg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 May 2021 20:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhE3Acf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 May 2021 20:32:35 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB298C061574
        for <linux-arch@vger.kernel.org>; Sat, 29 May 2021 17:30:57 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id f3-20020a17090a4a83b02901619627235bso2472102pjh.1
        for <linux-arch@vger.kernel.org>; Sat, 29 May 2021 17:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=lUMGhkNpzUYJl7mNHm/MIb9alcAEBQViZqKnCFlPkiQ=;
        b=IzBDDXAvaOLrqEa29uJVLU4OPt+UZpVx3SAwSF/lYpM99VEml2Jygyadpibil7SOpC
         ub135CdmEB3N6uDJOho5LxpKnKBmkfc/y4lwV9uMmRI9fPMl5pXy8XCqPAIAvq01vaDz
         /uYn0usaKGewAtoas5Equmd4zE8er4CS4amBxn6G4dtgtNJ1LjdMLwpNbrq8tiqAmi83
         Jv7N33mlpPMHfwpBtMYcrF1Sp8BhdyY0/i0dDfUed/tjzBivauNVZbPv1Iv+QuB9MI3P
         KIclbaOB96QipZnVQ3GkT+OZpx5VmVbi2F3MPuCAK6caVWDcVx2JDLgi0zkX/IFYx9Sj
         ehMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=lUMGhkNpzUYJl7mNHm/MIb9alcAEBQViZqKnCFlPkiQ=;
        b=RPd+S8lgGpziNWQnlKtlI4CyLNdtwbaSsddT8o+EOMW9F8RjZBzzI6rpuamiHdOgcW
         mUEqUY5ZvsMzsGs9/Q3D0PGbsLFOiGOig+kT3O/a7Bt/e6dxgRJXpEDx3jfd/1eTzbfv
         ofZ3DHZZotO9T6/NjkSkG3FhcLVInRtFSWl64CnSA7JC28v1upon7Z0SvTGc3ufkkgLS
         5q/fg9218LWRsAaGAG3zGix9060gYj+9lZRAYnxiJJpN45r9Djms8NWGPsB2Ahm1seui
         DQcuk7S1zLNeQhtxFERgJsC/vqLJCIt08ctsiAqt3ceRFOl6FbkF7YlDq0cde2n1XtzN
         SZ7A==
X-Gm-Message-State: AOAM532ZVaWqprPx9khYuRVz4vxkyvI8ZSIsekvZxsq+46sdmueiD6Kv
        jHFz3aAi30S8R23aUciXD4qbIA==
X-Google-Smtp-Source: ABdhPJzrK7ewIhdD+iXeUeeT39stH/hdTmeacu5hMJYBb9S+GydnapzD2mWKbjiiY7+PLg6yph1MeQ==
X-Received: by 2002:a17:90b:3e89:: with SMTP id rj9mr314786pjb.114.1622334657147;
        Sat, 29 May 2021 17:30:57 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 13sm7583786pfz.91.2021.05.29.17.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 17:30:56 -0700 (PDT)
Date:   Sat, 29 May 2021 17:30:56 -0700 (PDT)
X-Google-Original-Date: Sat, 29 May 2021 17:30:41 PDT (-0700)
Subject:     Re: [PATCH] arch: Cleanup unused functions
In-Reply-To: <CAJF2gTTMYi-fr2kz5PHBtZ17iJdq0gN5UWT+eRV7ODwNfUcqrw@mail.gmail.com>
CC:     Anup Patel <Anup.Patel@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        guoren@linux.alibaba.com, monstr@monstr.eu
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     guoren@kernel.org
Message-ID: <mhng-fbb37e83-fd8f-406f-b258-1a8e3fbd8591@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 29 May 2021 17:26:20 PDT (-0700), guoren@kernel.org wrote:
> On Sun, May 30, 2021 at 7:08 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>>
>> On Tue, 25 May 2021 05:20:34 PDT (-0700), guoren@kernel.org wrote:
>> > From: Guo Ren <guoren@linux.alibaba.com>
>> >
>> > These functions haven't been used, so just remove them. The patch
>> > has been tested with riscv, but I only use grep to check the
>> > microblaze's.
>> >
>> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>> > Cc: Arnd Bergmann <arnd@arndb.de>
>> > Cc: Michal Simek <monstr@monstr.eu>
>> > Cc: Christoph Hellwig <hch@lst.de>
>> > ---
>> >  arch/microblaze/include/asm/page.h |  3 ---
>> >  arch/riscv/include/asm/page.h      | 10 ----------
>> >  2 files changed, 13 deletions(-)
>> >
>> > diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
>> > index bf681f2..ce55097 100644
>> > --- a/arch/microblaze/include/asm/page.h
>> > +++ b/arch/microblaze/include/asm/page.h
>> > @@ -35,9 +35,6 @@
>> >
>> >  #define ARCH_SLAB_MINALIGN   L1_CACHE_BYTES
>> >
>> > -#define PAGE_UP(addr)        (((addr)+((PAGE_SIZE)-1))&(~((PAGE_SIZE)-1)))
>> > -#define PAGE_DOWN(addr)      ((addr)&(~((PAGE_SIZE)-1)))
>> > -
>> >  /*
>> >   * PAGE_OFFSET -- the first address of the first page of memory. With MMU
>> >   * it is set to the kernel start address (aligned on a page boundary).
>> > diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
>> > index 6a7761c..a1b888f 100644
>> > --- a/arch/riscv/include/asm/page.h
>> > +++ b/arch/riscv/include/asm/page.h
>> > @@ -37,16 +37,6 @@
>> >
>> >  #ifndef __ASSEMBLY__
>> >
>> > -#define PAGE_UP(addr)        (((addr)+((PAGE_SIZE)-1))&(~((PAGE_SIZE)-1)))
>> > -#define PAGE_DOWN(addr)      ((addr)&(~((PAGE_SIZE)-1)))
>> > -
>> > -/* align addr on a size boundary - adjust address up/down if needed */
>> > -#define _ALIGN_UP(addr, size)        (((addr)+((size)-1))&(~((size)-1)))
>> > -#define _ALIGN_DOWN(addr, size)      ((addr)&(~((size)-1)))
>> > -
>> > -/* align addr on a size boundary - adjust address up if needed */
>> > -#define _ALIGN(addr, size)   _ALIGN_UP(addr, size)
>> > -
>> >  #define clear_page(pgaddr)                   memset((pgaddr), 0, PAGE_SIZE)
>> >  #define copy_page(to, from)                  memcpy((to), (from), PAGE_SIZE)
>>
>> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
>> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
>>
>> It's generally easier if you split this sort of stuff up, as it'll be
>> easier to merge if we don't have to coordinate between the trees.  I'm
>> happy to take this, but I'd prefer an Ack from one of the microblaze
>> folks first.
> Em ... I'll separate it. Thx for reply.

Thanks, I'll drop this and expect a new one to show up.
