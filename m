Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BACEC3F35
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2019 20:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfJASAZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Oct 2019 14:00:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37888 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfJASAY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Oct 2019 14:00:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id x10so10197509pgi.5
        for <linux-arch@vger.kernel.org>; Tue, 01 Oct 2019 11:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yrPCibXZ8aAVlYeWu3qzUI+I4f/2IsCgC/T/cZwtUTk=;
        b=tP7kQ9mFk9GH83DD4Wn7w8bkC2bvSljjKeU02a8Ws9I/OYWSsc6I77CXb3DX8fKZ3Y
         uSiRydgZIuYa5+LNm0P/n1NC/j3RE9nl3yFtR3evY8dySp4mAv8FZHaVm03nLvysHSRw
         +S8bnOuLMJdRsQwaDpcvGUhY6rQo8oKkgT6pNIL8I3CrSef8L19AJraS9IWX/wr03g19
         Z8h6MQLFqYMCz6v/A4QO6EDDSwfq8sq1ZkFQAoQVWhRd4/7MRaBv3BByYgeyEdxwVB0o
         S8+cVyjvrip1SyEKNjzCZgx3HNFJCcHvrc8CTFr5GQEAa3ljNPfZ94BpEmNhIPLuJViz
         VyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yrPCibXZ8aAVlYeWu3qzUI+I4f/2IsCgC/T/cZwtUTk=;
        b=NtqKceL1wkuSSJIRGkprF03DfiFx674otQe7CZZHOUWQlmPsK00o6dPjZnDm+KWdon
         oNBJufcZbfvY5YmBYYbepfTPOBSv+mT5RcCy64jmBJQBJKVcJRQTxuI/LidEqD5RdwTb
         bp4kcihluMYuMJUwYCk1A8N3gdwQMTWB3Yq2JN8rdGj3i1Cn1tzI1nTVKVVN7r7d4U0q
         8ECgiuSAo7IokKOmT3zhX5TMcXDNVYC9RkiLO3lGpy1o0z8YAxVTUN2t9c4vrcsTrM1c
         voDJuOLxn0iZo+K+xpclruW5AHcG59kO11eSjUutiAP/MK253Qlhwaw9QZ1YyLjyncpT
         Q4Ww==
X-Gm-Message-State: APjAAAVBEdHxuNWYL1P4wqHEUgBvgpRuEbmTOrt760OqLjetfojidpvw
        QAZyeSgpIZ9QTg05hYNK8QMJ/IMLwMt9kzvKQKCH0w==
X-Google-Smtp-Source: APXvYqwYNCvEPHPmb+tyytchKsZjMGzhL9IBjNboIg7WvPbiYbOhSRJ0ENEMO+ep9ULQ6v9Zpf55jzuTzQTkRZD7kEo=
X-Received: by 2002:a63:2f45:: with SMTP id v66mr7764492pgv.263.1569952822500;
 Tue, 01 Oct 2019 11:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdk=tr5nqq1CdZnUvRskaVqsUCP0SEciSGonzY5ayXsMXw@mail.gmail.com>
 <CAHk-=wiTy7hrA=LkmApBE9PQtri8qYsSOrf2zbms_crfjgR=Hw@mail.gmail.com>
 <20190930112636.vx2qxo4hdysvxibl@willie-the-truck> <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck> <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck> <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk>
In-Reply-To: <20191001175512.GK25745@shell.armlinux.org.uk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Oct 2019 11:00:11 -0700
Message-ID: <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Will Deacon <will@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 1, 2019 at 10:55 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Tue, Oct 01, 2019 at 10:44:43AM -0700, Nick Desaulniers wrote:
> > I apologize; I don't mean to be difficult.  I would just like to avoid
> > surprises when code written with the assumption that it will be
> > inlined is not.  It sounds like we found one issue in arm32 and one in
> > arm64 related to outlining.  If we fix those two cases, I think we're
> > close to proceeding with Masahiro's cleanup, which I view as a good
> > thing for the health of the Linux kernel codebase.
>
> Except, using the C preprocessor for this turns the arm32 code into
> yuck:
>
> 1. We'd need to turn get_domain() and set_domain() into multi-line
>    preprocessor macro definitions, using the GCC ({ }) extension
>    so that get_domain() can return a value.
>
> 2. uaccess_save_and_enable() and uaccess_restore() also need to
>    become preprocessor macro definitions too.
>
> So, we end up with multiple levels of nested preprocessor macros.
> When something goes wrong, the compiler warning/error message is
> going to be utterly _horrid_.

That's why I preferred V1 of Masahiro's patch, that fixed the inline
asm not to make use of caller saved registers before calling a
function that might not be inlined.
-- 
Thanks,
~Nick Desaulniers
