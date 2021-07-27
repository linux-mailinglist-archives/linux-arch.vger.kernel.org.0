Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5D13D7ED6
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 22:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhG0UKV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 16:10:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhG0UKV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Jul 2021 16:10:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C853660F9B;
        Tue, 27 Jul 2021 20:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1627416620;
        bh=Y+22u+tRLyeCEMBb6In1ZjF6k/Q7kC+hWd73eqYEGas=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BVqWR6/vu3R3J5zfoKCep8iyJZp5vpOXQXMjCpyBKF5+fjjmsM3GAAh9luGKAyX8w
         TnUSkae4d6enUtqjUMLK5elkiFVHeOBBlB/WvoSt+pulwa5YBeWjHLswiQ/pay/Rwt
         WFBpnLlfubVGd5wruQc9aelH0q3iYdqHJRaI6Jng=
Date:   Tue, 27 Jul 2021 13:10:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Feng Tang <feng.tang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 0/6] compat: remove compat_alloc_user_space
Message-Id: <20210727131017.f151a81fc69db8f45f81a2b3@linux-foundation.org>
In-Reply-To: <YQAfa6iObAwwIpzb@infradead.org>
References: <20210727144859.4150043-1-arnd@kernel.org>
        <YQAfa6iObAwwIpzb@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 27 Jul 2021 15:59:55 +0100 Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Jul 27, 2021 at 04:48:53PM +0200, Arnd Bergmann wrote:
> > Since these patches are now all that remains, it would be nice to
> > merge it all through Andrew's Linux-mm tree, which is already based
> > on top of linux-next.
> 
> Is it?

the -mm tree is structured as

<90% of stuff>
linux-next.patch
<the other 10% of stuff>

So things like Arnd's series which have a dependency on linux-next
material get added to the "other 10%" and are merged behind the
linux-next material and all is good.

If possible I'll queue things ahead of linux-next.patch.  Those few
things which have dependencies on linux-next material get sent to Linus
after the required linux-next material is merged into mainline.
