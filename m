Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A46224BBA
	for <lists+linux-arch@lfdr.de>; Sat, 18 Jul 2020 16:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgGROQb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Jul 2020 10:16:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47236 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgGROQ3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Jul 2020 10:16:29 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595081787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=InESnWhhE1Lyrbm8RqL/G1i0QjcPEbAb4abQNdrt+bc=;
        b=ZA0vBN+SrOoNlxKj9fPmZs53XNpqeydqQ30JHCM1TiQIrq4FEa2B+ezj+nlrK2hW4pxtWS
        DSwRQNtcOFWyUKw77m14YurY6WpoOQJnbiS35d7QbVmhGxve7Kqb2Y1DgPKGLXEpYDYOS4
        oqoAziR7w2ayMO1EsUzU5G5BACkC3MkKzIC1mbbLKje8l038DFG8bJDFYWeHCPbvHLwrwD
        wz0iSwrRqslMZ9r2cLvPT98eVAHvW1hONwSwROSMngHDku7tUSDjwHh60DIs6K9UIkN2Xg
        T2JjpCXJmtonP5VWeUuROYj2AW4xVfxekliuTV2I2RTvtNy6yeEMXKfqzz9sxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595081787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=InESnWhhE1Lyrbm8RqL/G1i0QjcPEbAb4abQNdrt+bc=;
        b=Uz16ViUPG75XGv0PA6hTKa6ol+KLikD/0YIRqc3DiZjEqyUo0xmOSZzbt8Vl5Wuc4l8wWf
        vCyqhYdw8l3qFNAw==
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [patch V3 01/13] entry: Provide generic syscall entry functionality
In-Reply-To: <CALCETrXz_vEySQJ=f3MTPG9XjZS7U0P-diJE9j_+0KRa_Kie=Q@mail.gmail.com>
References: <20200716182208.180916541@linutronix.de> <20200716185424.011950288@linutronix.de> <202007161336.B993ED938@keescook> <87d04vt98w.fsf@nanos.tec.linutronix.de> <202007171045.FB4A586F1D@keescook> <87mu3yq6sf.fsf@nanos.tec.linutronix.de> <CALCETrXz_vEySQJ=f3MTPG9XjZS7U0P-diJE9j_+0KRa_Kie=Q@mail.gmail.com>
Date:   Sat, 18 Jul 2020 16:16:26 +0200
Message-ID: <875zakq56t.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:
> On Fri, Jul 17, 2020 at 12:29 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> The alternative is to play nasty games with TIF_IA32, TIF_ADDR32 and
>> TIF_X32 to free up bits for 32bit and make the flags field 64 bit on 64
>> bit kernels, but I prefer to do the above seperation.
>
> I'm all for cleaning it up, but I don't think any nasty games would be
> needed regardless.  IMO at least the following flags are nonsense and
> don't belong in TIF_anything at all:
>
> TIF_IA32, TIF_X32: can probably be deleted.  Someone would just need
> to finish the work.
> TIF_ADDR32: also probably removable, but I'm less confident.
> TIF_FORCED_TF: This is purely a ptrace artifact and could easily go
> somewhere else entirely.
>
> So getting those five bits back would be straightforward.
>
> FWIW, TIF_USER_RETURN_NOTIFY is a bit of an odd duck: it's an
> entry/exit word *and* a context switch word.  The latter is because
> it's logically a per-cpu flag, not a per-task flag, and the context
> switch code moves it around so it's always set on the running task.

Gah, I missed the context switch thing of that. That stuff is hideous.

Thanks,

       tglx
