Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E0C185178
	for <lists+linux-arch@lfdr.de>; Fri, 13 Mar 2020 23:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgCMWAX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Mar 2020 18:00:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:3418 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbgCMWAX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Mar 2020 18:00:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 15:00:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,550,1574150400"; 
   d="scan'208";a="416431849"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005.jf.intel.com with ESMTP; 13 Mar 2020 15:00:21 -0700
Message-ID: <c8c394fba4b64c9151201952752647d61324c0a8.camel@intel.com>
Subject: Re: [RFC PATCH v9 15/27] mm: Handle THP/HugeTLB Shadow Stack page
 fault
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Date:   Fri, 13 Mar 2020 15:00:20 -0700
In-Reply-To: <202002251258.7D6DA92@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
         <20200205181935.3712-16-yu-cheng.yu@intel.com>
         <202002251258.7D6DA92@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2020-02-25 at 12:59 -0800, Kees Cook wrote:
> On Wed, Feb 05, 2020 at 10:19:23AM -0800, Yu-cheng Yu wrote:
> > This patch implements THP Shadow Stack (SHSTK) copying in the same way as
> > in the previous patch for regular PTE.
> > 
> > In copy_huge_pmd(), clear the dirty bit from the PMD to cause a page fault
> > upon the next SHSTK access to the PMD.  At that time, fix the PMD and
> > copy/re-use the page.
> 
> Now is as good a time as any to ask: do you have selftests for all this?
> It seems like it would be really nice to have a way to verify SHSTK is
> working correctly.

Yes, I have some simple tests at https://github.com/yyu168/cet-smoke-test.
I also run Linux/tools/testing/selftests/x86 and GLIBC tests with CET and THP
combinations.

Yu-cheng


