Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D54C255372
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 06:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgH1EEH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 00:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgH1EEH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 00:04:07 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A39C061264;
        Thu, 27 Aug 2020 21:04:06 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id h10so3692903ioq.6;
        Thu, 27 Aug 2020 21:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pGq/lhS7z1CscFynP8v3j9ykp57TDwJZlPMQ1RLom5w=;
        b=M+GMWBOPeu019snfJtxa4zw8Ysge0SOqctk/DI82xg0dB/M9nXvnL8Ck39rw9h0emT
         U9jZEAZw3l5indDzQrQdnYsVUJSD3stUdDhN2CG6xx6qC9gisUAEs0WwJHO05IGcZ2G7
         OISD1kDZ8KYsSRDoMAMSC6XO3LEO/ySbZA4x3eF3qQOl6+/DFdjwHOgkFoCuXjm1voG7
         trQ6iADtrVSawbmPESZ5mqCQZLBLJjNMJrKi70gGcBhKQAHyBIMtVz8glohp9WC1Gir4
         wbLxloGJiVffln/hRpxpDE9oxggeSgUTgG1misTtCGv9Yw4sX7IgeSqE12uaCI3m/MM9
         Xg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pGq/lhS7z1CscFynP8v3j9ykp57TDwJZlPMQ1RLom5w=;
        b=LVz1seRufDAM4Kr9VZ99AsLm5v1zb6VCn9MgLfaCxMc3w1U95RoYVm3h9LM+iYauIC
         HX4dOElbyNZCOqJDJv0b/1rdDRDdeTOTrImk8QvWvify5NkcMzi0vBOPRrOuRF1WgJyT
         hvl1xHoyyVYNjjBjCbomB0w3xwwnNI8hS723Z+oG6WQTDOkmEmA0OMQVn3vV3o2LAF1p
         OfzjRMVutMhuiCITIIGyEyvm3oCX3M7YQTZ/Nt6ln+3h4x+2GfzuJ3yX/pxb/EwHtVBe
         itY1FGtQhK+BmVWprhqmYgkLZaNipPHVy+F6RHEGu6ust/RB6Vadgk4e5iIk2n5ocLlq
         GpRg==
X-Gm-Message-State: AOAM531umSwe2+razQ4iSZTFai7KI65yMRkIlI9HYDuGaKkRMqMSzt5C
        cQruqF0xe75FDRJ9F7cum/9GGt5TMRrQ52yJRj0=
X-Google-Smtp-Source: ABdhPJyQwRgVsCJ8RZ4kEl5wmOdoXFdnJsJaTnX0cQx/Rxiln2cRY640Qqr30KihfxKFO9SFcnZo/hgRuLOUh2bVK3Q=
X-Received: by 2002:a02:340c:: with SMTP id x12mr18279111jae.40.1598587445775;
 Thu, 27 Aug 2020 21:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200827161237.889877377@infradead.org> <20200827161754.535381269@infradead.org>
In-Reply-To: <20200827161754.535381269@infradead.org>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Fri, 28 Aug 2020 12:03:54 +0800
Message-ID: <CAJhGHyBBqdD7cpxDbRL3myGF7924EDrp0_-RLEd8m10dQGFXzA@mail.gmail.com>
Subject: Re: [RFC][PATCH 6/7] freelist: Lock less freelist
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Eddy_Wu@trendmicro.com,
        X86 ML <x86@kernel.org>, davem@davemloft.net,
        Steven Rostedt <rostedt@goodmis.org>,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 28, 2020 at 12:23 AM Peter Zijlstra <peterz@infradead.org> wrote:

> +static inline void __freelist_add(struct freelist_node *node, struct freelist_head *list)
> +{
> +       /*
> +        * Since the refcount is zero, and nobody can increase it once it's
> +        * zero (except us, and we run only one copy of this method per node at
> +        * a time, i.e. the single thread case), then we know we can safely


> +
> +               /*
> +                * OK, the head must have changed on us, but we still need to decrement
> +                * the refcount we increased.
> +                */
> +               refs = atomic_fetch_add(-1, &prev->refs);
> +               if (refs == REFS_ON_FREELIST + 1)
> +                       __freelist_add(prev, list);

I'm curious whether it is correct to just set the prev->refs to zero and return
@prev? So that it can remove an unneeded "add()&get()" pair (although in
an unlikely branch) and __freelist_add() can be folded into freelist_add()
for tidier code.

Thanks
Lai.
