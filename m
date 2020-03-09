Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2081217EAEB
	for <lists+linux-arch@lfdr.de>; Mon,  9 Mar 2020 22:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgCIVNK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Mar 2020 17:13:10 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36337 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgCIVNK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2020 17:13:10 -0400
Received: by mail-oi1-f195.google.com with SMTP id t24so11715073oij.3;
        Mon, 09 Mar 2020 14:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3z8EHLpMCQvcYpt6UukodjjMPaKQSfJoSvh+H1FwXpE=;
        b=Uo33X2KRJb36R+pDGYk+8RIeN85dKzwpgdLbDUPr+9B9BMZ85RveP6Gg4P9oyZxbm4
         2K3e4tdKvGoGtgRpjcwgMiWQZt8UJb/UFNJHw5tLF0NOWHFrNFdyRXTkFSbkf5H4tsc6
         IcpYpKYWqffJV6s2v90EZdhLsDqIKsO+RfndJ8vdAPvApbSRQC+o9evQVkA1fncfVn94
         /r1A5ShhXUejgZgxKKIPCMr3s+3DprNyhVawLwBIFSWp9lSWYYnxpaTqXttawWDI94Z0
         rwKxBj33qEtxur5xqGdRtakBXCrM+5cjMBQn/XmEncvVst15+znYnLuBqtLxKgb9OaTt
         ARPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3z8EHLpMCQvcYpt6UukodjjMPaKQSfJoSvh+H1FwXpE=;
        b=XaRcRA0nnFmk6hUImivNgx9D/4/iz6PE4iE+71d3TjFW9RVjTA2V2/+5wjvWgMBhBm
         XNclZSpwrGhfWJ8JL/Nwc6u+duX3OLhmim5PkI3qae1HbRus1MGcpGjMu0j2pt8ytvJI
         YLPlcXa7Lolo6e1mUbj1GkTBR+4zmpzr+A/0pu68C6C9nEpLYVsZEOIh5rS2Jr7KO/Ub
         P7JozaSqeZ9SfzuNVOWa4IrZsVMr77HR03H5Fq8JSHN51EANQ1n8FzPrGmpC+D61y0u7
         mSPH65yPrq9PfxKCFkdiLTlK3PM7tlbciDKtKIMvEtZyBVNVIpqiCAgufA8YCxnAeOHN
         MfXQ==
X-Gm-Message-State: ANhLgQ2vVITex+zonIROH+r5Hv99/GsMYcyolwHIvlO9BfOSB3U7Fi5W
        y0bz+nEgO9yO6/QhMgOhE7flTErhC4mO8WOUCP8=
X-Google-Smtp-Source: ADFU+vuIWAeuG6fp3KaR1L5/2IvghcQfrXPwsJh/m5EVZSNOWjVc3Evh0yp9ILZ/129trtK5JRkTF3lPbT5uuTXehkU=
X-Received: by 2002:aca:aa12:: with SMTP id t18mr853523oie.95.1583788387706;
 Mon, 09 Mar 2020 14:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAMe9rOoRTVUzNC88Ho2XTTNJCymrd3L=XdB9xFcgxPVwAZ0FWA@mail.gmail.com>
 <AE81FEF5-ECC5-46AA-804D-9D64E656D16E@amacapital.net> <CAMe9rOoDMenvD9XRL1szR5yLQEwv9Q6f4O7CtwbdZ-cJqzezKA@mail.gmail.com>
 <0088001c-0b12-a7dc-ff2a-9d5c282fa36b@intel.com>
In-Reply-To: <0088001c-0b12-a7dc-ff2a-9d5c282fa36b@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 9 Mar 2020 14:12:31 -0700
Message-ID: <CAMe9rOqf0OHL9397Vikgb=UWhRMf+FmGq-9VAJNmfmzNMMDkCw@mail.gmail.com>
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
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

On Mon, Mar 9, 2020 at 1:59 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 3/9/20 1:54 PM, H.J. Lu wrote:
> >> If a program with the magic ELF CET flags missing can=E2=80=99t make a
> >> thread with IBT and/or SHSTK enabled, then I think we=E2=80=99ve made =
an
> >> error and should fix it.
> >>
> > A non-CET program can start a CET program and vice versa.
>
> Could we be specific here, please?
>
> HJ are you saying that:
> * CET program can execve() a non-CET program, and
> * a non-CET program can execve() a CET program
>
> ?

Yes.

> That's obvious.
>
> But what are the rules for clone()?  Should there be rules for
> mismatches for CET enabling between threads if a process (not child
> processes)?

What did you mean? A threaded application is either CET enabled or not
CET enabled.   A new thread from clone makes no difference.

--=20
H.J.
