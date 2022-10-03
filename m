Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798AB5F3475
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 19:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiJCR0N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 13:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJCRZp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 13:25:45 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4982B38A35
        for <linux-arch@vger.kernel.org>; Mon,  3 Oct 2022 10:25:41 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id y189so6781525iof.5
        for <linux-arch@vger.kernel.org>; Mon, 03 Oct 2022 10:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=aXZU5Aj6YsvWXsitBdXXflaJiNNG45fO0UR9crXv66M=;
        b=JDD6RdGS1X/0oc37WFA58H5j2nrAKksFyEOlTgYZcvKnTWUVhQ1SQnNoUiLrd+KrnV
         8lq7ZTFxk7M6lh86aQ9Cz24Xs0rdnUApg2fMCQ9K2hoztWXNkN4uw31zvPVr5sUg2Tbk
         ZL7qWFsWfAn+wHbzMAzdfg3eBpQSbiwqnUFUFipjelqARDYVUUCI6UdANuCUUgof4xxE
         oY68vV+yG7wrJuJMKlZjTSYCKiLdWnqmh9n9FmjnWbXRTBNsaeci4bign2dCGdVZYSut
         dc1uKbLOPh1yNvNPwSV8aA3ls3Eny5jnkD2cB1fcj+00ZfiD+gaawJw4KPvKqCHKnPdY
         fptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=aXZU5Aj6YsvWXsitBdXXflaJiNNG45fO0UR9crXv66M=;
        b=6P6ivkria1Kv7T7uufeXwPaenES69AxwVIY+6CK2mbtQutXUxdrzOvdmy9Qz+4pRL6
         XKsfLnjvFfcZUkhLvTayOCr2OiH9fcJcC3TR6johIQjcrI7yhZvE+vfJXkEkU4TbkovM
         DfeNotU8n4wbCLH4eobaJti215CIxV27E5+iK1SdTF/rlbrT4ZJg0AYuTV95k8uMcvjg
         8MO01tnHICdOxnhvzJYbgrQSsbmsXfjUwbzY096RXtTuu3mMsO+Zny7nHbHrdYmszZ2P
         FCKxCVSBIZCB0KtgyWQhmHUBj3djCPo98EXlEq/S9/5cW/kghinwxgQ9LMOPqaHK/zNF
         EbNg==
X-Gm-Message-State: ACrzQf0hgIp+YCj8rP7TQq5uuE99zUmE+3H4opNN4JY0Bqom4Bka1asZ
        equkwRvBLbHBADHu9MBbuwLaBYZzin20GPDFEKiSSA==
X-Google-Smtp-Source: AMsMyM7dn7qupZyf60dQ6GkvouHdJ6tsNLLe30VdYZNvyoqYu5T0D69XRGfJ2KOQ5KKXS8VFs9DXyBZ101Q8LQgCdw0=
X-Received: by 2002:a05:6602:2ccd:b0:6a1:c561:50ca with SMTP id
 j13-20020a0566022ccd00b006a1c56150camr9365034iow.154.1664817939741; Mon, 03
 Oct 2022 10:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com> <202210030946.CB90B94C11@keescook>
In-Reply-To: <202210030946.CB90B94C11@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 3 Oct 2022 19:25:03 +0200
Message-ID: <CAG48ez2TGdwcr-jUPm1EL1D6X2a-wbx+gXLZUq46qxO-FTctHQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/39] Shadowstacks for userspace
To:     Kees Cook <keescook@chromium.org>
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
        "H . J . Lu" <hjl.tools@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 3, 2022 at 7:04 PM Kees Cook <keescook@chromium.org> wrote:
> On Thu, Sep 29, 2022 at 03:28:57PM -0700, Rick Edgecombe wrote:
> > This is an overdue followup to the =E2=80=9CShadow stacks for userspace=
=E2=80=9D CET series.
> > Thanks for all the comments on the first version [0]. They drove a dece=
nt
> > amount of changes for v2. Since it has been awhile, I=E2=80=99ll try to=
 summarize the
> > areas that got major changes since last time. Smaller changes are liste=
d in
> > each patch.
>
> Thanks for the write-up!
>
> > [...]
> >         GUP
> >         ---
> >         Shadow stack memory is generally treated as writable by the ker=
nel, but
> >         it behaves differently then other writable memory with respect =
to GUP.
> >         FOLL_WRITE will not GUP shadow stack memory unless FOLL_FORCE i=
s also
> >         set. Shadow stack memory is writable from the perspective of be=
ing
> >         changeable by userspace, but it is also protected memory from
> >         userspace=E2=80=99s perspective. So preventing it from being wr=
itable via
> >         FOLL_WRITE help=E2=80=99s make it harder for userspace to arbit=
rarily write to
> >         it. However, like read-only memory, FOLL_FORCE can still write =
through
> >         it. This means shadow stacks can be written to via things like
> >         =E2=80=9C/proc/self/mem=E2=80=9D. Apps that want extra security=
 will have to prevent
> >         access to kernel features that can write with FOLL_FORCE.
>
> This seems like a problem to me -- the point of SS is that there cannot b=
e
> a way to write to them without specific instruction sequences. The fact
> that /proc/self/mem bypasses memory protections was an old design mistake
> that keeps leading to surprising behaviors. It would be much nicer to
> draw the line somewhere and just say that FOLL_FORCE doesn't work on
> VM_SHADOW_STACK. Why must FOLL_FORCE be allowed to write to SS?

But once you have FOLL_FORCE, you can also just write over stuff like
executable code instead of writing over the stack. I don't think
allowing FOLL_FORCE writes over shadow stacks from /proc/$pid/mem is
making things worse in any way, and it's probably helpful for stuff
like debuggers.

If you don't want /proc/$pid/mem to be able to do stuff like that,
then IMO the way to go is to change when /proc/$pid/mem uses
FOLL_FORCE, or to limit overall write access to /proc/$pid/mem.
