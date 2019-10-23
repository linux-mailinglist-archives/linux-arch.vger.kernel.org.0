Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4D2E207C
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 18:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407242AbfJWQYs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 12:24:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42090 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404804AbfJWQYr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Oct 2019 12:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571847887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eanOm+wc4jMiTMvGZZMqtnxXgjKabvAJwYAPnub5fDU=;
        b=aRXrGlK6nW9STh26MP1i9tGRoLNhbL30i8GgsZ0Pgs/oDlSj0BkDp/Qtp+j0YrkI1HzF0B
        YYbH4l+8L85mJKH3kxw4CZWJv9mro3Ez9rDokap2RUHnxcyoUhjoMlfGkSo49RM/YWAZhP
        NteRVnptFFYq9zOy78qDHJjTgI5cAv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-nn_WxBf4PueDGKR47J5rTQ-1; Wed, 23 Oct 2019 12:24:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB51780183D;
        Wed, 23 Oct 2019 16:24:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 364AE6362F;
        Wed, 23 Oct 2019 16:24:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 23 Oct 2019 18:24:39 +0200 (CEST)
Date:   Wed, 23 Oct 2019 18:24:32 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Marco Elver <elver@google.com>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Potapenko <glider@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>,
        Daniel Lustig <dlustig@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v2 1/8] kcsan: Add Kernel Concurrency Sanitizer
 infrastructure
Message-ID: <20191023162432.GC14327@redhat.com>
References: <20191017141305.146193-1-elver@google.com>
 <20191017141305.146193-2-elver@google.com>
 <20191022154858.GA13700@redhat.com>
 <CANpmjNPUT2B3rWaa=5Ee2Xs3HHDaUiBGpG09Q4h9Gemhsp9KFw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CANpmjNPUT2B3rWaa=5Ee2Xs3HHDaUiBGpG09Q4h9Gemhsp9KFw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: nn_WxBf4PueDGKR47J5rTQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/22, Marco Elver wrote:
>
> On Tue, 22 Oct 2019 at 17:49, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Just for example. Suppose that task->state =3D TASK_UNINTERRUPTIBLE, th=
is task
> > does __set_current_state(TASK_RUNNING), another CPU does wake_up_proces=
s(task)
> > which does the same UNINTERRUPTIBLE -> RUNNING transition.
> >
> > Looks like, this is the "data race" according to kcsan?
>
> Yes, they are "data races". They are probably not "race conditions" thoug=
h.
>
> This is a fair distinction to make, and we never claimed to find "race
> conditions" only

I see, thanks, just wanted to be sure...

> KCSAN's goal is to find *data races* according to the LKMM.  Some data
> races are race conditions (usually the more interesting bugs) -- but
> not *all* data races are race conditions. Those are what are usually
> referred to as "benign", but they can still become bugs on the wrong
> arch/compiler combination. Hence, the need to annotate these accesses
> with READ_ONCE, WRITE_ONCE or use atomic_t:

Well, if I see READ_ONCE() in the code I want to understand why it was
used. Is it really needed for correctness or we want to shut up kcsan?
Say, why should wait_event(wq, *ptr) use READ_ONCE()? Nevermind, please
forget.

Btw, why __kcsan_check_watchpoint() does user_access_save() before
try_consume_watchpoint() ?

Oleg.

