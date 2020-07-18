Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CF2224BF1
	for <lists+linux-arch@lfdr.de>; Sat, 18 Jul 2020 16:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgGROlY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Jul 2020 10:41:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgGROlY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 18 Jul 2020 10:41:24 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0450521775
        for <linux-arch@vger.kernel.org>; Sat, 18 Jul 2020 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595083283;
        bh=dmEgNW5VbAFeNYVCYzm5DHh+GZ2HAhVpvEA/afSGYk8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=czALAJCOZ7586Awrv9GznRMNKeV/qdgPQJFCXCCfE15k5wnr8ifFsqlY3oV7mCnuO
         Q4Byrexj0+FEgdcIrZDW46mzYt0GKGFxLsc13HJha2aWxv5/0ZyAwSifiXG+EkkYYw
         6q8zsKSjIQOgjsaYChVhyEqPQnJBNzq4ogGdEHRY=
Received: by mail-wm1-f42.google.com with SMTP id c80so18391160wme.0
        for <linux-arch@vger.kernel.org>; Sat, 18 Jul 2020 07:41:22 -0700 (PDT)
X-Gm-Message-State: AOAM532q69FqSb9TPxhkrXYBWneR4lUzhGVK8aIr3fqF2AocHQgoRZ7Q
        1sgS4Vm71qSuWbY66DvZqF7ChvbQYxmMV+gWC2NDig==
X-Google-Smtp-Source: ABdhPJyW8HJzd/bIocRzxwAX14QSJxaW6VGWP36zZ9S5wOQEKzeQ9o9fEK2iENYr8TT19ujOO7fnUUtzTnjw/TsJqVI=
X-Received: by 2002:a1c:e4d4:: with SMTP id b203mr14776945wmh.49.1595083281508;
 Sat, 18 Jul 2020 07:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200716182208.180916541@linutronix.de> <20200716185424.011950288@linutronix.de>
 <202007161336.B993ED938@keescook> <87d04vt98w.fsf@nanos.tec.linutronix.de>
 <202007171045.FB4A586F1D@keescook> <87mu3yq6sf.fsf@nanos.tec.linutronix.de>
 <CALCETrXz_vEySQJ=f3MTPG9XjZS7U0P-diJE9j_+0KRa_Kie=Q@mail.gmail.com> <875zakq56t.fsf@nanos.tec.linutronix.de>
In-Reply-To: <875zakq56t.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 18 Jul 2020 07:41:09 -0700
X-Gmail-Original-Message-ID: <CALCETrU-z_73BsKwNq0fTDEg7tVicd=jOEaq-6LnH24uNWShDg@mail.gmail.com>
Message-ID: <CALCETrU-z_73BsKwNq0fTDEg7tVicd=jOEaq-6LnH24uNWShDg@mail.gmail.com>
Subject: Re: [patch V3 01/13] entry: Provide generic syscall entry functionality
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 18, 2020 at 7:16 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Andy Lutomirski <luto@kernel.org> writes:
> > On Fri, Jul 17, 2020 at 12:29 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> The alternative is to play nasty games with TIF_IA32, TIF_ADDR32 and
> >> TIF_X32 to free up bits for 32bit and make the flags field 64 bit on 64
> >> bit kernels, but I prefer to do the above seperation.
> >
> > I'm all for cleaning it up, but I don't think any nasty games would be
> > needed regardless.  IMO at least the following flags are nonsense and
> > don't belong in TIF_anything at all:
> >
> > TIF_IA32, TIF_X32: can probably be deleted.  Someone would just need
> > to finish the work.
> > TIF_ADDR32: also probably removable, but I'm less confident.
> > TIF_FORCED_TF: This is purely a ptrace artifact and could easily go
> > somewhere else entirely.
> >
> > So getting those five bits back would be straightforward.
> >
> > FWIW, TIF_USER_RETURN_NOTIFY is a bit of an odd duck: it's an
> > entry/exit word *and* a context switch word.  The latter is because
> > it's logically a per-cpu flag, not a per-task flag, and the context
> > switch code moves it around so it's always set on the running task.
>
> Gah, I missed the context switch thing of that. That stuff is hideous.

It's also delightful because anything that screws up that dance (such
as failure to do the exit-to-usermode path exactly right) likely
results in an insta-root-hole.  If we fail to run user return
notifiers, we can run user code with incorrect syscall MSRs, etc.
