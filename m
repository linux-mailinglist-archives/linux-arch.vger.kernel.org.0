Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0DE1D6185
	for <lists+linux-arch@lfdr.de>; Sat, 16 May 2020 16:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgEPOJg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 16 May 2020 10:09:36 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:51750 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgEPOJg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 16 May 2020 10:09:36 -0400
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: hDidN96EUzAnOHMS55xkxs8WWGVq+5pBKthbrckMfVRSrIbE6S6mARR7e6iCmfxtRs+t6dZgOn
 ky111k+QuspRYuPHlo/+bvt29pmbSElOVJe4am+k+1tbPdGq/i+V24dJ3m99rHE8HATp2ZNRal
 knsFZmYHRfkpmlZjBldpccNopJkJ6lo0HltBZH+ddN3rfRQYUukAzDVjzrj80JOwNd+xhBnxBN
 4I+HAvqcn84qN2FSgGa3aBcSWhG+FVqxNDKAS3eGl286pjYdRCihkiuh2RLGpNdST+isqSx6Wx
 l98=
X-SBRS: None
X-MesageID: 17965253
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.73,398,1583211600"; 
   d="scan'208";a="17965253"
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
To:     "H.J. Lu" <hjl.tools@gmail.com>
CC:     Dave Hansen <dave.hansen@intel.com>,
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
        "Arnd Bergmann" <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eugene Syromiatnikov" <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Jann Horn" <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
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
 <32235ffc-6e6c-fb3d-80c4-a0478e2d0e0f@intel.com>
 <6272c481-af90-05c5-7231-3ba44ff9bd02@citrix.com>
 <CAMe9rOqwbxis1xEWbOsftMB9Roxdb3=dp=_MgK8z2pwPP36uRw@mail.gmail.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <f8ce9863-6ada-2bc4-5141-122f64292aba@citrix.com>
Date:   Sat, 16 May 2020 15:09:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMe9rOqwbxis1xEWbOsftMB9Roxdb3=dp=_MgK8z2pwPP36uRw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 16/05/2020 03:37, H.J. Lu wrote:
> On Fri, May 15, 2020 at 5:13 PM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>> Finally seeing as the question was asked but not answered, it is
>> actually quite easy to figure out whether shadow stacks are enabled in
>> the current thread.
>>
>>     mov     $1, %eax
>>     rdsspd  %eax
> This is for 32-bit mode.

It actually works for both, if all you need is a shstk yes/no check.

Usually, you also want SSP in the yes case, so substitute rdsspq %rax as
appropriate.

(On a tangent - binutils mandating the D/Q suffixes is very irritating
with mixed 32/64bit code because you have to #ifdef your instructions
despite the register operands being totally unambiguous.  Also, D is the
wrong suffix for AT&T syntax, and should be L.  Frankly - the Intel
manuals are wrong and should not have the operand size suffix included
in the opcode name, as they are consistent with all the other
instructions in this regard.)

>   I use
>
>         /* Check if shadow stack is in use.  */
>         xorl    %esi, %esi
>         rdsspq  %rsi
>         testq   %rsi, %rsi
>         /* Normal return if shadow stack isn't in use.  */
>         je      L(no_shstk)

This is probably fine for user code, as I don't think it would be
legitimate for shstk to be enabled, with SSP being 0.

Sadly, the same is not true for kernel shadow stacks.

SSP is 0 after SYSCALL, SYSENTER and CLRSSBSY, and you've got to be
careful to re-establish the shadow stack before a CALL, interrupt or
exception tries pushing a word onto the shadow stack at 0xfffffffffffffff8.

It is a very good (lucky?) thing that frame is unmapped for other
reasons, because this corner case does not protect against multiple
threads/cores using the same shadow stack concurrently.

~Andrew
