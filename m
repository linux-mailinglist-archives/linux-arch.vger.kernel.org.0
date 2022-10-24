Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3D8609EBB
	for <lists+linux-arch@lfdr.de>; Mon, 24 Oct 2022 12:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiJXKIo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 06:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiJXKIC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 06:08:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BED565031;
        Mon, 24 Oct 2022 03:07:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E4A8B810B9;
        Mon, 24 Oct 2022 10:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2332FC43148;
        Mon, 24 Oct 2022 10:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666606041;
        bh=sHcd7a6CJYMXJN0T3O0Gmv4Ta3CAm5TN0dTsZcDGJ14=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ReZ2aXSu4iGUnECx43CmDCXR51jonPgXWttAkMbJ1vxW/RfZox0LtcML3bEU7c6D7
         hdY6vFzKrPAA6r4Rm+e+K9hwkdX6VDQBN3H/19MwBbioinWgiIdaWnhaFmEg45/IOe
         k8lDkDEQqTW4YPjEYFwOUXoRMUJLb0fRcW99YI6C7iH8dt/CzZ3ykwxv/iRXvKLaUR
         hl5j4uzA33e/5/L/4GxfTd0EaJRBYEzeKNcQXqS2bEYHXJxQyEvvaPwkW6k+ORlR9B
         JP/TPxwM/0BQiitncrp9Xhx3Y5OspSVCm1pgRk+AaXFrhkig3okDrlgpl/cmP8aYe3
         7JiaGnT4JjCsw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1322d768ba7so11288672fac.5;
        Mon, 24 Oct 2022 03:07:21 -0700 (PDT)
X-Gm-Message-State: ACrzQf0njA5MyTXB1kRWssL0s5jBIsCMszVXzhcaEXhkW/6GAdkP7VWg
        PQhfsBJEhlNJKvjz3v7uV9hyYAE/EdH+gOf0sL0=
X-Google-Smtp-Source: AMsMyM7QXKv6uxTpUWFoPA/4LGtlOREZxkoYaz1p9CiCmnpdXChNo5b56CWYTdva7IGbg7H9Bi+XdpUjePtX7f4UGH0=
X-Received: by 2002:a05:6870:5803:b0:12c:c3e0:99dc with SMTP id
 r3-20020a056870580300b0012cc3e099dcmr35011449oap.19.1666606040276; Mon, 24
 Oct 2022 03:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221020135913.2850550-1-guoren@kernel.org> <Y1Fb4HGzJEKCD1SF@zn.tnic>
In-Reply-To: <Y1Fb4HGzJEKCD1SF@zn.tnic>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 24 Oct 2022 18:07:08 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR92khYqensUorjWTQz=8u9HSsbmwSa2FBWmRsUkoxJcA@mail.gmail.com>
Message-ID: <CAJF2gTR92khYqensUorjWTQz=8u9HSsbmwSa2FBWmRsUkoxJcA@mail.gmail.com>
Subject: Re: [PATCH] arch: crash: Remove duplicate declaration in smp.h
To:     arnd@arndb.de, Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        heiko@sntech.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 20, 2022 at 10:32 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Oct 20, 2022 at 09:59:13AM -0400, guoren@kernel.org wrote:
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
>
> Acked-by: Borislav Petkov <bp@suse.de>
Thx.

Hi, Arnd

Because it crosses the architecture, could you take this in your next-tree?

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette



-- 
Best Regards
 Guo Ren
