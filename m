Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8ED6C4E90
	for <lists+linux-arch@lfdr.de>; Wed, 22 Mar 2023 15:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjCVOxa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Mar 2023 10:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjCVOxR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Mar 2023 10:53:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1276A6B5C8;
        Wed, 22 Mar 2023 07:51:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 05565CE1DC9;
        Wed, 22 Mar 2023 14:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8027C4339B;
        Wed, 22 Mar 2023 14:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496383;
        bh=mcvsw1hiR3Qyp1OeN9vHnJd3gGmdmQuM7Wjd77b+bFE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ELQQHZhIzJhFR/Tk978Cc4oL5KccT10G3P7OufM8u/DwJJrgnZYhnwjbsbICQlAMV
         H+J2nxPCk7sKDxEk34dFgAr484iXX4ipdk//qSUVurVNswYNy4ZSHw5nYc790DuL3M
         PnNS/ccgSsaYCQELdpk4B0pPGzXNVCo1CFLdg1MfyiNyibq7XYuZHOI0bzhHhix8lj
         U6J4yngMnQ+jtjD45ynxoDUuwZ57lvqd/kXS1x484UXRQ4eNCmEdQzZJDa/oy2x3Ia
         VYXpIz0i0RFlhNGItPYC8Dn2i2KTVu5XRZTviQ2+ZYGkJJUGLZ+Fac/BU6OCPSePxT
         XixNdk9EVFQPg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     guoren@kernel.org, arnd@arndb.de, guoren@kernel.org,
        palmer@rivosinc.com, tglx@linutronix.de, peterz@infradead.org,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, ben@decadent.org.uk,
        palmer@dabbelt.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        =?utf-8?B?QmrDtnJu?= =?utf-8?B?IFTDtnBlbA==?= 
        <bjorn@rivosinc.com>
Subject: Re: [PATCH -next V17 1/7] compiler_types.h: Add __noinstr_section()
 for noinstr
In-Reply-To: <20230222033021.983168-2-guoren@kernel.org>
References: <20230222033021.983168-1-guoren@kernel.org>
 <20230222033021.983168-2-guoren@kernel.org>
Date:   Wed, 22 Mar 2023 15:46:20 +0100
Message-ID: <87ilesu9mr.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

guoren@kernel.org writes:

> From: Lai Jiangshan <laijs@linux.alibaba.com>
>
> Using __noinstr_section() doesn't automatically disable all
> instrumentations on the section. Inhibition for some
> instrumentations requires extra code. I.E. KPROBES explicitly
> avoids instrumenting on .noinstr.text.

Guo, the generic entry series doesn't apply cleanly on
riscv/for-next >6.2-rc1, and this patch is the issue.

Could you do a respin (potentially w/o this patch)?


Cheers,
Bj=C3=B6rn
