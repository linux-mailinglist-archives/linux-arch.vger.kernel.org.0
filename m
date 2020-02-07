Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E88F31557CA
	for <lists+linux-arch@lfdr.de>; Fri,  7 Feb 2020 13:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgBGMce (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Feb 2020 07:32:34 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35702 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGMcd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Feb 2020 07:32:33 -0500
Received: by mail-lj1-f196.google.com with SMTP id q8so1968726ljb.2
        for <linux-arch@vger.kernel.org>; Fri, 07 Feb 2020 04:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jER99mriC9vlsKgoniDzTDraWAtVeo79r1G1mcS9/yo=;
        b=i+KNNInhNeKgdwb4M2pZ43rlElAqgkerzlqqO8vbqu9DY403/yiJYC7CJv7HV7K+R1
         cdWqsM0SulytZS06dkivMpbdGm5r1e35uHvedTJEz3jc4dutBWo0VkfPA3vDw73Q51uv
         vG8QeC9akDg0ntULb0IZ3zlpc1DL2KGAIHwHPgm0wbXUJGJGvhVJSJ3PIkU1BnstJSMb
         mBBekgKBJY2f428zZ0oqw2uryFUc6RLyAGVTHmcqQdyRNKgdKtRHf0shZNq6bk37xMVo
         m8Z36HySfjjaqBG8fIcUkqIxuU3bCggcBt52uKwsPIEd6cwUraw7KVVTecMZN3G3ZJRI
         8umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jER99mriC9vlsKgoniDzTDraWAtVeo79r1G1mcS9/yo=;
        b=dVLiBoaMVjJZtzvX7XGM56mVgCQ7WjUs22sKeU3THVIq5XMYpRuPVOZRsRYopwlWWg
         A5VO5kSKtLIQ8C6YBZ+tCvo+5nH8/UVpvuqFxpC5i/0MDDlJEJPnDBTR92xlX5B6MBKg
         ArcoEGzvGJ+7ZLtHz9lW8xtYnpRa7l2slIC7WvhoDQV0LTiSQnv9vMKWHEzZweWCfiI8
         EmH+4Qt46Vacy0h8f4xe7dQjX6+oV0EVWwP9Cw8YuYCUWrgKQKgUAUPDFaIEIr31WM1g
         l7GEA/dQyzmKTMk1vkF9nn/yUXoaJXQbiE+M6KrF0xXAubYdhf6Kb59JJ2Vfn2Iorigl
         rp+Q==
X-Gm-Message-State: APjAAAX8XkcJMzEa32nKuXHfko0YruX5ppb/uHo9Y2fWj+H3ueu1feQa
        7L9l0aFy0fwkpkFYLw3B3rHyL9wCsvP2WfpSb2A=
X-Google-Smtp-Source: APXvYqyaBbTdhXSQyw3jwcBEFFQYhB5h606+WnuhtKg8Y0mSzTh4+NF28dn5xD83wmDCdbp3B+IJ3XryahbQefUCmVg=
X-Received: by 2002:a2e:58c:: with SMTP id 134mr5146580ljf.12.1581078751991;
 Fri, 07 Feb 2020 04:32:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580882335.git.thehajime@gmail.com> <39e1313ff3cf3eab6ceb5ae322fcd3e5d4432167.1580882335.git.thehajime@gmail.com>
 <20200205093454.GG14879@hirez.programming.kicks-ass.net> <CAMoF9u3Jhqyvp3SpA3mUqPhS4zDuXP9GCUu_XsYx2etE0KGkcQ@mail.gmail.com>
 <20200205124908.GL14879@hirez.programming.kicks-ass.net> <CAMoF9u12nko0rBGT_iOgXtapuRitS9jSMzAoo8tTykn2dZGK7g@mail.gmail.com>
 <20200205171306.GP14879@hirez.programming.kicks-ass.net>
In-Reply-To: <20200205171306.GP14879@hirez.programming.kicks-ass.net>
From:   Octavian Purdila <tavi.purdila@gmail.com>
Date:   Fri, 7 Feb 2020 14:32:20 +0200
Message-ID: <CAMoF9u3qqJXwPiPnmbRXxs2NfPTVYxvHbbcdRnNR5+ZkTiAWuQ@mail.gmail.com>
Subject: Re: [RFC v3 01/26] asm-generic: atomic64: allow using generic
 atomic64 on 64bit platforms
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Hajime Tazaki <thehajime@gmail.com>,
        linux-um <linux-um@lists.infradead.org>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 5, 2020 at 7:13 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Feb 05, 2020 at 04:00:41PM +0200, Octavian Purdila wrote:
> > On Wed, Feb 5, 2020 at 2:49 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Feb 05, 2020 at 02:24:38PM +0200, Octavian Purdila wrote:
> > > > I was not aware that not allowing GENERIC_ATOMIC64 was intentional. I
> > >
> > > It might not have been, but presented with this patch, I feel like it
> > > should've been :-)
> > >
> > > > understand your point that a 64 bit architecture that can't handle 64
> > > > bit atomic operation is broken.
> > >
> > > (sadly they actually exist, I shall name no names)
> > >
> > > > One way to deal with this in LKL would be to use GCC atomic builtins
> > > > or if that doesn't work expose them as host operations. This would
> > > > keep LKL as a meta-arch that can run on multiple physical
> > > > architectures. I'll give it a try.
> > >
> > > What is this LKL you speak of and how does it do the 32bit atomics?
> > >
> >
> > LKL is a build of the Linux kernel as a library that can run in many
> > environments including multiple architectures and OSes [1]
>
> Thanks, I'll put it on the to-read list.
>
> > For 32bit atomics LKL also uses the asm-generic implementation. It is
> > very similar with generic 64bit atomic implementation and it is used
> > by multiple 32bit arches. I think this was my original reasoning for
> > this patch and not going with C11 atomics.
>
> Uh no, asm-generic/atomic.h is radically different from lib/atomic64.c.
>
> asm-generic/atomic.h builds all required atomic operations from
> cmpxchg() (loops), while lib/atomic64.c builds 64bit atomics by using a
> hashed set of spinlocks.
>
> The asm-generic stuff gives you real atomic ops, albeit sub-optimal,
> lib/atomic64.c gives you a turd.

Ah, yes, I overlooked that.

(I think that they are equivalent for LKL because it is a non-SMP arch
only at this moment, but I agree that the better approach is to have a
proper implementation in LKL)
