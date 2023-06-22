Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E977273A821
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 20:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjFVSV2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 14:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFVSV1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 14:21:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7601E2105;
        Thu, 22 Jun 2023 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t02GqixU93hABDtM3rcPTM2ZhN4nb0XzBqI30VoyYtE=; b=JkDrdCiYPmkRNJ5i6MKcglC3hd
        NNkrYcDa/j7MYLLBgA00ey9vHiYeBuzgjsqsikSND7EtUysmHbzGMxKW0AP+vk5H3dVHHqBiPIweh
        gG2XM09tag/4gG9lm6S6WKfYBzWVKUyZt/0vBnCFVNR1F1vtv4X47yTkGAYwS/GvQmPjPaCVg5bKB
        IO7lNl1cJezXl2O0/b4/TM5Vy3oc/85fzjOG3U4XQLNicGnZsWshEqYIHbXFJ7iNj5G4E9LVEQsKi
        o0Cj/wcmvdiOOJIBDh7OrM2p52ajZQP5/2+eZPYS5Xl62VvDjLXmLPfcwtk0+94x48hYBrJqteI14
        4sqgR3VA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qCOvX-00ForJ-LK; Thu, 22 Jun 2023 18:21:03 +0000
Date:   Thu, 22 Jun 2023 19:21:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
        torvalds@linux-foundation.org, broonie@kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v9 16/42] mm: Add guard pages around a shadow stack.
Message-ID: <ZJSRD1xZauOW3jFO@casper.infradead.org>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-17-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613001108.3040476-17-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 12, 2023 at 05:10:42PM -0700, Rick Edgecombe wrote:
> +++ b/include/linux/mm.h
> @@ -342,7 +342,36 @@ extern unsigned int kobjsize(const void *objp);
>  #endif /* CONFIG_ARCH_HAS_PKEYS */
>  
>  #ifdef CONFIG_X86_USER_SHADOW_STACK
> -# define VM_SHADOW_STACK	VM_HIGH_ARCH_5 /* Should not be set with VM_SHARED */
> +/*
> + * This flag should not be set with VM_SHARED because of lack of support
> + * core mm. It will also get a guard page. This helps userspace protect
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
> + *
> + * Prevent using INCSSP to move the SSP between shadow stacks by
> + * having a PAGE_SIZE guard gap.
> + */
> +# define VM_SHADOW_STACK	VM_HIGH_ARCH_5
>  #else
>  # define VM_SHADOW_STACK	VM_NONE
>  #endif

This is a lot of very x86-specific language in a generic header file.
I'm sure there's a better place for all this text.
