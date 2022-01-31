Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45D24A47B2
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jan 2022 14:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378428AbiAaNAj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jan 2022 08:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378383AbiAaNAi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jan 2022 08:00:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C2AC06173B;
        Mon, 31 Jan 2022 05:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xQCGsDUYFp6pvF7xS5natfKk/35QMnRgqEC4IjicK74=; b=mHJI8Uwd/igPBdxzDh546BJtm0
        3P8015UYpCjufDCns11sMr4x4XUTUoYmfCaooJOyET6T9puzam2oqO0WypPYwq2pKdcSuaPipjLiW
        B54WN/m8CyjVD7EkWHu3Vcr4EKgt111QlQLPPpBGftjmVPXXBsrYAJm+SBrF6xwNxgjYaz6lsyyjl
        OqMfckwxHhGtAK/jiXrwhjJ2LjgfPq0zeoIXQoShFWBQ+NXVmVKtZ3hKGJjxPERwP1qd2aL46jaf/
        cSpxFYoFfUeKlCrE1Br5Do3/1Mq7ACbodTF9yJVCqzUUsSBFaHW2sQgwMV0hHULJwCSHU8zuCfWr+
        /Yet86BQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEWIG-009PaF-Ds; Mon, 31 Jan 2022 13:00:28 +0000
Date:   Mon, 31 Jan 2022 05:00:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>, Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup.patel@wdc.com>
Subject: Re: [PATCH V4 05/17] riscv: Fixup difference with defconfig
Message-ID: <YffdbErmAjAWYuD9@infradead.org>
References: <20220129121728.1079364-1-guoren@kernel.org>
 <20220129121728.1079364-6-guoren@kernel.org>
 <YffUqErSVDgbGLTu@infradead.org>
 <CAK8P3a1jZyVBW70K6_u3mvXYNowV4DTBxivKc2L=HbRK8SgRXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1jZyVBW70K6_u3mvXYNowV4DTBxivKc2L=HbRK8SgRXg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 31, 2022 at 01:48:58PM +0100, Arnd Bergmann wrote:
> I thought that is what the patch does, there is already the normal 64-bit
> defconfig, and the new makefile target makes this shared with 32-bit
> to prevent them from diverging again.

I ment using a common fragment and the deriving both 32-bit and 64-bit
configs from it. The 64-bit specific fragment will be empty for now,
but we will sooner or later have an option that can only go into the
64-bit defconfig.
