Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452ED5FA22A
	for <lists+linux-arch@lfdr.de>; Mon, 10 Oct 2022 18:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJJQwS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Oct 2022 12:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJJQwQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Oct 2022 12:52:16 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FAD4BA6A;
        Mon, 10 Oct 2022 09:52:16 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id o22so6601572qkl.8;
        Mon, 10 Oct 2022 09:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oOAMrHmRSpkJakBve7WdskWcaTVGvBf9qYMZKSI8SYQ=;
        b=Q8sYVnf00kTWCRr5s2EW8yzbBLdtj9OCViQALucyqGDOJtQP3MHEdqAQReGolr/xzD
         oXsuCmag5lCpq+NCRO/cO6srCK6qFv1sTmdB+kMBkSTN02u5chyUgsAoDAW2knrLNr3b
         cbs4o2MjKbMNiTTkwHvVPc902Ls2ARbirKrjLLQJTjH8zq4pZKKe+blfBZPJ+xiPx7IN
         z4H8esj5bJnmfTax22U98Ph9FdG4zFBlZsAzhGctc6nOePpHfTX+0WF61MQKPws4ABpL
         gQpNfXR+UILoj6Bz/Vrm1Hz+pG0Q2njH/JLdw8oCKQd2tydifWBU3SxuFCFx30Y8vwzT
         CzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOAMrHmRSpkJakBve7WdskWcaTVGvBf9qYMZKSI8SYQ=;
        b=4BQSQk028K+h30wPoqOqGonZEhELiMbZ4iGdxZ+6qbumO5sftxz49AmdyzFrDGIv5b
         mOneLb3SjBKSDliL8V7Viexg88SQH2kvPfPLjpZ+Ep9x0RL5rHzAfoB+WTLJgiNdJiFh
         vtR/xIlLzWcb75Qre2gJwiNrdYSIGeXbKZ1O22Dx4/00US1XOLrh13PV8TVuxwcQF8CI
         c4h/ZyUif8/eYxgy3BlE9JQW9CBt8qlh4TdXaXM8gBoTuToKGcDj61LHmcawFjO82Wv2
         mE3E+0NUYJp1MU6dCGFhDBM802nAKzBROA389WRAvi+k8SJEh1LsGU+XPo+83ID2nfcF
         MFnw==
X-Gm-Message-State: ACrzQf2gnp1UU9S4RP4DL/Myt+LOvx6GwtWiDDKE2UkJ695vuHcETR7Z
        wmvZfg36m3jYdLaFbov+hOl53Nx46K2V+0HDAog=
X-Google-Smtp-Source: AMsMyM49KjxzPTCVcheNbVgLCnfXLZF3yu9XhSaUO9ek7LN8ijdPuj4/dIcJpfv1T0Zo8WgMzTLJSC7vsLiJ1dt15Mw=
X-Received: by 2002:a05:620a:2552:b0:6ca:bf8f:4d27 with SMTP id
 s18-20020a05620a255200b006cabf8f4d27mr13312607qko.383.1665420735085; Mon, 10
 Oct 2022 09:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-2-rick.p.edgecombe@intel.com> <87ilkr27nv.fsf@oldenburg.str.redhat.com>
 <62481017bc02b35587dd520ed446a011641aa390.camel@intel.com>
In-Reply-To: <62481017bc02b35587dd520ed446a011641aa390.camel@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 10 Oct 2022 09:51:39 -0700
Message-ID: <CAMe9rOriQJ96VWkfGLnczhV8E0a3J3_N-XzGa7sBRqyoLv0u0Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/39] Documentation/x86: Add CET description
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "fweimer@redhat.com" <fweimer@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 10, 2022 at 9:44 AM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Mon, 2022-10-10 at 14:19 +0200, Florian Weimer wrote:
> > Uhm, I think we are using binutils 2.30 with extra fixes.  I hope
> > that
> > these binaries are still valid.
>
> Yea, you're right. Andrew Cooper pointed out it has been supported
> since 2.29, so 2.30 should be fine.
>
> >
> > More importantly, glibc needs to be configured with --enable-cet
> > explicitly (unless the compiler defaults to CET).  The default glibc
> > build with a default GCC will produce dynamically-linked executables
> > that disable CET (when running on later/differently configured glibc
> > builds).  The statically linked object files are not marked up for
> > CET
> > in that case.
>
> Thanks, that's a good point. I'll add a blurb about glibc needs to be
> compiled with CET support.
>
> >
> > I think the goal is to support the new kernel interface for actually
> > switching on SHSTK in glibc 2.37.  But at that point, hopefully all
> > those existing binaries can start enjoying the STSTK benefits.
>
> Can you share more about this plan? HJ was previously planning to wait
> until the kernel support was upstream before making any more glibc
> changes. Hopefully this will be in time for that, but I'd really rather
> not repeat what happened last time where we had to design the kernel
> interface around not breaking old glibc's with mismatched CET
> enablement.
>
> What did you think of the proposal to disable existing binaries and
> start from scratch? Elaborated in the coverletter in the section
> "Compatibility of Existing Binaries/Enabling Interface".

My current glibc plan is that kernel won't enable CET automatically
and glibc will issue syscall to enable CET at early startup time.   All
existing CET enabled dynamic executables will have CET enabled
under the CET kernel and the updated CET glibc.

-- 
H.J.
