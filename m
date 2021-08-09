Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9AB3E4FC3
	for <lists+linux-arch@lfdr.de>; Tue, 10 Aug 2021 01:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbhHIXEs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Aug 2021 19:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236956AbhHIXEo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Aug 2021 19:04:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5E0460EE7;
        Mon,  9 Aug 2021 23:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628550263;
        bh=OIh9zq+IYhIhIiKupvVvEHfwMY95evZX39qJfIxbmIQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=X8QGkNyjeiBeJxlag/3SN2Xpw8+OC6Gj+cGkK/KDvR2kMaz8dO92SR2ah14t3AUn7
         QEvsvIrJr17Mc59De5xJNqhaOuVxNocXjM3Yo3B2cZMswh85C10nzKhXAXBwA05ja3
         8SOA/ErgtlUiuGMylliyQqHxqeeUEjhIRfxEZ3ZMuhVJOtFORoydv5utNDDo6Q23+U
         afQKwHGApnvhQwEyf/iMawyeTk4ZokAahsi8gDVxwfvP6jYw82QHgZdSyXvabZhqSp
         0BqWOwqMQcxjWSmwX1GaHhbeF4UGmmjF9tTGPHkzUsmeik75aOTd8fKRzJlbzOgiag
         tzAt5zk5K1n8A==
Subject: Re: [PATCH v28 04/10] x86/cet/ibt: Disable IBT for ia32
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
References: <20210722205723.9476-1-yu-cheng.yu@intel.com>
 <20210722205723.9476-5-yu-cheng.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <3318ca57-7ac3-8296-f9ae-0ae83d5f95dd@kernel.org>
Date:   Mon, 9 Aug 2021 16:04:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210722205723.9476-5-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/22/21 1:57 PM, Yu-cheng Yu wrote:
> In a signal, a task's IBT status needs to be saved to the signal frame, and
> later restored in sigreturn.  For the purpose, previous versions of the
> series add a new struct to the signal frame.  However, a new signal frame
> format (or re-using a reserved space) introduces complex compatibility
> issues.
> 
> In the discussion (see link below), Andy Lutomirski proposed using a
> ucontext flag.  The approach is clean and eliminates most compatibility
> issues.
> 
> However, a legacy IA32 signal frame does not have ucontext and cannot
> support a uc flag.  Thus,
> 
> - Disable IBT for ia32.
> - In ia32 sigreturn, verify ibt is disabled.

Acked-by: Andy Lutomirski <luto@kernel.org>
