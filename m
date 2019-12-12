Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46E5911D60C
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2019 19:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbfLLSnZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Dec 2019 13:43:25 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33234 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730255AbfLLSnY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Dec 2019 13:43:24 -0500
Received: by mail-lf1-f67.google.com with SMTP id n25so50590lfl.0
        for <linux-arch@vger.kernel.org>; Thu, 12 Dec 2019 10:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=daP2x4GLzegqYAtGzoN/GqQWx/OgbUZpFEmzsIb9AuY=;
        b=ESVNK1Mwi4VakiBbtSIOLOxnFTfo9yicVGMiebqVDAAObXDl8gUPGjFP3V6AoTVKJc
         HXbX49wJTIP8gVq4DIOHImreynSyKqrAyaVA413Sj66yFki8qzqdppnMRHspROxc1wIy
         o3RYW91grmKJW3WGA8r4+DqCoBMnHPzXSZzsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=daP2x4GLzegqYAtGzoN/GqQWx/OgbUZpFEmzsIb9AuY=;
        b=YEEWW7pRxB0rOjQDvnH904CIDhhV4TYJ9ZyTRQJZLuK4qVmJPP7vk/wjSNW8GxVpvm
         x/XuoeJOQZFVPgHzkpZ0rWCKYFqRf2eJhy0/DYylgL+QDeXFykVSMK5R/XQQkj0EW154
         Y/E5MvlzP0c15X8I2OarR6xSPjkp6NwRJXRIEDWRKLKL9tuyVbPTk8PrTtU7WVneh4N+
         7MJ1a8Qfy48cWOcvnedC7Un3zPcYt7kkKa4EXYcdc15uaO8LuDDsvx/bFKxlPmJj9dx9
         K2tbEfuLL3Yakcmx8foe+dV0dYll1ybLn5KlNLQQYRWUNMnGTEG8eE9WZc5JpFFoXahY
         htjg==
X-Gm-Message-State: APjAAAWpsDydf4DziSD8xSkx4ox1qOQ4xWOiI68Z9e+GZAURsRLIJkR7
        gy67+RZrqc4LPYqTWdpzfbF/+1PESO4=
X-Google-Smtp-Source: APXvYqzY1pS1xh1Fabh3eDO/aYXllP0XCRcoruNoKY2BqaJ3CG2t2cKoQqL8Y40zYjAFWqMuQItt6w==
X-Received: by 2002:ac2:4316:: with SMTP id l22mr6705956lfh.115.1576176202475;
        Thu, 12 Dec 2019 10:43:22 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id y11sm3840416lfc.27.2019.12.12.10.43.21
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 10:43:21 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id l18so46702lfc.1
        for <linux-arch@vger.kernel.org>; Thu, 12 Dec 2019 10:43:21 -0800 (PST)
X-Received: by 2002:ac2:4946:: with SMTP id o6mr6694407lfi.170.1576176201157;
 Thu, 12 Dec 2019 10:43:21 -0800 (PST)
MIME-Version: 1.0
References: <87blslei5o.fsf@mpe.ellerman.id.au> <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au> <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com> <20191212180634.GA19020@willie-the-truck>
In-Reply-To: <20191212180634.GA19020@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Dec 2019 10:43:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
Message-ID: <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 12, 2019 at 10:06 AM Will Deacon <will@kernel.org> wrote:
>
> I'm currently trying to solve the issue by removing volatile from the bitop
> function signatures

I really think that's the wrong thing to do.

The bitop signature really should be "volatile" (and it should be
"const volatile" for test_bit, but I'm not sure anybody cares).

Exactly because it's simply valid to say "hey, my data is volatile,
but do an atomic test of this bit". So it might be volatile in the
caller.

Now, I generally frown on actual volatile data structures - because
the data structure volatility often depends on _context_. The same
data might be volatile in one context (when you do some optimistic
test on it without locking), but 100% stable in another (when you do
have a lock).

So I don't want to see "volatile" on data definitions ("jiffies" being
the one traditional exception), but marking things volatile in code
(because you know you're working with unlocked data) and then passing
them down to various helper functions - including the bitops ones - is
quite traditional and accepted.

In other words, 'volatile" should be treated the same way "const" is
largely treated in C.

A pointer to "const" data doesn't mean that the data is read-only, or
that it cannot be modified _elsewhere_, it means that within this
particular context and this copy of the pointer we promise not to
write to it.

Similarly, a pointer to "volatile" data doesn't mean that the data
might not be stable once you take a lock, for example. So it's ok to
have volatile pointers even if the data declaration itself isn't
volatile - you're stating something about the context, not something
fundamental about the data.

And in the context of the bit operations, "volatile" is the correct thing to do.

                     Linus
