Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732B01B9A43
	for <lists+linux-arch@lfdr.de>; Mon, 27 Apr 2020 10:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgD0IbS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Apr 2020 04:31:18 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:37097 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgD0IbS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Apr 2020 04:31:18 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MofLl-1irjgI1R1N-00p50y; Mon, 27 Apr 2020 10:31:15 +0200
Received: by mail-lj1-f172.google.com with SMTP id u15so16648780ljd.3;
        Mon, 27 Apr 2020 01:31:15 -0700 (PDT)
X-Gm-Message-State: AGi0Pub4gB4bImFEreZ0CJ+ic2dvZsupwqTelv3PMwzXMr7hnhDIrHRI
        Y6R+GqDFIoOypwCRV88g72Vbm+23GYE2J3L3rZU=
X-Google-Smtp-Source: APiQypKAcnbUUWXlNyg96pM/OC4tHvewG9xXx/yyyNxR4zEsmm5rQr/f7pRTKhnRcwwF9cXmbTUOrFIU0TM+uvDhv/c=
X-Received: by 2002:a2e:6a08:: with SMTP id f8mr14221730ljc.8.1587976274762;
 Mon, 27 Apr 2020 01:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200426130100.306246-1-hagen@jauu.net> <20200426163430.22743-1-hagen@jauu.net>
In-Reply-To: <20200426163430.22743-1-hagen@jauu.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Apr 2020 10:30:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1qdyw+5B-E52O42VEWvpq_6jF74__ptM+q6SoKd3pkuA@mail.gmail.com>
Message-ID: <CAK8P3a1qdyw+5B-E52O42VEWvpq_6jF74__ptM+q6SoKd3pkuA@mail.gmail.com>
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
To:     Hagen Paul Pfeifer <hagen@jauu.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Ka4Wm7MWpM+RNPW+QnUrj+KN1kAsR6elSC0XDqoA8soDzQb/X2T
 dc1KNnKCX6vkbXFfCf7GobHBRU/cUMboiRMV9FMH36/GOXLfVHehc+7+/8Q8oPQDvrKa6yZ
 VQINi3VyZoNwOyNfG8w8SP4ACuniR/EhrwMEYocsMkquHI5A7WOtTbess1zDtq7uDRKWUJQ
 +ij/uUTavuJaNjTPnVRlQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jeH6gxgpOBQ=:WSbGomqreVARHjUgq/R0V0
 bnDjO/HUhOTfQraVzrZRbsDwiKi9NziWBZ0CinMa7Wp6/VVMNrY493GNIthT9TVTAyrnMlvsx
 8frDniMbLeXi+3E05XY4LUJOXgholG09R4xgWMT+WgOAYmExIdssUDyn+xAqgFBHQzCvtyspY
 fLuJaSOHA/bNrYZ9CFiwV1Uf/+k74ynyZVTegwiMBV7ic0RzFJvDnBazzhbxrAypXeOE3N27E
 QeVKBCWl5HSMrL8lOXdEEvUiGz7tGo1KWzy16dQJUEmOCsvQRx7B9XDcRbeM2kTrWUbLFh1tF
 /2NiHQvUWml3d9pE2Wh8CTyZnefedZsbcSaYGH+4bOv2e2Z31iJ4rSUElfTUlPkDv7ajdK59C
 SYL2n/aNeQ/h2AU1J0mYsLM90aCYBDPxuc3TJVTa9GNJ8zvyvBLc8IapHcY6kuK6ne4tz0+bI
 LUvJhhlDsRFku7HtWBchhfG9TQsUrLk9RQXq6G3vN0xVmeoWndJVzjL3hMa7q4KQkkflt2oDU
 MUS7KnJV53QjM9XcQQq6Gf/Tph/ob+nfq4rYcvz30JP3H3EPnTD1yQv+X3H4GLGSwhqzNhX2A
 bZFPvz3nhLNNS3dN4zoJIrKRy3CdPa1PD9l8qLsiGVJ68RnniVj0N9+tp18OyfC7hbZd94VsB
 xLwRmN6/r7kCHUVS0OyjjabDTazp1whdfmQsWm/Wrg1Uka9zdXd462IUhZeIlIU/G9AtUdOw7
 2VHMbilcLqeki9Qu7+VTzGomlwPBT09WPTKE53GHwG6xPksnN88yuxgQJJprVavqbY5eKRA0v
 sCwoMe/XUmN+P1S7WBLusxB/KXdHjJf0qGCrC+3AHCCf0ntX3Y=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>  arch/x86/entry/syscalls/syscall_32.tbl |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>  include/linux/syscalls.h               |   2 +
>  include/uapi/asm-generic/unistd.h      |   4 +-

When you add a new system call, please add it to all architectures.
See the patches for the last few additions on how to do it, in
particular the bit around adding the arm64 compat entry that is
a bit tricky.

It may be best to split out the patch changing all architectures from
the one adding the new syscall.

> +SYSCALL_DEFINE5(pidfd_ptrace, int, pidfd, long, request, unsigned long, addr,
> +               unsigned long, data, unsigned int, flags)
> +{

When you add a new variant of ptrace, there also needs to be the
corresponding COMPAT_SYSCLAL_DEFINE5(...) calling
compat_ptrace_request().

If you want, you could unify the native and compat code paths more by
merging compat_ptrace_request() into ptrace_request() and using
in_compat_syscall() checks for the ones that are different. This also
would best be done as a separate cleanup patch upfront.

      Arnd
