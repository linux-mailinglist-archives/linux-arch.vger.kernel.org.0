Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A964646C73
	for <lists+linux-arch@lfdr.de>; Thu,  8 Dec 2022 11:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiLHKLi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 05:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiLHKLh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 05:11:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BAE6E57A;
        Thu,  8 Dec 2022 02:11:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 825FB61E31;
        Thu,  8 Dec 2022 10:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760AFC43470;
        Thu,  8 Dec 2022 10:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670494291;
        bh=/C3PeG6QmqsUjFX9pmrsV/3THNanZB7XaM6jQlH8kHo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QsXxz9VBE5j1K9N9Vr2NNjQkOdQZkzz6Wr51x2qzouxLo6stZf0I6rVS8qlsfjTO7
         bSwqVj0Mm5CZZN6XlhFMcKoffEtZhxtM2kw5JwoTBtdI4dAyc12fuO9wHybCwClmtL
         mbHZDhtHM3YlRwBloq8IPVLauW5ATda/rOqwqZSBDhJO/HPPttvBQSdEhCgISRMkmE
         pn+TQLtexdRaOX2GuQPeQZsQG3RawRSU/QDWh+koJ6dzLhUCfG2q6mi2XX9+u3Waub
         mfNhcKPLlOp+n9MFXIC4uVU4RpLuZvbAd5NUfGyl6oGur9d0PYaJYNkrzPLQ3ATqls
         0E4+7wg86K+iQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     guoren@kernel.org, arnd@arndb.de, guoren@kernel.org,
        palmer@rivosinc.com, tglx@linutronix.de, peterz@infradead.org,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com, ben@decadent.org.uk
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH -next V10 05/10] riscv: entry: Remove extra level
 wrappers of trace_hardirqs_{on,off}
In-Reply-To: <20221208025816.138712-6-guoren@kernel.org>
References: <20221208025816.138712-1-guoren@kernel.org>
 <20221208025816.138712-6-guoren@kernel.org>
Date:   Thu, 08 Dec 2022 11:11:29 +0100
Message-ID: <87sfhqw6ge.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

guoren@kernel.org writes:

> From: Jisheng Zhang <jszhang@kernel.org>
>
> Since riscv is converted to generic entry, there's no need for the
> extra wrappers of trace_hardirqs_{on,off}.
>
> Tested with llvm + irqsoff.

What does this mean?


Bj=C3=B6rn
