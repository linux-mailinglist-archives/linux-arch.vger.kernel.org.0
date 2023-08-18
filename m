Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3017805E4
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 08:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357958AbjHRGjT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Aug 2023 02:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbjHRGiv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2023 02:38:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A892C3AAC;
        Thu, 17 Aug 2023 23:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1692340724;
        bh=hlt2WR9VKRQdnR39jECZXVVWv2cQfPKmwJiDfWtBxo4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Y0iReFoYSlL0+BxRV/n3nIxMdr6AyjmsO0dXwn9j+x+KduX7OhC0wklzd198xTaee
         9XcmQrl8GmmaMLE9O6icF7RHt6SPWQGb8Alc9TWqL1TXJ9u7InrnjGNGIsGQntC4Ew
         DUbEKBPT8AhYv5vfCcDGZaWz6sznFTeVHvju8DMx4amt8ewj1PY9jfDaqMYXPeO3CZ
         3f9CJKC/oH2D5/c7THyB6sR31THVNRSMvVKePdhVMhqU6jpQ32j9WShQOrvLYjKZde
         ym6SvEJqJ/fj1aBuf2tNjZtZ8kmblI8YJQqXJu5uNfXDIZcvJQhE2wqAaktwzCRup8
         SokeUBqcMPITA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RRsdp689Wz4wy8;
        Fri, 18 Aug 2023 16:38:38 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Russell King <linux@armlinux.org.uk>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/9] powerpc: Remove <asm/ide.h>
In-Reply-To: <eb79960c5f9f72013b3b2f6d19461e5d8134fcc2.1692288018.git.geert@linux-m68k.org>
References: <cover.1692288018.git.geert@linux-m68k.org>
 <eb79960c5f9f72013b3b2f6d19461e5d8134fcc2.1692288018.git.geert@linux-m68k.org>
Date:   Fri, 18 Aug 2023 16:38:36 +1000
Message-ID: <87bkf4x3bn.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:
> As of commit b7fb14d3ac63117e ("ide: remove the legacy ide driver") in
> v5.14, there are no more generic users of <asm/ide.h>.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  arch/powerpc/include/asm/ide.h | 18 ------------------
>  1 file changed, 18 deletions(-)
>  delete mode 100644 arch/powerpc/include/asm/ide.h

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
