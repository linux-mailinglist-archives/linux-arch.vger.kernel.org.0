Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95676A9DFA
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 18:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjCCRvF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 12:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjCCRu6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 12:50:58 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B93584B5;
        Fri,  3 Mar 2023 09:50:56 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id x199so2718164ybg.5;
        Fri, 03 Mar 2023 09:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677865856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCxddsYYw42LPM43/gkvlie96kmGO3FZ4G2subvXzzU=;
        b=fLGfl9d8hRxr0PWmqstZFZdpj03Y2a8vI1Icd/J+Yunnnd+mcFIXz4wtbdN2hYiGDW
         Rk9i60Tw2atvr6IPg1o9J5DPzTbj9nTvca4ZdGzL1gYVxPInrg8c4jDE9op7uuGh+IlO
         jeVW1ToKEMQcEYzghwsERQBGIXU6nh967eMtdK2JLknjEUztLiCki8FL+nAKYB2xSfBQ
         ArmboZy9wzMMEtZZnmAFVGm4dRwkqAYcGr6cjy970dTApX6TUtnZ0crw1Ir2Mkls9MTj
         bdGkPQEaM/mTDmV8YuPKvm3rxa+szH6OSsJoJIuWXepkkb1OwmTQ33pJPk3QDexijb8t
         1zSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677865856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCxddsYYw42LPM43/gkvlie96kmGO3FZ4G2subvXzzU=;
        b=Af9VpsovLTCM1AXEubDIMs3AcAcM6uREF+xvuZlUlGItFE4nb1k015NnoLQDNrxitC
         Si1n7pZWcA6e3Sc2uaxvtznLDxlgC/W5dxDiewBLumlen6n4O18b2O1p49f71QO3vMkn
         aCFyqUfJg6RKPgAJ+6IaYCV0Pm//VoAwPRdlLWqbf5bQRFJiJJF246fW1XhEXCWhWsHD
         k/0wUtj5IMuBgabrZbD15ytf72nCgX5MtD4AleoVGZMXVzQpOk0Ou1IIdxKdEnX0Wwuv
         +WXoP5vv9X0/KO1DHETb01T3IRiFTfOYhqNguzAe21lNO+S7m1EVPNuzhXh1FAGvAOGN
         2LBw==
X-Gm-Message-State: AO0yUKX0/Ic1h1EFqIM19fBy2gTyaERJlqiQZGYD55I6xgF+YEMmYNyj
        FUKJfbfu3YHryL022jC2JEljuhvJj7tS3KA6rfA=
X-Google-Smtp-Source: AK7set+guTb0nl3oPFuy1k9LGVkybiSalecoyAl7DJSMWvDgkBFGD40v5vxH/Y40U99lEPgcKmDYhBduebnPL+CBxBw=
X-Received: by 2002:a5b:38a:0:b0:ac9:cb97:bd0e with SMTP id
 k10-20020a5b038a000000b00ac9cb97bd0emr1212723ybp.5.1677865855710; Fri, 03 Mar
 2023 09:50:55 -0800 (PST)
MIME-Version: 1.0
References: <Y/9fdYQ8Cd0GI+8C@arm.com> <636de4a28a42a082f182e940fbd8e63ea23895cc.camel@intel.com>
 <ZADLZJI1W1PCJf5t@arm.com> <8153f5d15ec6aa4a221fb945e16d315068bd06e4.camel@intel.com>
 <ZAIgrXQ4670gxlE4@arm.com> <CAMe9rOrM=HXBY25rYrjLnHzSvHFuui06qRpc4xufxeaaGW-Fmw@mail.gmail.com>
 <ZAIwuvfPqNW/w3yt@arm.com>
In-Reply-To: <ZAIwuvfPqNW/w3yt@arm.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Fri, 3 Mar 2023 09:50:19 -0800
Message-ID: <CAMe9rOpvUVfhESeM457m2a9EotUEEAma67ivv5pmhrWmcxexDw@mail.gmail.com>
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

On Fri, Mar 3, 2023 at 9:40=E2=80=AFAM szabolcs.nagy@arm.com
<szabolcs.nagy@arm.com> wrote:
>
> The 03/03/2023 08:57, H.J. Lu wrote:
> > On Fri, Mar 3, 2023 at 8:31=E2=80=AFAM szabolcs.nagy@arm.com
> > <szabolcs.nagy@arm.com> wrote:
> > > longjmp to different stack should work: it can do the same as
> > > setcontext/swapcontext: scan for the pivot token. then only
> > > longjmp out of alt shadow stack fails. (this is non-conforming
> > > longjmp use, but e.g. qemu relies on it.)
> >
> > Restore token may not be used with longjmp.  Unlike setcontext/swapcont=
ext,
> > longjmp is optional.  If longjmp isn't called, there will be an extra
> > token on shadow
> > stack and RET will fail.
>
> what do you mean longjmp is optional?

In some cases, longjmp is called to handle an error condition and
longjmp won't be called if there is no error.

> it can scan the target shadow stack and decide if it's the
> same as the current one or not and in the latter case there
> should be a restore token to switch to. then it can INCSSP
> to reach the target SSP state.
>
> qemu does setjmp, then swapcontext, then longjmp back.
> swapcontext can change the stack, but leaves a token behind
> so longjmp can switch back.

This needs changes to support shadow stack.  Replacing setjmp with
getcontext and longjmp with setcontext may work for shadow stack.

BTW, there is no testcase in glibc for this usage.

--=20
H.J.
