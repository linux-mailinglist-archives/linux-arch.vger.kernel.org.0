Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126C3706040
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 08:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjEQGh6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 02:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjEQGh5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 02:37:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D903B10C;
        Tue, 16 May 2023 23:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JZ0E1cXLrZ9bDAe2GWQiXJ8aw7kmRqj0VQc5spb/718=; b=xPmECXDUC1tRNxXSHQpqDQApvL
        eRpHTc/0MGOkKNqgGS/gFUvRnEEDpb7ZDNFJnNPShlgH+oB2VRNIYChsTMxw62ks9bJek3pO4kpuT
        CQ1j+NMds2fUrAm6z84reZ7Ekj8NadfqtHtYqHd82ayEXfk7viS5YTXp4J/08PTwIzxF8/1AO4+qG
        5zc4xEkZlwPQLpjv1PX/kJm2aLmgVjoWEAGCgJ1Ioi6Iu/pyNKAIhSEn1ykiLwieOgSZ89Fspddz5
        jaRyLSaf/2K91BPZRjBFG0CSmHTB09dbldytgeTQ8dSFLt/i0kwzBJoX0Yyx3mHZF15DTTHemvk7Q
        gvTn0L3w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzAnK-008UrG-1E;
        Wed, 17 May 2023 06:37:54 +0000
Date:   Tue, 16 May 2023 23:37:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de, Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 11/17] sh: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZGR2Ql7zmwor/qR7@infradead.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-12-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-12-bhe@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 15, 2023 at 05:08:42PM +0800, Baoquan He wrote:
> Meanwhile, add macro definitions for port|mm io functions since SuperH
> has its own implementation in arch/sh/kernel/iomap.c and
> arch/sh/include/asm/io_noioport.h. These will conflict with the port|mm io
> function definitions in include/asm-generic/io.h to cause compiling
> errors like below:

Please split that inclusion of include/asm-generic/io.h and redefining
of the helpers into a separate prep patch.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
