Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AC03A7765
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 08:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhFOGzM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 02:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhFOGzL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 02:55:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C298C061574;
        Mon, 14 Jun 2021 23:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HjqockSIfBbywK4+NYwBOmrFJ3f5fy0pM7CjjlotpPw=; b=Hb/kwJ8t4jmHWjBHR9cw2/GUN0
        Za3ApHmavr4okvhH8OnZ7KI18mt0S8WR5Oz704W/FyQE3AuTOB8AKlA2rcp9DLO/R5JXk7+sIOgph
        WoYvfoRo+6sFmU4D80e+bzpxWQDpG+Zrrj4MKwsVgOY0evtx3fXRmyRbKVXEIDMUxThsuDzFCcVwf
        3j0ZbgnP6g3RCwBFADY+pjBI3VTItkFEVufT+aRspwgmYgYaOora+BorDssyLfspLkNCnLepSr6vR
        ABLQFcJc+EYyKXop476njYyvnCoods/Xzw4x+Zzz+K61xP54T7Ic1qB3sF1nBpoG3GxBeYLxAGgGd
        WMrQFy/Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lt2w6-006BMm-9v; Tue, 15 Jun 2021 06:52:37 +0000
Date:   Tue, 15 Jun 2021 07:52:34 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] signal: Add unsafe_copy_siginfo_to_user()
Message-ID: <YMhOMoKKvew0YYCt@infradead.org>
References: <b813c1f4d3dab2f51300eac44d99029aa8e57830.1623739212.git.christophe.leroy@csgroup.eu>
 <684939dcfef612fac573d1b983a977215b71f64d.1623739212.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <684939dcfef612fac573d1b983a977215b71f64d.1623739212.git.christophe.leroy@csgroup.eu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 15, 2021 at 06:41:01AM +0000, Christophe Leroy wrote:
> +	unsafe_copy_to_user(__ucs_to, __ucs_from,			\
> +			    sizeof(struct kernel_siginfo), label);	\
> +	unsafe_clear_user(__ucs_expansion, SI_EXPANSION_SIZE, label);	\
> +} while (0)

unsafe_clear_user does not exist at this point, and even your later
patch only adds it for powerpc.
