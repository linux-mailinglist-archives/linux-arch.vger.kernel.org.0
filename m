Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18DF256BA4
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2019 16:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfFZOQC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Jun 2019 10:16:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42446 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbfFZOQC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jun 2019 10:16:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id k13so1282073pgq.9
        for <linux-arch@vger.kernel.org>; Wed, 26 Jun 2019 07:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RFuejYlM7bxMzMBYo55vMp6D/kHvAVGp1jAquxKmlR4=;
        b=sAA0Xrgtpjj0t7/qJheVhmrLvnAfkqTUtVjrXwzajaELS5t73X7heZA6b5iLd11jhm
         hSC9ZK4ElajNN4wqgO86XZP3dmGSlWSvzXGQ6sqbpux5nhn0to+snNN2LR7xTribMiP2
         8eEWH9GVEf6c5YLN7gGe+m5F4XjcZrk11NJ1zFk7jC+eVuRVyWxlLf9EUrBdeZ0sbPEB
         3jYsGy4qwlzi7cnwS2HfC++EbdyJE516VdVtl89awjJc7n+0NzGkMBElxb0fQJ5KCxmx
         25vVWUl+o2q6eXePis3bC8WRbuhbfXU8eIZ3ggbxHxZJHqN1UQagxV/WVK5lH3OUwsG/
         Z61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RFuejYlM7bxMzMBYo55vMp6D/kHvAVGp1jAquxKmlR4=;
        b=uEl7kXZI4J5zXBEZZZ2gPmRlLTraCPYBcqOu8V2QJwwIo8MeyoKRSK7xKXlItX9egs
         B7bnbJy9Isd8rdHOcc5E1lQ8N3ixBCCYX3vj6hrKZw3nFTd3S+SCZxQ3ncxcZFPjVqIK
         XjD8wvmI4Z0RCF1ETaRaNdsHlgZIP+DdwhZ3nW0Qrj2vTu20uYauT5C6h0TvqcTv07r0
         g0N0CenkY20HsGFo11EF3JAxQFLBm00SWEHUSEIikLe5rdkxjObeoy22BEL/AEAFFscb
         tbEqrJ2I0af9mcsZulCRE+CRQxuQCnnXRZtEMG2FiPMEICg1ukAmI87Psai+muR4P9DW
         QZkw==
X-Gm-Message-State: APjAAAVrW6V3SFXvRfRdV5K9xGlUvS3d/A/YdEqgeBOf5a2pIxL0Vvw6
        gs0jJmrbUlyq6JWZ3v0oZlTnmA==
X-Google-Smtp-Source: APXvYqzTMlaCnwoIIHdMn8hfjJMeTYkVfnsg8/lIFMVzzs1PlALfjMc50Rp2C0jxGQ86SP/ieOnT+Q==
X-Received: by 2002:a17:90a:62c7:: with SMTP id k7mr4992918pjs.135.1561558560842;
        Wed, 26 Jun 2019 07:16:00 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:f0b6:b345:f129:c145? ([2601:646:c200:1ef2:f0b6:b345:f129:c145])
        by smtp.gmail.com with ESMTPSA id f2sm15000925pgs.83.2019.06.26.07.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:16:00 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Detecting the availability of VSYSCALL
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <87o92kmtp5.fsf@oldenburg2.str.redhat.com>
Date:   Wed, 26 Jun 2019 07:15:59 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-x86_64@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Carlos O'Donell <carlos@redhat.com>, X86 ML <x86@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CA96B819-30A9-43D3-9FE3-2D551D35369E@amacapital.net>
References: <87v9wty9v4.fsf@oldenburg2.str.redhat.com> <alpine.DEB.2.21.1906251824500.32342@nanos.tec.linutronix.de> <87lfxpy614.fsf@oldenburg2.str.redhat.com> <CALCETrVh1f5wJNMbMoVqY=bq-7G=uQ84BUkepf5RksA3vUopNQ@mail.gmail.com> <87a7e5v1d9.fsf@oldenburg2.str.redhat.com> <CALCETrUDt4v3=FqD+vseGTKTuG=qY+1LwRPrOrU8C7vCVbo=uA@mail.gmail.com> <87o92kmtp5.fsf@oldenburg2.str.redhat.com>
To:     Florian Weimer <fweimer@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Jun 26, 2019, at 5:12 AM, Florian Weimer <fweimer@redhat.com> wrote:
>=20
> * Andy Lutomirski:
>=20
>>> On Tue, Jun 25, 2019 at 1:47 PM Florian Weimer <fweimer@redhat.com> wrot=
e:
>>>=20
>>> * Andy Lutomirski:
>>>=20
>>>>> We want binaries that run fast on VSYSCALL kernels, but can fall back t=
o
>>>>> full system calls on kernels that do not have them (instead of
>>>>> crashing).
>>>>=20
>>>> Define "VSYSCALL kernels."  On any remotely recent kernel (*all* new
>>>> kernels and all kernels for the last several years that haven't
>>>> specifically requested vsyscall=3Dnative), using vsyscalls is much, muc=
h
>>>> slower than just doing syscalls.  I know a way you can tell whether
>>>> vsyscalls are fast, but it's unreliable, and I'm disinclined to
>>>> suggest it.  There are also at least two pending patch series that
>>>> will interfere.
>>>=20
>>> The fast path is for the benefit of the 2.6.32-based kernel in Red Hat
>>> Enterprise Linux 6.  It doesn't have the vsyscall emulation code yet, I
>>> think.
>>>=20
>>> My hope is to produce (statically linked) binaries that run as fast on
>>> that kernel as they run today, but can gracefully fall back to something=

>>> else on kernels without vsyscall support.
>>>=20
>>>>> We could parse the vDSO and prefer the functions found there, but this=

>>>>> is for the statically linked case.  We currently do not have a (minima=
l)
>>>>> dynamic loader there in that version of the code base, so that doesn't=

>>>>> really work for us.
>>>>=20
>>>> Is anything preventing you from adding a vDSO parser?  I wrote one
>>>> just for this type of use:
>>>>=20
>>>> $ wc -l tools/testing/selftests/vDSO/parse_vdso.c
>>>> 269 tools/testing/selftests/vDSO/parse_vdso.c
>>>>=20
>>>> (289 lines includes quite a bit of comment.)
>>>=20
>>> I'm worried that if I use a custom parser and the binaries start
>>> crashing again because something changed in the kernel (within the scope=

>>> permitted by the ELF specification), the kernel won't be fixed.
>>>=20
>>> That is, we'd be in exactly the same situation as today.
>>=20
>> With my maintainer hat on, the kernel won't do that.  Obviously a
>> review of my parser would be appreciated, but I consider it to be
>> fully supported, just like glibc and musl's parsers are fully
>> supported.  Sadly, I *also* consider the version Go forked for a while
>> (now fixed) to be supported.  Sigh.
>=20
> We've been burnt once, otherwise we wouldn't be having this
> conversation.  It's not just what the kernel does by default; if it's
> configurable, it will be disabled by some, and if it's label as
> =E2=80=9Csecurity hardening=E2=80=9D, the userspace ABI promise is suddenl=
y forgotten
> and it's all userspace's fault for not supporting the new way.
>=20
> It looks like parsing the vDSO is the only way forward, and we have to
> move in that direction if we move at all.
>=20
> It's tempting to read the machine code on the vsyscall page and analyze
> that, but vsyscall=3Dnone behavior changed at one point, and you no longer=

> any mapping there at all.  So that doesn't work, either.

It=E2=80=99s worse than that. I have patches to make the vsyscall be execute=
-only. And the slowly forthcoming CET patches will change the machine code.

>=20
> I do hope the next userspace ABI break will have an option to undo it on
> a per-container basis.  Or at least a flag to detect it.
>=20

I didn=E2=80=99t add a flag because the vsyscall page was thoroughly obsolet=
e when all this happened, and I wanted to encourage all new code to just par=
se the vDSO instead of piling on the hacks.

Anyway, you may be the right person to ask: is there some credible way that t=
he kernel could detect new binaries that don=E2=80=99t need vsyscalls?  Mayb=
e a new ELF note on a static binary or on the ELF interpreter? We can dynami=
cally switch it in principle.=
