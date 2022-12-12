Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21F364996E
	for <lists+linux-arch@lfdr.de>; Mon, 12 Dec 2022 08:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiLLHSS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Dec 2022 02:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiLLHSR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Dec 2022 02:18:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A6E959D;
        Sun, 11 Dec 2022 23:18:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9873B80B84;
        Mon, 12 Dec 2022 07:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930DCC433EF;
        Mon, 12 Dec 2022 07:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670829493;
        bh=HhgAx6952Z9nYKnYTtBIl7A9R8rM/sJD3+XUZwGcCTs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nTAnbi0XG4ppR6DuVf8l2jlqBAC+S227UY7PaYU534ldzCQNpzF4RJ8YAnx3LvrZq
         7xOy+3tSXwRq5bGme/5eV8zaIWpnyZfrKSdMS9XavWQPLWdX7j40VeuHBL2GKUk9X/
         Xld2DFuG/vaPx7r8/yyIqNxpJsLp9phM9SxQ1XTMnN1/KcsN62wz5JBWFndygSZuxM
         CGjBHAblahY2GLl9XQVD56ldB9nGrcTzahOIvAhMveyR2oRg9zTW8v4rubrkZAiHKB
         EycTX9jxCO9EVLjrP8aSm0MuR1ylpNPSiAkKaiKKgT6tC/MNXL/PuPYPSHDemIbE+g
         iFRhSf9g1tqWg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     guoren@kernel.org, arnd@arndb.de, guoren@kernel.org,
        palmer@rivosinc.com, tglx@linutronix.de, peterz@infradead.org,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, paul.walmsley@sifive.com,
        mark.rutland@arm.com, greentime.hu@sifive.com,
        andy.chiu@sifive.com, ben@decadent.org.uk
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH -next V11 0/7] riscv: Add GENERIC_ENTRY support
In-Reply-To: <20221210171141.1120123-1-guoren@kernel.org>
References: <20221210171141.1120123-1-guoren@kernel.org>
Date:   Mon, 12 Dec 2022 08:18:08 +0100
Message-ID: <87o7s9ay4v.fsf@all.your.base.are.belong.to.us>
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

> From: Guo Ren <guoren@linux.alibaba.com>
>
> The patches convert riscv to use the generic entry infrastructure from
> kernel/entry/*. Some optimization for entry.S with new .macro and merge
> ret_from_kernel_thread into ret_from_fork.
>
> The 1,2 are the preparation of generic entry. 3~7 are the main part
> of generic entry.
>
> All tested with rv64, rv32, rv64 + 32rootfs, all are passed.
>
> You can directly try it with:
> [1] https://github.com/guoren83/linux/tree/generic_entry_v11

FWIW, the v11 branch is not available here.

This series is a really nice cleanup for the RISC-V entry code. I've run
it on some kernel selftests, and haven't seen any issues.

I'm looking forward to having this series pulled in!

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
