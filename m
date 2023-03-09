Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554B16B317C
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 23:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjCIWzP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 17:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjCIWzK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 17:55:10 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520653CE03;
        Thu,  9 Mar 2023 14:54:40 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PXkyW6RNvz4x7s;
        Fri, 10 Mar 2023 09:54:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1678402469;
        bh=HnGqhsJTeGjqlPVUTmz3g9ouF0ULtGaBV4DNsEeVxsY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qtChMEayOa7BG3gV8biPN1UquvZjKKHH1PLnOktZLFk+z7+30lmoHFQWG/ybTGOfV
         Msn+vq0214G/5bCC5sK8YEWC4SONYn3IjVV2gLKa55Cy0vLJqZpwyIgKHr5xpyRlRO
         2B59x+JG32iD6Ll1IeACkY+jSFZ42uC6mHr940GQ8rZCqsWJ73oUfODgJNTU1QA4cH
         /Zt2BN0brA6nfVHnuvaamrjV+75syVJwmQZUAWs6jzdNGb6ONfyH1iskU2QALlqqJR
         fcr5fnsHZCG3RA30SBInWnaih8rWQ8VzjneqbRw1yHLKc3Q/ihjyNUCZJzzzjHFnUd
         puglrrgtkl1qg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        geert@linux-m68k.org, mcgrof@kernel.org, hch@infradead.org,
        Baoquan He <bhe@redhat.com>, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH v4 3/4] arch/*/io.h: remove ioremap_uc in some
 architectures
In-Reply-To: <20230308130710.368085-4-bhe@redhat.com>
References: <20230308130710.368085-1-bhe@redhat.com>
 <20230308130710.368085-4-bhe@redhat.com>
Date:   Fri, 10 Mar 2023 09:54:27 +1100
Message-ID: <874jqtpmcc.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Baoquan He <bhe@redhat.com> writes:
> ioremap_uc() is only meaningful on old x86-32 systems with the PAT
> extension, and on ia64 with its slightly unconventional ioremap()
> behavior. So remove the ioremap_uc() definition in architecutures
> other than x86 and ia64. These architectures all have asm-generic/io.h
> included and will have the default ioremap_uc() definition which
> returns NULL.
>
> This changes the existing behaviour, while no need to worry about
> any breakage because in the only callsite of ioremap_uc(), code
> has been adjusted to eliminate the impact. Please see
> atyfb_setup_generic() of drivers/video/fbdev/aty/atyfb_base.c.
>
> If any new invocation of ioremap_uc() need be added, please consider
> using ioremap() intead or adding a ARCH specific version if necessary.
>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> ---
>  Documentation/driver-api/device-io.rst | 9 +++++----
>  arch/alpha/include/asm/io.h            | 1 -
>  arch/hexagon/include/asm/io.h          | 3 ---
>  arch/m68k/include/asm/kmap.h           | 1 -
>  arch/mips/include/asm/io.h             | 1 -
>  arch/parisc/include/asm/io.h           | 2 --
>  arch/powerpc/include/asm/io.h          | 1 -

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
