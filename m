Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCCCD2FE6
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2019 20:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfJJSDf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 14:03:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55890 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbfJJSDf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Oct 2019 14:03:35 -0400
Received: from zn.tnic (p200300EC2F0A6300D1C0EB70E9B309BA.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:6300:d1c0:eb70:e9b3:9ba])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9C0E51EC090E;
        Thu, 10 Oct 2019 20:03:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570730613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1UJ85wrxUTh6ZjmKP+WxNvKm5uhVcmHwuihzVVphUA0=;
        b=nU1pP2YSMQ1D+YbJ1lqIUj3fIbqXmRei9IrwE7casgVZ3bf6uvckQOYFEy6VxgMByJdLas
        gfLhF2deNPAW3vJXpynsBSp1uVNCkCK3TGs2a02YYiWnywAPZqOojj1vdVy9ucSV/QlrU6
        X6II6ljlFaBt+0oSrDlytkAJMAR1SFQ=
Date:   Thu, 10 Oct 2019 20:03:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/29] vmlinux.lds.h: Refactor EXCEPTION_TABLE and NOTES
Message-ID: <20191010180331.GI7658@zn.tnic>
References: <20190926175602.33098-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190926175602.33098-1-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 26, 2019 at 10:55:33AM -0700, Kees Cook wrote:
> This series works to move the linker sections for NOTES and
> EXCEPTION_TABLE into the RO_DATA area, where they belong on most
> (all?) architectures. The problem being addressed was the discovery
> by Rick Edgecombe that the exception table was accidentally marked
> executable while he was developing his execute-only-memory series. When
> permissions were flipped from readable-and-executable to only-executable,
> the exception table became unreadable, causing things to explode rather
> badly. :)
> 
> Roughly speaking, the steps are:
> 
> - regularize the linker names for PT_NOTE and PT_LOAD program headers
>   (to "note" and "text" respectively)
> - regularize restoration of linker section to program header assignment
>   (when PT_NOTE exists)
> - move NOTES into RO_DATA
> - finish macro naming conversions for RO_DATA and RW_DATA
> - move EXCEPTION_TABLE into RO_DATA on architectures where this is clear
> - clean up some x86-specific reporting of kernel memory resources
> - switch x86 linker fill byte from x90 (NOP) to 0xcc (INT3), just because
>   I finally realized what that trailing ": 0x9090" meant -- and we should
>   trap, not slide, if execution lands in section padding

Yap, nice patchset overall.

> Since these changes are treewide, I'd love to get architecture-maintainer
> Acks and either have this live in x86 -tip or in my own tree, however
> people think it should go.

Sure, I don't mind taking v2 through tip once I get ACKs from the
respective arch maintainers.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
