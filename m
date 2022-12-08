Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D65646C7D
	for <lists+linux-arch@lfdr.de>; Thu,  8 Dec 2022 11:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiLHKM7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 05:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLHKMv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 05:12:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E000111471;
        Thu,  8 Dec 2022 02:12:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C29EB822E4;
        Thu,  8 Dec 2022 10:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A527C433D6;
        Thu,  8 Dec 2022 10:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670494360;
        bh=+BDuaUMsMhaz0oaPEpxgB70uzBkS/ncSmhvf9tLxCTo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BnJ+HS0FkG1a966j7Zf5Q5oxTwnQe7sYJgm3VmPScoexQgnid0pk0craNWT7D3vbG
         cJ4kXR/2dAxTtJmxItm2OIlazI5ghZrrdbLTwPTHh6GwE1sE/vCssCZHNiu7xu/4jm
         BfkQOeRaOXH5K3FbBVqWwu14X97RKSDmH1oBEvl0I8fsL9eRUj4ChpIgvaHZPtFyca
         jk86uHY5w+y5toa5eeUHXVjeZt3Zk5tu8TIc06jGUSoCk6C414axKnlzkXfoHbsZug
         YEZRREFSrtN/McpAHsIDb3zAk/AX9SynJ0XVZtfJ5FJEZjpHVCprsDtDPaVH5konQe
         cxo2H0ERZCd8Q==
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
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH -next V10 10/10] riscv: stack: Add config of thread
 stack size
In-Reply-To: <20221208025816.138712-11-guoren@kernel.org>
References: <20221208025816.138712-1-guoren@kernel.org>
 <20221208025816.138712-11-guoren@kernel.org>
Date:   Thu, 08 Dec 2022 11:12:38 +0100
Message-ID: <87mt7yw6eh.fsf@all.your.base.are.belong.to.us>
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
> 0cac21b02ba5 ("risc v: use 16KB kernel stack on 64-bit") increase the

checkpatch complains here: Use "commit SHA...".

> thread size mandatory, but some scenarios, such as D1 with a small
> memory footprint, would suffer from that. After independent irq stack
> support, let's give users a choice to determine their custom stack size.

...and again, my "why is this in the generic entry" series rant. :-)


Bj=C3=B6rn
