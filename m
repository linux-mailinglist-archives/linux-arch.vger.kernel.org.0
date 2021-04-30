Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E250036F5DB
	for <lists+linux-arch@lfdr.de>; Fri, 30 Apr 2021 08:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhD3Gqk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Apr 2021 02:46:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41246 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230394AbhD3Gqj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Apr 2021 02:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619765151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PFZmzCqPtD1TeQ1IgnxgwBuBBj2UfpUYGVhQ61V9gY0=;
        b=CO1ZtfocqTxIz6aW0nd/4+5Y9Yz4QjnUh+TbPWjWzaTK7+XtPzCLTHUB9sBspp+qoA9r31
        Lt6KUWv0GIPRF+EwGce5q45LOf/8sOfQQMuCOthTDWKdiym4vaK0bKSvVBnfVzUvwW0kk4
        rxpPM0brZ8OkDEGQCoXHtIAcHgkpWP4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-bVvfBOJoOuGwtxj_hE5rSQ-1; Fri, 30 Apr 2021 02:45:46 -0400
X-MC-Unique: bVvfBOJoOuGwtxj_hE5rSQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B23AB802939;
        Fri, 30 Apr 2021 06:45:42 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-115-124.ams2.redhat.com [10.36.115.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A74C5D9C6;
        Fri, 30 Apr 2021 06:45:27 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: extending ucontext (Re: [PATCH v26 25/30] x86/cet/shstk: Handle
 signals for shadow stack)
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
        <20210427204315.24153-26-yu-cheng.yu@intel.com>
        <CALCETrVTeYfzO-XWh+VwTuKCyPyp-oOMGH=QR_msG9tPQ4xPmA@mail.gmail.com>
Date:   Fri, 30 Apr 2021 08:45:40 +0200
In-Reply-To: <CALCETrVTeYfzO-XWh+VwTuKCyPyp-oOMGH=QR_msG9tPQ4xPmA@mail.gmail.com>
        (Andy Lutomirski's message of "Wed, 28 Apr 2021 16:03:55 -0700")
Message-ID: <87a6pgb78r.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Andy Lutomirski:

> The kernel has:
>
> struct rt_sigframe {
>     char __user *pretcode;
>     struct ucontext uc;
>     struct siginfo info;
>     /* fp state follows here */
> };
>
> This is roughly the actual signal frame.  But userspace does not have
> this struct declared, and user code does not know the sizes of the
> fields.  So it's accessed in a nonsensical way.  The signal handler
> function is passed a pointer to the whole sigframe implicitly in RSP,
> a pointer to &frame->info in RSI, anda pointer to &frame->uc in RDX.
> User code can *find* the fp state by following a pointer from
> mcontext, which is, in turn, found via uc:
>
> struct ucontext {
>     unsigned long      uc_flags;
>     struct ucontext  *uc_link;
>     stack_t          uc_stack;
>     struct sigcontext uc_mcontext;  <-- fp pointer is in here
>     sigset_t      uc_sigmask;    /* mask last for extensibility */
> };

I must say that I haven't reviewed this in detail, but for historic
reasons, glibc userspace has a differently-sized sigset_t.  So the
kernel ucontext (used in signals) and user ucontext (used for
swapcontext et al.) are already fully decoupled?

Thanks,
Florian

