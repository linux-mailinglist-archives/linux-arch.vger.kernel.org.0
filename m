Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD67955481
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2019 18:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfFYQac (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jun 2019 12:30:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43931 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfFYQac (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jun 2019 12:30:32 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfoKz-0003li-VM; Tue, 25 Jun 2019 18:30:30 +0200
Date:   Tue, 25 Jun 2019 18:30:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Florian Weimer <fweimer@redhat.com>
cc:     linux-api@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-x86_64@vger.kernel.org, linux-arch@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Carlos O'Donell <carlos@redhat.com>, x86@kernel.org
Subject: Re: Detecting the availability of VSYSCALL
In-Reply-To: <87v9wty9v4.fsf@oldenburg2.str.redhat.com>
Message-ID: <alpine.DEB.2.21.1906251824500.32342@nanos.tec.linutronix.de>
References: <87v9wty9v4.fsf@oldenburg2.str.redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 25 Jun 2019, Florian Weimer wrote:
> We're trying to create portable binaries which use VSYSCALL on older
> kernels (to avoid performance regressions), but gracefully degrade to
> full system calls on kernels which do not have VSYSCALL support compiled
> in (or disabled at boot).
>
> For technical reasons, we cannot use vDSO fallback.  Trying vDSO first
> and only then use VSYSCALL is the way this has been tackled in the past,
> which is why this userspace ABI breakage goes generally unnoticed.  But
> we don't have a dynamic linker in our scenario.

I'm not following. On newer kernels which usually have vsyscall disabled
you need to use real syscalls anyway, so why are you so worried about
performance on older kernels. That doesn't make sense.

> Is there any reliable way to detect that VSYSCALL is unavailable,
> without resorting to parsing /proc/self/maps or opening file
> descriptors?

Not that I'm aware of except

    sigaction(SIG_SEGV,....)

/me hides
 
> Should we try mapping something at the magic address (without MAP_FIXED)
> and see if we get back a different address?  Something in the auxiliary
> vector would work for us, too, but nothing seems to exists there
> unfortunately.

Would, but there is no such thing.

Thanks,

	tglx
