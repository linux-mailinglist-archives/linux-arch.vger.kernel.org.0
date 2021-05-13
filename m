Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF4B37FE75
	for <lists+linux-arch@lfdr.de>; Thu, 13 May 2021 21:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhEMT6P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 May 2021 15:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbhEMT6P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 May 2021 15:58:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FBFC061574;
        Thu, 13 May 2021 12:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=9ZAZ+z881JDgTJzeQAm+Bs/QG0gxkchxMNdqqahoJwQ=; b=ZRIwz8JsMo8S7kk7JJ2nYXyVn8
        i2CmwCoP+e+egCGimcWStyryMxR1DwYJifPYyMcUlVx721k9SSkIDIMItviFvzwcVkkthACsC1QtG
        maatHXBOERsuuLf62eHRpCIhDw9XI3fXHpqJOCWVbbQWqC1jR74Nnm+LP4sMnhl+4M395djjm2Xj1
        2NtwFYxdxD8zBcHtxyRn5U2iU6pgmZG2zsyQdlVRfFEaRxkp6InoHMMXAtCR1rKqkBZMl2I4WF2uM
        KJH1oX6/hZ2l9jWAl8BXd7ahfQcZ8hSlmNLwMpCTupGwj8ZbBi2vUg6EVYomPDOFMVgl6+BhGGLZ2
        GEqAIkXQ==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.253])
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhHS9-00BUYB-13; Thu, 13 May 2021 19:57:01 +0000
Subject: Re: [PATCH] x86: Define only {pud/pmd}_{set/clear}_huge when usefull
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
References: <7fbf1b6bc3e15c07c24fa45278d57064f14c896b.1620930415.git.christophe.leroy@csgroup.eu>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d18bec2b-8a6e-b218-f92b-87016db8a3a7@infradead.org>
Date:   Thu, 13 May 2021 12:56:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <7fbf1b6bc3e15c07c24fa45278d57064f14c896b.1620930415.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/13/21 11:27 AM, Christophe Leroy wrote:
> When PUD and/or PMD are folded, those functions are useless
> and we have a stub in linux/pgtable.h
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/x86/mm/pgtable.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)

WorksForMe. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

-- 
~Randy

