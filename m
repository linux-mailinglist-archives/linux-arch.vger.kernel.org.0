Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E492D167C
	for <lists+linux-arch@lfdr.de>; Mon,  7 Dec 2020 17:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgLGQhT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Dec 2020 11:37:19 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55868 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgLGQhS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Dec 2020 11:37:18 -0500
Received: from zn.tnic (p200300ec2f0a38008a496889bd0f59a1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:3800:8a49:6889:bd0f:59a1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 91A0E1EC0527;
        Mon,  7 Dec 2020 17:36:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607358996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=upOLoLwKqFXpg52lafTFF50LNTA779rHuHh39h/2HSE=;
        b=BXgePymDOQGSm5skSk0I0jU847LQ0R7y2mBf+jrhX06tw4BlOnsG0FtVoFz97jlrH2BiDs
        ceX3eExwz2o2Kn84EvDSmbF8sgs4yle02DaZ9VMTM5/rk5+krbJ2Zm80dSFjcaAhtufVOb
        dtAiZAApJA4k60I9lrp4zcsKKdCfHow=
Date:   Mon, 7 Dec 2020 17:36:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
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
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v15 07/26] x86/mm: Remove _PAGE_DIRTY_HW from kernel RO
 pages
Message-ID: <20201207163632.GE20489@zn.tnic>
References: <20201110162211.9207-1-yu-cheng.yu@intel.com>
 <20201110162211.9207-8-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201110162211.9207-8-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 10, 2020 at 08:21:52AM -0800, Yu-cheng Yu wrote:
> Kernel read-only PTEs are setup as _PAGE_DIRTY_HW.  Since these become
> shadow stack PTEs, remove the dirty bit.

This commit message is laconic to say the least. You need to start
explaining what you're doing because everytime I look at a patch of
yours, I'm always grepping the SDM and looking forward in the patchset,
trying to rhyme up what that is all about.

Like for this one. I had to fast-forward to the next patch where all
that is explained. But this is not how review works - each patch's
commit message needs to be understandable on its own because when
they land upstream, they're not in a patchset like here. And review
should be done in the order the patches are numbered - not by jumping
back'n'forth.

So please think of the readers of your patches when writing those commit
messages. Latter are *not* write-only and not unimportant.

And those readers haven't spent copious amounts of time on the
technology so being more verbose and explaining things is a Good
Thing(tm). Don't worry about explaining too much - better too much than
too little.

And last but not least, having understandable and properly written
commit messages increases the chances of your patches landing upstream
considerably.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
