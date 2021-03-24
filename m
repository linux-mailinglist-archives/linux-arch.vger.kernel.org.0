Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C44347DDF
	for <lists+linux-arch@lfdr.de>; Wed, 24 Mar 2021 17:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbhCXQja (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Mar 2021 12:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbhCXQi6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Mar 2021 12:38:58 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA600C0613E0
        for <linux-arch@vger.kernel.org>; Wed, 24 Mar 2021 09:38:57 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id b5so11669776vsl.9
        for <linux-arch@vger.kernel.org>; Wed, 24 Mar 2021 09:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wNHiEG33VxCvMonOriWGNjj3ArhqwshcClwSjyhBeSM=;
        b=aIdOLKogREItDPzd5A+jRjsMTc+xmHWs2f8DXYi4nKG1WB6O5apxTb0kST6RgOkHem
         ghgvEZWjF8nRr4dbvSOuwWbwjFPuV/vbaRD3Z7CGoVZawIxEFV5mJsE5ZtJNXdRjxRPM
         /pgQmlNT52f7FhktYcLYtuo6wxnQ3p+E5JGCLX8DI9PAwVPuYWrmoFrgkcQEOH3bWko1
         yeUR3ZGC2yXuGY5z4MB6db/ziAwUVV0vGN+TjSPkoDw6IcyU8wT+LKtbwhYggLzRtOkn
         QaW82SDYSI17mjm1c8GXof1fEQ8QDILZ6717zNSQ+sv7WNZgh0LtIzkVfeFDKEGTQ5cn
         qx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wNHiEG33VxCvMonOriWGNjj3ArhqwshcClwSjyhBeSM=;
        b=a2p/w275HkWDTUxApfCjKeXIn9jjKi9sQOVUEiE00KFcW0VIqXiTj5mOY57I0o4G5U
         cEkuq4ytfKZl7EDxE/YOyiI8NLJb6fpARBtPfAdJKMbkSw6NWwtwdp3jF7qjpVSVxEGU
         7YavP7ybO9N5ONj+H85myDf9Kmhj80inrrd0vyQjqq++dgtOcaFeuNS1Rp9M5+NxIezl
         pVfeiD98VixzNo2fhktHoW8lnsgKbMu79j6NhyJShXkDWykrCZ+ysN//GeBEmmYXlPv+
         VPrdy8j3pW75MurfbJW3b3YVw347geEReNdLR5GCzemh2GgGfiFlRhxHhCDSxg2Q5SCq
         uCFA==
X-Gm-Message-State: AOAM532CBZeGE4t4tC1ktnUblq46hCMvFpX6GFM9LMCryjFlxSt+unLW
        jIOl4k12/eCPHWr+w/eL+C/6Qho3ZiNVKOUuRiVzBg==
X-Google-Smtp-Source: ABdhPJyWiP2FO1YBFJh/0mu3kCEijgEQEuiJ4RCJ6qBqZ4V3CaaQ9VqbbV+Q52zSjlticSrKlbcWuV02zo+EVO7D8+4=
X-Received: by 2002:a67:2803:: with SMTP id o3mr2580346vso.36.1616603936571;
 Wed, 24 Mar 2021 09:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210323203946.2159693-1-samitolvanen@google.com>
 <20210323203946.2159693-3-samitolvanen@google.com> <92afcbea-1415-2df1-5e78-4e9a7a4d364b@rasmusvillemoes.dk>
In-Reply-To: <92afcbea-1415-2df1-5e78-4e9a7a4d364b@rasmusvillemoes.dk>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 24 Mar 2021 09:38:45 -0700
Message-ID: <CABCJKudTZang_aUCnO63MFUc5mud3DKpHUgRFB-e04L__j_XHA@mail.gmail.com>
Subject: Re: [PATCH v3 02/17] cfi: add __cficanonical
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        bpf <bpf@vger.kernel.org>, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 24, 2021 at 8:31 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 23/03/2021 21.39, Sami Tolvanen wrote:
> > With CONFIG_CFI_CLANG, the compiler replaces a function address taken
> > in C code with the address of a local jump table entry, which passes
> > runtime indirect call checks. However, the compiler won't replace
> > addresses taken in assembly code, which will result in a CFI failure
> > if we later jump to such an address in instrumented C code. The code
> > generated for the non-canonical jump table looks this:
> >
> >   <noncanonical.cfi_jt>: /* In C, &noncanonical points here */
> >       jmp noncanonical
> >   ...
> >   <noncanonical>:        /* function body */
> >       ...
> >
> > This change adds the __cficanonical attribute, which tells the
> > compiler to use a canonical jump table for the function instead. This
> > means the compiler will rename the actual function to <function>.cfi
> > and points the original symbol to the jump table entry instead:
> >
> >   <canonical>:           /* jump table entry */
> >       jmp canonical.cfi
> >   ...
> >   <canonical.cfi>:       /* function body */
> >       ...
> >
> > As a result, the address taken in assembly, or other non-instrumented
> > code always points to the jump table and therefore, can be used for
> > indirect calls in instrumented code without tripping CFI checks.
>
> Random ramblings, I'm trying to understand how this CFI stuff works.
>
> First, patch 1 and 2 explain the pros and cons of canonical vs
> non-canonical jump tables, in either case, there's problems with stuff
> implemented in assembly. But I don't understand why those pros and cons
> then end up with using the non-canonical jump tables by default. IIUC,
> with canonical jump tables, function pointer equality would keep working
> for functions implemented in C, because &func would always refer to the
> same stub "function" that lives in the same object file as func.cfi,
> whereas with the non-canonical version, each TU (or maybe DSO) that
> takes the address of func ends up with its own func.cfi_jt.

Correct.

> There are of course lots of direct calls of assembly functions, but
> I don't think we take the address of such functions very often. So why
> can't we instead equip the declarations of those with a
> __cfi_noncanonical attribute?

Clang doesn't support these attributes in function declarations,
unfortunately. If it did, that would certainly help, until someone
wants to compare addresses of assembly functions, in which case we
would again have a problem.

Another way to work around the issue with canonical CFI would be to
add C wrappers for all address-taken assembly functions, but that's
not quite ideal either. I think most indirect calls to assembly
functions happen in the crypto code, which would have required so many
changes that we decided to default to non-canonical CFI instead. This
resulted in far fewer kernel changes despite the cross-module function
address equality issue.

Sami
