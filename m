Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE658645BF7
	for <lists+linux-arch@lfdr.de>; Wed,  7 Dec 2022 15:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiLGODv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Dec 2022 09:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiLGODY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Dec 2022 09:03:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE555CD27;
        Wed,  7 Dec 2022 06:01:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CAC1B81E09;
        Wed,  7 Dec 2022 14:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38088C433D6;
        Wed,  7 Dec 2022 14:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670421688;
        bh=w6UAheOP9K9CZ5W+S4wCRu1UQ6+nS3YNGMMAjD5DFyY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MLrY/zqjG/ZJ7HYgA23kiPlkV0x+qkbC/tPOePS7+em9Swf4jrZh9x7/yoPhl2jF/
         g6pbbE72mZS7xm76MLD2nKtp8MFbruMYbtDnP+ExJZP1N6vW4oYU4xC84ylMuHFAXq
         kWQ1Yh/rXA5Be06ZEZuSJqWfBJjgY0IW4vnGhzYt6D6dMAf6aumhOasT7A6LtStxbR
         diAhbtLLPxBppYciQQhdTFNru5YsXcKV/vEbNKDkAGf2hYO3CaKh5fn/IYHORQlBTE
         cHdSvjCZn/vOSGtHVoZW4L36e+2Z1Q7Y9VLNJuFLt6qa7bxaVVo89OLe+cxCYSqdzB
         bIc2/mQ/Pdv6A==
Received: by mail-ed1-f41.google.com with SMTP id r26so24972601edc.10;
        Wed, 07 Dec 2022 06:01:28 -0800 (PST)
X-Gm-Message-State: ANoB5pnssUNhmq9rdxoqvI7lB/syoAlKHGT0+SEUfCkaSUXx2al02yc6
        sXlc7wSh8krXmlrkSccM7VoSUV+jBGq0knuGJpw=
X-Google-Smtp-Source: AA0mqf5e447ZTB0mmY7c1BgYGRUmx4Bc61x2rBDn1ATvJuU5w3XAlzlyO8fRfBuxcJ0pFx5jkb8Tn1kE9DIihu4T8xQ=
X-Received: by 2002:a05:6402:289d:b0:46c:2460:cdf with SMTP id
 eg29-20020a056402289d00b0046c24600cdfmr20874014edb.103.1670421686467; Wed, 07
 Dec 2022 06:01:26 -0800 (PST)
MIME-Version: 1.0
References: <20221207091112.2258674-1-guoren@kernel.org> <Y5BdpHrKrRCw9izQ@spud>
In-Reply-To: <Y5BdpHrKrRCw9izQ@spud>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 7 Dec 2022 22:01:15 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRiTqnDiWtqkOrJFxLDFHjwikSeREFWVSJH2uV_WpAz4g@mail.gmail.com>
Message-ID: <CAJF2gTRiTqnDiWtqkOrJFxLDFHjwikSeREFWVSJH2uV_WpAz4g@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fixup compile error with !MMU
To:     Conor Dooley <conor@kernel.org>
Cc:     palmer@rivosinc.com, conor.dooley@microchip.com,
        liaochang1@huawei.com, lizhengyu3@huawei.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 7, 2022 at 5:32 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Wed, Dec 07, 2022 at 04:11:12AM -0500, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Current nommu_virt_defconfig can't compile:
> >
> > In file included from
> > arch/riscv/kernel/crash_core.c:3:
> > arch/riscv/kernel/crash_core.c:
> > In function 'arch_crash_save_vmcoreinfo':
> > arch/riscv/kernel/crash_core.c:8:27:
> > error: 'VA_BITS' undeclared (first use in this function)
> >     8 |         VMCOREINFO_NUMBER(VA_BITS);
> >       |                           ^~~~~~~
> >
> > Add MMU dependency for KEXEC_FILE.
> >
> > Fixes: 6261586e0c91 ("RISC-V: Add kexec_file support")
> > Reported-by: Conor Dooley <conor@kernel.org>
>
> FWIW (but certainly don't resend for this)
> s/conor@kernel.org/conor.dooley@microchip.com
>
> Thanks for the quick fix, there's other issues w/ that config for me,
> but this fixed the kexec bits :)
> Tested-by: Conor Dooley <conor.dooley@microchip.com>
Thx for the report and test.

>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > ---
> >  arch/riscv/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index ef8d66de5f38..91319044fd13 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -496,7 +496,7 @@ config KEXEC_FILE
> >       select KEXEC_CORE
> >       select KEXEC_ELF
> >       select HAVE_IMA_KEXEC if IMA
> > -     depends on 64BIT
> > +     depends on 64BIT && MMU
> >       help
> >         This is new version of kexec system call. This system call is
> >         file based and takes file descriptors as system call argument
> > --
> > 2.36.1
> >



-- 
Best Regards
 Guo Ren
