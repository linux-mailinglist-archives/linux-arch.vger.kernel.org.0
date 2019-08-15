Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED09E8EBC3
	for <lists+linux-arch@lfdr.de>; Thu, 15 Aug 2019 14:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbfHOMmo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Aug 2019 08:42:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45440 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfHOMmn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Aug 2019 08:42:43 -0400
Received: from zn.tnic (p200300EC2F0B52007D93C58FB2CAB236.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5200:7d93:c58f:b2ca:b236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A11E31EC0959;
        Thu, 15 Aug 2019 14:42:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565872962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nh3pf51gCZmQw2YfQM+MgPsZnvg6T7RDaOXPp08q8gE=;
        b=gHATmie+7+tCBI8m6VDMKU7fIzpG6Gr6CPMbvoCpY4Sx/6dNSKkaakRabgFwpXnYcUMDmo
        IVIPjnTBkD9mOTeMUULICeC+sF25MCrVSpnq/Gjr+S7YBaj3cLwseX9+xPd5Qug0V6sEUj
        71VETtXK6yLjo8ZjMz65r/bk4DIXbCU=
Date:   Thu, 15 Aug 2019 14:43:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 04/28] x86/asm/entry: annotate THUNKs
Message-ID: <20190815124328.GG15313@zn.tnic>
References: <20190808103854.6192-1-jslaby@suse.cz>
 <20190808103854.6192-5-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190808103854.6192-5-jslaby@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 08, 2019 at 12:38:30PM +0200, Jiri Slaby wrote:
> Place SYM_*_START_NOALIGN and SYM_*_END around the THUNK macro body.
> Preserve @function by FUNC (64bit) and CODE (32bit). Given it was not
> marked as aligned, use NOALIGN.
> 
> The common tail .L_restore is put inside SYM_CODE_START_LOCAL_NOALIGN
> and SYM_CODE_END too.

What is that needed for? It is a local label...

> The result:
>  Value  Size Type    Bind   Vis      Ndx Name
>   0000    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_on_thunk
>   001c    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_off_thunk
>   0038    24 FUNC    GLOBAL DEFAULT    1 lockdep_sys_exit_thunk
>   0050    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule
>   0068    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule_notra

No difference except alignment:

before:
 70545: ffffffff81001c20    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_off_thunk
 78965: ffffffff81001c00    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_on_thunk
 82545: ffffffff81001c80    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule_notra
 86963: ffffffff81001c40    24 FUNC    GLOBAL DEFAULT    1 lockdep_sys_exit_thunk
 88045: ffffffff81001c60    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule

after:
 70545: ffffffff81001c10    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_off_thunk
 78965: ffffffff81001bf4    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_on_thunk
 82545: ffffffff81001c5c    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule_notra
 86963: ffffffff81001c2c    24 FUNC    GLOBAL DEFAULT    1 lockdep_sys_exit_thunk
 88045: ffffffff81001c44    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
