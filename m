Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9355014A470
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2020 14:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgA0NFe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jan 2020 08:05:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42820 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgA0NFe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jan 2020 08:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Qc26HyQAHogWcsmxTgBMKkoJi2+EVu/8ujULdcjBIe0=; b=UoFaOHjohUQOSrNw18yEKcDQs
        IPmp5D1GQJ6a3TvW8gwb54yw2Dwpjl+Rz6q2mO8GknLvkOp29yMdvGozOxzuixFcnqsgDw5BK68na
        rnDJhEEwhB06SuDgrwnORP2PKkkO8VBLC6c2N13gey00wMDQv5RBheY6tjbnTMK4k8Rw89u3DLKRg
        6hO1m8hgLqprxw+EC9Q9d7NkPwUsTcnIMw1lIWDzPk9H24AuimUx1cD2DdbnKiDlpTnYRQCp+Ga+a
        4ffYMHq3F07jPYL8irFCnD2uwpbsuK9ygp975UF5DiRHMd4AIebXy2ww4zuae/JGePtC3nQNkOs68
        wQeLRqdfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iw44g-0001WM-55; Mon, 27 Jan 2020 13:05:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8633B302524;
        Mon, 27 Jan 2020 14:03:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1BAD720D95C0C; Mon, 27 Jan 2020 14:05:03 +0100 (CET)
Date:   Mon, 27 Jan 2020 14:05:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Burton <paulburton@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Nick Hu <nickhu@andestech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH mk-II 08/17] asm-generic/tlb: Provide
 MMU_GATHER_TABLE_FREE
Message-ID: <20200127130503.GG14879@hirez.programming.kicks-ass.net>
References: <20191211120713.360281197@infradead.org>
 <20191211122956.112607298@infradead.org>
 <20191212093205.GU2827@hirez.programming.kicks-ass.net>
 <20200126155205.GA19169@roeck-us.net>
 <20200127081134.GI14914@hirez.programming.kicks-ass.net>
 <33932bc9-1fca-66ae-8f55-6da2f131c5be@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33932bc9-1fca-66ae-8f55-6da2f131c5be@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 27, 2020 at 01:43:34PM +0530, Aneesh Kumar K.V wrote:

> I did send a change to fix that. it is to drop !SMP change in the patch
> 
> https://lore.kernel.org/linux-mm/87v9p9mhnr.fsf@linux.ibm.com

Indeed you did. Did those patches land anywhere, or is it all still up
in the air? (I was hoping to find those patches in a tree somewhere)
