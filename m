Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4608F256420
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 04:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgH2CaO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 22:30:14 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:33625 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgH2CaM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 22:30:12 -0400
Received: by mail-il1-f193.google.com with SMTP id o16so2299330ilq.0;
        Fri, 28 Aug 2020 19:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FWBdAR56vGsyD+K5WMDJgqnCjlKsqb/5OQolFXido18=;
        b=taKjNwO2anzo+7/r4+RofzT/y4HoQQM7wxk9OGIzD3T8DUu9L9E7hZw8MxUeiG/Ei2
         sDxjR7R60lEikcIiZUwY+pfkGC7mNNaq/s8GBJjwjg7Qt9prDK5/PxuFHgKQfCQAsvnT
         cDZ5t9/x+enQ882CfWAtZvYxWeu/wvgZtNX9Z8sE6tgq3GixmdxHpuqnC3NvdDjG6t+L
         VOOFg2Qo2K3HRmB7ttsn/FMwcf/d5Z7V0serpcEahwM5VKayXiTUy4HLMAtCHE8hfsBS
         v4mTwOdjqekPBox83CpvTkNP0mKdWhWk9l6Xuv9s2f5wvPlHffdXBYW1D1tvLy3nQJQG
         VJ5Q==
X-Gm-Message-State: AOAM533W6TCUHqWcchJvtizi2R1wS3KfS47UFVkOtWbFvazDmjjQ/gVm
        YRE9ZGtoUsFf0nIdqv64wcKxAuYVZERKZ+qd6FR9C63GF5ltqQ==
X-Google-Smtp-Source: ABdhPJwdx3k8973XdZoPb0cdWYqZYVJ0E8TucbcmdeUksx3aepJEr0YX5Zy1G6eRyL695Z0rwix5N9vQkVvSXB71PUw=
X-Received: by 2002:a92:9186:: with SMTP id e6mr1320010ill.278.1598668211557;
 Fri, 28 Aug 2020 19:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200827161237.889877377@infradead.org> <20200827161754.594247581@infradead.org>
 <20200828084851.GQ1362448@hirez.programming.kicks-ass.net>
 <20200828181341.c1da066360c6085d48850e22@kernel.org> <20200828091813.GU1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200828091813.GU1362448@hirez.programming.kicks-ass.net>
From:   Cameron <cameron@moodycamel.com>
Date:   Fri, 28 Aug 2020 22:29:55 -0400
Message-ID: <CAFCw3dqhd35mdFE_SjUYtLrxNUYwdO-iFAonZ1OXu9CGBsyGrw@mail.gmail.com>
Subject: Re: [RFC][PATCH 7/7] kprobes: Replace rp->free_instance with freelist
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 28, 2020 at 5:18 AM <peterz@infradead.org> wrote:
> So the freelist->refs thing is supposed to pin freelist->next for
> concurrent usage, but if we instantly stick it on the
> current->kretprobe_instances llist while it's still elevated, we'll
> overwrite ->next, which would be bad.

I thought about this some more, and actually, it should be safe.

The next is not supposed to be changed while the node has non-zero
ref-count, true, but this is only important while the node is in the freelist.
If it's never added back to the freelist, then there is no problem (the
overwritten next may be read but never used).

But even if it is later re-added to the freelist, as long as the refcount is
still above zero, the node won't actually be in the list right away, and
again its next won't matter. When the refcount finally goes down to zero,
it will be put on the list but its next will be blindly overwritten at
that point.

Cameron
