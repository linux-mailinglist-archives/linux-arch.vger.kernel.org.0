Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F545E8B9D
	for <lists+linux-arch@lfdr.de>; Sat, 24 Sep 2022 12:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiIXK4z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 24 Sep 2022 06:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbiIXK4z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Sep 2022 06:56:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B43F1EAF3;
        Sat, 24 Sep 2022 03:56:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9939E60D2D;
        Sat, 24 Sep 2022 10:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02904C43470;
        Sat, 24 Sep 2022 10:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664017013;
        bh=V4Q7joVq4Vh28mV5JoGwZY9Fr4z3XEyNHjibZkJ6xM4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XdysJCEuXc5cvgbcvmOqzfh/Tntg3OJpYkLUjv4xCp6KqMXMsUZ1doFoS6Iy4ItVz
         O7Qzq3us/5mhsukwWTaqD9autRwqAx2N2K44iDqdovBgnl8+M+4cCvGCblmTRnNs8Q
         xbxUDewfMG5SoTByCOFybq5ftocddJNdJbFayCan36kYuj0FGY47EF/Lfz9XtpP0+6
         Wsj3DreWLlQY41Mm5+2KAe5A2AZhjhxjgluKZ0BB3ykWuA+SRrmHDJ3GzKnHhU2DBK
         zFVBQbMhwKv3faWKGsBbpX73hFiTotXTveq0+6zWzfydZBX01e66DDQtkYeg52LWGM
         9tpoQTVVMNM4A==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-12b542cb1d3so3397994fac.13;
        Sat, 24 Sep 2022 03:56:52 -0700 (PDT)
X-Gm-Message-State: ACrzQf3R7dyKYNw1awv9v9WlWrGs7/d6H5IkfsLebC9dDXCRBhlYyUGU
        FeJS7zynvB7Tcb6ekLPcUOsgGaNND/Hc5jvOjZc=
X-Google-Smtp-Source: AMsMyM7okz2g4+Eu8G2Vgq5ZMGTyNCaXzvu5bWg1+8D0MA3PwS8EAeFcqVNA5Op6Tyhd+HCgMYihgYioopETaTo0aSQ=
X-Received: by 2002:a05:6870:5803:b0:12c:c3e0:99dc with SMTP id
 r3-20020a056870580300b0012cc3e099dcmr13275175oap.19.1664017012091; Sat, 24
 Sep 2022 03:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220921033134.3133319-1-guoren@kernel.org> <20220921033134.3133319-4-guoren@kernel.org>
 <5594014.Sb9uPGUboI@phil>
In-Reply-To: <5594014.Sb9uPGUboI@phil>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 24 Sep 2022 18:56:39 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQqWFfcJsAn_UPaXVdC6HQecnLyFPBOrnpxrJfWJMsOeQ@mail.gmail.com>
Message-ID: <CAJF2gTQqWFfcJsAn_UPaXVdC6HQecnLyFPBOrnpxrJfWJMsOeQ@mail.gmail.com>
Subject: Re: [PATCH V4 3/3] arch: crash: Remove duplicate declaration in smp.h
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     xianting.tian@linux.alibaba.com, palmer@dabbelt.com,
        palmer@rivosinc.com, liaochang1@huawei.com, jszhang@kernel.org,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 23, 2022 at 7:00 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Am Mittwoch, 21. September 2022, 05:31:34 CEST schrieb guoren@kernel.org:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Remove crash_smp_send_stop declarations in arm64, x86 asm/smp.h which
> > has been done in include/linux/smp.h.
>
> nit: the commit message could reference the commit that brought in the
> generic declarations, which was
>         6f1f942cd5fb ("smp: kernel/panic.c - silence warnings")
Good advice, thx.

>
> other than that
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>
>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  arch/arm64/include/asm/smp.h | 1 -
> >  arch/x86/include/asm/crash.h | 1 -
> >  2 files changed, 2 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
> > index fc55f5a57a06..a108ac93fd8f 100644
> > --- a/arch/arm64/include/asm/smp.h
> > +++ b/arch/arm64/include/asm/smp.h
> > @@ -141,7 +141,6 @@ static inline void cpu_panic_kernel(void)
> >   */
> >  bool cpus_are_stuck_in_kernel(void);
> >
> > -extern void crash_smp_send_stop(void);
> >  extern bool smp_crash_stop_failed(void);
> >  extern void panic_smp_self_stop(void);
> >
> > diff --git a/arch/x86/include/asm/crash.h b/arch/x86/include/asm/crash.h
> > index 8b6bd63530dc..6a9be4907c82 100644
> > --- a/arch/x86/include/asm/crash.h
> > +++ b/arch/x86/include/asm/crash.h
> > @@ -7,6 +7,5 @@ struct kimage;
> >  int crash_load_segments(struct kimage *image);
> >  int crash_setup_memmap_entries(struct kimage *image,
> >               struct boot_params *params);
> > -void crash_smp_send_stop(void);
> >
> >  #endif /* _ASM_X86_CRASH_H */
> >
>
>
>
>


-- 
Best Regards
 Guo Ren
