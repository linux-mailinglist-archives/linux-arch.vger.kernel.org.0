Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923D12EF70C
	for <lists+linux-arch@lfdr.de>; Fri,  8 Jan 2021 19:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbhAHSKO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Jan 2021 13:10:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:57156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727910AbhAHSKO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Jan 2021 13:10:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A723EAD29;
        Fri,  8 Jan 2021 18:09:32 +0000 (UTC)
Date:   Fri, 8 Jan 2021 19:09:35 +0100
From:   Borislav Petkov <bp@suse.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org, len.brown@intel.com, dave.hansen@intel.com,
        hjl.tools@gmail.com, Dave.Martin@arm.com, jannh@google.com,
        mpe@ellerman.id.au, tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] x86/signal: Prevent an alternate stack overflow
 before a signal delivery
Message-ID: <20210108180935.GB12995@zn.tnic>
References: <20201223015312.4882-1-chang.seok.bae@intel.com>
 <20201223015312.4882-4-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201223015312.4882-4-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 22, 2020 at 05:53:11PM -0800, Chang S. Bae wrote:
> The kernel pushes data on the userspace stack when entering a signal. If
> using a sigaltstack(), the kernel precisely knows the user stack size.
^^^^^^^^^^^^^^^^^^^^^^^

Formulate properly.

> 
> When the kernel knows that the user stack is too small, avoid the overflow
> and do an immediate SIGSEGV instead.
      ^^^^^^^^^^^^^^^^^^^^^^^

Ditto.

> This overflow is known to occur on systems with large XSAVE state. The
> effort to increase the size typically used for altstacks reduces the
						^^^^^^^^^^

"alternate signal stacks"

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
