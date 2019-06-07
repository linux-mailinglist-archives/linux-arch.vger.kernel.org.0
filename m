Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA69339694
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2019 22:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfFGUOO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jun 2019 16:14:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:41728 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729353AbfFGUOO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 Jun 2019 16:14:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 13:14:14 -0700
X-ExtLoop1: 1
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by orsmga002.jf.intel.com with ESMTP; 07 Jun 2019 13:14:12 -0700
Message-ID: <0e505563f7dae3849b57fb327f578f41b760b6f7.camel@intel.com>
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
Date:   Fri, 07 Jun 2019 13:06:10 -0700
In-Reply-To: <4b448cde-ee4e-1c95-0f7f-4fe694be7db6@intel.com>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com>
         <20190606200926.4029-4-yu-cheng.yu@intel.com>
         <20190607080832.GT3419@hirez.programming.kicks-ass.net>
         <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com>
         <20190607174336.GM3436@hirez.programming.kicks-ass.net>
         <b3de4110-5366-fdc7-a960-71dea543a42f@intel.com>
         <34E0D316-552A-401C-ABAA-5584B5BC98C5@amacapital.net>
         <7e0b97bf1fbe6ff20653a8e4e147c6285cc5552d.camel@intel.com>
         <4b448cde-ee4e-1c95-0f7f-4fe694be7db6@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2019-06-07 at 13:00 -0700, Dave Hansen wrote:
> On 6/7/19 12:49 PM, Yu-cheng Yu wrote:
> > > 
> > > This also gives us an excellent opportunity to make it read-only as seen
> > > from
> > > userspace to prevent exploits from just poking it full of ones before
> > > redirecting execution.
> > 
> > GLIBC sets bits only for legacy code, and then makes the bitmap read-
> > only.  That
> > avoids most issues:
> > 
> >   To populate bitmap pages, mprotect() is required.
> >   Reading zero bitmap pages would not waste more physical memory, right?
> 
> Huh, how does glibc know about all possible past and future legacy code
> in the application?

When dlopen() gets a legacy binary and the policy allows that, it will manage
the bitmap:

  If a bitmap has not been created, create one.
  Set bits for the legacy code being loaded.

Yu-cheng
