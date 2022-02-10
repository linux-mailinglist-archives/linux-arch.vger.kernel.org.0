Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135C74B039B
	for <lists+linux-arch@lfdr.de>; Thu, 10 Feb 2022 03:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiBJCyM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 21:54:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiBJCyK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 21:54:10 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBB12409C;
        Wed,  9 Feb 2022 18:54:12 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id c5-20020a17090a1d0500b001b904a7046dso5581711pjd.1;
        Wed, 09 Feb 2022 18:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LYtzFa4ASuB/belwk4SpigACGs97QFCNc+YA+b4+Pu8=;
        b=ooyOBN7rERkODAn/O7i91EVsu/B8py9/9Ax69BwNB/kc8twYaVRYQbpcJLPfemS8hb
         HkZrVDMhaV95LcunHTo0tXcqRJZORHlOHEddL00vfE0PK8esTG7SYwyfiB500tCWC5ri
         l6pU4DRAUF2bgKokxVocV+eyMRJSuUiaChrZncXI+PVNYsSVUld+MssdbvKffnPGzFCP
         /mFWpEPHIlrNEUqjbs//hj1a3I/579YtM3Jds8TxeUAfuDxW/OEsiijqam43ukxKjsH2
         DVh6iBEBwC5CIYV0XcyMGIqDOrpfE98dazgVv4DXpTrUcv9pfj8LdcCQ7wiJQIrh4Oh5
         3Jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYtzFa4ASuB/belwk4SpigACGs97QFCNc+YA+b4+Pu8=;
        b=uALWmATrZX74RaBe98UHtNXaO4Hi28sKD9ehr2ue7uiuMjaZ3NQA18CDPRmfozkRPB
         q+0wadNFhmTb3/TM7B0xzKK9+dpDvM1dYrpNeU2tg4jRqDGiCPOmOFedjqwQRR5IjxWv
         LOw2NYLFOcnfO8oLhRyyUP75QfWZG/ghB/uQ6bJIQgJc6GAQeLS+qUAudQmEJnKDFZTE
         LiM+RRRh+fGVtXxtkUk7K9tBqVG3FNPpzqZdsj80X0V4nWLFubaf0hNMyU+XT6thyJGM
         MDWqlXurgp/6Sve2NGtls/J+sDubocjwNa5eK2UF0Xg1pwrgeSbWcgETWOF15RCyvlOx
         1obA==
X-Gm-Message-State: AOAM530nZC8cGP8fB+AEg4rfvv3nPQsqbLNJGOd5A5yCHrW+XLpquTcY
        F0VgsjdM+eMcxlvorzJYHPUwl4a3DyCy0WezQmM=
X-Google-Smtp-Source: ABdhPJzYBhEkkbttuvOrcTM53VUGSP9oL8rWSIPgIMmpLUpLM1VPVkR+SLhvmLHyyTITlBZxB9qfd23OzJjqo7RcYHM=
X-Received: by 2002:a17:903:2351:: with SMTP id c17mr367198plh.4.1644461651987;
 Wed, 09 Feb 2022 18:54:11 -0800 (PST)
MIME-Version: 1.0
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <YgAWVSGQg8FPCeba@kernel.org> <YgDIIpCm3UITk896@lisas.de> <8f96c2a6-9c03-f97a-df52-73ffc1d87957@intel.com>
 <YgI1A0CtfmT7GMIp@kernel.org> <YgI37n+3JfLSNQCQ@grain> <357664de-b089-4617-99d1-de5098953c80@www.fastmail.com>
 <YgKiKEcsNt7mpMHN@grain> <8e36f20723ca175db49ed3cc73e42e8aa28d2615.camel@intel.com>
 <9d664c91-2116-42cc-ef8d-e6d236de43d0@kernel.org>
In-Reply-To: <9d664c91-2116-42cc-ef8d-e6d236de43d0@kernel.org>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Wed, 9 Feb 2022 18:53:35 -0800
Message-ID: <CAMe9rOo+RbmK5GyFKe2q3GGFP4Oi3o16x9xVpD7HpoEn=v0mfQ@mail.gmail.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
To:     Andy Lutomirski <luto@kernel.org>,
        Felix Willgerodt <felix.willgerodt@intel.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "adrian@lisas.de" <adrian@lisas.de>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "avagin@gmail.com" <avagin@gmail.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 9, 2022 at 6:37 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On 2/8/22 18:18, Edgecombe, Rick P wrote:
> > On Tue, 2022-02-08 at 20:02 +0300, Cyrill Gorcunov wrote:
> >> On Tue, Feb 08, 2022 at 08:21:20AM -0800, Andy Lutomirski wrote:
> >>>>> But such a knob will immediately reduce the security value of
> >>>>> the entire
> >>>>> thing, and I don't have good ideas how to deal with it :(
> >>>>
> >>>> Probably a kind of latch in the task_struct which would trigger
> >>>> off once
> >>>> returt to a different address happened, thus we would be able to
> >>>> jump inside
> >>>> paratite code. Of course such trigger should be available under
> >>>> proper
> >>>> capability only.
> >>>
> >>> I'm not fully in touch with how parasite, etc works.  Are we
> >>> talking about save or restore?
> >>
> >> We use parasite code in question during checkpoint phase as far as I
> >> remember.
> >> push addr/lret trick is used to run "injected" code (code injection
> >> itself is
> >> done via ptrace) in compat mode at least. Dima, Andrei, I didn't look
> >> into this code
> >> for years already, do we still need to support compat mode at all?
> >>
> >>> If it's restore, what exactly does CRIU need to do?  Is it just
> >>> that CRIU needs to return
> >>> out from its resume code into the to-be-resumed program without
> >>> tripping CET?  Would it
> >>> be acceptable for CRIU to require that at least one shstk slot be
> >>> free at save time?
> >>> Or do we need a mechanism to atomically switch to a completely full
> >>> shadow stack at resume?
> >>>
> >>> Off the top of my head, a sigreturn (or sigreturn-like mechanism)
> >>> that is intended for
> >>> use for altshadowstack could safely verify a token on the
> >>> altshdowstack, possibly
> >>> compare to something in ucontext (or not -- this isn't clearly
> >>> necessary) and switch
> >>> back to the previous stack.  CRIU could use that too.  Obviously
> >>> CRIU will need a way
> >>> to populate the relevant stacks, but WRUSS can be used for that,
> >>> and I think this
> >>> is a fundamental requirement for CRIU -- CRIU restore absolutely
> >>> needs a way to write
> >>> the saved shadow stack data into the shadow stack.
> >
> > Still wrapping my head around the CRIU save and restore steps, but
> > another general approach might be to give ptrace the ability to
> > temporarily pause/resume/set CET enablement and SSP for a stopped
> > thread. Then injected code doesn't need to jump through any hoops or
> > possibly run into road blocks. I'm not sure how much this opens things
> > up if the thread has to be stopped...
>
> Hmm, that's maybe not insane.
>
> An alternative would be to add a bona fide ptrace call-a-function
> mechanism.  I can think of two potentially usable variants:
>
> 1. Straight call.  PTRACE_CALL_FUNCTION(addr) just emulates CALL addr,
> shadow stack push and all.
>
> 2. Signal-style.  PTRACE_CALL_FUNCTION_SIGFRAME injects an actual signal
> frame just like a real signal is being delivered with the specified
> handler.  There could be a variant to opt-in to also using a specified
> altstack and altshadowstack.
>
> 2 would be more expensive but would avoid the need for much in the way
> of asm magic.  The injected code could be plain C (or Rust or Zig or
> whatever).
>
> All of this only really handles save, not restore.  I don't understand
> restore enough to fully understand the issue.

FWIW, CET enabled GDB can call a function in a CET enabled process.
Adding Felix who may know more about it.


-- 
H.J.
