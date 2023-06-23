Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8B973B1D1
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jun 2023 09:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjFWHlA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Jun 2023 03:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFWHk7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Jun 2023 03:40:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95281988;
        Fri, 23 Jun 2023 00:40:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5ADF1617E8;
        Fri, 23 Jun 2023 07:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A5AC433C9;
        Fri, 23 Jun 2023 07:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687506056;
        bh=GzKdhhzyZ+iRj8RsJgARuHLY4EfLvN1z9hAE+ocFSf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gVLTca81VyzmWJPHZ1XRM8wpGx91F1ehz6zWo5RgDcGgnNrGRYv7gwb4L8wSaGQy6
         58p0kAqTEBX2B+ZhmkdkRtK4OvS0N3nBtO/44NvxnRTtG37M80tqbPxBCpuGVBVrYX
         Lc19vX6RLlULkBWswy35J1yqets3vasDgQMBrgRL0Zn8iEhGuVJhxJ7pgB+M1uwTSc
         DFIOaUc/RIZzLpDYhxqAvr1dmKC+B3faD6nBtFLTYETHitmbTxBp0g06mbo6hSa9eN
         zfW1VF5vpbIaUC/aVJixw/BgmmMoectkQsyn5DDvCQHDrA4bEgMdkhqgO/a0SXycWj
         q5TvSNFtlbpug==
Date:   Fri, 23 Jun 2023 10:40:00 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "willy@infradead.org" <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 16/42] mm: Add guard pages around a shadow stack.
Message-ID: <20230623074000.GG52412@kernel.org>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-17-rick.p.edgecombe@intel.com>
 <ZJSRD1xZauOW3jFO@casper.infradead.org>
 <ba77d21492e2631072f51328413d227f31dd78ae.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba77d21492e2631072f51328413d227f31dd78ae.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 22, 2023 at 06:27:40PM +0000, Edgecombe, Rick P wrote:
> On Thu, 2023-06-22 at 19:21 +0100, Matthew Wilcox wrote:
> > On Mon, Jun 12, 2023 at 05:10:42PM -0700, Rick Edgecombe wrote:
> > > +++ b/include/linux/mm.h
> > > @@ -342,7 +342,36 @@ extern unsigned int kobjsize(const void
> > > *objp);
> > >   #endif /* CONFIG_ARCH_HAS_PKEYS */
> > >   
> > >   #ifdef CONFIG_X86_USER_SHADOW_STACK
> > > -# define VM_SHADOW_STACK       VM_HIGH_ARCH_5 /* Should not be set
> > > with VM_SHARED */
> > > +/*
> > > + * This flag should not be set with VM_SHARED because of lack of
> > > support
> > > + * core mm. It will also get a guard page. This helps userspace
> > > protect
> > > + * itself from attacks. The reasoning is as follows:
> > > + *
> > > + * The shadow stack pointer(SSP) is moved by CALL, RET, and
> > > INCSSPQ. The
> > > + * INCSSP instruction can increment the shadow stack pointer. It
> > > is the
> > > + * shadow stack analog of an instruction like:
> > > + *
> > > + *   addq $0x80, %rsp
> > > + *
> > > + * However, there is one important difference between an ADD on
> > > %rsp
> > > + * and INCSSP. In addition to modifying SSP, INCSSP also reads
> > > from the
> > > + * memory of the first and last elements that were "popped". It
> > > can be
> > > + * thought of as acting like this:
> > > + *
> > > + * READ_ONCE(ssp);       // read+discard top element on stack
> > > + * ssp += nr_to_pop * 8; // move the shadow stack
> > > + * READ_ONCE(ssp-8);     // read+discard last popped stack element
> > > + *
> > > + * The maximum distance INCSSP can move the SSP is 2040 bytes,
> > > before
> > > + * it would read the memory. Therefore a single page gap will be
> > > enough
> > > + * to prevent any operation from shifting the SSP to an adjacent
> > > stack,
> > > + * since it would have to land in the gap at least once, causing a
> > > + * fault.
> > > + *
> > > + * Prevent using INCSSP to move the SSP between shadow stacks by
> > > + * having a PAGE_SIZE guard gap.
> > > + */
> > > +# define VM_SHADOW_STACK       VM_HIGH_ARCH_5
> > >   #else
> > >   # define VM_SHADOW_STACK      VM_NONE
> > >   #endif
> > 
> > This is a lot of very x86-specific language in a generic header file.
> > I'm sure there's a better place for all this text.
> 
> Yes, I couldn't find another place for it. This was the reasoning:
> https://lore.kernel.org/lkml/07deaffc10b1b68721bbbce370e145d8fec2a494.camel@intel.com/
> 
> Did you have any particular place in mind?

Since it's near CONFIG_X86_USER_SHADOW_STACK the comment in mm.h could be 

/*
 * VMA is used for shadow stack and implies guard pages.
 * See arch/x86/kernel/shstk.c for details
 */

and the long reasoning comment can be moved near alloc_shstk in
arch/x86/kernel/shstk.h

-- 
Sincerely yours,
Mike.
