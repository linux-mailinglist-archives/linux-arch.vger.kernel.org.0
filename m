Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECAC7467AA
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jul 2023 04:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjGDCog (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jul 2023 22:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGDCof (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jul 2023 22:44:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CE8E47;
        Mon,  3 Jul 2023 19:44:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 567E861113;
        Tue,  4 Jul 2023 02:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13D1C433C7;
        Tue,  4 Jul 2023 02:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688438673;
        bh=2ry2wUhl2WMVG4MRkJi45ZsW532TaR/pjwLU5mXIfCc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aUl4cSCdJ5X6MX+W9I6drCrKeZmGSl6GzooJIZypbQTlDHqr4ImgrQEpRIT8Dcved
         8MdYMw9HIjUfPjCI0NOfuis66CtqorcguJgknN8X1yF9BlOG1FBqrnhxBVR0IWfU2H
         MPY5+cBgNJxmwy5zLjlL4oFYVaxXIlhvBd9Ral0So+k+XEQ7xCHnltOf4w3m4SGOmJ
         RheQR9TXRmaD0bycOPZHRA7PhHqnwP7bfRZZtZmgEtoaphrs/xcrlse7mik7Xys19k
         k4+btCNNsl4wfnMmaqVG/dk2c38gCCF3Q12vzUQlDgTQ98RylCtNZClEgOcUUklDwQ
         invRhiirGygFg==
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3fba545d743so67706885e9.0;
        Mon, 03 Jul 2023 19:44:33 -0700 (PDT)
X-Gm-Message-State: AC+VfDxe7IY4O3dglw6iBhJ6kjBrUrM28mGIfNzNhNAXdsEneCBhDnmy
        pyWt+gqnrWXehTRk0dC+Ehq117B/kFPQhSqW5JY=
X-Google-Smtp-Source: ACHHUZ4aICqMI3CbW0/Bc26b7AmiXVkfoxo3S3bhnlDZvksxazD60nP7rp2uYQWqnW0Wj0S1IRug7Xj5k09eDMHD3tE=
X-Received: by 2002:a05:600c:2305:b0:3f8:c70e:7ed1 with SMTP id
 5-20020a05600c230500b003f8c70e7ed1mr11186990wmo.20.1688438672057; Mon, 03 Jul
 2023 19:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230702025708.784106-1-guoren@kernel.org> <20230703102941.GA4328@aspen.lan>
In-Reply-To: <20230703102941.GA4328@aspen.lan>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 4 Jul 2023 10:44:20 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTaeO_u1tuHyCmWKptvg=W52gLY2xue2DbnbC6kihPTog@mail.gmail.com>
Message-ID: <CAJF2gTTaeO_u1tuHyCmWKptvg=W52gLY2xue2DbnbC6kihPTog@mail.gmail.com>
Subject: Re: [PATCH] riscv: entry: Fixup do_trap_break from kernel side
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, bjorn@kernel.org,
        palmer@dabbelt.com, bjorn@rivosinc.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        stable@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 3, 2023 at 6:29=E2=80=AFPM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Sat, Jul 01, 2023 at 10:57:07PM -0400, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The irqentry_nmi_enter/exit would force the current context into in_int=
errupt.
> > That would trigger the kernel to dead panic, but the kdb still needs "e=
break" to
> > debug the kernel.
> >
> > Move irqentry_nmi_enter/exit to exception_enter/exit could correct hand=
le_break
> > of the kernel side.
>
> <snip>
>
> > Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
> > Reported-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: stable@vger.kernel.org
>
> I pushed this though the kgdb test suite that originally found the
> problem (although it didn't occur to me when I reported it that
> the problem was nothing to do with kgdb ;-) ). So FWIW:
>
> Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Thx for the report & tested-by.

>
>
> Daniel.



--=20
Best Regards
 Guo Ren
