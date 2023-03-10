Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EB46B521A
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 21:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjCJUoF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Mar 2023 15:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjCJUoE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Mar 2023 15:44:04 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AA8D1ACE;
        Fri, 10 Mar 2023 12:44:02 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-536af432ee5so121391327b3.0;
        Fri, 10 Mar 2023 12:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678481042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MiHyK6eFcFQYW0X9EQJHwCgulOPguYCYeXhog8HuzIs=;
        b=bWhKR3NGDtXleP47GUljwpGUd0ZL772CbqQX5a8h1Cb2+VINP3RxlrjyHM10iAn2O+
         SdnPFx1STjV9IOiCLIpPRReha5ycRwuThEYT5fYenqk3N582y6ngxY8vt9p+vls4hvh0
         qUb+yErHdSwsoFJfneYrQi3pZJ/7whFeV5w6LeldnliyC3Sw+7dVhTb3K/nKSsBLT7MB
         YeH++ImohPUUHeokysg68dANFfa+j6G+I19en6V7gBXDRjLJbQhB8A4W2m18HD3hROIC
         CJR7apmB3nJsFEVSB1hz7oEiYwx4jRbCv+WRKRaDcyh4BOTFARjocbxWPqWT4FmDBl+y
         JiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678481042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MiHyK6eFcFQYW0X9EQJHwCgulOPguYCYeXhog8HuzIs=;
        b=PqaNJ1n9DB17ogoxPxT2ycz6LlScNlvXGwuOiTS8vXfXJhWnnjobFI4irHnZ0ez6B2
         whrsiBbM2MhbMryie5tuTYVSlNQqJIPnsHN1yiSCKVUEK2NhWRRlm5LCXS8VAiRvOPvT
         VLjCP/jX/8pRsxjJcP6eI+1NR6ANblquQDY/lcr25ANqqKm0NxXkyQa0GmIrl2vbMgDs
         l/2uNb1GllXuIuerx01mfNoHzMdiqwDbRww7RQvUbDqrGLOHb2aHz5Z3XVOYGyyQodv5
         JHrDYho8+8Uz1aUdRzC0PI+/y6A+2NJEbBbjD+1vepxLNWFHr9WoSt02GpqkW73KJIvR
         pZpw==
X-Gm-Message-State: AO0yUKWLqSlz06p5ialLxCnYfA3cknj5QPz/xv62LrlLhDupQBIkBfd4
        C77YlBAFqSQzmFZEltF/ytD2jBY81viOpmJStKk=
X-Google-Smtp-Source: AK7set/wnmFzHOkuniTe8FhWVZ1SloaUAzrTpFYzMfVKG6Gf7/z0x1JQCIVDicqLTJnrMPNaqokwAQhpHW8IDezq6Xw=
X-Received: by 2002:a81:ac1a:0:b0:533:cf4e:9a80 with SMTP id
 k26-20020a81ac1a000000b00533cf4e9a80mr16886546ywh.6.1678481042094; Fri, 10
 Mar 2023 12:44:02 -0800 (PST)
MIME-Version: 1.0
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-29-rick.p.edgecombe@intel.com> <ZAhjLAIm91rJ2Lpr@zn.tnic>
 <9e00b2a3d988f7b24d274a108d31f5f0096eeaae.camel@intel.com>
 <20230309125739.GCZAnXw5T1dfzwtqh8@fat_crate.local> <a4dd415ac908450b09b9abbd4421a9132b3c34cc.camel@intel.com>
 <20230309235152.GBZApxGNnXLvkGXCet@fat_crate.local> <e83ee9fc1a6e98cab62b681de7209598394df911.camel@intel.com>
 <CAMe9rOrK2d6+Y_Xb+NUW4i+GWRbX+mGx+mJLwnEAB4hvsQ_eiw@mail.gmail.com>
 <CAMe9rOo990TPY-VDzOgGq7aN1aQUjZaWiXLRC81XTq_xqFUm9w@mail.gmail.com> <f020ce5ba5727dc6e25b6cc158be15e9c2ad0bee.camel@intel.com>
In-Reply-To: <f020ce5ba5727dc6e25b6cc158be15e9c2ad0bee.camel@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Fri, 10 Mar 2023 12:43:26 -0800
Message-ID: <CAMe9rOqSSH06azPmGM4_oLsJO65D5F5UzZoN_GJ3+s842a9mAA@mail.gmail.com>
Subject: Re: [PATCH v7 28/41] x86: Introduce userspace API for shadow stack
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
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

On Fri, Mar 10, 2023 at 12:27 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Fri, 2023-03-10 at 12:00 -0800, H.J. Lu wrote:
> > > > So it does:
> > > > 1. Enable shadow stack
> > > > 2. Call elf libs checking functions
> > > > 3. If all good, lock shadow stack. Else, disable shadow stack.
> > > > 4. Return from elf checking functions and if shstk is enabled,
> > > > don't
> > > > underflow because it was enabled in step 1 and we have return
> > > > addresses
> > > > from 2 on the shadow stack
> > > >
> > > > I'm wondering if this can't be improved in glibc to look like:
> > > > 1. Check elf libs, and record it somewhere
> > > > 2. Wait until just the right spot
> > > > 3. If all good, enable and lock shadow stack.
> > >
> > > I will try it out.
> > >
> >
> > Currently glibc enables shadow stack as early as possible.  There
> > are only a few places where a function call in glibc never returns.
> > We can enable shadow stack just before calling main.   There are
> > quite some code paths without shadow stack protection.   Is this
> > an issue?
>
> Thanks for checking. Hmm, does the loader get attacked?

Not I know of.  But there are user codes from .init_array
and .preinit_array which are executed before main.   In theory,
an attack can happen before main.

-- 
H.J.
