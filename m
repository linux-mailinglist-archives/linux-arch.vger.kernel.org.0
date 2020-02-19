Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A28B6164B95
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 18:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgBSRNQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 12:13:16 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57462 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgBSRNQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 12:13:16 -0500
Received: from zn.tnic (p200300EC2F095500C57DC876B1A4488F.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5500:c57d:c876:b1a4:488f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1221A1EC0CD9;
        Wed, 19 Feb 2020 18:13:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582132395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7DfBAxzsfzsoaYwSMpHlffOsW+v1IJwqGqC7dCae8pc=;
        b=imNSNhnnTsPWZyruxhXu5PjDZvAq0QlZ+HEcsO9G4JBHbZNvvsoE/fN/jMNeWLOBXL8XYW
        jeJ+NyGsmQ32sg6VcdD9QImnYCOIeOuT36XRAS3IydbycQEkdxW9IJoB5ZWjzl0otIU36N
        M4bdz0HJ62EoC9R6p5snvwkv2MjSjwM=
Date:   Wed, 19 Feb 2020 18:13:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 02/22] x86,mce: Delete ist_begin_non_atomic()
Message-ID: <20200219171309.GC32346@zn.tnic>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.488895196@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200219150744.488895196@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 03:47:26PM +0100, Peter Zijlstra wrote:
> Subject: Re: [PATCH v3 02/22] x86,mce: Delete ist_begin_non_atomic()

x86/mce: ...

> It is an abomination; and in prepration of removing the whole
> ist_enter() thing, it needs to go.
> 
> Convert #MC over to using task_work_add() instead; it will run the
> same code slightly later, on the return to user path of the same
> exception.

That's fine because the error happened in userspace.

...

> @@ -1202,6 +1186,29 @@ static void __mc_scan_banks(struct mce *
>  	*m = *final;
>  }
>  
> +static void mce_kill_me_now(struct callback_head *ch)
> +{
> +	force_sig(SIGBUS);
> +}
> +
> +static void mce_kill_me_maybe(struct callback_head *cb)

You don't even need the "mce_" prefixes - those are static functions and
in mce-land.

Change looks good otherwise.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
