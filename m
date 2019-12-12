Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7632A11D817
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2019 21:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbfLLUuN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Dec 2019 15:50:13 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45179 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730804AbfLLUuN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Dec 2019 15:50:13 -0500
Received: by mail-lf1-f67.google.com with SMTP id 203so267881lfa.12
        for <linux-arch@vger.kernel.org>; Thu, 12 Dec 2019 12:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=udrNHrYblR3sF99SQEkYkwez4FCarU/iIh5v4su3FS8=;
        b=bkVtv5h8m32kLkiXM0qzlbz+nqjHfWFk9/qgPuPRhcgkiw0ZGyA729E8BGkFqzS3Dp
         q+Wa3RFyS+SBMMZulr9ppWHo8LKoN71JFOrHQs6VbNoqHdluxrgUNcjbxTHasQy97nOf
         M7t7yc8gf4qDYxsmtgtXGgGLWzQC2DeoAcm+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=udrNHrYblR3sF99SQEkYkwez4FCarU/iIh5v4su3FS8=;
        b=C6nzk/VWHt5nZVeh12BzrdDtDOkAgc833EzixETKt8VF0yjs7U9R3qehMpf7wWtGd9
         ubCX17kop/DLaREgQhy/bNVzohPBKimOs0Cfao9i1NlsB41eY4YJdR5cG+rUD3kmnrnH
         iToecKZDgFu4+Abd/c3TZcjAATaGDDyvRMJPGu9Q2npsXFqU91hMNMmBL7bDWVonlOM6
         23tFXEpJEbhn4StiFr7CFU8A9cmMk1QkkSgnTfRE4csAKy+9WBs6VHi6tJJBRxxxUtoe
         M1ydjh4xvcmEbvEaNAq9cDsVKYNv46k8aHzaZrw9jOOClssJh2F4FRXOgSEio0xYa9ZQ
         vt0A==
X-Gm-Message-State: APjAAAXtHawkenwEBSmT39SvKSXY+cM3JAartlrRDBUtJAlno5ZD9qdR
        N2I1CVhprfEytEsjLzgeGiTgfa9OpGg=
X-Google-Smtp-Source: APXvYqxZ/5PXxiCI1e8JC90XSpaS2479xNBPcJNMygcEuY5jN6tFPePRniuc+1Bc+dD7q09YowpovA==
X-Received: by 2002:a19:cc49:: with SMTP id c70mr6938239lfg.73.1576183810410;
        Thu, 12 Dec 2019 12:50:10 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id z15sm3580264ljm.13.2019.12.12.12.50.08
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 12:50:09 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id n25so316107lfl.0
        for <linux-arch@vger.kernel.org>; Thu, 12 Dec 2019 12:50:08 -0800 (PST)
X-Received: by 2002:a19:23cb:: with SMTP id j194mr6971490lfj.79.1576183808614;
 Thu, 12 Dec 2019 12:50:08 -0800 (PST)
MIME-Version: 1.0
References: <87blslei5o.fsf@mpe.ellerman.id.au> <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au> <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck> <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck>
In-Reply-To: <20191212193401.GB19020@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Dec 2019 12:49:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
Message-ID: <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
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

On Thu, Dec 12, 2019 at 11:34 AM Will Deacon <will@kernel.org> wrote:
>
> The root of my concern in all of this, and what started me looking at it in
> the first place, is the interaction with 'typeof()'. Inheriting 'volatile'
> for a pointer means that local variables in macros declared using typeof()
> suddenly start generating *hideous* code, particularly when pointless stack
> spills get stackprotector all excited.

Yeah, removing volatile can be a bit annoying.

For the particular case of the bitops, though, it's not an issue.
Since you know the type there, you can just cast it.

And if we had the rule that READ_ONCE() was an arithmetic type, you could do

    typeof(0+(*p)) __var;

since you might as well get the integer promotion anyway (on the
non-volatile result).

But that doesn't work with structures or unions, of course.

I'm not entirely sure we have READ_ONCE() with a struct. I do know we
have it with 64-bit entities on 32-bit machines, but that's ok with
the "0+" trick.

               Linus
