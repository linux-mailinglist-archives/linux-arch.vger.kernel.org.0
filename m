Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B52D4927B5
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2019 16:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfHSO4y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 10:56:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34410 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfHSO4y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Aug 2019 10:56:54 -0400
Received: from zn.tnic (p200300EC2F04B7003923E3AC7BEA9973.dip0.t-ipconnect.de [IPv6:2003:ec:2f04:b700:3923:e3ac:7bea:9973])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D35141EC04CD;
        Mon, 19 Aug 2019 16:56:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566226612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uL8XD/CJYv4Vc8MNOkuxTsIsj/5UNIGjzcyVsd0lTGg=;
        b=A+qR5RmWScF4AslQ7okxH81RwFDlSuXu1WxiWJf6A0nYWawlqdCtTeYgPdOdtP8QHG5QAE
        ujTTrZYZUpOiM3BSxFZaJtLUYzK2laSsQ1ssD+QDCh62P+fkbSuyscZeNmJCzxkM5+L6ZB
        JxjbfmJOQaT1NwGM4JGDHZ3kzJX0xrc=
Date:   Mon, 19 Aug 2019 16:56:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 10/28] x86/asm/entry: annotate interrupt symbols
 properly
Message-ID: <20190819145652.GC4522@zn.tnic>
References: <20190808103854.6192-1-jslaby@suse.cz>
 <20190808103854.6192-11-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190808103854.6192-11-jslaby@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 08, 2019 at 12:38:36PM +0200, Jiri Slaby wrote:
> * annotate functions properly by SYM_CODE_START, SYM_CODE_START_LOCAL*
>   and SYM_CODE_END -- these are not C-like functions, so we have to
>   annotate them using CODE.
> * use SYM_INNER_LABEL* for labels being in the middle of other functions
> 
> [v4] alignments preserved
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> ---
>  arch/x86/entry/entry_32.S | 28 ++++++++++++++--------------
>  arch/x86/entry/entry_64.S | 13 ++++++-------
>  2 files changed, 20 insertions(+), 21 deletions(-)

Here again some of the symbols are used only in a single complilation
unit and thus made local symbols by prepending their name with ".L" so
that they don't pollute the symbol table. Pls do that for all symbols
you're touching, while you're at it.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
