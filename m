Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413FB6A9C83
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 17:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjCCQ6H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 11:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjCCQ6G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 11:58:06 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D6DBDDD;
        Fri,  3 Mar 2023 08:58:04 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id x199so2564215ybg.5;
        Fri, 03 Mar 2023 08:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677862683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tURdhw498bOHnYQo1Wbcyg/CVD2GUHQ/ilVefn7+ZzY=;
        b=IDIBW0UNVpMI+IMCx1+mckdBWjg/FVAdJKROu+nBsttHf8pTuYRxWlw4sNGnlqQR5l
         7WIyPrarL2OAHw3eugjv2bBaRATtrgVVY+6JMknIEirhKSPLNcEhhPNa7WHiZ2LpZ260
         /SzgyM/a3KmbmSGl9Vo+MJfY9mQLHxSmn2Iil/Me5OusWN6U2DYkkp10BA9g9dTpQSO/
         CWxVyJROAUMr++qVJPCqqdcFIgaP86Ysrw5vdbFlF8nf2oIfRk9GGkjmwINitq3+VFcm
         R6PaMqu3cjBYb9ZZlRdEIWH9NgDwNYjvOID4ClEtARGUOukOi+HIYQE2E1a5ZDVS3z2f
         z85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677862683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tURdhw498bOHnYQo1Wbcyg/CVD2GUHQ/ilVefn7+ZzY=;
        b=mWqo3X+q3ytjlxFyQ3SfHeiLiQEinGXHJdvOTQM6CczMH7KFSHYoEx/IzkaKg9eY/x
         m6Z5y5ZROqrv3Ig+2jKWVfAFwYZBfa7NiiKXFiO+6vqgkS6spoeoyAi9RAoX3dwG9iWC
         rKg3ATf9EJ00VbSKFDkW4BfyMAya83xgYgRF2x15U8gGa6FgbHXlXMh9ygh2Lhd2uI0l
         5oPAnfyuQs1NKtAhTWnxXx0VTQBZahT7EXTUk7wi7shq6oorXDjp5u1l/WeYA4Z1BhF2
         62vJV2RF5NtzG1OMSGDccDQV0sylE6rH8KLnaWeD9xUK8d/NrMCMTyPMNLgmqZdaxMCg
         rqsw==
X-Gm-Message-State: AO0yUKXNyOvns1jlBMkb1/nkJV5Vboq/LrHkR5rkyIxCFOyJQUEXBQHr
        lEM9p5GG2rvdSyC09SRGHVORImrOqQ9+Dk6JJgU=
X-Google-Smtp-Source: AK7set8CJEPgUHfm0NWAyZb3Ct1QVtkyvLCsvbeoZUIfZc1JR5vgiNci4fMnknHET2767/ewn501c8bkQgWEQc7mcyw=
X-Received: by 2002:a05:6902:2ca:b0:8a3:d147:280b with SMTP id
 w10-20020a05690202ca00b008a3d147280bmr1316955ybh.3.1677862683371; Fri, 03 Mar
 2023 08:58:03 -0800 (PST)
MIME-Version: 1.0
References: <Y/9fdYQ8Cd0GI+8C@arm.com> <636de4a28a42a082f182e940fbd8e63ea23895cc.camel@intel.com>
 <ZADLZJI1W1PCJf5t@arm.com> <8153f5d15ec6aa4a221fb945e16d315068bd06e4.camel@intel.com>
 <ZAIgrXQ4670gxlE4@arm.com>
In-Reply-To: <ZAIgrXQ4670gxlE4@arm.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Fri, 3 Mar 2023 08:57:27 -0800
Message-ID: <CAMe9rOrM=HXBY25rYrjLnHzSvHFuui06qRpc4xufxeaaGW-Fmw@mail.gmail.com>
Subject: Re: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack description
To:     "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, "nd@arm.com" <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 3, 2023 at 8:31=E2=80=AFAM szabolcs.nagy@arm.com
<szabolcs.nagy@arm.com> wrote:
>
> The 03/02/2023 21:17, Edgecombe, Rick P wrote:
> > Is the idea that shadow stack would be forced on regardless of if the
> > linked libraries support it? In which case it could be allowed to crash
> > if they do not?
>
> execute a binary
> - with shstk enabled and locked (only if marked?).
> - with shstk disabled and locked.
> could be managed in userspace, but it is libc dependent then.
>
> > > > > - I think it's better to have a new limit specifically for shadow
> > > > >   stack size (which by default can be RLIMIT_STACK) so userspace
> > > > >   can adjust it if needed (another reason is that stack size is
> > > > >   not always a good indicator of max call depth).
> >
> > Looking at this again, I'm not sure why a new rlimit is needed. It
> > seems many of those points were just formulations of that the clone3
> > stack size was not used, but it actually is and just not documented. If
> > you disagree perhaps you could elaborate on what the requirements are
> > and we can see if it seems tricky to do in a follow up.
>
> - tiny thread stack and deep signal stack.
> (note that this does not really work with glibc because it has
> implementation internal signals that don't run on alt stack,
> cannot be masked and don't fit on a tiny thread stack, but
> with other runtimes this can be a valid use-case, e.g. musl
> allows tiny thread stacks, < pagesize.)
>
> - thread runtimes with clone (glibc uses clone3 but some dont).
>
> - huge stacks but small call depth (problem if some va limit
>   is hit or memory overcommit is disabled).
>
> > > "sigaltshstk() is separate from sigaltstack(). You can have one
> > > without the other, neither or both together. Because the shadow
> > > stack specific state is pushed to the shadow stack, the two
> > > features don=E2=80=99t need to know about each other."
> ...
> > > i don't see why automatic alt shadow stack allocation would
> > > not work (kernel manages it transparently when an alt stack
> > > is installed or disabled).
> >
> > Ah, I think I see where maybe I can fill you in. Andy Luto had
> > discounted this idea out of hand originally, but I didn't see it at
> > first. sigaltstack lets you set, retrieve, or disable the shadow stack,
> > right... But this doesn't allocate anything, it just sets where the
> > next signal will be handled. This is different than things like threads
> > where there is a new resources being allocated and it makes coming up
> > with logic to guess when to de-allocate the alt shadow stack difficult.
> > You probably already know...
> >
> > But because of this there can be some modes where the shadow stack is
> > changed while on it. For one example, SS_AUTODISARM will disable the
> > alt shadow stack while switching to it and restore when sigreturning.
> > At which point a new altstack can be set. In the non-shadow stack case
> > this is nice because future signals won't clobber the alt stack if you
> > switch away from it (swapcontext(), etc). But it also means you can
> > "change" the alt stack while on it ("change" sort of, the auto disarm
> > results in the kernel forgetting it temporarily).
>
> the problem with swapcontext is that it may unmask signals
> that run on the alt stack, which means the code cannot jump
> back after another signal clobbered the alt stack.
>
> the non-standard SS_AUTODISARM aims to solve this by disabling
> alt stack settings on signal entry until the handler returns.
>
> so this use case is not about supporting swapcontext out, but
> about jumping back. however that does not work reliably with
> this patchset: if swapcontext goes to the thread stack (and
> not to another stack e.g. used by makecontext), then jump back
> fails. (and if there is a sigaltshstk installed then even jump
> out fails.)
>
> assuming
> - jump out from alt shadow stack can be made to work.
> - alt shadow stack management can be automatic.
> then this can be improved so jump back works reliably.
>
> > I hear where you are coming from with the desire to have it "just work"
> > with existing code, but I think the resulting ABI around the alt shadow
> > stack allocation lifecycle would be way too complicated even if it
> > could be made to work. Hence making a new interface. But also, the idea
> > was that the x86 signal ABI should support handling alt shadow stacks,
> > which is what we have done with this series. If a different interface
> > for configuring it is better than the one from the POC, I'm not seeing
> > a problem jump out. Is there any specific concern about backwards
> > compatibility here?
>
> sigaltstack syscall behaviour may be hard to change later
> and currently
> - shadow stack overflow cannot be recovered from.
> - longjmp out of signal handler fails (with sigaltshstk).
> - SS_AUTODISARM does not work (jump back can fail).
>
> > > "Since shadow alt stacks are a new feature, longjmp()ing from an
> > > alt shadow stack will simply not be supported. If a libc want=E2=80=
=99s
> > > to support this it will need to enable WRSS and write it=E2=80=99s ow=
n
> > > restore token."
> > >
> > > i think longjmp should work without enabling writes to the shadow
> > > stack in the libc. this can also affect unwinding across signal
> > > handlers (not for c++ but e.g. glibc thread cancellation).
> >
> > glibc today does not support longjmp()ing from a different stack (for
> > example even today after a swapcontext()) when shadow stack is used. If
> > glibc used wrss it could be supported maybe, but otherwise I don't see
> > how the HW can support it.
> >
> > HJ and I were actually just discussing this the other day. Are you
> > looking at this series with respect to the arm shadow stack feature by
> > any chance? I would love if glibc/tools would document what the shadow
> > stack limitations are. If the all the arch's have the same or similar
> > limitations perhaps this could be one developer guide. For the most
> > part though, the limitations I've encountered are in glibc and the
> > kernel is more the building blocks.
>
> well we hope that shadow stack behaviour and limitations can
> be similar across targets.
>
> longjmp to different stack should work: it can do the same as
> setcontext/swapcontext: scan for the pivot token. then only
> longjmp out of alt shadow stack fails. (this is non-conforming
> longjmp use, but e.g. qemu relies on it.)

Restore token may not be used with longjmp.  Unlike setcontext/swapcontext,
longjmp is optional.  If longjmp isn't called, there will be an extra
token on shadow
stack and RET will fail.

> for longjmp out of alt shadow stack, the target shadow stack
> needs a pivot token, which implies the kernel needs to push that
> on signal entry, which can overflow. but i suspect that can be
> handled the same way as stackoverflow on signal entry is handled.
>
> > A general comment. Not sure if you are aware, but this shadow stack
> > enabling effort is quite old at this point and there have been many
> > discussions on these topics stretching back years. The latest
> > conversation was around getting this series into linux-next soon to get
> > some testing on the MM pieces. I really appreciate getting this ABI
> > feedback as it is always tricky to get right, but at this stage I would
> > hope to be focusing mostly on concrete problems.
> >
> > I also expect to have some amount of ABI growth going forward with all
> > the normal things that entails. Shadow stack is not special in that it
> > can come fully finalized without the need for the real world usage
> > iterative feedback process. At some point we need to move forward with
> > something, and we have quite a bit of initial changes at this point.
> >
> > So I would like to minimize the initial implementation unless anyone
> > sees any likely problems with future growth. Can you be clear if you
> > see any concrete problems at this point or are more looking to evaluate
> > the design reasoning? I'm under the assumption there is nothing that
> > would prohibit linux-next testing while any ABI shakedown happens
> > concurrently at least?
>
> understood.
>
> the points that i think are worth raising:
>
> - shadow stack size logic may need to change later.
>   (it can be too big, or too small in practice.)
> - shadow stack overflow is not recoverable and the
>   possible fix for that (sigaltshstk) breaks longjmp
>   out of signal handlers.
> - jump back after SS_AUTODISARM swapcontext cannot be
>   reliable if alt signal uses thread shadow stack.
> - the above two concerns may be mitigated by different
>   sigaltstack behaviour which may be hard to add later.
> - end token for backtrace may be useful, if added
>   later it can be hard to check.
>
> thanks.



--=20
H.J.
