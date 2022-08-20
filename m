Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535F659AD06
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 11:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbiHTJlU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Aug 2022 05:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiHTJlU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Aug 2022 05:41:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908A6B99E8;
        Sat, 20 Aug 2022 02:41:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1835161127;
        Sat, 20 Aug 2022 09:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3295BC433D6;
        Sat, 20 Aug 2022 09:41:15 +0000 (UTC)
Date:   Sat, 20 Aug 2022 10:41:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     guoren@kernel.org
Cc:     xianting.tian@linux.alibaba.com, palmer@dabbelt.com,
        heiko@sntech.de, conor.dooley@microchip.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, liaochang1@huawei.com,
        mick@ics.forth.gr, jszhang@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        x86@kernel.org
Subject: Re: [PATCH V3 3/3] arch: crash: Remove duplicate declaration in smp.h
Message-ID: <YwCsNnfGwkTYShGs@arm.com>
References: <20220819025444.2121315-1-guoren@kernel.org>
 <20220819025444.2121315-4-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819025444.2121315-4-guoren@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 18, 2022 at 10:54:44PM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Remove crash_smp_send_stop declarations in arm64, x86 asm/smp.h which
> has been done in include/linux/smp.h.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: x86@kernel.org

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
