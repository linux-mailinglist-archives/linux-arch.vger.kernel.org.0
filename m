Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6218A41C
	for <lists+linux-arch@lfdr.de>; Mon, 12 Aug 2019 19:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfHLRRj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Aug 2019 13:17:39 -0400
Received: from foss.arm.com ([217.140.110.172]:53012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbfHLRRj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Aug 2019 13:17:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C90F215AB;
        Mon, 12 Aug 2019 10:17:38 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59BEC3F706;
        Mon, 12 Aug 2019 10:17:37 -0700 (PDT)
Date:   Mon, 12 Aug 2019 18:17:35 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
Message-ID: <20190812171734.GC62772@arrakis.emea.arm.com>
References: <20190807155321.9648-1-catalin.marinas@arm.com>
 <20190807155321.9648-2-catalin.marinas@arm.com>
 <20190808170424.6td34cpdngkcxxpu@willie-the-truck>
 <20190812104606.GY56241@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812104606.GY56241@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 12, 2019 at 11:46:06AM +0100, Andrew Murray wrote:
> On Thu, Aug 08, 2019 at 06:04:24PM +0100, Will Deacon wrote:
> > On Wed, Aug 07, 2019 at 04:53:20PM +0100, Catalin Marinas wrote:
> > > +
> > > +- mmap() addr parameter.
> > > +
> > > +- mremap() new_address parameter.
> > > +
> > > +- prctl(PR_SET_MM, ``*``, ...) other than arg2 PR_SET_MM_MAP and
> > > +  PR_SET_MM_MAP_SIZE.
> > > +
> > > +- prctl(PR_SET_MM, PR_SET_MM_MAP{,_SIZE}, ...) struct prctl_mm_map fields.
> > 
> > How did you generate this list and who will keep it up to date? How do you
> > know you haven't missed anything?
> 
> What about shared memory system calls: shmat, shmdt? The latest "arm64: untag
> user pointers passed to the kernel" series doesn't untag these, thus we should
> indicate here that these too are no supported.

Yes. We dropped them from a previous version of the series but they've
never been documented. I'll add something (unless someone has a real
use-case for using tags with shmat/shmdt).

-- 
Catalin
