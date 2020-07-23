Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C674222AA42
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 10:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgGWIAg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 04:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgGWIAg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 04:00:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E83FC0619DC;
        Thu, 23 Jul 2020 01:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zdzKrLJWVt7aMT8LFFNV0HicuVIyoT4jgGhxcP12oPc=; b=Q/FHCbVwm0YHTtgQLQ5AVmewfb
        Hvzq4sdK6evanSAHQMeTP1LqZHGbgot3dRZExQsR4mY1pu5mYt+ItperI9xhV6pb4pnTls4q7pOHL
        Zoa7c/ohOdZAFmJkDlS5H05aYM1GUHPrvorQtuBayB56sFIakTWqXlWKmszV7CAsOBtZyPsxUk6cf
        VPnddPyyv7lFdF9NQ4mNTdEU/OFeBqA1OflcOWRlJUQhIDEH0+SFZTPrVBatv+JB1XFv8g8ceLjqj
        pp0giyLjTxQYboaG68RRB7PzVSD3L7CyZD7OGFbsKBshK21vrgRuzDMmcsbZHqGaK/SnGys8ziTbx
        SDoixo2Q==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyW9V-0001aZ-UH; Thu, 23 Jul 2020 08:00:29 +0000
Date:   Thu, 23 Jul 2020 09:00:29 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [RFC][PATCHSET] regset ->get() rework
Message-ID: <20200723080029.GA5815@infradead.org>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629182349.GA2786714@ZenIV.linux.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Al,

what's the state of the series?  I noticed it hasn't shown up in
linux-next so far.
