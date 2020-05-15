Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BDB1D5C79
	for <lists+linux-arch@lfdr.de>; Sat, 16 May 2020 00:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgEOWoC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 18:44:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:35885 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbgEOWoC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 18:44:02 -0400
IronPort-SDR: aaZZ3WG8UU42sWIjkjaiu5lZUt8rtmCwdSxoe2c4p7yyDQs+1cgieLvjjrtyzXX0AR3Vz7qdHb
 UCw2aFtEG6Cw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 15:44:01 -0700
IronPort-SDR: k1eo7I4l0vpxx5b6MH7J+XONkOgXWkDpFd5cZ7+ZI86Nz/9cWjJqvrGB0H4SbMVbxZbRO8uHTR
 fyoHHgokSp5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,396,1583222400"; 
   d="scan'208";a="266750686"
Received: from thirum3x-mobl3.gar.corp.intel.com (HELO [10.255.0.216]) ([10.255.0.216])
  by orsmga006.jf.intel.com with ESMTP; 15 May 2020 15:43:58 -0700
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
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
        Weijiang Yang <weijiang.yang@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
 <20200429220732.31602-2-yu-cheng.yu@intel.com>
 <b5197a8d-5d8b-e1f7-68d4-58d80261904c@intel.com>
 <dd5b9bab31ecf247a0b4890e22bfbb486ff52001.camel@intel.com>
 <5cc163ff9058d1b27778e5f0a016c88a3b1a1598.camel@intel.com>
 <b0581ddc-0d99-cbcf-278e-0be55ba939a0@intel.com>
 <44c055342bda4fb4730703f987ae35195d1d0c38.camel@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <32235ffc-6e6c-fb3d-80c4-a0478e2d0e0f@intel.com>
Date:   Fri, 15 May 2020 15:43:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <44c055342bda4fb4730703f987ae35195d1d0c38.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/15/20 2:33 PM, Yu-cheng Yu wrote:
> On Fri, 2020-05-15 at 11:39 -0700, Dave Hansen wrote:
>> On 5/12/20 4:20 PM, Yu-cheng Yu wrote:
>> Can a binary compiled with CET run without CET?
> 
> Yes, but a few details:
> 
> - The shadow stack is transparent to the application.  A CET application does
> not have anything different from a non-CET application.  However, if a CET
> application uses any CET instructions (e.g. INCSSP), it must first check if CET
> is turned on.
> - If an application is compiled for IBT, the compiler inserts ENDBRs at branch
> targets.  These are nops if IBT is not on.

I appreciate the detailed response, but it wasn't quite what I was
asking.  Let's ignore IBT for now and just talk about shadow stacks.

An app compiled with the new ELF flags and running on a CET-enabled
kernel and CPU will start off with shadow stacks allocated and enabled,
right?  It can turn its shadow stack off per-thread with the new prctl.
 But, otherwise, it's stuck, the only way to turn shadow stacks off at
startup would be editing the binary.

Basically, if there ends up being a bug in an app that violates the
shadow stack rules, the app is broken, period.  The only recourse is to
have the kernel disable CET and reboot.

Is that right?

>> Can a binary compiled without CET run CET-enabled code?
> 
> Partially yes, but in reality somewhat difficult.
...
> - If a not-CET application does fork(), and the child wants to turn on CET, it
> would be difficult to manage the stack frames, unless the child knows what is is
> doing.  

It might be hard to do, but it is possible with the patches you posted?
 I think you're saying that the CET-enabled binary would do
arch_setup_elf_property() when it was first exec()'d.  Later, it could
use the new prctl(ARCH_X86_CET_DISABLE) to disable its shadow stack,
then fork() and the child would not be using CET.  Right?

What is ARCH_X86_CET_DISABLE used for, anyway?

> The JIT examples I mentioned previously run with CET enabled from the
> beginning.  Do you have a reason to do this?  In other words, if the JIT code
> needs CET, the app could have started with CET in the first place.

Let's say I have a JIT'd sandbox.  I want the sandbox to be
CET-protected, but the JIT engine itself not to be.

> - If you are asking about dlopen(), the library will have the same setting as
> the main application.  Do you have any reason to have a library running with
> CET, but the application does not have CET?

Sure, using old binaries.  That's why IBT has a legacy bitmap and things
like MPX had ways of jumping into old non-enabled binaries.

>> Can different threads in a process have different CET enabling state?
> 
> Yes, if the parent starts with CET, children can turn it off.

How would that work, though?  clone() by default will copy the parent
xsave state, which means it will be CET-enabled, which means it needs a
shadow stack.  So, if I want a CET-free child thread, I need to clone(),
then turn CET off, then free the shadow stack?

>> Does this *code* work?  Could you please indicate which JITs have been
>> enabled to use the code in this series?  How much of the new ABI is in use?
> 
> JIT does not necessarily use all of the ABI.  The JIT changes mainly fix stack
> frames and insert ENDBRs.  I do not work on JIT.  What I found is LLVM JIT fixes
> are tested and in the master branch.  Sljit fixes are in the release.

Huh, so who is using the new prctl() ABIs?

>> Where are the selftests/ for this new ABI?  Were you planning on
>> submitting any with this series?
> 
> The ABI is more related to the application side, and therefore most suitable for
> GLIBC unit tests.

I was mostly concerned with the kernel selftests.  The things in
tools/testing/selftests/x86 in the kernel tree.

> The more complicated areas such as pthreads, signals, ucontext,
> fork() are all included there.  I have been constantly running these 
> tests without any problems.  I can provide more details if testing is
> the concern.

For something this complicated, with new kernel ABIs, we need an
in-kernel sefltest.

MPX was not that much different from this feature.  It required a
boatload of compiler and linker changes to function.  Yet, there was a
simple in-kernel test for it that didn't require *any* of that big pile
of toolchain bits.

Is there a reason we don't have one of those for CET?
