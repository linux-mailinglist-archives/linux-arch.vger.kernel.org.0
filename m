Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7051E620174
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 22:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbiKGVsf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 16:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbiKGVsf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 16:48:35 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FFC2BED;
        Mon,  7 Nov 2022 13:48:33 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-13be3ef361dso14205120fac.12;
        Mon, 07 Nov 2022 13:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I46IWU9HY2ruNBy3JjstNCm87DjtFShdlj2dycepamI=;
        b=nIrkWr7jjloh2uAuMz/dJfFAvESxMqswgPNAj0cN4PvnsyXfOEXPIdW/w5XRUtyZ66
         GjRfZC3xVTE2hbJgF9HhnefWJEszLzFdHatbVc9B1lSPCARmDDtOOU9SHFA52ARys0N3
         1iaF5k+52u242vUyC3Jn9HQOhamLi/eQefNj7WTUXetZ6Lve4u/fi1i0QDMFvXCy1/Ny
         B20x1p0+zxjxBZZekosoTISB/iiY+N1v/XXbZS62ZdQzrKkgvP/gz7wka6dhbuQhUJ4O
         8ETkbJWYpk5hFp11MZOS2xG4Ste+XOc1YOCpZdB09ytSr37Nwd/NPlVdS3B3uELQN3eR
         UfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I46IWU9HY2ruNBy3JjstNCm87DjtFShdlj2dycepamI=;
        b=IilGekM+0/HGVUdxXESja8LvdsVJzeYNykVQmr350S351fr5OHbeRsRIVf4IEu9E4P
         VGCwn5VWz0n9SxxNA7HUVQ5reuU3PzsdDiMoeRdR+9WN8kRb/65V1Wi//XsvC8qOqJ0O
         mLv8vgF7B/RKNK4WrrksavXRHOrnoMszECN2aAADb7moBHbjHUPVrN+MuQThaps3G8QY
         qnsUTPiDUkQ6aXdhF8NnIQaLGg0TfKEy65tNp27ubRXN1/Dk/Dy6aZf5goZiCrbdSZAM
         JTeovmqltWI7iV1WCdC7KJ1YhKH1SszD1ele2lYVhdSNgNW+AsO7a0ai1cp4XxtPrM0r
         UKOA==
X-Gm-Message-State: ACrzQf2xbWSiEcijJkTJ9BOHSUL1bVZlgMRZwCeZoQPG9d83RyJRr9z7
        KL6/R4MGnDJGlAAVZF2OH+WZWJLRQOHfmBvevOo=
X-Google-Smtp-Source: AMsMyM4gNGsRmPP0akudxVGkG68/crhXiv8O0loidyj+0lxizRpWSxU58sjRDG5uC8rpYM5nRMtUJ/WUywt+8i5cjHc=
X-Received: by 2002:a05:6870:f5a4:b0:136:3e0d:acdd with SMTP id
 eh36-20020a056870f5a400b001363e0dacddmr33027556oab.298.1667857712559; Mon, 07
 Nov 2022 13:48:32 -0800 (PST)
MIME-Version: 1.0
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
 <20221104223604.29615-38-rick.p.edgecombe@intel.com> <CAMe9rOpfSccXVWmgK6E0Y0DXC=VX3PpdxXookN1Ty8soeAxrKw@mail.gmail.com>
 <87iljs4ecp.fsf@oldenburg.str.redhat.com> <ca106fe1b5005f54525e7a644684108f6a823e14.camel@intel.com>
 <87h6zaiu05.fsf@oldenburg.str.redhat.com> <f60f1138813f850d52dd92bc6b3df067c021a197.camel@intel.com>
 <CAMe9rOpVUwCccRb5DAyraEKO48rix+Xfiamfp_Vc_aHhjp7=LQ@mail.gmail.com>
 <73b8f726c424db1af1c10a48e101bf74703a186a.camel@intel.com>
 <CAMe9rOo6+Di5-mdWa6rviZ7zdO3yMgFPeTw-CXxXZNSQc=-8Wg@mail.gmail.com> <31b5284ce7930835b055e4207059e4bea32367be.camel@intel.com>
In-Reply-To: <31b5284ce7930835b055e4207059e4bea32367be.camel@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 7 Nov 2022 13:47:56 -0800
Message-ID: <CAMe9rOr1XpnisqWHh6C6Wi6tUAu5avhbKb_7E7ZpN_eMkktTww@mail.gmail.com>
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

On Mon, Nov 7, 2022 at 1:34 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Mon, 2022-11-07 at 13:21 -0800, H.J. Lu wrote:
> > > > Some applications and libraries are compiled with -fcf-
> > > > protection,
> > > > but
> > > > they manipulate the stack in such a way that they aren't
> > > > compatible
> > > > with the shadow stack.   However, if the build/test setup doesn't
> > > > support
> > > > shadow stack, it is impossible to validate.
> > > >
> > >
> > > When we have everything in place, the problems would be much more
> > > obvious when distros started turning it on. But we can't turn it on
> > > as
> >
> > Not necessarily.  The problem will show up only in a CET enabled
> > environment since build/test setup may not be on a CET capable
> > hardware.
>
> Well, I'm not sure of the details of distro testing, but there are
> plenty of TGL and later systems out there today. With kernel support,
> I'm thinking these types of problems couldn't lurk for years like they
> have.

If this is the case, we would have nothing to worry about since the CET
enabled applications won't pass validation if they aren't CET compatible.

> >
> > > planned without breaking things for existing binaries. We can have
> > > both
> > > by:
> > > 1. Choosing a new bit, adding it to the tools, and never supporting
> > > the
> > > old bit in glibc.
> > > 2. Providing the option to have the kernel block the old bit, so
> > > upgraded users can decide what experience they would like. Then
> > > distros
> > > can find the problems and adjust their packages. I'm starting to
> > > think
> > > a default off sysctl toggle might be better than a Kconfig.
> > > 3. Any other ideas?
> >
> > Don't enable CET in glibc until we can validate CET functionality.
>
> Can you elaborate on what you mean by this? Not upstream glibc CET
> support? Or have users not enable it? If the latter, how would they
> know about all these problems.

The current glibc doesn't support CET.  To enable CET in an application,
one should validate it together with the CET enabled glibc under the CET
enabled kernel on a CET capable machine.

>
> And what is wrong with the cleanest option, number 1? The ABI document
> can be updated.

It doesn't help resolve any issues.

-- 
H.J.
