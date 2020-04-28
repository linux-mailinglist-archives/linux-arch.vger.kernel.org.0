Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E8F1BB508
	for <lists+linux-arch@lfdr.de>; Tue, 28 Apr 2020 06:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgD1ER3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Apr 2020 00:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgD1ER3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Apr 2020 00:17:29 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E93C09B050
        for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2020 21:17:29 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a31so564301pje.1
        for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2020 21:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=8h84Asdal8ddGdf/Sbj5GbMgUMmfxecNR/DGTl7C5Ms=;
        b=yiHvCugecQvQXY4FTuCZbAeqgRSihOJpQiYtv4ucRIIrYF1q36lTJjRozoR5D2wm8l
         VF5mZ+dZWbk4kz4QBYd/2RYXIZsNZUFA3jT2mhccQQOrk4CDxQfdWsRtKyQt+hzc65zA
         /Lwe94WK5jLX/Xkq6KGUGJSydKi60TWSj82uliq2QsNMQOdvgmjwYgBolGWdJVeZIlJw
         zEBx5YWicx1ACchhvJrZuuhjE2KatYX7Roy/bZsMcDTdbNnn9ggDu3FliVQKv3H8etFL
         c1VjXCKqOC68ekMz/k10f3g29XEVCnMCtiCVnoVGRNtETVAeyEvWVFrv+Cxld/ekYTKu
         eJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=8h84Asdal8ddGdf/Sbj5GbMgUMmfxecNR/DGTl7C5Ms=;
        b=DOTNDT4Aro/ZFhy6dOyiKqdqQ+NAJBAcVaiNo43F7lNJwT7zIHTuUaKjit+rb383tr
         nD08/hpERyHJ71MyUBdbhzTwGfW1mng9P3Ri/oG9AsvKTt588SG+SghRpAAZ4/Jj2rn6
         7XafNwE+y1aapk2mddckptRoTwxa5hJQ/otUIozMdqzItvu3tE5f/HaQAmodKAJnehPS
         kb/MuVbG9ZS0FmqJuoAb0Y65zrIarnxWupqZf9j04i9gNnJeH2l2IqGlOKdPc+q4lzRG
         jx8NV++s56XouLW5v5KPAVq/hlP2TnQDfIwQ9tHrYUGl+ZGSmcGrfjTzBj7/ML2CTNEa
         dliA==
X-Gm-Message-State: AGi0PubxrVdzOeC8aFgN6Fh4O4Kk64iwO7DOHJ8K0FZox3NdROEwGmKB
        F5St7xlc7P+V3NU3V//CjlP9UQ==
X-Google-Smtp-Source: APiQypJLqu+Wcex4ySa91E5OvARz+j/btwustQ54FAzsCqbRYotfFZWp6P/WtLNIim1eeXg4dsa0kQ==
X-Received: by 2002:a17:90a:2b8f:: with SMTP id u15mr2718879pjd.137.1588047448950;
        Mon, 27 Apr 2020 21:17:28 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:95ae:5ea5:619c:8559? ([2601:646:c200:1ef2:95ae:5ea5:619c:8559])
        by smtp.gmail.com with ESMTPSA id z190sm13652412pfb.1.2020.04.27.21.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 21:17:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
Date:   Mon, 27 Apr 2020 21:17:26 -0700
Message-Id: <B7A115CB-0C8C-4719-B97B-74D94231CD1E@amacapital.net>
References: <CAHk-=wga3O=BoKZXR27-CDnAFareWcMxXhpWerwtCffdaH6_ow@mail.gmail.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <CAHk-=wga3O=BoKZXR27-CDnAFareWcMxXhpWerwtCffdaH6_ow@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (17E262)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Apr 27, 2020, at 6:36 PM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
> =EF=BB=BFOn Mon, Apr 27, 2020 at 5:46 PM Aleksa Sarai <cyphar@cyphar.com> w=
rote:
>>=20
>> I agree. It would be a shame to add a new ptrace syscall and not take
>> the opportunity to fix the multitude of problems with the existing API.
>> But that's a Pandora's box which we shouldn't open unless we want to
>> wait a long time to get an API everyone is okay with -- a pretty high
>> price to just get pidfds support in ptrace.
>=20
> We should really be very very careful with some "smarter ptrace".
> We've had _so_ many security issues with ptrace that it's not even
> funny.
>=20
> And that's ignoring all the practical issues we've had.
>=20
> I would definitely not want to have anything that looks like ptrace AT
> ALL using pidfd. If we have a file descriptor to specify the target
> process, then we should probably take advantage of that file
> descriptor to actually make it more of a asynchronous interface that
> doesn't cause the kinds of deadlocks that we've had with ptrace.
>=20
> The synchronous nature of ptrace() means that not only do we have
> those nasty deadlocks, it's also very very expensive to use. It also
> has some other fundamental problems, like the whole "take over parent"
> and the SIGCHLD behavior.
>=20
> It also is hard to ptrace a ptracer. Which is annoying when you're
> debugging gdb or strace or whatever.
>=20
> So I think the thing to do is ask the gdb (and strace) people if they
> have any _very_ particular painpoints that we could perhaps help with.
>=20
> And then very carefully think things through and not repeat all the
> mistakes ptrace did.
>=20
> I'm not very optimistic.

I hate to say this, but I=E2=80=99m not convinced that asking the gdb folks i=
s the right approach. GDB has an ancient architecture and is *incredibly* bu=
ggy.  I=E2=80=99m sure ptrace is somewhere on the pain point list, but I sus=
pect it=E2=80=99s utterly dwarfed by everything else.

Maybe the LLDB people would have a better perspective?  The rr folks would b=
e a good bet, too. Or, and I know this is sacrilege, the VSCode people?


I think one requirement for a better ptrace is that it should work if you tr=
y to debug, simultaneously, a debugger and its debugee. Maybe not perfectly,=
 but it should work. And you should be able to debug init.

Another major pain point I=E2=80=99ve seen is compat. A 64-bit debugger shou=
ld be able to debug a program that switches back and forth between 32-bit an=
d 64-bit.  A debugger that is entirely unaware of a set of registers should b=
e able to debug a process using those registers.
