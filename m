Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863B733454E
	for <lists+linux-arch@lfdr.de>; Wed, 10 Mar 2021 18:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhCJRns (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Mar 2021 12:43:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:53390 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229828AbhCJRnQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Mar 2021 12:43:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E74C8ACBF;
        Wed, 10 Mar 2021 17:43:13 +0000 (UTC)
Date:   Wed, 10 Mar 2021 18:43:10 +0100
From:   Borislav Petkov <bp@suse.de>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "jannh@google.com" <jannh@google.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "carlos@redhat.com" <carlos@redhat.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v6 3/6] x86/elf: Support a new ELF aux vector
 AT_MINSIGSTKSZ
Message-ID: <20210310174310.GB25403@zn.tnic>
References: <20210227165911.32757-1-chang.seok.bae@intel.com>
 <20210227165911.32757-4-chang.seok.bae@intel.com>
 <20210305104325.GA2896@zn.tnic>
 <F637CCE0-1744-478C-B2ED-65EA14B07938@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F637CCE0-1744-478C-B2ED-65EA14B07938@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 10, 2021 at 04:34:40PM +0000, Bae, Chang Seok wrote:
> Yeah, right. While this attempts to fix the issue, it involves the ABI change.
> Len and I think PATCH5 [1] is rather a backport candidate as it gives a more
> reasonable behavior.

Yap, patch 5 is more conservative, sure.

I guess I can take it out of the set and send it Linuswards now.

> > That source code needs some special markup to look like source code -
> > currently, the result looks bad.
> 
> How about this code:

No, build the docs by doing

make htmldocs

and look at the result.

Btw, you should always look at the result before sending it out.

> Rewrote like this:
> 
> AT_SYSINFO is used for locating the vsyscall entry point.  It is not exported
> on 64-bit mode.
> 
> AT_SYSINFO_EHDR is the start address of the page containing the vDSO.
> 
> AT_MINSIGSTKSZ denotes the minimum stack size required by the kernel to
> deliver a signal to user-space.  AT_MINSIGSTKSZ comprehends the space consumed
> by the kernel to accommodate the user context for the current hardware
> configuration.  It does not comprehend subsequent user-space stack
> consumption, which must be added by the user.  (e.g. Above, user-space adds
> SIGSTKSZ to AT_MINSIGSTKSZ.)

Better.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
