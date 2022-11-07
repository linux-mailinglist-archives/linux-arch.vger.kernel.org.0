Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA986203F2
	for <lists+linux-arch@lfdr.de>; Tue,  8 Nov 2022 00:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiKGXqU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 18:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbiKGXqO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 18:46:14 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C728B220D6;
        Mon,  7 Nov 2022 15:46:12 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-13bd2aea61bso14598646fac.0;
        Mon, 07 Nov 2022 15:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GZv4VEzTh60ff7rQ3G/lXHbECUZzBVMWsmSC7ny0h2U=;
        b=VjP2xLNvuzSQgD3I3ozjFn7UeaPo9By3BYlMaoCMJk7jmaecIwNEmn+KVxkbozJ7in
         F2T2cyAWTUBqTEppT1Z4uygxuQQqa0BFMXysIOX3ba4Bf4OIog1kUBS5sKaSzp8hJgTQ
         7kmPR4ebc4Nv2rSnS2g7PO8DAcXe0rC/Grjgmv0zZPBqjPAiJyUIyovdGmVnaRD/JH11
         U9WV72vCmRz5dYRVfd2svO3Q8bh7pL9DqQ0WNsX9c6EDzdRPjEH8nw1ljnil5NXImYbn
         ex+rfomJIlLAdipHuqEbJeYk8qUnJNN7RU32EXCJgUd7YpLUYkVAHaqLIGBP1VV9M4J6
         yvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZv4VEzTh60ff7rQ3G/lXHbECUZzBVMWsmSC7ny0h2U=;
        b=FojNV/pKvq6Csn8+W7wDsN4sutI/KZ5bXUAdX+z2yraOnVl4fF7mwNZw3cQkQraFrH
         jgL18qMksvXeHQNRKtb0eICrfR3+hRgASBxU7zvHEfKwqA5ZapDSg+29s+3Gk+X/9brA
         lh0AJcADqcOjwInPcsCg8duKG1gKelZI6HlXHxbhZZ0wFz3Hat1LQLF5qK5AEEDNUiZn
         GwFSV+kXlaCr+QgjsKKqi60jIbbfjLCubazjpKpYa9Xim8v+I07RBmQiII36U/A58Cte
         KKpLnBwGZvQt0HDlMMhyd9xMH8i3byA4OlsxvVk2jvBPO2JJb8GMIpK2jSLbP4fdcgA5
         S1Tw==
X-Gm-Message-State: ACrzQf3WLKXZb0ofALuYq05Is4sMFi3J2KRJsB7YfhHQAFAoDP1fQwWU
        QwwPuWpiGCEdrKjh8RZZPdw6Ud5qoZGNMtEj+Cs=
X-Google-Smtp-Source: AMsMyM5HPQzYIO4bhvVrQ4BX4/oYdqe2G9XJrxXQcHtdlRvqzM3YxSvaL6WZ/k4sAb+Aygi8fxH2APLc7Pk5juNOlOo=
X-Received: by 2002:a05:6870:5781:b0:13b:8bb8:5c5b with SMTP id
 i1-20020a056870578100b0013b8bb85c5bmr664481oap.298.1667864772071; Mon, 07 Nov
 2022 15:46:12 -0800 (PST)
MIME-Version: 1.0
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
 <20221104223604.29615-38-rick.p.edgecombe@intel.com> <CAMe9rOpfSccXVWmgK6E0Y0DXC=VX3PpdxXookN1Ty8soeAxrKw@mail.gmail.com>
 <87iljs4ecp.fsf@oldenburg.str.redhat.com> <ca106fe1b5005f54525e7a644684108f6a823e14.camel@intel.com>
 <87h6zaiu05.fsf@oldenburg.str.redhat.com> <f60f1138813f850d52dd92bc6b3df067c021a197.camel@intel.com>
 <CAMe9rOpVUwCccRb5DAyraEKO48rix+Xfiamfp_Vc_aHhjp7=LQ@mail.gmail.com>
 <73b8f726c424db1af1c10a48e101bf74703a186a.camel@intel.com>
 <CAMe9rOo6+Di5-mdWa6rviZ7zdO3yMgFPeTw-CXxXZNSQc=-8Wg@mail.gmail.com>
 <31b5284ce7930835b055e4207059e4bea32367be.camel@intel.com>
 <CAMe9rOr1XpnisqWHh6C6Wi6tUAu5avhbKb_7E7ZpN_eMkktTww@mail.gmail.com> <2f8fe2ede43909ea3c51ff05f7dae5f63d5ed8c8.camel@intel.com>
In-Reply-To: <2f8fe2ede43909ea3c51ff05f7dae5f63d5ed8c8.camel@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 7 Nov 2022 15:45:35 -0800
Message-ID: <CAMe9rOqULmJLM8O-_z7iZVoE6Ysngvw2UjBSwQ4BDB-+A__tdA@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 7, 2022 at 2:47 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Mon, 2022-11-07 at 13:47 -0800, H.J. Lu wrote:
> > On Mon, Nov 7, 2022 at 1:34 PM Edgecombe, Rick P
> > <rick.p.edgecombe@intel.com> wrote:
> > >
> > > On Mon, 2022-11-07 at 13:21 -0800, H.J. Lu wrote:
> > > > > > Some applications and libraries are compiled with -fcf-
> > > > > > protection,
> > > > > > but
> > > > > > they manipulate the stack in such a way that they aren't
> > > > > > compatible
> > > > > > with the shadow stack.   However, if the build/test setup
> > > > > > doesn't
> > > > > > support
> > > > > > shadow stack, it is impossible to validate.
> > > > > >
> > > > >
> > > > > When we have everything in place, the problems would be much
> > > > > more
> > > > > obvious when distros started turning it on. But we can't turn
> > > > > it on
> > > > > as
> > > >
> > > > Not necessarily.  The problem will show up only in a CET enabled
> > > > environment since build/test setup may not be on a CET capable
> > > > hardware.
> > >
> > > Well, I'm not sure of the details of distro testing, but there are
> > > plenty of TGL and later systems out there today. With kernel
> > > support,
> > > I'm thinking these types of problems couldn't lurk for years like
> > > they
> > > have.
> >
> > If this is the case, we would have nothing to worry about since the
> > CET
> > enabled applications won't pass validation if they aren't CET
> > compatible.
>
> Hmm, I think you couldn't have already forgotten the problem binaries
> are already shipped...

It should be OK since glibc doesn't support CET.

> >
> > > >
> > > > > planned without breaking things for existing binaries. We can
> > > > > have
> > > > > both
> > > > > by:
> > > > > 1. Choosing a new bit, adding it to the tools, and never
> > > > > supporting
> > > > > the
> > > > > old bit in glibc.
> > > > > 2. Providing the option to have the kernel block the old bit,
> > > > > so
> > > > > upgraded users can decide what experience they would like. Then
> > > > > distros
> > > > > can find the problems and adjust their packages. I'm starting
> > > > > to
> > > > > think
> > > > > a default off sysctl toggle might be better than a Kconfig.
> > > > > 3. Any other ideas?
> > > >
> > > > Don't enable CET in glibc until we can validate CET
> > > > functionality.
> > >
> > > Can you elaborate on what you mean by this? Not upstream glibc CET
> > > support? Or have users not enable it? If the latter, how would they
> > > know about all these problems.
> >
> > The current glibc doesn't support CET.  To enable CET in an
> > application,
> > one should validate it together with the CET enabled glibc under the
> > CET
> > enabled kernel on a CET capable machine.
>
> Agreed that this is how it should have gone.
>
> >
> > >
> > > And what is wrong with the cleanest option, number 1? The ABI
> > > document
> > > can be updated.
> >
> > It doesn't help resolve any issues.
>
> Please read the coverletter if you are unsure of what issues this is
> trying to address. I should have put more in the commit log.
>
>
>


-- 
H.J.
