Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B431849BDB8
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jan 2022 22:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbiAYVKT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jan 2022 16:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiAYVKQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jan 2022 16:10:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31160C061744;
        Tue, 25 Jan 2022 13:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9sBIA+4FUEiJsQc79gzBYm8TOBmdFpT74KXdSSubq6E=; b=eSKbIlnsv6RWgx7nwqgpkPqt5q
        EeCKatmP3k8DXITTemQLP53mSBz51qcd/VQGIhMSObhR+bTW5Cj8VBAXKYwj2Lil106cEWpZw88L5
        +VhQL/T1F4csdtkaIllFtvH3ArdQr7c4PoGbqaIhGAfeWq2WmnYyVpaPy8AjAzIvTGt65X/nxKURK
        ILINrwlO+ff2g782ZKFNBQPDrt2Zn6A5rwafsEW3/ImsPmPhBxFpMZIjNpgQnXxed6MX6D9hAABLV
        86OBLVcWGuI5Uf68fz1pNxiLkn30JJ+zWGrL+0m5BMhMRpysm1FMtgSq4nkKQDLiF9ZhIviZ3vNhP
        SiSkuCfg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCT4w-009ZLT-9v; Tue, 25 Jan 2022 21:10:14 +0000
Date:   Tue, 25 Jan 2022 13:10:14 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Jessica Yu <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 6/7] modules: Add
 CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
Message-ID: <YfBnNuXpR2l2AuCP@bombadil.infradead.org>
References: <cover.1643015752.git.christophe.leroy@csgroup.eu>
 <848d857871f457f4df37e80fad468d615b237c24.1643015752.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <848d857871f457f4df37e80fad468d615b237c24.1643015752.git.christophe.leroy@csgroup.eu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 24, 2022 at 09:22:34AM +0000, Christophe Leroy wrote:
> This can also be useful on other powerpc/32 in order to maximize the
> chance of code being close enough to kernel core to avoid branch
> trampolines.

Curious about all this branch trampoline talk. Do you have data to show
negative impact with things as-is?

Also, was powerpc/32 broken then without this? The commit log seems to
suggest so, but I don't think that's the case. How was this issue noticed?

Are there other future CPU families being planned where this is all true for
as well? Are they goin to be 32-bit as well?

  Luis
