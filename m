Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44324E37D1
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 05:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiCVELl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 00:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiCVELk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 00:11:40 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE98443E1;
        Mon, 21 Mar 2022 21:10:12 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o3-20020a17090a3d4300b001c6bc749227so1080116pjf.1;
        Mon, 21 Mar 2022 21:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YF27/o9OojcIlWSRXUYvT844QPtgp8LqnE9dm5viGDQ=;
        b=ln3p25fvXLz32myeqm5t0hBcUE6tyk/PEExo8WqpnsfcP5zlqpV1ll671d9e8ZulpU
         lqusXemHq030YWLjogGgWnDGnYL0cm48TsOkP3kJ+Ppu09gPxXQR6O8pCqHds+7TJITD
         NaQ9KpeM5/G3c23uTqF2SHe/SF/5rBIaZ2uoM3yqKWz8h8l8wxtagttGDbq3rwY3g6Jg
         NLL2W5/Gym4XWW5+xpEsUWRIEEcmIIGtidxZwXe/7LkHIP+huczI1wrWMfMVE/Nv+76a
         YEsWTOvlvfCbnrWOA+E7H/WtgT82LDtjHDHfDWlU0jOk3iLi0o77i7cXOLCn93Ww39Ln
         WzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YF27/o9OojcIlWSRXUYvT844QPtgp8LqnE9dm5viGDQ=;
        b=utDLmObtwKGbirY/juADl7hjmFqFpuCENl8cvfxdLi0mo/v0Qea59W+9RxVviZBYzr
         S0LQK7DIDAppKk6DOu1mjyEtWjY8bM0rknqf3itt6/au1vBPFCgcIZ7jsPhg5vUgIdWS
         lH6l4tT49lhUKsVs4NEifSy2ScorNg1lJryJamCKOqbZT0xqOnPw2VaGXeXb86eyATpn
         o12bCX1c77naXDU8ppBL7rHwlhrDPGG1Zw5VhFGWD7COlRwbkhR1X0pVenOEmHWMz1bB
         VdF2vLet2kSeeBG8ywsboYhmBF4HDkEIwQ9OGBupAY7WAHzyORq9K5PYIUsy/585D3PH
         o26w==
X-Gm-Message-State: AOAM533ee5cSdGnZHTx6u8JM7s/rl8Di9NlTp8Uv8pj6tbhn3SwBBu/W
        ljKrDvXqL6li/IVbs6DQuXM=
X-Google-Smtp-Source: ABdhPJw8K6SJLgXLdJjpWrOAa7EmA/p3qAJ4MfsOv0WC5B8UWGhsRke1K9C1t22yXzXvRnFtjfyYXg==
X-Received: by 2002:a17:90b:1a8a:b0:1c5:f707:93a6 with SMTP id ng10-20020a17090b1a8a00b001c5f70793a6mr2699198pjb.110.1647922211988;
        Mon, 21 Mar 2022 21:10:11 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id t71-20020a63784a000000b00380a9f7367asm16932561pgc.77.2022.03.21.21.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 21:10:10 -0700 (PDT)
Date:   Tue, 22 Mar 2022 13:10:08 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>, jszhang@kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Openrisc <openrisc@lists.librecores.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 3/5] openrisc: Move to ticket-spinlock
Message-ID: <YjlMIGKgYaLLpp5T@antec>
References: <20220316232600.20419-1-palmer@rivosinc.com>
 <20220316232600.20419-4-palmer@rivosinc.com>
 <YjjuOZMzQlnqfLDJ@antec>
 <CAJF2gTSFh0NKLys7kr=UdQWHDyYgg3XmgTJtVaL37Re7QdZ8uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTSFh0NKLys7kr=UdQWHDyYgg3XmgTJtVaL37Re7QdZ8uw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 22, 2022 at 11:29:13AM +0800, Guo Ren wrote:
> On Tue, Mar 22, 2022 at 7:23 AM Stafford Horne <shorne@gmail.com> wrote:
> >
> > On Wed, Mar 16, 2022 at 04:25:58PM -0700, Palmer Dabbelt wrote:
> > > From: Peter Zijlstra <peterz@infradead.org>
> > >
> > > We have no indications that openrisc meets the qspinlock requirements,
> > > so move to ticket-spinlock as that is more likey to be correct.
> > >
> > > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > >
> > > ---
> > >
> > > I have specifically not included Peter's SOB on this, as he sent his
> > > original patch
> > > <https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>
> > > without one.
> > > ---
> > >  arch/openrisc/Kconfig                      | 1 -
> > >  arch/openrisc/include/asm/Kbuild           | 5 ++---
> > >  arch/openrisc/include/asm/spinlock.h       | 3 +--
> > >  arch/openrisc/include/asm/spinlock_types.h | 2 +-
> > >  4 files changed, 4 insertions(+), 7 deletions(-)
> >
> > Hello,
> >
> > This series breaks SMP support on OpenRISC.  I haven't traced it down yet, it
> > seems trivial but I have a few places to check.
> >
> > I replied to this on a kbuild warning thread, but also going to reply here with
> > more information.
> >
> >  https://lore.kernel.org/lkml/YjeY7CfaFKjr8IUc@antec/#R
> >
> > So far this is what I see:
> >
> >   * ticket_lock is stuck trying to lock console_sem
> >   * it is stuck on atomic_cond_read_acquire
> >     reading lock value: returns 0    (*lock is 0x10000)
> >     ticket value: is 1
> >   * possible issues:
> >     - OpenRISC is big endian, that seems to impact ticket_unlock, it looks
> All csky & riscv are little-endian, it seems the series has a bug with
> big-endian. Is that all right for qemu? (If qemu was all right, but
> real hardware failed.)

Hi Guo Ren,

OpenRISC real hardware and QEMU are both big-endian.  It fails on both.

I replied on patch 1/5 with a suggested patch which fixes the issue for me.
Please have a look.

BTW. now I can look into the sparse warnings.

-Stafford

