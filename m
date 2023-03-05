Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262856AAEB9
	for <lists+linux-arch@lfdr.de>; Sun,  5 Mar 2023 10:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCEJXQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Mar 2023 04:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCEJXQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 04:23:16 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27A6F76C;
        Sun,  5 Mar 2023 01:23:13 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PTx8C0bydz4whh;
        Sun,  5 Mar 2023 20:23:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1678008188;
        bh=S5kZ8U1DxT09+WsN0usbweAzpxoqM+gTUtw71NO2hZY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PMrnpTMqfTNGy77Ve6cpOJPLTpaG1BSaXb77FTMa2BJ7XfCX3GSTu7WOIep1pbFWu
         DzFuO74vj7b8pC8U/g772fxSec0GaN4NmEJANjSqxvvz74mD0I6Oq68qv6GQvTT0mn
         NlRVdwUxd7vXNEUHzehDiM5/6Oi2HsiQz3s28QNQLyi0Rk/aZ2X7VIciMCyDUOFCmR
         naembNI4QBOdZoRFPwCEuYfe8G1CFWpXyAIC7yMlhwqQ2SAN7MysEvFN8k56wuhQFc
         LK6vvmPRnikQ/9vpIL+CL3NaW3y7w/tmqBbdzHqcfS6UqC1CqbZD+P83AOqT1MhLSn
         0h03Q/guV/yjA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        geert@linux-m68k.org, mcgrof@kernel.org, hch@infradead.org,
        Baoquan He <bhe@redhat.com>, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arch/*/io.h: remove ioremap_uc in some
 architectures
In-Reply-To: <20230303102817.212148-3-bhe@redhat.com>
References: <20230303102817.212148-1-bhe@redhat.com>
 <20230303102817.212148-3-bhe@redhat.com>
Date:   Sun, 05 Mar 2023 20:23:05 +1100
Message-ID: <87sfej1rie.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Baoquan He <bhe@redhat.com> writes:
> ioremap_uc() is only meaningful on old x86-32 systems with the PAT
> extension, and on ia64 with its slightly unconventional ioremap()
> behavior, everywhere else this is the same as ioremap() anyway.
>
> Here, remove the ioremap_uc() definition in architecutures other
> than x86 and ia64. These architectures all have asm-generic/io.h
> included and will have the default ioremap_uc() definition which
> returns NULL.
>
> Note: This changes the existing behaviour and could break code
> calling ioremap_uc(). If any ARCH meets this breakage and really
> needs a specific ioremap_uc() for its own usage, one ioremap_uc()
> can be added in the ARCH.

I see one use in:

drivers/video/fbdev/aty/atyfb_base.c:        par->ati_regbase = ioremap_uc(info->fix.mmio_start, 0x1000);


Which isn't obviously x86/ia64 specific.

I'm pretty sure some powermacs (powerpc) use that driver.

Maybe that exact code path is only reachable on x86/ia64? But if so
please explain why.

Otherwise it looks like this series could break that driver on powerpc
at least.

cheers
