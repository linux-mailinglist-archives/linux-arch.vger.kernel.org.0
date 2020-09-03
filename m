Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAA925C673
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 18:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgICQPl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 12:15:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbgICQPj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Sep 2020 12:15:39 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47A7D20829
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 16:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599149738;
        bh=M4de8VIlN5oGko56PdnQYFxQoRWoIZixfSOt8ZIRpmc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HUHyfNdaaBJXPriZlf3Ts2pJyj08I/ktPKdyfOn7ewAQ8zlUBn1eHxblXyok+MwmN
         Cn2QhTZnlkuJ0mfrATrWHnY35H3F9z4nd+P2u4UtlnIOm7OtR6ZH+dIl0N99ifRiOE
         dfYckGpTHxSmqtAurJcSq4FJh0Zga6d3lGbOhCqg=
Received: by mail-wr1-f45.google.com with SMTP id c15so3816579wrs.11
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 09:15:38 -0700 (PDT)
X-Gm-Message-State: AOAM533jEm1iFPLtkS9mMjbiMiM5XG58AMurn7iLXNcZB+fZWUIpjvK6
        26rHPEIY2eC8UF0zXetCDlXn65naRnEwJ1ZfhGj3Ag==
X-Google-Smtp-Source: ABdhPJzxk51W165I8aXmQ7ZsFkeOfAM9XM8FPpX1on1tLbF9c0ZcoI90VLnKqRN+zu5Iz7T/J1VzvJy8Uq4K7qJhTOU=
X-Received: by 2002:a5d:5111:: with SMTP id s17mr3244344wrt.70.1599149736897;
 Thu, 03 Sep 2020 09:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <46e42e5e-0bca-5f3f-efc9-5ab15827cc0b@intel.com>
 <40BC093A-F430-4DCC-8DC0-2BA90A6FC3FA@amacapital.net> <b3809dd7-8566-0517-2389-8089475135b7@intel.com>
 <88261152-2de1-fe8d-7ab0-acb108e97e04@intel.com> <1b51d89c-c7de-2032-df23-e138d1369ffa@intel.com>
In-Reply-To: <1b51d89c-c7de-2032-df23-e138d1369ffa@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 3 Sep 2020 09:15:25 -0700
X-Gmail-Original-Message-ID: <CALCETrUq3xiHV2xOZV-FD_de_P_TL-Bs91XT+F+79psBfigCSg@mail.gmail.com>
Message-ID: <CALCETrUq3xiHV2xOZV-FD_de_P_TL-Bs91XT+F+79psBfigCSg@mail.gmail.com>
Subject: Re: [PATCH v11 6/9] x86/cet: Add PTRACE interface for CET
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
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
        Andy Lutomirski <luto@kernel.org>,
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

On Thu, Sep 3, 2020 at 9:12 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 9/3/20 9:09 AM, Yu, Yu-cheng wrote:
> > If the debugger is going to write an MSR, only in the third case would
> > this make a slight sense.  For example, if the system has CET enabled,
> > but the task does not have CET enabled, and GDB is writing to a CET MSR.
> >  But still, this is strange to me.
>
> If this is strange, then why do we even _implement_ writes?

Well, if gdb wants to force a tracee to return early from a function,
wouldn't it want the ability to modify SSP?

--Andy
