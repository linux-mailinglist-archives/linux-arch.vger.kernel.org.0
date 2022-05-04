Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D212A519ED1
	for <lists+linux-arch@lfdr.de>; Wed,  4 May 2022 14:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348749AbiEDMGe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 08:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiEDMGb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 08:06:31 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D63A201B5;
        Wed,  4 May 2022 05:02:54 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nmDiP-0001Qi-Em; Wed, 04 May 2022 14:02:45 +0200
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
Subject: Re: [PATCH v4 5/7] RISC-V: Move to generic spinlocks
Date:   Wed, 04 May 2022 14:02:44 +0200
Message-ID: <3428595.iIbC2pHGDl@diego>
In-Reply-To: <20220430153626.30660-6-palmer@rivosinc.com>
References: <20220430153626.30660-1-palmer@rivosinc.com> <20220430153626.30660-6-palmer@rivosinc.com>
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

Am Samstag, 30. April 2022, 17:36:24 CEST schrieb Palmer Dabbelt:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> Our existing spinlocks aren't fair and replacing them has been on the
> TODO list for a long time.  This moves to the recently-introduced ticket
> spinlocks, which are simple enough that they are likely to be correct
> and fast on the vast majority of extant implementations.
> 
> This introduces a horrible hack that allows us to split out the spinlock
> conversion from the rwlock conversion.  We have to do the spinlocks
> first because qrwlock needs fair spinlocks, but we don't want to pollute
> the asm-generic code to support the generic spinlocks without qrwlocks.
> Thus we pollute the RISC-V code, but just until the next commit as it's
> all going away.
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

on riscv64+riscv32 qemu, beaglev and d1-nezha

Tested-by: Heiko Stuebner <heiko@sntech.de>


