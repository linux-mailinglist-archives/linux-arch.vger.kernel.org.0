Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE1C254F8C
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 21:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgH0T5k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 15:57:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33583 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgH0T5k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 15:57:40 -0400
Received: by mail-io1-f65.google.com with SMTP id g14so7172016iom.0;
        Thu, 27 Aug 2020 12:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mw0guraU922S6MNBxpmTvWKEzmeYw8ef+s1RqnYSqcc=;
        b=qaqmu3sQ7/jMwtZ3rYPCGM1kNq0sO3BYVuRhoNUUUtcln1IN0/V3l4gLcsMvsQ3q9g
         IWA7A6ajUEXXt9S6C5pd2g5vtst3qAKZ4ct+zk+A+HEdaNRdQyzslj3/wKpbohty8/cI
         Zfpy/KjoGWZ+uiwJSH5lj5BxpGfC9CUdzN4n5Ee6elxMyFCW0LzabtYI8dzhjZPtOGYR
         USY+1Tsvk2/8u/xSDnOv0ITkKaPRsSf02o+el45ptcRbEpeoomhSnC9VVFUHOPhz7cD/
         F6LULWudhx5fsCGU4TIWogJo/pBxmzKef41MIICltGksRO+IA8WaWN9IsWGvia4C9nMr
         4dXg==
X-Gm-Message-State: AOAM5304GEYSuz/i2qz3VIlpPGapd3nmHRF2lmgtU+66URNEJtvNq3XS
        ySJLg9/C2geWoHfE2NQLb1gZHWUSJ4QZIqJcRSg=
X-Google-Smtp-Source: ABdhPJzj9g4Bi6z6ehNaMrgbd7yprxWAIe9eAWz1heNeg9PvMDqAD3QXkJo8GsOVVzCW9BspJWjCRntAj0rCDls+Fh0=
X-Received: by 2002:a6b:8dc7:: with SMTP id p190mr5176853iod.209.1598558258904;
 Thu, 27 Aug 2020 12:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200827161237.889877377@infradead.org> <20200827161754.535381269@infradead.org>
 <20200827190804.GA128237@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
In-Reply-To: <20200827190804.GA128237@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
From:   Cameron <cameron@moodycamel.com>
Date:   Thu, 27 Aug 2020 15:57:22 -0400
Message-ID: <CAFCw3do_4TrZSQ6kYQ7Y1RYTuD+PfXRyZFp7gSDs2oUXrBZGqQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 6/7] freelist: Lock less freelist
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 27, 2020 at 3:08 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> So if try_cmpxchg_acquire() fails, we don't have ACQUIRE semantics on
> read of the new list->head, right? Then probably a
> smp_mb__after_atomic() is needed in that case?

Yes, there needs to be an acquire on the head after a failed cmpxchg;
does the atomic_fetch_add following that not have acquire semantics?

Cameron
