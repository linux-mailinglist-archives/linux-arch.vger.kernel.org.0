Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF6C6DEBAD
	for <lists+linux-arch@lfdr.de>; Wed, 12 Apr 2023 08:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjDLGSQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Apr 2023 02:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjDLGSO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2023 02:18:14 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99AA527A;
        Tue, 11 Apr 2023 23:18:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PxCF401xjz4xFj;
        Wed, 12 Apr 2023 16:17:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1681280282;
        bh=mVus6VBYhH8GmWv60JhlJfNhVtxbImSRmEm6BDRrW3s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lTZEAUAJ2QZsc9UPHGoexeIDhivQg0OZP2tQ8N178oguDiIOjU/GS5yjDEkHA0ZQY
         UoSdL/mLxTXV/wa3HPEVjblwcxsdx2c+OnuyDK5Tv1Pbg7hiKGkpXXQYiHyY9ZXKUK
         6CSwY02DKtu+cGQJMahEUbmjJakfBQLvnLNWdj1LScutIwzO/9mPiHZFRCutiHgFFy
         LDNwBaVtxl/OmcZoIc9q0YGGvsTAR4vPp6o9KxvHWYHacDs55AZq5ZD42D7HmgmLSM
         12TeMwxecBFtXBTtmtuIhlm5OkckoQGJYZdQPchk2E7CbMKkKzVuJ/odBCPWTELN7l
         5ijFDMn/S4fVA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de,
        daniel.vetter@ffwll.ch, deller@gmx.de, javierm@redhat.com,
        gregkh@linuxfoundation.org
Cc:     linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 15/19] arch/powerpc: Implement <asm/fb.h> with
 generic helpers
In-Reply-To: <20230406143019.6709-16-tzimmermann@suse.de>
References: <20230406143019.6709-1-tzimmermann@suse.de>
 <20230406143019.6709-16-tzimmermann@suse.de>
Date:   Wed, 12 Apr 2023 16:17:59 +1000
Message-ID: <87r0spipyg.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:
> Replace the architecture's fb_is_primary_device() with the generic
> one from <asm-generic/fb.h>. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/fb.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Looks fine.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/include/asm/fb.h b/arch/powerpc/include/asm/fb.h
> index 6541ab77c5b9..5f1a2e5f7654 100644
> --- a/arch/powerpc/include/asm/fb.h
> +++ b/arch/powerpc/include/asm/fb.h
> @@ -2,8 +2,8 @@
>  #ifndef _ASM_FB_H_
>  #define _ASM_FB_H_
>  
> -#include <linux/fb.h>
>  #include <linux/fs.h>
> +
>  #include <asm/page.h>
>  
>  static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
> @@ -13,10 +13,8 @@ static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
>  						 vma->vm_end - vma->vm_start,
>  						 vma->vm_page_prot);
>  }
> +#define fb_pgprotect fb_pgprotect
>  
> -static inline int fb_is_primary_device(struct fb_info *info)
> -{
> -	return 0;
> -}
> +#include <asm-generic/fb.h>
>  
>  #endif /* _ASM_FB_H_ */
> -- 
> 2.40.0
