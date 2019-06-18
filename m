Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F77A4A629
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2019 18:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbfFRQFt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jun 2019 12:05:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729455AbfFRQFt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Jun 2019 12:05:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 06BA17FDF9;
        Tue, 18 Jun 2019 16:05:39 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-87.ams2.redhat.com [10.36.116.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 70CCD37DE;
        Tue, 18 Jun 2019 16:05:26 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
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
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [PATCH v7 22/27] binfmt_elf: Extract .note.gnu.property from an ELF file
References: <87lfy9cq04.fsf@oldenburg2.str.redhat.com>
        <20190611114109.GN28398@e103592.cambridge.arm.com>
        <031bc55d8dcdcf4f031e6ff27c33fd52c61d33a5.camel@intel.com>
        <20190612093238.GQ28398@e103592.cambridge.arm.com>
        <87imt4jwpt.fsf@oldenburg2.str.redhat.com>
        <alpine.DEB.2.21.1906171418220.1854@nanos.tec.linutronix.de>
        <20190618091248.GB2790@e103592.cambridge.arm.com>
        <20190618124122.GH3419@hirez.programming.kicks-ass.net>
        <87ef3r9i2j.fsf@oldenburg2.str.redhat.com>
        <20190618125512.GJ3419@hirez.programming.kicks-ass.net>
        <20190618133223.GD2790@e103592.cambridge.arm.com>
        <d54fe81be77b9edd8578a6d208c72cd7c0b8c1dd.camel@intel.com>
        <87pnna7v1d.fsf@oldenburg2.str.redhat.com>
        <1ca57aaae8a2121731f2dcb1a137b92eed39a0d2.camel@intel.com>
Date:   Tue, 18 Jun 2019 18:05:24 +0200
In-Reply-To: <1ca57aaae8a2121731f2dcb1a137b92eed39a0d2.camel@intel.com>
        (Yu-cheng Yu's message of "Tue, 18 Jun 2019 08:53:29 -0700")
Message-ID: <87blyu7ubf.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 18 Jun 2019 16:05:49 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Yu-cheng Yu:

>> I assumed that it would also parse the main executable and make
>> adjustments based on that.
>
> Yes, Linux also looks at the main executable's header, but not its
> NT_GNU_PROPERTY_TYPE_0 if there is a loader.
>
>> 
>> ld.so can certainly provide whatever the kernel needs.  We need to tweak
>> the existing loader anyway.
>> 
>> No valid statically-linked binaries exist today, so this is not a
>> consideration at this point.
>
> So from kernel, we look at only PT_GNU_PROPERTY?

If you don't parse notes/segments in the executable for CET, then yes.
We can put PT_GNU_PROPERTY into the loader.

Thanks,
Florian
