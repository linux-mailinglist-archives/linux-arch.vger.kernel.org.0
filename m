Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258382295BA
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 12:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgGVKLb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 06:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbgGVKLa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 06:11:30 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBDEC0619DE
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 03:11:30 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id j11so1358213oiw.12
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 03:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aEtrJgbpsOebCukpCmfFytmRqvmav58R9V8W1bUHwwA=;
        b=s6BRFBxB6DMiogxI/Xm2pmaN/Ai2kw9dZQmuaL402WhVg97GWRniEH9T/OQcofUWeN
         DPVpgsvqUKyivc/NuczZMbgFas+2CTGG+umQFUgc9s46bY9B+GLXj4AaP4Dbfd/TeO3j
         w0EVj0odResMyiLFJ9blfrrlCZ//Wgg1KoJXeb2QprWdL7RLaxj/zHM7WKeLnFtQeEGM
         sGQGPqWYk5qfUWgbeAjHwX/DWhMwkrBLkr9LZKIpId6cfSXvEJQxi+5/Tmdw5NjOrA4A
         XpU65JnZSSOtJ4AxsxPz+I3x5G1lajtjeBNja3findd8APFrTf4YbdNbLPOKdM0QdTto
         ik2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aEtrJgbpsOebCukpCmfFytmRqvmav58R9V8W1bUHwwA=;
        b=ctiyB/aUeBqw50xq8vZgeGhKbxGId5xJmJe0d53Mga0RnA2x5ZjvzcNKNqDj6cJgvj
         wpd1/Fz/e7+RTorMCtQrp/6h1Me1wrhMhOje7uHB3+6z/fxAMAIYkA4DAQaY9nbjcWO4
         hBjDVr9M/cbdjpdYsyHsLsTEQuGygVplsxCy+pSLtOI9TuG5FbuwEvqTp2UAgT3/+1SV
         QhHKMk6DAH/eRa1JRbXHhMuDOkfd3OkmA63ahCe/VKmq48LJukM2Yc5tqf053VRuVPbu
         oaTo5QYl9EjfXVsG/ymWpx049kUnpM2anTH6yw3Nkm8wRsOaIf3iXx084Xm476v/7KLD
         X/yw==
X-Gm-Message-State: AOAM530hJxoKuVJBmR6u9z5QGE3ensa4o7bGOTsuUpuGYEY4CgK72qih
        tcnv94I5Mmhn2MOmlAGDmSzAhZiO4uw2oU3MyF9xBA==
X-Google-Smtp-Source: ABdhPJwUqgafZYtIGD4XYNh7yhysyeNlbnF3emANCKXh6lm6Wu/8rmOwf9BQuFcLLNZPp0ReZ2c3pNUO+g92ocqxRIo=
X-Received: by 2002:aca:cf4f:: with SMTP id f76mr6563659oig.172.1595412689438;
 Wed, 22 Jul 2020 03:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200721103016.3287832-1-elver@google.com> <20200721103016.3287832-9-elver@google.com>
 <20200721141859.GC10769@hirez.programming.kicks-ass.net>
In-Reply-To: <20200721141859.GC10769@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 22 Jul 2020 12:11:18 +0200
Message-ID: <CANpmjNM6C6QtrtLhRkbmfc3jLqYaQOvvM_vKA6UyrkWadkdzNQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] locking/atomics: Use read-write instrumentation for
 atomic RMWs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 21 Jul 2020 at 16:19, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jul 21, 2020 at 12:30:16PM +0200, Marco Elver wrote:
>
> > diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
> > index 6afadf73da17..5cdcce703660 100755
> > --- a/scripts/atomic/gen-atomic-instrumented.sh
> > +++ b/scripts/atomic/gen-atomic-instrumented.sh
> > @@ -5,9 +5,10 @@ ATOMICDIR=$(dirname $0)
> >
> >  . ${ATOMICDIR}/atomic-tbl.sh
> >
> > -#gen_param_check(arg)
> > +#gen_param_check(meta, arg)
> >  gen_param_check()
> >  {
> > +     local meta="$1"; shift
> >       local arg="$1"; shift
> >       local type="${arg%%:*}"
> >       local name="$(gen_param_name "${arg}")"
> > @@ -17,17 +18,24 @@ gen_param_check()
> >       i) return;;
> >       esac
> >
> > -     # We don't write to constant parameters
> > -     [ ${type#c} != ${type} ] && rw="read"
> > +     if [ ${type#c} != ${type} ]; then
> > +             # We don't write to constant parameters
> > +             rw="read"
> > +     elif [ "${meta}" != "s" ]; then
> > +             # Atomic RMW
> > +             rw="read_write"
> > +     fi
>
> If we have meta, should we then not be consistent and use it for read
> too? Mark?

gen_param_check seems to want to generate an 'instrument_' check per
pointer argument. So if we have 1 argument that is a constant pointer,
and one that isn't, it should generate different instrumentation for
each. By checking the argument type, we get that behaviour. Although
we are making the assumption that if meta indicates it's not a 's'tore
(with void return), it's always a read-write access on all non-const
pointers.

Switching over to checking only meta would always generate the same
'instrument_' call for each argument. Although right now that would
seem to work because we don't yet have an atomic that accepts a
constant pointer and a non-const one.

Preferences?

> >       printf "\tinstrument_atomic_${rw}(${name}, sizeof(*${name}));\n"
> >  }
> >
> > -#gen_param_check(arg...)
> > +#gen_params_checks(meta, arg...)
> >  gen_params_checks()
> >  {
> > +     local meta="$1"; shift
> > +
> >       while [ "$#" -gt 0 ]; do
> > -             gen_param_check "$1"
> > +             gen_param_check "$meta" "$1"
> >               shift;
> >       done
> >  }
> > @@ -77,7 +85,7 @@ gen_proto_order_variant()
> >
> >       local ret="$(gen_ret_type "${meta}" "${int}")"
> >       local params="$(gen_params "${int}" "${atomic}" "$@")"
> > -     local checks="$(gen_params_checks "$@")"
> > +     local checks="$(gen_params_checks "${meta}" "$@")"
> >       local args="$(gen_args "$@")"
> >       local retstmt="$(gen_ret_stmt "${meta}")"
> >
> > --
> > 2.28.0.rc0.105.gf9edc3c819-goog
> >
