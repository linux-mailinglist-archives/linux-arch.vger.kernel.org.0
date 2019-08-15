Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 767AC8E6C4
	for <lists+linux-arch@lfdr.de>; Thu, 15 Aug 2019 10:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbfHOIgy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Aug 2019 04:36:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38020 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfHOIgx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Aug 2019 04:36:53 -0400
Received: from zn.tnic (p200300EC2F0B5200DD69E9E370CF27BC.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5200:dd69:e9e3:70cf:27bc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6FBFF1EC0716;
        Thu, 15 Aug 2019 10:36:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565858212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bir8kfrFAU0YOr+52ulKaVBapWTLDDk20LurJeUAdC8=;
        b=cR17bCeABBpDdIUzGc7YWd3uwXYEqWuXVxZSIGpZxPyjxaOtJETk/yQyBBZIk5VU14SnmH
        hQgq/7GUbGaYt7oXzdie9cBhCkUQ/3pb1v8i3yjmrlHRIlFPZkELPExF8QoyGsysYvjba4
        spjxZTU9DvRF7hi3vacAOGoidznER+c=
Date:   Thu, 15 Aug 2019 10:37:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 03/28] x86/asm: annotate relocate_kernel
Message-ID: <20190815083737.GD15313@zn.tnic>
References: <20190808103854.6192-1-jslaby@suse.cz>
 <20190808103854.6192-4-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190808103854.6192-4-jslaby@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 08, 2019 at 12:38:29PM +0200, Jiri Slaby wrote:
> There are functions in relocate_kernel which are not annotated. This
					^
					_{32,64}.c

> makes automatic annotations rather hard. So annotate all the functions
> now.
> 
> Note that these are not C-like functions, so we do not use FUNC, but
> CODE markers. Also they are not aligned, so we use the NOALIGN versions:
> - SYM_CODE_START_NOALIGN
> - SYM_CODE_START_LOCAL_NOALIGN
> - SYM_CODE_END
> 
> In return, we get:
>   0000   108 NOTYPE  GLOBAL DEFAULT    1 relocate_kernel
>   006c   165 NOTYPE  LOCAL  DEFAULT    1 identity_mapped
>   0146   127 NOTYPE  LOCAL  DEFAULT    1 swap_pages
>   0111    53 NOTYPE  LOCAL  DEFAULT    1 virtual_mapped

It would be cool if those NOTYPE objects could be marked as OS-specific:

From /usr/include/elf.h:

#define STT_LOOS        10              /* Start of OS-specific */

to denote that they're special but gas doesn't seem to support that type
out of the box at least.

Oh well...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
