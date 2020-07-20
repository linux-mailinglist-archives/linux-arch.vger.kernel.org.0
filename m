Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D492257FE
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jul 2020 08:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgGTGuG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jul 2020 02:50:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55554 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTGuG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jul 2020 02:50:06 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595227804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t/qYtaXCKWFcQ++IUuI+8VoH3i4cW6b42fWT4jOgYmA=;
        b=I8NrnAiDCGeIzMpOK6d/529QMrR7yLW1IOA3Bpek9vOOlA2k5NqKlqZcIMaf1j/rYd9B7i
        /DxmDZ2C+Nbdvj9u/8Qq3lQkvHe7gnEEHyii2lHAY76prCZMPmkADNulos5ebbC43Ao3am
        rHmpG/LtLwFFz6wZNAje4k4SNHTbAse2Bj6ythgYRHMm7QQOFZBPAkCkMmHxEf8EY8WIAI
        22SrH2ZbgY/tfUZBgBPJL3Z5uWN3pIJERqp9XBjuGrTnUURQpM/OrFaI5f9eYE449INOef
        KsVHSDgfX0QAsNfyXOx5l6L5To5hWalfvr/+390Tjjf8wf1NakStsO0UXQNyPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595227804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t/qYtaXCKWFcQ++IUuI+8VoH3i4cW6b42fWT4jOgYmA=;
        b=JmW05mx6NDlANlEtUmk8WumFr8XSkHzEyeysCjvJt7mjlaCLUU8+tb2WwbeVWfpUHTjnBy
        IV0x3wGCbxgNtKBA==
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [patch V3 01/13] entry: Provide generic syscall entry functionality
In-Reply-To: <A790AF9D-3BF7-4FEE-9E29-7C13FA3FE0C3@amacapital.net>
References: <87v9ijollo.fsf@nanos.tec.linutronix.de> <A790AF9D-3BF7-4FEE-9E29-7C13FA3FE0C3@amacapital.net>
Date:   Mon, 20 Jul 2020 08:50:02 +0200
Message-ID: <87a6zuof39.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Andy Lutomirski <luto@amacapital.net> writes:
>> On Jul 19, 2020, at 3:17 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>>=20
>> =EF=BB=BFAndy Lutomirski <luto@kernel.org> writes:
>>>> On Sat, Jul 18, 2020 at 7:16 AM Thomas Gleixner <tglx@linutronix.de> w=
rote:
>>>> Andy Lutomirski <luto@kernel.org> writes:
>>>>> FWIW, TIF_USER_RETURN_NOTIFY is a bit of an odd duck: it's an
>>>>> entry/exit word *and* a context switch word.  The latter is because
>>>>> it's logically a per-cpu flag, not a per-task flag, and the context
>>>>> switch code moves it around so it's always set on the running task.
>>>>=20
>>>> Gah, I missed the context switch thing of that. That stuff is hideous.
>>>=20
>>> It's also delightful because anything that screws up that dance (such
>>> as failure to do the exit-to-usermode path exactly right) likely
>>> results in an insta-root-hole.  If we fail to run user return
>>> notifiers, we can run user code with incorrect syscall MSRs, etc.
>>=20
>> Looking at it deeper, having that thing in the loop is a pointless
>> exercise. This really wants to be done _after_ the loop.
>>=20
> As long as we=E2=80=99re confident that nothing after the loop can set th=
e flag again.

Yes, because that's the direct way off to user space.

Thanks,

        tglx
