Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5743BAF6
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2019 19:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfFJR2x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jun 2019 13:28:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbfFJR2x (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Jun 2019 13:28:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA733C057E37;
        Mon, 10 Jun 2019 17:28:49 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-117-27.ams2.redhat.com [10.36.117.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D8DC5DD63;
        Mon, 10 Jun 2019 17:28:37 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v7 03/14] x86/cet/ibt: Add IBT legacy code bitmap setup function
References: <20190606200926.4029-1-yu-cheng.yu@intel.com>
        <20190606200926.4029-4-yu-cheng.yu@intel.com>
        <20190607080832.GT3419@hirez.programming.kicks-ass.net>
        <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com>
        <20190607174336.GM3436@hirez.programming.kicks-ass.net>
        <b3de4110-5366-fdc7-a960-71dea543a42f@intel.com>
        <34E0D316-552A-401C-ABAA-5584B5BC98C5@amacapital.net>
        <7e0b97bf1fbe6ff20653a8e4e147c6285cc5552d.camel@intel.com>
        <4b448cde-ee4e-1c95-0f7f-4fe694be7db6@intel.com>
        <0e505563f7dae3849b57fb327f578f41b760b6f7.camel@intel.com>
        <f6de9073-9939-a20d-2196-25fa223cf3fc@intel.com>
        <5dc357f5858f8036cad5847cfe214401bb9138bf.camel@intel.com>
Date:   Mon, 10 Jun 2019 19:28:36 +0200
In-Reply-To: <5dc357f5858f8036cad5847cfe214401bb9138bf.camel@intel.com>
        (Yu-cheng Yu's message of "Mon, 10 Jun 2019 09:05:13 -0700")
Message-ID: <87h88xcptn.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 10 Jun 2019 17:28:53 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Yu-cheng Yu:

> On Fri, 2019-06-07 at 14:09 -0700, Dave Hansen wrote:
>> On 6/7/19 1:06 PM, Yu-cheng Yu wrote:
>> > > Huh, how does glibc know about all possible past and future legacy code
>> > > in the application?
>> > 
>> > When dlopen() gets a legacy binary and the policy allows that, it will
>> > manage
>> > the bitmap:
>> > 
>> >   If a bitmap has not been created, create one.
>> >   Set bits for the legacy code being loaded.
>> 
>> I was thinking about code that doesn't go through GLIBC like JITs.
>
> If JIT manages the bitmap, it knows where it is.
> It can always read the bitmap again, right?

The problem are JIT libraries without assembler code which can be marked
non-CET, such as liborc.  Our builds (e.g., orc-0.4.29-2.fc30.x86_64)
currently carries the IBT and SHSTK flag, although the entry points into
the generated code do not start with ENDBR, so that a jump to them will
fault with the CET enabled.

Thanks,
Florian
