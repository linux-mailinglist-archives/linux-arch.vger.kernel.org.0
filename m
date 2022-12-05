Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3889D642582
	for <lists+linux-arch@lfdr.de>; Mon,  5 Dec 2022 10:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiLEJNY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Dec 2022 04:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiLEJNM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2022 04:13:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617B7B7B;
        Mon,  5 Dec 2022 01:12:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DF24B80D8B;
        Mon,  5 Dec 2022 09:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34990C433C1;
        Mon,  5 Dec 2022 09:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670231573;
        bh=/dqeLVcmlRPq/zRmA5RKSVgbtdODDXrUTMM6jDvLQ0M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nKWex4r9l4zCzHTI8CLnK+YtYeLCWTtiuZzvCjpFSRWopb0mGcZbLQO6ZWu3TB61r
         qC1zzuPShWT9jWeVYbXnMqmEbxWSlJz6ekK4zi/vKZrm/+/ODqD0t9CIQPu3ufo3Bh
         AQkfPgKJd1JWZIxicqiB9LpiVGoe8LGHf1xOtkXHt/lItZ9PSLBh66GDRkdx63UPXa
         DtEdBn1hhEDqfHAomNieBHYVX2eWACky/3Te5PQNwyWeovsLCWTnnfzG7Mk3CGszn1
         86il5CtxmCMF0J1dRWOvnh28tTQnqp/UvTYqgdFWvpYjPUhVuIA4Ko3oMEh6GbmMy9
         9iYe1qWm+OQwA==
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
        linux-riscv@lists.infradead.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH -next V8 01/14] compiler_types.h: Add
 __noinstr_section() for noinstr
In-Reply-To: <20221103075047.1634923-2-guoren@kernel.org>
References: <20221103075047.1634923-1-guoren@kernel.org>
 <20221103075047.1634923-2-guoren@kernel.org>
Date:   Mon, 05 Dec 2022 10:12:51 +0100
Message-ID: <87k0369pt8.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

guoren@kernel.org writes:

> From: Lai Jiangshan <laijs@linux.alibaba.com>
>
> And it will be extended for C entry code.

It would be nice with a more elaborative commit message.
