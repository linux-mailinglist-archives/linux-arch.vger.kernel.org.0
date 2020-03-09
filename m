Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9712F17EC77
	for <lists+linux-arch@lfdr.de>; Tue, 10 Mar 2020 00:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgCIXLm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Mar 2020 19:11:42 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33827 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgCIXLm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2020 19:11:42 -0400
Received: by mail-ot1-f68.google.com with SMTP id j16so11396669otl.1;
        Mon, 09 Mar 2020 16:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LKRHxYimFMZUOSCFWBWPQEeraoRwWzQd26N8/GrplsA=;
        b=rulg74NMqVMzZo2by+XKSp3K4FvZFLEJZX14TihGtvaEapM1a5FXYMGx4Y0CzF/XQb
         p5dlHlN5peWB/cQQ+ltlHoDtJDdFFIH2cKE2/b21VuJ79VlmdZBJSNqtpUMpKFoqMtr+
         vmTtA1Kb22Sjvk/j66aWnqe06zNZBrP/+eNgVAC4ii9Ag1J8R0Jw2KbLs5fAn2FxG/Wm
         iDulToOeNyr0vnAEviO9klOQ4enf00c4roCnTPxv6qb6m9Uho20RwTMPGNjBPuuUef14
         FVaiSZ7QGc6bkPz6hck+9VM+xv1ZB5pwevCFNa4q1ycFRFVouUkX/2NW8kMtZComw9kc
         vmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LKRHxYimFMZUOSCFWBWPQEeraoRwWzQd26N8/GrplsA=;
        b=QoooLDU0OZ0mBJ4AXcfvmyn3m64Mx/RLByRaTjPR1IDD9QCqJMfaONEhgMpkCVCSwE
         WitEoWCLPt/VNszX8dFQlmOhDfPbq62oRT6iexALTQUezRGKVhBJYo4b+5jA22uNQmp5
         ueGQ5vadetrERNMxGW2AGxO+BNj8pS+ZLCiSZI9uJNS5ebTz2/3kvzbY0AGqSTMa7Auy
         cY+YYNisAjFTdNoh0r3lJrg7QPnnuCrSNl+6M39jyg7g8UVR3GPptanAkz9bMgEa/QR7
         6nUO7IpO3US4AvY2ycvewsTpi5flvZL4bjRgTscCCrMSEYwfRFMGofXVG5VQ31WW7ltx
         9XtA==
X-Gm-Message-State: ANhLgQ1QXK3Xq27G5I9gvlao4AHatUOuEY4U0GXcvrAPHeWqOjO23c8I
        D37bW4j+bJlkhHu/QLmjfMBZwANXT2iOsNLpcaI=
X-Google-Smtp-Source: ADFU+vtL/gChUunHBPDJ//510Fa7sEtCs5vnQQ5R8G6UMz//hGSWJNgzgLHodYMrsAEKImkJ7AcjxUHEpiE6XdjOIn8=
X-Received: by 2002:a9d:6c94:: with SMTP id c20mr15239729otr.285.1583795499756;
 Mon, 09 Mar 2020 16:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAMe9rOoRTVUzNC88Ho2XTTNJCymrd3L=XdB9xFcgxPVwAZ0FWA@mail.gmail.com>
 <AE81FEF5-ECC5-46AA-804D-9D64E656D16E@amacapital.net> <CAMe9rOoDMenvD9XRL1szR5yLQEwv9Q6f4O7CtwbdZ-cJqzezKA@mail.gmail.com>
 <0088001c-0b12-a7dc-ff2a-9d5c282fa36b@intel.com> <CAMe9rOqf0OHL9397Vikgb=UWhRMf+FmGq-9VAJNmfmzNMMDkCw@mail.gmail.com>
 <56ab33ac-865b-b37e-75f2-a489424566c3@intel.com>
In-Reply-To: <56ab33ac-865b-b37e-75f2-a489424566c3@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 9 Mar 2020 16:11:03 -0700
Message-ID: <CAMe9rOrzrXORQgcAwzGn+=PBvxCEgc5Km_TQq+P7uoqwiacJSA@mail.gmail.com>
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
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
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 9, 2020 at 3:19 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 3/9/20 2:12 PM, H.J. Lu wrote:
> >> But what are the rules for clone()?  Should there be rules for
> >> mismatches for CET enabling between threads if a process (not child
> >> processes)?
> > What did you mean? A threaded application is either CET enabled or not
> > CET enabled.   A new thread from clone makes no difference.
>
> Stacks are fundamentally thread-local resources.  The registers that
> point to them and MSRs that manage shadow stacks are all CPU-thread
> local.  Nothing is fundamentally tied to the address space shared across
> the process.
>
> A thread might also share *no* control flow with its child.  It might
> ask the thread to start in code that the parent can never even reach.
>
> It sounds like you've picked a Linux implementation that has
> restrictions on top of the fundamentals.  That's not wrong per se, but
> it does deserve explanation and deliberate, not experimental design.
>
> Could you go back to the folks at Intel and try to figure out what this
> was designed to *do*?  Yes, I'm probably one of those folks.  You know
> where to find me. :)

A threaded application is loaded from disk.  The object file on disk is
either CET enabled or not CET enabled.

-- 
H.J.
