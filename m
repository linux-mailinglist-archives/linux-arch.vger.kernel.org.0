Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E578D6435
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2019 15:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbfJNNiw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Oct 2019 09:38:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47974 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbfJNNiw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Oct 2019 09:38:52 -0400
Received: from zn.tnic (p200300EC2F065800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:5800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A4FC71EC0C84;
        Mon, 14 Oct 2019 15:38:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571060330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LhYo1U9soey/Z97d/lKYsmusPjDbMy/Va9YT9lXIm1g=;
        b=jGQz/+S0wRTH2pyZEosxps3kXmMusTWGViB6H5Pe1/f7C/nwE/x+ng54x8ecX38VKE22d8
        F8UhFSDpK2GhPSeow6blkHdFvDPONgXkBqqW30mLGqANcG9vxLkv+1PCkQkfHjv4Xr2pDP
        AAgsFEv4j92y4qB70ZH9iqrhjjWc/Y4=
Date:   Mon, 14 Oct 2019 15:38:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v9 04/28] x86/asm/entry: Annotate THUNKs
Message-ID: <20191014133843.GC4715@zn.tnic>
References: <20191011115108.12392-1-jslaby@suse.cz>
 <20191011115108.12392-5-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191011115108.12392-5-jslaby@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 11, 2019 at 01:50:44PM +0200, Jiri Slaby wrote:
> Place SYM_*_START_NOALIGN and SYM_*_END around the THUNK macro body.
> Preserve @function by FUNC (64bit) and CODE (32bit). Given it was not
> marked as aligned, use NOALIGN.

Yeah, I guess the NOALIGN is causing some relaxing of alignment because
the symbols all "move up", from looking at the addresses:

before:
$ readelf -a vmlinux | grep -E "\W(trace_hardirqs_o(n|ff)_thunk|lockdep_sys_exit_thunk|___preempt_schedule)"
 70007: ffffffff81001c60    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_off_thunk
 78467: ffffffff81001c40    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_on_thunk
 82067: ffffffff81001cc0    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule_notra
 86509: ffffffff81001c80    24 FUNC    GLOBAL DEFAULT    1 lockdep_sys_exit_thunk
 87594: ffffffff81001ca0    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule

after:
$ readelf -a vmlinux | grep -E "\W(trace_hardirqs_o(n|ff)_thunk|lockdep_sys_exit_thunk|___preempt_schedule)"
 70007: ffffffff81001c50    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_off_thunk
 78467: ffffffff81001c34    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_on_thunk
 82067: ffffffff81001c9c    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule_notra
 86509: ffffffff81001c6c    24 FUNC    GLOBAL DEFAULT    1 lockdep_sys_exit_thunk
 87594: ffffffff81001c84    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
