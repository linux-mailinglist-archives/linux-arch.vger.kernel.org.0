Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D5255403D
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jun 2022 03:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbiFVBvu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jun 2022 21:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiFVBvt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2022 21:51:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FB621256;
        Tue, 21 Jun 2022 18:51:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73D6961826;
        Wed, 22 Jun 2022 01:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D486DC385A2;
        Wed, 22 Jun 2022 01:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655862707;
        bh=yAoKxvq/RDbFoDjWadpyfGoPvsAe+GvtjboXMAJrB8U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WP2uA5+yhzxAiocs6TllYglw5Ney2lvFwuVS5SuF0ppeNQ7msSMo4PXnlYTThFAZO
         YRGmSuDuMFw6ndaXYOjX8PNgUMYls9HqiZawFwuYtkWg84/SdwXkTbbefygZCYPHNn
         hKYS3ttp+RikGG5yPSKGkdB3pjlN8kS/8u1Eu8vdOQ0Zyu9tS0sxlBcfkCdn4DLnoS
         SiXSN91uqHfjT8NG2YxB3aTVlSozwP5oTltY3J9Y1W8CL8B5jwZaZAZf70QVUqcJFR
         P4A/qi1fV80eWXT2k9g8VWLiHAr+i/epDObiHViCE1nKzp9oca6ru6y6VRVyv/E2sH
         j+nifdccyjbzQ==
Received: by mail-vs1-f41.google.com with SMTP id j6so7373224vsi.0;
        Tue, 21 Jun 2022 18:51:47 -0700 (PDT)
X-Gm-Message-State: AJIora/RraxxzCplyV5NnCEzBZMXcGG7U1gz7PgI1fitHqB+8NnISEj7
        nIbYE3t6hGQ4u6Q5pR5ae4BTEISBK2o2vpjQSt4=
X-Google-Smtp-Source: AGRyM1utZR//1y9issFD2tF2ldIncQQvR5Nc0+J0YOMi+6mLMJ2YHmHXaBKMVlzbI2nwm0FGLrq3VBDF3kYog1PA9kU=
X-Received: by 2002:a05:6102:f8b:b0:354:57e8:4c1b with SMTP id
 e11-20020a0561020f8b00b0035457e84c1bmr970617vsv.8.1655862706699; Tue, 21 Jun
 2022 18:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220621144920.2945595-1-guoren@kernel.org> <7adc9e19-7ffc-4b11-3e18-6e3a5225638f@redhat.com>
In-Reply-To: <7adc9e19-7ffc-4b11-3e18-6e3a5225638f@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 22 Jun 2022 09:51:35 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT4Q3HLabXPgACOmd-Z58LsD-77ga74pzgUT2scr+ydRA@mail.gmail.com>
Message-ID: <CAJF2gTT4Q3HLabXPgACOmd-Z58LsD-77ga74pzgUT2scr+ydRA@mail.gmail.com>
Subject: Re: [PATCH V6 0/2] riscv: Support qspinlock with generic headers
To:     Waiman Long <longman@redhat.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Conor.Dooley@microchip.com,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>, hev <r@hev.cc>,
        Stafford Horne <shorne@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 21, 2022 at 11:08 PM Waiman Long <longman@redhat.com> wrote:
>
> On 6/21/22 10:49, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Enable qspinlock and meet the requirements mentioned in a8ad07e5240c9
> > ("asm-generic: qspinlock: Indicate the use of mixed-size atomics").
> >
> > RISC-V LR/SC pairs could provide a strong/weak forward guarantee that
> > depends on micro-architecture. And RISC-V ISA spec has given out
> > several limitations to let hardware support strict forward guarantee
> > (RISC-V User ISA - 8.3 Eventual Success of Store-Conditional
> > Instructions):
> > We restricted the length of LR/SC loops to fit within 64 contiguous
> > instruction bytes in the base ISA to avoid undue restrictions on
> > instruction cache and TLB size and associativity. Similarly, we
>
> Does the 64 contiguous bytes need to be cacheline aligned?
No, they are instructions, and the IFU & issue units would guarantee
that. The programmer needn't worry about that.

>
> Regards,
> Longman
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
