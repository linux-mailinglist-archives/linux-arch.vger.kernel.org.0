Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673B422513D
	for <lists+linux-arch@lfdr.de>; Sun, 19 Jul 2020 12:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgGSKRN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Jul 2020 06:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSKRN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Jul 2020 06:17:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC79FC0619D2;
        Sun, 19 Jul 2020 03:17:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595153827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Klowtb+zpu2upHcc0/al6Z+g7rUSuNatngTABmSqQks=;
        b=q8WBW4lphpZf+Rpq1Cbtq7QgWkuGOkQnhsp20yFar8wiTi3gddfIDm+NyjZXpS2fG6rA+q
        nG+u1+A8/GifDOyHJe4mxZ6pq0OhvKaPDIOBpYTOIKKvcrn/YoixV5P5iwYLHRsu/SHrbB
        oabbWpe0eEH+8X31+lECGS4HW3og5wKDFwN9HWV0zdIh6E2oS5i9Ch6BOhIPYksPf0PS59
        HSzEz5B0gio3gV1tM43uyUPe2j/HmyVv99lFkpdKIIS5CZWoOK3Y3KH6ULxF3cL7tz/OT5
        Ye5LMOV4/wPXxTLQxm83eV6glbq19TpIa9HyJMKOa/DSXSJg/LWwwe+6zZl2oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595153827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Klowtb+zpu2upHcc0/al6Z+g7rUSuNatngTABmSqQks=;
        b=/icnqJkwLN5zSzDGZYcXzpGR7LI1HSuX35hwBCDMz7GGGc6gotQIlS2LCnsQLZ+UvWAWqy
        jn0fn49/bZ1nRjAQ==
To:     Andy Lutomirski <luto@kernel.org>
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
Subject: Re: [patch V3 01/13] entry: Provide generic syscall entry functionality
In-Reply-To: <CALCETrU-z_73BsKwNq0fTDEg7tVicd=jOEaq-6LnH24uNWShDg@mail.gmail.com>
References: <20200716182208.180916541@linutronix.de> <20200716185424.011950288@linutronix.de> <202007161336.B993ED938@keescook> <87d04vt98w.fsf@nanos.tec.linutronix.de> <202007171045.FB4A586F1D@keescook> <87mu3yq6sf.fsf@nanos.tec.linutronix.de> <CALCETrXz_vEySQJ=f3MTPG9XjZS7U0P-diJE9j_+0KRa_Kie=Q@mail.gmail.com> <875zakq56t.fsf@nanos.tec.linutronix.de> <CALCETrU-z_73BsKwNq0fTDEg7tVicd=jOEaq-6LnH24uNWShDg@mail.gmail.com>
Date:   Sun, 19 Jul 2020 12:17:07 +0200
Message-ID: <87v9ijollo.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:
> On Sat, Jul 18, 2020 at 7:16 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> Andy Lutomirski <luto@kernel.org> writes:
>> > FWIW, TIF_USER_RETURN_NOTIFY is a bit of an odd duck: it's an
>> > entry/exit word *and* a context switch word.  The latter is because
>> > it's logically a per-cpu flag, not a per-task flag, and the context
>> > switch code moves it around so it's always set on the running task.
>>
>> Gah, I missed the context switch thing of that. That stuff is hideous.
>
> It's also delightful because anything that screws up that dance (such
> as failure to do the exit-to-usermode path exactly right) likely
> results in an insta-root-hole.  If we fail to run user return
> notifiers, we can run user code with incorrect syscall MSRs, etc.

Looking at it deeper, having that thing in the loop is a pointless
exercise. This really wants to be done _after_ the loop.

Thanks,

        tglx
