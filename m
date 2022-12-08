Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FAD646C75
	for <lists+linux-arch@lfdr.de>; Thu,  8 Dec 2022 11:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiLHKMK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 05:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiLHKMG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 05:12:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213D52BB03;
        Thu,  8 Dec 2022 02:12:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3F1C61E68;
        Thu,  8 Dec 2022 10:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F28AC433C1;
        Thu,  8 Dec 2022 10:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670494325;
        bh=B10KeXGupOTZ9O/Osm7gIGMgA+zr2X0fyDsuPqU+p6Q=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jzC1x3m4jHd7F84vjyOy+NamYp39Gn3nrEFu2TeBOmBYx2dWmBUT1/pmwZxppbY1F
         k3mARGSpHXQf3jbRw2R32f6GWvOMKiBHTpUNZhE6wou3scBRoN9MRpMKQd1yjdDCSU
         Fch/E5PWHTfsLN2LDrvy6qOC42Wopi9m5ANt2emInNAd+fH1x7kQPjR5FwnB7gLUEI
         BXjnvpidbxJfcBeMGDl7DS9Hm4gzX215uUgcPLi9SRzCp0pZ9BuNvh0g1g37P9PQsZ
         xfAobjVzjKpZphURLyxzkO1avVJ5YY2Kw+lai6cyw4n2VPf91fBEhaNpv4wkR1W/lC
         +gleUuoO7qoog==
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
Subject: Re: [PATCH -next V10 06/10] riscv: entry: Consolidate
 ret_from_kernel_thread into ret_from_fork
In-Reply-To: <20221208025816.138712-7-guoren@kernel.org>
References: <20221208025816.138712-1-guoren@kernel.org>
 <20221208025816.138712-7-guoren@kernel.org>
Date:   Thu, 08 Dec 2022 11:12:02 +0100
Message-ID: <87r0xaw6fh.fsf@all.your.base.are.belong.to.us>
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
> The ret_from_kernel_thread() behaves similarly with ret_from_fork(),
> the only difference is whether call the fn(arg) or not, this can be
> achieved by testing fn is NULL or not, I.E s0 is 0 or not. Many
> architectures have done the same thing, it make entry.S more clean.

Nit: "it makes".


Bj=C3=B6rn
