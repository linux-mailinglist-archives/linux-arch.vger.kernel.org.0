Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A690E339406
	for <lists+linux-arch@lfdr.de>; Fri, 12 Mar 2021 17:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhCLQ5M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Mar 2021 11:57:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:50066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231331AbhCLQ5K (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Mar 2021 11:57:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 625456500F;
        Fri, 12 Mar 2021 16:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615568229;
        bh=SJfafrtQ5B5A3SwT7vSgIDHHYLMqHVBXm88U6i/lrz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZBHd/DIGMGGyAQ1Fyh1z65o26PZRWPBaC7HmqL2I2BJz0xpc2D2+UYR+uWE4tsBfF
         zKsPdydcsHyw1HKBdrcdU09WvmHKT1lPsLFxQq0x37koIVDPApwPcgVE2kveptR7H0
         Gu8Krielpjd6FDaZcfu0WRktySs+gqtoAic+1xoP/7qJWXYv9txQA72CN1rXi2U3lV
         7StlQT3Yp/t/TOcJlVtySp/DZuikkwGIKJ4LjTgPwu4CX9j6jYIjJow80BFYaSDYED
         eUITaKLoDEK1lW+fqO8UYxW/ayjQ+Xni3OFKmdPBIvg+g18BK0aEN390EwRVKxLmcC
         Pux89hDB5Ihfg==
Date:   Fri, 12 Mar 2021 18:56:45 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, x86@kernel.org,
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
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v22 8/8] x86/vdso: Add ENDBR64 to __vdso_sgx_enter_enclave
Message-ID: <YEudTW1cKAQG10BG@kernel.org>
References: <20210310220519.16811-1-yu-cheng.yu@intel.com>
 <20210310220519.16811-9-yu-cheng.yu@intel.com>
 <YElKjT2v628tidE/@kernel.org>
 <8b8efe44-b79f-ce29-ee28-066f88c93840@intel.com>
 <YEmQJjwjs8UCEO2F@kernel.org>
 <YEnX3Zn0FXPt7pcM@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEnX3Zn0FXPt7pcM@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 11, 2021 at 09:42:05AM +0100, Peter Zijlstra wrote:
> On Thu, Mar 11, 2021 at 05:36:06AM +0200, Jarkko Sakkinen wrote:
> > Does it do any harm to put it there unconditionally?
> 
> Blows up your text footprint and I$ pressure. These instructions are 4
> bytes each.
> 
> Aside from that, they're a NOP, so only consume front-end resources
> (hopefully) on older CPUs and when IBT is disabled.

OK, understood, thanks for the explanation.

/Jarkko
