Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B1060DF68
	for <lists+linux-arch@lfdr.de>; Wed, 26 Oct 2022 13:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbiJZLVR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Oct 2022 07:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiJZLVQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Oct 2022 07:21:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8596B157;
        Wed, 26 Oct 2022 04:21:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2779961E09;
        Wed, 26 Oct 2022 11:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87767C433B5;
        Wed, 26 Oct 2022 11:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666783271;
        bh=NAVp8uEduDStMJCrlDCOVZLsuRHl7T0LI1R4UdnAS9E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vEJNCsP4bu39Uh+7Z4a04naEGjU4ejwSELoNf0mGC2JEc3gLcGGvrh6K/KtoiBlwC
         VL0tm8T3B4tFkzPe/VXTZFmaTyJnGveR0p7bfy1azwZBOm4aBUzmiPhg2aR9IiQLDS
         brrTX/eErtT1k8eVh7yAaYZanQikZTppzesmwddCT66r2DD0p753N4OUVfEOjmuCGD
         pRu0Ired5tfPIZKgu8jDFMOTaPsPYzKDn49Cd3ezizIpvYfVe3CoVrnm014vuPej7q
         mug/EdWv5nRO20G463eB5ilWdYPVEIinKacuWdvR336m9q6So1sSJZNQ/T2ABd1SMw
         P9aNPUsZil+0A==
Received: by mail-lf1-f49.google.com with SMTP id b1so27840880lfs.7;
        Wed, 26 Oct 2022 04:21:11 -0700 (PDT)
X-Gm-Message-State: ACrzQf0cvx4jxsR+NTdcNhSi4c6v52tD4+13PZfak680JGh/8qaructi
        F1G8rQZpqN/ixHGs29VdZg2eoXxC+28t4+xM5Es=
X-Google-Smtp-Source: AMsMyM4WLWwPUohG4XslDN71DAQF8KR2HwzOwYLjQv9yIiPPf8jpuDcnXMXnFuBR171lJef+KZsCdzzD76v7/E23b2U=
X-Received: by 2002:a05:6512:150e:b0:492:d9fd:9bdf with SMTP id
 bq14-20020a056512150e00b00492d9fd9bdfmr15200308lfb.583.1666783269606; Wed, 26
 Oct 2022 04:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220924181915.3251186-1-masahiroy@kernel.org>
 <20220924181915.3251186-7-masahiroy@kernel.org> <ea468b86-abb7-bb2b-1e0a-4c8959d23f1c@kernel.org>
 <alpine.LSU.2.20.2210251210140.29399@wotan.suse.de> <2008526a-e0ca-7e67-cff6-b540d62e58c7@kernel.org>
In-Reply-To: <2008526a-e0ca-7e67-cff6-b540d62e58c7@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 26 Oct 2022 13:20:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGNZQLGxZm8487MRcViriv=S21erw+qMq05BUr0v+8=AQ@mail.gmail.com>
Message-ID: <CAMj1kXGNZQLGxZm8487MRcViriv=S21erw+qMq05BUr0v+8=AQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] kbuild: use obj-y instead extra-y for objects
 placed at the head
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Michael Matz <matz@suse.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Borislav Petkov <bpetkov@suse.de>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 26 Oct 2022 at 10:35, Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 25. 10. 22, 14:26, Michael Matz wrote:
> >> Ideas, comments? I'll send the attachment as a PATCH later (if there are
> >> no better suggestions).
> >
> > This will work.  An alternative way would be to explicitly name the input
> > file in the section commands, without renaming the section:
> >
> > @@ -126,6 +126,7 @@ SECTIONS
> >                  _text = .;
> >                  _stext = .;
> >                  /* bootstrapping code */
> > +               KEEP(vmlinux.a:head64.o(.head.text))
> >                  HEAD_TEXT
> >                  TEXT_TEXT
> >
> > But I guess not all arch's name their must-be-first file head64.o (or even
> > have such requirement), so that's probably still arch-dependend and hence
> > not inherently better than your way.
>
> The downside of this is that it doesn't make sure the function
> (startup_64()) is the first one. When someone sticks something before
> it, it breaks again. But leaving the decision up to the x86 maintainers ;).
>
> Re. other archs, I have absolutely no idea (haven't looked into that at
> all).
>

I seriously doubt that those __head routines need to be in .head.text.
At the time, there seems to have been some regression related to
5-level paging, but whether and how that change actually fixed
anything at all is undocumented.

So the fix here is to move those __head routines into __init, so that
only startup_64 remains in .head.text, and the existing linker script
will put it where it belongs.





commit 26179670a68b7b365fbfe38afb043dcd2e1a4678
Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Date:   Fri Jun 16 14:30:24 2017 +0300

    x86/boot/64: Put __startup_64() into .head.text

    Put __startup_64() and fixup_pointer() into .head.text section to make
    sure it's always near startup_64() and always callable.

    Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: kernel test robot <fengguang.wu@intel.com>
    Cc: wfg@linux.intel.com
    Link: http://lkml.kernel.org/r/20170616113024.ajmif63cmcszry5a@black.fi.intel.com
    Signed-off-by: Ingo Molnar <mingo@kernel.org>
