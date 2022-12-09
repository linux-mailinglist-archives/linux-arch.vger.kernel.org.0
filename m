Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50CB647BC8
	for <lists+linux-arch@lfdr.de>; Fri,  9 Dec 2022 03:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiLICBj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 21:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLICBi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 21:01:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7678D23151;
        Thu,  8 Dec 2022 18:01:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E882B82706;
        Fri,  9 Dec 2022 02:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C269C433A0;
        Fri,  9 Dec 2022 02:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670551295;
        bh=SkG0VIqWAQWylgRHfoMeG8lBjjuRZ9GmA+y0TH1J3fc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OxMFuJAK3rAc1PnY53u3QDUfFVttYZYZfiGw5pEgn96yEXMo5CdKl/qc9/Z9zNAky
         6LzbsRUJUFl4GYnKPVebOode5qURJq0CSVwyXn2fzTE4Mx9k0GSkYLNEgUR/VrKJyv
         tY6fWQcabY2yJne/YtnclSXOvvSEjAOMHMlSPqu/OS25aqQzoh12B9H3MXOj41noHN
         DeMX43aEcG5OTZfQ8BR3aVvhMJ2AuiaGp1XXNST6RFRLjxyEboOTW67+afB3ccvwUz
         9ItzqMp00KcoZRr5vm2icwLDoq6QroF5C26+Cvi2qR7GffV150QmVfRH8MkiiqqbvN
         zqIFww+131gmg==
Received: by mail-ed1-f49.google.com with SMTP id i15so1325300edf.2;
        Thu, 08 Dec 2022 18:01:34 -0800 (PST)
X-Gm-Message-State: ANoB5pkFEzt78cfKEg2Hmt220NG4xB1bjbgoSj4wRuLkEdFVA6xsj4KH
        zKrw6lGvBhMQetxTFvtPJwVqZdqzRfrW3glpkGU=
X-Google-Smtp-Source: AA0mqf5C/3tfEMZ0PsbumjXajBPqoEmuMmeihHRWIZKLRicqq0E/oDxh0zU8cL/o0mSjqj7e5LlTwvlQ3cMBhv+JcfE=
X-Received: by 2002:a05:6402:538a:b0:458:fbd9:e3b1 with SMTP id
 ew10-20020a056402538a00b00458fbd9e3b1mr28452851edb.6.1670551292956; Thu, 08
 Dec 2022 18:01:32 -0800 (PST)
MIME-Version: 1.0
References: <20221208025816.138712-1-guoren@kernel.org> <20221208025816.138712-6-guoren@kernel.org>
 <87sfhqw6ge.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87sfhqw6ge.fsf@all.your.base.are.belong.to.us>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 9 Dec 2022 10:01:21 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR3Eebw7juPiW4zA122qQKJjw4+7eC54vHgTDpctqJopA@mail.gmail.com>
Message-ID: <CAJF2gTR3Eebw7juPiW4zA122qQKJjw4+7eC54vHgTDpctqJopA@mail.gmail.com>
Subject: Re: [PATCH -next V10 05/10] riscv: entry: Remove extra level wrappers
 of trace_hardirqs_{on,off}
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

On Thu, Dec 8, 2022 at 6:11 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wro=
te:
>
> guoren@kernel.org writes:
>
> > From: Jisheng Zhang <jszhang@kernel.org>
> >
> > Since riscv is converted to generic entry, there's no need for the
> > extra wrappers of trace_hardirqs_{on,off}.
> >
> > Tested with llvm + irqsoff.
>
> What does this mean?
It's just a tested environment description. This is covered by the
generic entry. This patch removes unused code.

I would remove the "Tested with llvm + irqsoff." sentence; it's unnecessary=
.

>
>
> Bj=C3=B6rn



--=20
Best Regards
 Guo Ren
