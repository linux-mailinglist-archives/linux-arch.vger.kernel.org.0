Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049E0606318
	for <lists+linux-arch@lfdr.de>; Thu, 20 Oct 2022 16:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJTOcM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Oct 2022 10:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJTOcL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Oct 2022 10:32:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788BC14DF37;
        Thu, 20 Oct 2022 07:32:10 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e710329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e710:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C9F981EC0567;
        Thu, 20 Oct 2022 16:32:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666276324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kmZIn+RmPcFrrruewpP3q+eT9dV6viqfrtURROqoXV4=;
        b=c6vOv2k+nIu92WEk/Ed8XAbzSVCEMl31tZInGnnk957mMSXKeCaMDExHzoli7C5KMKrV+y
        ebd6to516TQ9ccj8KfLC/+jvqvIyQ5e4J8Eq1yn+ILqsJ9ZqOxLp7oQJGB4g6ntNCxyIAG
        fqIm3xd8Gkn4era5P1ZQDbYZLc4jtZE=
Date:   Thu, 20 Oct 2022 16:32:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, heiko@sntech.de,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] arch: crash: Remove duplicate declaration in smp.h
Message-ID: <Y1Fb4HGzJEKCD1SF@zn.tnic>
References: <20221020135913.2850550-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221020135913.2850550-1-guoren@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 20, 2022 at 09:59:13AM -0400, guoren@kernel.org wrote:
> diff --git a/arch/x86/include/asm/crash.h b/arch/x86/include/asm/crash.h
> index 8b6bd63530dc..6a9be4907c82 100644
> --- a/arch/x86/include/asm/crash.h
> +++ b/arch/x86/include/asm/crash.h
> @@ -7,6 +7,5 @@ struct kimage;
>  int crash_load_segments(struct kimage *image);
>  int crash_setup_memmap_entries(struct kimage *image,
>  		struct boot_params *params);
> -void crash_smp_send_stop(void);
>  
>  #endif /* _ASM_X86_CRASH_H */

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
