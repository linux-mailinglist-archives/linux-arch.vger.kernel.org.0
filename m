Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718046C13EA
	for <lists+linux-arch@lfdr.de>; Mon, 20 Mar 2023 14:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjCTNsX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 09:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjCTNsW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 09:48:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF454237;
        Mon, 20 Mar 2023 06:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PB5HYAZGv9HMfQ1pr0vDKU45cXNH5QgD4Xzo7ZuzTGs=; b=nhCZ2HVyP6i0qpXdnrwj4yKV9L
        lY3fNDHz5CYzPC9trnpffz9DShtCZ81A8g35WeHwhdWRAU6bH0CbJIVPileSo5p4dAZIywBGyUAli
        nBhQS9Mai+oJLiKJ9uC3exaOEon3uXi+SjRnXhLvxrwchEbx+i7cc2hSRaDPsuhiHv7atay7eMW0s
        liBhAemjna/Dif0dewXRTaBN76hKdMbX8iYRxdlSeLl0r1k8pycrgswVz+/uDwGTAEM3tbOaDw+Y+
        VSXKTdKl2SYH9vryLajjjnC++90Qp50eou+dud6yW879o6hsWUvZtntsURHgQiWSHNDS4NroemJf/
        q2ju+LAA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1peFrq-009EVA-1y;
        Mon, 20 Mar 2023 13:48:06 +0000
Date:   Mon, 20 Mar 2023 06:48:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH V2] LoongArch: Provide kernel fpu functions
Message-ID: <ZBhkFmGfalw/GgTY@infradead.org>
References: <20230306031258.99230-1-chenhuacai@loongson.cn>
 <ZAoNPuyHQTqucYxn@infradead.org>
 <428e2df8-d5b7-a200-62c2-59497f3facea@xen0n.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428e2df8-d5b7-a200-62c2-59497f3facea@xen0n.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 11, 2023 at 04:10:44PM +0800, WANG Xuerui wrote:
> again, and making the loongarch FPU helpers GPL-only works for me. However
> there's probably another question that Ruoyao pointed out: do we want to
> mark the neon/altivec/s390x helpers GPL-only right away? IMO this particular
> feature is not inherently arch-specific (the same would have to happen for
> every arch with optionally enabled extra state and instructions, not limited
> to FPU actually) so availability of such feature should preferably be made
> symmetric over arches.

In general we should, and all new code most.  For existing code please
contact the relevant maintainers first.
