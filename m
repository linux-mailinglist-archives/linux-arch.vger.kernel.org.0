Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754553393FE
	for <lists+linux-arch@lfdr.de>; Fri, 12 Mar 2021 17:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhCLQ4k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Mar 2021 11:56:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:49894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232501AbhCLQ4T (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Mar 2021 11:56:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BAC46501D;
        Fri, 12 Mar 2021 16:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615568179;
        bh=sUw5X72tXoX09gxNNea9KLqurXYlY189vCRL3W4qdik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G0oi+GyBCIDqsQHVnRhKDpq2WFc+tn4nKcydUWwiiUMAAd5j4YURLpF/QO1JgLRir
         SvUrEfEL2d9giqM6IwvBQ7/dDcdnZEC4LC/CPwz/RJuIWTSOsYOTXKXVq88RKlVXH5
         Gb3gTDMG2Xq3eIbJz2XbKgM8DB/tG3QN5V6WORRVTDIBHFeS9UMCL7DZyzXLvnWQcM
         QcU2tGem2rA38vh7k2HQVrAjr0Ds2MUPbHGdMDDmPKn0d6AwGLsJiAJFrtZRsjBek/
         AURbVhmz3efN/JgVM0lcUWNvS9uuqv6JFgSP+GptQtJvxMuU+dnVSKLISHD/R2GJW7
         088JTb7Yx3ZwA==
Date:   Fri, 12 Mar 2021 18:55:54 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v22 8/8] x86/vdso: Add ENDBR64 to __vdso_sgx_enter_enclave
Message-ID: <YEudGizbVrQaRoPq@kernel.org>
References: <20210310220519.16811-1-yu-cheng.yu@intel.com>
 <20210310220519.16811-9-yu-cheng.yu@intel.com>
 <YElKjT2v628tidE/@kernel.org>
 <8b8efe44-b79f-ce29-ee28-066f88c93840@intel.com>
 <c2bfe707-2ef6-213a-f02c-4689726a473a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2bfe707-2ef6-213a-f02c-4689726a473a@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 10, 2021 at 03:20:20PM -0800, Dave Hansen wrote:
> On 3/10/21 2:55 PM, Yu, Yu-cheng wrote:
> > On 3/10/2021 2:39 PM, Jarkko Sakkinen wrote:
> >> On Wed, Mar 10, 2021 at 02:05:19PM -0800, Yu-cheng Yu wrote:
> >>> When CET is enabled, __vdso_sgx_enter_enclave() needs an endbr64
> >>> in the beginning of the function.
> >>
> >> OK.
> >>
> >> What you should do is to explain what it does and why it's needed.
> >>
> > 
> > The endbr marks a branch target.  Without the "no-track" prefix, if an
> > indirect call/jmp reaches a non-endbr opcode, a control-protection fault
> > is raised.  Usually endbr's are inserted by the compiler.  For assembly,
> > these have to be put in manually.  I will add this in the commit log if
> > there is another revision.  Thanks!
> 
> This is close, but it's missing a detail or two that I think is
> important for someone like Jarkko trying to figure out what it means for
> his subsystem or driver.
> 
> I'd probably say:
> 
> ENDBR is a special new instruction for the Indirect Branch Tracking
> (IBR) component of CET.  IBT prevents attacks by ensuring that (most)
> indirect branches and function calls may only land at ENDBR
> instructions.  Branches that don't follow the rules will result in
> control flow (#CF) exceptions.
> 
> ENDBR is a noop when IBT is unsupported or disabled.  Most ENDBR
> instructions are inserted automatically by the compiler, but branch
> targets written in assembly must have ENDBR added manually, like this one.

Thank you, this clears the whole thing a lot.

Doesn't this mean that it could be there just as well unconditionally?

/Jarkko
