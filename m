Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE63174183D
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jun 2023 20:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjF1Svp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jun 2023 14:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjF1SvZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jun 2023 14:51:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6161FF7;
        Wed, 28 Jun 2023 11:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gzBVL7uWfH/0QncUeiWSVvNT7tu19KKFpZm/SdtHfy0=; b=F0geF1mDFUhFwejscu79P5AerF
        ChPxlz8AungTNw2nYlH8TmeT0FdBYZ403uLo6dwYbFZivePasVeM2QOKhl+SGZUnj3aelPYXtEfM9
        SrOHM/3oUTni3eU+S6cGIy3fXu368hUaiU/EA6YN2NOx+dDC0fkki3YX0I7X5QXDEfuDII33co6YT
        AgpMwEBC4ya/EPvRDl80CtdVgP3e2XagbMLqDsAoh6VP3gh2KZpEwz3m1/E0HTdSv3vSxKIUbldmu
        z9Fsmk0Dd2L6fefBSyj6JHJ0VqW7vTaNglMS0xkY6KNSksqhU+OkIfDiDfBXKznANmEoK/ikyWU4U
        7raG+AtA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qEaFx-0047Cx-Rw; Wed, 28 Jun 2023 18:51:09 +0000
Date:   Wed, 28 Jun 2023 19:51:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "David S. Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v6 00/33] Split ptdesc from struct page
Message-ID: <ZJyBHdcjuaykIRG9@casper.infradead.org>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
 <e8992eee-4140-427e-bacb-9449f346318@google.com>
 <ac1c162c-07d8-6084-44ca-a2c1a4183df2@redhat.com>
 <90e643ca-de72-2f4c-f4fe-35e06e1a9277@google.com>
 <26282cb8-b6b0-f3a0-e82d-b4fec45c5f72@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26282cb8-b6b0-f3a0-e82d-b4fec45c5f72@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 28, 2023 at 09:41:18AM +0200, David Hildenbrand wrote:
> I'm not a friend of these "overlays"; it all only really makes sense to me
> once we actually allocate the descriptors dynamically. Maybe some of the
> existing/ongoing conversions were different (that's why I was asking for the
> difference, as you said the "struct slab" thing was well received).
> 
> If they are primarily only unnecessary churn for now (and unclear when/how
> it will become useful), I share your opinion.

One of the reasons for doing these conversions "early" is that it helps
people who work on this code know what fields they can actually use in
their memory descriptor.  We have a _lot_ of historical baggage with
people just using random bits in struct page for their own purposes
without necessarily considering the effects on the rest of the system.

By creating specific types for each user of struct page, we can see
what's actually going on.  Before the ptdesc conversion started, I could
not have told you which bits in struct page were used by the s390 code.
I knew they were playing some fun games with the refcount (it's even
documented in the s390 code!) but I didn't know they were using ...
whetever it is; page->private to point to the kvm private data?

So maybe it is harder for MM developers right now to see what fields in
memdesc A overlap with which fields in memdesc B.  That _ought_ not to
be a concern!  We document which fields are available in each memdesc,
and have various assertions to trip when people make things not line up
any more.  There can still be problems, of course; we haven't set the
assertions quite tightly enough in some cases.

People are going to keep adding crap to struct page, and they're going
to keep misusing the crap that's in struct page.  That has to stop.
