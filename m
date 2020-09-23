Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B0727641C
	for <lists+linux-arch@lfdr.de>; Thu, 24 Sep 2020 00:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgIWWr1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Sep 2020 18:47:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgIWWr1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Sep 2020 18:47:27 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 236822388A
        for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2020 22:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600901246;
        bh=fachxeCcYA+Y90j0C9rYXFx72OerjMkaO4HvTjYJ2tY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IN8aBvC/1EKciqow+5mvDPBVaiMxXr2kvZOtd9FK4AOlggJnubcxsynWLu+lnSOtw
         t7nVO8a3yDP5Q1V6fMpHUM7w8o7/JOux2FpGemmv/1XTEtOOmz1oSxGN/xTAMGyefh
         RETXNdEl4ENCvikuBOgw02aPpoKqIBEYpo/ZcWsM=
Received: by mail-wr1-f49.google.com with SMTP id e16so1725044wrm.2
        for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2020 15:47:26 -0700 (PDT)
X-Gm-Message-State: AOAM533tcgpMvz+2aXIriMWOKb53vPLg4fA79qAT7z8DL3k4+tbpHjA6
        oCvQ3GxwB8/sTCX7txaBeOUq0wfGLX6kXm96A7tm6A==
X-Google-Smtp-Source: ABdhPJznuGEAn+IE5naOUy2EKE9CmQqUCZfv/keFlAGHq/G5ZZoiY59PyHaVeILzvhJdrECN9qqb9xgF+CH2UbMI0MA=
X-Received: by 2002:a5d:5281:: with SMTP id c1mr1854602wrv.184.1600901244569;
 Wed, 23 Sep 2020 15:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200918192312.25978-1-yu-cheng.yu@intel.com> <20200918192312.25978-9-yu-cheng.yu@intel.com>
 <CALCETrXfixDGJhf0yPw-OckjEdeF2SbYjWFm8VbLriiP0Krhrg@mail.gmail.com>
 <c96c98ec-d72a-81a3-06e2-2040f3ece33a@intel.com> <24718de58ab7bc6d7288c58d3567ad802eeb6542.camel@intel.com>
 <CALCETrWssUxxfhPPJZgPOmpaQcf4o9qCe1j-P7yiPyZVV+O8ZQ@mail.gmail.com>
 <20200923212925.GC15101@linux.intel.com> <a2e872ef-5539-c7c1-49ca-95d590f3b92a@intel.com>
 <e7c20f4c-23a0-4a34-3895-c4f60993ec41@intel.com> <a862be68-dc81-6db5-c79b-5bbd87ccddaf@intel.com>
In-Reply-To: <a862be68-dc81-6db5-c79b-5bbd87ccddaf@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 23 Sep 2020 15:47:12 -0700
X-Gmail-Original-Message-ID: <CALCETrW7o-j01aWCFjmy2TRm7X75Vd5EW_gAfOSP0nQfekkEmA@mail.gmail.com>
Message-ID: <CALCETrW7o-j01aWCFjmy2TRm7X75Vd5EW_gAfOSP0nQfekkEmA@mail.gmail.com>
Subject: Re: [PATCH v12 8/8] x86: Disallow vsyscall emulation when CET is enabled
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
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
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 23, 2020 at 3:20 PM Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>
> On 9/23/2020 3:08 PM, Dave Hansen wrote:
> > On 9/23/20 3:06 PM, Yu, Yu-cheng wrote:
> >> I think I'll add a check here for (r + 8) >= TASK_SIZE_MAX.  It is
> >> better than getting a fault.
> >
> > There's also wrmsr_safe().
> >
> Yes, thanks.
>
> Since I am going to change this to:
>
> fpu__prepare_write(), then write to the XSAVES area.
>
> The kernel does not expect XRSTORS to fail ("Bad FPU state detected..."
> message).  So maybe still check the address first.

Surely there are plenty of ways to use ptrace() to poke garbage into
the FPU state.  We should be able to handle this type of failure
somewhat gracefully.
