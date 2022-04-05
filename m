Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8284F229A
	for <lists+linux-arch@lfdr.de>; Tue,  5 Apr 2022 07:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiDEFh5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Apr 2022 01:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiDEFhz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Apr 2022 01:37:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908166C90A;
        Mon,  4 Apr 2022 22:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3b3CGMEtvbbiWr5yzpB1vkgXknPZ0unzkS2usWuM5zQ=; b=oprcixATceNR1lvr6wPiAeAep8
        9zCOtNH/nU1hogoIN80xVbrqnlQoEfQVvq7Bn35n7AX6HZ7xYdG3NZeHRdaP+dlWiBobrhoTmG9Qg
        HsTTBXyOtCN2ceRV76QybHMHpF/a0FPihgyb0BpCzLcXL3osENOfMq2vB/7W4q0QwCUN5G2lSJopz
        c/mT2S458mCRhSxI54khZkQ7lr20mNUpjOp+6nX1gO4DR933XIb3HXhI4JZYIxUwfpSH2Ys01vnwG
        hHHs2tI7mkc07epLdb2K6Rh+C8nB2oLfQuoaln8JY4m66vJ4pfBIsuqyT+Qg29P4THEvEnbFOYiuk
        MaFb58XQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbbr6-00HAqV-45; Tue, 05 Apr 2022 05:35:52 +0000
Date:   Mon, 4 Apr 2022 22:35:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 8/8] virtio_ring.h: do not include <stdint.h> from
 exported header
Message-ID: <YkvVOLj/Rv4yPf5K@infradead.org>
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-9-masahiroy@kernel.org>
 <Ykqh3mEy5uY8spe8@infradead.org>
 <CAK8P3a07ZdqA0UBC_qkqzMsZWLUK=Rti3AkFe2VVEWLivuZAqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a07ZdqA0UBC_qkqzMsZWLUK=Rti3AkFe2VVEWLivuZAqA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 04, 2022 at 10:04:02AM +0200, Arnd Bergmann wrote:
> The header is shared between kernel and other projects using virtio, such as
> qemu and any boot loaders booting from virtio devices. It's not technically a
> /kernel/ ABI, but it is an ABI and for practical reasons the kernel version is
> maintained as the master copy if I understand it correctly.

Besides that fact that as you correctly states these are not a UAPI at
all, qemu and bootloades are not specific to Linux and can't require a
specific kernel version.  So the same thing we do for file system
formats or network protocols applies here:  just copy the damn header.
And as stated above any reasonably portable userspace needs to have a
copy anyway.

If it is just as a "master copy" it can live in drivers/virtio/, just
like we do for other formats.
