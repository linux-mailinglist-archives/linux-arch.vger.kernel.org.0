Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65004125503
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2019 22:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfLRVpf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Dec 2019 16:45:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:55244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfLRVpe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 96540AD5D;
        Wed, 18 Dec 2019 21:45:32 +0000 (UTC)
Date:   Wed, 18 Dec 2019 22:45:31 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Sandipan Das <sandipan@linux.ibm.com>, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        fweimer@redhat.com, x86@kernel.org, linuxram@us.ibm.com,
        mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com,
        aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v15 06/23] selftests/vm/pkeys: Typecast the pkey register
Message-ID: <20191218214531.GI4113@kitsune.suse.cz>
References: <cover.1576645161.git.sandipan@linux.ibm.com>
 <719ec65756a64cc03e8464a9c6da51c4519d2389.1576645161.git.sandipan@linux.ibm.com>
 <5b6c3f8a-9d2f-2534-c072-89f130ce110f@intel.com>
 <20191218205905.GG4113@kitsune.suse.cz>
 <15c3b6cc-d8da-9a32-da6a-4c3990f48994@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15c3b6cc-d8da-9a32-da6a-4c3990f48994@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 18, 2019 at 01:01:46PM -0800, Dave Hansen wrote:
> On 12/18/19 12:59 PM, Michal Suchánek wrote:
> >> I'd really just rather do %016lx *everywhere* than sprinkle the
> >> PKEY_REG_FMTs around.
> > Does lx work with u32 without warnings?
> 
> Either way, I'd be happy to just make the x86 one u64 to make the whole
> thing look more sane,

So long as it still works with u64 on x86 it should be pretty
future-proof.  Does not look like we are getting 128bit registers for
anything but math units any time soon.

Thanks

Michal
