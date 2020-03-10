Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC6E817EE61
	for <lists+linux-arch@lfdr.de>; Tue, 10 Mar 2020 03:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgCJCOL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Mar 2020 22:14:11 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40452 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgCJCOL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2020 22:14:11 -0400
Received: by mail-ot1-f66.google.com with SMTP id x19so11712819otp.7;
        Mon, 09 Mar 2020 19:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gAewQcsa0gHih3wXpHAV80ssMemQtrtXXF853KTte9o=;
        b=L6Xq9iZGLEa1l14/JrlBDJBkv6HSKObpOzYqkDvz6JQ3GsPAHMI1pWejPHQchkBx/J
         7DYTfbBRiVRSC0rvWKTxzNI97bTlim0XdN1HVXIso9GWDDH9ZIEbUsirmgrK6cjDzCTV
         Ge94uFgJxo8bbnbP094yO7yKys8bFQDoQAIyZXhbAPUTDKRJU0Y23zTDUcqdQo0643N+
         scYHFsyP+aMiDWTUKAw8HAzoul6KYwMEnWVYDdb1HCxu9FCzTzNwuC4hfZJEYYtjNDbh
         71T4jtmAKGVBmywAehooLNjMEYzMwT8EoZhKl4EpuxgMTAxYCKfHbzE3aG4uKl6iobk8
         PSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gAewQcsa0gHih3wXpHAV80ssMemQtrtXXF853KTte9o=;
        b=NJpAJIl4/3LAigf+NTv5OlBER404onshMb2msx/G6/soCyHUxeEd7FNNBd+0scmaHu
         O8kgIH5FXcjOR/g5khOv20F7hLQfNfNOjIqP28IOjEgCLLU1AHC8IsWzeAzNb/84rvvN
         k6fIexutaQ1BXY04iEw3BeK4+cg1lDk/Sy7UtHUlP4vcqZzcQxqbSSuCMnlokB+INtuk
         4ACU4bdZT/DUSUqhAD4MXYhh6oYJAhlCyT+BPAZeh5D2wIHGt5yi90+clP11EI1Cp717
         3rPqEtA0KRIDyBpiRewYby1WFYtMC8RYh4nefnr0nV4rj7b+npganhb2nPOiLrWZbZt5
         MMDw==
X-Gm-Message-State: ANhLgQ1fGTRcik6H2uc0bTnIQWzxDKbzH37aq/glYKdDroWw0ihclkzx
        bAzA7yBbTwr/IMUlZe19/wNNVPIG+4O3KAgkSbc=
X-Google-Smtp-Source: ADFU+vtaVVdLu4F7XALa/kOBsPcMpoxoqzHShyPAI8Uyv+DJuJS2VG1IYhdWG4KhM/G0WcnD+WqCE+VveBubEMUEXwI=
X-Received: by 2002:a9d:19ef:: with SMTP id k102mr12179526otk.220.1583806450481;
 Mon, 09 Mar 2020 19:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAMe9rOpJjaro_qK6kghGNuSHDaP_MjVaZMbok2kbuBD48VmvXg@mail.gmail.com>
 <E7E7A2AE-500A-4817-B00A-BE419E89C6F9@amacapital.net>
In-Reply-To: <E7E7A2AE-500A-4817-B00A-BE419E89C6F9@amacapital.net>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 9 Mar 2020 19:13:34 -0700
Message-ID: <CAMe9rOoZazTpWcK1hr4d25z8Gv3yGbpn_48R1RHGfq-aDOJ0Eg@mail.gmail.com>
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
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

On Mon, Mar 9, 2020 at 6:21 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> I am baffled by this discussion.
>
> >> On Mar 9, 2020, at 5:09 PM, H.J. Lu <hjl.tools@gmail.com> wrote:
> >>
> >> =EF=BB=BFOn Mon, Mar 9, 2020 at 4:59 PM Andy Lutomirski <luto@amacapit=
al.net> wrote:
> >
> >>>> .
> >> This could presumably have been fixed by having libpcre or sljit
> >> disable IBT before calling into JIT code or by running the JIT code in
> >> another thread.  In the other direction, a non-CET libpcre build could
> >> build IBT-capable JITted code and enable JIT (by syscall if we allow
> >> that or by creating a thread?) when calling it.  And IBT has this
> >
> > This is not how thread in user space works.
>
> void create_cet_thread(void (*func)(), unsigned int cet_flags);
>
> I could implement this using clone() if the kernel provides the requisite=
 support. Sure, creating threads behind libc=E2=80=99s back like this is pe=
rilous, but it can be done.

Sure, this can live outside of libc with kernel support.

> >
> >> fancy legacy bitmap to allow non-instrumented code to run with IBT on,
> >> although SHSTK doesn't have hardware support for a similar feature.
> >
> > All these changes are called CET enabing.
>
> What does that mean?  If program A loads library B, and library B very ca=
refully loads CET-mismatched code, program A may be blissfully unaware.

Any source changes to make codes CET compatible is to enable CET.

Shadow stack can't be turned on or off arbitrarily.  ld.so checks it and
makes sure that everything is consistent.  But this is entirely done in
user space.  In the first phase, we want to make CET simple, not too
complicated.


H.J.
