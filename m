Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5214411D441
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2019 18:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbfLLRlx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Dec 2019 12:41:53 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38038 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730198AbfLLRlx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Dec 2019 12:41:53 -0500
Received: by mail-lj1-f195.google.com with SMTP id k8so3232343ljh.5
        for <linux-arch@vger.kernel.org>; Thu, 12 Dec 2019 09:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bMM9+SXbUifsEu+Y3zqfvwzhjRsedDBd5kfOwAh/UwA=;
        b=MAwdhQ2ApXj+Y01Th4BCE3RSlffcMF2vn+S1n9g9eLPqUXBxqb7H1E20UVL+9mb/zo
         TUamH+60U4LyvobpVidwKOG160coaIFky35EjHAPgaruzcWX7fUztBbagb0MZDX0xKZK
         b+3B1PXWXfIs13GZ1+vXd3HB1o38BkFLHhGiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bMM9+SXbUifsEu+Y3zqfvwzhjRsedDBd5kfOwAh/UwA=;
        b=F97xO4wZ28MeiiDpeaZvYXRD205oOfbF6Sd8bLo2WNPV2lMmFEghLMGwaVtrDq36af
         QnJW47EYKsksr7+CyP023vIGkA9y3QcVcQ6+vHnYbAAMafqaGEnP9fyUWQbVy1bqIOZg
         N7lHwlU6SQR5eOF7at9rKehuXwRqkO4Cq3U8HkCaXGKyI5S4tGsH0qApnz9BgCsgbxR7
         vIZh4xWJlNs5aVB+yQk8NctGQqi3zGFLPB6kjWmNU50pS7fKoLFiYpkmTaWNRCwEWWry
         Q0cI0n9RnEhPANF8IRXfevyWcBIyhzRqioXM+0jsdQxpmmnYu8JXcO6gyJDXcPAX2v4e
         RlSg==
X-Gm-Message-State: APjAAAXeDRZU3KMxtgk6uD4BbFbsOx2TREi6Wvj37IfFyxVtlCZ2HBwN
        f1zv0PChZgh6799owB1oHZL+225RWXM=
X-Google-Smtp-Source: APXvYqz6GjuxCAVGnWdic+h4L0k4HAGGtFMNE62bSm3INnD/Dy0RjwjKayXe8q6/xbb+5+ERBMklMw==
X-Received: by 2002:a2e:9e03:: with SMTP id e3mr6830352ljk.186.1576172509713;
        Thu, 12 Dec 2019 09:41:49 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id q13sm3785115ljj.63.2019.12.12.09.41.48
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 09:41:48 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id d20so3197000ljc.12
        for <linux-arch@vger.kernel.org>; Thu, 12 Dec 2019 09:41:48 -0800 (PST)
X-Received: by 2002:a2e:241a:: with SMTP id k26mr6727345ljk.26.1576172507997;
 Thu, 12 Dec 2019 09:41:47 -0800 (PST)
MIME-Version: 1.0
References: <87blslei5o.fsf@mpe.ellerman.id.au> <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au> <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net>
In-Reply-To: <20191212104610.GW2827@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Dec 2019 09:41:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
Message-ID: <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
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

On Thu, Dec 12, 2019 at 2:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> +#ifdef GCC_VERSION < 40800

Where does that 4.8 version check come from, and why?

Yeah, I know, but this really wants a comment. Sadly it looks like gcc
bugzilla is down, so

   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145

currently gives an "Internal Server Error" for me.

[ Delete the horrid code we have because of gcc bugs ]

> +#else /* GCC_VERSION < 40800 */
> +
> +#define READ_ONCE_NOCHECK(x)                                           \
> +({                                                                     \
> +       typeof(x) __x = *(volatile typeof(x))&(x);                      \

I think we can/should just do this unconditionally if it helps th eissue.

Maybe add a warning about how gcc < 4.8 might mis-compile the kernel -
those versions are getting close to being unacceptable for kernel
builds anyway.

We could also look at being stricter for the normal READ/WRITE_ONCE(),
and require that they are

 (a) regular integer types

 (b) fit in an atomic word

We actually did (b) for a while, until we noticed that we do it on
loff_t's etc and relaxed the rules. But maybe we could have a
"non-atomic" version of READ/WRITE_ONCE() that is used for the
questionable cases?

              Linus
