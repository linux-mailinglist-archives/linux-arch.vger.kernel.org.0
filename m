Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B431B4AB60B
	for <lists+linux-arch@lfdr.de>; Mon,  7 Feb 2022 08:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbiBGHik (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Feb 2022 02:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbiBGH3M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Feb 2022 02:29:12 -0500
X-Greylist: delayed 540 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 23:29:09 PST
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.DE [IPv6:2001:7c0:700::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C13C043181;
        Sun,  6 Feb 2022 23:29:09 -0800 (PST)
Received: by rhlx01.hs-esslingen.de (Postfix, from userid 1203)
        id 39F2529B540F; Mon,  7 Feb 2022 08:20:02 +0100 (CET)
Date:   Mon, 7 Feb 2022 08:20:02 +0100
From:   Adrian Reber <adrian@lisas.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Message-ID: <YgDIIpCm3UITk896@lisas.de>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <YgAWVSGQg8FPCeba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YgAWVSGQg8FPCeba@kernel.org>
X-Url:  <http://lisas.de/~adrian/>
X-Operating-System: Linux (5.15.12-200.fc35.x86_64)
X-Load-Average: 2.46 2.60 2.63
X-Unexpected: The Spanish Inquisition
X-GnuPG-Key: gpg --recv-keys D3C4906A
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 06, 2022 at 08:42:03PM +0200, Mike Rapoport wrote:
> (added more CRIU people)

Thanks, Mike.

> On Sun, Jan 30, 2022 at 01:18:03PM -0800, Rick Edgecombe wrote:
> > This is a slight reboot of the userspace CET series. I will be taking over the 
> > series from Yu-cheng. Per some internal recommendations, I’ve reset the version
> > number and am calling it a new series. Hopefully, it doesn’t cause confusion.
> > 
> > The new plan is to upstream only userspace Shadow Stack support at this point. 
> > IBT can follow later, but for now I’ll focus solely on the most in-demand and
> > widely available (with the feature on AMD CPUs now) part of CET.
> > 
> > I thought as part of this reset, it might be useful to more fully write-up the 
> > design and summarize the history of the previous CET series. So this slightly
> > long cover letter does that. The "Updates" section has the changes, if anyone
> > doesn't want the history.

[...]

> > 	CRIU Support
> > 	------------
> > 	In the past there was some speculation on the mailing list about 
> > 	whether CRIU would need to be taught about CET. It turns out, it does. 
> > 	The first issue hit is that CRIU calls sigreturn directly from its 
> > 	“parasite code” that it injects into the dumper process. This violates
> > 	this shadow stack implementation’s protection that intends to prevent
> > 	attackers from doing this.
> > 
> > 	With so many packages already enabled with shadow stack, there is 
> > 	probably desire to make it work seamlessly. But in the meantime if 
> > 	distros want to support shadow stack and CRIU, users could manually 
> > 	disabled shadow stack via “GLIBC_TUNABLES=glibc.cpu.x86_shstk=off” for 
> > 	a process they will wants to dump. It’s not ideal.
> > 
> > 	I’d like to hear what people think about having shadow stack in the 
> > 	kernel without this resolved. Nothing would change for any users until 
> > 	they enable shadow stack in the kernel and update to a glibc configured
> > 	with CET. Should CRIU userspace be solved before kernel support?

From the CRIU side I can say that I would definitely like to see this
resolved. CRIU just went through a similar exercise with rseq() being
enabled in glibc and CI broke all around for us and other projects
relying on CRIU. Although rseq() was around for a long time we were not
aware of it but luckily 5.13 introduced a way to handle it for CRIU with
ptrace. An environment variable existed but did not really help when
CRIU is called somewhere in the middle of the container software stack.

From my point of view a solution not involving an environment variable
would definitely be preferred.

		Adrian
