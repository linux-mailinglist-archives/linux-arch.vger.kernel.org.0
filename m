Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B3A647C0E
	for <lists+linux-arch@lfdr.de>; Fri,  9 Dec 2022 03:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiLICMM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 21:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiLICML (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 21:12:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466551F63B;
        Thu,  8 Dec 2022 18:12:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9FEA62119;
        Fri,  9 Dec 2022 02:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46481C4339C;
        Fri,  9 Dec 2022 02:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670551930;
        bh=rVgKlffiEF2OtdlS00jROW43FCHOBRtxFF76SiaLxlA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g9JvhGCrD0QapB7/ih8KC+9k5a69NF+gOr+Se463cyRY4QYyHoyPgaRv8aYKN0IMO
         z3aiHQzln/a3AheZHGQMewXtpYtA82iDMnMmrmNyrn3GIkfxPAW//jB+pK1/ywgCZR
         SHuFZywKDCWGMUxEItiKGzzpore1Ijf3Nsq2rC8dRXjA9F1BKaUAkzJ56lq9FrPuAe
         rBfwhNjBmAOWxUCL/G5qwimFUaS8OKJZK1092uYej+zzVEmGeQDjrgkDDsBhvbWuQy
         JDsJkohC2NOQX5nmwGxBkJp3ljlhZWOLbByYSPp4Eo8GWWlKPbFcJAeyrLQXguBro9
         zRSgmmV+KMl+A==
Received: by mail-ej1-f51.google.com with SMTP id n21so8292270ejb.9;
        Thu, 08 Dec 2022 18:12:10 -0800 (PST)
X-Gm-Message-State: ANoB5pklWSONcYwSOl3hc8XULtfxZytqEvOzJOOJmlaGycaxPrIE5n9L
        0eAkildMdjRF6xwMAsw0kFqQ76JPo1n9Y4agoDY=
X-Google-Smtp-Source: AA0mqf6qZESy7WGR2SxFc18ZJVgTfGA4tBgU5tArg1J1Ui4W5i5IwgHDF/9ZnULCqfySS6hAFP7XNiojuRKfKUdCQUc=
X-Received: by 2002:a17:906:b213:b0:7c0:f7af:7c5e with SMTP id
 p19-20020a170906b21300b007c0f7af7c5emr13505347ejz.406.1670551928446; Thu, 08
 Dec 2022 18:12:08 -0800 (PST)
MIME-Version: 1.0
References: <20221208025816.138712-1-guoren@kernel.org> <20221208025816.138712-11-guoren@kernel.org>
 <87mt7yw6eh.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87mt7yw6eh.fsf@all.your.base.are.belong.to.us>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 9 Dec 2022 10:11:56 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR+zbuJDQuW+=wEmQjF7xEsMokBW+yvTxXff38VYwSSKA@mail.gmail.com>
Message-ID: <CAJF2gTR+zbuJDQuW+=wEmQjF7xEsMokBW+yvTxXff38VYwSSKA@mail.gmail.com>
Subject: Re: [PATCH -next V10 10/10] riscv: stack: Add config of thread stack size
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

On Thu, Dec 8, 2022 at 6:12 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wro=
te:
>
> guoren@kernel.org writes:
>
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > 0cac21b02ba5 ("risc v: use 16KB kernel stack on 64-bit") increase the
>
> checkpatch complains here: Use "commit SHA...".
Okay, I would check that.

>
> > thread size mandatory, but some scenarios, such as D1 with a small
> > memory footprint, would suffer from that. After independent irq stack
> > support, let's give users a choice to determine their custom stack size=
.
>
> ...and again, my "why is this in the generic entry" series rant. :-)
I would remove it from the generic entry series.

>
>
> Bj=C3=B6rn



--=20
Best Regards
 Guo Ren
