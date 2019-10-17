Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18B05DAD7B
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 14:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfJQMyF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Oct 2019 08:54:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40295 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfJQMyF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 08:54:05 -0400
Received: by mail-qt1-f194.google.com with SMTP id m61so3359523qte.7;
        Thu, 17 Oct 2019 05:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eNtK7nir/YjxGC1ZaM6ec46tcPBIgXs4xh0QaLsBq6Q=;
        b=SoocMDph10kq8mCJyGM+ctGZk+xPo2owk+QPAqWbZ5U82HwEZaIQl0uPQMwRcKp07h
         JAymlDKP0K1TBOpdjpsZiXyPhN5XNdEosUD1ZmCuD2ae/VuNkQuv85f0Yr0QWudmWFz9
         F0FcxBingu+ewNh8tXbEuaIyU4eM6wV+R/Iu6l/iC0qWm0h1orSAxj37vGKbf5FiFmv9
         jLB9+nN06T1P/8+FOLELFsFUBZ4wR9CFS9QjPOIcSjDia1VUOsSuxvCuh3RA6V5Zy6RR
         OiScIh7/+UO52xL3YuHrNUojbJmZffWGOAI1KX/HSu51aYagsNIpLjO8/UJH06jmdQUp
         JOtA==
X-Gm-Message-State: APjAAAViS1HCe+RF7Nr2jRu1kshjEKDk+gvkySElmezl2arnQwD6KmMp
        FZqssm6vOsfuj7sMmSoczoZ2SML8Sp9mNkL7NtB9gfBl
X-Google-Smtp-Source: APXvYqylw2foVI8wlrDjk6Ml8wvlogivW/OM7n/5IHeGPeK0H+1iT9DFYi+3alEQMfCZ+gHJXdmumzYF/5wYiEdC4cc=
X-Received: by 2002:aed:3c67:: with SMTP id u36mr3586839qte.142.1571316843338;
 Thu, 17 Oct 2019 05:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <57fd50dd./gNBvRBYvu+kYV+l%akpm@linux-foundation.org>
 <CA+55aFxr2uZADh--vtLYXjcLjNGO5t4jmTWEVZWbRuaJwiocug@mail.gmail.com>
 <CA+55aFxQRf+U0z6mrAd5QQLWgB2A_mRjY7g9vpZHCSuyjrdhxQ@mail.gmail.com>
 <CAHk-=wgr12JkKmRd21qh-se-_Gs69kbPgR9x4C+Es-yJV2GLkA@mail.gmail.com>
 <20191016231116.inv5stimz6fg7gof@box.shutemov.name> <CAHk-=wh9Jjb6iiU5dNhGTei_jTEoe7eFjxnyQ2DezbtgzdoskQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh9Jjb6iiU5dNhGTei_jTEoe7eFjxnyQ2DezbtgzdoskQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 17 Oct 2019 14:53:47 +0200
Message-ID: <CAK8P3a3uiTSaruN7x5iMaDowYziqMFxKWjDyS1c8pYFJgPJ5Dg@mail.gmail.com>
Subject: Re: [patch 014/102] llist: introduce llist_entry_safe()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sasha.levin@oracle.com>,
        Andrew Pinski <apinski@cavium.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        mm-commits@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Ingo Molnar <mingo@elte.hu>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 17, 2019 at 1:30 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Oct 16, 2019 at 4:11 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > Looks like it was fixed soon after the complain:
> >
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63567
>
> Ahh, so there are gcc versions which essentially do this wrong, and
> I'm not seeing it because it was fixed.
>
> Ho humm. Considering that this was fixed in gcc five years ago, and we
> already require gc-4.6, and did that two years ago, maybe we can just
> raise the requirement a bit further.

If the compound literal extension is now all that's keeping us from
moving to gnu99, the alternative would be to change the kernel not
to use compound literals.

I think some other gnu99 incompatibilities were fixed by the clang patches,
such as marking inline as __gnu_inline, and other problems were avoiding by
making gcc-4.5 the minimum.

I've tried it out now, and found that we do use compound literals in
some important code, but the number of instances is small enough
that we can actually rewrite them all.

Just getting the defconfig (x86-64 and arm32) building with "gcc-4.9
--std=gnu89" takes changes to around 50 files, though at least one
driver (i915 gpu) needs significant additional changes beyond this:

 Makefile                                           |  2 +-
 arch/x86/boot/compressed/acpi.c                    |  4 +-
 arch/x86/entry/vsyscall/vsyscall_64.c              |  2 +-
 arch/x86/include/asm/pgtable_types.h               | 59 ++++++++++++----------
 arch/x86/include/asm/processor.h                   |  4 +-
 arch/x86/include/asm/uaccess.h                     |  3 +-
 arch/x86/mm/pat_rbtree.c                           |  2 +-
 arch/x86/platform/efi/quirks.c                     |  9 ++--
 block/partitions/efi.c                             |  4 +-
 drivers/acpi/numa.c                                |  2 +-
 drivers/firmware/efi/efi.c                         |  4 +-
 drivers/firmware/efi/libstub/fdt.c                 |  2 +-
 drivers/firmware/efi/libstub/tpm.c                 |  2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |  2 +-
 drivers/input/mouse/elantech.c                     | 22 ++++----
 .../broadcom/brcm80211/brcmfmac/firmware.c         |  2 +-
 drivers/soc/tegra/pmc.c                            |  8 +--
 fs/proc/root.c                                     |  2 +-
 include/linux/capability.h                         | 17 ++++---
 include/linux/cpumask.h                            |  8 +--
 include/linux/efi.h                                |  2 +-
 include/linux/futex.h                              |  2 +-
 include/linux/jump_label.h                         |  4 +-
 include/linux/nodemask.h                           | 20 ++++----
 include/linux/property.h                           | 10 ++--
 include/linux/rbtree.h                             |  7 ++-
 include/linux/rwlock.h                             |  2 +-
 include/linux/rwlock_types.h                       |  4 +-
 include/linux/sched/signal.h                       |  2 +-
 include/linux/spinlock.h                           |  2 +-
 include/linux/spinlock_types.h                     |  4 +-
 include/linux/uidgid.h                             | 13 ++++-
 include/uapi/linux/uuid.h                          |  8 +--
 init/init_task.c                                   |  4 +-
 kernel/audit.c                                     |  2 +-
 kernel/capability.c                                |  2 +-
 kernel/cred.c                                      | 24 ++++-----
 kernel/events/uprobes.c                            |  2 +-
 kernel/futex.c                                     |  2 +-
 kernel/power/swap.c                                |  2 +-
 kernel/trace/trace_clock.c                         |  2 +-
 kernel/umh.c                                       |  4 +-
 kernel/user.c                                      |  6 +--
 mm/backing-dev.c                                   |  2 +-
 mm/init-mm.c                                       |  2 +-
 mm/page_alloc.c                                    |  2 +-
 mm/vmalloc.c                                       |  4 +-
 net/core/fib_rules.c                               |  4 +-
 net/rds/cong.c                                     |  2 +-
 security/integrity/iint.c                          |  2 +-
 security/keys/process_keys.c                       |  2 +-
 51 files changed, 169 insertions(+), 141 deletions(-)
