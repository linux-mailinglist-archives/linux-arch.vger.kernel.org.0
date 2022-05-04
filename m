Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B176B519EB0
	for <lists+linux-arch@lfdr.de>; Wed,  4 May 2022 13:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbiEDMBc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 08:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiEDMBb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 08:01:31 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD46183AF;
        Wed,  4 May 2022 04:57:54 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nmDdM-0001N1-BL; Wed, 04 May 2022 13:57:32 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org
Cc:     guoren@kernel.org, peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, longman@redhat.com,
        boqun.feng@gmail.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, macro@orcam.me.uk, jszhang@kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v4 1/7] asm-generic: ticket-lock: New generic ticket-based spinlock
Date:   Wed, 04 May 2022 13:57:31 +0200
Message-ID: <2180881.iZASKD2KPV@diego>
In-Reply-To: <20220430153626.30660-2-palmer@rivosinc.com>
References: <20220430153626.30660-1-palmer@rivosinc.com> <20220430153626.30660-2-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Am Samstag, 30. April 2022, 17:36:20 CEST schrieb Palmer Dabbelt:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> This is a simple, fair spinlock.  Specifically it doesn't have all the
> subtle memory model dependencies that qspinlock has, which makes it more
> suitable for simple systems as it is more likely to be correct.  It is
> implemented entirely in terms of standard atomics and thus works fine
> without any arch-specific code.
> 
> This replaces the existing asm-generic/spinlock.h, which just errored
> out on SMP systems.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

on riscv64+riscv32 qemu, beaglev and d1-nezha

Tested-by: Heiko Stuebner <heiko@sntech.de>


