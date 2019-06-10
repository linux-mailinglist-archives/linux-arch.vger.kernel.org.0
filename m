Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 054373BE02
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2019 23:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389586AbfFJVGL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jun 2019 17:06:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:38294 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388342AbfFJVGK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Jun 2019 17:06:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 14:06:10 -0700
X-ExtLoop1: 1
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by orsmga002.jf.intel.com with ESMTP; 10 Jun 2019 14:06:08 -0700
Message-ID: <328275c9b43c06809c9937c83d25126a6e3efcbd.camel@intel.com>
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
Date:   Mon, 10 Jun 2019 13:58:01 -0700
In-Reply-To: <ac9a20a6-170a-694e-beeb-605a17195034@intel.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2019-06-10 at 13:43 -0700, Dave Hansen wrote:
> On 6/10/19 1:27 PM, Yu-cheng Yu wrote:
> > > > If the loader cannot allocate a big bitmap to cover all 5-level
> > > > address space (the bitmap will be large), it can put all legacy lib's
> > > > at lower address.  We cannot do these easily in the kernel.
> > > 
> > > This is actually an argument to do it in the kernel.  The kernel can
> > > always allocate the virtual space however it wants, no matter how large.
> > >  If we hide the bitmap behind a kernel API then we can put it at high
> > > 5-level user addresses because we also don't have to worry about the
> > > high bits confusing userspace.
> > 
> > We actually tried this.  The kernel needs to reserve the bitmap space in the
> > beginning for every CET-enabled app, regardless of actual needs. 
> 
> I don't think this is a problem.  In fact, I think reserving the space
> is actually the only sane behavior.  If you don't reserve it, you
> fundamentally limit where future legacy instructions can go.
> 
> One idea is that we always size the bitmap for the 48-bit addressing
> systems.  Legacy code probably doesn't _need_ to go in the new address
> space, and if we do this we don't have to worry about the gigantic
> 57-bit address space bitmap.
> 
> > On each memory request, the kernel then must consider a percentage of
> > allocated space in its calculation, and on systems with less memory
> > this quickly becomes a problem.
> 
> I'm not sure what you're referring to here?  Are you referring to our
> overcommit limits?

Yes.
