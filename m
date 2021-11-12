Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A6144EE8F
	for <lists+linux-arch@lfdr.de>; Fri, 12 Nov 2021 22:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhKLV3Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Nov 2021 16:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbhKLV3Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Nov 2021 16:29:25 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B65C061766
        for <linux-arch@vger.kernel.org>; Fri, 12 Nov 2021 13:26:33 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b1so19614549lfs.13
        for <linux-arch@vger.kernel.org>; Fri, 12 Nov 2021 13:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ntZGBdiceWxX5bWKAyYQPAfUlf1Jy17/iBsUfaHjtvE=;
        b=WnpzkwgfwXofLeiX77Oe8YFgQJUod+ED3X+7zGSdhuhBdJ1F2P+TdKgmMLEdVL1SvZ
         /GS6JghHYzPxFbK4+NWebHaGgWNfR8ePRUJ+vL2ZwudXOMenfcKfNrB9ar+yxKCNchIc
         qL8+VW1E3C2BAaWeSIjvcK1Ufg0h/Rn5taTmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ntZGBdiceWxX5bWKAyYQPAfUlf1Jy17/iBsUfaHjtvE=;
        b=XLUhIDbfu0Efspqtt5t98dkMWSZlrvbDgyxxi5ZmFyXQvvtc77arqJG4EZh5bR4+ad
         0J1+2bwFdgY/lMXma+L0VDv6GRLBmFQX2xo2I++nX9N+4vVwksPWgtAQDZGEILICci72
         d36BHl7L6fZQoJ/3iGjsnl54KQHorcCF6DW6C/cwSi1yWspUMpx3L/4oZtIHbtILP4ch
         ULKpPX3P3MHcsvvem8LlUvLo2CH0Bo2ZlOU2za7SRhgyZxZCE9Llgkim0aTs2tdDqu0O
         ANYo9oE8OmbgyDNEczwZZQjRkZwRe214E+g1OSIehkKuKDL4l6zjmSqHGz7lGHokA2rh
         RjJQ==
X-Gm-Message-State: AOAM530FIipIErcZuoKfMQPz1Vm0Dyabo0sW55ll5sJ2+jxoFyqzk63R
        FTNCSHTSpBw236g1gWo3bh0Rz5r/DgvZ2Y29oDU=
X-Google-Smtp-Source: ABdhPJzc6qtCaQtmsjahprFtZ2/V2PG1UbuO9tBw5Xjy1Di4mtxHwSsl9rHE9cCuIrfVvG517F0yRA==
X-Received: by 2002:ac2:5fee:: with SMTP id s14mr16096285lfg.537.1636752391920;
        Fri, 12 Nov 2021 13:26:31 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 80sm648627ljf.4.2021.11.12.13.26.29
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 13:26:30 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id l22so25440428lfg.7
        for <linux-arch@vger.kernel.org>; Fri, 12 Nov 2021 13:26:29 -0800 (PST)
X-Received: by 2002:adf:cf05:: with SMTP id o5mr22971280wrj.325.1636752379227;
 Fri, 12 Nov 2021 13:26:19 -0800 (PST)
MIME-Version: 1.0
References: <20211027233215.306111-1-alex.popov@linux.com> <ac989387-3359-f8da-23f9-f5f6deca4db8@linux.com>
In-Reply-To: <ac989387-3359-f8da-23f9-f5f6deca4db8@linux.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Nov 2021 13:26:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgRmjkP3+32XPULMLTkv24AkA=nNLa7xxvSg-F0G1sJ9g@mail.gmail.com>
Message-ID: <CAHk-=wgRmjkP3+32XPULMLTkv24AkA=nNLa7xxvSg-F0G1sJ9g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Introduce the pkill_on_warn parameter
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Maciej Rozycki <macro@orcam.me.uk>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Wei Liu <wl@xen.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Laura Abbott <labbott@kernel.org>,
        David S Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Scull <ascull@google.com>,
        Marc Zyngier <maz@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wang Qing <wangqing@vivo.com>, Mel Gorman <mgorman@suse.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Mathieu Chouquet-Stringer <me@mathieu.digital>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stephen Kitt <steve@sk2.org>, Stephen Boyd <sboyd@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mike Rapoport <rppt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, notify@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 12, 2021 at 10:52 AM Alexander Popov <alex.popov@linux.com> wrote:
>
> Hello everyone!
> Friendly ping for your feedback.

I still haven't heard a compelling _reason_ for this all, and why
anybody should ever use this or care?

               Linus
