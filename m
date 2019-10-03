Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD5BCAA8F
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2019 19:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393439AbfJCRId (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Oct 2019 13:08:33 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38979 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393432AbfJCRIa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Oct 2019 13:08:30 -0400
Received: by mail-lf1-f67.google.com with SMTP id 72so2425264lfh.6
        for <linux-arch@vger.kernel.org>; Thu, 03 Oct 2019 10:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xGPNBFqVYtxez447o7VfzpEEdWGUXuNgcxnMZZtHxhw=;
        b=JQlxhcyH0jHwarYabbpi6wNpJW+TQGKZ3Q/o2mSONQp+edqEcUDbfc+bZRMV+49X8b
         6iqsJ6W2xVarc2Qbqm9lYLbIQOaubfS2b2d2RR4HW+NziK3KAuGvVuwqS5GOwXs3hULK
         jTZNUAkzsyFNJMvYZMy8abMpYXNOFhEkahnBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xGPNBFqVYtxez447o7VfzpEEdWGUXuNgcxnMZZtHxhw=;
        b=CS7M0cVoCMR8m0rEJq2wIno/MYmaVIk/21aUBad7L0KBqbiRfbax6f4CP8BQdPOqee
         tOVHQUZrOc4oNbqeUzD+7N+hFMmI22gd4nPGw7XYpU0WfnsJbxM1GmWUjXJXgecvFKGr
         KgMitDuzS6FX1aodMzMVSokJvgMGpVpIGUXZ6Jnblw1sWgNC4ewr6Gc6wm3ihJPYvKfb
         /jUAXoH+PUQ7vnYCTKT5jjyKPpx2oGnq2Vm42PdJSF+O2STamkfhHuj0EwphZXVqsrq3
         yepdRPDRC7ynQ+8zMob6BzEJFIZ1Z4aVdXmgH9rkfDi6GRFs2r+Wo4NcyKrICIQAoh5N
         nIPw==
X-Gm-Message-State: APjAAAVpsZZFiqn2+o6I6qqTz/CrSiydBbVMamUsZw583wgshL37w5iQ
        nNhhLPDFSQaaM4Hbic1mirZ0jjvsSKw=
X-Google-Smtp-Source: APXvYqwt01sp9zZ8I79k4tDH/Z0xKp7H5663lqnaNNaN3ZL5cKQ816Y1lDSD+Z1mmfenTiHXLYv0eg==
X-Received: by 2002:a19:2c1:: with SMTP id 184mr2716172lfc.100.1570122508554;
        Thu, 03 Oct 2019 10:08:28 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id t10sm665197ljt.68.2019.10.03.10.08.26
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 10:08:26 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id f5so3597048ljg.8
        for <linux-arch@vger.kernel.org>; Thu, 03 Oct 2019 10:08:26 -0700 (PDT)
X-Received: by 2002:a2e:86d5:: with SMTP id n21mr6759265ljj.1.1570122505822;
 Thu, 03 Oct 2019 10:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck> <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck> <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk> <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk> <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
 <CAMuHMdWPhE1nNkmL1nj3vpQhB7fP3uDs2i_ZVi0Gf9qij4W2CA@mail.gmail.com>
 <CAHk-=wgFODvdFBHzgVf3JjoBz0z6LZhOm8xvMntsvOr66ASmZQ@mail.gmail.com>
 <CAK7LNARM2jVSdgCDJWDbvVxYLiUR_CFgTPg0nxzbCszSKcx+pg@mail.gmail.com> <CAHk-=wiMm3rN15WmiAqMHjC-pakL_b8qgWsPPri0+YLFORT-ZA@mail.gmail.com>
In-Reply-To: <CAHk-=wiMm3rN15WmiAqMHjC-pakL_b8qgWsPPri0+YLFORT-ZA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Oct 2019 10:08:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkB+g0R0JqLB+Y4piUZf9A8P1ugi5T92LjFLNY+epBeg@mail.gmail.com>
Message-ID: <CAHk-=whkB+g0R0JqLB+Y4piUZf9A8P1ugi5T92LjFLNY+epBeg@mail.gmail.com>
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

On Thu, Oct 3, 2019 at 10:01 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If this is purely about the fact that x86 is different from other
> architectures, then let's remove the "compiler can do stupid things"
> option on x86 too. It was never clear that it was a huge advantage.

Side note: what might be an actual advantage would be to have a mode
where you see when the compiler would choose to not inline things.

Maybe we have things that are marked "inline" that simply shouldn't
be. We do tend to have this history of adding small helper functions
to header files, and then they grow and grow and grow. And now they
shouldn't be in a header file any more, but they still are.

So having a "compiler doesn't want to inline this" flag might be
useful for finding those, but it might also be useful for people
looking for what triggers bugs.

But honestly, the last time I saw somebody argue for "I don't want
inlining", it was the broken "I want to compiler the kernel with no
optimizations so that it's easier to look at the resulting code". That
was just a _bad_ bad patch. And if it is concerns like that that are
driving this "compiler doesn't have to inline", then we should stop it
immediately.

             Linus
