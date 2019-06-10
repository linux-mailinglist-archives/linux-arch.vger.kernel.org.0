Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC9D33B91E
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2019 18:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389811AbfFJQNV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jun 2019 12:13:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:55102 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388850AbfFJQNV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Jun 2019 12:13:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 09:13:20 -0700
X-ExtLoop1: 1
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jun 2019 09:13:19 -0700
Message-ID: <5dc357f5858f8036cad5847cfe214401bb9138bf.camel@intel.com>
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
Date:   Mon, 10 Jun 2019 09:05:13 -0700
In-Reply-To: <f6de9073-9939-a20d-2196-25fa223cf3fc@intel.com>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com>
         <20190606200926.4029-4-yu-cheng.yu@intel.com>
         <20190607080832.GT3419@hirez.programming.kicks-ass.net>
         <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com>
         <20190607174336.GM3436@hirez.programming.kicks-ass.net>
         <b3de4110-5366-fdc7-a960-71dea543a42f@intel.com>
         <34E0D316-552A-401C-ABAA-5584B5BC98C5@amacapital.net>
         <7e0b97bf1fbe6ff20653a8e4e147c6285cc5552d.camel@intel.com>
         <4b448cde-ee4e-1c95-0f7f-4fe694be7db6@intel.com>
         <0e505563f7dae3849b57fb327f578f41b760b6f7.camel@intel.com>
         <f6de9073-9939-a20d-2196-25fa223cf3fc@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2019-06-07 at 14:09 -0700, Dave Hansen wrote:
> On 6/7/19 1:06 PM, Yu-cheng Yu wrote:
> > > Huh, how does glibc know about all possible past and future legacy code
> > > in the application?
> > 
> > When dlopen() gets a legacy binary and the policy allows that, it will
> > manage
> > the bitmap:
> > 
> >   If a bitmap has not been created, create one.
> >   Set bits for the legacy code being loaded.
> 
> I was thinking about code that doesn't go through GLIBC like JITs.

If JIT manages the bitmap, it knows where it is.
It can always read the bitmap again, right?

Yu-cheng
