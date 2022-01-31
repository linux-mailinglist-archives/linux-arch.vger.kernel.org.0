Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624354A46F7
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jan 2022 13:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358872AbiAaM0Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jan 2022 07:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349455AbiAaM0W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jan 2022 07:26:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE27AC061714;
        Mon, 31 Jan 2022 04:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hBha+4ZQjalDLD6xPvVHvMBCdVa7nDcSg1bYsYjsECY=; b=dZZojRSxt2WA3XFgSMkkhmm99W
        DKsfcim8XFhS7PPpIU54jNrfklMqQCQ3kh0B05DBTfmBSbUcoc+vaP6TvxOzJPczr1r0721w0pujn
        owwK8/bOJ6fP/eCyLRLK12xJcyFUTZbOmylV8pOnBqZsg6jzFRvX4zV2LuBZEml1UfsG5nnQl8xEu
        IoTxbUAkPCme+p6q+KC5jvSWxu7wp6L1eXPoGkrt+O5jmc1uPlCWK3k+SqAJzynzwnzWddqdGT7Pt
        lhLLnTuEGVwtibDNS6yEcRCRcd4/Lhe9ZeTHLHpWBfDe5ih1e/VgN0q4Bj4T323Ka5zqXDyRE7HWS
        8DvFpD/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEVl7-009L0d-Lx; Mon, 31 Jan 2022 12:26:13 +0000
Date:   Mon, 31 Jan 2022 04:26:13 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     guoren@kernel.org
Cc:     palmer@dabbelt.com, arnd@arndb.de, anup@brainfault.org,
        gregkh@linuxfoundation.org, liush@allwinnertech.com,
        wefu@redhat.com, drew@beagleboard.org, wangjunqiang@iscas.ac.cn,
        hch@lst.de, hch@infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V4 16/17] riscv: compat: Add COMPAT Kbuild skeletal
 support
Message-ID: <YffVZZg9GNcjgVdm@infradead.org>
References: <20220129121728.1079364-1-guoren@kernel.org>
 <20220129121728.1079364-17-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129121728.1079364-17-guoren@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Given that most rv64 implementations can't run in rv32 mode, what is the
failure mode if someone tries it with the compat mode enabled?
