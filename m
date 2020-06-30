Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5A820F58F
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 15:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbgF3NZS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Jun 2020 09:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730381AbgF3NZO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jun 2020 09:25:14 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A402C061755;
        Tue, 30 Jun 2020 06:25:13 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqGG4-002oEt-RX; Tue, 30 Jun 2020 13:25:08 +0000
Date:   Tue, 30 Jun 2020 14:25:08 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 18/41] regset: new method and helpers for it
Message-ID: <20200630132508.GF2786714@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
 <20200629182628.529995-18-viro@ZenIV.linux.org.uk>
 <CAHk-=wjd5HML-EuPGH7J8CjWJrbnMhst3NJbcUyt-P0RV649nA@mail.gmail.com>
 <20200629203028.GB2786714@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629203028.GB2786714@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 29, 2020 at 09:30:28PM +0100, Al Viro wrote:

> >  (b) or just call it something better to begin with. Maybe just
> > "get_regset" instead?
> 
> <nod>
> 
> Frankly, other field names there are also nasty - 'set' is not
> fun to grep for, but there are 'n' and 'size' as well.  There's
> also 'bias'  and 'align' (both completely unused)...

How about ->regset_get()?  I've force-pushed a variant with that change +
removal of leftover unused variables (caught by Intel build bot) +
braino fix in sparc conversion (spotted when looking through the
patchset again); same branch names.  Not sure if it's worth a repost
of the entire patchbomb...
