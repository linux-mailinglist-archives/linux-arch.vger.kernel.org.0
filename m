Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BC745F72C
	for <lists+linux-arch@lfdr.de>; Sat, 27 Nov 2021 00:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241361AbhKZXXl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Nov 2021 18:23:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51822 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234145AbhKZXVk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Nov 2021 18:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637968706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YgiQvwMbp08vBlE12HoXheM5NwL03lkPTtYhHTWGGHs=;
        b=fVl0zI2nylcKE1QFfJwsba5gifL+Ra3qEm0sVDz6fBn7nNYnnelUOr9b9YDxzbxw9uOpFY
        Mk3lyhEtvuDjZZFyRlNDQS00w9gcqF4z5gUM+C00oCv9L3wJ3cYHjOYgb8DwTbvs718C+G
        Qm2+OVuPoGvoUJraqKhcQ7PSFT8+OxA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-sWHclhRxM6Sgyilt0QJolw-1; Fri, 26 Nov 2021 18:18:23 -0500
X-MC-Unique: sWHclhRxM6Sgyilt0QJolw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBCC38042EA;
        Fri, 26 Nov 2021 23:18:20 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 745515D740;
        Fri, 26 Nov 2021 23:18:17 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Andy Lutomirski" <luto@kernel.org>
Cc:     linux-arch@vger.kernel.org,
        "Linux API" <linux-api@vger.kernel.org>,
        linux-x86_64@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, "the arch/x86 maintainers" <x86@kernel.org>,
        musl@lists.openwall.com,
        "Dave Hansen via Libc-alpha" <libc-alpha@sourceware.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Kees Cook" <keescook@chromium.org>
Subject: Re: [PATCH] x86: Implement arch_prctl(ARCH_VSYSCALL_LOCKOUT) to
 disable vsyscall
References: <87h7bzjaer.fsf@oldenburg.str.redhat.com>
        <4728eeae-8f1b-4541-b05a-4a0f35a459f7@www.fastmail.com>
        <87lf1ais27.fsf@oldenburg.str.redhat.com>
        <9641b76e-9ae0-4c26-97b6-76ecde34f0ef@www.fastmail.com>
Date:   Sat, 27 Nov 2021 00:18:14 +0100
In-Reply-To: <9641b76e-9ae0-4c26-97b6-76ecde34f0ef@www.fastmail.com> (Andy
        Lutomirski's message of "Fri, 26 Nov 2021 14:53:45 -0800")
Message-ID: <878rxaik09.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Andy Lutomirski:

> On Fri, Nov 26, 2021, at 12:24 PM, Florian Weimer wrote:
>> * Andy Lutomirski:
>>
>>> On Fri, Nov 26, 2021, at 5:47 AM, Florian Weimer wrote:
>>>> Distributions struggle with changing the default for vsyscall
>>>> emulation because it is a clear break of userspace ABI, something
>>>> that should not happen.
>>>>
>>>> The legacy vsyscall interface is supposed to be used by libcs only,
>>>> not by applications.  This commit adds a new arch_prctl request,
>>>> ARCH_VSYSCALL_LOCKOUT.  Newer libcs can adopt this request to signal
>>>> to the kernel that the process does not need vsyscall emulation.
>>>> The kernel can then disable it for the remaining lifetime of the
>>>> process.  Legacy libcs do not perform this call, so vsyscall remains
>>>> enabled for them.  This approach should achieves backwards
>>>> compatibility (perfect compatibility if the assumption that only libcs
>>>> use vsyscall is accurate), and it provides full hardening for new
>>>> binaries.
>>>
>>> Why is a lockout needed instead of just a toggle?  By the time an
>>> attacker can issue prctls, an emulated vsyscall seems like a pretty
>>> minor exploit technique.  And programs that load legacy modules or
>>> instrument other programs might need to re-enable them.
>>
>> For glibc, I plan to add an environment variable to disable the lockout.
>> There's no ELF markup that would allow us to do this during dlopen.
>> (And after this change, you can run an old distribution in a chroot
>> for legacy software, something that the userspace ABI break prevents.)
>>
>> If it can be disabled, people will definitely say, =E2=80=9Cwe get more =
complete
>> hardening if we break old userspace=E2=80=9D.  I want to avoid that.  (P=
eople
>> will say that anyway because there's this fairly large window of libcs
>> that don't use vsyscalls anymore, but have not been patched yet to do
>> the lockout.)
>
> I=E2=80=99m having trouble following the logic. What I mean is that I thi=
nk it
> should be possible to do the arch_prctl again to turn vsyscalls back
> on.

The =E2=80=9CBy the time an attacker can issue prctls=E2=80=9D argument doe=
s resonate
with me, but I'm not the one who needs convincing.

I can turn this into a toggle, and we could probably default our builds
to vsyscalls=3Dxonly.  Given the userspace ABI impact, we'd still have to
upstream the toggle.  Do you see a chance of a patch a long these lines
going in at all, given that it's an incomplete solution for
vsyscall=3Demulate?

>> Maybe the lockout also simplifies the implementation?
>>
>>> Also, the interaction with emulate mode is somewhat complex. For now,
>>> let=E2=80=99s support this in xonly mode only. A complete implementatio=
n will
>>> require nontrivial mm work.  I had that implemented pre-KPTI, but KPTI
>>> made it more complicated.
>>
>> I admit I only looked at the code in emulate_vsyscall.  It has code that
>> seems to deal with faults not due to instruction fetch, and also checks
>> for vsyscall=3Demulate mode.  But it seems that we don't get to this poi=
nt
>> for reads in vsyscall=3Demulate mode, presumably because the page is
>> already mapped?
>
> Yes, and, with KPTI off, it=E2=80=99s nontrivial to unmap it. I have code=
 for
> this, but I=E2=80=99m not sure the complexity is worthwhile.

Huh.  KPTI is the new thing, right?  Does it make things harder or not?
I'm confused.

If we knew at execve time that the new process image doesn't have
vsyscall, would that be easier to set up?  vsyscall opt-out could be
triggered by an ELF NOTE segment on the program interpreter (or main
program if there isn't one).

>>> Finally, /proc/self/maps should be wired up via the gate_area code.
>>
>> Should the "[vsyscall]" string change to something else if execution is
>> disabled?
>
> I think the line should disappear entirely, just like booting with
> vsyscall=3Dnone.

Hmm.  But only for vsyscall=3Dxonly, right?  With vsyscall=3Demulate,
reading at those addresses will still succeed.

Thanks,
Florian

