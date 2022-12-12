Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27886499B4
	for <lists+linux-arch@lfdr.de>; Mon, 12 Dec 2022 08:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiLLHr0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Dec 2022 02:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLLHrZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Dec 2022 02:47:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788E2B858;
        Sun, 11 Dec 2022 23:47:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30E7EB80B2A;
        Mon, 12 Dec 2022 07:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB349C4339C;
        Mon, 12 Dec 2022 07:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670831241;
        bh=WodXS32v21twmYiAX4EYlvjeOy5WNyupQTY3RKVIkMQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JRhQfJB40YY1E5o01ZIlNYc/kdRlHLSopZcdsjGRcGGaq/j8ogOV5FOb9ECPuXpV3
         3F4kAF7d+ZePQLnhrtqk6TnGyTB7nJJmBf2/SwzmXO29+gKYoL77hm28HSpGSMc0kc
         +e5bvEF2reg5XXKTe0uv4HxENb9IF0VZHq8iZS2xWKyg2FfeZe8hBGYa+lhgufAJT9
         jS7/rhDtZofEslTd5R8ecnylbu/UK6DX28P1RNHVo3raOFea75pK3+Xml6J/Ie6kmC
         BJI6vGkuF6tdHzwGsXZD9plAR/tqCoVTjgpqIWRi5XCnkL/dX28blJmeeOFpUMyBb6
         da2jonlWoe9QA==
Received: by mail-ej1-f48.google.com with SMTP id gh17so25756697ejb.6;
        Sun, 11 Dec 2022 23:47:21 -0800 (PST)
X-Gm-Message-State: ANoB5pnAFC0dHZFggu6F/6FUTDOq14Wr6B5gNjiVxRcIiUWbH4Dw1y2e
        BKsWxxeMGPUx6c6qDpyQTkjnna1Rn2Q6nvkNmi4=
X-Google-Smtp-Source: AA0mqf7N7UFVN5fBKS9zwvAu/9ydpmWDWTK7ZNrJwhsUxCGulp+irELYyY+9ZVZUSyYbpQOC8Wlu29oUzLHN3ddUewU=
X-Received: by 2002:a17:906:1546:b0:741:5c0e:1058 with SMTP id
 c6-20020a170906154600b007415c0e1058mr79503869ejd.472.1670831239987; Sun, 11
 Dec 2022 23:47:19 -0800 (PST)
MIME-Version: 1.0
References: <20221210171141.1120123-1-guoren@kernel.org> <87o7s9ay4v.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87o7s9ay4v.fsf@all.your.base.are.belong.to.us>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 12 Dec 2022 15:47:08 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTtw2A3Xkp7HZR4e+g9kZ9DGJx+gG2PtoTz1uAjnJ0mQw@mail.gmail.com>
Message-ID: <CAJF2gTTtw2A3Xkp7HZR4e+g9kZ9DGJx+gG2PtoTz1uAjnJ0mQw@mail.gmail.com>
Subject: Re: [PATCH -next V11 0/7] riscv: Add GENERIC_ENTRY support
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, paul.walmsley@sifive.com,
        mark.rutland@arm.com, greentime.hu@sifive.com,
        andy.chiu@sifive.com, ben@decadent.org.uk,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 12, 2022 at 3:18 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wr=
ote:
>
> guoren@kernel.org writes:
>
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The patches convert riscv to use the generic entry infrastructure from
> > kernel/entry/*. Some optimization for entry.S with new .macro and merge
> > ret_from_kernel_thread into ret_from_fork.
> >
> > The 1,2 are the preparation of generic entry. 3~7 are the main part
> > of generic entry.
> >
> > All tested with rv64, rv32, rv64 + 32rootfs, all are passed.
> >
> > You can directly try it with:
> > [1] https://github.com/guoren83/linux/tree/generic_entry_v11
Sorry, I forgot to push. Now it's ready.

>
> FWIW, the v11 branch is not available here.
>
> This series is a really nice cleanup for the RISC-V entry code. I've run
> it on some kernel selftests, and haven't seen any issues.
>
> I'm looking forward to having this series pulled in!
>
> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Thx.



--=20
Best Regards
 Guo Ren
