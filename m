Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2B04D073E
	for <lists+linux-arch@lfdr.de>; Mon,  7 Mar 2022 20:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbiCGTIe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Mar 2022 14:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236762AbiCGTId (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Mar 2022 14:08:33 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E3C76E02;
        Mon,  7 Mar 2022 11:07:37 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id n2so5318192plf.4;
        Mon, 07 Mar 2022 11:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dZFFGAI41Xqgivfjx6QQZdhcCE9AkmS2075GxxH2TUk=;
        b=D2blqdjH51q+kC52swKVIAnyEuirhV+zuTeosT8tBUiuQ8JUZgr6lFdKZSetysZjXY
         6snR+ZPSonkq8jJ3vvey8b+lzRj46QG4ezhO5OHnhjKmmcR4DZvVw5+gNeukXrg/e2ul
         qRRKG5h1hTJjgvjYbCoHsEWXS6goEtaLaUyz9aONsMEpd+6bDnYsu1nfRThBMO4iLVX/
         6mZ5+CGqbiCCwAVXXfA/jNT2f5QAV3h3Yrfg6hMWe+S3s9mjl5RtI7tjPfpGVCF3jVkh
         aw/lCVjp3XSNOL2Ngy3mUk9qqSZ/rdOmZooPGCthOQJGiIlwMlSIEiPDd7/dDswgdEtD
         YGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dZFFGAI41Xqgivfjx6QQZdhcCE9AkmS2075GxxH2TUk=;
        b=GpAprmTVgWbxyTNvULE8oE2qZGYbasy8lSLlOy9w3XvRU7QgZySXPhFXjmYQLpqS1F
         biPTtnYKsFIfH0EA9n6OFjpb3tHEqfas6Mm1ET07Ooeiiz/CA5bXF0okYq0QLqjlH+4a
         OpJqGpPtJXRwQJArkvvcOMiqiDECuUFX+37x/55Lnuw/Bvf63RddC7zVo9pXqKl8tlac
         xO7Lmjr+3pKeAduJ31gemKWplSAdpDnkl4ZaBy2zHl+JgrcRv6Yf0rjduEnD6v8gUeB1
         vtiSABmt+ESrNqmuO4/ljWSH1JSA9zNYadwh1Mym+r2fWOTDTWNxIotg2PtvuXtXi0Di
         6sIw==
X-Gm-Message-State: AOAM532OJ3fBTDET5fP8Ka7f6NrOE7ZIOA6Qt/u2tk/Fq2XfBDYP1Tlf
        9sXQ5Rb+qan2kr6rlhHpe+et7Sp3UgtiwuYCNdk=
X-Google-Smtp-Source: ABdhPJwt/gHLXtSar7JyewiFUXyqtmRnlaI7KiXXwYh3XzgPj2SzKQC04MUqErP8JFshxuzc56MxgGeD3GNuhYO2LQ8=
X-Received: by 2002:a17:90a:74c7:b0:1bf:5532:3ae8 with SMTP id
 p7-20020a17090a74c700b001bf55323ae8mr464224pjl.120.1646680057174; Mon, 07 Mar
 2022 11:07:37 -0800 (PST)
MIME-Version: 1.0
References: <8e36f20723ca175db49ed3cc73e42e8aa28d2615.camel@intel.com>
 <9d664c91-2116-42cc-ef8d-e6d236de43d0@kernel.org> <Yh0wIMjFdDl8vaNM@kernel.org>
 <5a792e77-0072-4ded-9f89-e7fcc7f7a1d6@www.fastmail.com> <Yh0+9cFyAfnsXqxI@kernel.org>
 <05df964f-552e-402e-981c-a8bea11c555c@www.fastmail.com> <YiEZyTT/UBFZd6Am@kernel.org>
 <CALCETrWacW8SC2tpPxQSaLtxsOXfXHueyuwLcXpNF4aG-0ZvhA@mail.gmail.com>
 <fb7d6e4da58ae77be2c6321ee3f3487485b2886c.camel@intel.com>
 <40a3500c-835a-60b0-15bf-40c6622ad013@kernel.org> <YiZVbPwlgSFnhadv@kernel.org>
In-Reply-To: <YiZVbPwlgSFnhadv@kernel.org>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 7 Mar 2022 11:07:01 -0800
Message-ID: <CAMe9rOrSLPKdL2gL=yx84zrs-u6ch1AVvjk3oqUe3thR5ZD=dQ@mail.gmail.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "adrian@lisas.de" <adrian@lisas.de>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "avagin@gmail.com" <avagin@gmail.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "dave.martin@arm.com" <dave.martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
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

On Mon, Mar 7, 2022 at 10:57 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Fri, Mar 04, 2022 at 11:13:19AM -0800, Andy Lutomirski wrote:
> > On 3/3/22 17:30, Edgecombe, Rick P wrote:
> > > On Thu, 2022-03-03 at 15:00 -0800, Andy Lutomirski wrote:
> > > > > > The intent of PTRACE_CALL_FUNCTION_SIGFRAME is push a signal
> > > > > > frame onto
> > > > > > the stack and call a function.  That function should then be able
> > > > > > to call
> > > > > > sigreturn just like any normal signal handler.
> > > > >
> > > > > Ok, let me reiterate.
> > > > >
> > > > > We have a seized and stopped tracee, use
> > > > > PTRACE_CALL_FUNCTION_SIGFRAME
> > > > > to push a signal frame onto the tracee's stack so that sigreturn
> > > > > could use
> > > > > that frame, then set the tracee %rip to the function we'd like to
> > > > > call and
> > > > > then we PTRACE_CONT the tracee. Tracee continues to execute the
> > > > > parasite
> > > > > code that calls sigreturn to clean up and restore the tracee
> > > > > process.
> > > > >
> > > > > PTRACE_CALL_FUNCTION_SIGFRAME also pushes a restore token to the
> > > > > shadow
> > > > > stack, just like setup_rt_frame() does, so that sys_rt_sigreturn()
> > > > > won't
> > > > > bail out at restore_signal_shadow_stack().
> > > >
> > > > That is the intent.
> > > >
> > > > >
> > > > > The only thing that CRIU actually needs is to push a restore token
> > > > > to the
> > > > > shadow stack, so for us a ptrace call that does that would be
> > > > > ideal.
> > > > >
> > > >
> > > > That seems fine too.  The main benefit of the SIGFRAME approach is
> > > > that, AIUI, CRIU eventually constructs a signal frame anyway, and
> > > > getting one ready-made seems plausibly helpful.  But if it's not
> > > > actually that useful, then there's no need to do it.
> > >
> > > I guess pushing a token to the shadow stack could be done like GDB does
> > > calls, with just the basic CET ptrace support. So do we even need a
> > > specific push token operation?
>
> I've tried to follow gdb CET push implementation, but got lost.
> What is "basic CET ptrace support"? I don't see any ptrace changes in this
> series.

Here is the CET ptrace patch on CET 5.16 kernel branch:

https://github.com/hjl-tools/linux/commit/3a43ec29ddac56f87807161b5aeafa80f632363d

> > > I suppose if CRIU already used some kernel encapsulation of a seized
> > > call/return operation it would have been easier to make CRIU work with
> > > the introduction of CET. But the design of CRIU seems to be to have the
> > > kernel expose just enough and then tie it all together in userspace.
> > >
> > > Andy, did you have any other usages for PTRACE_CALL_FUNCTION in mind? I
> > > couldn't find any other CRIU-like users of sigreturn in the debian
> > > source search (but didn't read all 819 pages that come up with
> > > "sigreturn"). It seemed to be mostly seccomp sandbox references.
> >
> > I don't see a benefit compelling enough to justify the added complexity,
> > given that existing mechanisms can do it.
> >
> > The sigframe thing, OTOH, seems genuinely useful if CRIU would actually use
> > it to save the full register state.  Generating a signal frame from scratch
> > is a pain.  That being said, if CRIU isn't excited, then don't bother.
>
> CRIU is excited :)
>
> I just was looking for the minimal possible interface that will allow us to
> call sigreturn. Rick is right and CRIU does try to expose as little as
> possible and handle the pain in the userspace.
>
> The SIGFRAME approach is indeed very helpful, especially if we can make it
> work on other architectures eventually.
>
> --
> Sincerely yours,
> Mike.



-- 
H.J.
