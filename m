Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F043646C03
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jun 2019 23:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfFNVmR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jun 2019 17:42:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:34983 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfFNVmQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Jun 2019 17:42:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 14:42:16 -0700
X-ExtLoop1: 1
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by orsmga007.jf.intel.com with ESMTP; 14 Jun 2019 14:42:14 -0700
Message-ID: <359e6f64d646d5305c52f393db5296c469630d11.camel@intel.com>
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
Date:   Fri, 14 Jun 2019 14:34:12 -0700
In-Reply-To: <598edca7-c36a-a236-3b72-08b2194eb609@intel.com>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com>
         <b3de4110-5366-fdc7-a960-71dea543a42f@intel.com>
         <34E0D316-552A-401C-ABAA-5584B5BC98C5@amacapital.net>
         <7e0b97bf1fbe6ff20653a8e4e147c6285cc5552d.camel@intel.com>
         <25281DB3-FCE4-40C2-BADB-B3B05C5F8DD3@amacapital.net>
         <e26f7d09376740a5f7e8360fac4805488b2c0a4f.camel@intel.com>
         <3f19582d-78b1-5849-ffd0-53e8ca747c0d@intel.com>
         <5aa98999b1343f34828414b74261201886ec4591.camel@intel.com>
         <0665416d-9999-b394-df17-f2a5e1408130@intel.com>
         <5c8727dde9653402eea97bfdd030c479d1e8dd99.camel@intel.com>
         <ac9a20a6-170a-694e-beeb-605a17195034@intel.com>
         <328275c9b43c06809c9937c83d25126a6e3efcbd.camel@intel.com>
         <92e56b28-0cd4-e3f4-867b-639d9b98b86c@intel.com>
         <1b961c71d30e31ecb22da2c5401b1a81cb802d86.camel@intel.com>
         <ea5e333f-8cd6-8396-635f-a9dc580d5364@intel.com>
         <cf0d1470e95e0a8b88742651d06601a53d6655c1.camel@intel.com>
         <5ddf59e2-c701-3741-eaa1-f63ee741ea55@intel.com>
         <b5a915602020a6ce26ea1254f7f60e239c91bc9f.camel@intel.com>
         <598edca7-c36a-a236-3b72-08b2194eb609@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2019-06-14 at 13:57 -0700, Dave Hansen wrote:
> On 6/14/19 10:13 AM, Yu-cheng Yu wrote:
> > On Fri, 2019-06-14 at 09:13 -0700, Dave Hansen wrote:
> > > On 6/14/19 8:25 AM, Yu-cheng Yu wrote:
> > > > The bitmap is very big.
> > > 
> > > Really?  It's actually, what, 8*4096=32k, so 1/32,768th of the size of
> > > the libraries legacy libraries you load?  Do our crash dumps really not
> > > know how to represent or deal with sparse mappings?
> > 
> > Ok, even the core dump is not physically big, its size still looks odd,
> > right?
> 
> Hell if I know.
> 
> Could you please go try this in practice so that we're designing this
> thing fixing real actual problems instead of phantoms that we're
> anticipating?
> 
> > Could this also affect how much time for GDB to load it.
> 
> I don't know.  Can you go find out for sure, please?

OK!

> 
> > I have a related question:
> > 
> > Do we allow the application to read the bitmap, or any fault from the
> > application on bitmap pages?
> 
> We have to allow apps to read it.  Otherwise they can't execute
> instructions.

What I meant was, if an app executes some legacy code that results in bitmap
lookup, but the bitmap page is not yet populated, and if we then populate that
page with all-zero, a #CP should follow.  So do we even populate that zero page
at all?

I think we should; a #CP is more obvious to the user at least.

> 
> We don't have to allow them to (popuating) fault on it.  But, if we
> don't, we need some kind of kernel interface to avoid the faults.

The plan is:

* Move STACK_TOP (and vdso) down to give space to the bitmap.

* Reserve the bitmap space from (mm->start_stack + PAGE_SIZE) to cover a code
size of TASK_SIZE_LOW, which is (TASK_SIZE_LOW / PAGE_SIZE / 8).

* Mmap the space only when the app issues the first mark-legacy prctl.  This
avoids the core-dump issue for most apps and the accounting problem that
MAP_NORESERVE probably won't solve completely.

* The bitmap is read-only.  The kernel sets the bitmap with
get_user_pages_fast(FOLL_WRITE) and user_access_begin()/user_addess_end().

I will send out a RFC patch.

Yu-cheng

