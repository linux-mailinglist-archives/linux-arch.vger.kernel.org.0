Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6194F17EA87
	for <lists+linux-arch@lfdr.de>; Mon,  9 Mar 2020 21:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgCIUyw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Mar 2020 16:54:52 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40088 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgCIUyv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2020 16:54:51 -0400
Received: by mail-ot1-f65.google.com with SMTP id x19so11053927otp.7;
        Mon, 09 Mar 2020 13:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EzETE5yRJO875WktHCogKuD+gLJ9pGXC3SMjRgGh6/s=;
        b=IOHJUtSt4gA2J3tjh8e6nwHGDQlBz5HEn8kCmWFJ/pKzMfURIv0zhomQ1HyrzLdRkk
         PmaeiOywzKFiwFsUTMNav/3IZ9+Ss0DfhZO8iQzxr4+KOkGQQE396mjwjqZAK9yAqIGO
         q81jDehmAPZ83ne1F7Cr/GY6sD6mn+z98/zjaxjDXJ1zzoQlMNs8Z5Ssvv7bPXuDGcl7
         eKllUwIP1IRCkA0xAyLWOalQPvskHGtMKWbK9wNB/zemsX7lWy8Gi/hLdS69lQ9PECpk
         ycvFafG1RDOhKZw3wtnJ72dsvthTBzoQUKbQy8J9kzGFm3W0L5hfdrhBfUAfwgS02LhU
         RFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EzETE5yRJO875WktHCogKuD+gLJ9pGXC3SMjRgGh6/s=;
        b=jmwUg1R9t23eMj+xfRIWmVktXzCzc0NoOb6g7sQPG+jaOuxB2FDr1NnP00YHCsqEGE
         T591LKmVYtKLA1XSBqmDbk7NPmLlJIxbVP1oy8mO9gLHV9gf7Jyu9VB4pGW3MjWoV62k
         +lKhmLYHVCH1gT0pR8pgNwweaFnX+geYsc4MoWIMuX7E/yNMd89lNpXs5AOunVraTXTh
         Y73KKI/eJIGD+mPuo+KGad4UVRKxGDOgiHCD0wIjr8In8QCziOFBgxOxQKfU2X7t849Q
         6P7mqM/d6f1g71hdy0TW9fwi2HH1jwsMTFjFRbyGmTsQ2eHl8BtT4bV1/gyu9nCQv1sT
         9tIA==
X-Gm-Message-State: ANhLgQ3UqH++bhEroFyj1o20djbKpyVN/v2zK7SlHbWCmqYpMgetlpco
        y/igYzRabchRo1tUEfHvobJCHtCkLkyD6tUjIk4=
X-Google-Smtp-Source: ADFU+vsPlWEzQFx4TbHhJADrI3NMCO9RXluoOsyiW9GGus6jzt3uDp2BmaPUuAHmAe10jjD+CbZ4n/easHasLtqyYoo=
X-Received: by 2002:a9d:19ef:: with SMTP id k102mr11368931otk.220.1583787290605;
 Mon, 09 Mar 2020 13:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAMe9rOoRTVUzNC88Ho2XTTNJCymrd3L=XdB9xFcgxPVwAZ0FWA@mail.gmail.com>
 <AE81FEF5-ECC5-46AA-804D-9D64E656D16E@amacapital.net>
In-Reply-To: <AE81FEF5-ECC5-46AA-804D-9D64E656D16E@amacapital.net>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 9 Mar 2020 13:54:14 -0700
Message-ID: <CAMe9rOoDMenvD9XRL1szR5yLQEwv9Q6f4O7CtwbdZ-cJqzezKA@mail.gmail.com>
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 9, 2020 at 1:16 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
>
>
> > On Mar 9, 2020, at 12:50 PM, H.J. Lu <hjl.tools@gmail.com> wrote:
> >
> > =EF=BB=BFOn Mon, Mar 9, 2020 at 12:35 PM Dave Hansen <dave.hansen@intel=
.com> wrote:
> >>
> >>> On 3/9/20 12:27 PM, Yu-cheng Yu wrote:
> >>> On Mon, 2020-03-09 at 10:21 -0700, Dave Hansen wrote:
> >>>> On 3/9/20 10:00 AM, Yu-cheng Yu wrote:
> >>>>> On Wed, 2020-02-26 at 09:57 -0800, Dave Hansen wrote>>>>> +Note:
> >>>>>>> +  There is no CET-enabling arch_prctl function.  By design, CET =
is
> >>>>>>> +  enabled automatically if the binary and the system can support=
 it.
> >>>>>>
> >>>>>> This is kinda interesting.  It means that a JIT couldn't choose to
> >>>>>> protect the code it generates and have different rules from itself=
?
> >>>>>
> >>>>> JIT needs to be updated for CET first.  Once that is done, it runs =
with CET
> >>>>> enabled.  It can use the NOTRACK prefix, for example.
> >>>>
> >>>> Am I missing something?
> >>>>
> >>>> What's the direct connection between shadow stacks and Indirect Bran=
ch
> >>>> Tracking other than Intel marketing umbrellas?
> >>>
> >>> What I meant is that JIT code needs to be updated first; if it skips =
RETs,
> >>> it needs to unwind the stack, and if it does indirect JMPs somewhere =
it
> >>> needs to fix up the branch target or use NOTRACK.
> >>
> >> I'm totally lost.  I think we have very different models of how a JIT
> >> might generate and run code.
> >>
> >> I can totally see a scenario where a JIT goes and generates a bunch of
> >> code, then forks a new thread to go run that code.  The control flow o=
f
> >> the JIT thread itself *NEVER* interacts with the control flow of the
> >> program it writes.  They never share a stack and nothing ever jumps or
> >> rets between the two worlds.
> >>
> >> Does anything actually do that?  I've got no idea.  But, I can clearly
> >> see a world where the entirety of Chrome and Firefox and the entire ru=
st
> >> runtime might not be fully recompiled and CET-enabled for a while.  Bu=
t,
> >> we still want the JIT-generated code to be CET-protected since it has
> >> the most exposed attack surface.
> >>
> >> I don't think that's too far-fetched.
> >
> > CET support is all or nothing.   You can mix and match, but you will ge=
t
> > no CET protection, similar to NX feature.
> >
>
> Can you explain?

I was talking about creating a program from mixed object files with and wit=
hout
CET marker.

> If a program with the magic ELF CET flags missing can=E2=80=99t make a th=
read with IBT and/or SHSTK enabled, then I think we=E2=80=99ve made an erro=
r and should fix it.
>

A non-CET program can start a CET program and vice versa.

--=20
H.J.
