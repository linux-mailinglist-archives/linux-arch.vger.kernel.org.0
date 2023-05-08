Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860506FAE2F
	for <lists+linux-arch@lfdr.de>; Mon,  8 May 2023 13:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbjEHLmN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 May 2023 07:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbjEHLlt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 May 2023 07:41:49 -0400
Received: from out0-218.mail.aliyun.com (out0-218.mail.aliyun.com [140.205.0.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F38742392;
        Mon,  8 May 2023 04:41:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047192;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---.Sbb2YsX_1683546048;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.Sbb2YsX_1683546048)
          by smtp.aliyun-inc.com;
          Mon, 08 May 2023 19:40:49 +0800
Date:   Mon, 08 May 2023 19:40:48 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, "Arnd Bergmann" <arnd@arndb.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Juergen Gross" <jgross@suse.com>,
        "Brian Gerst" <brgerst@gmail.com>, <linux-arch@vger.kernel.org>
Subject: Re: [PATCH RFC 25/43] x86/mm: Make the x86 GOT read-only
Message-ID: <20230508114048.GB116442@k08j02272.eu95sqa>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
 <980069339b23a6cc4ae6d605d188338467a5b08b.1682673543.git.houwenlong.hwl@antgroup.com>
 <CAMj1kXFFo6Y=p63N41DrN4wLzMNVdtD-hp6gBVQwNqrzt7oqwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFFo6Y=p63N41DrN4wLzMNVdtD-hp6gBVQwNqrzt7oqwQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Apr 30, 2023 at 10:23:56PM +0800, Ard Biesheuvel wrote:
> On Fri, 28 Apr 2023 at 11:55, Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
> >
> > From: Thomas Garnier <thgarnie@chromium.org>
> >
> > From: Thomas Garnier <thgarnie@chromium.org>
> >
> > The GOT is changed during early boot when relocations are applied. Make
> > it read-only directly. This table exists only for PIE binary. Since weak
> > symbol reference would always be GOT reference, there are 8 entries in
> > GOT, but only one entry for __fentry__() is in use.  Other GOT
> > references have been optimized by linker.
> >
> > [Hou Wenlong: Change commit message and skip GOT size check]
> >
> > Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
> > Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> > Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/x86/kernel/vmlinux.lds.S     |  2 ++
> >  include/asm-generic/vmlinux.lds.h | 12 ++++++++++++
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> > index f02dcde9f8a8..fa4c6582663f 100644
> > --- a/arch/x86/kernel/vmlinux.lds.S
> > +++ b/arch/x86/kernel/vmlinux.lds.S
> > @@ -462,6 +462,7 @@ SECTIONS
> >  #endif
> >                "Unexpected GOT/PLT entries detected!")
> >
> > +#ifndef CONFIG_X86_PIE
> >         /*
> >          * Sections that should stay zero sized, which is safer to
> >          * explicitly check instead of blindly discarding.
> > @@ -470,6 +471,7 @@ SECTIONS
> >                 *(.got) *(.igot.*)
> >         }
> >         ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
> > +#endif
> >
> >         .plt : {
> >                 *(.plt) *(.plt.*) *(.iplt)
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index d1f57e4868ed..438ed8b39896 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -441,6 +441,17 @@
> >         __end_ro_after_init = .;
> >  #endif
> >
> > +#ifdef CONFIG_X86_PIE
> > +#define RO_GOT_X86
> 
> Please don't put X86 specific stuff in generic code.
> 
> > +       .got        : AT(ADDR(.got) - LOAD_OFFSET) {                    \
> > +               __start_got = .;                                        \
> > +               *(.got) *(.igot.*);                                     \
> > +               __end_got = .;                                          \
> > +       }
> > +#else
> > +#define RO_GOT_X86
> > +#endif
> > +
> 
> I don't think it makes sense for this definition to be conditional.
> You can include it conditionally from the x86 code, but even that
> seems unnecessary, given that it will be empty otherwise.
>
Hi Ard,
I know that X86 specific stuff should be in generic code. I notice that
even relocation relaxation is enabled, the GOT would not be empty. I
want it to be included in the read-only data section (RODATA) between
the symbols __start_rodata and __end_rodata for safety. I noticed that
you placed it in the data section during your PIE linking.  Should it be
marked as read-only if it is not empty?

Thanks.
> >  /*
> >   * .kcfi_traps contains a list KCFI trap locations.
> >   */
> > @@ -486,6 +497,7 @@
> >                 BOUNDED_SECTION_PRE_LABEL(.pci_fixup_suspend_late, _pci_fixups_suspend_late, __start, __end) \
> >         }                                                               \
> >                                                                         \
> > +       RO_GOT_X86                                                      \
> >         FW_LOADER_BUILT_IN_DATA                                         \
> >         TRACEDATA                                                       \
> >                                                                         \
> > --
> > 2.31.1
> >
