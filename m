Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400936BF1A1
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 20:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjCQT00 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Mar 2023 15:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjCQT0Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Mar 2023 15:26:25 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20B842BC2
        for <linux-arch@vger.kernel.org>; Fri, 17 Mar 2023 12:26:21 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5418d54d77bso111828367b3.12
        for <linux-arch@vger.kernel.org>; Fri, 17 Mar 2023 12:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1679081181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDoP7wMOn5QpwBzbN9iej+FeZ8kKaqhVDSnQkP9mPKA=;
        b=if4Xv7MHtb5r/yx0jJJa7ZCf6eQjI9hJYAxsdQIFhamSCND9oLO8bYH/C2I1hUNeY8
         1BMlZLqLplLYHXMOHyoHWHhK4KDJObKlGKWpddb0oQRIBHss6GquFZ5dFLsAcM6NYro+
         pabWPsc5c8HNd6rzXX99ECRdtkqom+eV/fa7fIRLQXScMk7ka8eBFKmzBLBeKeAYCgXz
         Fo+VHMBQrrJ/j6Msoz1ab/7ZmVPRSyaBZpelmaWMMBlQpNFXaweiJf87AR3+9nefm4Go
         W8PPE9VHbz+5CAs9WWpzHA+c7oQ78s1CCMbx+v4aqVmba1SLdbQ06c/wt7SrZl86mumM
         +c2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679081181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDoP7wMOn5QpwBzbN9iej+FeZ8kKaqhVDSnQkP9mPKA=;
        b=JQmaZzhLcV9IdxIPICMzWI7R6ZxiMhSbbb3f7Sx4No2z/5lvhXhK5NXifo5cYUsAth
         qIwyVZRhcz1inWjdLBjx+k3u7bw5nvokul3t98OWaYedMd6tBGPacS1Dbr6FPxz0n3eC
         MtKbus4q6JWAn3rsl4RhPcwQaB52pyAYbG18mHvBx1+L3I+MxpbPhyQDOVHLjyNFTUW+
         2KZP63cADXdWRMjvT/yQCqjX9JP+gpyXNbV6ejg/BV+A9V3INCBB6qb3ovdOHLlKsRSl
         5GGwIDPF6elMGgPLVJxqA8kFnQzGIxYnKbeTGyc7eWb5nKZPb+rYT1qnXqmr/yqz+ZRh
         HAGg==
X-Gm-Message-State: AO0yUKVPAUc3wwpFacuSRafLFfOLaCmrD9eJqGFAfp+paE7usmufofX3
        zvkUaqYzrUALLk+DPCxEsMLKvySyB9IYSelaXQdQBw==
X-Google-Smtp-Source: AK7set+myjiUnKVO61LEZiJcudJZOJn6IXxmmQI8lH+wNR24WEkoog27XzLkn1lq3skZj5f0wOGKIvBdFCYchYFCzTo=
X-Received: by 2002:a81:1904:0:b0:542:927b:1c79 with SMTP id
 4-20020a811904000000b00542927b1c79mr2742027ywz.3.1679081180481; Fri, 17 Mar
 2023 12:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-23-rick.p.edgecombe@intel.com> <CAKC1njQ+resjS-O8vAVLhRfLHEdgta09faEr5zwi1JTNSWK0Fw@mail.gmail.com>
 <236ae66c-fafb-80e9-d58b-6b18a22071c1@intel.com> <CAKC1njR6WEuXbghupaX6R8LPSVP69yofYNb5+tEp5huHvsroCw@mail.gmail.com>
 <e9a302a41d68c4886d8d1989438d92eb2a89b922.camel@intel.com>
In-Reply-To: <e9a302a41d68c4886d8d1989438d92eb2a89b922.camel@intel.com>
From:   Deepak Gupta <debug@rivosinc.com>
Date:   Fri, 17 Mar 2023 12:26:08 -0700
Message-ID: <CAKC1njQL8zNHh35wbpQ71ncqOTdm-L9+sbp9aDmUOHRcqV+Z6A@mail.gmail.com>
Subject: Re: [PATCH v7 22/41] mm/mmap: Add shadow stack pages to memory accounting
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        "david@redhat.com" <david@redhat.com>,
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
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 17, 2023 at 10:42=E2=80=AFAM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Fri, 2023-03-17 at 10:28 -0700, Deepak Gupta wrote:
> > On Fri, Mar 17, 2023 at 10:16=E2=80=AFAM Dave Hansen <dave.hansen@intel=
.com>
> > wrote:
> > >
> > > On 3/17/23 10:12, Deepak Gupta wrote:
> > > > >   /*
> > > > > - * Stack area - automatically grows in one direction
> > > > > + * Stack area
> > > > >    *
> > > > > - * VM_GROWSUP / VM_GROWSDOWN VMAs are always private
> > > > > anonymous:
> > > > > - * do_mmap() forbids all other combinations.
> > > > > + * VM_GROWSUP, VM_GROWSDOWN VMAs are always private
> > > > > + * anonymous. do_mmap() forbids all other combinations.
> > > > >    */
> > > > >   static inline bool is_stack_mapping(vm_flags_t flags)
> > > > >   {
> > > > > -       return (flags & VM_STACK) =3D=3D VM_STACK;
> > > > > +       return ((flags & VM_STACK) =3D=3D VM_STACK) || (flags &
> > > > > VM_SHADOW_STACK);
> > > >
> > > > Same comment here. `VM_SHADOW_STACK` is an x86 specific way of
> > > > encoding a shadow stack.
> > > > Instead let's have a proxy here which allows architectures to
> > > > have
> > > > their own encodings to represent a shadow stack.
> > >
> > > This doesn't _preclude_ another architecture from coming along and
> > > doing
> > > that, right?  I'd just prefer that shadow stack architecture #2
> > > comes
> > > along and refactors this in precisely the way _they_ need it.
> >
> > There are two issues here
> >  - Encoding of shadow stack: Another arch can choose different
> > encoding.
> >    And yes, another architecture can come in and re-factor it. But so
> > much thought and work has been given to x86 implementation to keep
> >    shadow stack to not impact arch agnostic parts of the kernel. So
> > why creep it in here.
> >
> > - VM_SHADOW_STACK is coming out of the VM_HIGH_ARCH_XX bit position
> > which makes it arch specific.
> >
> >
>
> VM_SHADOW_STACK is defined like this (trimmed for clarity):
> #ifdef CONFIG_X86_USER_SHADOW_STACK
> # define VM_SHADOW_STACK        VM_HIGH_ARCH_5
> #else
> # define VM_SHADOW_STACK        VM_NONE
> #endif

Ok.

>
> Also, we actually had an is_shadow_stack_mapping(vma) in the past, but
> it was dropped from other feedback.

looks like I've been late to the party.
IMHO, that was the right approach.

>
>
