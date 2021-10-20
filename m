Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBFD43544B
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 22:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhJTUH4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 16:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbhJTUH4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 16:07:56 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02647C06161C
        for <linux-arch@vger.kernel.org>; Wed, 20 Oct 2021 13:05:41 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z11so786887lfj.4
        for <linux-arch@vger.kernel.org>; Wed, 20 Oct 2021 13:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0++TUycna+bE6Avhciu0oSb+ZwvvTLsg8M+asM8i1ao=;
        b=Ve/C0XG/xw8UyPAGxVwRPbpQH9RyAGe6NPgj4p4E7sLNs6ru46yKyU2Mo273jTGvAu
         Ig7Avg3/BtfJKmUHIBielU5BzXWEcSOvdhLp9P7itwhTM7l8nMLuKAqf9Prw682q73aZ
         2789HkXDUuVPBMBPyD6YLSKnDn2dksoJJlRsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0++TUycna+bE6Avhciu0oSb+ZwvvTLsg8M+asM8i1ao=;
        b=5gQW7CTtMrRRj4bGzNnyBqIFD3489mEq3hWcNfJWxdc21QkB+K0P46dtt2KPUt09P4
         4HamZR6c+3WwrgP0yd0bUV8KBzhglbpYkwFh5kIcz7QPka+P2F4g0sXK6AN0NimmIyBm
         QYnb1sDfCgGsaLC0VqpLP4+1cRdT/FVKdh4jnoUE7+rx2UzKuCbZDLvzEAfBea9D+pdF
         SQmsRzouPf21YpZ4Qb3r5IhP2YP6U/W1Xu726O8Ohq+tJPEvlifkHdFu5fwOvPPvtqoX
         pwEMRqfAB58VwWJYcD2Cc/J+pIulWaO6XmypjOURbIRxxDckxs4SdCng6fJ2I/ic0K3Z
         CzBQ==
X-Gm-Message-State: AOAM5335Yr4sdb6arREEAt+AkGxyZgoUbKE1iZ7eyZ2/9PvjeMQCCFSc
        cGvmC6uqe6+7Kvi3VwQMhYqHCctQobqP/Q==
X-Google-Smtp-Source: ABdhPJy5vwfSnvPJoRJKfTJv7qZoSmyUNBVJj270u5So2s0oHbYMLQ6/4UwQndhmh7qlsarfq/zfeg==
X-Received: by 2002:a05:6512:398f:: with SMTP id j15mr1158283lfu.523.1634760338040;
        Wed, 20 Oct 2021 13:05:38 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id u27sm267139lfm.275.2021.10.20.13.05.37
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 13:05:37 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id e19so46499ljk.12
        for <linux-arch@vger.kernel.org>; Wed, 20 Oct 2021 13:05:37 -0700 (PDT)
X-Received: by 2002:a2e:a407:: with SMTP id p7mr1286007ljn.68.1634760337033;
 Wed, 20 Oct 2021 13:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <87y26nmwkb.fsf@disp2133> <20211020174406.17889-13-ebiederm@xmission.com>
In-Reply-To: <20211020174406.17889-13-ebiederm@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Oct 2021 10:05:21 -1000
X-Gmail-Original-Message-ID: <CAHk-=whe-ixeDp_OgSOsC4H+dWTLDSuNDU2a0sE3p8DapNeCuQ@mail.gmail.com>
Message-ID: <CAHk-=whe-ixeDp_OgSOsC4H+dWTLDSuNDU2a0sE3p8DapNeCuQ@mail.gmail.com>
Subject: Re: [PATCH 13/20] signal: Implement force_fatal_sig
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 20, 2021 at 7:45 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Add a simple helper force_fatal_sig that causes a signal to be
> delivered to a process as if the signal handler was set to SIG_DFL.
>
> Reimplement force_sigsegv based upon this new helper.

Can you just make the old force_sigsegv() go away? The odd special
casing of SIGSEGV was odd to begin with, I think everybody really just
wanted this new "force_fatal_sig()" and allow any signal - not making
SIGSEGV special.

Also, I think it should set SIGKILL in p->pending.signal or something
like that - because we want this to trigger fatal_signal_pending(),
don't we?

Right now fatal_signal_pending() is only true for SIGKILL, I think.

               Linus
