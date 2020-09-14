Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A362694E3
	for <lists+linux-arch@lfdr.de>; Mon, 14 Sep 2020 20:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgINSbT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Sep 2020 14:31:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgINSbQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Sep 2020 14:31:16 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 924EA221E5
        for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2020 18:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600108274;
        bh=TWMzqZoZNralDEd5I14l94VOUCKWS0bUz/b6Q4OWmsg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D4P7AEngB+S1f31yQcalYo1zCNFyveknGKD9Hj70JfD4ABuAiXlotcEedmXFm7ic5
         hyF+FdjUZ/Pv8vmvFKWoUUv8UKd7aD5CEBujLlrbWQz6oxj49Y/+V5ZJ8vRVNdjlUU
         Hf9ohxCwkyBAIRMBxwyvi8S9wNjMHJEHhe3JffZo=
Received: by mail-wr1-f46.google.com with SMTP id e16so720309wrm.2
        for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2020 11:31:14 -0700 (PDT)
X-Gm-Message-State: AOAM531BgJQtrHJUU/6O7APZrA6nE9gv/nLUthkk5A/8r62UG4uR4XJU
        jdCepfPojPPqzVxxAthF19SXFheXfgGUzWaBOpM7Sg==
X-Google-Smtp-Source: ABdhPJzMOb3y0FnJul9OcJh57QbJ0oJTgC7Zp8nhwEEKBKBm7cEIBddAZgePqa+NXgC52VXRnjm9D5o/WjTt/jkVxNo=
X-Received: by 2002:a5d:5111:: with SMTP id s17mr17179124wrt.70.1600108272961;
 Mon, 14 Sep 2020 11:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
 <CALCETrVeNA0Kt2rW0CRCVo1JE0CKaBxu9KrJiyqUA8LPraY=7g@mail.gmail.com>
 <0e9996bc-4c1b-cc99-9616-c721b546f857@intel.com> <4f2dfefc-b55e-bf73-f254-7d95f9c67e5c@intel.com>
 <CAMe9rOqt9kbqERC8U1+K-LiDyNYuuuz3TX++DChrRJwr5ajt6Q@mail.gmail.com>
 <20200901102758.GY6642@arm.com> <c91bbad8-9e45-724b-4526-fe3674310c57@intel.com>
 <CALCETrWJQgtO_tP1pEaDYYsFgkZ=fOxhyTRE50THcxYoHyTTwg@mail.gmail.com>
 <32005d57-e51a-7c7f-4e86-612c2ff067f3@intel.com> <46dffdfd-92f8-0f05-6164-945f217b0958@intel.com>
 <ed929729-4677-3d3b-6bfd-b379af9272b8@intel.com> <6e1e22a5-1b7f-2783-351e-c8ed2d4893b8@intel.com>
 <5979c58d-a6e3-d14d-df92-72cdeb97298d@intel.com> <ab1a3344-60f4-9b9d-81d4-e6538fdcafcf@intel.com>
 <08c91835-8486-9da5-a7d1-75e716fc5d36@intel.com> <a881837d-c844-30e8-a614-8b92be814ef6@intel.com>
 <cbec8861-8722-ec31-2c02-1cfed20255eb@intel.com> <b3379d26-d8a7-deb7-59f1-c994bb297dcb@intel.com>
 <a1efc4330a3beff10671949eddbba96f8cde96da.camel@intel.com> <41aa5e8f-ad88-2934-6d10-6a78fcbe019b@intel.com>
In-Reply-To: <41aa5e8f-ad88-2934-6d10-6a78fcbe019b@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 14 Sep 2020 11:31:01 -0700
X-Gmail-Original-Message-ID: <CALCETrX5qJAZBe9sHL6+HFvre-bbo+us1==q9KHNCyRrzaUsjw@mail.gmail.com>
Message-ID: <CALCETrX5qJAZBe9sHL6+HFvre-bbo+us1==q9KHNCyRrzaUsjw@mail.gmail.com>
Subject: Re: [NEEDS-REVIEW] Re: [PATCH v11 25/25] x86/cet/shstk: Add
 arch_prctl functions for shadow stack
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Florian Weimer <fweimer@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> On Sep 14, 2020, at 7:50 AM, Dave Hansen <dave.hansen@intel.com> wrote:
>
> =EF=BB=BFOn 9/11/20 3:59 PM, Yu-cheng Yu wrote:
> ...
>> Here are the changes if we take the mprotect(PROT_SHSTK) approach.
>> Any comments/suggestions?
>
> I still don't like it. :)
>
> I'll also be much happier when there's a proper changelog to accompany
> this which also spells out the alternatives any why they suck so much.
>

Let=E2=80=99s take a step back here. Ignoring the precise API, what exactly=
 is
a shadow stack from the perspective of a Linux user program?

The simplest answer is that it=E2=80=99s just memory that happens to have
certain protections.  This enables all kinds of shenanigans.  A
program could map a memfd twice, once as shadow stack and once as
non-shadow-stack, and change its control flow.  Similarly, a program
could mprotect its shadow stack, modify it, and mprotect it back.  In
some threat models, though could be seen as a WRSS bypass.  (Although
if an attacker can coerce a process to call mprotect(), the game is
likely mostly over anyway.)

But we could be more restrictive, or perhaps we could allow user code
to opt into more restrictions.  For example, we could have shadow
stacks be special memory that cannot be written from usermode by any
means other than ptrace() and friends, WRSS, and actual shadow stack
usage.

What is the goal?

No matter what we do, the effects of calling vfork() are going to be a
bit odd with SHSTK enabled.  I suppose we could disallow this, but
that seems likely to cause its own issues.
