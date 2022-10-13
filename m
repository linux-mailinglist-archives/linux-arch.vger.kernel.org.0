Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D625FE51F
	for <lists+linux-arch@lfdr.de>; Fri, 14 Oct 2022 00:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJMWQY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Oct 2022 18:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJMWQX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Oct 2022 18:16:23 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A496D186D7C;
        Thu, 13 Oct 2022 15:16:21 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id bb5so2639112qtb.11;
        Thu, 13 Oct 2022 15:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B08O5vwoKAJbTDyb43gOoo2mIFVMU55F9hrLLIxw+10=;
        b=VLVRsF2N1UXUWLgAMwUAgkS9Mf7eQVzIjTfbntypnWe6qm9Z3KtDDy39b6vD8jkr5P
         IZE5itc/aOKHJ0oCcd98+bLOAh+Q8M30A1VZfAxrt7zUfyI/B2uj5aSDOWcDgD6us0y2
         Bzv4L7bktYmJ/xs11x6JC1RkS1oxtPS7bOzixFr8Ok6/0+YpH2jYPC8QB4eDuCq63SAD
         L+j4sBpFxMSXyFtooXcBT4Y9FksrAkNo2LPcCvBtPY2qRfUf28ge4FWUH1Oz47nA/SoJ
         S+eDEBNFqEpJhHn0a0VO5j2D90rRMTtkQ+yS9EsDGlkLzYvBNbgfviHXqzbYWPGlzNlN
         npPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B08O5vwoKAJbTDyb43gOoo2mIFVMU55F9hrLLIxw+10=;
        b=NVtPYXPvKexs6nEXqmyXv9rMRSZfGMffRiCtJRwb+dsieZObJMxs67Zz6gRiugj2lm
         HcnQyrrSfwEJIBDkpk76APLEVDSYDUnDuEV1+drVsFspBOgYvBvygt3vMPIwBp/ritL8
         6aSS8G7HwruSYW7mxBF9I7xEOVJW4axJpvI7btqPL4UQXvLKSJo0bCKGWcOBnlwW0CsH
         6/DfzKTli5jq8V2XzuBn5eqb0nV8gIsyo48YMMDEEMMcWlNNQyKEvHuOaZb3FQwmjhiN
         g99ZxSFBy1oK0Ljmaj7yvCVuO57Y5CPz68t3DOFgjX3+IC6Fh5DjdTWoiad78PD+Aavd
         fvCw==
X-Gm-Message-State: ACrzQf2sLqj/09iQgO2ZlDOHKN79+hDowhCcXwsjeYbgJOxvpr/zArH3
        4F4dP6urfBj1h62JE32gl0X975DJOK9L7LFeY5k=
X-Google-Smtp-Source: AMsMyM769HQeJFCDkh2T1f1/le40tAoPrylONceFcsK+2+j6T/7xU/RnZ3TRzR+Xcg+PeuGRCvx3ugsugve0JzdB/Ks=
X-Received: by 2002:ac8:6794:0:b0:39c:d44e:3682 with SMTP id
 b20-20020ac86794000000b0039cd44e3682mr1809700qtp.437.1665699380716; Thu, 13
 Oct 2022 15:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-2-rick.p.edgecombe@intel.com> <87ilkr27nv.fsf@oldenburg.str.redhat.com>
 <62481017bc02b35587dd520ed446a011641aa390.camel@intel.com>
 <87v8opz0me.fsf@oldenburg.str.redhat.com> <cc1838888e9da64415331e6f7d83965b553daae7.camel@intel.com>
In-Reply-To: <cc1838888e9da64415331e6f7d83965b553daae7.camel@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 13 Oct 2022 15:15:44 -0700
Message-ID: <CAMe9rOo5LkmCRhkWQW5FMCrs2VtCuw8mWdppyx_3K2hshTqJQA@mail.gmail.com>
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
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
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

On Thu, Oct 13, 2022 at 2:28 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Wed, 2022-10-12 at 14:29 +0200, Florian Weimer wrote:
> > The ABI was finalized around four years ago, and we have shipped
> > several
> > Fedora and Red Hat Enterprise Linux versions with it.  Other
> > distributions did as well.  It's a bit late to make changes now, and
> > certainly not for such trivialities.  In the case of the IBT ABI, it
> > may
> > be tempting to start over in a less trivial way, to radically reduce
> > the
> > amount of ENDBR instructions.  But that doesn't concern SHSTK, and
> > there's no actual implementation anyway.
> >
> > But as H.J. implied, you would have to do rather nasty things in the
> > kernel to prevent us from achieving ABI compatibility in userspace,
> > like
> > parsing property notes on the main executable and disabling the new
> > arch_prctl calls if you see something there that you don't like. 8-)
> > Of course no one is going to implement that.
> >
> > (We are fine with swapping out glibc and its dynamic loader to enable
> > CET with the appropriate kernel mechanism, but we wouldn't want to
> > change the way all other binaries are marked up.)
>
> So we have these compatibility issues with existing binaries. We know
> some apps are totally broken. It sounds like you are proposing to
> ignore this and let people who hit the issues work through it
> themselves. This was also proposed by other glibc developers as a
> solution for past CET compatibility issues that broke boot on kernel
> upgrade. I have to say, as the person pushing these patches, I=E2=80=99m
> uncomfortable with this approach. I don=E2=80=99t think users will like t=
he
> results. Basically, do they want to upgrade and run a bunch of untested
> integration with known failures? I also don=E2=80=99t want to get this fe=
ature
> reverted and I=E2=80=99m not exactly sure how this scenario would be take=
n.
>
> But I hear the point about it not being ideal to abandon the existing
> CET userspace. I think there is also a point about how userspace chose
> to do this optimistic and early wide enabling, even if it was a bad
> idea, and so how much should the kernel try to save userspace from
> itself. So what do you think about this instead:
>
> The current psABI spec talks about the binary being compatible with
> shadow stack. It doesn=E2=80=99t say much about what should happen after =
the
> loader. Since the greater ecosystem has used this bit with a more
> cavalier attitude, glibc could treat it as a request for a warn and
> continue mode. In the meantime we could have a new bit shstk_strict,
> that requests behavior like these patches implement, and kills the
> process on violation. Glibc/tools could add support for this strict bit
> and anyone that wants to more carefully compile with it could finally
> get shadow stack today. Then the implementation of the warn and
> continue mode could follow that, and glibc could map the original shstk
> bit to that kernel mode. So the old binaries would get there
> eventually, which is better than the continuing nothing they have
> today.
>
> And speaking of having nothing today, there are people that really want
> to use shadow stack and do not care at all about having CET support for
> existing binaries. Neither glibc or elf bits are required to use kernel
> shadow stack support. So if it comes to it, I don=E2=80=99t want to hold
> support back for other users because the elf note bit enabling path
> grew some issues.
>
> Please let me know about what you think of that plan.

The kernel CET description

+The kernel does not process these applications directly. Applications must
+enable them using the interface descriped in section 4. Typically this
+would be done in dynamic loader or static runtime objects, as is the case
+in glibc.

may leave an impression that each application needs to use the kernel
interface to enable CET itself.  This is an option.  But the updated glibc
will enable CET automatically on behalf of the CET enabled application.
If the glibc isn't updated to use the new CET kernel interface, the existin=
g
CET enabled binaries will run correctly under the new CET enabled
kernel without CET enabled.

--=20
H.J.
