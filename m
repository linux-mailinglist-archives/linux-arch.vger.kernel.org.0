Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AA341BD70
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 05:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243965AbhI2Dbx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Sep 2021 23:31:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243349AbhI2Dbw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Sep 2021 23:31:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DADA6136A;
        Wed, 29 Sep 2021 03:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1632886212;
        bh=lAsZkVWCgtK9MeeRJYwB3NBoT+2DxJthR4/1O1TAIes=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dfVjJrubYTO47quRVYblsuacimy4FdB01c/nTYORGfFL1JUqj7Gjssp7j1DflRu19
         DcZ6fguLWly3Lnj/eMqi4Cvk4LUTap0e9stLMmvC17RZxhUlHcPjGyoeqcfCrO0y4F
         gBEkAfZBr2ag37SjeuamGob5UZM6VN4l8mYqaQXw=
Date:   Tue, 28 Sep 2021 20:30:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2 2/4] mm: Make generic arch_is_kernel_initmem_freed()
 do what it says
Message-Id: <20210928203011.da1f059b72be9ada7d67fe35@linux-foundation.org>
In-Reply-To: <ec69cc95a98548c862c22b742936244fdb0c7984.1632813331.git.christophe.leroy@csgroup.eu>
References: <ffa99e8e91e756b081427b27e408f275b7d43df7.1632813331.git.christophe.leroy@csgroup.eu>
        <ec69cc95a98548c862c22b742936244fdb0c7984.1632813331.git.christophe.leroy@csgroup.eu>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 28 Sep 2021 09:15:35 +0200 Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Commit 7a5da02de8d6 ("locking/lockdep: check for freed initmem in
> static_obj()") added arch_is_kernel_initmem_freed() which is supposed
> to report whether an object is part of already freed init memory.
> 
> For the time being, the generic version of arch_is_kernel_initmem_freed()
> always reports 'false', allthough free_initmem() is generically called
> on all architectures.
> 
> Therefore, change the generic version of arch_is_kernel_initmem_freed()
> to check whether free_initmem() has been called. If so, then check
> if a given address falls into init memory.
> 
> In order to use function init_section_contains(), the fonction is
> moved at the end of asm-generic/section.h

i386 allmodconfig:

In file included from arch/x86/platform/intel-quark/imr.c:28:
./include/asm-generic/sections.h: In function 'arch_is_kernel_initmem_freed':
./include/asm-generic/sections.h:171:6: error: 'system_state' undeclared (first use in this function)
  171 |  if (system_state < SYSTEM_FREEING_INITMEM)
      |      ^~~~~~~~~~~~
./include/asm-generic/sections.h:171:6: note: each undeclared identifier is reported only once for each function it appears in
./include/asm-generic/sections.h:171:21: error: 'SYSTEM_FREEING_INITMEM' undeclared (first use in this function)
  171 |  if (system_state < SYSTEM_FREEING_INITMEM)
      |                     ^~~~~~~~~~~~~~~~~~~~~~


I don't think it would be a good idea to include kernel.h from
sections.h - it's unclear to me which is the "innermost" of those two. 
It would be better to uninline arch_is_kernel_initmem_freed().  Surely
there's no real reason for inlining it?

Anyway, I'll drop the series for now.

