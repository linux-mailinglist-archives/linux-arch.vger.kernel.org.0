Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B61341133
	for <lists+linux-arch@lfdr.de>; Fri, 19 Mar 2021 00:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhCRXtN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Mar 2021 19:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhCRXsz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Mar 2021 19:48:55 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC69C061761
        for <linux-arch@vger.kernel.org>; Thu, 18 Mar 2021 16:48:55 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id l4so2515951vsc.7
        for <linux-arch@vger.kernel.org>; Thu, 18 Mar 2021 16:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w4SsUNnog1rCkxnTwPGBzmgfbYVmtvLwFsZIIDtRJ+0=;
        b=tODKum7fYlaP1p1/wInlRZv3OQMdfXJCpiBT7MtQvTeiTInxAIccKNZwbuStHykgX3
         pRr40h9mudP1dFh48XCe0B1EMgnJcSgbjagFRqIbPF47JfIw3hqWAW02qmqzw4JIXudz
         snxbbOtqclC4Lv3msvK7EpgiJaio9ooDeRrV7xs3WxxWoANXDrrh620DCmhwBCkpz9VV
         DbB0XB7ayvEMnQzN/DRg2GCM/4XFWT7sKKJO07hT4K2b0cRrMSrUUreDquUusRAW5V4O
         NMWrcZjLq44F3N7hMmnke7yr9/YdGfdRQ9JD6SCye+TXaalPNgyyWzK8ZktScxsbGGoi
         /Mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4SsUNnog1rCkxnTwPGBzmgfbYVmtvLwFsZIIDtRJ+0=;
        b=Q+ZNq5uBDv5YYU3K2QBROrOsLluI6fFrpjO62yVOvgz+RaFDP5pahHVhJSiJ7tDBpL
         6ZcSt+mFu1jXEPdBODQSx2oJURoUJvJq3KYH2VtxnuKBkh8krjSfOlqp4ghmcV8sSh4M
         FmfuMJUQ1G9l8ejN8ntLL3jEWDJ2pV/RyaOgfAjVt7T5SRAueoqWDcWk3UHDmvnsbzfA
         9t8KcbIv6ruaK8gvfuX7c5+wnvbetGTQ8SFdM8ybr8sNOUwFJdSDZ9U6Smi0Kx50O+oV
         SME0+S+g8rnWfVK+6wyNe0hrLkLZ4S62Ss21kEjp+lltC9oqIq5PTnJw53VaI1G/jrC9
         jKJA==
X-Gm-Message-State: AOAM533q+NNBYTb6cFTxoA1L0Btyhx6+zUPK63wFyJi/dnV4m8I9+dzH
        EsoWtTMafB1z/K3jJwc8sNfX18odCAxoi14GdOGQtA==
X-Google-Smtp-Source: ABdhPJzbqtERqnP82xx5uHkisRqkk8CIF+77aYgiFY0OIofKP/nQ8IPXRpr1qeG2yOzhWdw89ZfJnXTYr43XinbZUe8=
X-Received: by 2002:a05:6102:124e:: with SMTP id p14mr1245907vsg.14.1616111334467;
 Thu, 18 Mar 2021 16:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com>
 <20210318171111.706303-2-samitolvanen@google.com> <YFPUNlOomp173o5B@hirez.programming.kicks-ass.net>
In-Reply-To: <YFPUNlOomp173o5B@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 18 Mar 2021 16:48:43 -0700
Message-ID: <CABCJKufkQay5Fk5mZspn4PY2+mBC0CqC5t9QGkKafX4vUQv6Lg@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] add support for Clang CFI
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        bpf <bpf@vger.kernel.org>, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 18, 2021 at 3:29 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Mar 18, 2021 at 10:10:55AM -0700, Sami Tolvanen wrote:
> > +static void update_shadow(struct module *mod, unsigned long base_addr,
> > +             update_shadow_fn fn)
> > +{
> > +     struct cfi_shadow *prev;
> > +     struct cfi_shadow *next;
> > +     unsigned long min_addr, max_addr;
> > +
> > +     next = vmalloc(SHADOW_SIZE);
> > +
> > +     mutex_lock(&shadow_update_lock);
> > +     prev = rcu_dereference_protected(cfi_shadow,
> > +                                      mutex_is_locked(&shadow_update_lock));
> > +
> > +     if (next) {
> > +             next->base = base_addr >> PAGE_SHIFT;
> > +             prepare_next_shadow(prev, next);
> > +
> > +             min_addr = (unsigned long)mod->core_layout.base;
> > +             max_addr = min_addr + mod->core_layout.text_size;
> > +             fn(next, mod, min_addr & PAGE_MASK, max_addr & PAGE_MASK);
> > +
> > +             set_memory_ro((unsigned long)next, SHADOW_PAGES);
> > +     }
> > +
> > +     rcu_assign_pointer(cfi_shadow, next);
> > +     mutex_unlock(&shadow_update_lock);
> > +     synchronize_rcu_expedited();
>
> expedited is BAD(tm), why is it required and why doesn't it have a
> comment?

Ah, this uses synchronize_rcu_expedited() because we have a case where
synchronize_rcu() hangs here with a specific SoC family after the
vendor's cpu_pm driver powers down CPU cores. Would you say expedited
is bad enough that we should avoid it here? The function is called
only when kernel modules are loaded or unloaded, so not very
frequently.

Sami
