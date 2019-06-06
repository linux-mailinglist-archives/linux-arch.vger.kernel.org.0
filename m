Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5032837EB4
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2019 22:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfFFU0s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jun 2019 16:26:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfFFU0r (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Jun 2019 16:26:47 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D68BD214AF
        for <linux-arch@vger.kernel.org>; Thu,  6 Jun 2019 20:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559852807;
        bh=KPzI+YwSmOs28yM0mu03w5J/5AGDUhBeJx6OEeWoVX4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sQw0Lu9CAjfPFLxj0f4izZgbct9wON3UkoluMWtqqvnVZi7LX6+PqbRKcUNtGFPRC
         VwSx/IwIvxNRl/Eh2ce4stDlwhsMthuxOUrJ/gpf6YOh6guy7TBeQP/aoPkMh3L+/v
         d2/JTlzLlzvCzvUELTMuYV1T3nAUPyJwHIqwc0MM=
Received: by mail-wm1-f53.google.com with SMTP id 22so1230507wmg.2
        for <linux-arch@vger.kernel.org>; Thu, 06 Jun 2019 13:26:46 -0700 (PDT)
X-Gm-Message-State: APjAAAVik4GpkHjswJ3oC6M/J4OHQc+5P2WNNCqg/xmP7sL9HyH1u7IG
        kT4sXyF3/04FtOYpJ1/qkJ579jKFHXxOjWGD9RfbkQ==
X-Google-Smtp-Source: APXvYqwZv50PloUZATpBbGT4OO6zXzFDR47DeJkyJO1yLg4R1WCRiHzDw51jl+w40n+V1KyBop2vJW/Rtz8YXJjW/A4=
X-Received: by 2002:a1c:6242:: with SMTP id w63mr1265538wmb.161.1559852805470;
 Thu, 06 Jun 2019 13:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190606200926.4029-1-yu-cheng.yu@intel.com> <20190606200926.4029-10-yu-cheng.yu@intel.com>
In-Reply-To: <20190606200926.4029-10-yu-cheng.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 6 Jun 2019 13:26:34 -0700
X-Gmail-Original-Message-ID: <CALCETrVhw4U939E2RorUMorxx8VqLyg2Zm8qEMUSM5pX+cc2FQ@mail.gmail.com>
Message-ID: <CALCETrVhw4U939E2RorUMorxx8VqLyg2Zm8qEMUSM5pX+cc2FQ@mail.gmail.com>
Subject: Re: [PATCH v7 09/14] x86/vdso: Insert endbr32/endbr64 to vDSO
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
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
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 6, 2019 at 1:17 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> From: "H.J. Lu" <hjl.tools@gmail.com>
>
> When Intel indirect branch tracking is enabled, functions in vDSO which
> may be called indirectly must have endbr32 or endbr64 as the first
> instruction.  Compiler must support -fcf-protection=branch so that it
> can be used to compile vDSO.

Acked-by: Andy Lutomirski <luto@kernel.org>

>
> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>

You're still missing your Signed-off-by.
