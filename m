Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9332B647BCE
	for <lists+linux-arch@lfdr.de>; Fri,  9 Dec 2022 03:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiLICCQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 21:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiLICCI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 21:02:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E476FF22;
        Thu,  8 Dec 2022 18:02:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E697862109;
        Fri,  9 Dec 2022 02:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D0AC433A8;
        Fri,  9 Dec 2022 02:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670551326;
        bh=TCJA0NUGNPVahhQQ1Hh45pVrzy/SBPNYQTr7lJlPvZA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AOt6nXINrFhD3l3S8AGeEWGjJdu/iDcqC7dw6pvW9uNXlKU9+xIAWyKn4Udpa9lGu
         tz23+Orysyyd7QCnMfAMmTRdIab5J2u5iFfwBH7SDRC2cjTlpeEy0W/UQVFCWvhTE/
         BND8LOG+YndCLHuyUZHcSDf0qNfb7d+J5YtXfZjhAv35OdXxypIdxGCxrwN2ZBAruR
         1QbdsIE7poNWNMJ+rqODLHdTTglEXEnrAEwEu3mEbFSDo9zei6lwpXt+3noXm3np9n
         yZQ4L8Z5aH6Cb3O4d4QBuqh7fmN1IvANZQOzw7nSV93uF1PVoKjUWeYIl/z2Pn79k7
         glwY4NMinObgw==
Received: by mail-ej1-f51.google.com with SMTP id kw15so8249048ejc.10;
        Thu, 08 Dec 2022 18:02:06 -0800 (PST)
X-Gm-Message-State: ANoB5plhqQ1XbwcbTxIi6wQ02D68XmLj4c2gLaT0F7fZrjlq9aBAB7M9
        n28GZWhFgsP0vqQNEo3XnV/nBXY5CMEQhWUyarI=
X-Google-Smtp-Source: AA0mqf7rwovsaAf13UZfyBGYG5BIBX9Qugpw3448wzFAmjiIot+YK5dKORtA+wYq7D7grCvkr7hneMnboU5JC+nuyIE=
X-Received: by 2002:a17:906:ee2:b0:78d:3f96:b7aa with SMTP id
 x2-20020a1709060ee200b0078d3f96b7aamr64216935eji.74.1670551324505; Thu, 08
 Dec 2022 18:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20221208025816.138712-1-guoren@kernel.org> <20221208025816.138712-7-guoren@kernel.org>
 <87r0xaw6fh.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87r0xaw6fh.fsf@all.your.base.are.belong.to.us>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 9 Dec 2022 10:01:52 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR+7phq0uaQOH_xtAju-q59BFDy2Nwf4MB=n3ZzV4W6Jg@mail.gmail.com>
Message-ID: <CAJF2gTR+7phq0uaQOH_xtAju-q59BFDy2Nwf4MB=n3ZzV4W6Jg@mail.gmail.com>
Subject: Re: [PATCH -next V10 06/10] riscv: entry: Consolidate
 ret_from_kernel_thread into ret_from_fork
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com, ben@decadent.org.uk,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
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

On Thu, Dec 8, 2022 at 6:12 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wro=
te:
>
> guoren@kernel.org writes:
>
> > From: Jisheng Zhang <jszhang@kernel.org>
> >
> > The ret_from_kernel_thread() behaves similarly with ret_from_fork(),
> > the only difference is whether call the fn(arg) or not, this can be
> > achieved by testing fn is NULL or not, I.E s0 is 0 or not. Many
> > architectures have done the same thing, it make entry.S more clean.
>
> Nit: "it makes".
Okay.

>
>
> Bj=C3=B6rn



--=20
Best Regards
 Guo Ren
