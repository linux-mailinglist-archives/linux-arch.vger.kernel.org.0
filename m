Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1783C882B
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jul 2021 17:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhGNQBP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jul 2021 12:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbhGNQBO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jul 2021 12:01:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541B3C061760;
        Wed, 14 Jul 2021 08:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8hYbifPc76LOzb2J+B8p5+vM4MPArprBkZh5uX63Hig=; b=VoMLlign6ABzQtnSPGgC8GeY3N
        TCkfMzz6Zjc1Yx2M2uY1bp4yCW5ASHcc4ZUvYaUuQAOOsYgrhLwKqrbuMYdU0yK30q8Fi8tCa8UGt
        ppaCgr+M2tP1VHdULFfST/DUV3ly4CavZFUFxJfgxdC7Z3+mlpEfeW+EL8A/H/753OyQYzxR1xGaA
        RdLVfK6TcZWRYg9xYmKlKY7i2GXWl4ZykuGDVl2s3RFHFPQVkt42yQUJGHkv70bFGm8+2CXwxPkhR
        E28fbhmbY+z95NKpr6gLzHgOaHeKOgNet3Gqeq9W4JKwsvq9uDvaXVVXWNz7TqTt9dCpW+96EyFQ+
        0sQpnDvg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3hFe-002LYj-8m; Wed, 14 Jul 2021 15:57:12 +0000
Date:   Wed, 14 Jul 2021 16:56:46 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH] Decouple build from userspace headers
Message-ID: <YO8JPuay5e3wz//n@infradead.org>
References: <YO3txvw87MjKfdpq@localhost.localdomain>
 <YO7zEFNSXOY8pKCQ@infradead.org>
 <YO8IoNwXS4h26+9v@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YO8IoNwXS4h26+9v@localhost.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 14, 2021 at 06:54:08PM +0300, Alexey Dobriyan wrote:
> On Wed, Jul 14, 2021 at 03:22:08PM +0100, Christoph Hellwig wrote:
> > > -#define signals_blocked false
> > > +#define signals_blocked 0
> > 
> > Why can't we get at the kernel definition of false here?
> 
> Variable and other code surrounding this wants "int".
> I don't really want to expand into bool conversion.

Maybe split this into a separate prep patch then.
