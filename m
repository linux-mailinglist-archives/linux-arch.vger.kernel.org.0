Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBB817AE4B
	for <lists+linux-arch@lfdr.de>; Thu,  5 Mar 2020 19:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgCESjJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Mar 2020 13:39:09 -0500
Received: from mga12.intel.com ([192.55.52.136]:53061 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgCESjJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Mar 2020 13:39:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 10:39:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="233019834"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga007.fm.intel.com with ESMTP; 05 Mar 2020 10:39:09 -0800
Message-ID: <5dcc9da2caff92a9af16846cbe1f168f61368c51.camel@intel.com>
Subject: Re: [RFC PATCH v9 18/27] x86/cet/shstk: Introduce WRUSS instruction
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
Date:   Thu, 05 Mar 2020 10:39:08 -0800
In-Reply-To: <202002251309.E238DFEEB4@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
         <20200205181935.3712-19-yu-cheng.yu@intel.com>
         <202002251309.E238DFEEB4@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2020-02-25 at 13:10 -0800, Kees Cook wrote:
> On Wed, Feb 05, 2020 at 10:19:26AM -0800, Yu-cheng Yu wrote:
> > WRUSS is a new kernel-mode instruction but writes directly to user Shadow
> > Stack (SHSTK) memory.  This is used to construct a return address on SHSTK
> > for the signal handler.
> > 
> > This instruction can fault if the user SHSTK is not valid SHSTK memory.
> > In that case, the kernel does a fixup.
> 
> Since these functions aren't used in this patch, should this get merged
> with patch 19?

Yes, I can do that.

Yu-cheng

