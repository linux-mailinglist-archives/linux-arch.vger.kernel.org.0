Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 797DBCAA3F
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2019 19:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388643AbfJCRCQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Oct 2019 13:02:16 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46242 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391919AbfJCRCP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Oct 2019 13:02:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id d1so3556504ljl.13
        for <linux-arch@vger.kernel.org>; Thu, 03 Oct 2019 10:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P5wXaF5ZltCgXSM34TOegFWPjTBpFPmOgUeBNVihY4w=;
        b=JKo8Sv2iFH9OWcLRj6EJ0lrBcfCtSlXqHG89kD5Ub09Y0owCLMwh7kGpo40D50FLmA
         8m3gZBLSebpsDzFqxjkVhUIsZ/avu9EVjhD2P/PgJ2J9Q889cf+ojytn85UfifR0QFdJ
         pJM51Bd87EjuNB8rn2bC+8WGyPlYd0s1aUgKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5wXaF5ZltCgXSM34TOegFWPjTBpFPmOgUeBNVihY4w=;
        b=sMQvjxf6ukGwEFV4ug1QUEUOUeIKe5jvi3fHdvAPniyg1rPLWiJ3rg5u8YpqERMpjZ
         mSYP7YsHFqELvhAM3TvGId4mEMUUyKkv7H0WkPEPlu8FzVjvvV1z2NwVni6u/YXY000G
         9jek+V3/RRLjiCcr1WTXS3XZt9FMTd36+kOxfj5t3Z7oy+SV106wocCMW5MUBdtols/l
         6PuABVeVmpkSrQkjgvqKxvWWBRaVsVSTartEWoetJvpJCy+dW/PIky0qWImX31WgheJE
         S8qUZE0vgUsRXiZ8XpiFfFwG7MaKAhkigf2FKtq5/3mtxSIR49NPm8YvpXcCbc5Bfzex
         KXIg==
X-Gm-Message-State: APjAAAXVJEEGbeA/SByy2S5X+V7Dl5rmS6GCH6eyn/TBYXeOO5OsUqRD
        SzZzm7xoq9Np1pMriSZMWdTiBVMG8uc=
X-Google-Smtp-Source: APXvYqwEQhsoL8fNrttFAv8UDOUFql2YnNMm8al8u/M3zdpVvbs1eXT7BFspowa1ppqImagCyGZgqw==
X-Received: by 2002:a2e:3a06:: with SMTP id h6mr7006466lja.128.1570122133315;
        Thu, 03 Oct 2019 10:02:13 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id w30sm552002lfn.82.2019.10.03.10.02.10
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 10:02:10 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id q11so2390646lfc.11
        for <linux-arch@vger.kernel.org>; Thu, 03 Oct 2019 10:02:10 -0700 (PDT)
X-Received: by 2002:a19:2489:: with SMTP id k131mr6216154lfk.52.1570122129934;
 Thu, 03 Oct 2019 10:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck> <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck> <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk> <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk> <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
 <CAMuHMdWPhE1nNkmL1nj3vpQhB7fP3uDs2i_ZVi0Gf9qij4W2CA@mail.gmail.com>
 <CAHk-=wgFODvdFBHzgVf3JjoBz0z6LZhOm8xvMntsvOr66ASmZQ@mail.gmail.com> <CAK7LNARM2jVSdgCDJWDbvVxYLiUR_CFgTPg0nxzbCszSKcx+pg@mail.gmail.com>
In-Reply-To: <CAK7LNARM2jVSdgCDJWDbvVxYLiUR_CFgTPg0nxzbCszSKcx+pg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Oct 2019 10:01:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiMm3rN15WmiAqMHjC-pakL_b8qgWsPPri0+YLFORT-ZA@mail.gmail.com>
Message-ID: <CAHk-=wiMm3rN15WmiAqMHjC-pakL_b8qgWsPPri0+YLFORT-ZA@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Kees Cook <keescook@google.com>, Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 2, 2019 at 7:11 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Macrofying the 'inline' is a horrid mistake that makes incorrect code work.
> It would eternally prevent people from writing portable, correct code.
> Please do not encourage to hide problems.

Honestly, if the alternative to hiding problems is "use a macro", then
I'd rather hide the problems and just make "inline" means "inline".

If "inline" means "it's just a hint, use macros", then inline is useless.

If "inline" means "using this means that there are known compiler
bugs, but we don't know where they trigger", then inline is _worse_
than useless.

I do not see the big advantage of letting the compiler say "yeah, I'm
not going to do that, Dave".

And I see a *huge* disadvantage when people are ignoring compiler
bugs, and are saying "use a macro". Seriously.

Right now we see the obvious compiler bugs that cause build breakages.
How many non-obvious compiler bugs do we have? And how sure are you
that our code is "correct" after fixing a couple of obvious cases?

As to "portable", nobody cares. We're a kernel. We aren't portable,
and never were.

If this is purely about the fact that x86 is different from other
architectures, then let's remove the "compiler can do stupid things"
option on x86 too. It was never clear that it was a huge advantage.

               Linus
