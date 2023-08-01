Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C251C76B9FD
	for <lists+linux-arch@lfdr.de>; Tue,  1 Aug 2023 18:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjHAQxT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Aug 2023 12:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjHAQxS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Aug 2023 12:53:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8667C2113;
        Tue,  1 Aug 2023 09:53:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2342461467;
        Tue,  1 Aug 2023 16:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C798C433C8;
        Tue,  1 Aug 2023 16:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690908796;
        bh=NHmRrolFzdbUCu0kGXaymHyZEubMVArK6rwqeVruN0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HwuBZpEXBkB3CE/V4KajSW3gnSYxF2tTjPViqE5A2oIIqLhUA+0e+IblDugFg9Z2u
         S0Ck8LhYAevrbvQxgA14aPLtbGABfSIR5vcwXDlVxuid5aG3oZuIZ24GF4qCEi3IIi
         nquYYS/spIOcUnYGkTZSIhj8c7X3XZblzixj+fUIuO+4mRpF6xrStoQCv057iq9NcN
         OkLBQr9pYhByRIZ12cquz0en1ISm3gUO4XVCwiWtG4Ia+W8uhfhrgR05V3posavWjw
         w1nbmtetuo2DR+rp1snmcsOZM8YJBF3KIXGQdzz738GzV9sSr7MiaVVvVM4/dTLin+
         4LEATCs36iNcA==
Date:   Tue, 1 Aug 2023 19:52:21 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     broonie@kernel.org, akpm@linux-foundation.org,
        andrew.cooper3@citrix.com, arnd@arndb.de, bp@alien8.de,
        bsingharora@gmail.com, christina.schimpe@intel.com, corbet@lwn.net,
        david@redhat.com, debug@rivosinc.com, dethoma@microsoft.com,
        eranian@google.com, esyr@redhat.com, fweimer@redhat.com,
        gorcunov@gmail.com, hjl.tools@gmail.com, hpa@zytor.com,
        jamorris@linux.microsoft.com, jannh@google.com, john.allen@amd.com,
        kcc@google.com, keescook@chromium.org,
        kirill.shutemov@linux.intel.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        mike.kravetz@oracle.com, mingo@redhat.com, nadav.amit@gmail.com,
        oleg@redhat.com, pavel@ucw.cz, pengfei.xu@intel.com,
        peterz@infradead.org, rdunlap@infradead.org, szabolcs.nagy@arm.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        weijiang.yang@intel.com, willy@infradead.org, x86@kernel.org,
        yu-cheng.yu@intel.com
Subject: Re: [PATCH] x86/shstk: Move arch detail comment out of core mm
Message-ID: <20230801165221.GA2607694@kernel.org>
References: <ad6df14b-1fbd-4136-abcd-314425c28306@sirena.org.uk>
 <20230706233248.445713-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706233248.445713-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Dave, Rick,

It seems it didn't get into the current tip.

On Thu, Jul 06, 2023 at 04:32:48PM -0700, Rick Edgecombe wrote:
> The comment around VM_SHADOW_STACK in mm.h refers to a lot of x86
> specific details that don't belong in a cross arch file. Remove these
> out of core mm, and just leave the non-arch details.
> 
> Since the comment includes some useful details that would be good to
> retain in the source somewhere, put the arch specifics parts in
> arch/x86/shstk.c near alloc_shstk(), where memory of this type is
> allocated. Include a reference to the existence of the x86 details near
> the VM_SHADOW_STACK definition mm.h.
> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/x86/kernel/shstk.c | 25 +++++++++++++++++++++++++
>  include/linux/mm.h      | 32 ++++++--------------------------
>  2 files changed, 31 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index b26810c7cd1c..47f5204b0fa9 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
> @@ -72,6 +72,31 @@ static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
>  	return 0;
>  }
>  
> +/*
> + * VM_SHADOW_STACK will have a guard page. This helps userspace protect
> + * itself from attacks. The reasoning is as follows:
> + *
> + * The shadow stack pointer(SSP) is moved by CALL, RET, and INCSSPQ. The
> + * INCSSP instruction can increment the shadow stack pointer. It is the
> + * shadow stack analog of an instruction like:
> + *
> + *   addq $0x80, %rsp
> + *
> + * However, there is one important difference between an ADD on %rsp
> + * and INCSSP. In addition to modifying SSP, INCSSP also reads from the
> + * memory of the first and last elements that were "popped". It can be
> + * thought of as acting like this:
> + *
> + * READ_ONCE(ssp);       // read+discard top element on stack
> + * ssp += nr_to_pop * 8; // move the shadow stack
> + * READ_ONCE(ssp-8);     // read+discard last popped stack element
> + *
> + * The maximum distance INCSSP can move the SSP is 2040 bytes, before
> + * it would read the memory. Therefore a single page gap will be enough
> + * to prevent any operation from shifting the SSP to an adjacent stack,
> + * since it would have to land in the gap at least once, causing a
> + * fault.
> + */
>  static unsigned long alloc_shstk(unsigned long addr, unsigned long size,
>  				 unsigned long token_offset, bool set_res_tok)
>  {
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 535c58d3b2e4..b647cf2e94ea 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -343,33 +343,13 @@ extern unsigned int kobjsize(const void *objp);
>  
>  #ifdef CONFIG_X86_USER_SHADOW_STACK
>  /*
> - * This flag should not be set with VM_SHARED because of lack of support
> - * core mm. It will also get a guard page. This helps userspace protect
> - * itself from attacks. The reasoning is as follows:
> + * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
> + * support core mm.
>   *
> - * The shadow stack pointer(SSP) is moved by CALL, RET, and INCSSPQ. The
> - * INCSSP instruction can increment the shadow stack pointer. It is the
> - * shadow stack analog of an instruction like:
> - *
> - *   addq $0x80, %rsp
> - *
> - * However, there is one important difference between an ADD on %rsp
> - * and INCSSP. In addition to modifying SSP, INCSSP also reads from the
> - * memory of the first and last elements that were "popped". It can be
> - * thought of as acting like this:
> - *
> - * READ_ONCE(ssp);       // read+discard top element on stack
> - * ssp += nr_to_pop * 8; // move the shadow stack
> - * READ_ONCE(ssp-8);     // read+discard last popped stack element
> - *
> - * The maximum distance INCSSP can move the SSP is 2040 bytes, before
> - * it would read the memory. Therefore a single page gap will be enough
> - * to prevent any operation from shifting the SSP to an adjacent stack,
> - * since it would have to land in the gap at least once, causing a
> - * fault.
> - *
> - * Prevent using INCSSP to move the SSP between shadow stacks by
> - * having a PAGE_SIZE guard gap.
> + * These VMAs will get a single end guard page. This helps userspace protect
> + * itself from attacks. A single page is enough for current shadow stack archs
> + * (x86). See the comments near alloc_shstk() in arch/x86/kernel/shstk.c
> + * for more details on the guard size.
>   */
>  # define VM_SHADOW_STACK	VM_HIGH_ARCH_5
>  #else
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.
