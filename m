Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8DD939667
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2019 22:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbfFGUEn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jun 2019 16:04:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:16835 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729342AbfFGUEn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 Jun 2019 16:04:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 13:04:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,564,1557212400"; 
   d="scan'208";a="182781141"
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jun 2019 13:04:42 -0700
Message-ID: <9d3cedc83c236ee7a109325113fd1c1f9d849f25.camel@intel.com>
Subject: Re: [PATCH v7 03/14] x86/cet/ibt: Add IBT legacy code bitmap setup
 function
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
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
        Florian Weimer <fweimer@redhat.com>,
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
Date:   Fri, 07 Jun 2019 12:56:40 -0700
In-Reply-To: <352e6172-938d-f8e4-c195-9fd1b881bdee@intel.com>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com>
         <20190606200926.4029-4-yu-cheng.yu@intel.com>
         <20190607080832.GT3419@hirez.programming.kicks-ass.net>
         <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com>
         <20190607174336.GM3436@hirez.programming.kicks-ass.net>
         <b3de4110-5366-fdc7-a960-71dea543a42f@intel.com>
         <34E0D316-552A-401C-ABAA-5584B5BC98C5@amacapital.net>
         <352e6172-938d-f8e4-c195-9fd1b881bdee@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2019-06-07 at 11:58 -0700, Dave Hansen wrote:
> On 6/7/19 11:29 AM, Andy Lutomirski wrote:
> ...
> > > I think this new MSR probably needs to get included in oops output when
> > > CET is enabled.
> > 
> > This shouldn’t be able to OOPS because it only happens at CPL 3,
> > right?  We should put it into core dumps, though.
> 
> Good point.
> 
> Yu-cheng, can you just confirm that the bitmap can't be referenced in
> ring-0, no matter what?  We should also make sure that no funny business
> happens if we put an address in the bitmap that faults, or is
> non-canonical.  Do we have any self-tests for that?

Yes, the bitmap is user memory, but the kernel can still get to it (e.g.
copy_from_user()).  We can do more check on the address.

> 
> Let's say userspace gets a fault on this.  Do they have the
> introspection capability to figure out why they faulted, say in their
> signal handler?

The bitmap address is kept by the application; the kernel won't provide it again
to user-space.  In the signal handler, the app can find out from its own record.

[...]
