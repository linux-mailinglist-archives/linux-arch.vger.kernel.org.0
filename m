Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE6248D38F
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jan 2022 09:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiAMI1j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jan 2022 03:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiAMI1j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Jan 2022 03:27:39 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CF5C06173F;
        Thu, 13 Jan 2022 00:27:38 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id q25so20274501edb.2;
        Thu, 13 Jan 2022 00:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N3Hcw5ErxsE3yjaJQlp2o1jkouM3pBLq4Tde9cqE82c=;
        b=HD811Jy8e47q5zldkoLH4/uqi07O12f8Dle21UZNGCrTyRDR5V6nx3we8CkSLcFy4q
         N4onqkubLmrK8LWvx3ojJE1tmgPuimJ5oB+pBo3n98oTnlMtoPHTo2kHn3knhJqwlvbT
         Hcd3Rz/RWjk701pn7EodLYNSBQCMWWwgOxRqJp2SlF6+YJi+py7xRamNXvDNx72eOumV
         HsPSUND9JCucbTHzj6a6EbXP12URvd72/v+PgvRyTc0VNWFh3dSPASUv0MQ3xxUYmEAA
         dWXLN194FrMxLjwE/zeWNo/KobICTw39wiRMJ0OYqEh6g3fvkfoKbDZ2u+LzhBvI8bOw
         wZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=N3Hcw5ErxsE3yjaJQlp2o1jkouM3pBLq4Tde9cqE82c=;
        b=pNc7/34bhgI778DY/HGFxqNRUq/PMV0Nmx8InyA7dZqdZWyoVvaWtBnR+TPraGO4Eg
         zOCo1p3z/4YBoHIan9nxD30r2+GS8zgUlNn3hcxuFo7usNA/vbeBphrqD/GMwEwhzhxX
         Dk7HFb+yn2ha8n6kpENuwd+T6MPYnxSMKjdjTRAFYywiXhui1o0hx5SD4vMThp+n4F4e
         WrEB//wH+S0F396PFvsfPrVNpvPprugkl52Z0KklMYcbT/I1uwtbO+7MfXmdjqY2Pdkg
         U2bESDDtsdaI+u77KtOACgvS/ne3TaanKah+hMVMyZNx1Hy78qzIcsc2CsNS8QC0dJut
         EqEA==
X-Gm-Message-State: AOAM530CUirRVzKRYjOHyKwbVkbwX9iwW4YymzXs0mXYdrFkwG4Cwvot
        jidDKDUnOuEaS99F6Oat+6Q=
X-Google-Smtp-Source: ABdhPJyUI9gwDRgkE5l0XPSr94K/rk3C6lEd7ViOnIBOV68YyS8QYnYschEdZ6/YaERJkl95HBFv3w==
X-Received: by 2002:a17:907:7750:: with SMTP id kx16mr2578615ejc.643.1642062457570;
        Thu, 13 Jan 2022 00:27:37 -0800 (PST)
Received: from gmail.com ([86.59.171.130])
        by smtp.gmail.com with ESMTPSA id q12sm620021ejc.139.2022.01.13.00.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 00:27:37 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 13 Jan 2022 09:27:33 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [ANNOUNCE] "Fast Kernel Headers" Tree -v2
Message-ID: <Yd/idffvv8QIQcEU@gmail.com>
References: <Ydm7ReZWQPrbIugn@gmail.com>
 <CAK8P3a1emGYHPcjTfLqd-yyU8_9w88=2g_B_vfhbKeDtDHMM-w@mail.gmail.com>
 <CAK8P3a3SpYe101RSFD5rzbTQNyQyfG1eb1sCY+rBO-DKVqBdBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3SpYe101RSFD5rzbTQNyQyfG1eb1sCY+rBO-DKVqBdBw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Arnd Bergmann <arnd@arndb.de> wrote:

> On Mon, Jan 10, 2022 at 11:03 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sat, Jan 8, 2022 at 5:26 PM Ingo Molnar <mingo@kernel.org> wrote:
> > I've started building randconfig kernels for arm64 and x86, and fixing
> > up things that come up, a few things I have noticed out so far:
> 
> I have run into a couple more specific issues:
> 
> * net/smc/smc_ib.c:824:26: error: implicit declaration of function
> 'cache_line_size' [-Werror=implicit-function-declaration]
> cache_line_size is generally provided by linux/cache.h, which includes
> asm/cache.h.
> This works on arm64, but not on x86, where asm/cache.h would have to include
> asm/cpufeature.h, and but it would be good to avoid that because of the implicit
> linux/percpu.h and linux/bitops.h inclusions. Also, if I add the
> include, I get this
> build failure instead: include/linux/smp_types.h:88:33: error:
> requested alignment '20'
> is not a positive power of 2

Note that this particular one should be fixed in the WIP branch, which is 
at:

   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers

> * arm64 has a couple of issues around asm/memory.h, linux/mm_types.h and 
> asm/page.h that can cause loops. I think my latest version has it figured 
> out, but there is probably room for optimization.

Yeah, this is like the 5th attempt at finding a robust solution. :-/

> * There is no general way to get the get_order() definition, other than 
> including asm/page.h from .c files. On arm64, this shows up in a couple 
> of files after the cleanup. Only xtensa and ia64 define their own version 
> of get_order(), and I think we should just remove those and move the 
> generic version to linux/getorder.h, where any file using it can pick it 
> up. For randconfig builds, I had to add asm/page.h to 
> net/xdp/xsk_queue.c, mm/memtest.c and 
> drivers/target/iscsi/iscsi_target_nego.c, after I removed the indirect 
> include from arch/arm64/include/asm/mmu.h in the previous step.

Would including <linux/mm_page_address.h> be sufficient? That already has 
an <asm/page.h> inclusion and is vaguely related.

I tried to avoid as many low level headers as possible from the main types 
headers - and the get_order() functionality also brings in bitops 
definitions, which I'm still hoping to be able to reduce from its current 
~95% utilization in a distro kernel ...

We could add <linux/page_api.h> as well, as a standardized header. We 
already have page_types.h and et_order() is a page types API.

Thanks,

	Ingo
