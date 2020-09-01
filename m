Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E562E259846
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 18:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbgIAQYt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 12:24:49 -0400
Received: from elvis.franken.de ([193.175.24.41]:45859 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730952AbgIAPcT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Sep 2020 11:32:19 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1kD8Gf-0002rq-01; Tue, 01 Sep 2020 17:32:17 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 0F0A1C0E68; Tue,  1 Sep 2020 17:23:24 +0200 (CEST)
Date:   Tue, 1 Sep 2020 17:23:24 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v3 11/23] mips: use asm-generic/mmu_context.h for no-op
 implementations
Message-ID: <20200901152324.GB14288@alpha.franken.de>
References: <20200901141539.1757549-1-npiggin@gmail.com>
 <20200901141539.1757549-12-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901141539.1757549-12-npiggin@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 02, 2020 at 12:15:27AM +1000, Nicholas Piggin wrote:
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-mips@vger.kernel.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> 
> Please ack or nack if you object to this being mered via
> Arnd's tree.
> 
>  arch/mips/include/asm/mmu_context.h | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
