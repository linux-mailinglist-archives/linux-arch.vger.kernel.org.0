Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9CB71DD283
	for <lists+linux-arch@lfdr.de>; Thu, 21 May 2020 17:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgEUP5w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 May 2020 11:57:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:6270 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727968AbgEUP5w (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 May 2020 11:57:52 -0400
IronPort-SDR: 0eEVmwzumtnz92CFANKpl7Uw5kFjC06+hfkC6qs7OgBN4I1TYxm/ltuGrUXLFWwvCZ/31vgtF8
 9s/1VzYrCfHQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 08:57:51 -0700
IronPort-SDR: KU0u7F/zAaSUkGmX6X4pMq8vLPzvIdvXNk9DZoNS/uZkOqFyB2C3kJui/HVPQAVxZhcb2vff4Z
 WGPr1cyxmXpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; 
   d="scan'208";a="255344664"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga008.fm.intel.com with ESMTP; 21 May 2020 08:57:51 -0700
Message-ID: <a1e7c71c72de517a288e6273ba0c18dac2e937bc.camel@intel.com>
Subject: Re: [PATCH v10 00/26] Control-flow Enforcement: Shadow Stack
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
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
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Date:   Thu, 21 May 2020 08:57:57 -0700
In-Reply-To: <20200521151556.pojijpmuc2rdd7ko@treble>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
         <20200521151556.pojijpmuc2rdd7ko@treble>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2020-05-21 at 10:15 -0500, Josh Poimboeuf wrote:
> On Wed, Apr 29, 2020 at 03:07:06PM -0700, Yu-cheng Yu wrote:
> > Control-flow Enforcement (CET) is a new Intel processor feature that blocks
> > return/jump-oriented programming attacks.  Details can be found in "Intel
> > 64 and IA-32 Architectures Software Developer's Manual" [1].
> > 
> > This series depends on the XSAVES supervisor state series that was split
> > out and submitted earlier [2].
> > 
> > I have gone through previous comments, and hope all concerns have been
> > resolved now.  Please inform me if anything is overlooked.
> > 
> > Changes in v10:
> 
> Hi Yu-cheng,
> 
> Do you have a git branch with the latest Shadow Stack and IBT branches
> applied?  I tried to apply IBT v9 on top of this, but I guess the SS
> code has changed since then and it didn't apply cleanly.

It is here:

https://github.com/yyu168/linux_cet/commits/cet

Yu-cheng

