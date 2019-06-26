Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E643256FAE
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2019 19:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfFZRir (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Jun 2019 13:38:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:18810 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfFZRir (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Jun 2019 13:38:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 10:38:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,420,1557212400"; 
   d="scan'208";a="183217012"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jun 2019 10:38:46 -0700
Message-ID: <9f7787e255ef859a39ea87e70132a50572f4db65.camel@intel.com>
Subject: Re: [PATCH] binfmt_elf: Extract .note.gnu.property from an ELF file
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
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
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>
Date:   Wed, 26 Jun 2019 10:30:24 -0700
In-Reply-To: <CALCETrVZCzh+KFCF6ijuf4QEPn=R2gJ8FHLpyFd=n+pNOMMMjA@mail.gmail.com>
References: <20190501211217.5039-1-yu-cheng.yu@intel.com>
         <20190502111003.GO3567@e103592.cambridge.arm.com>
         <CALCETrVZCzh+KFCF6ijuf4QEPn=R2gJ8FHLpyFd=n+pNOMMMjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2019-06-26 at 10:14 -0700, Andy Lutomirski wrote:
> On Thu, May 2, 2019 at 4:10 AM Dave Martin <Dave.Martin@arm.com> wrote:
> > 
> > On Wed, May 01, 2019 at 02:12:17PM -0700, Yu-cheng Yu wrote:
> > > An ELF file's .note.gnu.property indicates features the executable file
> > > can support.  For example, the property GNU_PROPERTY_X86_FEATURE_1_AND
> > > indicates the file supports GNU_PROPERTY_X86_FEATURE_1_IBT and/or
> > > GNU_PROPERTY_X86_FEATURE_1_SHSTK.
> > > 
[...]
> 
> Where did PT_GNU_PROPERTY come from?  Are there actual docs for it?
> Can someone here tell us what the actual semantics of this new ELF
> thingy are?  From some searching, it seems like it's kind of an ELF
> note but kind of not.  An actual description would be fantastic.
> 
> Also, I don't think there's any actual requirement that the upstream
> kernel recognize existing CET-enabled RHEL 8 binaries as being
> CET-enabled.  I tend to think that RHEL 8 jumped the gun here.  While
> the upstream kernel should make some reasonble effort to make sure
> that RHEL 8 binaries will continue to run, I don't see why we need to
> go out of our way to keep the full set of mitigations available for
> binaries that were developed against a non-upstream kernel.
> 
> In fact, if we handle the legacy bitmap differently from RHEL 8, we
> may *have* to make sure that we don't recognize existing RHEL 8
> binaries as CET-enabled.

We have worked out the issue.  Linux will look at only PT_GNU_PROPERTY, which is
a shortcut pointing directly to .note.gnu.property.  I have an updated patch,
and will send it out (although it is not yet perfect).

The Linux gABI extension draft is here: https://github.com/hjl-tools/linux-abi/w
iki/linux-abi-draft.pdf.

Yu-cheng

