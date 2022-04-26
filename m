Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0B8510587
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 19:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350813AbiDZRi5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 13:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241270AbiDZRiz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 13:38:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BAD9D063;
        Tue, 26 Apr 2022 10:35:47 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D31D1EC050D;
        Tue, 26 Apr 2022 19:35:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650994542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=h+bc84mRmYRlYNbxmWNU0GwQyvZuKeQeEnipPuIp9GY=;
        b=bUC3SbU1q4pkL2uYn0yuJJLWaQB1dPeKFe3YcCb2d+b+rGdZway0GApfdJsF+GFvWp4Bj1
        8pm/GYgfk3K2FF6ySF3bfX7GCq8d008K1RGQoWf9QXTN9xxEQTdoXNao334y+MzbGq84vQ
        ijLlvo+/qXx/BKqSIrdApscoK7UgrHI=
Date:   Tue, 26 Apr 2022 19:35:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>
Subject: Re: [PATCH 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
Message-ID: <Ymgtb2dSNYz7DBqx@zn.tnic>
References: <20220426134021.11210-1-jgross@suse.com>
 <20220426134021.11210-3-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220426134021.11210-3-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 26, 2022 at 03:40:21PM +0200, Juergen Gross wrote:
>  /* protected virtualization */
>  static void pv_init(void)
>  {
>  	if (!is_prot_virt_guest())
>  		return;
>  
> +	platform_set_feature(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);

Kinda long-ish for my taste. I'll probably call it:

	platform_set()

as it is implicit that it sets a feature bit.

> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index b43bc24d2bb6..6043ba6cd17d 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -40,6 +40,7 @@
>  #include <linux/mm.h>
>  #include <linux/mem_encrypt.h>
>  #include <linux/cc_platform.h>
> +#include <linux/platform-feature.h>
>  
>  #include <asm/setup.h>
>  #include <asm/sections.h>
> @@ -566,6 +567,10 @@ void __init sme_enable(struct boot_params *bp)
>  	} else {
>  		/* SEV state cannot be controlled by a command line option */
>  		sme_me_mask = me_mask;
> +
> +		/* Set restricted memory access for virtio. */
> +		platform_set_feature(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);

Huh, what does that have to do with SME?

In any case, yeah, looks ok at a quick glance. It would obviously need
for more people to look at it and say whether it makes sense to them and
whether that's fine to have in generic code but so far, the experience
with cc_platform_* says that it seems to work ok in generic code.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
