Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E182C5AEA
	for <lists+linux-arch@lfdr.de>; Thu, 26 Nov 2020 18:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404438AbgKZRo2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Nov 2020 12:44:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:50852 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403951AbgKZRo2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Nov 2020 12:44:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2B60AC2D;
        Thu, 26 Nov 2020 17:44:26 +0000 (UTC)
Date:   Thu, 26 Nov 2020 18:44:18 +0100
From:   Borislav Petkov <bp@suse.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org, len.brown@intel.com, dave.hansen@intel.com,
        hjl.tools@gmail.com, Dave.Martin@arm.com, mpe@ellerman.id.au,
        tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v2 2/4] x86/elf: Support a new ELF aux vector
 AT_MINSIGSTKSZ
Message-ID: <20201126174418.GA29770@zn.tnic>
References: <20201119190237.626-1-chang.seok.bae@intel.com>
 <20201119190237.626-3-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201119190237.626-3-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 19, 2020 at 11:02:35AM -0800, Chang S. Bae wrote:
> Historically, signal.h defines MINSIGSTKSZ (2KB) and SIGSTKSZ (8KB), for
> use by all architectures with sigaltstack(2). Over time, the hardware state
> size grew, but these constants did not evolve. Today, literal use of these
> constants on several architectures may result in signal stack overflow, and
> thus user data corruption.
> 
> A few years ago, the ARM team addressed this issue by establishing
> getauxval(AT_MINSIGSTKSZ), such that the kernel can supply at runtime value
> that is an appropriate replacement on the current and future hardware.
> 
> Add getauxval(AT_MINSIGSTKSZ) support to x86, analogous to the support
> added for ARM in commit 94b07c1f8c39 ("arm64: signal: Report signal frame
> size to userspace via auxv").

I don't see it documented here:

https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man3/getauxval.3

Dunno, now that two architectures will have it, maybe that is good
enough reason to document it.

Adding Michael.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
