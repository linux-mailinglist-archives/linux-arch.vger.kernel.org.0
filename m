Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E439C25C6E1
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 18:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgICQcw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 12:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728817AbgICQcu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Sep 2020 12:32:50 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEC6D2151B
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 16:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599150770;
        bh=ccAhlXDIqzUfCS53Ih6BJ5ZMtmY6cQaap0Ayu6dveG0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S6/5vWkd0595tqzmo0ugsNWddE90osJmmJAsbxxMQ4TxE4SRoG3OUQtNntLPYJclx
         E1KEcmUES0eLKuf5ZC3DUnXZFc+59E2IJWWB7HGryLnRx+JfrrJ26gUlkjycYOlc8y
         LhZLGgifoLCJM7dzgKXpu2vsMRpJDKsgKh4JCqT8=
Received: by mail-wr1-f49.google.com with SMTP id x14so3876616wrl.12
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 09:32:49 -0700 (PDT)
X-Gm-Message-State: AOAM533nskBRg8gZBBdS3uLxwiwreErB061l1LFH4ECQr0ey8Mmhqp0w
        uaY4ccEox+pYzqGIk86O7UgOW8M36VDDV2gDccz9vQ==
X-Google-Smtp-Source: ABdhPJwexd+tr/hjHpRJA3we13WyoCWohcGyKWMy9veXqwsBVx3FM7oAvkjCkAPLwTEoGEPDPidQEf6bR2x3xEpbm7E=
X-Received: by 2002:a05:6000:11c5:: with SMTP id i5mr3428679wrx.18.1599150768256;
 Thu, 03 Sep 2020 09:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <46e42e5e-0bca-5f3f-efc9-5ab15827cc0b@intel.com>
 <40BC093A-F430-4DCC-8DC0-2BA90A6FC3FA@amacapital.net> <b3809dd7-8566-0517-2389-8089475135b7@intel.com>
 <88261152-2de1-fe8d-7ab0-acb108e97e04@intel.com> <1b51d89c-c7de-2032-df23-e138d1369ffa@intel.com>
 <CALCETrUq3xiHV2xOZV-FD_de_P_TL-Bs91XT+F+79psBfigCSg@mail.gmail.com> <21491d05-6306-0a6f-58a7-8bf29feae8c7@intel.com>
In-Reply-To: <21491d05-6306-0a6f-58a7-8bf29feae8c7@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 3 Sep 2020 09:32:36 -0700
X-Gmail-Original-Message-ID: <CALCETrXJkXXDF=tdu3KBHgzDO+E-HhqMk9Ttixgk4WX_PLPDJw@mail.gmail.com>
Message-ID: <CALCETrXJkXXDF=tdu3KBHgzDO+E-HhqMk9Ttixgk4WX_PLPDJw@mail.gmail.com>
Subject: Re: [PATCH v11 6/9] x86/cet: Add PTRACE interface for CET
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Jann Horn <jannh@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 3, 2020 at 9:25 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 9/3/20 9:15 AM, Andy Lutomirski wrote:
> > On Thu, Sep 3, 2020 at 9:12 AM Dave Hansen <dave.hansen@intel.com> wrote:
> >>
> >> On 9/3/20 9:09 AM, Yu, Yu-cheng wrote:
> >>> If the debugger is going to write an MSR, only in the third case would
> >>> this make a slight sense.  For example, if the system has CET enabled,
> >>> but the task does not have CET enabled, and GDB is writing to a CET MSR.
> >>>  But still, this is strange to me.
> >>
> >> If this is strange, then why do we even _implement_ writes?
> >
> > Well, if gdb wants to force a tracee to return early from a function,
> > wouldn't it want the ability to modify SSP?
>
> That's true.
>
> Yu-cheng, can you take a look through and see for the other setregs
> users what they do for logically crazy, strange things?  Is there
> precedent for refusing a write which is possible but illogical or
> strange?  If so, which error code do they use?
>
> Taking the config register out of the init state is illogical, as is
> writing to SSP while the config register is in its init state.

What's so special about the INIT state?  It's optimized by XSAVES, but
it's just a number, right?  So taking the register out of the INIT
state is kind of like saying "gdb wanted to set xmm0 to (0,0,0,1), but
it was in the INIT state to begin with", right?
