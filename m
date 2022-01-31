Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D1A4A46E8
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jan 2022 13:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358598AbiAaMXL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jan 2022 07:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiAaMXL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jan 2022 07:23:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43B1C061714;
        Mon, 31 Jan 2022 04:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LgcNEscPK7A82N0xwygPOGsKpSsV//8pkOJRPKbq18M=; b=fTeURvePtpWBWNVCu5sZZ9Oh4w
        h3Bra+rreCVeO1rckuTuRM0RiWTbtxaemvfv3L1WnhxGjHhCbD9sXGipY4zxfUsVhTrp6LkBZB6hO
        1soj7ib66BJyhmaNVF8J7POCawaByH+ixrvkwPiwUHiiH4tJ5bUB8GKpQzxDdp5ZJXZryEx1KgdA3
        jgxHjAfbHvet9+WzmnL/naKMwJ9GJ1qiwlB2+vbMZebAapKNbNySMIRr7nQpjr/sQxzU2ZYwbhWcm
        ZiFx4w595ItXCgdftwpwAQH5M2uOgtRbUYN41kob+5WpoK3kEegPqeOqIKkDXcfDdy8wkMNVxPRG3
        4kjY9SMw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEVi4-009JmW-Jp; Mon, 31 Jan 2022 12:23:04 +0000
Date:   Mon, 31 Jan 2022 04:23:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     guoren@kernel.org
Cc:     palmer@dabbelt.com, arnd@arndb.de, anup@brainfault.org,
        gregkh@linuxfoundation.org, liush@allwinnertech.com,
        wefu@redhat.com, drew@beagleboard.org, wangjunqiang@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup.patel@wdc.com>
Subject: Re: [PATCH V4 05/17] riscv: Fixup difference with defconfig
Message-ID: <YffUqErSVDgbGLTu@infradead.org>
References: <20220129121728.1079364-1-guoren@kernel.org>
 <20220129121728.1079364-6-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129121728.1079364-6-guoren@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 29, 2022 at 08:17:16PM +0800, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Let's follow the origin patch's spirit:
> 
> The only difference between rv32_defconfig and defconfig is that
> rv32_defconfig has  CONFIG_ARCH_RV32I=y.
> 
> This is helpful to compare rv64-compat-rv32 v.s. rv32-linux.
> 
> Fixes: 1b937e8faa87ccfb ("RISC-V: Add separate defconfig for 32bit systems")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>

Wouldn't a common.config that generats both the 32-bit and 64-bit
configs a better idea?
