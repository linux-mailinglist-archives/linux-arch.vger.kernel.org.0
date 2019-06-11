Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5BB03D702
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2019 21:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407385AbfFKTjo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jun 2019 15:39:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:3339 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407028AbfFKTjo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Jun 2019 15:39:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 12:39:43 -0700
X-ExtLoop1: 1
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by orsmga007.jf.intel.com with ESMTP; 11 Jun 2019 12:39:42 -0700
Message-ID: <031bc55d8dcdcf4f031e6ff27c33fd52c61d33a5.camel@intel.com>
Subject: Re: [PATCH v7 22/27] binfmt_elf: Extract .note.gnu.property from an
 ELF file
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Martin <Dave.Martin@arm.com>,
        Florian Weimer <fweimer@redhat.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
Date:   Tue, 11 Jun 2019 12:31:34 -0700
In-Reply-To: <20190611114109.GN28398@e103592.cambridge.arm.com>
References: <20190606200646.3951-1-yu-cheng.yu@intel.com>
         <20190606200646.3951-23-yu-cheng.yu@intel.com>
         <20190607180115.GJ28398@e103592.cambridge.arm.com>
         <94b9c55b3b874825fda485af40ab2a6bc3dad171.camel@intel.com>
         <87lfy9cq04.fsf@oldenburg2.str.redhat.com>
         <20190611114109.GN28398@e103592.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2019-06-11 at 12:41 +0100, Dave Martin wrote:
> On Mon, Jun 10, 2019 at 07:24:43PM +0200, Florian Weimer wrote:
> > * Yu-cheng Yu:
> > 
> > > To me, looking at PT_GNU_PROPERTY and not trying to support anything is a
> > > logical choice.  And it breaks only a limited set of toolchains.
> > > 
> > > I will simplify the parser and leave this patch as-is for anyone who wants
> > > to
> > > back-port.  Are there any objections or concerns?
> > 
> > Red Hat Enterprise Linux 8 does not use PT_GNU_PROPERTY and is probably
> > the largest collection of CET-enabled binaries that exists today.
> 
> For clarity, RHEL is actively parsing these properties today?
> 
> > My hope was that we would backport the upstream kernel patches for CET,
> > port the glibc dynamic loader to the new kernel interface, and be ready
> > to run with CET enabled in principle (except that porting userspace
> > libraries such as OpenSSL has not really started upstream, so many
> > processes where CET is particularly desirable will still run without
> > it).
> > 
> > I'm not sure if it is a good idea to port the legacy support if it's not
> > part of the mainline kernel because it comes awfully close to creating
> > our own private ABI.
> 
> I guess we can aim to factor things so that PT_NOTE scanning is
> available as a fallback on arches for which the absence of
> PT_GNU_PROPERTY is not authoritative.

We can probably check PT_GNU_PROPERTY first, and fallback (based on ld-linux
version?) to PT_NOTE scanning?

Yu-cheng
