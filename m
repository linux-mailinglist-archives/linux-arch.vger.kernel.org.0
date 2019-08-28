Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E183A018D
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2019 14:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfH1MYY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Aug 2019 08:24:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43672 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfH1MYX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Aug 2019 08:24:23 -0400
Received: from zn.tnic (p200300EC2F0A5300B1A6357224C8EB83.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5300:b1a6:3572:24c8:eb83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E9ED31EC06E5;
        Wed, 28 Aug 2019 14:24:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566995058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kboUowfYWa+pTbnRkXQv/3rDdRX8gtuWZNvDaHTigoY=;
        b=m8Od59iGU/uu/tVlO+ylm+OL48LfTbu5CkVfET1frnc0UxUwmW2EHdCZOilZNADXiGnzi2
        R9cWiQBOaygTP/WsTs6Q5ROvdtz2K1CqH++hJnvBqQ1h3Z1iVn+/a4IPOGqU95QDnDkTJT
        zuCmDAb9pf46FGWK+nIB+BJcj7J8HGc=
Date:   Wed, 28 Aug 2019 14:24:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Asm & local labels for functions [was: [PATCH v8 05/28] x86/asm:
 annotate local pseudo-functions]
Message-ID: <20190828122417.GH4920@zn.tnic>
References: <20190808103854.6192-1-jslaby@suse.cz>
 <20190808103854.6192-6-jslaby@suse.cz>
 <20190815160719.GI15313@zn.tnic>
 <c5e0f683-796c-f552-0c3b-8a1105446200@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5e0f683-796c-f552-0c3b-8a1105446200@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 28, 2019 at 01:47:23PM +0200, Jiri Slaby wrote:
> Let's start with this one: do you really want me to get rid of (local)
> symbols like this? It would make backtraces completely misleading as the
> unwinder would put a name of the previous function (or some garbage,
> depending on unwinder) into the backtrace...

Yes, while looking at your patches, I was thinking about what
would be a good rule to use with which to make symbols local. I
guess those which are small and not really important for stack
traces like "bad_gs" in entry_64., for example. Or "relocated" in
arch/x86/boot/compressed/head_64.S, as another example. That last one
you probably are never going to see in stack traces due to it being too
early anyway.

Or, if we think that those symbols are important for stack traces, then
they should be called something more prominent, with a naming prefix or
so, so that they can be assigned to the respective source easier.

Am I making some sense?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
