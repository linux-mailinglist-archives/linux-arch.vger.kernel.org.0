Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCB736D9FE
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 17:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbhD1OxS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 10:53:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231506AbhD1OxS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Apr 2021 10:53:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30EE16143E
        for <linux-arch@vger.kernel.org>; Wed, 28 Apr 2021 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619621553;
        bh=v9MXjcMFDkwGRxGtKjG0QxDDhk6y4//cm0KjKwV14/0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KRG/4bXmqOpbEk2St/DRgo26OHKoEpvaJMcORuhBhJnAKSJO0hf22cyOzkqsqg7XJ
         NMBdrJ7AZp2Ifo59fj4Vk9u7RorERhLrwUapTwJLqqzV3IGaWJL5G06xIuGiogYHET
         b532Nv7EFUmxnIklw4vgXoHXRvRp5YuXx5u/MrA917KjaLWZ05kn65qG+o8QD3hwhg
         x0luXKQvpp1LpHfDmnvy1qm4DrsITXKKm6eRWgnsFuWGt4lA/Uv4+4Igr+o7FGb+Tg
         fN6BEMDxbs2tA9WFGcVPAO/4Qop+TNJjVaW3vlEdo0PmXfueeKeiWGCaWw9b1sbzHz
         kmbBpzDOXP1LQ==
Received: by mail-ed1-f50.google.com with SMTP id n25so2492091edr.5
        for <linux-arch@vger.kernel.org>; Wed, 28 Apr 2021 07:52:33 -0700 (PDT)
X-Gm-Message-State: AOAM533JvUyPgKop79JTd3cz2nImOY+NeNt5u4C/FKE0a2UHI9lvHHWY
        hJK/+NzqXSwRyDdt5XCZDnwDvg9Rn2kca2r6DE9OmQ==
X-Google-Smtp-Source: ABdhPJz+QIzKaPnT4DT6hm809Ge+488Ygp48T6Uu+3gaGnaUVYy9et+z5f3TMrjkz6M7tyk1lUqB4cQlJnvVlzDNxh4=
X-Received: by 2002:a05:6402:cbb:: with SMTP id cn27mr12113500edb.222.1619621551563;
 Wed, 28 Apr 2021 07:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210427204720.25007-1-yu-cheng.yu@intel.com> <0e03c50ea05440209d620971b9db4f29@AcuMS.aculab.com>
In-Reply-To: <0e03c50ea05440209d620971b9db4f29@AcuMS.aculab.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 28 Apr 2021 07:52:19 -0700
X-Gmail-Original-Message-ID: <CALCETrUpZfznXzN3Ld33DMvQcHD2ACnhYf9KdP+5-xXuX_pVpA@mail.gmail.com>
Message-ID: <CALCETrUpZfznXzN3Ld33DMvQcHD2ACnhYf9KdP+5-xXuX_pVpA@mail.gmail.com>
Subject: Re: [PATCH v26 0/9] Control-flow Enforcement: Indirect Branch Tracking
To:     David Laight <David.Laight@aculab.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 28, 2021 at 7:48 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Yu-cheng Yu
> > Sent: 27 April 2021 21:47
> >
> > Control-flow Enforcement (CET) is a new Intel processor feature that blocks
> > return/jump-oriented programming attacks.  Details are in "Intel 64 and
> > IA-32 Architectures Software Developer's Manual" [1].
> ...
>
> Does this feature require that 'binary blobs' for out of tree drivers
> be compiled by a version of gcc that adds the ENDBRA instructions?
>
> If enabled for userspace, what happens if an old .so is dynamically
> loaded?
> Or do all userspace programs and libraries have to have been compiled
> with the ENDBRA instructions?

If you believe that the userspace tooling for the legacy IBT table
actually works, then it should just work.  Yu-cheng, etc: how well
tested is it?

--Andy
