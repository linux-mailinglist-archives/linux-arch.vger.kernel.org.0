Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8508C620102
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 22:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbiKGVW7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 16:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbiKGVWm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 16:22:42 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF726102F;
        Mon,  7 Nov 2022 13:22:26 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-13b103a3e5dso14187609fac.2;
        Mon, 07 Nov 2022 13:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2p+o/wwFzaQT3YrtLLy11P/EQH0km3heDCq7YaIDuHE=;
        b=Kjm0WJEazxNniutHxpP/iWzp30/ucmFoXjNcrqKBpDby8wMAHcWjC5s4iDf2e1EXPU
         9xz7D01nAcLCLqWCrR1zC2fFZzsjL+V0hbcDxyZ2MGgrOk0zHpKczXOloTnlEEv1deLg
         kB2xq9pVDzuFnsL69XzNC291l8iCoDoWbczQBS06d5MwKJP/7YjEoJEO/T4+gMdf6CU7
         xOvRZApZvcxriK3UXAqxM81rho6C1vJkQy2v8jpIkMH8ly0JVq0kwdaaCwCucT9zVfEZ
         2kDlegWL+kb1CarsoXje0G8gr736QSdt52a9sQSckDoMLfEAOO7/z3AB7Sc35g+EAExm
         Y6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2p+o/wwFzaQT3YrtLLy11P/EQH0km3heDCq7YaIDuHE=;
        b=JiZDxAcWe0Q2eeQsgTX1ZwTMI5T7E1gXfRQ6bUCdXywOkZqEpByyCEwKoSwWp4b7Ry
         OstV9f6BhKiNKNyNfsClkULXBPGwWQA3EeygJ6hMrB8Ixdh7eZ7CbgJF7rkli/3VeGo/
         eQC8Hn0I/t50fFerYDngTDCecZyrD63DEClm/eMUMSTul0k8T3zMg0q83k6oeWf5knly
         yWilHFf/vQRiF7keb2W1UiefxgLFo1zGt/aTMAtZ27Gzk34Rfg0RUVLs/eppYMlvEJty
         mID6WBBoJliUauKPXjyT5DKA6nuhEETn/Q7ZtTdHkE7n78JN/LGaoLxmmtPej0r3iUIN
         TcwQ==
X-Gm-Message-State: ACrzQf30As744iKtds4e89jP6IGZQ03xOMdMh8EE/hHy04w93t4T/2NK
        3bP579MyRqn7fErZbJVe1sWlUH6rFwlULrX/I04=
X-Google-Smtp-Source: AMsMyM7zGoN0Xryx43RidskikH9G5CbyEmhHknjTpRv8ZR4Apq2ZIY5phqK71MLR9QxFCFZE96w1rWasCLWHB4wGK/8=
X-Received: by 2002:a05:6870:f5a4:b0:136:3e0d:acdd with SMTP id
 eh36-20020a056870f5a400b001363e0dacddmr32962986oab.298.1667856145978; Mon, 07
 Nov 2022 13:22:25 -0800 (PST)
MIME-Version: 1.0
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
 <20221104223604.29615-38-rick.p.edgecombe@intel.com> <CAMe9rOpfSccXVWmgK6E0Y0DXC=VX3PpdxXookN1Ty8soeAxrKw@mail.gmail.com>
 <87iljs4ecp.fsf@oldenburg.str.redhat.com> <ca106fe1b5005f54525e7a644684108f6a823e14.camel@intel.com>
 <87h6zaiu05.fsf@oldenburg.str.redhat.com> <f60f1138813f850d52dd92bc6b3df067c021a197.camel@intel.com>
 <CAMe9rOpVUwCccRb5DAyraEKO48rix+Xfiamfp_Vc_aHhjp7=LQ@mail.gmail.com> <73b8f726c424db1af1c10a48e101bf74703a186a.camel@intel.com>
In-Reply-To: <73b8f726c424db1af1c10a48e101bf74703a186a.camel@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 7 Nov 2022 13:21:49 -0800
Message-ID: <CAMe9rOo6+Di5-mdWa6rviZ7zdO3yMgFPeTw-CXxXZNSQc=-8Wg@mail.gmail.com>
Subject: Re: [RFC 37/37] fs/binfmt_elf: Block old shstk elf bit
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
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

On Mon, Nov 7, 2022 at 1:11 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Mon, 2022-11-07 at 11:10 -0800, H.J. Lu wrote:
> > On Mon, Nov 7, 2022 at 9:47 AM Edgecombe, Rick P
> > <rick.p.edgecombe@intel.com> wrote:
> > >
> > > On Mon, 2022-11-07 at 17:55 +0100, Florian Weimer wrote:
> > > > * Rick P. Edgecombe:
> > > >
> > > > > On Sun, 2022-11-06 at 10:33 +0100, Florian Weimer wrote:
> > > > > > * H. J. Lu:
> > > > > >
> > > > > > > This change doesn't make a binary CET compatible.  It just
> > > > > > > requires
> > > > > > > that the toolchain must be updated and all binaries have to
> > > > > > > be
> > > > > > > recompiled with the new toolchain to enable CET.  It
> > > > > > > doesn't
> > > > > > > solve
> > > > > > > any
> > > > > > > issue which can't be solved by not updating glibc.
> > > > > >
> > > > > > Right, and it doesn't even address the library case (the
> > > > > > kernel
> > > > > > would
> > > > > > have to hook into mmap for that).  The kernel shouldn't do
> > > > > > this.
> > > > >
> > > > > Shadow stack shouldn't enable as a result of loading a library,
> > > > > if
> > > > > that's what you mean.
> > > >
> > > > It's the opposite=E2=80=94loading incompatible libraries needs to d=
isable
> > > > shadow
> > > > stack (or ideally, not enable it in the first place).
> > >
> > > The glibc changes I have been using would not have enabled shadow
> > > stack
> > > in the first place unless the execing binary has the elf bit. So
> > > the
> > > binary would run as if shadow stack was not enabled in the kernel
> > > and
> > > there should be nothing to disable when an incompatible binary is
> > > loaded. Glibc will have to detect this and act accordingly because
> > > not
> > > all kernels will have shadow stack configured.
> > >
> > > >   Technically, I
> > > > think most incompatible code resides in libraries, so this kernel
> > > > change
> > > > achieves nothing besides punishing early implementations of the
> > > > published-as-finalized x86-64 ABI.
> > >
> > > It's under the assumption that not breaking things is more
> > > important
> > > than having shadow stack enabled. So it is not intended as a
> > > punishment
> > > for users at all, rather the opposite.
> > >
> > > I'm not sure how much the spec mandates things by the letter of it,
> > > but
> > > in any case things have gone wrong in the real world. I am very
> > > open to
> > > discussion here. I only went this way as a last resort because I
> > > didn't
> > > hear back on the last thread.
> >
> > Some applications and libraries are compiled with -fcf-protection,
> > but
> > they manipulate the stack in such a way that they aren't compatible
> > with the shadow stack.   However, if the build/test setup doesn't
> > support
> > shadow stack, it is impossible to validate.
> >
>
> When we have everything in place, the problems would be much more
> obvious when distros started turning it on. But we can't turn it on as

Not necessarily.  The problem will show up only in a CET enabled
environment since build/test setup may not be on a CET capable
hardware.

> planned without breaking things for existing binaries. We can have both
> by:
> 1. Choosing a new bit, adding it to the tools, and never supporting the
> old bit in glibc.
> 2. Providing the option to have the kernel block the old bit, so
> upgraded users can decide what experience they would like. Then distros
> can find the problems and adjust their packages. I'm starting to think
> a default off sysctl toggle might be better than a Kconfig.
> 3. Any other ideas?

Don't enable CET in glibc until we can validate CET functionality.

--=20
H.J.
