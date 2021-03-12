Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A4533940E
	for <lists+linux-arch@lfdr.de>; Fri, 12 Mar 2021 17:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhCLQ6P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Mar 2021 11:58:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:50476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231679AbhCLQ6F (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Mar 2021 11:58:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37F6B6500F;
        Fri, 12 Mar 2021 16:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615568284;
        bh=gKkUVElYcaHXJ1ly/d4kbT2/9U4Tw7bw+eiTqrYs7b8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZqPKG5aG0BpfyoiUeBI+egQZFVtE5C+b8/t5mfL9duPO3caEsNO/vNn5sF9SkBQ1+
         1pyIdEMn1uJbl1knOM1Hd+2H8n/a2TgyJfT5P3sdXi8R58yJ4HCyK0MyTYpZukSv3M
         9M4r3fSPLLMTlFwXVUsHkGA6ppr6GuR4F6l5cNLeGDhHlSose0r4vYwUxn4HhiHafx
         s56kQ8fVgyWoOqisATyAYrQgfJQU3caA8o4XbyruZjM43vwurHGkFr36Q1Uj+pPUEx
         JaoawokOszzZMlPemGoaCFkS7/iKRpbAY4B5VVSCtm9/Je9wazSjgpck8LnetP3Nt4
         Y9KG49L+wv39g==
Date:   Fri, 12 Mar 2021 18:57:40 +0200
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
Message-ID: <YEudhOlCk5ZUb8v9@kernel.org>
References: <20210310220519.16811-1-yu-cheng.yu@intel.com>
 <20210310220519.16811-9-yu-cheng.yu@intel.com>
 <YElKjT2v628tidE/@kernel.org>
 <8b8efe44-b79f-ce29-ee28-066f88c93840@intel.com>
 <c2bfe707-2ef6-213a-f02c-4689726a473a@intel.com>
 <YEudGizbVrQaRoPq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YEudGizbVrQaRoPq@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 12, 2021 at 06:55:57PM +0200, Jarkko Sakkinen wrote:
> On Wed, Mar 10, 2021 at 03:20:20PM -0800, Dave Hansen wrote:
> > On 3/10/21 2:55 PM, Yu, Yu-cheng wrote:
> > > On 3/10/2021 2:39 PM, Jarkko Sakkinen wrote:
> > >> On Wed, Mar 10, 2021 at 02:05:19PM -0800, Yu-cheng Yu wrote:
> > >>> When CET is enabled, __vdso_sgx_enter_enclave() needs an endbr64
> > >>> in the beginning of the function.
> > >>
> > >> OK.
> > >>
> > >> What you should do is to explain what it does and why it's needed.
> > >>
> > > 
> > > The endbr marks a branch target.  Without the "no-track" prefix, if an
> > > indirect call/jmp reaches a non-endbr opcode, a control-protection fault
> > > is raised.  Usually endbr's are inserted by the compiler.  For assembly,
> > > these have to be put in manually.  I will add this in the commit log if
> > > there is another revision.  Thanks!
> > 
> > This is close, but it's missing a detail or two that I think is
> > important for someone like Jarkko trying to figure out what it means for
> > his subsystem or driver.
> > 
> > I'd probably say:
> > 
> > ENDBR is a special new instruction for the Indirect Branch Tracking
> > (IBR) component of CET.  IBT prevents attacks by ensuring that (most)
> > indirect branches and function calls may only land at ENDBR
> > instructions.  Branches that don't follow the rules will result in
> > control flow (#CF) exceptions.
> > 
> > ENDBR is a noop when IBT is unsupported or disabled.  Most ENDBR
> > instructions are inserted automatically by the compiler, but branch
> > targets written in assembly must have ENDBR added manually, like this one.
> 
> Thank you, this clears the whole thing a lot.
> 
> Doesn't this mean that it could be there just as well unconditionally?

Please, ignore the question (got the answer).

/Jarkko
