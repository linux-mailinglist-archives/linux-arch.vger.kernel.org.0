Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26F2CC92F4
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2019 22:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfJBUkD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Oct 2019 16:40:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36939 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfJBUkD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Oct 2019 16:40:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id w67so96752lff.4
        for <linux-arch@vger.kernel.org>; Wed, 02 Oct 2019 13:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CZoX6/kAyBlNzPm3PxVJHHET8XR6oaEdHzpQ1JHxlxk=;
        b=WgH48i53OT8OxyAS10xRgTGen79hUl3stcfXDufRhIUV4G8traFDMLYOcDbmARGtri
         tU39pf48gI+/cvvec8i+m09klNO/DTKi0Xs0KDdSSGqqIUqlnGTnz+5xBoxTqitRtY8f
         KX6a88Kh0m0W4klfZBa6hR0r/gM5QP+f5tEIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CZoX6/kAyBlNzPm3PxVJHHET8XR6oaEdHzpQ1JHxlxk=;
        b=R3Lxl2y3GUyhBnRebdj+PrKprH5vC4qvR/TGD9rhv/DOkezOGenQs3QYbY8k7BzXrH
         c5aM4JIvg0QTTah9xhJBhEq2HaKJaVefp2rA+etmRLayY5TlwQDdWGQICK+tNNQK32fJ
         N5Krcio7mbDO48GYnJr5AwpdLcql85r0duQlV2+47zXx/rS5PsPvjBWhRty7lo60ouj8
         oSCTWRp5z9wYISz0LNbzLDy1zFJwIkppmPrqh+EJ7OOK7nkDb6RgGx3Ug2RCeOY0pkOT
         fhOKbJK0DvuKp8mYiijMeXCmaWb3VBxvYI6y/cRRgzo69sQTc8LiU9yz+EOc1aEmt9pn
         qG1g==
X-Gm-Message-State: APjAAAVp94aFfrhtaPL1k1XC0Xn4618xvA7Oh5TdWpsq6XeSKs/gXYEx
        v94EFQ3258YR0jVaHCYI1S8fONHOi6k=
X-Google-Smtp-Source: APXvYqzs4nXzl0rNFemidfbcVEXjQL/xXaliluny+PnT0A5k5PLUKF/TJzTXG485XXxzXTvX9gI28Q==
X-Received: by 2002:ac2:5965:: with SMTP id h5mr3399365lfp.129.1570048799047;
        Wed, 02 Oct 2019 13:39:59 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id a8sm106008ljf.47.2019.10.02.13.39.57
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 13:39:57 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id t8so59571lfc.13
        for <linux-arch@vger.kernel.org>; Wed, 02 Oct 2019 13:39:57 -0700 (PDT)
X-Received: by 2002:ac2:47f8:: with SMTP id b24mr3502326lfp.134.1570048796885;
 Wed, 02 Oct 2019 13:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck> <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck> <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk> <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk> <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
 <CAMuHMdWPhE1nNkmL1nj3vpQhB7fP3uDs2i_ZVi0Gf9qij4W2CA@mail.gmail.com>
In-Reply-To: <CAMuHMdWPhE1nNkmL1nj3vpQhB7fP3uDs2i_ZVi0Gf9qij4W2CA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Oct 2019 13:39:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgFODvdFBHzgVf3JjoBz0z6LZhOm8xvMntsvOr66ASmZQ@mail.gmail.com>
Message-ID: <CAHk-=wgFODvdFBHzgVf3JjoBz0z6LZhOm8xvMntsvOr66ASmZQ@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
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

On Wed, Oct 2, 2019 at 5:56 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> >
> > Then use the C preprocessor to force the inlining.  I'm sorry it's not
> > as pretty as static inline functions.
>
> Which makes us lose the baby^H^H^H^Htype checking performed
> on function parameters, requiring to add more ugly checks.

I'm 100% agreed on this.

If the inline change is being pushed by people who say "you should
have used macros instead if you wanted inlining", then I will just
revert that stupid commit that is causing problems.

No, the preprocessor is not the answer.

That said, code that relies on inlining for _correctness_ should use
"__always_inline" and possibly even have a comment about why.

But I am considering just undoing commit 9012d011660e ("compiler:
allow all arches to enable CONFIG_OPTIMIZE_INLINING") entirely. The
advantages are questionable, and when the advantages are balanced
against actual regressions and the arguments are "use macros", that
just shows how badly thought out this was.

                Linus
