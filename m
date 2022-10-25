Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF7760C1EA
	for <lists+linux-arch@lfdr.de>; Tue, 25 Oct 2022 04:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiJYCvV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 22:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJYCvT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 22:51:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD03103242;
        Mon, 24 Oct 2022 19:51:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5D83B80EE4;
        Tue, 25 Oct 2022 02:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F816C43144;
        Tue, 25 Oct 2022 02:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666666275;
        bh=kLyDAivtXjl7b9FNwIOi8R/xoqspaY0DzbslbZXJA38=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p9sGE0hTLj2N8smJAMWAwVEgvmwR5nu8X+LWJVHEDJ87MYMKGN6BZKuSePCCnZ2de
         n8I3A3FOKw+iie0FiUolq4G1YFAyvMOj2pw55oFXx5McVpzNHFRDDkbSn3XWkXgoyc
         7eYpEM3BnwobLACC+xAAm0Rf+9tCWjJU4WpqHU05yA9ApdXtZXebZwGfLSyyw3qujF
         BH48uTSs15eFxhVsSROFM4SIpJARdCBhwxqtD70C7CY3zqxzYVNvRptd1phXgnyVDe
         +Xb8QHk8FrYi1W34G4hFSMarnBIfKQ9/WyGLQgUXx0FdYFaqcgo4ulUznDjZ3y8zWl
         V9+ZjZaOmvvQw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-13ae8117023so14100062fac.9;
        Mon, 24 Oct 2022 19:51:15 -0700 (PDT)
X-Gm-Message-State: ACrzQf2XflEQKNuY9iKF/jfsihs3BZ1y5aDRwF6Dhim1CAhHAhhUbcJq
        kSgboJ1p6gYXKr2MfmHMH0IPsZKB/0jedAINmLk=
X-Google-Smtp-Source: AMsMyM5EPDsIKsDhKpa2tacV+samW4UcYdf1FV41waP3RSXg7QVWFrQ47hBEkSt3VMDgDA6b2T4bsOr1hUPCpPWYyO4=
X-Received: by 2002:a05:6870:5803:b0:12c:c3e0:99dc with SMTP id
 r3-20020a056870580300b0012cc3e099dcmr37449251oap.19.1666666274587; Mon, 24
 Oct 2022 19:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221002012451.2351127-1-guoren@kernel.org> <20221002012451.2351127-5-guoren@kernel.org>
 <YzrJ0wQxWfjWCxhQ@FVFF77S0Q05N> <CAJF2gTRBEGx3qncpk_C8rCsFN+kqxjgeAcPvZU5m7kDnpwytoA@mail.gmail.com>
 <Y1ERsP0YYVNulWnw@FVFF77S0Q05N> <CAJF2gTTurEaFjbKvj1tUptq_TLpXeBAE1UstNYxriC-7r5MHpQ@mail.gmail.com>
 <Y1Z9U7XN4nlGg8yb@FVFF77S0Q05N> <Y1Z/rLaaUp7e9xoy@hirez.programming.kicks-ass.net>
 <Y1aBshGIWMEm+yTv@FVFF77S0Q05N>
In-Reply-To: <Y1aBshGIWMEm+yTv@FVFF77S0Q05N>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 25 Oct 2022 10:51:02 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQvmSuOP_QQ8RGfq2soLrv9XD3g=8v9pE+U0y+pzqMY4A@mail.gmail.com>
Message-ID: <CAJF2gTQvmSuOP_QQ8RGfq2soLrv9XD3g=8v9pE+U0y+pzqMY4A@mail.gmail.com>
Subject: Re: [PATCH V6 04/11] compiler_types.h: Add __noinstr_section() for noinstr
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>, arnd@arndb.de,
        palmer@rivosinc.com, tglx@linutronix.de, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, zouyipeng@huawei.com,
        bigeasy@linutronix.de, David.Laight@aculab.com,
        chenzhongjin@huawei.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 24, 2022 at 8:14 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Mon, Oct 24, 2022 at 02:06:04PM +0200, Peter Zijlstra wrote:
> > On Mon, Oct 24, 2022 at 12:56:03PM +0100, Mark Rutland wrote:
> >
> > > How about we split this like:
> > >
> > > | /*
> > > |  * Prevent the compiler from instrumenting this code in any way
> > > |  * This does not prevent instrumentation via KPROBES, which must be
> > > |  * prevented through other means if necessary.
> >
> > Perhaps point to NOINSTR_TEXT in vmlinux.lds.h
>
> Makes sense, will do.
Do I need to update the comment with NOINSTR_TEXT? eg:

 * Prevent the compiler from instrumenting this code in any way
 * This does not prevent instrumentation via KPROBES, which must be
 * prevented through other means if necessary. See NOINSTR_TEXT
 * in vmlinux.lds.h.

>
> >
> > > |  */
> > > | #define __no_compiler_instrument                          \
> > > |   noinline notrace noinline notrace __no_kcsan            \
> > > |   __no_sanitize_address __no_sanitize_coverage
> > > |
> > > | /*
> > > |  * Section for code which can't be instrumented at all.
> > > |  * Any code in this section cannot be instrumented with KPROBES.
> > > |  */
> > > | #define noinstr __no_compiler_instrument section(".noinstr.text")
> > >
> > > ... then we don't need __noinstr_section(), and IMO the split is
> > > clearer.
> >
> > Yeah, perhaps, no strong feelings. Note I have this in the sched-idle
> > series as well (which I still need to rebase and repost :/).
>
> Ah; I'll sit on this for now then, and once that's all in I can send a
> cleanup/rework patch. Sorry for the noise!
We still keep __noinstr_section(), right?

>
> Thanks,
> Mark.
--
Best Regards
 Guo Ren
