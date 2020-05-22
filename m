Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8581DEEF5
	for <lists+linux-arch@lfdr.de>; Fri, 22 May 2020 20:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbgEVSKs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 May 2020 14:10:48 -0400
Received: from ppsw-31.csi.cam.ac.uk ([131.111.8.131]:33806 "EHLO
        ppsw-31.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgEVSKr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 May 2020 14:10:47 -0400
X-Greylist: delayed 1342 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 May 2020 14:10:46 EDT
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Received: from 88-109-182-220.dynamic.dsl.as9105.com ([88.109.182.220]:51732 helo=[192.168.1.219])
        by ppsw-31.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:465)
        with esmtpsa (PLAIN:amc96) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        id 1jcBmD-000an5-M3 (Exim 4.92.3)
        (return-path <amc96@hermes.cam.ac.uk>); Fri, 22 May 2020 18:48:09 +0100
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
References: <20200429220732.31602-2-yu-cheng.yu@intel.com>
 <b5197a8d-5d8b-e1f7-68d4-58d80261904c@intel.com>
 <dd5b9bab31ecf247a0b4890e22bfbb486ff52001.camel@intel.com>
 <5cc163ff9058d1b27778e5f0a016c88a3b1a1598.camel@intel.com>
 <b0581ddc-0d99-cbcf-278e-0be55ba939a0@intel.com>
 <44c055342bda4fb4730703f987ae35195d1d0c38.camel@intel.com>
 <32235ffc-6e6c-fb3d-80c4-a0478e2d0e0f@intel.com>
 <6272c481-af90-05c5-7231-3ba44ff9bd02@citrix.com>
 <CAMe9rOqwbxis1xEWbOsftMB9Roxdb3=dp=_MgK8z2pwPP36uRw@mail.gmail.com>
 <f8ce9863-6ada-2bc4-5141-122f64292aba@citrix.com>
 <20200522164953.GA411971@hirez.programming.kicks-ass.net>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <ee1b03d8-bb0e-57dc-0a6e-c82622f17067@citrix.com>
Date:   Fri, 22 May 2020 18:48:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522164953.GA411971@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 22/05/2020 17:49, Peter Zijlstra wrote:
> On Sat, May 16, 2020 at 03:09:22PM +0100, Andrew Cooper wrote:
>
>> Sadly, the same is not true for kernel shadow stacks.
>>
>> SSP is 0 after SYSCALL, SYSENTER and CLRSSBSY, and you've got to be
>> careful to re-establish the shadow stack before a CALL, interrupt or
>> exception tries pushing a word onto the shadow stack at 0xfffffffffffffff8.
> Oh man, I can only imagine the joy that brings to #NM and friends :-(

Establishing a supervisor shadow stack for the first time involves a
large leap of faith, even by usual x86 standards.

You need to have prepared MSR_PL0_SSP with correct mappings and
supervisor tokens, such that when you enable CR4.CET and
MSR_S_CET.SHSTK_EN, your SETSSBSY instruction succeeds at its atomic
"check the token and set the busy bit" shadow stack access.  Any failure
here tends to be a triple fault, and I didn't get around to figuring out
why #DF wasn't taken cleanly.

You also need to have prepared MSR_IST_SSP beforehand with the IST
shadow stack pointers matching any IST configuration in the IDT, lest a
NMI ruins your day on the instruction boundary before SETSSBSY.

A less obvious side effect of these "windows with an SSP of 0" is that
you're now forced to use IST for all non-maskable interrupts/exceptions,
even if you choose not to use SYSCALL, and you no longer need IST to
remove the risks of a userspace privilege escalation, and would prefer
not to use IST because of its problematic reentrancy characteristics.

For anyone counting the number of IST-necessary vectors across all
potential configurations in modern hardware, its #DB, NMI, #DF, #MC,
#VE, #HV, #VC and #SX, and an architectural limit of 7.

There are several other amusing aspects, such as iret-to-self needing to
use call-oriented-programming to keep itself shadow-stack-safe, or the
fact that IRET to user mode doesn't fault if it fails to clear the
supervisor busy bit, instead leaving you to double fault at some point
in the future at the next syscall/interrupt/exception because the stack
is still busy.

~Andrew

P.S. For anyone interested,
https://lore.kernel.org/xen-devel/20200501225838.9866-1-andrew.cooper3@citrix.com/T/#u
for getting supervisor shadow stacks working on Xen, which is far
simpler to manage than Linux.  I do not envy whomever has the fun of
trying to make this work for Linux.
