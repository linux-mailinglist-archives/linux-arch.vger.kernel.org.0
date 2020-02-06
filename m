Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA99154D09
	for <lists+linux-arch@lfdr.de>; Thu,  6 Feb 2020 21:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgBFUhd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Feb 2020 15:37:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:45767 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727773AbgBFUhd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Feb 2020 15:37:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 12:37:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,410,1574150400"; 
   d="scan'208";a="226268571"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga008.fm.intel.com with ESMTP; 06 Feb 2020 12:37:32 -0800
Message-ID: <b0e7e487d1bf92bf19df2ecf199b90c76d9097dd.camel@intel.com>
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Date:   Thu, 06 Feb 2020 12:17:30 -0800
In-Reply-To: <af5ee976-3b57-4afe-6304-fcab8de45c77@infradead.org>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
         <20200205181935.3712-2-yu-cheng.yu@intel.com>
         <af5ee976-3b57-4afe-6304-fcab8de45c77@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2020-02-05 at 16:16 -0800, Randy Dunlap wrote:
> Hi,
> 
> I have a few comments and a question (please see inline below).
> 
> 
> On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
[...]
> > +arch_prctl(ARCH_X86_CET_LOCK)
> > +    Lock in CET feature.
> 
> which feature?

Both SHSTK and IBT are locked.  They cannot be turned off afterwards.

I will check things you pointed out.

Thanks,
Yu-cheng

