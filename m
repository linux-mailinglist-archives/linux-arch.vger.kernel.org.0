Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B8E148D26
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2020 18:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389138AbgAXRo3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jan 2020 12:44:29 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41794 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388378AbgAXRo2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jan 2020 12:44:28 -0500
Received: by mail-ed1-f67.google.com with SMTP id c26so3240431eds.8
        for <linux-arch@vger.kernel.org>; Fri, 24 Jan 2020 09:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PpUhy8WdhQo7yn2G9tENFyd+BPqi316s2p72a22I/kM=;
        b=E0Lq8FFbgVl9GzkkHHsvD4aAT7s8Kyiy5R3To2otgXvIV4WtGWhmO0VAPKZyplWkpQ
         9fbytk/03qWfDWSy/b4im5LObo51pXVPG+2QYc8xouyIReu0xgLTNMnBqvtURbYmRlXH
         9ggvethS3Fn2LsF1kSh3PipG5fC47A+kEvXS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PpUhy8WdhQo7yn2G9tENFyd+BPqi316s2p72a22I/kM=;
        b=RNh4se1MANHIzBpoM95kZRp2dNkv/hgqX8xjp4YrK0CpmbnNQovldi9I8c1Nf/bNLk
         l18WMZkHqslmX73Zr/W5Oront9Zzn0meC7WFQHYvEIBxm+oKv2AZH5KKgpUzsb7uxbnk
         5lGBa3vH4AZL8z+Q/uqNc6QfNzQgvgAm/VL6f6iyA2+IUnKQZGqQklamBNlDgpeh0UoH
         V+75iwIA/zB8PnkJIUKXB8xeBUiOT1YsqUpBz5yCKcfyH19+BIlUe9qdkJmcdDMuJNyW
         BYyDfxeb1etMSSuT8qlpoqoe/zfYu5MXX6edivOAGtACaIEJ5o/5QYWo49GrkU/573/a
         TLIw==
X-Gm-Message-State: APjAAAWXMpCn2fnU7/czobUeY4pESFUzZ/a/xZM3nqwceYZlmyQ7jFeL
        Ycitok2L0r2nS8eiVQriCd2vxy68hBQ=
X-Google-Smtp-Source: APXvYqwSDIiwdkUUYIp/54pQYwm1kndz5TKydZWDJnAJ3gZbvdhCm9xDUUrFyYc2tZdkP3tQ2SlIyQ==
X-Received: by 2002:a17:906:8306:: with SMTP id j6mr3689337ejx.105.1579887866448;
        Fri, 24 Jan 2020 09:44:26 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id a9sm93588edm.82.2020.01.24.09.44.26
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 09:44:26 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id w15so3017345wru.4
        for <linux-arch@vger.kernel.org>; Fri, 24 Jan 2020 09:44:26 -0800 (PST)
X-Received: by 2002:a05:6512:78:: with SMTP id i24mr1931608lfo.10.1579887430457;
 Fri, 24 Jan 2020 09:37:10 -0800 (PST)
MIME-Version: 1.0
References: <20200123153341.19947-1-will@kernel.org> <20200123153341.19947-3-will@kernel.org>
 <CAKwvOdm2snorniFunMF=0nDH8-RFwm7wtjYK_Tcwkd+JZinYPg@mail.gmail.com> <20200124082443.GY14914@hirez.programming.kicks-ass.net>
In-Reply-To: <20200124082443.GY14914@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Jan 2020 09:36:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgbAfG6UZYd3PY3fmh5nCE191gY76Fn_g_D8nO64mdx-A@mail.gmail.com>
Message-ID: <CAHk-=wgbAfG6UZYd3PY3fmh5nCE191gY76Fn_g_D8nO64mdx-A@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] netfilter: Avoid assigning 'const' pointer to
 non-const pointer
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 24, 2020 at 12:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Just for curiosity's sake. What does clang actually do in that case?

This shouldn't necessarily be clang-specific. If the variable itself
is 'const', it might go into a read-only section. So trying to modify
it will quite possibly hit a SIGSEGV in user space (and in kernel
space cause an oops).

Note that that is different from a const pointer to something that
wasn't originally const. That's just a "error out at compile time if
somebody tries to write through it", but the const'ness can be cast
away, because all the 'const' really said was that the object can't be
modified through _that_ pointer, not in general.

(That also means that the compiler can't necessarily even optimize
multiple accesses through a const pointer away, because the object
might be modified through another pointer that aliases the const one -
you'd need to also mark it "restrict" to tell the compiler that no
other pointer will alias).

                 Linus
