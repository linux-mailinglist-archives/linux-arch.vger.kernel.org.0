Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2871DDA9B
	for <lists+linux-arch@lfdr.de>; Fri, 22 May 2020 00:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbgEUW7W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 May 2020 18:59:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:2085 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730041AbgEUW7V (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 May 2020 18:59:21 -0400
IronPort-SDR: rTpUX+v5Hc2pq3n/OdYSloDEEu/rS9n6m+7pnHoHduc6+u/t3bxn/fBSMEtxJsRPMxp/8dhMV0
 iUNinOrlMkLA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 15:59:20 -0700
IronPort-SDR: eVA4JMNYAhSkSjemmj7kQC1KSJo0SX42WpA2RqMlctZwO8R35JeFbPRT0ymL+Id0zifNd8bXm/
 8RWIhAI4W53w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,419,1583222400"; 
   d="scan'208";a="309207695"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by FMSMGA003.fm.intel.com with ESMTP; 21 May 2020 15:59:17 -0700
Message-ID: <35ce10628df75494569e5cf5bb6a3c537ff30cf2.camel@intel.com>
Subject: Re: [RFC PATCH 4/5] selftest/x86: Fix sysret_rip with ENDBR
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
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
Date:   Thu, 21 May 2020 15:59:23 -0700
In-Reply-To: <878shlt1jw.fsf@nanos.tec.linutronix.de>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
         <20200521211720.20236-5-yu-cheng.yu@intel.com>
         <878shlt1jw.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2020-05-21 at 23:34 +0200, Thomas Gleixner wrote:
> Yu-cheng Yu <yu-cheng.yu@intel.com> writes:
> 
> > Insert endbr64 to assembly code of sysret_rip.
> 
> This changelog explains what the patch does, but not the WHY. It also
> lacks any information why this is harmless for !CET enabled systems.
> 
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > ---
> 
> Please consult Dave Hansen about the void between your Signed-off-by
> and the '---' line.
> 
> Thanks,
> 
>         tglx

Thanks!  I will work on it.

Yu-cheng

