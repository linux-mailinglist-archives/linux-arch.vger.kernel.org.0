Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024F261FE52
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 20:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiKGTLJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 14:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiKGTKy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 14:10:54 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AD426AE5;
        Mon,  7 Nov 2022 11:10:53 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-13c569e5ff5so13789609fac.6;
        Mon, 07 Nov 2022 11:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnSdXKK8m/TJrSRjpKbt+NCWqdZs41kIo7jBijs/TeU=;
        b=dFI57mVeLdLCTF/+XJv4MLgt8AJf00hHj1SZ1TvShHINC1AeiIpsTbJYQD0PpD8f2P
         qyPIVPZbddFysDwm2/vv5n2pw/HvJ/hzgwF/9jBnbTb33IjvkaisUl4ESgfaaVhM2h32
         Xc4sfsZB/Gnhnv2c+FbMk09/2hIVbVRtc357MkZuqAXJ8pPaN5GUAtBSZZe73KZHZ7l0
         k3S9AYKJCFC2jrHqhX1BosNVb2BaF3M89cW7lxDFkyLs9vwkfhKruqHcqNPN9bqteOPQ
         P1IjYbSEGQSwSCkxZD0LwMdigGUJLKm4pSk6NTb/hGht89+/Dv7sBZmtG+w3oN18FErQ
         EoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnSdXKK8m/TJrSRjpKbt+NCWqdZs41kIo7jBijs/TeU=;
        b=4ZJvyvcsHmnWyDXERTQz8C12JJjf8VY1wXSBQHhOZ+3wkqsTYML/YfmSy5MGW378iW
         i0W9A47IJgvCc8e8/wFaQp6t3PPrfmTWGhXCjiwPZDlCovrIuwHeFreZo8g8Jqp9aX2T
         Nll6yqU/VvIfA78s8PQH1lQVCqkReAA2TJGmO86HQrTwIQRfMPMwZMn0l01KAmvIneGH
         RuMBjfrPc+FNqw2iMKikcU6Pv9f51m2AUOIOjYz2gph3ExmZA6+qH5WuDpKYFIqZdINN
         5LaDX3BGkEWoV+je+8yrT5eDTB9LWKU9juphAsu5hE3HcAOjay7tIitdng6483Gz4iIM
         1qXA==
X-Gm-Message-State: ACrzQf1AsG1BuyZZCa2DlOTx0P1dX6YauAqn80r1JRJPP+NNzLttbnNy
        FYkPE99uX5T0YmSLjRwh7ytaGHj1TunG+W9QZLM=
X-Google-Smtp-Source: AMsMyM6GiJyh9IyvmqNZZBHIGsfQJ6ZN9HLdU10rJi8jcabtIPMfsFwGxHxzce8ZZIo8zTZtoeKLCPwKDzdaxWY8cIQ=
X-Received: by 2002:a05:6870:f5a4:b0:136:3e0d:acdd with SMTP id
 eh36-20020a056870f5a400b001363e0dacddmr32579634oab.298.1667848251194; Mon, 07
 Nov 2022 11:10:51 -0800 (PST)
MIME-Version: 1.0
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
 <20221104223604.29615-38-rick.p.edgecombe@intel.com> <CAMe9rOpfSccXVWmgK6E0Y0DXC=VX3PpdxXookN1Ty8soeAxrKw@mail.gmail.com>
 <87iljs4ecp.fsf@oldenburg.str.redhat.com> <ca106fe1b5005f54525e7a644684108f6a823e14.camel@intel.com>
 <87h6zaiu05.fsf@oldenburg.str.redhat.com> <f60f1138813f850d52dd92bc6b3df067c021a197.camel@intel.com>
In-Reply-To: <f60f1138813f850d52dd92bc6b3df067c021a197.camel@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 7 Nov 2022 11:10:14 -0800
Message-ID: <CAMe9rOpVUwCccRb5DAyraEKO48rix+Xfiamfp_Vc_aHhjp7=LQ@mail.gmail.com>
Subject: Re: [RFC 37/37] fs/binfmt_elf: Block old shstk elf bit
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "fweimer@redhat.com" <fweimer@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
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

On Mon, Nov 7, 2022 at 9:47 AM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Mon, 2022-11-07 at 17:55 +0100, Florian Weimer wrote:
> > * Rick P. Edgecombe:
> >
> > > On Sun, 2022-11-06 at 10:33 +0100, Florian Weimer wrote:
> > > > * H. J. Lu:
> > > >
> > > > > This change doesn't make a binary CET compatible.  It just
> > > > > requires
> > > > > that the toolchain must be updated and all binaries have to be
> > > > > recompiled with the new toolchain to enable CET.  It doesn't
> > > > > solve
> > > > > any
> > > > > issue which can't be solved by not updating glibc.
> > > >
> > > > Right, and it doesn't even address the library case (the kernel
> > > > would
> > > > have to hook into mmap for that).  The kernel shouldn't do this.
> > >
> > > Shadow stack shouldn't enable as a result of loading a library, if
> > > that's what you mean.
> >
> > It's the opposite=E2=80=94loading incompatible libraries needs to disab=
le
> > shadow
> > stack (or ideally, not enable it in the first place).
>
> The glibc changes I have been using would not have enabled shadow stack
> in the first place unless the execing binary has the elf bit. So the
> binary would run as if shadow stack was not enabled in the kernel and
> there should be nothing to disable when an incompatible binary is
> loaded. Glibc will have to detect this and act accordingly because not
> all kernels will have shadow stack configured.
>
> >   Technically, I
> > think most incompatible code resides in libraries, so this kernel
> > change
> > achieves nothing besides punishing early implementations of the
> > published-as-finalized x86-64 ABI.
>
> It's under the assumption that not breaking things is more important
> than having shadow stack enabled. So it is not intended as a punishment
> for users at all, rather the opposite.
>
> I'm not sure how much the spec mandates things by the letter of it, but
> in any case things have gone wrong in the real world. I am very open to
> discussion here. I only went this way as a last resort because I didn't
> hear back on the last thread.

Some applications and libraries are compiled with -fcf-protection, but
they manipulate the stack in such a way that they aren't compatible
with the shadow stack.   However, if the build/test setup doesn't support
shadow stack, it is impossible to validate.

--=20
H.J.
