Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A696BEFA7
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 18:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCQR2Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Mar 2023 13:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjCQR2P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Mar 2023 13:28:15 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3729311659
        for <linux-arch@vger.kernel.org>; Fri, 17 Mar 2023 10:28:13 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id e65so6512826ybh.10
        for <linux-arch@vger.kernel.org>; Fri, 17 Mar 2023 10:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1679074092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tgr4FzdJQUvv8sxqD3n2+NEThU5C851YsP5telCNKqc=;
        b=AVJAcOWp//de/0qDhs3JXDyEG3wxRVQTCv1ru1HtbdhiRMIDKdXikzGW3RRw0fucvE
         VlB4zbOpDjPDB3ZElOjSCBckSPk1pFTIop+KtLRwQg6lMvKT5ZKvpMNtyfdKbzQsOhKc
         VDdc3Mm9tfcxn4dUeSa6w+E1LGqCBoha1ACyLYbR8J58ddMQJg+Bz8lEZjTnLAAGcaVN
         GcpTFBtPbde0FVM9WEaKk7OArNKido3Y4beg/x0rykBtwZCx4p5FouxY5j8foPMGD4Db
         BbK2BZB1Mq/I9a/AedKB6pO0RcEa0EQ8G6ApBBOp07MNGZ1ocDykMr8AoSuFPgLOuQKV
         udRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679074092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tgr4FzdJQUvv8sxqD3n2+NEThU5C851YsP5telCNKqc=;
        b=4RNxCaQFTNDfXTbZteb6ymxHrM6p5/Lcqv0bNIAxhVGiyJnYP/sc52zIEDAOaM8+Gd
         A8TdI7HiWAXzzlADwToDuLmKGmqEX0rj/LDKXJ0VgAZeh2dACCLq1p9Gfga/fJHXk986
         O2QcOGaBKVQkkCF1+mamF5Ex2q0IOSfX8bcR0qbBNPTuSAG2DD2hR3xIiHc+ChwptPcy
         a8J6OUJWWQGGrfSW0cKa9TE9ayw/jb+Vcfz4cKcFxSNycHWyTxTIWO1zYiPgf1oazad2
         X9rF3Nk/Hd+8MXXQT2PxqIMHIonYzhgTBiqOQKpIq30T/1aPGnq6KM+z+hFU00EOgyH7
         Mu6A==
X-Gm-Message-State: AO0yUKUniVfWgOdIu14u9U4/V/a/d1iegreLn7wyrOWh24ZOSc6zX24i
        cTc7w003Tvmq53/qhaYK5IWzz5d4VXqTT7Sc9K8S7Q==
X-Google-Smtp-Source: AK7set/RbsEZazIS5BwsZiaD/X/kDFc2no4aoSIrcxUs6+4E8c1A8bsJPb7czfxiV4RlDZCemGAGqyHD95or4DWx7m8=
X-Received: by 2002:a25:9385:0:b0:b46:c5aa:86ef with SMTP id
 a5-20020a259385000000b00b46c5aa86efmr148517ybm.12.1679074092398; Fri, 17 Mar
 2023 10:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-23-rick.p.edgecombe@intel.com> <CAKC1njQ+resjS-O8vAVLhRfLHEdgta09faEr5zwi1JTNSWK0Fw@mail.gmail.com>
 <236ae66c-fafb-80e9-d58b-6b18a22071c1@intel.com>
In-Reply-To: <236ae66c-fafb-80e9-d58b-6b18a22071c1@intel.com>
From:   Deepak Gupta <debug@rivosinc.com>
Date:   Fri, 17 Mar 2023 10:28:03 -0700
Message-ID: <CAKC1njR6WEuXbghupaX6R8LPSVP69yofYNb5+tEp5huHvsroCw@mail.gmail.com>
Subject: Re: [PATCH v7 22/41] mm/mmap: Add shadow stack pages to memory accounting
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 17, 2023 at 10:16=E2=80=AFAM Dave Hansen <dave.hansen@intel.com=
> wrote:
>
> On 3/17/23 10:12, Deepak Gupta wrote:
> >>  /*
> >> - * Stack area - automatically grows in one direction
> >> + * Stack area
> >>   *
> >> - * VM_GROWSUP / VM_GROWSDOWN VMAs are always private anonymous:
> >> - * do_mmap() forbids all other combinations.
> >> + * VM_GROWSUP, VM_GROWSDOWN VMAs are always private
> >> + * anonymous. do_mmap() forbids all other combinations.
> >>   */
> >>  static inline bool is_stack_mapping(vm_flags_t flags)
> >>  {
> >> -       return (flags & VM_STACK) =3D=3D VM_STACK;
> >> +       return ((flags & VM_STACK) =3D=3D VM_STACK) || (flags & VM_SHA=
DOW_STACK);
> > Same comment here. `VM_SHADOW_STACK` is an x86 specific way of
> > encoding a shadow stack.
> > Instead let's have a proxy here which allows architectures to have
> > their own encodings to represent a shadow stack.
>
> This doesn't _preclude_ another architecture from coming along and doing
> that, right?  I'd just prefer that shadow stack architecture #2 comes
> along and refactors this in precisely the way _they_ need it.

There are two issues here
 - Encoding of shadow stack: Another arch can choose different encoding.
   And yes, another architecture can come in and re-factor it. But so
much thought and work has been given to x86 implementation to keep
   shadow stack to not impact arch agnostic parts of the kernel. So
why creep it in here.

- VM_SHADOW_STACK is coming out of the VM_HIGH_ARCH_XX bit position
which makes it arch specific.

If re-factor takes care then I would say the 2nd issue still exists,
it's better to keep it away from arch agnostic code.
