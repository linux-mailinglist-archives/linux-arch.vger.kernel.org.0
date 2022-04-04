Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06964F1037
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 09:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377771AbiDDHq3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 03:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357956AbiDDHq2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 03:46:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08712237D4;
        Mon,  4 Apr 2022 00:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wK+J0MSOSpXOs7DxaA01v/+8Kp5RPaW5E6MQ/XdwYEQ=; b=APwuwZPJFpb5tUSZJOyrXP90mz
        JV+p35fusRoaGWCyKiRU1GBIg5FjoT/xD0aQvTDAn7e9LqrCD4+UF3KHpNp76BKaFwSVvy+eNY5wq
        s7BpVw6caTHoT9a3EwgVsDIbVY3qruf1QjUslxwHNj9SBaKhkjWPFeveVQtFwM34xZfZ5PTgVKlWw
        Mt8aBsfU9p++B92/TkqqKsJdF+F/wHG55QOIAoKGaB07YfyabgTQD7YZKbpzbSUBCvZ7HshCR+YLv
        JVBBZdhUGSsCk5luUmF0hjZK8hBJDOngeI8nMJy7NNfCzdOLdFxzVTezJJTKqvUbayS6jE7/Xx8P9
        3zX8FkHg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbHO3-00DfPU-01; Mon, 04 Apr 2022 07:44:31 +0000
Date:   Mon, 4 Apr 2022 00:44:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 8/8] virtio_ring.h: do not include <stdint.h> from
 exported header
Message-ID: <Ykqh3mEy5uY8spe8@infradead.org>
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-9-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404061948.2111820-9-masahiroy@kernel.org>
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

On Mon, Apr 04, 2022 at 03:19:48PM +0900, Masahiro Yamada wrote:
>  	vr->num = num;
>  	vr->desc = p;
>  	vr->avail = (struct vring_avail *)((char *)p + num * sizeof(struct vring_desc));
> -	vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
> +	vr->used = (void *)(((__kernel_uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
>  		+ align-1) & ~(align - 1));

This really does not look like it should be in a uapi header to start
with.
