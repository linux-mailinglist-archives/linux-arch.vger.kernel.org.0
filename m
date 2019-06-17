Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE38B4803C
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2019 13:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfFQLI6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jun 2019 07:08:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbfFQLI6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Jun 2019 07:08:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 206F4356E7;
        Mon, 17 Jun 2019 11:08:32 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-180.str.redhat.com [10.33.192.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EAC57BE78;
        Mon, 17 Jun 2019 11:08:16 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [PATCH v7 22/27] binfmt_elf: Extract .note.gnu.property from an ELF file
References: <20190606200646.3951-1-yu-cheng.yu@intel.com>
        <20190606200646.3951-23-yu-cheng.yu@intel.com>
        <20190607180115.GJ28398@e103592.cambridge.arm.com>
        <94b9c55b3b874825fda485af40ab2a6bc3dad171.camel@intel.com>
        <87lfy9cq04.fsf@oldenburg2.str.redhat.com>
        <20190611114109.GN28398@e103592.cambridge.arm.com>
        <031bc55d8dcdcf4f031e6ff27c33fd52c61d33a5.camel@intel.com>
        <20190612093238.GQ28398@e103592.cambridge.arm.com>
Date:   Mon, 17 Jun 2019 13:08:14 +0200
In-Reply-To: <20190612093238.GQ28398@e103592.cambridge.arm.com> (Dave Martin's
        message of "Wed, 12 Jun 2019 10:32:38 +0100")
Message-ID: <87imt4jwpt.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 17 Jun 2019 11:08:57 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Dave Martin:

> On Tue, Jun 11, 2019 at 12:31:34PM -0700, Yu-cheng Yu wrote:
>> On Tue, 2019-06-11 at 12:41 +0100, Dave Martin wrote:
>> > On Mon, Jun 10, 2019 at 07:24:43PM +0200, Florian Weimer wrote:
>> > > * Yu-cheng Yu:
>> > > 
>> > > > To me, looking at PT_GNU_PROPERTY and not trying to support anything is a
>> > > > logical choice.  And it breaks only a limited set of toolchains.
>> > > > 
>> > > > I will simplify the parser and leave this patch as-is for anyone who wants
>> > > > to
>> > > > back-port.  Are there any objections or concerns?
>> > > 
>> > > Red Hat Enterprise Linux 8 does not use PT_GNU_PROPERTY and is probably
>> > > the largest collection of CET-enabled binaries that exists today.
>> > 
>> > For clarity, RHEL is actively parsing these properties today?
>> > 
>> > > My hope was that we would backport the upstream kernel patches for CET,
>> > > port the glibc dynamic loader to the new kernel interface, and be ready
>> > > to run with CET enabled in principle (except that porting userspace
>> > > libraries such as OpenSSL has not really started upstream, so many
>> > > processes where CET is particularly desirable will still run without
>> > > it).
>> > > 
>> > > I'm not sure if it is a good idea to port the legacy support if it's not
>> > > part of the mainline kernel because it comes awfully close to creating
>> > > our own private ABI.
>> > 
>> > I guess we can aim to factor things so that PT_NOTE scanning is
>> > available as a fallback on arches for which the absence of
>> > PT_GNU_PROPERTY is not authoritative.
>> 
>> We can probably check PT_GNU_PROPERTY first, and fallback (based on ld-linux
>> version?) to PT_NOTE scanning?
>
> For arm64, we can check for PT_GNU_PROPERTY and then give up
> unconditionally.
>
> For x86, we would fall back to PT_NOTE scanning, but this will add a bit
> of cost to binaries that don't have NT_GNU_PROPERTY_TYPE_0.  The ld.so
> version doesn't tell you what ELF ABI a given executable conforms to.
>
> Since this sounds like it's largely a distro-specific issue, maybe there
> could be a Kconfig option to turn the fallback PT_NOTE scanning on?

I'm worried that this causes interop issues similarly to what we see
with VSYSCALL today.  If we need both and a way to disable it, it should
be something like a personality flag which can be configured for each
process tree separately.  Ideally, we'd settle on one correct approach
(i.e., either always process both, or only process PT_GNU_PROPERTY) and
enforce that.

Thanks,
Florian
