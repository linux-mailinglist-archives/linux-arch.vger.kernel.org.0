Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2464331EAF1
	for <lists+linux-arch@lfdr.de>; Thu, 18 Feb 2021 15:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhBRO0I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Feb 2021 09:26:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:54006 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230386AbhBRLyd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Feb 2021 06:54:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613647717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GmsCgAZLPBXWqpRTBQJmNesuC+VzbGrswlfwNCxzi2Y=;
        b=DW7BCx40StPXtRqi8TB9MbTLE/gLCOfiRxXTism98TewhMtE8dWM10Pp3Z7pvRUoPLv1Z0
        Jof5xr9quqaa8Gz7Y0grIaJYTF7eIK4n88jHV+9sm+FC9vP8Py2LxfZ+9JDhBS/rpaqj0x
        JpYoUbS82OvN/3IGwpm+jVaj8mq1aWM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B667AAFF8;
        Thu, 18 Feb 2021 11:28:35 +0000 (UTC)
Date:   Thu, 18 Feb 2021 12:28:34 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>, Jann Horn <jannh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH RFC] mm/madvise: introduce MADV_POPULATE to
 prefault/prealloc memory
Message-ID: <YC5PYuYVMSs5Mm6Q@dhcp22.suse.cz>
References: <20210217154844.12392-1-david@redhat.com>
 <YC5Am6a4KMSA8XoK@dhcp22.suse.cz>
 <3763a505-02d6-5efe-a9f5-40381acfbdfd@redhat.com>
 <de28b8db-a103-5bc2-8ace-d2907026a95d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de28b8db-a103-5bc2-8ace-d2907026a95d@redhat.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu 18-02-21 11:54:48, David Hildenbrand wrote:
> > > >      If we hit
> > > >      hardware errors on pages, ignore them - nothing we really can or
> > > >      should do.
> > > > 3. On errors during MADV_POPULATED, some memory might have been
> > > >      populated. Callers have to clean up if they care.
> > > 
> > > How does caller find out? madvise reports 0 on success so how do you
> > > find out how much has been populated?
> > 
> > If there is an error, something might have been populated. In my QEMU
> > implementation, I simply discard the range again, good enough. I don't
> > think we need to really indicate "error and populated" or "error and not
> > populated".
> 
> Clarifying again: if madvise(MADV_POPULATED) succeeds, it returns 0. If
> there was a problem poopulating memory, it returns -ENOMEM (similar to
> MADV_WILLNEED). Callers can detect the error and discard.

As responded to the previous mail. I wouldn't really bother telling
callers what they should do. The interface will not give them any means
to identify the error. They just have to live with the fact that the
operation has failed.
-- 
Michal Hocko
SUSE Labs
