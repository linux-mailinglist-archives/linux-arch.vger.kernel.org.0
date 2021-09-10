Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93725406A30
	for <lists+linux-arch@lfdr.de>; Fri, 10 Sep 2021 12:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhIJKgN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Sep 2021 06:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbhIJKgM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Sep 2021 06:36:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86A2C061574;
        Fri, 10 Sep 2021 03:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BnjkoDkjsjbdXuJZMHVw/3vYnTAfTHmvYL5pCGMzvlY=; b=lmeSAtMHCytohrvC+nvRBrDp+6
        uqPZ39i5/+awbr3fwLg/H/9UbKwiY7KnpQREJyxJiwhjpr6LJ0NjFh7BTpa7NYdaMn+4sriGJ8evK
        j0N7JBub7U9n2PyWI4bIvO2ry9i6a8Poiaol5DU08xkMk6VbbdB8mKive2vqhlyZ7S7dSVEKLBlgt
        iWOUdsQ6CvrOFmNnWIJ0DycCD1uKcOMyLP4qcWknOyNjHQxEHWs80tma9Ue7dcg7T5LxpjFAeWA9x
        i+6ShrzKY13J96aPtn2C2KXUMv1KC8tIQSpjPcAqr6TJKidYmUvamFqIugsgexBIsw/o0ssvPUtIT
        w60rghaA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOdq4-00AumA-0Z; Fri, 10 Sep 2021 10:33:11 +0000
Date:   Fri, 10 Sep 2021 11:32:56 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 18/22] LoongArch: Add PCI controller support
Message-ID: <YTs0WGYEFZp8uIO7@infradead.org>
References: <20210903095213.797973-1-chenhuacai@loongson.cn>
 <20210903095213.797973-19-chenhuacai@loongson.cn>
 <YTjbaz7iea1kwGYb@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTjbaz7iea1kwGYb@robh.at.kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Why is this whole series not on linux-kernel?
