Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62314278DF1
	for <lists+linux-arch@lfdr.de>; Fri, 25 Sep 2020 18:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgIYQSz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Sep 2020 12:18:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729353AbgIYQSz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 25 Sep 2020 12:18:55 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4935A2371F
        for <linux-arch@vger.kernel.org>; Fri, 25 Sep 2020 16:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601050734;
        bh=GUc4jpnEvctVnzgDAzmULezA1tRJBanFMPyHYi3PskM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cET+LyFrgZBvlCFjcW/UfnU9JVLddwQbaqcsDW7+dYYfjiX3C89dpiH44QVfwhyiM
         W+slZaP8r08NiHpX29xBrXll+lgSJ8OE1mRjirUFy0R4pepwnRjSknAHzI1blzfSph
         2eH0Fx8m9sMCrg+RjSHd3gWrDQsuwnIiJD2aY4QM=
Received: by mail-wr1-f53.google.com with SMTP id w5so4194664wrp.8
        for <linux-arch@vger.kernel.org>; Fri, 25 Sep 2020 09:18:54 -0700 (PDT)
X-Gm-Message-State: AOAM531PkuO4pzXFgRS+ipC2eaTdKfNYy/pbnsZC51Nz4ZFJuANnzasX
        ElVhdabPk2d7DN0J3fk1m9815REazVu4GV90ah5z1A==
X-Google-Smtp-Source: ABdhPJzJVQ4SroX19lHOoDdodedOBW7zt9uLDHTfG6pZa6tPMOiFKYUvMXunh9BhjogLm/n0RMCIDmE5ewnQIks5cFk=
X-Received: by 2002:adf:ce8e:: with SMTP id r14mr5289436wrn.257.1601050732711;
 Fri, 25 Sep 2020 09:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200925145804.5821-1-yu-cheng.yu@intel.com> <20200925145804.5821-8-yu-cheng.yu@intel.com>
In-Reply-To: <20200925145804.5821-8-yu-cheng.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 25 Sep 2020 09:18:40 -0700
X-Gmail-Original-Message-ID: <CALCETrUyLfbodgH3vWqneFgpJb0DEiqRs-ZikhrhhVUR_13xjQ@mail.gmail.com>
Message-ID: <CALCETrUyLfbodgH3vWqneFgpJb0DEiqRs-ZikhrhhVUR_13xjQ@mail.gmail.com>
Subject: Re: [PATCH v13 7/8] x86/vdso: Insert endbr32/endbr64 to vDSO
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
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
        Pengfei Xu <pengfei.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 25, 2020 at 7:58 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> From: "H.J. Lu" <hjl.tools@gmail.com>
>
> When Indirect Branch Tracking (IBT) is enabled, vDSO functions may be
> called indirectly, and must have ENDBR32 or ENDBR64 as the first
> instruction.  The compiler must support -fcf-protection=branch so that it
> can be used to compile vDSO.

Acked-by: Andy Lutomirski <luto@kernel.org>
