Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E767749BD79
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jan 2022 21:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiAYUw2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jan 2022 15:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbiAYUw0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jan 2022 15:52:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86120C061744;
        Tue, 25 Jan 2022 12:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UtdWMxSaDfBxA1q0kzgQMgUK1HA1XhmJT8E1djQS6r0=; b=HvBznvMJXXQ5wCjccOuoxDI4Xg
        B0ZgQhBeJBmlYaz0y3xOyJWjufMCOjIM51mEjGkrr468wyWeSIOC43+MhGGsLj0jiiBhZv2e4Xdrf
        +q1DgDWnxd2xFJGSszFC7FuHnN9Mxm8KNIboDx6XMtU3qtEuUFEwEB/s4iPlLDNci5nVimutWqHGB
        A0b5yTakxCAwyfm2xzNWv89jmW51ynCxKa90P9QYpZioBsFtxa9XICM/efvmtx9FK/vauxcEYCJRi
        +vp6Euhll5yx1btYLyamKdkUd9M2VV0FZ0KeBgSBM7HtBeJhTozULpcBES/kSQKEzuds+h57qbxof
        BnNEe57g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCSnd-009Xxc-Os; Tue, 25 Jan 2022 20:52:21 +0000
Date:   Tue, 25 Jan 2022 12:52:21 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Jessica Yu <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 0/7] Allocate module text and data separately
Message-ID: <YfBjBRFEbljfbrvx@bombadil.infradead.org>
References: <cover.1643015752.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1643015752.git.christophe.leroy@csgroup.eu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 24, 2022 at 09:22:11AM +0000, Christophe Leroy wrote:
> This series allow architectures to request having modules data in
> vmalloc area instead of module area.
> 
> This is required on powerpc book3s/32 in order to set data non
> executable, because it is not possible to set executability on page
> basis, this is done per 256 Mbytes segments. The module area has exec
> right, vmalloc area has noexec.
> 
> This can also be useful on other powerpc/32 in order to maximize the
> chance of code being close enough to kernel core to avoid branch
> trampolines.

Am I understanding that this entire effort is for 32-bit powerpc?
If so, why such an interest in 32-bit these days?

  Luis
