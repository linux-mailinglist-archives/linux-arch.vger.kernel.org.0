Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCCE258891
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 08:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgIAGyc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 02:54:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgIAGyb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Sep 2020 02:54:31 -0400
Received: from kernel.org (unknown [87.70.91.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAA4E2087D;
        Tue,  1 Sep 2020 06:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598943271;
        bh=NVmhxz3quM6Qr+ee/JkOEjpslKF1E6DzA+56ugDqG9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t9Y31Vy9OQ4upleKjlqFdKlJK15KKX0SeJMrIzpOD+h6YlgofD7l0DMfSRLJ3VJky
         nrx3MQjQHGExn3IlWT0UpeVebNfTu7czSbvy817AI5ED9IboS07XLdgA4yy7spNWwP
         DDlnAwt6zWXRDvjtlRUnCMDswWZXlDSzXZawiaLk=
Date:   Tue, 1 Sep 2020 09:54:25 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 00/23] Use asm-generic for mmu_context no-op functions
Message-ID: <20200901065425.GE432455@kernel.org>
References: <20200826145249.745432-1-npiggin@gmail.com>
 <20200830101837.GB423750@kernel.org>
 <1598940942.o1fbygdcvl.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598940942.o1fbygdcvl.astroid@bobo.none>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 01, 2020 at 04:17:00PM +1000, Nicholas Piggin wrote:
> Excerpts from Mike Rapoport's message of August 30, 2020 8:18 pm:
> > On Thu, Aug 27, 2020 at 12:52:26AM +1000, Nicholas Piggin wrote:
> >> It would be nice to be able to modify mmu_context functions or add a
> >> hook without updating all architectures, many of which will be no-ops.
> >> 
> >> The motivation for this series is a change to lazy mmu handling, but
> >> this series stands on its own as a good cleanup whether or not we end
> >> up making that change.
> > 
> > I really like this series, I just have some small comments in reply to
> > patch 1, otherwise feel free to add
> > 
> > Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> I can't see your comments in reply to patch 1.

Hmm, apparently I forgot to hit "Send"... 

> Thanks,
> Nick
> 

-- 
Sincerely yours,
Mike.
