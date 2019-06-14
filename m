Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A90F462DE
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jun 2019 17:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfFNPdV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jun 2019 11:33:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:64871 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfFNPdV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Jun 2019 11:33:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 08:33:20 -0700
X-ExtLoop1: 1
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jun 2019 08:33:20 -0700
Message-ID: <cf0d1470e95e0a8b88742651d06601a53d6655c1.camel@intel.com>
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
Date:   Fri, 14 Jun 2019 08:25:16 -0700
In-Reply-To: <ea5e333f-8cd6-8396-635f-a9dc580d5364@intel.com>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com>
         <20190606200926.4029-4-yu-cheng.yu@intel.com>
         <20190607080832.GT3419@hirez.programming.kicks-ass.net>
         <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com>
         <20190607174336.GM3436@hirez.programming.kicks-ass.net>
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
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2019-06-10 at 15:59 -0700, Dave Hansen wrote:
> On 6/10/19 3:40 PM, Yu-cheng Yu wrote:
> > Ok, we will go back to do_mmap() with MAP_PRIVATE, MAP_NORESERVE and
> > VM_DONTDUMP.  The bitmap will cover only 48-bit address space.
> 
> Could you make sure to discuss the downsides of only doing a 48-bit
> address space?

The downside is that we cannot load legacy lib's above 48-bit address space, but
currently ld-linux does not do that.  Should ld-linux do that in the future,
dlopen() fails.  Considering CRIU migration, we probably need to do this anyway?

> What are the reasons behind and implications of VM_DONTDUMP?

The bitmap is very big.

In GDB, it should be easy to tell why a control-protection fault occurred
without the bitmap.

Yu-cheng
