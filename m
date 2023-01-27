Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B8267DC08
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jan 2023 03:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjA0CCD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 21:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjA0CBe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 21:01:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A342974C35;
        Thu, 26 Jan 2023 17:56:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8648761A21;
        Fri, 27 Jan 2023 01:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CBEC4339B;
        Fri, 27 Jan 2023 01:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674784552;
        bh=xIIQl3ZB2+RMmaEg43n6+TKITV6u4wlncwDLBsaGFaE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FbcVwIs4hYmawu4L5kFbiFzSg6HjE5UJxiHNmSoNb+Z8SXVM2Zajny/2L+EkYrQq1
         JeLUPqIbPbK2ikEtw0k5XLrAfbneqVwc7MlHApfiKYUao5wGhaskNBZTo0qZjL2QLX
         1cPoyOUkVd1IoQp+y/E5KD3i4U2cXqKV3yBHhXJ2K89quHh/ZI0S5XPmnEM4S7TGpP
         ys8jYtYiIYjijQEs9rivCl86v7KfSGkFo4QFwe1q+4eUlF7mRTSoFVxXLf9JYGhN/w
         XuVwjHkt6evg0UtyVRO6YOwH04POkLpTdZaZ+itlILOHN1ypnKkSjzMTxyHXaEiM2X
         /us6kh6Kp72yA==
Received: by mail-ej1-f48.google.com with SMTP id ss4so9930726ejb.11;
        Thu, 26 Jan 2023 17:55:52 -0800 (PST)
X-Gm-Message-State: AFqh2kpHIIzZvMh5mCnpEan5xttjUXzDHjt20jy3b0HArNce6Dx/vo9V
        2yn5bTOizfnqCLFhC+9K+FSmxtPiV0M3YP2yOYU=
X-Google-Smtp-Source: AMrXdXvopK2g6QSnHhoWKIzgYgeptPf/W6Irz4d4w98uaPvM/YRNF511bGJiZPWLeks6aVTKf88CzEoCM6lvCrnsi7Q=
X-Received: by 2002:a17:906:bc54:b0:871:9048:b7e9 with SMTP id
 s20-20020a170906bc5400b008719048b7e9mr5464421ejv.120.1674784550987; Thu, 26
 Jan 2023 17:55:50 -0800 (PST)
MIME-Version: 1.0
References: <20230126172516.1580058-1-guoren@kernel.org> <20230126172516.1580058-2-guoren@kernel.org>
 <CANiq72=Srm7aBu7Stz8-t1PkhFsPXUyoxaLJCLJHG9b6mVc8sQ@mail.gmail.com>
In-Reply-To: <CANiq72=Srm7aBu7Stz8-t1PkhFsPXUyoxaLJCLJHG9b6mVc8sQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 27 Jan 2023 09:55:39 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTATWUHuCLWfpDfh_d-Wq72ry_=RnsDS_tFCxkgvAm99g@mail.gmail.com>
Message-ID: <CAJF2gTTATWUHuCLWfpDfh_d-Wq72ry_=RnsDS_tFCxkgvAm99g@mail.gmail.com>
Subject: Re: [PATCH -next V15 1/7] compiler_types.h: Add __noinstr_section()
 for noinstr
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, ben@decadent.org.uk,
        bjorn@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 27, 2023 at 3:14 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Jan 26, 2023 at 6:25 PM <guoren@kernel.org> wrote:
> >
> > From: Lai Jiangshan <laijs@linux.alibaba.com>
> >
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
>
> If Lai is the author, but you are submitting it, shouldn't your
> `Signed-off-by` be after his? Or are you co-authors? (but then it
> would need a Co-developed-by tag)
Okay

>
> Cheers,
> Miguel



-- 
Best Regards
 Guo Ren
