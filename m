Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123AB642607
	for <lists+linux-arch@lfdr.de>; Mon,  5 Dec 2022 10:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiLEJrC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Dec 2022 04:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiLEJrA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2022 04:47:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC14F19030;
        Mon,  5 Dec 2022 01:46:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 895BB60FF0;
        Mon,  5 Dec 2022 09:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F628C433C1;
        Mon,  5 Dec 2022 09:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670233618;
        bh=ATIjD4eir5XBkS5wpUUkHOY7bfI0wqvtDyCyhmJDvJU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fMmdYErt1K0gAmnAgiPHlIRvDzToBywyrW/wS50HU9jcAzg3IMoocz1TabriHd4v1
         GF5OMO9+IHu9/hBRTQ96a1by65RAMZVKmcVQnDYU31EFRrH6JDPF0l2J9J7R8OTsWI
         bn3S4S4AU2u9n4YSfSl6boVpF5g/TdD+bE9EH4LCS0S3CmxHcGvTlgCUrdIqtBYwRJ
         J9YIx7yAdyYtU0AUrhbvtSRpr7lOIyiM0n354wkfUqljeWST5OVMtkVFLHOk+Gb4Ah
         0DI5pIZGWRSHbtwipF8qVvGPF+gda6Cf+PL0iSgpMAoFtT10YwuQZiYlbtW0MFQ2RH
         ONcsIfI9zBqyQ==
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
        greentime.hu@sifive.com, andy.chiu@sifive.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH -next V8 00/14] riscv: Add GENERIC_ENTRY support and
 related features
In-Reply-To: <20221103075047.1634923-1-guoren@kernel.org>
References: <20221103075047.1634923-1-guoren@kernel.org>
Date:   Mon, 05 Dec 2022 10:46:56 +0100
Message-ID: <877cz69o8f.fsf@all.your.base.are.belong.to.us>
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
> kernel/entry/*. Additionally, add independent irq stacks (IRQ_STACKS)
> for percpu to prevent kernel stack overflows. Add generic_entry based
> STACKLEAK support. Some optimization for entry.S with new .macro and
> merge ret_from_kernel_thread into ret_from_fork.
>
> We have tested it with rv64, rv32, rv64 + 32rootfs, all are passed.
>
> You can directly try it with:
> [1] https://github.com/guoren83/linux/tree/generic_entry_v8

Guo, this is a really nice work, and I'm looking forward having generic
entry support for RV. However, there are many patches in this series
that really shouldn't be part of the series.

Patch 2, 3, 4, and 10 should defintely be pulled out.

I'm not sure 7, 8, and 9 belong to series, as it's really a separate
feature.

Dito for patch 11, it just makes the series harder to review.

For GENERIC_ENTRY support only patch 1, 5, 6, 12, 13, and 14, really
required. The others are unrelated.


Thanks,
Bj=C3=B6rn
