Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874714A7BC5
	for <lists+linux-arch@lfdr.de>; Thu,  3 Feb 2022 00:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbiBBXgl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Feb 2022 18:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiBBXgl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Feb 2022 18:36:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E477C061714;
        Wed,  2 Feb 2022 15:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sKMSro+nqi3+TRaInDh/r5jt9h3R6I+1JvbqLUuQ9zw=; b=EQFB7AmHjcEOog2AgXpabrhNbq
        eb+nIuW++r278MsQm+yo6BJLgWEi7DgA0z/LlXygv3QszEhUFbTZTYEd7tnQF95I9q+HDvddpS0dr
        ZT4oOJqpMyq2CEFRDI9sNR/0008KH9VEFO6SEXb/UlghtmM1nhzbpJM/5gNt8d05BRv4D8tQ5GrZW
        fpzQ8SgxsTS6vdNOuRec1F/wQ5pWQ0g4+NAL2ajplTSo5BZ+1fnALWGrFPMSPAfHFWRnsxJ/WmIg1
        N3Sh1ZVZn6t5DVK/fZ6Xax5LywKa/tBa8o8JoZbW2WIGkbbwfyxz0e9MK78JgVYWCcygyNJY3ImiP
        uQFa5xkw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFPAz-00H4rN-PB; Wed, 02 Feb 2022 23:36:37 +0000
Date:   Wed, 2 Feb 2022 15:36:37 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Jessica Yu <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 5/5] powerpc: Select
 ARCH_WANTS_MODULES_DATA_IN_VMALLOC on book3s/32 and 8xx
Message-ID: <YfsVhcpVTW0+YCl5@bombadil.infradead.org>
References: <cover.1643282353.git.christophe.leroy@csgroup.eu>
 <a20285472ad0a0a13a1d93c4707180be5b4fa092.1643282353.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a20285472ad0a0a13a1d93c4707180be5b4fa092.1643282353.git.christophe.leroy@csgroup.eu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 27, 2022 at 11:28:12AM +0000, Christophe Leroy wrote:
> book3s/32 and 8xx have a separate area for allocating modules,
> defined by MODULES_VADDR / MODULES_END.
> 
> On book3s/32, it is not possible to protect against execution
> on a page basis. A full 256M segment is either Exec or NoExec.
> The module area is in an Exec segment while vmalloc area is
> in a NoExec segment.
> 
> In order to protect module data against execution, select
> ARCH_WANTS_MODULES_DATA_IN_VMALLOC.
> 
> For the 8xx (and possibly other 32 bits platform in the future),
> there is no such constraint on Exec/NoExec protection, however
> there is a critical distance between kernel functions and callers
> that needs to remain below 32Mbytes in order to avoid costly
> trampolines. By allocating data outside of module area, we
> increase the chance for module text to remain within acceptable
> distance from kernel core text.
> 
> So select ARCH_WANTS_MODULES_DATA_IN_VMALLOC for 8xx as well.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>

Cc list first and then the SOB.

  Luis
